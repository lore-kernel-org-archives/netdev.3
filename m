Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD12395D99
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338911; cv=none; b=Q9FLvkBS1kUtmDkkQhKZmZ+kYHyEswP8PzR5pgDlEEaoS9aS5wR+TMRNjGu3ZxIXLGvAAkh8PMTbHCUSSa7DnGdcOTCS4B5T7g+bJo6kXcFph/fOln1+znYYCkszohZTQYQi3lgLFR4m/i+PdMfw/ebL5DqTuzJrbIj5BP9HyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338911; c=relaxed/simple;
	bh=2lpoIORG2SM49H5ldGWzSJFqJpm6rg1QD9PWk0p2XeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPcRNNip02AtPK68dgHyC9fC8luwSF93Dp10ZgOQz99C8hSmOapt/9KEX1/qwJlfbRzM4EW7uTi60+FzRWjf6xzQ0q+epMiVmpaVW3haiTHeHkVLcnzUyEYmI7ixCY5PV6j2Y9iN/2uvZqzu8SJfLjZgalUEHRArILiU/Kq1unE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RcBtYVvq; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RcBtYVvq"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso873564b3a.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786338909; x=1786943709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GpbrEj8gsvYwQ+XPIC67jwqDkOMIk9TVo37wh0ExWwI=;
        b=BcaZIezm2h9xZalDjmOCrVGUqFQFL8zzTAl6g2UMHlB1ASHSMsCS5vA5T6ZeONfwQG
         wugxkC/6/xr8Adam4rhVaHav+PY29njVF/6JfKVb6MhjIyQT92oxVRwFXKH8FcqAVA5d
         GonjQb70W9VrPugFK8C84Muy4I+o2HQ9Pj0vaGbJrpJZEifVbtiVFLIBP2F0u+rCs6LY
         RKe7LNGc6+mvfmAkpbWlWWz8KzexbDCp0ePOJeYSlNm4xbwE6WTA7uJbHsTDPixRyoZD
         i2w4zR9wGUHSQskIAurwzMvXpmLZxJ9rHCsfPqlsfi9y4s0W635p/ZebNJlXSiTAlF+5
         pfbQ==
X-Gm-Message-State: AOJu0YyFjg9tpRCdMgW3VdCAzzTgXR1VxXeojnyFB5tTy+s4Wplv7Odh
	WYkfPl6o1uFHWC04xw1ssL2vdhcRhaRIOBL2r+Bh2c1xNi608U/AufRo05PTnKqizCANvZU7OlD
	W4H2k1vLHTDfTNRYmI0QIfk4db/+04EEFJIsD++gLiYU1aQcIrToL4W3AW4bS7E8Lebic+5nL/w
	+D6OL0awV3c2OCAjOIQGf6VKvyXe847KPbK91LQ3yXY4zlXTRVHGin/qhDdfT2+c/flEXv2ucFB
	LYVPluLlhw=
X-Gm-Gg: AR+sD113tbxfpKdmt2lk3t9mg3FvXmptX1BCZeAPbaItnqtRsKS9BTtOhuAIQF3u63j
	oo9dSb6CdpC8uJYCwdvKGrzC9WNtTeRGY18326BKca6XRtq/nLt9rNnE4uNgLrsUuhkHuBGV8YO
	1ebjBel40gCaSjF4G45yn/TA9Qyv916w2gGvuVftFWT6tk5GTQOUQkxoI8ldoyeh7vPQgJj/m/F
	C9Dt4huoyqBmr3fvLg66TOAnoPHJcwUHr75Rad051uSOLf8O0fsKQtc5zF0+AoJF02oPDMmEClo
	63VYyftn1EwHRGP6ZtgRVlgx7QUCD/r0uVVuhrRwtpmijOAPbgKCcwoIflvoXzWfgoj+VM2Xdk7
	x3TFYHI8SzdKRW0Vx7UpAjz2hL/VGIHtVkxLRP3B31phlDbJokCBRNUiDT6NYtpmKr5jw6IQSRz
	B2s/5awWhv3C9LMEcnxJlrMF5VNCssns6S+kE=
X-Received: by 2002:a05:6a00:ba06:b0:84d:ff47:fa53 with SMTP id d2e1a72fcca58-84f4fd9f842mr31127819b3a.2.1786338908473;
        Sun, 09 Aug 2026 22:15:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cbe8f382b4esm1803284a12.11.2026.08.09.22.15.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2026 22:15:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52b4f6ac06aso27400661cf.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786338907; x=1786943707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GpbrEj8gsvYwQ+XPIC67jwqDkOMIk9TVo37wh0ExWwI=;
        b=RcBtYVvqN3MqIigiriv038PRgtVBM3big30eN0QU9AOzg0ll5hUZ0TQLU96KSsnGuK
         T7X9Zfq0w0X3H1Uu6gxkSIGW1TLQbXV6ltxzweJdbOjkQLFvcQraOHd56eUikUiWqT2W
         8zcyy2vO7DTDxyAGFjwxrGAjbumqPVTw7mPzE=
X-Received: by 2002:ac8:5ad5:0:b0:52b:4e1f:941d with SMTP id d75a77b69052e-52d0b003f05mr293506271cf.6.1786338906781;
        Sun, 09 Aug 2026 22:15:06 -0700 (PDT)
X-Received: by 2002:ac8:5ad5:0:b0:52b:4e1f:941d with SMTP id d75a77b69052e-52d0b003f05mr293505531cf.6.1786338906264;
        Sun, 09 Aug 2026 22:15:06 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165f2c76sm64862701cf.24.2026.08.09.22.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:15:04 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v6 12/15] bnxt_en: Support kTLS TX offload by implementing .tls_dev_add/del()
Date: Sun,  9 Aug 2026 22:13:55 -0700
Message-ID: <20260810051358.1244418-13-michael.chan@broadcom.com>
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

Add basic infrastructure to allocate and free kTLS context IDs (KIDs)
to support kTLS TX offload.  To offload a connection in .tls_dev_add(),
the first step is to allocate a KID.  After that the kTLS offload
command is sent to the HW via MPC using the function
bnxt_xmit_crypto_cmd() introduced in the last patch.

In .tls_dev_del(), we send the delete command to the HW using the
same bnxt_xmit_crypto_cmd().  After that we free the KID, making it
available for new offload.  There is extra logic to handle ifdown,
FW reset, and device reconfiguration while deleting the connection.

bnxt_ktls_init() assigns bnxt_ktls_ops to the netdev and sets up
the TLS TX offload feature.  bnxt_ktls_init() will be called in
the next patch.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v4:
https://lore.kernel.org/netdev/20260629184921.3496727-13-michael.chan@broadcom.com/

Fix uninitialized kctx_tx variable warning.

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-13-michael.chan@broadcom.com/

Use wait_event() in bnxt_ktls_dev_del() in case the device is in transient
reconfig state instead of poll wait.

Call bnxt_crypto_del_all() after BNXT_STATE_OPEN is cleared as documented.

Use memzero_explicit() to clear sensitive TLS parameters.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-13-michael.chan@broadcom.com/

Fix unused variable warning
Fix error recovery issues

v1:
https://lore.kernel.org/netdev/20260504235836.3019499-13-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/Makefile   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  16 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   1 +
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  |  82 ++++-
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  |  11 +
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.c    | 345 ++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.h    | 112 ++++++
 7 files changed, 566 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h

diff --git a/drivers/net/ethernet/broadcom/bnxt/Makefile b/drivers/net/ethernet/broadcom/bnxt/Makefile
index 3acdb81fa958..88e68248aad4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/Makefile
+++ b/drivers/net/ethernet/broadcom/bnxt/Makefile
@@ -5,4 +5,4 @@ bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.
 bnxt_en-$(CONFIG_BNXT_FLOWER_OFFLOAD) += bnxt_tc.o
 bnxt_en-$(CONFIG_DEBUG_FS) += bnxt_debugfs.o
 bnxt_en-$(CONFIG_BNXT_HWMON) += bnxt_hwmon.o
-bnxt_en-$(CONFIG_BNXT_TLS) += bnxt_mpc.o bnxt_crypto.o
+bnxt_en-$(CONFIG_BNXT_TLS) += bnxt_mpc.o bnxt_crypto.o bnxt_ktls.o
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 044e685e8efb..42f14c8fa458 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -78,6 +78,7 @@
 #include <net/tso.h>
 #include "bnxt_mpc.h"
 #include "bnxt_crypto.h"
+#include "bnxt_ktls.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
@@ -13351,6 +13352,7 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 		static_branch_disable(&bnxt_xdp_locking_key);
 	}
 	set_bit(BNXT_STATE_OPEN, &bp->state);
+	bnxt_ktls_wake(bp);
 	bnxt_enable_int(bp);
 	/* Enable TX queues */
 	bnxt_tx_enable(bp);
@@ -13492,7 +13494,8 @@ static int bnxt_open(struct net_device *dev)
 static bool bnxt_drv_busy(struct bnxt *bp)
 {
 	return (test_bit(BNXT_STATE_IN_SP_TASK, &bp->state) ||
-		test_bit(BNXT_STATE_READ_STATS, &bp->state));
+		test_bit(BNXT_STATE_READ_STATS, &bp->state) ||
+		bnxt_ktls_busy(bp));
 }
 
 static void bnxt_get_ring_stats(struct bnxt *bp,
@@ -13510,9 +13513,20 @@ static void __bnxt_close_nic(struct bnxt *bp, bool irq_re_init,
 
 	clear_bit(BNXT_STATE_OPEN, &bp->state);
 	smp_mb__after_atomic();
+	/* Wake any kTLS delete waiting on a reconfig so it re-evaluates and
+	 * either keeps waiting for the reopen or aborts (ifdown / FW reset).
+	 */
+	bnxt_ktls_wake(bp);
 	while (bnxt_drv_busy(bp))
 		msleep(20);
 
+	/* Delete all crypto connections and KIDs only on ifdown and FW reset,
+	 * not ethtool config changes.
+	 */
+	if (!netif_running(bp->dev) ||
+	    test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
+		bnxt_crypto_del_all(bp);
+
 	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
 		bnxt_clear_rss_ctxs(bp);
 	/* Flush rings and disable interrupts */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e2d781d0e390..b598e6718f38 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2477,6 +2477,7 @@ struct bnxt {
 
 	struct bnxt_mpc_info	*mpc_info;
 	struct bnxt_crypto_info	*crypto_info;
+	struct bnxt_tls_info	*ktls_info;
 
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
index 44362acb1633..75baf19f9146 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -11,6 +11,7 @@
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_mpc.h"
+#include "bnxt_ktls.h"
 #include "bnxt_crypto.h"
 
 static u32 bnxt_get_max_crypto_key_ctx(struct bnxt *bp, int key_type)
@@ -80,13 +81,91 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
 		kctx->max_ctx = bnxt_get_max_crypto_key_ctx(bp, i);
 	}
 	crypto->max_key_ctxs_alloc = max_keys;
-	bp->fw_cap |= BNXT_FW_CAP_KTLS;
+	if (!bp->ktls_info)
+		bnxt_alloc_ktls_info(bp);
+	if (bp->ktls_info)
+		bp->fw_cap |= BNXT_FW_CAP_KTLS;
 	return;
 
 alloc_err:
 	kfree(crypto);
 }
 
+int bnxt_crypto_del(struct bnxt *bp, u8 type, u8 kind, u32 kid)
+{
+	struct bnxt_tx_ring_info *txr;
+	struct ce_delete_cmd cmd = {};
+	u32 data;
+
+	if (BNXT_NO_FW_ACCESS(bp))
+		return 0;
+
+	txr = bnxt_select_mpc_ring(bp, type);
+	if (!txr)
+		return -ENODEV;
+	if (kind == BNXT_CTX_KIND_CK_TX)
+		data = CE_DELETE_CMD_CTX_KIND_CK_TX;
+	else if (kind == BNXT_CTX_KIND_CK_RX)
+		data = CE_DELETE_CMD_CTX_KIND_CK_RX;
+	else
+		return -EINVAL;
+
+	data |= CE_DELETE_CMD_OPCODE_DEL |
+		(BNXT_KID_HW(kid) << CE_DELETE_CMD_KID_SFT);
+
+	cmd.ctx_kind_kid_opcode = cpu_to_le32(data);
+	return bnxt_xmit_crypto_cmd(bp, txr, &cmd, sizeof(cmd),
+				    BNXT_MPC_TMO_MSECS);
+}
+
+static void bnxt_crypto_del_all_kids(struct bnxt *bp, struct bnxt_kid_info *kid)
+{
+	int i, rc;
+
+	for (i = 0; i < kid->count; i++) {
+		if (!test_bit(i, kid->ids)) {
+			rc = bnxt_crypto_del(bp, kid->type, kid->kind,
+					     kid->start_id + i);
+			if (!rc)
+				set_bit(i, kid->ids);
+		}
+	}
+}
+
+/**
+ * bnxt_crypto_del_all - Delete all crypto connections
+ * @bp: pointer to bnxt device
+ *
+ * Delete all crypto connections and free all KIDs for re-use during
+ * shutdown.  Increment the epoch counter to invalidate any outstanding
+ * key references.
+ *
+ * Locking: the caller must have cleared BNXT_STATE_OPEN and waited for all
+ * in-flight kTLS control ops to drain.  Under these preconditions there are
+ * no concurrent readers or writers of the KID lists, so the lists can be
+ * walked without rcu_read_lock() or the kctx lock.
+ *
+ * Context: Process context during shutdown/reset
+ */
+void bnxt_crypto_del_all(struct bnxt *bp)
+{
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+	struct bnxt_kid_info *kid;
+	struct bnxt_kctx *kctx;
+	int i;
+
+	if (!crypto)
+		return;
+
+	/* No concurrent access; see the locking note above. */
+	for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
+		kctx = &crypto->kctx[i];
+		list_for_each_entry(kid, &kctx->list, list)
+			bnxt_crypto_del_all_kids(bp, kid);
+		kctx->epoch = BNXT_NEXT_EPOCH(kctx->epoch);
+	}
+}
+
 /**
  * bnxt_clear_crypto - Clear all crypto key contexts
  * @bp: pointer to bnxt device
@@ -137,6 +216,7 @@ void bnxt_free_crypto_info(struct bnxt *bp)
 {
 	struct bnxt_crypto_info *crypto = bp->crypto_info;
 
+	bnxt_free_ktls_info(bp);
 	if (!crypto)
 		return;
 	bnxt_clear_crypto(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
index 8a2cbb7603a8..d4759059a6d2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
@@ -148,6 +148,8 @@ struct bnxt_crypto_cmd_ctx {
 #ifdef CONFIG_BNXT_TLS
 void bnxt_alloc_crypto_info(struct bnxt *bp,
 			    struct hwrm_func_qcaps_output *resp);
+int bnxt_crypto_del(struct bnxt *bp, u8 type, u8 kind, u32 kid);
+void bnxt_crypto_del_all(struct bnxt *bp);
 void bnxt_clear_crypto(struct bnxt *bp);
 void bnxt_free_crypto_info(struct bnxt *bp);
 void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
@@ -167,6 +169,15 @@ static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
 {
 }
 
+static inline int bnxt_crypto_del(struct bnxt *bp, u8 type, u8 kind, u32 kid)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void bnxt_crypto_del_all(struct bnxt *bp)
+{
+}
+
 static inline void bnxt_clear_crypto(struct bnxt *bp)
 {
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
new file mode 100644
index 000000000000..cec877075b16
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#include <net/tls.h>
+#include <linux/bnxt/hsi.h>
+
+#include "bnxt.h"
+#include "bnxt_mpc.h"
+#include "bnxt_crypto.h"
+#include "bnxt_ktls.h"
+
+/**
+ * bnxt_alloc_ktls_info - Allocate and initialize kTLS offload context
+ * @bp: pointer to bnxt device
+ *
+ * Allocates the main kTLS crypto info structure
+ *
+ * This function is called during device initialization when firmware
+ * reports kTLS offload capability. If allocation fails, kTLS offload
+ * will not be available but the device will still function.
+ *
+ * Context: Process context
+ *
+ * Return: zero on success, negative error code otherwise:
+ *	ENOMEM: out of memory
+ */
+int bnxt_alloc_ktls_info(struct bnxt *bp)
+{
+	struct bnxt_tls_info *ktls = bp->ktls_info;
+
+	if (BNXT_VF(bp))
+		return -EOPNOTSUPP;
+	if (ktls)
+		return 0;
+
+	ktls = kzalloc_obj(*ktls);
+	if (!ktls) {
+		netdev_warn(bp->dev, "Unable to allocate kTLS info\n");
+		return -ENOMEM;
+	}
+	ktls->counters = kzalloc_objs(*ktls->counters,
+				      BNXT_KTLS_MAX_CTRL_COUNTERS);
+	if (!ktls->counters)
+		goto ktls_err;
+
+	init_waitqueue_head(&ktls->open_wq);
+	bp->ktls_info = ktls;
+	return 0;
+
+ktls_err:
+	kfree(ktls->counters);
+	kfree(ktls);
+	return -ENOMEM;
+}
+
+/**
+ * bnxt_free_ktls_info - Free kTLS crypto offload resources
+ * @bp: pointer to bnxt device
+ *
+ * Frees all resources associated with kTLS crypto offload
+ *
+ * Context: Process context during device shutdown/removal
+ */
+void bnxt_free_ktls_info(struct bnxt *bp)
+{
+	struct bnxt_tls_info *ktls = bp->ktls_info;
+
+	if (!ktls)
+		return;
+	kfree(ktls->counters);
+	kfree(ktls);
+	bp->ktls_info = NULL;
+}
+
+/* Copy in reverse byte order */
+static void bnxt_copy_tls_mp_data(u8 *dst, u8 *src, int bytes)
+{
+	int i;
+
+	for (i = 0; i < bytes; i++)
+		dst[bytes - i - 1] = src[i];
+}
+
+static int bnxt_crypto_add(struct bnxt *bp, enum tls_offload_ctx_dir direction,
+			   struct tls_crypto_info *crypto_info, u32 tcp_seq_no,
+			   u32 kid)
+{
+	struct bnxt_tx_ring_info *txr;
+	struct ce_add_cmd cmd = {0};
+	u32 data;
+	int rc;
+
+	if (direction == TLS_OFFLOAD_CTX_DIR_TX) {
+		txr = bnxt_select_mpc_ring(bp, BNXT_MPC_TCE_TYPE);
+		cmd.ctx_kind = CE_ADD_CMD_CTX_KIND_CK_TX;
+	} else {
+		return -EOPNOTSUPP;
+	}
+	if (!txr)
+		return -ENODEV;
+
+	data = CE_ADD_CMD_OPCODE_ADD | (BNXT_KID_HW(kid) << CE_ADD_CMD_KID_SFT);
+	switch (crypto_info->cipher_type) {
+	case TLS_CIPHER_AES_GCM_128: {
+		struct tls12_crypto_info_aes_gcm_128 *aes;
+
+		aes = (void *)crypto_info;
+		data |= CE_ADD_CMD_ALGORITHM_AES_GCM_128;
+		if (crypto_info->version == TLS_1_3_VERSION)
+			data |= CE_ADD_CMD_VERSION_TLS1_3;
+		memcpy(&cmd.session_key, aes->key, sizeof(aes->key));
+		memcpy(&cmd.salt, aes->salt, sizeof(aes->salt));
+		memcpy(&cmd.addl_iv, aes->iv, sizeof(aes->iv));
+		bnxt_copy_tls_mp_data(cmd.record_seq_num, aes->rec_seq,
+				      sizeof(aes->rec_seq));
+		break;
+	}
+	case TLS_CIPHER_AES_GCM_256: {
+		struct tls12_crypto_info_aes_gcm_256 *aes;
+
+		aes = (void *)crypto_info;
+		data |= CE_ADD_CMD_ALGORITHM_AES_GCM_256;
+		if (crypto_info->version == TLS_1_3_VERSION)
+			data |= CE_ADD_CMD_VERSION_TLS1_3;
+		memcpy(&cmd.session_key, aes->key, sizeof(aes->key));
+		memcpy(&cmd.salt, aes->salt, sizeof(aes->salt));
+		memcpy(&cmd.addl_iv, aes->iv, sizeof(aes->iv));
+		bnxt_copy_tls_mp_data(cmd.record_seq_num, aes->rec_seq,
+				      sizeof(aes->rec_seq));
+		break;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+	cmd.ver_algo_kid_opcode = cpu_to_le32(data);
+	cmd.pkt_tcp_seq_num = cpu_to_le32(tcp_seq_no);
+	cmd.tls_header_tcp_seq_num = cmd.pkt_tcp_seq_num;
+	rc = bnxt_xmit_crypto_cmd(bp, txr, &cmd, sizeof(cmd),
+				  BNXT_MPC_TMO_MSECS);
+	memzero_explicit(&cmd, sizeof(cmd));
+	return rc;
+}
+
+static bool bnxt_ktls_cipher_supported(struct bnxt *bp,
+				       struct tls_crypto_info *crypto_info)
+{
+	u16 type = crypto_info->cipher_type;
+	u16 version = crypto_info->version;
+
+	if ((type == TLS_CIPHER_AES_GCM_128 ||
+	     type == TLS_CIPHER_AES_GCM_256) &&
+	    (version == TLS_1_2_VERSION ||
+	     version == TLS_1_3_VERSION))
+		return true;
+	return false;
+}
+
+static void bnxt_set_ktls_ctx_tx(struct tls_context *tls_ctx,
+				 struct bnxt_ktls_offload_ctx_tx *kctx_tx)
+{
+	struct bnxt_ktls_tx_driver_state *tx =
+		__tls_driver_ctx(tls_ctx, TLS_OFFLOAD_CTX_DIR_TX);
+
+	tx->ctx_tx = kctx_tx;
+}
+
+static struct bnxt_ktls_offload_ctx_tx *
+bnxt_get_ktls_ctx_tx(struct tls_context *tls_ctx)
+{
+	struct bnxt_ktls_tx_driver_state *tx =
+		__tls_driver_ctx(tls_ctx, TLS_OFFLOAD_CTX_DIR_TX);
+
+	return tx->ctx_tx;
+}
+
+static int bnxt_ktls_dev_add(struct net_device *dev, struct sock *sk,
+			     enum tls_offload_ctx_dir direction,
+			     struct tls_crypto_info *crypto_info,
+			     u32 start_offload_tcp_sn)
+{
+	struct bnxt_ktls_offload_ctx_tx *kctx_tx;
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_crypto_info *crypto;
+	struct tls_context *tls_ctx;
+	struct bnxt_tls_info *ktls;
+	struct bnxt_kctx *kctx;
+	u32 kid;
+	int rc;
+
+	BUILD_BUG_ON(sizeof(struct bnxt_ktls_tx_driver_state) >
+		     TLS_DRIVER_STATE_SIZE_TX);
+
+	ktls = bp->ktls_info;
+	if (direction == TLS_OFFLOAD_CTX_DIR_RX)
+		return -EOPNOTSUPP;
+
+	if (!BNXT_SUPPORTS_KTLS(bp)) {
+		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_NO_CAP]);
+		return -EOPNOTSUPP;
+	}
+	atomic_inc(&ktls->pending);
+	/* Make sure bnxt_close_nic() sees pending before we check the
+	 * BNXT_STATE_OPEN flag.
+	 */
+	smp_mb__after_atomic();
+	if (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
+		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_STATE_NOT_OPEN]);
+		rc = -ENODEV;
+		goto exit;
+	}
+
+	if (!bnxt_ktls_cipher_supported(bp, crypto_info)) {
+		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_INVALID_CIPHER]);
+		rc = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	kctx_tx = kzalloc_obj(*kctx_tx);
+	if (!kctx_tx) {
+		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_NO_MEM]);
+		rc = -ENOMEM;
+		goto exit;
+	}
+	tls_ctx = tls_get_ctx(sk);
+	crypto = bp->crypto_info;
+	kctx = &crypto->kctx[BNXT_TX_CRYPTO_KEY_TYPE];
+	rc = bnxt_key_ctx_alloc_one(bp, kctx, BNXT_CTX_KIND_CK_TX, &kid);
+	if (rc) {
+		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_KEY_CTX_ALLOC]);
+		goto free_ctx;
+	}
+	rc = bnxt_crypto_add(bp, direction, crypto_info, start_offload_tcp_sn,
+			     kid);
+	if (rc) {
+		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_CRYPTO_CMD]);
+		goto free_kctx;
+	}
+	kctx_tx->kid = kid;
+	kctx_tx->tcp_seq_no = start_offload_tcp_sn;
+	bnxt_set_ktls_ctx_tx(tls_ctx, kctx_tx);
+	atomic64_inc(&ktls->counters[BNXT_KTLS_TX_ADD]);
+	goto exit;
+
+free_kctx:
+	/* This KID was just allocated while holding ktls->pending, so epoch
+	 * check is unnecessary.
+	 */
+	bnxt_free_one_kctx(kctx, kid);
+free_ctx:
+	kfree(kctx_tx);
+exit:
+	atomic_dec(&ktls->pending);
+	return rc;
+}
+
+#define KTLS_RETRY_MAX		100
+#define KTLS_WAIT_TMO_MS	100
+
+static void bnxt_ktls_dev_del(struct net_device *dev,
+			      struct tls_context *tls_ctx,
+			      enum tls_offload_ctx_dir direction)
+{
+	struct bnxt_ktls_offload_ctx_tx *kctx_tx;
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_crypto_info *crypto;
+	struct bnxt_tls_info *ktls;
+	struct bnxt_kctx *kctx;
+	int retry_cnt = 0;
+	u8 kind;
+	u32 kid;
+
+	ktls = bp->ktls_info;
+	kctx_tx = bnxt_get_ktls_ctx_tx(tls_ctx);
+retry:
+	if (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
+		/* During ifdown or FW reset, all connections will be torn
+		 * down by bnxt_crypto_del_all() / FUNC_RESET, so nothing to
+		 * do here.  Only a reconfiguration is transient and
+		 * __bnxt_open_nic() will set BNXT_STATE_OPEN again and wake us.
+		 */
+		if (!netif_running(dev) ||
+		    test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
+			goto free;
+		/* Bound the wait so a wedged reconfig can't block the kTLS
+		 * destruct work indefinitely.
+		 */
+		if (retry_cnt++ > KTLS_RETRY_MAX) {
+			atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_RETRY_EXCEEDED]);
+			netdev_warn(dev, "%s timed out waiting for device, state %lx\n",
+				    __func__, bp->state);
+			goto free;
+		}
+		wait_event_timeout(ktls->open_wq,
+				   test_bit(BNXT_STATE_OPEN, &bp->state) ||
+				   !netif_running(dev) ||
+				   test_bit(BNXT_STATE_IN_FW_RESET, &bp->state),
+				   msecs_to_jiffies(KTLS_WAIT_TMO_MS));
+		goto retry;
+	}
+	atomic_inc(&ktls->pending);
+	/* Make sure bnxt_close_nic() sees pending before we check the
+	 * BNXT_STATE_OPEN flag.
+	 */
+	smp_mb__after_atomic();
+	if (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
+		atomic_dec(&ktls->pending);
+		goto retry;
+	}
+
+	crypto = bp->crypto_info;
+	kid = kctx_tx->kid;
+	kctx = &crypto->kctx[BNXT_TX_CRYPTO_KEY_TYPE];
+	kind = BNXT_CTX_KIND_CK_TX;
+	atomic64_inc(&ktls->counters[BNXT_KTLS_TX_DEL]);
+	/* This KID was allocated by an earlier add and may have outlived a FW
+	 * reset, so validate its epoch before deleting/freeing it.
+	 */
+	if (bnxt_kid_valid(kctx, kid) &&
+	    !bnxt_crypto_del(bp, kctx->type, kind, kid))
+		bnxt_free_one_kctx(kctx, kid);
+
+	atomic_dec(&ktls->pending);
+free:
+	bnxt_set_ktls_ctx_tx(tls_ctx, NULL);
+	kfree(kctx_tx);
+}
+
+static const struct tlsdev_ops bnxt_ktls_ops = {
+	.tls_dev_add = bnxt_ktls_dev_add,
+	.tls_dev_del = bnxt_ktls_dev_del,
+};
+
+int bnxt_ktls_init(struct bnxt *bp)
+{
+	struct bnxt_tls_info *ktls = bp->ktls_info;
+	struct net_device *dev = bp->dev;
+
+	if (!ktls)
+		return 0;
+
+	dev->tlsdev_ops = &bnxt_ktls_ops;
+	dev->hw_features |= NETIF_F_HW_TLS_TX;
+	dev->features |= NETIF_F_HW_TLS_TX;
+	return 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
new file mode 100644
index 000000000000..5a4f39f15e80
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#ifndef BNXT_KTLS_H
+#define BNXT_KTLS_H
+
+#include <linux/wait.h>
+
+/* Control plane counters */
+enum bnxt_ktls_ctrl_counters {
+	BNXT_KTLS_TX_ADD = 0,
+	BNXT_KTLS_TX_DEL,
+
+	/* Error counters for debugging */
+	BNXT_KTLS_ERR_NO_MEM,			/* Memory allocation failure */
+	BNXT_KTLS_ERR_NO_CAP,			/* Capability lost after FW reset */
+	BNXT_KTLS_ERR_KEY_CTX_ALLOC,		/* Key context alloc failure */
+	BNXT_KTLS_ERR_CRYPTO_CMD,		/* Crypto command failure */
+	BNXT_KTLS_ERR_DEVICE_BUSY,		/* Device not ready */
+	BNXT_KTLS_ERR_INVALID_CIPHER,		/* Unsupported cipher */
+	BNXT_KTLS_ERR_STATE_NOT_OPEN,		/* Device not open */
+	BNXT_KTLS_ERR_RETRY_EXCEEDED,		/* Retry limit exceeded */
+
+	BNXT_KTLS_MAX_CTRL_COUNTERS,
+};
+
+struct bnxt_tls_info {
+	atomic_t		pending;
+
+	/* Woken from __bnxt_open_nic()/__bnxt_close_nic() when
+	 * BNXT_STATE_OPEN changes, so a kTLS delete can wait out a ring
+	 * reconfiguration instead of polling the state bit.
+	 */
+	wait_queue_head_t	open_wq;
+
+	/* Atomic counters for control path */
+	atomic64_t		*counters;
+};
+
+struct bnxt_ktls_offload_ctx_tx {
+	u32		tcp_seq_no;	/* tcp seq no in sync with HW */
+	u32		next_tcp_seq_no;/* staged tcp seq no */
+	u32		kid;
+	u32		pending_bytes;	/* staged payload bytes */
+};
+
+struct bnxt_ktls_tx_driver_state {
+	struct bnxt_ktls_offload_ctx_tx *ctx_tx;
+};
+
+struct ce_add_cmd {
+	__le32	ver_algo_kid_opcode;
+	#define CE_ADD_CMD_OPCODE_MASK			0xfUL
+	#define CE_ADD_CMD_OPCODE_SFT			0
+	#define CE_ADD_CMD_OPCODE_ADD			 0x1UL
+	#define CE_ADD_CMD_KID_MASK			0xfffff0UL
+	#define CE_ADD_CMD_KID_SFT			4
+	#define CE_ADD_CMD_ALGORITHM_MASK		0xf000000UL
+	#define CE_ADD_CMD_ALGORITHM_SFT		24
+	#define CE_ADD_CMD_ALGORITHM_AES_GCM_128	 0x1000000UL
+	#define CE_ADD_CMD_ALGORITHM_AES_GCM_256	 0x2000000UL
+	#define CE_ADD_CMD_VERSION_MASK			0xf0000000UL
+	#define CE_ADD_CMD_VERSION_SFT			28
+	#define CE_ADD_CMD_VERSION_TLS1_2		 (0x0UL << 28)
+	#define CE_ADD_CMD_VERSION_TLS1_3		 (0x1UL << 28)
+	u8	ctx_kind;
+	#define CE_ADD_CMD_CTX_KIND_MASK		0x1fUL
+	#define CE_ADD_CMD_CTX_KIND_SFT			0
+	#define CE_ADD_CMD_CTX_KIND_CK_TX		 0x11UL
+	#define CE_ADD_CMD_CTX_KIND_CK_RX		 0x12UL
+	u8	unused0[3];
+	u8	salt[4];
+	u8	unused1[4];
+	__le32	pkt_tcp_seq_num;
+	__le32	tls_header_tcp_seq_num;
+	u8	record_seq_num[8];
+	u8	session_key[32];
+	u8	addl_iv[8];
+};
+
+static inline bool bnxt_ktls_busy(struct bnxt *bp)
+{
+	return bp->ktls_info && atomic_read(&bp->ktls_info->pending) > 0;
+}
+
+/* Wake any kTLS control op waiting for a BNXT_STATE_OPEN transition. */
+static inline void bnxt_ktls_wake(struct bnxt *bp)
+{
+	if (bp->ktls_info)
+		wake_up_all(&bp->ktls_info->open_wq);
+}
+
+#ifdef CONFIG_BNXT_TLS
+int bnxt_alloc_ktls_info(struct bnxt *bp);
+void bnxt_free_ktls_info(struct bnxt *bp);
+int bnxt_ktls_init(struct bnxt *bp);
+#else
+static inline int bnxt_alloc_ktls_info(struct bnxt *bp)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void bnxt_free_ktls_info(struct bnxt *bp)
+{
+}
+
+static inline int bnxt_ktls_init(struct bnxt *bp)
+{
+	return -EOPNOTSUPP;
+}
+#endif	/* CONFIG_BNXT_TLS */
+#endif	/* BNXT_KTLS_H */
-- 
2.51.0

