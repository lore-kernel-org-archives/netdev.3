Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DA6392C50
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338899; cv=none; b=NtVTIXaeMGkwV1OmK68gJICgDptoAH+/kIMRnPI0KzXLNRTkgQX/oUEf6Kc2wPe1b/GaFePtFFgMcKQU/0Ayauja3ACPFs5iUkbvv1hHz8EbjeEi7mQRWjO6GOe33eudPdDBzaZ3cNtszlCeBspo6G+8ErabcSY+AcrxEX2Z3rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338899; c=relaxed/simple;
	bh=ZF32U9zlMYFE48jhznkK4QXsbBek+XgjpPXBOefbrG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a18/ncFQDYA8kpo7gtod4B6GygjBXeuX8i1YiB0xE7BeWEPgShnjGAtXxxrulyrDGadpU7w4HLHqzqB3CpWVq7yP/xqiGJANWAV/LEjjrkYfLq8D1ks4KEJ+fY1aWiHUXaP1XAxkNldaIGxM60cKHry/tDAyJIEQk8Q9zTEHE78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VIPhXb/h; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VIPhXb/h"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-38f620399a0so1234204a91.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786338897; x=1786943697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SusKBCs5LZ1A5ObQjWI9R8w0OOM+Walx7FAGnB+uchQ=;
        b=fsMyY6JQcjAyYn3kZsmnVA+rise2y3HECzUja1m3lKZ56AFZuI7qcjg3sV3WpNA32v
         Vt66HIV4ljmd2F4CJf+XjucSzDDTaB4WxXqXKKCnXKgT92sjI7DPoIqcAtoZs5Wg7Hv9
         h0AS2zpENMpmiYVof0PMSPtqL/lcvO6xZMMUxFjZLe7a5CPMAqVU46nhZbfNnQaZULKL
         yaonjpzaaeNm5sCF6Hw86TXCLxz6Ia70gHG9S7CGpBjCf4PdworcCZFCpZItQppsBM8u
         CKYmI1RFc9Og1UKgeT+8fwpm6QR0LEMaqD6/HMMfacmkuy1txUqcG2i94RY7MPMhcbId
         nPsg==
X-Gm-Message-State: AOJu0YwdlfRMJcLD929RbTcPN4d7E0lYgBxR56ZDFRHtvpZjw4v6tRwE
	0+8LcCwfEfasCGcWPcFL72Tb4+5s7m2Dfdo3FkZbHXzGjKrip/WaB2PmUDMBXfcJ+i1f4yHkHAZ
	+VaZg3Dorl2Gi3FU1Oi9N2B2wdGytYHs2rT0X+6kVe7+fD1lgrrbX55SrbVKmTGSr+ha1/ckmqz
	ftQBY5cTT6aYZ44LA7hKuUPRIg0S506a0b14kdfOD4oV8OOZnwcG3cfbxtyH6FsTgPmdt6RbRTt
	XhvrXZzaZI=
X-Gm-Gg: AR+sD11tVAI69pOktM9g8Vew9PK9ocx7halehXIkrt2uD72AGKdfBqVug9SO4lxQ3Kc
	QyBMnqHS/ykn0B4nze9IjQeBKypvgDjR0VJc1JLXGAWN2BJInYLWpXzqOajkQj1Rfy4QE/ppBQw
	ojbpVoyGDBgF39khyCWZ14KEuuGAh+9SK/Kr7O4rw/Asy7ZmIJOeIlToW4KA40hsP4R0Gp8l8mm
	ETZx69V6s/hhOZDTBcWTbaPX6sEtGNeQMAaZX3Sx4+qANIPjpj8Brr0WivkIKXvxXKmlS0xz6s+
	f4QYtWIFFQQgVkPs4As2eBb4HITTfaBe2Np5QQyFidWbCPc7VL6TPJkWTh9suZLC+27DODKSD3f
	2F6QHdN9KBjFCytE4p+0xONq3UoIFXipQ3L11kaP2K1jkl8f2ZpdZxC9xbbo8hl4M9czCQ+bt8A
	1ncbt1Ks5UUswqKx7zt5FjNo9p+mFWBJUhTJU=
X-Received: by 2002:a17:90b:4f91:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-3903c542f55mr33874442a91.1.1786338897279;
        Sun, 09 Aug 2026 22:14:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39085f5238bsm6277825a91.8.2026.08.09.22.14.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2026 22:14:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51a8b0a08d2so9882631cf.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786338896; x=1786943696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SusKBCs5LZ1A5ObQjWI9R8w0OOM+Walx7FAGnB+uchQ=;
        b=VIPhXb/hsOpPNb/f3MhPsCCYXA3FhqZ6tOgYfErhtJA2XyFqX4LCknKg1EMbRzUJ2l
         zPcwisMcQcTzz+KI35VaDmeNOZTvyhXOE2YDU/OLHyicHMgpk3e9bf6PPMYqPdypfc/I
         iBPP9DJ3/ZAoFUUlW1z6+RleF/CvCd7bgtcRE=
X-Received: by 2002:a05:622a:1650:b0:517:8011:3a4d with SMTP id d75a77b69052e-52ce60d5147mr404236991cf.20.1786338895568;
        Sun, 09 Aug 2026 22:14:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1650:b0:517:8011:3a4d with SMTP id d75a77b69052e-52ce60d5147mr404236741cf.20.1786338894923;
        Sun, 09 Aug 2026 22:14:54 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165f2c76sm64862701cf.24.2026.08.09.22.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:14:54 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v6 07/15] bnxt_en: Allocate crypto structure and backing store
Date: Sun,  9 Aug 2026 22:13:50 -0700
Message-ID: <20260810051358.1244418-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810051358.1244418-1-michael.chan@broadcom.com>
References: <20260810051358.1244418-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

If the chip and firmware support crypto (TLS) offload, allocate a
bp->crypto_info software structure and backing store to support the RX
and TX contexts.  Each offloaded TLS connection requires a backing
store context for each direction.

bp->crypto_info will stay persistent even if kTLS is no longer
supported after a FW reset.  This makes it easier to avoid NULL
dereference of bp->crypto_info during FW reset and kTLS offload
race conditions.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v4:
https://lore.kernel.org/netdev/20260629184921.3496727-8-michael.chan@broadcom.com/

Clear BNXT_FW_CAP_KTLS in bnxt_free_cryto_info()

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-8-michael.chan@broadcom.com/

bp->crypto_info and bp->ktls_info now stay persistent for the driver's
lifetime.  max keys are refreshed after re-init.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-8-michael.chan@broadcom.
---
 drivers/net/ethernet/broadcom/bnxt/Makefile   |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 83 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  | 47 +++++++++++
 include/linux/bnxt/hsi.h                      | 37 +++++++++
 6 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h

diff --git a/drivers/net/ethernet/broadcom/bnxt/Makefile b/drivers/net/ethernet/broadcom/bnxt/Makefile
index 0506574c007a..3acdb81fa958 100644
--- a/drivers/net/ethernet/broadcom/bnxt/Makefile
+++ b/drivers/net/ethernet/broadcom/bnxt/Makefile
@@ -5,4 +5,4 @@ bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.
 bnxt_en-$(CONFIG_BNXT_FLOWER_OFFLOAD) += bnxt_tc.o
 bnxt_en-$(CONFIG_DEBUG_FS) += bnxt_debugfs.o
 bnxt_en-$(CONFIG_BNXT_HWMON) += bnxt_hwmon.o
-bnxt_en-$(CONFIG_BNXT_TLS) += bnxt_mpc.o
+bnxt_en-$(CONFIG_BNXT_TLS) += bnxt_mpc.o bnxt_crypto.o
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1ec3a9a31113..c6c9950ced97 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -77,6 +77,7 @@
 #include "bnxt_gso.h"
 #include <net/tso.h>
 #include "bnxt_mpc.h"
+#include "bnxt_crypto.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
@@ -9386,6 +9387,7 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
 
 static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
 {
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
 	struct bnxt_mpc_info *mpc = bp->mpc_info;
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	struct bnxt_ctx_mem_type *ctxm;
@@ -9393,6 +9395,19 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
 	int rc = 0;
 	u16 type;
 
+	if (BNXT_SUPPORTS_KTLS(bp)) {
+		ctxm = &ctx->ctx_arr[BNXT_CTX_TCK];
+		rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm,
+					     BNXT_TCK(crypto).max_ctx, 1);
+		if (rc)
+			return rc;
+		ctxm = &ctx->ctx_arr[BNXT_CTX_RCK];
+		rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm,
+					     BNXT_RCK(crypto).max_ctx, 1);
+		if (rc)
+			return rc;
+		last_type = BNXT_CTX_RCK;
+	}
 	if (mpc && mpc->mpc_chnls_cap) {
 		ctxm = &ctx->ctx_arr[BNXT_CTX_MTQM];
 		rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, ctxm->max_entries, 1);
@@ -9935,6 +9950,10 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_BACKING_STORE_V2;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_TX_COAL_CMPL_CAP)
 		bp->flags |= BNXT_FLAG_TX_COAL_CMPL;
+	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_KTLS_SUPPORTED)
+		bnxt_alloc_crypto_info(bp, resp);
+	else
+		bp->fw_cap &= ~BNXT_FW_CAP_KTLS;
 
 	flags_ext2 = le32_to_cpu(resp->flags_ext2);
 	if (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_RX_ALL_PKTS_TIMESTAMPS_SUPPORTED)
@@ -16639,6 +16658,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bp->ptp_cfg = NULL;
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_crypto_info(bp);
 	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
@@ -17322,6 +17342,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_ethtool_free(bp);
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_crypto_info(bp);
 	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e61e697e9085..3f0307cd144d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2462,6 +2462,7 @@ struct bnxt {
 	u8			tph_mode;
 
 	struct bnxt_mpc_info	*mpc_info;
+	struct bnxt_crypto_info	*crypto_info;
 
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
@@ -2549,6 +2550,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_NPAR_1_2			BIT_ULL(42)
 	#define BNXT_FW_CAP_MIRROR_ON_ROCE		BIT_ULL(43)
 	#define BNXT_FW_CAP_PTP_PTM			BIT_ULL(44)
+	#define BNXT_FW_CAP_KTLS			BIT_ULL(45)
 
 	u32			fw_dbg_cap;
 
@@ -2574,6 +2576,8 @@ struct bnxt {
 	((bp)->fw_cap & BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS)
 #define BNXT_MIRROR_ON_ROCE_CAP(bp)	\
 	((bp)->fw_cap & BNXT_FW_CAP_MIRROR_ON_ROCE)
+#define BNXT_SUPPORTS_KTLS(bp)	\
+	((bp)->fw_cap & BNXT_FW_CAP_KTLS)
 
 	u32			hwrm_spec_code;
 	u16			hwrm_cmd_seq;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
new file mode 100644
index 000000000000..5bc31ee8d7fd
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/bnxt/hsi.h>
+
+#include "bnxt.h"
+#include "bnxt_crypto.h"
+
+static u32 bnxt_get_max_crypto_key_ctx(struct bnxt *bp, int key_type)
+{
+	u32 fw_maj = BNXT_FW_MAJ(bp);
+
+	if (key_type == BNXT_TX_CRYPTO_KEY_TYPE)
+		return (fw_maj < 233) ? BNXT_MAX_TX_CRYPTO_KEYS_PRE_233FW :
+		       BNXT_MAX_TX_CRYPTO_KEYS;
+
+	return (fw_maj < 233) ? BNXT_MAX_RX_CRYPTO_KEYS_PRE_233FW :
+	       BNXT_MAX_RX_CRYPTO_KEYS;
+}
+
+/**
+ * bnxt_alloc_crypto_info - Allocate and initialize crypto offload context
+ * @bp: pointer to bnxt device
+ * @resp: pointer to firmware capability response
+ *
+ * Allocates the main crypto info structure
+ *
+ * This function is called during device initialization when firmware
+ * reports crypto offload capability. If allocation fails, crypto offload
+ * will not be available but the device will still function.
+ *
+ * Context: Process context
+ */
+void bnxt_alloc_crypto_info(struct bnxt *bp,
+			    struct hwrm_func_qcaps_output *resp)
+{
+	u16 max_keys = le16_to_cpu(resp->max_key_ctxs_alloc);
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+	struct bnxt_kctx *kctx;
+	int i;
+
+	if (BNXT_VF(bp))
+		return;
+	if (!crypto) {
+		crypto = kzalloc_obj(*crypto);
+		if (!crypto) {
+			netdev_warn(bp->dev,
+				    "Unable to allocate crypto info\n");
+			return;
+		}
+		for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
+			kctx = &crypto->kctx[i];
+			kctx->type = i;
+		}
+		bp->crypto_info = crypto;
+	}
+	for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
+		kctx = &crypto->kctx[i];
+		kctx->max_ctx = bnxt_get_max_crypto_key_ctx(bp, i);
+	}
+	crypto->max_key_ctxs_alloc = max_keys;
+	bp->fw_cap |= BNXT_FW_CAP_KTLS;
+}
+
+/**
+ * bnxt_free_crypto_info - Free crypto offload resources
+ * @bp: pointer to bnxt device
+ *
+ * Frees all resources associated with crypto offload.  Call this function
+ * only when it is idle with nothing in-flight.
+ *
+ * Context: Process context during device shutdown/removal
+ */
+void bnxt_free_crypto_info(struct bnxt *bp)
+{
+	kfree(bp->crypto_info);
+	bp->crypto_info = NULL;
+	bp->fw_cap &= ~BNXT_FW_CAP_KTLS;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
new file mode 100644
index 000000000000..629388fe1e6d
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#ifndef BNXT_CRYPTO_H
+#define BNXT_CRYPTO_H
+
+#define BNXT_MAX_TX_CRYPTO_KEYS		204800
+#define BNXT_MAX_RX_CRYPTO_KEYS		204800
+
+#define BNXT_MAX_TX_CRYPTO_KEYS_PRE_233FW	65535
+#define BNXT_MAX_RX_CRYPTO_KEYS_PRE_233FW	65535
+
+enum bnxt_crypto_type {
+	BNXT_TX_CRYPTO_KEY_TYPE = FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_TX,
+	BNXT_RX_CRYPTO_KEY_TYPE = FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_RX,
+	BNXT_MAX_CRYPTO_KEY_TYPE,
+};
+
+struct bnxt_kctx {
+	u8			type;
+	u32			max_ctx;
+};
+
+struct bnxt_crypto_info {
+	u16			max_key_ctxs_alloc;
+
+	struct bnxt_kctx	kctx[BNXT_MAX_CRYPTO_KEY_TYPE];
+};
+
+#define BNXT_TCK(crypto)	((crypto)->kctx[BNXT_TX_CRYPTO_KEY_TYPE])
+#define BNXT_RCK(crypto)	((crypto)->kctx[BNXT_RX_CRYPTO_KEY_TYPE])
+
+#ifdef CONFIG_BNXT_TLS
+void bnxt_alloc_crypto_info(struct bnxt *bp,
+			    struct hwrm_func_qcaps_output *resp);
+void bnxt_free_crypto_info(struct bnxt *bp);
+#else
+static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
+					  struct hwrm_func_qcaps_output *resp)
+{
+}
+
+static inline void bnxt_free_crypto_info(struct bnxt *bp)
+{
+}
+#endif	/* CONFIG_BNXT_TLS */
+#endif	/* BNXT_CRYPTO_H */
diff --git a/include/linux/bnxt/hsi.h b/include/linux/bnxt/hsi.h
index 74a6bf278d88..03444b81beb0 100644
--- a/include/linux/bnxt/hsi.h
+++ b/include/linux/bnxt/hsi.h
@@ -3837,6 +3837,43 @@ struct hwrm_func_ptp_ext_qcfg_output {
 	u8	valid;
 };
 
+/* hwrm_func_key_ctx_alloc_input (size:384b/48B) */
+struct hwrm_func_key_ctx_alloc_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	fid;
+	__le16	num_key_ctxs;
+	__le32	dma_bufr_size_bytes;
+	u8	key_ctx_type;
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_TX      0x0UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_RX      0x1UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_QUIC_TX 0x2UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_QUIC_RX 0x3UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_LAST   FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_QUIC_RX
+	u8	unused_0[7];
+	__le64	host_dma_addr;
+	__le32	partition_start_xid;
+	u8	unused_1[4];
+};
+
+/* hwrm_func_key_ctx_alloc_output (size:192b/24B) */
+struct hwrm_func_key_ctx_alloc_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	num_key_ctxs_allocated;
+	u8	flags;
+	#define FUNC_KEY_CTX_ALLOC_RESP_FLAGS_KEY_CTXS_CONTIGUOUS     0x1UL
+	u8	unused_0;
+	__le32	partition_start_xid;
+	u8	unused_1[7];
+	u8	valid;
+};
+
 /* hwrm_func_backing_store_cfg_v2_input (size:512b/64B) */
 struct hwrm_func_backing_store_cfg_v2_input {
 	__le16	req_type;
-- 
2.51.0

