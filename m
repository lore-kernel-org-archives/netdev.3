Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.19.166.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792610318;
	b=31/U4dGcQUuHredGyMH2t9xov11E/rk5tM3Ifk7J/QcKESaq2gj3OV7Xso7Uhr/jKCJC
	 QOazTMWMTyIMtw5RbOIDQFunKF5gRlGEwjcDY1B9nHYAmU+i4m4cUUM6sW1EUft/Vn1tD
	 1aYGDzCAmtu7t3dFizx8N2Ymdp0XYaP4Z0cT2Ih4mcYbaTBdbIiWnO6VfsKn4GE0+Bqil
	 ZesF42lFdNT7KtchzSqYQXFq9PatPFvBHlVA2Ede+5YxA/SxZQfPutz0bLi1Rl5c6e+Cm
	 DpiWMjD9BOzpXmRx2kQrrlBtu4MMS8NJCuLC4NkPU2qu0EE0I4EW16ZDz9FA0i+auOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792610318;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0hgSB5REeOoOU4+uL52FWMra36mU3bq54+5dt+GWlSg=;
	b=V20UTr09vmUT41h1hfmR6CAZn14UXGZC9Oo2dViC7WAdyuIc4tasC86Fr/qUlVTGj/m9
	 7AZdPwdTU4CAJ/QT3nX8boHSw0uCfP2QlPp9J1KFRHXbYNJTZdlRZ1H1Wfd1MbiVPjefo
	 LjsfCz9w9E/jn1jKaaMITl0ueBMcz2vRWofGxgGJ5kcmX2tGYygFib9WuLBRvl1ViBZDQ
	 KSrjC+mc+5aIZrV/Vf5A84nNJ9dGi/Ub6bIi6hrF+60gBqwWRZmobK5dQOaWxzwiWv52o
	 dLKviuDbAUoSBOz2BH2NbRlhHgf1CAXNgwB3xM7wctN1w77rGjcfV3KymwPlOg6dKVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=gAdWJaFc;
	arc=none smtp.remote-ip=192.19.166.231
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9C2606A323;
	Wed, 21 Oct 2026 19:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B9C2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=gAdWJaFc
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9F140C0000F3;
	Wed, 21 Oct 2026 12:18:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9F140C0000F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1792610317;
	bh=p9pwtt5lrLuqc9XYwYfXa6UPKjZHtaDJwgXBd3PoScU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gAdWJaFc9wNMJS4ezGC4h1OiWb3vcvr9Av2qMvB0wKVbYmgLakim+g5osl8YVITsM
	 oCHy3rIqJ5J1K76ggcfTaiYIE5OQaQcr4a2L+ItW2jLg8mUs4Ewx60JCJ1a/VSPQRD
	 2nROQ50j3Q9y1OBb3CwXAc0o1T02d8XoExhYcIX4=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 83BF8AEA2;
	Wed, 21 Oct 2026 15:18:36 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 6/6] net: dsa: b53: apply resolved link settings to serial port MACs
Date: Wed, 21 Oct 2026 12:18:24 -0700
Message-ID: <20261021191824.752309-7-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021191824.752309-1-florian.fainelli@broadcom.com>
References: <20261021191824.752309-1-florian.fainelli@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The serial port MAC callbacks leave speed, duplex and pause under the
hardware's autonomous control. In particular, changing phylink's pause
policy cannot affect the MAC when Clause 37 negotiation is in use.

Use the existing MAC override registers for SGMII and 1000BASE-X links,
including PHY and fixed-link negotiation modes. Apply the settings passed
by phylink at link-up and force the MAC link down at link-down. PCS power
and link observation remain independent of the MAC override.

Preserve the existing parallel-port handling, EEE initialization and
BCM5301x CPU-port pause quirk.

Fixes: 0e01491de646 ("net: dsa: b53: Add SerDes support")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 50 +++++++++++++++-----------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index b04f9d5f0525..172ada124cbf 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1600,6 +1600,17 @@ static void b53_phylink_mac_config(struct phylink_config *config,
 	}
 }
 
+static bool b53_phylink_mac_needs_override(struct b53_device *dev, int port,
+					   unsigned int mode,
+					   phy_interface_t interface)
+{
+	return mode == MLO_AN_FIXED ||
+	       interface == PHY_INTERFACE_MODE_SGMII ||
+	       interface == PHY_INTERFACE_MODE_1000BASEX ||
+	       (mode == MLO_AN_PHY && is63xx(dev) &&
+		in_range(port, B53_63XX_RGMII0, 4));
+}
+
 static void b53_phylink_mac_link_down(struct phylink_config *config,
 				      unsigned int mode,
 				      phy_interface_t interface)
@@ -1608,16 +1619,8 @@ static void b53_phylink_mac_link_down(struct phylink_config *config,
 	struct b53_device *dev = dp->ds->priv;
 	int port = dp->index;
 
-	if (mode == MLO_AN_PHY) {
-		if (is63xx(dev) && in_range(port, B53_63XX_RGMII0, 4))
-			b53_force_link(dev, port, false);
-		return;
-	}
-
-	if (mode == MLO_AN_FIXED) {
+	if (b53_phylink_mac_needs_override(dev, port, mode, interface))
 		b53_force_link(dev, port, false);
-		return;
-	}
 }
 
 static void b53_phylink_mac_link_up(struct phylink_config *config,
@@ -1633,29 +1636,22 @@ static void b53_phylink_mac_link_up(struct phylink_config *config,
 	struct ethtool_keee *p = &dev->ports[dp->index].eee;
 	int port = dp->index;
 
-	if (mode == MLO_AN_PHY) {
-		/* Re-negotiate EEE if it was enabled already */
+	/* Re-negotiate EEE if it was enabled already */
+	if (mode == MLO_AN_PHY)
 		p->eee_enabled = b53_eee_init(ds, port, phydev);
 
-		if (is63xx(dev) && in_range(port, B53_63XX_RGMII0, 4)) {
-			b53_force_port_config(dev, port, speed, duplex,
-					      tx_pause, rx_pause);
-			b53_force_link(dev, port, true);
-		}
-
+	if (!b53_phylink_mac_needs_override(dev, port, mode, interface))
 		return;
-	}
 
-	if (mode == MLO_AN_FIXED) {
-		/* Force flow control on BCM5301x's CPU port */
-		if (is5301x(dev) && dsa_is_cpu_port(ds, port))
-			tx_pause = rx_pause = true;
-
-		b53_force_port_config(dev, port, speed, duplex,
-				      tx_pause, rx_pause);
-		b53_force_link(dev, port, true);
-		return;
+	/* Force flow control on BCM5301x's CPU port */
+	if (mode == MLO_AN_FIXED && is5301x(dev) && dsa_is_cpu_port(ds, port)) {
+		tx_pause = true;
+		rx_pause = true;
 	}
+
+	/* PCS negotiation supplies state; the MAC applies phylink's policy. */
+	b53_force_port_config(dev, port, speed, duplex, tx_pause, rx_pause);
+	b53_force_link(dev, port, true);
 }
 
 int b53_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
-- 
2.53.0

