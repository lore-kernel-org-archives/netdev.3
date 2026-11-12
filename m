Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490267;
	b=x9/zMfNih2AF4DwNkYMHx8sLPnhfxVHYIjrulODV3PYA/gpOqPEQYq+hxNg2vOddorCx
	 PVxEpJ1pAbnaglgMiOk11Tf/N6+8mvNNy3aHO5gkAkbmBKrtRb0zCPCilKjIrIty57AjV
	 OcFQGWKsA5Y989OWQiEWlmCK0GuiAbce295M+tRcQZIWZilKHPgD7oHZJm+u60z0iUYoF
	 cuHQHqXnYGySp5AB93qeg0sz+o9BbbZ1TclQMJkZ6F3hYdB+sqFF+F9kegMR5JCMZzqKb
	 FnEliboEOCn3b7hGLPcwpGERMtWZzjLWSGGJOZJot6/0vUfTi/SJUZSeoQM9r1lo8uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490267;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=tGwxVXZYCMI48tMAWgdqT75Rt7/Q7H5nbuP4kLxTk5A=;
	b=P9v5Gr1iQArMJZwd1DGh0zcK91ALHYiiPZqyN6mxrTI472ta8mAClu9BPOO1e5zQJZD2
	 YPD3KzRw+cpwIxpgb7U4NipG/vDtVfjZU2Oqi8Y0WiF3cW4RbLQHjAHgFJIWtA16STRtp
	 sHhnnICuyKAURWrXOawdttaLRnwIJcLgVaDFU4UmYJiSJzkcWUXS6J0xgur+JsB1eNwYu
	 ZCW0/0z1j9NAUI08HXj6upmVp4fLWMNU5w4Lfx9YUODJ3udvuhtz1Mymg3+KAp0CdnVyA
	 ZHZoXER8Ej1G33EVi12obWjIpe75W2VsrcRrK399jZ2SxH9OtMvvTJL58KzQOL9AOYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNjYFgo5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F2F606A8A5
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNjYFgo5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82F31F00A08;
	Thu, 12 Nov 2026 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490267;
	bh=tGwxVXZYCMI48tMAWgdqT75Rt7/Q7H5nbuP4kLxTk5A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RNjYFgo5mpXkX9kY0pkQRD9a77VJfTONW2vL69Yp1UM+gkjk+bzh+lCOvCELh2sIE
	 Okx9caRJB76QZAtHaGIJOSr/iqZtMkyVm7U34Gtnv56+tS525bBsqUduIwuum3hkIO
	 PBHimL8XZ0jVOnXb/fyMa+SpAArEHmTPM+0HrIF0SwCQPXzosqUAUqZfwfEvUfvgKu
	 fBfCYz+KSsgTiITgAWzjeCDEdm3jtMeaIoVPqzLVnjrz5wvkKh9fnSMXDBZFV50hGK
	 OuCz2k366l6Z3AX6AgQRh8vzpWrQ0AtJAlFMls2dNtyCwSdYXtAoGC4NT03ePyETmx
	 N+YmF+YbixLyQ==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 14:30:32 +0100
Subject: [PATCH net-next v8 17/19] net: ethernet: cortina: Drain RX
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
Message-Id: <20261112-gemini-ethernet-fixes-3-v8-17-f55bd43e02d3@kernel.org>
References: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
In-Reply-To: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
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

gmac_open() also initializes the timer after enabling RX interrupts.
With RX coalescing configured, an interrupt can start an uninitialized
timer on first open, or one that setup then reinitializes while queued
on reopen.

Initialize the timer before requesting the IRQ. Keep the early stop-path
cancellation as a best-effort drain of an existing timer; an RX interrupt
can still rearm it before IRQ teardown. napi_disable() handles concurrent
scheduling attempts. Cancel the timer again after free_irq() has drained
the handler, so no timer callback can outlive the port.

This was found by code inspection and tested on the D-Link DIR-685.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index d0d161654f49..24a66fc34738 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2243,6 +2243,10 @@ static int gmac_open(struct net_device *netdev)
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	int err;
 
+	hrtimer_setup(&port->rx_coalesce_timer,
+		      &gmac_coalesce_delay_expired,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+
 	err = request_irq(netdev->irq, gmac_irq,
 			  IRQF_SHARED, netdev->name, netdev);
 	if (err) {
@@ -2279,9 +2283,6 @@ static int gmac_open(struct net_device *netdev)
 	gmac_enable_tx_rx(netdev);
 	netif_tx_start_all_queues(netdev);
 
-	hrtimer_setup(&port->rx_coalesce_timer, &gmac_coalesce_delay_expired, CLOCK_MONOTONIC,
-		      HRTIMER_MODE_REL);
-
 	netdev_dbg(netdev, "opened\n");
 
 	return 0;
@@ -2318,6 +2319,7 @@ static int gmac_stop(struct net_device *netdev)
 
 	phy_stop(netdev->phydev);
 	free_irq(netdev->irq, netdev);
+	hrtimer_cancel(&port->rx_coalesce_timer);
 
 	gmac_update_hw_stats(netdev);
 	return 0;

-- 
2.56.0

