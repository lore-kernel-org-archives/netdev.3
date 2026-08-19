Received: from mta0.migadu.com (out-153.mta0.migadu.com [91.218.175.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D1D3C0626
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 06:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119408; cv=none; b=FOkhiMoq2zmfI/ztVY91XqpugAZwuEt7qhbW37dh5bc8QG/GgzFUdPsszwczvdQZE8tXVX49AMon/az+ROAFFRGdj/gHI7nhVHKiMvfKDaYYzKv2Z5GTjlYanFvZJYT02j5sSbxWwB/jzwjg2Nck6fc+gcP/u+e2jv07s24/s7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119408; c=relaxed/simple;
	bh=EmhKUTWRS2gxMw60Au+ba04qxs4iAzdtgW66bOcnh+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDs/iOVSLyTYi+k/6cOQg9mlhbCKc2aui5AWhhlJvGOTTzZEwC2vM1c766xEa4GjUsYRs+/EVT97xp4BUtwjQX9zHOmLBITRTenxoQo/HgXIfKRGhNulnQUgBWG7xWfxV9DMri4qRidOoaSvZQhp8dHVJbw9ymLUPhQWopkZ4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wLO6x7Vc; arc=none smtp.client-ip=91.218.175.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wLO6x7Vc"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EmhKUTWRS2gxMw60Au+ba04qxs4iAzdtgW66bOcnh+w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787119405; v=1; x=1787724205;
 b=wLO6x7Vcf/O9jrCnEos0tuFWv+JQlMOwc9BmDvJf91HGpgGZo4H6S07UjaG6BRcqbpEAoI+u
 UPY+2manfzwUEi0tZGvW6CiPbG5OrTTvHw8hiXFx092IkR1l5q1kyhcDnWthdUIPXIu0a2GdJgA
 m32s+pKoUaGGL366py48x8G0=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 71db182c2f37b3bf;
	Wed, 19 Aug 2026 06:03:25 +0000
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com
Cc: hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	chleroy@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v3 5/5] net: phy: propagate errors from default port setup
Date: Wed, 19 Aug 2026 14:02:36 +0800
Message-ID: <20260819060236.24665-6-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
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
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 77318659ff985..22a5af92c620a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3458,6 +3458,7 @@ static int phy_default_setup_single_port(struct phy_device *phydev)
 {
 	struct phy_port *port = phy_port_alloc();
 	unsigned long mode;
+	int ret;
 
 	if (!port)
 		return -ENOMEM;
@@ -3484,9 +3485,11 @@ static int phy_default_setup_single_port(struct phy_device *phydev)
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

