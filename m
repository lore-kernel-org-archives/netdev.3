Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BF94746C1;
	Fri,  4 Sep 2026 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525385; cv=none; b=UsBhtgN7hopKxtJiUydLgIWI4WZvJEawyYk4Bob+78i+Lmm0GzE/RSSEiFvLlrhXuwR1VHG1dTseyu60YFp1yRGsoT0cw55fKY/sTpEx+Q5T1czuBr6ZPgM4WMOPo0xIp8VRLoJiN0uxAF2DFBCJ2jF6jed1DjtFoeY+1tmoWsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525385; c=relaxed/simple;
	bh=wkD9qgpUwvA7a2CzDHOQ9mwyy5QbT0SqBmqmXQwNObg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NUZcszHvisDJboGusNv+Hv7Y1/MUh3G4S320w+l0U2B0JSFDlpNpArk/dMcnsTp0ommyVWB+roAlOGcqQlGcv2K8OpR6DnfLUhjkTtsGwYhI/Jwyv4jFBBe94Wp8/debip6x0n3NQxc2rL5FSmqw6bVHekcg1UIcwQ97KKV8qRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=AD8BbN10; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="AD8BbN10"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 802123EC45;
	Fri,  4 Sep 2026 12:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1788525380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqg4kz9gu5UYEDh9qK2Iw1PpJBYcKjXWKjKpK/DqoKw=;
	b=AD8BbN10Xq8zXZh5rmoLPlurCGMvuJgl28hWi8uaixvS3kesgcQZdDMG11oEbNHqshtanM
	K7Zq5EBXNhyL7VuEDbtl43lrJrKXcpeOZXi7fsHH4QsAGULoTEn/W4xxD+Z/ryJl/Bi52V
	P3+T7Tsl+B0U7zcbnW9G47IXwdwNMsCssijRCwXHAxgsqj+TK1YjJMKw1QzoxU7c4+0wWh
	h8z9POL6BkQ2Fttv38nNVlZmClD4y3IpyaPhw8RubzKHQu6S8C5GzEBbfxP1D/PTNSnFxI
	AQKxfM3nIxLm+KGC4JC94Yb0vH3PVlYyHpP+uYtfpVaSjQG5upiRUgkhu1awjA==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Fri, 04 Sep 2026 14:36:00 +0200
Subject: [PATCH net-next v7 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-wiznet-link-gpio-v7-3-69f01b70c96f@marmottus.net>
References: <20260904-wiznet-link-gpio-v7-0-69f01b70c96f@marmottus.net>
In-Reply-To: <20260904-wiznet-link-gpio-v7-0-69f01b70c96f@marmottus.net>
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
X-GND-Score: -100
X-GND-Cause: dmFkZTEoOYE3Xl6y4pTm5T+4LfZ+vI1me5AQIa/0kee7YJbhaP2OOwvVGFmP50XqXW5VBYfYrYRYpePdOPaLJahVt9qVXaRAzsYF9UrEOayBgoU229nqEAV2ugUFtmvABk7auKo40dVBv0HI9vTPPT+eBalFuH3vAbOKW8GcB2Usj80XuCX3U/nuYOckWFNnfSLRzmz4D4OXU5X8yfJMT678pk5YH7+8dK+SbrXOKVPlo0eMLURjl/yK10y7d0BhqXc60++ve9AjUxTSehclyyf+aeAlszTfDZlxJLa90OGGzjy15COvSYEqoqFGtUK0ulfdifIE7iQKnZ1h1AQPTvrbG05sp6OYZZaYH9KFOvfkDihm3fzow4XTpiQM08tZT7k3rv6I9KXVrSpSTmgY/G1E4hG2c2cGhQPRQrTVlrEAZejsBht/1VIIqhklm8PJfHQWwJ6vLnsV3Ot5BCtaJNRYLSYqFD2OUC03Rdl8Z67fg3T3QpTe2GG0Svwn0Y1Jis8lVl/80igUeXH2wAZpvVzVRAQ1uBVY5jqPTWkUILOwCS9zN2JCiU3rIDpONp0txR4UDBdxJ46ebrPkmftdLX/rkAIXDWi+2vpTdiH4CIGnBv3f8MuafS6tyHNGU/Sn44SMa8VD9qqVNcy8cBBh3aCc1vp8wHDu3ub7EMUexE12OlJNnA
X-GND-State: clean

Detect the link status on the w5500 using the Link Status bit from the
PHY Configuration register (PHYCFGR).

On w5100/w5200, which lack this register, the link is always reported
as up.

Also add an optional interrupt, wired to the LINKLED pin of
the w5500, to detect link status changes and read the PHYCFGR register.
The initial link state is always probed from PHYCFGR regardless of
whether the link interrupt is available. The interrupt is only needed
to detect subsequent link changes.

Make sure that the netdev is registered last in the probe function so
no operation can be performed before the probing is finished.

The w5500 interrupt is only enabled when the netdev is opened and
disabled on stop. Same behavior for suspend/resume.

Commit dacf281771a9 ("w5100: remove unused gpio link detection")
dropped the link_gpio/link_irq handling on the grounds that no
devicetree user passed a "link" gpio at the time and that it used the
old gpio interface.
This isn't a plain revert of that removal: link detection is now done
using a second interrupt rather than a gpio with a documented DT binding.

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>

---
v7:
 - Address Sashiko reviews
 - Propagate spi read error to the caller
 - Do not change the state of the carrier on SPI read error
 - Enable the link IRQ before reading the PHYCFGR bit
 - Call unregister_netdev before reset
 - Update commit message

v6:
 - Revert to the reviewed v4 version by Arnd Bergmann with a few
changes based on Sashiko's review:
 - call netif_carrier_off in open if there is no link_irq or  get_link
 returns false
 - call register_netdev at the very end of probe
 - call unregister_netdev before destroying work queue
 - handle link irq probe defer error
 - call netif_device_attach in resume before reenabling the link irq
 - disable the link irq first in suspend
 - log netif_err when PHYCFGR cannot be read
 - enable link irq in open
 - disable link irq in stop
 - free irq and invalidate it in remove

v5:
 - Read the link status register only on w5500 instead of checking link_irq
 - Address sashiko review
 - call netif_carrier_off on w5500 link status off in open
 - enable/disable the link irq in open/stop
 - enable/disable the link irq in resume/suspend
 - handle link irq probe defer error
 - register the netdev last

v4:
 - Use directly an interrupt line instead of gpio -> irq
 - Address sashiko reviews
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
 drivers/net/ethernet/wiznet/w5100.c | 123 ++++++++++++++++++++++++++++++++----
 1 file changed, 112 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index 53d8dc642fbd..ecb99621d0a1 100644
--- a/drivers/net/ethernet/wiznet/w5100.c
+++ b/drivers/net/ethernet/wiznet/w5100.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
+#include <linux/property.h>
 #include <linux/irq.h>
 
 #include "w5100.h"
@@ -124,6 +125,8 @@ MODULE_LICENSE("GPL");
  */
 #define W5500_SIMR		0x0018 /* Socket Interrupt Mask Register */
 #define W5500_RTR		0x0019 /* Retry Time-value Register */
+#define W5500_PHYCFGR		0x002e /* PHY Configuration Register */
+#define   PHYCFGR_LNK		  0x01 /* Link status */
 
 #define W5500_S0_REGS		0x10000
 
@@ -154,6 +157,7 @@ struct w5100_priv {
 	u16 s0_rx_buf_size;
 
 	int irq;
+	int link_irq;
 
 	struct napi_struct napi;
 	struct net_device *ndev;
@@ -345,6 +349,44 @@ static void w5500_memory_configure(struct w5100_priv *priv)
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
+static irqreturn_t w5500_detect_link(int irq, void *ndev_instance)
+{
+	struct net_device *ndev = ndev_instance;
+	struct w5100_priv *priv = netdev_priv(ndev);
+	int state;
+
+	if (!netif_running(ndev))
+		return IRQ_HANDLED;
+
+	state = w5500_get_phycfgr_lnk(ndev);
+	if (state < 0)
+		return IRQ_HANDLED;
+
+	if (state) {
+		netif_info(priv, link, ndev, "link is up\n");
+		netif_carrier_on(ndev);
+	} else {
+		netif_info(priv, link, ndev, "link is down\n");
+		netif_carrier_off(ndev);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int w5100_hw_reset(struct w5100_priv *priv)
 {
 	u32 rtr;
@@ -414,6 +456,16 @@ static void w5100_get_drvinfo(struct net_device *ndev,
 		sizeof(info->bus_info));
 }
 
+static u32 w5100_get_link(struct net_device *ndev)
+{
+	struct w5100_priv *priv = netdev_priv(ndev);
+
+	if (priv->ops->chip_id == W5500)
+		return w5500_get_phycfgr_lnk(ndev) > 0;
+
+	return 1;
+}
+
 static u32 w5100_get_msglevel(struct net_device *ndev)
 {
 	struct w5100_priv *priv = netdev_priv(ndev);
@@ -659,6 +711,15 @@ static int w5100_open(struct net_device *ndev)
 	w5100_hw_start(priv);
 	napi_enable(&priv->napi);
 	netif_start_queue(ndev);
+
+	if (priv->link_irq >= 0)
+		enable_irq(priv->link_irq);
+
+	if (w5100_get_link(ndev))
+		netif_carrier_on(ndev);
+	else
+		netif_carrier_off(ndev);
+
 	return 0;
 }
 
@@ -667,6 +728,10 @@ static int w5100_stop(struct net_device *ndev)
 	struct w5100_priv *priv = netdev_priv(ndev);
 
 	netif_info(priv, ifdown, ndev, "shutting down\n");
+
+	if (priv->link_irq >= 0)
+		disable_irq(priv->link_irq);
+
 	w5100_hw_close(priv);
 	netif_carrier_off(ndev);
 	netif_stop_queue(ndev);
@@ -678,6 +743,7 @@ static const struct ethtool_ops w5100_ethtool_ops = {
 	.get_drvinfo		= w5100_get_drvinfo,
 	.get_msglevel		= w5100_get_msglevel,
 	.set_msglevel		= w5100_set_msglevel,
+	.get_link		= w5100_get_link,
 	.get_regs_len		= w5100_get_regs_len,
 	.get_regs		= w5100_get_regs,
 };
@@ -745,13 +811,21 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 		break;
 	default:
 		err = -EINVAL;
-		goto err_register;
+		goto err_wq;
 	}
 
 	priv->ndev = ndev;
 	priv->ops = ops;
 	priv->irq = irq;
 
+	priv->link_irq = ops->chip_id == W5500 ?
+			 fwnode_irq_get(dev_fwnode(dev), 1) : -ENODEV;
+	if (priv->link_irq == -EPROBE_DEFER) {
+		err = dev_err_probe(dev, priv->link_irq,
+				    "failed to get link irq\n");
+		goto err_wq;
+	}
+
 	ndev->netdev_ops = &w5100_netdev_ops;
 	ndev->ethtool_ops = &w5100_ethtool_ops;
 	netif_napi_add_weight(ndev, &priv->napi, w5100_napi_poll, 16);
@@ -761,12 +835,8 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
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
 		goto err_wq;
@@ -795,21 +865,39 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
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
 
+	if (priv->link_irq >= 0) {
+		err = request_threaded_irq(priv->link_irq, NULL,
+					   w5500_detect_link,
+					   IRQF_TRIGGER_RISING |
+					   IRQF_TRIGGER_FALLING |
+					   IRQF_ONESHOT | IRQF_NO_AUTOEN,
+					   "w5100-link", priv->ndev);
+		if (err < 0)
+			goto err_link_irq;
+	}
+
+	err = register_netdev(ndev);
+	if (err < 0)
+		goto err_register;
+
 	return 0;
 
+err_register:
+	if (priv->link_irq >= 0)
+		free_irq(priv->link_irq, ndev);
+err_link_irq:
+	free_irq(priv->irq, ndev);
 err_hw:
 	destroy_workqueue(priv->xfer_wq);
 err_wq:
-	unregister_netdev(ndev);
-err_register:
 	free_netdev(ndev);
 	return err;
 }
@@ -820,6 +908,11 @@ void w5100_remove(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct w5100_priv *priv = netdev_priv(ndev);
 
+	unregister_netdev(ndev);
+
+	if (priv->link_irq >= 0)
+		free_irq(priv->link_irq, ndev);
+
 	w5100_hw_reset(priv);
 	free_irq(priv->irq, ndev);
 
@@ -827,7 +920,6 @@ void w5100_remove(struct device *dev)
 	flush_work(&priv->restart_work);
 	destroy_workqueue(priv->xfer_wq);
 
-	unregister_netdev(ndev);
 	free_netdev(ndev);
 }
 EXPORT_SYMBOL_GPL(w5100_remove);
@@ -839,6 +931,9 @@ static int w5100_suspend(struct device *dev)
 	struct w5100_priv *priv = netdev_priv(ndev);
 
 	if (netif_running(ndev)) {
+		if (priv->link_irq >= 0)
+			disable_irq(priv->link_irq);
+
 		netif_carrier_off(ndev);
 		netif_device_detach(ndev);
 
@@ -857,6 +952,12 @@ static int w5100_resume(struct device *dev)
 		w5100_hw_start(priv);
 
 		netif_device_attach(ndev);
+
+		if (priv->link_irq >= 0)
+			enable_irq(priv->link_irq);
+
+		if (w5100_get_link(ndev))
+			netif_carrier_on(ndev);
 	}
 	return 0;
 }

-- 
2.55.0

