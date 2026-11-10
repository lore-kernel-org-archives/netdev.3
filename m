Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348815;
	b=DV6r2LIsu9y5nlxy0cssKW3U0827THRC4g97UsW57vNuKYidtVpiQMFOfDqSCXItWwF8
	 lDErhfnRJzlk62SFUDwwSyXeyXHyBOFFh4cWNRS2le1HWbnznP4LXhA+e0XutxRSkPlU2
	 NDbpfdHf9NxKD50kf5XjyIUDwQbuwNmYjXlyTFj7gkr1kmiqTKAX4khf6XQGwZMlm/F7i
	 moiA7T5pfWvNuj4AwfystakFNyjDrNjCcexLxBUNuhy3zmSHfxRjtHJrW5cwGxhYEMQaH
	 UoHmez5yqj2D07ygUo90Gg5R5qGYxbBw2BSorifbMMQ1YWbWOUb6vaJc56RFVLNWXgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348815;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=+nrZZunjUWX5eytq5b6BG4Rj/VRrVpeNM/ugVugGlt4=;
	b=k2d/BVn6zMGvp+rfeZruosj9In6bZKNWMxRKCORLsRpyp/qmVkS0pZ/myCz2H6kT0nXJ
	 FnjaK47JP4/UeHfcL3rsRn5P0x16qSz4SUzT5OdDwkRhyIwOZho1S/mRfCFBJYyR8wfcU
	 U+8zaZ3lbD6mNoRVE+y61eSgHtZHzPZp4cWVuomzch4pJSnU1SiBCNhVDcY0g3Z7oKRMw
	 bN+h3vuJMnzWbhkzibpLU8KTRSyj8iwwGav3MAIjtykJGN0mRN35BbsSjiYMdY37JZ0mw
	 Ky+Va8JtELsxeJI4imd7dapeieZPoJBbRipi0piechNfuvP87FsbfB5Tvbb0bOgl1Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=og7yYoHY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E560A2600
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=og7yYoHY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2021F0089F;
	Tue, 10 Nov 2026 22:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348814;
	bh=+nrZZunjUWX5eytq5b6BG4Rj/VRrVpeNM/ugVugGlt4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=og7yYoHYv+dyx1kZ6qiM7gowlFt2jzYg65msy+PXsS+/Q3ej55/rn34G+SEUT+wWj
	 zualxgiZvtEw1t7PCOD1WiBqiA6qvyVrq2xYdPOIR0WY7Ks+I7RPFY1vN3om0G/nl9
	 hvI2xUZ+e+oKA9eKAAyWtfvzQAhC9nWBHu9yvlCURYeI2F4mZo/N85PLCM2sPP4g+8
	 FnT2IZhKiOXAYEMzmqWgMhPnt39bgQwDTieu/QCiTIwG+fIBXjOHae7deCfhuuEOpx
	 yVuk3cP7m4kNYN2uPHuVXUkr9HBQIbDHAt/cU0Z0mQyTUh1UqO8jV/xgGCU3bCuPXj
	 s0YIcFRvv0Hbw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:19 +0100
Subject: [PATCH net-next v7 04/18] net: ethernet: cortina: Normalize free
 queue pointers on rebuild
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-4-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
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

A requested shrink may therefore retain a larger shared queue. A high
pointer inherited from firmware can impose the same allocation floor.
If allocation fails, leave the queue disabled and return the error;
retrying below that floor would not safely contain the retained pointer.
Removing this restriction requires verified hardware pointer-reset or
truncation behaviour.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 5fdbe987dc97..fa51f2b54073 100644
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

