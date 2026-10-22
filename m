Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671937;
	b=DWHEjD+/p/26mNnn2XhaDqRzEXigoo+NShY2QCP67ZJMxf0lZ9/jDHKV/lJ3NlNmxP68
	 TFpGCrIpoo4k3nrzidS8MJLptDEMClzMv5vXlx4OGnbxx/2m9egwhfxTgoW0EXL7lbNGC
	 bHPY6KqxszinGY/wdLN+BYxfJ7V6JXgHStL4Oi3gxlCfBq3mya63xq1aJTd1DmDYMz1ER
	 RTJ9syypGgkky0GVNMvtk/39TwFIG7FwBdmqRUpeYl1TeUZAF5t2rK2ytd8M1NV6u+JBO
	 sPDf7ak3IHj9A/ENetxmfEE1yE+kKlWZOQCR/3gnOsVvYfvXwTCBFVm/IosroLDr7cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671937;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=C0m0lk4mR96rzTYHK9ffFM9L1Pjy8jQ3td3yWQW6S8A=;
	b=zj/UBTmwlUoUIhlSubdK0690aZ1G+2kETjNlSEtzKmDkOIGb9z1kbuf91EgIdnOGlfMf
	 6jcluSO5y3RuKD5RxeINsk7cLMZkNg3kznwVNcbGhaHSlvJI1d9OFl6abWBmATXOjE8W5
	 0jgbEKrSa3KWmu1mnvxPLKAgi1GW2pDMYt4DjXPVgtRWs89A6bXcYMrAInTqnbo5ULCKW
	 NdOkA7I5OSdd7O5RRtPLBQP4IuMuQHVYeem2u75tn44IdxgDxI0EdIyBgK44lMtJXd3Jx
	 6oZGEkTGHn4A3E4zSOmY9RRkBFoGFvViGcaILFyqdPstSGN4BjstJDNUvQGdmz1a81g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fXl05Pyo;
	arc=none smtp.remote-ip=113.46.200.225
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB8606A323;
	Thu, 22 Oct 2026 12:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37EB8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fXl05Pyo
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=C0m0lk4mR96rzTYHK9ffFM9L1Pjy8jQ3td3yWQW6S8A=;
	b=fXl05PyoIlRav/EYDwensTl4UF6sWXLcrkbP941eNXk5nzOYpvVwf+bmqWY62jd4iyGovXrH+
	50gyDeKOsOQt6Nys+6eyr0/Ax/4eMy54lZ1Ofd2SXbEMwlDdOcDlZVFqsG64nvXsIyewPi6vC0M
	FkbMM8v6MHZLQ+mKMg41P3Q=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4j9QN76FY5z1K972;
	Thu, 22 Oct 2026 20:25:27 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C60440586;
	Thu, 22 Oct 2026 20:25:32 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.38) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 22 Oct 2026 20:25:31 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri Daskalakis
	<dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>
Subject: [PATCH net-next v18 4/4] hinic3: Add ethtool pause param ops
Date: Thu, 22 Oct 2026 20:25:18 +0800
Message-ID: <1e5e99cc3ff7a93094dddf96321ba465ba0ce343.1792671176.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1792671176.git.gongfan1@huawei.com>
References: <cover.1792671176.git.gongfan1@huawei.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

This commit adds port pause ops to the hinic3 driver. It implements
the .get_pauseparam and .set_pauseparam callbacks so these can be
read and write with ethtool -a/A.

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 41 +++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  7 ++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  2 +
 3 files changed, 50 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index e1f23e2477fa..3005441056f9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -869,6 +869,45 @@ static void hinic3_get_pause_stats(struct net_device *netdev,
 	kfree(ps);
 }
 
+static void hinic3_get_pauseparam(struct net_device *netdev,
+				  struct ethtool_pauseparam *pause)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_nic_pause_config nic_pause = {};
+	int err;
+
+	err = hinic3_get_pause_info(nic_dev, &nic_pause);
+	if (err) {
+		netdev_err_once(netdev, "Failed to get pauseparam\n");
+	} else {
+		pause->autoneg = AUTONEG_DISABLE;
+		pause->rx_pause = nic_pause.rx_pause;
+		pause->tx_pause = nic_pause.tx_pause;
+	}
+}
+
+static int hinic3_set_pauseparam(struct net_device *netdev,
+				 struct ethtool_pauseparam *pause)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_nic_pause_config nic_pause = {};
+	int err;
+
+	if (HINIC3_IS_VF(nic_dev->hwdev))
+		return -EOPNOTSUPP;
+
+	if (pause->autoneg)
+		return -EOPNOTSUPP;
+
+	nic_pause.rx_pause = (u8)pause->rx_pause;
+	nic_pause.tx_pause = (u8)pause->tx_pause;
+
+	err = hinic3_set_pause_info(nic_dev, &nic_pause);
+	if (err)
+		netdev_err_once(netdev, "Failed to set pauseparam\n");
+	return err;
+}
+
 static const struct ethtool_ops hinic3_ethtool_ops = {
 	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
 					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
@@ -885,6 +924,8 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
 	.get_eth_ctrl_stats             = hinic3_get_eth_ctrl_stats,
 	.get_rmon_stats                 = hinic3_get_rmon_stats,
 	.get_pause_stats                = hinic3_get_pause_stats,
+	.get_pauseparam                 = hinic3_get_pauseparam,
+	.set_pauseparam                 = hinic3_set_pauseparam,
 };
 
 void hinic3_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index e4a3fa6fb8db..b5c696fe6cdf 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -739,6 +739,13 @@ int hinic3_get_pause_info(struct hinic3_nic_dev *nic_dev,
 				   nic_pause);
 }
 
+int hinic3_set_pause_info(struct hinic3_nic_dev *nic_dev,
+			  struct hinic3_nic_pause_config *nic_pause)
+{
+	return hinic3_cfg_hw_pause(nic_dev->hwdev, MGMT_MSG_CMD_OP_SET,
+				   nic_pause);
+}
+
 int hinic3_get_vport_stats(struct hinic3_hwdev *hwdev, u16 func_id,
 			   struct l2nic_vport_stats *stats)
 {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index 63382191446d..beb491d66738 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -318,6 +318,8 @@ int hinic3_del_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id);
 
 int hinic3_get_pause_info(struct hinic3_nic_dev *nic_dev,
 			  struct hinic3_nic_pause_config *nic_pause);
+int hinic3_set_pause_info(struct hinic3_nic_dev *nic_dev,
+			  struct hinic3_nic_pause_config *nic_pause);
 
 int hinic3_get_vport_stats(struct hinic3_hwdev *hwdev, u16 func_id,
 			   struct l2nic_vport_stats *stats);
-- 
2.43.0

