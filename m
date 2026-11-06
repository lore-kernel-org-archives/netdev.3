Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.97.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949703;
	b=cKFWb+qTRN6RZMGLf5kPHwvdAwRwnKKhCWA/l228BMrlcKJbL/rp83aEinYMp01lTS9O
	 Kl4mqZMB1hVlkI2iyvbTcF11rK790iPPwpbzvkryUO36opJcufKnxEs8e1wJjuCpufz0J
	 +cBCvEyfSu+4QtOtfhPEgka8Lp957ZzL70kDKA1fmuXmS2zviiMjm3LScF+1nmEBVJHG5
	 jpVw809rSLGX0lXPQ4QPKENyU3yRQiwsxeXj4l2NNDmjO9+/ttDnEGbuiXxXK3SygulH0
	 dt0U+H6UN8R3M7qpKkEudYddFP0OVe746tTJchtt6M2MxpKxeLDTRyRnsyDi1cmI+8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949703;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=mVZiHmOuEdRMqFN7HnpPW986NDBFbPJFJP84aT4kdvI=;
	b=obqM87qpLPf/LPvu0tXW2HdhbWCGvWG+qTAYmibB2Km60wBeBHqMGqR7+216ylSc5who
	 D42C8r54UgZskaOM60PQtoHuE4O037cnrYZCyuk5sXiyBFhRLWraGiSdBDFmWXr8bWHVN
	 Apy1rMpdD41z7Pg8gldX3afNAGGmcSA7lye6tmCUmFwduz3TBlFz77Jz6HQppGtgAExMy
	 JfTZHYa8aEpSB9DX6HQUae4KiAMR6TxNMje5q4WdGSZTnuz3YFS7uKBf8+TTqza7endhB
	 0AEc+hwHK/EZ7LFSVdnTm2xIS21RtYl/9jco35CE5VPufo38FDGjqO58ybmizLZXd1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=birger-koblitz.de;
	spf=pass smtp.mailfrom=birger-koblitz.de;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=QHXvqQPj;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=z11N2o4t;
	arc=none smtp.remote-ip=23.88.97.239
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107BC606EEB9;
	Fri,  6 Nov 2026 07:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 107BC606EEB9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=QHXvqQPj;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=z11N2o4t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949701;
	bh=sB85/P4cqRZNZK4mHg9B3Ife2nyKRrwIcHiALBjVneM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QHXvqQPjZSpj9GrW6PcIkpFvMRQiBLke08dJeB4VcU4A3rdDDIOzgeNj5P7xz7Ln3
	 OjgShzJwTbL9nHOPYh2g05cSQeN5PLGBxDL3cOb8yr9B5bk8DFKVJXcncKBxBWuzUB
	 3EgpH3z1I9WZun86UPu/Xoxwwtk+TT/umRvJFSlG56ic1iy2HFf2EzcGsFmN+6NVVP
	 2CH5OHMwrGiOBZwXCxzmHpgFmVqVWhz91Hx69BwxVVxUe9F/WDKJ2Hts7gC723yBov
	 lTEcXmol9kCIE1hpVO6wsfBHYMAYLurmYwrxWBwdr8mss66mYsudakzLgCjkNopYi3
	 ZSus06cUXKjsA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 8C4B948BA9; Fri,  6 Nov 2026 07:21:41 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949687;
	bh=sB85/P4cqRZNZK4mHg9B3Ife2nyKRrwIcHiALBjVneM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=z11N2o4tRks+9eqpFil/zHLsyQBP0zFgJS/6AeUghmZtjm0Yu8e770LIjz/4x2R/l
	 Nz2Q9ZiA1STBaXLtz8pE76KsHmalQWdeCCki3jw+trS2zSEQWPs4daql8a+k7ORFrp
	 jcflA22wmEbb7B3g4Ig4Wh1wi7glhzkBTdWQ+oTDPkCFXda+kRtD9heZLvFLfWwu5e
	 3KD+9tUQPZUyWOKr+N949uFyxucDkEoiNMZsCzGdUOMndXPU+5E36LGJSr64aTLZV3
	 fTBGQFa51blo7iLSHr0xsMJ/LhKYWlwbszfXSkboMgLM7qQ7Al0aLNmTqBBzrRMKmw
	 LgBNSs6EFssfw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 88F9748B86;
	Fri,  6 Nov 2026 07:21:27 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 06 Nov 2026 08:21:24 +0100
Subject: [PATCH net-next v20 09/13] ax88179_178a: Add Suspend/resume
 support for AX88179A/772D/279
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ax88179a-v20-9-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
In-Reply-To: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Emir Beganovic <beganovic.emir@gmail.com>, 
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
index f78ad344c1c4f1f057164728e4f21f875e6cdc1a..b077b7153f0c07676aafd5dfd13a2c0d9a826719 100644
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
@@ -1362,9 +1365,9 @@ static struct usb_driver ax88179_178a_driver = {
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

