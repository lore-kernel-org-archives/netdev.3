Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF848424E
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055071; cv=none; b=vCET7fb0H9Rarqpzu/sL38rTUke17PAp62NN+E4pgdHZWwedFLJCjhWj2ptjKG9t6RqpiyB+Wzo1XrMM32USTfPlstna/A2xc3ruCfbQdptYIrUUSFL/VDO8SN9j5VYBfXZOaQVHZEYQx8b8FCn+c8n2KZjAXP9klGfwfmNspaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055071; c=relaxed/simple;
	bh=iE2EQIj89CjFufdSkRfrh/KJHBUHWO1xT4ECC4lhkH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMaXh0FExDPazS5pFWdRJSc329SqUBdbMQb4uLfAnTeFEFn+6HRuluSQbDX/MMeMl7UdToUyK+J+CHVaWxnHgaT7Qw0oXXqw8DtGvbNpWNLdlimCcHxNSlNIvC9kwZK0ZUh81fUoI+dc8I0+8aO+6jD2Uz6/ew3zF4zFTd0JvGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FJ87rkqI; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FJ87rkqI"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2dd68a16955so6407255ad.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790055066; x=1790659866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yttZlC+kNKcKuY5rxX74d0x76Vc7HjUslVhaenkBtlA=;
        b=Vv+v+SoqYDiMhftKQ6OXOdFWHQFwYyb+l0gkPa4DlzWR/AsCRHuE2il6oZMGQHhTmb
         K0o+Ywc35g7nQajRaAt5wFfhYtRUBqubjxnDkNWGvVdQvrObtJ5n8Asimp+nXIYaV8r9
         xzxKvm4qesRHc4qDzAdSnm6uPTIEnRIEjjhE1Faa6ZQd13kWQnoSHYCRR6SgR7ge5tlc
         3hAgo1vH51KpZD8x3avM4hiiLArBXNVyrsuSSTpIjM75rtnD9KwB/+kN6lzEUFsVljB8
         zc+ODyMB7dFhbyZ94RKeR1rmQyn9qhMOtWP50QsElwaHhXR877VhOh+LjHx023ApNQgG
         FzoQ==
X-Gm-Message-State: AFuF++nYZ+ZtYzZR///yUmr98l7hbEzqfXrqY59dF3gx84tafpXPWs9S
	VCu/SHe3dlHQEnkJ/nzhl+bQV+4WrLUVOiaFc4pTtmC1UAQFMbmnFqtNfoG1GKGAnIDMY6mIMQh
	9hPb/JHMMky3OfTgSsq2RnuUGPFIGhZ3gHgFbsIDhACo5VMCIW8Hbn/L8y8DyvPB+Kh+M7n1JSO
	KwXLcUkrR9/S0jk+5JWyQuTgmBokyRras5M3k87omYyu4Pjd/0TRhu3xlIvQoX9AdDexGmXDG5b
	Cjm2hIRNSdhI/mG2g==
X-Gm-Gg: AYBFou3PIAI8SDAyXCob8O/t4hDF1tx56qKjEZMs1ApfnU1c3xe8U0cXbJ2dE8mC7Wo
	4yVzkJpQyL7cn8pcD7iRlpFR3/kPu9H7oiIKlZiFQXbDhwWscZctg1o23Vk2P1Y6QG0uHX2rPtd
	tObwyeKeGi1LEEuICTzT4w5PLXRPCL+DzbnxuAsU5cxTlGqBP2DIBkSPRbYsk0TP8e0Pfi0pgFj
	L0AigqIbT7UyMejJYO+19M9B6lpFAobOZDkbeCaty4HQN/zt7hWCtyBNH3AIicA1RefS4ezm4Ij
	RPplI39OHyLX4CYbdZ72vZ3sI/LKMAXN7RcpEdoPIzzDK7ewKtpVyNOfMjI0U6YbuDlY8UY/syB
	+js7oYPdksVEcccQ46VuijO7clwZhQ+og2rSizKhL3ZRTXD9WIPaGpJKkkXnxAaMEMbUu2VjY5Y
	IBT1Yhd6DxSnwWdoPQ36NrjwAY4HRTYc5B29k2aU237g==
X-Received: by 2002:a17:90b:4c07:b0:39e:6c68:fd8d with SMTP id 98e67ed59e1d1-3a073241fa9mr28991a91.34.1790055066351;
        Mon, 21 Sep 2026 22:31:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a06e5041d3sm456524a91.7.2026.09.21.22.31.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2026 22:31:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-398dc3d8f0fso579708a91.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790055065; x=1790659865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yttZlC+kNKcKuY5rxX74d0x76Vc7HjUslVhaenkBtlA=;
        b=FJ87rkqIUHRyGSqZLJhFqbNhQJ3etLGxIdT0vbADOFH3EkhJRrrZ0em2BKHFAhk8+7
         P9bGsLohKt0ug4y4fs+PP79Cvh7kQcmlvWLloBsGGw1RsSggLU5glhPUEckYOQE72Z2b
         mmGGW0zwLtUQwdJThPeIjxkXUF2FUUwL/xmr8=
X-Received: by 2002:a17:90b:48ce:b0:39e:4c97:ce09 with SMTP id 98e67ed59e1d1-3a07320accfmr39314a91.42.1790055064651;
        Mon, 21 Sep 2026 22:31:04 -0700 (PDT)
X-Received: by 2002:a17:90b:48ce:b0:39e:4c97:ce09 with SMTP id 98e67ed59e1d1-3a07320accfmr39288a91.42.1790055064112;
        Mon, 21 Sep 2026 22:31:04 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f29dc903sm2029025c88.3.2026.09.21.22.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:31:03 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/6] bnge: Quiesce NQ0 around ring teardown in bnge_free_core()
Date: Tue, 22 Sep 2026 10:59:03 +0530
Message-ID: <20260922052904.59237-6-bhargava.marreddy@broadcom.com>
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

Add bnge_quiesce_nq0() and bnge_resume_nq0() helpers to temporarily disable
and re-enable NQ0 NAPI. Use these helpers to bracket ring teardown in
bnge_free_core() and ring rebuild in bnge_alloc_core().

Both helpers currently no-op, since no bnge_napi has BNGE_NAPI_NQ0 set
yet. The next patch creates NQ0 during probe and sets this flag, at
which point these helpers become load-bearing: because NQ0 will remain
active while administratively down, its NAPI is not disabled by the
standard close paths, so temporarily quiescing it during core resource
free/rebuild windows is required to prevent stray completions from
accessing uninitialized or freed memory.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 76 ++++++++++++++-----
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  | 11 +++
 2 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 9e606fd1a580..1c12282d7e88 100644
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
@@ -563,6 +582,40 @@ static void bnge_free_nq_tree(struct bnge_net *bn)
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
+	if (test_and_set_bit(BNGE_NAPI_QUIESCED, &bnapi->flags))
+		return;
+
+	ring = &nqr->ring_struct;
+	napi_disable_locked(&bnapi->napi);
+	synchronize_irq(bd->irq_tbl[ring->map_idx].vector);
+	bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
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
+	if (!test_and_clear_bit(BNGE_NAPI_QUIESCED, &bnapi->flags))
+		return;
+
+	napi_enable_locked(&bnapi->napi);
+	bnge_db_nq_arm(bn, &nqr->nq_db, nqr->nq_raw_cons);
+}
+
 static int alloc_one_cp_ring(struct bnge_net *bn,
 			     struct bnge_cp_ring_info *cpr)
 {
@@ -1260,6 +1313,7 @@ static void bnge_clear_bnapi_queues(struct bnge_net *bn)
 static void bnge_free_core(struct bnge_net *bn)
 {
 	bnge_free_vnic_attributes(bn);
+	bnge_quiesce_nq0(bn);
 	bnge_free_tx_rings(bn);
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
@@ -1275,6 +1329,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bn->rx_ring = NULL;
 
 	bnge_clear_bnapi_queues(bn);
+	bnge_resume_nq0(bn);
 }
 
 static int bnge_alloc_core(struct bnge_net *bn)
@@ -1352,10 +1407,12 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	if (rc)
 		goto err_free_core;
 
+	bnge_quiesce_nq0(bn);
 	rc = bnge_alloc_nq_tree(bn);
 	if (rc)
 		goto err_free_core;
 
+	bnge_resume_nq0(bn);
 	bn->vnic_info[BNGE_VNIC_DEFAULT].flags |= BNGE_VNIC_RSS_FLAG |
 						  BNGE_VNIC_MCAST_FLAG |
 						  BNGE_VNIC_UCAST_FLAG;
@@ -1379,25 +1436,6 @@ u32 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr)
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
index 476b5bab96fe..d6e65fc7d038 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -539,6 +539,15 @@ struct bnge_tx_ring_info {
 	struct bnge_ring_struct	tx_ring_struct;
 };
 
+#define BNGE_NQ0_NAPI_IDX	0
+
+enum bnge_napi_flag {
+	BNGE_NAPI_NQ0,
+	BNGE_NAPI_QUIESCED,
+};
+
+#define BNGE_NQ0_NAPI(bnapi)	(test_bit(BNGE_NAPI_NQ0, &(bnapi)->flags))
+
 struct bnge_napi {
 	struct napi_struct		napi;
 	struct bnge_net			*bn;
@@ -555,6 +564,8 @@ struct bnge_napi {
 #define BNGE_TX_CMP_EVENT		0x10
 	bool				in_reset;
 	bool				tx_fault;
+
+	unsigned long			flags;
 };
 
 #define INVALID_STATS_CTX_ID	-1
-- 
2.47.3

