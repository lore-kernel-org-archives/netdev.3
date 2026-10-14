Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D343D357D00;
	Wed, 14 Oct 2026 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961942; cv=none; b=PGQ5GCesd69UCA/gUrQwi5eENrkWnwChXsb0vmrkaNe1fVPZZDGUm1aF8k9Fe80bugWTB7suU3W9nBrJxCSz9JlB6fJeRxYD10EtrnvK5sx0xi5VqJGhqWyu0H6rRui6rM28mzd5ZKVC8DbWvNW5h4/hDHsgpDlkMeaAHpZqv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961942; c=relaxed/simple;
	bh=jHREZ6a9yEnGctn3wlCom9YOprD7A0LzeQFU4slR8R0=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=TBswHUNPBwPPyHP9xqGnt9AxoO50q4qZp5rPCrVaFfYvitH8l6HPpgvkpqyAAHx7WiqtxqQfr7RUuX14cQqP+FUuiXBhvvhGZ0PX1RFmJq8SZj5IJVQrFm4tZMdPRylI70YW3RxbcUkyWxaHVnhfTDyl08QkIIge7+WKvLEu1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4MpL5XXTz4yjjc;
	Wed, 14 Oct 2026 15:12:10 +0800 (CST)
Received: from njy2app04.zte.com.cn ([10.40.12.64])
	by mse-fl2.zte.com.cn with SMTP id 69E7BwKV099574;
	Wed, 14 Oct 2026 15:11:58 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njy2app04[null])
	by mapi (Zmail) with MAPI id mid204;
	Wed, 14 Oct 2026 15:12:00 +0800 (CST)
X-Zmail-TransId: 2afc6acf2b4094a-e6198
X-Mailer: Zmail v1.0
Message-ID: <20261014151200489685SCIlolykW0NGfL5EtQ@zte.com.cn>
Date: Wed, 14 Oct 2026 15:12:00 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <han.junyang@zte.com.cn>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <han.junyang@zte.com.cn>, <ran.ming@zte.com.cn>,
        <han.chengfei@zte.com.cn>, <zhang.yanze@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY1IDAvM10gZGluZ2hhaTogZmlybXdhcmUgaGFuZHNoYWtlLCBNU0ktWCBwb29scyBhbmQgYXN5bmMgZXZlbnQgcXVldWVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 69E7BwKV099574
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 14 Oct 2026 15:12:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ACF2B4A.002/4j4MpL5XXTz4yjjc

From: Junyang Han <han.junyang@zte.com.cn>

This series continues the DingHai (ZXDH) PF driver bring-up: after PCI
probing, it verifies the firmware version contract, waits for the
RISC-V management core to become ready, sets up the MSI-X interrupt
pools, and creates the async event queues through which the firmware
will report events.

Some notes on the IRQ design:

The vector space is partitioned into per-purpose pools (async, RDMA,
vq). Event queues share a vector through an atomic notifier chain
attached to the IRQ, and the sharing degree is governed by pool
thresholds. The IRQ table hangs off a void *priv in the shared core
device: the PF, MPF and SF core devices each carry a different pool
layout behind that pointer, so a type-specific struct in en_pf.c keeps
the shared header free of PF-only details.

Changes in v5:
- Drop __packed from zxdh_fw_compat and zxdh_health_buffer: both
  structs are naturally aligned with no padding.

Changes in v4:
- Fold the irq and eq table create() steps into their init()
  counterparts and route every probe error path through the same
  destroy() functions remove() uses, so cleanup has a single
  authority from the start (review feedback on v3).
- Give the pool name a buffer bound of its own (16 bytes) instead of
  sharing the 100-byte IRQ name buffer, so W=1 builds stay clean of
  -Wformat-truncation (review feedback on v3).
- Lower the compat region wait from 200 s to 20 s: the firmware
  publishes the block within 10 s of boot, so twice that leaves
  margin, and the wait now sits far below the 180 s udev event
  window raised on the thread (review feedback on v3).
- Wait for the compat block with a per-field readiness check instead
  of only the first dword: the firmware fills the fields one by one,
  and a dword-granular check can read a half-populated block (the
  "single write" justification given in v3 was wrong).
- Log the legacy-firmware assumption when the compat region wait
  times out, making the intentionally ignored timeout visible.

Changes in v3:
- Unmap the modern config MMIO regions on the probe error paths added
  in this series; they used to leak when the fw compat check or the
  RISC-V readiness wait failed.
- Skip the RISC-V readiness wait for firmware without the compat
  region: the erased patch field read as 0xffff and defeated the skip.
- Make fw_minor unsigned so firmware minor versions >= 128 are not
  rejected through sign wrap.
- Balance the per-CPU IRQ accounting on release, so pool teardown does
  not trip its leftover WARN; set the IRQ affinity for real with
  irq_set_affinity_and_hint() instead of only updating the hint; name
  IRQs after their pool instead of a hardcoded prefix; assert that the
  pool is empty at free instead of force-releasing leftovers.
- Clear eq->irq when the async IRQ request fails, so teardown does not
  treat the ERR_PTR as a live IRQ.

Review findings not taken:

- xa_alloc() with a NULL entry does not fail: __xa_alloc() turns a
  NULL entry into the internal zero entry as a reservation
  (lib/xarray.c), which is the reservation semantics the pool relies
  on.
- BAR 0 length checks against a truncated bar: the bar layout is part
  of the board firmware contract and the driver does not defend
  against a broken device, as settled during the review of the
  earlier device bring-up series (Andrew Lunn).

Changes in v2:
- Convert both firmware readiness polls to readx_poll_timeout()
  (Andrew Lunn).
- Read the fw compat block field by field through ioread*() accessors
  instead of an ioread32_rep() bulk copy, which misplaces the u8/u16
  fields on big-endian; no __le annotations are needed since each
  accessor converts from little-endian (Andrew Lunn).
- Use kref for the IRQ reference count (Andrew Lunn).

Junyang Han (3):
  dinghai: add firmware version check and RISC-V readiness polling
  dinghai: add MSI-X interrupt pools
  dinghai: add async event queue for firmware notifications

 drivers/net/ethernet/zte/dinghai/Makefile   |   2 +-
 drivers/net/ethernet/zte/dinghai/en_pf.c    | 223 +++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h    |  56 +++
 drivers/net/ethernet/zte/dinghai/zxdh_eq.c  | 137 +++++++
 drivers/net/ethernet/zte/dinghai/zxdh_eq.h  |  60 +++
 drivers/net/ethernet/zte/dinghai/zxdh_irq.c | 406 ++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/zxdh_irq.h |  73 ++++
 7 files changed, 956 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_eq.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_eq.h
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_irq.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_irq.h

-- 
2.27.0
