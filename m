Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372E3B6C1C;
	Fri, 14 Aug 2026 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786706090; cv=none; b=O3ifsvC9CLmEsdajeiWYmcGA4CXADz1lSY4kLlKzdetKtgZWt5UeKlgTEZaMCLhHN8cTwC4v3ZqU+LxHQVaT33G76pIjGqVyMWERdRa1/4a7kLcwcFFKInXLSisGb5GZGUjR/a0ofZqjh/zHHZBbQR4cRQqRiMqbz9nSzqrrpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786706090; c=relaxed/simple;
	bh=yXI1Skm0SYGOiPM7dM/ilapcquqNyA2Kg0BdR+BMuPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJdkbhVcbo7B8SijvWpOcJ8XQASuff5viKRLB5XPuM9+zAL32/Is4+epggk0bRhnfcddlWjP6kINMC5pyFZX+yn35XypiHE7JffUWSP/bboCGKZlTN+S9yyiqYHghf2lCmaway+RTlabM5YeYFHY3Dahk8n9wgvbv1m3Am7bKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1786706011tbb4e26e0
X-QQ-Originating-IP: QoR5ZQbZgkgPATOPBIHkdD4xw+P1vWidXwJTbgtSWUs=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 14 Aug 2026 19:13:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13407255322965497549
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
Subject: [PATCH net-next v9 0/4] net: rnpgbe: Add TX/RX and link status support
Date: Fri, 14 Aug 2026 19:13:13 +0800
Message-Id: <20260814111317.1741087-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MShfLn39PbN2Jn574Rdnk8oPpRybFA8KDHhgcaNeQ1T7gDcjOwzfRDQZ
	UyE2ddHkQxvJXp+GBhSQsExI/flZ8vMJn87FzS0p3VcOvJIIJBksH/GUGgHBA4yXUU9+PpJ
	D6SHCm0cLItL3VmO+XoQr4c9ZdAtr9VXMW2cX/cFobI094oe/ZEh0BniL/DDlLcl2DkvA+K
	hibrJOLdAMYQWazxN9ZwatJD+h/FQlcwUTJ4z9FeYSmyG60P1Wcj+Mw1AZvoF5GPFkE+WKq
	hME4E2iaPJyD5W3edBSuWoE4RFTafsLPymj0sxEAfHcx3O5GlE4KDtvfFHdd5zpiBigamUn
	QPsf9vdKJ/IyU629m40/IytKdS88EiBOTNcgs+ZIkZkDvKJ7rgmVYCpYz55WruDvmt829Bz
	cjBywC1jKarKEWQETbuWP51e7MsPIWjZwXgvzLox9Pe/3LC0cbNuUiVDJ9gkdKE5iYE5nj6
	zjD36b9OL7lgYEAvnUAm8XlhyG1MzOSGHcYgbeS6NxJ/cd8j/jtoI9VrS+iuPrrEb3PyZ1L
	xJKodsdwi4/V7easaeooFM72cFSfVL7hpfL7b9sELcPYsG2x1+2SCq3vNCWihX1NDw1png3
	gdD6I8lC3xTdwu4ih8Or+E1ojEVfCzuY0zQRRxsW7nNQFAjCoKS0Yh/7LyIpRrF1WVON49t
	/Ea2lxFM2NcrjT90aYPN1+40LVZAF5a9BqAptqz2AqmvPXT/HFwE9grAbFuIlz8JTQdL73g
	RUM0/b7bIW+7y7Uj31Cr4kDFjIZ0r2FKm6mkxROhdyZZOEs+KOCcpmkMaMZZl/DyDiHTy8Y
	Dbyq4hYdK3cSzjf/XRi70YHC/9A0dmyVvVEjaJLzRNHuZcwM3CMtJ+q2RpmWm43nPpUePxK
	zu3Tw/6XxntCdRf7io3nuAL9td4HyAmudDDhvKarcFgjB1hwJNMJQXW0R4mPiO49Bimtv9G
	vlRB7+carT6KELku//71srUbHoXUfFfficM0mbMFuHwVJ24b5WWAy2Pi/zcjjLT6r9klgpN
	kcuf9tLo+ABlggetp8X6K2oPs3Qrl4DL+CHGSrA/G8ANrire99JXpJxZjYPs2eVI+qO7jcQ
	/ZEC/K1+SZK
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series adds the packet transmission, reception, and link status
management features to the RNPGBE driver, building upon the previously
introduced mailbox communication and basic driver infrastructure.

The series introduces:
- MSI-X/MSI interrupt handling with NAPI support
- TX path with scatter-gather DMA and completion handling
- RX path with page pool buffer management
- Firmware link-event processing and carrier management

These changes enable the RNPGBE driver to support basic TX/RX
network operations.

---
Changelog:
v8 -> v9:
[patch 1/4]:
1. Remove the unused MSI mode flag and separate the q_vector array index
   from the hardware interrupt vector number. (sashiko-nipa)
2. Read back a valid per-ring interrupt mask register once after masking
   all queues to flush posted writes. (sashiko-nipa)
3. Document that TX and RX rings are allocated as pairs and share interrupt
   control registers. (sashiko-nipa)
4. Remove redundant ring checks before scheduling NAPI. (sashiko-nipa)
5. Fix the kernel-doc descriptions for the q_vector and ring
   parameters. (sashiko-nipa)
6. Make rnpgbe_down() and rnpgbe_close() idempotent to avoid repeated NAPI
   disabling and IRQ release during shutdown. (sashiko-nipa)
7. Drop the unnecessary pci_set_drvdata(pdev, NULL) change from this
   series. (sashiko-nipa)
8. Queue mailbox event handling on system_percpu_wq, the supported
   replacement for system_wq.
[patch 2/4]:
1. Use DMA_STATUS_REG to wait for TX read and write AXI transactions
   to complete before releasing TX DMA mappings. (sashiko-nipa)
2. Disable TX AXI read/write paths while programming TX ring registers,
   and enable them only after ring configuration is
   complete. (sashiko-nipa)
3. Enforce the hardware-required 33-byte minimum packet length in the
   chip-specific transmit entry point. (sashiko-nipa)
4. Advertise NETIF_F_HIGHDMA only when a DMA mask wider than 32 bits is
   available, while retaining the 32-bit DMA fallback. (sashiko-nipa)
5. Update TX cleanup documentation and comments to describe the DMA stop
   and ring reconfiguration ordering. (sashiko-nipa)
6. Reword the DMA mask setup as a prerequisite for the new TX DMA path,
   rather than a fix for a previously unused streaming DMA mask.
   (sashiko-nipa)
[patch 3/4]:
1. Replace per-ring delayed work and system_wq usage for RX refill
   recovery with one timer shared by each q_vector; cancel the timer
   before RX cleanup and q_vector teardown. (sashiko-nipa)
2. Publish the RX tail after every refill attempt, including when the
   first page allocation fails, to avoid using a stale tail after
   reopen. (sashiko-nipa)
3. Track packet-level NAPI work separately from successful RX statistics;
   count complete dropped, malformed, skb-build, and header-cleanup
   failures against the NAPI budget. (sashiko-nipa)
4. Clarify that 16 descriptors are reserved in the fixed 512-descriptor
   ring, leaving at most 496 descriptors posted to hardware. (sashiko-nipa)
5. Correct the kernel-doc for rnpgbe_process_skb_fields(). (sashiko-nipa)
6. Wait for RX DMA to become idle before disabling RX AXI and releasing
   RX mappings, and flush the posted register write. (sashiko-nipa)
7. Preserve the NAPI completion contract during teardown; do not complete
   NAPI when the full poll budget was consumed, and do not re-enable queue
   interrupts after the device is down. (sashiko-nipa)
[patch 4/4]:
1. Take a lock-protected snapshot of link, speed, and duplex after
   consuming a pending link event, avoiding mismatched link-state
   data. (sashiko-gemini)
2. Set carrier off before registering the netdev, so the initial
   RTM_NEWLINK reports no carrier. (sashiko-gemini)
3. Serialize resetting the firmware link-state snapshot with clearing the
   driver DOWN state, so a link event cannot be discarded during
   open. (sashiko-nipa)
4. Fail ndo_open() when firmware port-up notification or link-report
   enablement fails. (sashiko-nipa)
5. Validate firmware link events before updating cached link
   state. (sashiko-nipa)
6. Clarify the driver-owned link-state snapshot, firmware link speed
   encoding, and LINK_REPORT_EN mailbox payload layout. (sashiko-nipa)
7. Document firmware link-event rate limiting and mailbox worker
   behavior. (sashiko-nipa)
8. Queue the link service task on system_percpu_wq.
9. Document that link-up enables the GMAC receiver and bypasses its frame
   filter so the chip-level packet filter can receive all frames.
   (sashiko-nipa)
10. Include the LLDP status bit in the documented driver-owned link-state
    fields and reset semantics. (sashiko-nipa)

Links:
v1: https://lore.kernel.org/netdev/20260325091204.94015-1-dong100@mucse.com/
v2: https://lore.kernel.org/netdev/20260403025713.527841-1-dong100@mucse.com/
v3: https://lore.kernel.org/netdev/20260507081539.171844-1-dong100@mucse.com/
v4: https://lore.kernel.org/netdev/20260526033539.164061-1-dong100@mucse.com/
v5: https://lore.kernel.org/netdev/20260528023150.239532-1-dong100@mucse.com/
v6: https://lore.kernel.org/netdev/20260604112750.769215-1-dong100@mucse.com/
v7: https://lore.kernel.org/netdev/20260611100036.36370-1-dong100@mucse.com/
v8: https://lore.kernel.org/netdev/20260731120322.895955-1-dong100@mucse.com/

---

Dong Yibo (4):
  net: rnpgbe: Add interrupt handling
  net: rnpgbe: Add basic TX packet transmission support
  net: rnpgbe: Add RX packet reception support
  net: rnpgbe: Add link status handling support

 drivers/net/ethernet/mucse/Kconfig            |    1 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |    3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  196 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   45 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   30 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 2253 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   87 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  124 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |   32 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |    1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  206 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   51 +
 12 files changed, 3006 insertions(+), 23 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

-- 
2.25.1

