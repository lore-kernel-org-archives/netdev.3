Received: from mta0.migadu.com (out-241.mta0.migadu.com [91.218.175.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717403ACEE0
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787205378; cv=none; b=rdfGFd0cbZvBSiQd4qhfQ9t13v5ssXBFfw4fyXnigcDnK8yuSaVAszwr22T+6Mfm+mqiOaXUg8CMwoqv4UVty1snjXrG1ksg4uN/xRQzdPp0MuYwg4DZ5KngdxPERVmeh2vdml9CRIZA57nFfcm7Tx5CU0zL03J7nJTF3/H94Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787205378; c=relaxed/simple;
	bh=samyOAuKea5zxrnwaUe5hXnIswxz/JmqpAjAWZze8zo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KO7sy26aU+xa3kBPEoJRgamGrgsM8huG5xG88Oh2VxlZ9h3NxzNQEBTKnWqYTjXsJ39wj77qfO4fOygyGWVr6jfEDw88EEp9MLku5eJdmEA39sC0C73rcCrqCNFlhkmv9cUkYxg8pCpIOL/NannGM75gVUp6IHexFb9k55fD7v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U3qwsTMt; arc=none smtp.client-ip=91.218.175.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U3qwsTMt"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=samyOAuKea5zxrnwaUe5hXnIswxz/JmqpAjAWZze8zo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787205374; v=1; x=1787810174;
 b=U3qwsTMt85JE2yE03HthwZjqK0YLucbbxDd5+JqIHspR+j50euwaVZ3QpuOSnHFSn/T+JHF2
 q93ZlCDOIVk82XT2MZSFpiC8xu297VsLoSd0hXsaAjM28T2MFRrsTPUvYAJfZHD5ZEuXIWm8Yc0
 niTjhzZrNHgWE6UhDkSUiIlA=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.110.119] (216.236.36.152)
	by smtp.migadu.com with ESMTPS id 8160f7b0632893f2;
	Thu, 20 Aug 2026 05:56:03 +0000
X-Mizu-Trace-ID: 8160f7b0632893f2
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Subject: [PATCH net v4 0/2] bonding: fix TLB load-tracking overflow on
 high-speed NICs
Date: Thu, 20 Aug 2026 13:55:51 +0800
Message-Id: <20260820-bond_overflow-v4-0-805ba0d3efb6@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNwQ7CIAyA4VcxnMUA2wA9+R7GGEaLEg0YMKhZ9
 u6SeZnz2Dbf34FkTB4z2a0GkrD47GOoQ7teEXsx4YzUQ52JYEIyzSTtY4BTLJjcLT6psdJIozR
 Iw0g194TOv6begQR8kGNdXnx+xPSefhQ+nb45zha5wimnduuc2IKSSrH99X3zIeaNDVOqiDlvl
 1xUDo3DTmsDXKo/3sy5XvKGMoqsgxZ6KxzoHz6O4wfXPjEjLgEAAA==
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
architectures, and reworks compute_gap() to use u64 arithmetic with
READ_ONCE() on slave->speed.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
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

 drivers/net/bonding/bond_alb.c | 82 ++++++++++++++++++++++++++++++++++--------
 include/net/bond_alb.h         | 14 +++++---
 2 files changed, 77 insertions(+), 19 deletions(-)
---
base-commit: 564973a259ec76f2dad0853420e7034cc43994c4
change-id: 20260806-bond_overflow-ac6a6a78d6a0

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

