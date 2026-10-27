Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140326;
	b=Fa/pD+AMpfOwDlHxNWYoepHk6X1Jb61obLWW3UQ/d+/yG6P3eM/weRNAEg3BcQe2h+bK
	 9UTKigvycxhSOyjDgeOr1G3nPwCAkouxYUnOuXHgkRIp3kpAYWWTpR33WR5a951nVW8th
	 57c1DtuG4hhuiHLuky93ZNwTQNGdlHqoVKpNATkCKStDyFFk0bXllwIj2wEDTlXADaE/Q
	 ArYxc+QN0PXm2JEQ+xNW78U5sCOCBf1NjmV1zpeC+A9TqumNcDwNT0m/m4EeUhytDbSC+
	 AHDV8wpOuD9Lq9qQXG2S0l9V4ujt9IRGgIPVSCgIAr5jAFQgKl982S8hmBrEql5pC6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kPicyF0JOQLNW+JQsO0wEWL93KfdqOhJFo6fwT6dbS4=;
	b=5N8WnFtzlgiFt1EeTZSEE8FiMFMG8SrUamd6dgZaGfajN9ewMH+oH6CMLlYWY2TZrQyg
	 vOw0twzeRSLMkAArIgT1N5ZdFlEApcfbPyGP6uxoutUUFhxRefbvf6z1mnFObr3A+vA3v
	 dfA6ZOikQF8LPyg58Wi9zGyVZy86faRHb5EAuj43S5TEb30QMOHzVqvIzztrbMyIGXgnO
	 x6WMT0xFCpWSWC2T0e15fCtfcNFY97zSgZu+xi0k23YRHsK7jOWHsU/1TiRWS9YkqoLNA
	 sAtcmg1u5I/dNkD56PBa8eN0T6ngC5UJezseUHVSyTOATLWr5dGxqlXEMVZ320MKcsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HQU/hEHj";
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91EE606A325
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D91EE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HQU/hEHj
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-156cbe59524so355673c88.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793140325; x=1793745125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kPicyF0JOQLNW+JQsO0wEWL93KfdqOhJFo6fwT6dbS4=;
        b=HQU/hEHjFeTBUq1NIuSddFR6HXYfipg/o3Qp1IHbYAgdnv8Eb3D9BMuGMCqrSNfQC3
         WraVlKhQg7VbPDYava2pH7ri/i0nF/YSFb++Fun11YBQdkZpHjdTLPaxZ768ouKCip4j
         1WYzTzrso2bjbG3rBQl1ty8Rb9XqjkemRf/t22sAGRqZskgyI/rjcpfaG6gV+ghwB4di
         SFaiUuPjvabY5jZMaIjzjBNouWj61zpbEqHCKKSsG5JBwh6otcJDnGN2FgNBwI1UV4ty
         MuMm/NZDPivqioz1hbHU1vLqkV0CWLtvoPrCw02mHQQOZYOBYDQ3GrCYpRwmdrZniv8M
         /ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140325; x=1793745125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kPicyF0JOQLNW+JQsO0wEWL93KfdqOhJFo6fwT6dbS4=;
        b=z2Kfa1XpuOnEt+fYbZC2Ei9kSn7bCMik7drzktofvD+/HdkzVKaVjvzWbG4pWGYp+t
         xFpnA5mnc270g4DmoeE+dvsI+DLl3rjAJlaDuMzFcyKRbG+JQTzfH3xwgo0B8T0cfGs7
         z1EnPZA8LwkXj6rX6iDmTHGjX4oUsBJiqeXvesLM7sPaiWkML7JVWCY0m83aDxSWzxtc
         MCgzredtt8uRCqgtMvlXDsslLbujYihqa7goT6Hw0aAJVo/VF6pjseh/ls/XurM3Pg2L
         I2cdXCiwNg1Oq+RM0V5TsYzDRMqX8lo91A4rGwYnoc+2Vf1CvTsnaKLDqep3pMTBPMcM
         Mz7w==
X-Gm-Message-State: AFq9FYIInXKWQcITqrHLte8YsMCqFyAHjcn6yL2BkTwgkmFZPBqnqwwW
	xLjMtAcg6Or+NppRx/cr5yJky8uzzh40sfPRJ0+WJcL02gBuuN6zLFo15gqU30hE
X-Gm-Gg: AYBFou3GZ0tiC7Ev0o7YyV89TM2tSov/T0P9yS01g47KLSB9olZZGSO58b/8PntY0eH
	ZxnouH7w65/DEVg58N4p0t85of2opuY6gRdemA95owHPJAQCkDgyZ3vkwKU76NO5Ds3SRUjL7SP
	f23rIUNXSOJdycsGTV0CisweVB9dpt3rFsA8tbYytzuuo3AppzZYBIMImJYjZc3IE/oVxjBoLUh
	F4de5Kob5ykbo2Wr6xKk3QvZIQ58N8zqDgzAk4s6w4dAxrJOdkN1ARp5bB7qtDv74qJnhI9A32c
	BjVavX2YqcojypDutbor0bmVQolbZnH7ZnlkbV3b/S4+ifyLdAKMWk/HhExryPqhS5zaHNpBjOE
	bzRPFsFInjxugzpD8T7zbBV7mGpCQFbKfrgNoX8s0nIjb970IrQ7+t10UglUsWda4lwy1hhl9Ga
	7Y868YKAwMleXva8cUITXPV47Gfyx9RhSymg4tfuGJ6FPbNYoma7yd0C5p+Sq/V2enKqIA7JV3s
	QbWlMpD5l6iSZxF03bQCEhf7CRCFPLHypXEbo266gBdd6ZCp3ygLpj2RAkAebgcD3o9gSaUrNE5
	Clpo9w==
X-Received: by 2002:a05:7022:6b96:b0:19a:51da:f54f with SMTP id a92af1059eb24-1a6cd498fffmr1097038c88.14.1793140324678;
        Tue, 27 Oct 2026 15:32:04 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d98c93d7sm1130735c88.13.2026.10.27.15.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:32:00 -0700 (PDT)
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
Subject: [PATCH net 05/11] net: au1000: serialize TX completion with packet submission
Date: Tue, 27 Oct 2026 15:31:34 -0700
Message-ID: <20261027223140.3774570-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027223140.3774570-1-f.fainelli@gmail.com>
References: <20261027223140.3774570-1-f.fainelli@gmail.com>
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
same descriptors and ring state without locking. In particular, an
interrupt between netif_stop_queue() and setting tx_full can miss the
wakeup and leave the queue stopped until the watchdog runs. Use the
existing IRQ-safe device lock in both paths to serialize descriptor
reclamation and queue state changes.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index a507a524370f..90887dac26bc 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -873,7 +873,9 @@ static void au1000_tx_ack(struct net_device *dev)
 {
 	struct au1000_private *aup = netdev_priv(dev);
 	struct tx_dma *ptxd;
+	unsigned long flags;
 
+	spin_lock_irqsave(&aup->lock, flags);
 	ptxd = aup->tx_dma_ring[aup->tx_tail];
 
 	while (ptxd->buff_stat & TX_T_DONE) {
@@ -890,6 +892,8 @@ static void au1000_tx_ack(struct net_device *dev)
 			netif_wake_queue(dev);
 		}
 	}
+
+	spin_unlock_irqrestore(&aup->lock, flags);
 }
 
 /*
@@ -973,17 +977,20 @@ static netdev_tx_t au1000_tx(struct sk_buff *skb, struct net_device *dev)
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
@@ -1012,6 +1019,7 @@ static netdev_tx_t au1000_tx(struct sk_buff *skb, struct net_device *dev)
 	wmb(); /* drain writebuffer */
 	dev_kfree_skb(skb);
 	aup->tx_head = (aup->tx_head + 1) & (NUM_TX_DMA - 1);
+	spin_unlock_irqrestore(&aup->lock, flags);
 	return NETDEV_TX_OK;
 }
 
-- 
2.53.0

