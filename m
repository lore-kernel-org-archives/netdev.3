Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C563A7587
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211370; cv=none; b=Zbehh/ety7taB2ZjNOxkCsdCx+slZ9eOz8Ar4uqU3NOTxKX12zHAsiaXgGQ37fw9b+3qAA/a9Ohm5MtD8tJhVcM7oiRwVfPlWfWn2/Wl6Mxsu+uUedI19LORxGSC2p/xfBqwmVRIxNoMQytYCat8nRNtXAzoNWyCnyZ6r5fse9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211370; c=relaxed/simple;
	bh=7ryBp4J/qEyf2/01p+hdf/8QZoypRA4clk5o6hi7rC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVi6oUyIECOgY944nj1KHUqPpDaovKjV7uvLBCdjkcowA15K6FTALbifn5Tlq4gySddh9+mz/QrvCjSa2YFI/iPRRa7leYrNVavNTaQaF3nEo8QfYZBzA5hS0O2rp2AT9yPMAHgs2bfNtMTeHhEpxaDH8PtE7scc+qDA5E8KLTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q12Bf5r7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q12Bf5r7"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-855d2bfae95so371596b3a.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788211367; x=1788816167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VGnbInnCX26l95VXtFdZ6NsvhwlhpXxdn0FnqPhv8qQ=;
        b=q12Bf5r7sKohjI04oZLLDJ6a4MJC4epZAHYaKAqhFKImSrCGeSpDTfmx0aZqvMOtga
         xk1e1EhnuXvS8Kf/GKFGuYS7hVrgv5B00Zl6PzbQQZ3D5FEsg69JMfvTplRBTArq94SR
         JyYBueDae1PezWvxvoOG6zQUNq/Kt0FQ8FcE/FNjvSTkyjypFCBkVED0eOWxxmlVp7PC
         LYAj93CEM8s5yIOnRcVKAPz3HIpu57nEazWC+WkiGCb6BPDd0BaxLmHpP+ZTpP9KutUw
         sZLeEo61CbbxzX731xW8bVUO7OUlde41qnZsajV7k1rSHPPZ4uJzWslI6l4VfJgWuZwD
         KueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211367; x=1788816167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VGnbInnCX26l95VXtFdZ6NsvhwlhpXxdn0FnqPhv8qQ=;
        b=NJFQjyWUVszCcNHZdidENIg0TSjiTtrRzBfTkLgheaJQ15UUcC73e+3UB4IUBv+W5W
         FzHsZ1bZUgirKAXfnIWb+389rXfRoAv1dCoXO5h4mGluLrkaiRwQ/2asR+nMn+cIPBOh
         4x4FEHbVCFuCWEZEC5wn8dfutyQjNIW4eS4KvDNnMd5SYIn77quubf1ib+39PQcpSpK0
         rzuxtNleseHwauFMrl4Nu4UZ1YoHcK5ZsuWy/81n/0aJnOaJU7II8E13F+QTNBhTd6+V
         dzdEVCCjx52qjZzk6SvuSRt4oByVGYKONhl21tfVqJJObJMtiNY52M4ubPBNrOjN7JCH
         w+Rg==
X-Forwarded-Encrypted: i=1; AHgh+RplTOBQ/W9Kr8PHLlGH+i1vRjyAL01lxTPurud3a3DauZrE8dtyOydk+H9RDmfZU1Flniw0ab0=@vger.kernel.org
X-Gm-Message-State: AFuF++nlT1W+NCfaSsN7z+J90IJF4VWbnhDXcFDuTZPR+fOMSqi0sRRk
	lu725QdN20G3oXYL0fX8EfOf2IJQ+DgjFII0Uy3Yy3eOkW4skcEk5b1r
X-Gm-Gg: AR+sD10JCplYahRcqMFi9cnl7eAXqLLjVoSLWEb0GRDbJ8IsCMbwndeIO9dmsttjqdK
	kjKyMX8FiCdmNM/bJMg69usIwenCvMQC1tc0le0fxLP3ac/vQdZwZmXxypTUC95q2xhW3szZuVV
	nwXPMs4TzNcELK6sx5FgOnCeRL1JAV3HLwQk6+xuGV415XXJT7YSqxG2hlpZ+4TLWVqUsONmIBq
	p6kwitE87BnjpP9Phli8aL5XQK0ZJ/sDI/OB3kY/Hle9u17K3XbELA0qzzySWvbB6cMWfgCEnxd
	JHigLWYEmH752QbdRIp1bSQpqSnoHT5JQ0igB6fBF+MjCZBbFNLTiyCWaQ7gr0YWMiycbF6WqGO
	8HeeOLImX4dFPwOAOJYmD2jUNY0k41J5GnA6Mc/qxTRkgGSaiNLAjgYpEuJJ691oV/NoQxcYF8v
	PaGy3F60dMchgH7bFBxUwmj98uHV6qfDlQ1qBjbd48lBIlO4AqJEULAK58d4EoSC+IWAGwQ5eLC
	y0wEQ==
X-Received: by 2002:a05:6a21:e344:b0:3cc:f9a0:3ada with SMTP id adf61e73a8af0-3d818ab8a23mr799208637.16.1788211367000;
        Mon, 31 Aug 2026 14:22:47 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::6:bac7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f8094dasm34373765eec.13.2026.08.31.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:22:46 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/6] eth: fbnic: report temperature and voltage thresholds via hwmon
Date: Mon, 31 Aug 2026 14:22:32 -0700
Message-ID: <20260831212234.1212971-5-limzhineng2@gmail.com>
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

The firmware capability response carries per-board temperature
(min/max/crit) and voltage (min/max) thresholds. Parse and store them in
fbnic_fw_cap, and expose them through the hwmon interface as
temp1_{min,max,crit} and in0_{min,max}.

The thresholds are always exposed. Values the firmware did not report are
stored as the FBNIC_SENSOR_NO_DATA sentinel in the capability response
parser, and a read of such an attribute returns -ENODATA.

Signed-off-by: Zinc Lim <limzhineng2@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 21 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    | 14 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 67 ++++++++++++++-----
 3 files changed, 87 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 283d25fae79e..d814bd4041a0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -575,6 +575,11 @@ static const struct fbnic_tlv_index fbnic_fw_cap_resp_index[] = {
 	FBNIC_TLV_ATTR_STRING(FBNIC_FW_CAP_RESP_UEFI_COMMIT_STR,
 			      FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE),
 	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_ANTI_ROLLBACK_VERSION),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_CAP_RESP_TEMP_MIN),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_CAP_RESP_TEMP_MAX),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_CAP_RESP_TEMP_CRIT),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_CAP_RESP_VOLT_MIN),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_CAP_RESP_VOLT_MAX),
 	FBNIC_TLV_ATTR_LAST
 };
 
@@ -702,6 +707,22 @@ static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
 	/* Always assume we need a BMC reinit */
 	fbd->fw_cap.need_bmc_tcam_reinit = true;
 
+	fbd->fw_cap.temp.min =
+		fbnic_tlv_attr_get_signed(results[FBNIC_FW_CAP_RESP_TEMP_MIN],
+					  FBNIC_SENSOR_NO_DATA);
+	fbd->fw_cap.temp.max =
+		fbnic_tlv_attr_get_signed(results[FBNIC_FW_CAP_RESP_TEMP_MAX],
+					  FBNIC_SENSOR_NO_DATA);
+	fbd->fw_cap.temp.crit =
+		fbnic_tlv_attr_get_signed(results[FBNIC_FW_CAP_RESP_TEMP_CRIT],
+					  FBNIC_SENSOR_NO_DATA);
+	fbd->fw_cap.volt.min =
+		fbnic_tlv_attr_get_signed(results[FBNIC_FW_CAP_RESP_VOLT_MIN],
+					  FBNIC_SENSOR_NO_DATA);
+	fbd->fw_cap.volt.max =
+		fbnic_tlv_attr_get_signed(results[FBNIC_FW_CAP_RESP_VOLT_MAX],
+					  FBNIC_SENSOR_NO_DATA);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 42a5f83ddb45..68ffd49e0cdd 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -51,6 +51,12 @@ struct fbnic_fw_ver {
  */
 #define FBNIC_SENSOR_NO_DATA			S32_MIN
 
+struct fbnic_threshold {
+	s32 min;
+	s32 max;
+	s32 crit;
+};
+
 struct fbnic_fw_cap {
 	struct {
 		struct fbnic_fw_ver mgmt, bootloader;
@@ -67,6 +73,8 @@ struct fbnic_fw_cap {
 	u8	link_speed;
 	u8	link_fec;
 	u32	anti_rollback_version;
+	struct fbnic_threshold temp;
+	struct fbnic_threshold volt;
 };
 
 struct fbnic_fw_completion {
@@ -249,6 +257,12 @@ enum {
 	FBNIC_FW_CAP_RESP_UEFI_VERSION			= 0x11,
 	FBNIC_FW_CAP_RESP_UEFI_COMMIT_STR		= 0x12,
 	FBNIC_FW_CAP_RESP_ANTI_ROLLBACK_VERSION		= 0x15,
+	/* 0x16 and 0x17 are reserved for future use */
+	FBNIC_FW_CAP_RESP_TEMP_MIN			= 0x18,
+	FBNIC_FW_CAP_RESP_TEMP_MAX			= 0x19,
+	FBNIC_FW_CAP_RESP_TEMP_CRIT			= 0x1a,
+	FBNIC_FW_CAP_RESP_VOLT_MIN			= 0x1b,
+	FBNIC_FW_CAP_RESP_VOLT_MAX			= 0x1c,
 	FBNIC_FW_CAP_RESP_MSG_MAX
 };
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
index f35cb0065093..4938f7b39140 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
@@ -7,16 +7,6 @@
 #include "fbnic.h"
 #include "fbnic_mac.h"
 
-static int fbnic_hwmon_sensor_id(enum hwmon_sensor_types type)
-{
-	if (type == hwmon_temp)
-		return FBNIC_SENSOR_TEMP;
-	if (type == hwmon_in)
-		return FBNIC_SENSOR_VOLTAGE;
-
-	return -EOPNOTSUPP;
-}
-
 static umode_t fbnic_hwmon_is_visible(const void *drvdata,
 				      enum hwmon_sensor_types type,
 				      u32 attr, int channel)
@@ -88,14 +78,58 @@ static int fbnic_hwmon_sensor_read(struct fbnic_dev *fbd, int id, long *val)
 	return err;
 }
 
+static int fbnic_hwmon_read_threshold(long thr, long *val)
+{
+	if (thr == FBNIC_SENSOR_NO_DATA)
+		return -ENODATA;
+
+	*val = thr;
+	return 0;
+}
+
+static int fbnic_hwmon_temp_read(struct fbnic_dev *fbd, u32 attr, long *val)
+{
+	switch (attr) {
+	case hwmon_temp_input:
+		return fbnic_hwmon_sensor_read(fbd, FBNIC_SENSOR_TEMP, val);
+	case hwmon_temp_min:
+		return fbnic_hwmon_read_threshold(fbd->fw_cap.temp.min, val);
+	case hwmon_temp_max:
+		return fbnic_hwmon_read_threshold(fbd->fw_cap.temp.max, val);
+	case hwmon_temp_crit:
+		return fbnic_hwmon_read_threshold(fbd->fw_cap.temp.crit, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int fbnic_hwmon_in_read(struct fbnic_dev *fbd, u32 attr, long *val)
+{
+	switch (attr) {
+	case hwmon_in_input:
+		return fbnic_hwmon_sensor_read(fbd, FBNIC_SENSOR_VOLTAGE, val);
+	case hwmon_in_min:
+		return fbnic_hwmon_read_threshold(fbd->fw_cap.volt.min, val);
+	case hwmon_in_max:
+		return fbnic_hwmon_read_threshold(fbd->fw_cap.volt.max, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int fbnic_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			    u32 attr, int channel, long *val)
 {
 	struct fbnic_dev *fbd = dev_get_drvdata(dev);
-	int id;
 
-	id = fbnic_hwmon_sensor_id(type);
-	return id < 0 ? id : fbnic_hwmon_sensor_read(fbd, id, val);
+	switch (type) {
+	case hwmon_temp:
+		return fbnic_hwmon_temp_read(fbd, attr, val);
+	case hwmon_in:
+		return fbnic_hwmon_in_read(fbd, attr, val);
+	default:
+		return -EOPNOTSUPP;
+	}
 }
 
 static const struct hwmon_ops fbnic_hwmon_ops = {
@@ -104,8 +138,11 @@ static const struct hwmon_ops fbnic_hwmon_ops = {
 };
 
 static const struct hwmon_channel_info *fbnic_hwmon_info[] = {
-	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
-	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_CRIT),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX),
 	NULL
 };
 
-- 
2.53.0-Meta

