Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2EB435A87;
	Tue, 11 Aug 2026 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453006; cv=none; b=m4lhBUv7nJ0qaM8mtf9CxxUMrfahjHsr32VdiXXkUjlvxnTlHNwFcw4Y34mFh1/38sT/p+6lY2fGm5Nj5aixCccMDZXuTyUafSmiiAF4KS6Q9Xiu7glc1LpZ0A/jnKUAeJUUCvVZxjJFLc192hVhEYei0r5xRElTkS2EKKepFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453006; c=relaxed/simple;
	bh=fJ56bbwwe3vVMnpTdoyYC18bSgyXz3u7+wNH2PeNI8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=da2iA/hyQsk+qaCFMVcQefO0IybiMKHq7EqdRRpMMZpfKbYQnKc4jQIm/aENn1GS72aWycOwrDO4f/QiuXwlaHijdpKrALFQW35LwQ7qbswqP18M1Js43zZgOI/X9Gl9UJ2fx36xOiKmQmNDh6xqFdHU7jDf7wVsjod0KZKFpF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=KgWr3Ci8; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="KgWr3Ci8"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id B51C45822F0;
	Tue, 11 Aug 2026 12:34:56 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D4153ECDD;
	Tue, 11 Aug 2026 12:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786451688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EFPULwsCEQh8jxrDTdq68dQ4k9ee+NFqozFqmEB9s7g=;
	b=KgWr3Ci8SbC3otOEJercI3u4wxKY6jX5mdTLNc4w/SarZmsiT8fKFNCTPYZePommitvmWk
	jTwnI+1KhvYbuIIrZ/WHFkpDrxDSAO3Bn7epDxCr6Bol/OpSWugOFuCe0SwXtV2ErhVUYO
	G3Oc6EAXzv1vkMTHMlw5eT3SuWxAgOisG7aHRTuvM0xK+QAgJI/P8wiPzCzpv5k5f4agp+
	T2nOQkBA9mWADBdwEhBN8hia0t5Yb8d5lcPdgsWlUFniMWp5rFzLyiflBGnZZxIzx5X2Qz
	qvWCmWqjEDhOo/amRzz++IeL53bOiA7JE8dmsAAlPMo7/12rrHkE5qlZ2NBzpw==
From: =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Date: Tue, 11 Aug 2026 14:34:35 +0200
Subject: [PATCH net-next v4 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-wiznet-link-gpio-v4-3-4d5f7da885a8@marmottus.net>
References: <20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net>
In-Reply-To: <20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net>
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
X-GND-Cause: dmFkZTED/3HJKTgwxBO9D7jQ7O9WW6mZqKFTS5z9+t/FK1af0VH31e8paPNStgsQpQIYlcYucwL4cCmdHRXR1YYxqw1T8z7REX/fEaawr/SFTAReVmgPSkMSXhelgxXwGWSawVSbcpIQz1ApGSMt7N/EmbPGNzbGZYTYvDxpMYQGP1JlU5jgLN/HEWfQYe9TkhK3By7wmxsf+0M+P/IMA7PoVnge/FKBaYY9CaxM9zl0WOY5mQGtYkeKnvmiXrurdSxxCfaFLe1gD6LLRDm8B+uNjWpnFlfgPuimqtreC5Kqai1m6/hFQg5QKCoi3xpXvCY9c8GMn3Fz6R/dnpQZY+phR/sNQY9r6x+k9x1zRTatfSl2TcVGaH3AMwywSYmX+TSeRecaZq4abXGY0Yp0jO+0JP21trGrRDK197YNrLd/wiWJty2XS9YA+W94Ma0sgCxNDVkXRSjzH4e3IKYVXIy8PHXySTL1Qye/0nz9CGv/Y0ts9iFpAnoHSWMEL/R7/EWghAQwWi9h5AjvwPO1S9VYt9qLPTWD8GTCtgP3WkZAkbKaaJDC6sYIZZe/8jgo8+eX5t+5gcJpaX51ytLbna/ZRi0CNoMX4E3Y+/RcF3CpsOlcIXg4QxKYn3XKgZvqh8FcvLOCV8Wduebe13Z/qy6sgTJnzsExBOKFQ86T9tr2mINgpw
X-GND-State: clean
X-GND-Score: -100

Detect the link status on the w5500 using the Link Status bit from the
PHY Configuration register (PHYCFGR).

On w5100/w5200, which lack this register, the link is always reported
as up.

Also add an optional interrupt, wired to the LINKLED pin of
the w5500, to detect link status changes and read the PHYCFGR register.

Commit dacf281771a9 ("w5100: remove unused gpio link detection")
dropped the link_gpio/link_irq handling on the grounds that no
devicetree user passed a "link" gpio at the time and that it used the
old gpio interface.
This isn't a plain revert of that removal: link detection is now done
using a second interrupt rather than a gpio with a documented DT binding.

Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
---
 drivers/net/ethernet/wiznet/w5100.c | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index 53d8dc642fbd..ca5054c20993 100644
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
+#define W5500_PHYCFGR		0x002e /*  PHY Configuration Register */
+#define   PHYCFGR_LNK		  0x01 /* link status */
 
 #define W5500_S0_REGS		0x10000
 
@@ -154,6 +157,7 @@ struct w5100_priv {
 	u16 s0_rx_buf_size;
 
 	int irq;
+	int link_irq;
 
 	struct napi_struct napi;
 	struct net_device *ndev;
@@ -414,6 +418,20 @@ static void w5100_get_drvinfo(struct net_device *ndev,
 		sizeof(info->bus_info));
 }
 
+static u32 w5100_get_link(struct net_device *ndev)
+{
+	struct w5100_priv *priv = netdev_priv(ndev);
+
+	if (priv->ops->chip_id == W5500) {
+		int ret = w5100_read(priv, W5500_PHYCFGR);
+
+		if (ret >= 0)
+			return ret & PHYCFGR_LNK;
+	}
+
+	return 1;
+}
+
 static u32 w5100_get_msglevel(struct net_device *ndev)
 {
 	struct w5100_priv *priv = netdev_priv(ndev);
@@ -616,6 +634,24 @@ static irqreturn_t w5100_interrupt(int irq, void *ndev_instance)
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
@@ -659,6 +695,10 @@ static int w5100_open(struct net_device *ndev)
 	w5100_hw_start(priv);
 	napi_enable(&priv->napi);
 	netif_start_queue(ndev);
+
+	if (priv->link_irq < 0 || w5100_get_link(ndev))
+		netif_carrier_on(ndev);
+
 	return 0;
 }
 
@@ -678,6 +718,7 @@ static const struct ethtool_ops w5100_ethtool_ops = {
 	.get_drvinfo		= w5100_get_drvinfo,
 	.get_msglevel		= w5100_get_msglevel,
 	.set_msglevel		= w5100_set_msglevel,
+	.get_link		= w5100_get_link,
 	.get_regs_len		= w5100_get_regs_len,
 	.get_regs		= w5100_get_regs,
 };
@@ -751,6 +792,8 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 	priv->ndev = ndev;
 	priv->ops = ops;
 	priv->irq = irq;
+	priv->link_irq = ops->chip_id == W5500 ?
+			 fwnode_irq_get(dev_fwnode(dev), 1) : -ENODEV;
 
 	ndev->netdev_ops = &w5100_netdev_ops;
 	ndev->ethtool_ops = &w5100_ethtool_ops;
@@ -803,8 +846,21 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 	if (err)
 		goto err_hw;
 
+	if (priv->link_irq >= 0) {
+		err = request_threaded_irq(priv->link_irq, NULL,
+					   w5100_detect_link,
+					   IRQF_TRIGGER_RISING |
+					   IRQF_TRIGGER_FALLING |
+					   IRQF_ONESHOT,
+					   "w5100-link", priv->ndev);
+		if (err < 0)
+			goto err_link_irq;
+	}
+
 	return 0;
 
+err_link_irq:
+	free_irq(priv->irq, ndev);
 err_hw:
 	destroy_workqueue(priv->xfer_wq);
 err_wq:
@@ -820,6 +876,9 @@ void w5100_remove(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct w5100_priv *priv = netdev_priv(ndev);
 
+	if (priv->link_irq >= 0)
+		free_irq(priv->link_irq, ndev);
+
 	w5100_hw_reset(priv);
 	free_irq(priv->irq, ndev);
 
@@ -842,6 +901,9 @@ static int w5100_suspend(struct device *dev)
 		netif_carrier_off(ndev);
 		netif_device_detach(ndev);
 
+		if (priv->link_irq >= 0)
+			disable_irq(priv->link_irq);
+
 		w5100_hw_close(priv);
 	}
 	return 0;
@@ -856,7 +918,13 @@ static int w5100_resume(struct device *dev)
 		w5100_hw_reset(priv);
 		w5100_hw_start(priv);
 
+		if (priv->link_irq >= 0)
+			enable_irq(priv->link_irq);
+
 		netif_device_attach(ndev);
+
+		if (priv->link_irq < 0 || w5100_get_link(ndev))
+			netif_carrier_on(ndev);
 	}
 	return 0;
 }

-- 
2.55.0

