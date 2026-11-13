Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548879;
	b=v7sPsP56a4NjTackHHFaZqlaqQdfK21Z1QiZ5NSEBre44PyfqQBqU6GxH2ZhT6dLqJDE
	 /W2D2FFUyEP8fvUcx1T3D/l5viwnfq/pOWtkjv+NoedCZwH+u1vnCksggRVNPRQvQDllB
	 eyUaLY9DhrL4OGALgE5tTAYUVFrTmP2Ao19polvxsBByXpjzojS1e5nRocRfsEkBG2JlV
	 ZPDBpvdu0zI0+3vLAx8kCJXIzWD9Dzr8/ZK2wkU9vTCNknGG0pGw21wia7pW66msGhunZ
	 lExvlV0yAS6Z1LFSpKrshySD4YlT2rpGNhsFTMXzXqB+f8vSJWDIeQ4KGJto5EmXPCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548879;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=R/hztUFaUrZAxIgTvQh2iT2CdtlyFnFy+Eg07zRqZOY=;
	b=j51XL0vjeqRMf45oJqvnse+v3+WX35EwS3PpK7b8vYKulglG8QVw6VJuE4N3cw1oiJju
	 4TTvfw/Zjl5z3y/7p49HqpzLnQ3PAkrIBQ64VQW2FrVX2hsPFiY0XxaISUDbJNRK5MAPW
	 mAx8K7XDmXa6XGpRn6DQitZf3nmNiViy3oPRcYxDwG2Fqi0Nleg8xrYhKv0J/+MKsOHPq
	 oLCThvm10IdOkTfDeproox+c1FioyTl2WQvPDvKVJQgsrSvD6FIQHZDSmK0pnGbiNl/oC
	 /v1X6Jm0qMr7m7cnCxNdD1Q/MYAZrP/XWbQxTfUxNipOm3PQFxjywG84NFU24BFBNWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=AfzLxChg;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB5606A31C;
	Fri, 13 Nov 2026 05:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1EB5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=AfzLxChg
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQmWB36d5z8XrrX;
	Fri, 13 Nov 2026 13:47:50 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794548870;
	bh=UkjlPYbBuRGHzyN4ugD8RnQAqPPcq9laiZwvRkBQXrM=;
	h=Date:From:To:Cc:Subject;
	b=AfzLxChgLbyzAcIvsQD3luXLmJNhwgRBhIyKuG+GNGbToA4WSO8+pvxReMuLf+Cd9
	 txmQkvo9NZ9YdyM/TEDxLcYPSrHqsiYJCuYPIfR1S16bobSK+w8ThOiKXtk5wAcA48
	 BCvfq+aAn+BU4lSXdwRRNCeljbwZjPlF1OLOAgbUfLj3iYdV+69xLFKi/8htoLAUSn
	 2zZTO0vhHKAfd/JS70MrifMik6ncyGH5uE7dCdjTiRmsxH9KYiTGD0I4rQyuRWbi+d
	 31dOoLHrThrs/wt4V5EfL/diAaHAyOfzgZTqCq62KTaTwE2fT9clqDhqKIH3fJtgM3
	 R2DFGRm1ASedg==
Received: from njb2app06.zte.com.cn ([10.55.23.119])
	by mse-fl1.zte.com.cn with SMTP id 6AD5lfHB034786;
	Fri, 13 Nov 2026 13:47:41 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njb2app07[null])
	by mapi (Zmail) with MAPI id mid204;
	Fri, 13 Nov 2026 13:47:43 +0800 (CST)
X-Zmail-TransId: 2aff6af6a47f68e-346b4
X-Mailer: Zmail v1.0
Message-ID: <20261113134743145KUhKvpwU6uqR0QzymEP96@zte.com.cn>
Date: Fri, 13 Nov 2026 13:47:43 +0800 (CST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <han.junyang@zte.com.cn>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <han.junyang@zte.com.cn>, <ran.ming@zte.com.cn>,
        <han.chengfei@zte.com.cn>, <zhang.yanze@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY2IDAvM10gZGluZ2hhaTogZmlybXdhcmUgaGFuZHNoYWtlLCBNU0ktWCBwb29scyBhbmQgYXN5bmMgZXZlbnQgcXVldWVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AD5lfHB034786
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 13 Nov 2026 13:47:50 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF6A486.000/4jQmWB36d5z8XrrX

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

Changes in v6:
- Guard the IRQ table teardown in patch 2 rather than deferring the
  guards to patch 3, so the probe error paths of the MSI-X patch are
  safe on their own and bisection cannot land on an unguarded cleanup
  (sashiko review of v5).
- Review findings not taken from v5:
  The sashiko automated review of v5 [1], which was not posted to the
  list, reported four findings. The IRQ table teardown NULL
  dereferences on the probe error paths were real and are fixed in
  this revision. The remaining three restate earlier findings or
  do not apply: the BAR0 bounds item repeats the BAR 0 entry below;
  the 20 s legacy wait is the legacy-firmware detection itself:
  firmware that predates the compat region never populates it and
  the driver reports and proceeds in legacy mode after the timeout
  (see Changes in v4); and the health_version read cannot race the
  RISC-V core initialization: the readiness skip fires only for
  firmware with patch < ZXDH_HPIRQ_PATCH, which never reports the
  power-on flag, while firmware that does report health_version
  carries patch >= ZXDH_HPIRQ_PATCH and initializes the health
  buffer before the compat block reports ready.

  [1] https://sashiko.dev/#/patchset/20261014151200489685SCIlolykW0NGfL5EtQ%40zte.com.cn

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
