Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C31FB1;
	Mon, 25 May 2026 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720350; cv=none; b=TBMJFNxsqs2Fjy+zYgKljuS4/i2YkQdaO1oKF9gkfA6CBdKAaDM225f6QuUBpmnAunfPc7jxxDTwQkfZq6jJa5PfHsFeJ7gD2sk2HA7KqpiA53lVEL38Ncl1ZxG1wbyt7CPuMedX4XrUJ7SdxeO9LUSozBYrhpq4JaQYe5oIXZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720350; c=relaxed/simple;
	bh=mqUR9mm4+qgMq9TWEYi4FehGJJfMx8/x0BGyAYolc04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3BDibLjcOe/YsaUKvVNICFlN6LoWuXTE+/3QwhbmTWZtzInh10JeAZmj/C9LbqEsWFN0lhvZd/TM4a3bZ6OsSgb3rGNHDbe+nM7SaB2zJTrFjtDDVSjOwReEnmrxv6B7JpSvv9IEmAhLOihgeom8MyuPImx+CBZe0gxkOtIolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=h6obLB2k; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="h6obLB2k"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=m7qplFOFzzBXU4xfVPjGTX4ipP5o/gekOhkMSJBC8HA=;
	b=h6obLB2kMGj0bb/kwhcXQif1IYnu8NydUmAoAW6oAJY8lmyGGF3ib9COINEzKOFvTpKKNKoqB
	DAKCTLLU+hNZygxsN2lwImVmW849NbKnF4sityGOiPl5pAaoB+XXpxDEW2JfKDX1Sokw7DNEDyU
	tqOLZWm7R4wpmx+mwCHzPKs=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gPJQg2VCqzpStH;
	Mon, 25 May 2026 22:38:19 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BE46202E6;
	Mon, 25 May 2026 22:45:42 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 25 May 2026 22:45:41 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <shiyongbang@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V3 net 1/2] net: hibmcge: disable Relaxed Ordering to fix RX packet corruption
Date: Mon, 25 May 2026 22:45:24 +0800
Message-ID: <20260525144525.94884-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260525144525.94884-1-shaojijie@huawei.com>
References: <20260525144525.94884-1-shaojijie@huawei.com>
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
ChangeLog:
v2 -> v3:
  - Use pci_save_state () to ensure that Relaxed Ordering is disabled after the reset,
    suggested Paolo.
  v2: https://lore.kernel.org/all/20260518144253.1568118-2-shaojijie@huawei.com/
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 068da2fd1fea..f721e9893804 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -420,6 +420,9 @@ static int hbg_pci_init(struct pci_dev *pdev)
 		return -ENOMEM;
 
 	pci_set_master(pdev);
+	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
+				   PCI_EXP_DEVCTL_RELAX_EN);
+	pci_save_state(pdev);
 	return 0;
 }
 
-- 
2.33.0

