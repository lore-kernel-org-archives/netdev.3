Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12894F3931
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958290; cv=none; b=EFrY48QvYdWjBgEyTAEZqhupZq72hutRS9JoEPGDUeQ+HI1btqRnxpOZQKw/8xh+rsd1Di6ztr3H6APKtaBodQysnEnd+Kj++JulVvrdIPQXPe/s6xAQI09lOdzf5VP3P+nIxYjNPNm8lw71EkV6YjMQRHw9nYtbyAsBAdsIwBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958290; c=relaxed/simple;
	bh=R7EIa4a5StoH9X76jdgS7xz1b9Nuw1Tu58rirFWqRG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIVlF4ijlaojmpuNB9x5fE7gJrv4krGv80+PmlKsCIwQoLT2AtPYxPt582btg1kvrNzOcw/1X7Nemca79FSrC8Pe3JxKXdffpLYcjVoDQqNiKw/Fjvxq5DHzDPq7YatxJRqgPBN18iqyibiAOyN9jPVF77bqYIYcnfRHJymVeZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWsLwvvJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWsLwvvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE951F00893;
	Fri,  2 Oct 2026 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958288;
	bh=S9NRFR/KRBG1Sa+XG1DAfTF44+c3leNN9eNRzUpPDH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iWsLwvvJsDjFr/FFYyrDaCts+7aZiV9pX2FwbwdlcpNAJ03S31Dy/uPWb74WsT2Q7
	 5l8oK7b8iHTDshwTkG1dsBiB7q6YVnDySXdshxV8LuGG5mxrdsTR6znbd6Se8oYyQt
	 ibRJEbhKxx3CdNM25eRxDG9ZxNMdkwGvuHWwYgREuByH+2XiudhQDS2Q9XG+71pTZI
	 l+GhWQ1BJ7AvI3zcYRecSSbpguUPIc4tGXJU+GARg4AULiDLbGMUKgnVtAbHO633ea
	 sUPV/hUzAfoI6l7nMJnAt0fGPLD+h8ITvArELA2IWiq2PvS8+m35b3xonlTTyvGCZq
	 Kjn5aoyJltd6A==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 02 Oct 2026 18:24:40 +0200
Subject: [PATCH net-next v3 01/12] net: ethernet: cortina: Keep PHY-less
 port bound for shared IRQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-gemini-ethernet-fixes-3-v3-1-3e1f25890ae8@kernel.org>
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

The software free queue interrupt is routed through port 1 even on
boards which only connect a PHY to port 0. Since PHY setup was moved
into probe, the PHY-less port fails to bind after installing its parent
pointer. This leaves a dangling port pointer and releases the threaded
handler needed by the shared queue.

Keep children without a PHY description bound as IRQ-only ports. Clear
parent pointers on genuine probe failures and removal, and reject queue
setup cleanly if the port providing the shared interrupt is absent.

Fixes: 3e813d61401a ("net: gemini: Clean up phy registration")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 2fe7fd0202d2..2be3e9051981 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1048,10 +1048,15 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	u32 en;
 	int ret;
 
+	/* The software free queue interrupt is routed through port 1. */
+	if (!geth->port1)
+		return -ENODEV;
+
 	if (netdev->dev_id == 0)
-		other_netdev = geth->port1->netdev;
+		other_port = geth->port1;
 	else
-		other_netdev = geth->port0->netdev;
+		other_port = geth->port0;
+	other_netdev = other_port ? other_port->netdev : NULL;
 
 	if (other_netdev && netif_running(other_netdev))
 		return -EBUSY;
@@ -1062,7 +1067,6 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 		   new_size,
 		   port->rxq_order);
 	if (other_netdev) {
-		other_port = netdev_priv(other_netdev);
 		new_size += 1 << (other_port->rxq_order + 1);
 		netdev_dbg(other_netdev, "port %d size: %d order %d\n",
 			   other_netdev->dev_id,
@@ -2384,6 +2388,16 @@ static irqreturn_t gemini_port_irq(int irq, void *data)
 	return ret;
 }
 
+static void gemini_port_clear(struct gemini_ethernet_port *port)
+{
+	struct gemini_ethernet *geth = port->geth;
+
+	if (!port->id && geth->port0 == port)
+		geth->port0 = NULL;
+	else if (port->id && geth->port1 == port)
+		geth->port1 = NULL;
+}
+
 static void gemini_port_remove(struct gemini_ethernet_port *port)
 {
 	if (port->netdev) {
@@ -2392,6 +2406,7 @@ static void gemini_port_remove(struct gemini_ethernet_port *port)
 	}
 	clk_disable_unprepare(port->pclk);
 	geth_cleanup_freeq(port->geth);
+	gemini_port_clear(port);
 }
 
 static void gemini_ethernet_init(struct gemini_ethernet *geth)
@@ -2598,6 +2613,13 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	if (ret)
 		goto unprepare;
 
+	if (!of_property_present(np, "phy-handle") &&
+	    !of_phy_is_fixed_link(np)) {
+		dev_info(dev, "no PHY, keeping port for shared IRQ\n");
+		port->netdev = NULL;
+		return 0;
+	}
+
 	ret = gmac_setup_phy(netdev);
 	if (ret) {
 		netdev_err(netdev,
@@ -2612,6 +2634,7 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	return 0;
 
 unprepare:
+	gemini_port_clear(port);
 	clk_disable_unprepare(port->pclk);
 	return ret;
 }

-- 
2.55.0

