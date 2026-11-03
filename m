Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701108;
	b=40oIPioN9vumHNOHuFJI+ObVKTLlGVN6B4xlJqPViULchfhVCPbvFiySbaSX5KG5VpRk
	 pAuSCTTg4ulzUIx4fS600nv5Yo0zezROuh7fnXcDwkzzSf5J9e+rLxtTJddz7LkuvY2mq
	 0WoAiYhG8UKwLeO1Zk9QSR6JYoME1qpGs10Kcs4GjddDocv6hXJR0pdGU1HptlzhVraHb
	 NceaLff3/5oXZ+BY6elVLRjPIabiHza3wdMT2sx89o6iPXjsrSxSLRTGq1zoMeFHHDLq6
	 GLFB7FqbeboEO1uuo/B7+XD3A61iUnySPDVN1iW/LIrbf5jKAAmLHUxtz7tCTdUTn6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701108;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=UxgM8P2HIxypNQyiwe8DVm3Lb91bk//Dpc4QBTFjK+c=;
	b=VRBHQ4MO2PZot4igWdqZ3uGWRajJaYDroE7HR/TSfcFaOQWQrVnUBLc2YMfFiLHXmG4V
	 ItxglZIXzKwuaPIhUqRxqgVBz5TSRYfBE/K/FQxWNlccDKWmBxW15tdv0umGCPNTZ8x0k
	 TjlORFgDUnhCFdex64okcHcxb/V1v9FoxsNdYszkkenng5WhKl57bYcSghXGRy1/y5tyy
	 yABilBf+ozF7+7z0nvAsd3xR/K3/bqHCbnR9zuxg3nrB0oDh/uVNwOOmgbQbC8Zb2EHti
	 zG7iUVUnYNxJlTBeDXSuAsrjEb/JXNOIsdp6uSBLS/Nnow2g2oXUJ4399oCHMuAOjbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ya3uMW4w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862B96082BCE;
	Tue,  3 Nov 2026 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ya3uMW4w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904CC1F00A02;
	Tue,  3 Nov 2026 10:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701108;
	bh=UxgM8P2HIxypNQyiwe8DVm3Lb91bk//Dpc4QBTFjK+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ya3uMW4wDXlXMFg/bXBytmGLOGr/sIri79M9Z/a9eG+aP60Qr2yze9HgFkw5rsk2E
	 0XNq2Evz3DaZte2ivb8FwKeV12TJT9MlDuKRtKDGmxTGVwjlcpux5VngKErNbMhwD1
	 +ebsNrJybTD0vs3WdBVEs8F+udovpCkq6Zz1upDiwtT3cE5If7k8K3mcieSRTYZ8lR
	 tEjqjI+klT1u10ZAFvIubCLIifpDDTc05rJxbYa8f2Eic23efBWQbwy9oYWamFxC2N
	 m3nbAMD2SFt2+US/DNp42jHSVNg3aqL5J2x1XRZmxkVFlQoT21W9Nj1ld/KGDnu4q1
	 yuQ2FLM8k8jjA==
Subject: Re: [PATCH v3 net 2/4] net: hns3: fix page_pool leak in
 hns3_alloc_ring_memory error path
From: netdev-bot+sashiko@kernel.org
To: shaojijie@huawei.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com,
 ningwei15@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 10:18:27 +0000
Message-ID: <179370110712.488856.17112299707405359724@kernel.org>
In-Reply-To: <20261030095633.377289-3-shaojijie@huawei.com>
References: <20261030095633.377289-3-shaojijie@huawei.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says the new cleanup in
  hns3_alloc_ring_memory()…

--

net: hns3: fix page_pool leak in hns3_alloc_ring_memory error path

When hns3_alloc_ring_buffers() fails for an RX ring, the out_with_desc
error path in hns3_alloc_ring_memory() frees the descriptor ring. It does
not destroy the page_pool that hns3_alloc_page_pool() just created. This
patch adds a guarded page_pool_destroy() to that error path.

> Add page_pool_destroy() to the out_with_desc error path, guarded by
> a NULL check, mirroring the cleanup done in hns3_free_ring_memory().

[Severity: Low]
This isn't a bug, but is hns3_free_ring_memory() the right name here? I
can't find a function with that name under
drivers/net/ethernet/hisilicon/hns3/.

The only other RX page_pool_destroy() is in hns3_fini_ring(). That function
calls hns3_free_desc() first and destroys the pool last:

drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:hns3_fini_ring() {
	hns3_free_desc(ring);
	devm_kfree(ring_to_dev(ring), ring->desc_cb);
    ...
	if (!HNAE3_IS_TX_RING(ring) && ring->page_pool) {
		page_pool_destroy(ring->page_pool);
		ring->page_pool = NULL;
	}
}

The new out_with_desc path does it in the opposite order. It destroys the
pool and sets ring->page_pool to NULL, then calls hns3_free_desc().

That order looks harmless today. By the time hns3_alloc_ring_buffers()
returns an error, it has already detached every buffer it attached. Each
desc_cb[i].dma is zero, so hns3_free_buffer_detach() returns early and
never hands a page back to the NULL pool.

Could the commit message name hns3_fini_ring() instead? It could also drop
the word "mirroring", since the order differs.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030095633.377289-1-shaojijie%40huawei.com
