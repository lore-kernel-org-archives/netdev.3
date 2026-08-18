Received: from mta1.migadu.com (out-134.mta1.migadu.com [95.215.58.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A230F81A
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042896; cv=none; b=oYcECax8rECEw1stuJzSwlW8MrhB/DPwv3RlhiLjcb+udtBKjsDj8nZJN1xIELyZ20sEhafPuariOnIrr2kBjdZWV49aeht12A07tCc2GB4HIf2ATicEK59ylISySk8dYlHC0JvyjkxNNJEp9ew/El/KzGuDFT3kRW6mJDr5sU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042896; c=relaxed/simple;
	bh=tEMjd5E9zYo6aiRuZegOeIAJvmBWSKmri3ORsGcNxwI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JgHDrM9/vhN+Go4AQ0DT3zrt0LEMdtPwIzNLCt2NSFCm8vrYYJR7YPlXFswHHJc062jpmdoa1WTKWWPvHgj5j07/qRIrOnppCmeMlod4R7n2jat1w15yPg1GCHMn5V0+CPpzHnIon72vWYkQEROilXphGioynnnIN9peHiq7A4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rxIaPSHc; arc=none smtp.client-ip=95.215.58.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rxIaPSHc"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tEMjd5E9zYo6aiRuZegOeIAJvmBWSKmri3ORsGcNxwI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787042890; v=1; x=1787647690;
 b=rxIaPSHc6HpmcPeDmMImOwBQHwyxK7oaci6OYmmewJJ2PH4iHJqQ4Llk6qsI49I9uv7Cfyh8
 4yX1wTeqg800scOcCbuqgg0nQtFkpKYr2aW+JPb++dtMRQdxp1L4LfIFs0MeBUScLxACbJS9pGS
 HkOlPS877ZPvkmkHTCi8D2nE=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.110.119] (203.175.12.240)
	by smtp.migadu.com with ESMTPS id fbcc1d592846afc6;
	Tue, 18 Aug 2026 08:48:00 +0000
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Subject: [PATCH net v3 0/2] bonding: fix TLB load-tracking overflow on
 high-speed NICs
Date: Tue, 18 Aug 2026 16:47:43 +0800
Message-Id: <20260818-bond_overflow-v3-0-e05d4dbc2fd8@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NQQ7CIBREr2L+WgxQBerKexhjED6W2ICBBm2a3
 l1SN9rlzOS9mSBj8pjhuJkgYfHZx1BDs92A6XS4I/G2ZuCUC6qoILcY7DUWTK6PL6KN0EJLZYW
 mUJlnQuffi+8MAQe41LLzeYhpXD4KW6avjtGVrjDCiGmd462VQkp6eoy9DzHvTFhUhf/i+zXOK
 24bhweltGVC/uHzPH8Axs03hu8AAAA=
X-Change-ID: 20260806-bond_overflow-ac6a6a78d6a0
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

The bonding TLB (Transmit Load Balancing) mode tracks per-slave and
per-client transmit byte counts in u32 fields. At sustained throughput
above ~3.2 Gbit/s over the 10-second rebalance interval these counters
wrap, causing compute_gap() to produce incorrect gap values and
mis-select transmit slaves. Such speeds are routine on modern NICs
under heavy traffic.

This two-patch series fixes the overflow by widening the relevant
fields to u64.

Patch 1 converts the unbalanced_load counter to per-cpu state as a
preparatory step. The counter sits in the transmit hot path, so
converting it to per-cpu before widening avoids introducing cross-CPU
synchronization overhead for a u64.

Patch 2 widens tx_bytes, load_history, load, and the per-cpu
unbalanced_load tx_bytes from u32 to u64. It adds u64_stats_sync
protection for the per-cpu counter to prevent tearing on 32-bit
architectures, and reworks compute_gap() to use u64 arithmetic with
READ_ONCE() on slave->speed.

Note: In patch 2, I return 0 directly when the speed is unknown, because
I believe the comparison becomes meaningless if the NIC speed cannot be
determined. For example: a 1 G NIC and a 10 G NIC are bonded together,
yet both are marked as unknown. If you would prefer to retain the existing
logic, we could instead set the speed to `ULLONG_MAX` when speed is unknown.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
Changes in v3:
- Add a preparatory patch to convert unbalanced_load to per-cpu first
- widens tlb counters to u64 and add helpers to prevent tearing on 32-bit
- Link to v2: https://lore.kernel.org/r/20260814-bond_overflow-v2-1-d3fe588ad167@kylinos.cn

Changes in v2:
- update comment description, including AI-detected info.
- fix tx_bytes/load type detected by sashiko
- cast SPEED_UNKNOWN to 0 before shift, detected by sashiko
- Link to v1: https://lore.kernel.org/r/20260810-bond_overflow-v1-1-c9ff29d76770@kylinos.cn

---
Hangbin Liu (2):
      bonding: convert unbalanced_load to per-cpu state
      bonding: fix u32 overflow in compute_gap()

 drivers/net/bonding/bond_alb.c  | 69 +++++++++++++++++++++++++++++++----------
 drivers/net/bonding/bond_main.c |  9 ++++++
 include/net/bond_alb.h          | 13 +++++---
 3 files changed, 71 insertions(+), 20 deletions(-)
---
base-commit: 21040c7f931502070dcc66bb0f1aeed07dec032b
change-id: 20260806-bond_overflow-ac6a6a78d6a0

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

