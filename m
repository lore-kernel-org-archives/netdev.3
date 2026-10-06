Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A6537C0EC;
	Tue,  6 Oct 2026 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791265320; cv=none; b=CKvXK9GCZlFbvbYBdT8OolDOB2XHUOOqI0iG6b3Nfw9kLJxJXN1prYsmkDS1MBXcPJFRTbDjLijN44ULlKAkvaEcK4Hu1w6TC1rPwJx77zf8+bOf8xpOVNFuFmGAmN9B7v43R+ZbjQgtv0HhJFOmIFadjbYcD1wDStqCzbxrP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791265320; c=relaxed/simple;
	bh=VQSWNFQs2h/Y6XuSz8DMOSEEKDyIFOkxPI9Vh9REniY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOqqe0QCMghH3BaUILyiOuz8unf+NuL4Pn6rxcRPQfghu+xgiV4A6v3EZXAGIfFZB/BbzOqq+hHjm9t8yKo2CEF0BGLo1+Ldk3XEL6+c7RH/RdsBrjmyFXn16gFd1Bqp+o5Rf7WST8BU69jgbcRj3Ylz7XmIhzKGAzAh+9mYmOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=pur1YrXQ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="pur1YrXQ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B9C1A0EC1;
	Tue,  6 Oct 2026 07:41:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791265314; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/Q7jgyTwBB/OtmKIXh335HAkWTa4A7tbcanPZgwOpzU=;
	b=pur1YrXQIZ5f4xMTP+pZJ1oilOeGTYw6oKxX4axfCpgemx31Q6Gi87BL8ZDvYey0a53aZu
	COih7JvgsTob1XL3Hn0JT06WNfxC+lEgtIPrKK5r8/GMl+jylyUv1eXNneNkXLv0kehJ1F
	8SBl/HPDQKw5JXMUMyQdDhmlZn+8v962e2Gk+tPvav1pRzkhJ8kRUQ+w4IvAatmzAyzQve
	TlJLwKsIFaWTB+mF/iHoiTexVE342hy23174OgTaibLPC9QCSVs6M/ZN5VcVFiFurzNzEP
	4l2mhsZ9PU0mXvnnhOLL5ivJlnCiew2Bls6RcfynZ6wmyTuCiDmqz0tz3YP63Q==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 06 Oct 2026 07:41:33 +0200
Subject: [PATCH net 2/2] net: macb: copy shared skbs before appending the
 FCS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-nb-macb-shared-skb-net-v1-2-a80641479041@tipi-net.de>
References: <20261006-nb-macb-shared-skb-net-v1-0-a80641479041@tipi-net.de>
In-Reply-To: <20261006-nb-macb-shared-skb-net-v1-0-a80641479041@tipi-net.de>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

macb_pad_and_fcs() appends the FCS in place when the skb has tailroom.
A shared skb, as pktgen sends in clone_skb mode, grows by one FCS per
transmit. BQL then completes more bytes than were queued and
dql_completed() hits its BUG_ON.

On a Raspberry Pi CM5 (RP1 GEM) pktgen with clone_skb 1000 burst 32 at
60 bytes kills the box within seconds.

Copy shared skbs before appending the FCS. Clearing IFF_TX_SKB_SHARING
would also fix it but makes pktgen refuse clone_skb on macb.

Fixes: 653e92a9175e ("net: macb: add support for padding and fcs computation")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6082e63009a5..261a7e87520a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2435,6 +2435,7 @@ static int macb_pad_and_fcs(struct sk_buff **skb, bool add_fcs)
 		      skb_is_nonlinear(*skb);
 	int padlen = ETH_ZLEN - (*skb)->len;
 	int tailroom = skb_tailroom(*skb);
+	bool shared = skb_shared(*skb);
 	struct sk_buff *nskb;
 	u32 fcs;
 
@@ -2443,7 +2444,8 @@ static int macb_pad_and_fcs(struct sk_buff **skb, bool add_fcs)
 
 	if (padlen <= 0) {
 		/* FCS could be appended to tailroom. */
-		if (!skb_is_nonlinear(*skb) && tailroom >= ETH_FCS_LEN)
+		if (!shared && !skb_is_nonlinear(*skb) &&
+		    tailroom >= ETH_FCS_LEN)
 			goto add_fcs;
 		/* Reallocate with room for the FCS. */
 		padlen = ETH_FCS_LEN;
@@ -2452,7 +2454,7 @@ static int macb_pad_and_fcs(struct sk_buff **skb, bool add_fcs)
 		padlen += ETH_FCS_LEN;
 	}
 
-	if (cloned || tailroom < padlen) {
+	if (shared || cloned || tailroom < padlen) {
 		nskb = skb_copy_expand(*skb, 0, padlen, GFP_ATOMIC);
 		if (!nskb)
 			return -ENOMEM;

-- 
2.53.0

