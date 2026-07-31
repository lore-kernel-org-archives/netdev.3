Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD9323D7F0;
	Fri, 31 Jul 2026 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514773; cv=none; b=j9pKFMrwti+yryz1XCVPE61V3wVu3pclIyenrhbdIFYYPRYCR5GAp6Mx9eOHkYfAbBuVdvfn5p6Y5znVIK3oHgO997xCgcTfNZQK1xDYW2y4jj0SY7K2YIQ0/1IXcP9lc74VB4BL/8ZmhE7TPJVw9qLfC0l+LcjsxO067A9p6xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514773; c=relaxed/simple;
	bh=n52GD0YCx7hImSTm5nuINJr6hL1I8HQkqX/QYmEJipA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UJ5qP2vNeIlvjPW+0LEnSOKKRq5TuGJkTtOKuhthq1wmFY+L4CcqlwjRmjtq2K0F0nTe2nlzyH42VNNcyhiwXI5Qh2M+eTn811YiWAAhRcmIJakK8wkPcnRLr5wpgiymPMwyAu5+6br5gasg3QbPqsT3kamfJKWWwu9Pehsxcvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=rfZgGYyU; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=KF/Ui5ft; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="rfZgGYyU";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="KF/Ui5ft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514757;
	bh=n52GD0YCx7hImSTm5nuINJr6hL1I8HQkqX/QYmEJipA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rfZgGYyUzr1aTU+YwXF6A72WKLuavEq/QKBNmumi6q3LVhzi8vN0VT5KwHB3Pcs4E
	 VPsX43poC5V1+75atVSXV05vPw/2bz5QpIi8/h5GCsqjB76vA6NVxSqtjp4cUSOfA4
	 psoJn7/Are5Vdva/cqkOFesTi8oacPpMPjvnah5CwZ6/I9fOiUqNVtKD5JE0yUctHN
	 8up9ruLELzTr6Zz4w0TwsGiCbuU5uNNCwBBuPq6sStcxuqCdZDNTdVUZpmUtiA2VCY
	 EoqQhTe29cT+PsX2ZxLE5vWsPnwxTrqsKudSxTwrLKth/EylYQiu4lSUbJioPINJ94
	 ALDQsA/oWFB4w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id EBCB049507; Fri, 31 Jul 2026 16:19:17 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514746;
	bh=n52GD0YCx7hImSTm5nuINJr6hL1I8HQkqX/QYmEJipA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KF/Ui5ftaWOlV4iRtigXQXsYlVQ3Z6CCwN9eK//b2K7DXMiPrODKqeJAI6yP08Hxy
	 z4a7lRy5hlbJxLHUhRVDcih/ohybrtQxxKBE6Fi7VmnnibGSW4EfbYukgS0VB4Rj7J
	 BWFeHymWfT1P79kWFVLhJ5o3se01D24onbcv71bk1BOaDiLm7ULmfN0skk5RjTNTpp
	 WTT9+w9sL/NGvD03cIYQU2z6RfdNeqb5P4ZmJ3mCPUppy5vRMhpGXGbUI52OdtOnFN
	 Gkkvn78a0MteVAX3czmmpsE3cVY/sHGJerxRY1CMZ0LaSCUQBazJWVoliBKca4EFSC
	 DR4f5WNK14xPQ==
Received: from ThinkPadAMD.lan (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 3B773494F5;
	Fri, 31 Jul 2026 16:19:06 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 31 Jul 2026 18:19:10 +0200
Subject: [PATCH net-next v4 10/12] ax88179_178a: update driver information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ax88179a-v4-10-2cf1f71b1dd2@birger-koblitz.de>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
In-Reply-To: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
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
 drivers/net/usb/Kconfig        | 9 +++++++--
 drivers/net/usb/Makefile       | 2 +-
 drivers/net/usb/ax88179_178a.c | 8 ++++----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 52a5c0922c79fc52906d4d4040ec2b3411ff0984..06d3473858670c6e9c60350287bf3c6e30babc81 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -195,9 +195,11 @@ config USB_NET_AX8817X
 	  This driver creates an interface named "ethX", where X depends on
 	  what other networking devices you have in use.
 
-config USB_NET_AX88179_178A
-	tristate "ASIX AX88179/178A USB 3.0/2.0 to Gigabit Ethernet"
+config USB_NET_AX88179
+	tristate "ASIX AX88179/179A/178A USB 3.0/2.0 to Gigabit Ethernet"
 	depends on USB_USBNET
+	select PHYLINK
+	select AX88796B_PHY
 	select CRC32
 	select PHYLIB
 	default y
@@ -207,6 +209,9 @@ config USB_NET_AX88179_178A
 
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

