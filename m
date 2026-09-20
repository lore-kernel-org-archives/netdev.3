Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C81C38CFEF
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789937345; cv=none; b=pGEBVmtYgpL8qmN9UWKnMX9Aub9i6/sGBLelXbm6serrPQ7yKqgYAG/mGAIBI6GqUX6yOBNSDkO0XXWYDIMtdcnIuk8Vo0/FYTUvykXHriAhkkDX85bt+pN6LYPEaH2Y3GKaJoKLE1EmWzmmYUL4fcelqL3CDT5YV2oNcm+A88c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789937345; c=relaxed/simple;
	bh=A2d11Jh+8JPVdLlxGDtEr63nPNjNxpUWx7zoJShiaFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oyIP50/v0jg3vPZQ9G30RystHFEvPXWOyfmcDw6a7GdndFyh214gQSYCHUT4KJQXk6ssKNxY7iJ39BWIV/11DTOBBUj361dThYFSLGjg7Nz5Zg4njF9MngCQWMv4/IyPevQyH8d5ITdAHOxPkjNtQ00HqgSHZsn2qzsu0XrHxJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+Bg48Bu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+Bg48Bu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5DF1F00893;
	Sun, 20 Sep 2026 20:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789937344;
	bh=t3Bc8uAHSbFIM2qL0UDJMsHbwQ5bRlVGqqw72s5bBAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E+Bg48BupTyfpw2xRTATUUhGYaI4vJbeWDmLOtYhBwfBoDoz+5BSnZR0VipY5Z8tH
	 182EL+x4uFXhXJc8xWkaDHKBiBKKPSD55A/AetX22DtfFkuXF3Gq1eAOHFKPiuarHZ
	 9vGEjz4uHrShzj4D39JvkS8OKtsFx596ClpNpcMsIuFBmP6IwyHA/92toxh2OfC+vC
	 55umZLrTQOKTTWUxaAx5VWYK3kJhx9E/frEa0O3R2xDxJvzaf8V0vmC2/N810uGXDE
	 ZCbUjeR8yxzx/4zjSeH4bvOBxp2vbg0VzJLKUf3cNWkrCNdINUV1dMWm+JKhr+Wa3P
	 kcgvDaQbD+2aw==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 20 Sep 2026 22:48:51 +0200
Subject: [PATCH net-next 1/3] net: ethernet: cortina: Keep shared free
 queue parent-owned
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-gemini-ethernet-fixes-3-v1-1-3a2a50a83d89@kernel.org>
References: <20260920-gemini-ethernet-fixes-3-v1-0-3a2a50a83d89@kernel.org>
In-Reply-To: <20260920-gemini-ethernet-fixes-3-v1-0-3a2a50a83d89@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The software free queue is shared by both Ethernet ports, but each
child removal tears it down. The parent removal then tears it down once
more. This can destroy the queue while the sibling port is active and can
free it repeatedly.

Depopulate both port devices before cleaning up the queue, and perform
that cleanup only from the parent. Disable the free-queue interrupt after
the managed handlers have drained, since its threaded handler can
re-enable it. Guard cleanup for probe and removal paths where no queue was
allocated.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Reported-by: Myeonghun Pak <mhun512@gmail.com>
Resolves: https://lore.kernel.org/netdev/20260917192835.58126-1-mhun512@gmail.com/
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 2fe7fd0202d2..31bcd41c17fa 100644
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
@@ -2391,7 +2394,6 @@ static void gemini_port_remove(struct gemini_ethernet_port *port)
 		unregister_netdev(port->netdev);
 	}
 	clk_disable_unprepare(port->pclk);
-	geth_cleanup_freeq(port->geth);
 }
 
 static void gemini_ethernet_init(struct gemini_ethernet *geth)
@@ -2683,6 +2685,8 @@ static void gemini_ethernet_remove(struct platform_device *pdev)
 {
 	struct gemini_ethernet *geth = platform_get_drvdata(pdev);
 
+	devm_of_platform_depopulate(&pdev->dev);
+	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
 	geth_cleanup_freeq(geth);
 	geth->initialized = false;
 }

-- 
2.55.0

