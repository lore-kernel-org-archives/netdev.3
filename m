Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728281;
	b=Uw7xvvzfeifI4K+S2RbDXiEuBT22RbShZcJPemu3QTPH65VjYvCMHpoQOSSJwZDGqjKl
	 hZrz74NGlQJppbrrnclbNT2mXoi8fGejmie+ZYehUIJiye0OAgffjrq1lOEJZfw5RD5SA
	 vpZaCgjbsUYertnJUlysUO6UyZCShrgpURwDoxzWtgl+Ju+U1fjDiyGJs6mQRV7B/ALaD
	 ZeCe255B5+JBwKvA6jknb4Z4h2ycLcRA6X40R2l0F+U60J9iK4eqgXlqpLbaKiqfQb44f
	 P/+R6LRF+MgYOcMcqH/ZZDXKjexF75WXavLHVLcnH2cnjI7Hcwfw000T+OTkAXypuAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728281;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=TvwXf07XGLhnzy7I90Bhvn7ODIy/fcQKB7+2anJaAEo=;
	b=0ncQ2EQkwCPJWj85JQ2tKLaWJLOAfdyXLnM8FmEGdLJCcTg6tILWKQOR4QcpLAnhDplF
	 RsrQtj3hitYmULxxVxs9w7KuZTy9PFQ8spKgpaxKQFcesQX4Xq7EjYVh5sG1fR31AKFxA
	 VXrB0vge75hmGMA10ZA5dS+KEyTdEABOVSghRNPGBqUO3qoqOdFPOQOukRXpR+V8+JzsA
	 cWhS1zUJ7IWsJ/zTooRJ7PHDv5wqQRFds/YgWe9Ayof1TDx/TZSDkGOXiXe2WzelRVkib
	 PfUK0VPCP+ruENOJOfNt42e59XG4zmQ1I+ZDNftiSS05w4h8bNfSJMgS1UATLXQzG3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjGHF5Zn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7C606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjGHF5Zn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1651F00919;
	Tue,  3 Nov 2026 17:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728280;
	bh=TvwXf07XGLhnzy7I90Bhvn7ODIy/fcQKB7+2anJaAEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MjGHF5Zn+QMXC6o/+PCzmKlblXZ3ZTVvmVyw7azTP4WNoAt1U9bhW9gbbbOJ8Fpqw
	 PcDA1945H3p75te0e2c6hVkXcqy6HcK+rMa3yXdIEOHntcEmrAuNURg0dIdW20mKV8
	 OCuxFBgTo/8k+VvvKpwd/uzXyywwuLZBWozcvJwt/hR6aX1zniIBgAtFarQHC+K5Ja
	 CihoFzR89CvcWOAP8mUoJ0+aJYE6kwQISWjNCsjN9gzBhuWbZyjPHTqFGycpgAk8bJ
	 DhkUGkQ3+/6uj88AKSizK195dTDSzLRoxBnrJTisUk2HWFjvLIBZsfDcnlQKv7w0Nu
	 /RXbCTC2ySEdg==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 03 Nov 2026 18:51:12 +0100
Subject: [PATCH net-next v6 01/15] net: ethernet: cortina: Keep shared free
 queue parent-owned
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-gemini-ethernet-fixes-3-v6-1-c4b5ff8a65d8@kernel.org>
References: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
In-Reply-To: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
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

