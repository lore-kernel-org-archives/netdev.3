Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E394848B6
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585443; cv=none; b=d4hrX8djB7oNDD6tpRwxJmGBOdhTB/ShOsgS5/ecapkXtEBlBgVffOyjUNSqpXYybUYbH54huH0ZHPdq28yqY2chxpnea85vgk9xzw4BCLi08riw3YTRDtH/2LO/vtTfZL/kuOxoBqvHR5ViH/h85I2IRJJS1qcoeFzFLqmFn7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585443; c=relaxed/simple;
	bh=BRX1VNko0PLEOY5S1LAUAnlHl5U7Y8MJxO/yGPJw7EU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HnnKP1CE8NfU/huSfGfyqtDEzGcXDIfkSJ6ZAQlWLQm/I3aUBqDJuEYtEYPKZMLwuljI0+MDP5eyurAsEzzBdrU2Vgds+G0xZqB4iWGyK7/sdCzkkW63U2sN0NsFW6uojnlIqrwzyWWTDRpoETWZnrDtx8uGTctwqdaw5OhpmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etYDiXxP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etYDiXxP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B61B1F00893;
	Mon, 28 Sep 2026 08:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585442;
	bh=KBeAk54YcjUgE8FN9KiU2efwts9mMpcZq0Rx7n8whWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=etYDiXxP82xqfLqo8gM9NZbcoo2cT/yPb5ldJO/RV5YNrPluyxlGVJP3VERZCx/iw
	 jWeX1huRHiXQDkNXufA+E8wIBGgRzNGfHMFMuxeKD1wyqj6GlcpAolzz2uIprFbmDr
	 PygaasgQoJhEKgzvP29HbHSpAwD+wuuCV2dmKrI5RAxdDU1fseMHHBULbwG6NBOIdv
	 wvaixo+2U6JWXssAnRoHuKc2SavMNBPHffGmH5wYO1S9J719g2vI1n0Xb7bgdt6k+d
	 KxwukTNqmheXaKEoIsJwXpiT02Swn+Ek2DHjyStl35Of1mzqrlRd108bD+kJ26DFuh
	 q85nwLZImCcVQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 28 Sep 2026 10:50:27 +0200
Subject: [PATCH net-next v2 01/11] net: ethernet: cortina: Keep shared free
 queue parent-owned
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-gemini-ethernet-fixes-3-v2-1-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
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

