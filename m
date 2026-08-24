Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DAD37F8A1
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593876; cv=none; b=pJBVEQOhuRMifjzgarj399blEIryyGWQ3qawjm6VBvQ0CtI+x21Pg4xonptKzSu1SnxCzcDntsDBWsBqVMWOqgyW3UCHIdlsfizcLynUuQNz1PR8NFoKpPSBAM3V9HUr7vC42S5gINo96ZIIhmm14gYcayLKG0VaE6aQCsZNVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593876; c=relaxed/simple;
	bh=QK8aNSzL7ND4hoq7Mvy7TvP92pxHrFlqyV4BOQPaCNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lESaAqy8tQcAY0aUGwWoWrH/7e3vVZPgrGI51c0czs3iSys5zKmZE4bdCn4t38UWzIK8o3eUcJblTbXjCJAgrdEXJtTQnyWcbX/Y4LtG7GWuy3IQZPHJNSvqoDWSbMQkeD54aE6/AcALTMQsgS09TdHcw3mmQfllKUj3IC3gaHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzsZ6A3F; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzsZ6A3F"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cacb8416a1so32945815ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787593872; x=1788198672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uEYLADmFkDVF9LXmlc95J2Vic5BUF75td03Fx2o+E0U=;
        b=AzsZ6A3F0/ybYAE6nTxi77LwT5HH0epSZBs6TmmkRBw6Y66eFaS5uWfJ9r/6AqpSs2
         Fkf6MJsNN+P1FeOeg/6oCn0aAsBzmOKVlApye4M9F3+qbf+ixkZpBBetzZaYwTSQyLSZ
         PqmD1fK0FGehDrCKZ1K9qYTxZ+R+Y05Xox5C4D8mSdcOcIY6LaRx2ivUkOqP6kOpBLvC
         MntIxeD0M1aSyxCzLzVt1h4fF9RDkzi268djjdoQjIDhHbvWdCoZHQrA5UoIVzD3aaXa
         dAJeQEywY9tXuhmjNy+my4RgRwZYQzGfTExbnM/NlwWXA3PPjXem5wq4KHoNISyxdHSe
         /NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787593872; x=1788198672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uEYLADmFkDVF9LXmlc95J2Vic5BUF75td03Fx2o+E0U=;
        b=klFVMcLWKHWCVL2OgrNWpIGaHXDctqrUfTYQwVqFKY+4bupXJt8lHqK9rhz8OqMzr5
         peDNRLqrGVaCyCZg4+wmkzv7dXbs98cPsXbPpCENLAPAZ/2uhmpXdnbjI+vP/9fvxogu
         I87A7xM64akHU/8Jvi79usHqG/tBKcKysed595d7DQjj+GlYhEsENmXgOZAdDdnxA9a/
         X2uTu9M9jPZS3tuL5ER3bcS6jqOAQyrRXmGfKrgIDoE944VO3mgssiCTc8iLOraQ/Ccv
         5ve3PGPOKpBw36c2X0BjekNf2n7HcMskA/6cSgqoIpLugH/R505UClncj3fiOQCZLdEF
         WOxw==
X-Forwarded-Encrypted: i=1; AHgh+RrA9oqNXuJMuRz4P6zSSNgJi8/FLI8ctWgToeWThSSn2oBzXkgSzPtdM9QCK/COn4i5CAN7Diw=@vger.kernel.org
X-Gm-Message-State: AFuF++nJT+X82MrBZbJRvZwHges1N28S0+7WebRl1bPtK0IdQcGn400f
	incAClSehtD/M2qouQICCAvzbkArN4dbjG/wquK6FWM50iqK55+c/Sit
X-Gm-Gg: AR+sD11B4GMm8zPItSBNEOIgSFOgX0zFQ7NdN72Id+smTmu9nkdLSERNoi1WmvVpyqC
	//gAUBnHNTTyDX8RDQEYh/vNvrsip/4NTqljT3im3Ytkzc1owaZb3M3/3d2u8fQzFObpwrudH1E
	LmvH/6fh0sYZgImqPiuUMfZOT/y33R5A/T/N5z2M0VAgsmaF+LZ0Ost45liHMODTlk0KNrDgRPS
	bOK4TSxJLF+UMjC8EsRZenF6qnzJq1zJ2tQwbOHgJO21hbd8Tg1KASl4VG3HWjKFGVIxuXp639N
	J4Yaa0IVNN4VEJIpg61Ici+MphTHYOKn7fFJIuFrQwhmaQM7DAcU59aAQeRsBJKbW0wST5A/2gn
	A9ZMtqk3SPSzrV33j0UtOlMYeJZCDCejw9ZNjUvQoWMDsyQ4mKTmpgB/p2WvnY+4iFHEBje5JEf
	Ip9bZOXY41YRHk1mESZOOs+w8CEmWreZBc6ompMMLidE9W7r6kUjL5qtXfvd1yYJHWFVo=
X-Received: by 2002:a17:902:e74b:b0:2ca:2079:91cc with SMTP id d9443c01a7336-2d6dcaad3fdmr14430375ad.5.1787593872430;
        Mon, 24 Aug 2026 10:51:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:ddd2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90cb8e3sm42038477eec.12.2026.08.24.10.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 10:51:12 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/6] eth: fbnic: report temperature and voltage alarms via hwmon
Date: Mon, 24 Aug 2026 10:50:58 -0700
Message-ID: <20260824175059.2485048-6-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824175059.2485048-1-limzhineng2@gmail.com>
References: <20260824175059.2485048-1-limzhineng2@gmail.com>
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

