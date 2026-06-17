Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FDB2E7F3A;
	Wed, 17 Jun 2026 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695703; cv=none; b=c+7aKztFFogNWm2a94I5tNG7Li1lbWgVHd2Gp8cL+jdBG2+sQ9yKxAEmf+5E2GTr+VYubtrmt4m0LYcNbpb2CxQWTClb6eiwnUQ5nYLqkZnbxOLVtTauxGi0iLyTPgeECgrtrqESM5LY/4SmJbMARC/gqjGTPEcO+s6AAU6Odm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695703; c=relaxed/simple;
	bh=RvOja5xMdKtwVUY1hmYWhLkfDOm9LjI3vkTc/uclQf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6CaWk+GkHqgcjetEOqvDFXA0pHRf8YF9Kyt00vY9dshdJtjpR03jUZjE032FTv7YiExksh7sEI2yZtu1wv47CDhEANyMCemIIc3D50Tq/XIcOJI+K98K2WPv3cJg/H9d/s6aQz2nUDVH9M0vDkGq148GgwJBtp6hdEQgIopOLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LBf0cH8J; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LBf0cH8J"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=s4BhOJaHM8Fr9661fwBiBVftV0tFLYPKAQJf0fetwGM=;
	b=LBf0cH8JhcT3VLDTOmGtu4Avmg96srz5xpe26jAtG6f+vZVW5sI5Jnr2WqfjJLW+rzvEq+cOH
	KHLlVXH3vGT0akBLH+uYDWmKeRuJo8gWgyHH/AfIJZ9ozLIJwe8FNRcmuTrUb5pgBdusT8BIicU
	DShvQ8/lFAKG+t04DEaTqBI=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4ggLxY51PbzmV6K;
	Wed, 17 Jun 2026 19:20:17 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8167E40562;
	Wed, 17 Jun 2026 19:28:17 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 19:28:16 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 3/5] net: hns3: fix permanent link down deadlock after reset
Date: Wed, 17 Jun 2026 19:27:19 +0800
Message-ID: <20260617112721.75186-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260617112721.75186-1-shaojijie@huawei.com>
References: <20260617112721.75186-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Shuaisong Yang <yangshuaisong@h-partners.com>

Fix a critical race condition deadlock where the network interface
remains permanently Link Down after a hardware reset under specific
ethtool sequences.

This issue exclusively manifests in firmware-controlled PHY topologies
where the driver relies on the IMP firmware to arbitrate link parameters.
Standard devices driven by the kernel's native PHY_LIB are unaffected.

The deadlock occurs via the following path:
1. User disables autoneg and forces an unmatched speed, forcing link
   down: `ethtool -s ethx autoneg off speed 10 duplex full`
2. User re-enables autoneg: `ethtool -s ethx autoneg on`. The netdev
   stack passes cmd->base.speed as SPEED_UNKNOWN (0xffffffff).
3. Driver saves req_autoneg=1, but before the interface can link up,
   a hardware reset is triggered.
4. During reset recovery, MAC init reads the un-synchronized runtime
   state mac.autoneg (which is still 0/OFF), misinterprets it as
   forced mode, and pushes the cached SPEED_UNKNOWN into the hardware
   registers, causing the MAC firmware state machine to freeze.
   Meanwhile, PHY init reads req_autoneg=1 and enables PHY autoneg.

Since the MAC is frozen with 0xffffffff and PHY is running autoneg,
they mismatch permanently.

Fix this by:
1. Intercepting SPEED_UNKNOWN/DUPLEX_UNKNOWN in
   hclge_set_phy_link_ksettings() and hclge_cfg_mac_speed_dup_h() to
   prevent it from corrupting the driver's cached valid configuration.
2. Save req_autoneg in hclge_set_autoneg().
3. Aligning the state judgment in hclge_set_autoneg_speed_dup() to use
   req_autoneg instead of the un-synchronized runtime mac.autoneg,
   ensuring both MAC and PHY consistently enter the autoneg branch to
   eliminate configuration discrepancies during reset recovery.

Fixes: 05eb60e9648c ("net: hns3: using user configure after hardware reset")
Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 2c74675b149f..63e7b7458de0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2652,8 +2652,10 @@ static int hclge_cfg_mac_speed_dup_h(struct hnae3_handle *handle, int speed,
 	if (ret)
 		return ret;
 
-	hdev->hw.mac.req_speed = (u32)speed;
-	hdev->hw.mac.req_duplex = duplex;
+	if (speed != SPEED_UNKNOWN)
+		hdev->hw.mac.req_speed = (u32)speed;
+	if (duplex != DUPLEX_UNKNOWN)
+		hdev->hw.mac.req_duplex = duplex;
 
 	return 0;
 }
@@ -2684,6 +2686,7 @@ static int hclge_set_autoneg(struct hnae3_handle *handle, bool enable)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
+	int ret;
 
 	if (!hdev->hw.mac.support_autoneg) {
 		if (enable) {
@@ -2695,7 +2698,10 @@ static int hclge_set_autoneg(struct hnae3_handle *handle, bool enable)
 		}
 	}
 
-	return hclge_set_autoneg_en(hdev, enable);
+	ret = hclge_set_autoneg_en(hdev, enable);
+	if (!ret)
+		hdev->hw.mac.req_autoneg = enable;
+	return ret;
 }
 
 static int hclge_get_autoneg(struct hnae3_handle *handle)
@@ -3406,8 +3412,10 @@ hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
 		return ret;
 
 	hdev->hw.mac.req_autoneg = cmd->base.autoneg;
-	hdev->hw.mac.req_speed = cmd->base.speed;
-	hdev->hw.mac.req_duplex = cmd->base.duplex;
+	if (cmd->base.speed != SPEED_UNKNOWN)
+		hdev->hw.mac.req_speed = cmd->base.speed;
+	if (cmd->base.duplex != DUPLEX_UNKNOWN)
+		hdev->hw.mac.req_duplex = cmd->base.duplex;
 
 	return 0;
 }
@@ -11731,12 +11739,12 @@ static int hclge_set_autoneg_speed_dup(struct hclge_dev *hdev)
 	int ret;
 
 	if (hdev->hw.mac.support_autoneg) {
-		ret = hclge_set_autoneg_en(hdev, hdev->hw.mac.autoneg);
+		ret = hclge_set_autoneg_en(hdev, hdev->hw.mac.req_autoneg);
 		if (ret)
 			return ret;
 	}
 
-	if (!hdev->hw.mac.autoneg) {
+	if (!hdev->hw.mac.req_autoneg) {
 		ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
 						 hdev->hw.mac.req_duplex,
 						 hdev->hw.mac.lane_num);
-- 
2.33.0

