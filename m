Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000118;
	b=TA2KK4j7XsE/49vRdPztOWDgmmBXGo0BDDxEKR7CnqBPmkIn7FeJ96dTLZC9Ee81+fsq
	 Z7mkpcPhd0uAQu1Lenru1PipRAoMUo3WRprDE1KJfB0VVcJ+B+rA/+dIHHoN/ziugS0fL
	 Wof1SI+yS6KNXkHGqmiHLzJ/1V7NHJVg4iTJ1KoDFtQWsSUyDtfCZ960sJ8v968/rv+mp
	 74Muy1n6l1EvIyB9ZFryqV9KOfdc3i5rRSU22QodobEjN2Bzo8jjxYhyWjSgLlPjZamjs
	 BOudZPG/Y2MgTrRO2JoWAqGY4maKuxy8L0X7ppzq71Ug1CBQ2LumgQvGiZ5JowWqrnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000118;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PZTZ+baBEak191qDzxsfkiAJwS6lGJxUKvHfh+ZeHM4=;
	b=3LnxyUhflyUpqzdsrjbYr9uOZpu2NRtLoPdxnaHRyP73hS7NKR0PBu6MFXQ4+VrY5wPc
	 INsf7zcMAoiXFnQ4aDcKl640rq0Ouz4N1McELEjWl4rjmZVkf5qmyQ9iidJtSOlb5PZmj
	 PI4CY18kgJiPNorZ9n49qvnuT1GNikanfp0lhmshy1ohrzGZMQPS4Lcl8r4EIFWXR2u8o
	 0OKDl86CVFhY23G+WWgwet1nxlMj2DCUg7J6ieeCeQAByAQ7+7E8XL02CziXU8EjzCuGb
	 EXIu+ey7KGQDbdP4gd2EQ2UOf2NMFpwBXEam/g+sA0gL6QaGLQ4e4Ef2HhdahkjF8/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=fktGX8YP;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB8606A32E;
	Fri,  6 Nov 2026 21:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BDB8606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=fktGX8YP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794000101; bh=PZTZ+baBEak191qDzxsfkiAJwS6lGJxUKvHfh+ZeHM4=;
	h=From:To:Cc:Subject:Date;
	b=fktGX8YPzQM6s9ktsujASuB9knvEpTMp84hJ2FKZX2he5oKrve9NrKHsXMdOpwZ1R
	 m2i2DS2hNssYRAAcOgdkYgYhZUPzUZdNKx9U1x1pQaXhq1j8oHM450AW7ZTioUHSll
	 EBgW965uPKFJjvuuZQRl6r+Dx0ujftwSMn/PENrIpygX5nPeQruzW9UmNOGshFusOH
	 ezFNTfDhJLrUvPAUTRFW69D+qqOeLdqoCYdQCO3w2fMYfMGL9m4jW65fv33d5HI2H0
	 /0bBTDYdaH1SfHKkoj+G+TadKBUL5rF3OULA+wgLE4nVYiShd5Y8ZjFqCik2JDCpjz
	 wCfWiHhmJGdiQ==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id AA67B27A366A;
	Fri, 06 Nov 2026 23:21:41 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: ethernet: mtk_eth_soc: 9K jumbo frame support
Date: Fri, 6 Nov 2026 01:53:57 +0200
Message-Id: <patch-2793186c653124c4c0b3d463bde2ea3a@loljews.com>
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

Patch 1 gates page_pool on the ring buffer size.  The pool hands out
order-0 pages and is created with MTK_PP_MAX_BUF_SIZE, so rings that need
larger buffers - the HW-LRO ring already, and the rings used for jumbo
after patch 2 - cannot be backed by it.

Patch 2 adds the MTK_NETSYS_RX_9K capability, advertises 9K max_mtu on
the XGMII MACs (from the DT phy_mode at probe, so DSA can raise the
conduit MTU before the netdev is opened), programs XMAC_RX_CFG2, derives
the shared RX buffer length from the largest MTU, sizes the RX rings and
programs the PDMA RX SDL max frame from it.  A runtime MTU change that
would need a different ring buffer size is rejected with -EBUSY while DMA
is running; the rings are sized at the next open.

This work is a forward-port of the MediaTek downstream jumbo series:
Mason Chang's "change default rx buffer length", "add 9k jumbo frame
support" and "add dynamic rx buffer adjustment support" (MediaTek
OpenWrt feed 999-eth-30/31/33, carried in
frank-w/BPI-Router-Linux), plus Frank Wunderlich's "try to fix crash
the right way".  The per-ring page_pool rule is added here to make the
9K path safe without disabling page_pool for every ring.

The equivalent change was tested on a BPI-R4 Pro 8X (MT7988, 10G lan6 /
MxL86252) on the 6.18.60 backport: with both ends at MTU 9000, 8K ICMP
passes and iperf3 with MSS 8900 reaches ~9.87 Gbit/s (vs ~2.57 Gbit/s at
MSS 1460); the DSA conduit is raised to 9004 at boot.  This v7.3 series
is compile-tested with CONFIG_NET_MEDIATEK_SOC=y and COMPILE_TEST=y; no
hardware run of this exact tree yet.

Changes in v2:
- put the page_pool change first, so the series builds up to jumbo
  instead of adding it and then fixing it, as suggested by Simon Horman;
- drop the forward declarations by moving mtk_set_mcr_max_rx() above
  mtk_mac_config() and mtk_max_gmac_mtu() above mtk_dma_init(), as
  requested by Jakub Kicinski;
- wrap three lines that exceeded 80 columns;
- send patch 2 as a reply to the cover letter instead of chaining it off
  patch 1;
- Cc the maintainers listed by get_maintainer.pl.

v1: https://lore.kernel.org/all/patch-4f863a941889f0bceca1c082f2d79624@loljews.com/

The runtime-reallocation patch is not included: it reallocates the shared
RX rings when the MTU changes while an interface is up, removing the
-EBUSY restriction. It is a larger change and will be sent separately.

Sandeep Haemoon (2):
  net: ethernet: mtk_eth_soc: skip page_pool for large RX buffers
  net: ethernet: mtk_eth_soc: add 9K jumbo frame support

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 185 ++++++++++++++------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |   9 +-
 2 files changed, 144 insertions(+), 50 deletions(-)

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.53.0

