Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B83815F8
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077882; cv=none; b=hSoVpItJ2f1GnVjQdlKjLAOezV7BKVdWSQkd90DrQmnMtZKBTL5mCmiaONbdEI5CUEkPA/mRIrG6MpEbbePfK04vmWfeddWgiZUsFTB28Igz3pA5KZUxPytVAZmpcscxh7M1dWloVUPStOI39UA7UeFnyij3IM6KHkYaN8I0sHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077882; c=relaxed/simple;
	bh=eg4QsXktbQS3+yzJnzRWdgqnAb5kUBwBHaAWWYt9SvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YHVhjLz0WayX4eSn5CytguYs825EswLX2xq7SA4DQOHonTlgw86FF3wE5w+0DcZTvz5Swm9Vx6vXyn4l4XT5UZCImEKdQKCxdG13bZ9EX729zHiHteX9PCuTIIlPkvVbxdlc89VJKRe5k0M27oJR4z8THjOhhAA+8GVQqxOUmq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5PaJaRh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5PaJaRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C781F000C8;
	Thu, 15 Oct 2026 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077875;
	bh=5Ll2+7WqEpvu3+mBjdWTyxtNZUUWH8cee3FZ7BBz9W8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=K5PaJaRhpcUvojF6LulfcIfOatu29gg7ajZNhZMbtEHzjcqX3GvSVH9m7gAoMChbz
	 OOaEpsMzdRPfzh9aORcYCgFGM+I52dM7IwELVD+rHeN/eRm/Px8/1Pr1WAJkURJUsW
	 9emDDvd0Yv4fhsRz1PnNamPrrbc/PIGqEXSuxUc5uFQ9jpX5M/B79fxMPQahLO/ygI
	 sV7Z3E9QBxKOEZsUVcaWb41sQ0+u81GCEyZEuHLVsGv1UsNCTXb3ZDzhOro3VFYKyP
	 L48F9GfNclXc0WXUffaylhJmg8QqxxlEaiFvWTpa6fPHsbY9q3sonQBGhkNA4c8av8
	 Aubn2/BaO3HAw==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 15 Oct 2026 17:24:10 +0200
Subject: [PATCH net-next v5 10/14] net: ethernet: cortina: Validate RX
 fragment lengths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-gemini-ethernet-fixes-3-v5-10-b5c9e2f7b8a3@kernel.org>
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
page. Derive the final fragment length from the total frame byte count
rather than treating the descriptor buffer size as an EOF payload length.

Drop zero-length non-final descriptors. If an EOF descriptor carries no new
data after earlier descriptors completed the frame, release its unused page
reference and pass the assembled skb to GRO. Check this case before the
fragment limit so an empty EOF can terminate a full fragment array.

Correct the copied buffer_size comment to match the Gemini manual, which
defines it as the transfer buffer size associated with the descriptor.
Require the final frame length to cover an Ethernet frame so a malformed
chain cannot pass a short skb to GRO. Account descriptor inconsistencies as
drops rather than wire length errors.

The issue was found by inspecting the descriptor arithmetic and validated
against the Gemini receive descriptor definitions. The series was tested on
a D-Link DIR-685 with media playback and ksmbd transfers under ping load.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 42 +++++++++++++++++++++++++++--------
 drivers/net/ethernet/cortina/gemini.h |  2 +-
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index e42eeefd4d19..70aa418d7037 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1745,6 +1745,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned short m = (1 << port->rxq_order) - 1;
 	struct gemini_ethernet *geth = port->geth;
+	unsigned int freeq_frag_len = 1 << geth->freeq_frag_order;
 	void __iomem *ptr_reg = port->rxq_rwptr;
 	unsigned int frag_nr = port->rx_frag_nr;
 	struct sk_buff *skb = port->rx_skb;
@@ -1819,6 +1820,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			if (!skb)
 				goto err_drop;
 
+			if (frag_len < NET_IP_ALIGN)
+				goto err_drop;
+
 			page_offs += NET_IP_ALIGN;
 			frag_len -= NET_IP_ALIGN;
 			frag_nr = 0;
@@ -1827,15 +1831,33 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			goto err_drop;
 		}
 
-		if (word3.bits32 & EOF_BIT)
+		if (word3.bits32 & EOF_BIT) {
+			if (frame_len < ETH_ZLEN ||
+			    frame_len < skb->len)
+				goto err_drop;
 			frag_len = frame_len - skb->len;
+		}
+
+		if (!frag_len) {
+			if (word3.bits32 & EOF_BIT) {
+				put_page(page);
+				page = NULL;
+				goto complete_frame;
+			}
+
+			if (net_ratelimit())
+				netdev_err(netdev,
+					   "Received fragment with len = 0\n");
+			goto err_drop;
+		}
 
 		/* append page frag to skb */
 		if (frag_nr == MAX_SKB_FRAGS)
 			goto err_drop;
-
-		if (frag_len == 0 && net_ratelimit())
-			netdev_err(netdev, "Received fragment with len = 0\n");
+		if (frag_len > freeq_frag_len -
+			       (page_offs & (freeq_frag_len - 1)) ||
+		    frag_len > PAGE_SIZE - page_offs)
+			goto err_drop;
 
 		skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);
 		skb->len += frag_len;
@@ -1843,11 +1865,13 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 		skb->truesize += frag_len;
 		frag_nr++;
 
-		if (word3.bits32 & EOF_BIT) {
-			napi_gro_frags(&port->napi);
-			skb = NULL;
-			frag_nr = 0;
-		}
+		if (!(word3.bits32 & EOF_BIT))
+			goto next_desc;
+
+complete_frame:
+		napi_gro_frags(&port->napi);
+		skb = NULL;
+		frag_nr = 0;
 		goto next_desc;
 
 err_drop:
diff --git a/drivers/net/ethernet/cortina/gemini.h b/drivers/net/ethernet/cortina/gemini.h
index d359c633c5de..43006fe44c9f 100644
--- a/drivers/net/ethernet/cortina/gemini.h
+++ b/drivers/net/ethernet/cortina/gemini.h
@@ -519,7 +519,7 @@ struct gmac_txdesc {
 union gmac_rxdesc_0 {
 	unsigned int bits32;
 	struct bit_8060 {
-		/* bit 15:0 number of descriptors used for the current frame */
+		/* bit 15:0 transfer buffer size for this descriptor */
 		unsigned int buffer_size:16;
 		/* bit 21:16 number of descriptors used for the current frame */
 		unsigned int desc_count:6;

-- 
2.56.0

