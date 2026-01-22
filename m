Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32E427A16;
	Thu, 22 Jan 2026 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054459; cv=none; b=rRdUltVaGB8213yyJsXBX1t+9Q2bgqEUT4rp5xvbXfazJxWRJin4eKzBzHiopOFhyCwBcgMN5t0N/KnJG7eGj6tb900zKZxlrMM/sWmy4W4OSBMnT68TjwcyMwKmTaiuWGYxdmoOJImzeSzhZDNNs5TVl8MQcs9GCkEQiRtFn60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054459; c=relaxed/simple;
	bh=aGHizfN03SNkjbrltWphmfG6jaGzR34MdP6zFRi6nEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgAKi0oSapMlT36ot9y0qdN78axtlpunQs+x6493ya+80V4L7Lcc/NuuZFR++rKAWZzPhoyLD08F+2oHoqo1yxAGgvn6Cb6gT7KDQVsjhlux/A2SS8aDYb/erHWPPKL0WU1eIFi4lWatRPlFR1Yichvs3vL5a+5n9CotQMjhkWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vilsK-000000006Rt-2hkU;
	Thu, 22 Jan 2026 04:00:52 +0000
Date: Thu, 22 Jan 2026 04:00:50 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [RFC PATCH v2 1/2] net: phy: add (*register_phy)() hook to struct
 mii_bus
Message-ID: <82311b68468ba95e5fead3e2fe4574d616151adc.1769053496.git.daniel@makrotopia.org>
References: <cover.1769053496.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769053496.git.daniel@makrotopia.org>

Some MDIO busses require to program PHY polling registers depending on
the PHY type. RealTek switch SoCs are the most prominent example of a
DSA switch which doesn't allow to program MAC speed, duplex and
flow-control settings without using PHY polling to do so.

Hence there is a need to inform the MDIO bus driver that a PHY has been
registered on the bus, as otherwise the bus driver will have to reinvent
and duplicate all the bus scanning logic for Clause-22 and Clause-45
PHYs, and discover their features (or maintain a long list of PHY IDs).

Provide a simple hook in struct mii_bus which is called right after a
PHY has been fully probed.

Alternative ways which would allow to do the same things without
having to change any kernel code would of course be very welcome.

Link: https://github.com/openwrt/openwrt/pull/21515#discussion_r2714069716
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/phy_device.c | 8 +++++++-
 include/linux/phy.h          | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f624218bf3664..7807f3db50507 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3778,8 +3778,14 @@ static int phy_probe(struct device *dev)
 	/* Get the LEDs from the device tree, and instantiate standard
 	 * LEDs for them.
 	 */
-	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev))
+	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev)) {
 		err = of_phy_leds(phydev);
+		if (err)
+			goto out;
+	}
+
+	if (phydev->mdio.bus->register_phy)
+		err = phydev->mdio.bus->register_phy(phydev);
 
 out:
 	/* Re-assert the reset signal on error */
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5972f19af16da..1d38e27d20389 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -377,6 +377,9 @@ struct mii_bus {
 	/** @reset: Perform a reset of the bus */
 	int (*reset)(struct mii_bus *bus);
 
+	/** @register_phy: Called for each PHY detected on the bus */
+	int (*register_phy)(struct phy_device *phydev);
+
 	/** @stats: Statistic counters per device on the bus */
 	struct mdio_bus_stats stats[PHY_MAX_ADDR];
 
-- 
2.52.0
