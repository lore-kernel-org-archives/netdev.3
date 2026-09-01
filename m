Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3C4A2052
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290317; cv=none; b=lVM1D8hduKeKUiykxIgjmKvl7pKofjqx681R2bw0mJ7BeHx/HqzUERmVfccKj1X02g5rpuxnhXS6z620itJrRsRaBP/JhUD40mY5DB0p3GUnA/s9T4zOt7RBhTocEFsGrLVNZucxq/+tZx/ku5R/DMrsAZVPPfeJfENWPSnhZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290317; c=relaxed/simple;
	bh=vtAHAKj1PeAwfUJZCfBl4/eYH2oejA8SvnXfwzx3s3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VM2NDWFJ0upNv6qeccUrkrB6zuIQ6W6/LjtV4tDcUgmrLVEuWx02JYC9px945MFcwHQWIq8rYfKwuolkd7hQXsU3xqzIIPxyueZRp5mvNT2t1CDXDpda57Z02JKYqF+0fkhNOsmsxc5F4JuY32DeczTqRXymRAZbOyYVuMrSsZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IklVYuTt; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IklVYuTt"
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-7f432ac553fso78259a34.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290314; x=1788895114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BOaI+y6MhHla4FLXrbxJ4X/BF94hpA5tmvdB9YE3jGk=;
        b=gFnsXZxfb7d5frEYq+QKGytCxkB0iriER7o00bjEiOcKCHanwyW5kyUFqq/7AveJ54
         CW9VjCK6DDKenAG/dGDGppiFEwEM8nxiK0wFmUvAvvZ0rWwrM9HJbvBcibpS+QNNghhk
         VWZ/V/+HuBYMpzqOCP+oARNW+nK034g7XUO/L5UphKoXPmw6wgBCePktLZRPMHgU8G8J
         dgZmyPPZp3XpW1UMXaU7oRsudOb+jqGWhq7ei51p7pxRF/nqx4jxJoeH7OrvyhJW+FaI
         aAE/w8DyF0n7x1dsOMOOgXFVi9Axfz8y+MKDcBiXz6Ilc/c1C0cCUrcO0ran9EZGLPik
         Y5PQ==
X-Gm-Message-State: AFuF++m0+HxCk/vNziyMdqov3WCaKDIxkS0zmiUJ7h8faIHkYk58Bk9x
	6ww4jxnewNjlwfLP7WwckIi8Eh4ewfl6KzSrPVCb7Ocd8APszni4OJ0NSDrQr9UJh9c9XuSufAK
	IKLWzc+bQerlUM02PjOFfUapJKBH6DVQ7OM1B2zGmhkyh0OCSQvid01paK3V1nECWfP05eNp5sw
	AFcwA6XeP8L5aPLTRhwgYRujbsJTxtsMOfHGzwZiryoNy2pVvBxt2U77FdQgtDEFAWwyGWhQwXf
	zZVckZ/pWtlAsdmSg==
X-Gm-Gg: AR+sD10dOThcMKbMao9WRAo/7j/VSc5C7VSDy77PkCQn79RsSRU55DbpPxx1O8UdaYm
	l2dTfB1nuiNz7HG8cWiRj4cIpukn8lUW+GrjMoiAxb5eYP3UXKBXmrvKx4IgwQsQuozluOJI8ST
	gxFSTV3wrCFWyXM+2UomfEyF7oz9VSOaf6vI2KtlmrK1XKlQ7ArX+TvvaKSrOmD5olfF+JiJxPb
	rTGqhBrO+yf0NP1GfR9LRfzYfjvjt5OR1jMCZOPwf36P0cStMEsIwIPY8aY7cfAF6aUEGgFnyHs
	dSiiRLMIggSMpvN9YPtJ112AH02dvjuJb71zLvrcu+fTtu6750qNHx5c/OVHApOYODu+JEPPDhG
	Cq0a508YXxjbwgTyY0ZJduW3Bn4s4rfAhI8Ej8+g9SkP2MAjjNB+pRDTxHyDaiC/06RrAmqsw5d
	hOjkYp+0bG1prKOfJq3jbTa2ThCb71UaMuZVtNBHo+zQ==
X-Received: by 2002:a05:6820:a06:b0:6b1:51fa:3562 with SMTP id 006d021491bc7-6b372f3aec5mr10415099eaf.34.1788290313997;
        Tue, 01 Sep 2026 12:18:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6b40d50f928sm24758eaf.17.2026.09.01.12.18.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2026 12:18:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1b80835d5so274080a12.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788290312; x=1788895112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BOaI+y6MhHla4FLXrbxJ4X/BF94hpA5tmvdB9YE3jGk=;
        b=IklVYuTtTVGCU64ZPj8obgyQpdItEyYTNuLKFuCff6Xt7dbGmn5qRp0fGVMasNAqh1
         WSH0KqrKoOuTM7QrDpxCp2htqS2x09YzBnbhsBL+rLEdy5XKR3TPKT1ReCeqnU4MKAGT
         cQJSWMGSWvSJAYLwdFIgNOFvSGJVjEeVShya4=
X-Received: by 2002:a17:90b:52cc:b0:395:4de4:92be with SMTP id 98e67ed59e1d1-39907e0f90dmr15354901a91.13.1788290311977;
        Tue, 01 Sep 2026 12:18:31 -0700 (PDT)
X-Received: by 2002:a17:90b:52cc:b0:395:4de4:92be with SMTP id 98e67ed59e1d1-39907e0f90dmr15354829a91.13.1788290311499;
        Tue, 01 Sep 2026 12:18:31 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b79cf9sm186440eec.18.2026.09.01.12.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:18:30 -0700 (PDT)
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
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [PATCH net-next 5/7] bnge: Quiesce NQ0 around ring teardown in bnge_free_core()
Date: Wed,  2 Sep 2026 00:47:26 +0530
Message-ID: <20260901191728.643212-6-bhargava.marreddy@broadcom.com>
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

Add bnge_quiesce_nq0() and bnge_resume_nq0() helpers to temporarily disable
and re-enable NQ0 NAPI. Use these helpers to bracket ring teardown in
bnge_free_core() and ring rebuild in bnge_alloc_core().

Both helpers currently no-op, since no bnge_napi has BNGE_NAPI_FLAG_NQ0 set
yet. The next patch creates NQ0 during probe and sets this flag, at which
point these helpers become load-bearing: because NQ0 will remain active
while administratively down, its NAPI is not disabled by the standard close
paths, so temporarily quiescing it during core resource free/rebuild windows
is required to prevent stray completions from accessing uninitialized or
freed memory.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 70 ++++++++++++++-----
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  | 10 +++
 2 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index dc3d51f31e5e..10d54568f2c5 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -442,6 +442,25 @@ static void bnge_sp_task(struct work_struct *work)
 	netdev_unlock(bn->netdev);
 }
 
+static void bnge_db_nq_arm(struct bnge_net *bn,
+			   struct bnge_db_info *db, u32 idx)
+{
+	bnge_writeq(bn->bd, db->db_key64 | DBR_TYPE_NQ_ARM |
+		    DB_RING_IDX(db, idx), db->doorbell);
+}
+
+static void bnge_db_nq(struct bnge_net *bn, struct bnge_db_info *db, u32 idx)
+{
+	bnge_writeq(bn->bd, db->db_key64 | DBR_TYPE_NQ_MASK |
+		    DB_RING_IDX(db, idx), db->doorbell);
+}
+
+static void bnge_db_cq(struct bnge_net *bn, struct bnge_db_info *db, u32 idx)
+{
+	bnge_writeq(bn->bd, db->db_key64 | DBR_TYPE_CQ_ARMALL |
+		    DB_RING_IDX(db, idx), db->doorbell);
+}
+
 static void bnge_free_nq_desc_arr(struct bnge_nq_ring_info *nqr)
 {
 	struct bnge_ring_struct *ring = &nqr->ring_struct;
@@ -563,6 +582,34 @@ static void bnge_free_nq_tree(struct bnge_net *bn)
 	}
 }
 
+static void bnge_quiesce_nq0(struct bnge_net *bn)
+{
+	struct bnge_napi *bnapi = bn->bnapi[BNGE_NQ0_NAPI_IDX];
+	struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+	struct bnge_ring_struct *ring;
+	struct bnge_dev *bd = bn->bd;
+
+	if (!BNGE_NQ0_NAPI(bnapi))
+		return;
+
+	ring = &nqr->ring_struct;
+	bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
+	synchronize_irq(bd->irq_tbl[ring->map_idx].vector);
+	napi_disable_locked(&bnapi->napi);
+}
+
+static void bnge_resume_nq0(struct bnge_net *bn)
+{
+	struct bnge_napi *bnapi = bn->bnapi[BNGE_NQ0_NAPI_IDX];
+	struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+
+	if (!BNGE_NQ0_NAPI(bnapi))
+		return;
+
+	napi_enable_locked(&bnapi->napi);
+	bnge_db_nq_arm(bn, &nqr->nq_db, nqr->nq_raw_cons);
+}
+
 static int alloc_one_cp_ring(struct bnge_net *bn,
 			     struct bnge_cp_ring_info *cpr)
 {
@@ -1253,6 +1300,7 @@ static void bnge_clear_bnapi_queues(struct bnge_net *bn)
 static void bnge_free_core(struct bnge_net *bn)
 {
 	bnge_free_vnic_attributes(bn);
+	bnge_quiesce_nq0(bn);
 	bnge_free_tx_rings(bn);
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
@@ -1268,6 +1316,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bn->rx_ring = NULL;
 
 	bnge_clear_bnapi_queues(bn);
+	bnge_resume_nq0(bn);
 }
 
 static int bnge_alloc_core(struct bnge_net *bn)
@@ -1345,7 +1394,9 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	if (rc)
 		goto err_free_core;
 
+	bnge_quiesce_nq0(bn);
 	rc = bnge_alloc_nq_tree(bn);
+	bnge_resume_nq0(bn);
 	if (rc)
 		goto err_free_core;
 
@@ -1372,25 +1423,6 @@ u32 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr)
 	return txr->tx_cpr->ring_struct.fw_ring_id;
 }
 
-static void bnge_db_nq_arm(struct bnge_net *bn,
-			   struct bnge_db_info *db, u32 idx)
-{
-	bnge_writeq(bn->bd, db->db_key64 | DBR_TYPE_NQ_ARM |
-		    DB_RING_IDX(db, idx), db->doorbell);
-}
-
-static void bnge_db_nq(struct bnge_net *bn, struct bnge_db_info *db, u32 idx)
-{
-	bnge_writeq(bn->bd, db->db_key64 | DBR_TYPE_NQ_MASK |
-		    DB_RING_IDX(db, idx), db->doorbell);
-}
-
-static void bnge_db_cq(struct bnge_net *bn, struct bnge_db_info *db, u32 idx)
-{
-	bnge_writeq(bn->bd, db->db_key64 | DBR_TYPE_CQ_ARMALL |
-		    DB_RING_IDX(db, idx), db->doorbell);
-}
-
 static int bnge_cp_num_to_irq_num(struct bnge_net *bn, int n)
 {
 	struct bnge_napi *bnapi = bn->bnapi[n];
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 476b5bab96fe..4d84f109ad5f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -539,6 +539,14 @@ struct bnge_tx_ring_info {
 	struct bnge_ring_struct	tx_ring_struct;
 };
 
+#define BNGE_NQ0_NAPI_IDX	0
+
+enum bnge_napi_flag {
+	BNGE_NAPI_FLAG_NQ0,
+};
+
+#define BNGE_NQ0_NAPI(bnapi)	(test_bit(BNGE_NAPI_FLAG_NQ0, &(bnapi)->flags))
+
 struct bnge_napi {
 	struct napi_struct		napi;
 	struct bnge_net			*bn;
@@ -555,6 +563,8 @@ struct bnge_napi {
 #define BNGE_TX_CMP_EVENT		0x10
 	bool				in_reset;
 	bool				tx_fault;
+
+	unsigned long			flags;
 };
 
 #define INVALID_STATS_CTX_ID	-1
-- 
2.47.3

