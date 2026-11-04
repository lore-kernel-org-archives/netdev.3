Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793075;
	b=V5Tm0Yq699vYWPlxo7dvEcbORx2gFAAKv4j28JJxWehFJ5412b5Z8vRVjRex/JkNF9iJ
	 Pxzcq96rNex+d14JvCn4iH8XomS5JU4H2oq6KLKtM07RkPpSNL0b/H/hwMFLj6xWap9oc
	 LDrfPwPj+Nn93fB8uqmXgSV734QEAQuXNCehuJGL5j9nWejlpmDJ3kmYKar5zWixXY9a4
	 YqoDBiAzpt8bXhJKY3wwxNtODhSItNrzsarQg9K2DGbTGTIi1KRTJADlf8jJZUevNuHRh
	 1zvwVnr69GGmurPIUzjenVxNgwc6b6ee/+mFuGDXiDZYkf4/Q+yVyeYpoaWfG7Ig4yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793075;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=g11exoxlvmrxitGNcbcJpKjoh89AXFeg8RsYV6aUIHI=;
	b=xqXVoELWkc67jOzJ7hrWI6dQK2Klz8tIw0S29t6g7yWpxoUqRk4cvU9VEUXTpRmCb5z8
	 wolrvmhO4e1YC+SYvRS2ztXM+sp9vEp0aQZH5PRw7UbSoErDZRApVE2BiC9oyjxBS5+fW
	 xV5ztDWgC15swoK4xQKi8+yQYHHRZ44kvKCglT7DMIqmawG8zPQn2x2Kc1yDdglvkkOi8
	 7dGYcHRbpJ3jZeZ/Jjy5j7HZusS3mDPvEWCErLgQlEKaU74u7DT/eycAik1zBndnN3UyK
	 4VItekBpq640safzWv+2oOoXUWvI02KqCvv5eVamxsZHhSxbIeOZaiI47PU6FIcMn4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TV2WdrL4;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88213606A31B;
	Wed,  4 Nov 2026 11:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88213606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TV2WdrL4
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=g11exoxlvmrxitGNcbcJpKjoh89AXFeg8RsYV6aUIHI=;
	b=TV2WdrL4S17kV8RPOgnULouHNk3W0Dzy8ycqX7tnsKMk6uH7lgx2WLIpz0RgS777SnIxSQKAP
	89s63YlDDlU6hUyt3N55M9q8R1Q3xQO5NUrDtjGVgvKRgbYAx/SWNBIHRVnNgeywoZ31JrSsJXG
	N9h5KeHpfl7WHeaqfFpssTs=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jKP0F1nDFzmV7W;
	Wed,  4 Nov 2026 19:50:53 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AB6040565;
	Wed,  4 Nov 2026 19:51:04 +0800 (CST)
Received: from [10.67.121.233] (10.67.121.233) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 4 Nov 2026 19:51:03 +0800
Message-ID: <87245a0b-2d33-49c6-a21b-9a316c50bef7@huawei.com>
Date: Wed, 4 Nov 2026 19:51:02 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<yangshuaisong@h-partners.com>, <ningwei15@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net 2/4] net: hns3: fix page_pool leak in
 hns3_alloc_ring_memory error path
To: <netdev-bot+sashiko@kernel.org>
References: <20261030095633.377289-3-shaojijie@huawei.com>
 <179370110712.488856.17112299707405359724@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <179370110712.488856.17112299707405359724@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/11/3 18:18, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The commit message says the new cleanup in
>    hns3_alloc_ring_memory()…
>
> --
>
> net: hns3: fix page_pool leak in hns3_alloc_ring_memory error path
>
> When hns3_alloc_ring_buffers() fails for an RX ring, the out_with_desc
> error path in hns3_alloc_ring_memory() frees the descriptor ring. It does
> not destroy the page_pool that hns3_alloc_page_pool() just created. This
> patch adds a guarded page_pool_destroy() to that error path.
>
>> Add page_pool_destroy() to the out_with_desc error path, guarded by
>> a NULL check, mirroring the cleanup done in hns3_free_ring_memory().
> [Severity: Low]
> This isn't a bug, but is hns3_free_ring_memory() the right name here? I
> can't find a function with that name under
> drivers/net/ethernet/hisilicon/hns3/.
>
> The only other RX page_pool_destroy() is in hns3_fini_ring(). That function
> calls hns3_free_desc() first and destroys the pool last:
>
> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:hns3_fini_ring() {
> 	hns3_free_desc(ring);
> 	devm_kfree(ring_to_dev(ring), ring->desc_cb);
>      ...
> 	if (!HNAE3_IS_TX_RING(ring) && ring->page_pool) {
> 		page_pool_destroy(ring->page_pool);
> 		ring->page_pool = NULL;
> 	}
> }
>
> The new out_with_desc path does it in the opposite order. It destroys the
> pool and sets ring->page_pool to NULL, then calls hns3_free_desc().
>
> That order looks harmless today. By the time hns3_alloc_ring_buffers()
> returns an error, it has already detached every buffer it attached. Each
> desc_cb[i].dma is zero, so hns3_free_buffer_detach() returns early and
> never hands a page back to the NULL pool.
>
> Could the commit message name hns3_fini_ring() instead? It could also drop
> the word "mirroring", since the order differs.

Agreed, that function does not exist. Will rename to
hns3_fini_ring() and drop "mirroring" in v4, since the
destroy order differs (pool-then-desc here vs desc-then-pool
in hns3_fini_ring()). The opposite order is safe in this
error path because hns3_alloc_ring_buffers() has already
detached every buffer.


