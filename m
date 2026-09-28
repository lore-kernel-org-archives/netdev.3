Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26313290C5;
	Mon, 28 Sep 2026 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598069; cv=none; b=eUvJRWeWvSg2CSmnVB6/3BnZI3KhjLe8W2e1UlARW7duGP2+N47LGxwEBc06yjslYmf7CA+80yerZ7ftvIiDINtj9h7NPD5Qiu+EVNGY4aatQZhNf7n7+fgw+ipbxQAqDymu3TbdOkKZOOAisKiZ40hYnZ3ZjMyRQE9Den7p+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598069; c=relaxed/simple;
	bh=VFbdGv6qoaxx3AOT+9F1nUvXzKOOnHG/+a9PavEM9b0=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=n2lClR1N4ZbNBOpizSwao6Cy4ynR0zJDiOMS+ZfBAmDPLUDYssGX/6KSpKBvVsg8WVkmGdva3wtuSs9hcVjzH3k0NdAfyv+NSz0saZR0j8Ak8gGEpN2ayzmUSTQ32mMfCrUCMkIbhf/aJOZBuwwtFbSofsPTgJ1EcOhn6Ro046I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4htgQ84hTcz5BNRf;
	Mon, 28 Sep 2026 20:21:04 +0800 (CST)
Received: from njy2app01.zte.com.cn ([10.40.12.136])
	by mse-fl2.zte.com.cn with SMTP id 68SCKuI8062458;
	Mon, 28 Sep 2026 20:20:57 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njb2app06[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 28 Sep 2026 20:20:59 +0800 (CST)
X-Zmail-TransId: 2afe6aba5babcb3-135a7
X-Mailer: Zmail v1.0
Message-ID: <20260928202059763e9xqxhTwFe4DHa6a2wq0L@zte.com.cn>
Date: Mon, 28 Sep 2026 20:20:59 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY0IDAvM10gZGluZ2hhaTogZmlybXdhcmUgaGFuZHNoYWtlLCBNU0ktWCBwb29scyBhbmQgYXN5bmMgZXZlbnQgcXVldWVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 68SCKuI8062458
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 28 Sep 2026 20:21:04 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ABA5BB0.000/4htgQ84hTcz5BNRf

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
 drivers/net/ethernet/zte/dinghai/en_pf.c    | 223 ++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h    | 56 +++
 drivers/net/ethernet/zte/dinghai/zxdh_eq.c  | 137 +++++++
 drivers/net/ethernet/zte/dinghai/zxdh_eq.h  | 60 +++
 drivers/net/ethernet/zte/dinghai/zxdh_irq.c | 406 ++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/zxdh_irq.h | 73 ++++
 7 files changed, 956 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_eq.c
 create mode 100644 drivers/net/ethernet/zxdh_eq.h
 create mode 100644 drivers/net/ethernet/zxdh_irq.c
 create mode 100644 drivers/net/ethernet/zxdh_irq.h

--
2.27.0
