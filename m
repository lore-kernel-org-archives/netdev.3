Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811A83AB288
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211372; cv=none; b=MErYZo2HFQ9IUcSMAnriu9FUyFqcGlG63W+MCIKB8z0JeOIW5Ma32FDbV5fXvJm0y+0d92ACTBXoi3JSLPKxl4XclqLlX1ufVHU0FtPaS8Km7sVnq6vwhe2wqA/5tsVknEZXtnHkqCRuIzHrB+tZmBuJ1VE2R/1rA+i0/rDqmFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211372; c=relaxed/simple;
	bh=DAi+XZ+iVzK9opH5tLj0PVy/X0Xxq2muFO+ODlSkT0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvfLgsW3bJWT92Jj2UWL9xgqWMy8m3iewmM1bEU3wRz+UL4wRKHCmZ6fgyzLoWVdylhWlV2Z1lXgyMELi2lehXuuM/Nqx4Gul9sdFgkPUT0FDAP1Uyk/QkKm18o37CcLR/x3q1jszX1WIuAcNZN3LdVBAFOi1IncmUxOnScWrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bm24eAGg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm24eAGg"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso158284b3a.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788211370; x=1788816170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WjbJ4Pa6PEowkjvqP5cAHHCjr9IGaKnqwljufVDEqTA=;
        b=bm24eAGguVErCJYTJsrulyi7eiLjkyxRsyRxuykGjWduN6q5g8mXktsCipgXHC5sMN
         O6pzqqsgy/7/Calfrt0sSVXMUJiDvlfmjzaNqsJJhiB6IRigO5Di1g+c7MJM1xzvB3g7
         kmttBvZbnBRzAuDAOlXjmYoC9yEy/bkrjK/MrpQc+G7yfcrotDfsd3LRCgjA7VdvbcAk
         L6FIxO0BxK3h7WDWpF+JQfpb3Rm/1tk4iaGDn8eSCYU/lbD3snQWxU2DpfNzLCOqOMkE
         0iNUCUTkkqHeVxxqltVu3oaUA5y04Yn2uaYiMbaf80PR8eMujENiw+CZpby+4Pv671LS
         pJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211370; x=1788816170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WjbJ4Pa6PEowkjvqP5cAHHCjr9IGaKnqwljufVDEqTA=;
        b=mjZUMtPgZgRCz0W41WSytsbphm7mCTbuTPGnRp9ts0cuCr6vs6odJjZ/zuKel20FLq
         ZgG4KyLF9V1Y7S3FOsju9zdyhpBlaRM0e3LCGtWkrFTsT9/pIaPLNj6RTyagCOLetrzV
         m2xQ8ilBfDMOnsWXxYzByzoshB29kbn4gmFcCZZP72CE8IpwYoXen6uhTdmhDtygjJdD
         N/7nhfnbXs0vu9OR85Zi1mr3OxSb2kXYj7xSa9l93Agg2DgxB8Y8Wx7/w9faudNzDJsK
         tfihH7prHOOp5RsRf6GA5mUOI27ajbbqsRyCrCpLrW3K570y0TkG4ggWupSQejjECf50
         Yl4Q==
X-Forwarded-Encrypted: i=1; AHgh+RrJEBY+IrSvudKuhw7ukpmq7gXt4A4kCkaoBH901TcGDylJbeZTTchO2j4p7p73FfBe29pvhAE=@vger.kernel.org
X-Gm-Message-State: AFuF++lyRo/2Vjw1WLP5M3xQk1PYFwJLNL9RXzq4qk2oZ1bV4UpbcHQn
	ku2olOzfFMCc9SMhAmIm9Yvx/z2+ZzaFXr+pjiCXjBGeL80FUJQetJbj
X-Gm-Gg: AR+sD11IscybNhVO3nV6aDIaq48sWCsWIGma0lBOPeCOituKJ6up345YPt3bt2hQZOe
	Ev204O72xfCP+UQinNRnaYSeyC8Dg+cfqKtJtrjRLSTPZJfqMo18XVi+Zdtj/GNXuGRcPQE7RAy
	6vX8l53wAUJ7RcijJic+Momc0xERtd5ebsO8qbG3LeMid0wUfDomfT/X+PR/1KScRu78PBIjkk+
	uZlBqUEti8QrLGE3av62FtMuXXlNqWatbOM8LG9kb2d0MC4V/eULAfo/32NVPpLi86r71hwDWRq
	316E7KBClgWREGvosAzyp1Qlj5bHBvRv4hLlmm+29y0P2FBYftSPYHiUTBT2VfHebV3TrSsjoq+
	EFdaePNUV5RY0lC6M0/uZzECGfXwdT0Q7YX2RdMe9QK1enkTzhxj0aYKLBgiJEe4p6398akPFzG
	FQDBV5QEJpS2Szb6hzw8x9FnPGkJ2HtLCmyFH3xN782NzwMKcGLocsuzLkSlMaa5Bd7Pc=
X-Received: by 2002:a05:6a21:6b87:b0:3d1:39e9:b267 with SMTP id adf61e73a8af0-3d266582d7bmr49695837637.3.1788211369851;
        Mon, 31 Aug 2026 14:22:49 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::6:bac7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b49c867f5sm18516298eec.2.2026.08.31.14.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:22:49 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@roeck-us.net,
	horms@kernel.org,
	mohsin.bashr@gmail.com
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	zinclim@meta.com,
	limzhineng2@gmail.com
Subject: [PATCH net-next v2 6/6] eth: fbnic: firmware notifies hwmon on sensor threshold events
Date: Mon, 31 Aug 2026 14:22:34 -0700
Message-ID: <20260831212234.1212971-7-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831212234.1212971-1-limzhineng2@gmail.com>
References: <20260831212234.1212971-1-limzhineng2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware sends an unsolicited message via the new
FBNIC_TLV_MSG_ID_SENSOR_THRESHOLD_EXCEEDED_RESP IPC message when a
temperature or voltage sensor crosses one of its thresholds. Parse this
message and translate it into the corresponding hwmon alarm
(temp1_{min,max,crit}_alarm or in0_{min,max}_alarm) via
hwmon_notify_event(), so userspace listeners are woken on the relevant
sysfs attribute.

fbnic_hwmon_notify_event() is driven from the FW mailbox IRQ path, so it
can run concurrently with hwmon registration and teardown. Guard the
publish/teardown of fbd->hwmon: register publishes it with WRITE_ONCE()
only after a successful registration (and leaves it NULL on failure),
unregister clears it with WRITE_ONCE(NULL) and then
synchronize_irq(fbd->fw_msix_vector) to drain any in-flight mailbox IRQ
before unregistering, and notify_event reads it once with READ_ONCE() and
skips the notification when it is NULL.

Signed-off-by: Zinc Lim <limzhineng2@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 54 ++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  9 +++
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 71 ++++++++++++++++---
 4 files changed, 127 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index f647ef07704b..4a49c20e4a01 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -192,6 +192,7 @@ void fbnic_fw_free_mbx(struct fbnic_dev *fbd);
 
 void fbnic_hwmon_register(struct fbnic_dev *fbd);
 void fbnic_hwmon_unregister(struct fbnic_dev *fbd);
+void fbnic_hwmon_notify_event(struct fbnic_dev *fbd, int id, long val);
 
 int fbnic_mac_request_irq(struct fbnic_dev *fbd);
 void fbnic_mac_free_irq(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index d814bd4041a0..6dca38076d7b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -1639,6 +1639,57 @@ fbnic_fw_parser_test(void *opaque, struct fbnic_tlv_msg **results)
 	return err;
 }
 
+static const struct fbnic_tlv_index fbnic_threshold_exceeded_resp_index[] = {
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_TSENE_THERM_EXCEEDED_FLAG),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_TSENE_VOLT_EXCEEDED_FLAG),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_TSENE_THERMAL),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_TSENE_VOLTAGE),
+	FBNIC_TLV_ATTR_LAST
+};
+
+static int fbnic_fw_parse_threshold_exceeded_resp(void *opaque,
+						  struct fbnic_tlv_msg **results)
+{
+	bool therm_exceeded, volt_exceeded;
+	struct fbnic_dev *fbd = opaque;
+	s32 value;
+
+	therm_exceeded =
+		fta_get_sint(results, FBNIC_FW_TSENE_THERM_EXCEEDED_FLAG);
+	volt_exceeded =
+		fta_get_sint(results, FBNIC_FW_TSENE_VOLT_EXCEEDED_FLAG);
+
+	if (!therm_exceeded && !volt_exceeded) {
+		dev_err(fbd->dev,
+			"Threshold exceeded message with no flag set\n");
+		return -EINVAL;
+	}
+
+	if (therm_exceeded) {
+		if (!results[FBNIC_FW_TSENE_THERMAL]) {
+			dev_err(fbd->dev,
+				"Thermal threshold exceeded but no value received\n");
+			return -EINVAL;
+		}
+		value = fta_get_sint(results, FBNIC_FW_TSENE_THERMAL);
+		dev_err(fbd->dev, "Thermal threshold exceeded: %d mC\n", value);
+		fbnic_hwmon_notify_event(fbd, FBNIC_SENSOR_TEMP, value);
+	}
+
+	if (volt_exceeded) {
+		if (!results[FBNIC_FW_TSENE_VOLTAGE]) {
+			dev_err(fbd->dev,
+				"Voltage threshold exceeded but no value received\n");
+			return -EINVAL;
+		}
+		value = fta_get_sint(results, FBNIC_FW_TSENE_VOLTAGE);
+		dev_err(fbd->dev, "Voltage threshold exceeded: %d mV\n", value);
+		fbnic_hwmon_notify_event(fbd, FBNIC_SENSOR_VOLTAGE, value);
+	}
+
+	return 0;
+}
+
 static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
 	FBNIC_TLV_PARSER(TEST, fbnic_tlv_test_index, fbnic_fw_parser_test),
 	FBNIC_TLV_PARSER(FW_CAP_RESP, fbnic_fw_cap_resp_index,
@@ -1667,6 +1718,9 @@ static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
 	FBNIC_TLV_PARSER(TSENE_READ_RESP,
 			 fbnic_tsene_read_resp_index,
 			 fbnic_fw_parse_tsene_read_resp),
+	FBNIC_TLV_PARSER(SENSOR_THRESHOLD_EXCEEDED_RESP,
+			 fbnic_threshold_exceeded_resp_index,
+			 fbnic_fw_parse_threshold_exceeded_resp),
 	FBNIC_TLV_PARSER(LOG_MSG_REQ,
 			 fbnic_fw_log_req_index,
 			 fbnic_fw_parse_log_req),
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 68ffd49e0cdd..87301e608255 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -227,6 +227,7 @@ enum {
 	FBNIC_TLV_MSG_ID_QSFP_READ_RESP			= 0x39,
 	FBNIC_TLV_MSG_ID_TSENE_READ_REQ			= 0x3C,
 	FBNIC_TLV_MSG_ID_TSENE_READ_RESP		= 0x3D,
+	FBNIC_TLV_MSG_ID_SENSOR_THRESHOLD_EXCEEDED_RESP = 0x40,
 	FBNIC_TLV_MSG_ID_LOG_SEND_LOGS_REQ		= 0x43,
 	FBNIC_TLV_MSG_ID_LOG_MSG_REQ			= 0x44,
 	FBNIC_TLV_MSG_ID_LOG_MSG_RESP			= 0x45,
@@ -296,6 +297,14 @@ enum {
 	FBNIC_FW_TSENE_MSG_MAX
 };
 
+enum {
+	FBNIC_FW_TSENE_THERM_EXCEEDED_FLAG	= 0x0,
+	FBNIC_FW_TSENE_VOLT_EXCEEDED_FLAG	= 0x1,
+	FBNIC_FW_TSENE_THERMAL			= 0x2,
+	FBNIC_FW_TSENE_VOLTAGE			= 0x3,
+	FBNIC_FW_TSENE_EXCEEDED_MSG_MAX,
+};
+
 enum {
 	FBNIC_FW_OWNERSHIP_FLAG			= 0x0,
 	FBNIC_FW_OWNERSHIP_TIME			= 0x1,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
index c5cddd9cef12..3f33522fcfd2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
@@ -207,6 +207,8 @@ static const struct hwmon_chip_info fbnic_chip_info = {
 
 void fbnic_hwmon_register(struct fbnic_dev *fbd)
 {
+	struct device *hwmon;
+
 	if (!IS_REACHABLE(CONFIG_HWMON))
 		return;
 
@@ -214,22 +216,75 @@ void fbnic_hwmon_register(struct fbnic_dev *fbd)
 	fbd->hwmon_cache.temp_mdeg = FBNIC_SENSOR_NO_DATA;
 	fbd->hwmon_cache.volt_mv = FBNIC_SENSOR_NO_DATA;
 
-	fbd->hwmon = hwmon_device_register_with_info(fbd->dev, "fbnic",
-						     fbd, &fbnic_chip_info,
-						     NULL);
-	if (IS_ERR(fbd->hwmon)) {
+	hwmon = hwmon_device_register_with_info(fbd->dev, "fbnic", fbd,
+						&fbnic_chip_info, NULL);
+	if (IS_ERR(hwmon)) {
 		dev_notice(fbd->dev,
 			   "Failed to register hwmon device %pe\n",
-			   fbd->hwmon);
-		fbd->hwmon = NULL;
+			   hwmon);
+		return;
 	}
+
+	WRITE_ONCE(fbd->hwmon, hwmon);
 }
 
 void fbnic_hwmon_unregister(struct fbnic_dev *fbd)
 {
+	struct device *hwmon;
+
 	if (!IS_REACHABLE(CONFIG_HWMON) || !fbd->hwmon)
 		return;
 
-	hwmon_device_unregister(fbd->hwmon);
-	fbd->hwmon = NULL;
+	hwmon = fbd->hwmon;
+	/* Pair with READ_ONCE() in fbnic_hwmon_notify_event(). Publish NULL
+	 * and wait for any in-flight FW mailbox IRQ handler to finish so it
+	 * cannot dereference the hwmon device after we unregister it.
+	 */
+	WRITE_ONCE(fbd->hwmon, NULL);
+	synchronize_irq(fbd->fw_msix_vector);
+
+	hwmon_device_unregister(hwmon);
+}
+
+void fbnic_hwmon_notify_event(struct fbnic_dev *fbd, int id, long val)
+{
+	enum hwmon_sensor_types type;
+	struct device *hwmon;
+	s32 attr = -1;
+
+	if (!IS_REACHABLE(CONFIG_HWMON))
+		return;
+
+	switch (id) {
+	case FBNIC_SENSOR_TEMP:
+		type = hwmon_temp;
+
+		if (val <= fbd->fw_cap.temp.min)
+			attr = hwmon_temp_min_alarm;
+		else if (val >= fbd->fw_cap.temp.crit)
+			attr = hwmon_temp_crit_alarm;
+		else if (val >= fbd->fw_cap.temp.max)
+			attr = hwmon_temp_max_alarm;
+
+		break;
+	case FBNIC_SENSOR_VOLTAGE:
+		type = hwmon_in;
+
+		if (val <= fbd->fw_cap.volt.min)
+			attr = hwmon_in_min_alarm;
+		else if (val >= fbd->fw_cap.volt.max)
+			attr = hwmon_in_max_alarm;
+
+		break;
+	default:
+		return;
+	}
+
+	/* Pair with WRITE_ONCE() in fbnic_hwmon_unregister(). Skip the
+	 * notification if hwmon failed to register or has already been torn
+	 * down.
+	 */
+	hwmon = READ_ONCE(fbd->hwmon);
+	if (attr >= 0 && hwmon)
+		hwmon_notify_event(hwmon, type, attr, 0);
 }
-- 
2.53.0-Meta

