Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B03C9EE8;
	Thu, 24 Sep 2026 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243325; cv=none; b=LQi6Rq1mO9enJ3Xqw67cO/tv7r2R8EvIrWygAd4BUyBGGf89FiEza6nNkXfd+nkt49H/ipypkPpEvfIJ3/D2um3pejWudtNxeZNkriB3TAUltgWspxk4iPxg3VgM5+mriuMu6cfL1m4dqE8dpGeZgdBEIdVP2mNezaaHw3JPVu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243325; c=relaxed/simple;
	bh=ABycP1boVD5JnjPirc0mSCFrb1byah1MF5E4GGcraDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F6w2sjakdJO2U2JrIC3WLOPrq/6EtPOI6Qy7XeFJy3tU1HkmI/vk/9LKGgMV/AhGj64Jq4PMZN/Gr+3rL9a4ef1HeqAmQF7NkOveToh5vnFr6xrJHueonSQ9gbqvy4GjLQi6sRu3UZ+ocMNPfmpfH+BHTmPKXDU+I2aNzMVLOXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=o32hKqjp; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="o32hKqjp"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 467663EDFA;
	Thu, 24 Sep 2026 09:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1790243308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyvqSEiVR9E2Ts4gxha7eZ8S2YO8UQ5qjLW+fh5J7gw=;
	b=o32hKqjpF9iXOEv0+YmLIqYzCiGxovv1BuiMtvS5r1NZQDdUA5CLh+7EvlnH+hL3mMQCh8
	4WE5Lj3DCnSsrQ2w2q9xRDn+NGSuuSClRyipbdVoQmtPpovVizWHSNe49zFvKhd+58Kx46
	NxSJPmb1/ZVCudIcxR2XrPHnqo0G9E9FQ4eBTD454CaVU4pkY8tzFS4oo3rdwE20ZB3IL+
	nHiW6REgn72OdFT0/plIRyieQIJeC5QrsLK5/BfZB2bNAXxo1YTRuE7v44u/N0a3yniSkk
	SLPbt6Isy1mAga/Vrh6hCdieItPAT9Tr7uRf2/sJX1D1UXHFd05ud/oNojjCPg==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Thu, 24 Sep 2026 11:48:13 +0200
Subject: [PATCH net-next v11 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-wiznet-link-gpio-v11-3-42a332517b30@marmottus.net>
References: <20260924-wiznet-link-gpio-v11-0-42a332517b30@marmottus.net>
In-Reply-To: <20260924-wiznet-link-gpio-v11-0-42a332517b30@marmottus.net>
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
X-GND-Cause: dmFkZTEjLBf4y4Siu2iwbVH18d6vixFRfFlkBwnrNIfLoSiA6THOUXuxHkCV+kQPJfUtihY6IS07ihrBNpGO3LGviKc8LNOMkRXeypMNfcSrxd/tEVy/2UL7m3p76A2/5L7PXQmchic95PSAdePrNfeZCpoZnndGEQuruoUHGybRCkhO8TFtPAyVI7xG6aVoCvCniKf8YFsF70iaOmF+TacJLIPSipNytlQp6WYWen187J93xlN5AIu6PGrrGVNaOcHto+MJMr/Xgm+ad7VVrUquD2gf85seYuuN0CIVVemdURze1E4QBKtVu8L3+cXcVAAuOhiRsdSlPRqxcMUKOEpSGF/Ur8QLhHo48pgri6tJD7PBe/ndd/gS87oUqq0vY1jlF0fLm+9lea4GW2U7OmWo4rMA1cRxxyIdV38oxUNlGjtIOH5MJmTD1PJpgAkWq9ZDovNo+Y7vtT7iKs9oRwqsffhrRlE1GNVHXBoDDz4C9gp/ATViXa1aG0/WFVSfGwBzabMRT0zGUVLszTDHN/CPCcIVgSOnIT+XS4pRlFdcmnwbFTgFukLztyWcKaY8nOfiMqCtO37iRyOi7SjrCJhQO4Ec57OBtwh1tK/cdr4SNiTdOIaCi+jAnptHE/nFrnXQHDVo/1RC6us9Z78Z3u5hUjvpD35evrXv39Ao8Y7D5H5rNQ

Detect the carrier state on the w5500 Ethernet controller using the
Link Status bit from the PHY Configuration register (PHYCFGR).

On w5100/w5200, which lack this register, get_link() is not implemented
and the carrier state is not reported (netif_carrier_(on|off) is not
called).

For the w5500, add an optional interrupt, wired to the LINKLED pin of
the device, to detect link status changes with a read of the PHYCFGR
register and update of the carrier state with netif_carrier_(on|off).
If this interrupt is not set in the DT binding, get_link() is not
implemented and the carrier state is not reported
(netif_carrier_(on|off) is not called).
The interrupt handler and the PHYCFGR register readings are
synchronized using a mutex.

A few changes are also brought for the bring-up/teardown
synchronization:

 - The net device is registered last in the probe() function so no
   operation can be performed before the probing is finished
 - The net device is unregistered first in remove()
 - dev_name is now used instead of netdev_name
 - w5100_stop() calls cancel_work_sync() and flush_work() to make sure
   there is no race condition or unfinished work
 - w5100_suspend() calls w5100_stop()
 - w5100_resume() calls w5100_open()
 - The main irq is not automatically enabled in w5100_probe() but in
   w5100_open() and disabled in w5100_stop()

Commit dacf281771a9 ("w5100: remove unused gpio link detection")
dropped the link_gpio/link_irq handling on the grounds that no
devicetree user passed a "link" gpio at the time and that it used the
old gpio interface.
This isn't a plain revert of that removal: link detection is now done
using a second interrupt rather than a gpio with a documented DT
binding.

Set the WIZNET entry as DRIVER and add drivers/net/ethernet/wiznet in
MAINTAINERS file.

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
---
v11:
 - Fix line over 80 columns
 - Update commit message
 - Enable the link irq after reporting the carrier state
 - Call w5100_hw_close() earlier before cancelling/flushing the queues
   in w5100_stop()
 - Call w5100_stop() in w5100_suspend()
 - Call w5100_open() in w5100_resume()
 - Issue a reset w5100_open()
 - Call netif_stop_queue() earlier in w5100_stop() to avoid race
   condition
 - Prevent w5100_rx_work() from re-enabling the interrupt
 - Add a retry mechanism when reading PHYCFGR
 - Protect netif_device_attach|detach behind a mutex

v10:
 - Address Sashiko review
  - Always schedule the restart work to avoid atomic context
  - Move netif_device_detach before disabling irq in w5100_suspend
  - Flush rx/tx queues in w5100_remove

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
 MAINTAINERS                         |   3 +-
 drivers/net/ethernet/wiznet/w5100.c | 234 +++++++++++++++++++++++++++++++-----
 2 files changed, 206 insertions(+), 31 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42acc7bb7bfd..e6028e8e564c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29451,11 +29451,12 @@ M:	Miloslav Trmac <mitr@volny.cz>
 S:	Maintained
 F:	drivers/input/misc/wistron_btns.c
 
-WIZNET W5100 ETHERNET BINDINGS
+WIZNET W5100 ETHERNET DRIVER
 M:	Arthur Crepin Leblond <arthur@marmottus.net>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/wiznet,w5100.yaml
+F:	drivers/net/ethernet/wiznet/
 
 WMI BINARY MOF DRIVER
 M:	Armin Wolf <W_Armin@gmx.de>
diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index 53d8dc642fbd..dff39ba8103c 100644
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
@@ -345,6 +352,82 @@ static void w5500_memory_configure(struct w5100_priv *priv)
 	}
 }
 
+static int w5500_get_phycfgr_lnk(struct net_device *ndev)
+{
+	struct w5100_priv *priv = netdev_priv(ndev);
+	int retries = 3;
+	int ret;
+
+	do {
+		ret = w5100_read(priv, W5500_PHYCFGR);
+		if (ret < 0)
+			netif_err(priv, link, ndev,
+				  "failed to read link status: %d\n", ret);
+	} while (ret < 0 && --retries);
+
+	if (ret < 0)
+		return ret;
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
@@ -448,12 +531,28 @@ static void w5100_restart(struct net_device *ndev)
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
+	w5100_hw_close(priv);
+	flush_work(&priv->rx_work);
+	flush_work(&priv->tx_work);
 	w5100_hw_reset(priv);
+	enable_irq(priv->irq);
 	w5100_hw_start(priv);
 	ndev->stats.tx_errors++;
 	netif_trans_update(ndev);
 	netif_wake_queue(ndev);
+
+	if (priv->link_irq > 0) {
+		enable_irq(priv->link_irq);
+		w5500_report_carrier_state(ndev);
+	}
 }
 
 static void w5100_restart_work(struct work_struct *work)
@@ -468,10 +567,7 @@ static void w5100_tx_timeout(struct net_device *ndev, unsigned int txqueue)
 {
 	struct w5100_priv *priv = netdev_priv(ndev);
 
-	if (priv->ops->may_sleep)
-		schedule_work(&priv->restart_work);
-	else
-		w5100_restart(ndev);
+	schedule_work(&priv->restart_work);
 }
 
 static void w5100_tx_skb(struct net_device *ndev, struct sk_buff *skb)
@@ -564,7 +660,8 @@ static void w5100_rx_work(struct work_struct *work)
 	while ((skb = w5100_rx_skb(priv->ndev)))
 		netif_rx(skb);
 
-	w5100_enable_intr(priv);
+	if (netif_running(priv->ndev))
+		w5100_enable_intr(priv);
 }
 
 static int w5100_napi_poll(struct napi_struct *napi, int budget)
@@ -656,9 +753,17 @@ static int w5100_open(struct net_device *ndev)
 	struct w5100_priv *priv = netdev_priv(ndev);
 
 	netif_info(priv, ifup, ndev, "enabling\n");
+	w5100_hw_reset(priv);
+	enable_irq(priv->irq);
 	w5100_hw_start(priv);
 	napi_enable(&priv->napi);
 	netif_start_queue(ndev);
+
+	if (priv->link_irq > 0) {
+		enable_irq(priv->link_irq);
+		w5500_report_carrier_state(ndev);
+	}
+
 	return 0;
 }
 
@@ -667,13 +772,40 @@ static int w5100_stop(struct net_device *ndev)
 	struct w5100_priv *priv = netdev_priv(ndev);
 
 	netif_info(priv, ifdown, ndev, "shutting down\n");
-	w5100_hw_close(priv);
-	netif_carrier_off(ndev);
+
+	disable_irq(priv->irq);
+	if (priv->link_irq > 0)
+		disable_irq(priv->link_irq);
+
 	netif_stop_queue(ndev);
 	napi_disable(&priv->napi);
+
+	cancel_work_sync(&priv->restart_work);
+	cancel_work_sync(&priv->setrx_work);
+
+	w5100_hw_close(priv);
+
+	flush_work(&priv->rx_work);
+	flush_work(&priv->tx_work);
+
+	if (priv->link_irq > 0)  {
+		mutex_lock(&priv->link_lock);
+		netif_carrier_off(ndev);
+		mutex_unlock(&priv->link_lock);
+	}
+
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
@@ -721,6 +853,8 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 	dev_set_drvdata(dev, ndev);
 	priv = netdev_priv(ndev);
 
+	mutex_init(&priv->link_lock);
+
 	switch (ops->chip_id) {
 	case W5100:
 		priv->s0_regs = W5100_S0_REGS;
@@ -745,15 +879,27 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
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
+	ndev->ethtool_ops = priv->link_irq > 0 ? &w5500_ethtool_ops :
+						 &w5100_ethtool_ops;
+
 	netif_napi_add_weight(ndev, &priv->napi, w5100_napi_poll, 16);
 
 	/* This chip doesn't support VLAN packets with normal MTU,
@@ -761,15 +907,11 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
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
@@ -794,22 +936,45 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 
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
+				  IRQF_TRIGGER_LOW | IRQF_NO_AUTOEN,
+				  dev_name(dev), ndev);
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
@@ -820,14 +985,21 @@ void w5100_remove(struct device *dev)
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
+	cancel_work_sync(&priv->setrx_work);
+	cancel_work_sync(&priv->restart_work);
+	flush_work(&priv->rx_work);
+	flush_work(&priv->tx_work);
 
-	unregister_netdev(ndev);
+	w5100_hw_reset(priv);
+
+	destroy_workqueue(priv->xfer_wq);
+	mutex_destroy(&priv->link_lock);
 	free_netdev(ndev);
 }
 EXPORT_SYMBOL_GPL(w5100_remove);
@@ -839,10 +1011,11 @@ static int w5100_suspend(struct device *dev)
 	struct w5100_priv *priv = netdev_priv(ndev);
 
 	if (netif_running(ndev)) {
-		netif_carrier_off(ndev);
+		mutex_lock(&priv->link_lock);
 		netif_device_detach(ndev);
+		mutex_unlock(&priv->link_lock);
 
-		w5100_hw_close(priv);
+		w5100_stop(ndev);
 	}
 	return 0;
 }
@@ -853,10 +1026,11 @@ static int w5100_resume(struct device *dev)
 	struct w5100_priv *priv = netdev_priv(ndev);
 
 	if (netif_running(ndev)) {
-		w5100_hw_reset(priv);
-		w5100_hw_start(priv);
+		w5100_open(ndev);
 
+		mutex_lock(&priv->link_lock);
 		netif_device_attach(ndev);
+		mutex_unlock(&priv->link_lock);
 	}
 	return 0;
 }

-- 
2.55.0

