Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9C93BF67F
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527644; cv=none; b=MEmQe6TwD13sUMpnVz33Jtquy3qeJze5e0Q1sBG7ps3I6cY0MAwxAFP8q7Eq/8y0y0cDR6gsfAPQrREU+Jy4EGRkaU8yIcukI4fh1W3rXjRfM9qaOyFA541U6V/x/EZ2PVHfoKI26wLbrEkHRVxvADrzELuYwVARrBLrB6cZ99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527644; c=relaxed/simple;
	bh=zIttsbckYaL4O363yyUVACM7iMbMd1b8AK5I33AZjJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XXDtqkV1x7bLIs2FG/tYPepn7y/GPe+iz/D8O6E6BVcQo/jqQpd5QcGwSP89O8+5oY/7n34sj8ttuPsOnbC7pDsOV5jUKn1Er9L6iH2S9fA5jd8KBAesAzqck5sa4+3pMaBipVzcFrODbU+zXGDHaXYT3ZIbRWv5K25Jyd1wT+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3ndvz3v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3ndvz3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289C1C2BC87;
	Thu, 26 Mar 2026 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774527644;
	bh=zIttsbckYaL4O363yyUVACM7iMbMd1b8AK5I33AZjJ4=;
	h=From:To:Cc:Subject:Date:From;
	b=N3ndvz3vt+oahor8ihd3E4Ly+yHrbMcaQHIXW/0LLZH5wdW4shXuOhRP+qYRYIyxT
	 n52Uvg7YIv7tx9D8RNl+EMfMVrbfDqvO9mgEcrEEynlO29BIi62jfT3AL4TYqcJi9h
	 NEqI274KQ/UfC9p76yuTtkh33rQ7BeLkU6+hRoOGJAMSGaZEWwSuzR/VeSzxwIDhzy
	 dG+MveTD3W+fxLabhB0wL/06AJCMfdYkwkqj2rn20+ASSMx0ALKASGITTVCX2xdhIy
	 MdGpKRIJKnvg20/gKXR3wJ3Ly+NBkiO7+yrmHiHYUDhXkTC8VeqsXqN66OTUPZWHHS
	 Xtf5wjGS9OuoA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net] net: sfp: Fix Ubiquiti U-Fiber Instant SFP module on mvneta
Date: Thu, 26 Mar 2026 13:20:38 +0100
Message-ID: <20260326122038.2489589-1-kabel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In commit 8110633db49d7de2 ("net: sfp-bus: allow SFP quirks to override
Autoneg and pause bits") we moved the setting of Autoneg and pause bits
before the call to SFP quirk when parsing SFP module support.

Since the quirk for Ubiquiti U-Fiber Instant SFP module zeroes the
support bits and sets 1000baseX_Full only, the above mentioned commit
changed the overall computed support from
  1000baseX_Full, Autoneg, Pause, Asym_Pause
to just
  1000baseX_Full.

This broke the SFP module for mvneta, which requires Autoneg for
1000baseX since commit c762b7fac1b249a9 ("net: mvneta: deny disabling
autoneg for 802.3z modes").

Fix this by setting back the Autoneg, Pause and Asym_Pause bits in the
quirk.

Fixes: 8110633db49d7de2 ("net: sfp-bus: allow SFP quirks to override Autoneg and pause bits")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/sfp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 5db841377199..ce8924613363 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -480,11 +480,16 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 {
 	/* Ubiquiti U-Fiber Instant module claims that support all transceiver
 	 * types including 10G Ethernet which is not truth. So clear all claimed
-	 * modes and set only one mode which module supports: 1000baseX_Full.
+	 * modes and set only one mode which module supports: 1000baseX_Full,
+	 * along with the Autoneg and pause bits.
 	 */
 	linkmode_zero(caps->link_modes);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
 			 caps->link_modes);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, caps->link_modes);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, caps->link_modes);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, caps->link_modes);
+
 	phy_interface_zero(caps->interfaces);
 	__set_bit(PHY_INTERFACE_MODE_1000BASEX, caps->interfaces);
 }
-- 
2.52.0

