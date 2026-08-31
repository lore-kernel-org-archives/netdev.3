Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903303C456B;
	Mon, 31 Aug 2026 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161847; cv=none; b=a1v4exuPlQ1lUa/hcl3pxwr71gWlofPlVuu0iaXbu9XqlbU8T7wzHqKDgURT2umPAZaMomXzgt5MCvUKcjnxypn8eZxNtysLvj46XbzU5nRa9VuRe7SYW5J217BDgZscLWhppg766PFfIedoGxNakn0jp4bsa4ANB9VqVyUI7f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161847; c=relaxed/simple;
	bh=bdbKbh69yd2tFe1h/OWTpSMlg1494ifnLsuEVoVeFwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KrfCwlpZjjCoZvzZChKnoYYHvSy3VHcmh/dbDd3472WwbP8FO3zH9IG9lUwmjSzcuuUrerLDgSKpXtqM3fe08kWYfNMQ4Gc7r0NFHuWzkTTCq6UQZgCShsHbSqQe8xY4UQ2rak0z8/2k7Gt1crmyreXCFXi/lRz+PLqD2vRFQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1788161774ta14e3bb8
X-QQ-Originating-IP: 7KvrwUDfYJX30QayikOomGqSzLSIydCRYmukzAkVopk=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 31 Aug 2026 15:36:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2499586794323928395
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
Subject: [PATCH net-next v10 0/5] net: rnpgbe: Add TX/RX and link status support
Date: Mon, 31 Aug 2026 15:36:03 +0800
Message-ID: <8DDBCA0431A75B45+20260831073608.401988-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: ORtbrbXYhpNxgH35NFrhdrFkqfAWr4WJ4ewO6Y+744XrdAr8xMsBgCQV
	jDRL3u1ABo2yGg8yn217QCc0xyugikWkME83bClpLLu/CD6cYnWnDwAa0W7aUztbD7NV7Ms
	SP0HxO8YCsclDr7sovZ+VK2PTXoqpTuyfP4lMz55hnTmhVyTEN/WXch0TAZCD7QUuQAB5nC
	aK9g4nNI22KRq+pgggQ3QdjeapIeA2RETPzB0XIEVCZDSsRBvl1r1Wv4+H1/P9wtsHqXVtP
	gJBIJDoHVMteVgfkuwHI2P70x+KO5akO7//rpMMnXK/AXA7x0QbmCc4rIvKJDPmu3wnSJqo
	rJHPht2qAWveqGKpjKoNCCIpMWtvEgo8ANsXEY8Nr5oEdXyvNSIpwWADSvOwpFbbKa/oT5+
	j9m0EzqrcTseM0PsNXVBA2Ag9VqLaKfEUiEAmRh7KhAE1skAAsLho/K0osswX0HPUMB9O6N
	mCY7wToGrO9gbJk4KT75UUziNNlaLNHWWz70m/aGuRJf3H721Oi39m7TRMJ0fu9QrES8v49
	Ha7IeOvS3XWKVnRQR7byw1bLJBunVoOzQmeZluUVP3cJcIfL5bvf9sE8aEprvUuH02IKqXf
	7ktNZELB9H5s2eHX0p7Kog2qIerVEwKIDwQZBGgOu7bpxrigmWiKiISCGmQPNXNLGoxR5FZ
	z7EjMChTohDcmkojiyhf9I5mVJbRQyj/2y+/Y4bzCP2t2cEFIH95MGAcq+DfDcB5jdRomiq
	weetc5mz5f+VsNR0K1iDHTnGj/Zl1aMsQbMoiFj9DKtIwUqJ9qgbdVdH6qLTxb1dTyUTw4j
	vLkoDXkyYXK8cFPcMcDkK/jj3j7kwJGqG61STjpz5mL+bg/BiYaOT0WOd1fb0a5pCU/9Z/S
	JRKx3Z5kOQTZLAI7B9jOPnacYr7gS9YYXzj4NumcxcmKgKAQQiNIlObaSpkdDR1sx6Ljirz
	Ez+WaLbN9bJQLi9XRY6S6k3NTr2De/NQB5BXZniTiLTM9cAzaIQa+OUoAgYPKZFdj/8ng8x
	BTbYAVE4iGcsfn0xQth8+To9MQuL77fGD2eWfiLjLyLr6PJ5IfdxbbvZby1136hIQu3JV0B
	Q==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series adds the packet transmission, reception, and link status
management features to the RNPGBE driver, building upon the previously
introduced mailbox communication and basic driver infrastructure.

The series introduces:
- MSI-X/MSI interrupt handling with NAPI support
- TX path with scatter-gather DMA and completion handling
- RX path with page pool buffer management
- unicast/multicast filter.
- Firmware link-event processing and carrier management

These changes enable the RNPGBE driver to support basic TX/RX
network operations.

---
Changelog:
v9 -> v10:
[patch 1/5]:
1. Release mailbox IRQ and workqueue resources during device
   shutdown. (sashiko-nipa)
2. Correct the NAPI poll callback documentation and interrupt-mode
   comment. (sashiko-nipa)
3. Clarify that the mailbox handler is only a deferred notification hook at
   this stage of the series. (sashiko-nipa)
4. Update the interrupt-handling commit message. (sashiko-nipa)
[patch 2/5]:
1. Wake stopped TX queues after completion regardless of carrier
   state. (sashiko-nipa)
2. Propagate TX DMA quiesce failures to ndo_open(), and prevent DMA
   reconfiguration after a terminal AXI fault until chip reset and
   reprobe. (sashiko-nipa)
3. Release TX resources and IRQs on TX configuration failure. (sashiko-nipa)
4. Cast pfvfnum to u32 before encoding it in the TX ring address
   register. (sashiko-nipa)
[patch 3/5]:
1. Treat an RX DMA-idle timeout as a terminal AXI fault, keep DMA disabled,
   and reject subsequent opens until the device is reset and
   reprobed. (sashiko-nipa)
2. Cancel RX allocation-retry timers before releasing RX resources, and
   avoid re-enabling queue interrupts after the device is down. (sashiko-nipa)
3. Init '.netdev, .queue_idx and .napi' for page_pool. (sashiko-nipa)
[patch 5/5]:
1. Add a preceding receive-mode patch with chip-level RX filtering and
   ndo_set_rx_mode(), and program the GMAC frame filter before enabling
   its receiver. (sashiko-nipa)
2. Treat RNPGBE_LINK_ST as wholly driver-owned and construct complete
   snapshots instead of using read-modify-write. (sashiko-nipa)
3. Schedule the service task immediately after a valid link event while
   retaining its periodic execution for future maintenance work. (sashiko-nipa)
4. Remove unused mailbox definitions and unrelated changes. (sashiko-nipa)
5. Validate link-up speeds and reject unsupported values without changing
   the cached link state. (sashiko-nipa)
6. Use an invalid speed encoding for malformed link events so that the
   firmware snapshot cannot match a valid link-down state. (sashiko-nipa)
7. Decode port_status as a per-port bitmap using BIT(hw->port). (sashiko-nipa)
8. Process at most one mailbox request per work item. Use a sequence
   counter for the dedicated mailbox MSI-X vector to requeue work when
   another mailbox interrupt arrives during processing; shared IRQ modes
   continue to perform a coalesced mailbox check only. (sashiko-nipa)

Links:
v1: https://lore.kernel.org/netdev/20260325091204.94015-1-dong100@mucse.com/
v2: https://lore.kernel.org/netdev/20260403025713.527841-1-dong100@mucse.com/
v3: https://lore.kernel.org/netdev/20260507081539.171844-1-dong100@mucse.com/
v4: https://lore.kernel.org/netdev/20260526033539.164061-1-dong100@mucse.com/
v5: https://lore.kernel.org/netdev/20260528023150.239532-1-dong100@mucse.com/
v6: https://lore.kernel.org/netdev/20260604112750.769215-1-dong100@mucse.com/
v7: https://lore.kernel.org/netdev/20260611100036.36370-1-dong100@mucse.com/
v8: https://lore.kernel.org/netdev/20260731120322.895955-1-dong100@mucse.com/
v9: https://lore.kernel.org/netdev/20260814111317.1741087-1-dong100@mucse.com/

---


Dong Yibo (5):
  net: rnpgbe: Add interrupt handling
  net: rnpgbe: Add basic TX packet transmission support
  net: rnpgbe: Add RX packet reception support
  net: rnpgbe: Add receive mode support
  net: rnpgbe: Add link status handling support

 drivers/net/ethernet/mucse/Kconfig            |    1 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |    3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  202 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  116 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   43 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 2317 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   84 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  152 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |   32 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |    1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  233 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   43 +
 12 files changed, 3201 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

-- 
2.50.1

