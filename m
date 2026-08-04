Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD66378825;
	Tue,  4 Aug 2026 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854341; cv=none; b=M9hf48gU5P/wT4NG68Htt05SpjMg91M6HGaGOL51q4MfaumRi9y0I/VE4r4MpnvOJvuArj0kE63G7xnDvQ/8qlRna3MP8+1PU1FfEF/YnFq5b9Iu5g6OJRUG5BBDQ42whUJW063yaki4q5IeBav+m+p+IkKwY6ym0ynW/pTlkpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854341; c=relaxed/simple;
	bh=a9EhhRfa1GWmrgvr6o9vR7XXTvQizd+JuQuq1rmRFXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EPlCOCwOGg4P/aSq3hz5mgi9Y3yHfwqbTYjLtj6Hlyk9SbFLwL+PdMJbedUzvP8jmlxMxaPjqkY/Uhhn/XDUb4/YrlFTdbYrSy/KC8zgl2/aV+g2LO3dK9C9gTn+x+xavTz/TloWkDDcv3MZ7MH1e5iLKUCDzjtiEDVEC6So9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=VMdqKkjh; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="VMdqKkjh"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 87B423ECB6;
	Tue,  4 Aug 2026 14:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1785854336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XN5zCAOTaCpGETYPCuHm/vqvIrfyyQ05BbG/d0WpThc=;
	b=VMdqKkjhn9SwD/9beJQYcjmlL7/99aCjuz9V3q/pXNah1jInfzvVAH9dMbGdwh5oe/R9vT
	TDDmoog7X0r6NcCZj+2dcaaA/eIMzQuGU3AXc5i/jTc38EMcS+r/R7DRlMWmXHJaaNr7ew
	iBNPvrsirW/GjEJwm/p4eo7TxNH/d8KUD4byOvNKc2VR9u7IqSA/TqRAqLYkakV5O1XwGK
	M9u/RQSDX2Vhp3gxprAjkwKMlrIpv2szp+KKOxId2UC4KHH5d5Fssc8Rc2zksetVSYlf2k
	fUzAFX+p/D08dAKTlBMB6FpkSmtuAEsaDMK1KSNll6ViPCCSfjCIi0Ei/MjZbA==
From: =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Date: Tue, 04 Aug 2026 16:38:35 +0200
Subject: [PATCH] w5100: restore GPIO-based link detection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net>
X-B4-Tracking: v=1; b=H4sIAGr5cWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwMT3fLMqrzUEt2czLxs3fSCzHxdc0uzNGOz5BRDkzRLJaC2gqLUtMw
 KsJHRsRB+cWlSVmpyCcgcpdpaAAF3+dh0AAAA
X-Change-ID: 20260804-wiznet-link-gpio-796f36cd14f9
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
X-Mailer: b4 0.15.2
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEYIk4PNHVGpW+FXA8nCsfg7M8yHo5S2dUsal/GKpVGBHt2oSRnXkcPzJN7VX+nrZxy6vsW4i024Zzk+KrnzrgyVM/7cNkjhoZ0fiLzNOqJeBaFoNUcVJXTTr4KlB+DIREpEv9hZsVHgAU6mer+yFiQWNFGfzlbaFKczKgTdTg1lSCyHjfN9UtVi1ARUrsz4WgOtRkbskr0Hm5I9BQpo6Ph5hzhA+Yhyrg1F6SNOaM2KGMXzSjz4hClk5Q7Fjdblw+goKlAlICf/FuLgvxdodFdOLyo7RvqtbiPz9EJWoURnz0U5PANXYiObTJ40OlpKMaVKkiO5J6TVaa5oC10MHmCPN3HLNR90i0xTscEJnREVQ+DBrRXdrd697JMGURtvddYwbyMDqPbma7bLe6BDG0e/t176TDZTfLz6hMY7V7CZKZXVxt44m70s/73TTjj6D4YJJxIQXPg9SjzAw1BLWgEuLI4D7j0TOclG45xxmukR7vvzvo+q4lOlGr22ELprcBVkeSKnQWihuuDVDfcVma/68efiEqB9QGAxGRq4sMgi3a6s8dA5/e8huKMpnvOSGRudvOVRmcX6xxaeHLWZAEsL2rd9uxbV85RDyBYoc8jtboIxD5e0y75K8JMFVHTeQOtVCUZAgxxEfhrBn5meD1p2PqKd/nWqL7/DoRDns6ecQ

Commit dacf281771a9 ("w5100: remove unused gpio link detection")
dropped the link_gpio/link_irq handling on the grounds that no
devicetree user passed a "link" GPIO at the time.

Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
---
Hi,

I am using the W5500 on a Raspberry Pi and rely on the link GPIO for
the carrier detection.
If we could bring it back, I would greatly appreciate.

Thank you!

Arthur Crépin Leblond
---
 .../devicetree/bindings/net/wiznet,w5x00.txt       |  8 ++-
 drivers/net/ethernet/wiznet/w5100.c                | 84 ++++++++++++++++++++++
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wiznet,w5x00.txt b/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
index e9665798c4be..e97ce3cb9183 100644
--- a/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
+++ b/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
@@ -25,6 +25,7 @@ Optional properties:
   According to the w5500 datasheet, the chip allows a maximum of 80 MHz, however,
   board designs may need to limit this value.
 - local-mac-address: See ethernet.txt in the same directory.
+- link-gpios: a GPIO line used for the link detection interrupt
 
 
 Example (for Raspberry Pi with pin control stuff for GPIO irq):
@@ -38,13 +39,14 @@ Example (for Raspberry Pi with pin control stuff for GPIO irq):
 		interrupt-parent = <&gpio>;
 		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
 		spi-max-frequency = <30000000>;
+		link-gpios = <&gpio 4 GPIO_ACTIVE_HIGH>;
 	};
 };
 
 &gpio {
 	eth1_pins: eth1_pins {
-		brcm,pins = <25>;
-		brcm,function = <0>; /* in */
-		brcm,pull = <0>; /* none */
+		brcm,pins = <25 4>;
+		brcm,function = <0 0>; /* in */
+		brcm,pull = <0 0>; /* none */
 	};
 };
diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index 53d8dc642fbd..c9d1891f37b9 100644
--- a/drivers/net/ethernet/wiznet/w5100.c
+++ b/drivers/net/ethernet/wiznet/w5100.c
@@ -22,6 +22,7 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/gpio/consumer.h>
 
 #include "w5100.h"
 
@@ -154,6 +155,8 @@ struct w5100_priv {
 	u16 s0_rx_buf_size;
 
 	int irq;
+	int link_irq;
+	struct gpio_desc *link_gpio;
 
 	struct napi_struct napi;
 	struct net_device *ndev;
@@ -414,6 +417,16 @@ static void w5100_get_drvinfo(struct net_device *ndev,
 		sizeof(info->bus_info));
 }
 
+static u32 w5100_get_link(struct net_device *ndev)
+{
+	struct w5100_priv *priv = netdev_priv(ndev);
+
+	if (priv->link_gpio)
+		return !!gpiod_get_value_cansleep(priv->link_gpio);
+
+	return 1;
+}
+
 static u32 w5100_get_msglevel(struct net_device *ndev)
 {
 	struct w5100_priv *priv = netdev_priv(ndev);
@@ -616,6 +629,24 @@ static irqreturn_t w5100_interrupt(int irq, void *ndev_instance)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t w5100_detect_link(int irq, void *ndev_instance)
+{
+	struct net_device *ndev = ndev_instance;
+	struct w5100_priv *priv = netdev_priv(ndev);
+
+	if (netif_running(ndev)) {
+		if (gpiod_get_value(priv->link_gpio) != 0) {
+			netif_info(priv, link, ndev, "link is up\n");
+			netif_carrier_on(ndev);
+		} else {
+			netif_info(priv, link, ndev, "link is down\n");
+			netif_carrier_off(ndev);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
 static void w5100_setrx_work(struct work_struct *work)
 {
 	struct w5100_priv *priv = container_of(work, struct w5100_priv,
@@ -659,6 +690,14 @@ static int w5100_open(struct net_device *ndev)
 	w5100_hw_start(priv);
 	napi_enable(&priv->napi);
 	netif_start_queue(ndev);
+
+	if (priv->link_gpio) {
+		if (gpiod_get_value_cansleep(priv->link_gpio) != 0)
+			netif_carrier_on(ndev);
+		else
+			netif_carrier_off(ndev);
+	}
+
 	return 0;
 }
 
@@ -678,6 +717,7 @@ static const struct ethtool_ops w5100_ethtool_ops = {
 	.get_drvinfo		= w5100_get_drvinfo,
 	.get_msglevel		= w5100_get_msglevel,
 	.set_msglevel		= w5100_set_msglevel,
+	.get_link		= w5100_get_link,
 	.get_regs_len		= w5100_get_regs_len,
 	.get_regs		= w5100_get_regs,
 };
@@ -751,6 +791,13 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 	priv->ndev = ndev;
 	priv->ops = ops;
 	priv->irq = irq;
+	priv->link_gpio = gpiod_get_optional(dev, "link", GPIOD_IN);
+	if (IS_ERR(priv->link_gpio)) {
+		err = dev_err_probe(dev, PTR_ERR(priv->link_gpio),
+				    "failed to get link GPIO\n");
+		priv->link_gpio = NULL;
+		goto err_register;
+	}
 
 	ndev->netdev_ops = &w5100_netdev_ops;
 	ndev->ethtool_ops = &w5100_ethtool_ops;
@@ -803,13 +850,40 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 	if (err)
 		goto err_hw;
 
+	if (priv->link_gpio) {
+		char *link_name = devm_kasprintf(dev, GFP_KERNEL, "%s-link",
+						 dev_name(dev));
+		if (!link_name) {
+			err = -ENOMEM;
+			goto err_gpio;
+		}
+
+		priv->link_irq = gpiod_to_irq(priv->link_gpio);
+		if (priv->link_irq < 0) {
+			err = priv->link_irq;
+			goto err_gpio;
+		}
+
+		err = request_any_context_irq(priv->link_irq, w5100_detect_link,
+					      IRQF_TRIGGER_RISING |
+						      IRQF_TRIGGER_FALLING,
+					      link_name, priv->ndev);
+		if (err < 0)
+			goto err_gpio;
+	}
+
 	return 0;
 
+err_gpio:
+	free_irq(priv->irq, ndev);
 err_hw:
 	destroy_workqueue(priv->xfer_wq);
 err_wq:
 	unregister_netdev(ndev);
 err_register:
+	if (priv->link_gpio)
+		gpiod_put(priv->link_gpio);
+
 	free_netdev(ndev);
 	return err;
 }
@@ -822,6 +896,10 @@ void w5100_remove(struct device *dev)
 
 	w5100_hw_reset(priv);
 	free_irq(priv->irq, ndev);
+	if (priv->link_gpio) {
+		free_irq(priv->link_irq, ndev);
+		gpiod_put(priv->link_gpio);
+	}
 
 	flush_work(&priv->setrx_work);
 	flush_work(&priv->restart_work);
@@ -840,6 +918,7 @@ static int w5100_suspend(struct device *dev)
 
 	if (netif_running(ndev)) {
 		netif_carrier_off(ndev);
+
 		netif_device_detach(ndev);
 
 		w5100_hw_close(priv);
@@ -857,7 +936,12 @@ static int w5100_resume(struct device *dev)
 		w5100_hw_start(priv);
 
 		netif_device_attach(ndev);
+
+		if (!priv->link_gpio ||
+		    gpiod_get_value_cansleep(priv->link_gpio) != 0)
+			netif_carrier_on(ndev);
 	}
+
 	return 0;
 }
 #endif /* CONFIG_PM_SLEEP */



