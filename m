Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728289;
	b=PuFj/FkVT+8Sc33kleCl5OeLux2m0y30l/C9+uoTD9Oc4NnKAmkHgooepaVwE3LE1rER
	 XF3hzldVNrxlgn+QOgsPKh4qokaYbDM4JmSl4rkzykUM0dwdUuZnl8pTbJujbKDYL6eXz
	 AAdUHUy0vBu1tfrsCROHg8Rpew5/UougKTFYlJRtyUVyfvicvfV5yH7WpA5I/zHq0GSPi
	 E4dQ3Uco97/mjuxxyCZ4XSRBp6+1Bt5ZmHCp4Pax8o9w8Ix3rZ0hpsKPdDCmEYe5DK74p
	 lgxN+gIq4Fi77yXq7w3Kuk/mqjhZwwn9JvD9YUTQLi/Lvx31dFEFIo/HbuWAJhpTUPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728289;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=fFABdFdemLSusjZLC23cUbVSsrGcJ7NisgIVtUC/MMY=;
	b=F+F3MkjiYe3B5AY1iimbfegg00LvhSnuyp2TyNlz5XeaW/5DnQ+S6EMyYqHKXArDftZe
	 1vL0zpwYeDM3VBZHthP23KZV5tTZRmKhcUIxeU+z8ScKlSkMgWdU7UCDA6dhOD9VyciQo
	 FLR02MjUwjEucS1FteNNZqX+/Qx74S1Uxl/2YB0IBUoL7EaY+i46XTzO6bohnf/aEYY/I
	 Cy0FGOqLhvwNiCpkkZ0+M2EsrpoCnSrb5eGYNXxdk5dz2k2bytqPav5MQnDf81UXtIjoq
	 triZkyRmKZ3Jujohu6ErTvNgVuf0r3YTEjPlbFJitvFy2R1p4FfymwWibDheYvedHdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgFOxh++;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55208606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgFOxh++
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1BB1F0093A;
	Tue,  3 Nov 2026 17:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728288;
	bh=fFABdFdemLSusjZLC23cUbVSsrGcJ7NisgIVtUC/MMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hgFOxh++AipcM/1hJuMHNhQDZpNQCsHXCCBWs40+wz0nsG5/x4On09cuK0q2d4RrS
	 4Y0uQzN2+7vHNiOm/6Sp2ccPrf3BfTJzvZnL2fNI2pABRQu4zxS0TPchRQwAJsjJsF
	 3tpn1B/+rA4IUW43Q+LYNOU25R9THWVZlh+X0fYp6WmROkn2InGcZqD5oDCAv7IwVs
	 V6OPxlo09HEDJmh7yrICjyTnm5gzxP1/SDm448Fha5Tu0WJQAwOHfLuXkXqirXJW5D
	 9wfYJzoFgZEgEHwSB7GsD4pBMUs1fnx0YRLeVIWG23caHwlbOGGSayQPLtptXVy5C9
	 sBLZY3erlWSiQ==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 03 Nov 2026 18:51:15 +0100
Subject: [PATCH net-next v6 04/15] net: ethernet: cortina: Normalize free
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
Message-Id: <20261103-gemini-ethernet-fixes-3-v6-4-c4b5ff8a65d8@kernel.org>
References: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
In-Reply-To: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
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

