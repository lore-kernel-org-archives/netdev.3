Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6CE32860B;
	Mon, 28 Sep 2026 03:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566709; cv=none; b=h+6A/iJgsl/nPYtPMRnwM17YeHBFeYeZ3JsY41RwDT3bPjmHp4D+fR37nY0mjfhCY65xSXce8NV59ChM7sKe36EP8xjQIQgs639bKeEvoKwf+v6lqUZpjmzIaTqgNGI1K6szBkfbqZlhNdhMeciipGaycZQ2jaBXTE1nvyyqVOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566709; c=relaxed/simple;
	bh=gOujhOZIxL8MNYt810rybWupzWOSUqMEhzh9HDJBoiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S8nPJRkReZ1Zwt+sAcdO5NLIUe4ztOiNhpVURXy7lfLMCet7UGrtttVfXNuAgx9YGZmBm0v+edD7G3bRXgXZU2dFHREjY4Eds2HZG6K5tEtWFnmH/F2pU8fvk6raHyOCjTYEWk6gPLnlzjOJR2BGKB9HFyzzs3UMBddvLMPbr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz4t1790566629t10ee91f0
X-QQ-Originating-IP: xORg2FphBQ6uW94GOiI1w8Y766hLM7kBaXCyjMbo4r8=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 28 Sep 2026 11:37:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15633199245767454811
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
Subject: [PATCH net-next v14 0/5] net: rnpgbe: Add TX/RX and link status support
Date: Mon, 28 Sep 2026 11:37:00 +0800
Message-ID: <0A4D45AD9F6A0F14+20260928033701.1033196-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: ObIi6OEmoc4o7l2wYtoue+Llj/zIreB/1X4YKO7/h3UnqzUzLXNTuroP
	WnQELJlxECoFsBaDKu9YvFs+nfPcBq8pN73ufDSb3O8puTDjEQ3/lalLhTVqm5AibGwi7Uq
	yM6dZh8Wv7gRxTlVIeq4Z1GM74ckI8bphdsZa4SP9KfjpRI1JSiqYuIU64DoVHlAtprfQv2
	ypBm767CZJ9AL0vIxVuQd4qJ4gjA8RsSzMILTm/PbvYjaLM+wb0qx8RxtuXIxxbmh7NY0QW
	Azw3ik32fE8EuZe4yRu1lOK7ei6Qs3CBRgqX46Nn9nocmSILtMar8rxmAaUxzm+iHIfCrB2
	0k7cARs20NouOybs5tc2OtsGwHejC2yWHigPqiJtFupuGc1OXrwDyeJ/+HDHABPv2qUiPO4
	hSltIrJQOQ8GvP7VLkd+lO6lDLoRxk7oZpwY0gtIuLlzNyU8mewtYVjEb2cWhDbSuOOFTEH
	4dc35ZvazpLhLrrKzl/y/jxelwJStVSapnfOMlLIKJKsnbwLnDrM8wg9iBdXuoIJSpOgCuZ
	nOIofyIYUaiDcrHttGVlvIwfWTaoXhx+JcLNbyVc5Eed+m2jq0HtIVmRx1vioHGp4sxKB/W
	1gLRwLPCaGjuF1g5bysoogMYTikvY3/vaq2ENgGaf3u+eyZkm+GXKiHdJL1Y3TMDlQ23b3G
	4fCw4xLqsk3ItLUU/I+aAf1YwIggdzRL80QVy7fCRi3A7COK9UeQqTTjXKlmARmpI/KDw/9
	O+pIcZAJwK1Yhhq9xgMtcDmdZuTOhO4KM6I7YFxuPEgUN9AJINgjDf63OYEbokx2YAT/ucH
	TezdCiLUvrDgsWiWP8ryqbV2Hfzvaw6Z9dxkJaT2VIRWbTJkBx4eYW75sPcZ29aUs8+45uy
	AMRaHBSUVoyk5MmXBeHRHkYoQ9c33vTjHWqADjI5XsP6tKtP/1OQ130TRfqxrBe6j4HE8gx
	oF2y3hkxlsFa0JNFM5bsQI3wfUSywJJqXyD3WgG2y1ld9XclGzInIS2Vn0TO6ubpizEFCNo
	mUOzSFfz0DyZ43y8GPaJX4TXISXoNmDbhoXYDQX0pEaOEtq39EsLbMGWZGojmXmzwjnA+iR
	g==
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
v13 -> v14:
[patch 1/5]:
1. Add the missing PCI_MSI dependency.
2. Make rnpgbe_irq_disable() static.
3. Make shutdown/remove teardown idempotent by tracking mailbox IRQ
   ownership and avoiding mailbox or PCI operations after the device
   has already been disabled.
4. Include <linux/bits.h> directly from rnpgbe_lib.h.
[patch 2/5]:
1. Make rnpgbe_hw.h and rnpgbe_lib.h self-contained by including the
   headers that provide their macros and public types.
2. Reserve only the two TX descriptors needed to keep the ring tail from
   reaching the head, since the current TX path does not emit context
   descriptors.
3. Set carrier off before registering the netdev, preventing direct TX
   from reaching partially initialized TX resources during ndo_open().
4. Store TX queue statistics in adapter-owned storage and make
   ndo_get_stats64() independent of TX ring lifetime.
5. Remove the now-unnecessary ring RCU handling and free q_vectors
   synchronously after NAPI removal.
[patch 3/5]:
1. Ensure the Ethernet header is linear with pskb_may_pull() before
   calling eth_type_trans().
2. Validate RX descriptor lengths against the programmed 1536-byte DMA
   window instead of the page buffer size.
3. Include valid packets dropped inside the driver in rx_packets and
   rx_bytes while continuing to report them through rx_dropped.
4. Extend the adapter-owned statistics model to RX queues.
[patch 5/5]:
1. Serialize driver-side GMAC register updates with link_lock and
   document the firmware acknowledgment ordering for GMAC_CONTROL.
2. Add an explicit link-event readiness state so firmware events cannot
   enable the receiver before the data path is ready or during teardown.
3. Protect the pending link state with link_lock and cancel the link
   service work during mailbox IRQ teardown.
4. Disable the GMAC receiver after RX DMA is quiesced and firmware has
   processed the port-down notification, but before RX buffers are freed.
5. Document that firmware reserves mailbox request counter zero for
   reset and wraps the counter from U16_MAX to 1.
6. Use M_INVALID_ST for invalid link speeds so firmware retries the
   report without confusing it with a valid link-down snapshot.

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
---

Dong Yibo (5):
  net: rnpgbe: Add interrupt handling
  net: rnpgbe: Add basic TX packet transmission support
  net: rnpgbe: Add basic RX data path support
  net: rnpgbe: Add receive mode support
  net: rnpgbe: Add link status handling support

 drivers/net/ethernet/mucse/Kconfig            |    2 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |    3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  207 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  145 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   45 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 2257 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   88 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  205 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |  179 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |    4 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  283 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   60 +
 12 files changed, 3439 insertions(+), 39 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

-- 
2.50.1

