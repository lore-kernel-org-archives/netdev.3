Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4E3E4C7A;
	Sun, 20 Sep 2026 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789896390; cv=none; b=ei0xCNwm11B38kVDpIZB2lpIG0gQCx6Jeno531DQlJc8GaR98GvdZ+6kClMQeZzl5eaXN7aSN7PsYtpP2ex16eakELvMp4ekY2TvMeOUfnm3OMKGZsR4R324jkDnRmgHVpEzV1PCpCyJHHtVOCWOoU80gWft3VEPfakmsRwQA5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789896390; c=relaxed/simple;
	bh=5FZu5nTEig9X5GjN9d6Nw/bmuaoxQsWrrEsQ/sn4sek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGXkj5KtlxpudcGMS/6UHMe5gaEoy3vk7aVDbTkFy40SdiYwg4gtyRtD1+f9XfHHMWM0ZcScFCtdOUK0InNCyGnCZSfOzkODG22Esny+5gR319MZR/JcTRzIi9I2FoACDe2J8d7h6xpe5ej3MKeAPfESZ/ECFFgvVQO3DX8tBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz21t1789896276t92ca99ac
X-QQ-Originating-IP: wU56/T/Rcf1+BNzir3f4n40khMIFoewP6rXn+GjsL58=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 20 Sep 2026 17:24:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10153193491633799778
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
Subject: [PATCH net-next v13 0/5] net: rnpgbe: Add TX/RX and link status support
Date: Sun, 20 Sep 2026 17:24:24 +0800
Message-ID: <B8AF0FDE24FAFB51+20260920092424.345309-1-dong100@mucse.com>
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
X-QQ-XMAILINFO: MtOZkMFAG5AcVVuS0hJuUrzWLcPcnz7Zl6kTaYAtzzczWySwxcMjNrUf
	mmpyH2Y0fKMmJzFNOjcPaBl3BW1oXm/NXr2GgQomuLuyq92BTR4oPYSrv8W2PZJRLq7tti3
	Kwecw1a6wbumxf+NQsTdK4NREyZtm745q9n2igsq9x4q9RM3OK7Y7PAMW9kLtSHvYtuAyhW
	xWwYS2p/Vv8WZdOMOQG2aKPPRHonzJrQEWmDXPOXRSuW9jhCGGDfApS1xZC3c66ut7aezZE
	VZbgN+9+sTtpASm9afN3XJkQq//MdVEiE0W+k/w9reHnOTQc+uENjrq8duvz7Eag9jJsUiC
	32P+zArXI5jNiNgsmqMLQA42OwExoQQUSTlWL/6kNRJ8wwnkqVToc2LzS3/jROG9QLw8lLZ
	ooFlWsFAVxqVpNGQLS1kl+34B2w3z7w/4BJkwASD+utLpjF0QZCRpcU/NTHmSUUMr3CBg1s
	op7qAuDtLBlgffkAi4T3PBLoj7vUYgW/e4Kde4/LjGHwl/qsmb3b5L4BxE6d4r2o3Z/BQv2
	8vYvEDtmDTHqvI+FoZPT3vsC9zgy/QvzSSKRbAtrg6QsZ/67fwqC3arFlZ0zOs1cnbGY7BV
	Cw5mVB/dEJFfmc0hZ9G87nXP1QaPObPVkii3eXhBBc3UndXBpf0aEy5eAXok4Jp81EHaBju
	nW6Fc7h/yG/JqmBM2l4F7Y9U/psGsbsb3PPMGZXUNlxI7ZqNBea6Vbi2lRDH2QUH3Hzl75f
	whQ+eu9OjT4tdW0Cfl82dManiEc+ef97KVybF2RISYDgPdoBZvfrZDp4jHTfE9D2XUL5LZD
	MwlKD9dXJb46yYDcDvIErR67pwgt2kB4QWYE9WLfOai+x3rypEvLnCGpEFLLrC94nO+6gI1
	6Zhb6/WgYHTuuCvI1lgGJZqMR+AY0Jppp7IDA+pOtIBcYEA0PhQqkG+zDp2YFjuPmn89Y5Y
	vWBbSxa3vJWlDxpGZXMUxESS5RZWFzP3JCc74GfAPIwFSAT5hymdPduyVIJv78ZgKQ1hLE0
	dg99I577q9BhMMuZUYlzvzWIBjSPjTTNg4yplTAVQGtl+odd9DxWKmnF1tmfqhrUSIFqsNW
	42yrkyy6Y+g/ToUqJC3TGe1coFSceuQnzdNCnid0VcRZ5LWa62AAgY=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
v12 -> v13:
[patch 1/5]:
1. Remove __MUCSE_DOWN. (Jakub Kicinski)
2. Move the NAPI shutdown synchronization from the patch3 into this
   patch. Mask queue interrupts before disabling NAPI, wait for in-flight
   poll callbacks with synchronize_net(), and mask the interrupts again
   afterwards.
3. Clarify that the mailbox workqueue is plumbing for asynchronous
   firmware event handling added later in the series.
4. Update the queue-count, interrupt-scheme, and interrupt-disable
   comments to match the current implementation.
[patch 2/5]:
1. Use WRITE_ONCE() when publishing and clearing TX/RX ring pointers to
   pair with the lockless READ_ONCE() statistics path.
2. Remove the unused mucse argument from rnpgbe_setup_tx_resources().
3. Clarify the commit message description of the hardware's 56-bit DMA
   addressing capability. Keep the dma_set_mask_and_coherent() return
   value unchecked, as the DMA API documents that masks wider than 32
   bits do not fail.
[patch 3/5]:
1. Clarify the initial RX ring fill and allocation retry timing.
2. Document the sticky AXI fault return semantics and the RX resource
   teardown preconditions.
3. Move rnpgbe_clean_rx_ring() before its first caller and remove the
   unnecessary forward declaration.
[patch 5/5]:
1. Update the GMAC link state before acknowledging firmware link
   events, keeping mailbox ownership throughout event processing.
2. Coalesce a pending level-like link event before sending port or
   link-report commands, avoiding collisions in the shared mailbox window.
3. Remove the unused periodic link-service scheduling and run the
   service task only when a link event is received.
4. Distinguish an empty mailbox from reset and other mailbox errors,
   report actual failures with a rate-limited warning, and document the
   firmware mailbox lock and acknowledgment protocol.

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

---

Dong Yibo (5):
  net: rnpgbe: Add interrupt handling
  net: rnpgbe: Add basic TX packet transmission support
  net: rnpgbe: Add basic RX data path support
  net: rnpgbe: Add receive mode support
  net: rnpgbe: Add link status handling support

 drivers/net/ethernet/mucse/Kconfig            |    1 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |    3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  201 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  137 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   43 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 2221 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   84 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  162 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |  181 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |    4 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  283 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   60 +
 12 files changed, 3344 insertions(+), 36 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

-- 
2.50.1

