Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354233;
	b=X13DusfrLCAEojHUe6s6KH8acD34bummf7mNM/SUpLgWhp/y/iv5KoVGp0yEZviqoBWo
	 4lQROSOouAt2j/XPJlt/TOHTsXxDGPca8uNKNnOhnad7ss1dBY6Cdv8EXdImWYQ4xzdLU
	 YJLdkaelmwUCK7NowD+opOumrM+Inh5oa8ffRFojFFWs3H5JaLsIxuZpigyVwm56IDNzI
	 TfSuWN7+P+DvRX+H/OM56kCpq4hXq5mNxj02rY3SB7bY9O8xRiENJQ9yBx5g6EfPwo0OT
	 NwOFukqBC+cFWFyWiBJq4849z6s1gPidJ56X6C8whtlIeotwWJqWcyTUS/nJUB4fRgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354233;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=3LbVNazfsM2Q58uvglFiW/vriTAOOIBvjojRRPEHqxo=;
	b=yhrbLZsfu4BG2fwXFAv6uWPOs/BZCU9B/OAs2B2YTs1nzAbibzLY7pLDjNnKKAdSydx5
	 Su54p+FRW0I9oP0EyodkzGlF7R7MI3BmYN3MiHuG4C/JbMZFEu5h1By4DhGbr4udbt4Zz
	 giWPa9fE0eDv4t92QfcGcDhsBa+TW0TBSodnLGqbqFIftJh/o7sG7OiX/fWzWH5MFVVOm
	 q84kapwLAWLluShnDQoAbRWqIFzAWpk+8iNesK+abyPeFDZms4VnoxpozqWkDlAAmCELA
	 hvmLxRs0/xElaYRhz7mqLI4FS4hmPNqrap2WReGXlrZPi4NqMspMPSBgYnRGV/eYDGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HrTp8XDQ;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D12606A31A;
	Fri, 30 Oct 2026 09:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4D12606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HrTp8XDQ
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3LbVNazfsM2Q58uvglFiW/vriTAOOIBvjojRRPEHqxo=;
	b=HrTp8XDQT36oRONc80FvbEkqe4m7Uu9eM7wemgh/69KBC+batmrXbtVyqodIKmG6GaOG8nDZX
	Ro9zkJSlnQKdHLxyRSf+jXH1BVbtDtZ2c2+jnxGZMf7K2XB6eWNKJrHX3E9ICRI1lo45ieYrrTp
	42n8JvWOa6okm/bnJgTtVFQ=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jGGj940qNz1cySS;
	Fri, 30 Oct 2026 17:57:01 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D30C4057A;
	Fri, 30 Oct 2026 17:57:09 +0800 (CST)
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
Subject: [PATCH v3 net 2/4] net: hns3: fix page_pool leak in hns3_alloc_ring_memory error path
Date: Fri, 30 Oct 2026 17:56:31 +0800
Message-ID: <20261030095633.377289-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030095633.377289-1-shaojijie@huawei.com>
References: <20261030095633.377289-1-shaojijie@huawei.com>
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

In hns3_alloc_ring_memory(), when hns3_alloc_ring_buffers() fails for
an RX ring, the error path jumps to out_with_desc, which frees the
descriptor ring but does not destroy the page_pool that was just
allocated by hns3_alloc_page_pool(). The page_pool and its pages are
leaked.

Add page_pool_destroy() to the out_with_desc error path, guarded by
a NULL check, mirroring the cleanup done in hns3_free_ring_memory().

Fixes: 93188e9642c3 ("net: hns3: support skb's frag page recycling based on page pool")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 2f3aeade558c..024d435ab62b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -5078,6 +5078,10 @@ static int hns3_alloc_ring_memory(struct hns3_enet_ring *ring)
 	return 0;
 
 out_with_desc:
+	if (!HNAE3_IS_TX_RING(ring) && ring->page_pool) {
+		page_pool_destroy(ring->page_pool);
+		ring->page_pool = NULL;
+	}
 	hns3_free_desc(ring);
 out_with_desc_cb:
 	devm_kfree(ring_to_dev(ring), ring->desc_cb);
-- 
2.43.0

