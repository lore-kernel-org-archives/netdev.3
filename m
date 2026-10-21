Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584897;
	b=ya9zCErYb0IDCCHSdLeZyPjV0oBqmZdsRioZQQTs28rp+2EA7jXkWbyBUXqzMjerW8wJ
	 C7UrQ5X+ZBwJLK3YHGAPuv+MjLbwckvpLiuNhHT/fIcNHYdhpHVNKYDTIU3pG5U6/0XUF
	 lLzgjawXVPMfLYdoaHkbLt2JDcDSDxgfxjBULx+joptTPgx+5hJqPxAbXm1T3Ci5k+VE0
	 pqlKDThRYoVG9dEwNdqQSoWTvSXWsl5CRo+ASkbTRLjgpYVRuPSfcajDB+B1jWm0PN5DP
	 QGH6ibxMX2gl6Qacm4cprdSHnj8MHITtPe801szrnKfWRByzfuNa4lVmzK84dQ8gmnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584897;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Pp0lEThnj35kfWyHTvE22h4eScmu1/f68EtXC/xDDnA=;
	b=i5gDQxNVlCs7KR7Qf5iX6vqB9l/MRm4GbAz/1f1xla/ZrJ5kfvZpojF6wq4+in+nxG/C
	 vXOKc0BYHkBXAzgIJh8J2BqfpWDEGV+ZmmorrvtvJZWWiDxSydNniWfZeJaqwaEH+ufrP
	 gbu3zPESZS+WvAHokqndqJ4WdLz3HX1OgBrreQjKCj8AwDPBkmueTPJ94hFMDeL4BvEF9
	 PNfs505xp0h+gm6C3BO0VcWP5FMh2aoiZ4eOfSEbZakfTmEP8qDeny/DHkBBWaCfu6fMK
	 PJztOdP7WMTM0hUsiugbK7Zsd5foOJ7beUEWZwYUV7yySFkoPQah3ifAGXYQjG267Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=La4+OJI6;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5339D60A2618;
	Wed, 21 Oct 2026 12:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5339D60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=La4+OJI6
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Pp0lEThnj35kfWyHTvE22h4eScmu1/f68EtXC/xDDnA=;
	b=La4+OJI6QW1N6pj/AJjY2uoKVjcoQjDagBioiWHoyRRWpbkxstJGYZ0PDsDe7RCLZ5tq+Qjv7
	DWCQeNzQVzDQvxxUDsHiLmBxjVF6CBBCNgcLwejh3KWx/pdTT9W29wjjEZKAQWL78cOcEZqsGOc
	kM1qCsX4nGA8Yl4M4YgSJCk=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4j8pBK0BHmz12LCr;
	Wed, 21 Oct 2026 20:14:49 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id C66BD4056E;
	Wed, 21 Oct 2026 20:14:47 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 21 Oct 2026 20:14:47 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v2 net 0/3] net: hns3: three fixes for hns3 driver
Date: Wed, 21 Oct 2026 20:14:23 +0800
Message-ID: <20261021121426.3096838-1-shaojijie@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)

This series contains three bug fixes for the HNS3 driver.

Patch 1 fixes a vector resource leak in the error path of
hns3_nic_alloc_vector_data, where a devm_kcalloc failure after
successful get_vector() leaves allocated vectors unreleased.

Patch 2 fixes an interface stall that occurs when the hardware RX
queue is full and memory allocation fails.  Without an RX interrupt,
NAPI is never scheduled and the queue cannot drain.  A delayed work
re-arms NAPI polling on affected vectors to break the deadlock.

Patch 3 fixes a use-after-free in debugfs read callbacks that can
access priv->ring and ring->desc while reset, driver unload, or
ethtool ring resize is freeing those resources.  A mutex is added
to synchronize debugfs readers against resource teardown.

---
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

Jijie Shao (3):
  net: hns3: fix vector resource leak in hns3_nic_alloc_vector_data
  net: hns3: fix interface stuck after OOM with full hardware rx queue
  net: hns3: fix use-after-free in debugfs read during reset/unload

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   1 +
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 124 +++++++++++--------
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  70 +++++++++-
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  18 +++
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |   3 +
 5 files changed, 167 insertions(+), 49 deletions(-)

base-commit: 305deb54c6c287e586bed92da2375ae1220e8dde
--
2.43.0

