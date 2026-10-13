Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A635DA55
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918235; cv=none; b=FHRgBBTFXxU/8JBDuqXfYdYfWhDSEMQrU4YghY0p0kCK9MH2cWoUm3TCk4qtmNs1FuxUFgNvgy4xty5ArVmVJ9gHhc+GoUO2EWPsHKtgGAbYkU+qemndGKv0GB3gti98V1OiANEVe/E5MFh7TKTeeZ+EgXBJzMQje96Xm79esBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918235; c=relaxed/simple;
	bh=mZpnE/Swnv0WhWB+Wq7EukKgcDUhNqno2K7Pv67CP0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=brblGbRvUf46fxDx4nHYMaBzv43rOnJQ9EDFpq8vvWV7MfCYmU2t7xf3VNnnNmGG59vpladUXgdEIeau4DTvtrLEwgK0bPoTPwZPwRujl+QrweojlFivstoi7bkacAK0l4pDHFqpAfc/LxV1i9TZrOcArtASbUBbUXFKEKFVhV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYy4TtlC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYy4TtlC"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b170129413so346604a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791918232; x=1792523032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RmXCU4nxao059y5rK6bSrIsteEBugmZOufQtFeD5hE4=;
        b=WYy4TtlCCESKXPVBYxQxUk3BGTH2CyBjUORMb7isW7Sc/GHAB0A/QRQaWXobrRStgP
         zdTM+pa3h9w2TQIc26bkmAFHU4sNDxf01yEfaQyJI/FPv+IPdDhnrKOIGe7e80zGmkKs
         wMKW4bnl453Wn0ksBRvN6pX5/KO26qKMRVt9e8G4/5ZqxVDhThGB+iGqKn68ffryN2SF
         MqlCVnphYO36+Z8La+5HI+yBLjXOoCIJ25HUJV+RfSAAm/sUFZ6IPvuSldSj4LWtGtaV
         qQhiS+77u7te5ztHIYG924C8Kck3+K46QEZuI1DcDduwLogT8qqo8Y1+htGE6/nvvV3c
         y3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791918232; x=1792523032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RmXCU4nxao059y5rK6bSrIsteEBugmZOufQtFeD5hE4=;
        b=CSt4GRo7NORHSic9f3rrc3TjtNY9oAbWjS7/kyAZcqiCkNFwxtkug5YpUlHKoZFQBF
         njAXm0r+PUEhCVasHdOYSHNZZVGvqJ4sNh0fpWyJIUZdZV81votBj+UWS0iMCe47M8w9
         S0H5sLckgG9GPOnQQtsWcaE3Ndl4I3fvdWtNoF+HvjEZYy4rgDSIXAoItSp4zSQrhSiH
         pgtzyPbzEEJsH8EbD3EdV5G5Lj1NMt+FKoYZf9dM46pEERe2ohX8UBwQQTcLMJZWXLRs
         XsCZebyX1eWhZbm/lqLgkSlACRvfu0Fvf4piI2shCG2rxOqioprgDYSVgsqEMKDKzUP3
         Xlkg==
X-Gm-Message-State: AFq9FYIUPkESX5CkWDrP8Yj06kf9CISlN79AAOXqDvQqUxyyLvtgwVDS
	dsvxMyGAX+VV/UnDOGF50akAVjrm0X9VyOYCDXLP8XBOdJSjFm84feNTzC7duLD8gZI=
X-Gm-Gg: AYBFou00GhOpckvZlJvwfDNpr8SXiOkWKeEPj+x2YeshHnFDx1fSct1i2TzmoTFIp+P
	dFAraPwODHj4nl0gYmmX3DzSgvX0vvm4TUZusANR2hPipQgz7ITQ51ZtqZLOSuT4qPJr17k61sI
	vuh8brXpG/sq+bm9F6p2fptO8TqoqJ7PreVvQXL/yxTFOnflm45McLNf/F0bhDwqEHAY2EhlFWO
	1PcragnfaD6NGLKf9tLAEt2VBjrK9TsPCq68CLHQz/HjDpS+Jt8EBr9QxS7BiBNVgw9OEEJbM3J
	pzZV7KvBB9sUv0g9axgvLBVdyQTz2zZR0WWLJRimT7ix79c0cfHNE6BZMTPQ+WFRLY3RiqUZJyP
	gewQZa+JwFpoVNy9kHljAWXwH2B6tlsrK5+MT3Qp7HgjQ90Xk9trEXzlLBJ81BLoq8FIxVRfXEM
	Z6QWM/wpT7hNNPatQSYWvBX1DKF1X0P/lEB13Q8r2kLwmAJBG7G77wo5BMIqZLS7A7fqZtxmaWl
	OTaK+6hBfajslsQWiXzxsAnpUTKay5UvO+y3fzdRNMXPqkoIDJfxblveNgDU9y9Ehbqwxd+mPvc
	yvVtWqRRm61sumj0v3P2W6Y=
X-Received: by 2002:a05:6402:c50f:20b0:6b1:8316:ba32 with SMTP id 4fb4d7f45d1cf-6b18316bd07mr8322934a12.17.1791918231580;
        Tue, 13 Oct 2026 12:03:51 -0700 (PDT)
Received: from localhost.localdomain (94-255-221-162.cust.bredband2.com. [94.255.221.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203580958sm230980a12.0.2026.10.13.12.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 12:03:51 -0700 (PDT)
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
Subject: [PATCH net v5] net: phy: qca83xx: read resolved QCA8337 link status
Date: Tue, 13 Oct 2026 21:03:39 +0200
Message-ID: <20261013190339.51909-1-yongzhao.derek@gmail.com>
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
poll reads them again, as marvell_read_status_page_an() does. In that
case also clear the duplex, master/slave state and link partner modes
that genphy_read_status() read for an up link. QCA8337's register
layout matches the helper (data sheet 80-Y0619-3 Rev. D, pages
327-328).

Keep the generic master/slave read order and the early return for a
steady autonegotiated link. This avoids additional reads of the
clear-on-read idle error count in MII_STAT1000. Forced mode continues
to use BMCR. Report the MDI-X state read at link-up and invalidate it
when the link goes down or autonegotiation is disabled. Clear
mdix_ctrl because this driver does not implement MDI-X configuration.

The QCA8327 entries keep genphy_read_status(). The AR8327 data sheet
(MKG-15791 Rev. 1.0) lists the QCA8327-A PHY ID and documents the same
PHY-specific status layout, with SmartSpeed enabled after a hardware
reset, so those PHYs may have the same problem. That is untested on
QCA8327 hardware, so limit this change to QCA8337.

Fixes: b3591c2a3661 ("net: dsa: qca8k: Switch to PHYLINK instead of PHYLIB")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
Assisted-by: LLM
---
v5:
 - When the link is reported down at link-up, also clear duplex,
   master_slave_state and lp_advertising. v4 left the values that
   genphy_read_status() had read for an up link, and a reserved speed
   value left a concrete duplex.
 - State in the commit message why the QCA8327 entries are unchanged.
 - Rebased onto net 513444cc62e2. The files involved are unchanged.
 Both points were raised in the Sashiko review of v4.

v4: https://lore.kernel.org/netdev/20261008193515.14880-1-yongzhao.derek@gmail.com/
v3: https://lore.kernel.org/netdev/20261006160316.1356-1-yongzhao.derek@gmail.com/
v2: https://lore.kernel.org/netdev/20261003173210.1235-1-yongzhao.derek@gmail.com/
v1: https://lore.kernel.org/netdev/20260928220749.857-1-yongzhao.derek@gmail.com/

Testing: the source-extraction model passes 28 checks covering speed
and duplex at the phylib notification boundary, latch-low transitions,
pause, forced mode, MDIO errors, the idle-error and MSFAIL read order,
the unresolved and reserved status cases, and mdix. v4 fails only the
new check for the state left after an unresolved or reserved status.
An arm64 W=1 build of qca83xx.o, at803x.o and qcom-phy-lib.o is clean.

v5 has not been tested on hardware. The hardware result above used
v2's at803x_read_status() plus genphy_read_master_slave() on one board,
with an Intel igb peer, a two-pair cable and default autonegotiation.
Ping changed from 0/20 to 20/20 in each direction at resolved 100 Full.
Whether QCA8337 can report link up before the resolved bit is set is
unknown.
---
 drivers/net/phy/qcom/qca83xx.c | 58 ++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/net/phy/qcom/qca83xx.c b/drivers/net/phy/qcom/qca83xx.c
index bc70ed8efd8..2c4d085bacd 100644
--- a/drivers/net/phy/qcom/qca83xx.c
+++ b/drivers/net/phy/qcom/qca83xx.c
@@ -92,6 +92,63 @@ static int qca83xx_probe(struct phy_device *phydev)
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
+		 * so that the next poll reads them again. Also clear what
+		 * genphy_read_status() read for an up link, as the
+		 * PHY_HALTED path of the state machine does.
+		 */
+		if (phydev->speed == SPEED_UNKNOWN ||
+		    phydev->duplex == DUPLEX_UNKNOWN) {
+			phydev->link = 0;
+			phydev->duplex = DUPLEX_UNKNOWN;
+			phydev->mdix = ETH_TP_MDI_INVALID;
+			phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+			linkmode_zero(phydev->lp_advertising);
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
@@ -220,6 +277,7 @@ static struct phy_driver qca83xx_driver[] = {
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
 	.soft_reset		= genphy_soft_reset,
+	.read_status		= qca8337_read_status,
 	.get_sset_count		= qca83xx_get_sset_count,
 	.get_strings		= qca83xx_get_strings,
 	.get_stats		= qca83xx_get_stats,

base-commit: 513444cc62e231a11c9b15ea88de0890da9b2b4f
-- 
2.43.0

