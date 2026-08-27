Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F633546C0;
	Thu, 27 Aug 2026 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813986; cv=none; b=LhT4/71uwTLcs77TQdmmlETu5PiMje15kVoqtXfoHySSrnvZHal3DoIsdvlj6soiZbiI1qtj8CPHIVg+CVMLVfPv3c06LHyDaRVKHTRLT3i2M+HqYoLW0cE8sWgHLhqFHtBRbomM+X96OkSf1x0liQdypXyTXlE63+nsrvHRly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813986; c=relaxed/simple;
	bh=EtW5qDNNQBRBjNlHCtHoRr/rAuMn7nDw5UTRYfFujxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jkZIa5d9k2VOE5Ll7UW2HgMbk+5dSOli2OuCk7+KKZNOIBxvyja0Cywjui1PAZIfvZQxyZdNXVH+DjiF5o+J7HKTW0+NEJjwJC2qs5wUJYfkzi6xVoZewtmDABaHp6MqfkDkSvHC+kzsAnT4w2wLo/Drtsw24w997yw5sykhVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=e1TRsqKf; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="e1TRsqKf"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D74841F09C3;
	Thu, 27 Aug 2026 08:59:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1787813982; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=5a4Ct2TQR5GyrAmZBM32R/OaAnB2Eg0670ccoq9Z+7c=;
	b=e1TRsqKf1MY1Z2YTX9FOrv3ln5C2eqR2/d10MpigS+XCHz4nXUFhZ40VB99yeOWWLlp70I
	6rCmyxDwRu9XSqkfQv2UUQRFUD7xqr8kl3sNPCsvGov6GEIGcnoNXxcZPGQ2lzxteYnOas
	q+wywY/FH+BkZmNnT96FrDDSCTJil4KK24RHeqGRkgaxTiI8E5F1eRp2Q1e4mHoAXHgNs1
	Ii88+C11biKjUjq9PJfd0kLNugDvMTMUVrhF5QbhLdEyQLXa1iPlf2rxcJezIFFdt3sTPt
	lMkeo6OfcZ+gNwl6FwfT82Ksgg6WfSc4KfG8dV7oHxOwUBAXEO5SFlPeileAaw==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	daniel@makrotopia.org,
	naseefkm@gmail.com,
	joey@tinyisr.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH v2 net-next 1/2] net: phy: mediatek: differentiate MT7530 GE PHY from EcoNet FE PHY
Date: Thu, 27 Aug 2026 06:59:29 +0000
Message-Id: <20260827065930.2618729-2-cjd@cjdns.fr>
In-Reply-To: <20260827065930.2618729-1-cjd@cjdns.fr>
References: <20260827065930.2618729-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

MT7530 gigabit PHY has the same ID as an EcoNet EN751221 10/100
PHY. Differentiate by checking whether the PHY supports 1000BASE-T
which is always supported by MT7530.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/net/phy/mediatek/mtk-ge.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 73d9b72f9d9e..3b4d774057c2 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -96,6 +96,19 @@ static int mt7531_phy_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+/*
+ * MTK_GPHY_ID_MT7530 collides with ECONET_FEPHY_ID_LEGACY
+ * but this is a gigabit PHY so ESTATUS lists 1000BASE-T.
+ */
+static int mt7530_phy_match(struct phy_device *phydev,
+			    const struct phy_driver *phydrv)
+{
+	if (phydev->phy_id != MTK_GPHY_ID_MT7530)
+		return false;
+
+	return (phy_read(phydev, MII_ESTATUS) & ESTATUS_1000_TFULL) != 0;
+}
+
 static struct phy_driver mtk_gephy_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),
@@ -106,6 +119,7 @@ static struct phy_driver mtk_gephy_driver[] = {
 		 */
 		.config_intr	= genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
+		.match_phy_device = mt7530_phy_match,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.read_page	= mtk_phy_read_page,
-- 
2.39.5

