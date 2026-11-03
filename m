Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728319;
	b=VZdIESAVJAjj7hDe24k7V+mxamvOXvU8K1wzP7Bewh2808p+fcQCfQGN8N9CkDWK9Aqr
	 9wg+XAE8kDw0iKbYbenX5EwcQYarCjb9U6hVUyE0f/2CpAwDxu7Wr7dO56N6c28Spg8N7
	 oxkfD4k90WNw7XG7csO7S7dvKf6NvDqcs3TWOeVuRyO0Xw+ul+1h1Pyp5zJs6gpuyWwqw
	 tFrSqEDZTF4pc2AOQarvG+0Uj7xaCUFGXeuau+oXfeNV1p1H6BbwR+j5ZubgrFBtrOP7d
	 ovCzZQtdoxuptKwVXj1PKnD6Rxbo/DtwZFew0hLixMEophBYQFE9TJWeL7u5yW+I4fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728319;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=yOoskEkhcENCBR5CgtNpFEXxmqGszMkffnbh+nNVs0g=;
	b=zr5HsmcaaF3DUSUgHp5soOnc1hPAKIuWXuKX0JNPV4jpxdMoU2VCI8ivkyFsBgvkEtMS
	 taESFO7dJqkrN0j0BdT67YviZAUItHIt32yGA4sj1iM3JBBjHmUk201XpzY4hTWk5ofzI
	 oPqOFa7J1iCxPJIJAlHSr1aTWsXf4KhtYvEqBbWRR3S+2dEDl25yk18Lv/B25cBQxv36q
	 tBH5ZlbXyM+J8F24cQV6lnUKSSTzWWvOhKLvZdTByd9TmS8VDm/BSDYi6tsD76HIa+YIU
	 HRNCp3qZJMJSdjjd0HW0LzJ8vxpg7GxisafVxJZQoxHSy/Y3wDwDl+vmBMMPnNNyyxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDuMhVaD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25D606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDuMhVaD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645451F000C1;
	Tue,  3 Nov 2026 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728319;
	bh=yOoskEkhcENCBR5CgtNpFEXxmqGszMkffnbh+nNVs0g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YDuMhVaDED01tfbd1vextX9nHYdD/uUrrKuAwww0yd3t3tlnCvPCWfaorinV+MQvE
	 bsSTx1McAKrrP/LCQVQUDfQ6ijwXX7kcblqqru4uU29svIisaZtOPK0CDpw+/h+aqG
	 V9PIou4nK5eGVk6Bf85j4uC9fvh6vM90QDEFMJ5cFmRp80BvbCoSlPyK6yVB3zADx1
	 tk5sX6kS1NNw5IeZhbUHuwLI3xmx5pJBT69D7hpHJouin6evFh/7Ufvk5fCC8voTfi
	 rKlAM4C1a1t2gnFQlgmejClZDTqhpQP/1b7rySscvyVoAmVH1yZQS7FvXdaYMIPPx4
	 FJ6kM59gNpsNA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 03 Nov 2026 18:51:26 +0100
Subject: [PATCH net-next v6 15/15] net: ethernet: cortina: Drain RX
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
Message-Id: <20261103-gemini-ethernet-fixes-3-v6-15-c4b5ff8a65d8@kernel.org>
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
index c32e9574c8c9..d4afe6efb29e 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2194,6 +2194,10 @@ static int gmac_open(struct net_device *netdev)
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	int err;
 
+	hrtimer_setup(&port->rx_coalesce_timer,
+		      &gmac_coalesce_delay_expired,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+
 	err = request_irq(netdev->irq, gmac_irq,
 			  IRQF_SHARED, netdev->name, netdev);
 	if (err) {
@@ -2230,9 +2234,6 @@ static int gmac_open(struct net_device *netdev)
 	gmac_enable_tx_rx(netdev);
 	netif_tx_start_all_queues(netdev);
 
-	hrtimer_setup(&port->rx_coalesce_timer, &gmac_coalesce_delay_expired, CLOCK_MONOTONIC,
-		      HRTIMER_MODE_REL);
-
 	netdev_dbg(netdev, "opened\n");
 
 	return 0;
@@ -2269,6 +2270,7 @@ static int gmac_stop(struct net_device *netdev)
 
 	phy_stop(netdev->phydev);
 	free_irq(netdev->irq, netdev);
+	hrtimer_cancel(&port->rx_coalesce_timer);
 
 	gmac_update_hw_stats(netdev);
 	return 0;

-- 
2.56.0

