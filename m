Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEAC43A81B;
	Tue,  4 Aug 2026 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866311; cv=none; b=RycwPHg0N4EglQ+7HTtLHAHxarr6B5brVJCKmVZ5KoT3iRK8C8XS+E0JpNDE52xYZWluG/zBW89GeTlmpsXeZYhpM+TZaGUKB3m14l1HUnCzADtLSerAU39P/imy/2zpZ8MpHal5zORmBhbmuBhC82R9EnV/j/xGannLGo5o2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866311; c=relaxed/simple;
	bh=atydJnJbMmN1IHB6MAx18xPFmlJri2Tq4cII64DUqTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A5UY4Y5b7cLKc5oczUzjyzA6b8VSAENHRtq6T9zKatRJDd/b7f0+MTTAu5akrFjOku3qvudd2PwNQzSQhqOOAGjo06xE0VBmnDESPzjUcFxQ6cogLc2JK3r2KarqV7FZJgffvY0c3bRfS+VUcFIbe8cQUiYrvh9FfFKR+SOc+4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=FJ2z7ucw; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="FJ2z7ucw"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 9CF0558172C;
	Tue,  4 Aug 2026 17:41:06 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A8833F567;
	Tue,  4 Aug 2026 17:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1785865264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zA1ZTubBuh3m9i5h+yCivy1ldfhgN3dZbD7sp/exs4M=;
	b=FJ2z7ucwdZONwe4K3xXitH+LWNkTlLuEKWcNA/mVKyoevf/qfb1hSM3788i+48I7H7XUbc
	G5td33ThE+tATPqV5RNgAsI4bbNS9RKoqLhNaQlfOlmeuZkFSqJBByhkY6iUJ2bUyCFIRI
	0eeHhFyCJNl9sRRxsxBWTlb/cZmrx+nHqblkJ/lno+HbNzeq3ZAtW6zzae1/zaFs0B9x/A
	xw2SsWxikQ24r/RULNOGMPjzI+1HwFaY0Qo8HeAacr4+nwrrj98JxyAJhWm7z4PrIUMFu3
	qRw8FLFDIoJXeEWaWTRd7738tnDUSkUJ4PhJ9/pD7u1MmdaBOEURIDSwkAKF/Q==
From: =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Date: Tue, 04 Aug 2026 19:40:56 +0200
Subject: [PATCH v2 1/2] w5100: restore GPIO-based link detection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-wiznet-link-gpio-v2-1-3b1d0c870f35@marmottus.net>
References: <20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net>
In-Reply-To: <20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net>
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
X-GND-Cause: dmFkZTGnkLjOAcGhfyOqhLqfnii3rksT32ERFyu9TJrUkdKkXDMFxOf48vSprhQntGYF+VdlnwFWTG7ytlX2ArxPg1VBCUk9wDy7FA+tSGphGNppn0oIm7aJJNOXHMqscWorsGsuHIlED57VnnX+GfaeTzwOi7Sz294CaJgoVFpa/0wXx35mggn9EWya2ADE04T3a8Ir9Y/RwIRSxNvzzs5pfM6+O8o4hLlRuJX+eSkBKEt/GwiysKrjLQpbqx2lePe0VOJL6DZOaSqdtz2C7hao+vdoK7d64i1enIzFKQbYNsFt83IDxoychvuVfkPIPxZwdHxF3ChHlbqUkK5AYn3RlhQelUsiMRu7k4da333V0kjTtXMuy9qVZvDtWPz3OsjQEkbJezQ6gAmAA6z2mk7QIkQ/aaKzlPumriqSELu+/1MwMilzPoZ2kU7m+IujtIhMECU9C32lMcioJ6677B8YIou5FMwnIwR/03AE5vHo2XYJlOWhMsPzGMa9ow7+stGvoAfE4+AyAXBBbSBEuZ0yewAWPf+SNxeWU9NZBVnQ5g6VURjSL83IUmtw0+Sj7boXPOTOOBI5sGpcPix4NHDNRKaq1YqSCfvfKb2yhZngW0ujBPZo6hd2lWrsFQGIm5/iYgXqMQDhJxArIuTmmaatfQib+iYy7xWyOKGXA6xHhZGOGA
X-GND-State: clean
X-GND-Score: -100

Commit dacf281771a9 ("w5100: remove unused gpio link detection")
dropped the link_gpio/link_irq handling on the grounds that no
devicetree user passed a "link" GPIO at the time.

This isn't a plain revert of that removal. The link GPIO is now
bound from the device tree link-gpios property using the resource
managed GPIO descriptors.

The link IRQ is also requested with devm_request_threaded_irq()
instead of request_any_context_irq(), so it is released automatically
on driver removal or probe failure.

Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
---
 drivers/net/ethernet/wiznet/w5100.c | 71 +++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index 53d8dc642fbd..1410a9fcfa92 100644
--- a/drivers/net/ethernet/wiznet/w5100.c
+++ b/drivers/net/ethernet/wiznet/w5100.c
@@ -22,6 +22,7 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/gpio/consumer.h>
 
 #include "w5100.h"
 
@@ -154,6 +155,7 @@ struct w5100_priv {
 	u16 s0_rx_buf_size;
 
 	int irq;
+	struct gpio_desc *link_gpio;
 
 	struct napi_struct napi;
 	struct net_device *ndev;
@@ -414,6 +416,16 @@ static void w5100_get_drvinfo(struct net_device *ndev,
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
@@ -616,6 +628,24 @@ static irqreturn_t w5100_interrupt(int irq, void *ndev_instance)
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
@@ -659,6 +689,14 @@ static int w5100_open(struct net_device *ndev)
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
 
@@ -678,6 +716,7 @@ static const struct ethtool_ops w5100_ethtool_ops = {
 	.get_drvinfo		= w5100_get_drvinfo,
 	.get_msglevel		= w5100_get_msglevel,
 	.set_msglevel		= w5100_set_msglevel,
+	.get_link		= w5100_get_link,
 	.get_regs_len		= w5100_get_regs_len,
 	.get_regs		= w5100_get_regs,
 };
@@ -751,6 +790,13 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 	priv->ndev = ndev;
 	priv->ops = ops;
 	priv->irq = irq;
+	priv->link_gpio = devm_gpiod_get_optional(dev, "link", GPIOD_IN);
+	if (IS_ERR(priv->link_gpio)) {
+		err = dev_err_probe(dev, PTR_ERR(priv->link_gpio),
+				    "failed to get link GPIO\n");
+		priv->link_gpio = NULL;
+		goto err_register;
+	}
 
 	ndev->netdev_ops = &w5100_netdev_ops;
 	ndev->ethtool_ops = &w5100_ethtool_ops;
@@ -803,8 +849,29 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 	if (err)
 		goto err_hw;
 
+	if (priv->link_gpio) {
+		int link_irq = gpiod_to_irq(priv->link_gpio);
+
+		if (link_irq < 0) {
+			err = dev_err_probe(dev, link_irq,
+					    "No corresponding irq for link gpio\n");
+			goto err_gpio;
+		}
+
+		err = devm_request_threaded_irq(dev, link_irq, NULL,
+						w5100_detect_link,
+						IRQF_TRIGGER_RISING |
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						"w5100-link", priv->ndev);
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
@@ -857,6 +924,10 @@ static int w5100_resume(struct device *dev)
 		w5100_hw_start(priv);
 
 		netif_device_attach(ndev);
+
+		if (!priv->link_gpio ||
+		    gpiod_get_value_cansleep(priv->link_gpio) != 0)
+			netif_carrier_on(ndev);
 	}
 	return 0;
 }

-- 
2.55.0

