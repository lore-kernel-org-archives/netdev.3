Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C252B39E9DD;
	Fri, 18 Sep 2026 06:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712402; cv=none; b=rdu4GgpLLa0Uz48FjFZktcL7IvAy4D/maoPJ49Z8Q2WE0eGsUskWiOGIAlpSRqtHoz1n+KkQIjfTx7fGaV7QHfsPA655NGpnXzi7yBE+lKa0p4Cvxvr7hGpKMs4kaqVGk9ax5Nn9WcqPsaate1tS76mALCvq302oCYyPgIBwMEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712402; c=relaxed/simple;
	bh=Obu9s8aWAUYD7m1953hE8/p1/d6/rC23R+HtwFT20fk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czYX+lntn+bW6ibWi8oY/7DLrsrJETxPgYh/BqoXGSNPv0sLOYPJhQZN8poDVqx0GFGclbCUwS8EnzmMtW0euqjHVD3tAXUR1oUhUHZtcBFpH5srDzL2zxQzc85K59f7XgdOlOkTUuw4iXIWk8KvdYyUzRSEXZMw2Xio8Nxr4rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=hGIos348; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="hGIos348"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68I6JRTL03939109, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1789712367;
	bh=g8HGmnBGFHOR3bN1F5pgHpUoh/WzdEpwmMXvP1Oa4ms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=hGIos348hVSdzXGC/wHEFmeLXcSiKFoRRNJnEPqZutllM2RuqMHZwbYn+cheL9FxL
	 ThU+jlj7re/vj0oPIcfu9kp92PKbSVm1l6aKkD86q9b78yZNChZ8YZlo7jll/69v8j
	 SEyCw2tpHcVMzR/c9gZ/nPO13qVFdQy2FJgwweF/UUK81QLrp4Od0vwVV6omShVe0k
	 ordMNBb087aCG6O3DmQN/jVhz8q0LclsqM1g7dki4NIO/rRTUmqctgthaqM6TRzJbP
	 EwNXTUzvttgtQzZUv/11/xYX2EEr7D445i27GHtYJjP/WExpOjT8VjXctXIbUfimM3
	 kzmYbVqTxnKbA==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68I6JRTL03939109
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Sep 2026 14:19:27 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 18 Sep 2026 14:19:26 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 18 Sep 2026 14:19:26 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v14 7/7] r8169: add get_channel support for ethtool
Date: Fri, 18 Sep 2026 14:19:23 +0800
Message-ID: <20260918061923.313-8-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260918061923.313-1-javen_xu@realsil.com.cn>
References: <20260918061923.313-1-javen_xu@realsil.com.cn>
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

Changes in v13:
 - no changes

Changes in v14:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3be6f6e708f2..7a61c2ecc7d1 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6713,6 +6713,22 @@ static void r8169_init_napi(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_get_channels(struct net_device *dev,
+				 struct ethtool_channels *ch)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	if (tp->irq_nvecs > 1) {
+		ch->max_rx = tp->hw_supp_num_rx_queues;
+		ch->max_tx = 1;
+		ch->rx_count = tp->num_rx_rings;
+		ch->tx_count = 1;
+	} else {
+		ch->max_combined = 1;
+		ch->combined_count = 1;
+	}
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -6731,6 +6747,7 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.nway_reset		= rtl8169_nway_reset,
 	.get_eee		= rtl8169_get_eee,
 	.set_eee		= rtl8169_set_eee,
+	.get_channels		= rtl8169_get_channels,
 	.get_link_ksettings	= rtl8169_get_link_ksettings,
 	.set_link_ksettings	= rtl8169_set_link_ksettings,
 	.get_ringparam		= rtl8169_get_ringparam,
-- 
2.43.0

