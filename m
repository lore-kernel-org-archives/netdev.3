Received: from mta1.migadu.com (out-152.mta1.migadu.com [95.215.58.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3A0313267
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627833; cv=none; b=dlszKSdaQLiD3CxzYcqPx8fYtZ4ZRRHwXAHVwb+gSyhznihQXh/42B/JgICsCtaJPL7inNDHFSvPhl/sILs/oC6Pi80C1hCBBC2VjfivPJgL8QMrg9vOjJk69srEuaEr48G+Y9rpcBHOczWFsPGpgDq2g2978CPL64w2rdMrY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627833; c=relaxed/simple;
	bh=0vlOCpYNZjGLKJXhXKNPZlQoO53c/wGY2T+lT0zR1rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcaWbPcVEV1ZBkevKnZzBEcRAAkQx0yyBK63+0GbEMquAn+PCCvPSdhmiKWdLx0nV2/OvV8knXnVDBUQue/bhohX5E67aWVuOHTTzetsMRdsUKfmSH3hpFhsHCO/E+MRcfG/wnxoNW2yMIFLnh1UftPsqyMErJk/zmWHegAHdWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nYM4lutw; arc=none smtp.client-ip=95.215.58.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nYM4lutw"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0vlOCpYNZjGLKJXhXKNPZlQoO53c/wGY2T+lT0zR1rs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786627829; v=1; x=1787232629;
 b=nYM4lutw2XIpw7/VHM/l/0bUUYXXWCt/ePr5z3t8CYYrOvEHYvh+sEkyHOdTazgbTtTiKnj5
 DEHx60ZmNV1zwFcxMROQiYJhcdV75u7mAXNhDFvfI5NxetAl1JvOai2HczPJT3vQnWh6OSo35FI
 kWEOefCH21tL2kBFNbDR/GWo=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id a87847907bbed906;
	Thu, 13 Aug 2026 13:30:29 +0000
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com
Cc: hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v2 4/5] net: phy: call driver remove when core initialization fails
Date: Thu, 13 Aug 2026 21:29:44 +0800
Message-ID: <20260813132946.116176-5-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813132946.116176-1-xuanqiang.luo@linux.dev>
References: <20260813132946.116176-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

phy_probe() may fail while querying features or completing other core
initialization after the PHY driver probe callback has succeeded. The
driver core does not run the remove path after a probe error, so
resources that the PHY driver releases in its remove callback are
leaked.

Call the PHY driver remove callback on these failures.

Fixes: efbdfdc29bdd ("net: phy: Add support for asking the PHY its abilities")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c9e75bd3b81a2..e429e6d702933 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3733,7 +3733,7 @@ static int phy_probe(struct device *dev)
 		err = genphy_read_abilities(phydev);
 
 	if (err)
-		goto out_reset;
+		goto out_remove;
 
 	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 			       phydev->supported))
@@ -3750,7 +3750,7 @@ static int phy_probe(struct device *dev)
 
 	err = phy_setup_ports(phydev);
 	if (err)
-		goto out_reset;
+		goto out_remove;
 
 	phy_advertise_supported(phydev);
 
@@ -3827,6 +3827,10 @@ static int phy_probe(struct device *dev)
 	phy_sfp_release(phydev);
 	phy_cleanup_ports(phydev);
 
+out_remove:
+	if (phydev->drv->remove)
+		phydev->drv->remove(phydev);
+
 out_reset:
 	/* Re-assert the reset signal on error */
 	phy_device_reset(phydev, 1);
-- 
2.43.0

