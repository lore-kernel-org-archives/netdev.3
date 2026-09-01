Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79853BADA3
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282302; cv=none; b=YOIeLYMoDg4rGBHaA1yv3F/cq0K6uzl5JVJaKKA5dMdYdiZhPa0YwUcL/o+CzvdUiHSUy5ReYwkO4DeUgkJraSkK+ZnkWgdgdElRQdJIkUqbhfWwpfBYr10Ipdn42dT1vuCnqaJhtxpOPXa/empfXIIu4FL0jYaOER7JKoj5JR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282302; c=relaxed/simple;
	bh=aaiEewxYAXbCj7pU6U1S4exdGIfGP1ysTlgCQDwfI3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OGQj2bbO6GT2rmSDsn+hiz30w/ku4wRj1n7EkiEkymu4tx0SiNBHX+vPYV+57Jdv39zvvvkVweW43u9n8/7sEbv1AdvKk1jI75r+ZZ8/rjqJ45ox/gmmmSHcHwzvGBG+fsm2FQILO23lCAcpvjqTc9Cz/wmM5aDUAT6Oa28VXdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXBMLVuI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXBMLVuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BDB1F00A3A;
	Tue,  1 Sep 2026 17:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282301;
	bh=GPTlbEk1u36PwpgldGXd6D4/BMuaS5Mu/Fv91BAQhYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KXBMLVuIxwhQ4ZWk5ETsPtA1EZ1Yslcv3A7Amabr2DJyPgu+XSI/IpRoeCZsR0nc+
	 KwBrgNBf34m54VtOog0El+iAnzeBqkB9vUh19Sc1CiBYq93KXfaShU2NyH2Pq4/sDh
	 BdMEe7uE/RyPJLveHn+g2fUyilDLMVTVU9v3hnjj7daNw20aNydACFOP9bnFPYBtx7
	 w709GUwW2QV5FKNYc4CV6FFR/0b101VC9HxIgWKVC6NppsNKlcm6MtbDNjuz94lqL0
	 +wnQlJQFa00d0CmMsu0yIfR+imxDkyquGJo1tnFSU82MzNwI66A5o+8jTtsykgGwj1
	 KU/Qk6NkDUjAw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 01 Sep 2026 19:04:55 +0200
Subject: [PATCH 1/3] net: ethernet: cortina: Fix budget accounting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-gemini-ethernet-fixes-v1-1-ee6b09675876@kernel.org>
References: <20260901-gemini-ethernet-fixes-v1-0-ee6b09675876@kernel.org>
In-Reply-To: <20260901-gemini-ethernet-fixes-v1-0-ee6b09675876@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The gmac_rx() function returns the remaining NAPI budget, but its
caller treats the return value as the number of packets received. An
idle poll therefore reports a full budget and remains scheduled.

Return the number of received packets instead. Preserve the existing
free queue refill accounting by adding that count directly; continuing
to subtract it from the budget would invert the refill behavior.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Link: https://lore.kernel.org/r/20260509-gemini-ethernet-fixes-v1-4-6c5d20ddc35b@kernel.org
Link: https://lore.kernel.org/r/20260512131456.189452-1-pabeni@redhat.com
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 4c762229ce42..1d9824d1716c 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1450,6 +1450,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
 	struct gmac_queue_page *gpage;
+	unsigned int received = 0;
 	union gmac_rxdesc_0 word0;
 	union gmac_rxdesc_1 word1;
 	union gmac_rxdesc_3 word3;
@@ -1545,7 +1546,8 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 			napi_gro_frags(&port->napi);
 			skb = NULL;
 			frag_nr = 0;
-			--budget;
+			budget--;
+			received++;
 		}
 		continue;
 
@@ -1565,7 +1567,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	port->rx_skb = skb;
 	port->rx_frag_nr = frag_nr;
 	writew(r, ptr_reg);
-	return budget;
+	return received;
 }
 
 static int gmac_napi_poll(struct napi_struct *napi, int budget)
@@ -1586,7 +1588,7 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 		++port->rx_napi_exits;
 	}
 
-	port->freeq_refill += (budget - received);
+	port->freeq_refill += received;
 	if (port->freeq_refill > freeq_threshold) {
 		port->freeq_refill -= freeq_threshold;
 		geth_fill_freeq(geth, true);

-- 
2.55.0

