Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6DA4D90C6;
	Thu,  6 Aug 2026 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044987; cv=none; b=Q5weG2htbZVFli9G8hXcapCDxW7c1DFDUvY1QUYJtnW5vzrzBLiy230Rm0Qn62V0ebHHmhmE8XgqlOwODwZdKQ2tf2Q56DVMjDS8fqbjr2G6eCfPjnAJ4Uf7CbrrTraFduWIeGIwRJRlc2XAbD7GMzrtg48h0ukg2/h0LGThNvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044987; c=relaxed/simple;
	bh=5Y3YOI+/Ceht3PgLEUx1RdPmTljsgGdDUQunejb3310=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YqvgnditzX25ey65tabKuV3Fo6YKI11C4HJ4XY5f1Y2HnjhJ6eKbwA7vAr56bkea7GMKUWI4m/VO19vrxgt9Ez+pCRtU8NzzsODAxzTO2JJDmQ7RDo2qEozwuAA5w9Mg11qranNkkWAVoe+kKq1qyO68iGi6YJEkO8E1AsPV96Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=pocer9jl; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=lQI1IHIr; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="pocer9jl";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="lQI1IHIr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044983;
	bh=5Y3YOI+/Ceht3PgLEUx1RdPmTljsgGdDUQunejb3310=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pocer9jlnw8XPW5TKU4AhpVz+qoF6pLcRUpBpCMGISHOj2rhAWUOe3ieLzdfwwoAM
	 qMCDViGRfnhRfjNA7FR78auU9yEYWMSR3XgE4lKukF0bzgCSVivZVc+exLcCP7JMnk
	 ND+yCkls5G9gwy+M4VYeAUksO7ngb+heW8jwYn+RmqBtIvMjOobVyf6GwfdlxctXH/
	 6oKyiT75AyDAH0QwC/XYq3PfZLE35VPmzIt2ZOnMoidq0Xer4N7I/04Ggjj+NjJ7CT
	 lJeyMTZEImKwJb718udu9RhMChkPtePs7wWQoQ6y51dWTvo7i861s4Qj7PQL2sqQPX
	 0FX7lfdmRHS7Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 75CEE496F6; Thu,  6 Aug 2026 19:36:23 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044971;
	bh=5Y3YOI+/Ceht3PgLEUx1RdPmTljsgGdDUQunejb3310=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lQI1IHIrhaYmsrCAlwo6uaHfr/n/k+UdIp00PmsCulochN/VLqrzrjtosH8eD+mbp
	 l/R3GPw/T5HMZ0IqCfaYekxqFcXmaExrnuqr8NDSWvxACMFkJljSsb3jZV8Wy9yZ8T
	 UavdPTfl5r86mAp/ccwcHRHhT2RYs3O9axXrQCHW27gZSxJf3gCz64txExPSMFYhVs
	 MTvbOH2KPhcIcv9VeS6xLIrQf+KwgxKXDt21qz/oaLYkxOmMjwddbQ+ujSJM5taNEZ
	 Zmj15hRkNQNcomwQHv0dG3dd7faaUrIrLf6CUOlmfNGjL+3Fg8UaV3aLyJl/e0Ytlk
	 uI3zJMzA2gwUw==
Received: from ThinkPadAMD.lan (unknown [213.80.50.14])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id B16DA496FB;
	Thu,  6 Aug 2026 19:36:10 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Thu, 06 Aug 2026 21:36:09 +0200
Subject: [PATCH net-next v6 11/13] ax88179_178a: Update driver name and
 information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-ax88179a-v6-11-fde7414619e6@birger-koblitz.de>
References: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
In-Reply-To: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
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

