Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587CA3D0C1D
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486691; cv=none; b=bQcdIOLKRuJ7Oyi7hVroFDBHLj6GsPImtU5+VNZpFSVs5/9SygMNwGYdylLmBpmvVA8vTVHdZK5aWCp/HqswsC3kV6vpsepfoWVmj0WzS842gXk4d+wUUNwHFG8nYnsAI1tZHJ0uMiVDQC1Fu6yI0169GrdcTQHgdb59nsmllLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486691; c=relaxed/simple;
	bh=cbC2XhUsTJLB6BZt5mpJ/2DzTETC0/qixQ2p6zN/2zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Av6hY5Lid8wPD1veL08efj1V84QY95+1FarrNE6gLOFelhBlHB44bF/+HpOIh8o7K1zGN84ufGNAC/vjUNayuXgvHKitk/sAUTnxCDHxsMksCd0UApnXKRMxOznc7JFpYIDNAydkMy685mSj7opAF7IoXwgk4v5CKSr9KS1zFZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=otkVz3cm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="otkVz3cm"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e831e86ebfso3187625ad.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791486686; x=1792091486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q4Zz1mpKCSKqZegwUQ0D/3xMtgVn99v1wjaeCbwZBKw=;
        b=otkVz3cmCwkNBsvGx1tg7bGrIBdHHSKfcsf26FB8VBGsBcWSwljXMztNU3GGSG2rz8
         8R6zVST94PPpRitPDSpyHkzq2Djq1UPvgFWEkzp9raoPuh52sMYIN3T/sgX1EFvOTJXO
         UN4DKj169Yrkiss5/+VqzZz/cwL5JBBYAcUVjWrN9kjH1ABC9rc+RwyWKhzIixb68nEh
         aLW9r9ulC2qBosvXaqvzbmQSeee2IlDzAwuvXFcMXI5jOTGlNWQPiDzZSxL3WOMqTliN
         hr07VYNuUC5wxUiG6QEwYj3kfm5eLWsAf9MSQUhL0kvRdWYLr2pe89+kdg4ELOc/K/Y8
         0i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486686; x=1792091486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q4Zz1mpKCSKqZegwUQ0D/3xMtgVn99v1wjaeCbwZBKw=;
        b=OYcOQdfVf+N2zNLEIriwJV7q+cbHHLtgI8tHJcq3nhB5qO48pLbmn7SVOYF239OjtT
         XrUDIzYs64bnTKa4NLZY3NG+2CCR7OWg1Mj+QiTkkCwlpe03tRA8q0mMOeDBNnvC2yzW
         Z0IFTQ1vFa0xe7lw0LckLYi3HeKFPndCQM2LCbFvopLczQ37ZXCBBictMU1LOZGsZ1CZ
         NqgM4x7tU4nLn1rnF1twZ+RWqMhFlj0zTZwlQaft3E8H1c6/VKNaTkTbZpJkXYOKHccZ
         asQuJW0W+I/GSMzaDrpNR0IGgA16oB1v6FTOECjo1Jq2QZvTkfKJ+qu/fEhyWkP8qPvm
         8Mfg==
X-Gm-Message-State: AFq9FYJ0Dtsw1ymCXFrp0vMxO0iTGW1rCyVhy7ljXGfY/PLlwvF2PsoD
	yJYQBuPg1pqcS++2W6AVtDsniRRquBBIchB/Wiy2EDWF5gAzB+pIuAb6UrOCwfiwYNeUTnubOsY
	fQIXs
X-Gm-Gg: AYBFou07eCRM79HQg6setTGn18BtabpMuu652d7xgC+PzxxZQvkxsWQbaSpYqxUCllJ
	0sDgxm3DKYZX6bwuNDegt1JtEPTb7ibSOLmneNGixBn7XRS8P9yz7RGWV1tZrtf73EPQ9/qBB9q
	RBpv8fWL4fHmdm6w3ukaX0JqCvHjCg8FR1ZO2kZK5H/lGi0RMuzANj82eOlV5G/8pF1lBHUDAqW
	9MDXsydXgqwmz4Jk6SWhuly2BKxijx7Ro34WwBILxyAyWhXb8vGTnU5UDZlUOQ4DfHjZAKVe3Xg
	XuORaKsCb/aJPvw6NcIcrmTgvUih2X9oIkNGSxAwOnasqj1o95oP/6L/r4Iy2Cxu6M7h2T43d0z
	bMU4Min+NCq9052R3M0bXFqgQEFQ7BwUSICkJcNQd31xaMiFYGaNxPTzDVGZhO8ZCQvDFvJqJgt
	5QpqnLo2rEaUGslUcmqmJDG7yyeZFSZQbzQvxv07rTS0aGhAe1B8zKebvuf8eVGs0Qr6PcBEMyH
	PqzaGuWRplN
X-Received: by 2002:a17:903:2984:b0:2df:99e6:9448 with SMTP id d9443c01a7336-2e6005fe110mr46098885ad.61.1791486686444;
        Thu, 08 Oct 2026 12:11:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e83cceadf3sm762855ad.45.2026.10.08.12.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:11:25 -0700 (PDT)
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
	Joe Damato <joe@dama.to>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] bnxt_en: Add helper to fill SW USO payload BDs
Date: Thu,  8 Oct 2026 12:11:11 -0700
Message-ID: <20261008191114.3736826-2-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008191114.3736826-1-joe@dama.to>
References: <20261008191114.3736826-1-joe@dama.to>
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

Cc: stable@vger.kernel.org
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

