Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590053ED12
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077857; cv=none; b=DvsiYlkGlfxVCohPQjxX70itbfmPLxErhQg8vsmAXMIs7BUJLlvGNp3xjAJmaoS2zQ5x0WJwcB9I5quGSL1N6MTSD6S2yIOrD77w2ENK6MHAna/Af8PdPQBk+HwjCNUE0uZB66iWEcWBnY/tRJmmQt8LLIzvhVmNhk1G9AZF1lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077857; c=relaxed/simple;
	bh=CKoL26ABbwOGXOvSVsiDMkVA4eOCWp9NncspIwO2DFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sWJCO/d2g9SK8zB7Ov3pnCYGomqoJ6teVTUlRSB5JbaQZg0WNqonj11rG+5uQeubO1XlWnEpY7Gou+CXq4hs83y6qAhpQxud/qkNdBIUo9jmYqpJlxwSyglkSG66dBR8p/vytRjsTekvcqkTXemgyTQ4ChSEZlmgB4OA5/9X0AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzTv9NmZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzTv9NmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EDC1F000C5;
	Thu, 15 Oct 2026 15:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077850;
	bh=t7s6af2RCACMyBPQAb9C2Qbo1cKUrk6SdIfxEopqpjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GzTv9NmZNN+YPmajfdaMlJCg0pOr4BmsMjbV2AMMnQ6FjHklyJXoxNsMcDyb9P3NN
	 cwNXgf4T5Y+mMcZJ6JzFU2PT7H6k9GlavSgPXCkj7hTNpz7VIyH8mtxxQ7yag/rjLP
	 bQ1I2w24mjP+M12ZkaviqxB0FP8nywirzCvodxIx9pVvwRTtxCFAu6jZ518R3Rw7gb
	 vqgzKNziM2Cf5yrjEnlLpBM3Dn6UZcKKUNhq85rt4Z1+sLJC0hZkc8/qf4k3mfNaNu
	 zHSEkYVEvO3j41uPWfS92TKN6flQsYgQBpGP/ywWMTfPNvy9voOdez9bYZN+JYM/HH
	 /TdP2ZFfpkXDQ==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 15 Oct 2026 17:24:01 +0200
Subject: [PATCH net-next v5 01/14] net: ethernet: cortina: Keep shared free
 queue parent-owned
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-gemini-ethernet-fixes-3-v5-1-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The software free queue is shared by both Ethernet ports, but teardown is
not ordered around that ownership. On parent unbind or module unload, the
parent remove callback runs before devres depopulates the child devices. It
therefore destroys the queue while both child netdevs are still registered
and can be doing DMA. Devres then removes each child, and both child remove
callbacks destroy the same queue again, resulting in up to three cleanup
attempts.

Removal before the first interface has been opened is broken as well. The
shared block initialization assigns a nonzero queue order, but allocation
is deferred until open. Cleanup consequently derives a nonzero page count
and dereferences the NULL queue ring.

Depopulate both port devices before cleaning up the queue, and perform that
cleanup only from the parent. Disable the free-queue interrupt after the
managed handlers have drained, since its threaded handler can re-enable it.
Guard cleanup for paths where no queue was allocated.

Port 1 owns the shared refill interrupt, so prevent the children from being
unbound independently. Unregister each netdev before detaching its PHY so
ndo_stop can still access netdev->phydev.

Reported-by: Myeonghun Pak <mhun512@gmail.com>
Closes: https://lore.kernel.org/netdev/20260917192835.58126-1-mhun512@gmail.com/
Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 2fe7fd0202d2..bf7652b04f1b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1004,6 +1004,9 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 	unsigned int pages = len >> fpp_order;
 	unsigned int pn;
 
+	if (!geth->freeq_ring)
+		return;
+
 	writew(readw(geth->base + GLOBAL_SWFQ_RWPTR_REG),
 	       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
 	writel(0, geth->base + GLOBAL_SW_FREEQ_BASE_SIZE_REG);
@@ -2387,11 +2390,10 @@ static irqreturn_t gemini_port_irq(int irq, void *data)
 static void gemini_port_remove(struct gemini_ethernet_port *port)
 {
 	if (port->netdev) {
-		phy_disconnect(port->netdev->phydev);
 		unregister_netdev(port->netdev);
+		phy_disconnect(port->netdev->phydev);
 	}
 	clk_disable_unprepare(port->pclk);
-	geth_cleanup_freeq(port->geth);
 }
 
 static void gemini_ethernet_init(struct gemini_ethernet *geth)
@@ -2635,6 +2637,7 @@ static struct platform_driver gemini_ethernet_port_driver = {
 	.driver = {
 		.name = "gemini-ethernet-port",
 		.of_match_table = gemini_ethernet_port_of_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe = gemini_ethernet_port_probe,
 	.remove = gemini_ethernet_port_remove,
@@ -2683,6 +2686,8 @@ static void gemini_ethernet_remove(struct platform_device *pdev)
 {
 	struct gemini_ethernet *geth = platform_get_drvdata(pdev);
 
+	devm_of_platform_depopulate(&pdev->dev);
+	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
 	geth_cleanup_freeq(geth);
 	geth->initialized = false;
 }

-- 
2.56.0

