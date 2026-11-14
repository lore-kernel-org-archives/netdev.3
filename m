Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616248;
	b=VYGMEEZDBuy/AOcy51icu5SVpEY1ZIbtxIwm4kfdhKUKEoUbHpAOzkr4cNO/UbX8wLEu
	 vJtgwQsW1Bv5igaa7y6ywyg88EhgXxKNQprEmh2gEYB+dmYFbBbo8GoPm9luETUJrJl+X
	 gB6qyVQNIP8zfJoibqHdkLv60imRcJk530sslark6FbUSBhL2lUV5hxezE+0+8qrXXS2l
	 EICez2PnhZP0MAsBKMDZEKv87aZJDX8WgurrcxAg0nkNG4dZPrfuCTS5XG5M0xhBiZSqA
	 leSIquuKVMgQ53HcN544P/UfqoMiQUjwEVRfGIUo4n2uKq3i7oQZfF4hn9husmVgGzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616248;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=y4S5YAyo6mRweP6y8zJHMhum1+7e/wVfjs8PWSE6QOY=;
	b=F9sMd9gwuh4/NPGhHJ70J+XHKbnPFUk9/Xd7mZpfJFaSvWu2EYZRf8HoskmL/txNzdwX
	 sxmjuwF7QaY308mcnM8sl/bmJRLsFedti+ZuZUl19gCgVSyn2ojqTrRZMCPJSFgJwJvJY
	 ZNIRpLJGc5K1wjFxV0pUG1lL8XoIEEKD3ObZzy27HYZzZx0NITm+htC7C6DlPca2XAdcW
	 lJcY7cJW/+++5V+XpsdWZ7GhbRaClLoSD2sOUVh8YCGiTvzINB9hi8yW8lXhJA9bHQtvT
	 uk77sCJNdQIvV2TQN5Eq7h/SFbgP2TkGTGYJqIkcNP3CibmzKIEkQ6R8i/BwgYHqYPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=XmYi8ub9;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30960606A331;
	Sat, 14 Nov 2026 00:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30960606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=XmYi8ub9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794616243; bh=y4S5YAyo6mRweP6y8zJHMhum1+7e/wVfjs8PWSE6QOY=;
	h=From:To:Cc:Subject:Date;
	b=XmYi8ub9Fh1+cNiPqZLt9gpGRfXW9RVUVi54ZQ64j27dpdSNMuwFCFYsFI9JCGo0q
	 8XvrtBtGfbi0n7vAVTlHX9i593tpyT90u+rGI9Kvr7HgRmCFVQr9Eg2hw7m4etuoB4
	 5YnkWYY1SVOs/PIjWZkB3dKy9hBJlRcJh6YpMeIohwJxPRpEj1Yo+FPh/pD6Ts1FBK
	 P0+JV4MqTvVsup4w6m0LdbVYpW54GUYePDBG56PBnTJgMMGw0xjsS2gdWHOFRxhoKk
	 GrmyO4lu/fJ3OHQ3yY/l1oMS0ELUCjdP0vdsZAtMLZrpLkfYpcNEuym00+sdfMcSR0
	 fGLQmwjNHBTWg==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id 27A0F27A347E;
	Sat, 14 Nov 2026 02:30:43 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Daniel Golle <daniel@makrotopia.org>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 0/3] net: ethernet: mtk_eth_soc: 9K jumbo frame support
Date: Sat, 14 Nov 2026 02:29:44 +0200
Message-Id: <patch-9e765e74d06edbba3fd85a0cd49c4bb5@loljews.com>
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
frames on the 10G XGMII MACs (MT7988).  The driver advertises a
2030-byte max_mtu and programs the MAC max-rx field for at most 2048
bytes, so MTU > 2K is rejected and 9K frames are not usable.

Patch 1 fixes a pre-existing 36-bit DMA bug in mtk_poll_rx() that the
review of v3 found: a descriptor released without a new mapping is
handed back with the previous buffer's high address bits.  It is
independent of the rest of the series and carries a Fixes: tag for the
commit that introduced the bug, so the maintainers can route it to
net directly if they prefer.

Patch 2 gates the page_pool on the ring's descriptor length: the pool
hands out order-0 pages and maps at most MTK_PP_MAX_BUF_SIZE, so a
ring whose descriptor length is larger has to use the
netdev_alloc_frag()/mtk_max_buf_alloc() path.

Patch 3 adds the MTK_NETSYS_RX_9K capability, advertises a 9194-byte
max_mtu on the XGMII MACs (from the DT phy_mode at probe, so DSA can
raise the conduit MTU before the netdev is opened), programs
XMAC_RX_CFG2 and the PDMA RX SDL, derives the shared RX buffer length
from the largest MTU (802.1Q headroom included) and sizes the RX rings
from it, keeping the never-polled QDMA ring at its 2K buffers.  The
MAC max-rx limits stay in sync with that shared length, including
GMAC1's MCR jumbo field.  A runtime MTU change that needs larger
buffers is rejected with -EBUSY while DMA is running; shrinking is
allowed.  GMAC1, the built-in switch port, keeps its MCR programming
(bucket plus the jumbo field in 1024-byte units), written after the
MAC_MCR_FORCE_LINK_DOWN reset so it survives every mac_config();
whether the internal switch path enforces that field at all is a
hardware property the commit message documents.

This work is a forward-port of the MediaTek downstream jumbo work:
Mason Chang's "change default rx buffer length" and "add 9k jumbo
frame support" (MediaTek OpenWrt feed 999-eth-30/31, carried in
frank-w/BPI-Router-Linux), plus Frank Wunderlich's "try to fix crash
the right way".  The runtime reallocation of Mason's "dynamic rx
buffer adjustment" (feed 999-eth-33) is not included and will be sent
separately.  Attribution is prose plus Link: tags: Co-developed-by
requires the original authors' own Signed-off-by lines, which we do
not have, and the port diverges from the downstream implementation
(2K buffer floor, per-ring pool gate, the -EBUSY rule, the XDP checks
and the truesize fix are not in the downstream patches).

The equivalent change was tested on a BPI-R4 Pro 8X (MT7988, 10G
lan6 / MxL86252) on the 6.18.60 backport: with both ends at MTU 9000,
8K ICMP passes and iperf3 with MSS 8900 reaches ~9.87 Gbit/s (vs
~2.57 Gbit/s at MSS 1460); the DSA conduit is raised to 9004 at boot.
This v7.3 series is compile-tested with CONFIG_NET_MEDIATEK_SOC=y and
COMPILE_TEST=y; no hardware run of this exact tree yet.

With the 1 KiB rounding the RX buffer length is order-1 (8 KiB) for
rx_buf_len 4096..7168 and order-2 (16 KiB) from rx_buf_len 8192 up;
at the 9K ring size the 16 KiB buffers pin around 64 MiB while DMA is
up and make the refill a high-order GFP_ATOMIC allocation.  That cost
is inherent to the downstream design; skb->truesize now reports the
allocation that was actually made.

Changes in v6:
- rebase onto current net-next (a76e8bf4be) so the series applies
  again: net-next converted mtk_rx_alloc() to kzalloc_objs(), which
  the hunk context depended on.  No functional change.

Changes in v5 (the v4 review, in full):

- 802.1Q headroom (Medium): the shared RX buffer length now includes
  VLAN_HLEN before the 1 KiB round-up, and the advertised max_mtu is
  lowered by the same four bytes to 9194, so a tagged maximum-size
  frame (9194 + 18 + 4) still fits in rx_buf_len 9216 and the XMAC
  9216 cap.  XMAC_RX_CFG2 and the ring buffers therefore cover a
  tagged frame at every MTU, including the maximum.
- GMAC1 MCR jumbo field (Medium): the vendor driver has a second MCR
  max-rx field we had not ported.  mtk_set_mcr_max_rx() now clears
  and programs the jumbo field (bits 31:28, 1024-byte units,
  MAC_MCR_MAX_RX_JUMBO) for GMAC1, so the driver can program the same
  shared length for the switch port as for the XGMII MACs.  The new
  field handling is limited to the MTK_NETSYS_RX_9K SoCs; every other
  SoC keeps its previous MCR programming bit for bit.
- QDMA ring sizing (Medium): the helpers now take the buffer length
  instead of struct mtk_eth, and mtk_rx_alloc() sizes the
  never-polled QDMA RX ring at the fixed 2K length instead of the
  jumbo length, so it no longer pins ~32 MiB of high-order pages.
  HW-LRO rings keep their 12288-byte sizing.
- pktlen bound (Medium): mtk_poll_rx() drops descriptors whose PLEN0
  exceeds ring->buf_size, with rx_length_errors, before the buffer
  can be passed up, so the larger build_skb() size can no longer hand
  stale memory to the stack if the engine over-reports the length.
- PDMA SDL encoding (Medium): kept as in v4; the comment and commit
  message now say explicitly that the GENMASK(30,16) encoding (frame
  length offset by MTK_PDMA_LRO_SDL) is the vendor's and not publicly
  documented, and that a datasheet confirmation would be welcome.
- XDP detach (Medium): the pool-size check now runs only when a
  program is attached, so a detach always succeeds.  The shared
  eth->prog weakness the review also points out is pre-existing and
  is left to a separate fix.
- 3/3 message (Low): the buffer-size math is corrected (order-1 for
  rx_buf_len 4096..7168, order-2 from 8192) and the message now says
  that the build_skb()/truesize change also covers the HW-LRO rings
  on mt2701, mt7622, mt7623 and mt7629.
- 1/3 subject and message (Low): retitled to describe the fix ("fix
  the RX descriptor address on the release path") and the message now
  cites 6e0490fc36cd and e10a35abb3da, which moved the
  DMA_MAPPING_ERROR initialisation out of the loop and made the first
  commit's protection ineffective after the first iteration.

The pre-existing High finding of the review (a failure while filling
an RX ring leaks the partially filled buffers and DMA mappings
because ring->dma_size is still 0) is not part of this series: it is
in the untouched v7.3 code and will be sent as a separate fix that
sets ring->dma_size before the fill loop.

Simon Horman's Reviewed-by is kept on patch 2 only: patches 1 and 3
are new or changed materially since his review of v1.

Previous versions:
https://lore.kernel.org/all/patch-f1e62a87eb0f914e1ea52a395f465998@loljews.com/ (v5)
https://lore.kernel.org/all/patch-fc08a7ef40667bf3017366e452e6d3c0@loljews.com/ (v4)
https://lore.kernel.org/all/patch-aad4cfa8d9522d1f7dbc9893ea12e813@loljews.com/ (v3)
https://lore.kernel.org/all/patch-2793186c653124c4c0b3d463bde2ea3a@loljews.com/ (v2)
https://lore.kernel.org/all/patch-4f863a941889f0bceca1c082f2d79624@loljews.com/ (v1)

Sandeep Haemoon (3):
  net: ethernet: mtk_eth_soc: fix the RX descriptor address on the
    release path
  net: ethernet: mtk_eth_soc: skip page_pool for RX rings whose buffers
    do not fit
  net: ethernet: mtk_eth_soc: add 9K jumbo frame support

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 324 ++++++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  16 +-
 2 files changed, 282 insertions(+), 58 deletions(-)

base-commit: a76e8bf4be552eed20801186188e5606365870a0
-- 
2.53.0

