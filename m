Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354335;
	b=4wFUTREus9C36DV9asyiwQFOkVbsQFM2qlkI6w9UR8Mug3QYOvztEqA3LWjWD01U8OH7
	 Vixlg2pXCiPEjEuRgUR47+5o88gCOoANZ8hgM7QOkvB/9nDBNPDoWIJZ2iEdoHtLIGKW9
	 aF2A/yfbZimI78S96u/JeYpvq+NDqxZv6s2AlaA2jEP31zFaQMiMjsHbMhawSnddKncmv
	 Uf77Jmk7gXi4ufY2Y6Umw19xyar4pnZvtIreg3UYxifqKpDV81bPRP93sbL0zmypQdIhN
	 UL9a/36+iVyav5eawAsYEXsvkXp9EWi8SQytVjcb5XNjgWdQFlJgqvXrcI7+FLX78xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HosWUHlaOYuMVF37Fh9a12drQIP+JeWidriSfMU7poY=;
	b=1cgiQtypT3trGOawGbTTJjA8vRnAAmA/cQnDZjgmeamMRQIXEogWVdwkX8jRMdHr9c15
	 jnsTX8fj4BZpQ9CTBFZRzPJO7jCPzuKtbSckG5eSMYGDA4VpalcCvx4E7Mp24uTCE5DEO
	 hdKJZ2WBRez8C9PPJolYu/uLiKSCk0nkeZxgccSBKEdkfLPLPnqLFyQAdn09p8xKcXTRI
	 kG+EFpviO3E/HjgDzsX6P76knRFRjxvsEWkhRKY9YiD/BXt5+23Ak/YZyg4rTIxzuQyI7
	 RfPRAgqYS77pQooTVi86taxsWsgvdF2Sr/W19Sbb6o9RAalLd4s/pMb6+s2WCU3g9Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U+ymGBNC;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D19260A2612
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D19260A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U+ymGBNC
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15ea896ddc8so4146483c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794354334; x=1794959134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HosWUHlaOYuMVF37Fh9a12drQIP+JeWidriSfMU7poY=;
        b=U+ymGBNC6OVC6wHzIDDuOq7gpUfDwFrZtfjOK9r4ChPjwFGEd/fgTJEg25RWl/pnZl
         pzBnHyYxKw8e14ynGm+aoFImFAzIgXOBNS7fWL5dEFvlypcAO8BhRcQfwxFLrQuq5+gQ
         mQxyHNnBukUYTX1ZHiHxUmhfY+yJ1VW6DAmF80Chh7F9Hzb3wGuyjQj1w8kcakl8yBPI
         lsva5gauW+yK4kDTduJ/LPwtrbHo3ABT15EC1a4cCHZDVzrSfP7mKVkG+I2UtuUDJM+l
         BYGJ6HXtsxbXQe7su6MLyw6hlBhkiQdCHq8gpuhcUE9xUOPSfbmhsLh880De9L4dPq0V
         dKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794354334; x=1794959134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HosWUHlaOYuMVF37Fh9a12drQIP+JeWidriSfMU7poY=;
        b=yE9wZdn7EgEBh262F7c7/33DneuucPxfD1iOZHIXx4D/yN9mfNPvAhPRImG//39y+G
         OLYGxwkFVwb803rqiC0UsBeNjCmSDzWWdbQpNMG5VsXJTLFLQkYttgoDI+Wxpm3A99ER
         tuhnDyz5U+K+8o7FDTrHZ/HUNou2ZdV82KMlbJ4/TxeHL+mBPT94L2X8OYs8tyZv9q2Z
         i7YOp31srk6woyr0YPbPZ3rh6vV4GwHG9bhE153zTXgxkjsN1cY5ee4DMT4iMnWnD9Zm
         /8SF7ybKY+g2JhkNrvlKWixJbZ9idlGVrbDSItDIgir8lYhWQvDyaDXtvXzhShtVXrrw
         vDSA==
X-Gm-Message-State: APuU4Z8XAiA/MR9Uesw++9I0EU2ZIPkhoYh2eXFIRvcj8Ux1urYGQgB+
	btSuYzWmGTmg8k/AtNsubdtBu4cX01aYIiIUxjyiqfMHLfK9yVTZhooDJDzgMA==
X-Gm-Gg: AYBFou1U4/CZOM99O3nshO1UuxYvq0Z/q/jXWQ5NZdL/e+ctMf1CdA4NGFcnbVqHhsL
	E3FCuArqCMV1B7+mv/hqPe80/ic0n2Z+xx5MzeTZe1QGXJM2U0gJXIcX8XWdSa/2jco+dUZomFy
	SUa5tpTiQT774KJK4YsZnnBXXpvBDS/oZWquUXFXqCFOZpnvc3D4YcOlbqQeYNLED8/SPT6MOf8
	cexTiTc5ZOqP7dIspLy/zH8uPYn0+KF6/xyRj7ibXUo/bWFXGx0nJSTyckFCgVx0fF9V5Rgpocd
	ExVLMl0xGRr+Fluci+pzDTeIZ501twULN30P+v0XonjNwUWsVrwEojaTe+YdIiLmHr8jq7aTUzl
	+ZH5FjdvwAO9lapgE656Nv4iAD1tV2pcOW47b8BVuyvfYMBPnC2QnsyUBHRDwlzs1eVaiQQO4Bv
	/JBfOjVBppEHEJ/iNryX3zZgK0cv9GhsEAK2GaYrkgJXMUggEP1+4uk7ANndA/jAaqhLBzeCAAC
	Md0qAIWPugNkibXMpuuGMBS6tsogB9dtaXNOwwziynzm9PfW7x+PR17SXwb8dcCItC7rpoceLlT
	ZGYCrzEfeInMnHgo8wTAVztAlAkdTg==
X-Received: by 2002:a05:701b:21c8:b0:1b3:ae32:7a57 with SMTP id a92af1059eb24-1b3c036a2ccmr615467c88.47.1794354333685;
        Tue, 10 Nov 2026 15:45:33 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b20c55sm9145881c88.8.2026.11.10.15.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:45:32 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 4/4] net: sb1250-mac: Fix RX checksum status and header offset setup
Date: Tue, 10 Nov 2026 15:03:00 -0800
Message-ID: <20261110230300.2769327-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110230300.2769327-1-f.fainelli@gmail.com>
References: <20261110230300.2769327-1-f.fainelli@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The receive path tests M_DMA_ETHRX_BADTCPCS in descriptor A, but the
hardware reports it in descriptor B. Bit zero of descriptor A belongs
to the buffer address and is clear for the aligned receive buffers.
Consequently, a frame with a valid IPv4 checksum and a bad TCP checksum
can be marked CHECKSUM_UNNECESSARY. Read the TCP status from descriptor B.

The IP header offset setup also only masks the old register value due
to the combined AND/OR expression. Split the mask and field assignment
so that the intended offset of 15 is actually programmed.

Channel startup clears the receive filter register, losing any offset
set during probe. Program it again before enabling reception on every
channel start, including link changes, and preserve it when enabling
unicast and broadcast reception.

Both bugs predate the RX checksum feature advertisement. Sashiko AI
reported them during review of that change.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/sb1250-mac.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
index 433aa1e24439..7998ab9fc46c 100644
--- a/drivers/net/ethernet/broadcom/sb1250-mac.c
+++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
@@ -280,6 +280,7 @@ static void sbdma_tx_process(struct sbmac_softc *sc, struct sbmacdma *d,
 			     int poll);
 static int sbmac_initctx(struct sbmac_softc *s);
 static void sbmac_channel_start(struct sbmac_softc *s);
+static void sbmac_set_iphdr_offset(struct sbmac_softc *sc);
 static void sbmac_channel_stop(struct sbmac_softc *s);
 static enum sbmac_state sbmac_set_channel_state(struct sbmac_softc *,
 						enum sbmac_state);
@@ -1145,7 +1146,7 @@ static int sbdma_rx_process(struct sbmac_softc *sc, struct sbmacdma *d,
 				/* Honor the RX checksum offload feature setting. */
 				if (dev->features & NETIF_F_RXCSUM) {
 					if (!((dsc->dscr_a) & M_DMA_ETHRX_BADIP4CS) &&
-					    !((dsc->dscr_a) & M_DMA_ETHRX_BADTCPCS)) {
+					    !((dsc->dscr_b) & M_DMA_ETHRX_BADTCPCS)) {
 						sb->ip_summed = CHECKSUM_UNNECESSARY;
 						/* don't need to set sb->csum */
 					} else {
@@ -1496,6 +1497,7 @@ static void sbmac_channel_start(struct sbmac_softc *s)
 	 */
 
 	__raw_writeq(0, s->sbm_rxfilter);
+	sbmac_set_iphdr_offset(s);
 	__raw_writeq(0, s->sbm_imr);
 	__raw_writeq(framecfg, s->sbm_framecfg);
 	__raw_writeq(fifo, s->sbm_fifocfg);
@@ -1549,7 +1551,9 @@ static void sbmac_channel_start(struct sbmac_softc *s)
 	 * Enable receiving unicasts and broadcasts
 	 */
 
-	__raw_writeq(M_MAC_UCAST_EN | M_MAC_BCAST_EN, s->sbm_rxfilter);
+	reg = __raw_readq(s->sbm_rxfilter);
+	reg |= M_MAC_UCAST_EN | M_MAC_BCAST_EN;
+	__raw_writeq(reg, s->sbm_rxfilter);
 
 	/*
 	 * we're running now.
@@ -1717,7 +1721,8 @@ static void sbmac_set_iphdr_offset(struct sbmac_softc *sc)
 
 	/* Hard code the off set to 15 for now */
 	reg = __raw_readq(sc->sbm_rxfilter);
-	reg &= ~M_MAC_IPHDR_OFFSET | V_MAC_IPHDR_OFFSET(15);
+	reg &= ~M_MAC_IPHDR_OFFSET;
+	reg |= V_MAC_IPHDR_OFFSET(15);
 	__raw_writeq(reg, sc->sbm_rxfilter);
 
 	/* BCM1250 pass1 didn't have hardware checksum.  Everything
-- 
2.53.0

