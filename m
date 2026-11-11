Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401938;
	b=nGKhRjncM8sf2/gCX8IIPz0AtvekMh4mWWP091zpact2PsMRzxjTShrtZFKM4Q7Jvk8d
	 qq1XhSbxbtH7zM9zXR3v7WRn2WxcFmNpI0WxLYWj0jQhb57Urr9k7ZnOBwaYd3O+SeEpL
	 rlRstlOVH1EqMI92SF8SqBVcwM2y40EojMZ9Bj4O3qODyajCl7uIFB1S8PPRiyw0vITVP
	 teSAQ8l/17LWGJKrBqyGVgsMlBvT/Kgl4fd1z1Y32FhuX7vla7M+p7+SFBB7oxuWcgn76
	 PK3yt8Gg2eUwzwbblIWkCVN5b9L1pnfxu4ISc6EAOnqk6CHFonv9/QR1Ibd7Nz9HBzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401938;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=LSwOKCGSvBqz4A0+9jCrrAb3atuhY2goYSger40ZS/s=;
	b=4LDYAU6HsFdSZgcnckO9eOJjMavz1urcgZrOWUyeTOP2H8s7B40K3XS+BOe+sITin0nw
	 VXYbyIiN97ucjLXSQxqRYkEGI7boISym+RT5GkbMuCIdAm8v4tFVJEIrXoe1uk19v6BHv
	 PIdE/fGovx2epLv9jlUgq7pbp4yy5985nagZsMkcUMt2EfpUs60Xt0+pQcPUyvqYZEuXj
	 KrOrgMriZCBUNemZF9dTNKwZYj+A7HI2MW1aJDurq8OQreBdPuiYs9FEsnC2FPGTmMUo2
	 PqtWLnl7HHsPsW8zRyA89QZoyeHZQVAZCWFWc9YFaJUWYtmi/wxhtCKv2LWZE+LVLWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=IU7NZTi7;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8211E606A327;
	Wed, 11 Nov 2026 12:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8211E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=IU7NZTi7
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LSwOKCGSvBqz4A0+9jCrrAb3atuhY2goYSger40ZS/s=;
	b=IU7NZTi7zztwh7ZR4qF2CNLSOAveA5dnH1xtjuISAH5tT1ctzNJ6/v4LFwq/+fD6ChJ7rRSFL
	GwbbPHjUU6B1pYGJP2ZNUg738on6XQP83SaPCMw7NYIepoSfavIkHQ7oSrPs9cAtK6DrQ4YHrp+
	7rvzI3PUmcLGdO4FH35docs=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jPk99651cz1cyQR;
	Wed, 11 Nov 2026 20:58:37 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CD914055B;
	Wed, 11 Nov 2026 20:58:53 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 11 Nov 2026 20:58:52 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v4 net 2/4] net: hns3: fix page_pool leak in hns3_alloc_ring_memory error path
Date: Wed, 11 Nov 2026 20:58:08 +0800
Message-ID: <20261111125810.3359030-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111125810.3359030-1-shaojijie@huawei.com>
References: <20261111125810.3359030-1-shaojijie@huawei.com>
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

In hns3_alloc_ring_memory(), when hns3_alloc_ring_buffers() fails for
an RX ring, the error path jumps to out_with_desc, which frees the
descriptor ring but does not destroy the page_pool that was just
allocated by hns3_alloc_page_pool(). The page_pool and its pages are
leaked.

Destroy the page_pool in that error path as well. The pool is torn down
before the descriptor ring here, which is the opposite of the order in
hns3_fini_ring(); that is safe because hns3_alloc_ring_buffers() has
already detached every buffer it attached, so hns3_free_desc() walks
descriptors whose dma is zero and never hands a page back to the pool.

Fixes: 93188e9642c3 ("net: hns3: support skb's frag page recycling based on page pool")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
Changes in v4:
  - Name hns3_fini_ring() instead of the non-existent
    hns3_free_ring_memory(), and drop "mirroring" because the destroy
    order differs.  The pool is destroyed before the descriptor ring
    here, which is safe because hns3_alloc_ring_buffers() has already
    detached every buffer.
v3: https://lore.kernel.org/all/20261030095633.377289-3-shaojijie@huawei.com/
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 2f3aeade558c..dbf32c00bb7f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -5078,6 +5078,8 @@ static int hns3_alloc_ring_memory(struct hns3_enet_ring *ring)
 	return 0;
 
 out_with_desc:
+	page_pool_destroy(ring->page_pool);
+	ring->page_pool = NULL;
 	hns3_free_desc(ring);
 out_with_desc_cb:
 	devm_kfree(ring_to_dev(ring), ring->desc_cb);
-- 
2.43.0

