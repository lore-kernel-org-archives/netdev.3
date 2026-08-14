Received: from mta0.migadu.com (out-68.mta0.migadu.com [91.218.175.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755BF357D1E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 05:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786685977; cv=none; b=SdeCJuMSE+qE+6GK/3U2nnJ9XU/MH9xJjrLz2Dqfzg6qQj1mhmbTP5Ockyws7T0GWWjh8Ga59YwAC3xWSRnAUqXhDZjdaJ2E8yfQE5ujHQC6SkJkGwWIDIAGKLZoWZDNztd86jhcKSu0653GFzy4BPfJ4dTKVCXypS//FqqXHwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786685977; c=relaxed/simple;
	bh=9TqeIj5UNOoAMY52v5JAjrjBGkBnEZNZUbpJTLyGNEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HYrRkAJtLt3Ioectnc9PYzhvvb9eFmUtyjECJY7z0QVKU/JYIl5p8Cm0nzUY25ZkmWO1WyjOEM5SX7mBZmu/Fd/tZ9p0B0izUZF3zxgzIdI4TU0FIxCESv+XLDHsvQBywNzEbHPoToaCItWsSPMuX4aU828tgj2jTnU+x7pOfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wGBLPttg; arc=none smtp.client-ip=91.218.175.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wGBLPttg"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9TqeIj5UNOoAMY52v5JAjrjBGkBnEZNZUbpJTLyGNEU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786685972; v=1; x=1787290772;
 b=wGBLPttgcQpG7Qcf2i2WG127qcb+O+cWqOc1eP++ho67lJdY2i3tvQHimxf+sORMBbaPLaP3
 Q/Kb+TJdgKiGxbym5utCeFMyGp8BvnQquSpakC+znDz5ZL0/A1xpOoZEdfNLLTWio0tiBfZunpR
 FiOc7gR+eintHS1I3HHJPUOc=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.110.119] (203.175.12.241)
	by smtp.migadu.com with ESMTPS id bc379b4f37d99766;
	Fri, 14 Aug 2026 05:39:32 +0000
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Fri, 14 Aug 2026 13:39:23 +0800
Subject: [PATCH net v2] bonding: fix u32 overflow in compute_gap()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bond_overflow-v2-1-d3fe588ad167@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NQQ7CIBREr9L8tRhgAa0r72GaBuFjf2zAQIM2D
 XeX1J3LN5N5s0PGRJjh0u2QsFCmGBrIUwd2NuGBjFxjkFwq3nPF7jG4KRZMfolvZqwyyujeKcO
 hbV4JPX0O3w0CrjC2cKa8xrQdH0Uc1U8n+J+uCCaYHbyXg9NKa359bguFmM82wFhr/QJPPvl/s
 AAAAA==
X-Change-ID: 20260806-bond_overflow-ac6a6a78d6a0
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

The TLB fields tx_bytes, load_history, load, and unbalanced_load are
all u32, which can overflow when sustained throughput exceeds ~3.2
Gbit/s over the 10-second rebalance interval. On modern high-speed
NICs under heavy load this is easily reached, causing the gap
calculation in compute_gap() to wrap and produce incorrect slave
selection.

Widen these fields to s64 so the load arithmetic stays correct.
This also lets compute_gap() naturally return negative values when a
slave is oversubscribed, which the existing max-gap selection already
handles.

Additionally, the NIC speed is left-shifted before being cast to s64.
For speeds >= 4 Gbit/s (slave->speed >= 4096), the u32 shift
(4096 << 20 = 0x100000000) overflows before the cast takes effect.
Cast slave->speed to s64 before shifting so the arithmetic is
performed in 64 bits throughout.

Also cast SPEED_UNKNOWN to 0; otherwise, it would be the largest speed
after the shift.

Detected by AI code review.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
Changes in v2:
- update comment description, including AI-detected info.
- fix tx_bytes/load type detected by sashiko
- cast SPEED_UNKNOWN to 0 before shift, detected by sashiko
- Link to v1: https://lore.kernel.org/r/20260810-bond_overflow-v1-1-c9ff29d76770@kylinos.cn
---
 drivers/net/bonding/bond_alb.c | 12 ++++++++++--
 include/net/bond_alb.h         |  8 ++++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 839f7482dc18..052ab6beb661 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -6,6 +6,7 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/pkt_sched.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -160,8 +161,15 @@ static void tlb_deinitialize(struct bonding *bond)
 
 static long long compute_gap(struct slave *slave)
 {
-	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
-	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
+	s64 speed;
+
+	if (slave->speed == SPEED_UNKNOWN)
+		speed = 0;
+	else
+		speed = (s64)slave->speed;
+
+	return (speed << 20) - /* Mbit/s -> bit/s */
+	       (SLAVE_TLB_INFO(slave).load << 3); /* Byte/s -> bit/s */
 }
 
 static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)
diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
index e5945427f38d..4933a855a438 100644
--- a/include/net/bond_alb.h
+++ b/include/net/bond_alb.h
@@ -57,12 +57,12 @@ struct tlb_client_info {
 				 * packets to a Client that the Hash function
 				 * gave this entry index.
 				 */
-	u32 tx_bytes;		/* Each Client accumulates the BytesTx that
+	s64 tx_bytes;		/* Each Client accumulates the BytesTx that
 				 * were transmitted to it, and after each
 				 * CallBack the LoadHistory is divided
 				 * by the balance interval
 				 */
-	u32 load_history;	/* This field contains the amount of Bytes
+	s64 load_history;	/* This field contains the amount of Bytes
 				 * that were transmitted to this client by
 				 * the server on the previous balance
 				 * interval in Bps.
@@ -118,14 +118,14 @@ struct tlb_slave_info {
 			 * are the entries that were assigned to use this
 			 * slave for transmit.
 			 */
-	u32 load;	/* Each slave sums the loadHistory of all clients
+	s64 load;	/* Each slave sums the loadHistory of all clients
 			 * assigned to it
 			 */
 };
 
 struct alb_bond_info {
 	struct tlb_client_info	*tx_hashtbl; /* Dynamically allocated */
-	u32			unbalanced_load;
+	s64			unbalanced_load;
 	atomic_t		tx_rebalance_counter;
 	int			lp_counter;
 	/* -------- rlb parameters -------- */

---
base-commit: 447c9303942c439a117d9b76ce6d6e2116b38ee7
change-id: 20260806-bond_overflow-ac6a6a78d6a0

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

