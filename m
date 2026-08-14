Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B9305687
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670118; cv=none; b=n7YV1EBiFvy7nO2IVFe9zIs8PnmgS1xVUcr52sWWouVhY1xlZO4/ich7VGPl60Odpyxa0x+Lgqw4iouJd+oVGup4xEBjWrx1c7B/29oncpsLTF0E7J5YxMMXXV5Uh89sJtOy4tNhsvvD6SE6RQd5+HXkbAKnIeiaJhxy/uSx90s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670118; c=relaxed/simple;
	bh=5JxgG2giVr1vMhZXie1lStxEO5a9xYIQc4Hyf/XThDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLVeeXfq1GdE6mKnJZ3w4Cy9JIY5C6yECMi/syCcmBWsSd/YQmsdzrQKV+5IZeowYf3JJ/kJxHmsFZt4TC4PzYK80ro99hLRLdLAaM7bVRmViOa/q4WKz4n4hvkhrx9++6yPCbwO79OG+O2y95lPN3eTDsP2hxvUFKH2WzoY2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AE7Xa2VG; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AE7Xa2VG"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso410754a91.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786670116; x=1787274916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2CxGO/H3U8vw4OJhc5+GGcLXY1TQ42O8MsAwJO9HHD4=;
        b=lUcipU2RmSadhQrnAPtwMdGNZdBXdQQdL3pl4pef2sgxMyHQzj/idmGEBcm3t16lXX
         KYmUGe4xR2dcFZxbsVmyrACVH1jBjSPgeC45p13wocuRsWeWvbxwklnmUS4JQ5dumwW7
         +pgkFd+SqPcKC+c0DesmlmRXE6nFNSosLpcFBSxAtvamrQTcknQM6EXi+kMvU21zvTRW
         cmCK1qSM7YvvCC+/1QlnKO7ncz9A7z9p9ZAu5UlC4cHHFN/FljxBtLz9sesTfwtxfvZ6
         snuLDRV4v5Hj4wSTduINrEgbXOpyNjOKs5qZUvBx6Blm9KW8euB7QffZ8CcME/lPSbqv
         FdRg==
X-Gm-Message-State: AOJu0YxVRPvK8oQOIdA4r13PHBhrCM5feEthpfeNjcytSRP4sU5Mci/T
	2OW849eL1BcxAlKvsqNmpkYvoppg1CuY6AcniUVKUpvro48Yu48tZqQ9XwDsyLA6+Y6KBuFk8/6
	Mz0Faw7xJ5LBegANfe2fLgvX8rAkpeQJt2o8xqvqRRxGRIOXv9k2PsR3IZS7xXAwrDkEy8QmFH+
	cByP007XHB2VSyk/pyL+FHh4v3AnBIbNxDELM7O9CJ8l1UinT77HaRDbDSX7sywhn9JfycHx0tg
	WpSatfrdg==
X-Gm-Gg: AR+sD10aQ1zLUq+E8O/Rd+ynLo5qSG4BN1lVbheUNnB7gI/lntXqevqtHjbazjr424u
	vPlbbcbZM4PsaRmejGYemUl+fmo9C9r6IpN/Zh8lwulhn5d3YNMx/1inxJ8sE2A5fOSW26OD9xf
	kr9jfEcjDen6nDYfRRI7Y+oEB7gkTAkemLXwrlPbRMjhzU5/e4e9y/8HA/j4F7EB+1hKW/DAZxD
	gYZkZ1CFH4ZaZPJJDGx7+DIon1zyGrJYvJ8LseulF/S3IROwDU6eJ+jJ4VHW/InlXhfASNp//JT
	fB7oMcKAJeUhAtFFbARlgAfyCCKrNax4PziFr7ZQiw+ug02HXE2nU5tH6qTEX2osGrxXkN2ima0
	hIUeX88sv4qPGrKPsvU+3SLAlGDevB1BCbBDdjLOh+ZuDOoDSFktDivXWLjNvsRNvmN43vyUJtt
	Ox42bzDzYKVWNhqSv1p6QQtrMi06nZ6UQ=
X-Received: by 2002:a17:90a:da8f:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-3933b95e327mr2083152a91.14.1786670116387;
        Thu, 13 Aug 2026 18:15:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-394eac9537asm114356a91.8.2026.08.13.18.15.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2026 18:15:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbee57593baso302051a12.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786670115; x=1787274915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2CxGO/H3U8vw4OJhc5+GGcLXY1TQ42O8MsAwJO9HHD4=;
        b=AE7Xa2VG+xZ+KFGeaB/2FhsiYUVg+Sz8glXIoGLBfqO9hCJMiZdcHiO0st6laNu3//
         YNpIS8W9BxdS3+dl5SfJmUbV7vh6lejQWl/hHRqRuoSbMgDbKiBuSxhIPysi8RNVCNMS
         h8nY/opGBS0kzxQvFA6rnbPJEG5QGWHLx6AoE=
X-Received: by 2002:a05:6a21:998c:b0:3c1:d78:6457 with SMTP id adf61e73a8af0-3cc71d50736mr1799089637.32.1786670114658;
        Thu, 13 Aug 2026 18:15:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:998c:b0:3c1:d78:6457 with SMTP id adf61e73a8af0-3cc71d50736mr1799040637.32.1786670114018;
        Thu, 13 Aug 2026 18:15:14 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebcb69fbbsm12174177eec.11.2026.08.13.18.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 18:15:13 -0700 (PDT)
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
Subject: [PATCH net-next 06/11] bnge: add ethtool support to manage RSS contexts
Date: Fri, 14 Aug 2026 06:44:30 +0530
Message-ID: <20260814011435.194631-7-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260814011435.194631-1-vikas.gupta@broadcom.com>
References: <20260814011435.194631-1-vikas.gupta@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 129 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |   5 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |   2 +-
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    |  22 ++-
 .../net/ethernet/broadcom/bnge/bnge_vnic.h    |  14 +-
 5 files changed, 167 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index c6f564045647..a12948087338 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -1012,6 +1012,132 @@ static u32 bnge_get_rx_ring_count(struct net_device *dev)
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
+	struct bnge_rss_ctx *rss_ctx;
+	int rc;
+
+	rc = bnge_rxfh_context_check(bn, rxfh, extack);
+	if (rc)
+		return rc;
+
+	rss_ctx = ethtool_rxfh_context_priv(ctx);
+
+	bnge_modify_rss(bn, ctx, rss_ctx, rxfh);
+
+	return bnge_hwrm_vnic_rss_cfg(bn, &rss_ctx->vnic);
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
@@ -1041,6 +1167,9 @@ static const struct ethtool_ops bnge_ethtool_ops = {
 	.set_rxfh		= bnge_set_rxfh,
 	.get_rxfh_fields	= bnge_get_rxfh_fields,
 	.set_rxfh_fields	= bnge_set_rxfh_fields,
+	.create_rxfh_context	= bnge_create_rxfh_context,
+	.modify_rxfh_context	= bnge_modify_rxfh_context,
+	.remove_rxfh_context	= bnge_remove_rxfh_context,
 };
 
 void bnge_set_ethtool_ops(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 1a55c2fe4532..3c2cb9571af1 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2785,6 +2785,8 @@ int bnge_open_core(struct bnge_net *bn)
 	/* Poll link status and check for SFP+ module status */
 	bnge_get_port_module_status(bn);
 
+	bnge_hwrm_realloc_rss_ctx_vnic(bn);
+
 	return 0;
 
 err_free_irq:
@@ -3002,7 +3004,10 @@ void bnge_close_core(struct bnge_net *bn)
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
 
 	timer_delete_sync(&bn->timer);
+
+	bnge_clear_rss_ctxs(bn);
 	bnge_shutdown_nic(bn);
+
 	bnge_disable_napi(bn);
 
 	/* Save ring stats before shutdown */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index 9604bd05ba37..2fa7e829eef2 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -353,7 +353,7 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 		return -ENOMEM;
 
 	if (old_rx_rings != bd->hw_resc.resv_rx_rings)
-		bnge_set_dflt_rss_indir_tbl(bd);
+		bnge_set_dflt_rss_indir_tbl(bd, NULL);
 
 	if (!bnge_aux_registered(bd)) {
 		u16 resv_msix, resv_ctx, aux_ctxs;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
index 417abc7e8c74..40a6abcafce8 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
@@ -12,14 +12,19 @@
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
@@ -44,6 +49,8 @@ void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic)
 
 		if (vnic->flags & BNGE_VNIC_NTUPLE_FLAG)
 			j = ethtool_rxfh_indir_default(i, bd->rx_nr_rings);
+		else if (vnic->flags & BNGE_VNIC_RSSCTX_FLAG)
+			j = ethtool_rxfh_context_indir(vnic->rss_ctx)[i];
 		else
 			j = bd->rss_indir_tbl[i];
 
@@ -238,3 +245,14 @@ int bnge_alloc_vnic_rss_table(struct bnge_net *bn,
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
2.47.1

