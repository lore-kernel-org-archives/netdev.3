Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739143E4C88;
	Mon, 31 Aug 2026 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170358; cv=none; b=FX82LXRR+/3genn2ilWrM2WlfYFJ5sRBSufrgY7ZAXFDvqA6lvdCJ8PqBEPIwdquIYRoA4JveCirObUd+R0Fm/e3gFqrfY+/U2xkLbTqWExMRzBTTJURzQlNn8uAdlZ/XPXkLo2DvP9gxYR6laqRFJYslO1rcdA2oEG5bokhKPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170358; c=relaxed/simple;
	bh=5Y3YOI+/Ceht3PgLEUx1RdPmTljsgGdDUQunejb3310=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gTNU+T5OLjs/PQIwnfLjrqDUzTzdEpNu0aUKISpyOoD+rCes5w9WCXABGyVJIgrEWFlLpvaAHRsBY26L23D7RYpbbCngtZCCyTomcsh+yKr6nIE9ZLKkJ5+zs+HNxXXNVfgyyirJ5Vq4KaZ7CSdIad0g41UKlRarRY/hQFYbaxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Ce28VDcp; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=10Ehu1Vl; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Ce28VDcp";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="10Ehu1Vl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170354;
	bh=5Y3YOI+/Ceht3PgLEUx1RdPmTljsgGdDUQunejb3310=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ce28VDcpdUODHEMBIf6yzSQGv1wVkTM7m9D+NH4mMt1Cl+IaqRwkPU1XYeGRsvnYM
	 7DcgXCuD9FFiuqO+6aooYOfQIBm7hNmYell0QHDsVCzbsBzFbhRttxET19SzEUhery
	 KrazWKkesbWYkUMvBYqsg1+pzVFHGY7JEgo9rbRJ3T4+N3wRY8CKpt7LO9iIYhMbn7
	 TP4/BDQSaaVNnYFFCEHZ9MtCLstwyhHAD7vUsMFkjQqpp9RWkBoXdh6+nSslTU6BKg
	 +v4rllTnufKhjOLyRCWfbs8dSfF5gac1o7IIRkAA3oaykLTaflGfYj3HtZsUNmQnte
	 Etl4ghFfITSRw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A4D763EC7D; Mon, 31 Aug 2026 09:59:14 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170341;
	bh=5Y3YOI+/Ceht3PgLEUx1RdPmTljsgGdDUQunejb3310=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=10Ehu1VlNhtlnHTy6m40CpJRxL2FV20/6XSchtNA2WOJwb9FE3TotSdpul20uYWUc
	 V/fhQRb9g0MBdXkFDLhjzMr5DGk+YRoiK/3olYnSoi3fX4fh4EElDO2BdAFd05/gb/
	 KgtN6p2ZQEQS+sai5Rm7az/cQX7tzYL/hgwPB6htwpDMyGPoUz/U2tHc5HgUrSZwqv
	 lHK4iFf0Pu56jZ2n1/cV+lF2S7GIFfVX41zqCjCHry6/SOloOLxF8UJclxENTbaKzS
	 qX2Dh8DZDpHu/XbK0N5ON+6fpiYAyLahloXFvazGosMY30e6FlzGtgOh3jNspJKuG6
	 R4kj/5r7cohgg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 89E033EC1C;
	Mon, 31 Aug 2026 09:59:01 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 31 Aug 2026 11:59:02 +0200
Subject: [PATCH net-next v8 13/15] ax88179_178a: Update driver name and
 information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ax88179a-v8-13-de905f2ee426@birger-koblitz.de>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
In-Reply-To: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
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

