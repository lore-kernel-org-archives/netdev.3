Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB12F3632
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055060; cv=none; b=S0l0N7U7jAzkwfBIYAhEHCGRcjZ8bOwAmrkkGt78dCGzEdQZjnYML3d1ZbxreNvS4OSbf142k/6+svvandLKilXENDsIRD+SJOiZr+PgSzG4pePj0gN2VZdZWe2wAVhSFgOpsC0Vv8RiUnhbjRG3nwenwaKMq7MeQmp1K9fOGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055060; c=relaxed/simple;
	bh=R9W+C7rd8vsQ9s4brAJxxgTCT73+HardaBeiuIRGQm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0BseAT+esqBH3SnNbP8GKhomW0F1fe0R4VmMhckSu1fzNZEUC2GY8GcQtInJhxkQhptlT9USyAKUzkGI8wQswUvX24kzm6iu7W8RGysCxB9oYVeoktDOZBVsrw0TV6cNwAwWJxFKuq+wDsb8BPKKe0WQie1er1yk8UaICAeBdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UtEikXG5; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UtEikXG5"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3964e480f76so1954245a91.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790055055; x=1790659855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0VxH32e4VrZZVOWi9fyj9drLBeVlGptObkrNS0hqXwg=;
        b=u5NRsrFkHMww+aWIFVcvZZP+ztY8SkpL6PPxnsHqIGaAmheqvngkLedhYzgwCik8CL
         /Po4hPlZK63deTv0Qt6xo/u8NU+zCoWjIKEXrORq9Jc/B29BATjXpHSWXPCd5LBxF5oq
         G/7fFxaxY/sL4aEm7pEknFyhQnkJ9e8Soa2BzzGXgU61FxPNq6RwFKeL7fjBx65KTL8l
         wkg5hp3fb+pLYrND/KTEquemW8i9Q03+QL/cFZC0u1gEVF/zxCYa+V7hga3YgC6Zw2e6
         qLkRTRLw25WAV/ec6C/TiZbI0g9+ZHKmgMP6O1X7/UDkCAoz15eBpW0BPVkFF7cEABvJ
         jXIQ==
X-Gm-Message-State: AFuF++mkhGH6dPw44H9jce9slbDJ80UxHZ28jnxGzXZbqnUPSC+nxYVh
	5fQRRsmae1baPrgs8oBlEodtbvUcZnCY7NvJoovk62pp/8XsbpSOEjxGgjtfARunEM88cByojk8
	KWDIqsVrRTaVRFCpMqs7vbReOj0B0r/PR21/uzLdCiek5TqRBt1ZfzLNXKauP7XeHkM3uFlWtwv
	XdIWFE2Ss47gpbhwk2oWBaVLH3iqidlbICVQ6uzF5itCH73go11qunY2Wdr4FkOtg3LKKisZgFZ
	sG7+2igsLLJj6W3Kw==
X-Gm-Gg: AYBFou0fdC9wbahUAstSZQs/GtBj+j5OLAQ1Ux8NcVs53A03KtW8+aWLYC9CQblpOIh
	ienDx5RQtM2HnXLANHqWGP+BE/g2lx5M992M+dIgj1iHabaXoPcHj4iBPRkXf6cpw17wYdf8AFK
	b5j++zeWftKXko1ftKHyuRYkUXcAh+kpz2aua8n1kxvTS09cqpCs6y4e0hLWsaSIuMvF3JhdPN1
	j0ByievpBQsN5UPZHa9r2ZT4a8qr/aylY2ed5H+VEo6JLDX6J62ce3JRYMvfdIWgrLGoRwcAtwz
	7l0WXbwR8NAD47wejlRJcPJ7UXVJdlBnEibeGXYGSELfb3ECUGyUF46ZJBnqgjXe8hiGs6KuoFI
	VTbn3uhEMgaErh0n1o54egWQP609nMCXCj/xsxpSIUwxHzcrP9SW2SvMd5yUZZAWPInaXiMtN40
	XFAdVIecmCspjTB2S/MWtoKeGTFsbR33ADUkQKVdzv1w==
X-Received: by 2002:a17:90b:1fc3:b0:39e:2f57:67c7 with SMTP id 98e67ed59e1d1-3a07309b1bdmr56559a91.3.1790055055130;
        Mon, 21 Sep 2026 22:30:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a06e3dbe17sm453229a91.6.2026.09.21.22.30.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2026 22:30:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e3c10ac70so9298853a91.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790055053; x=1790659853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0VxH32e4VrZZVOWi9fyj9drLBeVlGptObkrNS0hqXwg=;
        b=UtEikXG5ek0YYc9/cxEWV9lbhNexgc2m7kF/eNGCRXmwuG6RtjTG657xU5WTKJu/jl
         x03BdQ0yFTdbn+xcbOnK8yeg//qVgjllzTh7ow2jqZbz2L6zuEMsank4bdAvzjiznfV9
         WkgywtqGTlNSQAV1uV3sVOuqyQu073THdIDkM=
X-Received: by 2002:a17:90b:4fd0:b0:3a0:2900:f584 with SMTP id 98e67ed59e1d1-3a07322128bmr45359a91.46.1790055053140;
        Mon, 21 Sep 2026 22:30:53 -0700 (PDT)
X-Received: by 2002:a17:90b:4fd0:b0:3a0:2900:f584 with SMTP id 98e67ed59e1d1-3a07322128bmr45337a91.46.1790055052677;
        Mon, 21 Sep 2026 22:30:52 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f29dc903sm2029025c88.3.2026.09.21.22.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:30:52 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>,
	Kiran Kella <kiran.kella@broadcom.com>
Subject: [PATCH net-next v2 3/6] bnge: Move bnapi and ring_grp allocation to probe/remove
Date: Tue, 22 Sep 2026 10:59:01 +0530
Message-ID: <20260922052904.59237-4-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922052904.59237-1-bhargava.marreddy@broadcom.com>
References: <20260922052904.59237-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Allocate bn->bnapi and bn->grp_info during probe and free them during
remove instead of reallocating on every open/close.

To support this shift:
- Pass an irq_re_init flag to bnge_init_ring_grps() so open can reset
  per-group state without reallocating bn->grp_info.
- Have bnge_free_core() clear rx_ring/tx_ring back-pointers via the new
  bnge_clear_bnapi_queues() rather than freeing bn->bnapi.
- Replace "!bn->bnapi" checks in bnge_get_queue_stats_rx() and
  bnge_get_ethtool_stats() with !netif_running(dev) checks to avoid
  reading sw_stats memory freed on close.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |   2 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 107 ++++++++++++------
 2 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index 2467e44de291..ad9956bc4408 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -346,7 +346,7 @@ static void bnge_get_ethtool_stats(struct net_device *dev,
 	u32 tpa_stats;
 	u32 i, j = 0;
 
-	if (!bn->bnapi) {
+	if (!netif_running(dev)) {
 		j += bnge_get_num_ring_stats(bd);
 		goto skip_ring_stats;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index dfd68b830ded..367109dad496 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1185,14 +1185,18 @@ static void bnge_free_ring_grps(struct bnge_net *bn)
 	bn->grp_info = NULL;
 }
 
-static int bnge_init_ring_grps(struct bnge_net *bn)
+static int bnge_init_ring_grps(struct bnge_net *bn, bool irq_re_init)
 {
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
-	bn->grp_info = kzalloc_objs(struct bnge_ring_grp_info, bd->nq_nr_rings);
-	if (!bn->grp_info)
-		return -ENOMEM;
+	if (irq_re_init) {
+		bn->grp_info = kzalloc_objs(struct bnge_ring_grp_info,
+					    bd->nq_nr_rings);
+		if (!bn->grp_info)
+			return -ENOMEM;
+	}
+
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		bn->grp_info[i].fw_stats_ctx = INVALID_HW_RING_ID;
 		bn->grp_info[i].fw_grp_id = INVALID_HW_RING_ID;
@@ -1210,25 +1214,6 @@ static void bnge_free_bnapi_mem(struct bnge_net *bn)
 	bn->bnapi = NULL;
 }
 
-static void bnge_free_core(struct bnge_net *bn)
-{
-	bnge_free_vnic_attributes(bn);
-	bnge_free_tx_rings(bn);
-	bnge_free_rx_rings(bn);
-	bnge_free_nq_tree(bn);
-	bnge_free_nq_arrays(bn);
-	bnge_free_ring_stats(bn);
-	bnge_free_ring_grps(bn);
-	bnge_free_vnics(bn);
-	kfree(bn->tx_ring_map);
-	bn->tx_ring_map = NULL;
-	kfree(bn->tx_ring);
-	bn->tx_ring = NULL;
-	kfree(bn->rx_ring);
-	bn->rx_ring = NULL;
-	bnge_free_bnapi_mem(bn);
-}
-
 static int bnge_alloc_bnapi_mem(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -1257,16 +1242,52 @@ static int bnge_alloc_bnapi_mem(struct bnge_net *bn)
 	return 0;
 }
 
-static int bnge_alloc_core(struct bnge_net *bn)
+static void bnge_clear_bnapi_queues(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
-	int i, j, rc;
+	int i;
 
-	rc = bnge_alloc_bnapi_mem(bn);
-	if (rc)
-		return rc;
+	if (!bn->bnapi)
+		return;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		int j;
+
+		if (!bnapi)
+			continue;
+
+		bnapi->rx_ring = NULL;
+		for (j = 0; j < BNGE_MAX_TXR_PER_NAPI; j++)
+			bnapi->tx_ring[j] = NULL;
+	}
+}
+
+static void bnge_free_core(struct bnge_net *bn)
+{
+	bnge_free_vnic_attributes(bn);
+	bnge_free_tx_rings(bn);
+	bnge_free_rx_rings(bn);
+	bnge_free_nq_tree(bn);
+	bnge_free_nq_arrays(bn);
+	bnge_free_ring_stats(bn);
+	bnge_free_vnics(bn);
+
+	kfree(bn->tx_ring_map);
+	bn->tx_ring_map = NULL;
+	kfree(bn->tx_ring);
+	bn->tx_ring = NULL;
+	kfree(bn->rx_ring);
+	bn->rx_ring = NULL;
+
+	bnge_clear_bnapi_queues(bn);
+}
+
+static int bnge_alloc_core(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j, rc = -ENOMEM;
 
-	rc = -ENOMEM;
 	bn->rx_ring = kzalloc_objs(struct bnge_rx_ring_info, bd->rx_nr_rings);
 	if (!bn->rx_ring)
 		goto err_free_core;
@@ -1402,6 +1423,7 @@ static void bnge_init_nq_tree(struct bnge_net *bn)
 		struct bnge_nq_ring_info *nqr = &bn->bnapi[i]->nq_ring;
 		struct bnge_ring_struct *ring = &nqr->ring_struct;
 
+		nqr->nq_raw_cons = 0;
 		ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
 		for (j = 0; j < nqr->cp_ring_count; j++) {
 			struct bnge_cp_ring_info *cpr = &nqr->cp_ring_arr[j];
@@ -2847,19 +2869,15 @@ static int bnge_init_nic(struct bnge_net *bn)
 
 	bnge_init_tx_rings(bn);
 
-	rc = bnge_init_ring_grps(bn);
-	if (rc)
-		goto err_free_rx_ring_pair_bufs;
+	bnge_init_ring_grps(bn, false);
 
 	bnge_init_vnics(bn);
 
 	rc = bnge_init_chip(bn);
 	if (rc)
-		goto err_free_ring_grps;
+		goto err_free_rx_ring_pair_bufs;
 	return rc;
 
-err_free_ring_grps:
-	bnge_free_ring_grps(bn);
 err_free_rx_ring_pair_bufs:
 	bnge_free_rx_ring_pair_bufs(bn);
 	return rc;
@@ -3235,7 +3253,7 @@ static void bnge_get_queue_stats_rx(struct net_device *dev, int i,
 	struct bnge_nq_ring_info *nqr;
 	u64 *sw;
 
-	if (!bn->bnapi)
+	if (!netif_running(dev))
 		return;
 
 	nqr = &bn->bnapi[i]->nq_ring;
@@ -3557,14 +3575,27 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	spin_lock_init(&bn->stats_lock);
 
 	netdev->request_ops_lock = true;
+
+	rc = bnge_alloc_bnapi_mem(bn);
+	if (rc)
+		goto err_free_port_stats;
+
+	rc = bnge_init_ring_grps(bn, true);
+	if (rc)
+		goto err_free_bnapi_mem;
+
 	rc = register_netdev(netdev);
 	if (rc) {
 		dev_err(bd->dev, "Register netdev failed rc: %d\n", rc);
-		goto err_free_port_stats;
+		goto err_free_ring_grps;
 	}
 
 	return 0;
 
+err_free_ring_grps:
+	bnge_free_ring_grps(bn);
+err_free_bnapi_mem:
+	bnge_free_bnapi_mem(bn);
 err_free_port_stats:
 	bnge_free_port_stats(bn);
 err_free_workq:
@@ -3589,6 +3620,8 @@ void bnge_netdev_free(struct bnge_dev *bd)
 	destroy_workqueue(bn->bnge_pf_wq);
 
 	bnge_free_port_stats(bn);
+	bnge_free_ring_grps(bn);
+	bnge_free_bnapi_mem(bn);
 
 	free_netdev(netdev);
 	bd->netdev = NULL;
-- 
2.47.3

