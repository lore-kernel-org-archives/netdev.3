Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38348315D33
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781961101; cv=none; b=jpnOBYU4iwxLNPb9gCY0aLSOhGZkW6NbVoBrJ88raC7xA8pG4he1UbJ0AkX0vvExlNWA7wMg70p0SAOW/E5r7uzh4oPZenW/hsvYZ5g2rU209jum+9ACPfhW0XMfS2HgeiN2f5ccjn4dEKQU7XvKWdfYEQtQ0vQjmVSNJerY1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781961101; c=relaxed/simple;
	bh=AZ97wqsFotxnNxdlCBlxJv+DUkfvEG47RhLX9d0fFeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HA6VwR9c3inizeSIfGce65ZH2Tmr6YAkj8JsVvKjVvPZP3lw0AeIxPH2tULf+ksWPQAnA7UU7M9RRFzS11y4kEcScCV1QbAbrofos4wMY7HnnoNbraoM6IQPA+xqeoICZPcg7ADyKnn5fybEH0JImoEVxcbVYBgtwA1SroRtXps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=y5QwiBbl; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="y5QwiBbl"
Received: (wp-smtpd smtp.wp.pl 1146 invoked from network); 20 Jun 2026 15:11:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1781961095; bh=FihQkQb3fTPCIc0JKtlry5IkU/LW6YEej7nzbs09M78=;
          h=From:To:Cc:Subject;
          b=y5QwiBblvPqb04mZWP6PH14QqXA7aJpuNsjvY+riP9TDe5OwxL3Bf4/dNtjiVLgSv
           WqJSxud4DHuNOFtKHDKR2XnxnWHc4aoV6SjJV/187EBwBymIGvG866X2jtNz1Buh0U
           goXZM+QXKuolGL0hA4H8TrJqlLUkfILcD6+ltLrv6Dyk3syydKb2U1s/GzAVwfBqxg
           XbfLHRy9ITTOb5LQDLX8DwPTx+nBSdyF1xfdLuHz/Tz7ez7VcDFJoan20ggjUafkh8
           jQdZN+3mK9ZurqiSpVXDcsNzk4+3Ko5/tedqSIyVGlGhZJMqRXciQLA4rdn3a9XeyX
           ezUmKKkrzV72Q==
Received: from 83.5.151.132.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.5.151.132])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <linux@armlinux.org.uk>; 20 Jun 2026 15:11:35 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	vladimir.oltean@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH net] net: phylink: print correct c45 phy id when missing PHY driver
Date: Sat, 20 Jun 2026 15:11:13 +0200
Message-ID: <20260620131130.949298-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: a309c6e095426610e04f850591e955b0
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [wWP0]                               

If no PHY driver is found, `phy_id` is returned. `phy_id` holds the c22 ID.
Modules with a rollball bridge support only c45 transfers. The c45 IDs are
stored in the `c45_ids` structure. In the current code these modules report
an ID 0x00000000. This may lead users to mistakenly conclude that the
rollball bridge isn't properly implemented in their SFP module. This patch
fixes the wrong IDs for c45 modules when a driver cannot be found.

Tested on Fiberstore SFP-GB-BE-T (C22) and ONTi ONT-C1TE-R05 (Rollball).

Before:
[ 2440.373985] mtk_soc_eth 15100000.ethernet sfp-lan: PHY i2c:sfp2:11 (id 0x00000000) has no driver loaded
[ 2440.383385] mtk_soc_eth 15100000.ethernet sfp-lan: Drivers which handle known common cases: CONFIG_BCM84881_PHY, CONFIG_MARVELL_PHY
[ 2440.395274] sfp sfp2: sfp_add_phy failed: -EINVAL

After:
[   82.573700] mtk_soc_eth 15100000.ethernet sfp-lan: PHY i2c:sfp2:11 (id 0x001cc898) has no driver loaded
[   82.583098] mtk_soc_eth 15100000.ethernet sfp-lan: Drivers which handle known common cases: CONFIG_BCM84881_PHY, CONFIG_MARVELL_PHY
[   82.594996] sfp sfp2: sfp_add_phy failed: -EINVAL

Fixes: ffcbfb5f9779 ("net: phylink: improve phylink_sfp_config_phy() error message with missing PHY driver")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/phy/phylink.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 087ac63f9193..7d7595158bf9 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3917,13 +3917,30 @@ static void phylink_sfp_link_up(void *upstream)
 	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_LINK);
 }
 
+static u32 phylink_get_phy_id(struct phy_device *phy)
+{
+	if (phy->is_c45) {
+		const int num_ids = ARRAY_SIZE(phy->c45_ids.device_ids);
+		int i;
+
+		for (i = 1; i < num_ids; i++) {
+			if (phy->c45_ids.mmds_present & BIT(i))
+				return (phy->c45_ids.device_ids[i]);
+		}
+
+		return 0;
+	} else {
+		return phy->phy_id;
+	}
+}
+
 static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 {
 	struct phylink *pl = upstream;
 
 	if (!phy->drv) {
-		phylink_err(pl, "PHY %s (id 0x%.8lx) has no driver loaded\n",
-			    phydev_name(phy), (unsigned long)phy->phy_id);
+		phylink_err(pl, "PHY %s (id 0x%.8x) has no driver loaded\n",
+			    phydev_name(phy), phylink_get_phy_id(phy));
 		phylink_err(pl, "Drivers which handle known common cases: CONFIG_BCM84881_PHY, CONFIG_MARVELL_PHY\n");
 		return -EINVAL;
 	}
-- 
2.53.0

