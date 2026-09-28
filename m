Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A78429013
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576023; cv=none; b=H+bSLQt3JafFJSpLOrnbBu+ASLtV9vn1H7AaVRCoIieP+M0dMniFzt2U8whX+npgmM1UkHhbWHCMQ5cA3j34jlACCHTVi3tT5A/GV2wVjjjtxG3Ted0KmuPJ/pDafCVzuiN6twAfnNsWDugl9LEbiL+M1ZJatOMQmXL8hiBt/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576023; c=relaxed/simple;
	bh=PuAxte98DUDY59ISaQRjDl8ruobgu0layGgZakgXva8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8SqZx1ksO3yCj94tuwbZWMZk7P0cKVshIdM2SMVIIHmnLIaLocaJTBkYc9eIIKgIUw1wtl20zBGuwOWBpmDkcawNccdI+JpjZ5A4iN/xlmYFOiVHopAMnasW3702IUei2a4tN+amomjkEJP+/Tx4DJLIag7Hb3VZp42WQ0+OtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SrS0porH; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SrS0porH"
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-915ea0650bbso1253796d6.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576011; x=1791180811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MB0VPXfDGYqHHJw4LOcvJmKccCtxBhjO47tk1IwnE9Q=;
        b=U1q3dsO7Vkl0f0bqVa5Or0XwgPA2uN6pdCgqld9Azq/LY/OGKVT1y8AxWB5lB8XR8N
         tBj953s8c12fupyUNrXouX7eiqdA5sl+6klvbGSboZ9FQrEjvJcDDo/b/IPM7Y/Q7c5L
         jB1bn8f9oyP1owBq8k4fU2fmPQNIYkS9vVcX47UT5J8hnuO4o4EN9q1RiueUp+rxlzBL
         x9hPgHmdDigDV9EGm1zS11ImsFogXkVz4XSDmSoziEysa2+vGEQsIhBkTWC+d5mtBDR6
         P3ovrcgjvZq38vAxknViVD79E0jyEpyvTYeohL5q9P3TnqegLfWnidygCzwppn/h6Rf6
         CT3w==
X-Gm-Message-State: AFuF++kjVBMk5AzR5XHHEUdSvNyQ3zoeKjiKhrLcZbOf3Jhb6pUxMwKy
	6gxm1HmODuLkra4s4vVMmOit3F6bxZ9f8e5nJOIEubj94Td8C+8Aokc9FZALw/UKm3FxEcydk7f
	J3VTslIBzsUYstMTuEDS3/uy4U/rLx1N5ydyUGcyliwRVnUFil1I4iDzIELR68X7hz40vdf5YT6
	DTTIZH5E3x3x1SdHjmZkKwiQtIDuyra2iFwG3jn75sfjRvwcMunhnOkmU7Vgx8IkMZn9rvipniL
	9omr2vUAQ==
X-Gm-Gg: AYBFou1fINdh0HkkRsUjPLa2cGp6GJXppgf6+6dGmGGRN/xeIf4ydMSTqO6I1XrCFQZ
	S0ATlCIjrS7Ohs9iJZhmlXU/+ldP9FZvk/Ba4Gb27Vobr268O7lRrR7zEsindBwM7Thu2gALA1y
	Bw/wAfbAJ+KV+iPqcCf8zhR/ZZCGbwYAH/rC9XPacSs9OlQcTArNc8J8wUuUZBbNyp4zOCdY8ds
	3z5WWtiJs5svwkitlATmZ9ZWHQP4aSbWzD6SwNb/T/HblfhaWoXXI3UjTZJqE053qnabJsTNL5K
	ZzX06pIq5Lro9SZcNlIrFs63oGgaLKxj1eC8uiKJj+8Sp287AjpLDWcYfffDGhe8hnfDZjdLtWQ
	qJZBAgBT2HY3s7gLP/eToY4ssz53iUKgdqdCGE7EAOpVxQHMWgVMo+q9JjZtIVZrM9tlNYp6y0u
	5JAHQpZj+6K8PvEHVp5Vp0pFasVfJj19o0vlF1
X-Received: by 2002:a05:620a:1b9b:b0:939:6dea:ce79 with SMTP id af79cd13be357-93c43ce3316mr1944938885a.47.1790576011588;
        Sun, 27 Sep 2026 23:13:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93c81259be3sm28192885a.1.2026.09.27.23.13.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 23:13:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1438492fb40so3931591c88.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790576010; x=1791180810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MB0VPXfDGYqHHJw4LOcvJmKccCtxBhjO47tk1IwnE9Q=;
        b=SrS0porHXxjm4Xb27WodelZnA78MDl7bD/XACB6VVRXUx3AIMGNgcxHkp5pVS/NxRk
         aZ2ukejUUE1VsY+uGEI7BTe/QepLzusShyDzO2BpHyjOYmNwkjHv7OUhV64VVhbifyDp
         RbrQNZm4FP03NsoapfmGVbq739wfzmFa+jK5Y=
X-Received: by 2002:a05:701b:4202:10b0:138:4e43:6399 with SMTP id a92af1059eb24-146ce491e90mr8957402c88.11.1790576009661;
        Sun, 27 Sep 2026 23:13:29 -0700 (PDT)
X-Received: by 2002:a05:701b:4202:10b0:138:4e43:6399 with SMTP id a92af1059eb24-146ce491e90mr8957344c88.11.1790576008064;
        Sun, 27 Sep 2026 23:13:28 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-147913a776fsm17355561c88.17.2026.09.27.23.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:13:27 -0700 (PDT)
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
Subject: [net-next, v4 02/10] bnge: add NTUPLE/ARFS VNIC
Date: Mon, 28 Sep 2026 11:42:59 +0530
Message-ID: <20260928061307.1172344-3-vikas.gupta@broadcom.com>
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

Initialize the second VNIC, which is specifically used for the
NTUPLE/ARFS feature. This VNIC helps support the aRFS/NTUPLE
functionality. With this change, the total number of VNICs becomes 2.
Add bnge_set_dflt_rfs() to configure the default NTUPLE feature state
at netdev allocation time.

Also, allocate and configure the ARFS VNIC.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     | 10 ++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 76 +++++++++++++++++--
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  1 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    | 60 ++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |  1 +
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    | 33 +++++++-
 .../net/ethernet/broadcom/bnge/bnge_vnic.h    |  7 +-
 7 files changed, 176 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index bde54ba5d50f..a88aac140c7d 100644
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
@@ -74,6 +72,7 @@ enum {
 	BNGE_EN_STRIP_VLAN				= BIT_ULL(2),
 	BNGE_EN_SHARED_CHNL				= BIT_ULL(3),
 	BNGE_EN_UDP_GSO_SUPP				= BIT_ULL(4),
+	BNGE_EN_ARFS_CAP				= BIT_ULL(5),
 };
 
 #define BNGE_EN_ROCE		(BNGE_EN_ROCE_V1 | BNGE_EN_ROCE_V2)
@@ -218,6 +217,11 @@ static inline bool bnge_is_roce_en(struct bnge_dev *bd)
 	return bd->flags & BNGE_EN_ROCE;
 }
 
+static inline bool bnge_is_arfs_cap(struct bnge_dev *bd)
+{
+	return bd->flags & BNGE_EN_ARFS_CAP;
+}
+
 static inline bool bnge_is_agg_reqd(struct bnge_dev *bd)
 {
 	if (bd->netdev) {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 9e64b1933c02..c6b9048586b3 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1149,12 +1149,10 @@ static int bnge_alloc_vnic_attributes(struct bnge_net *bn)
 
 static int bnge_alloc_vnics(struct bnge_net *bn)
 {
-	int num_vnics;
+	int num_vnics = 1;
 
-	/* Allocate only 1 VNIC for now
-	 * Additional VNICs will be added based on RFS/NTUPLE in future patches
-	 */
-	num_vnics = 1;
+	if (bn->priv_flags & BNGE_NET_EN_NTUPLE)
+		num_vnics++;
 
 	bn->vnic_info = kzalloc_objs(struct bnge_vnic_info, num_vnics);
 	if (!bn->vnic_info)
@@ -1320,6 +1318,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	bn->vnic_info[BNGE_VNIC_DEFAULT].flags |= BNGE_VNIC_RSS_FLAG |
 						  BNGE_VNIC_MCAST_FLAG |
 						  BNGE_VNIC_UCAST_FLAG;
+	if (bn->priv_flags & BNGE_NET_EN_NTUPLE)
+		bn->vnic_info[BNGE_VNIC_NTUPLE].flags |= BNGE_VNIC_RSS_FLAG |
+							 BNGE_VNIC_NTUPLE_FLAG;
+
 	rc = bnge_alloc_vnic_attributes(bn);
 	if (rc)
 		goto err_free_core;
@@ -2546,6 +2548,18 @@ static int bnge_init_chip(struct bnge_net *bn)
 	if (rc)
 		goto err_out;
 
+	if ((bn->priv_flags & BNGE_NET_EN_NTUPLE) && bnge_is_arfs_cap(bd)) {
+		rc = bnge_alloc_rfs_vnic(bn);
+		if (rc) {
+			netdev_warn(bn->netdev,
+				    "Failed to allocate aRFS VNIC (%d), disabling ARFS\n",
+				    rc);
+			bd->flags &= ~BNGE_EN_ARFS_CAP;
+			bn->priv_flags &= ~BNGE_NET_EN_NTUPLE;
+			bn->netdev->features &= ~NETIF_F_NTUPLE;
+		}
+	}
+
 	if (bd->rss_cap & BNGE_RSS_CAP_RSS_HASH_TYPE_DELTA)
 		bnge_hwrm_update_rss_hash_cfg(bn);
 
@@ -3019,6 +3033,8 @@ static int bnge_close(struct net_device *dev)
 	bnge_hwrm_if_change(bn->bd, false);
 	bn->sp_event = 0;
 
+	netdev_update_features(dev);
+
 	return 0;
 }
 
@@ -3101,6 +3117,40 @@ static const struct netdev_stat_ops bnge_stat_ops = {
 	.get_base_stats		= bnge_get_base_stats,
 };
 
+static netdev_features_t bnge_fix_features(struct net_device *dev,
+					   netdev_features_t features)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+
+	/* NTUPLE can only be changed while the interface is down. */
+	if (netif_running(dev)) {
+		if (dev->features & NETIF_F_NTUPLE)
+			features |= NETIF_F_NTUPLE;
+		else
+			features &= ~NETIF_F_NTUPLE;
+	} else if ((features & NETIF_F_NTUPLE) && !bnge_is_arfs_cap(bn->bd)) {
+		features &= ~NETIF_F_NTUPLE;
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
@@ -3108,6 +3158,8 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_set_rx_mode_async	= bnge_set_rx_mode,
 	.ndo_features_check	= bnge_features_check,
+	.ndo_fix_features	= bnge_fix_features,
+	.ndo_set_features	= bnge_set_features,
 };
 
 static void bnge_init_mac_addr(struct bnge_dev *bd)
@@ -3233,6 +3285,18 @@ static void bnge_init_ring_params(struct bnge_net *bn)
 	bn->netdev->cfg->hds_thresh = max(BNGE_DEFAULT_RX_COPYBREAK, rx_size);
 }
 
+static void bnge_set_dflt_rfs(struct bnge_net *bn)
+{
+	bn->netdev->hw_features &= ~NETIF_F_NTUPLE;
+	bn->netdev->features &= ~NETIF_F_NTUPLE;
+	bn->priv_flags &= ~BNGE_NET_EN_NTUPLE;
+	if (bnge_is_arfs_cap(bn->bd)) {
+		bn->netdev->hw_features |= NETIF_F_NTUPLE;
+		bn->netdev->features |= NETIF_F_NTUPLE;
+		bn->priv_flags |= BNGE_NET_EN_NTUPLE;
+	}
+}
+
 int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 {
 	struct net_device *netdev;
@@ -3339,6 +3403,8 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
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
index 69a894b52485..c7024e75f925 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -178,6 +178,16 @@ static int bnge_adjust_rings(struct bnge_dev *bd, u16 *rx,
 	return bnge_fix_rings_count(rx, tx, max_nq, sh);
 }
 
+static unsigned int bnge_get_max_func_rss_ctxs(struct bnge_dev *bd)
+{
+	return bd->hw_resc.max_rsscos_ctxs;
+}
+
+static unsigned int bnge_get_max_func_vnics(struct bnge_dev *bd)
+{
+	return bd->hw_resc.max_vnics;
+}
+
 int bnge_cal_nr_rss_ctxs(u16 rx_rings)
 {
 	if (!rx_rings)
@@ -190,11 +200,18 @@ int bnge_cal_nr_rss_ctxs(u16 rx_rings)
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
+	if (bnge_is_arfs_cap(bd))
+		return 2;
+
 	return 1;
 }
 
@@ -563,6 +580,44 @@ static int bnge_alloc_rss_indir_tbl(struct bnge_dev *bd)
 	return 0;
 }
 
+/* If runtime conditions support RFS */
+bool bnge_arfs_capable(struct bnge_dev *bd, bool new_rss_ctx)
+{
+	struct bnge_hw_rings hwr = {};
+	int max_vnics, max_rss_ctxs;
+
+	hwr.grp = bd->rx_nr_rings;
+	hwr.vnic = bnge_get_total_vnics(bd);
+
+	if (!bnge_is_arfs_cap(bd))
+		hwr.vnic++;
+
+	if (new_rss_ctx)
+		hwr.vnic++;
+	hwr.rss_ctx = bnge_get_total_rss_ctxs(bd, &hwr);
+	max_vnics = bnge_get_max_func_vnics(bd);
+	max_rss_ctxs = bnge_get_max_func_rss_ctxs(bd);
+
+	if (hwr.vnic > max_vnics || hwr.rss_ctx > max_rss_ctxs) {
+		if (bd->rx_nr_rings > 1)
+			dev_warn(bd->dev,
+				 "Not enough resources to support NTUPLE filters\n");
+		return false;
+	}
+
+	if (hwr.vnic <= bd->hw_resc.resv_vnics &&
+	    hwr.rss_ctx <= bd->hw_resc.resv_rsscos_ctxs)
+		return true;
+
+	bnge_hwrm_reserve_rings(bd, &hwr);
+	if (hwr.vnic <= bd->hw_resc.resv_vnics &&
+	    hwr.rss_ctx <= bd->hw_resc.resv_rsscos_ctxs)
+		return true;
+
+	dev_warn(bd->dev, "Unable to reserve resources to support NTUPLE filters\n");
+	return false;
+}
+
 int bnge_net_init_dflt_config(struct bnge_dev *bd)
 {
 	struct bnge_hw_resc *hw_resc;
@@ -576,6 +631,9 @@ int bnge_net_init_dflt_config(struct bnge_dev *bd)
 	if (rc)
 		goto err_free_tbl;
 
+	if (bnge_arfs_capable(bd, false))
+		bd->flags |= BNGE_EN_ARFS_CAP;
+
 	hw_resc = &bd->hw_resc;
 	bd->max_fltr = hw_resc->max_rx_em_flows + hw_resc->max_rx_wm_flows +
 		       BNGE_L2_FLTR_MAX_FLTR;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
index b62a634669f6..1e55fbe6985b 100644
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
index c81d3a64561e..4fa1c7570dc4 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
@@ -22,13 +22,15 @@ struct bnge_l2_filter;
 #define BNGE_MAX_UC_ADDRS	4
 
 enum {
-	BNGE_VNIC_DEFAULT	= 0
+	BNGE_VNIC_DEFAULT	= 0,
+	BNGE_VNIC_NTUPLE	= 1
 };
 
 enum {
 	BNGE_VNIC_RSS_FLAG	= BIT(0),
 	BNGE_VNIC_MCAST_FLAG	= BIT(1),
-	BNGE_VNIC_UCAST_FLAG	= BIT(2)
+	BNGE_VNIC_UCAST_FLAG	= BIT(2),
+	BNGE_VNIC_NTUPLE_FLAG	= BIT(3)
 };
 
 struct bnge_vnic_info {
@@ -60,4 +62,5 @@ int bnge_hwrm_vnic_rss_cfg(struct bnge_net *bn,
 			   struct bnge_vnic_info *vnic);
 int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic);
 void bnge_set_dflt_rss_indir_tbl(struct bnge_dev *bd);
+int bnge_alloc_rfs_vnic(struct bnge_net *bn);
 #endif /* _BNGE_VNIC_H_ */
-- 
2.52.0

