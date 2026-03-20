Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29353D9050
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025262; cv=none; b=gizH+h01HIXJnt+EDa0Iw08C4wYadJev6OqdSpAF+WEcukuK7/vMRApmiaiAJvKY5y29nfikapnrdZ2E+VyRX8twoRZai/yK2K6Zpw4qIwD0Uj+iuYKHeKCekBNoxPbOPZB3+JFxqmQ4G/4epJ6oaf2DwzBqOnLB7QNuXLBDYHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025262; c=relaxed/simple;
	bh=ZB0Rpn+TRhgI+SYx6FoGup0JZ3+5CQEOxCiSHkh9OMI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=h+b9IVupg/+gjHKBe5gjioGZF7DSEFAUB/n3PRYjPTDYon7u4wodrV4HQ+cQjxkSbTFgOeBjJKtAodVqevBd0+pD8k3kiwrYQVqHsLGtEFDEm3cRjl1hEyPjuUbgIhJNAXiv9pvLhZiCEgQ0eNBcuD4DE0UrJithmUbUgGJcMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Vo1TvmbO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Vo1TvmbO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1t19Dgh3hZYr0qQ3zdBg1bnVpGadg1ouWN+kqUkJjKA=; b=Vo1TvmbOo1kLdibuiUbgt8CJ1L
	ZxLccNiofwKrkaqJprtLHH3MQFI6HcL7Z5CvLhNUkPptJJJTcWZkGRkd2Rdka4RzdZdgYY0boGV6Q
	zmHSYaGezFowEQRWQV1H6pQD0vLvSa/bko8ko5qStuag4OyNSGU9G085LCBYcqsqRxj00at0+Z4eW
	Hy4kUa4r7nvmq1vWabHxjTuSL6qQarnjGkqBKLSH/AEbOhRZl09apabX7IrmY7e/tgVSOkbrZEspq
	3RmR0VsDuttunP0/4E2Em33ShisPrE9fjYx+oxl3mEiLqFfvf3TzSCmy1iBP2ouR2YwmDncDeKQgp
	VHiouLAg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34176 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w3d0X-000000006MM-1eGE;
	Fri, 20 Mar 2026 16:47:33 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w3d0W-0000000DfM7-2BMA;
	Fri, 20 Mar 2026 16:47:32 +0000
In-Reply-To: <ab15_JvLGFtUH_3x@shell.armlinux.org.uk>
References: <ab15_JvLGFtUH_3x@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 5/6] net: stmmac: use first_desc for TBS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w3d0W-0000000DfM7-2BMA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 20 Mar 2026 16:47:32 +0000

Rather than freshly getting a pointer for the TBS descriptor (because
we want to access its enhanced fields) convert the existing first_desc
basic descriptor to a pointer to the enhanced descriptor.

Add a comment explaining why it is safe to convert from the basic
descriptor pointer to the enhanced descriptor pointer.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 95da2940cc3d..a733249c3f9b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4801,10 +4801,15 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (priv->sarc_type)
 		stmmac_set_desc_sarc(priv, first_desc, priv->sarc_type);
 
+	/* STMMAC_TBS_EN can only be set if SYMMC_TBS_AVAIL has already
+	 * been set, which means the underlying type of the descriptors
+	 * will be struct stmmac_edesc. Therefore, it is safe to convert
+	 * the basic descriptor to the enhanced descriptor here.
+	 */
 	if (tx_q->tbs & STMMAC_TBS_EN) {
 		struct timespec64 ts = ns_to_timespec64(skb->tstamp);
 
-		tbs_desc = &tx_q->dma_entx[first_entry];
+		tbs_desc = dma_desc_to_edesc(first_desc);
 		stmmac_set_desc_tbs(priv, tbs_desc, ts.tv_sec, ts.tv_nsec);
 	}
 
-- 
2.47.3

