Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793545373;
	b=hpbSKwg7kv7gw196QEx169+rlYc1m65BF9hjIABSHnquTDugKJaPJd9ztOX1caxbkOpF
	 pFx0ZKQtKzi0jHgTCPZPW0dPNctRcHzolphEpIhsgC02jo4qaoJ+pFaxhnvjOdAzpkR4p
	 cL+oALkTFX7kcF5DLbnBpV2XOg6PdPQcZS1vkjd5vfnen2HiK3pLLBy2gdc49FYtFJ1NY
	 1R0p/LyMycOsivpBbievvp3FY2u/0FUfT/8gLdQKm/ZskQYfZ5iDePG5Umthxla1EKRI+
	 utyZjdHfpep6SkopioEU4BK72w7ZY3YijTws1UgeOfUuX9N2/nzBkKZVnyitjE9sTeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793545373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=n526eF796VsVK0te1y2BUvy07jmqYe5zbpzfr00FB+I=;
	b=TS+Cdpa5gwRUb0sVRhW//Z02a5tx+ianH/kUiZ6dm9YsDkdNfyKHG02tEbE8G583j2iH
	 bvYISvPADgcbO4b9t0lWpf1YgZQ4rQVR6p6dpIs23TXMK950gVDJ87ZnX5b3IDJsi+WUF
	 g4J7oJ8WLp8Z7jQzGu2BSS+TANo9q0yHhXE1fkrC+T0IwHfhVruBlHptXefsvtkq48JBq
	 GVE8tsrifRbZAZwc5z3FElUBH4acKpXx2IbO3+2h7tKgWmcbpXJP3mEKYRVNEo9I8OF5U
	 CGILdslqOLTjtpbt9yb3VLSoOqyu/grVEt1D6b238QNs/+4H62W1JKrC1w6YTLjfbFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WYISqS9W;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3235A606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 15:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3235A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WYISqS9W
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so13913245e9.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 07:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793545371; x=1794150171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n526eF796VsVK0te1y2BUvy07jmqYe5zbpzfr00FB+I=;
        b=WYISqS9WQ40IsqY5xG5yW+LDrBE4+wMrDHEK0lqbYfZtkPi/rdsEVlbJum4eaRRoeS
         PwBPe9Gl86JgrSt/OCkxoJQpRyH52Y2+NmJzi21fscZI6yOhbJOgO2sPeqlq1c167M/i
         womkYkjs+WKe37jK2L7Ph4m2QRiEqp1Jg/yuhs2V16YBFYfddEtMOXJ+ToqA+lk7dgXI
         vUEvo5Khe0akIDRvkhrlETegbz2ATOhMnwUHN6mgc/cZz6ciMYJNWP4Utkdqewt9y6tB
         lCfG5e5wlmk5UUV19HfvTr6fBbWZkX9nOqwCsv2WF0B9rH27mZyyuHVIqSQoa6i6Znkc
         V0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793545371; x=1794150171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n526eF796VsVK0te1y2BUvy07jmqYe5zbpzfr00FB+I=;
        b=TcobM55l4sx1HUBKo5V2tPrgPLZ3eZouk/G8nqxhozXW0OWnRdf6G6Wf8YFYdd4h8K
         lqgLyZH0d4jtI57+4WfhPpyQb4ttaSHsKUIt79hLvVjh6rmDju9ZYHCMIEoOT6n32Pmj
         lm+wW0ct2XM9YLh4Z9ALK28ZLPRofz4nPofayA55LcvYc6Gx/4YHlqHjsdbeCf/33VpZ
         XNOOfLbnc6Fy++93LNK77RrXQyLzgNGAQeWyhmG+m/7eAdYDKf5c6ClWVFNmB82KSWJy
         UQbhDDgr8yS0OHsAY9nN/zPHzaDPqcSS0RfGYIPHOOrdq4si/bNMaOerC22MXZeU/x8C
         ydcQ==
X-Gm-Message-State: AFq9FYJAQeKiYa01qr8i+5lXgKqQCN6Fpv85pT4PbzL5eCdttKKHh+P3
	o8dGA4FoOdVzpEd2Fnq1bowqF1kYJ3rszYOISx54jhHnDvDd6J0XgZt79GaggQ==
X-Gm-Gg: AYBFou3I2sTtant7OnMx4uRcbU/I3mvpBmEIMCXv5e4tfO71wM2qkPgnSEOeMOqCZxy
	w/4FDQAQlwn+/tr4zRPkzEBU57hnksiJgY3IzgD3NUsoT9uOvOKa38O4cY810URqb924V5k2Foi
	+EAfHL8b4pBlwHDJ+TQLg1wVuhr46QHvOHgSl7N56tmhALIgfe18eHkm9npBxg9GUAdv+rmqTwZ
	DHvH22VDO0Qjdc842IDcCHYKhvDJvd2w5opLjBlKfvsqQ6qOUDba6mfRxeWylSXllau7J6gJgfr
	lzG++jpC+kajDarDdmsjBQQ6bfBiLm/XuTk7Fw0Dt/tqF3zQePdT2lO6gwjdtYmGtdg7rrc0yhY
	Ioy4zEw6CF93gLAK6Mz7zEGk8+2t0xg1aZyJ0Y02BS7aW8uv4UNkzmjBB9mKpTiyerJH88EYi94
	Cr/O13KQtYYvFGLrNcHjs4ie9lqL9VByMkNAnQran+pmGUwVhMLnPqistiZjjKbFDmI41XDjjHC
	On4KgIRq2tiBWRhXWCZAoGtFu3FSrl4oihpTQUFGnU2cj4TfzTfv7TTG3nJDeD5i8xOEhfd3hUt
	ohbdiEnf6QzDau77SRVUhXj7c6baO7aa6zALiUDWMLcK
X-Received: by 2002:a05:600c:19c8:b0:4a3:59c9:a743 with SMTP id 5b1f17b1804b1-4ac1913ef8fmr177099825e9.27.1793545371461;
        Sun, 01 Nov 2026 07:02:51 -0800 (PST)
Received: from stukan.bbrouter ([46.201.91.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09fadb75sm135018375e9.3.2026.11.01.07.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:02:49 -0800 (PST)
From: Timur Stukan <timur.stukan.linux@gmail.com>
To: netdev@vger.kernel.org
Cc: Hangbin Liu <hangbin.liu@linux.dev>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Timur Stukan <timur.stukan.linux@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] bonding: fix missing down path on speed/duplex failure after FAIL->UP
Date: Sun,  1 Nov 2026 17:02:39 +0200
Message-ID: <20261101150240.66292-1-timur.stukan.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bond_miimon_commit(), when a slave is proposed as BOND_LINK_UP but
bond_update_speed_duplex() fails in bonding mode that needs speed/duplex
(802.3ad, tlb, alb), the slave is set to BOND_LINK_DOWN directly. This
bypasses bond_set_slave_link_state(), bond_miimon_link_change() and
failover.

This is fine for slave that coming from BOND_LINK_BACK, which was never
brought up and is not in use. But since commit 1899bb325149 ("bonding:
fix state transition issue in link monitoring") the commit phase also
handles BOND_LINK_FAIL -> BOND_LINK_UP which means a slave that is still
in use and may be curr_active_slave.

If the link recovers within downdelay and goes down again before the
commit phase reads speed/duplex, the slave is silently marked down while
remaining the active slave in worst cases. In alb/tlb the bond MAC stays
on the dead port, no failover happens and TLB/RLB state is not cleaned,
so the bond stops passing traffic until that link comes back even though
other slaves are up. A non-active slave is affected too, in alb, RLB
clients assigned to it are not reassigned and become unreachable.

Reproduced in tlb and alb mode with miimon=100 and downdelay=10000 by
flapping a slave within downdelay and dropping it again before commit
(a longer delay was added between inspect and commit to make window
wider and easier to test):
  bond0: (slave enp0s3): link status down for interface, disabling it in 10000 ms
  bond0: (slave enp0s3): link status up again after 3400 ms
  bond0: (slave enp0s3): failed to get link speed/duplex

procfs then shows the active slave with "MII Status: down" and "Link
Failure Count: 0", and all traffic is lost.

Fix this by dropping the loop in bond_mii_monitor() that applied all
proposed link states before bond_miimon_commit(). bond_miimon_commit()
now applies each state itself: UP after the speed/duplex check, as it
already did, DOWN in the down path, and FAIL/BACK directly. So when the
speed/duplex check runs, slave->link still holds the previous state. If
the check fails for a slave that is FAIL or UP, take it through the
regular down path, including failover. DOWN and BACK slaves were
never brought up and are still just reverted to DOWN. The down path is
moved into bond_miimon_slave_down() so both callers share it.

After the fix:
  bond0: (slave enp0s3): failed to get link speed/duplex
  bond0: (slave enp0s3): link status definitely down, disabling slave
  bond0: (slave enp0s4): making interface the new active one

Fixes: 1899bb325149 ("bonding: fix state transition issue in link monitoring")
Signed-off-by: Timur Stukan <timur.stukan.linux@gmail.com>
---

Notes:
    Changes in v3:
    - Drop the loop in bond_mii_monitor() and apply FAIL/BACK in
      bond_miimon_commit() with bond_commit_link_state() (Jay, Hangbin)
    - Also take the full down path for a slave that is already UP when
      the speed/duplex update fails (Sashiko)
    - The 802.3ad notifier issue reported by Sashiko is fixed separately:
      https://lore.kernel.org/netdev/20261101145653.63648-1-timur.stukan.linux@gmail.com/
    - v2: https://lore.kernel.org/netdev/20261028104758.299129-1-timur.stukan.linux@gmail.com/
    
    Changes in v2:
    - Drop link_prev_state. Instead, don't commit UP proposals in
      bond_mii_monitor() and let bond_miimon_commit() commit them after
      the speed/duplex check, so no extra state is needed (Jay)
    - v1: https://lore.kernel.org/netdev/20261022103821.89552-1-timur.stukan.linux@gmail.com/

 drivers/net/bonding/bond_main.c | 63 +++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7019e5d8fdc8..d6b6c125470f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2779,6 +2779,27 @@ static void bond_miimon_link_change(struct bonding *bond,
 	}
 }
 
+static bool bond_miimon_slave_down(struct bonding *bond,
+				   struct slave *slave)
+{
+	if (slave->link_failure_count < UINT_MAX)
+		slave->link_failure_count++;
+
+	bond_set_slave_link_state(slave, BOND_LINK_DOWN,
+				  BOND_SLAVE_NOTIFY_NOW);
+
+	if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP ||
+	    BOND_MODE(bond) == BOND_MODE_8023AD)
+		bond_set_slave_inactive_flags(slave,
+					      BOND_SLAVE_NOTIFY_NOW);
+
+	slave_info(bond->dev, slave->dev, "link status definitely down, disabling slave\n");
+
+	bond_miimon_link_change(bond, slave, BOND_LINK_DOWN);
+
+	return slave == rcu_access_pointer(bond->curr_active_slave);
+}
+
 static void bond_miimon_commit(struct bonding *bond)
 {
 	struct slave *slave, *primary, *active;
@@ -2807,10 +2828,22 @@ static void bond_miimon_commit(struct bonding *bond)
 			err = bond_update_speed_duplex(slave);
 			netdev_unlock_ops(slave->dev);
 			if (err && bond_needs_speed_duplex(bond)) {
-				slave->link = BOND_LINK_DOWN;
 				if (net_ratelimit())
 					slave_warn(bond->dev, slave->dev,
 						   "failed to get link speed/duplex\n");
+				/* Coming from FAIL/UP, the slave may still be
+				 * in use and may be curr_active_slave, so take
+				 * it through the full down path. Coming from
+				 * DOWN/BACK, it was never brought up, so just
+				 * revert it to DOWN.
+				 */
+				if (slave->link == BOND_LINK_FAIL ||
+				    slave->link == BOND_LINK_UP) {
+					if (bond_miimon_slave_down(bond, slave))
+						do_failover = true;
+					continue;
+				}
+				slave->link = BOND_LINK_DOWN;
 				continue;
 			}
 			bond_set_slave_link_state(slave, BOND_LINK_UP,
@@ -2839,28 +2872,13 @@ static void bond_miimon_commit(struct bonding *bond)
 			continue;
 
 		case BOND_LINK_DOWN:
-			if (slave->link_failure_count < UINT_MAX)
-				slave->link_failure_count++;
-
-			bond_set_slave_link_state(slave, BOND_LINK_DOWN,
-						  BOND_SLAVE_NOTIFY_NOW);
-
-			if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP ||
-			    BOND_MODE(bond) == BOND_MODE_8023AD)
-				bond_set_slave_inactive_flags(slave,
-							      BOND_SLAVE_NOTIFY_NOW);
-
-			slave_info(bond->dev, slave->dev, "link status definitely down, disabling slave\n");
-
-			bond_miimon_link_change(bond, slave, BOND_LINK_DOWN);
-
-			if (slave == rcu_access_pointer(bond->curr_active_slave))
+			if (bond_miimon_slave_down(bond, slave))
 				do_failover = true;
-
 			continue;
 
 		case BOND_LINK_FAIL:
 		case BOND_LINK_BACK:
+			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
 			slave_dbg(bond->dev, slave->dev, "link_new_state %d on slave\n",
 				  slave->link_new_state);
 			continue;
@@ -2894,8 +2912,6 @@ static void bond_mii_monitor(struct work_struct *work)
 {
 	struct bonding *bond = container_of(work, struct bonding,
 					    mii_work.work);
-	struct list_head *iter;
-	struct slave *slave;
 	unsigned long delay;
 	bool commit;
 
@@ -2917,13 +2933,8 @@ static void bond_mii_monitor(struct work_struct *work)
 			goto re_arm;
 		}
 
-		if (commit) {
-			bond_for_each_slave(bond, slave, iter) {
-				bond_commit_link_state(slave,
-						       BOND_SLAVE_NOTIFY_LATER);
-			}
+		if (commit)
 			bond_miimon_commit(bond);
-		}
 
 		if (bond->send_peer_notif)
 			bond_peer_notify_may_events(bond, true);
-- 
2.43.0

