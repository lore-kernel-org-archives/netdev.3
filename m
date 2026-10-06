Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7701C35F5ED;
	Tue,  6 Oct 2026 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255938; cv=none; b=K7pboLXEmoNlnwvZnDiPjkmtJoQDaKuFQTsMYdU1EzAJlaiB8cthVmK1TJT0PJQKqKi+uT3b4eFXUD07kMGmRenpB6mEaxKBKsl3GEqkbtx6wbKaWBL6LIxDE2zxz/v1V3/+jAmls75BLSCeUYttPz6w5Jt+JPkdR903F8rh/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255938; c=relaxed/simple;
	bh=n1YY4Ck2NNxTF6Dv0Dg+v2Ep1MCGfRSCuwmTVbpO6QU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AoMUbdK/6MsiQfipmZzmPFvxH9bSs+I5eRgSa1b5Tz/qBannIldWCy553sGfLp0QiV/cdfbHFEfwk5bRLefjzSG5a2oH3/qMON76R5tvP5dG4E9LCczkRPb1DYoouwwQx3Ugp38ncTXAGqQDrRQDbBSozkcSQpCgymKtLdRwB+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=sXiDxu+G; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=K82fz3cB; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="sXiDxu+G";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="K82fz3cB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791255932;
	bh=n1YY4Ck2NNxTF6Dv0Dg+v2Ep1MCGfRSCuwmTVbpO6QU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sXiDxu+GWXP66p9uX29FdS79QySQ3aMQnaRUY7xubCnVxStg5SF9ADJulFmF46hzQ
	 lIeuTvzKtBX3lImcOiKcAnjxT3Vuao2+zphRZITCSMj8/F1XNDv+cK2OGaGqAftzMa
	 1xszE1EblNbPLbUdLo/kUlVwRTzIa5EbuPWWlQJwNGg51XQ7scPCaaf2bPVxtK8mQW
	 31+Jj2AN8YUkymO13Tuw94VDqrtuSmtZxl3D61z+HhJbul2hgJd5f5mFoVBqjMGwCd
	 DqW6WcTfYCThl6eOgPc75Y8oio3FmklEo0kJUzAu9e89dJ5c6Q3O6teUevsLcyOWmw
	 EIWLTqGykqamw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 7BB14485AE; Tue,  6 Oct 2026 03:05:32 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791255915;
	bh=n1YY4Ck2NNxTF6Dv0Dg+v2Ep1MCGfRSCuwmTVbpO6QU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K82fz3cB0C1YDrMLl/lNrlgAeLhgetULkjg4u1fW9P+C8PFbWiDXLF163vCZbYcgf
	 mIULCyJnyyp0kyKbUhhXvDBieUWTG9XE4V6n3d7TMnrRiCb1AfAghhVKUKMJeclHno
	 q+MTy/kRq9fEFRb7gSI4Ksp6c4dwYOnmdhJhtCjsAb/xbjZK3+Nwjn7kCSL8yMP8kI
	 oln53ZFMnSRcAedsGiHPoanTagxcSHSW83N/SFVKougndRQwj4hSaOvuYKVJd42J9p
	 ryjk5M4GHl+IynyLu+aEU91kYmkfbzdTV+ekZNxybxqMaqAHlxifXvpnjW7Cu1tKBX
	 46aj6ICLRnDnw==
Received: from AMDDesktop.lan (p4fd5971b.dip0.t-ipconnect.de [79.213.151.27])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 7E1AA485C1;
	Tue,  6 Oct 2026 03:05:15 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 06 Oct 2026 05:05:17 +0200
Subject: [PATCH net-next v17 11/13] ax88179_178a: Update driver name and
 information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-ax88179a-v17-11-252814fe35ea@birger-koblitz.de>
References: <20261006-ax88179a-v17-0-252814fe35ea@birger-koblitz.de>
In-Reply-To: <20261006-ax88179a-v17-0-252814fe35ea@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Birger Koblitz <mail@birger-koblitz.de>, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2

Add additionally supported devices to Kconfig description, add
further requirements such as PHYLINK.

Update driver name in usb_driver and update MODULE_DESCRIPTION
to include the additionally supported chips.

Change Kconfig symbol name from USB_NET_AX88179_178A to USB_NET_AX88179
and update loongson32_defconfig/loongson64_defconfig to use that
symbol.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 arch/loongarch/configs/loongson32_defconfig |  2 +-
 arch/loongarch/configs/loongson64_defconfig |  2 +-
 drivers/net/usb/Kconfig                     | 10 +++++++---
 drivers/net/usb/Makefile                    |  2 +-
 drivers/net/usb/ax88179_178a.c              |  8 ++++----
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/loongarch/configs/loongson32_defconfig b/arch/loongarch/configs/loongson32_defconfig
index dbef879935f322e6167b4ed878ad4cb20048c6db..a039b8e8d242073c16ea281cf8734068a1a9b29f 100644
--- a/arch/loongarch/configs/loongson32_defconfig
+++ b/arch/loongarch/configs/loongson32_defconfig
@@ -641,7 +641,7 @@ CONFIG_USB_RTL8150=m
 CONFIG_USB_RTL8152=m
 CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_AX8817X is not set
-# CONFIG_USB_NET_AX88179_178A is not set
+# CONFIG_USB_NET_AX88179 is not set
 CONFIG_USB_NET_CDC_EEM=m
 CONFIG_USB_NET_HUAWEI_CDC_NCM=m
 CONFIG_USB_NET_CDC_MBIM=m
diff --git a/arch/loongarch/configs/loongson64_defconfig b/arch/loongarch/configs/loongson64_defconfig
index 4f8bb77b8a1e6e30bcbd6e96d7e38b5054630ea0..b30415c03fa185cae77e81ded929c743ef22ee40 100644
--- a/arch/loongarch/configs/loongson64_defconfig
+++ b/arch/loongarch/configs/loongson64_defconfig
@@ -657,7 +657,7 @@ CONFIG_USB_RTL8150=m
 CONFIG_USB_RTL8152=m
 CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_AX8817X is not set
-# CONFIG_USB_NET_AX88179_178A is not set
+# CONFIG_USB_NET_AX88179 is not set
 CONFIG_USB_NET_CDC_EEM=m
 CONFIG_USB_NET_HUAWEI_CDC_NCM=m
 CONFIG_USB_NET_CDC_MBIM=m
diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 115990b0d9537aea2776544c9768b034f32aa7a4..27862e380bdb4a54d184fa8618e4c9b348354e84 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -195,11 +195,12 @@ config USB_NET_AX8817X
 	  This driver creates an interface named "ethX", where X depends on
 	  what other networking devices you have in use.
 
-config USB_NET_AX88179_178A
-	tristate "ASIX AX88179/178A USB 3.0/2.0 to Gigabit Ethernet"
+config USB_NET_AX88179
+	tristate "ASIX AX88179/179A/178A USB 2.0/3.0 to 100M/1G/2.5GbE Adapters"
 	depends on USB_USBNET
-	select CRC32
 	select PHYLINK
+	select AX88796B_PHY
+	select CRC32
 	default y
 	help
 	  This option adds support for ASIX AX88179 based USB 3.0/2.0
@@ -207,6 +208,9 @@ config USB_NET_AX88179_178A
 
 	  This driver should work with at least the following devices:
 	    * ASIX AX88179
+	    * ASIX AX88179A/B
+	    * ASIX AX88279
+	    * ASIX AX88772D/E
 	    * ASIX AX88178A
 	    * Sitcomm LN-032
 
diff --git a/drivers/net/usb/Makefile b/drivers/net/usb/Makefile
index 2ecead0181eaf8d66fb6f5dbd6f2905b22b6eb57..4026f19ecb826a6465de38f1d9bb0e4c0af80421 100644
--- a/drivers/net/usb/Makefile
+++ b/drivers/net/usb/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_USB_HSO)		+= hso.o
 obj-$(CONFIG_USB_LAN78XX)	+= lan78xx.o
 obj-$(CONFIG_USB_NET_AX8817X)	+= asix.o
 asix-y := asix_devices.o asix_common.o ax88172a.o
-obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179.o
+obj-$(CONFIG_USB_NET_AX88179)      += ax88179.o
 ax88179-y := ax88179_178a.o ax88179a_devices.o ax88179_lib.o
 obj-$(CONFIG_USB_NET_CDCETHER)	+= cdc_ether.o
 obj-$(CONFIG_USB_NET_CDC_EEM)	+= cdc_eem.o
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 245ccf6896033922adcef79bd395b347918f57e3..8b52994e2a604101b61ec9cc0d698a0ecb520a14 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1354,8 +1354,8 @@ static const struct usb_device_id products[] = {
 };
 MODULE_DEVICE_TABLE(usb, products);
 
-static struct usb_driver ax88179_178a_driver = {
-	.name =		"ax88179_178a",
+static struct usb_driver ax88179_driver = {
+	.name =		"ax88179",
 	.id_table =	products,
 	.probe =	usbnet_probe,
 	.suspend =	ax88179_suspend_wrapper,
@@ -1366,8 +1366,8 @@ static struct usb_driver ax88179_178a_driver = {
 	.disable_hub_initiated_lpm = 1,
 };
 
-module_usb_driver(ax88179_178a_driver);
+module_usb_driver(ax88179_driver);
 
-MODULE_DESCRIPTION("ASIX AX88179/178A based USB 3.0/2.0 Gigabit Ethernet Devices");
+MODULE_DESCRIPTION("ASIX AX88179/179A/178A/279 based USB 3.0/2.0 100M/1G/2.5GbE Controllers");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("ax88179_178a");

-- 
2.47.3

