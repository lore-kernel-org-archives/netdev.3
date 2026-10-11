Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D56391E57
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742012; cv=none; b=UNtC+gDR3X/yc6Tt+YR0FjcU7XXpNgFC2/KFbJrgpI9waRGu7ZdrCkOQF4Ko7aBYClFIM/JF52UUTif++gqT0G5wAjaRBB5y7xP4NAJ6/JrGVcSr9UdvNiwhIHy7yp4m/LcSaW47K5pQVi4g1eOx38JSJTVuxMqUxjB+wf8HG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742012; c=relaxed/simple;
	bh=FutUYwIIvmrXcOkPU/Aw7i4xwjhQ65blixC2La4P4gE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=un5TZejj0kWCbU7H1gy7Qlj+0+X8Wfa9qbb0qS93es6iZTE7gVZm7DBCMbEO5fmJF16rUQtiQfdcvv2s6POigUma8AaSgJ+Qbl3WDXrA1ZXdA2bF38IH8AoJQ3dzvCcQuL+ZKcbycVxjzo+oUa6H1714La5K4rKZbPl1P2ZdsV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CktFS05b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CktFS05b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47871F0089C;
	Sun, 11 Oct 2026 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791742010;
	bh=O2ZNYannc/RpLEC57V78wBLH778SKquFH6L1vaaIs5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CktFS05beHdaCLuOif5z2ub0GJgU5+sF9VUzg//IDmxiWYxJjeFFKjHBviMoA+ndU
	 5MMhaNgeke72cE+M0yiwDdUp7yMBKcwDGlrzsv6v1jWai8B/tAJ4M+dW//YjdZdfLI
	 pvkM9/RPkCEf6dMEmKdlJ0ewZjkWPLMVZIEqlVhUDr9YxweDs7ulQw4dUnZK6CcDPg
	 HTl/Z99RZmvSNYisunrcgAm+VC3A+YMSYG+wP+UwO04/a+xvYlV+h+rHWNikwQSfDc
	 C85gvVFYCEFaYzvS7M/VDyiobNm8jeTQiOtBqLCEAsjwMQyXDmJk8fIu6+6b4uoSJ8
	 TOCydrQ7RaLpg==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 20:06:24 +0200
Subject: [PATCH net-next v4 11/15] net: ethernet: cortina: Validate RX
 fragment lengths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-gemini-ethernet-fixes-3-v4-11-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

RX descriptor lengths are used to adjust the page offset and populate skb
fragments without checking that the resulting range remains inside the
posted free queue fragment. A zero-length descriptor is logged but is still
appended.

The backing page is larger than the default 2 KiB DMA fragment, so checking
only the page boundary would allow a malformed descriptor for the first
half of a page to consume data from the sibling fragment. That fragment may
still be owned by the device.

Reject a short initial fragment before applying NET_IP_ALIGN, reject frame
length underflow and ranges extending beyond either the DMA fragment or the
page, and drop zero-length fragments instead of adding them to the skb.
Require the final frame length to cover an Ethernet frame and fit in the
current descriptor so a malformed chain cannot pass a short skb to GRO.
Account these descriptor inconsistencies as drops rather than wire length
errors.

The issue was found by inspecting the descriptor arithmetic and validated
against the Gemini receive descriptor definitions. The series was tested on
a D-Link DIR-685 with media playback and ksmbd transfers under ping load.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 943c31c02674..d8bafcdf4d5f 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1737,6 +1737,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned short m = (1 << port->rxq_order) - 1;
 	struct gemini_ethernet *geth = port->geth;
+	unsigned int freeq_frag_len = 1 << geth->freeq_frag_order;
 	void __iomem *ptr_reg = port->rxq_rwptr;
 	unsigned int frag_nr = port->rx_frag_nr;
 	struct sk_buff *skb = port->rx_skb;
@@ -1811,6 +1812,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			if (!skb)
 				goto err_drop;
 
+			if (frag_len < NET_IP_ALIGN)
+				goto err_drop;
+
 			page_offs += NET_IP_ALIGN;
 			frag_len -= NET_IP_ALIGN;
 			frag_nr = 0;
@@ -1819,15 +1823,28 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			goto err_drop;
 		}
 
-		if (word3.bits32 & EOF_BIT)
+		if (word3.bits32 & EOF_BIT) {
+			if (frame_len < ETH_ZLEN ||
+			    frame_len < skb->len ||
+			    frame_len - skb->len > frag_len)
+				goto err_drop;
 			frag_len = frame_len - skb->len;
+		}
 
 		/* append page frag to skb */
 		if (frag_nr == MAX_SKB_FRAGS)
 			goto err_drop;
+		if (frag_len > freeq_frag_len -
+			       (page_offs & (freeq_frag_len - 1)) ||
+		    frag_len > PAGE_SIZE - page_offs)
+			goto err_drop;
 
-		if (frag_len == 0 && net_ratelimit())
-			netdev_err(netdev, "Received fragment with len = 0\n");
+		if (!frag_len) {
+			if (net_ratelimit())
+				netdev_err(netdev,
+					   "Received fragment with len = 0\n");
+			goto err_drop;
+		}
 
 		skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);
 		skb->len += frag_len;

-- 
2.56.0

