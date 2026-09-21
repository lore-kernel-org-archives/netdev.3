Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6A368264;
	Mon, 21 Sep 2026 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973938; cv=none; b=SutEYo7wnuVy6HrGHmX36+iSAW1NRyyfF7ET6MNg+Jzm6hWA0ndQ05yxIa6+GOFpfdM0O6Bv5HtVMuHr0OmgNi9rYhlqCsqnymHMjIYncErytKBmpFmEuBlZw8zmywnb5vButo8NfHshMc+lMqg9tjUN2B7PzlOgtybJPh9Qv80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973938; c=relaxed/simple;
	bh=mlCaAZWk958tL0hKDs08qXiWiuYV9kF5Rhd8qlCfj2E=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=AYvyDp852yC1LZY/7zbTgr8Jf2OV+hj1PAag2DUYMPbmisQAqdc+wHf1dqEluuUtvzgYwkFGWB0tFbZPkD1rRdpsLvvnJqVbaHVsJperqsggHVyrG4MLVkx95PN3TZ/lT0EPaAGEKYmqXT3rvAGOIwt/9ElnoJ+sRUj3uE7dM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4hpDRx3w3yzCh8D;
	Mon, 21 Sep 2026 14:52:13 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4hpDRm1BNZzBQkJq;
	Mon, 21 Sep 2026 14:52:04 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hpDRZ398yz8XrrM;
	Mon, 21 Sep 2026 14:51:54 +0800 (CST)
Received: from njy2app01.zte.com.cn ([10.40.12.136])
	by mse-fl1.zte.com.cn with SMTP id 68L6pcA5029938;
	Mon, 21 Sep 2026 14:51:38 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njb2app06[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 21 Sep 2026 14:51:40 +0800 (CST)
X-Zmail-TransId: 2afe6ab0d3fca25-4dbc7
X-Mailer: Zmail v1.0
Message-ID: <202609211451400236_aZ55Ox3y7NW8MQnYImM@zte.com.cn>
Date: Mon, 21 Sep 2026 14:51:40 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHYzIDAvM10gZGluZ2hhaTogZmlybXdhcmUgaGFuZHNoYWtlLCBNU0ktWCBwb29scyBhbmQgYXN5bmMgZXZlbnQgcXVldWVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 68L6pcA5029938
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.35.20.121 unknown Mon, 21 Sep 2026 14:52:13 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AB0D41C.000/4hpDRx3w3yzCh8D

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
- The 200 s compat region wait is the cold boot budget and is
  bounded; firmware that never populates the region is handled by
  the module id check, which defers to the readiness wait.
- Torn reads of the compat block: the firmware populates the region
  with a single write, so there is no partial-write window.

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
 drivers/net/ethernet/zte/dinghai/en_pf.c    | 231 +++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h    |  57 +++
 drivers/net/ethernet/zte/dinghai/zxdh_eq.c  | 146 +++++++
 drivers/net/ethernet/zte/dinghai/zxdh_eq.h  |  61 +++
 drivers/net/ethernet/zte/dinghai/zxdh_irq.c | 405 ++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/zxdh_irq.h |  72 ++++
 7 files changed, 973 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_eq.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_eq.h
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_irq.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_irq.h

-- 
2.27.0
