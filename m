Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A34F55BE
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958315; cv=none; b=Kkhh7AlT15jgwPHApWRFYwbLXscTK3JWzTtUHGtZ8ZtlRjG1XeBVVnPndY2JEkUhkEnc9qxfy0rpDTbuma3u6xiTuvGUUL6TOl54G5dtezW06FgwS+fwJ74Spr+e/YYJITbkrVk5zK1NArbKESrpISzlJWOkWU5uzsSBtMHUlsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958315; c=relaxed/simple;
	bh=jqBE90iSh3BpuM0+8x9597WOQ0bFlXo6aKqYQjz18/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LJXvwnIZcruVhEuUiPqwcmPfLU76UOepfCyjYyDdpq+rrTk3EKfmdNTQF9kbsrkeMdxsP9AXh/dkZCKN2jQuDzgu98dzpJTfYD6jfKsCuWyey2eVVD1COK+Xy2XY2VWrG/T0WYDUFzXddTFJyuiAYwl9S2Xf/aksjWQ9Eqn4jSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dC/T7GC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dC/T7GC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37971F000FF;
	Fri,  2 Oct 2026 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958314;
	bh=ckmFqH6zVSX9DOa22jRAjvN3KsIHEDUyKNPX71G7Nuw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dC/T7GC4v9yWCkKstuvFOKMl5ZBHAtY3FPSOtCCDjaUY1j0LxtNxw6YRcH25m2WqF
	 JFaTzBX3Mdwlzz8Nh+3XbffVkXFZJ4C+mebnmEPmv2UDneH/K2pfxyzFoJdeznXWMI
	 6rIiNCynd4Tn9p+RG+S7kjejCVw9rCTmslY46hZ8PdohdityC8Jx8Ms2reWb+06tsP
	 1gQStgx+qVyPwAWyqDDe3wZmrdK0CeC0wDMz7dccevf33GJuTfoab8pmXAjVefTuUl
	 1khyJ+GIpgld5MuJ4bHrrwbQ+3RYnYnBMLe6Bqj1btYJRRnT85ybJ1QpIxKlgy8BMR
	 uU0kouT1L5ICg==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 02 Oct 2026 18:24:49 +0200
Subject: [PATCH net-next v3 10/12] net: ethernet: cortina: Validate RX
 fragment lengths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-gemini-ethernet-fixes-3-v3-10-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org>
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
Account these descriptor inconsistencies as drops rather than wire length
errors.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index a0186cc4b943..6b333eb81f9c 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1697,6 +1697,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned short m = (1 << port->rxq_order) - 1;
 	struct gemini_ethernet *geth = port->geth;
+	unsigned int freeq_frag_len = 1 << geth->freeq_frag_order;
 	void __iomem *ptr_reg = port->rxq_rwptr;
 	unsigned int frag_nr = port->rx_frag_nr;
 	struct sk_buff *skb = port->rx_skb;
@@ -1771,6 +1772,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			if (!skb)
 				goto err_drop;
 
+			if (frag_len < NET_IP_ALIGN)
+				goto err_drop;
+
 			page_offs += NET_IP_ALIGN;
 			frag_len -= NET_IP_ALIGN;
 			frag_nr = 0;
@@ -1779,15 +1783,26 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			goto err_drop;
 		}
 
-		if (word3.bits32 & EOF_BIT)
+		if (word3.bits32 & EOF_BIT) {
+			if (frame_len < skb->len)
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
2.55.0

