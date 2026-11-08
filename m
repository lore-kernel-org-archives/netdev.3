Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172549;
	b=trsFtwy70r+Ujt2Ic3x+LAiCViMp9m/rEnFxzojSbJG8YCUC3JnK6xNe/JKGeMi8gSmX
	 DTLSoeG32F4ECx8iaz4aeVtRDI6PztO+MtKhPbmQsJfMlVZ262khSH68eeCpcZXKrO/XA
	 tF3wMmQKeT+aeswm9h1yc/DNPRc3aMrYHNHynXEsjJ+NAAan6nh2rA39f6OH0KDfwfxuD
	 YbBrS9oCn1jZOt//cMDxqmpvp5aTPAY+muR97/NfOL8JhFJ/02xtc/zX37v/dAXNACXL/
	 cxovZwb2gASxDUYZkCRggOQpB2u8eBNT/PNALkeyojjdJ+PCHV0JzVR2PtL1gSpi8Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172549;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QVUbFs7Z4kyGdbEXF6zg2YiEg2VY57J5U/RR+tPalRE=;
	b=SVmrlop1hUm86UfworNRU3R8u24kLoQP3Km8CyWRm3bfUQPvFjSTeN4jaai7dPz8zpZ+
	 v2n5Qr2QXaAIEuEuPHi2kqp5yK+zMLg/jNX4rijQlFofj/YwXvnkW8cFnPDPUJKZoQWgg
	 UcTB1uUFcQOaEljuHcPE3ZqbboJLNdDBEJD2/lNf27cbkpwsS38tDemNIIMHz1CRr1l9N
	 jTeQR0p75KfC2SWA0Pn6uWPB2h+HkZaq6/mLxG3xfy/LNUVH/WugAkEya6Smc4A96SFdS
	 tMNiNabHKT56N6/OYtyO0m+zoqbhanATIky3NHhkD0W0ajQ9RuFO6ri60akR86fplmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=QNk0Uvma;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DFB606A323;
	Sun,  8 Nov 2026 21:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3DFB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=QNk0Uvma
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794172536; bh=QVUbFs7Z4kyGdbEXF6zg2YiEg2VY57J5U/RR+tPalRE=;
	h=From:To:Cc:Subject:Date;
	b=QNk0UvmabABrVKHt5evVen51oIh6a39nvJBA3DFWRB7/KVX0VlUgptjtYUPlJfwv8
	 7qAlH2fwi/Irc5Ax2yubzoxFU8pHsonIDkPn+9PkCTtQ1Q5+GPjBrno72QEJM8VuZT
	 9pnzZllF5WLsyASHRMotvWPFrQggmVbi62zFNaUmNjJaSeZ9vigq1aIdNkBN7tQulF
	 CzKO+c/EFRd/4AlOGO9avfN5SaxePocZ7bV5cb8Lw1UireT2Rwgf20WbWl6OqJaUtE
	 0Aqn2QzLSaT1U2wnzhlKaiVB4ZiNxaHAmyoUB88McCHmObyvnOUmR4/3+D2awU/cT2
	 fExQkdWkjSzFQ==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id A789027A3593;
	Sun, 08 Nov 2026 23:15:36 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/2] net: ethernet: mtk_eth_soc: 9K jumbo frame support
Date: Sun, 8 Nov 2026 22:38:19 +0200
Message-Id: <patch-aad4cfa8d9522d1f7dbc9893ea12e813@loljews.com>
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

Patch 1 gates page_pool on the descriptor length of the ring: the pool
hands out order-0 pages and maps at most MTK_PP_MAX_BUF_SIZE, so a ring
whose descriptor length is larger has to use the
netdev_alloc_frag()/mtk_max_lro_buf_alloc() path.  It is pure
preparation, every ring fits today.

Patch 2 adds the MTK_NETSYS_RX_9K capability, advertises 9K max_mtu on
the XGMII MACs (from the DT phy_mode at probe, so DSA can raise the
conduit MTU before the netdev is opened), programs XMAC_RX_CFG2 and the
PDMA RX SDL, derives the shared RX buffer length from the largest MTU,
sizes the RX rings from it and keeps the MAC max-rx limits in sync with
it.  A runtime MTU change that needs larger buffers is rejected with
-EBUSY while DMA is running; shrinking is allowed.

This work is a forward-port of the MediaTek downstream jumbo work: Mason
Chang's "change default rx buffer length" and "add 9k jumbo frame
support" (MediaTek OpenWrt feed 999-eth-30/31, carried in
frank-w/BPI-Router-Linux), plus Frank Wunderlich's "try to fix crash the
right way".  The runtime reallocation of Mason's "dynamic rx buffer
adjustment" (feed 999-eth-33) is not included and will be sent
separately.

The equivalent change was tested on a BPI-R4 Pro 8X (MT7988, 10G lan6 /
MxL86252) on the 6.18.60 backport: with both ends at MTU 9000, 8K ICMP
passes and iperf3 with MSS 8900 reaches ~9.87 Gbit/s (vs ~2.57 Gbit/s at
MSS 1460); the DSA conduit is raised to 9004 at boot.  This v7.3 series
is compile-tested with CONFIG_NET_MEDIATEK_SOC=y and COMPILE_TEST=y; no
hardware run of this exact tree yet.

Changes in v3:
- gate page_pool on ring->buf_size <= MTK_PP_MAX_BUF_SIZE instead of
  ring->frag_size <= PAGE_SIZE: frag_size uses the netdev_alloc_frag()
  layout, so a ring could pass the old test while its descriptor length
  was already larger than the pool can map;
- keep 2K as the minimum RX buffer length, so MTUs up to 2K keep working
  at runtime on every SoC, DSA user ports included;
- restore MT7628's 1518 max_mtu, which v2 dropped by accident;
- in mtk_change_mtu() reject only a change that needs larger buffers, so
  a lowered MTU no longer locks the port out of further changes;
- program XMAC_RX_CFG2 with read-modify-write, keeping the bits outside
  the length field;
- replace the PDMA RX SDL field instead of OR-ing into it, which grew on
  every open with a different MTU;
- rewrite the MAC max-rx limits on every mac_config(), so a reopen with a
  smaller MTU narrows MACs that still carry the old limit;
- derive the XDP admission checks from the shared RX buffer length, so a
  program cannot attach and then never run;
- correct the commit messages: no runtime reallocation is included, and
  mtk_hw_init() now uses the shared length too;
- keep Simon Horman's Reviewed-by on 1/2 only, as 2/2 changed materially.

The order-2 allocation cost at 9K (one buffer per slot, high-order
GFP_ATOMIC refill) is unchanged from the downstream design and is called
out in the commit message.

v2: https://lore.kernel.org/all/patch-2793186c653124c4c0b3d463bde2ea3a@loljews.com/
v1: https://lore.kernel.org/all/patch-4f863a941889f0bceca1c082f2d79624@loljews.com/

Sandeep Haemoon (2):
  net: ethernet: mtk_eth_soc: skip page_pool for RX rings it cannot back
  net: ethernet: mtk_eth_soc: add 9K jumbo frame support

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 215 +++++++++++++++-----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  10 +-
 2 files changed, 173 insertions(+), 52 deletions(-)

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.53.0

