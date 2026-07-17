Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F3D379989
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284684; cv=none; b=OEGywyuYqbNAcej5F0Cd4a/cPb/nKMWwilAk5Lq7HTPynNUTqcXYQ7yv00o8aVAnXJk3nnBIv/oSXwW6smJqik41Hn6OPMXDVcv1xbt+UC9o3YrHWqSy/R3clte26Q1PT2SOl/IBwY109F7Su2xBMFFhvLWSsOcqTbXGAmZf6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284684; c=relaxed/simple;
	bh=zjxrR5iNQxT3KBb/9QZ3n4GXdmGTzyuOZOa0xGwLtU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6bqHndu7eJ9D5Trs+CrGQZhPo7dmfuxx0M1H6hBvEJaZVPSG/bIUIqf38K1JJfKYH2qGAIu0+LV14SVxOynSEn65bAI8Lz552VOUz/glIM/Mww1Fl8a6M8Kgq9LZKopCh9AIbx2PTykjY14/IBoW4K2Gu60xvr5zeXyH8Rrd/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hP+I7Aek; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hP+I7Aek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Bp
	2BTT0oJb2aCDNOBzGNCw9r+6YZ5pezjheFS0NzuPk=; b=hP+I7Aeke/gFuLJLvP
	6fEUykaaL90pd3CJ6570hkiFFHShmkk2/88jKB5NaCctcQMV/gZJV+vs9PEHyLUH
	u0ys3HDJJtrpuENirEbkZ49Q7J/Bi5UT+JMGd5FxhKnTaAnGJXqfppDyawzLFBp0
	D3aF5MlsE+ZMwP6olhPu8ZDfA=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBnVWDlBVpqguBEKA--.5251S3;
	Fri, 17 Jul 2026 18:37:26 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH 01/13] 8139cp: fix DMA mapping unwind on TX frag map failure
Date: Fri, 17 Jul 2026 18:37:23 +0800
Message-ID: <20260717103724.13971-2-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717103724.13971-1-luyun_611@163.com>
References: <20260717103724.13971-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnVWDlBVpqguBEKA--.5251S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyDJw4rJF48Gr1rCrW7Jwb_yoW5GFW7pa
	yFya4Ykrs5JrnIv3W8Gay2qr45Za1rt34YvFyfC3s5Zrs8CFnagFWSgFyUCFWUKFW8uFWx
	trs0ya48CF15t37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtrchUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6warempaBeZjWgAA3W

From: Yun Lu <luyun@kylinos.cn>

When dma_map_single() fails for one of the TX fragments in
cp_start_xmit(), unwind_tx_frag_mapping() is supposed to drop the
DMA mappings that have been established so far. The current code
gets this wrong in three ways:

- it unmaps the DMA address read from the descriptor of the head
  slot, but the head descriptor is only written after the fragment
  loop, so a stale address of a previously completed (and already
  unmapped) packet gets unmapped again;
- the unmap sizes are off by one slot: slot first_entry + 1 + k
  holds frags[k], but is unmapped with the size of frags[k + 1];
- the head buffer mapping (first_mapping) is never unmapped at all,
  leaking one DMA mapping on every failure.

Pass the head mapping and its length to the unwind helper, unmap it
explicitly, and unmap the successfully mapped fragments with their
matching sizes.

Fixes: cf3c4c03060b ("8139cp: Add dma_mapping_error checking")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 drivers/net/ethernet/realtek/8139cp.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
index 5652da8a178c..03929bb0bd79 100644
--- a/drivers/net/ethernet/realtek/8139cp.c
+++ b/drivers/net/ethernet/realtek/8139cp.c
@@ -713,13 +713,24 @@ static inline u32 cp_tx_vlan_tag(struct sk_buff *skb)
 }
 
 static void unwind_tx_frag_mapping(struct cp_private *cp, struct sk_buff *skb,
+				   dma_addr_t first_mapping, u32 first_len,
 				   int first, int entry_last)
 {
 	int frag, index;
-	struct cp_desc *txd;
-	skb_frag_t *this_frag;
-	for (frag = 0; frag+first < entry_last; frag++) {
-		index = first+frag;
+
+	/* The head mapping was never written to the ring, unmap it
+	 * using the saved address.
+	 */
+	dma_unmap_single(&cp->pdev->dev, first_mapping, first_len,
+			 DMA_TO_DEVICE);
+	cp->tx_skb[first] = NULL;
+
+	/* Unmap the frags that were successfully mapped. */
+	for (frag = 0; first + 1 + frag < entry_last; frag++) {
+		struct cp_desc *txd;
+		skb_frag_t *this_frag;
+
+		index = first + 1 + frag;
 		cp->tx_skb[index] = NULL;
 		txd = &cp->tx_ring[index];
 		this_frag = &skb_shinfo(skb)->frags[frag];
@@ -828,7 +839,9 @@ static netdev_tx_t cp_start_xmit (struct sk_buff *skb,
 						 skb_frag_address(this_frag),
 						 len, DMA_TO_DEVICE);
 			if (dma_mapping_error(&cp->pdev->dev, mapping)) {
-				unwind_tx_frag_mapping(cp, skb, first_entry, entry);
+				unwind_tx_frag_mapping(cp, skb, first_mapping,
+						       first_len, first_entry,
+						       entry);
 				goto out_dma_error;
 			}
 
-- 
2.25.1

