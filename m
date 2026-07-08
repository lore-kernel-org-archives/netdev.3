Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9943E487;
	Wed,  8 Jul 2026 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519553; cv=none; b=XOV2wi1nTpu1QZIT0pontmsVh6Pxdm9CNwlWLZQZ3f8f9BC0rTSs6q3LnKCbA6hdXSlTW0xfdNkazFVpuHdxb4NmQTK+rHi00NzYk18DfPF+7+jnQpBfirEqNFUEKM8qvz9cCf6q7VfmzpoXnyXrWNo/C8NIqmqZ2fxxxhH2BSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519553; c=relaxed/simple;
	bh=YNOD2IdyP1DUNm2lZt2xJ9bA+ruZls8qgMHq7VFP47U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gFeDN6YIzxfdIqevADKFy36FvC/cZO/zENNPZ0QoRJDKgovEoGRR7ou/tL71cMhfef1DDAI2CnFGCO84kXHgyuSOfJLVVDpR8pl6Umh0HZx7tAWvQ/J2SGqHKMcecCdq9Gwhm1gpgGyRlGr1mkM1TB3UmuQ9XmunZNbNZelz3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YQk+Tt4C; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YQk+Tt4C"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iWMQSMJvHG1NNWpmlkeunWRo28qp2f38429zWZh7/II=;
	b=YQk+Tt4CvuXjgJJSk+92kgv3nABn+Xeg89hGEqdm6vy1L6i4UZ9IvS8Hg8gPDv9nmpUJu06yl
	DS/tW50Bmp4GKaNCAooseOhgRG2fJtYOE+SoxulKRdQ+qzlL/tqDncIM2dVv+/7SMVSFi/CIFQw
	C91rX2vtM2i3Yzo86ktZJWg=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gwKQt4LS1znTWQ;
	Wed,  8 Jul 2026 21:57:10 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 81E7C40565;
	Wed,  8 Jul 2026 22:05:46 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 8 Jul 2026 22:05:45 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net] net: hns3: fix speed configuration residue after driver reload
Date: Wed, 8 Jul 2026 22:05:32 +0800
Message-ID: <20260708140532.1691493-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
v2:
 - Discard v1 and resend with the correct "net" prefix in the subject. 
   Apologies for the noise. No code changes.
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

base-commit: 235acadd310533ba386ae61ad155b72bee381559
-- 
2.33.0

