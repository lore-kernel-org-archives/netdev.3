Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2922A2FFDE1;
	Tue,  7 Jul 2026 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430691; cv=none; b=EkZOwwdaxgewHQNBspofZZ5Puve74h+oaLOeb75vTNfawYNjC2ZB0D/gCQjYuM4pwx5AzaxvekSor2uI81Lnf2briEU2nMwV1IqvsoX8RLilIr26gkU2DCC9o/Ya3nSwGYkaUosSwgo4G7Q4rvt7RZPojDU5ouzysgwxamF3ZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430691; c=relaxed/simple;
	bh=fd28tikjxtfVOWvGOYHN8c1UlG3cslgeXUETdJhD7nw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qr7X2XBGXvbg6CditoQHXyOj8gV28fHp3QmIp61HOXsBqAvP4y0AeR0ogCzvOFkSIco49Oba0O3vM652KbwIYriCnJTXDTdYX8fjian08LLmcoEaj7R5YydjnN1IIeB7M/4qk6+oP3z3LwKIx9nSreEqHa1lTj8X/67F/9wrPlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=K8VFlGAy; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="K8VFlGAy"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IL3498YlXEdBSvxWvQxA2syZEknSs/wfZNz3wGC1eb8=;
	b=K8VFlGAyx5MrcxAUF8Xnnb7dnguuwgkvrmzpvl5qfUINjGknVszjT+M/q9hq+Oo+yiyV4YV0l
	Ck6zrrzGRNin7nkozG7bVXWhHgkZpUaaHdojSVPrbV0Qa1nvyBuaD5HHE9zX5Yak+oyFELCajam
	1wMihq1Z708JI4u0KV3ukz4=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gvhYJ71Vzz1cyP2;
	Tue,  7 Jul 2026 21:15:32 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 16D924057A;
	Tue,  7 Jul 2026 21:24:45 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Jul 2026 21:24:44 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH] net: hns3: fix speed configuration residue after driver reload
Date: Tue, 7 Jul 2026 21:24:36 +0800
Message-ID: <20260707132436.1848559-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)

After setting a 100G optical port to 40G via ethtool and reloading
the driver, the port remains at 40G instead of reverting to the
firmware default speed of 100G.

In hclge_init_ae_dev(), hclge_update_port_info() reads mac.speed
from hardware, which reflects the last user configuration (e.g.
ethtool changes), not the firmware default. When req_speed is
overwritten with this value, hclge_set_autoneg_speed_dup() re-applies
the stale speed instead of the firmware default on non-copper media.

Fix by removing the req_speed overwrite in hclge_init_ae_dev(),
keeping only the req_autoneg synchronization. This ensures req_speed
retains the firmware default value set during hclge_configure().

Fixes: d9d349c4e8a0 ("net: hns3: differentiate autoneg default values between copper and fiber")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index fc8587c80813..164c3ecf195c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -9498,12 +9498,8 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	if (ret)
 		goto err_ptp_uninit;
 
-	if (hdev->hw.mac.media_type != HNAE3_MEDIA_TYPE_COPPER) {
+	if (hdev->hw.mac.media_type != HNAE3_MEDIA_TYPE_COPPER)
 		hdev->hw.mac.req_autoneg = hdev->hw.mac.autoneg;
-		if (hdev->hw.mac.autoneg == AUTONEG_DISABLE &&
-		    hdev->hw.mac.speed != SPEED_UNKNOWN)
-			hdev->hw.mac.req_speed = hdev->hw.mac.speed;
-	}
 
 	ret = hclge_set_autoneg_speed_dup(hdev);
 	if (ret) {

base-commit: 9e05e91a9a847ed57926414bd7c2c5e54d6c56c6
-- 
2.33.0

