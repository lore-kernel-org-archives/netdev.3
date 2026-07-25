Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D262264A3
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785022781; cv=none; b=HibNB5kQPglJNKOw11wkxFWeXRHK1jV/pxBscWGcPS/wvmNw/R5wl1qDnl2xNzscY8RNWOmOSoNQZRgft5a70w3CmMJdFUAecIaq1v/+7U3wjVtKQda2LYKjdd6DUYSW3Al3uumboiLw15RzgQgr6Ic7vH+l5fC30A2xJqzpdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785022781; c=relaxed/simple;
	bh=T6H25QsYHQAyhvmJ1wAtoaniJGfe744N7cuWFOaowmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFt1s8VYnuJcl1S+obXO9nkU8i7y0BJz1VSFEbp4PZsOA4QJiesb8AexX2NbpSMms2b65WsWohQeMr3whYBLmL0ixyJ5jjqdP0B59zYUb75YtQU+NxbGBezX9y2DwyBzmK+25uXPqnrU4395BfQbQ9VgYSO3YySKOgqJSnid3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=pG4hkeW7; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="pG4hkeW7"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso909857a12.2
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 16:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785022778; x=1785627578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JC9ZdVFTf7Xa7maY1R4coF7T4mnzu0aLeN48WX3SCr4=;
        b=pG4hkeW7ZqkhIdhj1WGMZp5PBal4cjyzFq2TbSX/ul3tSg0z337j7j+T4SGM7TjBVO
         3Ze28wMpNoOII/QXY5MouVcj6xdHwcGusRs0QZN0hyh3Ut4WbNCsjDTw317Mfuy+3/Zd
         3iydanlzowtVjWg4qCU5FgxrM8iN7BEba/VvWRurUC1uZoNyxj9OZAlA75t1xQwlc5WX
         F/A/hPKx485DlTT2qGFbz2cXfZXddtoq2IBiB5U86p1UeXiU2LjEfjNkOvIN4bIZ5yYz
         z2wU7axDkpyZwRZHxWf+oz0dmyiTmqbL+2mm9hs4mNQ3LXosVhialdLBp9APkkPfbVjh
         y8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785022778; x=1785627578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JC9ZdVFTf7Xa7maY1R4coF7T4mnzu0aLeN48WX3SCr4=;
        b=TEpeYrqsfALnoITjTE30PR1tG0LHUx26gt0XWZjZgL4vrNikb4oWR3lHufL8ioUwsP
         u2ttgcBKIOagDHSjHdAbZEj/UQ2c3Aqx2U3zORwxjDxd2aoqyDImrardF8o/s+KGxTMP
         Rm7v9ry4FYZXrHm+KjBsxOA6MlYvugM6LUet0oz5R9FiXfLNEr0pBXB7u5xopkDFvcKg
         /wRSnYvtWlGQx30ZSDqETmNJz83qkbmGF+HKkJOXn963ruPGcpxSWJGrVpbf08wzgHXH
         SiQY+V5smVcX4SzGvkERKd6kuyvcYQxSF2OdhXJtKTNJZdHKJV0WU0M9tjiHZvjaG5lu
         mpiQ==
X-Gm-Message-State: AOJu0YyYx1TNDlARhuqtmaSHTVc3We2yOU5bhct7YMpYwjFgAfZMVJKA
	Mb/wxx88fd56VXuwpCo4Uojnh/2+ns4Gsw2EjZDTXUsR+A7AFi2XI+4NRA7zyfLi9A==
X-Gm-Gg: AR+sD106afuuUVxIdiHJH82qDsK9jI/I5xs0283SScqA3ZD7nU7/6kre5E2PRykdtHx
	kk7QNzfHXkbroXQm+DbYVUU0kfd83ImA09Q61XnqzM7vg4V0Fs2jB5gcn6HvzYcVxsmcGoc2aH5
	yW3BAWc7RnmOgEh04kDSJsszUHZdKZqOl6JJD5aDcCqXKqqC+7TKwUGB0iKPnCthHcrjubiT/oj
	IWLroiTjrbSaNWqWcM1MYfo75VAYseZvf1eVOiA7B9JD9auwhq6s3i7SK4O2Ehb0V9hPEjtKVIX
	IkEPmqxpX3zBZVAaFsxgAEPaPJLmZ/0T7EVCXehegUa7NflRGV61GmYKi9Hx9T0/p3vTEQ6nK54
	iCAujlYfG2gBFpry+3Ex6I065NED/TbwFwk6/YvXTd/OJpWW+ceJ7GXy7k8SWRnS+aFIaFhHMZB
	AKQ/fIvoI=
X-Received: by 2002:a05:6a20:9146:b0:3b3:4406:202c with SMTP id adf61e73a8af0-3c67d9b42admr3471585637.10.1785022778488;
        Sat, 25 Jul 2026 16:39:38 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13014d27sm40613277c88.4.2026.07.25.16.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 16:39:38 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: razor@blackwall.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net v2] bonding: alb: re-check primary_is_promisc under RTNL in bond_alb_monitor
Date: Sat, 25 Jul 2026 23:39:30 +0000
Message-ID: <20260725233930.2957317-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bond_alb_monitor() reads primary_is_promisc under RCU, then drops RCU and
takes RTNL via rtnl_trylock() before undoing the promiscuity it set on the
active slave. In that window the active slave can change under RTNL
(RTM_DELLINK -> __bond_release_one() -> bond_alb_handle_active_change()),
which already drops the promiscuity and clears primary_is_promisc. The
monitor still acts on the stale decision: if the slave was removed with no
failover, curr_active_slave is now NULL and the deref faults; if it failed
over, the stale dev_set_promiscuity(-1) underflows the new slave's
promiscuity counter and pins it in IFF_PROMISC.

  Oops: general protection fault, probably for non-canonical address ...
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  Workqueue: b42 bond_alb_monitor
  RIP: 0010:bond_alb_monitor (drivers/net/bonding/bond_alb.c:1600)
   process_one_work (kernel/workqueue.c:3322)
   worker_thread (kernel/workqueue.c:3486)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
  Kernel panic - not syncing: Fatal exception

Re-check primary_is_promisc (and curr_active_slave) after taking RTNL so
the monitor only undoes an increment it still owns. The other bonding
monitors already re-read state under RTNL in their commit phase
(bond_miimon_commit/bond_ab_arp_commit); bond_alb_monitor() was the only
one acting on the pre-trylock decision.

Fixes: d0e81b7e2246 ("bonding: Acquire correct locks in alb for promisc change")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
v2: keep vars' rev-x-mas tree order

 drivers/net/bonding/bond_alb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 2d37b07c8215..839f7482dc18 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -1534,8 +1534,8 @@ void bond_alb_monitor(struct work_struct *work)
 	struct bonding *bond = container_of(work, struct bonding,
 					    alb_work.work);
 	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
+	struct slave *slave, *curr;
 	struct list_head *iter;
-	struct slave *slave;
 
 	if (!bond_has_slaves(bond)) {
 		atomic_set(&bond_info->tx_rebalance_counter, 0);
@@ -1597,9 +1597,11 @@ void bond_alb_monitor(struct work_struct *work)
 			 * because a slave was disabled then
 			 * it can now leave promiscuous mode.
 			 */
-			dev_set_promiscuity(rtnl_dereference(bond->curr_active_slave)->dev,
-					    -1);
-			bond_info->primary_is_promisc = 0;
+			curr = rtnl_dereference(bond->curr_active_slave);
+			if (bond_info->primary_is_promisc && curr) {
+				dev_set_promiscuity(curr->dev, -1);
+				bond_info->primary_is_promisc = 0;
+			}
 
 			rtnl_unlock();
 			rcu_read_lock();
-- 
2.43.0

