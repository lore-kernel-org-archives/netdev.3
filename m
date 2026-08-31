Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006532F691D;
	Mon, 31 Aug 2026 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154830; cv=none; b=oHIJRcbS1UDbVC3wrjNngyfc064nVCcT5HXKHEa27fkvXomJ97FMMWrWnDgT45NkmW0dYnGwdwPcO+cNDuaZ53Pdpv+Fzv1OkHVuJKmK+VLbtgak4/nugCUjCdtdf9G5Z0CHDUhT+nG+POhomBCOqvGMzY6E0vr8yOXRDA81h8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154830; c=relaxed/simple;
	bh=GyR1aCyPS5HfEqPTkE8awcexH2Q2YzwEZZJdo7Z63y0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKOFrujpU90SpQlR9JqK5uV79K1s9eE+aIvOAiKIZszq/MO3M9PwijAfbXcnbqWPW2bF05LnvM4PuSNSgTT9nULRJHBMhgNkaYsEiXBfKIWojJWIrhYKIWv3ySwYftRvD1Dn22dz9+apFrobsy87GMZBcLAvYLMGi7uYyDDzCyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=RvKpZUAv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="RvKpZUAv"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67V5dkCfB479611, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1788154786;
	bh=kSAt4pP7q2zJ+tIhocMDyl1Js2iqnMV/Xzr4XTJhS1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=RvKpZUAvTnb89TiOwAfoq8qTONrXVo7V+lsaT+69VoVvRAga4qwXkezZ/hEg1T8Tx
	 +W2EWlvD8ojYrw+yjsNOgLT1tht3h1OUef4DmliKFKexGeAcNeZGhczHLdBg+uhrbi
	 eIcKBmtayVdXWl7dCGHpEywASU5DFbbMnyRIzDUwBJi4Ctr3zyZyfijsby/QZtybwB
	 CkdSsWBZuB4P0LTvWCMVxh2thpzeAPLH+oQD16GK91nHbf+BVszKVJ+DmkmTO69uQc
	 nqnZCUygQ1PNW3S0RfeRHWyZuRdUy6fpv/tTb3Mqu45j/feBaCO/uK+XnKYOPKjLmq
	 8ViWGd1UM85DA==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67V5dkCfB479611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 13:39:46 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 31 Aug 2026 13:39:44 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Mon, 31 Aug 2026 13:39:44 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v12 7/7] r8169: add get_channel support for ethtool
Date: Mon, 31 Aug 2026 13:39:40 +0800
Message-ID: <20260831053940.620-8-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260831053940.620-1-javen_xu@realsil.com.cn>
References: <20260831053940.620-1-javen_xu@realsil.com.cn>
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

Changes in v12:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 11fb31223f49..a76fbf1e50d1 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6302,6 +6302,18 @@ static void r8169_init_napi(struct rtl8169_private *tp)
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
@@ -6320,6 +6332,7 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.nway_reset		= phy_ethtool_nway_reset,
 	.get_eee		= rtl8169_get_eee,
 	.set_eee		= rtl8169_set_eee,
+	.get_channels		= rtl8169_get_channels,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= rtl8169_set_link_ksettings,
 	.get_ringparam		= rtl8169_get_ringparam,
-- 
2.43.0

