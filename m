Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E835DA69;
	Wed, 16 Sep 2026 03:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529113; cv=none; b=pgCOVkbVQeprkDGPOFTWCMrC9rHOuJttPnYruBLZxpmzkva2JgHamWwidu+i4qb2Qiy/GooTaA7HcE74ncIFOvJrmsMUZCtsvhwg4uixqPRDNAA+VL7v3ZQKS2cqTftWMsFDk6uca4qy6UAckMHj0UCZblqkmAWtEH/2vyhr8KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529113; c=relaxed/simple;
	bh=lC61MN8nqUOmxti+MUkrYTRbYi8j/0XheQ/3EVgD4oY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qdsYTGYF6bMp+2F50k70jita1Q7YGAtvvOHVvolMuLucRDQslVWBuVF2w9uXBcCdxBBzwqUmDUtz3muv56x3a64sBr2Uw2ttAcwZDUtrO2am/ghUUm8LIedAfqDHaUDeysZYtZWLjA12QpRH8CiQGQoXsWxbzPiedmKCP5UFGG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=DU1EBOgz; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=K99gYUyO; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="DU1EBOgz";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="K99gYUyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529110;
	bh=lC61MN8nqUOmxti+MUkrYTRbYi8j/0XheQ/3EVgD4oY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DU1EBOgz0QI5kxWXQD5ukxQXT6kPblNDy1FAdUq6i2Ee+Njg2S7p94/eie4asZEeZ
	 Bs4ooSqORhN7zJ50IG9Gt+Oy+4IsNt4HUwv2pxkzETuuN69bF6RJkzntEJ/fvJ4MLh
	 EttzJBHLSs4pgpwy8yAPrhIbzGSAmLr1WI+KDB6e0Vzyh73R9ijRlSnUXnrXeAPZSM
	 8tS4DtN9LETfYOUfogQrIUZBcN3VLDvFMyQJERKUBjTm6gtCHefXaA3Da8SuC9psin
	 CUSVkZfE8rYN6pHJhMbkKK5HFbcrtJzqIPjHf+VILSir2TRQdabQJKIEn9UPMbs5Le
	 RcrpY1w0meZvw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 8AA2E3FA7D; Wed, 16 Sep 2026 03:25:10 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529109;
	bh=lC61MN8nqUOmxti+MUkrYTRbYi8j/0XheQ/3EVgD4oY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K99gYUyO4uCepDnkQ2v51420z2nC5LLZmp5v/DYa6LposFNgStjIJnjtz98q84uLp
	 iKRwueS80dg/TDoi1/I2WirCsGjAKTU/aIEhkhSx2fm1ebbXEo8tmGmFEhDG5r2BWK
	 1GNBW5Ek7zVmAWJag5kigWCHxBgSCfpPUFhwno5UPYh5tmeUFPcZfMUEKqRE0QUaMy
	 LTRkvDpeF6QZWCp94ukkDG/NVPpEOsdfMwUeUJcrEHFWO699kIrq7VjFplKUsXSZ3x
	 x2fpBxOlNNnT/3p91ggLu4MkN3ueZYzUbnL9uKw7ckA2/BCG82YmSuHXQfzAwSJyEh
	 W1aAetYNk5TMg==
Received: from DELLLaptop.net (unknown [223.86.26.228])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 58F913FA6C;
	Wed, 16 Sep 2026 03:25:03 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 16 Sep 2026 05:24:10 +0200
Subject: [PATCH net-next v12 11/15] ax88179_178a: Add Suspend/resume
 support for AX88179A/772D/279
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ax88179a-v12-11-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
In-Reply-To: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
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
Suggested-by: Jianhui Xu <neuromoments@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179_178a.c     |  9 ++--
 drivers/net/usb/ax88179_lib.c      | 19 ++++++++
 drivers/net/usb/ax88179_lib.h      |  4 ++
 drivers/net/usb/ax88179a_devices.c | 95 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 123 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index a2c596305f7988175ef56afbc853e798406159f6..93031b9ee92bc64c53387291616aa3b40db6feb9 100644
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
@@ -1342,9 +1345,9 @@ static struct usb_driver ax88179_178a_driver = {
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
index 708b0b23f1363daf90f329a3e6b6a2721d110387..3b498206c50d5b5d9d5cd489114ef28bf280fe97 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -455,3 +455,22 @@ int ax88179_set_mac_addr(struct net_device *net, void *p)
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
index 2e4d35c74ee8b32cd2916924b85d5427860bb08c..16a6dcbd6e66e37d3da0e57d2800c29d8a95a34a 100644
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
@@ -346,6 +348,8 @@ int ax88179_set_features(struct net_device *net, netdev_features_t features);
 void ax88179_get_mac_addr(struct usbnet *dev);
 int ax88179_change_mtu(struct net_device *net, int new_mtu);
 int ax88179_set_mac_addr(struct net_device *net, void *p);
+int ax88179_suspend_wrapper(struct usb_interface *intf, pm_message_t message);
+int ax88179_resume_wrapper(struct usb_interface *intf);
 
 extern const struct driver_info ax88179a_info;
 extern const struct driver_info ax88772d_info;
diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index e77450bc3299fb1a3698b36cab2785e82cf759a6..ff41d20c219d46392c2633a1eaff021385490b0e 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -5,6 +5,8 @@
 #include <linux/if_vlan.h>
 #include "ax88179_lib.h"
 
+static int ax88179a_reset(struct usbnet *dev);
+
 #define AX88279_EEPROM_LEN			0x4000
 #define AX88179A_EEPROM_LEN			(32 * 20)
 
@@ -123,6 +125,53 @@ static void ax88179a_status(struct usbnet *dev, struct urb *urb)
 	phylink_mac_interrupt(data->phylink);
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
@@ -132,6 +181,43 @@ static int ax88179a_auto_detach(struct usbnet *dev)
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
+	ax88179a_reset(dev);
+
+	if (netif_running(dev->net)) {
+		rtnl_lock();
+		phylink_resume(ax179_data->phylink);
+		rtnl_unlock();
+	}
+
+	ax88179_set_pm_mode(dev, false);
+
+	return usbnet_resume(intf);
+}
+
 static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts, u8 speed, bool full_duplex)
 {
 	struct ax88179_data *ax179_data = dev->driver_priv;
@@ -687,6 +773,9 @@ static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
 		ax179_data->eeprom_wen = 0;
 	}
 
+	ax179_data->resume = ax88179a_resume;
+	ax179_data->suspend = ax88179a_suspend;
+
 	dev->net->netdev_ops = &ax88179a_netdev_ops;
 	dev->net->ethtool_ops = &ax88179a_ethtool_ops;
 	dev->net->needed_headroom = 8;
@@ -1048,7 +1137,11 @@ static int ax88179a_reset(struct usbnet *dev)
 			     1, 1, &tmp) > 0)
 		ax179_data->wol_supported = WAKE_MAGIC | WAKE_PHY;
 
-	phylink_start(ax179_data->phylink);
+	/* ax88179a_reset() may also be called from resume context, phylink
+	 * is already started, then.
+	 */
+	if (!ax179_data->in_pm)
+		phylink_start(ax179_data->phylink);
 
 	usbnet_link_change(dev, 0, 0);
 

-- 
2.47.3

