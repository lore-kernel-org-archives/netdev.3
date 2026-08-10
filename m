Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4433932D4
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338905; cv=none; b=ouWQ9V6X7IhM0lFlGtbdzxAbmFnU10R8DUEpzW7/TlGHCd37d52Rl+kqlXZKukSHRZmIp4U7ZzD7XuxQpPY7n87CyAOil6Qr2d2KJM+o3N5DUEET6PyHApO4tj7bZx+25Cr1nYvMBu0k+L6msurJfBSpc0dLdOgYZBq6hq5ntA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338905; c=relaxed/simple;
	bh=6CqYirSvsPs6xXUBs7rzVORMNoLmQYewTILdePaeWqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZ5msurZFLzWS0Tde2Ucd5Xj7Ic+1BNG8RY5BWf/Q0NN4wqDVYp7LApTF6OtFxOt8quh1yIdzoMFxv6uHHX3PQPyj7THtkoZUZFwMpfBCrnqruQXaSFvJ0x6Qk7zmwvDBixX7UZOf0djn8neYuN4/x5b1IgATfjGiWqzKMMYLxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MLmrD2Ag; arc=none smtp.client-ip=209.85.217.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MLmrD2Ag"
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-74ae4c75b20so889669137.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786338902; x=1786943702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jtGGxAk5YQf/Xw0GshYoPIk60jLjN2kifGvmGq4ihBI=;
        b=Bhxmozkn+9vAUexy3jSIEV2v/P6eYicR0EEG3s5Xc3Fjdw8YuHCZZD2Yoe033c02w1
         m045UxHeVmvE42dqyZKkfo7nfvpzDVxahEEYGqdCds5pWbsRPGfI7ncNDSn6DaZAUjdT
         WaiVc8SoR5fUuL+hKcnmvMtrPe0245P3AEHx6laBeWC9O1D26HxDVCMJmbCXrDkwkvak
         n2+28YeNvboB2xkRYndBy/RTLvRA4Iw2gXIVyGwATtwFTh8vQL8WU4R4OTDm96qxoKfZ
         +AON13g2NOq/vKQy6Vfcz6kYneu15d3Q53hFPvS/tnCjSp7fIUHRzYezRBRArf4ld9RO
         zWpQ==
X-Gm-Message-State: AOJu0YxpViju0PGdYGpaFCz3Gip7Axp2MQ8+MhYe7gelJ4GZ8jKm2Wlc
	tm3fqjF1BQot5xF2KWffZVbDK8rFtO2YQFALBgAMUq07NZEMmG9wlXUANlGu8DQutTmPGjg6gWo
	BshyXL1FjR/UpedVz9p/Mkx97X/ldC1EGc4iR8MolaYYUVSNKheC7n3OZcS1M92Q9SdHFecchGq
	5+Hm12mF4LL2XoR5pjfI9O5a6ttBKkc74wtY4PeMeV6EO/uiqvdl8gOumrRdcy9eT1qn1YqBvg8
	XleYuNADC4=
X-Gm-Gg: AR+sD13UmICCi0skJG+qjwj0JOSEuOF9E+SjFXQmM2LEeSigEamskxATKITYfws08dF
	U+f0MWQgoknGeyKBroOypQK+/vep4P4pV7I2LPfapjMQOhMqEz/hkKM68GxuV/zvD/Evy9fmYU4
	ao937aELIq+tSqojt7QslGnYpWFUdP2QOLhUFLBSQufTlHcfE0ackhMoJdSj9iX0jmyuH3RH7Uf
	wTeiLTOOHU+1cdOlijcAgWikAYSEuIVZreI0fNTI8/s7QkuZGHQP7xuyl2RqTv9xJUOuT+Av9wn
	GIBrweRu6aiKunphXIWeTM6OLowA5H1HpZdMYyoHvRuez7qeiDUAYFnJIFb4LTxlNYXrP6OJwe3
	7aDvilaxKbg6repkgKHqZ84KoEZ7EPStabrJE3wW6YfnH4goGVke4XYjGJDZ6VLxMe5urPvCuFu
	DgrgMDvg38/UHkbfhTsestFZkkXtfczjv/sTg=
X-Received: by 2002:a05:6102:5248:b0:634:2450:7998 with SMTP id ada2fe7eead31-765207a412amr1459389137.4.1786338902234;
        Sun, 09 Aug 2026 22:15:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-76400cfedccsm74019137.16.2026.08.09.22.15.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2026 22:15:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5283fa0656dso49047671cf.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786338901; x=1786943701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jtGGxAk5YQf/Xw0GshYoPIk60jLjN2kifGvmGq4ihBI=;
        b=MLmrD2AgbOLJTreOvqSigM8WvR1k1xXzBna+QTvSO1oj1TCbQS4Ll4WYVqYxOpJh1W
         EgrwgdPiUo4y7L0tfB5bpIfC+UlUnJc/l9Eo6ORp6SanGdKp0mSKynAPnc23fR+XxRLB
         bkrdA1Jif+6WvLUpJNPTYIuHL86O932QLpEd0=
X-Received: by 2002:a05:622a:58e:b0:51b:feee:b08f with SMTP id d75a77b69052e-52d2364dee9mr139242391cf.1.1786338901477;
        Sun, 09 Aug 2026 22:15:01 -0700 (PDT)
X-Received: by 2002:a05:622a:58e:b0:51b:feee:b08f with SMTP id d75a77b69052e-52d2364dee9mr139242131cf.1.1786338900896;
        Sun, 09 Aug 2026 22:15:00 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165f2c76sm64862701cf.24.2026.08.09.22.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:15:00 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v6 10/15] bnxt_en: Add MPC transmit and completion functions
Date: Sun,  9 Aug 2026 22:13:53 -0700
Message-ID: <20260810051358.1244418-11-michael.chan@broadcom.com>
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

Add transmit, ring selection, and completion functions for midpath rings.
These will be used to send control data to the crypto engines.

All TCE/RCE completions are short (16-byte) completions.  The long
completions logic in bnxt_mpc_cmp() is added for completeness only.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v6:
Handle both long and short MPC completions.
Leave one empty slot in the MPC ring just like TX ring.
Use memory barrier when updating tx_cons for MPC ring.

v5:
https://lore.kernel.org/netdev/20260710042400.3996847-11-michael.chan@broadcom.com/

Add description in commit log that crypto engines use short completions
only.

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-11-michael.chan@broadcom.com/

Use WRITE_ONCE() for TX prod/cons.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-11-michael.chan@broadcom.com/

Fix unused variable warnings

v1:
https://lore.kernel.org/netdev/20260504235836.3019499-11-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   4 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 158 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h |  65 +++++++
 4 files changed, 230 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1529be7e12cf..7659041e652d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3115,6 +3115,10 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 				rx_pkts++;
 			else if (rc == -EBUSY)	/* partial completion */
 				break;
+		} else if (cmp_type == CMP_TYPE_MPC_CMP_SHORT ||
+			   cmp_type == CMP_TYPE_MPC_CMP_LONG) {
+			if (bnxt_mpc_cmp(bp, cpr, &raw_cons))
+				break;
 		} else if (unlikely(cmp_type == CMPL_BASE_TYPE_HWRM_DONE ||
 				    cmp_type == CMPL_BASE_TYPE_HWRM_FWD_REQ ||
 				    cmp_type == CMPL_BASE_TYPE_HWRM_ASYNC_EVENT)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index b7a055281687..46f3c304cd73 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -47,6 +47,7 @@ struct tx_bd {
 	__le32 tx_bd_len_flags_type;
 	#define TX_BD_TYPE					(0x3f << 0)
 	 #define TX_BD_TYPE_SHORT_TX_BD				 (0x00 << 0)
+	 #define TX_BD_TYPE_MPC_TX_BD				 (0x08 << 0)
 	 #define TX_BD_TYPE_LONG_TX_BD				 (0x10 << 0)
 	#define TX_BD_FLAGS_PACKET_END				(1 << 6)
 	#define TX_BD_FLAGS_NO_CMPL				(1 << 7)
@@ -160,6 +161,8 @@ struct tx_cmp {
 	 #define CMP_TYPE_RX_TPA_AGG_CMP			 22
 	 #define CMP_TYPE_RX_L2_V3_CMP				 23
 	 #define CMP_TYPE_RX_L2_TPA_START_V3_CMP		 25
+	 #define CMP_TYPE_MPC_CMP_SHORT				 30
+	 #define CMP_TYPE_MPC_CMP_LONG				 31
 	 #define CMP_TYPE_STATUS_CMP				 32
 	 #define CMP_TYPE_REMOTE_DRIVER_REQ			 34
 	 #define CMP_TYPE_REMOTE_DRIVER_RESP			 36
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index 40351b7c0b82..7af581c7391b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -418,3 +418,161 @@ void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path)
 		}
 	}
 }
+
+struct bnxt_tx_ring_info *bnxt_select_mpc_ring(struct bnxt *bp, int ring_type)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int n;
+
+	if (!mpc || ring_type >= BNXT_MPC_TYPE_MAX ||
+	    !mpc->mpc_ring_count[ring_type])
+		return NULL;
+
+	n = raw_smp_processor_id() % mpc->mpc_ring_count[ring_type];
+	return &mpc->mpc_rings[ring_type][n];
+}
+
+/**
+ * bnxt_start_xmit_mpc - Transmit message on an MPC ring
+ * @bp: pointer to bnxt device
+ * @txr: MPC TX ring structure pointer
+ * @data: MPC message pointer
+ * @len: MPC message length
+ * @handle: Non-zero handle passed back for the completion
+ *
+ * This function is called to transmit an MPC message on an MPC TX ring.
+ * The caller must hold txr->tx_lock.  When successful, the HW will return
+ * a completion and bnxt_crypto_mpc_cmp() will be called with the handle
+ * passed back.
+ *
+ * Return: zero on success, negative error code otherwise:
+ *	ENODEV: MPC TX ring is shutting down.
+ *	EBUSY: MPC TX ring is full
+ */
+int bnxt_start_xmit_mpc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			void *data, unsigned int len, unsigned long handle)
+{
+	u32 bds, total_bds, bd_space, free_size;
+	struct bnxt_sw_mpc_tx_bd *tx_buf;
+	struct tx_bd *txbd;
+	u16 prod;
+
+	if (READ_ONCE(txr->dev_state) == BNXT_DEV_STATE_CLOSING)
+		return -ENODEV;
+
+	bds = DIV_ROUND_UP(len, sizeof(*txbd));
+	total_bds = bds + 1;
+	free_size = bnxt_tx_avail(bp, txr);
+	if (free_size <= total_bds)
+		return -EBUSY;
+
+	prod = txr->tx_prod;
+	txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	tx_buf = &txr->tx_mpc_buf_ring[RING_TX(bp, prod)];
+	tx_buf->handle = handle;
+	tx_buf->inline_bds = total_bds;
+
+	txbd->tx_bd_len_flags_type =
+		cpu_to_le32((len << TX_BD_LEN_SHIFT) | TX_BD_TYPE_MPC_TX_BD |
+			    TX_BD_CNT(total_bds));
+	txbd->tx_bd_opaque = SET_TX_OPAQUE(bp, txr, prod, total_bds);
+
+	prod = NEXT_TX(prod);
+	txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	bd_space = TX_DESC_CNT - TX_IDX(prod);
+	if (bd_space < bds) {
+		unsigned int len0 = bd_space * sizeof(*txbd);
+
+		memcpy(txbd, data, len0);
+		prod += bd_space;
+		txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+		bds -= bd_space;
+		len -= len0;
+		data += len0;
+	}
+	memcpy(txbd, data, len);
+	prod += bds;
+	WRITE_ONCE(txr->tx_prod, prod);
+
+	/* Sync BD data before updating doorbell */
+	wmb();
+	bnxt_db_write(bp, &txr->tx_db, prod);
+
+	return 0;
+}
+
+static bool bnxt_mpc_unsolicit(struct mpc_cmp *mpcmp)
+{
+	u32 client = MPC_CMP_CLIENT_TYPE(mpcmp);
+
+	if (client != MPC_CMP_CLIENT_TCE && client != MPC_CMP_CLIENT_RCE)
+		return false;
+	return MPC_CMP_UNSOLICIT_SUBTYPE(mpcmp);
+}
+
+int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, u32 *raw_cons)
+{
+	struct bnxt_cmpl_entry cmpl_entry_arr[2];
+	struct bnxt_napi *bnapi = cpr->bnapi;
+	u16 cons = RING_CMP(*raw_cons);
+	struct mpc_cmp *mpcmp, *mpcmp1;
+	u32 tmp_raw_cons = *raw_cons;
+	u32 client, cmpl_num;
+	u8 type;
+
+	mpcmp = (struct mpc_cmp *)
+		&cpr->cp_desc_ring[CP_RING(cons)][CP_IDX(cons)];
+	type = MPC_CMP_CMP_TYPE(mpcmp);
+	cmpl_entry_arr[0].cmpl = mpcmp;
+	cmpl_entry_arr[0].len = sizeof(*mpcmp);
+	cmpl_num = 1;
+	if (type == MPC_CMP_TYPE_MID_PATH_LONG) {
+		tmp_raw_cons = NEXT_RAW_CMP(tmp_raw_cons);
+		cons = RING_CMP(tmp_raw_cons);
+		mpcmp1 = (struct mpc_cmp *)
+			 &cpr->cp_desc_ring[CP_RING(cons)][CP_IDX(cons)];
+
+		if (!MPC_CMP_VALID(bp, mpcmp1, tmp_raw_cons))
+			return -EBUSY;
+		/* The valid test of the entry must be done first before
+		 * reading any further.
+		 */
+		dma_rmb();
+		if (mpcmp1 == mpcmp + 1) {
+			cmpl_entry_arr[cmpl_num - 1].len += sizeof(*mpcmp1);
+		} else {
+			cmpl_entry_arr[cmpl_num].cmpl = mpcmp1;
+			cmpl_entry_arr[cmpl_num].len = sizeof(*mpcmp1);
+			cmpl_num++;
+		}
+	}
+	client = MPC_CMP_CLIENT_TYPE(mpcmp) >> MPC_CMP_CLIENT_SFT;
+	if (client >= BNXT_MPC_TYPE_MAX)
+		goto cmp_done;
+
+	if (!bnxt_mpc_unsolicit(mpcmp)) {
+		struct bnxt_sw_mpc_tx_bd *mpc_buf;
+		struct bnxt_tx_ring_info *txr;
+		u16 tx_cons;
+		u32 opaque;
+
+		opaque = mpcmp->mpc_cmp_opaque;
+		txr = bnapi->tx_mpc_ring[client];
+		tx_cons = txr->tx_cons;
+		if (TX_OPAQUE_RING(opaque) != txr->tx_napi_idx) {
+			netdev_warn(bp->dev, "Wrong opaque %x, expected ring %x, cons idx %x\n",
+				    opaque, txr->tx_napi_idx, txr->tx_cons);
+			goto cmp_done;
+		}
+		mpc_buf = &txr->tx_mpc_buf_ring[RING_TX(bp, tx_cons)];
+		mpc_buf->handle = 0;
+		tx_cons += mpc_buf->inline_bds;
+		/* Make sure handle is cleared before updating tx_cons */
+		smp_store_release(&txr->tx_cons, tx_cons);
+		txr->tx_hw_cons = RING_TX(bp, tx_cons);
+	}
+
+cmp_done:
+	*raw_cons = tmp_raw_cons;
+	return 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index 3210ecf29c76..91fb27ba8090 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -30,11 +30,53 @@ struct bnxt_mpc_info {
 };
 
 struct bnxt_sw_mpc_tx_bd {
+	u8 inline_bds;
 	unsigned long handle;
 };
 
 #define SW_MPC_TXBD_RING_SIZE (sizeof(struct bnxt_sw_mpc_tx_bd) * TX_DESC_CNT)
 
+struct bnxt_cmpl_entry {
+	void *cmpl;
+	u32 len;
+};
+
+struct mpc_cmp {
+	__le32 mpc_cmp_client_subtype_type;
+	#define MPC_CMP_TYPE					(0x3f << 0)
+	 #define MPC_CMP_TYPE_MID_PATH_SHORT			 0x1e
+	 #define MPC_CMP_TYPE_MID_PATH_LONG			 0x1f
+	#define MPC_CMP_SUBTYPE					0xf00
+	#define MPC_CMP_SUBTYPE_SFT				 8
+	 #define MPC_CMP_SUBTYPE_SOLICITED			 (0x0 << 8)
+	 #define MPC_CMP_SUBTYPE_ERR				 (0x1 << 8)
+	 #define MPC_CMP_SUBTYPE_RESYNC				 (0x2 << 8)
+	#define MPC_CMP_CLIENT					(0xf << 12)
+	 #define MPC_CMP_CLIENT_SFT				 12
+	 #define MPC_CMP_CLIENT_TCE				 (0x0 << 12)
+	 #define MPC_CMP_CLIENT_RCE				 (0x1 << 12)
+	 #define MPC_CMP_CLIENT_TE_CFA				 (0x2 << 12)
+	 #define MPC_CMP_CLIENT_RE_CFA				 (0x3 << 12)
+	u32 mpc_cmp_opaque;
+	__le32 mpc_cmp_v;
+	#define MPC_CMP_V					(1 << 0)
+	__le32 mpc_cmp_filler;
+};
+
+#define MPC_CMP_CMP_TYPE(mpcmp)						\
+	(le32_to_cpu((mpcmp)->mpc_cmp_client_subtype_type) & MPC_CMP_TYPE)
+
+#define MPC_CMP_CLIENT_TYPE(mpcmp)					\
+	(le32_to_cpu((mpcmp)->mpc_cmp_client_subtype_type) & MPC_CMP_CLIENT)
+
+#define MPC_CMP_UNSOLICIT_SUBTYPE(mpcmp)				\
+	((le32_to_cpu((mpcmp)->mpc_cmp_client_subtype_type) &		\
+	 MPC_CMP_SUBTYPE) != MPC_CMP_SUBTYPE_SOLICITED)
+
+#define MPC_CMP_VALID(bp, mpcmp, raw_cons)				\
+	(!!((mpcmp)->mpc_cmp_v & cpu_to_le32(MPC_CMP_V)) ==		\
+	 !((raw_cons) & (bp)->cp_bit))
+
 #define BNXT_MPC_CRYPTO_CAP    \
 	(FUNC_QCAPS_RESP_MPC_CHNLS_CAP_TCE | FUNC_QCAPS_RESP_MPC_CHNLS_CAP_RCE)
 
@@ -64,6 +106,10 @@ void bnxt_free_mpc_rings(struct bnxt *bp);
 void bnxt_init_mpc_rings(struct bnxt *bp);
 int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp);
 void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path);
+struct bnxt_tx_ring_info *bnxt_select_mpc_ring(struct bnxt *bp, int ring_type);
+int bnxt_start_xmit_mpc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			void *data, unsigned int len, unsigned long handle);
+int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, u32 *raw_cons);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -144,5 +190,24 @@ static inline int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp)
 static inline void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path)
 {
 }
+
+static inline struct bnxt_tx_ring_info *bnxt_select_mpc_ring(struct bnxt *bp,
+							     int ring_type)
+{
+	return NULL;
+}
+
+static inline int bnxt_start_xmit_mpc(struct bnxt *bp,
+				      struct bnxt_tx_ring_info *txr, void *data,
+				      unsigned int len, unsigned long handle)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
+			       u32 *raw_cons)
+{
+	return 0;
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
-- 
2.51.0

