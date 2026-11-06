Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.97.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949695;
	b=O5YQPq+siI3GWaQ3afHt3N7lBKCCU+INGLp2nl70lKELQXNSFD/c+rvzGsCrmNbghb4M
	 Uep3ab5eMLuIzqMpsRaqDV53N4i7zpdxfsJN74EoM/e1q4hoVLdtbukA1IfoyA/pqYuED
	 nnBUT+XUSfPRuES80mMbcNpk6eXht6WOh3BYY+58FqRiegcfs8cscsxVcQOXFioarR7L9
	 heHX3+cSoECW2kGCeA7ga+wtbfhL6LHj0gN0M8lHqBxg/w4oFzrM+S+4y/5xHc4mtAIkx
	 uDlmtc+ruDy55gHBTmBuWLw/FkhV5E/yX9v6M96lzRjphOoOSUmkyI14CJ9Whr/2W6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949695;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=T2nTaGKnGdGPKJPXZGKjsBIupzve4i3OOjphha9/dbs=;
	b=Hp37/JqlgCJOut+9EaZg2jTaNmk7smkH/SqrIPP+sLDxdhjP7wLQYCUe8DtkH0pJWBKN
	 L/xKwAf8S6FSM4M/uQbQIy/rUXVpiOvPFVymnmJRjbD7PANIvoBeY+pZvoTy2Xz05OUE9
	 iT+Ccs1p69EFvv5ObGBO+eUgS1OUkAsNxCUWPcK1Ij+QO0YSPbaCdf1xJDGTLxxi9Yaj4
	 UZCAzjQexRwQevh/FNdails6iWXoAaVe3Uikfpvq0Mge3Cy/5gBOz+bD9+krPg1TfQCoK
	 N1eRq/Oi3IgoIXCinnR4GNBuiQR0a3aW/NWh3DZDkq0dIcIwk3WCwOjp/wIogqoV7VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=birger-koblitz.de;
	spf=pass smtp.mailfrom=birger-koblitz.de;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=KduD7Xo9;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b="aWXgyg/q";
	arc=none smtp.remote-ip=23.88.97.239
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC062606A329;
	Fri,  6 Nov 2026 07:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC062606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=KduD7Xo9;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=aWXgyg/q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949692;
	bh=twEY2ldqjJAIiXeE51wGyQvJVHKtsVYYULlvgEdqL9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KduD7Xo99E/KFm6RP8FrvoUKI4gKRp55x3L6635/0NQe5sMGHmDG3BNYYh775/dq7
	 xrIg75gvE6hhjmWspVICq0vXIz3k9VhS1DrQMngLaMaGn85VLxYjFUZJTATu0KJ6Mg
	 Jy1/QGUq/hmrBKH0WDj2bMtwPtWH8QdOxvN5Mphjj79zdk97IVjROOP26Y4k92Cf1O
	 7sUSnzY5XrzfGKkG6gnRYQqBKDaH507AGLUWuRir6Pq/uImBHlfc6/K16h0UfBPPZJ
	 vDa8sy6jNCNC9MxG/mr3at/grZMdlRt35cPNqk2F9YkKjKHCVg+UttQqE/Wqg2ML5i
	 ZUwvJ1OZhBszQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 5D52E48BA6; Fri,  6 Nov 2026 07:21:32 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949685;
	bh=twEY2ldqjJAIiXeE51wGyQvJVHKtsVYYULlvgEdqL9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aWXgyg/qBoIVCjl4Ue9U/onrFGDd9yqrt3ozRCXD3b8ZRjy72WbSorHo4m4vWyjfz
	 IWrhHOtT42LTbVkN2HiJgycWbhHspZJfSArqW12camPiVX6kLUvfs4wJ30FGeoju8v
	 MfXwBe6/pxADoyPsZlG4AM3TJryq5IifqTVhuhbUwIZXkyEW+WQW8u7sr3aKMbPxhy
	 99fE5GUNK7wI/+NYcjU31GAwwOVJwTu+0MlxuzmsBBfMEKhrQvTx2q3Yem6dy2zE5e
	 nwVFUDQ9P0spTQQ4vNbnVFjm5gLbZ8R6cRkhw2sFaDz0BWlK3HI9nOoownsomAQtp6
	 oCkE0a6iMlg9A==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 8B57548B8C;
	Fri,  6 Nov 2026 07:21:24 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 06 Nov 2026 08:21:18 +0100
Subject: [PATCH net-next v20 03/13] ax88179_178a: Split driver into library
 and device specific code
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
Message-Id: <20261106-ax88179a-v20-3-37b5a1189983@birger-koblitz.de>
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
 Birger Koblitz <mail@birger-koblitz.de>, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2

Split the ax88179_178a module code into code common to the
AX88179/178a/179a and 279 family of controllers and device
specific code for the currently supported devices based
on the AX88179 and AX88178a.

Rename the module to ax88179 to reflect the broader scope of
controllers supported by the module and add an alias to the old
module name:
MODULE_ALIAS("ax88179_178a");

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/usb/Makefile       |   3 +-
 drivers/net/usb/ax88179_178a.c | 613 +----------------------------------------
 drivers/net/usb/ax88179_lib.c  | 461 +++++++++++++++++++++++++++++++
 drivers/net/usb/ax88179_lib.h  | 195 +++++++++++++
 4 files changed, 661 insertions(+), 611 deletions(-)

diff --git a/drivers/net/usb/Makefile b/drivers/net/usb/Makefile
index 4964f7b326fbcedffc1e5a1bf004aea95560db8c..ddd76fa71e2ee670888df1c9715632e5c04a8149 100644
--- a/drivers/net/usb/Makefile
+++ b/drivers/net/usb/Makefile
@@ -12,7 +12,8 @@ obj-$(CONFIG_USB_HSO)		+= hso.o
 obj-$(CONFIG_USB_LAN78XX)	+= lan78xx.o
 obj-$(CONFIG_USB_NET_AX8817X)	+= asix.o
 asix-y := asix_devices.o asix_common.o ax88172a.o
-obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179_178a.o
+obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179.o
+ax88179-y := ax88179_178a.o ax88179_lib.o
 obj-$(CONFIG_USB_NET_CDCETHER)	+= cdc_ether.o
 obj-$(CONFIG_USB_NET_CDC_EEM)	+= cdc_eem.o
 obj-$(CONFIG_USB_NET_DM9601)	+= dm9601.o
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index c179e2319081738d1d342c808578772b7ef9b36c..55268d0890d1200be07b87f2dc9e62d2d7b69fc1 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -8,179 +8,12 @@
 #include <linux/module.h>
 #include <linux/etherdevice.h>
 #include <linux/mii.h>
-#include <linux/usb.h>
-#include <linux/crc32.h>
-#include <linux/usb/usbnet.h>
 #include <uapi/linux/mdio.h>
 #include <linux/mdio.h>
-
-#define AX88179_PHY_ID				0x03
-#define AX_EEPROM_LEN				0x100
-#define AX88179_EEPROM_MAGIC			0x17900b95
-#define AX_MCAST_FLTSIZE			8
-#define AX_MAX_MCAST				64
-#define AX_INT_PPLS_LINK			((u32)BIT(16))
-#define AX_RXHDR_L4_TYPE_MASK			0x1c
-#define AX_RXHDR_L4_TYPE_UDP			4
-#define AX_RXHDR_L4_TYPE_TCP			16
-#define AX_RXHDR_L3CSUM_ERR			2
-#define AX_RXHDR_L4CSUM_ERR			1
-#define AX_RXHDR_CRC_ERR			((u32)BIT(29))
-#define AX_RXHDR_DROP_ERR			((u32)BIT(31))
-#define AX_ACCESS_MAC				0x01
-#define AX_ACCESS_PHY				0x02
-#define AX_ACCESS_EEPROM			0x04
-#define AX_ACCESS_EFUS				0x05
-#define AX_RELOAD_EEPROM_EFUSE			0x06
-#define AX_PAUSE_WATERLVL_LOW			0x54
-#define AX_PAUSE_WATERLVL_HIGH			0x55
-
-#define PHYSICAL_LINK_STATUS			0x02
-	#define	AX_USB_SS		0x04
-	#define	AX_USB_HS		0x02
-
-#define GENERAL_STATUS				0x03
-/* Check AX88179 version. UA1:Bit2 = 0,  UA2:Bit2 = 1 */
-	#define	AX_SECLD		0x04
-
-#define AX_SROM_ADDR				0x07
-#define AX_SROM_CMD				0x0a
-	#define EEP_RD			0x04
-	#define EEP_BUSY		0x10
-
-#define AX_SROM_DATA_LOW			0x08
-#define AX_SROM_DATA_HIGH			0x09
-
-#define AX_RX_CTL				0x0b
-	#define AX_RX_CTL_DROPCRCERR	0x0100
-	#define AX_RX_CTL_IPE		0x0200
-	#define AX_RX_CTL_START		0x0080
-	#define AX_RX_CTL_AP		0x0020
-	#define AX_RX_CTL_AM		0x0010
-	#define AX_RX_CTL_AB		0x0008
-	#define AX_RX_CTL_AMALL		0x0002
-	#define AX_RX_CTL_PRO		0x0001
-	#define AX_RX_CTL_STOP		0x0000
-
-#define AX_NODE_ID				0x10
-#define AX_MULFLTARY				0x16
-
-#define AX_MEDIUM_STATUS_MODE			0x22
-	#define AX_MEDIUM_GIGAMODE	0x01
-	#define AX_MEDIUM_FULL_DUPLEX	0x02
-	#define AX_MEDIUM_EN_125MHZ	0x08
-	#define AX_MEDIUM_RXFLOW_CTRLEN	0x10
-	#define AX_MEDIUM_TXFLOW_CTRLEN	0x20
-	#define AX_MEDIUM_RECEIVE_EN	0x100
-	#define AX_MEDIUM_PS		0x200
-	#define AX_MEDIUM_JUMBO_EN	0x8040
-
-#define AX_MONITOR_MOD				0x24
-	#define AX_MONITOR_MODE_RWLC	0x02
-	#define AX_MONITOR_MODE_RWMP	0x04
-	#define AX_MONITOR_MODE_PMEPOL	0x20
-	#define AX_MONITOR_MODE_PMETYPE	0x40
-
-#define AX_GPIO_CTRL				0x25
-	#define AX_GPIO_CTRL_GPIO3EN	0x80
-	#define AX_GPIO_CTRL_GPIO2EN	0x40
-	#define AX_GPIO_CTRL_GPIO1EN	0x20
-
-#define AX_PHYPWR_RSTCTL			0x26
-	#define AX_PHYPWR_RSTCTL_BZ	0x0010
-	#define AX_PHYPWR_RSTCTL_IPRL	0x0020
-	#define AX_PHYPWR_RSTCTL_AT	0x1000
-
-#define AX_RX_BULKIN_QCTRL			0x2e
-#define AX_CLK_SELECT				0x33
-	#define AX_CLK_SELECT_BCS	0x01
-	#define AX_CLK_SELECT_ACS	0x02
-	#define AX_CLK_SELECT_ULR	0x08
-
-#define AX_RXCOE_CTL				0x34
-	#define AX_RXCOE_IP		0x01
-	#define AX_RXCOE_TCP		0x02
-	#define AX_RXCOE_UDP		0x04
-	#define AX_RXCOE_TCPV6		0x20
-	#define AX_RXCOE_UDPV6		0x40
-
-#define AX_TXCOE_CTL				0x35
-	#define AX_TXCOE_IP		0x01
-	#define AX_TXCOE_TCP		0x02
-	#define AX_TXCOE_UDP		0x04
-	#define AX_TXCOE_TCPV6		0x20
-	#define AX_TXCOE_UDPV6		0x40
-
-#define AX_LEDCTRL				0x73
-
-#define GMII_PHY_PHYSR				0x11
-	#define GMII_PHY_PHYSR_SMASK	0xc000
-	#define GMII_PHY_PHYSR_GIGA	0x8000
-	#define GMII_PHY_PHYSR_100	0x4000
-	#define GMII_PHY_PHYSR_FULL	0x2000
-	#define GMII_PHY_PHYSR_LINK	0x400
-
-#define GMII_LED_ACT				0x1a
-	#define	GMII_LED_ACTIVE_MASK	0xff8f
-	#define	GMII_LED0_ACTIVE	BIT(4)
-	#define	GMII_LED1_ACTIVE	BIT(5)
-	#define	GMII_LED2_ACTIVE	BIT(6)
-
-#define GMII_LED_LINK				0x1c
-	#define	GMII_LED_LINK_MASK	0xf888
-	#define	GMII_LED0_LINK_10	BIT(0)
-	#define	GMII_LED0_LINK_100	BIT(1)
-	#define	GMII_LED0_LINK_1000	BIT(2)
-	#define	GMII_LED1_LINK_10	BIT(4)
-	#define	GMII_LED1_LINK_100	BIT(5)
-	#define	GMII_LED1_LINK_1000	BIT(6)
-	#define	GMII_LED2_LINK_10	BIT(8)
-	#define	GMII_LED2_LINK_100	BIT(9)
-	#define	GMII_LED2_LINK_1000	BIT(10)
-	#define	LED0_ACTIVE		BIT(0)
-	#define	LED0_LINK_10		BIT(1)
-	#define	LED0_LINK_100		BIT(2)
-	#define	LED0_LINK_1000		BIT(3)
-	#define	LED0_FD			BIT(4)
-	#define	LED0_USB3_MASK		0x001f
-	#define	LED1_ACTIVE		BIT(5)
-	#define	LED1_LINK_10		BIT(6)
-	#define	LED1_LINK_100		BIT(7)
-	#define	LED1_LINK_1000		BIT(8)
-	#define	LED1_FD			BIT(9)
-	#define	LED1_USB3_MASK		0x03e0
-	#define	LED2_ACTIVE		BIT(10)
-	#define	LED2_LINK_1000		BIT(13)
-	#define	LED2_LINK_100		BIT(12)
-	#define	LED2_LINK_10		BIT(11)
-	#define	LED2_FD			BIT(14)
-	#define	LED_VALID		BIT(15)
-	#define	LED2_USB3_MASK		0x7c00
-
-#define GMII_PHYPAGE				0x1e
-#define GMII_PHY_PAGE_SELECT			0x1f
-	#define GMII_PHY_PGSEL_EXT	0x0007
-	#define GMII_PHY_PGSEL_PAGE0	0x0000
-	#define GMII_PHY_PGSEL_PAGE3	0x0003
-	#define GMII_PHY_PGSEL_PAGE5	0x0005
+#include "ax88179_lib.h"
 
 static int ax88179_reset(struct usbnet *dev);
 
-struct ax88179_data {
-	u8  eee_enabled;
-	u8  eee_active;
-	u16 rxctl;
-	u8 in_pm;
-	u32 wol_supported;
-	u32 wolopts;
-	u8 disconnecting;
-};
-
-struct ax88179_int_data {
-	__le32 intdata1;
-	__le32 intdata2;
-};
-
 static const struct {
 	unsigned char ctrl, timer_l, timer_h, size, ifg;
 } AX88179_BULKIN_SIZE[] =	{
@@ -190,165 +23,6 @@ static const struct {
 	{7, 0xcc, 0x4c, 0x18, 8},
 };
 
-static void ax88179_set_pm_mode(struct usbnet *dev, bool pm_mode)
-{
-	struct ax88179_data *ax179_data = dev->driver_priv;
-
-	ax179_data->in_pm = pm_mode;
-}
-
-static int ax88179_in_pm(struct usbnet *dev)
-{
-	struct ax88179_data *ax179_data = dev->driver_priv;
-
-	return ax179_data->in_pm;
-}
-
-static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
-			      u16 size, void *data)
-{
-	int ret;
-	int (*fn)(struct usbnet *, u8, u8, u16, u16, void *, u16);
-	struct ax88179_data *ax179_data = dev->driver_priv;
-
-	BUG_ON(!dev);
-
-	if (!ax88179_in_pm(dev))
-		fn = usbnet_read_cmd;
-	else
-		fn = usbnet_read_cmd_nopm;
-
-	ret = fn(dev, cmd, USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-		 value, index, data, size);
-
-	if (unlikely((ret < 0) && !(ret == -ENODEV && ax179_data->disconnecting)))
-		netdev_warn(dev->net, "Failed to read reg index 0x%04x: %d\n",
-			    index, ret);
-
-	return ret;
-}
-
-static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
-			       u16 size, const void *data)
-{
-	int ret;
-	int (*fn)(struct usbnet *, u8, u8, u16, u16, const void *, u16);
-	struct ax88179_data *ax179_data = dev->driver_priv;
-
-	BUG_ON(!dev);
-
-	if (!ax88179_in_pm(dev))
-		fn = usbnet_write_cmd;
-	else
-		fn = usbnet_write_cmd_nopm;
-
-	ret = fn(dev, cmd, USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-		 value, index, data, size);
-
-	if (unlikely((ret < 0) && !(ret == -ENODEV && ax179_data->disconnecting)))
-		netdev_warn(dev->net, "Failed to write reg index 0x%04x: %d\n",
-			    index, ret);
-
-	return ret;
-}
-
-static void ax88179_write_cmd_async(struct usbnet *dev, u8 cmd, u16 value,
-				    u16 index, u16 size, void *data)
-{
-	u16 buf;
-
-	if (2 == size) {
-		buf = *((u16 *)data);
-		cpu_to_le16s(&buf);
-		usbnet_write_cmd_async(dev, cmd, USB_DIR_OUT | USB_TYPE_VENDOR |
-				       USB_RECIP_DEVICE, value, index, &buf,
-				       size);
-	} else {
-		usbnet_write_cmd_async(dev, cmd, USB_DIR_OUT | USB_TYPE_VENDOR |
-				       USB_RECIP_DEVICE, value, index, data,
-				       size);
-	}
-}
-
-static int ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
-			    u16 size, void *data)
-{
-	int ret;
-
-	if (2 == size) {
-		u16 buf = 0;
-		ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
-		le16_to_cpus(&buf);
-		*((u16 *)data) = buf;
-	} else if (4 == size) {
-		u32 buf = 0;
-		ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
-		le32_to_cpus(&buf);
-		*((u32 *)data) = buf;
-	} else {
-		ret = __ax88179_read_cmd(dev, cmd, value, index, size, data);
-	}
-
-	return ret;
-}
-
-static int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
-			     u16 size, const void *data)
-{
-	int ret;
-
-	if (2 == size) {
-		u16 buf;
-		buf = *((u16 *)data);
-		cpu_to_le16s(&buf);
-		ret = __ax88179_write_cmd(dev, cmd, value, index,
-					  size, &buf);
-	} else {
-		ret = __ax88179_write_cmd(dev, cmd, value, index,
-					  size, data);
-	}
-
-	return ret;
-}
-
-static void ax88179_status(struct usbnet *dev, struct urb *urb)
-{
-	struct ax88179_int_data *event;
-	u32 link;
-
-	if (urb->actual_length < 8)
-		return;
-
-	event = urb->transfer_buffer;
-	le32_to_cpus((void *)&event->intdata1);
-
-	link = (((__force u32)event->intdata1) & AX_INT_PPLS_LINK) >> 16;
-
-	if (netif_carrier_ok(dev->net) != link) {
-		usbnet_link_change(dev, link, 1);
-		if (!link)
-			netdev_info(dev->net, "ax88179 - Link status is: 0\n");
-	}
-}
-
-static int ax88179_mdio_read(struct net_device *netdev, int phy_id, int loc)
-{
-	struct usbnet *dev = netdev_priv(netdev);
-	u16 res;
-
-	ax88179_read_cmd(dev, AX_ACCESS_PHY, phy_id, (__u16)loc, 2, &res);
-	return res;
-}
-
-static void ax88179_mdio_write(struct net_device *netdev, int phy_id, int loc,
-			       int val)
-{
-	struct usbnet *dev = netdev_priv(netdev);
-	u16 res = (u16) val;
-
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, phy_id, (__u16)loc, 2, &res);
-}
-
 static inline int ax88179_phy_mmd_indirect(struct usbnet *dev, u16 prtad,
 					   u16 devad)
 {
@@ -510,146 +184,11 @@ static void ax88179_disconnect(struct usb_interface *intf)
 	usbnet_disconnect(intf);
 }
 
-static void
-ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
-{
-	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *priv = dev->driver_priv;
-
-	wolinfo->supported = priv->wol_supported;
-	wolinfo->wolopts = priv->wolopts;
-}
-
-static int
-ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
-{
-	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *priv = dev->driver_priv;
-
-	if (wolinfo->wolopts & ~(priv->wol_supported))
-		return -EINVAL;
-
-	priv->wolopts = wolinfo->wolopts;
-
-	return 0;
-}
-
 static int ax88179_get_eeprom_len(struct net_device *net)
 {
 	return AX_EEPROM_LEN;
 }
 
-static int
-ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
-		   u8 *data)
-{
-	struct usbnet *dev = netdev_priv(net);
-	u16 *eeprom_buff;
-	int first_word, last_word;
-	int i, ret;
-
-	if (eeprom->len == 0)
-		return -EINVAL;
-
-	eeprom->magic = AX88179_EEPROM_MAGIC;
-
-	first_word = eeprom->offset >> 1;
-	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
-	eeprom_buff = kmalloc_array(last_word - first_word + 1, sizeof(u16),
-				    GFP_KERNEL);
-	if (!eeprom_buff)
-		return -ENOMEM;
-
-	/* ax88179/178A returns 2 bytes from eeprom on read */
-	for (i = first_word; i <= last_word; i++) {
-		ret = __ax88179_read_cmd(dev, AX_ACCESS_EEPROM, i, 1, 2,
-					 &eeprom_buff[i - first_word]);
-		if (ret < 0) {
-			kfree(eeprom_buff);
-			return -EIO;
-		}
-	}
-
-	memcpy(data, (u8 *)eeprom_buff + (eeprom->offset & 1), eeprom->len);
-	kfree(eeprom_buff);
-	return 0;
-}
-
-static int
-ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
-		   u8 *data)
-{
-	struct usbnet *dev = netdev_priv(net);
-	u16 *eeprom_buff;
-	int first_word;
-	int last_word;
-	int ret;
-	int i;
-
-	netdev_dbg(net, "write EEPROM len %d, offset %d, magic 0x%x\n",
-		   eeprom->len, eeprom->offset, eeprom->magic);
-
-	if (eeprom->len == 0)
-		return -EINVAL;
-
-	if (eeprom->magic != AX88179_EEPROM_MAGIC)
-		return -EINVAL;
-
-	first_word = eeprom->offset >> 1;
-	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
-
-	eeprom_buff = kmalloc_array(last_word - first_word + 1, sizeof(u16),
-				    GFP_KERNEL);
-	if (!eeprom_buff)
-		return -ENOMEM;
-
-	/* align data to 16 bit boundaries, read the missing data from
-	   the EEPROM */
-	if (eeprom->offset & 1) {
-		ret = ax88179_read_cmd(dev, AX_ACCESS_EEPROM, first_word, 1, 2,
-				       &eeprom_buff[0]);
-		if (ret < 0) {
-			netdev_err(net, "Failed to read EEPROM at offset 0x%02x.\n", first_word);
-			goto free;
-		}
-	}
-
-	if ((eeprom->offset + eeprom->len) & 1) {
-		ret = ax88179_read_cmd(dev, AX_ACCESS_EEPROM, last_word, 1, 2,
-				       &eeprom_buff[last_word - first_word]);
-		if (ret < 0) {
-			netdev_err(net, "Failed to read EEPROM at offset 0x%02x.\n", last_word);
-			goto free;
-		}
-	}
-
-	memcpy((u8 *)eeprom_buff + (eeprom->offset & 1), data, eeprom->len);
-
-	for (i = first_word; i <= last_word; i++) {
-		netdev_dbg(net, "write to EEPROM at offset 0x%02x, data 0x%04x\n",
-			   i, eeprom_buff[i - first_word]);
-		ret = ax88179_write_cmd(dev, AX_ACCESS_EEPROM, i, 1, 2,
-					&eeprom_buff[i - first_word]);
-		if (ret < 0) {
-			netdev_err(net, "Failed to write EEPROM at offset 0x%02x.\n", i);
-			goto free;
-		}
-		msleep(20);
-	}
-
-	/* reload EEPROM data */
-	ret = ax88179_write_cmd(dev, AX_RELOAD_EEPROM_EFUSE, 0x0000, 0, 0, NULL);
-	if (ret < 0) {
-		netdev_err(net, "Failed to reload EEPROM data\n");
-		goto free;
-	}
-
-	ret = 0;
-free:
-	kfree(eeprom_buff);
-	return ret;
-}
-
 static int ax88179_get_link_ksettings(struct net_device *net,
 				      struct ethtool_link_ksettings *cmd)
 {
@@ -864,125 +403,6 @@ static const struct ethtool_ops ax88179_ethtool_ops = {
 	.get_ts_info		= ethtool_op_get_ts_info,
 };
 
-static void ax88179_set_multicast(struct net_device *net)
-{
-	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *data = dev->driver_priv;
-	u8 *m_filter = ((u8 *)dev->data);
-
-	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_IPE);
-
-	if (net->flags & IFF_PROMISC) {
-		data->rxctl |= AX_RX_CTL_PRO;
-	} else if (net->flags & IFF_ALLMULTI ||
-		   netdev_mc_count(net) > AX_MAX_MCAST) {
-		data->rxctl |= AX_RX_CTL_AMALL;
-	} else if (netdev_mc_empty(net)) {
-		/* just broadcast and directed */
-	} else {
-		/* We use dev->data for our 8 byte filter buffer
-		 * to avoid allocating memory that is tricky to free later
-		 */
-		u32 crc_bits;
-		struct netdev_hw_addr *ha;
-
-		memset(m_filter, 0, AX_MCAST_FLTSIZE);
-
-		netdev_for_each_mc_addr(ha, net) {
-			crc_bits = ether_crc(ETH_ALEN, ha->addr) >> 26;
-			*(m_filter + (crc_bits >> 3)) |= (1 << (crc_bits & 7));
-		}
-
-		ax88179_write_cmd_async(dev, AX_ACCESS_MAC, AX_MULFLTARY,
-					AX_MCAST_FLTSIZE, AX_MCAST_FLTSIZE,
-					m_filter);
-
-		data->rxctl |= AX_RX_CTL_AM;
-	}
-
-	ax88179_write_cmd_async(dev, AX_ACCESS_MAC, AX_RX_CTL,
-				2, 2, &data->rxctl);
-}
-
-static int
-ax88179_set_features(struct net_device *net, netdev_features_t features)
-{
-	u8 tmp;
-	struct usbnet *dev = netdev_priv(net);
-	netdev_features_t changed = net->features ^ features;
-
-	if (changed & NETIF_F_IP_CSUM) {
-		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, &tmp);
-		tmp ^= AX_TXCOE_TCP | AX_TXCOE_UDP;
-		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, &tmp);
-	}
-
-	if (changed & NETIF_F_IPV6_CSUM) {
-		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, &tmp);
-		tmp ^= AX_TXCOE_TCPV6 | AX_TXCOE_UDPV6;
-		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, &tmp);
-	}
-
-	if (changed & NETIF_F_RXCSUM) {
-		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, &tmp);
-		tmp ^= AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
-		       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
-		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, &tmp);
-	}
-
-	return 0;
-}
-
-static int ax88179_change_mtu(struct net_device *net, int new_mtu)
-{
-	struct usbnet *dev = netdev_priv(net);
-	u16 tmp16;
-
-	WRITE_ONCE(net->mtu, new_mtu);
-	dev->hard_mtu = net->mtu + net->hard_header_len;
-
-	if (net->mtu > 1500) {
-		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
-				 2, 2, &tmp16);
-		tmp16 |= AX_MEDIUM_JUMBO_EN;
-		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
-				  2, 2, &tmp16);
-	} else {
-		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
-				 2, 2, &tmp16);
-		tmp16 &= ~AX_MEDIUM_JUMBO_EN;
-		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
-				  2, 2, &tmp16);
-	}
-
-	/* max qlen depend on hard_mtu and rx_urb_size */
-	usbnet_update_max_qlen(dev);
-
-	return 0;
-}
-
-static int ax88179_set_mac_addr(struct net_device *net, void *p)
-{
-	struct usbnet *dev = netdev_priv(net);
-	struct sockaddr *addr = p;
-	int ret;
-
-	if (netif_running(net))
-		return -EBUSY;
-	if (!is_valid_ether_addr(addr->sa_data))
-		return -EADDRNOTAVAIL;
-
-	eth_hw_addr_set(net, addr->sa_data);
-
-	/* Set the MAC address */
-	ret = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN,
-				 ETH_ALEN, net->dev_addr);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static const struct net_device_ops ax88179_netdev_ops = {
 	.ndo_open		= usbnet_open,
 	.ndo_stop		= usbnet_stop,
@@ -1249,35 +669,6 @@ static int ax88179_led_setting(struct usbnet *dev)
 	return 0;
 }
 
-static void ax88179_get_mac_addr(struct usbnet *dev)
-{
-	u8 mac[ETH_ALEN];
-
-	memset(mac, 0, sizeof(mac));
-
-	/* Maybe the boot loader passed the MAC address via device tree */
-	if (!eth_platform_get_mac_address(&dev->udev->dev, mac)) {
-		netif_dbg(dev, ifup, dev->net,
-			  "MAC address read from device tree");
-	} else {
-		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN,
-				 ETH_ALEN, mac);
-		netif_dbg(dev, ifup, dev->net,
-			  "MAC address read from ASIX chip");
-	}
-
-	if (is_valid_ether_addr(mac)) {
-		eth_hw_addr_set(dev->net, mac);
-		if (!is_local_ether_addr(mac))
-			dev->net->addr_assign_type = NET_ADDR_PERM;
-	} else {
-		netdev_info(dev->net, "invalid MAC address, using random\n");
-	}
-
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN, ETH_ALEN,
-			  dev->net->dev_addr);
-}
-
 static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	struct ax88179_data *ax179_data;
@@ -1292,6 +683,7 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 		return -ENOMEM;
 
 	dev->driver_priv = ax179_data;
+	mutex_init(&ax179_data->medium_status_mutex);
 
 	dev->net->netdev_ops = &ax88179_netdev_ops;
 	dev->net->ethtool_ops = &ax88179_ethtool_ops;
@@ -1951,3 +1343,4 @@ module_usb_driver(ax88179_178a_driver);
 
 MODULE_DESCRIPTION("ASIX AX88179/178A based USB 3.0/2.0 Gigabit Ethernet Devices");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("ax88179_178a");
diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
new file mode 100644
index 0000000000000000000000000000000000000000..063427ff55e42e38be1acb66806c0cdbe8e84347
--- /dev/null
+++ b/drivers/net/usb/ax88179_lib.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ASIX AX88179/178A USB 3.0/2.0 to Gigabit Ethernet Devices
+ *
+ * Copyright (C) 2011-2013 ASIX
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/rtnetlink.h>
+#include "ax88179_lib.h"
+
+void ax88179_set_pm_mode(struct usbnet *dev, bool pm_mode)
+{
+	struct ax88179_data *ax179_data = dev->driver_priv;
+
+	ax179_data->in_pm = pm_mode;
+}
+
+static int ax88179_in_pm(struct usbnet *dev)
+{
+	struct ax88179_data *ax179_data = dev->driver_priv;
+
+	return ax179_data->in_pm;
+}
+
+int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
+		       u16 size, void *data)
+{
+	int (*fn)(struct usbnet *dev, u8 cmd, u8 rtype, u16 val, u16 i, void *d, u16 size);
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	int ret;
+
+	if (!ax88179_in_pm(dev))
+		fn = usbnet_read_cmd;
+	else
+		fn = usbnet_read_cmd_nopm;
+
+	ret = fn(dev, cmd, USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+		 value, index, data, size);
+
+	if (unlikely(ret < 0 && !(ret == -ENODEV && ax179_data->disconnecting)))
+		netdev_warn(dev->net, "Failed to read reg index 0x%04x: %d\n",
+			    index, ret);
+
+	return ret;
+}
+
+static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value,
+			       u16 index, u16 size, const void *data)
+{
+	int (*fn)(struct usbnet *dev, u8 cmd, u8 rtype, u16 val, u16 i, const void *d, u16 size);
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	int ret;
+
+	if (!ax88179_in_pm(dev))
+		fn = usbnet_write_cmd;
+	else
+		fn = usbnet_write_cmd_nopm;
+
+	ret = fn(dev, cmd, USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+		 value, index, data, size);
+
+	if (unlikely(ret < 0 && !(ret == -ENODEV && ax179_data->disconnecting)))
+		netdev_warn(dev->net, "Failed to write reg index 0x%04x: %d\n",
+			    index, ret);
+
+	return ret;
+}
+
+void ax88179_write_cmd_async(struct usbnet *dev, u8 cmd, u16 value,
+			     u16 index, u16 size, void *data)
+{
+	u16 buf;
+
+	if (size == 2) {
+		buf = *((u16 *)data);
+		cpu_to_le16s(&buf);
+		usbnet_write_cmd_async(dev, cmd, USB_DIR_OUT | USB_TYPE_VENDOR |
+				       USB_RECIP_DEVICE, value, index, &buf,
+				       size);
+	} else {
+		usbnet_write_cmd_async(dev, cmd, USB_DIR_OUT | USB_TYPE_VENDOR |
+				       USB_RECIP_DEVICE, value, index, data,
+				       size);
+	}
+}
+
+int ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
+		     u16 size, void *data)
+{
+	int ret;
+
+	if (size == 2) {
+		u16 buf = 0;
+
+		ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
+		le16_to_cpus(&buf);
+		*((u16 *)data) = buf;
+	} else if (size == 4) {
+		u32 buf = 0;
+
+		ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
+		le32_to_cpus(&buf);
+		*((u32 *)data) = buf;
+	} else {
+		ret = __ax88179_read_cmd(dev, cmd, value, index, size, data);
+	}
+
+	return ret;
+}
+
+int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
+		      u16 size, const void *data)
+{
+	int ret;
+
+	if (size == 2) {
+		u16 buf;
+
+		buf = *((u16 *)data);
+		cpu_to_le16s(&buf);
+		ret = __ax88179_write_cmd(dev, cmd, value, index,
+					  size, &buf);
+	} else {
+		ret = __ax88179_write_cmd(dev, cmd, value, index,
+					  size, data);
+	}
+
+	return ret;
+}
+
+void ax88179_status(struct usbnet *dev, struct urb *urb)
+{
+	struct ax88179_int_data *event;
+	u32 link;
+
+	if (urb->actual_length < 8)
+		return;
+
+	event = urb->transfer_buffer;
+	le32_to_cpus((void *)&event->intdata1);
+
+	link = (((__force u32)event->intdata1) & AX_INT_PPLS_LINK) >> 16;
+
+	if (netif_carrier_ok(dev->net) != link) {
+		usbnet_link_change(dev, link, 1);
+		if (!link)
+			netdev_info(dev->net, "ax88179 - Link status is: 0\n");
+	}
+}
+
+int ax88179_mdio_read(struct net_device *netdev, int phy_id, int loc)
+{
+	struct usbnet *dev = netdev_priv(netdev);
+	u16 res;
+
+	ax88179_read_cmd(dev, AX_ACCESS_PHY, phy_id, (__u16)loc, 2, &res);
+	return res;
+}
+
+void ax88179_mdio_write(struct net_device *netdev, int phy_id, int loc, int val)
+{
+	struct usbnet *dev = netdev_priv(netdev);
+	u16 res = (u16)val;
+
+	ax88179_write_cmd(dev, AX_ACCESS_PHY, phy_id, (__u16)loc, 2, &res);
+}
+
+void ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *priv = dev->driver_priv;
+
+	wolinfo->supported = priv->wol_supported;
+	wolinfo->wolopts = priv->wolopts;
+}
+
+int ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *priv = dev->driver_priv;
+
+	if (wolinfo->wolopts & ~(priv->wol_supported))
+		return -EINVAL;
+
+	priv->wolopts = wolinfo->wolopts;
+
+	return 0;
+}
+
+int ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8 *data)
+{
+	struct usbnet *dev = netdev_priv(net);
+	u16 *eeprom_buff;
+	int first_word, last_word;
+	int i, ret;
+
+	if (eeprom->len == 0)
+		return -EINVAL;
+
+	eeprom->magic = AX88179_EEPROM_MAGIC;
+
+	first_word = eeprom->offset >> 1;
+	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
+	eeprom_buff = kmalloc_array(last_word - first_word + 1, sizeof(u16),
+				    GFP_KERNEL);
+	if (!eeprom_buff)
+		return -ENOMEM;
+
+	/* ax88179/178A returns 2 bytes from eeprom on read */
+	for (i = first_word; i <= last_word; i++) {
+		ret = __ax88179_read_cmd(dev, AX_ACCESS_EEPROM, i, 1, 2,
+					 &eeprom_buff[i - first_word]);
+		if (ret < 0) {
+			kfree(eeprom_buff);
+			return -EIO;
+		}
+	}
+
+	memcpy(data, (u8 *)eeprom_buff + (eeprom->offset & 1), eeprom->len);
+	kfree(eeprom_buff);
+	return 0;
+}
+
+int ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8 *data)
+{
+	struct usbnet *dev = netdev_priv(net);
+	u16 *eeprom_buff;
+	int first_word;
+	int last_word;
+	int ret;
+	int i;
+
+	netdev_dbg(net, "write EEPROM len %d, offset %d, magic 0x%x\n",
+		   eeprom->len, eeprom->offset, eeprom->magic);
+
+	if (eeprom->len == 0)
+		return -EINVAL;
+
+	if (eeprom->magic != AX88179_EEPROM_MAGIC)
+		return -EINVAL;
+
+	first_word = eeprom->offset >> 1;
+	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
+
+	eeprom_buff = kmalloc_array(last_word - first_word + 1, sizeof(u16),
+				    GFP_KERNEL);
+	if (!eeprom_buff)
+		return -ENOMEM;
+
+	/* align data to 16 bit boundaries, read the missing data from
+	 * the EEPROM
+	 */
+	if (eeprom->offset & 1) {
+		ret = ax88179_read_cmd(dev, AX_ACCESS_EEPROM, first_word, 1, 2,
+				       &eeprom_buff[0]);
+		if (ret < 0) {
+			netdev_err(net, "Failed to read EEPROM at offset 0x%02x.\n", first_word);
+			goto free;
+		}
+	}
+
+	if ((eeprom->offset + eeprom->len) & 1) {
+		ret = ax88179_read_cmd(dev, AX_ACCESS_EEPROM, last_word, 1, 2,
+				       &eeprom_buff[last_word - first_word]);
+		if (ret < 0) {
+			netdev_err(net, "Failed to read EEPROM at offset 0x%02x.\n", last_word);
+			goto free;
+		}
+	}
+
+	memcpy((u8 *)eeprom_buff + (eeprom->offset & 1), data, eeprom->len);
+
+	for (i = first_word; i <= last_word; i++) {
+		netdev_dbg(net, "write to EEPROM at offset 0x%02x, data 0x%04x\n",
+			   i, eeprom_buff[i - first_word]);
+		ret = ax88179_write_cmd(dev, AX_ACCESS_EEPROM, i, 1, 2,
+					&eeprom_buff[i - first_word]);
+		if (ret < 0) {
+			netdev_err(net, "Failed to write EEPROM at offset 0x%02x.\n", i);
+			goto free;
+		}
+		msleep(20);
+	}
+
+	/* reload EEPROM data */
+	ret = ax88179_write_cmd(dev, AX_RELOAD_EEPROM_EFUSE, 0x0000, 0, 0, NULL);
+	if (ret < 0) {
+		netdev_err(net, "Failed to reload EEPROM data\n");
+		goto free;
+	}
+
+	ret = 0;
+free:
+	kfree(eeprom_buff);
+	return ret;
+}
+
+void ax88179_set_multicast(struct net_device *net)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data = dev->driver_priv;
+	u8 *m_filter = ((u8 *)dev->data);
+
+	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_IPE);
+
+	if (net->flags & IFF_PROMISC) {
+		data->rxctl |= AX_RX_CTL_PRO;
+	} else if (net->flags & IFF_ALLMULTI ||
+		   netdev_mc_count(net) > AX_MAX_MCAST) {
+		data->rxctl |= AX_RX_CTL_AMALL;
+	} else if (netdev_mc_empty(net)) {
+		/* just broadcast and directed */
+	} else {
+		/* We use dev->data for our 8 byte filter buffer
+		 * to avoid allocating memory that is tricky to free later
+		 */
+		u32 crc_bits;
+		struct netdev_hw_addr *ha;
+
+		memset(m_filter, 0, AX_MCAST_FLTSIZE);
+
+		netdev_for_each_mc_addr(ha, net) {
+			crc_bits = ether_crc(ETH_ALEN, ha->addr) >> 26;
+			*(m_filter + (crc_bits >> 3)) |= (1 << (crc_bits & 7));
+		}
+
+		ax88179_write_cmd_async(dev, AX_ACCESS_MAC, AX_MULFLTARY,
+					AX_MCAST_FLTSIZE, AX_MCAST_FLTSIZE,
+					m_filter);
+
+		data->rxctl |= AX_RX_CTL_AM;
+	}
+
+	ax88179_write_cmd_async(dev, AX_ACCESS_MAC, AX_RX_CTL,
+				2, 2, &data->rxctl);
+}
+
+int ax88179_set_features(struct net_device *net, netdev_features_t features)
+{
+	u8 tmp;
+	struct usbnet *dev = netdev_priv(net);
+	netdev_features_t changed = net->features ^ features;
+
+	if (changed & NETIF_F_IP_CSUM) {
+		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, &tmp);
+		tmp ^= AX_TXCOE_TCP | AX_TXCOE_UDP;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, &tmp);
+	}
+
+	if (changed & NETIF_F_IPV6_CSUM) {
+		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, &tmp);
+		tmp ^= AX_TXCOE_TCPV6 | AX_TXCOE_UDPV6;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, &tmp);
+	}
+
+	if (changed & NETIF_F_RXCSUM) {
+		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, &tmp);
+		tmp ^= AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
+		       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, &tmp);
+	}
+
+	return 0;
+}
+
+void ax88179_get_mac_addr(struct usbnet *dev)
+{
+	u8 mac[ETH_ALEN];
+
+	memset(mac, 0, sizeof(mac));
+
+	/* Maybe the boot loader passed the MAC address via device tree */
+	if (!eth_platform_get_mac_address(&dev->udev->dev, mac)) {
+		netif_dbg(dev, ifup, dev->net,
+			  "MAC address read from device tree");
+	} else {
+		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN,
+				 ETH_ALEN, mac);
+		netif_dbg(dev, ifup, dev->net,
+			  "MAC address read from ASIX chip");
+	}
+
+	if (is_valid_ether_addr(mac)) {
+		eth_hw_addr_set(dev->net, mac);
+		if (!is_local_ether_addr(mac))
+			dev->net->addr_assign_type = NET_ADDR_PERM;
+	} else {
+		netdev_info(dev->net, "invalid MAC address, using random\n");
+	}
+
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN, ETH_ALEN,
+			  dev->net->dev_addr);
+}
+
+int ax88179_change_mtu(struct net_device *net, int new_mtu)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data;
+	u16 tmp16;
+	int err;
+
+	data = dev->driver_priv;
+	mutex_lock(&data->medium_status_mutex);
+	WRITE_ONCE(net->mtu, new_mtu);
+	dev->hard_mtu = net->mtu + net->hard_header_len;
+	if (net->mtu > 1500) {
+		err = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
+				       2, 2, &tmp16);
+		if (err < 0)
+			goto err_out;
+		tmp16 |= AX_MEDIUM_JUMBO_EN;
+		err = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
+					2, 2, &tmp16);
+		if (err < 0)
+			goto err_out;
+	} else {
+		err = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
+				       2, 2, &tmp16);
+		if (err < 0)
+			goto err_out;
+		tmp16 &= ~AX_MEDIUM_JUMBO_EN;
+		err = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
+					2, 2, &tmp16);
+		if (err < 0)
+			goto err_out;
+	}
+	mutex_unlock(&data->medium_status_mutex);
+
+	/* max qlen depend on hard_mtu and rx_urb_size */
+	usbnet_update_max_qlen(dev);
+
+	return 0;
+
+err_out:
+	mutex_unlock(&data->medium_status_mutex);
+	return err;
+}
+
+int ax88179_set_mac_addr(struct net_device *net, void *p)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct sockaddr *addr = p;
+	int ret;
+
+	if (netif_running(net))
+		return -EBUSY;
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	eth_hw_addr_set(net, addr->sa_data);
+
+	/* Set the MAC address */
+	ret = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN,
+				ETH_ALEN, net->dev_addr);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
diff --git a/drivers/net/usb/ax88179_lib.h b/drivers/net/usb/ax88179_lib.h
new file mode 100644
index 0000000000000000000000000000000000000000..9111a1395eb2f7208c7e90c93027845423bbda00
--- /dev/null
+++ b/drivers/net/usb/ax88179_lib.h
@@ -0,0 +1,195 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <linux/usb.h>
+#include <linux/crc32.h>
+#include <linux/usb/usbnet.h>
+
+#ifndef __LINUX_USBNET_AX88179_H
+#define __LINUX_USBNET_AX88179_H
+
+#define AX88179_PHY_ID				0x03
+#define AX_EEPROM_LEN				0x100
+#define AX88179_EEPROM_MAGIC			0x17900b95
+#define AX_MCAST_FLTSIZE			8
+#define AX_MAX_MCAST				64
+#define AX_INT_PPLS_LINK			((u32)BIT(16))
+#define AX_RXHDR_L4_TYPE_MASK			0x1c
+#define AX_RXHDR_L4_TYPE_UDP			4
+#define AX_RXHDR_L4_TYPE_TCP			16
+#define AX_RXHDR_L3CSUM_ERR			2
+#define AX_RXHDR_L4CSUM_ERR			1
+#define AX_RXHDR_CRC_ERR			((u32)BIT(29))
+#define AX_RXHDR_DROP_ERR			((u32)BIT(31))
+#define AX_ACCESS_MAC				0x01
+#define AX_ACCESS_PHY				0x02
+#define AX_ACCESS_EEPROM			0x04
+#define AX_ACCESS_EFUS				0x05
+#define AX_RELOAD_EEPROM_EFUSE			0x06
+#define AX_PAUSE_WATERLVL_LOW			0x54
+#define AX_PAUSE_WATERLVL_HIGH			0x55
+
+#define PHYSICAL_LINK_STATUS			0x02
+	#define	AX_USB_SS		0x04
+	#define	AX_USB_HS		0x02
+
+#define GENERAL_STATUS				0x03
+/* Check AX88179 version. UA1:Bit2 = 0,  UA2:Bit2 = 1 */
+	#define	AX_SECLD		0x04
+
+#define AX_SROM_ADDR				0x07
+#define AX_SROM_CMD				0x0a
+	#define EEP_RD			0x04
+	#define EEP_BUSY		0x10
+
+#define AX_SROM_DATA_LOW			0x08
+#define AX_SROM_DATA_HIGH			0x09
+
+#define AX_RX_CTL				0x0b
+	#define AX_RX_CTL_DROPCRCERR	0x0100
+	#define AX_RX_CTL_IPE		0x0200
+	#define AX_RX_CTL_START		0x0080
+	#define AX_RX_CTL_AP		0x0020
+	#define AX_RX_CTL_AM		0x0010
+	#define AX_RX_CTL_AB		0x0008
+	#define AX_RX_CTL_AMALL		0x0002
+	#define AX_RX_CTL_PRO		0x0001
+	#define AX_RX_CTL_STOP		0x0000
+
+#define AX_NODE_ID				0x10
+#define AX_MULFLTARY				0x16
+
+#define AX_MEDIUM_STATUS_MODE			0x22
+	#define AX_MEDIUM_GIGAMODE	0x01
+	#define AX_MEDIUM_FULL_DUPLEX	0x02
+	#define AX_MEDIUM_EN_125MHZ	0x08
+	#define AX_MEDIUM_RXFLOW_CTRLEN	0x10
+	#define AX_MEDIUM_TXFLOW_CTRLEN	0x20
+	#define AX_MEDIUM_RECEIVE_EN	0x100
+	#define AX_MEDIUM_PS		0x200
+	#define AX_MEDIUM_JUMBO_EN	0x8040
+
+#define AX_MONITOR_MOD				0x24
+	#define AX_MONITOR_MODE_RWLC	0x02
+	#define AX_MONITOR_MODE_RWMP	0x04
+	#define AX_MONITOR_MODE_PMEPOL	0x20
+	#define AX_MONITOR_MODE_PMETYPE	0x40
+
+#define AX_GPIO_CTRL				0x25
+	#define AX_GPIO_CTRL_GPIO3EN	0x80
+	#define AX_GPIO_CTRL_GPIO2EN	0x40
+	#define AX_GPIO_CTRL_GPIO1EN	0x20
+
+#define AX_PHYPWR_RSTCTL			0x26
+	#define AX_PHYPWR_RSTCTL_BZ	0x0010
+	#define AX_PHYPWR_RSTCTL_IPRL	0x0020
+	#define AX_PHYPWR_RSTCTL_AT	0x1000
+
+#define AX_RX_BULKIN_QCTRL			0x2e
+#define AX_CLK_SELECT				0x33
+	#define AX_CLK_SELECT_BCS	0x01
+	#define AX_CLK_SELECT_ACS	0x02
+	#define AX_CLK_SELECT_ULR	0x08
+
+#define AX_RXCOE_CTL				0x34
+	#define AX_RXCOE_IP		0x01
+	#define AX_RXCOE_TCP		0x02
+	#define AX_RXCOE_UDP		0x04
+	#define AX_RXCOE_TCPV6		0x20
+	#define AX_RXCOE_UDPV6		0x40
+
+#define AX_TXCOE_CTL				0x35
+	#define AX_TXCOE_IP		0x01
+	#define AX_TXCOE_TCP		0x02
+	#define AX_TXCOE_UDP		0x04
+	#define AX_TXCOE_TCPV6		0x20
+	#define AX_TXCOE_UDPV6		0x40
+
+#define AX_LEDCTRL				0x73
+
+#define GMII_PHY_PHYSR				0x11
+	#define GMII_PHY_PHYSR_SMASK	0xc000
+	#define GMII_PHY_PHYSR_GIGA	0x8000
+	#define GMII_PHY_PHYSR_100	0x4000
+	#define GMII_PHY_PHYSR_FULL	0x2000
+	#define GMII_PHY_PHYSR_LINK	0x400
+
+#define GMII_LED_ACT				0x1a
+	#define	GMII_LED_ACTIVE_MASK	0xff8f
+	#define	GMII_LED0_ACTIVE	BIT(4)
+	#define	GMII_LED1_ACTIVE	BIT(5)
+	#define	GMII_LED2_ACTIVE	BIT(6)
+
+#define GMII_LED_LINK				0x1c
+	#define	GMII_LED_LINK_MASK	0xf888
+	#define	GMII_LED0_LINK_10	BIT(0)
+	#define	GMII_LED0_LINK_100	BIT(1)
+	#define	GMII_LED0_LINK_1000	BIT(2)
+	#define	GMII_LED1_LINK_10	BIT(4)
+	#define	GMII_LED1_LINK_100	BIT(5)
+	#define	GMII_LED1_LINK_1000	BIT(6)
+	#define	GMII_LED2_LINK_10	BIT(8)
+	#define	GMII_LED2_LINK_100	BIT(9)
+	#define	GMII_LED2_LINK_1000	BIT(10)
+	#define	LED0_ACTIVE		BIT(0)
+	#define	LED0_LINK_10		BIT(1)
+	#define	LED0_LINK_100		BIT(2)
+	#define	LED0_LINK_1000		BIT(3)
+	#define	LED0_FD			BIT(4)
+	#define	LED0_USB3_MASK		0x001f
+	#define	LED1_ACTIVE		BIT(5)
+	#define	LED1_LINK_10		BIT(6)
+	#define	LED1_LINK_100		BIT(7)
+	#define	LED1_LINK_1000		BIT(8)
+	#define	LED1_FD			BIT(9)
+	#define	LED1_USB3_MASK		0x03e0
+	#define	LED2_ACTIVE		BIT(10)
+	#define	LED2_LINK_1000		BIT(13)
+	#define	LED2_LINK_100		BIT(12)
+	#define	LED2_LINK_10		BIT(11)
+	#define	LED2_FD			BIT(14)
+	#define	LED_VALID		BIT(15)
+	#define	LED2_USB3_MASK		0x7c00
+
+#define GMII_PHYPAGE				0x1e
+#define GMII_PHY_PAGE_SELECT			0x1f
+	#define GMII_PHY_PGSEL_EXT	0x0007
+	#define GMII_PHY_PGSEL_PAGE0	0x0000
+	#define GMII_PHY_PGSEL_PAGE3	0x0003
+	#define GMII_PHY_PGSEL_PAGE5	0x0005
+
+struct ax88179_data {
+	struct mutex medium_status_mutex;  /* protect AX_MEDIUM_STATUS_MODE */
+	u8  eee_enabled;
+	u8  eee_active;
+	u16 rxctl;
+	u8 in_pm;
+	u32 wol_supported;
+	u32 wolopts;
+	u8 disconnecting;
+};
+
+struct ax88179_int_data {
+	__le32 intdata1;
+	__le32 intdata2;
+};
+
+void ax88179_set_pm_mode(struct usbnet *dev, bool pm_mode);
+int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index, u16 size, void *data);
+int ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index, u16 size, void *data);
+int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index, u16 size,
+		      const void *data);
+void ax88179_write_cmd_async(struct usbnet *dev, u8 cmd, u16 value, u16 index,
+			     u16 size, void *data);
+int ax88179_mdio_read(struct net_device *netdev, int phy_id, int loc);
+void ax88179_mdio_write(struct net_device *netdev, int phy_id, int loc, int val);
+void ax88179_status(struct usbnet *dev, struct urb *urb);
+void ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo);
+int ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo);
+int ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8 *data);
+int ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8 *data);
+void ax88179_set_multicast(struct net_device *net);
+int ax88179_set_features(struct net_device *net, netdev_features_t features);
+void ax88179_get_mac_addr(struct usbnet *dev);
+int ax88179_change_mtu(struct net_device *net, int new_mtu);
+int ax88179_set_mac_addr(struct net_device *net, void *p);
+#endif /*__LINUX_USBNET_AX88179_H */

-- 
2.47.3

