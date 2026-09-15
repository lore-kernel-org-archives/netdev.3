Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB7C346ACE;
	Tue, 15 Sep 2026 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459586; cv=none; b=Q1Pkv5H2POW/MPWQuQ/jVAP2sI6pDrxskgimPq29rO5bWY1y0EGbit3UUYY+lSSWBhl1SOIY/2rvp0tdKKLOlD0qsh9GDEUbCasIUMYi/i4KxQpL+O07NjvZTLizT1GERbAg5vYAh4OkBSyRcCdrqXS+i147NsYEd/oVOsMVNw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459586; c=relaxed/simple;
	bh=ml2g+ppJkaDHul0KvlUDW7KKQjh5kOEaqIj8U0oGT5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JGyu6GKk4UzX8jGWiFZv59HeaZ1uvhitgA5+7MDOSbk4gMS8+UCBpKG3REBjM1G9Ucrs6PIuK04FMsB1kb2GjgfNYGpHjL82pJ+zVo1g9oIRhksSF8anjQIejPBmoNy6MPOWmeTJy8sbGcJEe5tHR4DLTU0Xa2yy0FU42dUmBos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=nOLyo5h4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="nOLyo5h4"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30FD63EDBD;
	Tue, 15 Sep 2026 08:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789459581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tz1aT6Hss6CL1K9BopTDMRxfiQGjjDNLEgSy6K3YP/w=;
	b=nOLyo5h4BK4+YqDjDVzcx7ADbTIXwCfWwzAz+loaMr0OgbEpE6UQJDdbQEFuR9GDdgaN+o
	SWeAWwayfjW/8R3bBytfwZV/iQ+D7EpH4sWZODutUR87zBLWUEIqEyFC0tZ17aTw9tCZft
	S4nbdEoav4KDa7lSUus0p1XKRPwFD0N9CCLIfmS3HliiB79wxEF63cRPmn27JcCZlC0y4n
	gIyOFAnvvsfj1sR58jKSyB61uiEGdC5Pq0/MQxWgfgzzg6fiLN9UY2qdfG6up+9EeQuyJt
	tnvu0EXrIUB4fG031AX39GlhSC05QoKcyCFeqEy2LmeNja63TRduyvCV4A7euA==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Tue, 15 Sep 2026 10:06:04 +0200
Subject: [PATCH net-next v8 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-wiznet-link-gpio-v8-3-d173622474cc@marmottus.net>
References: <20260915-wiznet-link-gpio-v8-0-d173622474cc@marmottus.net>
In-Reply-To: <20260915-wiznet-link-gpio-v8-0-d173622474cc@marmottus.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arthur Crepin Leblond <arthur@marmottus.net>
X-Mailer: b4 0.15.2
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFAFqprjYmMpGKftCTkYlbk5kdK4l8Fitu7zs4+KBA0m8t3VRCs8xUf9+CZ5U3qNYjJxsUJwkHFm6CTcIxkrUixEh9MRSgg+b+3GEgRVe5rGxdkPxTUXurRaic+wE2+hLOnmGcr/adm+W6FlAeH+y8E/wnjtu9WluIC4LFUQWUCjN5rGuBUOIxMySz0myLCeSuyrzkg/LXvW4ECcruBfdzuWPCZwp6ZINeRnspLS9TpE5Yd/tynzLutmhfM0brccBXPAVxNesNx0XZY7/j/f+G1m4k5L9tNogzM4K5fCyjvtneZA9frkKyXLiznFGo2i+z3w4FUXo7q2gbFgrem5XnCFwVZgkYB8NiUwuZZ84sMkJUAgS5gH8ppxE3zjjbggcvu8DsRiyxG6ww4okFYRd50hSx07VCP4xSXc0Y6gtBsn6+0Ov4jaRW6Ee/XlV+I0ZvFklVZW6+Erh6ScsKpHrmmrusA2h4JXGHkpw5qr3ILi+oPIHE72A86iyzQiuODWQk6nKY1+7sAMpn1IT2mJDs69Myl4BvoyrQwN2NpVpFqDvpIem3bbM0aB+qrPpm2Ymcg3Q4dOaPVASzVFL5J1QghzAMLWkhwonWCGz6QMQK9HjkuuoyDkKUdopFD+TssObs/64BRB3dek3PyEpkZ8JYDm34sqzQ8gnoM5Ac8defs6A

Detect the link status on the w5500 using the Link Status bit from the
PHY Configuration register (PHYCFGR).

On w5100/w5200, which lack this register, .get_link is not
implemented and the carrier state is not reported.

Add an optional interrupt, wired to the LINKLED pin of the w5500, to
detect link status changes with a read of the PHYCFGR register and
update of the carrier state with netif_carrier_on|off.
If this interrupt is not set in the DT binding, only .get_link can be
used to get the carrier state. The interrupt handler and the PHYCFGR
register read are synchronized using a mutex.

The carrier state (netif_carrier_on|off) is not called anymore on
w5100/w5200 or w5500 without the link irq.

Make sure that the netdev is registered last in the probe function so
no operation can be performed before the probing is finished. dev_name
is now used instead of netdev_name.

Commit dacf281771a9 ("w5100: remove unused gpio link detection")
dropped the link_gpio/link_irq handling on the grounds that no
devicetree user passed a "link" gpio at the time and that it used the
old gpio interface.
This isn't a plain revert of that removal: link detection is now done
using a second interrupt rather than a gpio with a documented DT binding.

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
---
v8:
 - Add myself in the MAINTAINERS file
 - Address Sashiko reviews from online bot and locally run
  - Add a mutex to synchronize the link state read and interrupt
  - Return last known carrier state (netif_carrier_ok) in
    w5500_get_link on SPI error or if the device is not present
  - Only set ops .get_link on w5500
  - Check the netif state, disable/enable the irq and re-check the
    carrier state in w5100_restart
  - Cancel the restart work on stop/suspend
  - Only set carrier state to off in w5100_stop/suspend  when a link
    irq is present
  - Warn on fwnode_irq_get errors for the link irq
  - Free the main irq and flush queues before resetting the hardware
    in w5100_remove

v7:
 - Address Sashiko reviews
  - Propagate spi read error to the caller
  - Do not change the state of the carrier on SPI read error
  - Enable the link IRQ before reading the PHYCFGR bit
  - Call unregister_netdev before reset
  - Update commit message

v6:
 - Revert to the reviewed v4 version by Arnd Bergmann with a few
   changes based on Sashiko's review
 - Address Sashiko reviews
  - call netif_carrier_off in open if there is no link_irq or  get_link
    returns false
  - call register_netdev at the very end of probe
  - call unregister_netdev before destroying work queue
  - handle link irq probe defer error
  - call netif_device_attach in resume before re enabling the link irq
  - disable the link irq first in suspend
  - log netif_err when PHYCFGR cannot be read
  - enable link irq in open
  - disable link irq in stop
  - free irq and invalidate it in remove

v5:
 - Address Sashiko review
  - Read the link status register only on w5500 instead of checking
    link_irq
  - call netif_carrier_off on w5500 link status off in open
  - enable/disable the link irq in open/stop
  - enable/disable the link irq in resume/suspend
  - handle link irq probe defer error
  - register the netdev last

v4:
 - Use directly an interrupt line instead of gpio -> irq
 - Address Sashiko reviews
 - drop devm_ on request_threaded_irq to avoid use after free
 - disable/enable the link_irq in the suspend/resume
 - only call netif_carrier_on|off if the link interrupt is present

v3:
 - Use the Link Status bit of the PHY Configuration Register
 - Use the LINKLED gpio binding for change detection only

v2:
 - Use devm_request_threaded_irq instead of request_any_context_irq
 - Use devm_gpiod_get_optional instead of gpiod_get_optional
 - Call dev_err_probe on gpiod_to_irq failure
 - Remove link_irq from priv
 - Use a fixed string for the IRQ name
 - Remove empty new lines
---
 MAINTAINERS                         |   1 +
 drivers/net/ethernet/wiznet/w5100.c | 192 ++++++++++++++++++++++++++++++++----
 2 files changed, 174 insertions(+), 19 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 624beed96f32..2a52f5cbe218 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29445,6 +29445,7 @@ M:	Arthur Crepin Leblond <arthur@marmottus.net>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/wiznet,w5100.yaml
+F:	drivers/net/ethernet/wiznet/
 
 WMI BINARY MOF DRIVER
 M:	Armin Wolf <W_Armin@gmx.de>
diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index 53d8dc642fbd..335bafbc9fa4 100644
--- a/drivers/net/ethernet/wiznet/w5100.c
+++ b/drivers/net/ethernet/wiznet/w5100.c
@@ -18,9 +18,11 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
+#include <linux/property.h>
 #include <linux/irq.h>
 
 #include "w5100.h"
@@ -124,6 +126,8 @@ MODULE_LICENSE("GPL");
  */
 #define W5500_SIMR		0x0018 /* Socket Interrupt Mask Register */
 #define W5500_RTR		0x0019 /* Retry Time-value Register */
+#define W5500_PHYCFGR		0x002e /* PHY Configuration Register */
+#define   PHYCFGR_LNK		  0x01 /* Link status */
 
 #define W5500_S0_REGS		0x10000
 
@@ -154,6 +158,9 @@ struct w5100_priv {
 	u16 s0_rx_buf_size;
 
 	int irq;
+	int link_irq;
+	/* Protects link state and carrier updates */
+	struct mutex link_lock;
 
 	struct napi_struct napi;
 	struct net_device *ndev;
@@ -345,6 +352,67 @@ static void w5500_memory_configure(struct w5100_priv *priv)
 	}
 }
 
+static int w5500_get_phycfgr_lnk(struct net_device *ndev)
+{
+	struct w5100_priv *priv = netdev_priv(ndev);
+	int ret = w5100_read(priv, W5500_PHYCFGR);
+
+	if (ret < 0) {
+		netif_err(priv, link, ndev,
+			  "failed to read link status: %d\n", ret);
+		return ret;
+	}
+
+	return ret & PHYCFGR_LNK;
+}
+
+static void w5500_report_carrier_state(struct net_device *ndev)
+{
+	struct w5100_priv *priv = netdev_priv(ndev);
+	int state;
+
+	mutex_lock(&priv->link_lock);
+
+	state = w5500_get_phycfgr_lnk(ndev);
+	if (state > 0) {
+		netif_info(priv, link, ndev, "link is up\n");
+		netif_carrier_on(ndev);
+	} else if (state == 0) {
+		netif_info(priv, link, ndev, "link is down\n");
+		netif_carrier_off(ndev);
+	}
+
+	mutex_unlock(&priv->link_lock);
+}
+
+static irqreturn_t w5500_detect_link_interrupt(int irq, void *ndev_instance)
+{
+	struct net_device *ndev = ndev_instance;
+
+	if (netif_running(ndev))
+		w5500_report_carrier_state(ndev);
+
+	return IRQ_HANDLED;
+}
+
+static u32 w5500_get_link(struct net_device *ndev)
+{
+	struct w5100_priv *priv = netdev_priv(ndev);
+	int state;
+
+	if (!netif_device_present(ndev))
+		return netif_carrier_ok(ndev);
+
+	mutex_lock(&priv->link_lock);
+	state = w5500_get_phycfgr_lnk(ndev);
+	mutex_unlock(&priv->link_lock);
+
+	if (state < 0)
+		return netif_carrier_ok(ndev);
+
+	return state > 0;
+}
+
 static int w5100_hw_reset(struct w5100_priv *priv)
 {
 	u32 rtr;
@@ -448,12 +516,23 @@ static void w5100_restart(struct net_device *ndev)
 {
 	struct w5100_priv *priv = netdev_priv(ndev);
 
+	if (!netif_running(ndev))
+		return;
+
+	if (priv->link_irq > 0)
+		disable_irq(priv->link_irq);
+
 	netif_stop_queue(ndev);
 	w5100_hw_reset(priv);
 	w5100_hw_start(priv);
 	ndev->stats.tx_errors++;
 	netif_trans_update(ndev);
 	netif_wake_queue(ndev);
+
+	if (priv->link_irq > 0) {
+		w5500_report_carrier_state(ndev);
+		enable_irq(priv->link_irq);
+	}
 }
 
 static void w5100_restart_work(struct work_struct *work)
@@ -659,6 +738,12 @@ static int w5100_open(struct net_device *ndev)
 	w5100_hw_start(priv);
 	napi_enable(&priv->napi);
 	netif_start_queue(ndev);
+
+	if (priv->link_irq > 0) {
+		w5500_report_carrier_state(ndev);
+		enable_irq(priv->link_irq);
+	}
+
 	return 0;
 }
 
@@ -667,13 +752,31 @@ static int w5100_stop(struct net_device *ndev)
 	struct w5100_priv *priv = netdev_priv(ndev);
 
 	netif_info(priv, ifdown, ndev, "shutting down\n");
+
+	cancel_work_sync(&priv->restart_work);
+
+	if (priv->link_irq > 0) {
+		disable_irq(priv->link_irq);
+		mutex_lock(&priv->link_lock);
+		netif_carrier_off(ndev);
+		mutex_unlock(&priv->link_lock);
+	}
+
 	w5100_hw_close(priv);
-	netif_carrier_off(ndev);
 	netif_stop_queue(ndev);
 	napi_disable(&priv->napi);
 	return 0;
 }
 
+static const struct ethtool_ops w5500_ethtool_ops = {
+	.get_drvinfo		= w5100_get_drvinfo,
+	.get_msglevel		= w5100_get_msglevel,
+	.set_msglevel		= w5100_set_msglevel,
+	.get_link		= w5500_get_link,
+	.get_regs_len		= w5100_get_regs_len,
+	.get_regs		= w5100_get_regs,
+};
+
 static const struct ethtool_ops w5100_ethtool_ops = {
 	.get_drvinfo		= w5100_get_drvinfo,
 	.get_msglevel		= w5100_get_msglevel,
@@ -721,6 +824,8 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 	dev_set_drvdata(dev, ndev);
 	priv = netdev_priv(ndev);
 
+	mutex_init(&priv->link_lock);
+
 	switch (ops->chip_id) {
 	case W5100:
 		priv->s0_regs = W5100_S0_REGS;
@@ -745,15 +850,26 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 		break;
 	default:
 		err = -EINVAL;
-		goto err_register;
+		goto err_mutex;
 	}
 
 	priv->ndev = ndev;
 	priv->ops = ops;
 	priv->irq = irq;
 
+	priv->link_irq = ops->chip_id == W5500 ?
+			 fwnode_irq_get(dev_fwnode(dev), 1) : -EINVAL;
+	if (priv->link_irq == -EPROBE_DEFER) {
+		err = dev_err_probe(dev, priv->link_irq,
+				    "failed to get link irq\n");
+		goto err_mutex;
+	} else if (priv->link_irq < 0 && priv->link_irq != -EINVAL) {
+		dev_warn(dev, "invalid link irq: %d\n", priv->link_irq);
+	}
+
 	ndev->netdev_ops = &w5100_netdev_ops;
-	ndev->ethtool_ops = &w5100_ethtool_ops;
+	ndev->ethtool_ops = ops->chip_id == W5500 ? &w5500_ethtool_ops :
+						    &w5100_ethtool_ops;
 	netif_napi_add_weight(ndev, &priv->napi, w5100_napi_poll, 16);
 
 	/* This chip doesn't support VLAN packets with normal MTU,
@@ -761,15 +877,11 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 	 */
 	ndev->features |= NETIF_F_VLAN_CHALLENGED;
 
-	err = register_netdev(ndev);
-	if (err < 0)
-		goto err_register;
-
 	priv->xfer_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM | WQ_PERCPU, 0,
-					netdev_name(ndev));
+					dev_name(dev));
 	if (!priv->xfer_wq) {
 		err = -ENOMEM;
-		goto err_wq;
+		goto err_mutex;
 	}
 
 	INIT_WORK(&priv->rx_work, w5100_rx_work);
@@ -795,21 +907,42 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 	if (ops->may_sleep) {
 		err = request_threaded_irq(priv->irq, NULL, w5100_interrupt,
 					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					   netdev_name(ndev), ndev);
+					   dev_name(dev), ndev);
 	} else {
 		err = request_irq(priv->irq, w5100_interrupt,
-				  IRQF_TRIGGER_LOW, netdev_name(ndev), ndev);
+				  IRQF_TRIGGER_LOW, dev_name(dev), ndev);
 	}
 	if (err)
 		goto err_hw;
 
+	if (priv->link_irq > 0) {
+		err = request_threaded_irq(priv->link_irq, NULL,
+					   w5500_detect_link_interrupt,
+					   IRQF_TRIGGER_RISING |
+					   IRQF_TRIGGER_FALLING |
+					   IRQF_ONESHOT | IRQF_NO_AUTOEN,
+					   "w5100-link", ndev);
+		if (err < 0)
+			goto err_irq;
+
+		netif_carrier_off(ndev);
+	}
+
+	err = register_netdev(ndev);
+	if (err < 0)
+		goto err_link_irq;
+
 	return 0;
 
+err_link_irq:
+	if (priv->link_irq > 0)
+		free_irq(priv->link_irq, ndev);
+err_irq:
+	free_irq(priv->irq, ndev);
 err_hw:
 	destroy_workqueue(priv->xfer_wq);
-err_wq:
-	unregister_netdev(ndev);
-err_register:
+err_mutex:
+	mutex_destroy(&priv->link_lock);
 	free_netdev(ndev);
 	return err;
 }
@@ -820,14 +953,22 @@ void w5100_remove(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct w5100_priv *priv = netdev_priv(ndev);
 
-	w5100_hw_reset(priv);
+	unregister_netdev(ndev);
+
+	cancel_work_sync(&priv->rx_work);
+	cancel_work_sync(&priv->tx_work);
+	cancel_work_sync(&priv->setrx_work);
+	cancel_work_sync(&priv->restart_work);
+
+	if (priv->link_irq > 0)
+		free_irq(priv->link_irq, ndev);
+
 	free_irq(priv->irq, ndev);
+	w5100_hw_reset(priv);
 
-	flush_work(&priv->setrx_work);
-	flush_work(&priv->restart_work);
 	destroy_workqueue(priv->xfer_wq);
+	mutex_destroy(&priv->link_lock);
 
-	unregister_netdev(ndev);
 	free_netdev(ndev);
 }
 EXPORT_SYMBOL_GPL(w5100_remove);
@@ -839,9 +980,17 @@ static int w5100_suspend(struct device *dev)
 	struct w5100_priv *priv = netdev_priv(ndev);
 
 	if (netif_running(ndev)) {
-		netif_carrier_off(ndev);
+		if (priv->link_irq > 0) {
+			disable_irq(priv->link_irq);
+			mutex_lock(&priv->link_lock);
+			netif_carrier_off(ndev);
+			mutex_unlock(&priv->link_lock);
+		}
+
 		netif_device_detach(ndev);
 
+		cancel_work_sync(&priv->restart_work);
+
 		w5100_hw_close(priv);
 	}
 	return 0;
@@ -857,6 +1006,11 @@ static int w5100_resume(struct device *dev)
 		w5100_hw_start(priv);
 
 		netif_device_attach(ndev);
+
+		if (priv->link_irq > 0) {
+			w5500_report_carrier_state(ndev);
+			enable_irq(priv->link_irq);
+		}
 	}
 	return 0;
 }

-- 
2.55.0

