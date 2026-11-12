Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490232;
	b=OYy0vJVirgI02vuQdFMCrdcBdcjHXICIzk5g8SZijshgYhWwVR9/wXi+Px8RXwF78rEQ
	 dM1zF7pNEH9dRTVyG/Xa7gmDSpya2uxkcGr6F/C4VCcpTKZsoVFk2rfVLkKBXsxjE92EW
	 j6PtyrTyNknbZKh4PZDk30UIw7Voxz3vQzGxm287sFviKuSAVCWCBPaPxs5H+jSFoyiMn
	 xXS8zlj5A9htjLAiMC88UHJYdq+hHc66C/bdn6oyrwpngKW3SSdgdB85SYLUw+l97uhwa
	 4ncoIdXEYnbzkG4ZVoPorOWTZq/WZHGKVFBn+NhEKFr4kVj379zC8JUR4pAs3AX47gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490232;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=i/bKoaL4F/EVcAk+PerofgkL4oXqj5//FL1YWsOKmgQ=;
	b=VvnF7nCQD6Ck06HXuZ2zf1PeTMp66OW46fG/HEfGCAhXUE6Nz+FHopPcjpureBhNSUhp
	 RDrR1WQL2e1HuMYTe3+i+PH1YKKX5qxfSwpFZdmYMaEj1gerLoLXtTwmB7nPVZe6fkvXg
	 sST6ryX4/tU7Qr2mFUWd+94aQxjUzhL0A3MjZOgtzA+64q60Ki7wLnbP+V8bPpUw9NDjF
	 HyvxEGMTo9shU5dRhOsJUIFwljeLC4GNrwcSNmQbciwodJcB+rFpYnM/WNR4r/sGFZFRS
	 tKW7ZmX9NU2TNGWPOo7HOjaZNSEA5nC5KvlumUJlQdGajiFe2eXlqyQlydvp42ZA2mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="agNIY/eG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6E606A333
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=agNIY/eG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D288E1F00A05;
	Thu, 12 Nov 2026 13:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490232;
	bh=i/bKoaL4F/EVcAk+PerofgkL4oXqj5//FL1YWsOKmgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=agNIY/eG5Akxr8S2ghLrj/nomjs6fZqS9JBsgNOhXqI6yf9h4KZtbQPEFT0wDDUtk
	 uLqBvQmi04hl1/BvHZn5GrHnIDY/T2h0qUsnyS224aJdmoPOzLRrMX9mVdOWGREJda
	 N0wwzOh8tIsT6MGaodr+Wn8rDQM62tdIXEeoz8WhF3yKYGgN0IaNgdGUtL4BV7aTRX
	 46by8y6ZQxtbQQifGsXtgkQ38fpVeMZmnKb0Z1ALM63GTOXrt3evNQncy6cCB4zPFX
	 VBdvANkiUQ6DJ8bZji7bS2h8VeBpyktOzT5+oB9ykq3O9gd77qF57L4NWn/8zgfXK4
	 xcje60zDPkFIw==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 14:30:19 +0100
Subject: [PATCH net-next v8 04/19] net: ethernet: cortina: Normalize free
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
Message-Id: <20261112-gemini-ethernet-fixes-3-v8-4-f55bd43e02d3@kernel.org>
References: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
In-Reply-To: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
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
ring. This represents an empty queue without relying on a read-pointer
reset.

Testing on a D-Link DIR-685 with both ports stopped and the free queue
disabled showed that neither a 16-bit zero write to rptr nor a 32-bit
zero write to the pointer register resets rptr. The latter clears only
wptr. Clearing the queue base also leaves rptr unchanged. Networking
recovered after each rebuild, with all ten ping replies received.

A retained pointer can prevent shrinking the descriptor allocation. At
order 15 this is a 512 KiB ring. Buffer allocation initially follows that
order too, approaching 64 MiB; a following patch decouples the RX buffer
budget from descriptor geometry. If allocation fails, retries see the
same floor while DMA is stopped. Keep the queue disabled rather than use
a descriptor ring that cannot contain the retained pointer. Removing
this restriction requires verified pointer-reset or truncation behaviour.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 5eade1394a56..31dd4ddad9ea 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -920,6 +920,7 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
 
 	rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
 	pn = (refill ? rw.bits.wptr : rw.bits.rptr) >> fpp_order;
+	pn &= m_pn;
 	epn = (rw.bits.rptr >> fpp_order) - 1;
 	epn &= m_pn;
 
@@ -969,6 +970,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	union dma_skb_size skbsz;
 	unsigned int filled;
 	unsigned int pn;
+	u16 rptr;
 
 	geth->freeq_ring = dma_alloc_coherent(geth->dev,
 		sizeof(*geth->freeq_ring) << geth->freeq_order,
@@ -991,6 +993,10 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 		if (!geth_freeq_alloc_map_page(geth, pn))
 			goto err_freeq_alloc;
 
+	/* Match the software pointer to the retained hardware pointer. */
+	rptr = GET_RPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG);
+	SET_WPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG, rptr & (len - 1));
+
 	filled = geth_fill_freeq(geth, false);
 	if (!filled)
 		goto err_freeq_alloc;
@@ -1101,6 +1107,7 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	struct net_device *other_netdev;
 	unsigned int new_size = 0;
 	unsigned int new_order;
+	u16 rptr;
 	int ret;
 
 	ASSERT_RTNL();
@@ -1132,6 +1139,10 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
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

