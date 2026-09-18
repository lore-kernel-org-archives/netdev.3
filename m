Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFF5013C4;
	Fri, 18 Sep 2026 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744455; cv=none; b=StOzroYxlubhKso++iOUZNayeC1nm90EUMifp6k1Nx5rc5qhlKon713zFvb5iE6k+MfJgHTcVJWN22wnsDXJiKezax0CJUkUkRe+ImkEYN//S7cBbUO1qVMjdhPNlI810EFDfL/5rrkewmBPHoDBZDkhB7x6eyhfLHOpjGtc9p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744455; c=relaxed/simple;
	bh=U17uwyjqWSLUicsyQbJaDeASIbAWpfb0sKzKv2PO+3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPaAQrGNWmZqT/2gilfV1RHWlFfONg0juI6fyF0yF1OESttoMdcjGPDO2Vh4i7pfIbdoeTqDEhMo9EY2c06vtBtTfK2AgVrN+orW9JypsnNeLOUedOdPgaJL1bZhlTwwFzRMmuQg982N07pig5ISotAjbj5sZN3EyhDVZjT8Ucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=bbYJIqwO; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="bbYJIqwO"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04F823EF93;
	Fri, 18 Sep 2026 15:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789744450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4FDHcN0dBTzUzRdscUDZpmj3PQrCRMpKATUEGZvSTM=;
	b=bbYJIqwOw50NENBnZL7IhK4hQrCzMtWIkMxYP6nIP9as10GynmjRjFNwVapGn8jNUl8QfZ
	8u4o5baFObwPvmVxGm5cXDTUTXMZ35yw4PVVElJ81QmTbSVY/3yZcJ1GAFNfK18j7OS0xS
	pxvB0qx2WFPNU1sWgBWEUG7aEcpNGzVTaaxy3bY0JbRSDCXysd8qaGHvOwK7HL6wbhkSoD
	eoDSOoyTWylg4vCX5PEG0xBTJF0gx+jiNH1v37iK/ukZcO7oESgh5ntLH5G40GR8e6oV2A
	AU4/nZNccFhmHxo7fzDZ3fgoVFUpKiS4gpzGuEQZCudORe3igi4F48zjsYBV/w==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Fri, 18 Sep 2026 17:13:55 +0200
Subject: [PATCH net-next v9 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-wiznet-link-gpio-v9-3-5536f24d8d6d@marmottus.net>
References: <20260918-wiznet-link-gpio-v9-0-5536f24d8d6d@marmottus.net>
In-Reply-To: <20260918-wiznet-link-gpio-v9-0-5536f24d8d6d@marmottus.net>
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
X-GND-Cause: dmFkZTFS2sth9ps5Z787jmCwf5jUB4saRsy3OjoHb9M4YNA5CDF7I2Mi7BiMfC9+pXRW620mnrspKoKpuOc0KfwAyeWCVCbV9ihLJRxo8ERcxkmdm2DobYI3tVzkDTrt9anaHq9cTSwZq2hofIYHMnYhpdKVL/i+8qiX3vs6lJPcKpu1NGUXorkAEbog0SmgQ04AmGgqICTJVuJmwGqWEHBDoO6GwMfFN2nybgVOhoOZt9dogl9n011JuRx7lK1oLSNPM1QpWV+kQddhVCNqhKijs6Cz5AK23nglakh+K2j6VL4/OavLC4HjoRLI2pYkHkstuapRWIfXpBsbycJgXrXKqb1fnLtMNxiMlsN8wNwQd+4AiJMrDLqv/r+BH1Z4J1l0TxGfSjPvrFgQ2R/luXHauQ8dDnb/COH1AQPsnGuLO2BKzvT02FVOqMXX4Pxj4dEWVA+gNnYE9ryst4TCqatEoiinwiKoP2ipdz78PLHuD6wgImEQ7E6XuNcs88IZ5CsXc73NB7hmgfJ949XFiO5m15aqsS9IdAfXxNEueER0wkAMv3Q9kaUl2WWqgwWqwXa1DmhnqYSQo3vdpqXIckRZy/DoQU1orp5CwsBxTxk8+r8/T+LkeFF9wZmedd+KM/fx36mRHMwXOT2x2WInC3RDye48VmUlTItdkMI5A99h1DcoQg

Detect the carrier state on the w5500 Ethernet controller using the
Link Status bit from the PHY Configuration register (PHYCFGR).

On w5100/w5200, which lack this register, .get_link() is not implemented
and the carrier state is not reported. The carrier state is also not
reported using netif_carrier_on|off().

For the w5500, add an optional interrupt, wired to the LINKLED pin of
the device, to detect link status changes with a read of the PHYCFGR
register and update of the carrier state with netif_carrier_on|off().
If this interrupt is not set in the DT binding, only .get_link() can be
used to get the carrier state, netif_carrier_on|off() is not called. The
interrupt handler and the PHYCFGR register read are synchronized using
a mutex.

A few changes are brought to the bring-up teardown:

 - The net device is registered last in the probe() function so no
   operation can be performed before the probing is finished
 - the net device is unregistered first in remove()
 - dev_name is now used instead of netdev_name
 - w5100_remove(), w5100_stop() and w5100_suspend() call
   cancel_work_sync()/flush_work() to make sure there is no pending
   work
 - the main irq is enabled/disabled in open()/stop() and
   suspend()/resume()
 - enable the link irq after checking PHYCFGR

Commit dacf281771a9 ("w5100: remove unused gpio link detection")
dropped the link_gpio/link_irq handling on the grounds that no
devicetree user passed a "link" gpio at the time and that it used the
old gpio interface.
This isn't a plain revert of that removal: link detection is now done
using a second interrupt rather than a gpio with a documented DT
binding.

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
---
v9:
 - Address Sashiko review
  - Rework commit message
  - Disable the link irq first in w5100_stop()
  - Call w5100_hw_close earlier in w5100_stop()
  - Flush rx/tx work and cancel restart in w5100_stop()
  - Call cancel_work_sync() after unregister_netdev in w5100_remove()
  - Call cancel_work_sync before netif_carrier_off in w5100_suspend()
  - Enable/Disable main irq in open()/stop() and suspend()/resume()
  - Check the number of irqs defined in DT
  - Ignore fwnode_irq_get errors other than EPROBE_DEFER

v8:
 - Add myself in the MAINTAINERS file
 - Address Sashiko reviews from online bot and locally run
  - Add a mutex to synchronize the link state read and interrupt
  - Return last known carrier state (netif_carrier_ok()) in
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
 drivers/net/ethernet/wiznet/w5100.c | 220 ++++++++++++++++++++++++++++++++----
 2 files changed, 199 insertions(+), 22 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e6a5a4e245a0..7e6f7a95a341 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29444,6 +29444,7 @@ M:	Arthur Crepin Leblond <arthur@marmottus.net>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/wiznet,w5100.yaml
+F:	drivers/net/ethernet/wiznet/
 
 WMI BINARY MOF DRIVER
 M:	Armin Wolf <W_Armin@gmx.de>
diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index 53d8dc642fbd..e6dc5fe7c088 100644
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
@@ -345,6 +352,77 @@ static void w5500_memory_configure(struct w5100_priv *priv)
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
+	bool link;
+
+	mutex_lock(&priv->link_lock);
+
+	if (!netif_device_present(ndev)) {
+		link = netif_carrier_ok(ndev);
+		goto out;
+	}
+
+	state = w5500_get_phycfgr_lnk(ndev);
+
+	if (state < 0) {
+		link = netif_carrier_ok(ndev);
+		goto out;
+	}
+
+	link = state > 0;
+
+out:
+	mutex_unlock(&priv->link_lock);
+
+	return link;
+}
+
 static int w5100_hw_reset(struct w5100_priv *priv)
 {
 	u32 rtr;
@@ -448,12 +526,25 @@ static void w5100_restart(struct net_device *ndev)
 {
 	struct w5100_priv *priv = netdev_priv(ndev);
 
+	if (!netif_running(ndev) || !netif_device_present(ndev))
+		return;
+
+	disable_irq(priv->irq);
+	if (priv->link_irq > 0)
+		disable_irq(priv->link_irq);
+
 	netif_stop_queue(ndev);
 	w5100_hw_reset(priv);
+	enable_irq(priv->irq);
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
@@ -656,9 +747,16 @@ static int w5100_open(struct net_device *ndev)
 	struct w5100_priv *priv = netdev_priv(ndev);
 
 	netif_info(priv, ifup, ndev, "enabling\n");
-	w5100_hw_start(priv);
 	napi_enable(&priv->napi);
+	enable_irq(priv->irq);
+	w5100_hw_start(priv);
 	netif_start_queue(ndev);
+
+	if (priv->link_irq > 0) {
+		w5500_report_carrier_state(ndev);
+		enable_irq(priv->link_irq);
+	}
+
 	return 0;
 }
 
@@ -667,13 +765,38 @@ static int w5100_stop(struct net_device *ndev)
 	struct w5100_priv *priv = netdev_priv(ndev);
 
 	netif_info(priv, ifdown, ndev, "shutting down\n");
+
+	disable_irq(priv->irq);
+	if (priv->link_irq > 0)
+		disable_irq(priv->link_irq);
+
+	cancel_work_sync(&priv->restart_work);
+	cancel_work_sync(&priv->setrx_work);
+	flush_work(&priv->rx_work);
+	flush_work(&priv->tx_work);
+
 	w5100_hw_close(priv);
-	netif_carrier_off(ndev);
+
+	if (priv->link_irq > 0)  {
+		mutex_lock(&priv->link_lock);
+		netif_carrier_off(ndev);
+		mutex_unlock(&priv->link_lock);
+	}
+
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
@@ -721,6 +844,8 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 	dev_set_drvdata(dev, ndev);
 	priv = netdev_priv(ndev);
 
+	mutex_init(&priv->link_lock);
+
 	switch (ops->chip_id) {
 	case W5100:
 		priv->s0_regs = W5100_S0_REGS;
@@ -745,15 +870,26 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 		break;
 	default:
 		err = -EINVAL;
-		goto err_register;
+		goto err_mutex;
 	}
 
 	priv->ndev = ndev;
 	priv->ops = ops;
 	priv->irq = irq;
 
+	priv->link_irq = -EINVAL;
+	if (ops->chip_id == W5500) {
+		priv->link_irq = fwnode_irq_get(dev_fwnode(dev), 1);
+		if (priv->link_irq == -EPROBE_DEFER) {
+			err = dev_err_probe(dev, priv->link_irq,
+					    "failed to get link irq\n");
+			goto err_mutex;
+		}
+	}
+
 	ndev->netdev_ops = &w5100_netdev_ops;
-	ndev->ethtool_ops = &w5100_ethtool_ops;
+	ndev->ethtool_ops = ops->chip_id == W5500 ? &w5500_ethtool_ops :
+						    &w5100_ethtool_ops;
 	netif_napi_add_weight(ndev, &priv->napi, w5100_napi_poll, 16);
 
 	/* This chip doesn't support VLAN packets with normal MTU,
@@ -761,15 +897,11 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
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
@@ -794,22 +926,44 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 
 	if (ops->may_sleep) {
 		err = request_threaded_irq(priv->irq, NULL, w5100_interrupt,
-					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					   netdev_name(ndev), ndev);
+					   IRQF_TRIGGER_LOW | IRQF_ONESHOT |
+					   IRQF_NO_AUTOEN,
+					   dev_name(dev), ndev);
 	} else {
 		err = request_irq(priv->irq, w5100_interrupt,
-				  IRQF_TRIGGER_LOW, netdev_name(ndev), ndev);
+				  IRQF_TRIGGER_LOW | IRQF_NO_AUTOEN, dev_name(dev), ndev);
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
@@ -820,14 +974,19 @@ void w5100_remove(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct w5100_priv *priv = netdev_priv(ndev);
 
-	w5100_hw_reset(priv);
+	unregister_netdev(ndev);
+
+	if (priv->link_irq > 0)
+		free_irq(priv->link_irq, ndev);
 	free_irq(priv->irq, ndev);
 
-	flush_work(&priv->setrx_work);
-	flush_work(&priv->restart_work);
-	destroy_workqueue(priv->xfer_wq);
+	w5100_hw_reset(priv);
 
-	unregister_netdev(ndev);
+	cancel_work_sync(&priv->setrx_work);
+	cancel_work_sync(&priv->restart_work);
+
+	destroy_workqueue(priv->xfer_wq);
+	mutex_destroy(&priv->link_lock);
 	free_netdev(ndev);
 }
 EXPORT_SYMBOL_GPL(w5100_remove);
@@ -839,7 +998,18 @@ static int w5100_suspend(struct device *dev)
 	struct w5100_priv *priv = netdev_priv(ndev);
 
 	if (netif_running(ndev)) {
-		netif_carrier_off(ndev);
+		disable_irq(priv->irq);
+		if (priv->link_irq > 0)
+			disable_irq(priv->link_irq);
+
+		cancel_work_sync(&priv->restart_work);
+
+		if (priv->link_irq > 0) {
+			mutex_lock(&priv->link_lock);
+			netif_carrier_off(ndev);
+			mutex_unlock(&priv->link_lock);
+		}
+
 		netif_device_detach(ndev);
 
 		w5100_hw_close(priv);
@@ -854,9 +1024,15 @@ static int w5100_resume(struct device *dev)
 
 	if (netif_running(ndev)) {
 		w5100_hw_reset(priv);
+		enable_irq(priv->irq);
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

