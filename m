Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992486;
	b=hMQthNXzbVfNgzV6QLccwcki9lnFXjHr9P35mem2OCB7iX4CVU1X810Jr7hdL4EtA7xc
	 S6ztWc34F6DGVI2aV8oIS4W0VqhobupC5Qb+GOOrVY0rB7z1XJ9hAoQeK99u1yAm9RCgH
	 cS5HLCoXFRcQxxRs4/FNr51n+m9MfV0SBFwTxj5yNfwN135Mm6CbuYQbxjx/AFMI/RKp0
	 IUDUcgzPcM/4JC2r90svoXcjrZNOnzR45/H4aX1i0i+K0w7uW9BsKpWrrxQP4BLxPMXX8
	 sbWVei8C5VvM8RZVKIGd8o9fCv9F9TZFdxGgjUmN7nyFj9eMBk79BdPYBNtKTRj2Z9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GZytUPiv2e4WSZ94rSI3nMfLrUeBBSwxjoxGIAO9Nx8=;
	b=dlxaRC+YTIgLLoo5uLfjj4VFBYtTiexGk7euv6TKWJBHRQ4PKZVLzPvgQOC7s1pt6dO7
	 H0tBHx1475ivBYdmah9ueXt5QPlCg1SojmrAQVkOo2bALMLxm5EsobiYpOKb82KU88oSc
	 EgJw9gDafNtVEfb4cnr89xR20B2MPeiFYuqcDWAb79kYwpBGdpjctquj4ctA7uTPsluLV
	 O2Mnzxhw2dcHZ3gw7d6q+5w+tAZKl6EB8RuqwQGdJOQvA7F8OR/27eEiwPxB0LPcJbpo3
	 1XifcwDvUyCw//qDGRT5x528JXOSkCIYwI+K0eOFdWzhu+w6MuFmsgZuDmTIbVoxsgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AvrI+74D;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52967606A33F
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 19:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52967606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AvrI+74D
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdb684859cbso619221a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 11:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793992485; x=1794597285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GZytUPiv2e4WSZ94rSI3nMfLrUeBBSwxjoxGIAO9Nx8=;
        b=AvrI+74DuMkM9CG+0PgbSrncJJMG1FFJpx2k8JhRLeN8ZCcapOQJeZvALXyMPEkjlO
         4QQ0EFDuHKyRhHT89uSCQ/efyMb1RRj/be7olHC8FLIjAcxsx+rQcQyIlB2ZixByEH7g
         xwjkT/DEMS/9sSb9Ccw78m5uGNXfnhc87BuRKBy2gIAPOSr0iM+sZ1i066G66TQKfMK9
         MBJLLKwi6h9KqAkXl3JvQ2Sf5ZUjo7U3Elg0gMDKOoIUFETi03qorF712vbLiUzms/Ai
         r/ZebbKNGy6jwlTwWwTyQkxiKxDxFj+vNMV3byllaPSpJJLrHpmibJ76Cx7J9MJC+aen
         6RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793992485; x=1794597285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GZytUPiv2e4WSZ94rSI3nMfLrUeBBSwxjoxGIAO9Nx8=;
        b=HW4GqB8fnOG1lDQeQrnWVd4cAELO9SEqCil3klHTszBv6C4dlJ8QCBsw74c4rQ3iIB
         KEp8mfBljcDQtHrxdxSpgt/WIgHZi88SfT3utCVGvaaLs4ZBhz7IfGZZxe+xf3GC+PSO
         ZyB0wvWzckc27ZB+xGLCanFpcXcUk0nHrE2beKcFkLlzuQZ0H/SgD/2O35H6Pk3Tt6W1
         Yaw2Am5EhxQ/4DAcuEaeAhsHWJbY9SHQpUFjDhttmNX2l6P/Cm5RMfHpiCM50Qu/haGB
         s4UuSpOKR0HVbZhdHVFRj/aOKK1doEHcFyQJGjEGXF5e+fd0XBNOpg1oaQEaLgZ+NN/E
         PwDw==
X-Gm-Message-State: APuU4Z+lCU6+dGAVXfhXZoJEDa/4Y+08Z78+2b/x83j2AM3Vvw4jDIOH
	MJCR4Pyj/VN7tvv5truwcDnMGedbyE2QkhFakmWxe3eOgLuPhIQd1E7CQKl5TOfdbsMXuVA3UaS
	nh3oG
X-Gm-Gg: AYBFou2IHyP6we00wwVQoHbfV8XWUVbYmfhzjKgu7V3/heV1pL7aGsczTwSNapuXtTw
	qhI/WJScgljb9x5kBgviBdsofgQEFXyy5+q7uRhqEKHhC0V/HB15tajbjTssjPYjOIZeDU6oXi+
	theWxJDl8xuw8/E5iHbzKznuYg6wzm1jJRu1UpAbuYFoOl9cIq197TQ/gKSr3l3WL9NRe6GgW1F
	CgQkmQ9dvTlhIo/PwcVFzpR8RGBRndoI1otX+Xm3ayRf21MegpYquLRaSZDgM7hUWxrbKtWdok1
	kIMTi0cACjACRcWSJPosgUsAJR+TB1sKItpNALGxywI5Gh91laEOukntJ6JgD9LH+kC2ASB/a2b
	yhYgiJJ6U6AJBy3yW07rXwQfqEjAIKeGvTj3OolexhWVkZJH4gWWcUt8YiooK6SX3RKJ1ZEAYmZ
	hGvCu6pycg8hKqYoL2PSbBFKmSaON1bHxyKbJ+03WTNz5O0ixdiVrNGBA+U4mv1CKaFWmtMj2/W
	7rSVQZJ4nkOQdzdf+7UEOiXkEOJf902gZcIo42XVMz80BPt1dTWV8InAVNfc1QXnX+qG8Y4i+jt
	mzUHqx1Ht8YoVhlzmrMtOnd1dMZvnvKR9KpHVC9+Qw==
X-Received: by 2002:a17:90b:4c8f:b0:3a8:9b79:e6ea with SMTP id 98e67ed59e1d1-3b0db6fd4dfmr3631101a91.59.1793992485635;
        Fri, 06 Nov 2026 11:14:45 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105904951sm42781a91.16.2026.11.06.11.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:14:43 -0800 (PST)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Prashant Sreedharan <prashant@broadcom.com>
Cc: edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [PATCH net v5 3/4] bnxt_en: stop DMA before releasing rings the firmware did not free
Date: Fri,  6 Nov 2026 11:14:19 -0800
Message-ID: <20261106191423.4194081-4-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106191423.4194081-1-joe@dama.to>
References: <20261106191423.4194081-1-joe@dama.to>
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

When HWRM_RING_FREE is not answered, bnxt_hwrm_ring_free() clears
fw_ring_id and __bnxt_close_nic() goes on to call bnxt_free_mem(), which
unmaps the ring memory and the RX buffers that the FW may still be
using.

This is reachable in production. On a BCM57504 the first sign is the TX
watchdog; the close that follows times out a subset of its RING_FREEs and
the driver releases those rings anyway:

  05:30:12  NETDEV WATCHDOG: transmit queue 0 timed out 6073 ms
  05:30:12  Resp cmpl intr err msg: 0x51                  x20
  05:30:12  hwrm_ring_free type 1 failed                  x12
  05:30:12  hwrm_ring_free type 2 failed                  x8
  05:30:12  AMD-Vi: IO_PAGE_FAULT  x3

Count the rings the firmware did not free and report that to the caller
so it can decide what to do. bnxt_hwrm_resource_free() still frees the
remaining firmware resources before returning the error, so the shutdown
can send every message it needs to before the device is stopped.

The device stays unusable until the driver is rebound.

Fixes: 74608fc98d28 ("bnxt_en: Ring free response from close path should use completion ring")
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 48 +++++++++++++++++------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ea8529c78994..b5ef86bf92bf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7773,21 +7773,25 @@ static void bnxt_clear_one_cp_ring(struct bnxt *bp, struct bnxt_cp_ring_info *cp
 			memset(cpr->cp_desc_ring[i], 0, size);
 }
 
-static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
+static int bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 {
+	int stuck = 0;
 	u32 type;
 	int i;
 
 	if (!bp->bnapi)
-		return;
+		return 0;
 
 	for (i = 0; i < bp->tx_nr_rings; i++)
-		bnxt_hwrm_tx_ring_free(bp, &bp->tx_ring[i], close_path);
+		if (bnxt_hwrm_tx_ring_free(bp, &bp->tx_ring[i], close_path))
+			stuck++;
 
 	bnxt_cancel_dim(bp);
 	for (i = 0; i < bp->rx_nr_rings; i++) {
-		bnxt_hwrm_rx_ring_free(bp, &bp->rx_ring[i], close_path);
-		bnxt_hwrm_rx_agg_ring_free(bp, &bp->rx_ring[i], close_path);
+		if (bnxt_hwrm_rx_ring_free(bp, &bp->rx_ring[i], close_path))
+			stuck++;
+		if (bnxt_hwrm_rx_agg_ring_free(bp, &bp->rx_ring[i], close_path))
+			stuck++;
 	}
 
 	/* The completion rings are about to be freed.  After that the
@@ -7817,6 +7821,19 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 			bp->grp_info[i].cp_fw_ring_id = INVALID_HW_RING_ID;
 		}
 	}
+
+	if (!stuck)
+		return 0;
+
+	netdev_err(bp->dev, "Firmware did not free %d ring(s)\n", stuck);
+	return -EIO;
+}
+
+static void bnxt_stop_dma(struct bnxt *bp)
+{
+	netdev_err(bp->dev,
+		   "Disabling DMA before releasing ring memory, the driver must be rebound to recover\n");
+	pci_clear_master(bp->pdev);
 }
 
 static int __bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
@@ -10851,16 +10868,19 @@ static void bnxt_clear_vnic(struct bnxt *bp)
 		bnxt_hwrm_vnic_ctx_free(bp);
 }
 
-static void bnxt_hwrm_resource_free(struct bnxt *bp, bool close_path,
-				    bool irq_re_init)
+static int bnxt_hwrm_resource_free(struct bnxt *bp, bool close_path,
+				   bool irq_re_init)
 {
+	int rc;
+
 	bnxt_clear_vnic(bp);
-	bnxt_hwrm_ring_free(bp, close_path);
+	rc = bnxt_hwrm_ring_free(bp, close_path);
 	bnxt_hwrm_ring_grp_free(bp);
 	if (irq_re_init) {
 		bnxt_hwrm_stat_ctx_free(bp);
 		bnxt_hwrm_free_tunnel_ports(bp);
 	}
+	return rc;
 }
 
 static int bnxt_hwrm_set_br_mode(struct bnxt *bp, u16 br_mode)
@@ -11382,15 +11402,15 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 	return 0;
 
 err_out:
-	bnxt_hwrm_resource_free(bp, 0, true);
+	if (bnxt_hwrm_resource_free(bp, 0, true))
+		bnxt_stop_dma(bp);
 
 	return rc;
 }
 
 static int bnxt_shutdown_nic(struct bnxt *bp, bool irq_re_init)
 {
-	bnxt_hwrm_resource_free(bp, 1, irq_re_init);
-	return 0;
+	return bnxt_hwrm_resource_free(bp, 1, irq_re_init);
 }
 
 static int bnxt_init_nic(struct bnxt *bp, bool irq_re_init)
@@ -13461,7 +13481,8 @@ int bnxt_half_open_nic(struct bnxt *bp)
  */
 void bnxt_half_close_nic(struct bnxt *bp)
 {
-	bnxt_hwrm_resource_free(bp, false, true);
+	if (bnxt_hwrm_resource_free(bp, false, true))
+		bnxt_stop_dma(bp);
 	bnxt_del_napi(bp);
 	bnxt_free_skbs(bp);
 	bnxt_free_mem(bp, true);
@@ -13540,7 +13561,8 @@ static void __bnxt_close_nic(struct bnxt *bp, bool irq_re_init,
 	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
 		bnxt_clear_rss_ctxs(bp);
 	/* Flush rings and disable interrupts */
-	bnxt_shutdown_nic(bp, irq_re_init);
+	if (bnxt_shutdown_nic(bp, irq_re_init))
+		bnxt_stop_dma(bp);
 
 	/* TODO CHIMP_FW: Link/PHY related cleanup if (link_re_init) */
 
-- 
2.53.0-Meta

