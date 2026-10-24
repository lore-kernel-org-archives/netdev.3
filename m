Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792826114;
	b=hLdxTwpgCoP7M3nwrEXgyuVIPb5KTEbmF9seRF6Q6NCyoiDSxLJfQTsUcgLxVZ/1y2Y1
	 kQYnkkNz2Wj7/4RfBSNbaQ+69K3aIc2fRjAgTLcv6ZcNN/JAaycqm5QF5/Qx5j+7LJNhv
	 J4fvwVEJ2LQv+g79ULjbSlMQdBp0eL0eeOuntA56lXuysNXviv3kted1zwsPAfYceXCrM
	 /iTZ59DD4wnmRNBXn/pXx47CvXy+WNvp7FM71/v/DuYQQt6+njTLFGof2INlhAgkfKqgb
	 jUcoM2TI8hvvT5YZDTyc9wM62yYGYU3HlDUmtrhNSH4miCh9AnzEoaNuiYyDkSJmk4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792826114;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=ZAim7a7Mw2f4u2GqAJJCl39Hm/2+x8OUH9OyNgrjapQ=;
	b=FeStPleOGW4bThnW4XmNh72+ZLLhZOQmaeLPx7YzT+jqmM7R1lLszhgZLe0pqvxuHNIE
	 PIiUVo5xu9IGKnPyA7WOgDIJfw3fzkfHuMEQNVQhiWiHjwvyjSf4P/uDKD6FqDTBal81f
	 2nKuBOTaZF8iEpesmvJWW0iUjaPNUScG0Z7PTgj7ybyG/gRUYmYxFv/+fL4vznPJCnHsR
	 PuOsAZ8lkkW2IOtomUV0DV47MfBPsh4244b+ayxdSMmaX2tZ41VlJbZf2OKtnJoJ7vS7Q
	 j8zGsU1VT/EgcOt2F3vLIV8RrauJZP4In5DJz9FSwR1D8y4acvNcfkW4HR+1QkfMGGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=h318Nj9K;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE721606A324;
	Sat, 24 Oct 2026 07:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE721606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=h318Nj9K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZA
	im7a7Mw2f4u2GqAJJCl39Hm/2+x8OUH9OyNgrjapQ=; b=h318Nj9Khr/oE1jAIF
	SEnZ4JiNHqtZNfK5S8Omc10942WL/3JHKFO/e7SqTpN0NNEbQW4bjoCWXm6Oa8Q+
	29UJYqhYOzYzI8qEwMMuU8P78oLR0svw6Htuhn3f6lhL6g+WA51+X0oxUdBl6c/C
	HbL3qgYNqhZbhWnIOlrNzmZd8=
Received: from 4CV529F122.company.local (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD310ySWtxq_y0rCg--.41124S2;
	Sat, 24 Oct 2026 15:13:32 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org (open list:STMMAC ETHERNET DRIVER),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: dinghui@lixiang.com,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com,
	liuxuanjun@lixiang.com
Subject: [PATCH net-next v6 0/4] net: stmmac: fix DMA descriptor ring cleanup issues
Date: Sat, 24 Oct 2026 15:13:14 +0800
Message-Id: <20261024071319.875921-1-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wD310ySWtxq_y0rCg--.41124S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWkCw4xJFy8Ww4rCw4fAFb_yoW5tFy3pa
	ySvws8tr98Xr1xJrsxCw4xW3W8Ca1fCF4Ygr17tw1fua15uryF9rWSkrWYgF1DCryjkw1j
	qryYvasrAFyUA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jgXo7UUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC8xyPu2rcWpxixgAA3P

From: Ding Hui <dinghui@lixiang.com>

Hello,

This series fixes the NULL pointer dereferences in the stmmac TX/RX
DMA resource cleanup paths and the associated error path issues,
found on a DWMAC platform whose descriptor ring allocation may fail
under memory pressure.

Patch 1 adds NULL guards in the free helpers and makes them clear
the pointers they free, so that a NULL pointer reliably means "not
allocated" for the long-lived priv->dma_conf.

Patch 2 makes the per-queue allocation functions undo their own
allocations on error, instead of leaving the cleanup to the outer
error paths that would then walk partially-initialized queues.

Patch 3 releases the descriptor resources through priv->dma_conf
when __stmmac_open() fails after copying the temporary dma_conf, so
the long-lived configuration stays consistent with the resource
cleanup.

Patch 4 holds RTNL around the descriptors_status debugfs reader and
skips queues whose rings are not allocated.

This series is rebased on top of the current net-next.

Changes in v6:
  - Split the single patch into a four-patch series as requested
    during review: NULL guards and pointer clearing, allocation
    error paths, descriptor resource release through priv->dma_conf
    on open failure, and the descriptors_status debugfs locking.
  - Merge the descriptor resource release with the ptp_error unwind
    from 8181678a92f0 and rebase on top of the current net-next.
  - Use the "net-next" subject prefix, which was requested back in
    v1 but mistakenly kept as "net" in all previous revisions.
  - Link to v5:
    https://lore.kernel.org/netdev/20261012142458.2845385-1-dinghui1111@163.com/

Changes in v5:
  - Release the descriptor resources through priv->dma_conf when
    __stmmac_open() fails, avoiding stale pointers in the
    long-lived configuration.
  - Hold RTNL while descriptors_status reads the descriptor rings.
  - Link to v4:
    https://lore.kernel.org/netdev/20261001035045.3305816-1-dinghui1111@163.com/

Changes in v4:
  - Free the RX resources in alloc_dma_desc_resources() when the TX
    allocation fails.
  - Skip queues whose descriptor rings are not allocated in
    stmmac_rings_status_show() and print a hint instead.
  - Link to v3:
    https://lore.kernel.org/netdev/20260919121436.1642724-1-dinghui1111@163.com/

Changes in v3:
  - Use addr directly in __alloc_dma_rx_desc_resources() error path
    instead of the if/else block on rx_q->dma_erx/dma_rx.
  - Clear the freed pointers in __free_dma_rx_desc_resources() and
    __free_dma_tx_desc_resources().
  - Link to v2:
    https://lore.kernel.org/netdev/20260905154654.1725313-1-dinghui1111@163.com/

Changes in v2:
  - Instead of only adding NULL checks in the free helpers, also fix
    __alloc_dma_rx_desc_resources() and
    __alloc_dma_tx_desc_resources() to clean up their own
    allocations on error, as suggested by Andrew.
  - Link to v1:
    https://lore.kernel.org/netdev/20260830040610.1156008-1-dinghui1111@163.com/

Ding Hui (4):
  net: stmmac: guard against NULL pointers when freeing TX/RX buffers
  net: stmmac: clean up partially allocated DMA rings on error
  net: stmmac: release descriptor resources through priv->dma_conf on
    open failure
  net: stmmac: hold RTNL when reading descriptor rings in
    descriptors_status

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 115 +++++++++++++++---
 1 file changed, 98 insertions(+), 17 deletions(-)

--
2.34.1

