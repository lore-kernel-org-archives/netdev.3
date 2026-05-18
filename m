Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9324537883C;
	Mon, 18 May 2026 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115400; cv=none; b=BO8pif6vf4XyV15natl0Cu99IxEnTie+QfBOFTkLUuoXh059/z8J51HKaAb7nTwL52HZd/a/P8k61zMIPHDyhrUeyA87CLYQ8CoVpHParjiio3GuRTfBM/Hn0qV4FaumoDsTKSXpmZM+x+DcJS/K8MfEXQBRhwY2SAhT/C+Iza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115400; c=relaxed/simple;
	bh=Agn6IiSX3nlgKjQFGyKCvqJT/j00FS9mOthIr/hDqzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtDKY3vQ9WnbqLITfgpyxgiwJqxZzMa9wiDMwfu70gkx0kvn/GFUWXSigLDlkeJ3G+UgrR8K5e20UkzD81g+gF/QJ5se0y3FcVIyu+NndFUE4BtvJNajWHvjHnTIERHpyLBnwxfZCx1AXNf55uoIJmiczkoB683eP89fvT4xeTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eEZhhDQO; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eEZhhDQO"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SVGwqbTeZU3kIiWiEwf1d08QHU57J+iYWNoFq0/cWjI=;
	b=eEZhhDQOHVDmcFE1zJ3FIo91u9uVLxkTwcQlx243ZDnlBR8fiPco2Z+F3gLZMNW1kj+YsGuvL
	PXScCh6iVuPLsKtCL+mhfOa8le5cY04JND+t3uWYmnOTEiI5UnTHnthqu+soMjZ0xyc2BHVLopB
	frUQtz1B93+QUAujB9TGl0o=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gK0hg1ftMz1prN3;
	Mon, 18 May 2026 22:35:31 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CA3D4056D;
	Mon, 18 May 2026 22:43:14 +0800 (CST)
Received: from
 deployment-s00611957-4ii0-20260331111539-78d5c5cfbb-9s2bv.default.svc.cluster.local
 (7.197.8.232) by kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 18 May 2026 22:43:13 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <shiyongbang@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net 1/2] net: hibmcge: disable Relaxed Ordering to fix RX packet corruption
Date: Mon, 18 May 2026 22:42:52 +0800
Message-ID: <20260518144253.1568118-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260518144253.1568118-1-shaojijie@huawei.com>
References: <20260518144253.1568118-1-shaojijie@huawei.com>
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

When SMMU is disabled, the hibmcge driver may receive corrupted packets.
The hardware writes packet data and descriptors to the same page, but
with Relaxed Ordering enabled, PCI write transactions may not be
strictly ordered. This can cause the driver to observe a valid
descriptor before the corresponding packet data is fully written.

Fix this by clearing PCI_EXP_DEVCTL_RELAX_EN in the PCI bridge control
register to ensure strict write ordering between packet data and
descriptors.

Fixes: f72e25594061 ("net: hibmcge: Implement rx_poll function to receive packets")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 068da2fd1fea..319551caf047 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -420,6 +420,8 @@ static int hbg_pci_init(struct pci_dev *pdev)
 		return -ENOMEM;
 
 	pci_set_master(pdev);
+	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
+				   PCI_EXP_DEVCTL_RELAX_EN);
 	return 0;
 }
 
-- 
2.33.0

