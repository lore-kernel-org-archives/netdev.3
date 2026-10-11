Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072FD44A701
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791741984; cv=none; b=DiSysyk3m0pyqm24eXIwBn+lmP7oEt6Evb1NmMehKbLMa9hRn4GW/d2QA/V5C6Vng0HwhLxOJJXip8eG3BnM086BzcGpK8sy0dbgn7XYrdLYSQo7WYbpQE1Ltexw4cPRhR07BJINRnkDwejnopYWGPx8E8jTtQ0rbUYWj5AFOUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791741984; c=relaxed/simple;
	bh=IsB09d8ZCHbm/5exxpU0sW208aRDlCZGgp2PBOdNr2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QNZIV6J33nQTPQoVJ35PUaRCHpzcZdytqB/AgqKfhrN8E62udoScptcL6Av3x80vzLxqCpxmQqZcSzlBameKWneepp6PEfLGVEv7Xkq3Jk1hUdWf1vUxH4ODpSYcQR/vA/Ej8TwUNqaKVKdp7QV94MWsM4vr+4OW5w+KdJEtFfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDzvcVPZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDzvcVPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D70A1F0089C;
	Sun, 11 Oct 2026 18:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791741982;
	bh=Zt9LiX25gwQ8iGisViZMfp4aTpOteCsLnJvQ3NPy72E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZDzvcVPZzQb+BctV5wNmnLUtEkGophX5ZGjO9Iar9xF7BxkA7rb+IYQu4mSNKUrPa
	 yImV+KqiFTIRG8C7U1qBjS1pP7YoKlniyj7AE8xInGFw1iOh3TQ+ZsyAE+HnR77dU4
	 SFE4KXof3hQubqlgoQDiE2F1iDyACLoyf3aRWRsUOmGVBbvT6AAvz+P7xZSoFG/5uO
	 2EeASk3k8vV9eAAZSw+1FxL13SmgCtBQ4/6Ih4FM/7bpfpRjk2/iCBpGy+zadvboDg
	 k3ssfiLfosPpcpHw8IAmhab4lGHxb5OhIg3gb5R5uhU771lFfcgxZhYGsohjgZGh62
	 YayZA4gY5eCdg==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 20:06:14 +0200
Subject: [PATCH net-next v4 01/15] net: ethernet: cortina: Keep shared free
 queue parent-owned
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-gemini-ethernet-fixes-3-v4-1-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The software free queue is shared by both Ethernet ports, but each
child removal tears it down. The parent removal then tears it down once
more. This can destroy the queue while the sibling port is active and
can free it repeatedly.

Depopulate both port devices before cleaning up the queue, and perform
that cleanup only from the parent. Disable the free-queue interrupt after
the managed handlers have drained, since its threaded handler can
re-enable it. Guard cleanup for paths where no queue was allocated.

Port 1 owns the shared refill interrupt, so prevent the children from
being unbound independently. Unregister each netdev before detaching its
PHY so ndo_stop can still access netdev->phydev.

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

