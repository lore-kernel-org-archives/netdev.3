Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7200391E4E
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338901; cv=none; b=MWL3juaVd55mGglbUGFIyQAIvm56YmAh42H4m41yzZ9pBtFs8Vfi2NgCUZRlnPedqdrd7VmoRP3X+zWYpPcyrwTJd/sJ0K/rO+DxAi1BKkxFIM+ShR0BJXOsKkKIlMijp+TXjQY8SzjI8XkoH6bCjqs+Uf/hAl5GjoalJp3TE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338901; c=relaxed/simple;
	bh=SJLbRL9Qg5fCfy35WybRTdBJqlbeNq1+2hp708njMu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkauS8qhv4rz5HmeiSbseelXuTnuhlIi4EIaRfAxywxrwLV2A2nfryqKU+CY2/oQuHOHodRzjfx/AWpYn1IzND8SOfUPie2ffDKKHkWMmaE557vbnBPZQf76Zz6gln4fQ/6Lvsix8fkSw5/iofO+4dXHkKxp7w/j0OByIABjfV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MSblXl0a; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MSblXl0a"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso1869925a91.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786338898; x=1786943698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0zVfGXtvqParhl79YL7BJuRiA2X1u/IY0OGIGAEWL9M=;
        b=tIRyhWOUkThFAovf3Cju/gQVcBrA5Li2j117ru5sRHUiUl6oO49lWjRGYaq6HbQls7
         zpCM+QdITJYJoBHivrcnES6pKySgLrFpaOs9mBOZmzZAbapYvfUjhCFa6OIQJPCxTMwc
         bNxujFMHGLV6uurPn4KVbqcSLE/P3eya6gsADwsLKVpfSJCwcEMrdkbImvNvq5pxOBcf
         kZEfD2UFCQnWRxfsFbulvjBdTka2g+GrJtjD58AbxdCQxLnKMJ1UVvVnb1nVNmUixqhc
         2Dyt+/57blTyT8KtQ7YyQiENnDLMcWVkwxI5L200OKqNSf3SzqvA+nTBiWHLThyVMt6+
         RrTw==
X-Gm-Message-State: AOJu0YzNEdXhU5wOrGLUnlSjFgdvNvVvCT30eSZaYreAKzgm6vo5DmbW
	WlXctkRVZ9PNhRbbAc8nHO6CU9uh5e23Jh8VnUnAqJRc32TsAZLobhnwcFduh3kYzKME77dYjbJ
	MZgTpvHgkLuhY885wWpLqbQEuxR7qermJ+RAFX4issi98cwO4FoMk0iAdJbLkC4N8iObTg0GKqp
	4wKknnwqHvAGXdVZ85mQCB0kThOe5pTMu9Rp9srpmj0mIIgOgQ0LMNTWfyXbU56gALiL65ZYVpo
	crEyl5OdSE=
X-Gm-Gg: AR+sD12ps8dgC+Ls/rP5kz/LGtMfrZc0mtNE9agdq5QnRofl765SOr7t5KgmODRJ4Qj
	tqPkwsnBsUpjKMtyvaERjLW40Tgu6mFwULkdIfsjcRPm3IW8NlLQnkDf5rUW8IoR+mQ/0lRD40O
	vSPtP7IZBXlMJ6MpgF+QZH7sOmS8NQ8Q7aUwAsDzpZdYh+tsMhUVCnNba26iYfr3hZ99+Qja51L
	trJUpAGZiTGTvqSNugIycmo5IJRWjEyQqhjqmhPxHgBRIAz/6MRP+/9ckC9C6AMQto+zf7+kpr3
	xsEyagYXJckFQuhlByg0svSc8Hd6VkrU+y0iwY3I8oenWL/a6cKN5EizWnUdTyZ/rZ/6KiXxAut
	taxuspysGovcBKAEGvtrt01ZbaSxU4N8tNjCy/EfRsGkC6xLH6RSwdv+iodUMwHkXhYNrHItuw+
	sTd4l0uxqonla1MmUrYjxnssY8rQ/ln96Z
X-Received: by 2002:a17:90b:2585:b0:38e:bbf1:de34 with SMTP id 98e67ed59e1d1-39261fdab5amr24423048a91.7.1786338898313;
        Sun, 09 Aug 2026 22:14:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39085f5238bsm6277843a91.8.2026.08.09.22.14.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2026 22:14:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5174a23afcbso17509681cf.3
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786338897; x=1786943697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0zVfGXtvqParhl79YL7BJuRiA2X1u/IY0OGIGAEWL9M=;
        b=MSblXl0aGHmE7wwvmLR/AGBBFyIy8klC/HUKhYBIYfI7pdsBmvpeP45wnBbsi4gy3W
         6f7cdkNdqeVON9iTICMnxoK1mV0kSrmCgTpSmGoPdGCjOACFzjkWqPGPTYEKlRMhEQby
         2UofbZpsbtCV1Ggo+ZoJvgFAIRx5kfKc+fkTE=
X-Received: by 2002:ac8:5c85:0:b0:51c:f3e:7819 with SMTP id d75a77b69052e-52d191a50b0mr212354951cf.39.1786338897051;
        Sun, 09 Aug 2026 22:14:57 -0700 (PDT)
X-Received: by 2002:ac8:5c85:0:b0:51c:f3e:7819 with SMTP id d75a77b69052e-52d191a50b0mr212354741cf.39.1786338896587;
        Sun, 09 Aug 2026 22:14:56 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165f2c76sm64862701cf.24.2026.08.09.22.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:14:56 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v6 08/15] bnxt_en: Reserve crypto RX and TX key contexts on a PF
Date: Sun,  9 Aug 2026 22:13:51 -0700
Message-ID: <20260810051358.1244418-9-michael.chan@broadcom.com>
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

If kTLS crypto offload is supported, reserve RX and TX key contexts.
These keys will later be allocated during run-time to support offloading
TX and RX kTLS connections.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v3:
https://lore.kernel.org/netdev/20260614072407.2761092-9-michael.chan@broadcom.com/

Add missing ASSETS_TEST flag when checking reserved crypto keys.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-9-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 22 +++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 11 +++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 32 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  |  7 ++++
 4 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c6c9950ced97..06bfe06d2d3c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7801,6 +7801,7 @@ static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
 static int bnxt_hwrm_get_rings(struct bnxt *bp)
 {
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
 	struct hwrm_func_qcfg_output *resp;
 	struct hwrm_func_qcfg_input *req;
 	int rc;
@@ -7861,6 +7862,10 @@ static int bnxt_hwrm_get_rings(struct bnxt *bp)
 		}
 		hw_resc->resv_cp_rings = cp;
 		hw_resc->resv_stat_ctxs = stats;
+
+		crypto_resc = &hw_resc->crypto_resc;
+		crypto_resc->resv_tx_key_ctxs = le32_to_cpu(resp->num_ktls_tx_key_ctxs);
+		crypto_resc->resv_rx_key_ctxs = le32_to_cpu(resp->num_ktls_rx_key_ctxs);
 	}
 get_rings_exit:
 	hwrm_req_drop(bp, req);
@@ -7931,8 +7936,9 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 		}
 		req->num_stat_ctxs = cpu_to_le16(hwr->stat);
 		req->num_vnics = cpu_to_le16(hwr->vnic);
+		bnxt_hwrm_reserve_pf_key_ctxs(bp, req);
 	}
-	req->enables = cpu_to_le32(enables);
+	req->enables |= cpu_to_le32(enables);
 	return req;
 }
 
@@ -8334,7 +8340,7 @@ static int bnxt_hwrm_check_vf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 static int bnxt_hwrm_check_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
 	struct hwrm_func_cfg_input *req;
-	u32 flags;
+	u32 flags, flags2 = 0;
 
 	req = __bnxt_hwrm_reserve_pf_rings(bp, hwr);
 	flags = FUNC_CFG_REQ_FLAGS_TX_ASSETS_TEST;
@@ -8348,9 +8354,14 @@ static int bnxt_hwrm_check_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 				 FUNC_CFG_REQ_FLAGS_NQ_ASSETS_TEST;
 		else
 			flags |= FUNC_CFG_REQ_FLAGS_RING_GRP_ASSETS_TEST;
+		if (req->enables &
+		    cpu_to_le32(FUNC_CFG_REQ_ENABLES_KTLS_TX_KEY_CTXS |
+				FUNC_CFG_REQ_ENABLES_KTLS_RX_KEY_CTXS))
+			flags2 |= FUNC_CFG_REQ_FLAGS2_KTLS_KEY_CTX_ASSETS_TEST;
 	}
 
 	req->flags = cpu_to_le32(flags);
+	req->flags2 = cpu_to_le32(flags2);
 	return hwrm_req_send_silent(bp, req);
 }
 
@@ -9764,6 +9775,7 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
 	struct hwrm_func_resource_qcaps_output *resp;
 	struct hwrm_func_resource_qcaps_input *req;
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
 	int rc;
 
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_RESOURCE_QCAPS);
@@ -9801,6 +9813,12 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
 	    hw_resc->max_vnics * BNXT_LARGE_RSS_TO_VNIC_RATIO)
 		bp->rss_cap |= BNXT_RSS_CAP_LARGE_RSS_CTX;
 
+	crypto_resc = &hw_resc->crypto_resc;
+	crypto_resc->min_tx_key_ctxs = le32_to_cpu(resp->min_ktls_tx_key_ctxs);
+	crypto_resc->max_tx_key_ctxs = le32_to_cpu(resp->max_ktls_tx_key_ctxs);
+	crypto_resc->min_rx_key_ctxs = le32_to_cpu(resp->min_ktls_rx_key_ctxs);
+	crypto_resc->max_rx_key_ctxs = le32_to_cpu(resp->max_ktls_rx_key_ctxs);
+
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		u16 max_msix = le16_to_cpu(resp->max_msix);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 3f0307cd144d..b7a055281687 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1364,6 +1364,15 @@ struct bnxt_hw_rings {
 	int rss_ctx;
 };
 
+struct bnxt_hw_crypto_resc {
+	u32	min_tx_key_ctxs;
+	u32	max_tx_key_ctxs;
+	u32	resv_tx_key_ctxs;
+	u32	min_rx_key_ctxs;
+	u32	max_rx_key_ctxs;
+	u32	resv_rx_key_ctxs;
+};
+
 struct bnxt_hw_resc {
 	u16	min_rsscos_ctxs;
 	u16	max_rsscos_ctxs;
@@ -1398,6 +1407,8 @@ struct bnxt_hw_resc {
 	u32	max_tx_wm_flows;
 	u32	max_rx_em_flows;
 	u32	max_rx_wm_flows;
+
+	struct bnxt_hw_crypto_resc	crypto_resc;
 };
 
 #define BNXT_LARGE_RSS_TO_VNIC_RATIO	7
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
index 5bc31ee8d7fd..b2a96ac725ea 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -81,3 +81,35 @@ void bnxt_free_crypto_info(struct bnxt *bp)
 	bp->crypto_info = NULL;
 	bp->fw_cap &= ~BNXT_FW_CAP_KTLS;
 }
+
+/**
+ * bnxt_hwrm_reserve_pf_key_ctxs - Reserve key contexts with firmware
+ * @bp: pointer to bnxt device
+ * @req: pointer to HWRM function config request
+ *
+ * Populates the firmware request with key context reservation parameters
+ * for crypto offload based on current max settings and capabilities.
+ *
+ * Context: Process context during device configuration
+ */
+void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
+				   struct hwrm_func_cfg_input *req)
+{
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
+	u32 tx, rx;
+
+	if (!crypto || !BNXT_SUPPORTS_KTLS(bp))
+		return;
+
+	crypto_resc = &hw_resc->crypto_resc;
+	tx = min(BNXT_TCK(crypto).max_ctx, crypto_resc->max_tx_key_ctxs);
+	rx = min(BNXT_RCK(crypto).max_ctx, crypto_resc->max_rx_key_ctxs);
+	req->num_ktls_tx_key_ctxs = cpu_to_le32(tx);
+	req->num_ktls_rx_key_ctxs = cpu_to_le32(rx);
+	if (tx)
+		req->enables |= cpu_to_le32(FUNC_CFG_REQ_ENABLES_KTLS_TX_KEY_CTXS);
+	if (rx)
+		req->enables |= cpu_to_le32(FUNC_CFG_REQ_ENABLES_KTLS_RX_KEY_CTXS);
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
index 629388fe1e6d..e090491006db 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
@@ -34,6 +34,8 @@ struct bnxt_crypto_info {
 void bnxt_alloc_crypto_info(struct bnxt *bp,
 			    struct hwrm_func_qcaps_output *resp);
 void bnxt_free_crypto_info(struct bnxt *bp);
+void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
+				   struct hwrm_func_cfg_input *req);
 #else
 static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
 					  struct hwrm_func_qcaps_output *resp)
@@ -43,5 +45,10 @@ static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
 static inline void bnxt_free_crypto_info(struct bnxt *bp)
 {
 }
+
+static inline void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
+						 struct hwrm_func_cfg_input *req)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_CRYPTO_H */
-- 
2.51.0

