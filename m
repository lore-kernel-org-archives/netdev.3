Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B8C282F3E;
	Mon, 25 May 2026 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720349; cv=none; b=HxgWzJ1gwGuj5yT0It5jZhKzphbApxJ88Diz86Fiw+4nyBgq7lFk3y5ZKZsw+AGbr1/67P/1XwzBX+iuImoWStgC/icYp+l3iFmsCIs3QvPjXoF55GR5955aIa43YFQjJCvISdkRlnnBpt+lBF/azFbaTuVTTT+lRF2/i8J3Q1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720349; c=relaxed/simple;
	bh=RDoVbYkYyJ9I1Of507KaR3BPkeX1aBtX87LItO1PIJA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q4t/YegzFptwYoF9pVF6iyCNR+5s0Y+jN8jUGyAs01v9PFcPzJTZdvk2gv7z3HPvJMpYBfcpUMcxTdUMHknEeHwm0HEHkRjBGD6/k1qdHuv9hPkw2LjNF2hYP+WFWMWzX1NdfzI+CAUzH4eTQqd1ZqasJhpwcLsrezUkubvxs0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=injRb0a1; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="injRb0a1"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iJIDC2YMFMFz0JjsgAcjYc8Q6nfBkl4VswVMHkOKMcI=;
	b=injRb0a1vv6UAdrqUAULEoj+4lpLVOkYzq40MlirytU/dnqQCvIT1jksK7i/OdNJk2VkYxKdj
	j9EU9UUSb+aK+FkZL6359EGBxqyFUmDzSReL+8UEb8fKa8ZB0VJzfeGoe/MM0GAW+0f2/RVedrw
	NGximxs4GHy2rR5xGIlMh8s=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gPJQF58BdzRhRG;
	Mon, 25 May 2026 22:37:57 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E0FCC40537;
	Mon, 25 May 2026 22:45:41 +0800 (CST)
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
Subject: [PATCH V3 net 0/2] hibmcge: fix RX packet corruption issue
Date: Mon, 25 May 2026 22:45:23 +0800
Message-ID: <20260525144525.94884-1-shaojijie@huawei.com>
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
v2 -> v3:
  - Use pci_save_state () to ensure that Relaxed Ordering is disabled after the reset,
    suggested Paolo.
  v2: https://lore.kernel.org/all/20260518144253.1568118-2-shaojijie@huawei.com/
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

 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 3 +++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.33.0

