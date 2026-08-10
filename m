Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852DC39A04C
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338916; cv=none; b=T5C7uLZwbqPVLVIcMB4tCzmvVfZNErighcGKjioiASR+dT2Xc4iy2qNVatFiDksScSQZhYNVCvlfqw6H450Eflz2kL4HEBjW8IM0cg+koF70+9wu6hR7vRRBw31tnELpXn6DXbSAmMwS+/kZkcNCs6tkdvUfgZBNRW8isO+81DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338916; c=relaxed/simple;
	bh=wql89J2bW/s4vfRwSusRbIoSPxLWTFzweuHBnjp1qsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sU+IP24rehEAY4ssOCEqCc/atoLtijz5Ym4YgijdTjfUvLJc/4RXbSPLIgJv1/ZAItbK7JtMqxDfyv+fJ5s0GSVCwRuh4xG2vmfPjkd7alaDalYUviqmEAknTuMqd30zrqQ4p0ag/so7G6yYgCLQLtwdcqxb2VjwKecbL60p0gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ISAsIJZa; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ISAsIJZa"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso1171314a91.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786338914; x=1786943714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gnYGYYiHm+2xfIGBBLPf3vel7Vn93VOeH0kqlqDrAYA=;
        b=iuqsOl1xMK5LJ69zpfTxV58I6SqnsB70Vq4OuH3x8vep//HleadhrB9TxxSOUPBkRs
         dZ2Ly+h2EfYV7l6nqQWV3qNxVObbUn6yF0oHy3pPeYhOq0lSVuukxBMN6IHSji4o6OB1
         mRL1OGGdMyOHtx58IDMIeszr79j7PTwBiF18sxX9DDWEefOQiaqQw2yYcPtJNjDpuwt6
         QD2jC+FOrg4prC8IiLvVZq4hG1HrdV3MV1pd1/Uo9KpKGfcqGvKH5tW8OMiON1LUqvxU
         W3H4wpPf4fNle6K5Xs9uzyGwzUR2S/XuxJXNllscaEN+USbn1T005ZMmttsZBDEIuJZ5
         HgVA==
X-Gm-Message-State: AOJu0YysB19zebrUfKACWKgL9JWjEzrVdtmrYYGEEw5vcWCgjE73u9Zh
	01W1o9rJT24VRCZVd8e1+I+0eJBA1Y+GGnsei32S5nHu8Mpsteaea14ZDCHxY3+STrYVSKQ0PCk
	FUv17QdfwT5mXRBTT+gik2gmJQ3SYd1h/LI8z6YrLFu6myPsU3QWzorinDPbUBFJ7/qKxTG2GS2
	lmbTW4qaavARKJHaEppvLrXKwNeqJpfV7A+r76fRSK2e2GRQZgaj1Qv5daE8d/VTUbVOPeAM/KK
	99kf1iVJm4=
X-Gm-Gg: AR+sD13Br112B/OYn8vBvf/VAJyYTjhOcTK5WPohv8MkXzcsiaKOAMv+/QCZE5v9PP0
	7PqU+KfNPzFmLzffnxTw6JZzReUqqxopSOm/2XBgdqZWhj36A4pb6SkBX4h28wrgj815ZeTgrzs
	y9lkUMAnR/TLAJEvxXNjnEXsPmPlZ5ivMvCaE7I7YwYbpQr8CkF/K/uNQ5FSZ7WwiZG+jc2jTm4
	aCglMDARJXyCbOCEiP6bn7q4IEY6Lo6d1v8nIKVa5UXkUv8d83pAUi9PWxkbXJN1MXuLBsiXQir
	LRVBv6X4quJa4K/RIAn2XNV4khM60EkXdrfU/7l/s7+B66RXFF00/3R6kKUoOdbv+2j61xDNKal
	UM2YrF6lWMTY2xmlARY7+DMGDdI5bpbAmxf+6PUKSh5c2DjTHvuIELRf0jy04BPUKWN9kwJuvTV
	5TQCgHCiEzqucm47hDmAf7KGlaWA/aHKYO/GE=
X-Received: by 2002:a17:90b:4fcb:b0:386:ca4b:16a9 with SMTP id 98e67ed59e1d1-392846f2325mr6666672a91.16.1786338913727;
        Sun, 09 Aug 2026 22:15:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3925fec93a9sm4925567a91.5.2026.08.09.22.15.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2026 22:15:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5283fa0656dso49049661cf.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786338912; x=1786943712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gnYGYYiHm+2xfIGBBLPf3vel7Vn93VOeH0kqlqDrAYA=;
        b=ISAsIJZasE3qJQK9B8v5q+L8I1vGYeFWZpNL+DcCX9M3JhEld+uCIlYKw/sv9EzhP3
         oWcNt8sEYcFS2HbPBdXT5FVjJVfEG80kJDkTAAyDq/K93FWmeYDH64B/KOulvnP5E1Ki
         jxVxKZ3BnM+m+SwsYEOnmdsKLuMx1+mGPM4VQ=
X-Received: by 2002:a05:622a:5908:b0:516:7a83:8c37 with SMTP id d75a77b69052e-52d237a66edmr147832871cf.11.1786338912219;
        Sun, 09 Aug 2026 22:15:12 -0700 (PDT)
X-Received: by 2002:a05:622a:5908:b0:516:7a83:8c37 with SMTP id d75a77b69052e-52d237a66edmr147831951cf.11.1786338911308;
        Sun, 09 Aug 2026 22:15:11 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165f2c76sm64862701cf.24.2026.08.09.22.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:15:10 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v6 15/15] bnxt_en: Add kTLS retransmission support
Date: Sun,  9 Aug 2026 22:13:58 -0700
Message-ID: <20260810051358.1244418-16-michael.chan@broadcom.com>
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

If TCP retransmits a TLS packet that requires encryption by the NIC, the
TCP sequence number will go backwards and the hardware will require some
assistance from the driver.  The driver needs to retrieve the TLS record
that covers the byte sequence of the retransmitted packet.  If the
retransmitted packet does not include the tag, the hardware can simply
encrypt the packet using the informtaion in the TLS record.

The driver provides the TLS record information for the retransmitted
packet in the presync TX BD.  The presync TX BD introduced in the last
patch is treated very much like a TX push BD with inline data.  The only
exception is that no SKB will be stored for the presync TX BD.

Retransmission that includes the TLS tag will be handled in future
patches.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v5:
https://lore.kernel.org/netdev/20260710042400.3996847-16-michael.chan@broadcom.com/

Use bool instead of bit fields to keep track of kTLS states (requested by
Paolo).

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-16-michael.chan@broadcom.com/

Unwind the TX ring properly if the TLS packet cannot be sent.

Improve the OOO TLS counters.

Fix endianness of the record sequence number.

Check valid return address from skb_frag_address_safe().

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-16-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  14 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   4 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   4 +
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.c    | 152 +++++++++++++++++-
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.h    |   2 +
 5 files changed, 167 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 55f999dbe7ad..ac3fe35cf4e7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -482,9 +482,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	unsigned int length, pad = 0;
 	u32 len, free_size, vlan_tag_flags, cfa_action, flags;
 	struct bnxt_ktls_offload_ctx_tx *kctx_tx = NULL;
+	u16 prod, start_prod, last_frag, txts_prod;
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	struct pci_dev *pdev = bp->pdev;
-	u16 prod, last_frag, txts_prod;
 	struct bnxt_tx_ring_info *txr;
 	struct bnxt_sw_tx_bd *tx_buf;
 	__le32 lflags = 0;
@@ -500,7 +500,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	txq = netdev_get_tx_queue(dev, i);
 	txr = &bp->tx_ring[bp->tx_ring_map[i]];
-	prod = txr->tx_prod;
 
 #if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
 	if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS) {
@@ -529,12 +528,14 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 	}
 
+	start_prod = txr->tx_prod;
 	skb = bnxt_ktls_xmit(bp, txr, skb, &lflags, &kid, &kctx_tx);
 	if (unlikely(!skb)) {
 		dev_core_stats_tx_dropped_inc(dev);
 		goto tx_kick_pending;
 	}
 
+	prod = txr->tx_prod;
 	length = skb->len;
 	len = skb_headlen(skb);
 	last_frag = skb_shinfo(skb)->nr_frags;
@@ -817,9 +818,16 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			/* set SKB to err so PTP worker will clean up */
 			ptp->txts_req[txts_prod].tx_skb = ERR_PTR(-EIO);
 	}
+	txr->tx_buf_ring[RING_TX(bp, txr->tx_prod)].skb = NULL;
+	/* Unwind any kTLS presync BDs */
+	if (unlikely(txr->tx_prod != start_prod)) {
+		tx_buf = &txr->tx_buf_ring[RING_TX(bp, start_prod)];
+		tx_buf->is_push = 0;
+		tx_buf->inline_data_bds = 0;
+		WRITE_ONCE(txr->tx_prod, start_prod);
+	}
 	if (txr->kick_pending)
 		bnxt_txr_db_kick(bp, txr, txr->tx_prod);
-	txr->tx_buf_ring[RING_TX(bp, txr->tx_prod)].skb = NULL;
 	dev_core_stats_tx_dropped_inc(dev);
 	return NETDEV_TX_OK;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e500178d5f80..f2239eb67a6d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1193,6 +1193,10 @@ struct bnxt_cmn_sw_stats {
 enum bnxt_ktls_data_counters {
 	BNXT_KTLS_TX_PKTS = 0,
 	BNXT_KTLS_TX_BYTES,
+	BNXT_KTLS_TX_OOO_PKTS,
+	BNXT_KTLS_TX_OOO_FALLBACK_NO_SYNC,
+	BNXT_KTLS_TX_OOO_FALLBACK_NO_SPACE,
+	BNXT_KTLS_TX_OOO_FALLBACK_NO_HDR,
 
 	BNXT_KTLS_MAX_DATA_COUNTERS,
 };
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 66a35876c00b..cee743996d3f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -359,6 +359,10 @@ static const char *const bnxt_ring_drv_stats_arr[] = {
 static const char *const bnxt_ktls_data_stats[] = {
 	[BNXT_KTLS_TX_PKTS]		= "tx_tls_encrypted_packets",
 	[BNXT_KTLS_TX_BYTES]		= "tx_tls_encrypted_bytes",
+	[BNXT_KTLS_TX_OOO_PKTS]			= "tx_tls_ooo_packets",
+	[BNXT_KTLS_TX_OOO_FALLBACK_NO_SYNC]	= "tx_tls_ooo_fallback_no_sync",
+	[BNXT_KTLS_TX_OOO_FALLBACK_NO_SPACE]	= "tx_tls_ooo_fallback_no_space",
+	[BNXT_KTLS_TX_OOO_FALLBACK_NO_HDR]	= "tx_tls_ooo_fallback_no_hdr",
 };
 
 /* kTLS control plane counter strings indexed by enum bnxt_ktls_ctrl_counters */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
index c111b42e4cde..12111cdefc2b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
@@ -345,7 +345,8 @@ int bnxt_ktls_init(struct bnxt *bp)
 	return 0;
 }
 
-static void bnxt_ktls_inc_tx_stats(struct bnxt_tx_ring_info *txr, u32 bytes)
+static void bnxt_ktls_inc_tx_stats(struct bnxt_tx_ring_info *txr, u32 bytes,
+				   bool ooo)
 {
 	struct bnxt_tls_sw_stats *ring_stats = txr->tls_stats;
 
@@ -353,6 +354,128 @@ static void bnxt_ktls_inc_tx_stats(struct bnxt_tx_ring_info *txr, u32 bytes)
 		return;
 	ring_stats->counters[BNXT_KTLS_TX_PKTS]++;
 	ring_stats->counters[BNXT_KTLS_TX_BYTES] += bytes;
+	if (ooo)
+		ring_stats->counters[BNXT_KTLS_TX_OOO_PKTS]++;
+}
+
+static void bnxt_ktls_pre_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			       u32 kid, struct crypto_prefix_cmd *pre_cmd)
+{
+	struct bnxt_sw_tx_bd *tx_buf;
+	struct tx_bd_presync *psbd;
+	u32 bd_space, space;
+	u8 *pcmd;
+	u16 prod;
+
+	prod = txr->tx_prod;
+	tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
+
+	psbd = (void *)&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	psbd->tx_bd_len_flags_type = CRYPTO_PRESYNC_BD_CMD;
+	psbd->tx_bd_kid = cpu_to_le32(BNXT_KID_HW(kid));
+	psbd->tx_bd_opaque =
+		SET_TX_OPAQUE(bp, txr, prod, CRYPTO_PREFIX_CMD_BDS + 1);
+
+	prod = NEXT_TX(prod);
+	pcmd = (void *)&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	bd_space = TX_DESC_CNT - TX_IDX(prod);
+	space = bd_space * sizeof(struct tx_bd);
+	if (space >= CRYPTO_PREFIX_CMD_SIZE) {
+		memcpy(pcmd, pre_cmd, CRYPTO_PREFIX_CMD_SIZE);
+		prod += CRYPTO_PREFIX_CMD_BDS;
+	} else {
+		memcpy(pcmd, pre_cmd, space);
+		prod += bd_space;
+		pcmd = (void *)&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+		memcpy(pcmd, (u8 *)pre_cmd + space,
+		       CRYPTO_PREFIX_CMD_SIZE - space);
+		prod += CRYPTO_PREFIX_CMD_BDS - bd_space;
+	}
+	txr->tx_prod = prod;
+	tx_buf->is_push = 1;
+	/* Minus 1 since the header psbd is a single entry short BD */
+	tx_buf->inline_data_bds = CRYPTO_PREFIX_CMD_BDS - 1;
+}
+
+static int bnxt_ktls_tx_ooo(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    struct sk_buff *skb, u32 payload_len, u32 seq,
+			    struct tls_context *tls_ctx)
+{
+	struct bnxt_tls_sw_stats *ring_stats = txr->tls_stats;
+	struct tls_offload_context_tx *tx_tls_ctx;
+	struct bnxt_ktls_offload_ctx_tx *kctx_tx;
+	u32 hdr_tcp_seq, end_seq, total_bds;
+	struct crypto_prefix_cmd pcmd = {};
+	struct tls_record_info *record;
+	unsigned long flags;
+	bool fwd = false;
+	__le64 le_rec_sn;
+	u64 rec_sn;
+	u8 *hdr;
+	int rc;
+
+	tx_tls_ctx = tls_offload_ctx_tx(tls_ctx);
+	kctx_tx = bnxt_get_ktls_ctx_tx(tls_ctx);
+	end_seq = seq + skb->len - skb_tcp_all_headers(skb);
+	if (unlikely(after(seq, kctx_tx->tcp_seq_no) ||
+		     after(end_seq, kctx_tx->tcp_seq_no))) {
+		fwd = true;
+		pcmd.flags = CRYPTO_PREFIX_CMD_FLAGS_UPDATE_IN_ORDER_VAR_LE;
+	}
+
+	spin_lock_irqsave(&tx_tls_ctx->lock, flags);
+	record = tls_get_record(tx_tls_ctx, seq, &rec_sn);
+	if (!record || !record->num_frags) {
+		rc = -EPROTO;
+		ring_stats->counters[BNXT_KTLS_TX_OOO_FALLBACK_NO_SYNC]++;
+		goto unlock_exit;
+	}
+	hdr_tcp_seq = tls_record_start_seq(record);
+	hdr = skb_frag_address_safe(&record->frags[0]);
+
+	total_bds = CRYPTO_PRESYNC_BDS + skb_shinfo(skb)->nr_frags + 2;
+	if (bnxt_tx_avail(bp, txr) < total_bds) {
+		rc = -ENOSPC;
+		ring_stats->counters[BNXT_KTLS_TX_OOO_FALLBACK_NO_SPACE]++;
+		goto unlock_exit;
+	}
+
+	if (before(record->end_seq - tls_ctx->prot_info.tag_size,
+		   seq + payload_len)) {
+		/* retransmission includes tag bytes */
+		rc = -EOPNOTSUPP;
+		goto unlock_exit;
+	}
+	pcmd.header_tcp_seq_num = cpu_to_le32(hdr_tcp_seq);
+	pcmd.start_tcp_seq_num = cpu_to_le32(seq);
+	pcmd.end_tcp_seq_num = cpu_to_le32(seq + payload_len - 1);
+	if (tls_ctx->prot_info.version == TLS_1_2_VERSION) {
+		u32 nonce_bytes = tls_ctx->prot_info.iv_size;
+		u32 retrans_off = seq - hdr_tcp_seq;
+
+		if (!hdr) {
+			rc = -ENOBUFS;
+			ring_stats->counters[BNXT_KTLS_TX_OOO_FALLBACK_NO_HDR]++;
+			goto unlock_exit;
+		}
+		if (retrans_off > 5 && retrans_off < 5 + nonce_bytes)
+			nonce_bytes = retrans_off - 5;
+		memcpy(pcmd.explicit_nonce, hdr + 5, nonce_bytes);
+	}
+	le_rec_sn = cpu_to_le64(rec_sn);
+	memcpy(&pcmd.record_seq_num[0], &le_rec_sn, sizeof(le_rec_sn));
+
+	rc = 0;
+	bnxt_ktls_pre_xmit(bp, txr, kctx_tx->kid, &pcmd);
+
+	if (fwd) {
+		kctx_tx->next_tcp_seq_no = end_seq;
+		kctx_tx->pending_fwd = true;
+	}
+
+unlock_exit:
+	spin_unlock_irqrestore(&tx_tls_ctx->lock, flags);
+	return rc;
 }
 
 struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
@@ -363,6 +486,7 @@ struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	struct bnxt_ktls_offload_ctx_tx *kctx_tx;
 	struct tls_context *tls_ctx;
 	u32 seq, payload_len;
+	int rc;
 
 	if (!IS_ENABLED(CONFIG_TLS_DEVICE) || !ktls ||
 	    !tls_is_skb_tx_device_offloaded(skb))
@@ -381,14 +505,25 @@ struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		 */
 		kctx_tx->next_tcp_seq_no = seq + payload_len;
 		kctx_tx->pending_bytes = payload_len;
+		kctx_tx->pending_ooo = false;
+		kctx_tx->pending_fwd = true;
 		*kid = BNXT_KID_HW(kctx_tx->kid);
 		*kctx_tx_p = kctx_tx;
 		*lflags |= cpu_to_le32(TX_BD_FLAGS_CRYPTO_EN |
 				       BNXT_TX_KID_LO(*kid));
 	} else {
-		skb = tls_encrypt_skb(skb);
-		if (!skb)
-			return NULL;
+		kctx_tx->pending_fwd = false;
+		rc = bnxt_ktls_tx_ooo(bp, txr, skb, payload_len, seq, tls_ctx);
+		if (rc)
+			return tls_encrypt_skb(skb);
+
+		kctx_tx->pending_bytes = payload_len;
+		kctx_tx->pending_ooo = true;
+		*kid = BNXT_KID_HW(kctx_tx->kid);
+		*kctx_tx_p = kctx_tx;
+		*lflags |= cpu_to_le32(TX_BD_FLAGS_CRYPTO_EN |
+				       BNXT_TX_KID_LO(*kid));
+		return skb;
 	}
 	return skb;
 }
@@ -398,8 +533,13 @@ void bnxt_ktls_xmit_commit(struct bnxt_tx_ring_info *txr,
 {
 	if (!kctx_tx)
 		return;
-	kctx_tx->tcp_seq_no = kctx_tx->next_tcp_seq_no;
-	bnxt_ktls_inc_tx_stats(txr, kctx_tx->pending_bytes);
+	if (kctx_tx->pending_fwd)
+		kctx_tx->tcp_seq_no = kctx_tx->next_tcp_seq_no;
+	bnxt_ktls_inc_tx_stats(txr, kctx_tx->pending_bytes,
+			       kctx_tx->pending_ooo);
+	kctx_tx->pending_bytes = 0;
+	kctx_tx->pending_fwd = false;
+	kctx_tx->pending_ooo = false;
 }
 
 int bnxt_ktls_alloc_tx_ring_stats(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
index fd17d2ddb8b8..3ec56b8f08d4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
@@ -42,6 +42,8 @@ struct bnxt_ktls_offload_ctx_tx {
 	u32		next_tcp_seq_no;/* staged tcp seq no */
 	u32		kid;
 	u32		pending_bytes;	/* staged payload bytes */
+	bool		pending_fwd;
+	bool		pending_ooo;
 };
 
 struct bnxt_ktls_tx_driver_state {
-- 
2.51.0

