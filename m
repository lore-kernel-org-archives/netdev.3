Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348849;
	b=FNi34l+jxjEBYtBvSraYJ1+2hVDnIfwpBe39ntZ8ssIMPj3+vc4uevWFAh6Y+KHxCvHq
	 paXHsjycFmKy2cOmqpT1xifhUk8b1MjkXqDkN3GR06DTWYbMOsohlwYDJsGJ7kMx7QujH
	 pq4wv396qJQewW52BoBCIAACPmmqDYv/pZEf7vUUeGJuDqXBpYp5Sn1UyiMpVoP9ccmnH
	 uw799rRveqIx6EQJCVcAs9FWRME0TXr4AZwcgVZUI9Kg+808aARyziy+jr6+c7lEvtoBe
	 f3vf8YKZGPsCXccwgC5iFFT7qnY0fM3C2n+jSteVLhm7GE6/3Io/ZZUhZygbQnO8EHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348849;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=pGLoh0u5RmNG4gqtS+J5b9z7SMZ9u0takAT1avgzd/8=;
	b=BCP+St3YyajQBV3U6hdLfBlGJ5bkhYasIw2rNBe6xLG+E5/ScLtJj/JGyM5udBLaey4p
	 0P6POY3sdRN2hJ7HDPqxPGBkR2mJXx3R1FO021CaYvctaI53UpVkaPQ5j4EO2gupb4gN3
	 DwPyRH8nYaiWGUvI1ngVgKPfhYljDr3Q0fTQ6wISRMV4T0lSHFiHJNbN2A8FS/nx4IuID
	 paHS+eDaXesKs4XwvFSDwhGISzI8zLbCnFr3urlze7KtXtVjZSBTH4uMIOEogfhsoxqAm
	 qAuBoH+nqRuo9m4ujZVud3rxKJ7qTiUeHfoVzynC5FpYlJQOGsGlK+q3KCb5u8jBrAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YANC1yBn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7C1606A33B
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YANC1yBn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BB41F008A5;
	Tue, 10 Nov 2026 22:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348848;
	bh=pGLoh0u5RmNG4gqtS+J5b9z7SMZ9u0takAT1avgzd/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YANC1yBn6B9BdbMc2C1COMDM2buw+Kb59I4vvsNNNP7iDhR4XbNocEmDsNH7Wspew
	 nZncKE3AoOTdFcV7vqM0PaV8MDWNfDrV33UVjzVYfVk1R1TYWO8TVW12g3dEiem7mE
	 JD9R2dF9EUVf5boR+M1fleKGMdawY/mcJ+KbitVjPm8BIZgveHiX8/Wy/gup5e+9OI
	 uGF2OJnBlsrvqftlpLKcSHebtf0fxq70cQCJHoUDUQckLZxCD06D57zsOaKyO7Ajm5
	 mq39ffR80+NGg0qvuNmU4VKKKd/S4fxenRT8M39NtYSblwj3g9fhjFxGVXcdB5WQsL
	 debA/N69BV+mw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:31 +0100
Subject: [PATCH net-next v7 16/18] net: ethernet: cortina: Drain RX
 coalescing timer on stop
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
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-16-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

gmac_stop() cancels the RX coalescing timer before disabling and
freeing the IRQ. An RX interrupt racing with that cancellation can
rearm the timer, leaving it queued after the netdev and its private
port state have been freed.

Initialize the timer before requesting the IRQ, and cancel it again
after free_irq() has drained every handler that can rearm it. Keep the
first cancellation to prevent the timer callback from scheduling NAPI
while the poll instance is being disabled.

This was found by code inspection and tested on the D-Link DIR-685.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 59e6aeb07e0b..58d6ed81a59c 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2201,6 +2201,10 @@ static int gmac_open(struct net_device *netdev)
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	int err;
 
+	hrtimer_setup(&port->rx_coalesce_timer,
+		      &gmac_coalesce_delay_expired,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+
 	err = request_irq(netdev->irq, gmac_irq,
 			  IRQF_SHARED, netdev->name, netdev);
 	if (err) {
@@ -2237,9 +2241,6 @@ static int gmac_open(struct net_device *netdev)
 	gmac_enable_tx_rx(netdev);
 	netif_tx_start_all_queues(netdev);
 
-	hrtimer_setup(&port->rx_coalesce_timer, &gmac_coalesce_delay_expired, CLOCK_MONOTONIC,
-		      HRTIMER_MODE_REL);
-
 	netdev_dbg(netdev, "opened\n");
 
 	return 0;
@@ -2276,6 +2277,7 @@ static int gmac_stop(struct net_device *netdev)
 
 	phy_stop(netdev->phydev);
 	free_irq(netdev->irq, netdev);
+	hrtimer_cancel(&port->rx_coalesce_timer);
 
 	gmac_update_hw_stats(netdev);
 	return 0;

-- 
2.56.0

