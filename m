Received: from mta1.migadu.com (out-165.mta1.migadu.com [95.215.58.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8AB1D63F3
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787619718; cv=none; b=X/0s2PCyYH4HXJ5sV08uepaIEYkH6Va2UbOHxQcygt2aVQ6NvSUIom1/wcgb9tyT/iq7qLFwTR0uSB1Pi1mZg5E6Ljx1i+DRSSj2WaiH2imDgTniCbts5TeqCDntXfvGLxieW7NjyIZXg+dlKmZpXwrDL9gA2cEYgmI3DWEVZlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787619718; c=relaxed/simple;
	bh=NVX1ZBpi6232FV9WxF89B9i9CGM7/OiA9bbT2esFE/A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OgXXH+1Nhj9CC0fJpx/jp155DBSGuXcpDiUNdugpvfNRj7QfEPD+5SUjiksETX7PPHyCwCrGqalINcnanVRmF2NNbc1EJ8/40zmQDHpJciG74Sid5+5d+GBAhPgAXYVtrGzI5xr9qFnoOUdqm5/gcnZEjz+cenCWcCXbLh8St1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ad/+lXVn; arc=none smtp.client-ip=95.215.58.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ad/+lXVn"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NVX1ZBpi6232FV9WxF89B9i9CGM7/OiA9bbT2esFE/A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787619713; v=1; x=1788224513;
 b=ad/+lXVnJcRxh/tMhYWyaxo2qKal1TD+Hg9dDsmy/kV9yR33luUYQw/SyZLZ5gPjY4oVC36L
 5LyyUIzeiieTA4lEo+EmeCThJPso2fkTcZTjyuiDj5lJpAHa/yRf5CeP41iwwZFwLU5Xy2UJeuS
 eOKP8GovHRCldgJWJs+dOkA0=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.110.119] (216.236.36.147)
	by smtp.migadu.com with ESMTPS id 33d4ce9755b67d8f;
	Tue, 25 Aug 2026 01:01:53 +0000
X-Mizu-Trace-ID: 33d4ce9755b67d8f
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Subject: [PATCH net v5 0/2] bonding: fix TLB load-tracking overflow on
 high-speed NICs
Date: Tue, 25 Aug 2026 09:01:28 +0800
Message-Id: <20260825-bond_overflow-v5-0-7a800de133f1@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XOwW7DIAwG4FepOI/KkARoT32PqZoINitaBRVUr
 FWVdx9KL1ly/G19v/1ihXKgwo67F8tUQwkptjB87Ji72PhNPGDLTIJUYEDxMUX8SpWyv6Zfbp2
 yymqDygJr5pbJh8fc98ki3dm5DS+h3FN+zjeqmFfvOgGruiq44O7gvTygVlrD6ed5DTGVvYtzV
 ZVL3q+5bBw7T4MxFoXSG94tuVnzjgMnGLDH0UmPZsP7BZeb5/vGDQyjBezIj+ofn6bpD/HRoC9
 tAQAA
X-Change-ID: 20260806-bond_overflow-ac6a6a78d6a0
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
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
synchronization overhead for a u64. Also use a prev_total_unbalanced
to store the previous total load to avoid reset per-cpu data.

Patch 2 widens tx_bytes, load_history, load, and the per-cpu
unbalanced_load tx_bytes from u32 to u64. It adds u64_stats_sync
protection for the per-cpu counter to prevent tearing on 32-bit
architectures, and reworks compute_gap() to use s64 arithmetic with
READ_ONCE() on slave->speed.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
Changes in v5:
- use s64 as the return value for compute_gap, so we can compute the
  difference when NICs are overload. (Nikolay Aleksandrov)
- Link to v4: https://lore.kernel.org/r/20260820-bond_overflow-v4-0-805ba0d3efb6@kylinos.cn

Changes in v4:
- move per-cpu allocation to tlb_initialize/tlb_deinitialize (Nikolay Aleksandrov)
- use an extra prev_total_unbalanced to avoid reset per-cpu data (Nikolay Aleksandrov)
- Link to v3: https://lore.kernel.org/r/20260818-bond_overflow-v3-0-e05d4dbc2fd8@kylinos.cn

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

 drivers/net/bonding/bond_alb.c | 69 +++++++++++++++++++++++++++++++++++-------
 include/net/bond_alb.h         | 14 ++++++---
 2 files changed, 68 insertions(+), 15 deletions(-)
---
base-commit: 564973a259ec76f2dad0853420e7034cc43994c4
change-id: 20260806-bond_overflow-ac6a6a78d6a0

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

