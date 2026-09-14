Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7D1435EF0;
	Mon, 14 Sep 2026 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378062; cv=none; b=PC4hIYKGomHDCMOazWQasRTBvOH0MBdaPwnM4Y+VxA9ybckXzUYerJGCQr+BzMic1oqzW+O9LZlEARjQvOEvYotCvQIKi3XwVsndRAn67XpHZ4W5mY8TbE1G1lhfk2e6oJJs6dKQUdMlDjvj2mToJML3wokQaC0lEAcSBANzuj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378062; c=relaxed/simple;
	bh=uyXY0JhqdY04u4gvXcwlNliDhIT7V48/3Ky+SA0t1gU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cKRK38ef7w3KxhlQqbIhzwz5s9206ajgBzCph8VfnzCzGlHrBggrvQCdkc/AaRr1VWt9xFcxytU4ATjc7q3ZhS2xTcaMe6KYwfgcVVHiiBt/RTnqgM42R8O2vT1a3SnRrp+diM+D7V4ew5ZqfCQZ081T7pSqgNMZIa4VEyRDfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=CTYtwTSb; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="CTYtwTSb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=V4
	0l4BEPJi0x3bSRqBmren6BviAFly+T5dJ5Wff1QSU=; b=CTYtwTSb/XrkAUZ6sT
	2oi6wGcZyRf7o/jJbigd/pfNqv5wATq2VvLjnL0XS1Oo7ZMXogW7ROfSp1Zw6Jb5
	M5vSFSE0AAANSuoHnLG4BjIcJHBFSX/BD1yhF4TnRm9TGXRaN89JhM3c9/C66GCF
	Ix+Xs5VuHqKTk7vxEmBPyTm08=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCkvCgD337LEvadqgTuQFw--.32944S2;
	Mon, 14 Sep 2026 17:26:28 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH] ixgbe: do not busy wait in ixgbe_devlink_reload_empr_finish()
Date: Mon, 14 Sep 2026 17:26:26 +0800
Message-Id: <20260914092626.263886-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCkvCgD337LEvadqgTuQFw--.32944S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW7AryUuw13JF1rAr1fWFg_yoW8tFWrpF
	WUWasayw17Xr4Fg340vayUuF9xX3WagrW5GFyfK3y5C3Wktw1DKF1rtFyaqrWUArZ5Wr4I
	qr1Y9rZ5Aan8Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULFxUUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlAQl+2qnvcRXfwAA3S

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ixgbe_devlink_reload_empr_finish() is the .reload_up devlink operation,
so it always runs in process context with the devlink instance lock held.
Its polling loop delays with mdelay(500), i.e. it busy waits for half a
second per iteration and, because the loop bound is 20 iterations, for up
to ten seconds with preemption and interrupts to the timer subsystem
effectively blocked on that CPU. That is long enough to trip the soft
lockup detector and to stall RCU grace periods, and it keeps a CPU fully
occupied while the firmware performs the EMP reset.

Use msleep() instead, the loop does not need to be atomic and nothing in
it holds a spinlock.

While at it, rename IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC to
IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS: the value counts 0.5 s tics, as the
comment right above it already explains, so the _SEC suffix is
misleading.

Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index cf8908b82f8a..7ce0a0cbf9d2 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -430,7 +430,7 @@ static int ixgbe_devlink_reload_empr_start(struct devlink *devlink,
 }
 
 /*Wait for 10 sec with 0.5 sec tic. EMPR takes no less than half of a sec */
-#define IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC	20
+#define IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS	20
 
 /**
  * ixgbe_devlink_reload_empr_finish - finishes EMP reset
@@ -460,11 +460,11 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
 		 * may be not cleared yet, so begin the loop with the delay
 		 * in order to not check the not updated register.
 		 */
-		mdelay(500);
+		msleep(500);
 
 		fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
 
-		if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC)
+		if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS)
 			return -ETIME;
 
 	} while (!(fwsm & IXGBE_FWSM_FW_VAL_BIT));
-- 
2.25.1

