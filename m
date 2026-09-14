Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2F4457C4
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421220; cv=none; b=rABB7ar88AJSU8BCAdu4EU6MKe97s/pbPlb+p/XKoi/fyZBvQj53B+H7HwzKwTL7XuFjt2ZwKjFt+Hnterm/I7liu33TrfMrQ5TMyDITwnNu5CLMLoUL6DBhJBz6V1QSdblE5pMRmyzIbariaNtNuo26glvzkaSgTG9IgKh1lKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421220; c=relaxed/simple;
	bh=imOYJxMiWQqFBK3wHgW4ucgqXDVmc9RDOsaTQbhe1PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sadrf6OltobP+Y8/Dcjuavxbzfary2OYWaBFavSa7V15d62lEP4wOETKkXGpHYusizL8bCsNNj9wyKKU6MKvdCDphZ7X5Gnmex0DcziLiV0UJauqorkSND6E3GUII1dBoJDczcsn4Ksqanw/P1RMqJxM6RlqgWWN13NQKCuLkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zkt76J+K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zkt76J+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F6A1F00893;
	Mon, 14 Sep 2026 21:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789421217;
	bh=IyG0sXVnmxwHhntu1L7wc/n2XCZHl1eDAtdFEpeqVpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zkt76J+KnUPYLiOJ+JhaeTAFNLytae75563EpT5ONWz69c8T3xuMtoIWNR0dUyjPP
	 fKgLmrSvtKiordNMplGOQp/dolBw6SVI0BPiHaqhnp1KIg/ZTeO/1Tdqfim+C7DEXn
	 3yZ7UIZyEGkySRcVsmtphhrzYgU3wGfid8rk4ME9vJ5kjYyuCy3igVoPlbORg+nuaZ
	 sfu63onpYbYRBq3COXlDhmOMODsISpqleePYWsQ5NruDbg5dsewTHMvZWbuiE0P7PT
	 VqWlsRRVlsQ36MfnTnlZUzsW5Px6kD+s2LEFtEahD/Fdmiv9aDVNM3Al9jA9tCgEoz
	 9hk7ij6l+MmHg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 23:26:41 +0200
Subject: [PATCH net-next v2 1/2] net: ethernet: cortina: Ack RX overrun
 interrupt correctly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-b4-gemini-ethernet-fixes-2-v2-1-5ab39a047b90@kernel.org>
References: <20260914-b4-gemini-ethernet-fixes-2-v2-0-5ab39a047b90@kernel.org>
In-Reply-To: <20260914-b4-gemini-ethernet-fixes-2-v2-0-5ab39a047b90@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The RX overrun interrupt is reported in interrupt status register 4, but
gmac_irq() acknowledges it using the RX descriptor error bit from status
register 0. For GMAC0 this writes the GMAC1 overrun bit, while for GMAC1
the shift leaves no bit in the 32-bit register.

Acknowledge the same per-port RX overrun bit that was detected.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index f08de623e6f7..2dd2fa801829 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1798,7 +1798,7 @@ static irqreturn_t gmac_irq(int irq, void *data)
 
 	if (val & (GMAC0_RX_OVERRUN_INT_BIT << (netdev->dev_id * 8))) {
 		spin_lock(&geth->irq_lock);
-		writel(GMAC0_RXDERR_INT_BIT << (netdev->dev_id * 8),
+		writel(GMAC0_RX_OVERRUN_INT_BIT << (netdev->dev_id * 8),
 		       geth->base + GLOBAL_INTERRUPT_STATUS_4_REG);
 		u64_stats_update_begin(&port->ir_stats_syncp);
 		++port->stats.rx_fifo_errors;

-- 
2.55.0

