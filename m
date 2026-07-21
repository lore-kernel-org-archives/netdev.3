Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0AB46D2D9
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672155; cv=none; b=ZLdOP3Hd0iHEhf53YS3LWDBDYj0vGGzlgZon/daZxWjow7nhCaA1qzOJBJOIYybF7AXAUH+8RWuCsITGOTzHpJ7noX+K4WjQKeUH61+Ve+8eVWBdkn0Hsjg6bS+2iIVA5cd/moCDdEMvFNdh6vhSVYwQDiKMZPdbiZuud0eg8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672155; c=relaxed/simple;
	bh=QK8aNSzL7ND4hoq7Mvy7TvP92pxHrFlqyV4BOQPaCNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mD8uVIyiFcurNIng9myx8jUXZmlkEFfubNn7ojgEgi5D3Y+PWsc4W7icvfC23efAFHYNsmIERrCFIHK3rClw+NAKd4lCCsGyhr45phUWF7Dc76KHFbY80eR1e+6+9vXQ1V8b+Dsi2DMCINOMia15l0ok7R1wwTufqUpvOyjxMIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frznfk/r; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frznfk/r"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso2504413a91.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784672153; x=1785276953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uEYLADmFkDVF9LXmlc95J2Vic5BUF75td03Fx2o+E0U=;
        b=frznfk/rezMDGNw7EBKCLS4OUqj5L49ZmRDkxylL63IioUDNZJwKZ1MO/Bc+iYCZK+
         edM3vtY38GtRP7KKx1yTz4IVi4CPj/CB27vVb7+RdFe3AKGtPSYR7LLDg3OoEiEj0Dvd
         hvE3veo9x8DY0PtPDIqu4aXK6xmvYjiaU6l5pGeAyn3L+PylPqXLoeDzqMgM2ZRBjO/R
         8R93YxJodRXdlDvl5qNDYng2f7NOe8w+ZqD/8rgSMlcFFUFsEFn6Nx77IpRiYQ4/FFXO
         6uTsN4vSPERVRWdGL6CUxb7MrjfiN2bW+4pLrw8UN75UDx72x2FG+5i76OK3wAh1ys4F
         /1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784672153; x=1785276953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uEYLADmFkDVF9LXmlc95J2Vic5BUF75td03Fx2o+E0U=;
        b=gly9UqCB+fB2jLKJLRDqFhREm4yyMo7P2G8ApmvPA2UvP1qdbQsXD9k4PabBiZLjnd
         aoeAGfAvlZdcKn5xraMPEgEbCq4rwgiIKoDA05LsEmxqVyiHNp5UZRXzN6Q/iaNdfV1H
         NU3RTPrbZ8SfR2+umyX427FugNnRhh6ykb6O/aLV1foYUcA89wvdrI1edSjIPpfMdx9f
         A64s9SWD3Qmj1cBEfLrRgLRrREYImWkhniMEig+9tdkOEOHtt+I9Gjg6VJWK09LuUUcY
         PMGJ9OtYi7bkkeroaIpau/NVhFeIsTuCX5391Yu28lQf7UC6F4R7wrHHfqfhiyapUMKu
         slXg==
X-Forwarded-Encrypted: i=1; AHgh+RpnfzaOF7qL67MDUQ4UIDVtqEC2g6oLJ+bbHGqr4wPL46qKANGDT/o6ee2dDRt51AHDTLzJkt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdVlnyrzeyI8yzGMg+LncsZsh47WKiHGki0uFoZv08W6U4l6Fq
	LNRHfwzzFkxsBBsAlIpM7JyLjpoWSsM7/6t0YObJ2KtvjyBAS65JIp5M
X-Gm-Gg: AR+sD10tOvRg3JKkK/HkAb+TeQsl337wxN1MRoiriiZ4W482NfbDKt3Wphys6scq2Kd
	8BDrWdJSxP0gps54ZAaExQSs0jOQqBMcSLdOrk63nIOLzTFugFWsjw39VpgbFgDwt0/fS/Gk//y
	//XK/yD0ldY8i+18kWIdINbT6XTM5A6TGxi+19i+v9MhmZec60z8i+kRIeULnd/1N7bfcLddVSP
	ZbEpnLQNoLOgAvVxVxlR4u15k1Cf8v1KCeE/3VWuz09YbN9VXpnznK/r/UEWCGdUjT2zscKUBMB
	WdjH9xUAwovl9C7DXxs4IoaVldOiCeqtRgYhRDEud/K8M0dDffIMQO0vqJP+Xhqp1NqM8G+iAs9
	AksmkJCCcNjTYA9pCcd9Ck+wyxGOMMagTt9OjkL9eOSeCveQiPyQgRq6ftgkMCyozhPM1gvlnRw
	buLk4JpG6JowqFkxMu
X-Received: by 2002:a05:6a21:1404:b0:3b4:e4f6:4f15 with SMTP id adf61e73a8af0-3c3ad676326mr21536990637.5.1784672152988;
        Tue, 21 Jul 2026 15:15:52 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::9edb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc1a689sm2388931eec.4.2026.07.21.15.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:15:52 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Simon Horman <horms@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	zinclim@meta.com,
	Zinc Lim <limzhineng2@gmail.com>
Subject: [PATCH net-next 5/6] eth: fbnic: report temperature and voltage alarms via hwmon
Date: Tue, 21 Jul 2026 15:15:39 -0700
Message-ID: <20260721221540.648272-6-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721221540.648272-1-limzhineng2@gmail.com>
References: <20260721221540.648272-1-limzhineng2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building on the temperature and voltage thresholds stored in
fbnic_fw_cap, expose alarm attributes through the hwmon interface:
temp1_{min,max,crit}_alarm and in0_{min,max}_alarm.

Each alarm is computed by taking a live sensor reading and comparing it
against the corresponding stored threshold. The static thresholds
(min/max/crit) are returned first straight from fbnic_fw_cap without a
firmware round-trip, and unsupported attributes are rejected up front, so
only attributes that actually need a live value fall through to a single
sensor read that then feeds input and every alarm.

A threshold the firmware did not populate reports -ENODATA for both the
threshold attribute and its alarm.

Signed-off-by: Zinc Lim <limzhineng2@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 68 +++++++++++++++++--
 1 file changed, 61 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
index 4938f7b39140..c5cddd9cef12 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
@@ -87,34 +87,84 @@ static int fbnic_hwmon_read_threshold(long thr, long *val)
 	return 0;
 }
 
+static int fbnic_hwmon_read_alarm(long a, long b, long *val)
+{
+	if (a == FBNIC_SENSOR_NO_DATA || b == FBNIC_SENSOR_NO_DATA)
+		return -ENODATA;
+
+	*val = a >= b;
+	return 0;
+}
+
 static int fbnic_hwmon_temp_read(struct fbnic_dev *fbd, u32 attr, long *val)
 {
+	int err;
+
 	switch (attr) {
-	case hwmon_temp_input:
-		return fbnic_hwmon_sensor_read(fbd, FBNIC_SENSOR_TEMP, val);
 	case hwmon_temp_min:
 		return fbnic_hwmon_read_threshold(fbd->fw_cap.temp.min, val);
 	case hwmon_temp_max:
 		return fbnic_hwmon_read_threshold(fbd->fw_cap.temp.max, val);
 	case hwmon_temp_crit:
 		return fbnic_hwmon_read_threshold(fbd->fw_cap.temp.crit, val);
+	case hwmon_temp_input:
+	case hwmon_temp_min_alarm:
+	case hwmon_temp_max_alarm:
+	case hwmon_temp_crit_alarm:
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
+
+	err = fbnic_hwmon_sensor_read(fbd, FBNIC_SENSOR_TEMP, val);
+	if (err)
+		return err;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		return 0;
+	case hwmon_temp_min_alarm:
+		return fbnic_hwmon_read_alarm(fbd->fw_cap.temp.min, *val, val);
+	case hwmon_temp_max_alarm:
+		return fbnic_hwmon_read_alarm(*val, fbd->fw_cap.temp.max, val);
+	case hwmon_temp_crit_alarm:
+		return fbnic_hwmon_read_alarm(*val, fbd->fw_cap.temp.crit, val);
+	}
+
+	return -EOPNOTSUPP;
 }
 
 static int fbnic_hwmon_in_read(struct fbnic_dev *fbd, u32 attr, long *val)
 {
+	int err;
+
 	switch (attr) {
-	case hwmon_in_input:
-		return fbnic_hwmon_sensor_read(fbd, FBNIC_SENSOR_VOLTAGE, val);
 	case hwmon_in_min:
 		return fbnic_hwmon_read_threshold(fbd->fw_cap.volt.min, val);
 	case hwmon_in_max:
 		return fbnic_hwmon_read_threshold(fbd->fw_cap.volt.max, val);
+	case hwmon_in_input:
+	case hwmon_in_min_alarm:
+	case hwmon_in_max_alarm:
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
+
+	err = fbnic_hwmon_sensor_read(fbd, FBNIC_SENSOR_VOLTAGE, val);
+	if (err)
+		return err;
+
+	switch (attr) {
+	case hwmon_in_input:
+		return 0;
+	case hwmon_in_min_alarm:
+		return fbnic_hwmon_read_alarm(fbd->fw_cap.volt.min, *val, val);
+	case hwmon_in_max_alarm:
+		return fbnic_hwmon_read_alarm(*val, fbd->fw_cap.volt.max, val);
+	}
+
+	return -EOPNOTSUPP;
 }
 
 static int fbnic_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
@@ -139,10 +189,14 @@ static const struct hwmon_ops fbnic_hwmon_ops = {
 
 static const struct hwmon_channel_info *fbnic_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(temp,
-			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
-			   HWMON_T_CRIT),
+			   HWMON_T_INPUT |
+			   HWMON_T_MIN | HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX | HWMON_T_MAX_ALARM |
+			   HWMON_T_CRIT | HWMON_T_CRIT_ALARM),
 	HWMON_CHANNEL_INFO(in,
-			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX),
+			   HWMON_I_INPUT |
+			   HWMON_I_MIN | HWMON_I_MIN_ALARM |
+			   HWMON_I_MAX | HWMON_I_MAX_ALARM),
 	NULL
 };
 
-- 
2.53.0-Meta

