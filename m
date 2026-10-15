Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783153C3B5
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077865; cv=none; b=AOI0JRLWDxFJh7z8noKLnwEPwg5jubiTEhpA0A0LiLJIvJXfp3WYJZu+uVG7R87p9smTISPZpZj69FNJQYFSN8/vwZN65xPDwgLgl8QsMDISGU5jTVjO+sCRRtAVPBHKFp16i+uOgkHuCYfgWcoaDhhYUzfsYMZlA6bDprlzIgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077865; c=relaxed/simple;
	bh=ZhtqGMlbs0+ybiwyldWBrEDCtOXwVrctncd4nkTy4Ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qVdUUg/KIPEeFQKZPz1plV8rBGNDTrq9kClubAkSPYmByBXgCJjKwog3LNO2mg//US5BQPcX7nJljKmgrLK540XFq7xVizgFV7zlIQVjg8j02MmsUqK6tNX0bO8rrraq2t3eypv0sbq8+N6TmAf+ecIm849q+Z7vsxsSkA5JT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCr54O50; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCr54O50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EFD1F000C8;
	Thu, 15 Oct 2026 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077858;
	bh=LOfrTBgIGw1Ut6NFjD4piJE94VqdEtQNmpxMIVPj7hE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nCr54O50vB62+itjyh8SqWLjP0pU1U0DZfryXF/P4u8Amx4IMVhAz1HQdcLvPAQiq
	 byOGNOqxCQBikxRhdrNpXIbk5k+nmqOCREYT82x07WfN1i0nfoEoKq92w3rO9ejSDB
	 7zWat53abNvhkrhKGDv++eg+ggvuFw6B+ExlGYqyszC/TKLOOFApi/sSGumhmSXFb/
	 t+ARMAbF2o/PO1V9Ajj9HT4Teb3jJEIvfSLRjv5pI59NmC9vzKAdbH2Cgr51VjbAxD
	 I8mW87rBDm3xSXW2IUc5Woc80BFWSaDhA4rfRm/H7qHO73nM/w7oh+5FA6gfLfJG1a
	 xEZVMMwsYZMmw==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 15 Oct 2026 17:24:04 +0200
Subject: [PATCH net-next v5 04/14] net: ethernet: cortina: Normalize free
 queue pointers on rebuild
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-gemini-ethernet-fixes-3-v5-4-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The free queue read pointer is owned by hardware and can retain a
position from the previous ring when the queue is rebuilt at a smaller
order. Using an unmasked pointer to index the replacement page table can
then access it out of bounds. A replacement ring which does not contain
the raw retained pointer can also let hardware address past the new
allocation.

Mask software page indices to the active queue order. Keep the
replacement ring large enough for the retained hardware pointer and
initialize the software-owned write pointer from it before filling the
ring. This represents an empty queue without trying to write the
read-only pointer.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 003108270d06..7ebd62f8a3a4 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -887,6 +887,7 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
 
 	rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
 	pn = (refill ? rw.bits.wptr : rw.bits.rptr) >> fpp_order;
+	pn &= m_pn;
 	epn = (rw.bits.rptr >> fpp_order) - 1;
 	epn &= m_pn;
 
@@ -936,6 +937,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	union dma_skb_size skbsz;
 	unsigned int filled;
 	unsigned int pn;
+	u16 rptr;
 
 	geth->freeq_ring = dma_alloc_coherent(geth->dev,
 		sizeof(*geth->freeq_ring) << geth->freeq_order,
@@ -958,6 +960,10 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 		if (!geth_freeq_alloc_map_page(geth, pn))
 			goto err_freeq_alloc;
 
+	/* Match the software pointer to the retained hardware pointer. */
+	rptr = GET_RPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG);
+	SET_WPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG, rptr & (len - 1));
+
 	filled = geth_fill_freeq(geth, false);
 	if (!filled)
 		goto err_freeq_alloc;
@@ -1068,6 +1074,7 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	struct net_device *other_netdev;
 	unsigned int new_size = 0;
 	unsigned int new_order;
+	u16 rptr;
 	int ret;
 
 	ASSERT_RTNL();
@@ -1099,6 +1106,10 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	}
 
 	new_order = min(15, ilog2(new_size - 1) + 1);
+	rptr = GET_RPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG);
+	if (rptr >= BIT(15))
+		return -EIO;
+	new_order = max_t(unsigned int, new_order, fls(rptr));
 	dev_dbg(geth->dev, "set shared queue to size %d order %d\n",
 		new_size, new_order);
 	if (geth->freeq_ring && geth->freeq_order == new_order)

-- 
2.56.0

