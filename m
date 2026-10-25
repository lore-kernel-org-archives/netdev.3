Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792922926;
	b=CQL04XDTYwc2r5m5tXwGtSmkd/hEM++HmV6RFuln9eLX1N8wpVRJ9ezV7jAJwsHE935D
	 V/PgTgasl7WysEX0CEKpwlfFnwCsU1jik88GgO9cbDlrRY/Tb0KcwFic16WZ+nmbkzRww
	 F/k965vbkYJB8oRSQYBj+3OupoI5hx3mpF1ZN+ucMvigoPcRA0V7C3Ssl5wx3FImpgdGx
	 BjztjkS5db0hWUH/dh7cWVh8Ry7WnXpTcD8KKtVE0oSQsxY7QxS8QE8nv732cyNwSAPYT
	 lPVmxsKJ07ISa/ZebiXYfzWj+GYA70r+xLbqlnYzgEzI3LT10nAfsm71X4MCZoYDlAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792922926;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=ERZR5jPccvo3d9kJQynA8g8Qib1muJ8RwObTD5dMpYU=;
	b=3Xbvq10rVTG3OUe+E2/8KwmdJfnCpJAS5grs069vosaeybhMCXWgucp7SmKyAXhixef6
	 PN4PYJaLuMUZv6GwIrpufy8JahZqcC3+RzRosXjkOeEjLjPcJMte8IxC2WfuvZ0+HeYcA
	 8B8DL+2gozDnvCzXI7yseoFS0kItADycs0JQQoSG9CswvJ1ndzvdkr+xtFHGhWfwqN4el
	 WBn/Ed7ZmMJ4HCwt7JI+mmh4iCs+wjElgWQY+nMGg3ukV8+Eq5RajGqQhu9X0HJgE/U6O
	 LebML4Y8s+B9EG/+hatxU5QG3EAOrRw37i5odIrtRN7LA04+aGSfPLr2yyc0J5rC3Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EpRGsXKH;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1CC606A31B;
	Sun, 25 Oct 2026 10:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E1CC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EpRGsXKH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ER
	ZR5jPccvo3d9kJQynA8g8Qib1muJ8RwObTD5dMpYU=; b=EpRGsXKHNQiWf09er5
	fn++rTWt/yDaRGjh78dTM43gQOikzH2At5aooPhz45nunfxlYHb6Zdp0mPfa7bOl
	ASgwg+Fkdlx4hDJGFpdND30g2ZrB2oLHLnVzMrrf7Aok5wd2imN2oKAXSmkrEG2d
	UJepCeFIuHQYAmRSdPCZ+EQag=
Received: from 4CV529F122.company.local (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3_26u1N1q7fwbCQ--.3918S2;
	Sun, 25 Oct 2026 18:06:58 +0800 (CST)
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
	liuxuanjun@lixiang.com,
	zhoujing3@lixiang.com,
	fujiahui@lixiang.com
Subject: [PATCH net v5 0/2] net: stmmac: restore RX descriptors on resume
Date: Sun, 25 Oct 2026 18:06:34 +0800
Message-Id: <20261025100636.613670-1-dinghui1111@163.com>
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
X-CM-TRANSID:_____wD3_26u1N1q7fwbCQ--.3918S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFy3Xw15trWUCw15CFy8Xwb_yoWrJFy8pF
	WSk3yYyr4kur18Kws5Zw4IqFySka1rArW7W3y0q34Fvw45WFy29rW2kF4YvFyDCrn7G3W8
	Xr4j9anrCF1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jLeOJUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC9AN3o2rd1MM3zQAA35

From: Ding Hui <dinghui@lixiang.com>

This series fixes RX descriptor buffer addresses that hardware writeback
may overwrite between disabling NAPI and stopping RX DMA during suspend.
Restoring these addresses before restarting DMA on resume prevents a
fatal bus error.

Patch 1 fixes the ignored allocation flags independently. Patch 2 shares
buffer preparation with the normal and zero-copy refill paths and restores
RX descriptor addresses on resume. Missing primary and secondary pages
are allocated with GFP_KERNEL; failure aborts resume. Unavailable XSK slots
remain CPU-owned, and all address writes precede the final OWN update.

The earlier fix, commit 9c63faaa931e ("net: stmmac: re-init rx buffers when
mac resume back"), was reverted by commit 00423969d806 after a Jetson TX2
suspend/resume regression. This series retains attached buffers and their
DMA mappings and only allocates missing buffers. It does not repeat the
recycle-and-reallocate sequence of that fix. Jetson TX2 has not been tested
with this series.

Reproduction and testing:
On our hardware platform, run iperf traffic from a PC to the platform
(the platform is the receiver), and suspend/resume the platform while
traffic is running. Without the fix, a fatal bus error occurs after
resume in almost every run. With the fix applied, the fatal bus error
was no longer observed under the same test conditions.

This comparison was performed using a backport of this series to a kernel
based on Linux 6.12.41, running on our hardware platform that integrates
a Synopsys XGMAC.

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
- Link to v4:
  https://lore.kernel.org/netdev/20260627122533.1165324-1-dinghui1111@163.com/

Changes in v4:
- Document the return value of stmmac_reinit_rx_descriptors().
- Link to v3:
  https://lore.kernel.org/netdev/20260604144557.3175399-1-dinghui1111@163.com/

Changes in v3:
- Allocate missing page_pool buffers with GFP_KERNEL and abort resume
  on allocation failure.
- Try to allocate missing XSK buffers and clear descriptors when the
  fill ring cannot supply a buffer.
- Restore OWN after programming addresses and rebuilding chain pointers.
- Honor the flags argument of stmmac_init_rx_buffers().
- Restore RX descriptors after stmmac_clear_descriptors().
- Link to v2:
  https://lore.kernel.org/netdev/20260526022620.501229-1-dinghui1111@163.com/

Changes in v2:
- Introduce a helper to restore addresses from existing RX buffers.
- Update the commit message.
- Link to v1:
  https://lore.kernel.org/netdev/20260515053856.2310369-1-dinghui1111@163.com/

Ding Hui (2):
  net: stmmac: honor allocation flags when initializing RX buffers
  net: stmmac: restore RX descriptor buffer addresses on resume

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 190 +++++++++++++-----
 1 file changed, 138 insertions(+), 52 deletions(-)


base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.34.1

