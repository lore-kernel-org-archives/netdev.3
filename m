Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567541D104
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576031; cv=none; b=g2XLvBppTq+BzqOY1UBO4krXI6Zo3edmCu+JRL/Agnwd8vjFE/+Mf+NP833vDvP4suRCD8/VcVkAzteT8v/vUcWHNbnkhOKHT8lU0FEvc9vdkBNUyg9WnE10UgqkOZdERWCmI8QTCjw73uVSHhXOJAeFCBIQjhXh71kiuFmT9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576031; c=relaxed/simple;
	bh=65qMxZ6qDHqV6MqIufpGztS3PZ/9Nnmzy/e5GxIfB+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rypql26j8ujmj3lh6nkUKd6EhWR+E8nNzDILfuYgZp/H+OTMeGEQAvMaCEfD0BCjAMx9HotldhK0sJtRBW72mryyYRyfBxKmscRavEtdd7tN2zFI5RbfXMydnEiD87zZ+GSnMel+Gatret4N75dqw/jCgzobV4trexBtz2EdqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WXzQCNYf; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WXzQCNYf"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-90ccb6102a1so9672486d6.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576016; x=1791180816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FFGaeI+LxP9B/9REdQaKNp8Nlo1OtNx/jyc6c5o9d9Q=;
        b=m0BzdxxYUwlpBVDSZINuDj7ZU7M/nF2tWA1OUzjxKTH82czQtNuwMtyzxvrsU1seq2
         sBqGlBvIOIM4gLDRkHXdI7uySVMV4wcpRH2mh6q8adw/cAPYmgG8+aonBjLF822YbImf
         sPtN9Ae0Iu++5Nfd8jaHqIiiyRTlwO7aHWKfFfUiY5OP2ULPkVjs2OsORemeQlxnAI7X
         V/NqLQq5/XlwN8o5jVWU81jD3P2WgBOUStM0gWNX2P704OYHR//DoFaghS02SwLoKt7G
         bNslW2MK3JAI6+l5xakP62+jtOPt8vUTFtUThFONyWmVxyHa/EKjTcFMOC7rvEHZHlcP
         BojQ==
X-Gm-Message-State: AFuF++nXysRf0xPIIqbzbKbCUkiGMJkgd7KKMieNS9LhxTNXuSQixC8a
	Eu6Oj8X6Lg3ua6JuBOxFVyXyf/jHpiH3DdW0R9q67sgFKyIQsB9Si6pBEla8Yw4zw93HA6APtvr
	7U65SuII0h7Yd1RyX8mKrjRBgyVouzSYuZTe+5EWLHMzDJcOk04JYf8mIaKAsXcUJuUMn3mxuN7
	+RfX9ko0neaL1U6E8swHpKC1EKYs+SHJo4KLm0NYdI/l2C05jPg9ATKrNnQToSXyr8nO0gOJTOu
	t4mLfiL9Q==
X-Gm-Gg: AYBFou3lymTFeXwK3vwFQItFEVMTf7mBnV2udqLmZnmkPEVEd3IMu7YCE3ap3NKD6ck
	/x7MYqfm6p261o/ocXkorIJJyL8lKJ/mvB9Fy5vDhc/nGj4c5uXXSLqi8Z20FgauVo/62CLaUGR
	XbrIuL311eaLjz6F5G1QGs/Fe4+ctKIGrolf5auIpbJRFF+tPHvCG+JjNWMFhpBLEHN6ote9C6b
	IKI3TLaVZF+Uh1nff2yv/M723C1/N+XekH4xo+cWPO95ay9K245cVhyLXjkE39nk64XTYmb/XiH
	krYIDZLmx1BY+cyZC4fXWGrvHpqhSwp6qyY8eEqsBcKAON8TI6XwVS/VLbvB2IozR6jNOdIDi/J
	V4IKmtXFssCxVVz8tIoLlkUi0Yu40++XRPL/mfP1MhlhJbyjT3K9fPg+hOGAZBsnI4i+MMv3baL
	uGmPbtGh9KslYUgOZf2+33UnTQnR8wSqT2OA==
X-Received: by 2002:a05:620a:6193:b0:939:6de7:a624 with SMTP id af79cd13be357-93c43dccc8fmr1884785985a.48.1790576016065;
        Sun, 27 Sep 2026 23:13:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93c8138bd78sm29741785a.3.2026.09.27.23.13.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 23:13:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-342217d8d53so8711723eec.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790576015; x=1791180815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FFGaeI+LxP9B/9REdQaKNp8Nlo1OtNx/jyc6c5o9d9Q=;
        b=WXzQCNYfObZiRicWo4u5+mdf184UuN6RvFyVrq2DaCG1Qbj2WeigGLcNN1UrySNSfl
         vkRrVJ9Pt3Eea/uEvymsb08jcUqGJjgi4kqIeIPGKXfOvm1tkjWyOWgOf6g1BKBBm28E
         YCYI2g4rK+xx56XJfid67x7Ty+gPmZr9u4WdQ=
X-Received: by 2002:a05:7022:222a:b0:144:f089:b189 with SMTP id a92af1059eb24-146d01af97emr12247746c88.36.1790576014047;
        Sun, 27 Sep 2026 23:13:34 -0700 (PDT)
X-Received: by 2002:a05:7022:222a:b0:144:f089:b189 with SMTP id a92af1059eb24-146d01af97emr12247701c88.36.1790576013410;
        Sun, 27 Sep 2026 23:13:33 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-147913a776fsm17355561c88.17.2026.09.27.23.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:13:33 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [net-next, v4 03/10] bnge: add helper functions for multi RSS contexts
Date: Mon, 28 Sep 2026 11:43:00 +0530
Message-ID: <20260928061307.1172344-4-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928061307.1172344-1-vikas.gupta@broadcom.com>
References: <20260928061307.1172344-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add infrastructure for creating, modifying, and deleting user-defined
RSS contexts. This helps the next patch implement commands for ethtool.
For each user RSS context, a VNIC is allocated.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   2 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |  12 +-
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    | 113 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_vnic.h    |  15 +++
 4 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index c47a874df4ba..3c0fea0a7608 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -371,6 +371,8 @@ struct bnge_net {
 
 	u8			pri2cos_idx[8];
 	bool			pri2cos_valid;
+
+	u16			num_rss_ctx;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index c7024e75f925..e0744e59c6ae 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -209,8 +209,16 @@ static u16 bnge_get_total_rss_ctxs(struct bnge_dev *bd,
 
 static u16 bnge_get_total_vnics(struct bnge_dev *bd)
 {
-	if (bnge_is_arfs_cap(bd))
-		return 2;
+	if (bnge_is_arfs_cap(bd)) {
+		u16 vnics = 2;
+
+		if (bd->netdev) {
+			struct bnge_net *bn = netdev_priv(bd->netdev);
+
+			vnics += bn->num_rss_ctx;
+		}
+		return vnics;
+	}
 
 	return 1;
 }
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
index d98a6196c859..a44971a7c74d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
@@ -129,3 +129,116 @@ int bnge_alloc_rfs_vnic(struct bnge_net *bn)
 	vnic = &bn->vnic_info[BNGE_VNIC_NTUPLE];
 	return bnge_alloc_and_setup_vnic(bn, vnic, bn->bd->rx_nr_rings);
 }
+
+void bnge_modify_rss(struct bnge_net *bn, struct ethtool_rxfh_context *ctx,
+		     struct bnge_rss_ctx *rss_ctx,
+		     const struct ethtool_rxfh_param *rxfh)
+{
+	struct bnge_dev *bd = bn->bd;
+
+	if (rxfh->key) {
+		if (rss_ctx) {
+			memcpy(rss_ctx->vnic.rss_hash_key, rxfh->key,
+			       HW_HASH_KEY_SIZE);
+		} else {
+			memcpy(bn->rss_hash_key, rxfh->key, HW_HASH_KEY_SIZE);
+			bn->rss_hash_key_updated = true;
+		}
+	}
+
+	if (rxfh->indir) {
+		u32 i, pad, tbl_size = bnge_get_rxfh_indir_size(bd);
+		u32 *indir_tbl = bd->rss_indir_tbl;
+
+		if (rss_ctx)
+			indir_tbl = ethtool_rxfh_context_indir(ctx);
+		for (i = 0; i < tbl_size; i++)
+			indir_tbl[i] = rxfh->indir[i];
+		pad = bd->rss_indir_tbl_entries - tbl_size;
+		if (pad)
+			memset(&indir_tbl[i], 0, pad * sizeof(*indir_tbl));
+	}
+}
+
+void bnge_del_one_rss_ctx(struct bnge_net *bn, struct bnge_rss_ctx *rss_ctx,
+			  bool all)
+{
+	struct bnge_vnic_info *vnic = &rss_ctx->vnic;
+	int i;
+
+	bnge_hwrm_vnic_free_one(bn->bd, &rss_ctx->vnic);
+	for (i = 0; i < BNGE_MAX_CTX_PER_VNIC; i++) {
+		if (vnic->fw_rss_cos_lb_ctx[i] != INVALID_HW_RING_ID)
+			bnge_hwrm_vnic_ctx_free_one(bn->bd, vnic, i);
+	}
+
+	if (!all)
+		return;
+
+	if (vnic->rss_table)
+		dma_free_coherent(bn->bd->dev, vnic->rss_table_size,
+				  vnic->rss_table,
+				  vnic->rss_table_dma_addr);
+	bn->num_rss_ctx--;
+}
+
+void bnge_hwrm_realloc_rss_ctx_vnic(struct bnge_net *bn)
+{
+	u32 tpa_flags = bn->priv_flags & BNGE_NET_EN_TPA;
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+
+	xa_for_each(&bn->netdev->ethtool->rss_ctx, context, ctx) {
+		struct bnge_rss_ctx *rss_ctx = ethtool_rxfh_context_priv(ctx);
+		struct bnge_vnic_info *vnic = &rss_ctx->vnic;
+
+		if (bnge_hwrm_vnic_alloc(bn->bd, vnic, bn->bd->rx_nr_rings) ||
+		    bnge_hwrm_vnic_set_tpa(bn->bd, vnic, tpa_flags) ||
+		    bnge_setup_vnic(bn, vnic)) {
+			netdev_err(bn->netdev, "Failed to restore RSS ctx %d\n",
+				   rss_ctx->index);
+			bnge_del_one_rss_ctx(bn, rss_ctx, true);
+			ethtool_rxfh_context_lost(bn->netdev, rss_ctx->index);
+		}
+	}
+}
+
+void bnge_clear_rss_ctxs(struct bnge_net *bn)
+{
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+
+	xa_for_each(&bn->netdev->ethtool->rss_ctx, context, ctx) {
+		struct bnge_rss_ctx *rss_ctx = ethtool_rxfh_context_priv(ctx);
+
+		bnge_del_one_rss_ctx(bn, rss_ctx, false);
+	}
+}
+
+struct bnge_rss_ctx *bnge_get_rss_ctx_from_index(struct bnge_net *bn, u32 idx)
+{
+	struct ethtool_rxfh_context *ctx;
+
+	ctx = xa_load(&bn->netdev->ethtool->rss_ctx, idx);
+	if (!ctx)
+		return NULL;
+	return ethtool_rxfh_context_priv(ctx);
+}
+
+int bnge_alloc_vnic_rss_table(struct bnge_net *bn,
+			      struct bnge_vnic_info *vnic)
+{
+	unsigned int size = L1_CACHE_ALIGN(BNGE_MAX_RSS_TABLE_SIZE);
+
+	vnic->rss_table_size = size + HW_HASH_KEY_SIZE;
+	vnic->rss_table = dma_alloc_coherent(bn->bd->dev,
+					     vnic->rss_table_size,
+					     &vnic->rss_table_dma_addr,
+					     GFP_KERNEL);
+	if (!vnic->rss_table)
+		return -ENOMEM;
+
+	vnic->rss_hash_key = ((void *)vnic->rss_table) + size;
+	vnic->rss_hash_key_dma_addr = vnic->rss_table_dma_addr + size;
+	return 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
index 4fa1c7570dc4..ff7244cdf1a8 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
@@ -57,10 +57,25 @@ struct bnge_vnic_info {
 	u32		vnic_id;
 };
 
+struct bnge_rss_ctx {
+	struct bnge_vnic_info vnic;
+	u32 index;
+};
+
 void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic);
 int bnge_hwrm_vnic_rss_cfg(struct bnge_net *bn,
 			   struct bnge_vnic_info *vnic);
 int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic);
 void bnge_set_dflt_rss_indir_tbl(struct bnge_dev *bd);
 int bnge_alloc_rfs_vnic(struct bnge_net *bn);
+int bnge_alloc_vnic_rss_table(struct bnge_net *bn,
+			      struct bnge_vnic_info *vnic);
+struct bnge_rss_ctx *bnge_get_rss_ctx_from_index(struct bnge_net *bn, u32 idx);
+void bnge_modify_rss(struct bnge_net *bn, struct ethtool_rxfh_context *ctx,
+		     struct bnge_rss_ctx *rss_ctx,
+		     const struct ethtool_rxfh_param *rxfh);
+void bnge_del_one_rss_ctx(struct bnge_net *bn, struct bnge_rss_ctx *rss_ctx,
+			  bool all);
+void bnge_hwrm_realloc_rss_ctx_vnic(struct bnge_net *bn);
+void bnge_clear_rss_ctxs(struct bnge_net *bn);
 #endif /* _BNGE_VNIC_H_ */
-- 
2.52.0

