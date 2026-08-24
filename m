Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996DF37EFE3
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593879; cv=none; b=qdMDcGL3OCfTX41GpAsO1CUQnZfTxD5uOI+cLchqfYUIkbnAZKycRy9RV1lbFISXH0TbQFfEtilygzzQOShsnA6hEmGPK2Ek39ALELpbY4mcdOBuXOsk17q8hnhVuViKoXkoylNhqqKabTS4T1wSlxqFYrOmeflCv4MiM1gyins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593879; c=relaxed/simple;
	bh=DAi+XZ+iVzK9opH5tLj0PVy/X0Xxq2muFO+ODlSkT0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEET2Gq6CNBCTw7bYjTyZ38bmErI1srq7YewPTQa58FfVY30LbIvnTYyZWkj2aN9M5TPR8w7Htx8AqWFdpFTCg2aTtdTmUbbsFcAzkDIhwXf08wCgV+DTbxKfoy2hns97MoFEebw+L0QtwslfiC3ffHE0z3XppLzkC6u34GfClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtPZuA7c; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtPZuA7c"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso5243423a91.2
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787593875; x=1788198675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WjbJ4Pa6PEowkjvqP5cAHHCjr9IGaKnqwljufVDEqTA=;
        b=TtPZuA7cXtbhbi58MgYXqotecSNJH7OYhbTB0YUWp6MdRbHv7V8OmMLPggIqCXiUmk
         ErV01dqfDI2PmbXKSIedYLvM/gZcjL6UHYTtRDRSydCZDzwoLP4MNvDV8eP5cHGvhTZC
         hoRJa3ggVkVx81k+djbnNgNnA8v3jbwfVYjXGdOburwsRNlbRuqybnm9+gd6TdTh/bYp
         EtdtRV62UaVwQT1CC2gemeaYULlnt5ADgRP6Decwdy3X0371qE9TH6jhj2HILBHhzMH5
         l0zVuj4bY4lOq3zAuauG2OLjcRjMqXyrJtrow6/ET6gvW/Don89xIhfizBQxytaEnzBw
         8+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787593875; x=1788198675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WjbJ4Pa6PEowkjvqP5cAHHCjr9IGaKnqwljufVDEqTA=;
        b=ee/dbnDQM652EmsTgalWR987A11wUCnow/VXiI4ptkaGqjTDJrwoAwWv1xGgYqMqhP
         j+YJWqU5pz/PdCPfpqkq3AWTZ9CcH16aXNqpW3RjHngmsnfMWPBfix4sW6qK78hIAKfl
         3JiYgFRn7DMHes1se4awuigm5XHWM6lRhH9NyZx0m8wSqOls5pAm5n0F4PdrDP2Un13y
         HzHb/UHsHkkGqNW3I7Z0fW2L3vw10iJIHmvqwyZsERMuaRVArXqwXfgMZeRuAbIODKOS
         Eho0T80q8khqlWCO24TYahmcCsmuJ0ULtcxhsUlbFAhRPeb3XPB4V6z2EiGONXxoZRUt
         pujg==
X-Forwarded-Encrypted: i=1; AHgh+Rq9vbyFgdFBAmicjs4GeaNrG7prmqb3y3T5/dl9CAa/Ww3WhMjVlYNZZ0sNBDEDpSXeRrN9Zro=@vger.kernel.org
X-Gm-Message-State: AFuF++mTM+NvZAguTIGDiCYat+oU++Fp+ds9XNXA+IfXMpwfuSbHNc8u
	qS9cMTWGSKLE/vklIYvpFNga1z30qoumhLnatPctoMWOHvtk8S8YKttI
X-Gm-Gg: AR+sD10kGX7WCljTKfRTzGomKnCYqSBBpxQOqu57H6LqI8gSTTVkHvpPBJlWe95GfBy
	tAD0YuBke0c9bbdyIF/cfKk1awFK4shTRFSuqDTCmbd7msTn+3yr3zOyAnYnpdmhQjVo31CREgm
	xQb4I6kMnldHmM4vzR7HIDRzrdKN621NGVe70D9a9rkjqUExuIYGtuSSBuLxI+5Q2m2vfhErQWj
	jH9b8ChM/fYSy0O4dPPoB4Ctvzvbt2+ssNSv1w6trxtZYZbaau51R0X5SaIIP4YipVIJFDDLdJF
	GO+DVSQrZcTyR58Uiun8zfw7eEqo3Gmz54X5wNzyycw7NTC1svMSvxjzBYuKJFyb3BMJhcWul6J
	/gXthe920RqPC0TXDs4PbxDeBzusztV4ttHydTgFQdiYUJxUsHRCwd6FggmqPJy2nWwkFrFNeJ4
	fnHmdbl44KnGVOqW+ULbMsD534H3uD0Btp7A24lW39lkRZVU27uiPwZOFBpyf0eePXayo=
X-Received: by 2002:a17:90b:588c:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-396464bf465mr1085197a91.10.1787593874845;
        Mon, 24 Aug 2026 10:51:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:ddd2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90e22f8sm25350961eec.13.2026.08.24.10.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 10:51:14 -0700 (PDT)
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
Subject: [PATCH net-next v2 6/6] eth: fbnic: firmware notifies hwmon on sensor threshold events
Date: Mon, 24 Aug 2026 10:50:59 -0700
Message-ID: <20260824175059.2485048-7-limzhineng2@gmail.com>
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

