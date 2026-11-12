Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794455495;
	b=Gmc1LkuWJPsc1hab52HmjwbSMUcLB9UNKxaYQAS4SYDBbYrXhmStIl3jIfGh41AZ6ASX
	 iG6fF0EUpukIRyotXRW8HujHcwdgh4xyUqyQmPrwSE5O6fR0v4eqFU/20J8/kojiS7E2S
	 ASpLRUM+jJ/hGZz5sZeOiVq3mzPkWUY0wf3TgXCydtzNeBv6kOw6uQmxTw2TTNtZvRXzJ
	 PpwXyk1RfmkI8GIBjJwmWyGt8iXnQDRl9VsHW9ds82lzeUf5I2fs9ZYCaXOeWALQHNeCy
	 SnsUwtuS+7stRW6FzKACWBr3nfimJ64JNWdRmY9czAHlfp5FG8kVAKAp3n5aQ8x6h8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794455495;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SCVn4ixoUhM5kBe1PutJBybtN9lGQ3HUNA/BXvLhSJw=;
	b=SdxU0Xw4GGN3u42lhUCklYIN2QL54rJ+uBfbE+lddSVtca5rmtoT1qjlLWSbfLOJ/Lbt
	 BkGgHP+xPq4S4OWL6LDT+GaazrFJVPgBD9oKeAjnDA+4OZfo3mj5o5hEL/RK8+giobMKG
	 y8fGiY8nVZtfMtsibIpYZ0hoC32dqIwAmEYQnvzbOQKr5R86/UYW32GBb8SzOVF2LHaPO
	 uQR7SyyPJRnBp8GkQIeXuyg6AH7gEttA0gFw3KeqQDIM+HCW0YWh9zUD87Mxrb8xep9P9
	 qR99+I+VMnzFRCHqi+y25jAOLv1NghkTWHenkoZt5UtKI4uA/lMni9iBqDcEwVqiuJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vlk87VrX;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABAD606A31C;
	Thu, 12 Nov 2026 03:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ABAD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vlk87VrX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=vlk87VrXfClLyKz7/NC3Akq1maOI8c5Zh93vseazjnYYm/jZNUyraeRP0dcaEX3N+h/gMC69JmDqm
	 7ZeWRGhv13kNZ1qRRvIjNxKFnoGC2wbLI7c7b+uI/F4bdCA5VceRPnhr1g6pqGu90jlSAqK/19EMJS
	 WhtkFF5/Cl+GeyMk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af537c35ac-7d81e;
	Thu, 12 Nov 2026 11:51:31 +0800 (CST)
X-RM-TRANSID:2ee86af537c35ac-7d81e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.64] (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af537c24aa-f086d;
	Thu, 12 Nov 2026 11:51:31 +0800 (CST)
X-RM-TRANSID:2ee36af537c24aa-f086d
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yanqing Wang <ot_yanqing.wang@mediatek.com>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 yana06070@163.com
Subject: [PATCH net-next v2] net: ethernet: mtk-star-emac: fix device_node
 leak in mtk_star_probe()
Date: Thu, 12 Nov 2026 11:51:30 +0800
Message-ID: <1794455490000.585551.2561101329908158128@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

mtk_star_probe() gets the PHY node from the "phy-handle" property
with of_parse_phandle(). The helper takes a reference on the node it
returns. The node is used by of_phy_connect() each time the netdevice
is opened.

That reference is never dropped. Every error return after the lookup
leaks it. Unbind leaks it as well: the driver is devm-only and has no
remove callback.

Release it with a devm action, registered right after the lookup.
The error paths and the unbind path then drop the node through the
devm cleanup.

Found during a code review of the OF node handling in ethernet drivers.

Fixes: 8c7bd5a454ff ("net: ethernet: mtk-star-emac: new driver")
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
Changes in v2:
- Add the missing Fixes: tag.

v1: https://lore.kernel.org/netdev/1794061182000.57993.3986467551914992480@cmss.chinamobile.com/

 drivers/net/ethernet/mediatek/mtk_star_emac.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index b83886a41121..bac4a24c5979 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1501,6 +1501,11 @@
 	clk_bulk_disable_unprepare(MTK_STAR_NCLKS, priv->clks);
 }
 
+static void mtk_star_of_node_put(void *data)
+{
+	of_node_put(data);
+}
+
 static int mtk_star_set_timing(struct mtk_star_priv *priv)
 {
 	struct device *dev = mtk_star_get_dev(priv);
@@ -1603,6 +1608,11 @@
 		return -ENODEV;
 	}
 
+	ret = devm_add_action_or_reset(dev, mtk_star_of_node_put,
+				       priv->phy_node);
+	if (ret)
+		return ret;
+
 	priv->rmii_rxc = of_property_read_bool(of_node, "mediatek,rmii-rxc");
 	priv->rx_inv = of_property_read_bool(of_node, "mediatek,rxc-inverse");
 	priv->tx_inv = of_property_read_bool(of_node, "mediatek,txc-inverse");


