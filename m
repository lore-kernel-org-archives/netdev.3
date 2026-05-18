Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FDD480DCB;
	Mon, 18 May 2026 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115403; cv=none; b=OgBk0Oy0Hzk6sHEo4lYmA6bissP3uXd6if5F9G7ooIdEcsjmVtHF80IE81rW25ZhCEPj5g+1YEizC57t7zAFl8zUHTaJm99xJDYVKQtUupQwYiW1mTbgZpKCfwye2tDK+badoNGHJlDSYEQM9NBCezDpt1uHeHhUXS6qpmKhieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115403; c=relaxed/simple;
	bh=A94qCKmXvT7rUFkriX6ydUd2Q29HmXdP4gsYvx2nOb0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G0D9NX9KxBjCYNImN8sQhKof7AjkM25W7olf9htNbPZOxxZLf3tCz+7m0NjpeyAIptrikzM6ws/hEQNNIHkhPwnFsyUfFwsqu02t9qLvNy0K33/FmQW70oYVuIy8MSjWNmFtIHndKFvOBPuuyugNEnORibtRqVFcj9xVP1nwRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4JAWrCiU; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4JAWrCiU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=R6XbN8kimrea/0opxCYkzz0js6ZjfmS3oZHuNVEcVUI=;
	b=4JAWrCiUJwZn2r0ZIq2LbGyS9mJf38pZV180jj/8D+YBkYOqkwWMkZrzhXohPrpxoRKjfbecq
	ejqQwO8ldGVEpsPodBrQ1cWKwNSunw7qB/SM8Tz8/y4r52MyZ40iuRsprFMk3ctCLyV1Zybfg9r
	1LDzUFSmm49HBo3NIoaRB1o=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gK0jH2FrlzpStd;
	Mon, 18 May 2026 22:36:03 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id F31B64048F;
	Mon, 18 May 2026 22:43:13 +0800 (CST)
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
Subject: [PATCH V2 net 0/2] hibmcge: fix RX packet corruption issue
Date: Mon, 18 May 2026 22:42:51 +0800
Message-ID: <20260518144253.1568118-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
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

This series fixes an RX packet corruption issue observed when SMMU is
disabled on the hibmcge driver. The fixes include disabling PCI Relaxed
Ordering and correcting the order of DMA barrier operations in the RX
data sync path.

---
ChangeLog:
v1 -> v2:
  - Split original single patch into two independent patches,
    suggested Jakub
  - Remove MODULE_VERSION change, pointed out by Jakub
  v1: https://lore.kernel.org/all/20260512123456.3786635-1-shaojijie@huawei.com/
---

Jijie Shao (2):
  net: hibmcge: disable Relaxed Ordering to fix RX packet corruption
  net: hibmcge: move dma_rmb() after dma_sync_single_for_cpu() in RX
    path

 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 2 ++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

--
2.33.0
