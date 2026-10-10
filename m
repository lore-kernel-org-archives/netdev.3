Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430136A033;
	Sat, 10 Oct 2026 04:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791608089; cv=none; b=h/B/IBCNH3t5sYlXMBE5Wr6EmktUg+C6oDNSNJTg/O8nE3tUyMHAOtNJndYei6dXTKt2ID1AZuNZpG2QxhB35euqqwYRdWmM365p+YFubxusf8OXR/5HqDL3waaYO+hx5qv/20MqcdWcWNpJGG7QSnsXdXel/9qCCXQd8O5g/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791608089; c=relaxed/simple;
	bh=tUJJD0jksXNkuuen4ysvmFDXBzUvd0XFximdyxc56jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WLBgFprej/WEVbqvGh1ct+qyK8aaqBUzuZQQwOqnOJWnCrcYdI/5o8+zFA7JtXn0Z6Wx0qViOqniq3X5eSNwkRs53x20oVAVgWwbmChiXz39cB4v73Yevp63j32UFjm7wpgj9S7Xz58iw7LwldOjVNX4XiemAYlWgpBxjo/xsnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=DkCiYBRV; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=YsR3a54g; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="DkCiYBRV";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="YsR3a54g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791608085;
	bh=tUJJD0jksXNkuuen4ysvmFDXBzUvd0XFximdyxc56jU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DkCiYBRVwozSiyrUhyvLVpSXI9C4W28mORdHZrEAq5tST4fRicxCJPUn17LMDeiwY
	 1793J3Pk8LI+jjfGlQdAQOx6d3z4hDBndEaoW3yr6i/VSw2xWam2drTluqYpIKEy7F
	 ugMw15t9ggd2tNZ+MN74sIuS64fq7vtf4LFOyLZVNjO5WqyZjRuzoPvqaeKUxmgOv6
	 S5EXh3uvUyAkwnwVivEtKDLW/nzKqsPMkWHg5RxlEdyuftGnEnsxC7zBxitQTp/4nx
	 ajvqhBgrR+Z8GwLkHuP3NctBBuPfKYeJ5DxNy5ZrRHdmqhySAG+x4txK0+gutm7+7X
	 50+OOTbIFA3wg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id DC90F47575; Sat, 10 Oct 2026 04:54:45 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791608072;
	bh=tUJJD0jksXNkuuen4ysvmFDXBzUvd0XFximdyxc56jU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YsR3a54gPNoP5uwml/Xt2T4Z9MEGWp8ExN/qnyHrVFzqbAkcc3iGhb3GgDrtgmgnr
	 GfCkUVp3OVDal3xMm85ogwdb8nA9V4T2zLCrHZjEWmA6K910TflDpJ7QMvXw5xPAVj
	 Fthmxi+2hntEHRjoiOtNUOkLPBStzbCnTl3biRRTbXDJU0BgpgKRkMTeqnigp9XXHC
	 XESapEG8Qtggd5LFVbT/aYBd3uCIkhJdBVd9KBg6grahgG03IuwcJJckyY6I/vGr34
	 SClctWvOTzVTzN2inBnu9Ajggb6jTEP6YyWGnuF/WySg1c4OmfL3oUbBaXpILZIgfx
	 D01h0VQ90TLPg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 579A3475E4;
	Sat, 10 Oct 2026 04:54:32 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 10 Oct 2026 06:54:31 +0200
Subject: [PATCH net-next v19 09/13] ax88179_178a: Add Suspend/resume
 support for AX88179A/772D/279
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-ax88179a-v19-9-7475173cfb56@birger-koblitz.de>
References: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
In-Reply-To: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
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
 drivers/net/usb/ax88179_178a.c     |   9 ++-
 drivers/net/usb/ax88179_lib.c      |  19 ++++++
 drivers/net/usb/ax88179_lib.h      |   4 ++
 drivers/net/usb/ax88179a_devices.c | 129 +++++++++++++++++++++++++++++++++++--
 4 files changed, 153 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 071b03b4f145c05fd2391546655cf569cf6ea4cd..ef0856627d08b456afb1569e8a4459b0e526ab46 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -685,6 +685,9 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 	dev->driver_priv = ax179_data;
 	mutex_init(&ax179_data->medium_status_mutex);
 
+	ax179_data->resume = ax88179_resume;
+	ax179_data->suspend = ax88179_suspend;
+
 	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_CHIP_STATUS,
 			       1, 1, &ax179_data->chip_version);
 	if (ret < 0)
@@ -1356,9 +1359,9 @@ static struct usb_driver ax88179_178a_driver = {
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
index b4b00c8b4b62320471e13ae34a1fed5d02e80441..b54e98e781f334c5aeff0b3d2861a5565934454c 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -495,3 +495,22 @@ int ax88179_set_mac_addr(struct net_device *net, void *p)
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
index adc2b4598bb52d80c18a6e2cc467144d3bd57a88..401c0bed3d28b4b94f0a0cad7509cd7087ef0639 100644
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
@@ -348,6 +350,8 @@ int ax88179_set_features(struct net_device *net, netdev_features_t features);
 void ax88179_get_mac_addr(struct usbnet *dev);
 int ax88179_change_mtu(struct net_device *net, int new_mtu);
 int ax88179_set_mac_addr(struct net_device *net, void *p);
+int ax88179_suspend_wrapper(struct usb_interface *intf, pm_message_t message);
+int ax88179_resume_wrapper(struct usb_interface *intf);
 
 extern const struct driver_info ax88179a_info;
 extern const struct driver_info ax88772d_info;
diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index a6b0a3f47118c46db38d483792c083510aa2641a..01d6a35f68b2c56f79acbe2875ce8e99ccdfb197 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -5,6 +5,8 @@
 #include <linux/if_vlan.h>
 #include "ax88179_lib.h"
 
+static int ax88179a_reset(struct usbnet *dev);
+
 #define AX88279_EEPROM_LEN			0x4000
 #define AX88179A_EEPROM_LEN			(32 * 20)
 
@@ -126,6 +128,63 @@ static void ax88179a_status(struct usbnet *dev, struct urb *urb)
 	phylink_mac_interrupt(data->phylink);
 }
 
+static int ax88179a_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct usbnet *dev = usb_get_intfdata(intf);
+	struct ax88179_data *priv;
+	u8 tmp8 = 0;
+	u16 tmp16;
+	int ret;
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
+	ret = usbnet_suspend(intf, message);
+	if (ret && netif_running(dev->net)) {
+		rtnl_lock();
+		phylink_resume(priv->phylink);
+		rtnl_unlock();
+		ax88179_set_pm_mode(dev, false);
+		return ret;
+	}
+
+	/* Enable WoL */
+	if (priv->wolopts) {
+		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, &tmp8);
+		tmp8 &= ~(AX_MONITOR_MODE_RWLC | AX_MONITOR_MODE_RWMP);
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
+	ax88179_set_pm_mode(dev, false);
+	return 0;
+}
+
 static int ax88179a_auto_detach(struct usbnet *dev)
 {
 	u16 tmp16;
@@ -135,6 +194,47 @@ static int ax88179a_auto_detach(struct usbnet *dev)
 	return 0;
 }
 
+static int ax88179a_resume(struct usb_interface *intf)
+{
+	struct usbnet *dev = usb_get_intfdata(intf);
+	struct ax88179_data *ax179_data;
+	u8 reg8 = 0;
+	int ret;
+
+	ax179_data = dev->driver_priv;
+	ax88179_set_pm_mode(dev, true);
+
+	ret = ax88179_read_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
+	if (ret < 0)
+		goto err_out;
+
+	if (!(reg8 & AX_PHY_POWER)) {
+		reg8 = AX_PHY_POWER;
+		ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
+		msleep(250);
+	}
+	ax88179_write_cmd(dev, AX_FW_MODE, AX_FW_MODE_179A, 0, 0, NULL);
+
+	/* Now, that AX_FW_MODE_179A is enabled, the PHY needs a power-cycle.
+	 * PHY-power is re-enabled in ax88179a_reset()
+	 */
+	ax88179_write_u8(dev, AX88179A_PHY_POWER, 0, 0, 0);
+	msleep(250);
+
+	ax88179a_reset(dev);
+
+err_out:
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
@@ -755,6 +855,9 @@ static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
 		ax179_data->eeprom_wen = 0;
 	}
 
+	ax179_data->resume = ax88179a_resume;
+	ax179_data->suspend = ax88179a_suspend;
+
 	dev->net->netdev_ops = &ax88179a_netdev_ops;
 	dev->net->ethtool_ops = &ax88179a_ethtool_ops;
 	dev->net->needed_headroom = 8;
@@ -802,6 +905,13 @@ static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
 	if (ret)
 		goto initphy_err;
 
+	/* Keep this interface runtime-PM active by taking a usage ref.
+	 * Prevents runtime suspend while bound and avoids resume paths
+	 * that could deadlock (autoresume under RTNL while USB PM lock
+	 * is held, phylink/MDIO wants RTNL).
+	 */
+	pm_runtime_get_noresume(&intf->dev);
+
 	return 0;
 
 initphy_err:
@@ -829,7 +939,8 @@ static void ax88179a_unbind(struct usbnet *dev, struct usb_interface *intf)
 	ax88179a_mdio_unregister(ax179_data);
 
 	ax88179_write_u8(dev, AX88179A_PHY_POWER, 0, 0, 0);
-
+	/* Drop the PM usage ref taken in bind() */
+	pm_runtime_put_noidle(&intf->dev);
 	kfree(ax179_data);
 }
 
@@ -1055,9 +1166,13 @@ static int ax88179a_reset(struct usbnet *dev)
 	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_SWP_CTRL, 1, 0);
 	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_TX_HDR_CKSUM, 1, 0);
 
-	/* Read MAC address from DTB or asix chip */
-	ax88179_get_mac_addr(dev);
-	memcpy(dev->net->perm_addr, dev->net->dev_addr, ETH_ALEN);
+	/* Read MAC address from DTB or asix chip, except when called
+	 * from resume context.
+	 */
+	if (!ax179_data->in_pm) {
+		ax88179_get_mac_addr(dev);
+		memcpy(dev->net->perm_addr, dev->net->dev_addr, ETH_ALEN);
+	}
 
 	/* The Bulk-Register configuration for the AX88179A is done in
 	 * ax88179a_mac_link_up(), once the link is up for a given link and USB-speed.
@@ -1117,7 +1232,11 @@ static int ax88179a_reset(struct usbnet *dev)
 	/* Ensure EEE state is off, consistent with phylink setup */
 	ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, false, 0, NULL);
 
-	phylink_start(ax179_data->phylink);
+	/* ax88179a_reset() may also be called from resume context,
+	 * phylink_resume() will start phylink, then.
+	 */
+	if (!ax179_data->in_pm)
+		phylink_start(ax179_data->phylink);
 
 	return 0;
 }

-- 
2.47.3

