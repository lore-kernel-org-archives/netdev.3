Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0935C6A0;
	Thu, 10 Sep 2026 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021906; cv=none; b=BFaEuwJ19gA1X0J41ciOdITwvhPnzMMYGwU4bzw7o76aGSHH0ZLw2f2mhdZBxVxU62YJxld+h6rLOl8pOs0d8KWIeHHpM2Rw220q9v4BZMdXZOqxftrJZqomT+2YjZlDTQZWQ7eUjfqDF5k4MOUDi2Z8lGzYmFXuaBq/4zyTJMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021906; c=relaxed/simple;
	bh=dKsBgPkCp4Mm20wjkhNiis4P6tKXYfB3uX0VENATX98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCU80OVKuuqt+N/xikOd6SBUOKsWvfL1p6UFRpmkTpbLr/5sk/0qKPNuCbcM8TyrPh5kZ4Ist/xNTtmP86TJEykUkGn1vy7wUFBRFqa8sgBlu2FLk6UEnOLSt+kH0dV5MT8W7Ka+nMONxaQ/Sj+pqVzng+dGItZOxJsT3wb387I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=aUiRyGAz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="aUiRyGAz"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68A6VFI001272539, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1789021876;
	bh=+vKIK/iON+GSIGW0B5evfZrVAgZPoj+LkRZJrknSthA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=aUiRyGAzau/JcVu/S72MV542dCtxLUvoOm/+y+FhTxPEM2+ECs5I8YRyCcBFgxPeG
	 232RDLD/3rXVBGKYljO79PjEnTWIKVyuwKLE72Y+01emN1oAVqmpCOPNKlAKWDK+XK
	 +8h6f6uowzg6K3zutotjNEVFn5Be3I7mrZ/TsacE7xvPF6/lvX39XWD1Wwm46ZZQVR
	 70pDbPDqEnzML/+upvL+22XnaBrOqwsNkM8rZ3thdob+Xd3u7JN42nHfGKSsH68pN5
	 vI6iJm/049ukCCG4hMQYzfWEGVuEp3+1RmwnFXXjJSep0A6f+aPUOk32UfBbQoBOwr
	 oDWvOx6ApEqAg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68A6VFI001272539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 14:31:15 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 10 Sep 2026 14:31:15 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 10 Sep 2026 14:31:15 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v13 7/7] r8169: add get_channel support for ethtool
Date: Thu, 10 Sep 2026 14:31:10 +0800
Message-ID: <20260910063110.1350-8-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260910063110.1350-1-javen_xu@realsil.com.cn>
References: <20260910063110.1350-1-javen_xu@realsil.com.cn>
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
---
 drivers/net/ethernet/realtek/r8169_main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index a103e04e6fc0..b6f7d212ed77 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6705,6 +6705,22 @@ static void r8169_init_napi(struct rtl8169_private *tp)
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
@@ -6723,6 +6739,7 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.nway_reset		= rtl8169_nway_reset,
 	.get_eee		= rtl8169_get_eee,
 	.set_eee		= rtl8169_set_eee,
+	.get_channels		= rtl8169_get_channels,
 	.get_link_ksettings	= rtl8169_get_link_ksettings,
 	.set_link_ksettings	= rtl8169_set_link_ksettings,
 	.get_ringparam		= rtl8169_get_ringparam,
-- 
2.43.0

