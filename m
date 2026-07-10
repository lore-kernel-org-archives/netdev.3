Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4993DDAF8
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674448; cv=none; b=i/Tu3PUJ5bidIFNaqzKPjRwTt+iy32smpiRQddbzkERoixZprVuZUPhlxDFaqKx/ustXp9h7+9EqAN8G1mzj/mfnuAXyNc1d+A6Jz6N33m5xRPg9rLSkW7Hr1E2hAWB9tFw0K6RLW1eg0E8WR99YrexwBHCis2OTFRAPceD+htY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674448; c=relaxed/simple;
	bh=uQghfOMqAieaXWL/V/uyqBHu+tBty5j/FwnMUNMlkbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUyCzwrKfA0iN///jM7a6p5e/R3zBNJjs9KQUyvIlEzGxT2qF7Wf1L7rNGEQYwxMg36B72SbEMV4P9UrWSajr2CQkwKjIf8ITHd+I6X/FyIE3RLiaBOyS0MHisagD5nYa8MGQOCq3hPxMH4Mgk5rxEFB7bAkWJX986nfjMqO4W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W/YbU15y; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W/YbU15y"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783674444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfXFXrSXL0Osw1K5e7Mta9NtqrS2eZ1FPVYi2bwW7oU=;
	b=W/YbU15yRz/pi+a8R8q9I/nBnE351cXsCRPwg2aBJIPpXp1voELDyTWSEk00/+fhGpoOon
	8RZsW14x/evZUEdqK8O7IqzIVuYlTswmUWPSWEr1zPtP9RBFbIrBtmHD0epbMg7BMXj5nB
	ih0ISAB3WxCWhhii7vDJJtbcokiyZpo=
From: xuanqiang.luo@linux.dev
To: netdev@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Jijie Shao <shaojijie@huawei.com>,
	Jian Shen <shenjian15@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v1 3/3] net: hibmcge: fix double-free of tx skb on DMA mapping failure
Date: Fri, 10 Jul 2026 17:05:24 +0800
Message-ID: <20260710090527.58354-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20260710090527.58354-1-xuanqiang.luo@linux.dev>
References: <20260710090527.58354-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

If hbg_dma_map() fails, hbg_net_start_xmit() frees the skb, but buffer->skb
is left pointing to it. ring->ntu is not advanced, so the buffer is not
visible to the TX cleanup path.

A subsequent transmit normally overwrites the buffer. However, if the
interface is brought down first, hbg_ring_uninit() calls hbg_buffer_free().
It sees the stale pointer, attempts to unmap the failed mapping, and frees
the skb again.

Clear buffer->skb before freeing the skb in the error path, preventing
hbg_buffer_free() from treating it as an outstanding TX buffer.

Fixes: 40735e7543f9 ("net: hibmcge: Implement .ndo_start_xmit function")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:deepseek-v4-pro[1m]
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index 0ae3149946769..4382af937e2e7 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -155,6 +155,7 @@ netdev_tx_t hbg_net_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	buffer->skb = skb;
 	buffer->skb_len = skb->len;
 	if (unlikely(hbg_dma_map(buffer))) {
+		buffer->skb = NULL;
 		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
-- 
2.43.0
