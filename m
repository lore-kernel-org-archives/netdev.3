Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC233AEB5F;
	Thu,  6 Aug 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028427; cv=none; b=WUpCm8tPFr1dK5GuQn+8iefkHrM+0H7Jx9GH3H61DW+oEJTUqkQiy/xzVMljWwVqjUmpBTWkfx5d0TkRnYAYNa9yDy6IIVRtj/cHELcwUzKtEPjSPEFF3GyA8i+QG4Ytmsn4manN6ePBfS65xHlKm0TByhaG5OcQ0ynbfyMD7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028427; c=relaxed/simple;
	bh=lp8eITXUCfgHmVikAplRm1gVPpLc2Ql2JMBCRKbqS7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p+C2k4pWrVhQ+bVpXUZJsvGg2LARiFkBKJMp/k8tWk+mr1O0/VtkoOfj8PYJjsb6FkHTVunFB36CwzfBeHGK0cWa18b/SK66CZUtne5lBaZNwXQTpv5zk1Lqt5VH0kjcxFc/OsW6AtTbcBig/rzyM92BQaRZ6s/Fqo628IqrrgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=amn9WweM; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="amn9WweM"
Received: by mail.gandi.net (Postfix) with ESMTPSA id F39E73ECEA;
	Thu,  6 Aug 2026 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786028423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHZA1FNeXrM1A3izwrYic9PHMjd1HkNfriy7KZM7waY=;
	b=amn9WweMSeGH3qH7vBjnBb6IbW1lqfjStoC2+I9PIVdkGWMSd67h5DC9lPRnFSBNKka6/c
	Hxw9yMOgFtxXcBIXLWIS7XfT/Brzds2pcoCHe5bmvTdlHqN6s/THOgIRlD3evlERe7xgkU
	0EVq2RpJKCL/3nhIjEVygajbong8Zpp14i3FR+m9e9S95OX1rGqUNunGddLAT4aCiLozSk
	eQVSD4COJ/D5d73k8Ixd5j1PEu3xBRpO9xpzk1L8gHu3RQaDj4xjh9aFBenP/zVHrcs8bn
	oCamU5iA6UEmKCgS5D+MQAuy+X/eS8g9ErdwSTYcZ/OfGAcVjI6xkB5ZknSybg==
From: =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Date: Thu, 06 Aug 2026 17:00:02 +0200
Subject: [PATCH net-next v3 3/3] w5100: detect carrier state using link
 status bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260806-wiznet-link-gpio-v3-3-532d4a143805@marmottus.net>
References: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
In-Reply-To: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
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
X-GND-Score: -100
X-GND-Cause: dmFkZTE+WcSggV5zCp8g8eT5E/JolsF24Rl9OX9pXx8yvsvxSceOKMXWcUHCvd4FGfevv8symVzCRbUUPKuWQJrU0JMpZ4BXbtbyj1f/j+clyQ1HGu2c46H5js9LJVJE8KA3BBxdUe9a053FvnuCrnM8aIzoCoaPGF6fkS7JkXplNhcPhSwG3KxHsexsKkHwH9U2A2bYSfs14ahqkakWTVvmMuOCCFFLlhTynsi9SmUPAc4HsxDK8ORsAeHen5Pzi8iDuFMwsE40c16a2c+1FGEvCTezP8A4oNhT1kFysW4RXvpJKfxZdizPrIkk3wC80Bsw8Yr7m4qqwKsIByUhvFuQ1N9PnjHMD/Jj/1h+SNNzwidmUtJLgUfOEcevqw1wVBIOoIVLzofQjejtXyeCRtyxk263AvczqRCqUJMy99Y+g/+5+nt8850KrZ2vwsFk9J/r+gIgyH+xMlDJw1HFZ3dXIzqlqw58TVqd8m8vDjzWvQnpDE6Usv0OkoBADQ3J41NL4Y/0BWPo1WahBkNE0udwb/ybNRGLMdvn3rM5SdCQf/AmtH3SxJDn3wqaS0CGXkVXQ8FD3kKs3XpEqAAWwyXUurhviyBn5aoNgG98iL+I39wfSrdPgwmjkcPf3+MWFSOxU6UalmJSTh5jcgxtjUhQHZfMUFH/dWLZzu2Mdb0gVlxDUQ
X-GND-State: clean

Detect the link status on the w5500 using the Link Status bit from the
PHY Configuration register.

Also add an optional GPIO line that can be wired to the LINKLED pin of
the w5500 as an interrupt to detect link status changes and read the
register.

On chip variants other than the w5500, which lack this register, the
link is always reported as up.

Commit dacf281771a9 ("w5100: remove unused gpio link detection")
dropped the link_gpio/link_irq handling on the grounds that no
devicetree user passed a "link" GPIO at the time and that it used the
old gpio interface.

This isn't a plain revert of that removal. It uses the new managed GPIO
descriptors so that the resources are released automatically on driver
removal or probe failure.

Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
---
 drivers/net/ethernet/wiznet/w5100.c | 70 +++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index 53d8dc642fbd..6707a6f27395 100644
--- a/drivers/net/ethernet/wiznet/w5100.c
+++ b/drivers/net/ethernet/wiznet/w5100.c
@@ -22,6 +22,7 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/gpio/consumer.h>
 
 #include "w5100.h"
 
@@ -124,6 +125,8 @@ MODULE_LICENSE("GPL");
  */
 #define W5500_SIMR		0x0018 /* Socket Interrupt Mask Register */
 #define W5500_RTR		0x0019 /* Retry Time-value Register */
+#define W5500_PHYCFGR		0x002e /*  PHY Configuration Register */
+#define   PHYCFGR_LNK		  0x01 /* link status */
 
 #define W5500_S0_REGS		0x10000
 
@@ -154,6 +157,7 @@ struct w5100_priv {
 	u16 s0_rx_buf_size;
 
 	int irq;
+	struct gpio_desc *link_gpio;
 
 	struct napi_struct napi;
 	struct net_device *ndev;
@@ -414,6 +418,16 @@ static void w5100_get_drvinfo(struct net_device *ndev,
 		sizeof(info->bus_info));
 }
 
+static u32 w5100_get_link(struct net_device *ndev)
+{
+	struct w5100_priv *priv = netdev_priv(ndev);
+
+	if (priv->ops->chip_id == W5500)
+		return w5100_read(priv, W5500_PHYCFGR) & PHYCFGR_LNK;
+
+	return 1;
+}
+
 static u32 w5100_get_msglevel(struct net_device *ndev)
 {
 	struct w5100_priv *priv = netdev_priv(ndev);
@@ -616,6 +630,24 @@ static irqreturn_t w5100_interrupt(int irq, void *ndev_instance)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t w5100_detect_link(int irq, void *ndev_instance)
+{
+	struct net_device *ndev = ndev_instance;
+	struct w5100_priv *priv = netdev_priv(ndev);
+
+	if (netif_running(ndev)) {
+		if (w5100_get_link(ndev)) {
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
@@ -659,6 +691,12 @@ static int w5100_open(struct net_device *ndev)
 	w5100_hw_start(priv);
 	napi_enable(&priv->napi);
 	netif_start_queue(ndev);
+
+	if (w5100_get_link(ndev))
+		netif_carrier_on(ndev);
+	else
+		netif_carrier_off(ndev);
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
@@ -857,6 +924,9 @@ static int w5100_resume(struct device *dev)
 		w5100_hw_start(priv);
 
 		netif_device_attach(ndev);
+
+		if (w5100_get_link(ndev))
+			netif_carrier_on(ndev);
 	}
 	return 0;
 }

-- 
2.55.0

