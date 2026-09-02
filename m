Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFDB4AA1F7;
	Wed,  2 Sep 2026 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368261; cv=none; b=DxftucHCYLDIenLXLpzx7daCgvnydz/RHUqCyx2qpdR9qgQjsbVK6DwLzV764cz3CLH/curwUts7YPgXT74UmtxlZ21juBWcUoXZYXfWyFLQR6hvIp63QdXDcmspYxA1gbzBJa4xEi/SDMQR6qvAuJ7iyYfBjxBggccJTBzUXhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368261; c=relaxed/simple;
	bh=KgVSO7DP4oF4aASyZU5688XSr5Qn+cr5c2IL4GWrSVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oVkjljtuATpSBQ81ByoGXhNpT4Tb4dXJGzRcvMgxaDrCAzsYTReBvNfRw/NQwwrp2h1sbg8wDjmYFj73evZSh16dtKkncTB/iv30K/TxWejWIQkjgLOWLzzzdZ5IvesCVqN36NUCjM0nfdXDoFZb3wOJsysvt+6KdP541p9ml4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=rIdSm6Pn; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=EEHlkqGx; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="rIdSm6Pn";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="EEHlkqGx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368256;
	bh=KgVSO7DP4oF4aASyZU5688XSr5Qn+cr5c2IL4GWrSVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rIdSm6PnGfHkOiYi3VVXCVYAqhZhgSk8QseVf+tOS1x1RTP3G4mEeRZPNgZ+755eX
	 sgSrVDhINugOAQfkLxfEv/O1wo3DgbzMKjEOwjK41CyULwhKpGBukiTx3QW1PY9Hx1
	 38YEOp3W8+xx35qCWuxU1+D0TeBWOQwerc6yjt30qOE28FzfR/ryo/QqM5ts6aQBe6
	 VazocIDw/HWJG/F0+9lfUQy9di9srWn14YOEmqpcMt+34BPwrvbqY+WX0PlEOte7lJ
	 4LYtS696keOLmpHBqJ1TtxhaqjIB/ZRr+rKhtXwD6pneFjEa7/cDZINOxUX/p6Poal
	 7RkcJ7zPMYt7A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 069453EF25; Wed,  2 Sep 2026 16:57:36 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368245;
	bh=KgVSO7DP4oF4aASyZU5688XSr5Qn+cr5c2IL4GWrSVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EEHlkqGxt559rGXIR7C3GRifc2oh6C3cTZx01bt0pnD7Jjduc80+zIyc9ylIDTNb1
	 r6R+GRBKsggiMECpgoXo1B5JtkowLPPTg6a+QOT8dXf4ZEoHyIY+HhsS7h4OTi1DFX
	 /y2CGA4Pd9qW6OcOLXUilIgPTuZjcxbq7eUlR8mVAViy8CWJg5OytsRg0IiLvLih0G
	 fi4ebzH8DQKXfJBVZYn4agUlDrag/1CC/z7fw2UyAn9KYVXCQ6UcSbulLPDRJodIGp
	 q1Xbz29seR5tLlLlhWfg+6Zu2ANqRHZBaBYX4Pza8uX0uiz+iRak26bli0qslI9ewO
	 vOjsnzelB2hUQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:c4e4:2069:f0cb:22e2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 104DB3EF1A;
	Wed,  2 Sep 2026 16:57:25 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 02 Sep 2026 18:57:20 +0200
Subject: [PATCH net-next v9 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ax88179a-v9-6-8e6d7710a2ae@birger-koblitz.de>
References: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
In-Reply-To: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

This adds bindings and HW support for AX179A-based USB-Ethernet
controllers. The AX179A-family of chips consists of the
AX88279 (2.5GBit PHY)
AX88179A/B (1GBit PHY, B variant has wider temperature range)
AX772D/E (100Mbit PHY)

The controllers all have the same vendor and device ID
(0x0b95, 0x1790) and are distinguished by their BCD device versions,
which are
2.00 AX88179A/B
3.00 AX88772D/E
4.00 AX88279

For all chips, the driver calls the same ax88179a_bind() function
and the chips are then distinguished by the chip version and
BCD device ID. The AX179A-based chips all provide both a CDC-NCM
compatible USB interface, and a proprietary vendor interface. By default,
the proprietary vendor interface is not active and Linux will load the
CDC-NCM driver to support the devices. If the ax88179_178a module is
configured by the OS to have precedence over CDC-NCM, then this driver
will switch the device to use the vendor interface, and the device will
be controlled by the ax88179_178a driver when the device is probed again
after an automatic reset by the device.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 MAINTAINERS                        |   6 +
 drivers/net/usb/Kconfig            |   2 +-
 drivers/net/usb/Makefile           |   2 +-
 drivers/net/usb/ax88179_178a.c     |  12 +
 drivers/net/usb/ax88179_lib.h      | 159 ++++++
 drivers/net/usb/ax88179a_devices.c | 962 +++++++++++++++++++++++++++++++++++++
 6 files changed, 1141 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b42e898f4d8e4892e943bb3db839ff9afcd3569..442e8ea3ca04e41037021fe04570549ecdde49ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4020,6 +4020,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/asix,ax88796c.yaml
 F:	drivers/net/ethernet/asix/ax88796c_*
 
+ASIX AX88179 USB ETHERNET DRIVER
+M:	Birger Koblitz <mail@birger-koblitz.de>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/usb/ax88179*
+
 ASIX PHY DRIVER [RUST]
 M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
 R:	Trevor Gross <tmgross@umich.edu>
diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 52a5c0922c79fc52906d4d4040ec2b3411ff0984..115990b0d9537aea2776544c9768b034f32aa7a4 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -199,7 +199,7 @@ config USB_NET_AX88179_178A
 	tristate "ASIX AX88179/178A USB 3.0/2.0 to Gigabit Ethernet"
 	depends on USB_USBNET
 	select CRC32
-	select PHYLIB
+	select PHYLINK
 	default y
 	help
 	  This option adds support for ASIX AX88179 based USB 3.0/2.0
diff --git a/drivers/net/usb/Makefile b/drivers/net/usb/Makefile
index ddd76fa71e2ee670888df1c9715632e5c04a8149..2ecead0181eaf8d66fb6f5dbd6f2905b22b6eb57 100644
--- a/drivers/net/usb/Makefile
+++ b/drivers/net/usb/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_USB_LAN78XX)	+= lan78xx.o
 obj-$(CONFIG_USB_NET_AX8817X)	+= asix.o
 asix-y := asix_devices.o asix_common.o ax88172a.o
 obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179.o
-ax88179-y := ax88179_178a.o ax88179_lib.o
+ax88179-y := ax88179_178a.o ax88179a_devices.o ax88179_lib.o
 obj-$(CONFIG_USB_NET_CDCETHER)	+= cdc_ether.o
 obj-$(CONFIG_USB_NET_CDC_EEM)	+= cdc_eem.o
 obj-$(CONFIG_USB_NET_DM9601)	+= dm9601.o
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 6aa35c8eb594fda38f7680f8801f0d82090c1efd..33be9ef73e73dd550402692e96605d22c481c7ec 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1270,6 +1270,18 @@ static const struct driver_info at_umc2000sp_info = {
 
 static const struct usb_device_id products[] = {
 {
+	/* ASIX AX88179A USB 3.2 1000Mbit Ethernet */
+	USB_DEVICE_VER(0x0b95, 0x1790, 0, 0x0200),
+	.driver_info = (unsigned long)&ax88179a_info,
+}, {
+	/* ASIX AX88772D USB 2.0 100Mbit Ethernet */
+	USB_DEVICE_VER(0x0b95, 0x1790, 0x0300, 0x0300),
+	.driver_info = (unsigned long)&ax88772d_info,
+}, {
+	/* ASIX AX88279 USB 3.2 2500Mbit Ethernet */
+	USB_DEVICE_VER(0x0b95, 0x1790, 0, 0x0400),
+	.driver_info = (unsigned long)&ax88279_info,
+}, {
 	/* ASIX AX88179 10/100/1000 */
 	USB_DEVICE_AND_INTERFACE_INFO(0x0b95, 0x1790, 0xff, 0xff, 0),
 	.driver_info = (unsigned long)&ax88179_info,
diff --git a/drivers/net/usb/ax88179_lib.h b/drivers/net/usb/ax88179_lib.h
index 9ff2a94a6fb2de4ee85f25e913ae2fe263bcea7c..2e4d35c74ee8b32cd2916924b85d5427860bb08c 100644
--- a/drivers/net/usb/ax88179_lib.h
+++ b/drivers/net/usb/ax88179_lib.h
@@ -2,6 +2,7 @@
 
 #include <linux/usb.h>
 #include <linux/crc32.h>
+#include <linux/phylink.h>
 #include <linux/usb/usbnet.h>
 
 #ifndef __LINUX_USBNET_AX88179_H
@@ -25,17 +26,34 @@
 #define AX_ACCESS_EEPROM			0x04
 #define AX_ACCESS_EFUS				0x05
 #define AX_RELOAD_EEPROM_EFUSE			0x06
+#define AX88179A_WAKEUP_SETTING			0x07
+#define AX_FW_MODE				0x08
+#define AX_GPHY_CTL				0x0F
+#define AX88179A_FLASH_READ			0x21
+#define AX88179A_FLASH_WEN			0x22
+#define AX88179A_FLASH_WDIS			0x23
+#define AX88179A_FLASH_WRITE			0x24
+#define AX88179A_PHY_CLAUSE45			0x27
+#define AX88179A_FLASH_ERASE_SECTION		0x28
+#define AX88179A_ACCESS_BL			0x2A
+#define AX88179A_PHY_POWER			0x31
+#define AX88179A_AUTODETACH			0xC0
+
 #define AX_PAUSE_WATERLVL_LOW			0x54
 #define AX_PAUSE_WATERLVL_HIGH			0x55
 
+#define AX_FW_MODE_179A				0x01
 #define PHYSICAL_LINK_STATUS			0x02
 	#define	AX_USB_SS		0x04
 	#define	AX_USB_HS		0x02
+	#define AX_USB_FS		0x01
 
 #define GENERAL_STATUS				0x03
 /* Check AX88179 version. UA1:Bit2 = 0,  UA2:Bit2 = 1 */
 	#define	AX_SECLD		0x04
 
+#define AX_CHIP_STATUS				0x05
+
 #define AX_SROM_ADDR				0x07
 #define AX_SROM_CMD				0x0a
 	#define EEP_RD			0x04
@@ -55,6 +73,15 @@
 	#define AX_RX_CTL_PRO		0x0001
 	#define AX_RX_CTL_STOP		0x0000
 
+#define AX88179A_ETH_TX_GAP			0x0D
+
+#define AX88179A_BFM_DATA			0x0E
+	#define AX_TX_QUEUE_CFG		0x02
+	#define AX_TX_QUEUE_SET		0x08
+	#define AX_TX_Q1_AHB_FC_EN	0x10
+	#define AX_TX_Q2_AHB_FC_EN	0x20
+	#define AX_XGMII_EN		0x80
+
 #define AX_NODE_ID				0x10
 #define AX_MULFLTARY				0x16
 
@@ -84,7 +111,20 @@
 	#define AX_PHYPWR_RSTCTL_IPRL	0x0020
 	#define AX_PHYPWR_RSTCTL_AT	0x1000
 
+#define AX88179A_VLAN_ID_ADDRESS		0x2A
+
+#define AX88179A_VLAN_ID_CONTROL		0x2B
+	#define AX_VLAN_CONTROL_WE	0x0001
+	#define AX_VLAN_CONTROL_RD	0x0002
+	#define AX_VLAN_CONTROL_VSO	0x0010
+	#define AX_VLAN_CONTROL_VFE	0x0020
+
+#define AX88179A_VLAN_ID_DATA0			0x2C
+#define AX88179A_VLAN_ID_DATA1			0x2D
+
 #define AX_RX_BULKIN_QCTRL			0x2e
+#define AX_GPHY_EEE_CTRL			0x01
+
 #define AX_CLK_SELECT				0x33
 	#define AX_CLK_SELECT_BCS	0x01
 	#define AX_CLK_SELECT_ACS	0x02
@@ -104,7 +144,51 @@
 	#define AX_TXCOE_TCPV6		0x20
 	#define AX_TXCOE_UDPV6		0x40
 
+#define AX88179A_MAC_BM_INT_MASK		0x41
+#define AX88179A_MAC_BM_RX_DMA_CTL		0x43
+#define AX88179A_MAC_BM_TX_DMA_CTL		0x46
+
+#define AX88179A_MAC_RX_STATUS_CDC		0x6D
+	#define AX_LSOFC_WCNT_7_ACCESS	0x03
+	#define AX_GMII_CRC_APPEND	0x10
+
 #define AX_LEDCTRL				0x73
+#define AX88179A_MAC_ARC_CTRL			0x9E
+#define AX88179A_MAC_SWP_CTRL			0xB1
+
+#define AX88179A_MAC_TX_PAUSE			0xB2
+
+#define AX88179A_MAC_CDC_DELAY_TX		0xB5
+
+#define AX88179A_MAC_PATH			0xB7
+	#define AX_MAC_RX_PATH_READY	0x01
+	#define AX_MAC_TX_PATH_READY	0x02
+
+#define AX88179A_NEW_PAUSE_CTRL			0xB8
+	#define AX_NEW_PAUSE_EN		0x01
+
+#define AX88179A_MAC_BULK_OUT_CTRL		0xB9
+	#define AX_MAC_EFF_EN		0x02
+
+#define AX88179A_MAC_RX_DATA_CDC_CNT		0xC0
+	#define AX_MAC_LSO_ERR_EN	0x04
+	#define AX_MAC_MIQFFCTRL_FORMAT	0x10
+	#define AX_MAC_MIQFFCTRL_DROP_CRC 0x20
+
+#define AX88179A_AUTODETACH_DELAY	(5UL << 8)
+#define AX88179A_AUTODETACH_EN		1
+
+#define AX88179A_MAC_LSO_ENHANCE_CTRL		0xC3
+	#define AX_LSO_ENHANCE_EN	0x01
+
+#define AX88179A_MAC_TX_HDR_CKSUM		0xCC
+#define AX88179A_EP5_EHR			0xF9
+
+#define AX_PHY_POWER				0x02
+
+#define EPHY_LOW_POWER_EN			0x01
+#define S5_WOL_EN				0x04
+#define S5_WOL_LOW_POWER			0x20
 
 #define GMII_PHY_PHYSR				0x11
 	#define GMII_PHY_PHYSR_SMASK	0xc000
@@ -157,6 +241,56 @@
 	#define GMII_PHY_PGSEL_PAGE3	0x0003
 	#define GMII_PHY_PGSEL_PAGE5	0x0005
 
+/* TX Descriptor */
+#define AX179A_TX_DESC_LEN_MASK		0x1FFFFF
+#define AX179A_TX_DESC_DROP_PADD	BIT(28)
+#define AX179A_TX_DESC_VLAN		BIT(29)
+#define AX179A_TX_DESC_MSS_MASK		0x7FFF
+#define AX179A_TX_DESC_MSS_SHIFT	0x20
+#define AX179A_TX_DESC_VLAN_MASK	0xFFFF
+#define AX179A_TX_DESC_VLAN_SHIFT	0x30
+
+/* RX Packet Descriptor */
+#define AX179A_RX_PD_L4_ERR		BIT(0)
+#define AX179A_RX_PD_L3_ERR		BIT(1)
+#define AX179A_RX_PD_L4_TYPE_MASK	0x1C
+#define AX179A_RX_PD_L4_UDP		0x04
+#define AX179A_RX_PD_L4_TCP		0x10
+#define AX179A_RX_PD_L3_TYPE_MASK	0x60
+#define AX179A_RX_PD_L3_IP		0x20
+#define AX179A_RX_PD_L3_IP6		0x40
+
+#define AX179A_RX_PD_VLAN		BIT(10)
+#define AX179A_RX_PD_RX_OK		BIT(11)
+#define AX179A_RX_PD_DROP		BIT(31)
+#define AX179A_RX_PD_LEN_MASK	0x7FFF0000
+#define AX179A_RX_PD_LEN_SHIFT	0x10
+#define AX179A_RX_PD_VLAN_SHIFT	0x20
+
+/* RX Descriptor header */
+#define AX179A_RX_DH_PKT_CNT_MASK		0x1FFF
+#define AX179A_RX_DH_DESC_OFFSET_MASK	0xFFFFE000
+#define AX179A_RX_DH_DESC_OFFSET_SHIFT	0x0D
+
+#define AX179A_RX_HW_PAD			0x02
+
+#define AX_ADVERTISE_2500		0x1000
+
+enum ax_ether_link_speed {
+	ETHER_LINK_NONE = 0,
+	ETHER_LINK_10   = 1,
+	ETHER_LINK_100  = 2,
+	ETHER_LINK_1000 = 3,
+	ETHER_LINK_2500 = 4,
+};
+
+enum ax_chip_version {
+	AX_VERSION_INVALID		= 0x0,
+	AX_VERSION_AX88179		= 0x4,
+	AX_VERSION_AX88179A		= 0x6,	/* Also AX88772D */
+	AX_VERSION_AX88279		= 0x7,
+};
+
 struct ax88179_data {
 	u8  eee_enabled;
 	u8  eee_active;
@@ -165,6 +299,22 @@ struct ax88179_data {
 	u32 wol_supported;
 	u32 wolopts;
 	u8 disconnecting;
+	u8 chip_version;
+	u8 fw_version[4];
+	u8 is_ax88772d;
+	u8 ip_align;
+	u8 link;
+	u8 speed;
+	u8 full_duplex;
+	u8 rx_checksum;
+	u8 eeprom_read_cmd;
+	u8 eeprom_write_cmd;
+	u8 eeprom_wen;
+	u16 eeprom_block;
+	struct mii_bus *mdio;
+	struct phy_device *phydev;
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
 };
 
 struct ax88179_int_data {
@@ -172,6 +322,10 @@ struct ax88179_int_data {
 	__le32 intdata2;
 };
 
+struct ax_bulkin_settings {
+	unsigned char ctrl, timer_l, timer_h, size, ifg;
+};
+
 void ax88179_set_pm_mode(struct usbnet *dev, bool pm_mode);
 int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index, u16 size, void *data);
 int ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index, u16 size, void *data);
@@ -192,4 +346,9 @@ int ax88179_set_features(struct net_device *net, netdev_features_t features);
 void ax88179_get_mac_addr(struct usbnet *dev);
 int ax88179_change_mtu(struct net_device *net, int new_mtu);
 int ax88179_set_mac_addr(struct net_device *net, void *p);
+
+extern const struct driver_info ax88179a_info;
+extern const struct driver_info ax88772d_info;
+extern const struct driver_info ax88279_info;
+
 #endif /*__LINUX_USBNET_AX88179_H */
diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
new file mode 100644
index 0000000000000000000000000000000000000000..57fc70ad704ae6b31c4addc9e8701ee4a7fef1dd
--- /dev/null
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -0,0 +1,962 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/module.h>
+#include <linux/phylink.h>
+#include <linux/if_vlan.h>
+#include "ax88179_lib.h"
+
+#define AX88279_EEPROM_LEN			0x4000
+#define AX88179A_EEPROM_LEN			(32 * 20)
+
+enum ax_bulk_in_speeds {
+	BULK_IN_SPEED_2G5 = 0,
+	BULK_IN_SPEED_1G_SS = 1,
+	BULK_IN_SPEED_1G_HS   = 2,
+	BULK_IN_SPEED_100_FULL_SS = 3,
+	BULK_IN_SPEED_100_HALF_SS = 4,
+	BULK_IN_SPEED_100_FULL_HS = 5,
+	BULK_IN_SPEED_100_HALF_HS = 6,
+	BULK_IN_SPEED_FS = 7,
+};
+
+static const struct ax_bulkin_settings AX88179A_BULKIN_SIZE[] = {
+	[BULK_IN_SPEED_1G_SS]		= {5, 0x7B, 0x00, 0x17, 0x0F},
+	[BULK_IN_SPEED_1G_HS]		= {5, 0xC0, 0x02, 0x06, 0x0F},
+	[BULK_IN_SPEED_100_FULL_SS]	= {7, 0xF0, 0x00, 0x0C, 0x0F},
+	[BULK_IN_SPEED_100_HALF_SS]	= {6, 0x00, 0x00, 0x06, 0x0F},
+	[BULK_IN_SPEED_100_FULL_HS]	= {5, 0xC0, 0x04, 0x06, 0x0F},
+	[BULK_IN_SPEED_100_HALF_HS]	= {7, 0xC0, 0x04, 0x06, 0x0F},
+	[BULK_IN_SPEED_FS]		= {7, 0x00, 0x00, 0x03, 0x3F},
+};
+
+static const struct ax_bulkin_settings AX88772D_BULKIN_SIZE[] = {
+	[BULK_IN_SPEED_100_FULL_HS]	= {5, 0xC0, 0x04, 0x06, 0x0F},
+	[BULK_IN_SPEED_100_HALF_HS]	= {7, 0xC0, 0x04, 0x06, 0x0F},
+	[BULK_IN_SPEED_FS]		= {7, 0x00, 0x00, 0x03, 0x3F},
+};
+
+static const struct ax_bulkin_settings AX88279_BULKIN_SIZE[] = {
+	[BULK_IN_SPEED_2G5]		= {5, 0x10, 0x01, 0x11, 0x0F},
+	[BULK_IN_SPEED_1G_SS]		= {7, 0xB3, 0x01, 0x11, 0x0F},
+	[BULK_IN_SPEED_1G_HS]		= {7, 0xC0, 0x02, 0x06, 0x0F},
+	[BULK_IN_SPEED_100_FULL_SS]	= {7, 0x80, 0x01, 0x03, 0x0F},
+	[BULK_IN_SPEED_100_HALF_SS]	= {7, 0x80, 0x01, 0x03, 0x0F},
+	[BULK_IN_SPEED_100_FULL_HS]	= {7, 0x80, 0x01, 0x03, 0x0F},
+	[BULK_IN_SPEED_100_HALF_HS]	= {7, 0x80, 0x01, 0x03, 0x0F},
+	[BULK_IN_SPEED_FS]		= {7, 0x00, 0x00, 0x03, 0x3F},
+};
+
+static int ax88179_mdiobus_read(struct mii_bus *bus, int phy_id, int regnum)
+{
+	struct usbnet *dev = bus->priv;
+	struct ax88179_data *priv;
+	u16 res;
+
+	priv = dev->driver_priv;
+	/* When reading PHYSID, return unused PHY-IDs from the ASIX vendor range */
+	if (phy_id == AX88179_PHY_ID && regnum == MII_PHYSID1)
+		return 0x003b;
+	if (phy_id == AX88179_PHY_ID && regnum == MII_PHYSID2) {
+		if (priv->chip_version == AX_VERSION_AX88179A && priv->is_ax88772d)
+			return 0x772d;
+		else if (priv->chip_version == AX_VERSION_AX88179A)
+			return 0x179a;
+		else if (priv->chip_version == AX_VERSION_AX88279)
+			return 0x2790;
+	}
+
+	ax88179_read_cmd(dev, AX_ACCESS_PHY, phy_id, (__u16)regnum, 2, &res);
+	return res;
+}
+
+static int ax88179_mdiobus_write(struct mii_bus *bus, int phy_id, int regnum, u16 val)
+{
+	struct usbnet *dev = bus->priv;
+
+	return ax88179_write_cmd(dev, AX_ACCESS_PHY, phy_id, (__u16)regnum, 2, &val);
+}
+
+static int ax179a_read_mmd(struct usbnet *dev, u16 dev_addr, u16 reg)
+{
+	u16 res;
+	int ret;
+
+	ret = ax88179_read_cmd(dev, AX88179A_PHY_CLAUSE45, dev_addr, reg, 2, &res);
+	if (ret < 0)
+		return ret;
+	return res;
+}
+
+static int ax179a_write_mmd(struct usbnet *dev, u16 dev_addr, u16 reg, u16 data)
+{
+	return ax88179_write_cmd(dev, AX88179A_PHY_CLAUSE45, dev_addr, reg, 2, &data);
+}
+
+static int ax88179_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum, int regnum)
+{
+	struct usbnet *dev = bus->priv;
+
+	if (addr != AX88179_PHY_ID)
+		return -EINVAL;
+
+	return ax179a_read_mmd(dev, devnum, regnum);
+}
+
+static int ax88179_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
+				     int regnum, u16 val)
+{
+	struct usbnet *dev = bus->priv;
+
+	if (addr != AX88179_PHY_ID)
+		return -EINVAL;
+
+	return ax179a_write_mmd(dev, devnum, regnum, val);
+}
+
+static void ax88179a_status(struct usbnet *dev, struct urb *urb)
+{
+	if (urb->actual_length < 8)
+		return;
+
+	phylink_mac_interrupt(data->phylink);
+}
+
+static int ax88179a_auto_detach(struct usbnet *dev)
+{
+	u16 tmp16;
+
+	tmp16 = AX88179A_AUTODETACH_DELAY;
+	ax88179_write_cmd(dev, AX88179A_AUTODETACH, tmp16, 0, 0, NULL);
+	return 0;
+}
+
+static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts, u8 speed, bool full_duplex)
+{
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	const struct ax_bulkin_settings *bulkin_data;
+	int index = 0;
+
+	switch (speed) {
+	case ETHER_LINK_2500:	/* AX88279 only */
+		index = BULK_IN_SPEED_2G5;
+		break;
+
+	case ETHER_LINK_1000:	/* AX88279 & AX88178A */
+		if (link_sts & AX_USB_SS)
+			index = BULK_IN_SPEED_1G_SS;
+		else if (link_sts & AX_USB_HS)
+			index = BULK_IN_SPEED_1G_HS;
+		break;
+
+	case ETHER_LINK_100:
+		if (link_sts & AX_USB_SS)
+			index = BULK_IN_SPEED_100_FULL_SS;
+		else if (link_sts & AX_USB_HS)
+			index = BULK_IN_SPEED_100_FULL_HS;
+		if (!full_duplex)
+			index++;
+		break;
+
+	case ETHER_LINK_10:
+		index = BULK_IN_SPEED_FS;
+		break;
+
+	default:	/* No link */
+		index = BULK_IN_SPEED_FS;
+	}
+
+	if (ax179_data->chip_version == AX_VERSION_AX88279 && (link_sts & AX_USB_FS))
+		index = BULK_IN_SPEED_FS;
+
+	if (ax179_data->chip_version == AX_VERSION_AX88279) {
+		bulkin_data = AX88279_BULKIN_SIZE;
+	} else {
+		if (ax179_data->is_ax88772d)
+			bulkin_data = AX88772D_BULKIN_SIZE;
+		else
+			bulkin_data = AX88179A_BULKIN_SIZE;
+	}
+
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, &bulkin_data[index]);
+}
+
+static void ax88179a_get_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
+{
+	struct ax88179_data *data = netdev2data(net);
+
+	phylink_ethtool_get_pauseparam(data->phylink, pause);
+}
+
+static int ax88179a_set_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
+{
+	struct ax88179_data *data = netdev2data(net);
+
+	return phylink_ethtool_set_pauseparam(data->phylink, pause);
+}
+
+static int ax88179a_get_eeprom_len(struct net_device *net)
+{
+	struct ax88179_data *ax179_data = netdev2data(net);
+
+	if (ax179_data->chip_version >= AX_VERSION_AX88279)
+		return AX88279_EEPROM_LEN;
+	else
+		return AX88179A_EEPROM_LEN;
+}
+
+static const struct ethtool_ops ax88179a_ethtool_ops = {
+	.get_link		= ethtool_op_get_link,
+	.get_msglevel		= usbnet_get_msglevel,
+	.set_msglevel		= usbnet_set_msglevel,
+	.get_wol		= ax88179_get_wol,
+	.set_wol		= ax88179_set_wol,
+	.get_eeprom_len		= ax88179a_get_eeprom_len,
+	.get_eeprom		= ax88179_get_eeprom,
+	.set_eeprom		= ax88179_set_eeprom,
+	.nway_reset		= usbnet_nway_reset,
+	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
+	.get_pauseparam		= ax88179a_get_pauseparam,
+	.set_pauseparam		= ax88179a_set_pauseparam,
+	.get_ts_info		= ethtool_op_get_ts_info,
+};
+
+static void ax88179a_mdio_unregister(struct ax88179_data *data)
+{
+	mdiobus_unregister(data->mdio);
+	mdiobus_free(data->mdio);
+}
+
+static int ax88179a_init_phy(struct usbnet *dev)
+{
+	struct ax88179_data *data = dev->driver_priv;
+	int ret;
+
+	data->phydev = mdiobus_get_phy(data->mdio, AX88179_PHY_ID);
+	if (!data->phydev) {
+		netdev_err(dev->net, "Could not find PHY\n");
+		return -ENODEV;
+	}
+
+	data->phydev->irq = PHY_MAC_INTERRUPT;
+	ret = phylink_connect_phy(data->phylink, data->phydev);
+	if (ret) {
+		netdev_err(dev->net, "Could not connect PHY\n");
+		return ret;
+	}
+
+	phy_suspend(data->phydev);
+	data->phydev->mac_managed_pm = true;
+
+	phy_attached_info(data->phydev);
+
+	return 0;
+}
+
+static void ax88179a_mac_config(struct phylink_config *config, unsigned int mode,
+				const struct phylink_link_state *state)
+{
+	/* Nothing to do */
+}
+
+static void ax88179a_mac_link_down(struct phylink_config *config,
+				   unsigned int mode, phy_interface_t interface)
+{
+	/* Nothing to do */
+}
+
+static void ax88179a_mac_link_up(struct phylink_config *config,
+				 struct phy_device *phy,
+				 unsigned int phy_mode, phy_interface_t interface,
+				 int speed, int duplex,
+				 bool tx_pause, bool rx_pause)
+{
+	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	u8 tmp8, link_sts, reg8[3];
+	u8 bulk_config_speed = 0;
+	u16 tmp16, mode;
+
+	/* Stop RX/TX for link configuration */
+	tmp16 = AX_RX_CTL_STOP;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);
+	tmp8 = 0;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 1, &tmp8);
+
+	tmp8 = 0xa5;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_CDC_DELAY_TX, 1, 1, &tmp8);
+
+	tmp16 = 0x0410;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 2, 2, &tmp16);
+
+	tmp8 = 0;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_ETH_TX_GAP, 1, 1, &tmp8);
+
+	tmp8 = 0x07;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_EP5_EHR, 1, 1, &tmp8);
+
+	tmp8 = 0x28 | AX_NEW_PAUSE_EN;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_NEW_PAUSE_CTRL, 1, 1, &tmp8);
+
+	mode = AX_MEDIUM_RECEIVE_EN;
+	if (tx_pause)
+		mode |= AX_MEDIUM_TXFLOW_CTRLEN;
+	if (rx_pause)
+		mode |= AX_MEDIUM_RXFLOW_CTRLEN;
+
+	switch (speed) {
+	case SPEED_2500:
+		reg8[0] = 0x00;
+		reg8[1] = 0xF8;
+		reg8[2] = 0x07;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_TX_PAUSE, 3, 3, reg8);
+
+		reg8[0] = 0x78;
+		reg8[1] = (AX_LSOFC_WCNT_7_ACCESS << 5);
+		reg8[2] = 0;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_STATUS_CDC, 3, 3, reg8);
+
+		reg8[0] = 0x40;
+		reg8[1] = AX_MAC_MIQFFCTRL_FORMAT | AX_MAC_MIQFFCTRL_DROP_CRC | AX_MAC_LSO_ERR_EN;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 2, 2, reg8);
+
+		tmp8 = AX_XGMII_EN;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_BFM_DATA, 1, 1, &tmp8);
+
+		tmp8 = 0x1C | AX_LSO_ENHANCE_EN;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_LSO_ENHANCE_CTRL, 1, 1, &tmp8);
+
+		mode |= AX_MEDIUM_GIGAMODE | AX_MEDIUM_FULL_DUPLEX;
+		bulk_config_speed = ETHER_LINK_2500;
+
+		break;
+
+	case SPEED_1000:
+		mode |= AX_MEDIUM_GIGAMODE;
+		bulk_config_speed = ETHER_LINK_1000;
+		fallthrough;
+
+	case SPEED_100:
+		reg8[0] = 0x78;
+		reg8[1] = (AX_LSOFC_WCNT_7_ACCESS << 5) | AX_GMII_CRC_APPEND;
+		reg8[2] = 0;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_STATUS_CDC, 3, 3, reg8);
+
+		tmp8 = 0x40;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 1, &tmp8);
+		if (!bulk_config_speed)
+			bulk_config_speed = ETHER_LINK_100;
+		break;
+
+	case SPEED_10:
+		reg8[0] = 0xFA;
+		reg8[1] = (AX_LSOFC_WCNT_7_ACCESS << 5) | AX_GMII_CRC_APPEND;
+		reg8[2] = 0xFF;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_STATUS_CDC, 3, 3, reg8);
+
+		tmp8 = 0xFA;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 1, &tmp8);
+
+		bulk_config_speed = ETHER_LINK_10;
+		break;
+	}
+
+	ax88179_read_cmd(dev, AX_ACCESS_MAC, PHYSICAL_LINK_STATUS, 1, 1, &link_sts);
+	ax88179a_bulkin_config(dev, link_sts, bulk_config_speed, !!duplex);
+
+	if (ax179_data->chip_version < AX_VERSION_AX88279) {
+		tmp8 = 0;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_BFM_DATA, 1, 1, &tmp8);
+	}
+
+	if (duplex)
+		mode |= AX_MEDIUM_FULL_DUPLEX;
+
+	if (dev->net->mtu > 1500)
+		mode |= AX_MEDIUM_JUMBO_EN;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &mode);
+
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &ax179_data->rxctl);
+
+	tmp8 = AX_MAC_RX_PATH_READY | AX_MAC_TX_PATH_READY;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 1, &tmp8);
+}
+
+static const struct phylink_mac_ops ax88179a_phylink_mac_ops = {
+	.mac_config = ax88179a_mac_config,
+	.mac_link_down = ax88179a_mac_link_down,
+	.mac_link_up = ax88179a_mac_link_up,
+};
+
+static int ax88179a_phylink_setup(struct usbnet *dev)
+{
+	struct ax88179_data *data = dev->driver_priv;
+	phy_interface_t phy_if_mode;
+	struct phylink *phylink;
+
+	data->phylink_config.dev = &dev->net->dev;
+	data->phylink_config.type = PHYLINK_NETDEV;
+	data->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE | MAC_100;
+	if (data->is_ax88772d)
+		data->phylink_config.mac_capabilities |= MAC_10;
+	else if (data->chip_version < AX_VERSION_AX88279)
+		data->phylink_config.mac_capabilities |= MAC_10 | MAC_1000;
+	else
+		data->phylink_config.mac_capabilities |= MAC_1000 | MAC_2500FD;
+
+	if (!data->is_ax88772d) {
+		data->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
+		data->phylink_config.eee_enabled_default = false;
+	}
+
+	if (data->chip_version == AX_VERSION_AX88279) {
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  data->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  data->phylink_config.supported_interfaces);
+		phy_if_mode = PHY_INTERFACE_MODE_2500BASEX;
+	} else {
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  data->phylink_config.supported_interfaces);
+		phy_if_mode = PHY_INTERFACE_MODE_SGMII;
+	}
+
+	phylink = phylink_create(&data->phylink_config, dev->net->dev.fwnode,
+				 phy_if_mode, &ax88179a_phylink_mac_ops);
+	if (IS_ERR(phylink))
+		return PTR_ERR(phylink);
+
+	data->phylink = phylink;
+	return 0;
+}
+
+static int ax88179a_init_mdio(struct usbnet *dev)
+{
+	struct ax88179_data *data = dev->driver_priv;
+	int ret;
+
+	data->mdio = mdiobus_alloc();
+	if (!data->mdio)
+		return -ENOMEM;
+
+	data->mdio->priv = dev;
+	data->mdio->read = ax88179_mdiobus_read;
+	data->mdio->write = ax88179_mdiobus_write;
+	data->mdio->read_c45 = ax88179_mdiobus_read_c45;
+	data->mdio->write_c45 = ax88179_mdiobus_write_c45;
+	data->mdio->name = "AX88179A MDIO Bus";
+	data->mdio->phy_mask = ~(1 << AX88179_PHY_ID);
+	/* mii bus name is usb-<usb bus number>-<usb device number> */
+	snprintf(data->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
+		 dev->udev->bus->busnum, dev->udev->devnum);
+
+	ret = mdiobus_register(data->mdio);
+	if (ret) {
+		netdev_err(dev->net, "Could not register MDIO bus (err %d)\n", ret);
+		mdiobus_free(data->mdio);
+		data->mdio = NULL;
+	}
+
+	return ret;
+}
+
+static const struct net_device_ops ax88179a_netdev_ops = {
+	.ndo_open		= usbnet_open,
+	.ndo_stop		= usbnet_stop,
+	.ndo_start_xmit		= usbnet_start_xmit,
+	.ndo_tx_timeout		= usbnet_tx_timeout,
+	.ndo_get_stats64	= dev_get_tstats64,
+	.ndo_change_mtu		= ax88179_change_mtu,
+	.ndo_set_mac_address	= ax88179_set_mac_addr,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_eth_ioctl		= usbnet_mii_ioctl,
+};
+
+static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct ax88179_data *ax179_data;
+	int ret;
+	u8 reg8;
+
+	/* Check if vendor configuration */
+	if (udev->actconfig->desc.bConfigurationValue != 1) {
+		netdev_info(dev->net, "Switching to vendor mode\n");
+		usb_driver_set_configuration(udev, 1);
+		return -ENODEV;
+	}
+
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret < 0)
+		return ret;
+
+	ax179_data = kzalloc_obj(*ax179_data);
+	if (!ax179_data)
+		return -ENOMEM;
+
+	dev->driver_priv = ax179_data;
+
+	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_CHIP_STATUS,
+			       1, 1, &ax179_data->chip_version);
+	if (ret < 0)
+		goto err_nodev;
+
+	ax179_data->chip_version = (ax179_data->chip_version & 0xf0) >> 4;
+	ax179_data->is_ax88772d = 0;
+	if (ax179_data->chip_version == AX_VERSION_AX88179A) {
+		if (udev->descriptor.bcdDevice == 0x300)
+			ax179_data->is_ax88772d = 1;
+	}
+
+	for (int i = 0; i < 3; i++) {
+		ret = ax88179_read_cmd(dev, AX88179A_ACCESS_BL, (0xFD + i),
+				       1, 1, &ax179_data->fw_version[i]);
+		if (ret < 0)
+			ax179_data->fw_version[i] = 0xff;
+	}
+	netdev_info(dev->net, "AX88179A/279/772D Chip Version: %x, FW: %d.%d.%d.%d\n",
+		    ax179_data->chip_version,
+		    ax179_data->fw_version[0], ax179_data->fw_version[1],
+		    ax179_data->fw_version[2], ax179_data->fw_version[3]);
+
+	/* The AX88279 requires both the AX_RX_CTL_IPE and AX_RX_CTL_DROPCRCERR
+	 * bits set in AX_RX_CTL for creating correct RX-URBs. AX_RX_CTL_DROPCRCERR
+	 * is anyway set for all chips, make sure AX_RX_CTL_IPE is set via ip_align.
+	 * Also configure eeprom access parameters.
+	 */
+	if (ax179_data->chip_version == AX_VERSION_AX88279) {
+		ax179_data->ip_align = 1;
+		ax179_data->eeprom_read_cmd = AX88179A_FLASH_READ;
+		ax179_data->eeprom_write_cmd = AX88179A_FLASH_WRITE;
+		ax179_data->eeprom_block = 256;
+		ax179_data->eeprom_wen = 1;
+	} else {
+		ax179_data->ip_align = 0;
+		ax179_data->eeprom_read_cmd = AX_ACCESS_EFUS;
+		ax179_data->eeprom_write_cmd = AX_ACCESS_EFUS;
+		ax179_data->eeprom_block = 20;
+		ax179_data->eeprom_wen = 0;
+	}
+
+	dev->net->netdev_ops = &ax88179a_netdev_ops;
+	dev->net->ethtool_ops = &ax88179a_ethtool_ops;
+	dev->net->needed_headroom = 8;
+	dev->net->needed_tailroom = 8;
+	dev->net->min_mtu = ETH_MIN_MTU;
+	dev->hard_mtu = 9 * 1024;
+	dev->net->max_mtu = dev->hard_mtu - dev->net->hard_header_len;
+
+	if (!ax179_data->is_ax88772d)
+		dev->mii.supports_gmii = 1;
+
+	dev->net->features |= NETIF_F_SG | NETIF_F_IP_CSUM |
+			      NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO |
+			      NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
+			      NETIF_F_HW_VLAN_CTAG_FILTER;
+
+	dev->net->hw_features |= dev->net->features;
+
+	dev->net->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM |
+				  NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO;
+
+	netif_set_tso_max_size(dev->net, 16384);
+
+	/* Enable Transmission of Link Speed byte in interrupt URB */
+	ax88179_write_cmd(dev, AX_FW_MODE, AX_FW_MODE_179A, 0, 0, NULL);
+	ax88179_write_cmd(dev, AX_RELOAD_EEPROM_EFUSE, 0, 0, 0, NULL);
+
+	/* Read MAC address from DTB or ASIX chip */
+	ax88179_get_mac_addr(dev);
+	memcpy(dev->net->perm_addr, dev->net->dev_addr, ETH_ALEN);
+
+	/* Power PHY for probing */
+	reg8 = AX_PHY_POWER;
+	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
+	msleep(250);
+
+	ret = ax88179a_init_mdio(dev);
+	if (ret)
+		goto err_nodev;
+
+	ret = ax88179a_phylink_setup(dev);
+	if (ret)
+		goto phylink_err;
+
+	ret = ax88179a_init_phy(dev);
+	if (ret)
+		goto initphy_err;
+
+	return 0;
+
+initphy_err:
+	phylink_destroy(ax179_data->phylink);
+phylink_err:
+	ax88179a_mdio_unregister(ax179_data);
+err_nodev:
+	kfree(ax179_data);
+	ax179_data = NULL;
+
+	return ret;
+}
+
+static void ax88179a_unbind(struct usbnet *dev, struct usb_interface *intf)
+{
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	u16 tmp16;
+	u8 tmp8;
+
+	/* Configure RX control register => stop operation */
+	tmp16 = AX_RX_CTL_STOP;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);
+
+	rtnl_lock();
+	phylink_disconnect_phy(ax179_data->phylink);
+	rtnl_unlock();
+	phylink_destroy(ax179_data->phylink);
+	ax88179a_mdio_unregister(ax179_data);
+
+	tmp8 = 0;
+	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &tmp8);
+
+	kfree(ax179_data);
+}
+
+static void ax88179a_rx_checksum(struct sk_buff *skb, u64 pkt_desc)
+{
+	u32 pkt_type;
+
+	skb->ip_summed = CHECKSUM_NONE;
+	/* checksum error bit is set */
+	if (pkt_desc & AX179A_RX_PD_L4_ERR || pkt_desc & AX179A_RX_PD_L3_ERR)
+		return;
+
+	pkt_type = pkt_desc & AX179A_RX_PD_L4_TYPE_MASK;
+	/* It must be a TCP or UDP packet with a valid checksum */
+	if (pkt_type == AX179A_RX_PD_L4_TCP || pkt_type == AX179A_RX_PD_L4_UDP)
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+}
+
+static int ax88179a_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
+{
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	struct sk_buff *ax_skb;
+	u32 hdr_off, pkt_end;
+	u64 *pkt_desc_ptr;
+	u16 vlan_tag;
+	u16 pkt_cnt;
+	u64 rx_hdr;
+
+	/* SKB contents for AX179A-based chips:
+	 *   <packet 1>
+	 *   ...
+	 *   <packet N>
+	 *   <per-packet metadata entry 1>
+	 *   ...
+	 *   <per-packet metadata entry N>
+	 *   <rx_hdr>
+	 *
+	 * where:
+	 *   <packet N> contains pkt_len data bytes and padding:
+	 *		2 bytes of IP alignment (optional, depends on AX_RX_CTL_IPE flag)
+	 *		packet data received
+	 *		optional padding to 8-bytes boundary
+	 *   <per-packet metadata entry N> contains 8 bytes:
+	 *		pkt_len and fields AX_RXHDR_*
+	 *   <rx-hdr>	contains 8 bytes:
+	 *		pkt_cnt and hdr_off (offset of <per-packet metadata entry 1>)
+	 *
+	 * pkt_cnt is number of entries in the per-packet metadata array.
+	 */
+
+	if (!skb || skb->len < sizeof(rx_hdr))
+		goto err;
+
+	/* RX Descriptor Header */
+	skb_trim(skb, skb->len - sizeof(rx_hdr));
+	rx_hdr = le64_to_cpup((u64 *)skb_tail_pointer(skb));
+
+	/* Check these packets */
+	hdr_off = (rx_hdr & AX179A_RX_DH_DESC_OFFSET_MASK) >> AX179A_RX_DH_DESC_OFFSET_SHIFT;
+	pkt_cnt = rx_hdr & AX179A_RX_DH_PKT_CNT_MASK;
+
+	/* Consistency check header position */
+	if (hdr_off != skb->len - (pkt_cnt * sizeof(rx_hdr)))
+		goto err;
+
+	/* Make sure that the bounds of the metadata array are inside the SKB
+	 * (and in front of the counter at the end).
+	 */
+	if (pkt_cnt * 8 + hdr_off > skb->len)
+		goto err;
+
+	/* Packets must not overlap the metadata array */
+	skb_trim(skb, hdr_off);
+
+	if (!pkt_cnt)
+		goto err;
+
+	/* Get the first RX packet descriptor */
+	pkt_desc_ptr = (u64 *)(skb->data + hdr_off);
+
+	pkt_end = 0;
+	while (pkt_cnt--) {
+		u64 pkt_desc = le64_to_cpup(pkt_desc_ptr);
+		u32 pkt_len_plus_padd;
+		u32 pkt_len;
+
+		pkt_len = (u32)((pkt_desc & AX179A_RX_PD_LEN_MASK) >> AX179A_RX_PD_LEN_SHIFT)
+			  - (ax179_data->ip_align ? 2 : 0);
+		pkt_len_plus_padd = ((pkt_len + 7 + (ax179_data->ip_align ? 2 : 0)) & 0x7FFF8);
+
+		pkt_end += pkt_len_plus_padd;
+		if (pkt_end > hdr_off || (pkt_cnt == 0 && pkt_end != hdr_off))
+			goto err;
+
+		if (pkt_desc & AX179A_RX_PD_DROP || !(pkt_desc & AX179A_RX_PD_RX_OK) ||
+		    pkt_len > (dev->hard_mtu + AX179A_RX_HW_PAD)) {
+			skb_pull(skb, pkt_len_plus_padd);
+
+			/* Next RX Packet Descriptor */
+			pkt_desc_ptr++;
+			continue;
+		}
+
+		ax_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len);
+		if (!ax_skb)
+			goto err;
+
+		skb_put(ax_skb, pkt_len);
+		memcpy(ax_skb->data, skb->data + (ax179_data->ip_align ? AX179A_RX_HW_PAD : 0),
+		       pkt_len);
+
+		if (ax179_data->rx_checksum)
+			ax88179a_rx_checksum(ax_skb, pkt_desc);
+
+		if (pkt_desc & AX179A_RX_PD_VLAN) {
+			vlan_tag = pkt_desc >> AX179A_RX_PD_VLAN_SHIFT;
+			__vlan_hwaccel_put_tag(ax_skb, htons(ETH_P_8021Q),
+					       vlan_tag & VLAN_VID_MASK);
+		}
+
+		usbnet_skb_return(dev, ax_skb);
+		skb_pull(skb, pkt_len_plus_padd);
+
+		/* Next RX Packet Header */
+		pkt_desc_ptr++;
+	}
+
+	return 1;
+
+err:
+	return 0;
+}
+
+static struct sk_buff *ax88179a_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
+{
+	u64 tx_desc = skb->len & AX179A_TX_DESC_LEN_MASK;
+	int frame_size = dev->maxpacket;
+	struct sk_buff *ax_skb;
+	u64 *tx_desc_ptr;
+	int padding_size;
+	int headroom;
+	int tailroom;
+	u16 tci = 0;
+
+	/* TSO MSS */
+	tx_desc |= ((u64)(skb_shinfo(skb)->gso_size & AX179A_TX_DESC_MSS_MASK)) <<
+		   AX179A_TX_DESC_MSS_SHIFT;
+
+	headroom = (skb->len + sizeof(tx_desc)) % 8;
+	padding_size = headroom ? 8 - headroom : 0;
+
+	if (((skb->len + sizeof(tx_desc) + padding_size) % frame_size) == 0) {
+		padding_size += 8;
+		tx_desc |= AX179A_TX_DESC_DROP_PADD;
+	}
+
+	if ((dev->net->features & NETIF_F_HW_VLAN_CTAG_TX) && (vlan_get_tag(skb, &tci) >= 0)) {
+		tx_desc |= AX179A_TX_DESC_VLAN;
+		tx_desc |= ((u64)tci & AX179A_TX_DESC_VLAN_MASK) << AX179A_TX_DESC_VLAN_SHIFT;
+	}
+
+	if (!dev->can_dma_sg && (dev->net->features & NETIF_F_SG) && skb_linearize(skb))
+		return NULL;
+
+	headroom = skb_headroom(skb);
+	tailroom = skb_tailroom(skb);
+
+	if (!(headroom >= sizeof(tx_desc) && tailroom >= padding_size)) {
+		ax_skb = skb_copy_expand(skb, sizeof(tx_desc), padding_size, flags);
+		dev_kfree_skb_any(skb);
+		skb = ax_skb;
+		if (!skb)
+			return NULL;
+	}
+	if (padding_size != 0)
+		skb_put_zero(skb, padding_size);
+	/* Copy TX header */
+	tx_desc_ptr = skb_push(skb, sizeof(tx_desc));
+	*tx_desc_ptr = cpu_to_le64(tx_desc);
+
+	usbnet_set_skb_tx_stats(skb, 1, 0);
+
+	return skb;
+}
+
+static int ax88179a_reset(struct usbnet *dev)
+{
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	u16 *tmp16;
+	u8 buf[5];
+	u8 *tmp;
+
+	tmp16 = (u16 *)buf;
+	tmp = (u8 *)buf;
+
+	/* Power up ethernet PHY */
+	*tmp = AX_PHY_POWER;
+	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, tmp);
+	msleep(250);
+
+	/* Ethernet PHY Auto Detach*/
+	ax88179a_auto_detach(dev);
+
+	*tmp = AX_MAC_EFF_EN;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BULK_OUT_CTRL, 1, 1, tmp);
+
+	*tmp16 = 0;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, tmp16);
+
+	*tmp = 0x04;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);
+	*tmp = 0x10;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH, 1, 1, tmp);
+
+	*tmp = 0;
+	if (dev->net->features & NETIF_F_HW_VLAN_CTAG_FILTER)
+		*tmp |= AX_VLAN_CONTROL_VFE;
+	if (dev->net->features & NETIF_F_HW_VLAN_CTAG_RX)
+		*tmp |= AX_VLAN_CONTROL_VSO;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, tmp);
+
+	*tmp = 0xff;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_INT_MASK, 1, 1, tmp);
+
+	*tmp = 0;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_RX_DMA_CTL, 1, 1, tmp);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_TX_DMA_CTL, 1, 1, tmp);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_ARC_CTRL, 1, 1, tmp);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_SWP_CTRL, 1, 1, tmp);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_TX_HDR_CKSUM, 1, 1, tmp);
+
+	/* Read MAC address from DTB or asix chip */
+	ax88179_get_mac_addr(dev);
+	memcpy(dev->net->perm_addr, dev->net->dev_addr, ETH_ALEN);
+
+	/* The Bulk-Register configuration for the AX88179A is done in
+	 * ax88179a_mac_link_up(), once the link is up for a given link and USB-speed.
+	 */
+	if (ax179_data->is_ax88772d)
+		dev->rx_urb_size = 1024 * 24;
+	else
+		dev->rx_urb_size = 1024 * 48;
+
+	/* Enable checksum offload */
+	*tmp = AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
+	       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, tmp);
+	ax179_data->rx_checksum = 1;
+
+	*tmp = AX_TXCOE_IP | AX_TXCOE_TCP | AX_TXCOE_UDP |
+	       AX_TXCOE_TCPV6 | AX_TXCOE_UDPV6;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, tmp);
+
+	/* Configure RX control register => start operation */
+	ax179_data->rxctl = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_START |
+			    AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;
+	if (ax179_data->ip_align)
+		ax179_data->rxctl |= AX_RX_CTL_IPE;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &ax179_data->rxctl);
+
+	if (ax179_data->chip_version < AX_VERSION_AX88179A)
+		*tmp = AX_MONITOR_MODE_PMETYPE | AX_MONITOR_MODE_PMEPOL | AX_MONITOR_MODE_RWMP;
+	else
+		*tmp = AX_MONITOR_MODE_RWMP;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, tmp);
+
+	/* Configure default medium type => giga */
+	*tmp16 = AX_MEDIUM_RECEIVE_EN | AX_MEDIUM_TXFLOW_CTRLEN |
+		 AX_MEDIUM_RXFLOW_CTRLEN | AX_MEDIUM_FULL_DUPLEX;
+	if (!ax179_data->is_ax88772d)
+		*tmp16 |= AX_MEDIUM_GIGAMODE;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, tmp16);
+
+	/* Check if WoL is supported */
+	ax179_data->wol_supported = 0;
+	if (ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD,
+			     1, 1, &tmp) > 0)
+		ax179_data->wol_supported = WAKE_MAGIC | WAKE_PHY;
+
+	phylink_start(ax179_data->phylink);
+
+	usbnet_link_change(dev, 0, 0);
+
+	return 0;
+}
+
+static int ax88179a_stop(struct usbnet *dev)
+{
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	u16 reg16;
+	u8 reg8;
+
+	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);
+	reg16 &= ~AX_MEDIUM_RECEIVE_EN;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);
+
+	reg16 = 0;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &reg16);
+
+	reg8 = 0;
+	ax88179_read_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
+
+	phylink_stop(ax179_data->phylink);
+
+	return 0;
+}
+
+const struct driver_info ax88179a_info = {
+	.description = "ASIX AX88179A USB 3.2 Gigabit Ethernet",
+	.bind = ax88179a_bind,
+	.unbind = ax88179a_unbind,
+	.status = ax88179a_status,
+	.reset = ax88179a_reset,
+	.stop = ax88179a_stop,
+	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET | FLAG_AVOID_UNLINK_URBS,
+	.rx_fixup = ax88179a_rx_fixup,
+	.tx_fixup = ax88179a_tx_fixup,
+};
+
+const struct driver_info ax88772d_info = {
+	.description = "ASIX AX88772D/E USB 2.0 Fast Ethernet",
+	.bind = ax88179a_bind,
+	.unbind = ax88179a_unbind,
+	.status = ax88179a_status,
+	.reset = ax88179a_reset,
+	.stop = ax88179a_stop,
+	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET | FLAG_AVOID_UNLINK_URBS,
+	.rx_fixup = ax88179a_rx_fixup,
+	.tx_fixup = ax88179a_tx_fixup,
+};
+
+const struct driver_info ax88279_info = {
+	.description = "ASIX AX88279 USB 3.2 2.5Gigabit Ethernet",
+	.bind = ax88179a_bind,
+	.unbind = ax88179a_unbind,
+	.status = ax88179a_status,
+	.reset = ax88179a_reset,
+	.stop = ax88179a_stop,
+	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET | FLAG_AVOID_UNLINK_URBS,
+	.rx_fixup = ax88179a_rx_fixup,
+	.tx_fixup = ax88179a_tx_fixup,
+};

-- 
2.47.3

