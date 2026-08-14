Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48211F9C0
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670105; cv=none; b=HHa0VTl311EYcJm53NVNwxvwx1HHvB0JyegLT62SdDezIEnrXpEa7zQabZl7KYr8YyJPnMMS0plIIM8WNFAD1QSXEAZE/wuxl9s3OhNdaE7XDXkwEKYd6MrMsRItwZaUE+UOnPqxjnhjOJGAu7dBmWDRqW0KFo2oNY1oQY3wqBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670105; c=relaxed/simple;
	bh=RBLGBFB6+4G1i0qi2xiHSwE7CrWH13S/tc2rM/HpGOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8pURngrRuwNWM8A6zpL0EZK8kMSC8mVOf1LqWLOVkWt2251ofLKWmh43gLm8BnGuVeNAyr0hkSIuKmDRxOQAAU6u6T0V+i6GTnrVh3ZgiZONoCpYLbKXLcbnInCP5RfgePfP2KVbibC7n0U+hSBJ94bI8KhXXO3R1w+QitLrPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NtMoc018; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NtMoc018"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2cc61541f8cso21209005ad.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786670102; x=1787274902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5NjbmqOPRpWPD16V32nJXEiV7iFNk7FKYecQcVZ6UV8=;
        b=Sr9SNWOUeMRfev9lLeNjMGTaTXXJha2E96aQHPapWWNwkSaa7mlQl/dIw0weFlDwHL
         2S/xsUXEr43yqKO3Q1WjAx99ErgWSwVM6Ybm7El1m6egSJJDFUr4UFNMWYAWgoG6yZfm
         ud7E2hX1w7xscGig39ogx1JSOW1cdP9Alq5Tv9nR5dnFJvv9LC9dlU7HIaeFRRS0/ABP
         fdcDGFkhhUNfjvHQA2OU8V1RJeEgdMjIjzpchH0jyuYRZBJ6wsXcq4S6gworxOFWarjP
         pdJWGCV9pLXGOHL8D0YawiyDoi29wkeB1XKIFIpWrJe6ogl8yXq2DUvuhpYDMbLWuO0+
         Q9eQ==
X-Gm-Message-State: AOJu0YxXnk8nnqV66hjkGCIdjmcOq7PK+elCz2bWH499nqvRS3wAgFol
	4eEM489eGM42K64yZBEP4vBLDEHLE1PgWT4eohJrku/qoeJPeyO5EoD/C38D14A52PZn+s7XBAw
	LgyFi+B2r7JpM66dBT7MKZALEi+53MbggUz0yZZfPeTNVW91aaTo310lgXZn/YlOtA+9XsGENzr
	AXU7ryNyA/sO+v9mNLOwqXM8slsZFyXuWE6V/dvG5924dXw/uRoOjzjUB+dEOM1c8wuAncOKJ4E
	ZxAgmRByw==
X-Gm-Gg: AR+sD13aRmqe1LxKpR1/RdJbpfzz8zpka2Yn1jxyf6spHhMF2dDsXYCgwFsMvR8qfs1
	WGvYWpvBpC1rl7Buz+F5kgzHenVHpF0dT0/xUd/CzPEGpqe0QEk4kuZpRBlIQy+HhTmhre00PkA
	S61VOuCWpE5EK8sBKk3rqY71RtvBnCfTafyGiLmupE3q5E0+k3ykAmU/Ge5dv3l1Zx8tbkuZ4uA
	PdP6aco9bEu0fDWSZ0OUznI09NtHZ5aCMwDqKR4MOYj/1OMLfAQ2WeeeGmjW6tsNExGsbmoXjA2
	6VP6XE0+mT+wB2vA9+0slfgD/6h2XoHm+UiRQ2h3bCl/+BdKMo4lewPXrBWS/oHEYVmhZhiq/BU
	EqEzrw3aYGhhY4koCMw4ukawAd4pU+dOjSRCWADNHS1rqrnWNN8VxqRNNYbEJdRwJVuPC9tIhJz
	loQwxYih8/R29J/ER2jj1U7bK/wM0g5cYHFA==
X-Received: by 2002:a17:90b:1b0c:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-3933aadb80cmr1421975a91.0.1786670102378;
        Thu, 13 Aug 2026 18:15:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-394eb77bcf7sm108373a91.13.2026.08.13.18.15.01
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2026 18:15:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f0fe57470so1671053a91.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786670100; x=1787274900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5NjbmqOPRpWPD16V32nJXEiV7iFNk7FKYecQcVZ6UV8=;
        b=NtMoc018QlF6ASUyW5O2dGeon+1/LswaOE8Byus6irbNnR37JOddoEokfvHG6HIKTl
         oKXz9DG5BFfSstx8o1F13IrTsvXVn8fXHIHpAJTeCTDpIc9mZZdYve6/iMQhoBsVGZRY
         e1Syph8ZI/jjtFpetz1Api21SMDIozRVJIb6U=
X-Received: by 2002:a17:90a:d005:b0:36d:b12b:f57d with SMTP id 98e67ed59e1d1-3931f581f38mr6189367a91.12.1786670100265;
        Thu, 13 Aug 2026 18:15:00 -0700 (PDT)
X-Received: by 2002:a17:90a:d005:b0:36d:b12b:f57d with SMTP id 98e67ed59e1d1-3931f581f38mr6189324a91.12.1786670099689;
        Thu, 13 Aug 2026 18:14:59 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebcb69fbbsm12174177eec.11.2026.08.13.18.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 18:14:59 -0700 (PDT)
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
Subject: [PATCH net-next 03/11] bnge: add NTUPLE/ARFS VNIC
Date: Fri, 14 Aug 2026 06:44:27 +0530
Message-ID: <20260814011435.194631-4-vikas.gupta@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 31 +++++++--
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  1 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    | 69 ++++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |  1 +
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    | 29 +++++++-
 .../net/ethernet/broadcom/bnge/bnge_vnic.h    |  7 +-
 10 files changed, 170 insertions(+), 9 deletions(-)

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
index 9e64b1933c02..0f5e46937828 100644
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
 
@@ -3233,6 +3241,17 @@ static void bnge_init_ring_params(struct bnge_net *bn)
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
@@ -3339,6 +3358,8 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
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
index 69a894b52485..e4090982099b 100644
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
@@ -572,6 +636,9 @@ int bnge_net_init_dflt_config(struct bnge_dev *bd)
 	if (rc)
 		return rc;
 
+	if (bnge_arfs_capable(bd, false))
+		bd->flags |= BNGE_EN_ARFS_CAP;
+
 	rc = bnge_net_init_dflt_rings(bd, true);
 	if (rc)
 		goto err_free_tbl;
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

