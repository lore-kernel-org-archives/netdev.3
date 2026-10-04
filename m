Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6C1343882;
	Sun,  4 Oct 2026 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791097064; cv=none; b=p9HmEtpntWdpLLtD+KWQAsOnpi30RPU4k+vEDon2yLahh7QwfWV5FGn0k9rzGVqJ0pcWoyKPcGjiEADW8y9PaR0JBQiBynO+A2AnBBJp9I36GFGBKbB6gwlqf+6QbQZBZPnUnr2KzvaNCegDEjZaKTLtUnJ8TwDaubAlViWhFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791097064; c=relaxed/simple;
	bh=qMKTeX6QtXNBVgXx7Zs6dfhOPvBtw5YVSWO/dUNU3+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FW/wuyzPQVW1hZ9uV92qmhSajYsncze+rKBsvOyxAIsBNwvq8LolfkSbXAo6EyeTfDeVyAW7i5vgnFZqZMm91Ovd7EZmeNsWliahJLAApZntJdGZNUhY8m58DlhtxlsOCinSpKx25cOBuVTtMoNdd1NmYMlAVlnvbOYyEH6aPbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz10t1791096970t10344664
X-QQ-Originating-IP: nJOR0frfwbGnqrdfnzE1aYjnJ2R8q/MNtkEsBs/YjUs=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 04 Oct 2026 14:56:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1219953670316839340
EX-QQ-RecipientCnt: 11
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next v15 0/5] net: rnpgbe: Add TX/RX and link status support
Date: Sun,  4 Oct 2026 14:56:04 +0800
Message-ID: <B438B0A83ACCA2DE+20261004065604.224873-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Ml+nSbudC4cFn5V7GcE68rimTl9hs1oBTR/nO/m2q8saddUlLX/5Jb6+
	z+CDICfkO7Axh+ywv/m1I5VbfYTcbc0VvP3rwrmctn/db20b3M2UE4tYq1yDEGtD5/BgND+
	Ir8t3buk3tWJ8pE1vnMrIiQcudIXXdzgOOxFGoIihkIY79jBPDND7xsS7y3DduA7zc0y/Ly
	y+OsqlmTgO+Y8Nn8lo7+3R34GUkHNrkoWLoY8rY1xAMjHojmoris3N3X9Rmp01jlfgKM3mD
	ciLBldnEA+ZxjyX5UWFksUys7ds0lqdMGI+voRqkhGKkl6InvrTR/UB4hANfwBQzGIru2Wz
	pIpBNuwMwKaXDICzpNjiyoquiymoqgZmxCJqA3qDjE2sSisIMQ9ipoqOqmOYMJ6vZmseTLF
	v9CxDDmIOUIF1X+o3Qa/L/sh0lcirvbuE/XjV7UYkq0+kxdAKZabSLdvu+HXyAcQKfZMbOr
	sKxPweln3uKfWNtww0KzZHuhMeAUeH3sJ8tsmebD7P+PExbxcTFlDlUE/L0O8HvGJf3EbGc
	b9L9Vir6cYqJar+h0v+lhPuLQmd941UW0S+ECXp+fAWTcfH6XVUiS5Zfli8bb/aZltDMYYC
	/KZhihpxV/UtkuClvDtqrq6nn/51uHYE4KkTyKx/tumwRbWWq+qAE0qCrwLv/ZVys2RrFS1
	fFjb2M7KHPuC7sdaOOSKG7ZftjVntxsYtZzf6Hdwp0FnvD9nWfHkw0pQj14Bg6Lm1tnaxxG
	+Hq65vsOS03P3S4dkwIUAbU1fJwDxjj6aO0g0dlfPRGmeDcG91MOFkeLfGRte8WNI2No/+B
	1hKUXQ+N6Rmy3xlM+i647FmV2x3MFttowg0eMk1vJO8EtyiaxBALCT59xfVL75ObIv0htxR
	DyrLJdksJPZ1KNlDma02QFhBJo12vlbQMaL37+/mxo5nMjTRCSf7VTRptPVqaMMFUX9p2Op
	KmbygMkaKbMe0nv/PxvvYISvUEgyHtFnLlIVnfuXZ0WIiZE58AxijhlNDqRIw1/YewyzBwO
	24BQ95VJQ7Q12fVyg2N4KWwerxi/tEFi+8qzTuFKi9Je8hjdNy4c1D5ybHn78=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series adds the packet transmission, reception, and link status
management features to the RNPGBE driver, building upon the previously
introduced mailbox communication and basic driver infrastructure.

The series introduces:
- MSI-X interrupt handling with NAPI support
- TX path with scatter-gather DMA and completion handling
- RX path with page pool buffer management
- Unicast/Multicast filter.
- Firmware link-event processing and carrier management

These changes enable the RNPGBE driver to support basic TX/RX
network operations.

---
Changelog:
v14 -> v15:
[patch 1/5]:
1. Update the interrupt helper documentation to describe the MSI-X-only
   implementation instead of implying MSI or INTx fallback support.
2. Document in the commit message that mailbox transactions run in
   process context and use sleepable polling to acquire the hardware
   mailbox lock.
[patch 2/5]:
1. Document that carrier is kept off before register_netdev(), and is
   enabled only after a valid link state is reported by the later
   link-status patch.
[patch 3/5]:
1. Clarify that rnpgbe_is_non_eop() may consume and free the skb when the
   fragment limit is reached.
2. Avoid retrying a failed RX page allocation for every descriptor in the
   same NAPI poll. Check for pending refills after NAPI completes and use
   the per-q_vector timer for delayed retries.
3. Report invalid RX descriptor lengths through rx_errors and
   rx_length_errors instead of rx_dropped. Count at most one length error
   for each complete packet and protect the counter with the existing
   u64_stats_sync sequence.
4. Set the page-pool DMA synchronization window to start at
   RNPGBE_SKB_PAD and cover only RNPGBE_RX_DESC_DATA_LEN bytes. Use the
   same range when manually synchronizing reused pages.
5. Schedule the initial allocation retry only for batch-sized shortfalls.
   Leave smaller shortfalls to be replenished when traffic frees a full
   refill batch, and update the comment to describe this behavior.
[patch 4/5]:
1. Avoid transient receive-filter gaps when updating RAR and multicast
   filter state.
2. Switch the receive-mode implementation to ndo_set_rx_mode_async while
   retaining synchronous filter setup before RX is enabled.
[patch 5/5]:
1. Avoid a GMAC_CONTROL read-modify-write race with firmware during
   port-down by leaving GMAC receiver disablement to firmware after RX
   DMA has been quiesced.

Links:
v1:  https://lore.kernel.org/netdev/20260325091204.94015-1-dong100@mucse.com/
v2:  https://lore.kernel.org/netdev/20260403025713.527841-1-dong100@mucse.com/
v3:  https://lore.kernel.org/netdev/20260507081539.171844-1-dong100@mucse.com/
v4:  https://lore.kernel.org/netdev/20260526033539.164061-1-dong100@mucse.com/
v5:  https://lore.kernel.org/netdev/20260528023150.239532-1-dong100@mucse.com/
v6:  https://lore.kernel.org/netdev/20260604112750.769215-1-dong100@mucse.com/
v7:  https://lore.kernel.org/netdev/20260611100036.36370-1-dong100@mucse.com/
v8:  https://lore.kernel.org/netdev/20260731120322.895955-1-dong100@mucse.com/
v9:  https://lore.kernel.org/netdev/20260814111317.1741087-1-dong100@mucse.com/
v10: https://lore.kernel.org/netdev/F44E6669E6C9E7C4+20260831073608.401988-2-dong100@mucse.com/
v11: https://lore.kernel.org/netdev/745DADAC2A5786BD+20260911112416.2142101-1-dong100@mucse.com/
v12: https://lore.kernel.org/netdev/64BE41C2D2C0836A+20260914013019.2262317-1-dong100@mucse.com/
v13: https://lore.kernel.org/netdev/B8AF0FDE24FAFB51+20260920092424.345309-1-dong100@mucse.com/
v14: https://lore.kernel.org/netdev/0A4D45AD9F6A0F14+20260928033701.1033196-1-dong100@mucse.com/
---

Dong Yibo (5):
  net: rnpgbe: Add interrupt handling
  net: rnpgbe: Add basic TX packet transmission support
  net: rnpgbe: Add basic RX data path support
  net: rnpgbe: Add receive mode support
  net: rnpgbe: Add link status handling support

 drivers/net/ethernet/mucse/Kconfig            |    2 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |    3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  210 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  167 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   45 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 2258 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   88 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  208 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |  179 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |    4 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  283 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   60 +
 12 files changed, 3468 insertions(+), 39 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

-- 
2.50.1

