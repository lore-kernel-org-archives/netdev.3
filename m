Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709441;
	b=alMZKfjFGzZjLV/NqCobbJcXHN7ZFKBNn2DRckPRePd547NKnFSquQlEfoJGZIneWwIj
	 LbH0MRaxZoEpx/K1ZCndcU4YSrPFNOg4CtHICIL7XDLzBlqRNmk5N3yxJpLaLZOtJiCPk
	 fwmot9AecvJGYKZUuf5LSSIluIsSzOrvcoo+eBPOn1LxqzNdhBG9il+rwPwh+/1/F+kiD
	 ZqgHV20hOzOSRAp4LL6rNSVnqF4QSR1AZEy2jrDXH+DEBU7Rgomlws6OkJmbRT5ThrDSD
	 awQxVcYK6MnmB1EFuoDNGGXrFlveg9RdTaZ5PedN8HrmNPOv+hHOkFpZoWSwi5rzYVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709441;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=biqhh6AVCyjlUCNF4Gt7stTjoMQOLxdpqxFWO7vTXew=;
	b=W1QOitiSCY/+LbYylMKhRIvNoxTLog9QImLv90vknpDBlJbA0lONooxqcvn6awtfCYrp
	 TfFLNABSVlpoV54Y6t7yKmxu+XH13aBH6ymU/ER6LwCnGGyG3ZhWHrEofXuhTZhY4ZkqW
	 YeLmY50WlAOoMqN/tsOkZWOHd7yfCxvFF5om5ijcesVwTwypi71Tz+tEG8OZkVKJZEWLe
	 ipfvnErEOPxVomV+CT0GD2pBew1HdBE2imA2oAKJFkcSCnM0WXWBTN/7fJNUxd2GJOXUW
	 Etjem9c1PRyllpXRO8B+Wbi7Q8az+LyNGWtdg68aJKLru8n7TPBhtpXjlCI8lCseaLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f5N2Q+8k;
	arc=none smtp.remote-ip=74.125.82.99
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07F0606A339
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E07F0606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f5N2Q+8k
Received: by mail-dl1-f99.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so4161969c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793709440; x=1794314240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=biqhh6AVCyjlUCNF4Gt7stTjoMQOLxdpqxFWO7vTXew=;
        b=bMFv//ae3dGhdfmEok9Hvm8WgQTH8pFueRvdZecCDVcz93ET8iHTfh9tjIzMohujm5
         JK0JQ7uZz3DxzrRjMjeIF5GeWXLBhZQlm7jr8v+a+B4Z+AxMgyViyegW1W9fPNlLHrJx
         TBMWzsmX8ar4DF/Qam1hRkM3KuRRY9f3rXlJSSJ8r+ylEDOuUEErstzSi/p2yT/5tdOa
         t7ADv92eYERP5xOia/Q8XJ+KHEvW2QGsUEQIvdQfqxTDV2JO98YL8SLwdeFbcmlYrlsC
         rZhNqTNWHhutCPxx8rf5KXBU9koolDnCgcbrz+9/edWYuvbxverXk8bsuIi+Pb1ZP1r6
         /UNA==
X-Gm-Message-State: APuU4Z8cMmaEBDTUWEC6wYWk8cWJOzFaN1IkeNK/orTMS+zf7JLQwp1B
	3O4ck9Yl41Bwmh2smWKsvF8j7GbU5peZXjzwoowPGmwj8i5165OSKccYM0ApzBPZXCLtG8huPFA
	cLrQBL7LiM8WlOm/DF/uMIH73Ti3MjvNExX7ywm/5DMs7ntu31oJIRbzm7OU1XGZz+B8MvNaamy
	ZmVTUygF9uLTBg+e2dGXUhk7R/yOZJX5TiWpxACf8MYpZcs1IMzdthc1AFsNdIRuxeE9a7fotsK
	XoLnKu4Hw==
X-Gm-Gg: AYBFou009IGJJTeq8APrhMdUeFbq2WfTePPOZaK/cDzUu49tbNCUMafdBmj0/ZXlH0h
	WSHGxKJHLdiLRokVsFxH3Qa1QKC10C4mEuMkePfXySUsFr9tYrg78Yz3hF3ElYDqOf7VgNPzH2L
	r4SUdq+OX5lc0frcOgGIvlqY61gfVPKkx0PVIenpG3TaeNKjB3rxgMnnLVEDTietLfc3Rh05Q3j
	W+6QAyiWJCCFiNtI6Kx6toi4TiY/94uPTWdcpw87whsnGxxQdoe6FzPd/bMY3Yy6l4qUnibTsx3
	YjWuKyeGhvN5Vo8QPrHqv4vA2asrDFN35UFiu7vY8ZTH3a8uAevemTolPdE2qYWcG6LpH4WY1tt
	y5xIAgFKiUnBWv3b3pVi+C1w1uPYHP7HUqDYmQK35ybVafk5TWKC+8n4M21hGo6s2cseSRY9lEA
	P3tK4kud+2ygcQT6FKsX0ngYuNVR5sDWXHAQ==
X-Received: by 2002:a05:7022:7f19:b0:1b2:3a68:f18f with SMTP id a92af1059eb24-1b23a68f64bmr5881865c88.22.1793709439605;
        Tue, 03 Nov 2026 04:37:19 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1b2386a515dsm53404c88.14.2026.11.03.04.37.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 04:37:19 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3adad90c894so4310531a91.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793709438; x=1794314238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=biqhh6AVCyjlUCNF4Gt7stTjoMQOLxdpqxFWO7vTXew=;
        b=f5N2Q+8kLA50zjmpc053MaPW1S4Od5uRR7c2fQzvV9iCituh+w1h4FeTswWmcLvTVm
         PcHG19F/OrFHJuMH4SpRYSl3Ca80UfBMpGzIAVfmMaLcr5BU7bhUGM9KGyVqNt46AMa8
         2B/CU9tgcE3fAhFWTXFXUxt5bevMYHYwtvqX4=
X-Received: by 2002:a17:90b:5603:b0:3ac:9a03:20bf with SMTP id 98e67ed59e1d1-3ae8985b551mr11099414a91.55.1793709437467;
        Tue, 03 Nov 2026 04:37:17 -0800 (PST)
X-Received: by 2002:a17:90b:5603:b0:3ac:9a03:20bf with SMTP id 98e67ed59e1d1-3ae8985b551mr11099387a91.55.1793709436917;
        Tue, 03 Nov 2026 04:37:16 -0800 (PST)
Received: from H5-S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b08759344dsm2131567a91.13.2026.11.03.04.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:37:15 -0800 (PST)
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
Subject: [PATCH net-next v5 02/10] bnge: add NTUPLE/ARFS VNIC
Date: Tue,  3 Nov 2026 18:06:42 +0530
Message-ID: <20261103123651.442893-3-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261103123651.442893-1-vikas.gupta@broadcom.com>
References: <20261103123651.442893-1-vikas.gupta@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Initialize the second VNIC, which is specifically used for the
NTUPLE/ARFS feature. This VNIC helps support the aRFS/NTUPLE
functionality. With this change, the total number of VNICs becomes 2.
Add bnge_set_dflt_rfs() to configure the default NTUPLE feature state
at netdev allocation time.

The NTUPLE/aRFS VNIC is always allocated, so the function needs at
least BNGE_BASE_VNICS (2) VNICs and the matching RSS contexts.
Firmware grants these to every supported function. If it grants fewer,
bnge_reserve_rings() fails with -ENOMEM and the device does not probe,
as it would for any other missing ring resource.

The patch also removes BNGE_FW_CAP_CFA_NTUPLE_RX_EXT_IP_PROTO and
BNGE_FW_CAP_CFA_RFS_RING_TBL_IDX_V3, which nothing uses, and renumbers
BNGE_FW_CAP_VNIC_RE_FLUSH from BIT_ULL(26) to BIT_ULL(24).

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  4 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 58 +++++++++++++++++--
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  1 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    | 21 ++++---
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |  1 +
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    | 33 ++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_vnic.h    |  8 ++-
 7 files changed, 107 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index bde54ba5d50f..3e8210626062 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -63,9 +63,7 @@ enum {
 	BNGE_FW_CAP_THRESHOLD_TEMP_SUPPORTED		= BIT_ULL(21),
 	BNGE_FW_CAP_DFLT_VLAN_TPID_PCP			= BIT_ULL(22),
 	BNGE_FW_CAP_VNIC_TUNNEL_TPA			= BIT_ULL(23),
-	BNGE_FW_CAP_CFA_NTUPLE_RX_EXT_IP_PROTO		= BIT_ULL(24),
-	BNGE_FW_CAP_CFA_RFS_RING_TBL_IDX_V3		= BIT_ULL(25),
-	BNGE_FW_CAP_VNIC_RE_FLUSH			= BIT_ULL(26),
+	BNGE_FW_CAP_VNIC_RE_FLUSH			= BIT_ULL(24),
 };
 
 enum {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 31ca314fd52b..3248aae88c8d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1149,12 +1149,7 @@ static int bnge_alloc_vnic_attributes(struct bnge_net *bn)
 
 static int bnge_alloc_vnics(struct bnge_net *bn)
 {
-	int num_vnics;
-
-	/* Allocate only 1 VNIC for now
-	 * Additional VNICs will be added based on RFS/NTUPLE in future patches
-	 */
-	num_vnics = 1;
+	int num_vnics = BNGE_BASE_VNICS;
 
 	bn->vnic_info = kzalloc_objs(struct bnge_vnic_info, num_vnics);
 	if (!bn->vnic_info)
@@ -1320,6 +1315,9 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	bn->vnic_info[BNGE_VNIC_DEFAULT].flags |= BNGE_VNIC_RSS_FLAG |
 						  BNGE_VNIC_MCAST_FLAG |
 						  BNGE_VNIC_UCAST_FLAG;
+	bn->vnic_info[BNGE_VNIC_NTUPLE].flags |= BNGE_VNIC_RSS_FLAG |
+						 BNGE_VNIC_NTUPLE_FLAG;
+
 	rc = bnge_alloc_vnic_attributes(bn);
 	if (rc)
 		goto err_free_nq_tree;
@@ -2578,6 +2576,13 @@ static int bnge_init_chip(struct bnge_net *bn)
 	if (rc)
 		goto err_out;
 
+	rc = bnge_alloc_rfs_vnic(bn);
+	if (rc) {
+		netdev_err(bn->netdev,
+			   "hwrm aRFS vnic alloc failure rc: %d\n", rc);
+		goto err_out;
+	}
+
 	if (bd->rss_cap & BNGE_RSS_CAP_RSS_HASH_TYPE_DELTA)
 		bnge_hwrm_update_rss_hash_cfg(bn);
 
@@ -3133,6 +3138,36 @@ static const struct netdev_stat_ops bnge_stat_ops = {
 	.get_base_stats		= bnge_get_base_stats,
 };
 
+static netdev_features_t bnge_fix_features(struct net_device *dev,
+					   netdev_features_t features)
+{
+	/* NTUPLE can only be changed while the interface is down. */
+	if (netif_running(dev)) {
+		if (dev->features & NETIF_F_NTUPLE)
+			features |= NETIF_F_NTUPLE;
+		else
+			features &= ~NETIF_F_NTUPLE;
+	}
+	return features;
+}
+
+static int bnge_set_features(struct net_device *dev, netdev_features_t features)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	u32 flags = bn->priv_flags;
+
+	flags &= ~BNGE_NET_EN_NTUPLE;
+	if (features & NETIF_F_NTUPLE)
+		flags |= BNGE_NET_EN_NTUPLE;
+
+	if (flags == bn->priv_flags)
+		return 0;
+
+	bn->priv_flags = flags;
+
+	return 0;
+}
+
 static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
@@ -3140,6 +3175,8 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_set_rx_mode_async	= bnge_set_rx_mode,
 	.ndo_features_check	= bnge_features_check,
+	.ndo_fix_features	= bnge_fix_features,
+	.ndo_set_features	= bnge_set_features,
 };
 
 static void bnge_init_mac_addr(struct bnge_dev *bd)
@@ -3265,6 +3302,13 @@ static void bnge_init_ring_params(struct bnge_net *bn)
 	bn->netdev->cfg->hds_thresh = max(BNGE_DEFAULT_RX_COPYBREAK, rx_size);
 }
 
+static void bnge_set_dflt_rfs(struct bnge_net *bn)
+{
+	bn->netdev->hw_features |= NETIF_F_NTUPLE;
+	bn->netdev->features |= NETIF_F_NTUPLE;
+	bn->priv_flags |= BNGE_NET_EN_NTUPLE;
+}
+
 int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 {
 	struct net_device *netdev;
@@ -3371,6 +3415,8 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bnge_set_ring_params(bd);
 
 	bnge_init_l2_fltr_tbl(bn);
+	bnge_set_dflt_rfs(bn);
+
 	bnge_init_mac_addr(bd);
 
 	rc = bnge_probe_phy(bn, true);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index ee649cc644db..c47a874df4ba 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -152,6 +152,7 @@ enum {
 	BNGE_NET_EN_GRO		= BIT(0),
 	BNGE_NET_EN_LRO		= BIT(1),
 	BNGE_NET_EN_JUMBO	= BIT(2),
+	BNGE_NET_EN_NTUPLE	= BIT(3),
 };
 
 #define BNGE_NET_EN_TPA		(BNGE_NET_EN_GRO | BNGE_NET_EN_LRO)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index 21f55ea056f4..ef5e235a7cdd 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -191,12 +191,16 @@ int bnge_cal_nr_rss_ctxs(u16 rx_rings)
 static u16 bnge_get_total_rss_ctxs(struct bnge_dev *bd,
 				   struct bnge_hw_rings *hwr)
 {
-	return bnge_cal_nr_rss_ctxs(hwr->grp);
+	u16 rss_ctx = bnge_cal_nr_rss_ctxs(hwr->grp);
+
+	rss_ctx *= hwr->vnic;
+
+	return rss_ctx;
 }
 
 static u16 bnge_get_total_vnics(struct bnge_dev *bd)
 {
-	return 1;
+	return BNGE_BASE_VNICS;
 }
 
 u32 bnge_get_rxfh_indir_size(struct bnge_dev *bd)
@@ -222,8 +226,8 @@ static void bnge_copy_reserved_rings(struct bnge_dev *bd,
 
 static bool bnge_rings_ok(struct bnge_hw_rings *hwr)
 {
-	return hwr->tx && hwr->rx && hwr->nq && hwr->grp && hwr->vnic &&
-	       hwr->stat && hwr->cmpl;
+	return hwr->tx && hwr->rx && hwr->nq && hwr->grp &&
+	       hwr->vnic >= BNGE_BASE_VNICS && hwr->stat && hwr->cmpl;
 }
 
 static bool bnge_need_reserve_rings(struct bnge_dev *bd)
@@ -232,18 +236,21 @@ static bool bnge_need_reserve_rings(struct bnge_dev *bd)
 	u16 cprs = bnge_cprs_demand(bd);
 	u16 rx = bd->rx_nr_rings, stat;
 	u16 nqs = bnge_nqs_demand(bd);
-	u16 vnic;
+	struct bnge_hw_rings hwr = {};
 
 	if (hw_resc->resv_tx_rings != bd->tx_nr_rings)
 		return true;
 
-	vnic = bnge_get_total_vnics(bd);
+	hwr.grp = bd->rx_nr_rings;
+	hwr.vnic = bnge_get_total_vnics(bd);
 
 	if (bnge_is_agg_reqd(bd))
 		rx <<= 1;
 	stat = bnge_func_stat_ctxs_demand(bd);
 	if (hw_resc->resv_rx_rings != rx || hw_resc->resv_cp_rings != cprs ||
-	    hw_resc->resv_vnics != vnic || hw_resc->resv_stat_ctxs != stat)
+	    hw_resc->resv_vnics != hwr.vnic ||
+	    hw_resc->resv_rsscos_ctxs != bnge_get_total_rss_ctxs(bd, &hwr) ||
+	    hw_resc->resv_stat_ctxs != stat)
 		return true;
 	if (hw_resc->resv_irqs != nqs)
 		return true;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
index c0b6992d7f82..97e8ef08974c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
@@ -75,6 +75,7 @@ void bnge_aux_init_dflt_config(struct bnge_dev *bd);
 u32 bnge_get_rxfh_indir_size(struct bnge_dev *bd);
 int bnge_cal_nr_rss_ctxs(u16 rx_rings);
 bool bnge_aux_has_enough_resources(struct bnge_dev *bd);
+bool bnge_arfs_capable(struct bnge_dev *bd, bool new_rss_ctx);
 
 static inline u32
 bnge_adjust_pow_two(u32 total_ent, u16 ent_per_blk)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
index 3a6c8f0a5954..d98a6196c859 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
@@ -42,7 +42,11 @@ void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic)
 	for (i = 0; i < tbl_size; i++) {
 		u16 ring_id, j;
 
-		j = bd->rss_indir_tbl[i];
+		if (vnic->flags & BNGE_VNIC_NTUPLE_FLAG)
+			j = ethtool_rxfh_indir_default(i, bd->rx_nr_rings);
+		else
+			j = bd->rss_indir_tbl[i];
+
 		rxr = &bn->rx_ring[j];
 
 		ring_id = rxr->rx_ring_struct.fw_ring_id;
@@ -98,3 +102,30 @@ int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic)
 	}
 	return rc;
 }
+
+static int bnge_alloc_and_setup_vnic(struct bnge_net *bn,
+				     struct bnge_vnic_info *vnic,
+				     u16 rx_rings)
+{
+	int rc;
+
+	rc = bnge_hwrm_vnic_alloc(bn->bd, vnic, rx_rings);
+	if (rc) {
+		netdev_err(bn->netdev, "hwrm vnic %u alloc failure rc: %d\n",
+			   vnic->vnic_id, rc);
+		return rc;
+	}
+
+	/* If bnge_setup_vnic() fails, the VNIC allocated above is not freed
+	 * here; the caller (bnge_init_chip) unwinds via its err_out path.
+	 */
+	return bnge_setup_vnic(bn, vnic);
+}
+
+int bnge_alloc_rfs_vnic(struct bnge_net *bn)
+{
+	struct bnge_vnic_info *vnic;
+
+	vnic = &bn->vnic_info[BNGE_VNIC_NTUPLE];
+	return bnge_alloc_and_setup_vnic(bn, vnic, bn->bd->rx_nr_rings);
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
index c81d3a64561e..72357e0b37ac 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
@@ -22,13 +22,16 @@ struct bnge_l2_filter;
 #define BNGE_MAX_UC_ADDRS	4
 
 enum {
-	BNGE_VNIC_DEFAULT	= 0
+	BNGE_VNIC_DEFAULT	= 0,
+	BNGE_VNIC_NTUPLE	= 1,
+	BNGE_BASE_VNICS		= 2
 };
 
 enum {
 	BNGE_VNIC_RSS_FLAG	= BIT(0),
 	BNGE_VNIC_MCAST_FLAG	= BIT(1),
-	BNGE_VNIC_UCAST_FLAG	= BIT(2)
+	BNGE_VNIC_UCAST_FLAG	= BIT(2),
+	BNGE_VNIC_NTUPLE_FLAG	= BIT(3)
 };
 
 struct bnge_vnic_info {
@@ -60,4 +63,5 @@ int bnge_hwrm_vnic_rss_cfg(struct bnge_net *bn,
 			   struct bnge_vnic_info *vnic);
 int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic);
 void bnge_set_dflt_rss_indir_tbl(struct bnge_dev *bd);
+int bnge_alloc_rfs_vnic(struct bnge_net *bn);
 #endif /* _BNGE_VNIC_H_ */
-- 
2.52.0

