Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D64C3CBE6D
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582883; cv=none; b=UQ2+PpmwvLNUvSNKa4YjAZtpa9HBXVudx1ZVzCbXTHPtvpjryDgttxBbCoWXIetQl+8UrN73e9alBHWJ+nEpY3dqJeNlw8apqKim+xiEeepy7rdy+O6lwvlDq+upxsn/YDaRVFZhhgg2Oo/HjLLMnVULZDjtVIe2aqa6hkfSNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582883; c=relaxed/simple;
	bh=Yw+kW60tiyde7KiT0jO+rnWgC5MSbh+FufdnqnUvDEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dy00t1PWOjog6oikEs8+vcS0nEoB7b2PorTcTqP2TWnd+rEcannjpjJpTTbuAluhA65W95943qW/OruhFbzzmWz5i8vdPlKXCP1jeHt3Eh/ZeMkl/ZI+nIriihXIiUW/na/5n7YJCoJL07M/56Px/1GK4k0OW5XyVtpCEI1u3hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=pR1lKHbQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="pR1lKHbQ"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so64880a12.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791582881; x=1792187681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z7iB6MuKqAb6OuycuUnKN9NPjjEJxtCuOVdjVCejVb8=;
        b=pR1lKHbQZreWKMFA71JBZuWYGCkVfo/Txj4RTXA4MqcyiRmdY7YmUDs5nSOrjhOHDr
         vkqPq00xOLdUjUX0mKWNjl+jtUBAhxmxpsStjneaVgGzpu2yIY0qByT5rwISeID9Sj5R
         W9r3wVhg3FJXq2WiQzWabP96U0RhFosrGFW/LS2Uly1ZWzFY3hOtyn95peyDxo984yWM
         ccYtSPufiLpiLZ5LdOPo6NTZI2fPqTUFx8xMPuNDHQMRcqMMA4SQftoC181niklIDG+f
         fZCBa8Jv3QfjFaA47yfJM1+8MD5RO5VS/HEoW/oujwRmugZHRv+5S1Nl0FCBZFLbS7u3
         MkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791582881; x=1792187681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z7iB6MuKqAb6OuycuUnKN9NPjjEJxtCuOVdjVCejVb8=;
        b=M9GNpYpJBNdoU1wcMn7ZvQ2uLYBVxk5ef9/2Hvvg6BN4BfZeA1I571TyE34gMsmycG
         BwEBu70JVSFJqWYcBA1Qesrf+n56s1jn22KoCZROHIw20eOSoJFqbBEUcm+XoCOlsirT
         //d/0qhtDmoER+UvGuPvx1OMQBxlMVa1lHL4tIAc0gbkZ9wHF7R1Qgv8pvKl+YnphAIq
         fczdsUw9ZsH68cRPEadCQfO6/cbKhk5k3UG68ny6Z5V4D+nnYCpUIb96ZkwxiqdtH7jG
         rK4vSeHVAKbw8f5j4UaOODguFt6/7K1SyDruf110oARA1oZSh1+PDGZIMFap382Zo8EQ
         CFeA==
X-Gm-Message-State: AFq9FYK99ZX0VPyKu594V59IjmpLtxfKs2etkeSzlVoWLOc7lCUNNnPE
	gHdySemPBPomtSx5dRixL6RAEN9y2srWsZYcuzpbTwZVnXL755mWjNauGQ/0e46vk7GtpOe5t1y
	Gy0E1
X-Gm-Gg: AYBFou171Q4jLCSgQ2trYqbwzQeLQYfq/VYK4wht/yR0WFkYrRacvQe6lU+xwxVaIm4
	3RfbE+tU2CYGD6ZJKbrjc+HfOUWYWL8kK3TjKfVcHxolpNmb8KBULq+JcTR7LBAPLrZbsCwGJYq
	LYK2P5ji6Hn+GCoI+ZQzriXh+XihOzKzCSZgRWbg4B/VLF03zZlKLQIib4LtsnY229OTUG5Uv1W
	Mx4NFp2lCYewynDJpjDc55IpScK9cohzHbFLN2DL9a2hFC41m34AoK6dlKg3Bg83RUhNMIDhCGJ
	Hz/vpBNjS093Ky3g5xwQFshL/RgkJHmVeW4IvK9l4FcCGGJ7WGCC9Ny2D1Z6ruJeeRXHbyqVOcL
	5brx63h2xqLiqwdj0xSQyBOCeTXsPsS+iI6l51k3D8vDZU7GWp71rhKmOR5jh1jegfbR2nbipRH
	HgqYYYSNagVOD9MpfNPG/rIZ5xJPs1x/zzm/eX700GbdXgOBca7jTbwskgy8wGwZu9b211dPFI5
	v7SE5+SVr/7
X-Received: by 2002:a17:90a:d2c7:b0:3a4:ca46:8d44 with SMTP id 98e67ed59e1d1-3ab3a735fafmr2733232a91.18.1791582881278;
        Fri, 09 Oct 2026 14:54:41 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab37139b59sm5389248a91.13.2026.10.09.14.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:54:36 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/2] bnxt_en: Pad short SW USO segments to BNXT_MIN_PKT_SIZE
Date: Fri,  9 Oct 2026 14:54:24 -0700
Message-ID: <20261009215426.2377946-3-joe@dama.to>
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

Each SW USO segment is hdr_len + seg_payload bytes. With IPv4, hdr_len
is 42 bytes, so a segment carrying less than 10 bytes of UDP payload is
sent shorter than BNXT_MIN_PKT_SIZE. This happens with a short last
segment (e.g. gso_size 1400 and 1405 bytes of payload) or with a
gso_size below 10 bytes.

Fix the short last segment in bnxt_sw_udp_gso_xmit(): zero the pad
bytes after the header in the segment's inline header slot and add a
pad BD pointing at them after the payload BDs. Only the last segment
can need padding, and its pad BD fits within the existing bound in
bds_needed and BNXT_SW_USO_MAX_DESCS, since payload BDs are at most
num_segs + nr_frags.

If gso_size itself is too small, every segment would need a pad BD,
exceeding the descriptor bound. This case is unlikely, so
bnxt_features_check() clears GSO features for these skbs and the stack
segments them instead; bnxt_start_xmit() then pads each segment.

Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 12 ++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 28 +++++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h | 15 ++++++++++
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c1d3fcc7ae84..0682060b048c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14268,6 +14268,18 @@ static netdev_features_t bnxt_features_check(struct sk_buff *skb,
 	u8 *l4_proto;
 
 	features = vlan_features_check(skb, features);
+
+	/* SW USO pads at most the last segment; let the stack segment skbs
+	 * where every segment would be shorter than BNXT_MIN_PKT_SIZE.
+	 */
+	if (skb_is_gso(skb) &&
+	    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    bnxt_sw_gso_pad_len(skb_transport_offset(skb) +
+				sizeof(struct udphdr),
+				skb_shinfo(skb)->gso_size))
+		features &= ~NETIF_F_GSO_MASK;
+
 	switch (vlan_get_protocol(skb)) {
 	case htons(ETH_P_IP):
 		if (!skb->encapsulation)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
index ef04c9d08066..80d5c4f963a9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -82,11 +82,19 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	if (unlikely(num_segs <= 1))
 		goto drop;
 
+	/* bnxt_features_check() makes the stack segment these, but paths
+	 * that skip validate_xmit_skb() (e.g. generic XDP_TX of a GRO'd
+	 * skb) can still get here. Padding every segment would need more
+	 * BDs than bds_needed reserves below, so drop instead.
+	 */
+	if (unlikely(bnxt_sw_gso_pad_len(hdr_len, mss)))
+		goto drop;
+
 	/* Upper bound on the number of descriptors needed.
 	 *
 	 * Each segment uses 1 long BD + 1 ext BD + payload BDs, which is
 	 * at most num_segs + nr_frags (each frag boundary crossing adds at
-	 * most 1 extra BD).
+	 * most 1 extra BD). The last segment may need 1 pad BD.
 	 */
 	bds_needed = 3 * num_segs + skb_shinfo(skb)->nr_frags + 1;
 
@@ -133,12 +141,14 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		dma_addr_t dma_addr;
 		struct tx_bd *txbd;
 		struct udphdr *uh;
+		unsigned int pad;
 		void *this_hdr;
 		int bd_count;
 		bool last;
 		u32 flags;
 
 		last = (i == num_segs - 1);
+		pad = bnxt_sw_gso_pad_len(hdr_len, seg_payload);
 		offset = slot * TSO_HEADER_SIZE;
 		this_hdr = txr->tx_inline_buf + offset;
 		this_hdr_dma = txr->tx_inline_dma + offset;
@@ -156,10 +166,18 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			iph->check = 0;
 		}
 
+		/* Pad bytes follow the header in the inline slot. Zero them
+		 * so stale header bytes from an earlier packet are not sent.
+		 */
+		if (pad)
+			memset(this_hdr + hdr_len, 0, pad);
+
 		dma_sync_single_for_device(&pdev->dev, this_hdr_dma,
-					   hdr_len, DMA_TO_DEVICE);
+					   hdr_len + pad, DMA_TO_DEVICE);
 
 		bd_count = tso_dma_map_count(&map, seg_payload);
+		if (pad)
+			bd_count++;
 
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
 		txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
@@ -222,6 +240,12 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			seg_payload -= chunk_len;
 		}
 
+		if (pad) {
+			prod = NEXT_TX(prod);
+			txbd = bnxt_sw_gso_data_bd(bp, txr, prod,
+						   this_hdr_dma + hdr_len, pad);
+		}
+
 		txbd->tx_bd_len_flags_type |=
 			cpu_to_le32(TX_BD_FLAGS_PACKET_END);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
index 77d9af97cc22..5916ee08c0e6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
@@ -19,10 +19,25 @@
  * Each segment: 1 long BD + 1 ext BD + payload BDs.
  * Total payload BDs across all segs <= num_segs + nr_frags (each frag
  * boundary crossing adds at most 1 extra BD).
+ * The last segment may need 1 pad BD (see bnxt_sw_gso_pad_len()).
  * So: 3 * max_segs + MAX_SKB_FRAGS + 1 = 3 * 64 + 17 + 1 = 210.
  */
 #define BNXT_SW_USO_MAX_DESCS	(3 * BNXT_SW_USO_MAX_SEGS + MAX_SKB_FRAGS + 1)
 
+/* Bytes of padding needed to bring a segment carrying @seg_payload bytes
+ * up to BNXT_MIN_PKT_SIZE, or 0 if no padding is needed.
+ */
+static inline unsigned int bnxt_sw_gso_pad_len(unsigned int hdr_len,
+					       unsigned int seg_payload)
+{
+	unsigned int len = hdr_len + seg_payload;
+
+	if (len < BNXT_MIN_PKT_SIZE)
+		return BNXT_MIN_PKT_SIZE - len;
+	else
+		return 0;
+}
+
 static inline u16 bnxt_inline_avail(struct bnxt_tx_ring_info *txr)
 {
 	return BNXT_SW_USO_MAX_SEGS -
-- 
2.53.0-Meta

