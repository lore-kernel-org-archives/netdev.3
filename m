Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF207442FD7;
	Thu, 20 Aug 2026 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229847; cv=none; b=M09U3bg/SRuSM8CNe3WGYi1qX5qNojJ1PjI5ZAiKc7ODNhpiwNkHQGkAIlhIA3sBhqMIvZD2PXgBMURY3ZjsmrLBprIQcyXztR7FfM+Y6uzvD/c2gCIMundROd9tMtchfYdAVgHQeEPeAyyFPT1LFasKNEYcYUlYQJFGjGIBHJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229847; c=relaxed/simple;
	bh=BYpU77dNgE23ucUc66d1lQqohz99Lv7rBqk48Vjv3fs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WWLCSJFLc5Cc6FnCuTEQ2QKcTOHF6rgKcVYxUzcjLpC7oIFh2tWZpJuSD4+2NIX4HMr0f3qgOyB81NF5hxgeGI6Wl5bcmzMSrVg22JkyXUoucRNxkgYNq8xN7HHHsaLgd+zydq7C2YVbz4BQmqNudyNJSu0YhUYJ2spDVwagMns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=v47eaQrt; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="v47eaQrt"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VY0rY1mJ5T9xNtIe0BmW575BrHW85MLQNtu/EqiDFsE=;
	b=v47eaQrt5YkLu5U9hkncLaxIwmJ8yZUzr9uzGpkkOi3Dofsq9EhSzo5NXCy0DSVYFmznQnTVC
	h0SeYyq3NXzZekzSYZvhOUa3dnn98hxhIfMK/SF39TLwzSMqe76PIfWhtd1/9p+rfw8HzNdnOMO
	TjV/i1OzJ3/jioNpgkgav0I=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hQjXD5388z1K96b;
	Thu, 20 Aug 2026 20:33:16 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id C9B5940578;
	Thu, 20 Aug 2026 20:43:58 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 20:43:58 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net] net: hibmcge: fix page_pool DMA direction mismatch
Date: Thu, 20 Aug 2026 20:43:46 +0800
Message-ID: <20260820124346.4097115-1-shaojijie@huawei.com>
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

From: Jian Shen <shenjian15@huawei.com>

The driver memsets the RX buffer page head to zero before
submitting it to hardware, then calls dma_sync_single_for_device()
with DMA_TO_DEVICE.  This sync direction does not match the pool
dma_dir which is DMA_FROM_DEVICE, violating the DMA API contract
that the sync direction must match the mapping direction.

On swiotlb platforms the mismatch can cause incorrect bounce-buffer
behaviour, and CONFIG_DMA_API_DEBUG emits a warning.

Switch the page_pool dma_dir to DMA_BIDIRECTIONAL so that the
CPU-to-device memset sync becomes legal.

Fixes: c30595917585 ("net: hibmcge: add support for pagepool on rx")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index 0ae314994676..3e6ae2aa0d4b 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -553,7 +553,7 @@ static int hbg_ring_page_pool_init(struct hbg_priv *priv, struct hbg_ring *ring)
 		.nid = dev_to_node(&priv->pdev->dev),
 		.dev = &priv->pdev->dev,
 		.napi = &ring->napi,
-		.dma_dir = DMA_FROM_DEVICE,
+		.dma_dir = DMA_BIDIRECTIONAL,
 		.offset = 0,
 		.max_len = hbg_get_page_size(ring),
 	};

base-commit: e2466392a0b8496000e12181cb1ee1535eb0da25
-- 
2.33.0

