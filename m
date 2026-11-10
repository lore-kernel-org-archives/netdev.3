Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314416;
	b=5actdsrr4hFySrsX8qqd7SZqoE/MOrrOPy7iiq3ikMLWT1yDuSZsSMXRa1gwZNlcGd/X
	 bPzBO2uXoKzaa3lDWI9m1A5qj5AovfMKuhbPJZXBq9WOVERvd1UaKvvWHA86ClMbmpXe9
	 Ggm3Q43nZs9PEU1AAEmm4zbU29QRmSzTSyaCrlrYCWCmKuhXmZfUzT8jPvtlrwSZ4UUZv
	 Z4ymOrdpMK5KKsuwf2i1CrzpFQ2dx2N8yDix/WRjXfgBTuJ5rg3sCfXxTM+HayLZpNE/3
	 3/D0TnU+nWFzrjFvnn7Uojyg0MhKPAjH5NflFP35gsWZAe+hkwWYUVeqcIeUjhIxMgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314416;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=2pKjOnB7thorowgyXI58dtDZeDUgnklgN0ioGos6ajU=;
	b=PYhPiV2FQYEyvQlvjFdat3D5Tkn61ZBnN8vwtH0YBJnJj8YS7vtMwqJ5F2FAEYXtK/78
	 5C9ZvFyI+tiaJrGj2KBO+j5MLsD2kzQ1Z7UjEgXEKiIHLnkeyi25Q4nE0aYj/cpEkEZmv
	 pRmlEImrIOGSmqlRQlKCmOIjCzdX5Ae+jR1PIxDf9/5f0I1cKvavFgrRqL8p3wRoLv/p9
	 6zCFcMdaQ/fDBP/KaOJuo5cQgNuZWEfN4uTkwREMVlN2LyeNLHIZ8JLiCMPEoHEK/toaS
	 IAcgID5rhLfEyUsBO76qO5ap0D1t9uKOxXI2oj7e5NQU5BJzgx/jKI9sPGEJDDIiriw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="eZa/Gow/";
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421B606A31C;
	Tue, 10 Nov 2026 12:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F421B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=eZa/Gow/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2p
	KjOnB7thorowgyXI58dtDZeDUgnklgN0ioGos6ajU=; b=eZa/Gow/VLJcjcx3V8
	ds2ts8qL4APY0xIP7xfxVbMvHiOqtuO8rprxUBeZBllnTbhBpK1d8CHNa1hoQlvT
	kDa+d8SjUNhXQe7EBBLopyntAylUxheakO1i8eVnUjSCMpS37kvLnMpvUm1AAm1B
	vw40mGMI4g+H0JpVy86J4xf+U=
Received: from 4CV529F122.company.local (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3X4hjEPNqevk+Eg--.59821S2;
	Tue, 10 Nov 2026 20:39:07 +0800 (CST)
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
Subject: [PATCH net v6 0/4] net: stmmac: fix RX descriptors and XSK TX on resume
Date: Tue, 10 Nov 2026 20:38:51 +0800
Message-Id: <cover.1794311618.git.dinghui@lixiang.com>
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
X-CM-TRANSID:PCgvCgD3X4hjEPNqevk+Eg--.59821S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFWfGw4xJry7Cw4kJry5Jwb_yoWxGrWkpr
	Z5Kan0yw1kGr18Aws5uw4xXFyrKa1rAr43WrW5X3yF9FW5Wr1aqr4akF4Yqa4DCrs7G3W2
	yr4UuwsrCF15Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j289NUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC9A224mrzEG159QAA3F

From: Ding Hui <dinghui@lixiang.com>

This series restores RX descriptor addresses overwritten by hardware
writeback between disabling NAPI and stopping RX DMA during suspend. It
also fixes an AF_XDP TX-only resume stall found while testing the series.

Patch 1 honors RX allocation flags. Patch 2 keeps unfilled XSK slots
CPU-owned and tracks pending refills explicitly, including an empty ring
and short refills. Patch 3 restores RX addresses from retained buffers,
rebuilds chain pointers and initializes descriptor control fields. It
publishes a contiguous XSK prefix and recomputes the tail and pending
region. Patch 4 restores the bound XSK TX pool after TX buffer cleanup;
otherwise zero-copy transmission can stop after resume.

The earlier commit 9c63faaa931e ("net: stmmac: re-init rx buffers when mac
resume back") was reverted by 00423969d806 after a Jetson TX2 suspend/resume
regression. This series retains existing buffers and DMA mappings instead
of recycling and reallocating every buffer. Jetson TX2 has not been tested.

Hardware validation used backports on our XGMAC platform with a vendor
kernel based on Linux 6.12.41, not these upstream commits as-is:
- Receiving iperf traffic from a PC while suspending and resuming caused a
  fatal bus error after resume in almost every run without the RX fix.
  The same test no longer showed that failure with the fix.
- Native XDP/AF_XDP zero-copy RX continued after two suspend/resume cycles
  with the receive socket kept open.
- Zero-copy TX-only, with no RX fill buffers, is tested ok after one suspend/resume
  cycle, with no fatal bus error.
- Pausing the receive application with SIGSTOP and resuming it with SIGCONT
  recovered RX without recreating the socket.
- xdpsock is used for native XDP testing.

Additional testing would be welcome for RX sockets initially supplied with
0/1/8/15 fill buffers, replenishment in batches below 16, and those states
across suspend/resume. These differ from TX-only with no RX fill buffers.
Legacy descriptor cores, GMAC4, chain mode, timestamp-specific descriptor
paths, multiple XSK queues and long suspend/resume runs remain untested.

Missing page_pool buffers are still allocated during resume. Allocation
failure returns -ENOMEM without restarting DMA and leaves the device
detached. This adds a trigger for existing resume error-recovery problems;
full close/open recovery, including NAPI and platform power handling, is
separate work. The Medium-severity AI review on failure recovery is not
fully resolved by this revision.

Changes in v6:
- Add a separate fix to restore the bound XSK TX pool after resume cleanup,
  addressing TX-only stalls found during XGMAC validation.
- Factor resume descriptor work into one TX queue loop and one RX loop,
  following Thomas's review, and use common error cleanup.
- Restore addresses and chain pointers before initializing RX control fields,
  preserving legacy fields and RIWT/IOC policy without a separate OWN loop.
- Add format-specific RX ownership clearing for unfilled XSK descriptors.
- Track pending XSK refills independently of circular index equality; retry
  short refills and prevent consumption of unfilled descriptors.
- Restore a populated XSK prefix and retain later attached buffers for refill;
  recompute the allocation count, initial tail and pending region.
- Select XSK buffer size independently of the initial allocation count.
- Discard any partially assembled RX frame before resetting the RX ring after resume.

Link to v5:
https://lore.kernel.org/netdev/20261025100636.613670-1-dinghui1111@163.com/

Changes in v5:
- Target net and add Fixes tags to both patches.
- Split the allocation-flags fix into a separate patch, with a Fixes tag
  identifying the page_pool conversion that stopped honoring the flags.
- Share page_pool and XSK buffer preparation with the RX refill paths.
- Allocate missing secondary pages even when the primary page exists,
  using the current baseline's buffer2 capability check.
- Condense the reinitialization kernel-doc to two paragraphs.
- Restore descriptor addresses before the final dma_wmb()/OWN pass.
- Clarify that unavailable XSK slots remain CPU-owned and may stop DMA
  with RBU, rather than claiming that hardware skips them.
- Power down legacy SerDes if RX descriptor restoration fails.

Link to v4:
https://lore.kernel.org/netdev/20260627122533.1165324-1-dinghui1111@163.com/

Changes in v4:
- Document the return value of stmmac_reinit_rx_descriptors().

Link to v3:
https://lore.kernel.org/netdev/20260604144557.3175399-1-dinghui1111@163.com/

Changes in v3:
- Allocate missing page_pool buffers with GFP_KERNEL and abort resume
  on allocation failure.
- Try to allocate missing XSK buffers and clear descriptors when the
  fill ring cannot supply a buffer.
- Restore OWN after programming addresses and rebuilding chain pointers.
- Honor the flags argument of stmmac_init_rx_buffers().
- Restore RX descriptors after stmmac_clear_descriptors().

Link to v2:
https://lore.kernel.org/netdev/20260526022620.501229-1-dinghui1111@163.com/

Changes in v2:
- Introduce a helper to restore addresses from existing RX buffers.
- Update the commit message.

Link to v1:
https://lore.kernel.org/netdev/20260515053856.2310369-1-dinghui1111@163.com/

Ding Hui (4):
  net: stmmac: honor allocation flags when initializing RX buffers
  net: stmmac: track unfilled XSK RX descriptors explicitly
  net: stmmac: restore RX descriptor buffer addresses on resume
  net: stmmac: restore the XSK TX pool on resume

 .../ethernet/stmicro/stmmac/dwmac4_descs.c    |   6 +
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |   6 +
 .../net/ethernet/stmicro/stmmac/enh_desc.c    |   6 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   3 +
 .../net/ethernet/stmicro/stmmac/norm_desc.c   |   6 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   2 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 277 +++++++++++++-----
 7 files changed, 228 insertions(+), 78 deletions(-)


base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.34.1

