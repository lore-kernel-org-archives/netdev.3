Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B84C14F3
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016562; cv=none; b=PUBC9it4rEWaiTey0kHfVS0i/80Zf9UTipigPi3QoqTlbDVtO0CAyqNmCQvMzV4OaWFK3hXqNy74CUtq56b9qSCfmDx3O4g2eO3hj//K7dHj4PFN/J6gtRvmR9fGpbku89gNoXX7RdlIfnlWtrZ2AnhaW/UCvrL7lYAfXgPMoSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016562; c=relaxed/simple;
	bh=yHLMDM/48dcDq/Dd2thjDfocEkPnBBmEY6ZjqusswBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEAh7gx//BlxDdVGvYrvMRYPm+xrwXWbcc92JxcPPpWwVGEiVd6Q908vsNT1r1IrpwnYO21SjwwwrS1kIVUuWF1Mlp6wR69gB2ESqw6WaXAv4bFB3xODbveHMWo6NlA3GFFLntPvEoqfOmSDF0xdlOawLtrpGeLvHrpmJMkbpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eof+hDF4; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eof+hDF4"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-17bc533fda3so1580122c88.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792016559; x=1792621359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2+TdeI/FqKLxgmSZUeosOnsLC255UKO2RqcJWHBdyk=;
        b=eof+hDF4EuNCH+ObZmq77+1Iw9ZNd/zQ+I3oz6w3OVOO1DUI+y+ZOOxjv8wXlC+7Ru
         7d3Ynnzo8jTHbtV7D0EAH5HrIleBWcLLS5+2qDSEY/Nb4D0I/7bN7yjF+6VhGE83rFpt
         NjiFX9yZPAMXczZ8VTKUM5AyW5B30wl1yOIVgYaFyTc+uIwBvEgj7NPrAItdfLSOQh+A
         xOwu0srD9o12u8INwxvKpnQapQ4BZl3mzMaubnjr5Rou+ip9j2vrnp936EXGoj0TLwq+
         cah0brhJ4OQYCIxo/fgmF614pIRk/mGnX4O6cfzRB+5GJ+QircpcngF2EPx5JU5nxjWy
         5i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792016559; x=1792621359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W2+TdeI/FqKLxgmSZUeosOnsLC255UKO2RqcJWHBdyk=;
        b=V4scTYeDsK3mZMeeGMcP7qC5D/XLOvqIS0rHVvH1aHw4gFmGrsZfLuV0X6wKdh3AB6
         MLHARwrN1qv1PXTCtTe07e5zxm+B7sxMVjjdeEnm2HdpoNz+03ond6ttNKRCtN1uqYVx
         yAMt2yhUVWxaEi/2ht+XZu4Lo7tyaKxZD+E6B8lWSsJcGanbKEkEWn/XQcOwj8NSIeLO
         ReYXxVZ3PY1OA3HSZ6ToQjkIG3ix94PrlfhZEF2ioTskqPu2yxg6UVwKeYZ+R6kXZY3a
         wHladgAOZ0neZq5bLn7ru/IgENV5DSt11HzUYBiYzy3tpRk7GbNIBkeGZrgt4RrxVxXp
         tt6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwmzkdwFtyf2ipILwwRG2wBzMw3TXjBmxRl94LBompfR8zxbFJ9pa30noI/YPWOI+vX8XdnosI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvPp1APERqYcI1hTpg2Bngtgn549f4XP1LZq4XazFNN/edSaFL
	+ddOailkYwWzHr1I2Ya4TdKU3NatRvaq/EE1wsZguEcj90GdJvDZtaHB
X-Gm-Gg: AYBFou3UuGPmCt7KgwoRLEOqyOrzvDV033OmRoWxLhhvJ6c4+dcZYh+q0HCAloHcuwN
	MNPvZkdy0ur2hhWrgUFxucFr9Y44BY+Gcv/nrFkVLjueXemlOFdBunllBSujtM8nJLn4Rm1NNma
	ECn2jUT0ox9GCncNABIXnAV9VKWAJFw0Fjs1O5i6EnQJU2iBdTQji1euWokYGKZOY9s5OO9+Hxb
	aOsZUeQs6o7V7UyrEBUPU247Ea9vwg+2hmYu9xGgrbEz+y91oIQjKcPH13uLFz6+MyA2mEEeep5
	6ipS2uvnwdBzHdRsiRUOTSsFS8qpQQztCvZKA614GYl/TI/mBjsAeKRmZP4P8O6tdMG/t6alcUg
	WwvusDKh52JSl9qH5u48a9qclbnEC/eXthllnGXhdDWVsA62J+T3pA38K+OA8Z2i/fvpKZ0c9/W
	1H4rDWF8J0XHvP9YR99J3LkuESZY4GS+OgyshOYcx/RUHaBy9lef2a8J40/r+aVrxRL6oe221j7
	PvfAQ==
X-Received: by 2002:a05:7022:eb53:20b0:170:64b:b388 with SMTP id a92af1059eb24-170064bb41amr18274573c88.46.1792016558840;
        Wed, 14 Oct 2026 15:22:38 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::5:7561])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1761ed641ddsm24225058c88.1.2026.10.14.15.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:22:38 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	linux@roeck-us.net,
	horms@kernel.org,
	hmohsin@meta.com,
	mike.marciniszyn@gmail.com
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	zinclim@meta.com,
	limzhineng2@gmail.com
Subject: [PATCH net-next v4 6/6] eth: fbnic: derive the alarm range on older firmware
Date: Wed, 14 Oct 2026 15:22:24 -0700
Message-ID: <20261014222225.2803660-7-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014222225.2803660-1-limzhineng2@gmail.com>
References: <20261014222225.2803660-1-limzhineng2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware that predates range reporting uses the threshold event to flag
that a limit was exceeded, with the attribute hardcoded to 1, rather than
reporting which range the sensor entered. The range enum reserves that
value as FBNIC_FW_TSENE_ALARM_DEPRECATED. It does not indicate which
limit was crossed, so it is not cached and the alarm classifies a fresh
reading on every sysfs read.

Such firmware re-arms the trip points around the range the reading
landed in, so every crossing interrupts, including the one back to
normal. The event carries the reading that tripped it, so derive the
range from that, against the same capability response thresholds and
boundaries firmware uses. The alarm then tracks crossings there too, and
wakes anything polling the sysfs attribute.

An event can arrive before the capability response that carries those
thresholds, since rx messages are parsed while polling for it. There is
nothing to classify against yet, so the reading would come back as the
normal range and stick there. Leave the range unknown and let the read
path derive it once the thresholds are in.

Signed-off-by: Zinc Lim <limzhineng2@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 18 +++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 29 +++++++++++++++++++
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 90e54cffe6a9..8180028b20a2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -201,6 +201,7 @@ void fbnic_fw_free_mbx(struct fbnic_dev *fbd);
 void fbnic_hwmon_register(struct fbnic_dev *fbd);
 void fbnic_hwmon_unregister(struct fbnic_dev *fbd);
 void fbnic_hwmon_notify_event(struct fbnic_dev *fbd, int id);
+void fbnic_hwmon_old_notify_event(struct fbnic_dev *fbd, int id, s32 value);
 
 int fbnic_mac_request_irq(struct fbnic_dev *fbd);
 void fbnic_mac_free_irq(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 9485665cba46..cfec30e5cb98 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -1737,8 +1737,13 @@ static int fbnic_fw_parse_threshold_exceeded_resp(void *opaque,
 			dev_err(fbd->dev, "Thermal alarm %u, temperature is currently %dmC!\n",
 				alarm, value);
 
-		/* Old firmware reports no range, leave the cache alone */
-		if (alarm != FBNIC_FW_TSENE_ALARM_DEPRECATED) {
+		if (alarm == FBNIC_FW_TSENE_ALARM_DEPRECATED) {
+			/* Nothing to derive the range from, so do not guess */
+			if (have_temp)
+				fbnic_hwmon_old_notify_event(fbd,
+							     FBNIC_SENSOR_TEMP,
+							     value);
+		} else {
 			WRITE_ONCE(fbd->hwmon_cache.temp_alarm, alarm);
 			fbnic_hwmon_notify_event(fbd, FBNIC_SENSOR_TEMP);
 		}
@@ -1757,8 +1762,13 @@ static int fbnic_fw_parse_threshold_exceeded_resp(void *opaque,
 			dev_err(fbd->dev, "Voltage alarm %u, voltage is currently %dmV!\n",
 				alarm, value);
 
-		/* Old firmware reports no range, leave the cache alone */
-		if (alarm != FBNIC_FW_TSENE_ALARM_DEPRECATED) {
+		if (alarm == FBNIC_FW_TSENE_ALARM_DEPRECATED) {
+			/* Nothing to derive the range from, so do not guess */
+			if (have_volt)
+				fbnic_hwmon_old_notify_event(fbd,
+							     FBNIC_SENSOR_VOLTAGE,
+							     value);
+		} else {
 			WRITE_ONCE(fbd->hwmon_cache.volt_alarm, alarm);
 			fbnic_hwmon_notify_event(fbd, FBNIC_SENSOR_VOLTAGE);
 		}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
index 310a2c52bb4d..9fa9eb843c68 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
@@ -302,6 +302,35 @@ void fbnic_hwmon_unregister(struct fbnic_dev *fbd)
 	hwmon_device_unregister(hwmon);
 }
 
+void fbnic_hwmon_old_notify_event(struct fbnic_dev *fbd, int id, s32 value)
+{
+	const struct fbnic_threshold *thr;
+	u8 *cached;
+
+	switch (id) {
+	case FBNIC_SENSOR_TEMP:
+		thr = &fbd->fw_cap.temp;
+		cached = &fbd->hwmon_cache.temp_alarm;
+		break;
+	case FBNIC_SENSOR_VOLTAGE:
+		thr = &fbd->fw_cap.volt;
+		cached = &fbd->hwmon_cache.volt_alarm;
+		break;
+	default:
+		return;
+	}
+
+	/* Event arrived before the capability response containing
+	 * the thresholds.
+	 */
+	if (thr->min == FBNIC_SENSOR_NO_DATA ||
+	    thr->max == FBNIC_SENSOR_NO_DATA)
+		return;
+
+	WRITE_ONCE(*cached, fbnic_hwmon_classify(thr, value));
+	fbnic_hwmon_notify_event(fbd, id);
+}
+
 void fbnic_hwmon_notify_event(struct fbnic_dev *fbd, int id)
 {
 	enum hwmon_sensor_types type;
-- 
2.53.0-Meta

