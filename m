Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01813546C6;
	Sat, 10 Oct 2026 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791608074; cv=none; b=WW87TLTVElan7FPiDEdhJ8W09OMDt8m2U2sx5ln7VWf6lH1WRYGKq8FMMRnIfGVjzMjPenh31+2XQMB7NJfHMfWIE2VjQ1Rf/sm7LG25rIbC6PE83DMYeUNoFZrvQbl+hgAQL9l2bzeDgWQ9bwp+/hWP3sywG2KKGUaSe6mZ31c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791608074; c=relaxed/simple;
	bh=gNeiBeIBcPq+3N6f0e6/oenfPkBMrSQA5YVjwdyOuis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OTGvkvoS+GEPIEr3+LWMvQOG4A2cpiH6iLJ6CYu+SKZEBFi//aW5uSCA+ObMT/ib4rJ/BJ6ii3g1boMMK7PA3zBWNwYh/6o64ka2X0BwrtGalYiB4w/ZTFakkQgxgtJtvnMnpHBpeTnsJxBnMWKzi23ND2fDUVspm5YQCF1OZ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=eb1yhTRB; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=1gqWCmlH; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="eb1yhTRB";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="1gqWCmlH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791608072;
	bh=gNeiBeIBcPq+3N6f0e6/oenfPkBMrSQA5YVjwdyOuis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eb1yhTRB+TfZCExFttxZ0SCdvxXzueXAj9O9FD7lM/guu0nBhEpj/rJHaz922yOgp
	 JFuxH98+0kCS/XV2S8zKILKgn1niZNKo9Or22GLv+huqZKvDlgM7GcHMSQRySBgdhh
	 3ClxmWFMKsj3C5aSzTgsXYsse2+zYySt3KQcZyB3ejuZQ00iSblkOBcgr46CcVvNx9
	 BTvJ21q1d2u4rVyDedUkVVZ1qDmDSfZXDXXjmzqus4eOswi+IhS9ZuoC3kJIvy1bpX
	 QI69v36hyg40ZZF9406B3hVu7Xo7NZCn709jv5LQ2208EX1LfcU/jZXTseNyTEexyX
	 y0b+X6ge1/cMA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 1B7E7475D3; Sat, 10 Oct 2026 04:54:32 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791608069;
	bh=gNeiBeIBcPq+3N6f0e6/oenfPkBMrSQA5YVjwdyOuis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=1gqWCmlHXiKJehtv6t7NUd6kFpGch32ixzABkPPKFLpX6kkNQ8cz5Gy+w71izJxBH
	 VVdXq9vumh8qqvdHJiYd27iO7aESxW7xyUCUF05MU3iluTzgot+VNOuZmr+JNwRW9j
	 2p3ELCboXo/xAf2ZcZfHfGQc0YSsZ0/gW6ETU8+6EcBLtpvTgmUFmU4tU+G/VQwTnN
	 5qJOtjvoFIDdmLuaUjleqIzrKEaZ6IOHLrsZiBJPoz7xmqyuQeqjjimIRXXCh9jW2c
	 U6z+UY6HSSWHN12M3h/H+pCME0IiisFe+wfhCIVhhPLSoxAvyk7iKaMjtBTUM2XToJ
	 AkAtUJXOE4E1w==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id F3D8B4752E;
	Sat, 10 Oct 2026 04:54:28 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 10 Oct 2026 06:54:24 +0200
Subject: [PATCH net-next v19 02/13] phylib: Add support for PHYs with
 broken forced mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-ax88179a-v19-2-7475173cfb56@birger-koblitz.de>
References: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
In-Reply-To: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
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

Add support for PHYs which only supported auto-negotiated
speed modes. This prevents a kernel warning and stack-trace within the
phy_state_machine when PHYs return -EOPNOTSUPP from config_aneg()
because they do not support forced modes.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/phy.c | 7 +++++++
 include/linux/phy.h   | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fce9bc7be3304b408c9f3ec9b5b95c76d3680a88..079c53516f424ca5f8d50292f1912af04b45b07a 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -354,6 +354,9 @@ int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
 			switch (devad) {
 			case MII_BMCR:
 				if ((val & (BMCR_RESET | BMCR_ANENABLE)) == 0) {
+					if (phydev->drv &&
+					    (phydev->drv->flags & PHY_BROKEN_FORCED))
+						return -EOPNOTSUPP;
 					if (phydev->autoneg == AUTONEG_ENABLE)
 						change_autoneg = true;
 					phydev->autoneg = AUTONEG_DISABLE;
@@ -1190,6 +1193,10 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 	      duplex != DUPLEX_FULL)))
 		return -EINVAL;
 
+	if (autoneg == AUTONEG_DISABLE && phydev->drv &&
+	    (phydev->drv->flags & PHY_BROKEN_FORCED))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&phydev->lock);
 	phydev->autoneg = autoneg;
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7c5098a0dd6cd1ffbfc5f55240cd68e41bfb2d73..4143bffdcdb9b293a6e717a41816c05a2c5a252b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -64,6 +64,7 @@ extern const int phy_basic_ports_array[3];
 #define PHY_RST_AFTER_CLK_EN	0x00000002
 #define PHY_POLL_CABLE_TEST	0x00000004
 #define PHY_ALWAYS_CALL_SUSPEND	0x00000008
+#define PHY_BROKEN_FORCED	0x00000010
 #define MDIO_DEVICE_IS_PHY	0x80000000
 
 /**

-- 
2.47.3

