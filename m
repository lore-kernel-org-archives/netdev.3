Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263924CCDEB
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949110; cv=none; b=nj7q/SoYvSlngsBQBniZDDikR8fcUWW2X+v9zpnyCYhzac8QZKCQLXikzbeYeYjs2hFFCvpxkiLckbHgDPNfvXQa3OLbmLGGvDn/9FZTSsF6VmJU9SVQhe17jGesvivI8ysZ+mCk8tGubLcX3/Pwqp+OTl6S4SVgTEycOQLBkrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949110; c=relaxed/simple;
	bh=imOYJxMiWQqFBK3wHgW4ucgqXDVmc9RDOsaTQbhe1PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMRzhmRvS4vICyanCY4Xnl/jZsYpTbbEpUc8AFyaqtUnIPIwC0zl7vCFInYajOdG2cUxRcbSqFniNNdEVSqLRnGEGC2GiVE9hpu5om9RiTOarTU/q8uMTQ+IUhZHth9vv9kUGf9Mbs2IO9XKJm3DOVfvcqPH0m9awzQZ9XN7gF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0Zzx+E+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0Zzx+E+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34BB1F00AC4;
	Wed,  9 Sep 2026 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788949105;
	bh=IyG0sXVnmxwHhntu1L7wc/n2XCZHl1eDAtdFEpeqVpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l0Zzx+E+apuFUGcUwRMOG+EHZ3cbTiNsNm4xjD90EE+0Qpz70spiRM/nTmHfcLNzZ
	 SWEf/ajRCNHTb6wKlxAeGY3Po1AWiSM8ynH9daOJqW1Swo61zX5G1acCCSea+3RIi0
	 Z+28s7tlikaG4G7U1vpb5OGk9z7l50Kvw8nHZjFnwVGhfLK9FXHCYGvB93dyQgSxsj
	 0xw2qgC8fnHzHfEO0yEgsbiz4iVIe+6OfzBj5UdopY11BJ2m2NdkHixhe8Rs4pBV3E
	 bKB0nRRfN+At+bJZWgVhdbGhJZobdTyMqBZZ4EYJts5vW9UFREjMyX6UrX4Wj6VESW
	 4IrjGQnxLrpQg==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 09 Sep 2026 12:18:19 +0200
Subject: [PATCH net-next 1/2] net: ethernet: cortina: Ack RX overrun
 interrupt correctly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-gemini-ethernet-fixes-2-v1-1-5ea3aa393f41@kernel.org>
References: <20260909-b4-gemini-ethernet-fixes-2-v1-0-5ea3aa393f41@kernel.org>
In-Reply-To: <20260909-b4-gemini-ethernet-fixes-2-v1-0-5ea3aa393f41@kernel.org>
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

