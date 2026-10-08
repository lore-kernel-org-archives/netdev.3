Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DFA3CB2DC
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488132; cv=none; b=f5vJepFxiMH5KpYAS9s6QkF86K7QOjxlRhqVpMySqfHu9rA/W7Zk2ssGpFhw07dgZItz0hR4aGM/GBnIhf3WEqDSIJkzz7FPQMaf/VU5w7HpdVga4Q2EyKHK7lVrNgzjpgoHfZrPE+u5lVgmRhw3CWy1bmtO82WlIU+Adw3qQ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488132; c=relaxed/simple;
	bh=QvZVaGbODwAM5jppJsUP+qBdizHnEOAGSyu2NQ6vYwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mozQgnRJJLiMS4MRb3x36MSV354E0s27CL0SFhuq1itkPIMB1IbrYaZj+LgCXp1h7ZjVJ5O5HcMSDhoTIfzLsVKW+DZPWEMbXvq7FAmHIWRkDezvOPjV7LKWhwthGaKfblr7s2mX7+bVA6rP0NBWecsEE/Ap7yTH+qnkm4p4A0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqC2VO8n; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqC2VO8n"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1755b8c10so464568a12.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791488128; x=1792092928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iiPxBE9Ry4NGuZQKC7Sy9Rq5YEZRiRdQyKz0w0rafvA=;
        b=LqC2VO8n/ilP3F1qOhicxYdquGXePBKabsPsOQx6H3rT7yTkxbML3t7DL9vovr/6PV
         j1p9krKKIJ63KpHjSsr+OlPRK7n8wyMmR8YKiI3JEE8p9NZxuxl/XpOiUMX3q1XOufJ+
         2W19S+GpIpmm4omM/I7akIx8bwIDhrNDzqZi9dGk7TBlbEALfub0ZppF0AAU6hUntwbh
         wapq7D5A9LmkyYFQ29KUTJThGHAG1qBulRFNBVV5fUEJakz7Rx+nmI9g8bxJzjCqRioR
         ccfCU4mBlR8LuqczCvDQrmwEqyDtTzxAiUAA/OOz4sWCUyWeHSpuVZNlGWKEDAkMsJPa
         aljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488128; x=1792092928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iiPxBE9Ry4NGuZQKC7Sy9Rq5YEZRiRdQyKz0w0rafvA=;
        b=pfd0L6+zQDnauNdigG71vNXIh55pBVo5N+E9WAb5xYYUpm4ibkpUhwD4zlNTaxPXfi
         qEl+hOsfs+Bzs4V9PYKvcEo6rWhhbI79DbRTuvQ7kZ4zerU2dBSWpAB7sjyWDuNihdb0
         NcwTl1NbysmMig1G9eSXA2Hr4qU2qRDZFSLd/DfI1kua+EPY5kXFLJSJ88VgB+jqcZWY
         I9UoPdJ/PI5wQH7j0RDMN9loAsUiQyoUceUECuVKJXoghfIbA6NrBOpEuGnxrmA7Wepb
         3we6fllQSheczq+jUBG6xVSga4dH5UCRtIPXzd7bU4k493WLmV4tnuPwzE+UzZYAMtZ3
         5JoA==
X-Gm-Message-State: AFq9FYJLVqwtQ4Kwhx+4FgPshm+xmQnmqB99vGonl2NL+jssy+XNjKWr
	g2zQc4gaG+UXPoV7gvxtCvEVNzLwS7jTpfrdKHp22IedzRkg1PmJSpPSzUcZwmzWkQ4=
X-Gm-Gg: AYBFou06l88P8lTsg2ruxvv0vqTE5QhffjQ0lyLHybKqPgK9XlYr0o8HgGal7LXtvUf
	Eo1s5JKLbQnh5r1nhKkFMWb4XxrnjwJW7i+lxn1AJNnf/5TBetkAd+dk00rNoziR7fP9QRyYMx8
	VeURvHmsqG2GSK8+rZdKFH0oHpLn/8JQ3gjR3r27FoP7zGZHA9Blhkjb+575c+bYh2OL7WCOENt
	FbDlA3lIuEqLwcAtmhWj8/DAoMx/21q4y8sNe+wuW0CLq8ss2m8XSZZpdGRVjl+UpcZ5RhEk2Rs
	boKbZGVA5QLr++IVzIOk86lcvz3COakvhM5JzYihBBN7v5ZPeaq4u5vMgzL7lPyyE8Vp/SArqR3
	9K2nfk/r17/CaurAxf3rLewmQI1ZBCVEjiz2CPk4kTaA2z1+OQypJd6kT/5aJZ7newc29WnPRwL
	59TJKYqbF7rBso4yQ33HlplsoqepQxJhMGAj8rHY5+t9/RSRWmVAh3NKu43rMftLAGqdQ0QWKka
	N5izx/Lf/D0IJY3G/0qcqdQZR9LBGr7dkXVeH47GSD8KOsLs4AQyWYgt/wOTSeBM2AmeDxgP2wr
	CHlg2SZoVzI3aSD8ZfijSS0=
X-Received: by 2002:a05:6402:2789:b0:6aa:915a:f51e with SMTP id 4fb4d7f45d1cf-6aff4421a6fmr5713755a12.17.1791488127623;
        Thu, 08 Oct 2026 12:35:27 -0700 (PDT)
Received: from localhost.localdomain (94-255-221-162.cust.bredband2.com. [94.255.221.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a4d0c2c0sm9043366b.28.2026.10.08.12.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:35:27 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4] net: phy: qca83xx: read resolved QCA8337 link status
Date: Thu,  8 Oct 2026 21:35:14 +0200
Message-ID: <20261008193515.14880-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a QCA8337 SmartSpeed downshift, genphy_read_status() can report
1000 Mbit/s from the advertised modes when the PHY is running at
100 Mbit/s. On a Redmi AX5400 running downstream OpenWrt Linux 6.18.52,
this caused qca8k to program the user-port MAC for 1000 Mbit/s and
traffic failed. An earlier prototype that read the resolved speed
from the PHY restored traffic.

Wrap genphy_read_status() and use at803x_read_specific_status() to
replace its speed and duplex result when an autonegotiated link comes
up. Resolve pause for the resulting duplex. Until the PHY reports a
resolved speed and duplex, report the link as down so that the next
poll reads them again, as marvell_read_status_page_an() does.
QCA8337's register layout matches the helper (data sheet 80-Y0619-3
Rev. D, pages 327-328).

Keep the generic master/slave read order and the early return for a
steady autonegotiated link. This avoids additional reads of the
clear-on-read idle error count in MII_STAT1000. Forced mode continues
to use BMCR. Report the MDI-X state read at link-up and invalidate it
when the link goes down or autonegotiation is disabled. Clear
mdix_ctrl because this driver does not implement MDI-X configuration.

Fixes: b3591c2a3661 ("net: dsa: qca8k: Switch to PHYLINK instead of PHYLIB")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
Assisted-by: LLM
---
v4:
 - Report the link as down while the PHY-specific status is unresolved
   or holds the reserved speed value, as marvell_read_status_page_an()
   does. v3 reported the link up with SPEED_UNKNOWN, and the early
   return then kept it until the link dropped.
 - Invalidate mdix when the link goes down or autonegotiation is
   disabled, instead of keeping the value read at the last link-up.
 - Rebased onto net 37f12441f557. The files involved are unchanged.
 Both issues were raised in the Sashiko review of v3, which Jakub
 forwarded.

v3: https://lore.kernel.org/netdev/20261006160316.1356-1-yongzhao.derek@gmail.com/
v2: https://lore.kernel.org/netdev/20261003173210.1235-1-yongzhao.derek@gmail.com/
v1: https://lore.kernel.org/netdev/20260928220749.857-1-yongzhao.derek@gmail.com/

Testing: the source-extraction model passes 27 checks covering speed
and duplex at the phylib notification boundary, latch-low transitions,
pause, forced mode, MDIO errors, the idle-error and MSFAIL read order
from v3, and the two issues above. v3 fails exactly the four checks
for those two issues: an unresolved or reserved status at link-up,
and mdix after a link drop or with autonegotiation disabled. An arm64
W=1 build of qca83xx.o, at803x.o and qcom-phy-lib.o is clean.

v4 has not been tested on hardware. The hardware result above used
v2's at803x_read_status() plus genphy_read_master_slave() on one board,
with an Intel igb peer, a two-pair cable and default autonegotiation.
Ping changed from 0/20 to 20/20 in each direction at resolved 100 Full.
Whether QCA8337 can report link up before the resolved bit is set is
unknown.

 drivers/net/phy/qcom/qca83xx.c | 53 ++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/phy/qcom/qca83xx.c b/drivers/net/phy/qcom/qca83xx.c
index bc70ed8efd8..be00bc7cda0 100644
--- a/drivers/net/phy/qcom/qca83xx.c
+++ b/drivers/net/phy/qcom/qca83xx.c
@@ -92,6 +92,58 @@ static int qca83xx_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca8337_read_status(struct phy_device *phydev)
+{
+	struct at803x_ss_mask ss_mask = {
+		.speed_mask = AT803X_SS_SPEED_MASK,
+		.speed_shift = __bf_shf(AT803X_SS_SPEED_MASK),
+	};
+	int ret, old_link = phydev->link;
+
+	ret = genphy_read_status(phydev);
+	if (ret)
+		return ret;
+
+	/* Keep the state resolved at link-up while the link stays up */
+	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
+		goto out;
+
+	phydev->mdix = ETH_TP_MDI_INVALID;
+
+	/* genphy_read_status() derives speed and duplex from the
+	 * advertisements, which is wrong after a SmartSpeed downshift.
+	 * Use what the PHY resolved instead.
+	 */
+	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete &&
+	    phydev->link) {
+		phydev->speed = SPEED_UNKNOWN;
+		phydev->duplex = DUPLEX_UNKNOWN;
+		phydev->pause = false;
+		phydev->asym_pause = false;
+
+		ret = at803x_read_specific_status(phydev, ss_mask);
+		if (ret)
+			return ret;
+
+		/* Report the link down until speed and duplex are resolved,
+		 * so that the next poll reads them again.
+		 */
+		if (phydev->speed == SPEED_UNKNOWN ||
+		    phydev->duplex == DUPLEX_UNKNOWN) {
+			phydev->link = 0;
+			phydev->mdix = ETH_TP_MDI_INVALID;
+		} else {
+			phy_resolve_aneg_pause(phydev);
+		}
+	}
+
+out:
+	/* MDI-X configuration is not implemented */
+	phydev->mdix_ctrl = ETH_TP_MDI_INVALID;
+
+	return 0;
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -220,6 +272,7 @@ static struct phy_driver qca83xx_driver[] = {
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
 	.soft_reset		= genphy_soft_reset,
+	.read_status		= qca8337_read_status,
 	.get_sset_count		= qca83xx_get_sset_count,
 	.get_strings		= qca83xx_get_strings,
 	.get_stats		= qca83xx_get_stats,

base-commit: 37f12441f557468a56c1e27790413aa78c82afa2
-- 
2.43.0

