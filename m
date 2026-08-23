Received: from mta1.migadu.com (out-146.mta1.migadu.com [95.215.58.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875AA327C09
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 03:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787457413; cv=none; b=QWB2ubsJMowFRK5dQ3eaxbPVOQ4Ww4m84YDOiJYL4o4hTlbBCcns63Nq/jHbhFuCXWqr3vzvtDXd73O0KtGBTDPE5EjLmCuT3iAlAzp3WRnTergg9G6+xolsR8Yuuk9GE8VH2ra1pE3YDJ97sXDpAV04RWxzWc666PQZdD3BMVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787457413; c=relaxed/simple;
	bh=BVqz1oSIQi/XvJyGJbj+unnm7ap4CuuN+D9EOZHYO0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaZDCQdOzLKf2D/G/t9zTTb6GEWtTwlFPC8dhVlQmhw+UiDc2W9AoOYfUgG4O/xf+ItrDKeX5EEJf7ujuupEJsoF+/EfOXGFvm//OMO35hcKuvI9adORZQsQC/KUZYqCJzH5zdxEc0ODmq7y2qZ9pAA3i+Na9aFuk44mbYUkkdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dgKgoHeN; arc=none smtp.client-ip=95.215.58.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dgKgoHeN"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BVqz1oSIQi/XvJyGJbj+unnm7ap4CuuN+D9EOZHYO0Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787457409; v=1; x=1788062209;
 b=dgKgoHeNhX1e9aHyr32OmPSzeLukB/0md6dSHBSbAxkFHjEX378Z+i+vPb0i68wXFoO/Nliu
 4miD+l0iQMSGdsJj0DKvPZegs8zkYPiXU8/is2E24s+46i/EvZXSDO3fGOHYGN0MbwPi7zWIX7a
 s7HmAOm3rew9nTP0iFPQn30A=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 48c5bcb9f7b66140;
	Sun, 23 Aug 2026 03:56:49 +0000
X-Mizu-Trace-ID: 48c5bcb9f7b66140
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	kuba@kernel.org
Cc: hkallweit1@gmail.com,
	chleroy@kernel.org,
	qingfang.deng@siflower.com.cn,
	hao.guan@siflower.com.cn,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v5 5/6] net: phy: propagate errors from default port setup
Date: Sun, 23 Aug 2026 11:55:59 +0800
Message-ID: <20260823035600.188864-6-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823035600.188864-1-xuanqiang.luo@linux.dev>
References: <20260823035600.188864-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

phy_default_setup_single_port() ignores errors from phy_add_port() and
always reports success. If a PHY driver attach_mdi_port() callback fails,
the phy_port is leaked and PHY probing continues without the expected
default port.

Destroy the port and return the error.

Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 691396794decd..8cb0d60fcbba9 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3483,6 +3483,7 @@ static int phy_default_setup_single_port(struct phy_device *phydev)
 {
 	struct phy_port *port = phy_port_alloc();
 	unsigned long mode;
+	int ret;
 
 	if (!port)
 		return -ENOMEM;
@@ -3509,9 +3510,11 @@ static int phy_default_setup_single_port(struct phy_device *phydev)
 		port->pairs = max_t(int, port->pairs,
 				    ethtool_linkmode_n_pairs(mode));
 
-	phy_add_port(phydev, port);
+	ret = phy_add_port(phydev, port);
+	if (ret)
+		phy_port_destroy(port);
 
-	return 0;
+	return ret;
 }
 
 static int of_phy_ports(struct phy_device *phydev)
-- 
2.43.0

