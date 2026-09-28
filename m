Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2C548FF82
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585464; cv=none; b=VqdqFDy5/za+eHFp0kahaksfi4W1TgHXJmjz0floi4CnB21hTEi/ITy/KvO2RgWaOpTNYRElJsZKDP7ZRdTtsZrfaSqrpHbVsDAHUlge8UJImKELkVamAhhEUAoV/fsn9EULqjyehWtPixlbG3PfWGsZIjiQL5unVAnww5SnIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585464; c=relaxed/simple;
	bh=cjCQN6vXNzSkai7l902An+M3DCrg55uEsY9fabF3IHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y6TI66CgucBYvkkwPtLYxfd5XOwt2YK/8axTG7RqE514TGk7AoR69wfX5LFDk4TI+BMgPmL0pQgYqoihfOHshORk05h2B+XTjtrzEIlckT7yLLtZjcJZP/PA9I2h3Rnt19MnZ40irk1HHTlhNETH7ha3oBRr5y2MB2NeOEsAygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrK7TN8n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrK7TN8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2371F00899;
	Mon, 28 Sep 2026 08:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585462;
	bh=yUFgs5UunkX8+0xQ42E3JVGh+4yMdsGPqprv28m3SV0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jrK7TN8n1spXbIBtdONGqKeCaB5Q4j2lvZUBXqnr9lhA0OG96v8rP9Ig03nKFvD6f
	 cKzl54Z1cYfFtpQglBW2Yd3lL8OWAfz3dhz7w2IiU7TRrE+IPb78RzLVno8r55Vdlj
	 VS/G3WGlnKvt6S3JyG7e81v3BpW6APSIJvIymVtpZ3jzjTNaBVc+6BA0ITNPsrHOl/
	 uq32c5CAi9dvAsugrYU/vpKJJFColoa4r6fxDHuKnElRlS+MK6pVame5KXGHPmZj6S
	 GycM5S7Q8MJqgLQKAhNtUxwE230n9ADneJMAlfGcgcOfHzY5I/ruQJqBcfSYCVnhGw
	 Pg7ivePBHmihA==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 28 Sep 2026 10:50:34 +0200
Subject: [PATCH net-next v2 08/11] net: ethernet: cortina: Validate RX
 fragment lengths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-gemini-ethernet-fixes-3-v2-8-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>
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
Count these drops as receive and length errors.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index d677d7431ab2..258bb44d5570 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1593,6 +1593,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned short m = (1 << port->rxq_order) - 1;
 	struct gemini_ethernet *geth = port->geth;
+	unsigned int freeq_frag_len = 1 << geth->freeq_frag_order;
 	void __iomem *ptr_reg = port->rxq_rwptr;
 	unsigned int frag_nr = port->rx_frag_nr;
 	struct sk_buff *skb = port->rx_skb;
@@ -1667,6 +1668,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			if (!skb)
 				goto err_drop;
 
+			if (frag_len < NET_IP_ALIGN)
+				goto err_length;
+
 			page_offs += NET_IP_ALIGN;
 			frag_len -= NET_IP_ALIGN;
 			frag_nr = 0;
@@ -1675,15 +1679,26 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			goto err_drop;
 		}
 
-		if (word3.bits32 & EOF_BIT)
+		if (word3.bits32 & EOF_BIT) {
+			if (frame_len < skb->len)
+				goto err_length;
 			frag_len = frame_len - skb->len;
+		}
 
 		/* append page frag to skb */
 		if (frag_nr == MAX_SKB_FRAGS)
 			goto err_drop;
+		if (frag_len > freeq_frag_len -
+			       (page_offs & (freeq_frag_len - 1)) ||
+		    frag_len > PAGE_SIZE - page_offs)
+			goto err_length;
 
-		if (frag_len == 0 && net_ratelimit())
-			netdev_err(netdev, "Received fragment with len = 0\n");
+		if (!frag_len) {
+			if (net_ratelimit())
+				netdev_err(netdev,
+					   "Received fragment with len = 0\n");
+			goto err_length;
+		}
 
 		skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);
 		skb->len += frag_len;
@@ -1698,6 +1713,11 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 		}
 		goto next_desc;
 
+err_length:
+		if (!dropping) {
+			port->stats.rx_errors++;
+			port->stats.rx_length_errors++;
+		}
 err_drop:
 		if (skb) {
 			napi_free_frags(&port->napi);

-- 
2.55.0

