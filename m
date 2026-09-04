Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125A511221;
	Fri,  4 Sep 2026 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542945; cv=none; b=jAyOxQb3m01Wnki2koV21BREQj90OxmGWrGV7lWoz/2Oea5IkVRmf/qiQ9GE4orPg51pS3RT24x9W70omzYOxaqHClMfVQ75A/fzhE/hWTAPntfdNMWU6X36vH2dAZ3m6CM2K13d4e0OjPVEl/KVfkKtStVH77lkqq0E2iguv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542945; c=relaxed/simple;
	bh=YaYhpYb8ITKG2lZdph7RQGOKNSrerEFmw8Vd3AguqH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFsyjNNkpTeYQhoMiRFIPXLRdFsj+cTCvWV08cLZWSmmCxvFI8aouawFN8xHsH7FSABfciGvXcXjMuDtmbwZgUNgQkW0ZDzapYyTukTrUxSmQNBcsZ6Y2q80KadwGALDk+uWBDlvZVwTa0kO5ENlMSczkgbUYLf4bittI+KX3uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=aGOk3VqO; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=1hUkZKDa; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="aGOk3VqO";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="1hUkZKDa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542931;
	bh=YaYhpYb8ITKG2lZdph7RQGOKNSrerEFmw8Vd3AguqH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aGOk3VqOnoBJsatvDYT/xbQYMf81t7ypvEn9eCG9Kx83OAg8qSQCsFocLKi3AuS+C
	 RfPhb/i7aCRifrQuWvyi3KJ+y2/anGnuVcCPaPu4q8HwPOL94r1uY4lQDo1fwpIdD9
	 L/OKYa1WbVknIYukVp0DoFIJMCIj+OiY8oEq8f0p1Xkwg3Cv+5g7dtqSBcGOzIFREV
	 LWOwORw+g4jB3cmUAf7JDFYx/x3JcfuRABoZCVV1CxiY58O9A698btWE9jqBGnm7SA
	 i5AcdWSfNBlDGDjD351pSL1Ioq9lN6R/Ngsd6c40udIGaedHt47Vk+S4+/thHGprwZ
	 X/ZI6BaNWozdg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 7B09B3F0E8; Fri,  4 Sep 2026 17:28:51 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542918;
	bh=YaYhpYb8ITKG2lZdph7RQGOKNSrerEFmw8Vd3AguqH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=1hUkZKDaShq2g4va3hYuCDtSnZm8Y2SaLvupahMpddt3FrFBqO9+FFXJisV1YZYN4
	 HbpF2uU0QX1CtAJwRYqAZ0qei75igcIfvNtaELu2w18sxcYyV3/CjiXdaRzYaSLmZm
	 nXWGiyNtR1h3vLgpiCNw6kgpK51rAs3fP4NPSkFnRioqxn2InCn6pA//xuDqwJgBXI
	 l5oTlIL3YgHJZ1z/+6YcbLQejXZCpILPS2QGjbTt/oTdpCAfHZfs6VkTNEFquD6yrw
	 +JEkyR4SUhxRpiouqjbXO4qVfvAwI1FDXqMdlIxUBrAHqWdLuRfU+o5dmEbAuEhIRA
	 8fZWBKT/ecZFA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id D03303F0DF;
	Fri,  4 Sep 2026 17:28:37 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 04 Sep 2026 19:28:38 +0200
Subject: [PATCH net-next v10 13/15] ax88179_178a: Update driver name and
 information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ax88179a-v10-13-b5e60eca7690@birger-koblitz.de>
References: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
In-Reply-To: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

Add additionally supported devices to Kconfig description, add
further requirements such as PHYLINK.

Update driver name in usb_driver and update MODULE_DESCRIPTION
to include the additionally supported chips.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/Kconfig        | 10 +++++++---
 drivers/net/usb/Makefile       |  2 +-
 drivers/net/usb/ax88179_178a.c |  8 ++++----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 115990b0d9537aea2776544c9768b034f32aa7a4..4158455a2da76cd43a9a9d9d0e8c66028d57b095 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -195,11 +195,12 @@ config USB_NET_AX8817X
 	  This driver creates an interface named "ethX", where X depends on
 	  what other networking devices you have in use.
 
-config USB_NET_AX88179_178A
-	tristate "ASIX AX88179/178A USB 3.0/2.0 to Gigabit Ethernet"
+config USB_NET_AX88179
+	tristate "ASIX AX88179/179A/178A USB 3.0/2.0 to Gigabit Ethernet"
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
index 44a768c5808ac1f7071e186d9c86cd6149601971..1d35ef90eceb77b27e8d96e64a008c63b40f4bd7 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1341,8 +1341,8 @@ static const struct usb_device_id products[] = {
 };
 MODULE_DEVICE_TABLE(usb, products);
 
-static struct usb_driver ax88179_178a_driver = {
-	.name =		"ax88179_178a",
+static struct usb_driver ax88179_driver = {
+	.name =		"ax88179",
 	.id_table =	products,
 	.probe =	usbnet_probe,
 	.suspend =	ax88179_suspend_wrapper,
@@ -1353,7 +1353,7 @@ static struct usb_driver ax88179_178a_driver = {
 	.disable_hub_initiated_lpm = 1,
 };
 
-module_usb_driver(ax88179_178a_driver);
+module_usb_driver(ax88179_driver);
 
-MODULE_DESCRIPTION("ASIX AX88179/178A based USB 3.0/2.0 Gigabit Ethernet Devices");
+MODULE_DESCRIPTION("ASIX AX88179/179A/178A based USB 3.0/2.0 Gigabit Ethernet Devices");
 MODULE_LICENSE("GPL");

-- 
2.47.3

