Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DEF288B8;
	Wed,  4 Feb 2026 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211998; cv=none; b=ULFY0QjbE4Yot9Du7KtP0jABbeZcliUFKE31se14fQy10aOofkJXNbL8nhcqXMZJZ571WPII2Yw3yrfCF53WTH9qZk90kIlTTIA808xVv7HK1V4k3oc0D9H6r4ztMPO+BuqzVJWAhip+GA3xgQumHwXuIuNvBaZBsuR//ZewiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211998; c=relaxed/simple;
	bh=NG92sbBKDBE5FaIgogPXv5eQ3zwbli9E3+AykwtSeAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Snp2yQ/hiFMD0rChd7D9qLHny2NFbLvT4lY+Cxbi4MAVWqYU7WIPhs/IMcMurn2r3cZ39WHmLBbQP+UnlX/u0b9Ru0VulD/B5SAAd6Up9xKTGqXUTPPPuL6nm7AYihp+dzN+e0mzNyUcyHWgtjlc3o1DWNeNZvd8FJvHpUX3cg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vnd0M-000000003zW-4BgL;
	Wed, 04 Feb 2026 13:33:15 +0000
Date: Wed, 4 Feb 2026 13:33:11 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>, John Crispin <john@phrozen.org>
Subject: [PATCH net-next v13 3/4] net: mdio: add unlocked mdiodev C45 bus
 accessors
Message-ID: <85976db5c9b5efa4f60b6f08766d30f801985dab.1770211259.git.daniel@makrotopia.org>
References: <cover.1770211259.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770211259.git.daniel@makrotopia.org>

Add helper inline functions __mdiodev_c45_read() and
__mdiodev_c45_write(), which are the C45 equivalents of the existing
__mdiodev_read() and __mdiodev_write() added by commit e6a45700e7e1
("net: mdio: add unlocked mdiobus and mdiodev bus accessors")

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v13: add Russell's Reviewed-by:-tag given for v11
v12: no changes
v11: no changes
v10: no changes
v9: no changes
v8: no changes
v7: no changes
v6: no changes
v5: fix indentation
RFC v4: no changes
RFC v3: no changes
RFC v2: add this patch, initial submission
---
 include/linux/mdio.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 7ad7ce48f531..5d1203b9af20 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -647,6 +647,19 @@ static inline int mdiodev_modify_changed(struct mdio_device *mdiodev,
 				      mask, set);
 }
 
+static inline int __mdiodev_c45_read(struct mdio_device *mdiodev, int devad,
+				     u16 regnum)
+{
+	return __mdiobus_c45_read(mdiodev->bus, mdiodev->addr, devad, regnum);
+}
+
+static inline int __mdiodev_c45_write(struct mdio_device *mdiodev, u32 devad,
+				      u16 regnum, u16 val)
+{
+	return __mdiobus_c45_write(mdiodev->bus, mdiodev->addr, devad, regnum,
+				   val);
+}
+
 static inline int mdiodev_c45_modify(struct mdio_device *mdiodev, int devad,
 				     u32 regnum, u16 mask, u16 set)
 {
-- 
2.52.0
