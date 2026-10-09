Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADFF3EDE7C
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582878; cv=none; b=eLpJi3+qEbSZmhfd9vKoazudDeo9THyO+yqKtnk4x66rXr0Y204i4yJhgDy5hnqxOlIyHxwkKYrp4uot81UlxjFUHp68JvX6sBBUwpqhrCZeBkq/61lyrmq84l39yjR6PBPHAVumzwj5WKnF2JVRY3btr5RyUgymWRNNbx56hvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582878; c=relaxed/simple;
	bh=jyTQX6gHVlLMAuxSV9YrNqfXCPA15cOhWl5JBqLVTn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epUtuvKwDipRdRiHCyPRe4J0s4yDwQwROPXcn9hotEUgu+4Ur6aekoxIeyGmDClyJcSZFMA3R1qFOBYgdEPToUOTMYRV+Y8Ewx3+l6OI5t64NAxu2EYrpsFkdl7dLQgDJ6kpAjI1mgPRwwTkCCfKnygYO16I3acb1CFRcLSyGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=qkNDU2if; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="qkNDU2if"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso69921a91.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 14:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791582875; x=1792187675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=86KAF2s8MyS8a1OAHwlwG1z8Q/cZ8M57EZYH8fFLoz0=;
        b=qkNDU2ifM5TLloHirhQoMCTf/lFXWI9vPtNVCog11/fgtUIiMd6FCce8KGnXzOEpXs
         2Pi/B7XCUWUSSLOIKUFBiadkgXDyNpqjlq9ICI7iocKuU5dBdJ75nF9VzyjFb6M5Q2et
         xrFUmkkc9ksSYIvVVjLXWI8xZrzQ7IGyfgNEhsjajE3sVek3/QClnXohuwhXqQL9gP5L
         F0pyK/8ta6fNeH6dBwBnAoZR/+JDO2wLkg02p9wiMeNWLrXhBqjwPH0C9RYij5tWVslE
         z5AGRK+MCqTacmdjmA48lIpETW+JYYxF4gxu6nixOjp94qAoD8CIzWqM9bvZaHrTUTqB
         +mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791582875; x=1792187675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=86KAF2s8MyS8a1OAHwlwG1z8Q/cZ8M57EZYH8fFLoz0=;
        b=TaqDL+1O4P+Wtu4zTrUtK6eu7NhM/BKwxXUem7693tnkWGBugxnVcrDk7OV2i+Uhy+
         AGJOeHdqBTVXy1TvgrgviyVg/oKYWka/zFL0NpkJsxYD4q6jV+6BSgR1hvD2UCPnI5qV
         UoxgRREbCfVama16Wr5bUzeNJx1Lpy3zdpQb9UGVwsJPW6eA/4bbIGIZz5neqnLOSk4U
         kOB7tPVaBcXLIxfcPEWtxaB0MTx8NinqI/V+0rlGTX6v6vOIYU2XtFzJyZ/ZXOoq2naa
         4psToVqGYFY+K8xBO/mhGhOc9pxBfJhLCI3fu7UIXnZDf99u8PBVCsqmdPtSOStbiwha
         rx6A==
X-Gm-Message-State: AFq9FYIP0E9uTjmG6GDIbMKa9+qXUawB0IsRdZ6GddPXvGERJnBeEdAP
	7W0Obot24kj+ExQzVzhguUPzARvSJu4UiW2rEPeCQjAzsyZHvYn3orIplVOQ6GWHNG7fexb0hiO
	4Gn2e
X-Gm-Gg: AYBFou2Acukppb76cfJzjPAP62Id4kEcViOyOrOhblsragbBJ/+klP8onYSA/lFKR8C
	naV4PM+Q9Nw/nK6NLTbcxZqkffYiAHpNWpsGD4Zy1W2jfEjjsV2Ekrf1gzHcWQEZoDnBaAup8iZ
	6t9dL3fjPdCiJEQz0yFaSaDZJF1TPByXCrLL1SSFmOQViQQ1XGRZDFXtBCAln7tOXQ6loS1mtrM
	pST4NQnXEVqDlp3yHpmJOl5EOJmeV7ebCuriSr8wwi3hoEKLTL/2bDrlVscBdCa9w30eQ5yjDav
	cnZY3lH9cnewRxpQmKnmg54gNsBjzDOJHQctekGhQp78EU+n1HOR7FIueOftE4aEOi/p6SkpTty
	fTxJunLmBXTGT/Ej5TOaGSCBaHB0KBZkvnUa0X7ghzl/k3HLdLApKNKQ6hN0eLdGwwX3EXuXYGP
	FGL+2LU3pWwhCEkOgOIxqBl6FCql0V83BBZ9fj6TOBEr6c/J/Y6ho5d27vBFS1bDZE/sr71edBi
	8Hqp2kafjX06ElcpCU+cg4=
X-Received: by 2002:a17:90a:d006:b0:39e:53a:c8d4 with SMTP id 98e67ed59e1d1-3ab3a90e57amr2463266a91.12.1791582874924;
        Fri, 09 Oct 2026 14:54:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:56::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed040dsm6555649a91.6.2026.10.09.14.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:54:33 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [PATCH net-next v2 1/2] bnxt_en: Add helper to fill SW USO payload BDs
Date: Fri,  9 Oct 2026 14:54:23 -0700
Message-ID: <20261009215426.2377946-2-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009215426.2377946-1-joe@dama.to>
References: <20261009215426.2377946-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the code that fills a payload BD and its software ring entry in
bnxt_sw_udp_gso_xmit() into a helper, bnxt_sw_gso_data_bd().

No functional change. A following patch uses the helper to add a pad BD
to short SW USO segments.

Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 33 ++++++++++++-------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
index 6c1060fa2ea5..ef04c9d08066 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -31,6 +31,26 @@ static u32 bnxt_sw_gso_lhint(unsigned int len)
 		return TX_BD_FLAGS_LHINT_2048_AND_LARGER;
 }
 
+static struct tx_bd *bnxt_sw_gso_data_bd(struct bnxt *bp,
+					 struct bnxt_tx_ring_info *txr,
+					 u16 prod, dma_addr_t addr,
+					 unsigned int len)
+{
+	struct tx_bd *txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	struct bnxt_sw_tx_bd *tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
+
+	txbd->tx_bd_haddr = cpu_to_le64(addr);
+	txbd->tx_bd_len_flags_type = cpu_to_le32(len << TX_BD_LEN_SHIFT);
+	txbd->tx_bd_opaque = 0;
+
+	dma_unmap_addr_set(tx_buf, mapping, addr);
+	dma_unmap_len_set(tx_buf, len, 0);
+	tx_buf->skb = NULL;
+	tx_buf->is_sw_gso = 0;
+
+	return txbd;
+}
+
 /* Transmit an skb requiring software UDP segmentation.
  *
  * Returns 1 if the skb was queued and new BDs were produced, 0 if the skb
@@ -181,15 +201,10 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		while (tso_dma_map_next(&map, &dma_addr, &chunk_len,
 					&mapping_len, seg_payload)) {
 			prod = NEXT_TX(prod);
-			txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+			txbd = bnxt_sw_gso_data_bd(bp, txr, prod, dma_addr,
+						   chunk_len);
 			tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
 
-			txbd->tx_bd_haddr = cpu_to_le64(dma_addr);
-			dma_unmap_addr_set(tx_buf, mapping, dma_addr);
-			dma_unmap_len_set(tx_buf, len, 0);
-			tx_buf->skb = NULL;
-			tx_buf->is_sw_gso = 0;
-
 			if (mapping_len) {
 				if (last_unmap_buf) {
 					dma_unmap_addr_set(last_unmap_buf,
@@ -204,10 +219,6 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			}
 			last_unmap_buf = tx_buf;
 
-			flags = chunk_len << TX_BD_LEN_SHIFT;
-			txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
-			txbd->tx_bd_opaque = 0;
-
 			seg_payload -= chunk_len;
 		}
 
-- 
2.53.0-Meta

