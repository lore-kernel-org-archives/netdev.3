Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32903A3E98;
	Fri, 14 Aug 2026 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672358; cv=none; b=q1DTnvY43DpRfScqUGZMBQTjV+8mDEj8uYLauyHQBROVx/ffGhx8+aO3mgOnk9nGw7czfhV7rd8AG9XfPOTkBxHLY3vzEy4k+ePyqQgY7qeuWcKO9o/UHFaRZIBbh8yzq0fqLPsehHtBD2jo6pc1Mc8+xHjJx6VD6QAoy72Z4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672358; c=relaxed/simple;
	bh=PwG/aFwCkeA0D1ViWjeuYjHzFqExVEZ0jjMwokIfXBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2bFlggila3j/awxoICNrzjw2DC7tUG7OdreMGySqF0qtq8cVsJdg+7AgL2sb8/NGGdNQW0rAjqy8kFfbn2ZrVoYOhYmvIuvGlH3lzUa/Te6mEG6hp0xzMj3umrCsh2YjXZVLLovEbr+4jwKRcStvjRc0yMA6E/BzFEuctANYRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=wlNkdtR4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="wlNkdtR4"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67E1q8zmD864087, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1786672329;
	bh=R5Vw5ABE3/eH8wXTl9dK3hseFAkvUIgLEAZ2P1EsAmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wlNkdtR4y81qS1eIPoq/ZlsAR+JuVWm6D2H9J2/GlI1wF8ABGfukaHEY31W+zGst3
	 FpNr+kUaVr59VEtRKuOVnkPJ7W84rCQInio0BkqTaGt483ZSkijDan48TO3piMh0tm
	 8rGrQ3OGtum21eIvFYpW7pevEQSB1PoUqSwhcPNHaidLZsr8YW3Ahk3ASdGpq9MqIL
	 cftcg+mIZZSBfOGYFeJoaJizpDI9B8aqv2pqLyXYaGKiz0sU1of6DgMRxYzL/HM4H0
	 u2+atr7T2xctFxlZr6Ki/BALVwlQixz0S9DeJC/y71fEDAKV7t8SjTIa1VswBzcR7F
	 w9B2HG1NF8dng==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67E1q8zmD864087
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Aug 2026 09:52:08 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 14 Aug 2026 09:52:07 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Fri, 14 Aug 2026 09:52:07 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v11 7/7] r8169: add get_channel support for ethtool
Date: Fri, 14 Aug 2026 09:52:03 +0800
Message-ID: <20260814015203.1328-8-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260814015203.1328-1-javen_xu@realsil.com.cn>
References: <20260814015203.1328-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

Add get_channel support for ethtool.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v11:
 - new file, no change
---
 drivers/net/ethernet/realtek/r8169_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index e4a944727bbb..13372fc55eee 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6295,6 +6295,18 @@ static void r8169_init_napi(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_get_channels(struct net_device *dev,
+				 struct ethtool_channels *ch)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	ch->max_rx = tp->hw_supp_num_rx_queues;
+	ch->max_tx = 1;
+
+	ch->rx_count = tp->num_rx_rings;
+	ch->tx_count = 1;
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -6313,6 +6325,7 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.nway_reset		= phy_ethtool_nway_reset,
 	.get_eee		= rtl8169_get_eee,
 	.set_eee		= rtl8169_set_eee,
+	.get_channels		= rtl8169_get_channels,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= rtl8169_set_link_ksettings,
 	.get_ringparam		= rtl8169_get_ringparam,
-- 
2.43.0

