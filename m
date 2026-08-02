Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AB139902B
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785670851; cv=none; b=Lu56JjWT9ESwqevgeRA1V9pH+0iwLZ4USQte9EDL2FrleLCQ2iCjPYLuNmsUOksbswm/m0F4E3HGmWSEVd6U7SZgIbV7bPfjInUhYeBx5BEylbRnR0xXgeznchwE+5/nxwE3K/D+teE1dW/PZiA/q04LYhzjLVjkZaEm8o3RsUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785670851; c=relaxed/simple;
	bh=o0Oe4Qe65/9NyvDwNNptWUbZhq++tkdJy0gpjJQ8rjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNu5LoB01nW0+m0oSWRkHT8t29BdrAoX+HDABw54UoqjVZK7CDHynq+Fh1yntU0PRPPYirGk/u1NGrXB1cxrjJQqWK4X+msruSPQz8B6dbSb6R8YDtMhufSIkeRgP0JmDAlctgnlh5vhIpljy+JDZAHhk1KI/XAOwGVacxiiCsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PAngdWN6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PAngdWN6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A7E614E410A0;
	Sun,  2 Aug 2026 11:40:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7D51B6029B;
	Sun,  2 Aug 2026 11:40:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFF7311C17580;
	Sun,  2 Aug 2026 13:40:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785670831; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=I4Tgmpjf7Ilmqtz+aDL1dWKoCzuAU0Ep6wZi5PJ2Z1o=;
	b=PAngdWN6Kzyy6RaS1SocProVrElUHk+7aR63UdtGX8aeUFj5FKxZA1GHiBktiFT6xEPsQC
	4inKyi+YGs+ojuQOCYoU2piqRRPPWMx5BOAa8DCTlLgPaAnZWOpcCHB8kO/pHt2+CasYxa
	lXbadogFobFi5rxEjWN/nXXRcwlnEOGTfWcEMM7oA9WLBbZqh4dpc6m4CfB1Ze7QQ0o03d
	qEBVvuwvC/BfrQxq6+XESu/d+aRqFe7SqlErLTRyJQu9n+t7pbaK/2AJrYeeIxWl98s12h
	8fRu7/+m5CczHDwrlK3ENeQN5qbVywY8qNlwwYP8xAT70l7gDELcsyA4ZOKxBw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 1/2] net: stmmac: ethtool: Comment the magic numbers in RIWT computation
Date: Sun,  2 Aug 2026 13:40:13 +0200
Message-ID: <20260802114015.214212-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802114015.214212-1-maxime.chevallier@bootlin.com>
References: <20260802114015.214212-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Receive Interrupt Watchdog Timer is an RX interrupt coalescing mechanism
used by some variants of dwmac. It allows waiting a bit before
triggering the rx interrupts, allowing for batch processing.

The RIWT is configured with a granularity of 256 stmmac clk ticks. Let's
add a comment for that and wrap the raw "1000000" into USEC_PER_SEC, as
we're computing "how many clock cycles in one microsec" with that step.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 92585d27ab88..eebfd6976aaa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -759,7 +759,10 @@ static u32 stmmac_usec2riwt(u32 usec, struct stmmac_priv *priv)
 			return 0;
 	}
 
-	return (usec * (clk / 1000000)) / 256;
+	/* Receive Interrupt Watchdog Timer (riwt) has a resolution of 256
+	 * ticks.
+	 */
+	return (usec * (clk / USEC_PER_SEC)) / 256;
 }
 
 static u32 stmmac_riwt2usec(u32 riwt, struct stmmac_priv *priv)
@@ -772,7 +775,7 @@ static u32 stmmac_riwt2usec(u32 riwt, struct stmmac_priv *priv)
 			return 0;
 	}
 
-	return (riwt * 256) / (clk / 1000000);
+	return (riwt * 256) / (clk / USEC_PER_SEC);
 }
 
 static int __stmmac_get_coalesce(struct net_device *dev,
-- 
2.55.0

