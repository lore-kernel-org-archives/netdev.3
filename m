Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829162E7F3A;
	Wed, 17 Jun 2026 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695709; cv=none; b=RQezRnJmpUMokz54mr1ocPska3Ty4mEWTZ1X3PM0G/hPTSD50leN6JlPNzzL61qQzzQxDzOO6Q/UI5EzeUJVJ5WTuMvVT0CnJFDqyTcUsN9n4fKPoak+qcbXMaM/LbLfAHvrofqSjAbo9qwjYMP3eKNYdbOmTlbo8aO8sy64VnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695709; c=relaxed/simple;
	bh=e3EJuODRdU8xb73eET6758PdD9QD3yNOVR3JHZR5RJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/OY97TD6gLSUKepnTlPc4nbge136cQ7V2rcKk84PrlFyxI6OWWKBNkDB8G301LuL/D2Ch9HH+TfnPjwgt2LVSlfoE2Co2A+zl5EpL5jUzyEv01C7889cxD/w6a4qDEWargz6P2P5nkhx/cvwrEcqOjmhoNfxfTAssQkW7OWtM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Kr8J7ZNd; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Kr8J7ZNd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/R71KPRUmVzouWqKRlzWpRgVwf+N2tpGcKIjz82NSm4=;
	b=Kr8J7ZNdAsA/1ypVsHg4MnseB5U/oK88q4yY5wj1Y98jOkn+rD2z9vxl3lBmptgNsfd8TD7/i
	6x3D2gFJakPgV9h3qDktXgiAH8TOATC6FWlh8oYE61N12V32ZutyFJ+WHcT2FDHACUonmf5j+IB
	lnqMAtuZ6k2T5Qn3Y9XEOLc=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4ggLxh2lF8zmV6K;
	Wed, 17 Jun 2026 19:20:24 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DDAC40539;
	Wed, 17 Jun 2026 19:28:24 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 19:28:17 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 4/5] net: hns3: differentiate autoneg default values between copper and fiber
Date: Wed, 17 Jun 2026 19:27:20 +0800
Message-ID: <20260617112721.75186-5-shaojijie@huawei.com>
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

Fix a link loss issue during driver initialization on optical ports
connected to forced-mode (non-autoneg) remote switches.

Previously, during driver probe or initialization, hclge_configure()
blindly hardcoded hdev->hw.mac.req_autoneg to AUTONEG_ENABLE for all
media types. While this is necessary for copper (BASE-T) ports to
establish a link, many high-speed optical (fiber) ports in data
centers are connected to switches running in forced mode (fixed speed,
autoneg disabled). Forcing autoneg on these optical ports during
initialization causes a permanent link failure since the remote end
refuses to respond to autoneg pulses.

Fix this by implementing media-type differentiated initialization in
hclge_init_ae_dev(). Copper ports continue to default to
AUTONEG_ENABLE, while optical ports strictly inherit the preset
autoneg status pre-configured by the firmware (hdev->hw.mac.autoneg),
preserving native compatibility with forced-mode network environments.

Fixes: 05eb60e9648c ("net: hns3: using user configure after hardware reset")
Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 63e7b7458de0..853e97b0b6ff 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -11916,6 +11916,9 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	if (ret)
 		goto err_ptp_uninit;
 
+	if (hdev->hw.mac.media_type != HNAE3_MEDIA_TYPE_COPPER)
+		hdev->hw.mac.req_autoneg = hdev->hw.mac.autoneg;
+
 	ret = hclge_set_autoneg_speed_dup(hdev);
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
2.33.0

