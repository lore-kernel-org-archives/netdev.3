Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CED3B71D4
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055053; cv=none; b=BZnKMeo8kffTlitqdxOhS/0EmkiNsfVh6uNFLiMLdPf0bjMVy6PUZ6K4S+EvL4LFuyQuL0mSmDBlMxnc6l4T2VXXkGpPZEHPvA8lcpyHLXVsZZDuxLJguNK5Awkx1/aZFgmTBLg8CLGyT9A1ZYs1419aC0E6uqrARA/SslZ2Vos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055053; c=relaxed/simple;
	bh=KYfDz4uPRl/aivTit7YIOz1bsaw8pDpD4HjGCtQ0P+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHAE5K96Q70YvqdQscSXDMcOffIr5UQD3Og4E0O+xVhrVGs4amK/h/edkeqmvHwrcqYiC/tHPZo9YEJQRTBMpCPlqUTR1z4FE8gPVutLRWXUWCx5kJ4TRXLPc54zigWnuymGhDPVNncrTeVIg0DplOVHOsLi2aKHGQi8JNc+Bvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ff07VFSo; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ff07VFSo"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-86b32af25f6so1308434b3a.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790055049; x=1790659849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xP65CtudS7JRVRE1w/xpvlIe7/T3zxfhNqXK5442s84=;
        b=CKUnSkMtrJdImBLhbLs4IBRsijH0e6nBrbYgnP2Fb+I1j2bgUUerlXM/er8dqQz+Tr
         jnW3hERoaHYG7FTWN0K9mSE0qCqTM3jVcAQxFZlJU/CtuP/ljc4QnjUPHO5Y9C7d8EyI
         2f5nj94ET3sMRDjjaKrMi3ASCKrLvvXUZ3a+md0+nCevBdO7SlDLVf6EdJJiAol/ejBq
         +q5HWvknIFPfNY8mUsOUYwKPvDG1di/9wnlKJNyJt2FMgm5L6hFO5QoEMpB8XVreynYu
         ZAD+/KcojfAoG/GiyV57eH8y/mg87+GS96F6L+jzEzjAhIZf+H8DbZndtcOEooBsSZFQ
         ZkxQ==
X-Gm-Message-State: AFuF++lp3Stn3xkH+yv5ayFONwAOTN+5KgK94KbTG675FHuZusg4kR6U
	bkZIcoMsbgvIbuz4/vk8uBzSElhPf4MqGWO2tB57+bLr7wgT+qV4lRNnC2r2o4Y+NHP/R1hUe3a
	mGwRLzwVydwPVi8GbEWMNek82ygiQ1VLXriC8a5T9qAVQnR2lS3HBqohCqccnyq6HoG1yRmNqPS
	pvISdiCwY2u+0q8JkMqtD4XyxaibXAw0JSX0VoOC7mEbtbGrpt/nPNTVvNygb4+AMCvXCqK28Mq
	Au3b0jCWiLGDxCVFw==
X-Gm-Gg: AYBFou1bTjcCD+NF62vvrBKN1pofHhasNGGqzOQ1aunzCo0BggUUdc0rWq/AchQTjDD
	qtay4O4rb2Vsg5GLCktgM72l3cxue1mzuhIEG8TzLkxZIwaK4YoY0ODvXEPf54jTfbl7p7do7bM
	6o5C2LspsE+dW3YM1h29/exmUEYidsixNOq6eW2JJzMdWe2RjEOrLAVXQXm5u0s6I4zvGuJSIIo
	cSCtjuy20KWPpHBDnDFAMh+lERw5Omf5SYhT48Et1rnRId+LZn9U6oi5XH1YTUF4d24jQnfbTV1
	FRCqc0S9lTfWSlJbUtRiYd1EzWI2DcOfwDCy7poJCUc+hloQdK9PDG+JR8hLuB39pS/q+ihd40x
	Q1Uw8SBHmBWJAVqKfZz5dDPX9FwkLoOdVqAabYJY+awb07lIHi0oCcYZvkgTCNJP3hSIhVPPZR9
	TXLvFZ7GY09u+uQDdJLR66DGi0S/rNP/7K0NWlWEu+bA==
X-Received: by 2002:a05:6a00:2e26:b0:878:1aee:fa43 with SMTP id d2e1a72fcca58-87c8433c04cmr40536b3a.33.1790055048729;
        Mon, 21 Sep 2026 22:30:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-87c322dec2csm353672b3a.8.2026.09.21.22.30.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2026 22:30:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc73ab90ae7so3137455a12.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790055047; x=1790659847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xP65CtudS7JRVRE1w/xpvlIe7/T3zxfhNqXK5442s84=;
        b=ff07VFSoXNfz4JVykkbYDL8N7w4mv7ATyhW+3x9Kd+O/npFxObgff+dXX3AZxbCEN0
         JSufW9A2IUBrXG6uOD/Q2fZjORZg5j/M77H52cGxk1F8FGZZgTt78YBBs4TiWfH65F8/
         MkFOY5qzszhiSQvXr28f2XOhFQeoN2kvsuji8=
X-Received: by 2002:a17:90b:390e:b0:39e:433:23b5 with SMTP id 98e67ed59e1d1-3a07314f59amr50514a91.5.1790055046778;
        Mon, 21 Sep 2026 22:30:46 -0700 (PDT)
X-Received: by 2002:a17:90b:390e:b0:39e:433:23b5 with SMTP id 98e67ed59e1d1-3a07314f59amr50480a91.5.1790055046261;
        Mon, 21 Sep 2026 22:30:46 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f29dc903sm2029025c88.3.2026.09.21.22.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:30:45 -0700 (PDT)
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
	Dharmender Garg <dharmender.garg@broadcom.com>,
	Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Subject: [PATCH net-next v2 2/6] bnge: Extract per-NQ ring allocation and init helpers
Date: Tue, 22 Sep 2026 10:59:00 +0530
Message-ID: <20260922052904.59237-3-bhargava.marreddy@broadcom.com>
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

Factor the per-NQ loop body in bnge_hwrm_ring_alloc() and
bnge_init_ring_struct() into standalone bnge_hwrm_nq_ring_alloc() and
bnge_init_nq_ring_struct() helpers.

This is a pure refactor with no functional changes, preparing NQ0 setup
to run independently during probe rather than through the open path loop.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 60 ++++++++++++-------
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    | 25 +++++---
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |  4 +-
 3 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index c1810a309888..dfd68b830ded 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1918,6 +1918,41 @@ static int bnge_hwrm_rx_ring_alloc(struct bnge_net *bn,
 	return 0;
 }
 
+static int bnge_hwrm_nq_ring_alloc(struct bnge_net *bn, int index)
+{
+	struct bnge_napi *bnapi = bn->bnapi[index];
+	struct bnge_nq_ring_info *nqr;
+	struct bnge_ring_struct *ring;
+	u32 type = HWRM_RING_ALLOC_NQ;
+	struct bnge_dev *bd = bn->bd;
+	unsigned int vector;
+	u32 map_idx;
+	int rc;
+
+	nqr = &bnapi->nq_ring;
+	ring = &nqr->ring_struct;
+	map_idx = ring->map_idx;
+	vector = bd->irq_tbl[map_idx].vector;
+
+	disable_irq_nosync(vector);
+	rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
+	if (rc) {
+		enable_irq(vector);
+		return rc;
+	}
+	bnge_set_db(bn, &nqr->nq_db, type, map_idx, ring->fw_ring_id);
+	bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
+	enable_irq(vector);
+	bn->grp_info[index].nq_fw_ring_id = (u16)ring->fw_ring_id;
+	if (!index) {
+		rc = bnge_hwrm_set_async_event_cr(bd, ring->fw_ring_id);
+		if (rc)
+			netdev_warn(bn->netdev, "Failed to set async event completion ring.\n");
+	}
+
+	return 0;
+}
+
 static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -1926,30 +1961,9 @@ static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
 
 	agg_rings = !!(bnge_is_agg_reqd(bd));
 	for (i = 0; i < bd->nq_nr_rings; i++) {
-		struct bnge_napi *bnapi = bn->bnapi[i];
-		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
-		struct bnge_ring_struct *ring = &nqr->ring_struct;
-		u32 type = HWRM_RING_ALLOC_NQ;
-		u32 map_idx = ring->map_idx;
-		unsigned int vector;
-
-		vector = bd->irq_tbl[map_idx].vector;
-		disable_irq_nosync(vector);
-		rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
-		if (rc) {
-			enable_irq(vector);
+		rc = bnge_hwrm_nq_ring_alloc(bn, i);
+		if (rc)
 			goto err_out;
-		}
-		bnge_set_db(bn, &nqr->nq_db, type, map_idx, ring->fw_ring_id);
-		bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
-		enable_irq(vector);
-		bn->grp_info[i].nq_fw_ring_id = (u16)ring->fw_ring_id;
-
-		if (!i) {
-			rc = bnge_hwrm_set_async_event_cr(bd, ring->fw_ring_id);
-			if (rc)
-				netdev_warn(bn->netdev, "Failed to set async event completion ring.\n");
-		}
 	}
 
 	for (i = 0; i < bd->tx_nr_rings; i++) {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
index b066ee887a09..e0ddb2800c54 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -423,6 +423,21 @@ int bnge_alloc_ctx_mem(struct bnge_dev *bd)
 	return 0;
 }
 
+void bnge_init_nq_ring_struct(struct bnge_net *bn,
+			      struct bnge_nq_ring_info *nqr)
+{
+	struct bnge_ring_mem_info *rmem;
+	struct bnge_ring_struct *ring;
+
+	ring = &nqr->ring_struct;
+	rmem = &ring->ring_mem;
+	rmem->nr_pages = bn->cp_nr_pages;
+	rmem->page_size = HW_CMPD_RING_SIZE;
+	rmem->pg_arr = (void **)nqr->desc_ring;
+	rmem->dma_arr = nqr->desc_mapping;
+	rmem->vmem_size = 0;
+}
+
 void bnge_init_ring_struct(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -431,19 +446,11 @@ void bnge_init_ring_struct(struct bnge_net *bn)
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_ring_mem_info *rmem;
-		struct bnge_nq_ring_info *nqr;
 		struct bnge_rx_ring_info *rxr;
 		struct bnge_tx_ring_info *txr;
 		struct bnge_ring_struct *ring;
 
-		nqr = &bnapi->nq_ring;
-		ring = &nqr->ring_struct;
-		rmem = &ring->ring_mem;
-		rmem->nr_pages = bn->cp_nr_pages;
-		rmem->page_size = HW_CMPD_RING_SIZE;
-		rmem->pg_arr = (void **)nqr->desc_ring;
-		rmem->dma_arr = nqr->desc_mapping;
-		rmem->vmem_size = 0;
+		bnge_init_nq_ring_struct(bn, &bnapi->nq_ring);
 
 		rxr = bnapi->rx_ring;
 		if (!rxr)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
index bb0c79a1ee60..a5a1d346ac93 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
@@ -7,6 +7,7 @@
 struct bnge_ctx_mem_type;
 struct bnge_dev;
 struct bnge_net;
+struct bnge_nq_ring_info;
 
 #define PTU_PTE_VALID             0x1UL
 #define PTU_PTE_LAST              0x2UL
@@ -198,5 +199,6 @@ void bnge_free_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem);
 int bnge_alloc_ctx_mem(struct bnge_dev *bd);
 void bnge_free_ctx_mem(struct bnge_dev *bd);
 void bnge_init_ring_struct(struct bnge_net *bn);
-
+void bnge_init_nq_ring_struct(struct bnge_net *bn,
+			      struct bnge_nq_ring_info *nqr);
 #endif /* _BNGE_RMEM_H_ */
-- 
2.47.3

