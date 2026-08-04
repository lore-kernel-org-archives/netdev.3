Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532D63EC822;
	Tue,  4 Aug 2026 03:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813069; cv=none; b=BOky/kj1udzcbA+08Yaa75yXnNlvN3vImgnOh0P//y0l35rMzM2W1LdyaUSGWsXKUwyrYLxbeaTLqfgzDzk6eY7UZ7fuKQk9rdcrpFwhKhtmUtjGcXCfr4zlUuS5ZCPQCK1BD6ljkjan8E8v2AnuJ9qhZTo5Ws8KNKxPlTuVbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813069; c=relaxed/simple;
	bh=ub3F+rC6rtI5cSg69MhEnLJ+09HEPdAJ/HE8GsNy/H4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jL0mI2AKq9NALmmuBQ+biKaZ2+58wFmpWCFDbRI94xEPl3nA4Z+Z2y6czaxSdiyDixERWjxmuqi5H+/g8qAdXCOQygyt7eErFAatoQDWtKOYCGwPo51xIZBm9nN/1jHfpCdZVzACrbY4DvTbNlH8M22aDTGii10eBk0/CgHGr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wr5YO-00000000471-1sJf;
	Tue, 04 Aug 2026 03:10:56 +0000
Date: Tue, 4 Aug 2026 04:10:53 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 5/6] net: dsa: mt7530: check command register writes
 in fdb and vlan cmd
Message-ID: <0e5d65a672313286e5a8ce28a9faba9c8972dbb6.1785811140.git.daniel@makrotopia.org>
References: <cover.1785811140.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785811140.git.daniel@makrotopia.org>

mt7530_fdb_cmd() and mt7530_vlan_cmd() start a command by writing the
BUSY bit to MT7530_ATC / MT7530_VTCR, then poll for it to clear.
mt7530_write() discards the write's return value, so a failed command
write leaves BUSY unset and the poll succeeds on its first read,
reporting a command that never ran as done -- returning stale FDB data
or silently dropping a VLAN table update.

Return mt7530_mii_write()'s error from mt7530_write() and check it in
both command helpers.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: new patch

 drivers/net/dsa/mt7530.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 69cee61564cb..c0437273270b 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -185,14 +185,18 @@ mt7530_mii_read(struct mt7530_priv *priv, u32 reg)
 	return val;
 }
 
-static void
+static int
 mt7530_write(struct mt7530_priv *priv, u32 reg, u32 val)
 {
+	int ret;
+
 	mt7530_mutex_lock(priv);
 
-	mt7530_mii_write(priv, reg, val);
+	ret = mt7530_mii_write(priv, reg, val);
 
 	mt7530_mutex_unlock(priv);
+
+	return ret;
 }
 
 static u32
@@ -249,7 +253,9 @@ mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
 
 	/* Set the command operating upon the MAC address entries */
 	val = ATC_BUSY | ATC_MAT(0) | cmd;
-	mt7530_write(priv, MT7530_ATC, val);
+	ret = mt7530_write(priv, MT7530_ATC, val);
+	if (ret)
+		return ret;
 
 	mt7530_mutex_lock(priv);
 
@@ -1632,7 +1638,9 @@ mt7530_vlan_cmd(struct mt7530_priv *priv, enum mt7530_vlan_cmd cmd, u16 vid)
 	int ret;
 
 	val = VTCR_BUSY | VTCR_FUNC(cmd) | vid;
-	mt7530_write(priv, MT7530_VTCR, val);
+	ret = mt7530_write(priv, MT7530_VTCR, val);
+	if (ret)
+		return ret;
 
 	mt7530_mutex_lock(priv);
 
-- 
2.55.0
