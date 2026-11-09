Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279101;
	b=knzC+n/WnzHjzL7mgRwNZVHDu5ieMTDkoGOzF+C62HPlUP9h8ETaTedkssEaR0+YqqCc
	 n24XORE3ZQHlZprxqqWGwBM5GfXiCG5W9Pex7BqeBlvd9skNZ559bS3L0/nlh9F14po/f
	 aHfc5XpsE++RDNH/gEd7RfArVlh2WtnsJunodnPugOGZalqj/vgndNBiy3fgvq8MJZRth
	 4MAzMhqT6EKPhvGqIWzrB9lGEAOQoAziqjoKBA2FBOMu8rqpNlOkgTJBtlJksVy56bVkJ
	 GnPtWTGVh3uYdTCOkXtfi7xrGl3hKexQETRogwMk9yBNmixzdfOFHhTALpCMmdrtonw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279101;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/3YVe9+UPTEY5+fwkaIb6HFpSrRXYqaEguXCXE4LZ7E=;
	b=2GLdR9ZDSdfF2pZkjFyLaHXIpEASgveoGcp36LM1lCi0jRy6I/W2/w3TxgRVuA0ExMxg
	 1VfYOdrp7HVvcYXxqXg0Yfs7LgZr06IfgEwXzQBwq1FeHnua2bZhRjUVfuO96i7+OSlxu
	 fIRUIucJeDUvmz8EaIw0gb671r6QAYssxxAV0Ph/wqf5fpqAD52D98Q2NMsD3i8qWt7Eq
	 NZmz90ieREEbilYi4xgBZfkAn9LV/2jbhxaR5tMKS4xksuSzNjwVO02cyJlKBUdhNcGM8
	 HRS8NYCpJQL3iYBYaXtgs+p1dc0brM65KbhnkD2bejmKgDdJZAD1VV1DDVwluzK37lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=iYXmpWAB;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1511D606A31C;
	Tue, 10 Nov 2026 02:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1511D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=iYXmpWAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794279090; bh=/3YVe9+UPTEY5+fwkaIb6HFpSrRXYqaEguXCXE4LZ7E=;
	h=From:To:Cc:Subject:Date;
	b=iYXmpWABDDqwJ9pv+q08Uer9uMIgyEB97WHWpTrT+8ICmkFlvlwfsbM1eRFJhamEV
	 pkO7+zHStZ/nZfFn/+JIPY7LiHh/8PH8aCE5iPzengadxIIlv9gOrP8mH7GaN7sB1C
	 hVvjDGdd/mMF+KozvQNyrXiYjGYYxQFR4rswtzXB9kUP6f9UeV4Q45Y2ic7svTjjpD
	 70sapImH6LXzKNE+PkACqzD+PJj7epH0JfDZJ4mVCazEulaDjXSpFFR3rlDFDOvCbe
	 X7ESbSOdXVgbNQuJghqcjuYEbH1MF6hF+//clnpPNph3RF/BO+2Y4P44tqK4mUzy3v
	 W7+Gfh+TOtCsQ==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id EA39D27A3593;
	Tue, 10 Nov 2026 04:51:29 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/3] net: ethernet: mtk_eth_soc: 9K jumbo frame support
Date: Tue, 10 Nov 2026 01:59:11 +0200
Message-Id: <patch-fc08a7ef40667bf3017366e452e6d3c0@loljews.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

This series makes the MediaTek SoC ethernet driver support 9K jumbo
frames on the 10G XGMII MACs (MT7988).  The driver advertises a 2030-byte
max_mtu and programs the MAC max-rx field for at most 2048 bytes, so
MTU > 2K is rejected and 9K frames are not usable.

Patch 1 fixes a pre-existing 36-bit DMA bug in mtk_poll_rx() that the
review of v3 found: a descriptor released without a new mapping is
handed back with the previous buffer's high address bits.  It is
independent of the rest of the series and carries a Fixes: tag for the
commit that introduced the bug, so the maintainers can route it to net
directly if they prefer.

Patch 2 gates the page_pool on the ring's descriptor length: the pool
hands out order-0 pages and maps at most MTK_PP_MAX_BUF_SIZE, so a ring
whose descriptor length is larger has to use the
netdev_alloc_frag()/mtk_max_buf_alloc() path.

Patch 3 adds the MTK_NETSYS_RX_9K capability, advertises 9K max_mtu on
the XGMII MACs (from the DT phy_mode at probe, so DSA can raise the
conduit MTU before the netdev is opened), programs XMAC_RX_CFG2 and the
PDMA RX SDL, derives the shared RX buffer length from the largest MTU,
sizes the RX rings from it and keeps the MAC max-rx limits in sync with
it.  A runtime MTU change that needs larger buffers is rejected with
-EBUSY while DMA is running; shrinking is allowed.  GMAC1, the built-in
switch port, keeps its MCR bucket programming (the largest the field
encodes is 2048), written after the MAC_MCR_FORCE_LINK_DOWN reset so it
survives every mac_config(); whether the internal switch path enforces
that field at all is a hardware property the commit message documents.

This work is a forward-port of the MediaTek downstream jumbo work: Mason
Chang's "change default rx buffer length" and "add 9k jumbo frame
support" (MediaTek OpenWrt feed 999-eth-30/31, carried in
frank-w/BPI-Router-Linux), plus Frank Wunderlich's "try to fix crash the
right way".  The runtime reallocation of Mason's "dynamic rx buffer
adjustment" (feed 999-eth-33) is not included and will be sent
separately.  Attribution is prose plus Link: tags: Co-developed-by
requires the original authors' own Signed-off-by lines, which we do not
have, and the port diverges from the downstream implementation (2K
buffer floor, per-ring pool gate, the -EBUSY rule, the XDP checks and
the truesize fix are not in the downstream patches).

The equivalent change was tested on a BPI-R4 Pro 8X (MT7988, 10G lan6 /
MxL86252) on the 6.18.60 backport: with both ends at MTU 9000, 8K ICMP
passes and iperf3 with MSS 8900 reaches ~9.87 Gbit/s (vs ~2.57 Gbit/s at
MSS 1460); the DSA conduit is raised to 9004 at boot.  This v7.3 series
is compile-tested with CONFIG_NET_MEDIATEK_SOC=y and COMPILE_TEST=y; no
hardware run of this exact tree yet.

Once any MAC's MTU needs more than ~3.5K, every RX buffer becomes a
16 KiB compound page; with the 9K ring size that pins around 64 MiB
while DMA is up and makes the refill a high-order GFP_ATOMIC
allocation.  That cost is inherent to the downstream design and is
called out in the commit message; skb->truesize now reports the
allocation that was actually made.

Changes in v4 (both v3 reviews, in full):

- XDP admission (High): the attach check now uses eth->rx_buf_len, the
  length the live rings were actually built with.  It is recomputed
  from the current MTUs whenever the rings are not live, or when the
  attach itself tears them down, so a program can neither attach while
  the rings have no page_pool nor be rejected on a closed device over a
  stale ring length; the dead dev->mtu clause in the same check is
  removed.
- the MAC max-rx rewrite in mtk_mac_config() and the new value in
  mtk_hw_init() are gated on MTK_NETSYS_RX_9K, so the other SoCs keep
  their per-device MCR buckets exactly as before this series.
- the PDMA RX SDL write is described as the new register write it is
  (the message no longer claims it replaces OR-ing).  The field layout
  (bits 16-30, frame length offset by MTK_PDMA_LRO_SDL) is the MediaTek
  downstream layout, validated on MT7988 hardware; the write is
  read-modify-write so every other RX_CFG bit keeps its value, and it
  now happens only in mtk_dma_init(), which runs at every DMA start.
- GMAC1 (the internal switch port) keeps its MCR bucket programming
  (largest encodable bucket is 2048); XMAC_RX_CFG2 is not used for it,
  matching the downstream reference.  The write in mtk_mac_config() now
  runs after the XGMII setup, whose MAC_MCR_FORCE_LINK_DOWN write is a
  full-register write that previously reset GMAC1's max-rx field back
  to the 1518 bucket on every mac_config().  Whether the internal path
  enforces the MCR field for switch-side 9K frames is a hardware
  property and is documented in the commit message: the downstream
  reference programs no limit for GMAC1 and jumbo frames pass the
  switch on the reference hardware, but if the field is enforced,
  switch-side frames above 2048 bytes are dropped and no driver write
  can lift that.
- XMAC_RX_CFG2 is always programmed from the shared buffer length
  (2K minimum), which includes 802.1Q headroom at every MTU, so the
  limit is the same value no matter which path ran last.
- skb->truesize reports the size of the compound page that was actually
  allocated, not the smaller frag_size.
- the -EBUSY rule's consequence for DSA (a user port MTU can only be
  raised with every MAC down) is now spelled out in the commit message.
- the stale comments above the pool gate and in mtk_dma_init() are
  rewritten to describe the code as it stands.
- patch 1/3 fixes the pre-existing 36-bit DMA descriptor corruption in
  mtk_poll_rx() found by the review of patch 1; it is small, sits in
  the file this series touches, and the introducing commit was
  identified upstream, so the Fixes: tag is included.
- patch 2/3 is retitled to say when the pool is skipped and its message
  no longer implies a frag_size gate existed before it.

Simon Horman's Reviewed-by is kept on patch 2 only: patches 1 and 3 are
new or changed materially since his review of v1.

Previous versions:
https://lore.kernel.org/all/patch-aad4cfa8d9522d1f7dbc9893ea12e813@loljews.com/ (v3)
https://lore.kernel.org/all/patch-2793186c653124c4c0b3d463bde2ea3a@loljews.com/ (v2)
https://lore.kernel.org/all/patch-4f863a941889f0bceca1c082f2d79624@loljews.com/ (v1)

Sandeep Haemoon (3):
  net: ethernet: mtk_eth_soc: reset RX DMA address each poll iteration
  net: ethernet: mtk_eth_soc: skip page_pool for RX rings whose buffers
    do not fit
  net: ethernet: mtk_eth_soc: add 9K jumbo frame support

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 284 ++++++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  12 +-
 2 files changed, 238 insertions(+), 58 deletions(-)

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.53.0

