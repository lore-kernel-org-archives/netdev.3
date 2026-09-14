Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9F476043;
	Mon, 14 Sep 2026 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390059; cv=none; b=QhCzDSmEjZ44GHgCS7ZnkdDx53SQINlDYFytDWloXxfnVrRhMciN6rUNdz6wsCzomdkzu5h0Zh4Ru3FghMvbYmf8A3qPpdnusVwGfs9V8ZIaA5G3WEoWEFzUBXG+92xy+UCEeeYoCKzgMVvXp+q4aV+MMGiDBb717wF3DWVZd0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390059; c=relaxed/simple;
	bh=YaYhpYb8ITKG2lZdph7RQGOKNSrerEFmw8Vd3AguqH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlMDp+tMrc4w/oIFM/TO8mQUd4tbT6ErOMYxH5cevJM48AimEVjGb6uFeL0UhQVNwriV+z4cv6Cn1kDzJ45hj+2JQRSJ5RpcXakPHWGpTrzjI2rrUbzmBW9JQJD+TRIhB5Aab5Lmyhla3So2EOYqH7wsKFCVSrzMyycIPXvoooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=dTy09woa; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=pkB+e2Rz; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="dTy09woa";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="pkB+e2Rz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789390056;
	bh=YaYhpYb8ITKG2lZdph7RQGOKNSrerEFmw8Vd3AguqH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dTy09woa7qQH+7yAE66uzg9FbsdN4b0ueAioiWcZXOV+mJf1O1S+550yPB+CNViHR
	 7lPpycOk829TIMvGz7XHKdsrLyqrOA0EBBrK0k0h+6bsKgYcaFrzgFvs+T9P8OapqC
	 Th8ixzDNI6UBLsAMI9WcVHNhwL7ACCN3DTQ6ZAreQ93WvMjL9DwDEtzmQON0hbo/pa
	 OvUGbt51PskdZsLqdKIAuHNwb1dvmp0xGZfoRUqCN3qzfZGBhFzVr68lOLZLRVxLv3
	 J6QxxDE4LK9iDlbp+g6bog1dVfVEwpaYHqd/An/M1dkTQfjv36kXefGNSFgcbDrRV0
	 qvc1mILf8rR4w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 611DB3F6DF; Mon, 14 Sep 2026 12:47:36 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789390055;
	bh=YaYhpYb8ITKG2lZdph7RQGOKNSrerEFmw8Vd3AguqH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pkB+e2RzwljrS6I+SsgJNjUiXI3xisb57DFkzh35nAv+T0W+g/a8sRBiURqNBzc80
	 Sey+hiYiVlqKtO5opAsI7KlVUpzCWf29mm9Gwrd5dgENO8ks1ckbT3takA2ntbllqD
	 AP91/6Af5gjG1MPLmxQfQL17NSpditocNcDVXJKRavyIEiQx/x4W0Zl9nTiXqy43in
	 d+dnFim8eoVS9FjdbwtKcJlnkK3XvZGloDqUoCE7khLT3s91Ydg1g3lZ6qO/R7sMZ4
	 zVOE9xDqoReK4CYHinic3ZJob/9vjg8otyMbA4swjfoognRsi6QnuIiP2i54+gbEWe
	 9uy/jdUB1K+Ag==
Received: from DELLLaptop.net (unknown [IPv6:2409:8a62:2532:dca0:14f4:3e22:1e7c:23c2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 7C8F33F6DC;
	Mon, 14 Sep 2026 12:47:31 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 14 Sep 2026 14:46:22 +0200
Subject: [PATCH net-next v11 13/15] ax88179_178a: Update driver name and
 information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ax88179a-v11-13-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
In-Reply-To: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
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

