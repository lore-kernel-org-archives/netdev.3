Received: from mta0.migadu.com (out-127.mta0.migadu.com [91.218.175.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6FC392C32
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295881; cv=none; b=CpWnF1LrzPlIZzrNqYUseQVjBT4dEPCawMEr94ewem+5ZdDLGYeIfWjO7FmqiQZZzZZBp0ihHXrU9I2ydTx6qrVe/rSNpFkyKGOF/8seQHOO+OiFvtbiKb4HzuMmVDNkn3gT7OyKYVujEsnEUkrL/4XvNXzyOOUkZt7vEkMgdKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295881; c=relaxed/simple;
	bh=zBNB+lv/4uFx+0jKJ/L0bskD//2Tm9LY0LvconbI2o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkW44CiTVeZd9pmHx0/ycHSzF8a/dKUS7L4NhR9ruEfSwuleW4XTmkOlu8avcCc+6hYoey2bwvdVX1mwRgiJsCrHwo0GroCPYY5pADHb3Zk/4nPKK3EL6RFWhXKsxKsd+w7wgyJ0yytOFqiGj4FuzZbeAE58wo16qqm7V4kw6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yb232Erp; arc=none smtp.client-ip=91.218.175.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yb232Erp"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zBNB+lv/4uFx+0jKJ/L0bskD//2Tm9LY0LvconbI2o8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787295877; v=1; x=1787900677;
 b=Yb232Erp7/tetdnO+c17tY1dNO6eyTffSF6SUssv5chlCXF25ymjgTOk8pyUbyomipGV5k0W
 jdgdW7ogrCSC7VrrlLQd8P5uzVql1NHC3F6qFNFZweYVpggakxmKvSX9o92jDUdj8Xj0EQ0OUwH
 WlWttqWpOn3E+SITsqdABUtg=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 5995ade47ca2e225;
	Fri, 21 Aug 2026 07:04:37 +0000
X-Mizu-Trace-ID: 5995ade47ca2e225
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
Subject: [PATCH net v4 5/6] net: phy: propagate errors from default port setup
Date: Fri, 21 Aug 2026 15:03:26 +0800
Message-ID: <20260821070327.16147-6-xuanqiang.luo@linux.dev>
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

phy_default_setup_single_port() ignores errors from phy_add_port() and
always reports success. If a PHY driver attach_mdi_port() callback fails,
the phy_port is leaked and PHY probing continues without the expected
default port.

Destroy the port and return the error.

Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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

