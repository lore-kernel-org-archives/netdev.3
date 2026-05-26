Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1A2C0F8C;
	Tue, 26 May 2026 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809916; cv=none; b=Koh0ZP4/5t+HztgcPw2NP6XmZBQRY8dMEGsRjUGhXe4SOczjHI6/LQtkXSekONELBE75dQeftQJNfwPeAhiY6IlK+tI3gRwZQBFo0Be9WN04WyBgtD2BzH/xedGDOugI6Ln8L74bMY31KPCNpTm6GOT0J78SfDYNV5ZudGnkNNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809916; c=relaxed/simple;
	bh=SoF0+qd7Up8AsaKcAgt3JDCGyWedTZte8EHHCxI8dZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HWsG5WPvNzvGygaeWi7ex+J0cgdFJ5oAHqsNAMKz54qJVeGkkO6V4z5HhBLamEqxVDcaOl1/x7fRuqRwrnMZ1p4wYv2+kyAzm4DezIdrdYw9ecnO1pKLudsuYLcpjRWNxNqoKDw/kQObYgYUWMCb7aDoBWXfLo1KdNesh8fh4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=wQ7Oiy7m; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="wQ7Oiy7m"
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id 79455602E6;
	Tue, 26 May 2026 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1779809567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GESGTyRKjIQzxSqSfucE0sI1Xh7zcNnZwvp69z7bt8E=;
	b=wQ7Oiy7mfqRvlFuzhLyK8gMi7Se7vPyXNVzHuCYNJrFLB3grvbo8IGsXqr1GIFdvUvNtdp
	z2EMZosZPStIixvNBdkcq05+KhFpDClEa73Skw0JB8NcNAP0KsU5IiD2Cad1kYciKegETC
	4HNMs5SAnyrYNvlq/ftNz6m18xo+UT0=
Received: from frank-G5-5590 (fttx-pool-217.61.151.155.bambit.de [217.61.151.155])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 3AC81120056;
	Tue, 26 May 2026 15:32:47 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [net v2] net: pcs: pcs-mtk-lynxi: fix bpi-r3 serdes configuration
Date: Tue, 26 May 2026 17:32:38 +0200
Message-ID: <20260526153239.30194-1-linux@fw-web.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Commit 8871389da151 introduces common pcs dts properties which writes
rx=normal,tx=normal polarity to register SGMSYS_QPHY_WRAP_CTRL of switch.
This is initialized with tx-bit set and so change inverts polarity
compared to before.

It looks like mt7531 has tx polarity inverted in hardware and set tx-bit
by default to restore the normal polarity.

The MT7531 datasheet quite clearly states:
Register 000050EC QPHY_WRAP_CTRL -- QPHY wrapper control
Reset value: 0x00000501

BIT 1 RX_BIT_POLARITY -- RX bit polarity control
 1'b0: normal
 1'b1: inverted

BIT 0 TX_BIT_POLARITY -- TX bit polarity control (TX default inversed
in MT7531)
 1'b0: normal
 1'b1: inverted

Till this patch the register write was only called when mediatek,pnswap
property was set which cannot be done for switch because the fw-node param
was always NULL from switch driver in the mtk_pcs_lynxi_create call.

Do not configure switch side like it's done before.

Fixes: 8871389da151 ("net: pcs: pcs-mtk-lynxi: deprecate "mediatek,pnswap"")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2:
  - send as non-RFC
  - add datasheet information from Daniel
---
 drivers/net/pcs/pcs-mtk-lynxi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index c12f8087af9b..a753bd88cbc2 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -129,6 +129,9 @@ static int mtk_pcs_config_polarity(struct mtk_pcs_lynxi *mpcs,
 	unsigned int val = 0;
 	int ret;
 
+	if (!fwnode)
+		return 0;
+
 	if (fwnode_property_read_bool(fwnode, "mediatek,pnswap"))
 		default_pol = PHY_POL_INVERT;
 
-- 
2.53.0

