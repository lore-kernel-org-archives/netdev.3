Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354232;
	b=aDlcxkJO/KM3lku/Y/uvttrYj3w+Q3Of7PuxNp3lxzToTLlj3IOAp2tmrEiq6TI/cWAs
	 V17Y4by1cwhEqdDjTxeftKbT2I9hJCi2w7Pugb2SaSq9ZuIPRc09zOL2ioeMey0GaJEJI
	 yTVc8K/fgz6/6oKUM4n6lXPUTXWvornU04/IQ0llVV86B3Y2oTCefCrhAvYKdeYbIWToj
	 ZBvUt1BWn4qEYiBCDzeK7c11fS9oQify9ydghcjAG4DN17SQlI5MbZb46N8aFzd4uV0I5
	 0ul/VMMyteq9Iac6ewhxywgFLQSvwTG93LWyATKatMYXGMbcQUxBRh80zsoydqE/IoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354232;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=8q+ukuLgxB4xLT78ZiIlpHjQYf8U+hD5kv9AJN8oK28=;
	b=bT7rcEjsOlBZ1GzyukdVF1VcVi0VvCUy/DaGIfqNDfxrFashLyBZS7U9WLAfwSlz6fbT
	 taf1ta8PL5L+uNCXqUI2HYk7YC+fLO9QnxcYAqVDRjVcBw+y07Zz89fUo6A+Qnv0n7FBo
	 b3Ku1HSCC3fXwyKkS6FgVV2pOzsQX+x07+gXsckd/l/V6RUI6eiT9yD+CwY3TINVORlDG
	 g1O0XaAT3ofwG6151euexJkXRSownWGO5EVLGSgzLxEkflkqfEJqWw8ba618N0QqFRe/i
	 k0TKqUeV7mtjlClUmjXk0ryCmAiz38ccmix/YHnQE47lrp5otESaDDB3pUlmq4Ki2mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=tbSlqj3R;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2EF606A31C;
	Fri, 30 Oct 2026 09:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F2EF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=tbSlqj3R
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8q+ukuLgxB4xLT78ZiIlpHjQYf8U+hD5kv9AJN8oK28=;
	b=tbSlqj3R72D1JHnreydN6GWVp834dM2cgzRyISzx4R9cdl7cnoK/X2lHZ5UEBWL4YdjTTm3OC
	oUTWE29Sa7FgmPofHsg3N02TjGc5gf+MuHE2jpowQ1ZXFVn0DAtmUG1aA1VgfIhCa1YJN0qqnMg
	UR6urQQ5vCndbZ6PXxe5IZE=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jGGj90TvCzmV6w;
	Fri, 30 Oct 2026 17:57:01 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id A5F3C40586;
	Fri, 30 Oct 2026 17:57:08 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 30 Oct 2026 17:57:08 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v3 net 0/4] net: hns3: fix multiple bugs in reset/error paths
Date: Fri, 30 Oct 2026 17:56:29 +0800
Message-ID: <20261030095633.377289-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500018.china.huawei.com (7.202.195.199)

This series contains four bug fixes for the HNS3 driver, all related
to resource lifecycle management on reset, driver unload, or error
paths.

Patch 1 fixes a vector resource leak in the error path of
hns3_nic_alloc_vector_data, where a devm_kcalloc failure after
successful get_vector() leaves allocated vectors unreleased.

Patch 2 fixes a page_pool leak in the error path of
hns3_alloc_ring_memory, where an hns3_alloc_ring_buffers() failure
for an RX ring frees the descriptor ring but not the page_pool
allocated just before.

Patch 3 fixes an interface stall that occurs when the hardware RX
queue is full and memory allocation fails.  Without an RX interrupt,
NAPI is never scheduled and the queue cannot drain.  A delayed work
re-arms NAPI polling on affected rings to break the deadlock.

Patch 4 fixes a use-after-free in debugfs read callbacks that can
access priv->ring and ring->desc while reset, driver unload, or
ethtool ring resize is freeing those resources.  A mutex is added
to synchronize debugfs readers against resource teardown.

---
Changes in v3:
  - Patch 1: simplify commit message; drop the accumulated-leak
    consequence paragraph and clarify that the vector_num reset avoids
    a NULL deref in hns3_nic_dealloc_vector_data().
  - Patch 2: new patch, fixes a page_pool leak in the error path of
    hns3_alloc_ring_memory().
  - Patch 3: rework the OOM bitmap from per-vector to per-ring,
    indexed by ring->queue_index.  Add cancel_delayed_work_sync() in
    hns3_nic_net_down() after hns3_disable_irqs_and_tqps().  Remove
    the OOM marking in hns3_handle_rx_copybreak() since the packet is
    still delivered via the original page.
  - Patch 4: add Fixes tag for the ring resize path.  Add per-ring
    page_pool NULL check at hns3_dump_page_pool_info() entry.
v2: https://lore.kernel.org/all/20261021121426.3096838-1-shaojijie@huawei.com/
Changes in v2:
Patch 1:
  - No change.
Patch 2:
  - Clear per-vector OOM bitmap when device is DOWN to avoid
    spurious napi_schedule() on next up event.
  - Move rx_oom_cnt accounting to hns3_ring_set_oom_state() with
    test_and_set_bit() for per-event counting.
Patch 3:
  - Drop hclge_debugfs.c changes; mutex only protects enet-layer.
  - Replace guard(mutex) with explicit mutex_lock/unlock.
  - Remove redundant NULL checks; unify -EPERM to -EBUSY.
v1: https://lore.kernel.org/all/20260915132434.1141742-1-shaojijie@huawei.com/
---

Jijie Shao (4):
  net: hns3: fix vector resource leak in hns3_nic_alloc_vector_data
  net: hns3: fix page_pool leak in hns3_alloc_ring_memory error path
  net: hns3: fix interface stuck after OOM with full hardware rx queue
  net: hns3: fix use-after-free in debugfs read during reset/unload

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   1 +
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 125 ++++++++++++------
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  74 ++++++++++-
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  18 +++
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |   3 +
 5 files changed, 174 insertions(+), 47 deletions(-)


base-commit: 5838f10563d58afca6711edb5e4eda968ca181d9
-- 
2.43.0

