Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE1B4E3259
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958292; cv=none; b=UqYSs+vaL0PiDOQK1t9Uz4Iq7pfKAOgGeoL+rfXQU1KXv7FENn4Ki+li31JUdufxLQTWaRnLp3BZ0IokB3Drl3qOJ/w6MAct4dlbCP+QqwyPmIYGNeJVsyCBitgFJ4yB7TvGPmjj/xwUG8YR7TA/9UY/XXDV2ytN2B8VMRUGWi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958292; c=relaxed/simple;
	bh=NsajDz5fz+OimIn85N3WC3vaKkNiswIF46oOrsx63yU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kwR0Of441hV3ofzAB8PHy0HOEK5vwujsC8IiesWFxdPQCeytKlrBZ24NpmSBV/z4nvX+LVMatUZKUUpaMeoovbKNSzfgW+L4hio9pNwC8AEbyBqnlGuj20tAtCVwDYzlfWKNa/CXIyHNGhukf/0kB5vX3JOudMO/Z8uXnKeAM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFO9EILm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFO9EILm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D221F000FF;
	Fri,  2 Oct 2026 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958291;
	bh=StozNtaRlynU+MY/DcSGqW9hlJ4drLjbeaJQCzfQy+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VFO9EILm6QGxTlE2oGc8wie6gSKHfQ37dBSek1dnn9LKm2HoNPrwi/rBotqYalZHY
	 vdZje9W4lQiMBF/Vuk2q8LZzLuGqqH8vLFNbMUBuH/V2KI2nDTcqh++lB0qPHCgJCZ
	 Txk3jP5WF058fPQ/hQjphJCLAbHeuSdoRkvNQM/fON8jRWuykjAqRj18Sh9hV67hms
	 t5yRk9DRIphwA9h6jgBvS/YU7Z+iLLKQIlSIbOFiTjXrmvkKSa3weeZXaxM54rvpcJ
	 DlPMWUXnFI3lJYutiDpLWP09yp1/nYtb+LzD2VrA8aP1YM420PgMzV7jSqXANFNdlB
	 On8aJUOtl9UDg==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 02 Oct 2026 18:24:41 +0200
Subject: [PATCH net-next v3 02/12] net: ethernet: cortina: Keep shared free
 queue parent-owned
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-gemini-ethernet-fixes-3-v3-2-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org>
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
more. This can destroy the queue while the sibling port is active and can
free it repeatedly.

Depopulate both port devices before cleaning up the queue, and perform
that cleanup only from the parent. Disable the free-queue interrupt after
the managed handlers have drained, since its threaded handler can
re-enable it. Guard cleanup for probe and removal paths where no queue was
allocated.

Reported-by: Myeonghun Pak <mhun512@gmail.com>
Closes: https://lore.kernel.org/netdev/20260917192835.58126-1-mhun512@gmail.com/
Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 2be3e9051981..15ad9f721dd5 100644
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
@@ -2405,7 +2408,6 @@ static void gemini_port_remove(struct gemini_ethernet_port *port)
 		unregister_netdev(port->netdev);
 	}
 	clk_disable_unprepare(port->pclk);
-	geth_cleanup_freeq(port->geth);
 	gemini_port_clear(port);
 }
 
@@ -2706,6 +2708,8 @@ static void gemini_ethernet_remove(struct platform_device *pdev)
 {
 	struct gemini_ethernet *geth = platform_get_drvdata(pdev);
 
+	devm_of_platform_depopulate(&pdev->dev);
+	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
 	geth_cleanup_freeq(geth);
 	geth->initialized = false;
 }

-- 
2.55.0

