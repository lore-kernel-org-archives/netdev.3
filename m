Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495E39478C
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338903; cv=none; b=S2I6V78oChGkCy7lWbsUatN4oExv8U4KKNfKOa5iDXPJ0Sw3X3oeImRk8Yya3GYeg9/yutP/UDgn85Z4FPBbiNGan3HpFpwOme6ued5D1AuXXdE2i3pULgcSYkLvr68YA6iwTR7xfbXGiU6ox+oyfDQ4xUS2jCGEkTagBlSuNQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338903; c=relaxed/simple;
	bh=v+hFRX8FfP7dHN06iwZW8pu0Xxj2kXjE/7SUFIM54kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASBgqsHDYpLWFLysIkWXW8v+Bh8qxA8fd7ByPrSNgS2heFmXTKksf+lewyku8GuOsIfZvlijzglCz9ipQuYl7TPoZfcJUklkrxih+L4S4xki+pKjKcxGT6btSuUXawk2Ymt81EkYvdTpVP/V5x6MotpeYdycA7RoAFowBFhM7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hw4wyCYV; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hw4wyCYV"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1374844a91.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786338901; x=1786943701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aQgVIjUQHAJ9R3EoGSVbPveAS/8Ad8VhNkHNPoXTvVE=;
        b=obUuJe7DEIvh6KYAmodRBDJUeGFHOqXQDyMXMTB6wfqhpdWVEDF7Jisdu9sKec34+q
         Q9H7AUlksTretFcYpa1asvTYluLpP96g0h6jjwahfWOJBmHYIdZnwdKUv6U0NwSyo7e6
         7ZHMglAXtcUHyBQ07h229bQ1h6IAt7BXHeaDXG4/WblAcEj1MzxC9XE6gRFU60BQQ6XW
         tyO7K97dCptqIIa+R7S5WR9HhinWOchkylM/N9E85NdVvpcjv53LQEva73/L4vWQTmeB
         MxC58EWbDmimdvD+20v+umumwCWJcL3dG79bQW7YGUWB/S+DWHvGghrnBrN74eBjjUU3
         IwKw==
X-Gm-Message-State: AOJu0Yw+y3D8//ma40UbkNehSSFGcTMvYHgg6UqQrp8mlUkOgCJjTZMz
	rYgYl61Z8LVHrOO2BZwwTYyaKoAyXpFXsKWPGJ5Mfog+wb5vTVMcimWxLM65ZpgAPhizBalGNT6
	nJ4HOjyc0c5POPHowoCW9HE+paQvBCHKrKUfoQ+utv2lte8keWLUSUQElcqgjwNjdWNCBggVfqn
	kDNW4N2usvzNTOM98wB+ozR1ExkGEatt/egFhNpgYubTAmF7M47sclBYgJhI9zMzumQvU0UmGLG
	tTjXZXh7zc=
X-Gm-Gg: AR+sD136BL27rSWe2DLGnBXFRVn3raNTgzI9yzYd5gF7EuVWZufWn87Cm6b7D5zl20m
	HX9v0PgxoX6IPURqCsHR5K3K/EI5e23hjoy72V6N6+FFyvv1AjqqaLnmO2WVzGCsrvYpkbm6vA5
	+Ahf3u9Nrh4eAdnJu5xD2pKY7L47oRjwAjRNd1RYKB/mv9Xih1VN8EwyqWXgVDovDThTs9UZwGw
	fgOkRVKT+nzi8s45vkVxSAMI1yDcZPdpcTkImfJjveHc6KTGL0Rp5PmaCtEXgtMSIE4y2CkWbAJ
	tNoUqW3V9Z70RYvHcpbT+5t5rv72CObFWQmZn4+rcA92u4D4DIEPg4iQFthio93wBl1hqW1DCS9
	b7QId992rJaFweI1p0caYtrESkoOhj5MCwaDHpcSswnuU2VMpmY15xnOvk+KKj+LLAopl+n5/F8
	IYijrho0gOzoOPtfPDSCvdzSP3AehJln72
X-Received: by 2002:a17:90a:f943:b0:392:c80b:8eff with SMTP id 98e67ed59e1d1-392c80b912amr95610a91.11.1786338901064;
        Sun, 09 Aug 2026 22:15:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39085f17cf8sm6204352a91.6.2026.08.09.22.15.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2026 22:15:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52769fc3f2eso21139461cf.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786338900; x=1786943700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQgVIjUQHAJ9R3EoGSVbPveAS/8Ad8VhNkHNPoXTvVE=;
        b=hw4wyCYVyjYA6zNwyTXLCH9pf1ODms/9rL9OLK88WTnjfE9pSa+63pDafTa9aICmBe
         3g6RxM9hddeiaFcYa2q3uy3ZczEDm4tQ9LLhgYvqx2+bxOMVEUhJUwlPoPoz4k4T/9BS
         l4v2i/hp/UamMf1da297uwagGRg8w74C36gtc=
X-Received: by 2002:a05:622a:c8c:b0:51c:19af:6341 with SMTP id d75a77b69052e-52ce61d2d25mr456346721cf.36.1786338899469;
        Sun, 09 Aug 2026 22:14:59 -0700 (PDT)
X-Received: by 2002:a05:622a:c8c:b0:51c:19af:6341 with SMTP id d75a77b69052e-52ce61d2d25mr456346411cf.36.1786338898980;
        Sun, 09 Aug 2026 22:14:58 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165f2c76sm64862701cf.24.2026.08.09.22.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:14:58 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v6 09/15] bnxt_en: Add infrastructure for crypto key context IDs
Date: Sun,  9 Aug 2026 22:13:52 -0700
Message-ID: <20260810051358.1244418-10-michael.chan@broadcom.com>
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

Each kTLS connection requires a crypto key context ID (KID).  These KIDs
are allocated from the firmware in batches.  Add data structure to store
these IDs.  The bnxt_kid_info structure stores a batch of IDs and it can be
linked as we allocate more batches.  There is a bitmap in the structure
to keep track of which ones are in use.  Add APIs to allocate and free
these KIDs.

Once allocated, these KIDs are not freed during run-time.  They are
re-used for new connections.  FW reset or HWRM_FUNC_RESET will free
all KIDs.  Call bnxt_clear_crypto() to clear all KIDs in the driver's
structures during these reset events.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v5:
https://lore.kernel.org/netdev/20260710042400.3996847-10-michael.chan@broadcom.com/

More clearly document and explain that bnxt_clear_crypto() has no
concurrent readers/writers.

Add comment to explain that the bnxt_free_one_ctx() caller is reponsible
to check the epoch value when needed.

v4:
https://lore.kernel.org/netdev/20260629184921.3496727-10-michael.chan@broadcom.com/

Fix kernel doc for bnxt_free_one_kctx().

Add BNXT_NEXT_EPOCH() to mask the epoch value.

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-10-michael.chan@broadcom.com/

Use a larger (12-bit) epoch value for the keys.

Improve comments, kerneldoc, and dmesg.

Make sure bnxt_clear_crypto() is called during shutdown with the
BNXT_STATE_OPEN flag cleared.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-10-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  10 +
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 285 ++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  |  70 +++++
 3 files changed, 365 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 06bfe06d2d3c..1529be7e12cf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12922,6 +12922,8 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 				bnxt_ulp_irq_stop(bp);
 			bnxt_free_ctx_mem(bp, false);
 			bnxt_dcb_free(bp);
+			if (fw_reset || caps_change)
+				bnxt_clear_crypto(bp);
 			rc = bnxt_fw_init_one(bp);
 			if (rc) {
 				clear_bit(BNXT_STATE_FW_RESET_DET, &bp->state);
@@ -14659,6 +14661,7 @@ static void bnxt_fw_reset_close(struct bnxt *bp)
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	if (pci_is_enabled(bp->pdev))
 		pci_disable_device(bp->pdev);
+	bnxt_clear_crypto(bp);
 	bnxt_free_ctx_mem(bp, false);
 }
 
@@ -17318,6 +17321,12 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	rc = bnxt_dl_register(bp);
 	if (rc)
 		goto init_err_dl;
+	rc = bnxt_crypto_init(bp);
+	if (rc) {
+		bnxt_free_crypto_info(bp);
+		netdev_warn(bp->dev, "Failed to initialize crypto offload, err = %d\n",
+			    rc);
+	}
 
 	INIT_LIST_HEAD(&bp->usr_fltr_list);
 
@@ -17544,6 +17553,7 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 
 	if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
+	bnxt_clear_crypto(bp);
 	bnxt_free_ctx_mem(bp, false);
 	netdev_unlock(netdev);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
index b2a96ac725ea..72927c32bf0c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -8,6 +8,7 @@
 #include <linux/bnxt/hsi.h>
 
 #include "bnxt.h"
+#include "bnxt_hwrm.h"
 #include "bnxt_crypto.h"
 
 static u32 bnxt_get_max_crypto_key_ctx(struct bnxt *bp, int key_type)
@@ -55,6 +56,10 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
 		for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
 			kctx = &crypto->kctx[i];
 			kctx->type = i;
+			INIT_LIST_HEAD(&kctx->list);
+			spin_lock_init(&kctx->lock);
+			atomic_set(&kctx->alloc_pending, 0);
+			init_waitqueue_head(&kctx->alloc_pending_wq);
 		}
 		bp->crypto_info = crypto;
 	}
@@ -66,6 +71,43 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
 	bp->fw_cap |= BNXT_FW_CAP_KTLS;
 }
 
+/**
+ * bnxt_clear_crypto - Clear all crypto key contexts
+ * @bp: pointer to bnxt device
+ *
+ * Clears all key context allocations during shutdown or firmware reset.
+ * Frees all key info structures and bitmaps, and increments the epoch
+ * counter to invalidate any outstanding key references.
+ *
+ * Locking: the caller must have cleared BNXT_STATE_OPEN and waited for all
+ * in-flight kTLS control ops to drain.  Under these preconditions there are
+ * no concurrent readers or writers of the KID lists, so the lists can be
+ * walked without rcu_read_lock() or the kctx lock.
+ *
+ * Context: Process context during shutdown/reset
+ */
+void bnxt_clear_crypto(struct bnxt *bp)
+{
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+	struct bnxt_kid_info *kid, *tmp;
+	struct bnxt_kctx *kctx;
+	int i;
+
+	if (!crypto)
+		return;
+
+	/* No concurrent access; see the locking note above. */
+	for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
+		kctx = &crypto->kctx[i];
+		list_for_each_entry_safe(kid, tmp, &kctx->list, list) {
+			list_del(&kid->list);
+			kfree(kid);
+		}
+		kctx->total_alloc = 0;
+		kctx->epoch = BNXT_NEXT_EPOCH(kctx->epoch);
+	}
+}
+
 /**
  * bnxt_free_crypto_info - Free crypto offload resources
  * @bp: pointer to bnxt device
@@ -77,6 +119,7 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
  */
 void bnxt_free_crypto_info(struct bnxt *bp)
 {
+	bnxt_clear_crypto(bp);
 	kfree(bp->crypto_info);
 	bp->crypto_info = NULL;
 	bp->fw_cap &= ~BNXT_FW_CAP_KTLS;
@@ -113,3 +156,245 @@ void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
 	if (rx)
 		req->enables |= cpu_to_le32(FUNC_CFG_REQ_ENABLES_KTLS_RX_KEY_CTXS);
 }
+
+static int bnxt_key_ctx_store(struct bnxt_kctx *kctx, __le32 *key_buf, u32 num,
+			      bool contig, u8 kind, u32 *id)
+{
+	struct bnxt_kid_info *kid;
+	u32 i;
+
+	for (i = 0; i < num; ) {
+		kid = kzalloc_obj(*kid);
+		/* If we cannot store the IDs, they will be lost and only
+		 * reclaimed by the FW during reset/reinit.
+		 */
+		if (!kid)
+			return -ENOMEM;
+		kid->start_id = le32_to_cpu(key_buf[i]);
+		kid->type = kctx->type;
+		kid->kind = kind;
+		if (contig)
+			kid->count = num;
+		else
+			kid->count = 1;
+		bitmap_set(kid->ids, 0, kid->count);
+		if (id && !i) {
+			clear_bit(0, kid->ids);
+			*id = BNXT_SET_KID(kctx, kid->start_id);
+		}
+		spin_lock(&kctx->lock);
+		list_add_tail_rcu(&kid->list, &kctx->list);
+		WRITE_ONCE(kctx->total_alloc,
+			   READ_ONCE(kctx->total_alloc) + kid->count);
+		spin_unlock(&kctx->lock);
+		i += kid->count;
+	}
+	return 0;
+}
+
+/* Note that the driver does not free the key contexts.  They are freed
+ * by the FW during FLR and HWRM_FUNC_RESET.
+ */
+static int bnxt_hwrm_key_ctx_alloc(struct bnxt *bp, struct bnxt_kctx *kctx,
+				   u8 kind, u32 num, u32 *id)
+{
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+	struct hwrm_func_key_ctx_alloc_output *resp;
+	struct hwrm_func_key_ctx_alloc_input *req;
+	dma_addr_t mapping;
+	int pending_count;
+	__le32 *key_buf;
+	u32 num_alloc;
+	bool contig;
+	int rc;
+
+	num = min3(num, crypto->max_key_ctxs_alloc, (u32)BNXT_KID_BATCH_SIZE);
+	rc = hwrm_req_init(bp, req, HWRM_FUNC_KEY_CTX_ALLOC);
+	if (rc)
+		return rc;
+
+	key_buf = hwrm_req_dma_slice(bp, req, num * 4, &mapping);
+	if (!key_buf) {
+		rc = -ENOMEM;
+		goto key_alloc_exit;
+	}
+	req->dma_bufr_size_bytes = cpu_to_le32(num * 4);
+	req->host_dma_addr = cpu_to_le64(mapping);
+	resp = hwrm_req_hold(bp, req);
+
+	req->key_ctx_type = kctx->type;
+	req->num_key_ctxs = cpu_to_le16(num);
+
+	pending_count = atomic_inc_return(&kctx->alloc_pending);
+	rc = hwrm_req_send(bp, req);
+	atomic_dec(&kctx->alloc_pending);
+	if (rc)
+		goto key_alloc_exit_wake;
+
+	num_alloc = le16_to_cpu(resp->num_key_ctxs_allocated);
+	if (num_alloc > num) {
+		netdev_warn(bp->dev,
+			    "FW allocated more type %d keys (%d) than requested (%d)\n",
+			    kctx->type, num_alloc, num);
+	} else if (!num_alloc) {
+		netdev_warn(bp->dev,
+			    "FW allocated 0 type %d keys\n", kctx->type);
+		rc = -ENOENT;
+		goto key_alloc_exit_wake;
+	} else {
+		num = num_alloc;
+	}
+	contig = resp->flags &
+		 FUNC_KEY_CTX_ALLOC_RESP_FLAGS_KEY_CTXS_CONTIGUOUS;
+	rc = bnxt_key_ctx_store(kctx, key_buf, num, contig, kind, id);
+
+key_alloc_exit_wake:
+	if (pending_count >= BNXT_KCTX_ALLOC_PENDING_MAX)
+		wake_up_all(&kctx->alloc_pending_wq);
+key_alloc_exit:
+	hwrm_req_drop(bp, req);
+	return rc;
+}
+
+bool bnxt_kid_valid(struct bnxt_kctx *kctx, u32 id)
+{
+	struct bnxt_kid_info *kid;
+	bool valid = false;
+	u32 epoch;
+
+	epoch = BNXT_KID_EPOCH(id);
+	if (epoch != kctx->epoch)
+		return false;
+
+	id = BNXT_KID_HW(id);
+	rcu_read_lock();
+	list_for_each_entry_rcu(kid, &kctx->list, list) {
+		if (id >= kid->start_id && id < kid->start_id + kid->count) {
+			if (!test_bit(id - kid->start_id, kid->ids)) {
+				valid = true;
+				break;
+			}
+		}
+	}
+	rcu_read_unlock();
+	return valid;
+}
+
+static int bnxt_alloc_one_kctx(struct bnxt_kctx *kctx, u8 kind, u32 *id)
+{
+	struct bnxt_kid_info *kid;
+	int rc = -ENOMEM;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(kid, &kctx->list, list) {
+		u32 idx = 0;
+
+		if (kid->kind != kind)
+			continue;
+		do {
+			idx = find_next_bit(kid->ids, kid->count, idx);
+			if (idx >= kid->count)
+				break;
+			if (test_and_clear_bit(idx, kid->ids)) {
+				*id = BNXT_SET_KID(kctx, kid->start_id + idx);
+				rc = 0;
+				goto alloc_done;
+			}
+		} while (1);
+	}
+
+alloc_done:
+	rcu_read_unlock();
+	return rc;
+}
+
+/**
+ * bnxt_free_one_kctx - Free a key context for later re-use
+ * @kctx: pointer to bnxt_kctx key context structure
+ * @id: Key context ID
+ *
+ * This function is called to free a key context ID when the offload
+ * using the ID has successfully terminated or aborted.  If the offload
+ * cannot be terminated, the caller should not call this function to free
+ * the ID.  The ID will only be recycled by the FW during reset/reinit.
+ *
+ * The ID is matched by its hardware id only (epoch stripped), so the caller
+ * must ensure it is valid for the current epoch.
+ */
+void bnxt_free_one_kctx(struct bnxt_kctx *kctx, u32 id)
+{
+	struct bnxt_kid_info *kid;
+
+	id = BNXT_KID_HW(id);
+	rcu_read_lock();
+	list_for_each_entry_rcu(kid, &kctx->list, list) {
+		if (id >= kid->start_id && id < kid->start_id + kid->count) {
+			set_bit(id - kid->start_id, kid->ids);
+			break;
+		}
+	}
+	rcu_read_unlock();
+}
+
+#define BNXT_KCTX_ALLOC_RETRY_MAX	3
+
+int bnxt_key_ctx_alloc_one(struct bnxt *bp, struct bnxt_kctx *kctx, u8 kind,
+			   u32 *id)
+{
+	int rc, retry = 0;
+
+	while (retry++ < BNXT_KCTX_ALLOC_RETRY_MAX) {
+		rc = bnxt_alloc_one_kctx(kctx, kind, id);
+		if (!rc)
+			return 0;
+
+		/* When approaching the max, multiple threads may proceed
+		 * and exceed the max.  Some may fail the serialized HWRM call
+		 * later when the max is exceeded.
+		 */
+		if ((READ_ONCE(kctx->total_alloc) + BNXT_KID_BATCH_SIZE) >
+		    kctx->max_ctx)
+			return -ENOSPC;
+
+		if (!BNXT_KCTX_ALLOC_OK(kctx)) {
+			wait_event(kctx->alloc_pending_wq,
+				   BNXT_KCTX_ALLOC_OK(kctx));
+			continue;
+		}
+		rc = bnxt_hwrm_key_ctx_alloc(bp, kctx, kind,
+					     BNXT_KID_BATCH_SIZE, id);
+		if (!rc)
+			return 0;
+	}
+	return -EAGAIN;
+}
+
+int bnxt_crypto_init(struct bnxt *bp)
+{
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
+	int rc;
+
+	if (!crypto || !BNXT_SUPPORTS_KTLS(bp))
+		return 0;
+
+	crypto_resc = &hw_resc->crypto_resc;
+	BNXT_TCK(crypto).max_ctx = crypto_resc->resv_tx_key_ctxs;
+	BNXT_RCK(crypto).max_ctx = crypto_resc->resv_rx_key_ctxs;
+
+	if (!BNXT_TCK(crypto).max_ctx || !BNXT_RCK(crypto).max_ctx)
+		return -ENODEV;
+
+	rc = bnxt_hwrm_key_ctx_alloc(bp, &BNXT_TCK(crypto), BNXT_CTX_KIND_CK_TX,
+				     BNXT_KID_BATCH_SIZE, NULL);
+	if (rc)
+		return rc;
+
+	rc = bnxt_hwrm_key_ctx_alloc(bp, &BNXT_RCK(crypto), BNXT_CTX_KIND_CK_RX,
+				     BNXT_KID_BATCH_SIZE, NULL);
+	if (rc)
+		return rc;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
index e090491006db..f88aa410efdd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
@@ -16,11 +16,47 @@ enum bnxt_crypto_type {
 	BNXT_MAX_CRYPTO_KEY_TYPE,
 };
 
+/* Maximum keys supported by newer FW always multiples of 128 */
+#define BNXT_KID_BATCH_SIZE	128
+
+struct bnxt_kid_info {
+	struct list_head	list;
+	u8			type;
+	u8			kind;
+	u32			start_id;
+	u32			count;
+	DECLARE_BITMAP(ids, BNXT_KID_BATCH_SIZE);
+};
+
 struct bnxt_kctx {
+	struct list_head	list;
+	/* to serialize update to the linked list and total_alloc */
+	spinlock_t		lock;
 	u8			type;
+	u16			epoch;
+	u32			total_alloc;
 	u32			max_ctx;
+	atomic_t		alloc_pending;
+#define BNXT_KCTX_ALLOC_PENDING_MAX	8
+	wait_queue_head_t	alloc_pending_wq;
 };
 
+#define BNXT_KID_HW_MASK	0x000fffff
+#define BNXT_KID_HW(kid)	((kid) & BNXT_KID_HW_MASK)
+#define BNXT_KID_EPOCH_MASK	0xfff00000
+#define BNXT_KID_EPOCH_SHIFT	20
+#define BNXT_KID_EPOCH(kid)	(((kid) & BNXT_KID_EPOCH_MASK) >>	\
+				 BNXT_KID_EPOCH_SHIFT)
+
+#define BNXT_NEXT_EPOCH(epoch)	\
+	(((epoch) + 1) & (BNXT_KID_EPOCH_MASK >> BNXT_KID_EPOCH_SHIFT))
+
+#define BNXT_SET_KID(kctx, kid)						\
+	((kid) | ((u32)(kctx)->epoch << BNXT_KID_EPOCH_SHIFT))
+
+#define BNXT_KCTX_ALLOC_OK(kctx)	\
+	(atomic_read(&((kctx)->alloc_pending)) < BNXT_KCTX_ALLOC_PENDING_MAX)
+
 struct bnxt_crypto_info {
 	u16			max_key_ctxs_alloc;
 
@@ -30,18 +66,31 @@ struct bnxt_crypto_info {
 #define BNXT_TCK(crypto)	((crypto)->kctx[BNXT_TX_CRYPTO_KEY_TYPE])
 #define BNXT_RCK(crypto)	((crypto)->kctx[BNXT_RX_CRYPTO_KEY_TYPE])
 
+#define BNXT_CTX_KIND_CK_TX	0x11
+#define BNXT_CTX_KIND_CK_RX	0x12
+
 #ifdef CONFIG_BNXT_TLS
 void bnxt_alloc_crypto_info(struct bnxt *bp,
 			    struct hwrm_func_qcaps_output *resp);
+void bnxt_clear_crypto(struct bnxt *bp);
 void bnxt_free_crypto_info(struct bnxt *bp);
 void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
 				   struct hwrm_func_cfg_input *req);
+bool bnxt_kid_valid(struct bnxt_kctx *kctx, u32 id);
+void bnxt_free_one_kctx(struct bnxt_kctx *kctx, u32 id);
+int bnxt_key_ctx_alloc_one(struct bnxt *bp, struct bnxt_kctx *kctx, u8 kind,
+			   u32 *id);
+int bnxt_crypto_init(struct bnxt *bp);
 #else
 static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
 					  struct hwrm_func_qcaps_output *resp)
 {
 }
 
+static inline void bnxt_clear_crypto(struct bnxt *bp)
+{
+}
+
 static inline void bnxt_free_crypto_info(struct bnxt *bp)
 {
 }
@@ -50,5 +99,26 @@ static inline void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
 						 struct hwrm_func_cfg_input *req)
 {
 }
+
+static inline bool bnxt_kid_valid(struct bnxt_kctx *kctx, u32 id)
+{
+	return false;
+}
+
+static inline void bnxt_free_one_kctx(struct bnxt_kctx *kctx, u32 id)
+{
+}
+
+static inline int bnxt_key_ctx_alloc_one(struct bnxt *bp,
+					 struct bnxt_kctx *kctx, u8 kind,
+					 u32 *id)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int bnxt_crypto_init(struct bnxt *bp)
+{
+	return 0;
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_CRYPTO_H */
-- 
2.51.0

