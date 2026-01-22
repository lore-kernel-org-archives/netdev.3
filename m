Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B7F339873;
	Thu, 22 Jan 2026 04:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054453; cv=none; b=gv0aFchwx4kPEV/nRKeab3OZF7XzZ4qVOzWH4pBt10Ll1mVRX5UelXbCYUKfKcsSbsmz8p1q5le0arK6dX5KZ9bdNIdakvg+23+tVBKbQ0JkLA4/fhUdlk59UhqRbJl6ythRfj8BEUtbpljMDi5hc55/VhpvaRAp7FQaXVnvBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054453; c=relaxed/simple;
	bh=z4LrY/Mb3JCN3vI2EiudRCRLYA51QvpKnsU1tbajbb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ekDex3UZ4jcK3Bqn04wI8z5WqGihvMEloPwMbaSKmb/U1fVrDrOuh1eClhyBz4b8hLafmDPl1p8aI1tyXvtXMWUJqUjAz/3yKMcM5/Pd5XWgOghaDAB39P8gEXWJ5V2ZPcbkUXGi2NKdeUN6IpsX/ExWfqEL4PUPL3UgiljW4uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vilsD-000000006RY-1My1;
	Thu, 22 Jan 2026 04:00:45 +0000
Date: Thu, 22 Jan 2026 04:00:42 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [RFC PATCH v2 0/2] net: mdio: setup RealTek MDIO polling registers
Message-ID: <cover.1769053496.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Some switch SoCs supported as DSA devices such as RTL930x require to
setup hardware polling of the PHY status in order to configure the
switch MACs, there just isn't another way to setup MAC speed, duplex,
flow-control, ... settings.

In order to reduce code duplication it would be great if the MDIO driver
could expect to get a pointer to the fully populated 'struct phy_device'
and use that to then setup the polling registers based on the PHY type.
Obviously there will still need to be register definitions for each
supported type of PHY, but generally there aren't that many different
kind of PHYs used on those switches, and already being able to rely on
phydev->supported being intialized helps a lot.

Please take a look at the downstream MDIO bus driver for RealTek switch
SoCs here:

https://github.com/jonasjelonek/openwrt/blob/5f4c692319c66dcff9602441d5512546c81d7a1e/target/linux/realtek/files-6.12/drivers/net/mdio/mdio-realtek-otto.c#L864

Note that the driver currently re-implements MDIO bus scanning in order
to figure out which PHYs are on the bus, see

https://github.com/jonasjelonek/openwrt/blob/5f4c692319c66dcff9602441d5512546c81d7a1e/target/linux/realtek/files-6.12/drivers/net/mdio/mdio-realtek-otto.c#L798

As you can see the polling registers of the MDIO bus need to be set to
MMD device, register and bit-inside-register values in case of Clause-45
PHYs to deal with half-duplex and 1000M advertisement and LPA the
controller needs to be told that it is dealing with a 1G standard PHY
(plus there are some proprietary extensions, like 1G over 2 pairs, but
never mind those at this point).

This is due to the Clause-45 standard lacking clear definitions for
these features, while being able to rely on standard registers for
pretty much everything else.

In vanilla Linux, drivers/net/mdio/mdio-realtek-rtl9300.c currently
relies on the bootloader to setup these registers, however, on quite a
lot of switches the bootloader only does this in case the user
interrupts the boot process and loads firmware via TFTP, otherwise
Ethernet remains uninitialized. On some devices the U-Boot environment
can be customized so they always intialize the switch and MDIO
controller, and rarely vendors decide to just always do it.

In order to efficiently implement setting up the PHY polling registers
of the MDIO controller, add a new hook (*register_phy)() to
struct mii_bus which is called once the PHY is fully probed and it's
ID(s) and supported features have been populated in struct phy_device.

Use this new hook to setup the MDIO controller's polling registers
without having to maintain an excessive list of PHY IDs, or re-implement
scanning the bus.

Daniel Golle (2):
  net: phy: add (*register_phy)() hook to struct mii_bus
  net: mdio: rtl9300: setup PHY polling registers

 drivers/net/mdio/mdio-realtek-rtl9300.c | 82 +++++++++++++++++++++++++
 drivers/net/phy/phy_device.c            |  8 ++-
 include/linux/phy.h                     |  3 +
 3 files changed, 92 insertions(+), 1 deletion(-)

-- 
2.52.0
