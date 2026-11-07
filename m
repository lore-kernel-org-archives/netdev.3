Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061193;
	b=oOehcRMaI454nq0jx05t/L/gLrlGUxEWyOG6dyawQfbbtwTznW+NXG6mJmRRLD+73vRK
	 qnStKSVdHn5B+lEwe3VXXmSsCPYs2vH/1VnA7Tt59bWQ2g4DUPQ1SbflKU0X6BvgKNO77
	 Q6ip4/xcWSXLnNHLBq2iOMRUs5gyuHYk4Eafwp2mAP5cGIySU/TwD20efKPmSF/uqDFm1
	 waWz48y27vNR0XPkiXC9VeaJ/fS0lxGGCg9mG/BCkYE2lhn7xUnh5O1UfRrUiQDP61jfz
	 98WOYMw4lV9dn+IMc3k5SgQklRW1gz9wJHOde5orVMT5KBpceAdq3l0oKKLx8hwLYCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061193;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6Xy4g2k9SgZBU5SQWNQcYqwfJeIbihBIIqmeCYm2TIs=;
	b=kqRK3ooK8fzlz2PtqApzURN4upJvjOpc+mz6OIm9ezCN78hduLUtQD+Evkwt4ikKSfdG
	 wOrqLp2umcd4Rwtn8PrzhrGcC667vIg+Yz2YqmJXJNoFSICjNYZ0c+eqCHtpPt+PtqtlI
	 Jv5e7q903qxPMylAXxX1/9cA4G+EF34Rm52OxG6uJBhFxzmTvGU0EsXFBhJgeMnKgxhAe
	 pppAz90dI560tE62FxBoNxHt3uF4cEfonU/01lzSPKAQb1yHu6iM17qI1ZxYZtAH/Tyd0
	 kirjFEdW97/A7mE0LuBqPJjtRSPJYqanUgPIgXvfGSdDzVLKySbeI/0f+nkvsLN7BnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=OfoZT1md;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EEC606A326;
	Sat,  7 Nov 2026 14:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3EEC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=OfoZT1md
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=OfoZT1mdEV1XwpGxGjrElEH0VxKM7xWy8hj6ScvZu/fK/lGZH2KUTc0M3cAQOwMeQs8XZyYTQSp1O
	 auK57dKui2koR4W18X4TmUSbN3XZAfq9ChAgf1nWgIj6hEoMikmhRYM645W9Mcde/ViKs4RaWQgner
	 87cSA96ODVUKBqUc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76aef337ba39-b8122;
	Sat, 07 Nov 2026 22:19:44 +0800 (CST)
X-RM-TRANSID:2ee76aef337ba39-b8122
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.79] (unknown[112.23.104.16])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6aef337e00c-47617;
	Sat, 07 Nov 2026 22:19:44 +0800 (CST)
X-RM-TRANSID:2eea6aef337e00c-47617
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 yana06070@163.com
Subject: [PATCH net-next] net: ethernet: mtk-star-emac: fix device_node leak
 in mtk_star_probe()
Date: Sat, 07 Nov 2026 22:19:42 +0800
Message-ID: <1794061182000.57993.3986467551914992480@cmss.chinamobile.com>
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

Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
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


