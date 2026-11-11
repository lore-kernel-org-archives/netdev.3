Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401937;
	b=USvbqhn6js1H0cD6D4TRe0bJiwn9su7nYBSO0kznHVUHSKrCxDCqzBisffy5qYgbHnob
	 +xlPHH5BQyOaUc98q7NDKx/8uBF/bZWHptIB6oyCX4qPMvWH5psPfIzD9lvDaLSptNy+n
	 E4eGvUqrDbTV44z7x/ihpdfrw8TFnzMGDCGpdOcI07Cz/sT07xdOpEbmdfkdeBvs+xqQH
	 6nWAne8UJdnC23C8lVx5HSv3xztFcVypmeyUtk4O8fHjlZXR+0db7gIo9v+KlWe07rIb0
	 bNOZcOXlLCb71k6asn19qb3i34SLWGS5N140zpTh33bK18QBsZ8SaxuTPoPo0QVjF3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401937;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Q8x5FW0GZ0QdCGdfAFTweAPmtPMaW+h6b1JkoX4m6JM=;
	b=CzD80Shvpttm50J955E7ve99ZawGu3nFIuusRtCHrsWJpa3Rp87IXhDPXG7Eh6R7qQD5
	 VPCs15ZBmBqyFznY+Tiz3fkYWohRXePsx81siiObWLK1+Mz7lO0vs3ojXccitEfcsvVjL
	 6dKroIZdjC+k7kiQaOilXA2Za8vALjjeyQryiCq7qAhrVlqGU+59CVxOTiXq6sV1VPpXN
	 F2Qyd1QbMGmlFJtgDk9TUxRDoPNq2LCRhcHz8tjHXw7lqC+U/wpHQyDKtmmqxlLJSGxqL
	 qdgFvdv1vPsYpe5625CQ0CiwnNKvDH0mJhW8iL7oCr6TeEJtW/+wbcmvriwxEQGvgiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="BP4/BEFk";
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5AB606A321;
	Wed, 11 Nov 2026 12:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F5AB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=BP4/BEFk
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Q8x5FW0GZ0QdCGdfAFTweAPmtPMaW+h6b1JkoX4m6JM=;
	b=BP4/BEFkXTSp8ChQayBGODVXiFYKZHyBBaCITu1Bgh8Cidksi6zh09c6as/lmPm+lS6l7saOp
	88IsSGc8bEXNVlYJRlthPSrNSGWUonvw/31vgQMBF3sNsSxfRB9Oh/m0aLaS2iylF0/hzJ8OgZ6
	zk3DiOZadf7nDQGn804KW2c=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jPk8t50Pdz1T4MF;
	Wed, 11 Nov 2026 20:58:22 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C0F14056E;
	Wed, 11 Nov 2026 20:58:52 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 11 Nov 2026 20:58:51 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v4 net 0/4] net: hns3: fix multiple bugs in reset/error paths
Date: Wed, 11 Nov 2026 20:58:06 +0800
Message-ID: <20261111125810.3359030-1-shaojijie@huawei.com>
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
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
Changes in v4:
  - Patch 1: correct the reason for resetting priv->vector_num, as
    reported by Sashiko.  hns3_nic_dealloc_vector_data() is not
    reachable after hns3_nic_alloc_vector_data() fails, so the reset
    is not protecting that path; it keeps the count from describing
    vectors that were already handed back.
  - Patch 2: name hns3_fini_ring() instead of the non-existent
    hns3_free_ring_memory(), and drop "mirroring" because the destroy
    order differs.  The pool is destroyed before the descriptor ring
    here, which is safe because hns3_alloc_ring_buffers() has already
    detached every buffer.
  - Patch 3:
    * Allocate rx_ring_oom_bm in hns3_init_all_ring() only after every
      ring has been set up, and free it in hns3_uninit_all_ring().
      This fixes the leak and the NULL bitmap dereference reported for
      hns3_set_ringparam(), which calls hns3_init_all_ring() without a
      matching hns3_uninit_all_ring(); the allocation is reused when
      the pointer is already set.
    * Cancel the delayed work in hns3_nic_uninit_vector_data() instead
      of hns3_nic_net_down(), so every teardown path cancels it before
      the bitmap is freed.  This closes the use-after-free reported
      for the self-test and external loopback paths, which set DOWN
      without going through hns3_nic_net_down().
    * Drop the cancel and bitmap_zero from hns3_nic_net_down().  A
      pending work that runs while DOWN is set zeroes the bitmap and
      exits, and one that runs after the interface is brought back up
      only schedules a single extra poll round.
    * Always attempt the exit refill in hns3_clean_rx_ring(), so the
      descriptors cleaned by this poll stay armed and the head pointer
      is written as before.
    * Document why rx_oom_cnt is not the standard rx-alloc-fail
      counter, as requested in review.
  - Patch 4: describe both writer paths (client_uninit/reset_uninit vs
    set_ringparam) explicitly, note the -EBUSY user-visible change, and
    return -EBUSY from hns3_dbg_page_pool_info() instead of -EFAULT so
    that sibling readers agree.
v3: https://lore.kernel.org/all/20261030095633.377289-1-shaojijie@huawei.com/
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
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 127 +++++++++++-------
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  80 ++++++++++-
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  18 +++
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |   3 +
 5 files changed, 179 insertions(+), 50 deletions(-)


base-commit: 8d5ce4751fad9499ea408163af7f410f18a85782
-- 
2.43.0

