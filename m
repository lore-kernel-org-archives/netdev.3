Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728305;
	b=XvfOhYtXoT5GpKvG/v/G9ioZHbmTlK1wwfGfNuYf+1YuM+p5uv8h6WkEWGjbfPChFnHN
	 FlFeEPdSsnFrTfhCsG/Wyyvm5D0LzNWp8rOFGw99v9uBPSCWS7F2JWeKOW3bq52T9baDp
	 ESHNByUaB3yhJ8a5oQCbp46EoQplduIuyQhQv6KFjqDKWYuTU3difrtoLNflkkIszRD48
	 Dazp7P1Fslb0ndcdPgJ3RlHFSpaeijRV9pRH7KzDlUbjJbrkSmf//lIETyEBSoD+HlZH6
	 vSselLW93PmYQpWfhvL79Q1Hyr4Sc3umhMZKEOUsOpJZei+tMVs1FldoLHJYYkxT36g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728305;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=B/vd+1ziogt4gTwuNY2K8+9IdPfACPoCAEx0hccR5ig=;
	b=qbANLHh46VbtSJK5OoGH3FRXu48e9g4xSIc2DMM6ImmMa4Jhi/1NbisJ+5MbgvD35S/o
	 GZ4zH0Me8BNs75TzqX1W7YvYnAyyaw9lhIEBNOe3l/zfSZcEOC0C7zL0jyg5Ox3lgZhSi
	 qKh4fEv11bL2FY9C7xR5XihD6Jg9WDtuKbEKWDtdcbwJBA/3KfhIBNSjsLzqE3iLY1Nih
	 9Gp7r1O5LbLCqo37yvGMIAZ1nFz/XGRtznd4sMHgEq1UX99hSl9e4M2NgeP+k6h1U2lrv
	 jhhD06mZBYEKGYjRX88YRAJnZ6uru9oFVZe8qO87RR9MTQep2Y2q/x9eDZ2bM4aNbOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUnCR7oP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B297606A328
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUnCR7oP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14AC1F00919;
	Tue,  3 Nov 2026 17:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728305;
	bh=B/vd+1ziogt4gTwuNY2K8+9IdPfACPoCAEx0hccR5ig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hUnCR7oPQ8DQX5hHQvSTEnEvSfZlArrLi2cNxMEw7CL4PwN/jUFnd0G0h0dBoPLga
	 mDoQqSnuQgsU9wrDqLjkFHzH5qHJ8YbjOBu0hfQy5+d+O1AFRSmXj3uQ4as/5zq0jW
	 aS9caZvj+trhHN/4Kw86xnVUGB8N8l5Duj/WPxiTem8cJ9/2azHlwgCgPyZRtmkJea
	 Q69g4Cg6aQrXxz0U9fm+XqFdMSpFBMiUcKpvpVyjd5dqU/WfGz9LzGmvmpa4FqhF/h
	 xWSulpznnX9XRGPHOGiXcmr6IALHINd/RTeBBeg2iWyNWNN98Y0qqh+4HVVE14ygWE
	 30NHsh8xHHytg==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 03 Nov 2026 18:51:21 +0100
Subject: [PATCH net-next v6 10/15] net: ethernet: cortina: Validate RX
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
Message-Id: <20261103-gemini-ethernet-fixes-3-v6-10-c4b5ff8a65d8@kernel.org>
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
index 25121325f219..972119080c2e 100644
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

