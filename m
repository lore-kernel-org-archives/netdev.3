Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05843F8AC;
	Thu, 13 Aug 2026 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611515; cv=none; b=IBgwdaXsQ2S8ErqzQbb2WLTXpVuduIjQEINVsFLE54xLZFjmXjPEUw29+Az7G5+dChRsTOT8+/0zoX4fZ15d5WujVyf4ROPM1qraym34dUGQEBHS7PVkdLgW9vO7SURrdG5y83i3pCGaRCceO0U1FHwtHYIf5JOrZHuMJqSC+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611515; c=relaxed/simple;
	bh=eMGzuFewfGtIYN0C0eJpqu97B6dAblhN1cMCUugLcKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7Cmg4akNnOtM9g6fFW6M2iDOLSzH/1LerNEN4JdR+oOiqSiUP9jFNpelw+hf7WlraV6MKvOWcs2PDQisMQSDJZl+VgrCtCDwWXLwCLOfIAbiF/aq6Ulrle019Y435q3Tn0SGPrrl7oS6wmTD3AmrB+SU3J2e1xyXynIrVA4ouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=OPk0TrTV; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="OPk0TrTV"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2356D1F6A9;
	Thu, 13 Aug 2026 08:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786611510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOPI8QRTJRKE7q8uv8QbuoU2yJuWRYbi5nzp3r7Xbf0=;
	b=OPk0TrTV0J5MWtCFld4ATX8O/6Ok4ciCHZ9ogoVIqaxCTC0i9Dek9qWJTqnpjKfOmOowvy
	Xbq+Zdfmg5rdwyfQpFqsZ3GVJYnxy7U7ua+Qc9yAve0QmhLQftScffZjuzBuvf2/TrcIut
	coU1d1c5e8zeMmYdlQ/gVLgQE6jmpgrdKMpP9G55FrnUIg7NIPTMfFnBH7nGMS3R5z2Gpe
	FlKNZzvDq/ZvSFn8BLTpp31LVzI7KDrBT9+iWn1xIemaIQND1jxylMWewwGd+xlfNiO1Yc
	EBQ9VmAAsk1fqWKdFP4EympRARRDqzDx/kvuU6vCRIKeYSUCe12TYF3PHAy4mw==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Thu, 13 Aug 2026 10:58:16 +0200
Subject: [PATCH net-next v5 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-wiznet-link-gpio-v5-3-ac8046f24413@marmottus.net>
References: <20260813-wiznet-link-gpio-v5-0-ac8046f24413@marmottus.net>
In-Reply-To: <20260813-wiznet-link-gpio-v5-0-ac8046f24413@marmottus.net>
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
X-GND-Cause: dmFkZTFlHy9UV5KrcAc65cAqSIoL1v8G+Pp1OCsnNJtOtAHdcMzzR7eNxtFYxzCTgczprVKvWZcsfmFtYApGFrC7wMNZV0nbm+v/IXyxRNx39HGsW0l37FM8MVgcZ+v8fiEJy4Nb8hSr44Vet+Wb0ajorM36iW5plKoRZUQy7UTfDzIHeUjtmK3krVOg1kTHGAhIsKKsEH6oynLL/lj5iatNmm5CzeJLAr0rn2+VWg91cEL3qtI0vxVSvZjXvl6AE/4pOHDvoElCyg7FwhEg6RUWwZ7FlVx2Ijm5zDKevXgnPLvZggswCMez381ko/6lwMLAvynCJFA/mDREZ2egYgpoQKjGO21K047Xx6/u4kYBdm/+wrssRj0iiF3pIbH7hHrofYLU9PCLfa2pbdRUM0CiRKOb+MQQd/VIydVydg3GeLpjvhTxohf1b1K2G/kqSXJThxDpAVbwwkdKKlP4AsBrigHruQCKlhRat6NbKkBJH97oWmVWl/KtnCGSFW8/L76qRdgWCR4mrJoKRYUCHL/rMnh/CxLm0zTIgA3GkVPwbtSPHyU5nUetL8jNf/hDTEu3I6oPlaGukUwSrLkQQeA4ymz2mlHlRt95r70KjzoLqK32t/7k6AqsqL9GvMFVwHyYqJAjgRedgBWZY2/5iOw1b4JXfQ9aJv6VvqLeqDb2MChTcw
X-GND-State: clean

Detect the link status on the w5500 using the Link Status bit from the
PHY Configuration register (PHYCFGR).

On w5100/w5200, which lack this register, the link is always reported
as up.

Also add an optional interrupt, wired to the LINKLED pin of
the w5500, to detect link status changes and read the PHYCFGR register.

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
 drivers/net/ethernet/wiznet/w5100.c | 119 ++++++++++++++++++++++++++++++++----
 1 file changed, 108 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index 53d8dc642fbd..b5976d5e6c60 100644
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
@@ -345,6 +349,20 @@ static void w5500_memory_configure(struct w5100_priv *priv)
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
+		return 0;
+	}
+
+	return ret & PHYCFGR_LNK;
+}
+
 static int w5100_hw_reset(struct w5100_priv *priv)
 {
 	u32 rtr;
@@ -414,6 +432,16 @@ static void w5100_get_drvinfo(struct net_device *ndev,
 		sizeof(info->bus_info));
 }
 
+static u32 w5100_get_link(struct net_device *ndev)
+{
+	struct w5100_priv *priv = netdev_priv(ndev);
+
+	if (priv->ops->chip_id == W5500)
+		return w5500_get_phycfgr_lnk(ndev);
+
+	return 1;
+}
+
 static u32 w5100_get_msglevel(struct net_device *ndev)
 {
 	struct w5100_priv *priv = netdev_priv(ndev);
@@ -616,6 +644,24 @@ static irqreturn_t w5100_interrupt(int irq, void *ndev_instance)
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
@@ -659,6 +705,15 @@ static int w5100_open(struct net_device *ndev)
 	w5100_hw_start(priv);
 	napi_enable(&priv->napi);
 	netif_start_queue(ndev);
+
+	if (priv->link_irq >= 0)
+		enable_irq(priv->link_irq);
+
+	if (priv->ops->chip_id != W5500 || w5500_get_phycfgr_lnk(ndev))
+		netif_carrier_on(ndev);
+	else
+		netif_carrier_off(ndev);
+
 	return 0;
 }
 
@@ -667,6 +722,10 @@ static int w5100_stop(struct net_device *ndev)
 	struct w5100_priv *priv = netdev_priv(ndev);
 
 	netif_info(priv, ifdown, ndev, "shutting down\n");
+
+	if (priv->link_irq >= 0)
+		disable_irq(priv->link_irq);
+
 	w5100_hw_close(priv);
 	netif_carrier_off(ndev);
 	netif_stop_queue(ndev);
@@ -678,6 +737,7 @@ static const struct ethtool_ops w5100_ethtool_ops = {
 	.get_drvinfo		= w5100_get_drvinfo,
 	.get_msglevel		= w5100_get_msglevel,
 	.set_msglevel		= w5100_set_msglevel,
+	.get_link		= w5100_get_link,
 	.get_regs_len		= w5100_get_regs_len,
 	.get_regs		= w5100_get_regs,
 };
@@ -745,13 +805,21 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
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
@@ -761,12 +829,8 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
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
@@ -795,21 +859,39 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
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
+					   w5100_detect_link,
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
@@ -820,6 +902,13 @@ void w5100_remove(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct w5100_priv *priv = netdev_priv(ndev);
 
+	unregister_netdev(ndev);
+
+	if (priv->link_irq >= 0) {
+		free_irq(priv->link_irq, ndev);
+		priv->link_irq = -ENODEV;
+	}
+
 	w5100_hw_reset(priv);
 	free_irq(priv->irq, ndev);
 
@@ -827,7 +916,6 @@ void w5100_remove(struct device *dev)
 	flush_work(&priv->restart_work);
 	destroy_workqueue(priv->xfer_wq);
 
-	unregister_netdev(ndev);
 	free_netdev(ndev);
 }
 EXPORT_SYMBOL_GPL(w5100_remove);
@@ -839,6 +927,9 @@ static int w5100_suspend(struct device *dev)
 	struct w5100_priv *priv = netdev_priv(ndev);
 
 	if (netif_running(ndev)) {
+		if (priv->link_irq >= 0)
+			disable_irq(priv->link_irq);
+
 		netif_carrier_off(ndev);
 		netif_device_detach(ndev);
 
@@ -857,6 +948,12 @@ static int w5100_resume(struct device *dev)
 		w5100_hw_start(priv);
 
 		netif_device_attach(ndev);
+
+		if (priv->link_irq >= 0)
+			enable_irq(priv->link_irq);
+
+		if (priv->ops->chip_id != W5500 || w5500_get_phycfgr_lnk(ndev))
+			netif_carrier_on(ndev);
 	}
 	return 0;
 }

-- 
2.55.0

