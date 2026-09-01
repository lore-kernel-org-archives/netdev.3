Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE684A2053
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290307; cv=none; b=XXo2qtBa++Bhq9xmRQH/zNGgqtkfOf64Ycb/ijmjbQizLad9VJi8s6aOrRe2oEVSY7MpiUl2tR++gVkgN1o7AW7QyjIqtqzdzHCvVDepahTOt3UaRfpNiazKQhsS++L3Ll4nOa3j39xIXzUlQJwapoedxX9+qx0ODllxQ79Eygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290307; c=relaxed/simple;
	bh=CfM0eijYTe4EMwggRuAtJSxshQBNNr2dyu8Y/j11nu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeI6Bwx81g3//i7P1pgiXU1Kqmy8b+ootEZ16aD4+jyAAK5p+VgyRZ//xkQstGsl/cHPHWXVOtl24XRnh/ShHbUvR+57D4cABgFsFz8TwA/MD4q3dbkqUpJYnzY8p4XGX2d4SLBG9k8jRkvWdL8uTW1LG/J2URDb5oDRml4boRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a7xZAQtd; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a7xZAQtd"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-8557c3f270eso129721b3a.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290304; x=1788895104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Qt4ErnHA2TyAOzZ5lGY+0BQOly+HcEnFTD0zMWHD+M=;
        b=HI8SNYimzzprFZ5aM4PiO2160Xq5cmjkOhRm8azHK1r7390JKADPMpGwUgf6m0oHEk
         8aKBMLdKZVQ0R0BKiEkt8ByMs6EkeJp7E7PyN16jFRY+C3gANOwmEv1Op2aRgGgp7pWA
         iPt9jPX6tH3rmpBLZGDiDJcZl2qYCrtvYFRj8+ERBXXEZv2yWzLPrcpWzXH+tiIMqN7p
         XMHyDCq2x/UHUF/KAkVF28Dl4Yfni695n7wiI/uAWgskH9Gocma7lO/8CLARpqNamDnf
         MyhNkjP/hzuPXPahMIZvAOBjHdLZ2nX1fRw3QymgFDLp5U1qpar1WzwnuaIBbOWBmMbs
         4EYw==
X-Gm-Message-State: AFuF++mrG8zu1lMm17TtOFkisDazsJViqZ5qRyfTRdEWwD+fvEGXr9hn
	bujotJBv5w+sDNTvE7ZOq0R1n33nwIhIhHP4vRlPMvGlpdg3aaJQtV1sXEpV4ba09BTk1gFpome
	lr8Z5HcQlWfjeVUMP3Sp53QItByZKOsPbKQ9x6/PyO4H5u1iRbVNRME1DGRSLxPBC6FPjZLaPRQ
	C//q6eQBAs5ENhUl7Uuxvt2jvQiyqrfFVaYLi7D31S+XQupDaxtnTSckxCh6CdoEg995l/GgJxy
	udGcTAAQkR/YmPfgQ==
X-Gm-Gg: AR+sD12NXhPMmOQR2cCESyCKWlV0LCJFcSIyanTD4cpvZ3WN78wP4AGHNef8VEJaOay
	4SBBis0oLdQ5L54w1JDUj5lJbc5AapdxkJDggUmV/JUtEkQ8Hhqg62l8JIGaFDnyMw1Qfm6lvb1
	VRNiXIS9Y7kTCVgdko9Cm7hTwWHniQQ2arnnhb8ccyuXbyIKXrp8JoQ16reKBJomi09EYN+LD8x
	S0liZSDXdPpLapGggYV5g9lhlM3TWjr1aJ0uDbnx9x+ddhSSaUC4y2zj0+ydB7/aYyg20XQs1RN
	3Mvt9mip3OrktHGsJljCVcltZlDN9fIzr6ZIOLjS/vpHbQ7nATJr5zYKPcUbBK/26n1Pll5XhgG
	1q9wYnkOrPmHnQXTMKTq7Lkb9EnxLN7RfjA897cgpGs6Tulb1a8O5tsEVqf8uQwX1a8NXsgMrMV
	S8qkgcL8S/L/pFWRGnSqpjGXpZoHdwnnGGg7dLP79O4g==
X-Received: by 2002:a05:6a00:330b:b0:857:4dea:e2fe with SMTP id d2e1a72fcca58-85ed0a6e5demr163315b3a.13.1788290303802;
        Tue, 01 Sep 2026 12:18:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-85db5726aaesm190798b3a.5.2026.09.01.12.18.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2026 12:18:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso255230a91.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788290302; x=1788895102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Qt4ErnHA2TyAOzZ5lGY+0BQOly+HcEnFTD0zMWHD+M=;
        b=a7xZAQtdtrHAyZU8gVIHKW5VM2EVoTZ2boiQkjx4D5qM17r9aFAXdu5Q2XE5pQFV6N
         26L7CVKqeKUfekkLzyjtWqXOD9e3ogdAedho5K9Qx6XabzyYvhQ/NBhLVggu3+qsplmw
         0wkHk0ZM0Q6YLR1f5r+jJILiEnCzMoG6lbPYo=
X-Received: by 2002:a17:90a:dfd0:b0:398:9beb:5c19 with SMTP id 98e67ed59e1d1-39ae847b3f2mr408076a91.20.1788290301832;
        Tue, 01 Sep 2026 12:18:21 -0700 (PDT)
X-Received: by 2002:a17:90a:dfd0:b0:398:9beb:5c19 with SMTP id 98e67ed59e1d1-39ae847b3f2mr407974a91.20.1788290301253;
        Tue, 01 Sep 2026 12:18:21 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b79cf9sm186440eec.18.2026.09.01.12.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:18:20 -0700 (PDT)
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
Subject: [PATCH net-next 3/7] bnge: Move bnapi and ring_grp allocation to probe/remove
Date: Wed,  2 Sep 2026 00:47:24 +0530
Message-ID: <20260901191728.643212-4-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901191728.643212-1-bhargava.marreddy@broadcom.com>
References: <20260901191728.643212-1-bhargava.marreddy@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 108 ++++++++++++------
 2 files changed, 73 insertions(+), 37 deletions(-)

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
index 6c1cb3aab5a8..dcf04d391570 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1176,20 +1176,26 @@ static void bnge_free_ring_grps(struct bnge_net *bn)
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
-		bn->grp_info[i].fw_stats_ctx = INVALID_HW_RING_ID;
 		bn->grp_info[i].fw_grp_id = INVALID_HW_RING_ID;
 		bn->grp_info[i].rx_fw_ring_id = INVALID_HW_RING_ID;
 		bn->grp_info[i].agg_fw_ring_id = INVALID_HW_RING_ID;
 		bn->grp_info[i].nq_fw_ring_id = INVALID_HW_RING_ID;
+
+		if (irq_re_init)
+			bn->grp_info[i].fw_stats_ctx = INVALID_HW_RING_ID;
 	}
 
 	return 0;
@@ -1201,25 +1207,6 @@ static void bnge_free_bnapi_mem(struct bnge_net *bn)
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
@@ -1248,16 +1235,52 @@ static int bnge_alloc_bnapi_mem(struct bnge_net *bn)
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
@@ -1393,6 +1416,7 @@ static void bnge_init_nq_tree(struct bnge_net *bn)
 		struct bnge_nq_ring_info *nqr = &bn->bnapi[i]->nq_ring;
 		struct bnge_ring_struct *ring = &nqr->ring_struct;
 
+		nqr->nq_raw_cons = 0;
 		ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
 		for (j = 0; j < nqr->cp_ring_count; j++) {
 			struct bnge_cp_ring_info *cpr = &nqr->cp_ring_arr[j];
@@ -2834,9 +2858,7 @@ static int bnge_init_nic(struct bnge_net *bn)
 
 	bnge_init_tx_rings(bn);
 
-	rc = bnge_init_ring_grps(bn);
-	if (rc)
-		goto err_free_rx_ring_pair_bufs;
+	bnge_init_ring_grps(bn, false);
 
 	bnge_init_vnics(bn);
 
@@ -2847,7 +2869,6 @@ static int bnge_init_nic(struct bnge_net *bn)
 
 err_free_ring_grps:
 	bnge_free_ring_grps(bn);
-err_free_rx_ring_pair_bufs:
 	bnge_free_rx_ring_pair_bufs(bn);
 	return rc;
 }
@@ -3222,7 +3243,7 @@ static void bnge_get_queue_stats_rx(struct net_device *dev, int i,
 	struct bnge_nq_ring_info *nqr;
 	u64 *sw;
 
-	if (!bn->bnapi)
+	if (!netif_running(dev))
 		return;
 
 	nqr = &bn->bnapi[i]->nq_ring;
@@ -3544,14 +3565,27 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
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
@@ -3576,6 +3610,8 @@ void bnge_netdev_free(struct bnge_dev *bd)
 	destroy_workqueue(bn->bnge_pf_wq);
 
 	bnge_free_port_stats(bn);
+	bnge_free_ring_grps(bn);
+	bnge_free_bnapi_mem(bn);
 
 	free_netdev(netdev);
 	bd->netdev = NULL;
-- 
2.47.3

