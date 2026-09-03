Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E633C18B
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471938; cv=none; b=KQcaI1zeyUO1wHmZiXadxVVvsN62xE2+zm2jVpxILGzSFwSRcxFX/LyiPxH6Nap49T8ROr9Kiahrx+UH2rqKZmq+fk5fnKth16ohQoozLVkdKDfg1wG7Q6NyD3Bcycjm1sncCJWqObQd900Ntqq+LalIAazcjpRuKvWZEuQYdoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471938; c=relaxed/simple;
	bh=qk6Jgnk9jY7mBhX90Ks0aqNubb4hFG5CsqtPLa8F2l0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sfQIB27ZW5dNncMKyijVc8CfuZrPVtAB+WIjH7OXEOLXoYWARZHehcnpa+v/SZp3I+LOWzu+YjognjWRLCUFaJ5wDUjrZAm8Kgp/XjMFtyuZKcqqY/cucVYnHPliJ3hNDdZ8D2hGxcnBwtVYyBix1i77GWCptiBWIyx4h1hgo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3bOffZd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3bOffZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE9F1F00A3D;
	Thu,  3 Sep 2026 21:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788471937;
	bh=B8B2nnTj040O1zxcTTABBjjduUmVhHBej0FWYUDnj3Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b3bOffZdvAEAbDpqYVBdhEg1XIs2+jqh2HqKoFXbQIBocb3KcRand6/krChmYiWTo
	 YSNMOCDq9pJfRn1x10njzqvW+ALu+dU6T4bZFIuQTAjB6UfTjXfb2h6Dtci3rtuulf
	 jvvF8M1P8YanVAG/LL4q/cl5Gl1AZxBPN8aZvuPfaFNdXmE1KXBKhnbqQv5PDMclXn
	 FEcHqICoQGjRgp1r89s33kY5KKa3ksDNm0IctB5KbWb9NoKavX6QpBf+n2MCMnQ+LV
	 VHDmfe9duKF5LQ2I8718fOhBJebmjAnhmUlBUd0qdOh+9vmjHDfIr6Fvpqp8R72mFJ
	 49s3u9jTh/8rQ==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 03 Sep 2026 23:45:29 +0200
Subject: [PATCH v2 1/5] net: ethernet: cortina: Fix budget accounting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-gemini-ethernet-fixes-v2-1-2bbbd598ca6e@kernel.org>
References: <20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e@kernel.org>
In-Reply-To: <20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Joe Damato <joe@dama.to>
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
Reviewed-by: Joe Damato <joe@dama.to>
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

