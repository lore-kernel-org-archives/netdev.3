Received: from mta1.migadu.com (out-88.mta1.migadu.com [95.215.58.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD21357CEA
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 07:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295874; cv=none; b=qYXwNRxcG3GsSuJGvuMs2RbX7BG+VQinO1pkDsnUgMpygJyED1imiW+LTmm4fClBFEtRIdEygzuZH2lZjsA56cgBAHB91SasRSzjpzoc08k1bfg4uG+TO6m9Ljn5JsDA8k/iMdXDEc8GzdTM0MfWvtOX5af5BEArZE8Wn2077Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295874; c=relaxed/simple;
	bh=Pibs+c7tZQLPitx0IfvSOl7lc/8t3c9y/LRGCRLWcAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jR6bSMU78JPDh76veaMcBf7dHrHMr0z3MxKahsKgoL3fHMdXt12Knj4CHPWALrhwJixOr9ZGG9xz42ktZchzuYomuCnryAvjC1U1NOIUhXhBMKJrnvSd1SHrUTuZunUBbOeybkd5QpJbdcmEkCPNtoXMhKpBCRgm3bvooB+3wjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MTHWYhtW; arc=none smtp.client-ip=95.215.58.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MTHWYhtW"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Pibs+c7tZQLPitx0IfvSOl7lc/8t3c9y/LRGCRLWcAg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787295870; v=1; x=1787900670;
 b=MTHWYhtWpHB6uD6WIJMV+Pm0KLduchzRrZSH7whY9uHrfFOlLBULYoK9nVdyy4ORd62MxBcJ
 OJ5XjnnZytZeeOPnh9OuG+5Db+3p0wzMNyig8HgZR+os/HNQMhJgGEgmB23ofzlSfbsVm4bRXBn
 DXmsU94XqdnJqJhuiV5aLVEc=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id be9ba88dc2e76e90;
	Fri, 21 Aug 2026 07:04:30 +0000
X-Mizu-Trace-ID: be9ba88dc2e76e90
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	kuba@kernel.org
Cc: hkallweit1@gmail.com,
	qingfang.deng@siflower.com.cn,
	hao.guan@siflower.com.cn,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v4 4/6] net: phy: call driver remove when core initialization fails
Date: Fri, 21 Aug 2026 15:03:25 +0800
Message-ID: <20260821070327.16147-5-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821070327.16147-1-xuanqiang.luo@linux.dev>
References: <20260821070327.16147-1-xuanqiang.luo@linux.dev>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 891df46d0597f..691396794decd 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3758,7 +3758,7 @@ static int phy_probe(struct device *dev)
 		err = genphy_read_abilities(phydev);
 
 	if (err)
-		goto out_reset;
+		goto out_remove;
 
 	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 			       phydev->supported))
@@ -3775,7 +3775,7 @@ static int phy_probe(struct device *dev)
 
 	err = phy_setup_ports(phydev);
 	if (err)
-		goto out_reset;
+		goto out_remove;
 
 	phy_advertise_supported(phydev);
 
@@ -3850,6 +3850,10 @@ static int phy_probe(struct device *dev)
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

