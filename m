Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794243499;
	b=H2Ybi0ZW3aT/8gKJfBwTe4rhkSzbEvk4d530LNc8mtzDdKnM4EZJaHq7AU8gnZAzPVDj
	 m2EndbHs81HvI/fDvjRabXKMBHqqfc/EAoBD3PFZ6j6zDkh1nO2nsnV/55b6u/LME/s0S
	 YE7Q7YAWc/KH1ZIMTZElWuJ9yU3pUypIk50AZyW0TRvZYQXIWspLHSVBItLhEYXZaYAfF
	 FIwaBBZugzBDHqk1ErtqpGj/l954RT5CSFHZUksFEcfxKRATKGrpTF4WZBYTHJphQwFoK
	 7w4oNKAttuqHMmSICGrB6ziZ9DsNKzavEGSvFuZdi1asTJUVZlGpHBnh/xMjJvoB6Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243499;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=04wIlAZbBBFLI1pA4/Ovc7MOg/six0fgzdXInH7VT0c=;
	b=aZamLma4KTNdk8iM1oXZSV6AYIoH1GOsXlR705XH03YuiTynjxnPe7DezjeRkf9ylE3l
	 Dx9f/GoKZQgLNOvDvPJHC/OD78TcpttzTkxwlVoY9CAVRdTne21+HxoTtLk7A9ld68eaD
	 EFKNRkKyPnWhuavbJzcKI1DaS5VqIJVCGTf3ZVS2d/MMxf4kyLdFI6oezF/IlWaxp37DI
	 IIUEdSGil2JFocK0cDs5K4CdiIxGOQ8nRB/WN7zfRTpxx0vVE84kAXGaiTCZ+hX9yQCJ2
	 b0lqn6LU2TBkMjku8VBOH+GYwkFGH1IgQlr06onk4ViXyhi1Zmi9JsuHKga9c75H4wQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oK8pr/6H";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A260E606A42B;
	Mon,  9 Nov 2026 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK8pr/6H
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794243499;
	b=pI+ZnuNCKpntsuE6pArlg8hOOa1LyKtngxd+y8/xKV5axXimOUJgBLlN1aBLVAKbI4RL
	 Wx2uRSeHkpArNeecnF2k9+r2ZDfN2YG5UfsEsMSXdFfDnEwDHpLI0wZelBLgcFNatuF0J
	 5ggYmw8YjqV3UagbrNUXOKL17MZwB61xakLWz1h1S8Ry3fncWfTLZkdtYHafA0Pv7G5T1
	 Z56+FJeTOtwo3ETGhJwb4B6oN0qF63QmVbAPflZvs6i6eBM9YBwal6j4SFJM1elwR7WS3
	 gqL1HIENeY7B/PaWcqWLHdNDCBDWvgjGlokd7GuBmLJuIsYdH7QrDF0bdHsiqbNpi2A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794243499;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=04wIlAZbBBFLI1pA4/Ovc7MOg/six0fgzdXInH7VT0c=;
	b=cP8dFBE1DrFpxIK6h1xM3EcrdGgq377q2epItrzV05Qh3QGuJSeYCgu5nfgiMPqkgU96
	 Ew+Me+nd6mWuICULB016T+Zy4HNMVh2ALTUkjt7JwuFWhX3qucYZCfBWIqqatjNLzyMs8
	 3a17h4dtf8gjxCLFNLN/fmnznbDlgwDKIOcg7ncYzfDAyxQaf4R7Hhjjl+BzgyE3Z/GDe
	 joNQxFNl3YdQiSJNNen/gxHF/acKju93Onety9rkXjq3bzSQwtYJsyfpOmlPzYu3Lp0s+
	 0RkLHmhH1or4crOB8DdwHtbrmfubo5BRgULiLTMvqucNxbkKfKoNM1v7KJjF/3lkq7w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 98C671F0089F;
	Mon,  9 Nov 2026 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794243499;
	bh=04wIlAZbBBFLI1pA4/Ovc7MOg/six0fgzdXInH7VT0c=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=oK8pr/6HljH8ktY2RK8fjE+m+xekvFRuwnJj2YTb7j+2Cul0gCe3bPBqjwp/Mj1mP
	 JxQ43pDi6ghAMiz1mlLinJ118NS84gV/JqDbUdgr3tfzl0O2AAsJ9cuLxjENingGUL
	 Bw3Scde8oJabjH9f41d1kRzIHGrBrxr8ofVlUHj197wB4i+tHbjEOUzphdtqjdLNuZ
	 ynvLfHZWubAyyuOesbmwK9W9vE96MpiDprAExsv/FShKubwHGPpnf//aABsptuMgSg
	 E3JI0xScB4glfcliatw55aiI6Qpj1W1Yjp6gdfE5pyviUe76eZMXwXmVwfPUL9iLno
	 Q8ZnMR3KS7kmQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2CA1E4853A;
	Mon,  9 Nov 2026 16:58:18 +0000 (UTC)
From: Blake Alexander via B4 Relay <devnull+blake.alexander.airbus.com@kernel.org>
Date: Mon, 09 Nov 2026 17:56:30 +0100
Subject: [PATCH net-next] net: usb: name usb ethernet mdio buses reliably
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
Message-Id: <20261109-net-usb-mdio-naming-v1-1-f4cca6737784@airbus.com>
X-B4-Tracking: v=1; b=H4sIAD378WoC/yWNQQqEMBAEvyJzdiCJbHD3K+JB46hzcNQkiiD+f
 aMei6K6TwjkmQL8shM87Rx4lgQ6z8CNjQyE3CUGo4zVWn1RKOIWWpw6nlGaiWVA1xamt6X6uMJ
 CKhdPPR/PagV3IHREqF/jad3STXx1fV1/74gEGYQAAAA=
X-Change-ID: 20261109-net-usb-mdio-naming-cb32f6805c36
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
 UNGLinuxDriver@microchip.com
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Blake Alexander <blake.alexander@airbus.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794243402; l=3082;
 i=blake.alexander@airbus.com; s=20261109; h=from:subject:message-id;
 bh=Aq+iM0Hh6B0JDL8TaEt+jovCKbEtmkgqtg3fnPSTJ7g=;
 b=zQtsDUC3IQ/9zbR59Oke/23oXkcipe+Aoo0hYfR0yshRy6+pJHAYpnxqU6DhpgCnfUZ9j4sO6
 creHUuquyHCC2m7dmNf0wVECO2+pfqkrStd6/TlvRj0bQ5/4SNqnNdh
X-Developer-Key: i=blake.alexander@airbus.com; a=ed25519;
 pk=cfpa2FQbYHF1zxIJuHbr8W+NR9T4DK/baAknnTv2I68=
X-Endpoint-Received: by B4 Relay for blake.alexander@airbus.com/20261109
 with auth_id=1461
X-Original-From: Blake Alexander <blake.alexander@airbus.com>
Reply-To: blake.alexander@airbus.com
Content-Transfer-Encoding: 7bit

From: Blake Alexander <blake.alexander@airbus.com>

Embedded systems may utilize fixed USB ethernet controllers (such as the
LAN78xx series) which are soldered directly onto the board. Currently,
the MDIO bus names for USB ethernet devices are non-deterministic as
they rely on the USB bus and device numbers (e.g.
"usb-${bus_num}:${dev_num}").

For hot-pluggable devices a stable MDIO bus name cannot be assumed.
However, for systems using fixed devices, user-space configuration
scripts and tools require predictable bus names.

Use usb_make_path() to generate the MDIO bus name instead, ensuring a
predictable and deterministic bus naming scheme when attached at the
same position within the USB hierarchy.

Signed-off-by: Blake Alexander <blake.alexander@airbus.com>
---
 drivers/net/usb/asix_devices.c | 5 ++---
 drivers/net/usb/ax88172a.c     | 5 ++---
 drivers/net/usb/lan78xx.c      | 3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 293ef80c4e30..c752fa3868b8 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -680,9 +680,8 @@ static int ax88772_init_mdio(struct usbnet *dev)
 	priv->mdio->write = &asix_mdio_bus_write;
 	priv->mdio->name = "Asix MDIO Bus";
 	priv->mdio->phy_mask = ~(BIT(priv->phy_addr & 0x1f) | BIT(AX_EMBD_PHY_ADDR));
-	/* mii bus name is usb-<usb bus number>-<usb device number> */
-	snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
-		 dev->udev->bus->busnum, dev->udev->devnum);
+
+	usb_make_path(dev->udev, priv->mdio->id, MII_BUS_ID_SIZE);
 
 	ret = mdiobus_register(priv->mdio);
 	if (ret) {
diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index f5036451f086..9f050de0cddb 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -73,9 +73,8 @@ static int ax88172a_init_mdio(struct usbnet *dev)
 	priv->mdio->read = &asix_mdio_bus_read;
 	priv->mdio->write = &asix_mdio_bus_write;
 	priv->mdio->name = "Asix MDIO Bus";
-	/* mii bus name is usb-<usb bus number>-<usb device number> */
-	snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
-		 dev->udev->bus->busnum, dev->udev->devnum);
+
+	usb_make_path(dev->udev, priv->mdio->id, MII_BUS_ID_SIZE);
 
 	ret = mdiobus_register(priv->mdio);
 	if (ret) {
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index d73002b2c21a..153aa56b8e68 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2117,8 +2117,7 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
 	dev->mdiobus->name = "lan78xx-mdiobus";
 	dev->mdiobus->parent = &dev->udev->dev;
 
-	snprintf(dev->mdiobus->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
-		 dev->udev->bus->busnum, dev->udev->devnum);
+	usb_make_path(dev->udev, dev->mdiobus->id, MII_BUS_ID_SIZE);
 
 	switch (dev->chipid) {
 	case ID_REV_CHIP_ID_7800_:

---
base-commit: fa5196392691051963726787944db872420dfa75
change-id: 20261109-net-usb-mdio-naming-cb32f6805c36

Best regards,
--  
Blake Alexander <blake.alexander@airbus.com>


