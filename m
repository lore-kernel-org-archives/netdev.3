Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6565F4FB9D9
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859894; cv=none; b=asT6kgrJE6ucHmpyjKzf8fK788mKLIW48CNvhMsvfR2fcta09lp04owzGIiGPINLY3pUY48y8I2nJs61h59E0O/AMg38SZk7YChZJWjZytqVAfJ9AT0BJUqhaJ1N0x+c/+nnEcXb4WM/omV4GcusmmP5qF5ODVZ4q+KNgla/gT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859894; c=relaxed/simple;
	bh=tcb3w0ulKQuMLQCFawSuXpD+IJqFHdb+8LLf5Q5pMIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrWh47B0U2zPm3whQF0jNyq6a4mL0qhaEZGUqs69YdqzZsi/CMUry8JT+PVoRm4qxY+EhGNNbvtUwOACaXO1Q2NGxl7R2nvbAu9q8eNV+xtRm00pt0GjqQO2DES/ZiSsstRXA38SxlEtGGg1mwmV5A+QiffWYX/O+y3ZmV+Vyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cU07ybcY; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cU07ybcY"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-39b35105ba4so3889606a91.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859892; x=1789464692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6VaGdMakzP/0ZQCuDIXqsDvntfDGvnKxPvFPtNbvbaQ=;
        b=p36GrXEe5XobWSGZJElQM7hPVi3G6zokhF3FdHMDBb1Sgnp3oD+uHxaSQ6NHzmRRqv
         bw37rfggBAkjse9NB5Fi+dqdGb25f558zd+ZZCeVkHEzGhJkdlI226ZpJt95Pgw296QW
         3gRRS9zVpUk4QApE8WLx5jLgPOmnBJGpkJgwRrLErIDUsQ/qDXbyB/ylxh21YJxdweWe
         HoQnVIZa9NWeBhe+UrGnBlK0tyZWkBfCueB5+wt1mtEln2sQ9emOnTVKt/uMpB/a0Qdt
         HY8t6SZ87C8cBc8Z6MKzUMRfQFRvPQhwW75vcSWUX2FausVTCpGoKlfV4xPufm876CEn
         uynQ==
X-Gm-Message-State: AFuF++liyEKHSHRNCcOCgW1niSfelZpCiX2Tpr7gHaBZe1vZaRMzBe7K
	lSw+h0zZhlFp013UaBCxjmdc7sp1+iqZIeL8Bni/jUGYkDdBQ54xOwlA2iLqa6z0EbrXIZaaH2W
	hdIjp6KJA3ZmrJ4soDzco0szZBUi/DACvPRq4Ou5r14LKJbL7hyZRjgrRqC/XocKW3KWPw5yVnY
	pEpNsorMYMmPkS7WLaNsArHuwUOsRmHLSQH3ttpkraBIuHzou8qgsnhl5jqHI3cGsl29kqR1CFf
	lXC6QXKDQ==
X-Gm-Gg: AYBFou2qCh2iKzlBEllpP8LoCzUqLziE9GdhvznFeyMNhD3TEdlBanLTKYAaHln4B3b
	bRfbaRrZcjOB+/TTcL0iAKXLJbWxDszMSroXGOZPGDIL9xGssraKO1lhUKiM94ALy9eG63Sv5As
	lVa8mnDeyAIolHpGcLv6w8irirkQDxXP3jdkOhOGbuqP226afW76DUJvP4Pdvgz3HwsHbXvZKqj
	6xWp/OiuTLtq3K8FBmRFyFlEKEn7KY4+Ccdq04z/ua4FYCw4cqw9FrpPPDFX8/rGIMGa4YgoB58
	W9EERVIgTc7YYpp7LK+vgWrYRwEpFRnWpDpGHn+4q2la0nIwC8V5Puon86SkcdPe4BLkBjmv9gE
	hUadx9Kd1CrpcAAnb/BDexFFR/VVhnMj+Gl21A+JMKpHp73Zn0z17XGipLPs5gsJF2R+HRTZ8uU
	DGHMV7VNby7CzkVgnNfB1NyphRenbcgseFW5BP
X-Received: by 2002:a17:90b:5866:b0:398:e73e:5a13 with SMTP id 98e67ed59e1d1-39b2613272amr41373261a91.9.1788859891476;
        Tue, 08 Sep 2026 02:31:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39b15caea34sm9719293a91.2.2026.09.08.02.31.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 02:31:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so6916953a91.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788859889; x=1789464689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6VaGdMakzP/0ZQCuDIXqsDvntfDGvnKxPvFPtNbvbaQ=;
        b=cU07ybcYcaQBnidpxNKcmSCGFLp2pDrQ1suIXeexUOoZStv235b0JgrSaH6NWKvamd
         cKwSng3LE8NKfIURuOrkOSf7z+8I2ub3i0htahiIcaSLLLh2yuPk/apjaEH6KmD7WNo7
         wRVVAOj1hH5JpjXblNHm8SiXBpogJe11HZ8zE=
X-Received: by 2002:a17:90b:4ad1:b0:396:635a:9b10 with SMTP id 98e67ed59e1d1-39b2616ef8amr39472990a91.11.1788859889396;
        Tue, 08 Sep 2026 02:31:29 -0700 (PDT)
X-Received: by 2002:a17:90b:4ad1:b0:396:635a:9b10 with SMTP id 98e67ed59e1d1-39b2616ef8amr39472957a91.11.1788859888879;
        Tue, 08 Sep 2026 02:31:28 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ca63b3sm31493316a91.11.2026.09.08.02.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:31:28 -0700 (PDT)
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
Subject: [net-next, v2 03/11] bnge: add NTUPLE/ARFS VNIC
Date: Tue,  8 Sep 2026 15:00:45 +0530
Message-ID: <20260908093053.2596020-4-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260908093053.2596020-1-vikas.gupta@broadcom.com>
References: <20260908093053.2596020-1-vikas.gupta@broadcom.com>
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
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  6 ++
 .../net/ethernet/broadcom/bnge/bnge_core.c    |  7 ++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 27 ++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |  1 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 65 +++++++++++++++--
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  1 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    | 69 ++++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |  1 +
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    | 29 +++++++-
 .../net/ethernet/broadcom/bnge/bnge_vnic.h    |  7 +-
 10 files changed, 204 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index bde54ba5d50f..d43c67232a86 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -74,6 +74,7 @@ enum {
 	BNGE_EN_STRIP_VLAN				= BIT_ULL(2),
 	BNGE_EN_SHARED_CHNL				= BIT_ULL(3),
 	BNGE_EN_UDP_GSO_SUPP				= BIT_ULL(4),
+	BNGE_EN_ARFS_CAP				= BIT_ULL(5),
 };
 
 #define BNGE_EN_ROCE		(BNGE_EN_ROCE_V1 | BNGE_EN_ROCE_V2)
@@ -218,6 +219,11 @@ static inline bool bnge_is_roce_en(struct bnge_dev *bd)
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
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 68b74eb2c3a2..90e61a53a77d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -93,6 +93,13 @@ static int bnge_func_qrcaps_qcfg(struct bnge_dev *bd)
 		return rc;
 	}
 
+	rc = bnge_hwrm_cfa_adv_flow_mgnt_qcaps(bd);
+	if (rc) {
+		dev_warn(bd->dev, "hwrm query adv flow mgnt failure rc: %d\n",
+			 rc);
+		return rc;
+	}
+
 	rc = bnge_hwrm_vnic_qcaps(bd);
 	if (rc) {
 		dev_err(bd->dev, "vnic caps failure rc: %d\n", rc);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 91d246c8dcf2..dd48c60aeef4 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -1636,3 +1636,30 @@ int bnge_hwrm_port_qstats(struct bnge_dev *bd, u8 flags)
 
 	return bnge_hwrm_req_send(bd, req);
 }
+
+int bnge_hwrm_cfa_adv_flow_mgnt_qcaps(struct bnge_dev *bd)
+{
+	struct hwrm_cfa_adv_flow_mgnt_qcaps_output *resp;
+	struct hwrm_cfa_adv_flow_mgnt_qcaps_input *req;
+	u32 flags;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_CFA_ADV_FLOW_MGNT_QCAPS);
+	if (rc)
+		return rc;
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (rc)
+		goto err_hwrm_drop;
+
+	flags = le32_to_cpu(resp->flags);
+
+	if (flags &
+	    CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_NTUPLE_FLOW_RX_EXT_IP_PROTO_SUPPORTED)
+		bd->fw_cap |= BNGE_FW_CAP_CFA_NTUPLE_RX_EXT_IP_PROTO;
+
+err_hwrm_drop:
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index ae03041c36ac..2ae8ec9f33d3 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -67,4 +67,5 @@ int bnge_hwrm_shutdown_link(struct bnge_dev *bd);
 int bnge_hwrm_port_qstats(struct bnge_dev *bd, u8 flags);
 int bnge_hwrm_port_qstats_ext(struct bnge_dev *bd, u8 flags);
 int bnge_hwrm_func_qstat_ext(struct bnge_dev *bd, struct bnge_stats_mem *stats);
+int bnge_hwrm_cfa_adv_flow_mgnt_qcaps(struct bnge_dev *bd);
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 9e64b1933c02..cc4246b0539d 100644
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
@@ -2546,6 +2548,12 @@ static int bnge_init_chip(struct bnge_net *bn)
 	if (rc)
 		goto err_out;
 
+	if (bn->priv_flags & BNGE_NET_EN_NTUPLE) {
+		rc = bnge_alloc_rfs_vnic(bn);
+		if (rc)
+			goto err_out;
+	}
+
 	if (bd->rss_cap & BNGE_RSS_CAP_RSS_HASH_TYPE_DELTA)
 		bnge_hwrm_update_rss_hash_cfg(bn);
 
@@ -3019,6 +3027,8 @@ static int bnge_close(struct net_device *dev)
 	bnge_hwrm_if_change(bn->bd, false);
 	bn->sp_event = 0;
 
+	netdev_update_features(dev);
+
 	return 0;
 }
 
@@ -3101,6 +3111,36 @@ static const struct netdev_stat_ops bnge_stat_ops = {
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
@@ -3108,6 +3148,8 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_set_rx_mode_async	= bnge_set_rx_mode,
 	.ndo_features_check	= bnge_features_check,
+	.ndo_fix_features	= bnge_fix_features,
+	.ndo_set_features	= bnge_set_features,
 };
 
 static void bnge_init_mac_addr(struct bnge_dev *bd)
@@ -3233,6 +3275,17 @@ static void bnge_init_ring_params(struct bnge_net *bn)
 	bn->netdev->cfg->hds_thresh = max(BNGE_DEFAULT_RX_COPYBREAK, rx_size);
 }
 
+static void bnge_set_dflt_rfs(struct bnge_net *bn)
+{
+	bn->netdev->hw_features |= NETIF_F_NTUPLE;
+	bn->netdev->features &= ~NETIF_F_NTUPLE;
+	bn->priv_flags &= ~BNGE_NET_EN_NTUPLE;
+	if (bnge_is_arfs_cap(bn->bd)) {
+		bn->priv_flags |= BNGE_NET_EN_NTUPLE;
+		bn->netdev->features |= NETIF_F_NTUPLE;
+	}
+}
+
 int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 {
 	struct net_device *netdev;
@@ -3339,6 +3392,8 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
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
index 69a894b52485..19d7f1e2b74b 100644
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
@@ -190,11 +200,24 @@ int bnge_cal_nr_rss_ctxs(u16 rx_rings)
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
+	if (bd->netdev) {
+		struct bnge_net *bn = netdev_priv(bd->netdev);
+
+		if (bn->priv_flags & BNGE_NET_EN_NTUPLE)
+			return 2;
+	} else if (bnge_is_arfs_cap(bd)) {
+		return 2;
+	}
+
 	return 1;
 }
 
@@ -563,6 +586,47 @@ static int bnge_alloc_rss_indir_tbl(struct bnge_dev *bd)
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
+	/* Do not reduce VNIC and RSS ctx reservations. There is a FW
+	 * issue that will mess up the default VNIC if we reduce the
+	 * reservations.
+	 */
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
+	hwr.vnic = 1;
+	hwr.rss_ctx = 0;
+	bnge_hwrm_reserve_rings(bd, &hwr);
+	return false;
+}
+
 int bnge_net_init_dflt_config(struct bnge_dev *bd)
 {
 	struct bnge_hw_resc *hw_resc;
@@ -576,6 +640,9 @@ int bnge_net_init_dflt_config(struct bnge_dev *bd)
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
index 80b4ad77c659..c79eb403844a 100644
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
@@ -98,3 +102,26 @@ int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic)
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
index 30281e26f39f..93c6d736cbeb 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
@@ -21,13 +21,15 @@ struct bnge_l2_filter;
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
@@ -59,4 +61,5 @@ int bnge_hwrm_vnic_rss_cfg(struct bnge_net *bn,
 			   struct bnge_vnic_info *vnic);
 int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic);
 void bnge_set_dflt_rss_indir_tbl(struct bnge_dev *bd);
+int bnge_alloc_rfs_vnic(struct bnge_net *bn);
 #endif /* _BNGE_VNIC_H_ */
-- 
2.47.1

