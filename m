Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6923914FE
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338898; cv=none; b=CQaq2tVFcY1dxyyEwiu4SHWJ+X2cRcSnpH3bOXy6pw+ELuKX5rqLgo3ITG4PKdwJ+38eofcnbhC+okpljx3Lp/PZGUMIFoI3zEAynXvvFvLogXTA1lJ7zM2Rn10RkB9/bldK/tbezgs114mp6VNbwv0gYVozvJNAyRzIaqMXrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338898; c=relaxed/simple;
	bh=PrT8fq7naefqjb6fdbq8o0qBSnFWexf6gOAB0zyRP5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGzX/L2FzGpMPPRH/FDSVy2dgoO+VgPAlchERSq1BauaiR1ugTcmO6wX4DSLBOSw7GBYOL6pmO6TyyKDSfuh7rM4AH3c3qoP5/r/AmQwDEkjgM4VQHKvHiBSclehkla0+uXPdW67XF5ZbkAIMgb2e51pZLmvCx72RO7ijD7jmRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hhU2qMxm; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hhU2qMxm"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1457843a91.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786338895; x=1786943695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r26AwQXDWSoG/c8V5pguslMFwIm88PJKuqjXsAY3nTg=;
        b=eZTlXLXy4xvlVKbi/aunC7eWKIYA8lVbHBGWJynWrB8Ni+D8I+CJs+hMuMrR8lxlzB
         IaQmlqn+rIL11YclPmwK7B1aHoPAvjjJzXJe6+EXrqCzWgJnCsYZ7U0ram/lJ571MS4I
         r/bN6E2gRP0XU4RXTXB+UR2pVimYwFeNARTu7Wy2J2YS9wJFW3Zh8Lx8stWSCDBs6SRF
         IsxpJ6O2XQIyg5dbgCN+3AKDB6rL9PR/ncmFeEDwxtV1W1fobTZ3q4NeR3jqs4yl6mOh
         fE1HY5bD/8Cht3iAO/Sk0Q6zhoc3lZGyJ0YP8WgQH9NX7ti4wKWgq4h4bZdE4MLo+EYs
         Z1cA==
X-Gm-Message-State: AOJu0YzZOW3M5K/swWAnnQ5p9fdU4f6VwIk+5HpLkPEr1ngIlZucmQPc
	AzzNtvRve0mC21A6BCIS+D9LlAtmakir1v02wbaXyygUbXSap7CeqNIyE2FiLNTVIhbZDI8Wzh+
	KgiVYS1FvNW/ugbsqMMRsji+qh31QnfyuKKw9im0bfkbcPzdmvdH4fuLZn03G4uQx+IW35o0k6r
	ACBOTxvT7zASymqMweDuxWO4ojnMl3c8lpG3i7eWXYqMuQ0xFgyNZGr5N6/caFdQsB0Op7rjkUu
	0Hsis/3+WI=
X-Gm-Gg: AR+sD10ZKkLulCdEnMtFVhZ0gjxO7wSPk3Lx6DuWE/+sQr2s+liAj9D7UhOSdcT4lkU
	v8A5z0xCoXN77HQDZvJkLLgN+Ao/TteJ/EU02DDiuLaWFSrL8r/oJ4xFsOLNUYD8TDjHd5JMu/I
	gzogCucqYS2LzUSZmLfBG7G2kLChhDtYluttuwKGsW/Be3L8tt1UdrWcnEkh2NrVYTJECOSGCQR
	OcHQBfX+2W5sFU1rW9LfJCuemc8eA+nJ9NNr/tdoh1exW0pgjscSn3rWTHqR0chnd1/ZgS9cFjB
	D+33z0nAznCNOGsBeMG7MGbIIlNpw5vDFtwPDnDD36PIazuaa7pon8w4zGJPI+oU4NzMS6qUYKG
	jyOpfqXlji2IoudLPZeRCOKu1IFWG+g3z3iPZmc2D1UM5Zg6cvzHF1bipX6VlK1ZpuDI2u2ci1V
	GHFLxRm4WQz69IHjaWqUxvF3RKFpytGwkcQZU=
X-Received: by 2002:a17:90b:3a81:b0:37f:f8c5:93c2 with SMTP id 98e67ed59e1d1-3903c634c04mr33630287a91.21.1786338895079;
        Sun, 09 Aug 2026 22:14:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3925fe8f3e3sm4854889a91.4.2026.08.09.22.14.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2026 22:14:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1eb52e1fso29638051cf.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786338894; x=1786943694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r26AwQXDWSoG/c8V5pguslMFwIm88PJKuqjXsAY3nTg=;
        b=hhU2qMxmhd+Qs8BcvuwuBZi4+FwsnZ1eqwhWT2N3W2LaKSMxvdF++GKeuAemCk6fev
         ex06DH+9oX0tuL+gKBq7K5ZWjPwr3i7wFSiIVeHbWxfd3YrRCvhAnrYihW+dQ5p+Qpui
         6TfNvuY9lvxXE7KeDpz+VHomPWVGmbrXcpmgg=
X-Received: by 2002:a05:622a:5c07:b0:51c:1a46:9148 with SMTP id d75a77b69052e-52ce61934eamr480557791cf.34.1786338893870;
        Sun, 09 Aug 2026 22:14:53 -0700 (PDT)
X-Received: by 2002:a05:622a:5c07:b0:51c:1a46:9148 with SMTP id d75a77b69052e-52ce61934eamr480557471cf.34.1786338893367;
        Sun, 09 Aug 2026 22:14:53 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165f2c76sm64862701cf.24.2026.08.09.22.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:14:52 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v6 06/15] bnxt_en: Allocate and free MPC channels from firmware
Date: Sun,  9 Aug 2026 22:13:49 -0700
Message-ID: <20260810051358.1244418-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810051358.1244418-1-michael.chan@broadcom.com>
References: <20260810051358.1244418-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Allocate and free the reserved MPC TX rings and completion rings from
firmware.  MPC backing store memory also needs to be configured in
order to successfully allocate the MPC TX rings.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 30 ++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  6 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 93 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 16 ++++
 4 files changed, 136 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d11676d97fed..1ec3a9a31113 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7489,8 +7489,7 @@ static int bnxt_hwrm_rx_agg_ring_alloc(struct bnxt *bp,
 	return 0;
 }
 
-static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
-				      struct bnxt_cp_ring_info *cpr)
+int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
 {
 	const u32 type = HWRM_RING_ALLOC_CMPL;
 	struct bnxt_napi *bnapi = cpr->bnapi;
@@ -7508,8 +7507,8 @@ static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
 	return 0;
 }
 
-static int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp,
-				   struct bnxt_tx_ring_info *txr, u32 tx_idx)
+int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    u32 tx_idx)
 {
 	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
 	const u32 type = HWRM_RING_ALLOC_TX;
@@ -7594,6 +7593,9 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 				goto err_out;
 		}
 	}
+
+	rc = bnxt_hwrm_mpc_ring_alloc(bp);
+
 err_out:
 	return rc;
 }
@@ -7651,9 +7653,8 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
 	return 0;
 }
 
-static void bnxt_hwrm_tx_ring_free(struct bnxt *bp,
-				   struct bnxt_tx_ring_info *txr,
-				   bool close_path)
+void bnxt_hwrm_tx_ring_free(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    bool close_path)
 {
 	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
 	u32 cmpl_ring_id;
@@ -7712,8 +7713,7 @@ static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
 	bp->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
 }
 
-static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,
-				   struct bnxt_cp_ring_info *cpr)
+void bnxt_hwrm_cp_ring_free(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
 {
 	struct bnxt_ring_struct *ring;
 
@@ -7747,6 +7747,8 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 	if (!bp->bnapi)
 		return;
 
+	bnxt_hwrm_mpc_ring_free(bp, close_path);
+
 	for (i = 0; i < bp->tx_nr_rings; i++)
 		bnxt_hwrm_tx_ring_free(bp, &bp->tx_ring[i], close_path);
 
@@ -9384,12 +9386,21 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
 
 static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
 {
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	struct bnxt_ctx_mem_type *ctxm;
 	u16 last_type = BNXT_CTX_INV;
 	int rc = 0;
 	u16 type;
 
+	if (mpc && mpc->mpc_chnls_cap) {
+		ctxm = &ctx->ctx_arr[BNXT_CTX_MTQM];
+		rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, ctxm->max_entries, 1);
+		if (rc)
+			return rc;
+		last_type = BNXT_CTX_MTQM;
+	}
+
 	for (type = BNXT_CTX_SRT; type <= BNXT_CTX_QPC; type++) {
 		ctxm = &ctx->ctx_arr[type];
 		if (!bnxt_bs_trace_avail(bp, type))
@@ -11392,6 +11403,7 @@ static int bnxt_init_nic(struct bnxt *bp, bool irq_re_init)
 	bnxt_init_cp_rings(bp);
 	bnxt_init_rx_rings(bp);
 	bnxt_init_tx_rings(bp);
+	bnxt_init_mpc_rings(bp);
 	bnxt_init_ring_grps(bp, irq_re_init);
 	bnxt_init_vnics(bp);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index bd6befe6d29d..e61e697e9085 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -3003,6 +3003,12 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 			 unsigned int start_rx_ring_idx,
 			 unsigned int nr_rings);
+int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
+int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    u32 tx_idx);
+void bnxt_hwrm_tx_ring_free(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    bool close_path);
+void bnxt_hwrm_cp_ring_free(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
 int bnxt_total_tx_rings(struct bnxt *bp);
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
 int bnxt_nq_rings_in_use(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index a595c9b36218..40351b7c0b82 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -325,3 +325,96 @@ void bnxt_free_mpc_rings(struct bnxt *bp)
 		}
 	}
 }
+
+void bnxt_init_mpc_rings(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i, j;
+
+	if (!mpc)
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		int num = mpc->mpc_ring_count[i];
+
+		for (j = 0; j < num; j++) {
+			struct bnxt_tx_ring_info *txr = &mpc->mpc_rings[i][j];
+			struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
+
+			txr->tx_prod = 0;
+			txr->tx_cons = 0;
+			txr->tx_hw_cons = 0;
+			WRITE_ONCE(txr->dev_state, 0);
+			ring->fw_ring_id = INVALID_HW_RING_ID;
+		}
+	}
+}
+
+static int bnxt_hwrm_one_mpc_ring_alloc(struct bnxt *bp,
+					struct bnxt_tx_ring_info *txr)
+{
+	struct bnxt_cp_ring_info *cpr = txr->tx_cpr;
+	struct bnxt_ring_struct *ring;
+	int rc;
+
+	ring = &cpr->cp_ring_struct;
+	if (ring->fw_ring_id == INVALID_HW_RING_ID) {
+		rc = bnxt_hwrm_cp_ring_alloc_p5(bp, cpr);
+		if (rc)
+			return rc;
+	}
+	/* tx_idx not used on P5_PLUS, so set it to 0 */
+	return bnxt_hwrm_tx_ring_alloc(bp, txr, 0);
+}
+
+int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i, j, rc = 0;
+
+	if (!mpc)
+		return 0;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		int num = mpc->mpc_ring_count[i];
+
+		for (j = 0; j < num; j++) {
+			struct bnxt_tx_ring_info *txr = &mpc->mpc_rings[i][j];
+
+			rc = bnxt_hwrm_one_mpc_ring_alloc(bp, txr);
+			if (rc)
+				goto mpc_ring_alloc_exit;
+		}
+	}
+mpc_ring_alloc_exit:
+	if (rc)
+		bnxt_hwrm_mpc_ring_free(bp, false);
+	return rc;
+}
+
+void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	struct bnxt_cp_ring_info *cpr;
+	int i, j;
+
+	if (!mpc)
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		for (j = 0; j < mpc->mpc_ring_count[i]; j++)
+			bnxt_hwrm_tx_ring_free(bp, &mpc->mpc_rings[i][j],
+					       close_path);
+	}
+	/* CP rings must be freed at the end to guarantee that the HWRM_DONE
+	 * responses for HWRM_RING_FREE can still be seen on the CP rings.
+	 */
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		for (j = 0; j < mpc->mpc_ring_count[i]; j++) {
+			cpr = mpc->mpc_rings[i][j].tx_cpr;
+			if (cpr && cpr->cp_ring_struct.fw_ring_id !=
+			    INVALID_HW_RING_ID)
+				bnxt_hwrm_cp_ring_free(bp, cpr);
+		}
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index 90aec8e0955a..3210ecf29c76 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -61,6 +61,9 @@ int bnxt_alloc_mpcs(struct bnxt *bp);
 void bnxt_free_mpcs(struct bnxt *bp);
 int bnxt_alloc_mpc_rings(struct bnxt *bp);
 void bnxt_free_mpc_rings(struct bnxt *bp);
+void bnxt_init_mpc_rings(struct bnxt *bp);
+int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp);
+void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -128,5 +131,18 @@ static inline int bnxt_alloc_mpc_rings(struct bnxt *bp)
 static inline void bnxt_free_mpc_rings(struct bnxt *bp)
 {
 }
+
+static inline void bnxt_init_mpc_rings(struct bnxt *bp)
+{
+}
+
+static inline int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp)
+{
+	return 0;
+}
+
+static inline void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
-- 
2.51.0

