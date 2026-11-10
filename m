Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348832;
	b=dkUCramnkgcAQ82z0T+io/1m2H2w3yctPFDahOZsW2x6nBzks1R7VaQPLqThgcP9r19v
	 r56zaVl8COsAeR+zJK33S0YPdfaCUjEU3kFQ/BJsVCuXcItekUlGv7vcyvB5ElCDh71Ty
	 FlLvNX9qeG3aOLKb5PkZcVMEDALQlewfepvJZH/RXk+Qvn38n04PflYDpSp9xlYDtB+4G
	 1EchszFyk1yY18oHA5mxu0lj7NFFHWVS+YoBp8zMC40TXCZ0DK7vLIzoRBDhvX6UezPLE
	 oFDxgkfsQ/63vNrf6wwZwjmmtkwKU2Hs/bI9AEnTD/IpRyk59DqgXpV9gfqJhBDrQYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348832;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=0+4mI7awBwp3z0VCDnFi0fLdbvQFVtZ0FnhKivyg3b0=;
	b=IfT5l94ESuCHgijx5XtIcj2FP0DqwHQISJVFuIi/kJAxFi/vMztb/t3PWHYSL/yMZQEZ
	 xPcShly3+se3JHc3qwQNmGXVp5+9IOiXQo0SSqZ1FF83xnyZh/lGjfOBkKmBOaHDg46F9
	 WhGs6//cHQ7ti5QHOmcOSR4WWOXWacjK29rptJKt8bZBEut5mL0rLlzIECRaBvXUo7JFK
	 Iw5ZgZe0Tq0/MYgHzDtyNNBkqYmMx7zLepny5tk2+5wjewG85yF4QA6cTAkdFiV1mItSo
	 OS0MiVsRZGnFwFdrkAPukfyEpOAsGd4k6z1Akdk0jQ9BMY6Gtixruyp4IB4lcvX9c0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnqZNN9g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8F0606A33C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnqZNN9g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F431F008A4;
	Tue, 10 Nov 2026 22:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348831;
	bh=0+4mI7awBwp3z0VCDnFi0fLdbvQFVtZ0FnhKivyg3b0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bnqZNN9gRqFPLLQLTd4jhu0bRa3q+fzugFDs+2BSut7Ih/whKKfTJMV7/viVyyGHZ
	 4W8C/ox5G9sAGnKRTZjm5u1YylxVGLnde7LXwQVtd3Vdvq8h81OZJmfH3nUK9jI25+
	 +opBhfvC3pA+PSJqU0hsHnbI+5hioKK+40FFOtkQ8NORV26ZzARhY8J0pBIvzfnPyR
	 P3IFxS/dxk44wva4MLnQ/mmZpPMQrh2kS84aPvT7EB/WWJnjFjyi+RmUMYoE2JOQ7d
	 AdKrr25TMW5gJeKUVPlCQYcNMpv3qOnvrIehQGCCJ3hAPyYmg/syrHFwBxJdvGiBe6
	 60EOdfKOykNlQ==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:25 +0100
Subject: [PATCH net-next v7 10/18] net: ethernet: cortina: Validate RX
 fragment lengths
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
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-10-9c32a1a46aec@kernel.org>
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

RX descriptor lengths are used to adjust the page offset and populate skb
fragments without checking that the resulting range remains inside the
posted free queue fragment. A zero-length descriptor is logged but is still
appended.

The backing page is larger than the default 2 KiB DMA fragment, so checking
only the page boundary would allow a malformed descriptor for the first
half of a page to consume data from the sibling fragment. That fragment may
still be owned by the device.

Reject a short initial fragment before applying NET_IP_ALIGN. Validate the
final fragment length derived from the total frame byte count, rejecting
underflow and ranges extending beyond either the DMA fragment or the page.

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

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 42 +++++++++++++++++++++++++++--------
 drivers/net/ethernet/cortina/gemini.h |  2 +-
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 4dfc8325eb72..ddda4a9c236b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1749,6 +1749,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned short m = (1 << port->rxq_order) - 1;
 	struct gemini_ethernet *geth = port->geth;
+	unsigned int freeq_frag_len = 1 << geth->freeq_frag_order;
 	void __iomem *ptr_reg = port->rxq_rwptr;
 	unsigned int frag_nr = port->rx_frag_nr;
 	struct sk_buff *skb = port->rx_skb;
@@ -1823,6 +1824,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			if (!skb)
 				goto err_drop;
 
+			if (frag_len < NET_IP_ALIGN)
+				goto err_drop;
+
 			page_offs += NET_IP_ALIGN;
 			frag_len -= NET_IP_ALIGN;
 			frag_nr = 0;
@@ -1831,15 +1835,33 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
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
@@ -1847,11 +1869,13 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
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

