Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.97.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949700;
	b=Udc1oZ/2UWHDeJdTlTxl0+hjh78e92+rY16q7SeoooWf8oJPdmCClf7D03eItU6SoWwv
	 sggJSq0IlaS/3lqDr2hAwR6tYeKf5+q+TnhniyvXQOzY48weIObzCTbd1uMtgpPhQlc7r
	 sD5uGtnnP44pEQQ1upL4NbLlzoEtO+M0aqRFj9zl01HMEXm2pYff6NVZ3cfH01lSPbl5y
	 dY3+5oKS9cNM/nuetKJSIuvGqrSZZU9dNb1nkU+4Dqi0PiJ6Lr7kACRdr5lCc0nRwRC2l
	 B8t6C1DJxcQmVFzcx007cmHcB+g4O1MaiK1XLv8UebnLUfvdPpj0Byjg2a1XiL7iCUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949700;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=XWepQ27i6OBrSgYBIzsTFmVKwm0ceF2smeY0BOZwH8g=;
	b=t+LCp9X0VkcfYBJjF8nPlkUwZehP13VLgE4UREgElq0S6GIpi0vz3TnVOxVz5+GHwS1/
	 22Eaj18yHZRNU+KyvBLhL2MJSJ3fZuvH1mR0xrUAG0a5yYKYmToV4XA5zWM+zx+QiWQHu
	 kT7Cfdm4cP3OoiSDkxZjXkxio7utXxESuhiQjtZX3Hd08zss8NPXvM6yRSUtRFzSb741S
	 rWNZMfVwfwtlfWDFeCLnI7np40yqnsV+E/8D5dwcSP8rPni4HJg8HYpJ8+d0rRithAJLe
	 npGZvJ35mTVwbxtUkrQVwj63lc7IHxp8wn3FjsbTMUbBr2ULr6h6J4nnQhTOl7KeH6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=birger-koblitz.de;
	spf=pass smtp.mailfrom=birger-koblitz.de;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=0OHkMew+;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=Sqkxduah;
	arc=none smtp.remote-ip=23.88.97.239
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5FB606A326;
	Fri,  6 Nov 2026 07:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A5FB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=0OHkMew+;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=Sqkxduah
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949697;
	bh=PRfzpdJIMsLWunEEfuefkdJmBW0rsdAfv3VSvbgy20k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0OHkMew+wxarwsLJyYh8tHeIKupXrxjPsD0Qai/D7o+eRdkU1ElPjcrpolR/Dm1Nd
	 Ve9FHKdS90EdRMd40U7568G/NFiviC/BU/yyIH5EBTiIqrFUKfHcP31mKBv1S+Ay7O
	 tod867qexbQwL/RiB2wdxpE8UCiwaAcg35SG7Vd+BOjTnq9vYZwECFrnneK9+RzE4D
	 PHRCpzyZzB0b+XveiZArCcy1kjp5MXpNQZBRtDBUFJWutIvgvNhLuLWOFGy/hQpcLa
	 kWvU3aob7xL2pCHikPgTIKGMDqsIoxeduGXQmM39qltoThEt99ceBmiKbEf3f9xKEU
	 4H3gXxEhbXqTA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 46AF748BB3; Fri,  6 Nov 2026 07:21:37 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949685;
	bh=PRfzpdJIMsLWunEEfuefkdJmBW0rsdAfv3VSvbgy20k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SqkxduahUXi8RiPHgXYw/Y0Hli7JJyNC11PdqbV0QRoRrw7QRxJVNs8ehPAtfKGFk
	 a9NvxLScUTKKPaO74wfaM623F/0UZXi6lLNocS3mC8y2ed4C3JUT9thfdUilpW6Bpm
	 P1cZpRd9QBzyLuV7fnRqjzHcAKIsPOcOxBGr/L7deIJNm/gQoEtkCyCzPXNBhv0edB
	 iYNjT9pzROfaROPpmsWjdpp66GeMzuzGgeCLAa+YtmE17lawOVKQxE3pIRLMrgwDnN
	 SHJ5dhLkvS0sp5YGxV2saf12dfA9M5aCpfStoQJhreTei254+pvT+k/O47aN41lj0U
	 4JIYbYtIc5V4Q==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 1A9A348B8D;
	Fri,  6 Nov 2026 07:21:25 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 06 Nov 2026 08:21:19 +0100
Subject: [PATCH net-next v20 04/13] ax88179_178a: Add HW support for
 AX179A-based chips
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
Message-Id: <20261106-ax88179a-v20-4-37b5a1189983@birger-koblitz.de>
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

Also add a convenience function for the ethtool ops that use
phylink and need to retrieve the ax88179_data structure from
net_device: netdev2data().

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 MAINTAINERS                        |   6 +
 drivers/net/usb/Kconfig            |   2 +-
 drivers/net/usb/Makefile           |   2 +-
 drivers/net/usb/ax88179_178a.c     |  31 ++
 drivers/net/usb/ax88179_lib.c      |  30 ++
 drivers/net/usb/ax88179_lib.h      | 161 ++++++
 drivers/net/usb/ax88179a_devices.c | 983 +++++++++++++++++++++++++++++++++++++
 7 files changed, 1213 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe23913b1e4329b2c4e6f518f12945e286b01058..c22f8ed0880834083b056760160c8ca3393870a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4114,6 +4114,12 @@ S:	Maintained
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
index 55268d0890d1200be07b87f2dc9e62d2d7b69fc1..f78ad344c1c4f1f057164728e4f21f875e6cdc1a 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -685,6 +685,19 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 	dev->driver_priv = ax179_data;
 	mutex_init(&ax179_data->medium_status_mutex);
 
+	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_CHIP_STATUS,
+			       1, 1, &ax179_data->chip_version);
+	if (ret < 0)
+		goto err_nodev;
+
+	ax179_data->chip_version = (ax179_data->chip_version & 0xf0) >> 4;
+	ax179_data->is_ax88772d = 0;
+	ax179_data->ip_align = 1;
+	ax179_data->eeprom_read_cmd = AX_ACCESS_EEPROM;
+	ax179_data->eeprom_write_cmd = AX_ACCESS_EEPROM;
+	ax179_data->eeprom_block = 2;
+	ax179_data->eeprom_wen = 0;
+
 	dev->net->netdev_ops = &ax88179_netdev_ops;
 	dev->net->ethtool_ops = &ax88179_ethtool_ops;
 	dev->net->needed_headroom = 8;
@@ -709,6 +722,12 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 	ax88179_reset(dev);
 
 	return 0;
+
+err_nodev:
+	kfree(ax179_data);
+	ax179_data = NULL;
+
+	return ret;
 }
 
 static void ax88179_unbind(struct usbnet *dev, struct usb_interface *intf)
@@ -1271,6 +1290,18 @@ static const struct driver_info at_umc2000sp_info = {
 
 static const struct usb_device_id products[] = {
 {
+	/* ASIX AX88179A USB 3.2 1000Mbit Ethernet */
+	USB_DEVICE_VER(0x0b95, 0x1790, 0x0200, 0x0200),
+	.driver_info = (unsigned long)&ax88179a_info,
+}, {
+	/* ASIX AX88772D USB 2.0 100Mbit Ethernet */
+	USB_DEVICE_VER(0x0b95, 0x1790, 0x0300, 0x0300),
+	.driver_info = (unsigned long)&ax88772d_info,
+}, {
+	/* ASIX AX88279 USB 3.2 2500Mbit Ethernet */
+	USB_DEVICE_VER(0x0b95, 0x1790, 0x0400, 0x0400),
+	.driver_info = (unsigned long)&ax88279_info,
+}, {
 	/* ASIX AX88179 10/100/1000 */
 	USB_DEVICE_AND_INTERFACE_INFO(0x0b95, 0x1790, 0xff, 0xff, 0),
 	.driver_info = (unsigned long)&ax88179_info,
diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
index 063427ff55e42e38be1acb66806c0cdbe8e84347..a314db4c9766679568a036f98acf868784835865 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -129,6 +129,28 @@ int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 	return ret;
 }
 
+int ax88179_write_u16(struct usbnet *dev, u8 cmd, u16 value, u16 index, u16 data)
+{
+	u16 buf = data;
+
+	cpu_to_le16s(&buf);
+	return __ax88179_write_cmd(dev, cmd, value, index, 2, &buf);
+}
+
+int ax88179_write_u8(struct usbnet *dev, u8 cmd, u16 value, u16 index, u8 data)
+{
+	u8 buf = data;
+
+	return __ax88179_write_cmd(dev, cmd, value, index, 1, &buf);
+}
+
+struct ax88179_data *netdev2data(struct net_device *net)
+{
+	struct usbnet *dev = netdev_priv(net);
+
+	return dev->driver_priv;
+}
+
 void ax88179_status(struct usbnet *dev, struct urb *urb)
 {
 	struct ax88179_int_data *event;
@@ -340,6 +362,7 @@ int ax88179_set_features(struct net_device *net, netdev_features_t features)
 {
 	u8 tmp;
 	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data = dev->driver_priv;
 	netdev_features_t changed = net->features ^ features;
 
 	if (changed & NETIF_F_IP_CSUM) {
@@ -355,10 +378,17 @@ int ax88179_set_features(struct net_device *net, netdev_features_t features)
 	}
 
 	if (changed & NETIF_F_RXCSUM) {
+		/* When we disable rx-checksumming, we need to clear the rx_checksum
+		 * flag before disabling the engine
+		 */
+		if (!(features & NETIF_F_RXCSUM))
+			data->rx_checksum = 0;
+
 		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, &tmp);
 		tmp ^= AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
 		       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
 		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, &tmp);
+		data->rx_checksum = !!(features & NETIF_F_RXCSUM);
 	}
 
 	return 0;
diff --git a/drivers/net/usb/ax88179_lib.h b/drivers/net/usb/ax88179_lib.h
index 9111a1395eb2f7208c7e90c93027845423bbda00..adc2b4598bb52d80c18a6e2cc467144d3bd57a88 100644
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
@@ -157,6 +241,55 @@
 	#define GMII_PHY_PGSEL_PAGE3	0x0003
 	#define GMII_PHY_PGSEL_PAGE5	0x0005
 
+#define AX88179A_SW_REVISION		0xFC
+#define AX88179A_SW_VERSION		0xFD
+
+/* TX Descriptor */
+#define AX179A_TX_DESC_LEN_MASK		0x1FFFFF
+#define AX179A_TX_DESC_DROP_PADD	BIT(28)
+#define AX179A_TX_DESC_VLAN		BIT(29)
+#define AX179A_TX_DESC_MSS		GENMASK_U64(46, 32)
+#define AX179A_TX_DESC_VLAN_ID		GENMASK_U64(63, 48)
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
+#define AX179A_RX_PD_LEN		GENMASK(30, 16)
+#define AX179A_RX_PD_VLAN_SHIFT		0x20
+
+/* RX Descriptor header */
+#define AX179A_RX_DH_PKT_CNT_MASK	0x1FFF
+#define AX179A_RX_DH_DESC_OFFSET	GENMASK(31, 13)
+
+#define AX179A_RX_HW_PAD		0x02
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
 	struct mutex medium_status_mutex;  /* protect AX_MEDIUM_STATUS_MODE */
 	u8  eee_enabled;
@@ -166,6 +299,22 @@ struct ax88179_data {
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
@@ -173,6 +322,10 @@ struct ax88179_int_data {
 	__le32 intdata2;
 };
 
+struct ax_bulkin_settings {
+	unsigned char ctrl, timer_l, timer_h, size, ifg;
+};
+
 void ax88179_set_pm_mode(struct usbnet *dev, bool pm_mode);
 int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index, u16 size, void *data);
 int ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index, u16 size, void *data);
@@ -180,8 +333,11 @@ int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index, u16 size
 		      const void *data);
 void ax88179_write_cmd_async(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 			     u16 size, void *data);
+int ax88179_write_u16(struct usbnet *dev, u8 cmd, u16 value, u16 index, u16 data);
+int ax88179_write_u8(struct usbnet *dev, u8 cmd, u16 value, u16 index, u8 data);
 int ax88179_mdio_read(struct net_device *netdev, int phy_id, int loc);
 void ax88179_mdio_write(struct net_device *netdev, int phy_id, int loc, int val);
+struct ax88179_data *netdev2data(struct net_device *net);
 void ax88179_status(struct usbnet *dev, struct urb *urb);
 void ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo);
 int ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo);
@@ -192,4 +348,9 @@ int ax88179_set_features(struct net_device *net, netdev_features_t features);
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
index 0000000000000000000000000000000000000000..1aa8479422517bff6758c884c5e47258c5d3ed3a
--- /dev/null
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -0,0 +1,983 @@
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
+	int ret;
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
+	ret = ax88179_read_cmd(dev, AX_ACCESS_PHY, phy_id, (__u16)regnum, 2, &res);
+	if (ret < 0)
+		return ret;
+	return res;
+}
+
+static int ax88179_mdiobus_write(struct mii_bus *bus, int phy_id, int regnum, u16 val)
+{
+	struct usbnet *dev = bus->priv;
+
+	return ax88179_write_u16(dev, AX_ACCESS_PHY, phy_id, (__u16)regnum, val);
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
+	struct ax88179_data *data = dev->driver_priv;
+
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
+	if (link_sts & AX_USB_FS)
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
+static int ax88179a_get_link_ksettings(struct net_device *net,
+				       struct ethtool_link_ksettings *cmd)
+{
+	struct ax88179_data *data = netdev2data(net);
+
+	return phylink_ethtool_ksettings_get(data->phylink, cmd);
+}
+
+static int ax88179a_set_link_ksettings(struct net_device *net,
+				       const struct ethtool_link_ksettings *cmd)
+{
+	struct ax88179_data *data = netdev2data(net);
+
+	return phylink_ethtool_ksettings_set(data->phylink, cmd);
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
+	.nway_reset		= phy_ethtool_nway_reset,
+	.get_link_ksettings	= ax88179a_get_link_ksettings,
+	.set_link_ksettings	= ax88179a_set_link_ksettings,
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
+	u8 link_sts = 0, reg8[3];
+	u8 bulk_config_speed = 0;
+	u16 mode;
+
+	/* Stop RX/TX for link configuration */
+	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, AX_RX_CTL_STOP);
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 0);
+
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_CDC_DELAY_TX, 1, 0xa5);
+
+	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 2, 0x0410);
+
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_ETH_TX_GAP, 1, 0);
+
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_EP5_EHR, 1, 0x07);
+
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_NEW_PAUSE_CTRL, 1,
+			 0x28 | AX_NEW_PAUSE_EN);
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
+		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 0x40);
+		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT + 1, 1,
+				 AX_MAC_MIQFFCTRL_FORMAT | AX_MAC_MIQFFCTRL_DROP_CRC |
+				 AX_MAC_LSO_ERR_EN);
+
+		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_BFM_DATA, 1, AX_XGMII_EN);
+
+		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_LSO_ENHANCE_CTRL, 1,
+				 0x1C | AX_LSO_ENHANCE_EN);
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
+		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 0x40);
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
+		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 0xFA);
+
+		bulk_config_speed = ETHER_LINK_10;
+		break;
+	}
+
+	ax88179_read_cmd(dev, AX_ACCESS_MAC, PHYSICAL_LINK_STATUS, 1, 1, &link_sts);
+	ax88179a_bulkin_config(dev, link_sts, bulk_config_speed, !!duplex);
+
+	if (speed != SPEED_2500)
+		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_BFM_DATA, 1, 0);
+
+	if (duplex)
+		mode |= AX_MEDIUM_FULL_DUPLEX;
+
+	mutex_lock(&ax179_data->medium_status_mutex);
+	if (dev->net->mtu > 1500)
+		mode |= AX_MEDIUM_JUMBO_EN;
+	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, mode);
+
+	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, READ_ONCE(ax179_data->rxctl));
+	mutex_unlock(&ax179_data->medium_status_mutex);
+
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1,
+			 AX_MAC_RX_PATH_READY | AX_MAC_TX_PATH_READY);
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
+static int ax88179a_mii_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
+{
+	struct ax88179_data *data = netdev2data(net);
+
+	return phylink_mii_ioctl(data->phylink, rq, cmd);
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
+	.ndo_eth_ioctl		= ax88179a_mii_ioctl,
+};
+
+static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct ax88179_data *ax179_data;
+	int ret;
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
+	mutex_init(&ax179_data->medium_status_mutex);
+
+	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_CHIP_STATUS,
+			       1, 1, &ax179_data->chip_version);
+	if (ret < 0)
+		goto err_nodev;
+
+	ax179_data->chip_version = (ax179_data->chip_version & 0xf0) >> 4;
+	ax179_data->is_ax88772d = 0;
+	if (ax179_data->chip_version == AX_VERSION_AX88179A) {
+		if (le16_to_cpu(udev->descriptor.bcdDevice) == 0x300)
+			ax179_data->is_ax88772d = 1;
+	}
+
+	for (int i = 0; i < 3; i++) {
+		ret = ax88179_read_cmd(dev, AX88179A_ACCESS_BL, AX88179A_SW_VERSION + i,
+				       1, 1, &ax179_data->fw_version[i]);
+		if (ret < 0)
+			ax179_data->fw_version[i] = 0xff;
+	}
+	ret = ax88179_read_cmd(dev, AX88179A_ACCESS_BL, AX88179A_SW_REVISION,
+			       1, 1, &ax179_data->fw_version[3]);
+	if (ret < 0)
+		ax179_data->fw_version[3] = 0xff;
+
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
+			      NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO;
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
+	ax88179_write_u8(dev, AX88179A_PHY_POWER, 0, 0, AX_PHY_POWER);
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
+
+	/* Configure RX control register => stop operation */
+	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, AX_RX_CTL_STOP);
+
+	rtnl_lock();
+	phylink_disconnect_phy(ax179_data->phylink);
+	rtnl_unlock();
+	phylink_destroy(ax179_data->phylink);
+	ax88179a_mdio_unregister(ax179_data);
+
+	ax88179_write_u8(dev, AX88179A_PHY_POWER, 0, 0, 0);
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
+	__le64 *pkt_desc_ptr;
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
+	rx_hdr = get_unaligned_le64((__le64 *)skb_tail_pointer(skb));
+
+	/* Check these packets */
+	hdr_off = FIELD_GET(AX179A_RX_DH_DESC_OFFSET, rx_hdr);
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
+	pkt_desc_ptr = (__le64 *)(skb->data + hdr_off);
+
+	pkt_end = 0;
+	while (pkt_cnt--) {
+		u64 pkt_desc = get_unaligned_le64(pkt_desc_ptr);
+		u32 pkt_len_plus_padd;
+		u32 pkt_len;
+
+		pkt_len = FIELD_GET(AX179A_RX_PD_LEN, pkt_desc);
+		pkt_len -= (ax179_data->ip_align ? 2 : 0);
+		pkt_len_plus_padd = ((pkt_len + 7 + (ax179_data->ip_align ? 2 : 0)) & 0x7FFF8);
+
+		pkt_end += pkt_len_plus_padd;
+		if (pkt_end > hdr_off || (pkt_cnt == 0 && pkt_end != hdr_off))
+			goto err;
+
+		if (pkt_desc & AX179A_RX_PD_DROP || !(pkt_desc & AX179A_RX_PD_RX_OK) ||
+		    pkt_len > (dev->hard_mtu + AX179A_RX_HW_PAD) || pkt_len < 2 + ETH_HLEN) {
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
+			__vlan_hwaccel_put_tag(ax_skb, htons(ETH_P_8021Q), vlan_tag);
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
+	tx_desc |= FIELD_PREP(AX179A_TX_DESC_MSS, (u64)skb_shinfo(skb)->gso_size);
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
+		tx_desc |= FIELD_PREP(AX179A_TX_DESC_VLAN_ID, (u64)tci);
+	}
+
+	if (!dev->can_dma_sg && (dev->net->features & NETIF_F_SG) && skb_linearize(skb)) {
+		dev_kfree_skb_any(skb);
+		return NULL;
+	}
+
+	headroom = skb_headroom(skb);
+	tailroom = skb_tailroom(skb);
+
+	if (skb_cloned(skb) || !(headroom >= sizeof(tx_desc) && tailroom >= padding_size)) {
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
+	put_unaligned_le64(tx_desc, tx_desc_ptr);
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
+	u16 rxctl;
+	u8 *tmp;
+
+	tmp16 = (u16 *)buf;
+	tmp = (u8 *)buf;
+
+	/* Power up ethernet PHY */
+	ax88179_write_u8(dev, AX88179A_PHY_POWER, 0, 0, AX_PHY_POWER);
+	msleep(250);
+
+	/* Ethernet PHY Auto Detach*/
+	ax88179a_auto_detach(dev);
+
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_BULK_OUT_CTRL, 1, AX_MAC_EFF_EN);
+
+	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 0);
+
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 0x04);
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH, 1, 0x10);
+
+	*tmp = 0;
+	if (dev->net->features & NETIF_F_HW_VLAN_CTAG_FILTER)
+		*tmp |= AX_VLAN_CONTROL_VFE;
+	if (dev->net->features & NETIF_F_HW_VLAN_CTAG_RX)
+		*tmp |= AX_VLAN_CONTROL_VSO;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, tmp);
+
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_INT_MASK, 1, 0xff);
+
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_RX_DMA_CTL, 1, 0);
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_TX_DMA_CTL, 1, 0);
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_ARC_CTRL, 1, 0);
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_SWP_CTRL, 1, 0);
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_TX_HDR_CKSUM, 1, 0);
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
+	if (dev->net->features & NETIF_F_RXCSUM) {
+		ax88179_write_u8(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1,
+				 AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
+				 AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6);
+		ax179_data->rx_checksum = 1;
+	} else {
+		ax179_data->rx_checksum = 0;
+		ax88179_write_u8(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 0);
+	}
+
+	*tmp = 0;
+	if (dev->net->features & NETIF_F_IP_CSUM)
+		*tmp = AX_TXCOE_IP | AX_TXCOE_TCP | AX_TXCOE_UDP;
+	if (dev->net->features & NETIF_F_IPV6_CSUM)
+		*tmp |= AX_TXCOE_IP | AX_TXCOE_TCPV6 | AX_TXCOE_UDPV6;
+	ax88179_write_u8(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, *tmp);
+
+	/* Configure RX control register => start operation */
+	rxctl = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_START | AX_RX_CTL_AP |
+		AX_RX_CTL_AMALL | AX_RX_CTL_AB;
+	if (ax179_data->ip_align)
+		rxctl |= AX_RX_CTL_IPE;
+	if (dev->net->flags & IFF_PROMISC)
+		rxctl |= AX_RX_CTL_PRO;
+	WRITE_ONCE(ax179_data->rxctl, rxctl);
+	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, rxctl);
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
+			     1, 1, tmp) > 0)
+		ax179_data->wol_supported = WAKE_MAGIC | WAKE_PHY;
+
+	/* Ensure EEE state is off, consistent with phylink setup */
+	ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, false, 0, NULL);
+
+	phylink_start(ax179_data->phylink);
+
+	return 0;
+}
+
+static int ax88179a_stop(struct usbnet *dev)
+{
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	u16 reg16 = 0;
+
+	phylink_stop(ax179_data->phylink);
+
+	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);
+	reg16 &= ~AX_MEDIUM_RECEIVE_EN;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);
+
+	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 0);
+
+	ax88179_write_u8(dev, AX88179A_PHY_POWER, 0, 0, 0);
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

