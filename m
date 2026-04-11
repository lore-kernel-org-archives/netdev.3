Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EF5330D36
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775904723; cv=none; b=XRt6i1nh1zsVzCTRuqNEMGUYWLJG8WvGYp8Awb7X5b23KtFHcAWug1+UxLIY42sHOr1by3HkRbN6R2sUpYgZ61UTAbzxg5IbetQfyBIQdXYItLvdN3tbIOna9qIdxtM5gZTLVDxw1GK56K1e+BSzZyPm8Q5ZqZ8RsfjiXEWymaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775904723; c=relaxed/simple;
	bh=CeL22EtUzobZbqgtLEZCQlySccBoTzq4T88blAkolMs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mzHD435oWTVtdc06pOanm/GIkaBSJdGoMYG44xfOCmcqyy8OCSPanWoQflFOQTnktA+r3mjcIZrAchbNs06JPaPbY8l7VgY1UaKGpPycBH2UoY7bGdOC7PdWhHFZvDWclrZHj+HnSto3rY1FxtzmyQF36Np81as8TBInvVkjJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=OaCvvZCW; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="OaCvvZCW"
Received: (wp-smtpd smtp.wp.pl 12789 invoked from network); 11 Apr 2026 12:51:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1775904712; bh=VL1aUuTehdpsPt1NvR4cFwwQ6ADuYM46bjkSA11Cyvs=;
          h=From:To:Subject;
          b=OaCvvZCWnGg2nLYKamtkhF4kpEcMU4BFAvaxnOb1jbZCZSkdXzZk6rsDUujkQS3OD
           s4LhON3NdMrHO624XydEkOHsoDf1DyaBu35Qf0PgNR3rQAnxwCc3/J/87IA1DlKEIt
           m6A2WTE220t0+U29/jJs9Z03vETVvlkg9zeokxJTSawReTU2RsXOgV6gxc3lV06OV3
           3CWarryO2jjf7rwwjBmtDXcLpf7SJeHT9rAhvzLp5HUytsvB+/ombVcxOHuUzBrNnQ
           dmNUZu1OLgXW50F03bpy+pZI1jO0bj34zTVmP5Z4DG4Xb/xW/v2ETH4qnD68nEZ3Ez
           5SNiDOr7odBgQ==
Received: from 83.24.120.84.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.24.120.84])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 11 Apr 2026 12:51:52 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	vladimir.oltean@nxp.com,
	michael@fossekall.de,
	olek2@wp.pl,
	daniel.braunwarth@kuka.com,
	ih@simonwunderlich.de,
	rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy: realtek: use LEDCR page number define on RTL8211F
Date: Sat, 11 Apr 2026 12:51:45 +0200
Message-ID: <20260411105150.184577-1-olek2@wp.pl>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: fae9851f353b5e1f596622006733a10c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [8cMk]                               

Replace the magic number with an existing define for the LEDCR
register page number on the RTL8211F.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/phy/realtek/realtek_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 75565fbdbf6d..536cbb3820eb 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -874,7 +874,7 @@ static int rtl8211f_led_hw_control_get(struct phy_device *phydev, u8 index,
 	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
-	val = phy_read_paged(phydev, 0xd04, RTL8211F_LEDCR);
+	val = phy_read_paged(phydev, RTL8211F_LEDCR_PAGE, RTL8211F_LEDCR);
 	if (val < 0)
 		return val;
 
@@ -936,7 +936,8 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 	reg <<= RTL8211F_LEDCR_SHIFT * index;
 	reg |= RTL8211F_LEDCR_MODE;	 /* Mode B */
 
-	return phy_modify_paged(phydev, 0xd04, RTL8211F_LEDCR, mask, reg);
+	return phy_modify_paged(phydev, RTL8211F_LEDCR_PAGE, RTL8211F_LEDCR,
+				mask, reg);
 }
 
 static int rtl8211e_led_hw_control_get(struct phy_device *phydev, u8 index,
-- 
2.51.0

