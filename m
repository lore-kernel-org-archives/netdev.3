Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3896408612;
	Fri, 31 Jul 2026 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785499473; cv=none; b=QW0UuzJafm9H+x2uRFx2lFqE7sgZoW/PJcPRutg2bVVSYuVUof+KOtHngollfqO0q0n2b0WnZTrUwY/udrt2R5f8G65rx5jNoL9u+WFlm1gWN3PA4yKbu1iWoDRwrC1Jb8BfU0X2e4HXVJwSurUDzr46xALTVs1vUxWt6IdRRR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785499473; c=relaxed/simple;
	bh=vCCaYJfVXgfaP03VuWr8no9eupftF/l7FUp6Pnb/RyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TFjidhE7HXwUqojZG9q+9nPOMRp+vum1kiE26jSmYyTDLZ4HWIgZVFJ8ILZXxp+tN3MBd4fjTwHebeZEwB/I7p565pqilQykna9GGnJPBYLg4JOEucCd8geE2nOlLXidjORXL1/ROCOwicCpLVfO0sn/NaTf1/XJxCaQzJSfTnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz14t1785499413tb67c1059
X-QQ-Originating-IP: CYAi7jkxMNUy94euMU5Uv8wkj2Ry3aEnBuQLR1ghqCQ=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 20:03:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11751310261211007002
EX-QQ-RecipientCnt: 10
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next v8 0/4] net: rnpgbe: Add TX/RX and link status support
Date: Fri, 31 Jul 2026 20:03:18 +0800
Message-Id: <20260731120322.895955-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MVzjU61Pu/QvPBc+jj+/yJ5GVt2Wk369hp7ADlpQybH6DeaJRh14UhON
	KesMkcbT0FCLAbDCBa8zk8GFEpWX1/xQPHrlOXhN8hJueXYJTNKH4aNDbp79mqlkXg3e9jF
	oXAagHHHaKZcHB5eAMfjJGcQCdjWw8BYIJ1APHthIy+3AftTop/F7prYlMXRL6Gg5Agy18v
	8A9kT8oYHLMWkALL+zb4W2kNCHArBhTdT5JmqYyoqkncq3cfZfmQuP72YFxs+Mpz7Q2tCFS
	g6jIEOBgF/1uF7W8OePk2SSr0pB9udd/i9C2EuTmvOgjvbYUgPlypHhuudo3rbCNs/0sWvz
	QThD32OaMjtsR78bU6X5u39/5kogOy8OlXCz+iIW3oY1d7u1IHVkBV5nWTSzW0tH4w7UOsJ
	eHhmJGyUWuAxe9gLBTLbMuTLchVKBbj83mZKnjoKQ6HrWDKYxHaupgtKpD//cwZmeNubvSe
	aYq21es6bmKNdNSSjHDwXhpvev9qSDXgQ2B49S/Ir3PtBuXzsDB6p5kzadUyODYwUt04Hor
	XpmSMt188RMX5Wn5EtGoqmYZDOV0A37MlyHGaSWJOKvsCEE5e5MnvXqRLmF7W5LdG/ZDYTs
	uuVHSDOhJyNXD4z9TlaW2mj45OI9AKQTVyAnkOtqteJ716bLuRrhgPQH9JA7MmcFna4r/Ga
	ykB69bNRxp7OaWaeEHUISTSAROrAfLksIabwhItZoZl5SlSzUvOWcWwEhZ3WrD3OrfU246C
	wGRtL0PNg8NuHY1UyqbgJ1A0tVg8gAvPcW9IB17A4EZCsUlCW45p3ZTMmjCgHHE7y3NC4sl
	HJFtnT1po3HoJOraNPXcfBFT7E8RT+73bA68pODPQrzAUTind0vXt/8v7dmRq4svhdHfJgN
	Y+356bXMDzmY4exg8xiETkmuwfxxCU/et0yiizxE4i7siACCCiXxlW5JWDRAODDER+gKnsP
	SHgDX/4NF5GETvU1qkbnYB3ZRbFK1SptNhk2uOce6usUXUb2NjZ28XGTqVQFnJrOkRMnKqv
	g/GWOz9lElrczXDtnvDH24qgxHqsYh9bLXG10AAHhpe/LDtZJXLni+IwSdO/TF+MebWr1jA
	ksXO8oPaFyN
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series adds the packet transmission, reception, and link status
management features to the RNPGBE driver, building upon the previously
introduced mailbox communication and basic driver infrastructure.

The series introduces:
- MSI-X/MSI interrupt handling with NAPI support
- TX path with scatter-gather DMA and completion handling
- RX path with page pool buffer management
- Link status monitoring and carrier management

These changes enable the RNPGBE driver to support basic TX/RX
network operations.

---
Changelog:
v7 -> v8:
[patch 1/4]:
1. Update kernel-doc for rnpgbe_poll. (Sashiko-nipa)
2. Move mbx-handler from hardirq to workqueue. (Sashiko-gemini)
[patch 2/4]:
1. Add fallback for dma_set_mask_and_coherent. (Sashiko-nipa)
2. Move the posted-write flush in rnpgbe_irq_disable_queues()
   to patch 1.
3. Make atomic64_read outside eth u64_stats_fetch_begin/retry
   loop. (Sashiko-nipa)
4. Fix comments in rnpgbe_clean_tx_ring. (Sashiko-nipa)
5. Fix the duplicate call to rnpgbe_clean_tx_ring in
   rnpgbe_close. (Sashiko-nipa)
6. Remove the redundant netif_tx_stop_all_queues() call
   before netif_tx_disable().
7. Use modulo for ring->next_to_clean in
   rnpgbe_configure_tx_ring. (Sashiko-nipa)
8. Set 'dma_unmap_len_set(tx_buffer, len, 0)' for all tx_buffer_info[]
   slots. (Sashiko-nipa)
9. Remove duplicate define RNPGBE_DMA_INT_TRIG. (Sashiko-nipa)
10. Optimize delay when stop rings. (Sashiko-nipa)
[patch 3/4]:
1. Fix comments in rnpgbe_clean_rx_ring. (Sashiko-nipa)
2. Move atomic64_read outside eth u64_stats_fetch_begin/retry
   loop. (Sashiko-nipa)
3. Use modulo for ring->next_to_clean in
   rnpgbe_configure_rx_ring. (Sashiko-nipa)
4. Fix the duplicate call to rnpgbe_clean_rx_ring in
   rnpgbe_close. (Sashiko-nipa)
5. Fix NULL pointer in rnpgbe_alloc_retry_work. (Sashiko-gemini)
6. Call alloc_retry_work if rnpgbe_alloc_rx_buffers fails in
   rnpgbe_configure_rx_ring. (Sashiko-nipa)
7. Optimize the delay when stopping rings. (Sashiko-nipa)
[patch 4/4]:
1. Clean the link status before sending the port-up
   notification. (Sashiko-gemini)
2. Remove the unused irq_en state and completion-based reply handling to
simplify the mailbox code.
3. Move netdev_info() after releasing the lock. (Sashiko-nipa)

Links:
v1: https://lore.kernel.org/netdev/20260325091204.94015-1-dong100@mucse.com/
v2: https://lore.kernel.org/netdev/20260403025713.527841-1-dong100@mucse.com/
v3: https://lore.kernel.org/netdev/20260507081539.171844-1-dong100@mucse.com/
v4: https://lore.kernel.org/netdev/20260526033539.164061-1-dong100@mucse.com/
v5: https://lore.kernel.org/netdev/20260528023150.239532-1-dong100@mucse.com/
v6: https://lore.kernel.org/netdev/20260604112750.769215-1-dong100@mucse.com/
v7: https://lore.kernel.org/netdev/20260611100036.36370-1-dong100@mucse.com/

---

Dong Yibo (4):
  net: rnpgbe: Add interrupt handling
  net: rnpgbe: Add basic TX packet transmission support
  net: rnpgbe: Add RX packet reception support
  net: rnpgbe: Add link status handling support

 drivers/net/ethernet/mucse/Kconfig            |    1 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |    3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  200 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   45 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   19 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 2204 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   87 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  116 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |   32 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |    1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  206 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   45 +
 12 files changed, 2935 insertions(+), 24 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

-- 
2.25.1

