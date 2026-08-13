Received: from mta1.migadu.com (out-157.mta1.migadu.com [95.215.58.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478B412BFB
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627837; cv=none; b=B9O9/bvGpd7EgszMMpswmk+6qrjG/fYFUM5lr0WIa4xostwOgKqQ1k7IKKoNBOofWio77sC+qLIGV5yQqbt/xeq9wow5V6e8Q0oZj/rTyriNwzYVlV/1lpGpLx9yuN95h+hPotWmirDEecAEojYMmzrB3u2/yKb0ACsqFbiIZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627837; c=relaxed/simple;
	bh=Nudt+IbkfkwauE6dUG3bv1rneSe/FGDN28GDWLG9XsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLctaus2LlnsbrXFV7sDZ7Ba2kOEpRdSXr+iWo3Ro7ZQP2/PTnIwEhAG3m2b/LDOOet0lJqW8FAjbIgfizkoOpuXh2Lpq2U4sSmiq34JtLNZoMGZnAxyVrAGaKsrAg1+7JkwiZIi47HI4GFmoOV8WVuqaBKhrnDhwdsTvrgWIq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zpa1zCa6; arc=none smtp.client-ip=95.215.58.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zpa1zCa6"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Nudt+IbkfkwauE6dUG3bv1rneSe/FGDN28GDWLG9XsU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786627834; v=1; x=1787232634;
 b=Zpa1zCa67sTsaAbldjGVJ8DiVZCwwB3MyeARtAD6F2Ndt1MgEY5Wj0d98WFY7WC4K4SPmGf5
 GYaRiTy+7zxF2kAJkRfDiCpBA6VTzISrpV0ygDLi8XRh8BhD26chM95FCfaCmtAnsaRvDV08hwo
 Jlyg/Cw9+Zw2cdI9pqrFLqNE=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 135311f7978a6c62;
	Thu, 13 Aug 2026 13:30:34 +0000
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
Subject: [PATCH net v2 5/5] net: phy: propagate errors from default port setup
Date: Thu, 13 Aug 2026 21:29:45 +0800
Message-ID: <20260813132946.116176-6-xuanqiang.luo@linux.dev>
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
index e429e6d702933..b0060b4147348 100644
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

