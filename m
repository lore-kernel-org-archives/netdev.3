Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205544E05B
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627598; cv=none; b=lES4/tlQeu6qQ2YNfOxl9Az+wN0bic2eccWwjMCQTjDB/f9gNejtbaKR026ya5UzjKtlv0Dt3HRvdZrgZay1bJ4E8LAyUIFW4kEPYa1K77B/kzwC/PhazsUc3eGMo0yHD740PXfkLEaX19nulKTTg+O0eC/BrnPqLpuE4W6MiWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627598; c=relaxed/simple;
	bh=VUyUgX9gI54uFRlYe86ZoSCrxkp9Zm/UKKydohdqeNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5hka+kKb09dViAiYWffF2FkzjLsrNOE/AFcC0WB6h6Wy/T0Zi7kNp4NQxdJYMYWbndhMfsXRpMjFDOivH2vMxvbnogaZIKpkLfBNk9+FIW3Othplt3JQ75Vbs7GwODfKL/52UyDN+R4iqY2VT1Jl64b7VRpvFK8hPVksvE+z4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BWmEyfxh; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BWmEyfxh"
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-806a2a27a4bso241126a34.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627595; x=1790232395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b8YyMvujqHd3wteUfLkNVe9en1vIb7NBkl9jwt2Wzes=;
        b=FgF37XWrOSSRnAupiFZVphR2YFtLe5bz4LHh8V48XRm9g5BAH7pvgOxQh154PK340o
         fy4+xeHGL0oppHWiFEAr0wg41kCaokIsmAmQqQMKOMkwBkznJpsl9lXGhVUot1p+Q3V0
         DT0eXxgD9T4ghk+Yk3j5MemCIqa1+6+FAp8OoSMQ0x08Eg2dibE8W+7dZJb3SCB6NWhV
         REusXb6Zvu36UQC6Z3q9oKBTUqpPg3TFysnYaxa0J03dQxTp5fENP+zu7IzwEwRvf3HH
         WgQdy3hyxTaHggSKPssZHL3X4fWZpKz5ZDOy4zKgsf+/DMvpaKsSoZONXDJUwJcAOYOU
         V5gg==
X-Gm-Message-State: AFuF++m0wcZ/oDsKcVPwOTATIcxSFkbyELZzI7ddurF67CbEN3Sr13Gc
	7GQjt2bdRucJM0dVrUsrhS/qLqRKG+p71i+8Jy2FK7iaLhZ+kvrOxIkitZ9YVsCKK6KmqeLeGbv
	44pva6QPqDawYPlAXdq5hbnlv+dBITxHyGEw4tsh1hvcGEBOKvNccxpUjn0CzujLdsb9FCWawDf
	mqWu/moZOaDD2g2iYWLJmI+PyFlIiq2AToRTwV7wezkKOVjmZdpxfxympJz4OlYxrSybQDhKAbz
	UwfcXhMtQ==
X-Gm-Gg: AYBFou05Pb6DkdSh7bf5CGPPZZdRBHB72taJEPVbp+FmPBtH/Yw5b+RdceJuCQNNJIY
	Y71S6g9GxqCujE+lSnGyJVor+Nm+1PpBlCdkkHn8AtrFszkIqqY25gVv1MsOu3IjeBwtFp0nVEH
	PkeETJvLZo1smtBtQvguKM1KAI5UWi5CD5nfJCZ33HHA5yMaYV8TsKEM3eTJYauUuwtszl7ySOJ
	PKRrGxEQKupttGPAl1W9LJSgUcHrVNXKMGreJIXJJVr+LZJEq0BPPzbVyonMK+96WOmtTkdHe8e
	wEGZ4sSDphz0Eje3TRXIgk3B1tDT/JF98PvGyio2IB+rIF2WnbFtIGGUE9VVepKNzeXPEIL9KOa
	QdNvjF11UoM8KOEoxjgYL3N1C3X3FbPxpJ1yEB+jDZjT52HPglSC2yxV6tiRi6UOPFeW0iTJXxu
	UnpV5N7LuQAXeMlPKxeVM2uW4SDVao7ZlAzQ==
X-Received: by 2002:a05:6830:6d06:b0:806:5948:bea1 with SMTP id 46e09a7af769-80b2c59fc55mr10153012a34.4.1789627595438;
        Wed, 16 Sep 2026 23:46:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-80c410c9ed8sm1144686a34.0.2026.09.16.23.46.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 23:46:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1b80835d5so649918a12.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789627594; x=1790232394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b8YyMvujqHd3wteUfLkNVe9en1vIb7NBkl9jwt2Wzes=;
        b=BWmEyfxhZfeyGUPhMF/sNY5SQs4/r4P2kHvme7K4UtHGOb9QxoECspi+vrwGc7asf4
         hnhtIQ/C7lCW6MaWLVfhGa52pl7KDC3IkL530sINwSMqBsLZYpzZh9L4BwvGrO4wgSgz
         P+Pt6lAya6+/boL30+oLYmwpJOSakUNLRj7R8=
X-Received: by 2002:a05:6a20:7faa:b0:3d8:f78a:9349 with SMTP id adf61e73a8af0-3dd5f5c9013mr12096174637.13.1789627593660;
        Wed, 16 Sep 2026 23:46:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:7faa:b0:3d8:f78a:9349 with SMTP id adf61e73a8af0-3dd5f5c9013mr12096112637.13.1789627592995;
        Wed, 16 Sep 2026 23:46:32 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab960edsm2754293a12.20.2026.09.16.23.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:46:32 -0700 (PDT)
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
Subject: [net-next, v3 06/11] bnge: add ethtool support to manage RSS contexts
Date: Thu, 17 Sep 2026 12:15:43 +0530
Message-ID: <20260917064548.773334-7-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917064548.773334-1-vikas.gupta@broadcom.com>
References: <20260917064548.773334-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Introduce ethtool callbacks to manage RSS contexts.

Each context allocates a dedicated VNIC with its own RSS indirection
table and hash key, configured with TPA settings matching those of the
default VNIC.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 163 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |   9 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |   5 +-
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    |  31 +++-
 .../net/ethernet/broadcom/bnge/bnge_vnic.h    |  14 +-
 5 files changed, 214 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index f1969de08534..d4e2968988e2 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -1004,6 +1004,166 @@ static u32 bnge_get_rx_ring_count(struct net_device *dev)
 	return bd->rx_nr_rings;
 }
 
+static int bnge_rxfh_context_check(struct bnge_net *bn,
+				   const struct ethtool_rxfh_param *rxfh,
+				   struct netlink_ext_ack *extack)
+{
+	if (rxfh->hfunc && rxfh->hfunc != ETH_RSS_HASH_TOP) {
+		NL_SET_ERR_MSG_MOD(extack, "RSS hash function not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (!(bn->priv_flags & BNGE_NET_EN_NTUPLE)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Enable ntuple filtering before adding RSS contexts");
+		return -EOPNOTSUPP;
+	}
+
+	if (!netif_running(bn->netdev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to set RSS contexts when interface is down");
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static int bnge_create_rxfh_context(struct net_device *dev,
+				    struct ethtool_rxfh_context *ctx,
+				    const struct ethtool_rxfh_param *rxfh,
+				    struct netlink_ext_ack *extack)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_rss_ctx *rss_ctx;
+	struct bnge_vnic_info *vnic;
+	int rc;
+
+	rc = bnge_rxfh_context_check(bn, rxfh, extack);
+	if (rc)
+		return rc;
+
+	if (bn->num_rss_ctx >= BNGE_MAX_ETH_RSS_CTX) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Out of RSS contexts, maximum %u",
+				       BNGE_MAX_ETH_RSS_CTX);
+		return -EINVAL;
+	}
+
+	if (!bnge_arfs_capable(bn->bd, true)) {
+		NL_SET_ERR_MSG_MOD(extack, "Out of hardware resources");
+		return -ENOMEM;
+	}
+
+	rss_ctx = ethtool_rxfh_context_priv(ctx);
+
+	bn->num_rss_ctx++;
+
+	vnic = &rss_ctx->vnic;
+
+	bnge_init_vnic_mem(vnic);
+
+	vnic->rss_ctx = ctx;
+	vnic->flags |= BNGE_VNIC_RSSCTX_FLAG;
+	rc = bnge_alloc_vnic_rss_table(bn, vnic);
+	if (rc)
+		goto err_del_rss_ctx;
+
+	/* Populate defaults in the context */
+	bnge_set_dflt_rss_indir_tbl(bn->bd, ctx);
+	ctx->hfunc = ETH_RSS_HASH_TOP;
+	memcpy(vnic->rss_hash_key, bn->rss_hash_key, HW_HASH_KEY_SIZE);
+	memcpy(ethtool_rxfh_context_key(ctx),
+	       bn->rss_hash_key, HW_HASH_KEY_SIZE);
+
+	rc = bnge_hwrm_vnic_alloc(bn->bd, vnic, bn->bd->rx_nr_rings);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to allocate VNIC");
+		goto err_del_rss_ctx;
+	}
+
+	rc = bnge_hwrm_vnic_set_tpa(bn->bd, vnic,
+				    bn->priv_flags & BNGE_NET_EN_TPA);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Unable to set TPA settings to vnic");
+		goto err_del_rss_ctx;
+	}
+	bnge_modify_rss(bn, ctx, rss_ctx, rxfh);
+
+	rc = bnge_setup_vnic(bn, vnic);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to setup vnic");
+		goto err_del_rss_ctx;
+	}
+
+	rss_ctx->index = rxfh->rss_context;
+	return 0;
+
+err_del_rss_ctx:
+	bnge_del_one_rss_ctx(bn, rss_ctx, true);
+	return rc;
+}
+
+static int bnge_modify_rxfh_context(struct net_device *dev,
+				    struct ethtool_rxfh_context *ctx,
+				    const struct ethtool_rxfh_param *rxfh,
+				    struct netlink_ext_ack *extack)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	u8 old_key[HW_HASH_KEY_SIZE];
+	struct bnge_rss_ctx *rss_ctx;
+	u32 *old_indir = NULL;
+	u32 tbl_size;
+	int rc;
+
+	rc = bnge_rxfh_context_check(bn, rxfh, extack);
+	if (rc)
+		return rc;
+
+	rss_ctx = ethtool_rxfh_context_priv(ctx);
+	tbl_size = bnge_get_rxfh_indir_size(bn->bd);
+
+	/* Snapshot the software state so it can be restored if the hardware
+	 * update fails, keeping the reported config consistent with the
+	 * hardware.
+	 */
+	if (rxfh->key)
+		memcpy(old_key, rss_ctx->vnic.rss_hash_key, HW_HASH_KEY_SIZE);
+	if (rxfh->indir) {
+		old_indir = kmemdup(ethtool_rxfh_context_indir(ctx),
+				    tbl_size * sizeof(*old_indir), GFP_KERNEL);
+		if (!old_indir)
+			return -ENOMEM;
+	}
+
+	bnge_modify_rss(bn, ctx, rss_ctx, rxfh);
+
+	rc = bnge_hwrm_vnic_rss_cfg(bn, &rss_ctx->vnic);
+	if (rc) {
+		if (rxfh->key)
+			memcpy(rss_ctx->vnic.rss_hash_key, old_key,
+			       HW_HASH_KEY_SIZE);
+		if (rxfh->indir)
+			memcpy(ethtool_rxfh_context_indir(ctx), old_indir,
+			       tbl_size * sizeof(*old_indir));
+	}
+
+	kfree(old_indir);
+	return rc;
+}
+
+static int bnge_remove_rxfh_context(struct net_device *dev,
+				    struct ethtool_rxfh_context *ctx,
+				    u32 rss_context,
+				    struct netlink_ext_ack *extack)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_rss_ctx *rss_ctx;
+
+	rss_ctx = ethtool_rxfh_context_priv(ctx);
+
+	bnge_del_one_rss_ctx(bn, rss_ctx, true);
+	return 0;
+}
+
 static const struct ethtool_ops bnge_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
 	.get_link_ksettings	= bnge_get_link_ksettings,
@@ -1033,6 +1193,9 @@ static const struct ethtool_ops bnge_ethtool_ops = {
 	.set_rxfh		= bnge_set_rxfh,
 	.get_rxfh_fields	= bnge_get_rxfh_fields,
 	.set_rxfh_fields	= bnge_set_rxfh_fields,
+	.create_rxfh_context	= bnge_create_rxfh_context,
+	.modify_rxfh_context	= bnge_modify_rxfh_context,
+	.remove_rxfh_context	= bnge_remove_rxfh_context,
 };
 
 void bnge_set_ethtool_ops(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index c75c0a7f5c80..3dcab0370bdf 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2794,6 +2794,8 @@ int bnge_open_core(struct bnge_net *bn)
 	/* Poll link status and check for SFP+ module status */
 	bnge_get_port_module_status(bn);
 
+	bnge_hwrm_realloc_rss_ctx_vnic(bn);
+
 	return 0;
 
 err_free_irq:
@@ -3015,7 +3017,10 @@ void bnge_close_core(struct bnge_net *bn)
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
 
 	timer_delete_sync(&bn->timer);
+
+	bnge_clear_rss_ctxs(bn);
 	bnge_shutdown_nic(bn);
+
 	bnge_disable_napi(bn);
 
 	/* Save ring stats before shutdown */
@@ -3149,6 +3154,10 @@ static int bnge_set_features(struct net_device *dev, netdev_features_t features)
 	if (flags == bn->priv_flags)
 		return 0;
 
+	if ((bn->priv_flags & BNGE_NET_EN_NTUPLE) &&
+	    !(flags & BNGE_NET_EN_NTUPLE) && bn->num_rss_ctx)
+		return -EBUSY;
+
 	bn->priv_flags = flags;
 
 	return 0;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index b7a01cf885f2..0a4c4cf5eabf 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -352,8 +352,9 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 	if (!bnge_rings_ok(&hwr))
 		return -ENOMEM;
 
-	if (old_rx_rings != bd->hw_resc.resv_rx_rings)
-		bnge_set_dflt_rss_indir_tbl(bd);
+	if (old_rx_rings != bd->hw_resc.resv_rx_rings &&
+	    (!bd->netdev || !netif_is_rxfh_configured(bd->netdev)))
+		bnge_set_dflt_rss_indir_tbl(bd, NULL);
 
 	if (!bnge_aux_registered(bd)) {
 		u16 resv_msix, resv_ctx, aux_ctxs;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
index 7857421cd672..3aa89bcd96b9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
@@ -12,21 +12,26 @@
 #include "bnge_filter.h"
 #include "bnge_ethtool.h"
 
-void bnge_set_dflt_rss_indir_tbl(struct bnge_dev *bd)
+void bnge_set_dflt_rss_indir_tbl(struct bnge_dev *bd,
+				 struct ethtool_rxfh_context *rss_ctx)
 {
 	u16 max_entries, pad;
 	u32 *rss_indir_tbl;
 	u16 i;
 
 	max_entries = bnge_get_rxfh_indir_size(bd);
-	rss_indir_tbl = &bd->rss_indir_tbl[0];
+
+	if (rss_ctx)
+		rss_indir_tbl = ethtool_rxfh_context_indir(rss_ctx);
+	else
+		rss_indir_tbl = &bd->rss_indir_tbl[0];
 
 	for (i = 0; i < max_entries; i++)
 		rss_indir_tbl[i] = ethtool_rxfh_indir_default(i,
 							      bd->rx_nr_rings);
 
 	pad = bd->rss_indir_tbl_entries - max_entries;
-	if (pad)
+	if (pad && !rss_ctx)
 		memset(&rss_indir_tbl[i], 0, pad * sizeof(*rss_indir_tbl));
 }
 
@@ -44,6 +49,8 @@ void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic)
 
 		if (vnic->flags & BNGE_VNIC_NTUPLE_FLAG)
 			j = ethtool_rxfh_indir_default(i, bd->rx_nr_rings);
+		else if (vnic->flags & BNGE_VNIC_RSSCTX_FLAG)
+			j = ethtool_rxfh_context_indir(vnic->rss_ctx)[i];
 		else
 			j = bd->rss_indir_tbl[i];
 
@@ -155,7 +162,7 @@ void bnge_modify_rss(struct bnge_net *bn, struct ethtool_rxfh_context *ctx,
 		for (i = 0; i < tbl_size; i++)
 			indir_tbl[i] = rxfh->indir[i];
 		pad = bd->rss_indir_tbl_entries - tbl_size;
-		if (pad)
+		if (pad && !rss_ctx)
 			memset(&indir_tbl[i], 0, pad * sizeof(*indir_tbl));
 	}
 }
@@ -188,6 +195,10 @@ void bnge_hwrm_realloc_rss_ctx_vnic(struct bnge_net *bn)
 	struct ethtool_rxfh_context *ctx;
 	unsigned long context;
 
+	/* Erasing lost contexts touches netdev->ethtool->rss_ctx and calls
+	 * ethtool_rxfh_context_lost(), which requires the ethtool rss_lock.
+	 */
+	mutex_lock(&bn->netdev->ethtool->rss_lock);
 	xa_for_each(&bn->netdev->ethtool->rss_ctx, context, ctx) {
 		struct bnge_rss_ctx *rss_ctx = ethtool_rxfh_context_priv(ctx);
 		struct bnge_vnic_info *vnic = &rss_ctx->vnic;
@@ -201,6 +212,7 @@ void bnge_hwrm_realloc_rss_ctx_vnic(struct bnge_net *bn)
 			ethtool_rxfh_context_lost(bn->netdev, rss_ctx->index);
 		}
 	}
+	mutex_unlock(&bn->netdev->ethtool->rss_lock);
 }
 
 void bnge_clear_rss_ctxs(struct bnge_net *bn)
@@ -242,3 +254,14 @@ int bnge_alloc_vnic_rss_table(struct bnge_net *bn,
 	vnic->rss_hash_key_dma_addr = vnic->rss_table_dma_addr + size;
 	return 0;
 }
+
+void bnge_init_vnic_mem(struct bnge_vnic_info *vnic)
+{
+	int i;
+
+	vnic->fw_vnic_id = INVALID_HW_RING_ID;
+	vnic->vnic_id = BNGE_VNIC_ID_INVALID;
+
+	for (i = 0; i < BNGE_MAX_CTX_PER_VNIC; i++)
+		vnic->fw_rss_cos_lb_ctx[i] = INVALID_HW_RING_ID;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
index b2a1d8332a5f..3954c450315d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
@@ -21,6 +21,11 @@ struct bnge_l2_filter;
 #define BNGE_MAX_MC_ADDRS	16
 #define BNGE_MAX_UC_ADDRS	4
 
+#define BNGE_VNIC_ID_INVALID	0xffffffff
+
+struct ethtool_rxfh_context;
+struct ethtool_rxfh_param;
+
 enum {
 	BNGE_VNIC_DEFAULT	= 0,
 	BNGE_VNIC_NTUPLE	= 1
@@ -30,7 +35,8 @@ enum {
 	BNGE_VNIC_RSS_FLAG	= BIT(0),
 	BNGE_VNIC_MCAST_FLAG	= BIT(1),
 	BNGE_VNIC_UCAST_FLAG	= BIT(2),
-	BNGE_VNIC_NTUPLE_FLAG	= BIT(3)
+	BNGE_VNIC_NTUPLE_FLAG	= BIT(3),
+	BNGE_VNIC_RSSCTX_FLAG	= BIT(4)
 };
 
 struct bnge_vnic_info {
@@ -55,6 +61,8 @@ struct bnge_vnic_info {
 
 	u32		flags;
 	u32		vnic_id;
+
+	struct ethtool_rxfh_context	*rss_ctx;
 };
 
 struct bnge_rss_ctx {
@@ -66,7 +74,8 @@ void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic);
 int bnge_hwrm_vnic_rss_cfg(struct bnge_net *bn,
 			   struct bnge_vnic_info *vnic);
 int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic);
-void bnge_set_dflt_rss_indir_tbl(struct bnge_dev *bd);
+void bnge_set_dflt_rss_indir_tbl(struct bnge_dev *bd,
+				 struct ethtool_rxfh_context *ctx);
 int bnge_alloc_rfs_vnic(struct bnge_net *bn);
 int bnge_alloc_vnic_rss_table(struct bnge_net *bn,
 			      struct bnge_vnic_info *vnic);
@@ -78,4 +87,5 @@ void bnge_del_one_rss_ctx(struct bnge_net *bn, struct bnge_rss_ctx *rss_ctx,
 			  bool all);
 void bnge_hwrm_realloc_rss_ctx_vnic(struct bnge_net *bn);
 void bnge_clear_rss_ctxs(struct bnge_net *bn);
+void bnge_init_vnic_mem(struct bnge_vnic_info *vnic);
 #endif /* _BNGE_VNIC_H_ */
-- 
2.52.0

