Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C1364EAF;
	Fri,  2 Oct 2026 04:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916508; cv=none; b=SNnqbizrTDzvOmJTZvG6HCgkG77sQvunGN37f+yRJkDthNRm5ymx7QW0YahtVtOpGbwBhbKXP8bz2aTs/7bBL2U5RsY20fCdkgOeybZLH41+SaX4xFItWQv2y9CD9CHgBr5lAR9USc/n+er39F5tqJyusP1TZooMp92G4aLsRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916508; c=relaxed/simple;
	bh=n1YY4Ck2NNxTF6Dv0Dg+v2Ep1MCGfRSCuwmTVbpO6QU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qn+Cc53ys7tybkVTZI5jsPQw7gL/Ttoi50IJD3yZM6o73iDijuiGI6HrSY6JwiUjJpKY4G+KhDwOKgd6SXswCWMOILjfG305UCJQn0s8h9oHOfguc+GOBMCVyGxFbS7PXhF182ooJWZb+HKlRdmWbjA/krCNMoP4VaG4rEbBgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ZiGDD3Em; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=NAQ9cR+J; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ZiGDD3Em";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="NAQ9cR+J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916496;
	bh=n1YY4Ck2NNxTF6Dv0Dg+v2Ep1MCGfRSCuwmTVbpO6QU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZiGDD3EmM8dM8Hy0dEvPeP3A+DZOrETlXMEolwGChngVme5JalmTJeKQfZEY2SyMm
	 861UMyUdpvBf8dXUoGum9QvBwYHnReSj5nqF8Qj0CVvJE9B9dy0B5guAGMwaTLIeja
	 noAkOVejB0ZMM1dT7sAKnb3UZEF0/p3ofFptwVaVXFl3Ym/ChzSWKNSoJ1FplllB0q
	 FxZ/fBG7iBCec0fSzpGnZMWF9zGnCLsOClW0FYULO/ZQO6xqhDJM5mXBwFDcG9O7R9
	 ckDXEvUvj2UXTHXAV+eYJTHIYUZvVYQzIsMGaDCwm/dNugZl8EhFT2utwFlWwr/qLO
	 HfIQAJ2tkViwA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id BC4A7481D9; Fri,  2 Oct 2026 04:48:16 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916480;
	bh=n1YY4Ck2NNxTF6Dv0Dg+v2Ep1MCGfRSCuwmTVbpO6QU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NAQ9cR+JlqLgIBzwf/+0TWYwJb0+hitPgha1WVPZbomgPx0rC10moujXALziRd0G8
	 9yHPyPccQUBvjbOuO5ZAW07/cJOL33BA3Ai2nboyJhjFRmoQeKJItTrga0ASn9Mq+P
	 2c93JwEuQlqCqPCdDvYR/gjvU3+4/wlQrQYuvS1l9HXNhjIJR72N9z7ik3D534JTeW
	 bsGfrWU+dgYgxANq2NxHYAsfQyOsCcIygwOCsyVylNbQLrlzy6s1GsuYiwm9Iei6Cv
	 D3/6LBUNFSoGTF2mVrfk1W2fYtxxHGk/4AJaXSubJCDJE6/gFYDDEL0m+1x14rvuLg
	 2qpPmsEu52YRw==
Received: from AMDDesktop.lan (p5798b2cf.dip0.t-ipconnect.de [87.152.178.207])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 2CE4147DD5;
	Fri,  2 Oct 2026 04:48:00 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 02 Oct 2026 06:47:55 +0200
Subject: [PATCH net-next v15 11/13] ax88179_178a: Update driver name and
 information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-ax88179a-v15-11-131d9286fcd7@birger-koblitz.de>
References: <20261002-ax88179a-v15-0-131d9286fcd7@birger-koblitz.de>
In-Reply-To: <20261002-ax88179a-v15-0-131d9286fcd7@birger-koblitz.de>
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

