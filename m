Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955992;
	b=mnnEmbM+wLJlo7g1bQnIZUogh9TNggc76iGhydv8xvpS39aQFLsXO9ZSBN4FWhfUwHVq
	 aY+IWUQnXhGGyl0tccgGQWX0Fzn5hi7c+VqZfy4NZUXv+b/nics31aUdlJCIp/INqTubI
	 wheULOWy1H87wev2oRebNfrwTNZo/OqHcHGTx/gY9BIgIQV1QTTyS1UBJ6I6cdxhH50vv
	 w6upzPRtNEZCcEdTK/+MZ180iIWQh9SoUPNpULisqm3qCiKJDxh9tnfm4rCFHC1H7+UIk
	 nrXIxHFTIxcAN0grrud2MiBGjHRH0Mhz79muE7ZuC4q8NkxXDaM/feSSHGs+kkH3xjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955992;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=q1H95/3jUArP09V4hzLaUE0XBUgQ2k28lsOurBPd7c8=;
	b=PB0ol/5m+0uH+dpLYAhaDrZp9B5LxQp0XuA/rDo5NdnitAHtej75Ov/TG/029akJR8CW
	 Npi66aAqK+kEF50j77j2u2kACY5dk5uiN1bFvOZBUFcmpKGWSyWZCmsc/TtfKu46OMKCc
	 318TN86LcULv4ToGKWEsHfbQtxXLrUpc9oBO6IYRPSh/Y1yFSLw4cfmW/u2s8iXqeKXTC
	 oCML2VdholnS7UDCUsyFGuannpXC5A68R3PTJXd3CWehH/qx6TR+MbmoXhN30tKNQz7vD
	 9TyIzp+iJA+2C0AL8FqiZp4xuVZzn40YZSoXhNvQIx4zFzJhz30ScRCRFKR/Lhn7xpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="ETUQ/8Er";
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EAA606A328;
	Fri,  6 Nov 2026 09:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8EAA606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ETUQ/8Er
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=q1
	H95/3jUArP09V4hzLaUE0XBUgQ2k28lsOurBPd7c8=; b=ETUQ/8ErmweduNzLfe
	rBILfqHyBPbKH7HUgdKY5q+xKHcf1aBazRi6DbR0smOY5pWsx2QSQRJ2+1reOgku
	iDDigAjh0gNv9MeHsaNl7AOCF/Fu1A+0ZvnY130/XT3nsKFBgniz6R/kMuZ6mjTA
	QHvinM241W6gEIo/jrAdYhfFc=
Received: from 4CV529F122.company.local (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3_7hJmO1qqwdQFQ--.15084S2;
	Fri, 06 Nov 2026 17:05:28 +0800 (CST)
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
Subject: [PATCH net-next v6 RESEND 0/4] net: stmmac: fix DMA descriptor ring cleanup issues
Date: Fri,  6 Nov 2026 17:05:02 +0800
Message-Id: <20261106090507.1020751-1-dinghui1111@163.com>
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
X-CM-TRANSID:_____wD3_7hJmO1qqwdQFQ--.15084S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw4UAF4kKw15XrW5JF1DZFb_yoWrGw1Dpa
	yfKan8tryDXr18JwsxCw4xWF18Aa1fCF4Ygr17Jw1fua15uryF9rWS9rWYgFyDCryqkw1j
	qF15ZasrAF1UAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jayxiUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC0RlSfmrtmFlPrAAA3B

From: Ding Hui <dinghui@lixiang.com>

Hello,

This is a resend of v6, originally posted on October 24, 2026,
when net-next was closed. The four patches are unchanged.

Previous posting (v6):
https://lore.kernel.org/netdev/20261024071319.875921-1-dinghui1111@163.com/

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

The original v6 series was based on net-next commit
734bef548a96 (Merge tag 'net-next-7.4' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next).
This resend retains the same base.

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

