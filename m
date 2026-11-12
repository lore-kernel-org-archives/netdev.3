Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459226;
	b=4gfUVNyC2M90GKuNE3VLmwovav5UgOKi+IJwBy0Ok7lmD2Zfv669aHWEjMQiyjeUQAeI
	 HHO9nC2yZx8uiEEu3ZddvMjD3+TfRFe8iX8tWnEfVPVzvKnGlWdir21AJ3NHL+Q7lYG4/
	 3bMc3gCG0aLZvoqEefmEA9rR9WFogPT5aWChShZyA9TxOgXK0OP7pc4pCecfeBIDaEF+E
	 O+NQHZ++DrneGHKVKodye8rAK/v7qP5V4OTT6T52A7IE1cm3h2BEi4zRajadTm1lYyAli
	 ioDPF9rjmWidVYCpp7c4W9DJYcShyf8J6eqmcuYbDWoRKS/HRAJfPeiKFpUs1Q2oCAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aReQhoQDtTjsXQU7L8MfhGPbTYfsAF+OFRMYwi8UI4I=;
	b=p10GS2v8O+5ZG9dDy28dHh/dZ8QNZts2Un8hc8WmzLm8FJtiO4SeF4DKqFRVqWeFJmH7
	 f1+HVC3hwOIJUDFxI7hQK+zTODoxkDESyXXFC9zFtjDkhVMkUP13dfJ9ZFRnNbB4QIY3m
	 X9YLNB7fcgBsmIcgYWhhjdjtCaR8VfYcOv18F4ckZabei+c1ZiH0buOpnck+TOXxAwd4D
	 OR1UODovfzcNYtQD9mbTHuK2nqYVt7gunHzt0GBosCz44b0svU4dSDlFHBFRjHGBXil16
	 yl8YpxBOlk2hHFNgWX8MXI1QNH2TX+OIpzh+Vd+qK4vH1rodW8EhPJscwkk5zPbFipQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OO941wBz;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC20606A32A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AC20606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OO941wBz
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so7038121eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 20:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459226; x=1795064026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aReQhoQDtTjsXQU7L8MfhGPbTYfsAF+OFRMYwi8UI4I=;
        b=OO941wBzSWdMLo4wQ9thfK8QgXLDpqmIeX3mxdrhKhazrWjN4RKBRPpqehxIM19qkK
         1UPMhaCGZuieeimncw6kbFuQIcaR0YsNA/yzyg/mbarqMiHkqwHYYm4fx1D211gplKMk
         WYORIdPuFG0TChlouMdmAjc9WgHd+tCJFNxuo95Uo4nfnjEe9jXy6va3Tx7jNohYJevj
         25mtyRJRCXiC54lH2NRf7duME4Mvq72/W8z/WmwORIyO01vpdyICKLOp+3lKiywsUEHC
         ggdQCp9o+8hND2oVPZ9RAS09+CBRHewiBc9uzJAAJXtIvT49Cq1wGmgMJiq1APRAXfAo
         lpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459226; x=1795064026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aReQhoQDtTjsXQU7L8MfhGPbTYfsAF+OFRMYwi8UI4I=;
        b=mUW1Su92Gh507ukV6pAN589GhkynMbkMxMwmSiBt2muRHoMdMFsGnXUkvCtykMt/JK
         /2t0K1vChf3ycWUwqqpzzZMbTqYUyShJeM10LafuuUXYpzLi7n09uxzY8NvEjmeujDB3
         +HptOwsaB7oyxVahfK2D9VvEpQjh/y+mZvzpa41K87UzZrbXXEX/zCRKy+CUwQDJ8BZf
         +2+tY09L/mogqNkMbwRvNKjtmNpA2E5cX+KFAxLXwYNSdLR7Cip66MU3SZZ9VFO86yo9
         c8oR6YYSh7Du5xaeBnjgfE7qk5Neajv8KkdTMRBrJHdnbf9iTWgpYKsd3WAnmWmc0F+E
         Es5A==
X-Gm-Message-State: APuU4Z9gJXK6HVftyPSlxGyZGhWmMsQ3h1ba8VRF5rYlqaPKbUGUEDPb
	hsMu2MgdTvSI0ETMnRk0YWC0+ETO7fpEe9Jox7OFIvZRt+3aXGdhlT/aZI800Q==
X-Gm-Gg: AYBFou0LgHIGyYnj2bepENXppaevPDxiLjxxsOeCR1KxSkJn6DAn60p0ujT6dyfHvzu
	iKlyUsb/SFdJH0q8+D50vJtlTVSRIb4lCwH7f6B/I5TN8Ga4nfAJwJBm3fju/wX7w9DEu80UzA/
	rzzEFIl2Lv0Jc9HOToB8oWbZESfDYZM0/PEgo+9G7S4bjIGhZCbe5pP476iL+JNOzLXWNTb69vv
	MSE76SfCQlEoaVXFROMh0m3IiXwULj53DGtl5uU6OVqCnz5vdxkJPajLUkGMHRXPEN6bYQKZRSp
	0sXor8cqqcfmmoETQy49zh5OfHDzubDOeIBKNTgeHjxMR1JIGyQUbx1AvuL0RuQI3BXh3mlpRVW
	Qmc3/AgVTsj7vznGvIgXZvV/qeI9bNi9DP1cpwQGBI+rONjgqFOU8InyHYtxRE5bKBErX8cnJxY
	TniGLvzQtpzXdG8anSSl7RB9KP7gHCu2NeTED/Aah6kxyFg7XLctCeLuLW8miiXxGxE6uBTnRl8
	gh/3qd7I0BftfJNvdQVw36zphQWhsq5LhnFwO0T32BozKLzGTnKnPjI9SPo3YJORT1hZTXf3jI2
	7tvnTeTOaA==
X-Received: by 2002:a05:693c:20c3:20b0:343:9eb1:9940 with SMTP id 5a478bee46e88-37686759540mr4770613eec.26.1794459225474;
        Wed, 11 Nov 2026 20:53:45 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm23921585eec.17.2026.11.11.20.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 20:53:41 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	David Yang <mmyangfl@gmail.com>,
	Herbert Valerio Riedel <hvr@gnu.org>,
	Jeff Garzik <jeff@garzik.org>,
	Danny Kukawka <danny.kukawka@bisect.de>,
	Mugunthan V N <mugunthanvnm@ti.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH net v2 05/12] net: au1000: serialize TX completion with packet submission
Date: Wed, 11 Nov 2026 20:52:47 -0800
Message-ID: <20261112045301.3669532-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112045301.3669532-1-f.fainelli@gmail.com>
References: <20261112045301.3669532-1-f.fainelli@gmail.com>
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

TX completion runs in hard IRQ context while ndo_start_xmit updates the
same descriptors and ring state without locking. An interrupt between
netif_stop_queue() and setting tx_full can miss the wakeup and leave the
queue stopped until the watchdog runs. Use the existing IRQ-safe device
lock in both paths to serialize reclamation and queue state changes.

When submission reclaims a completed descriptor at tx_head, advance
tx_tail before reusing it so the interrupt handler does not wait on the
new packet while older completions remain pending. Consume the copied
skb after releasing the lock with dev_consume_skb_any(), which also
handles netpoll entry with hardware interrupts disabled.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 6b2e216a8361..5ce106d0389f 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -872,7 +872,9 @@ static void au1000_tx_ack(struct net_device *dev)
 {
 	struct au1000_private *aup = netdev_priv(dev);
 	struct tx_dma *ptxd;
+	unsigned long flags;
 
+	spin_lock_irqsave(&aup->lock, flags);
 	ptxd = aup->tx_dma_ring[aup->tx_tail];
 
 	while (ptxd->buff_stat & TX_T_DONE) {
@@ -889,6 +891,8 @@ static void au1000_tx_ack(struct net_device *dev)
 			netif_wake_queue(dev);
 		}
 	}
+
+	spin_unlock_irqrestore(&aup->lock, flags);
 }
 
 /*
@@ -972,21 +976,25 @@ static netdev_tx_t au1000_tx(struct sk_buff *skb, struct net_device *dev)
 	u32 buff_stat;
 	struct db_dest *pDB;
 	int i;
+	unsigned long flags;
 
 	netif_dbg(aup, tx_queued, dev, "tx: aup %x len=%d, data=%p, head %d\n",
 				(unsigned)aup, skb->len,
 				skb->data, aup->tx_head);
 
+	spin_lock_irqsave(&aup->lock, flags);
 	ptxd = aup->tx_dma_ring[aup->tx_head];
 	buff_stat = ptxd->buff_stat;
 	if (buff_stat & TX_DMA_ENABLE) {
 		/* We've wrapped around and the transmitter is still busy */
 		netif_stop_queue(dev);
 		aup->tx_full = 1;
+		spin_unlock_irqrestore(&aup->lock, flags);
 		return NETDEV_TX_BUSY;
 	} else if (buff_stat & TX_T_DONE) {
 		au1000_update_tx_stats(dev, ptxd->status);
 		ptxd->len = 0;
+		aup->tx_tail = (aup->tx_tail + 1) & (NUM_TX_DMA - 1);
 	}
 
 	if (aup->tx_full) {
@@ -1009,8 +1017,9 @@ static netdev_tx_t au1000_tx(struct sk_buff *skb, struct net_device *dev)
 
 	ptxd->buff_stat = lower_32_bits(pDB->dma_addr) | TX_DMA_ENABLE;
 	wmb(); /* drain writebuffer */
-	dev_kfree_skb(skb);
 	aup->tx_head = (aup->tx_head + 1) & (NUM_TX_DMA - 1);
+	spin_unlock_irqrestore(&aup->lock, flags);
+	dev_consume_skb_any(skb);
 	return NETDEV_TX_OK;
 }
 
-- 
2.53.0

