Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7483CB547;
	Sun,  2 Aug 2026 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688371; cv=none; b=pBGXaH5IOKHZbHL1DrE3AMxpWvnp6K+aj6e+WkDEb4Km184+cEJXbW3xSa9DpKS/IfWluIONg23VH5LJfUB3upnqsUk4WN+HRTMukFaLfcnT8bKdZ+uHmdLssOhvqCyBvmhOKtNYYmIrA9+oAkfEZbuWQgCmJWc9gkAP0sCU7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688371; c=relaxed/simple;
	bh=yJI1i9OovlKPX702eR4VoV2OZS2wvoRbasdSeeN/BU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IXTu8KFGB4zWZbJLNUz9kkanclKsv9AoNfJ+nuPtOylA3bzlZCH3NM7SG9s+u5+gM3PXwqHGMNTt2Igdgrx6wvZRSFf7SYmqDpBfHRlT37NjleQvEuvBoe64hAgjObk3MqleLMSi1LubPVpFrBE3LnggxRiO7D6hdx4j9yr8ZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=M6vjA+OR; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=aQkgWn46; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="M6vjA+OR";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="aQkgWn46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688366;
	bh=yJI1i9OovlKPX702eR4VoV2OZS2wvoRbasdSeeN/BU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M6vjA+ORTvM4gGJJ4r14dZRDJz9cBqeWAVLEr6wHgq7QTJRwGTOjTAlNgIOeVx22g
	 Y3Xanm6CaOYkVU7ak12yeDuMSEGyn+w69nFzSTFD68P7aL+13PSvoQ3+4M+tdKILZe
	 59QWV9XeLVaQabYy+P1+RENp/MRcT3PXWqQVjBX3/Je7Swp/OIGMRdFnsSVgfRWvUz
	 9WhDELex8Bs8bXA7e4DraEMT45jNK+ZALEoXsqVAvZbJwVGwYUjyS9Ux5y9m49+Dfn
	 mSOauXISVF7lSrSlQMOetmfy7sECedhb4axm/p+xwAJa8DmCtRQxVMuNstOYyMUN0Z
	 PrdvRaxeao9+g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 76FB54965D; Sun,  2 Aug 2026 16:32:46 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688357;
	bh=yJI1i9OovlKPX702eR4VoV2OZS2wvoRbasdSeeN/BU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aQkgWn46xqLUyL+QjOFvDYzafirmX0NyTII6JuymYtK+UdQzxIhWkZUU/QjA+mU6M
	 xMnq7ty/vayRp1ewgsrXmyOn4byXd9o2Xd3/pvdDxkSNo7OQeItqnBKfj4KDpBAjqm
	 VLupyQKE6SIwqXefItAPowRH8ejLnNedxLLG5BCBabXafLA0oH4WOQ+yUH7WRD03PU
	 /IAA6B0/M+ozzejFHji+dL9X80jayyzgrhuno19aO9QCPpiJZPH1IdXmyP9k/gA6e7
	 +QJ8fZKRP2uRFMlVeLqSAtsvzJHodncfBVuwKjVPmoVmiw1sHj0JEOhgagf9GtP8/k
	 ApqgRN+5rJ/jQ==
Received: from ThinkPadAMD.lan (90-227-251-202-no2480.tbcn.telia.com [90.227.251.202])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 23F0B49651;
	Sun,  2 Aug 2026 16:32:37 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 02 Aug 2026 18:32:09 +0200
Subject: [PATCH net-next v5 11/13] ax88179_178a: Update driver name and
 information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-ax88179a-v5-11-dcb9fea4acd4@birger-koblitz.de>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
In-Reply-To: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
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
index 8c22c2517cc08249c4e89625f142a76d4edc7d6a..6d6ee39b342e9b4e008bb2c1ee276dc27279a2f7 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1339,8 +1339,8 @@ static const struct usb_device_id products[] = {
 };
 MODULE_DEVICE_TABLE(usb, products);
 
-static struct usb_driver ax88179_178a_driver = {
-	.name =		"ax88179_178a",
+static struct usb_driver ax88179_driver = {
+	.name =		"ax88179",
 	.id_table =	products,
 	.probe =	usbnet_probe,
 	.suspend =	ax88179_suspend_wrapper,
@@ -1351,7 +1351,7 @@ static struct usb_driver ax88179_178a_driver = {
 	.disable_hub_initiated_lpm = 1,
 };
 
-module_usb_driver(ax88179_178a_driver);
+module_usb_driver(ax88179_driver);
 
-MODULE_DESCRIPTION("ASIX AX88179/178A based USB 3.0/2.0 Gigabit Ethernet Devices");
+MODULE_DESCRIPTION("ASIX AX88179/179A/178A based USB 3.0/2.0 Gigabit Ethernet Devices");
 MODULE_LICENSE("GPL");

-- 
2.47.3

