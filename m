Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3B44C641;
	Fri, 31 Jul 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514774; cv=none; b=QmWrst6X8fOiIC3zmjoAmQd16eBfEPriijmRK9YhWS+U7g8axACqygEeFocwR/lmF6cr3knP6GBzkJmTeAn/NPN8Sglqm7LEWyfjzI2ZdC2TVp1XQY1O4szai1jVqTOyY100YkAY3c3EkIlSh7BTOmxmQqI9vBPFByuRCxXeXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514774; c=relaxed/simple;
	bh=HrxnLDJZFjfABGfUjcXRAesl9teyYG70WB8kbj23bcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pszBCb9ZNHvlIEPEpgSRmst0XUzHpUAr2ucmS2Prvm9GtZH27YmPaNi592u8nEi/yOMcAGkR4lk1TJlN8dNwoAPKq2VX/n25JBffReWWLSL+FSkwe+d1zLkUGWH+Hp1BYfEPbg72jCFnsYKsoGSjbHkq56q2M7T5XksJyCsH0mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=esigsp40; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=XluZoC+u; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="esigsp40";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="XluZoC+u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514756;
	bh=HrxnLDJZFjfABGfUjcXRAesl9teyYG70WB8kbj23bcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=esigsp40xI6yPyTmPBmZt08RQ1AbLZEcT8m7zicITBgDTjdzNiU5T7d8Axl2M+Ur2
	 ncUxFMsVvVvC9xJ3jf88Q8+vO+HsUbykdIDUVscKy7BQ/CoQYZ9delwQmGdJfIxj+J
	 Vr78DpTjGwliKFlUZ2kpQxUGBPd3Wzwk6HXl45cIc3Cjf5qxk2gzwmuDtr9vfq1i4S
	 ZytL42EPu2vQE57mFDLyj3zqFAYrvyoj9bQTT6QVMlrtpKUc91Kt691Y6JG6NMA0o9
	 4vd8fUjZSYwliSE8K9lT7qz983rjVHJkky+77ir74k6v53HciCVGlK8dnKtMqw832H
	 4xZcWvyaZ7bRA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id C4A4649500; Fri, 31 Jul 2026 16:19:16 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514745;
	bh=HrxnLDJZFjfABGfUjcXRAesl9teyYG70WB8kbj23bcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XluZoC+uR+P3pPfA7eZWdtmR2HAeFCEwqVsln6ND7F4czg9+hH0jbDiMkWvARWxjL
	 YIV2JnVPWC+Qj1pSV6DOsZ5ORZDDjpaHCiGbf2R6vd3ERnBEuI8vw7j6/N1lhpM5Sj
	 bSdEFo6+W/hnZQRMV0SIIWhVNtP1M3LAUUxQCmFpfu5yUeZfV5Q4jTaGkSUmtG1bGH
	 mW8U/P7PuI/uEw5pvkpBrFamWzgIII4wqXxizijr3gK6QDr55feHPxVaUYoCkn6+Gi
	 tHUmc9LJVQop/QQIBS4EUTLtjHqr03M2p8YJc0UAp0TMZIaLhloisQ20eriTnyT3cx
	 zc+B6yuc6aBgA==
Received: from ThinkPadAMD.lan (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 637FE494F4;
	Fri, 31 Jul 2026 16:19:05 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 31 Jul 2026 18:19:08 +0200
Subject: [PATCH net-next v4 08/12] ax88179_178a: Add Suspend/resume support
 for AX88179A/772D/279
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ax88179a-v4-8-2cf1f71b1dd2@birger-koblitz.de>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
In-Reply-To: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

The suspend and resume functions are called via the usb_driver structure,
for which the driver has only a single instance. Add wrapper functions
for the different implementations for the AX88179 and AX179A architecutres
in ax88179_lib which calls the 2 implementations in ax88179_178a and
ax88179a_devices, respectively.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c     |  9 ++--
 drivers/net/usb/ax88179_lib.c      | 19 ++++++++
 drivers/net/usb/ax88179_lib.h      |  4 ++
 drivers/net/usb/ax88179a_devices.c | 95 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 123 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 6bd9704046009d7aad5ee6ddddc18faab5b030dc..8c22c2517cc08249c4e89625f142a76d4edc7d6a 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -684,6 +684,9 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	dev->driver_priv = ax179_data;
 
+	ax179_data->resume = ax88179_resume;
+	ax179_data->suspend = ax88179_suspend;
+
 	dev->net->netdev_ops = &ax88179_netdev_ops;
 	dev->net->ethtool_ops = &ax88179_ethtool_ops;
 	dev->net->needed_headroom = 8;
@@ -1340,9 +1343,9 @@ static struct usb_driver ax88179_178a_driver = {
 	.name =		"ax88179_178a",
 	.id_table =	products,
 	.probe =	usbnet_probe,
-	.suspend =	ax88179_suspend,
-	.resume =	ax88179_resume,
-	.reset_resume =	ax88179_resume,
+	.suspend =	ax88179_suspend_wrapper,
+	.resume =	ax88179_resume_wrapper,
+	.reset_resume =	ax88179_resume_wrapper,
 	.disconnect =	ax88179_disconnect,
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
index e3f01a9654f8399158aa67b688ee76dd93997939..d40b1d3238c86f9e4fb1e5996c239ab417544e7e 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -457,3 +457,22 @@ int ax88179_set_mac_addr(struct net_device *net, void *p)
 	return 0;
 }
 
+int ax88179_suspend_wrapper(struct usb_interface *intf, pm_message_t message)
+{
+	struct usbnet *dev = usb_get_intfdata(intf);
+	struct ax88179_data *priv;
+
+	priv = dev->driver_priv;
+
+	return priv->suspend(intf, message);
+}
+
+int ax88179_resume_wrapper(struct usb_interface *intf)
+{
+	struct usbnet *dev = usb_get_intfdata(intf);
+	struct ax88179_data *priv;
+
+	priv = dev->driver_priv;
+	return priv->resume(intf);
+}
+
diff --git a/drivers/net/usb/ax88179_lib.h b/drivers/net/usb/ax88179_lib.h
index 32989a6ac79c08919d67c2a04b2a5e2e02170cd0..d0150d1db12e5dc7812cd21515792fb5399a3a18 100644
--- a/drivers/net/usb/ax88179_lib.h
+++ b/drivers/net/usb/ax88179_lib.h
@@ -315,6 +315,8 @@ struct ax88179_data {
 	struct phy_device *phydev;
 	struct phylink *phylink;
 	struct phylink_config phylink_config;
+	int (*resume)(struct usb_interface *intf);
+	int (*suspend)(struct usb_interface *intf, pm_message_t message);
 };
 
 struct ax88179_int_data {
@@ -345,6 +347,8 @@ int ax88179_set_features(struct net_device *net, netdev_features_t features);
 void ax88179_get_mac_addr(struct usbnet *dev);
 int ax88179_change_mtu(struct net_device *net, int new_mtu);
 int ax88179_set_mac_addr(struct net_device *net, void *p);
+int ax88179_suspend_wrapper(struct usb_interface *intf, pm_message_t message);
+int ax88179_resume_wrapper(struct usb_interface *intf);
 
 extern const struct driver_info ax88179a_info;
 extern const struct driver_info ax88772d_info;
diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 9667cdbda9fa5e8da5eddc610f902b7c9bb66cfc..24ff28acc9366385c2e7c0f7e412635786995568 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -5,6 +5,8 @@
 #include <linux/if_vlan.h>
 #include "ax88179_lib.h"
 
+static int ax88179a_reset(struct usbnet *dev);
+
 #define AX88279_EEPROM_LEN			0x4000
 #define AX88179A_EEPROM_LEN			(32 * 20)
 
@@ -107,6 +109,53 @@ static int ax88179_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 	return ax179a_write_mmd(dev, devnum, regnum, val);
 }
 
+static int ax88179a_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct usbnet *dev = usb_get_intfdata(intf);
+	struct ax88179_data *priv;
+	u16 tmp16;
+	u8 tmp8;
+
+	priv = dev->driver_priv;
+	ax88179_set_pm_mode(dev, true);
+
+	if (netif_running(dev->net)) {
+		rtnl_lock();
+		phylink_suspend(priv->phylink, !!priv->wolopts);
+		rtnl_unlock();
+	}
+
+	/* Enable WoL */
+	if (priv->wolopts) {
+		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, &tmp8);
+		if (priv->wolopts & WAKE_PHY)
+			tmp8 |= AX_MONITOR_MODE_RWLC;
+		if (priv->wolopts & WAKE_MAGIC)
+			tmp8 |= AX_MONITOR_MODE_RWMP;
+
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, &tmp8);
+
+		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &tmp16);
+		tmp16 |= AX_MEDIUM_RECEIVE_EN;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &tmp16);
+
+		if (priv->chip_version == AX_VERSION_AX88279)
+			ax88179_write_cmd(dev, AX88179A_WAKEUP_SETTING, 8,
+					  EPHY_LOW_POWER_EN | S5_WOL_EN
+					  | S5_WOL_LOW_POWER | 0x8000, 0, NULL);
+		else
+			ax88179_write_cmd(dev, AX88179A_WAKEUP_SETTING, 0,
+					  EPHY_LOW_POWER_EN, 0, NULL);
+
+	} else if (priv->chip_version == AX_VERSION_AX88279) {
+		ax88179_write_cmd(dev, AX88179A_WAKEUP_SETTING, 8, 0x8000, 0, NULL);
+	}
+
+	usbnet_suspend(intf, message);
+	ax88179_set_pm_mode(dev, false);
+	return 0;
+}
+
 static int ax88179a_auto_detach(struct usbnet *dev)
 {
 	u16 tmp16;
@@ -116,6 +165,43 @@ static int ax88179a_auto_detach(struct usbnet *dev)
 	return 0;
 }
 
+static int ax88179a_resume(struct usb_interface *intf)
+{
+	struct usbnet *dev = usb_get_intfdata(intf);
+	struct ax88179_data *ax179_data;
+	u8 reg8;
+
+	ax179_data = dev->driver_priv;
+	ax88179_set_pm_mode(dev, true);
+
+	ax88179_read_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
+	if (!(reg8 & AX_PHY_POWER)) {
+		reg8 = AX_PHY_POWER;
+		ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
+		msleep(250);
+	}
+	ax88179_write_cmd(dev, AX_FW_MODE, AX_FW_MODE_179A, 0, 0, NULL);
+
+	/* Now, that AX_FW_MODE_179A is enabled, the PHY needs a power-cycle.
+	 * PHY-power is re-enabled in ax88179_reset()
+	 */
+	reg8 = 0;
+	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
+	msleep(250);
+
+	if (netif_running(dev->net)) {
+		rtnl_lock();
+		phylink_resume(ax179_data->phylink);
+		rtnl_unlock();
+	}
+
+	ax88179a_reset(dev);
+
+	ax88179_set_pm_mode(dev, false);
+
+	return usbnet_resume(intf);
+}
+
 static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts)
 {
 	struct ax88179_data *ax179_data = dev->driver_priv;
@@ -695,6 +781,9 @@ static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
 		ax179_data->eeprom_wen = 0;
 	}
 
+	ax179_data->resume = ax88179a_resume;
+	ax179_data->suspend = ax88179a_suspend;
+
 	dev->net->netdev_ops = &ax88179a_netdev_ops;
 	dev->net->ethtool_ops = &ax88179a_ethtool_ops;
 	dev->net->needed_headroom = 8;
@@ -1071,7 +1160,11 @@ static int ax88179a_reset(struct usbnet *dev)
 	ax179_data->eee_enabled = 0;
 	ax179_data->eee_active = 0;
 
-	phylink_start(ax179_data->phylink);
+	/* ax88179a_reset() may also be called from resume context, phylink
+	 * is already started, then.
+	 */
+	if (!ax179_data->in_pm)
+		phylink_start(ax179_data->phylink);
 
 	usbnet_link_change(dev, 0, 0);
 

-- 
2.47.3

