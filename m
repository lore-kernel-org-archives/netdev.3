Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184496;
	b=1uE+ml2VPztm1Fim46S0RbJ2T2hVQFaPnwfax2pb1xjX9kK+d5nWAP03aQl/jxdIj/IK
	 Q4VLrNQwtQ0iSdE+VItzpN0k+xUvvlnE6lVNNIV47xdU57R0+JPwE4hAeIRZgMjXGSgI+
	 /+BqjrEfYVpsIofnJ62kCQb/lgnXyiTK0s7wzWPJbm6po8b7d8k3ZwzKJsZcGut+qsLWO
	 gLWYgFvoHZf7b9mcwwreEPUcAsGaQCJ+8cYcLqklTlHelBD5QoEM7VW649zAakBsxr0Qe
	 ESuC8CFYzLGjDKVtiR74o5GyDDNiz1OhsAbDPAJyj2nLUDByTMryVQMkFMSm4uJqrTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TqToxHGseKlj0tkEHKdMJ5cBD8pcWKq5e5BUUFio/f0=;
	b=q/x4q7xPHGMV1l5FvKyivmZbaSPSfpg7A/gRZlRCJ/LVAdOP3edau1xw9OG9EvLsVB3p
	 FtXYC829y2CLN2vyiGzJKS8pkmo3Q+Rci+QUl+FVGMnBsLZIvKtxEEKvXKLTaM3R23XiB
	 UGhLRPsGkpG08LQ0PQ8YBqNu3009htSwh+sjT9qtJhDY76zwFU1EswHjLTB0kSmjzzsdS
	 2WgdCX12GGVQTCPl19HJ/QHuWNtXN4UTABG2m/sbAjB3Q3TVCLlrQqxGmUgdWzlIi58kn
	 YlwOuB+ojROdRgdKTNNAekYv+9Whqv+GMj4qDXFD8nUn6uMEVNmCZp3u0RlOw3nkVEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWjkcDZf;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F06606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54F06606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWjkcDZf
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a214af2076so6961105e9.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 03:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793184494; x=1793789294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TqToxHGseKlj0tkEHKdMJ5cBD8pcWKq5e5BUUFio/f0=;
        b=rWjkcDZfa8l/QrqYuCB4IiPqaoALxFa8BxSgqikCr4APRtuOEWR6vTL4HUoN9wyQal
         c9XsMmja1d7cTUI7NjrWrzLVu5Nyh/W+rNet6GXyClVb8L9GXjZLV0YCCz4RgGYL1UAV
         lNTVjhXjMaFkSSjAUnYR7bhztR/X+foRo6KyCP2uhbvM8nxOQN8JL5MpjD+KJm6vvX3+
         gbjWGKhqkq3sTkm2yl8elyjaPRlfQt09GzcN7qPLnGgmiGaSkmVrSoTi9AuYLnt+qfW7
         Gz//Ne0HP2vInQaJAYPCTilSXpDP2xLnbYw+69VorlHqdAoP2yWop2tX25qmr9dypc74
         PdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793184494; x=1793789294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TqToxHGseKlj0tkEHKdMJ5cBD8pcWKq5e5BUUFio/f0=;
        b=XI2JdvoWgE5c32D0JdGlJJZk4w3rJOJQOzx8XNZlQkQYkAUrBQAIbFJAXAlTtbTvFw
         Ekq/ykgQvcf3VRG6gdxcRScw+cPVuoa5J/fw+eryPH3SAK3ynA2ovDZWRUjchxLcw7mo
         EU5bJb3ucWGiyazE4I47hFI1E3BMdqLzNv1dgWKlfyPIXskpckz2fISFdhplzfELYt3p
         tgHWpc4/KJpndToWqilqwsrfQjWAEmKVl35INkvyyy59D7/PBZZAlVFJdgTluFX5qkWO
         qCC5n01Hf1Cc0dABWUWDRBZvXPXVPNk1CacIcnqXyXiaWesK1bsXHPyi71VMe3UKjK3L
         GV0g==
X-Gm-Message-State: AFq9FYKnRt9VwCOUMDX1HA2XbDRSDxlKcgnYyJXeZUQHRQoM7kL9BrOZ
	cSGoUo63cpHbCr6FFRVfZtSLOwx77HVsXwsejQvY2MeBV0GqH/bbH5DAarwSuA==
X-Gm-Gg: AYBFou3bomWeabPCSPBqwfMdcsRwml4I4LmtZIDiSmDBYI45xbhckc3WHxuG0d0kzmg
	SsOD3IqmMxpd5gUJY4Ycz3H2C1Vub11HQ7/cxomZ3TOXBDjrVPUJRvabfw1yoJp3H5FEUGFGkvf
	CfCX8TctXkzHAQWz5msvdoRnYODq+8d9LdfalBHOYOh+36+yT35Osi4idtmt7SDiURxQhwVJ+CS
	IpLN03wZXyUmgTxXs10CDrv8d/TEfdKdofq3fO+sgetmSqnTHi8SP70ArxDwzjGBObxx4/F1UdG
	dSnoPfaZBxHXvV03i87WmTp3yzNKe2UMhBmwxP5TDIHXkT2BVuy7akVIVY+mvMyfBvCiGbVHvPB
	2kGYvYZiF2Ffrw8RQJFygifxRG8HMbY+7muRAvtLiwaT+F0mOAH9hzSTi9ebe2Gmlf8eh/gvQZl
	rOqaUR4+uelPl0xHuhHmLD276n9mGb6uWkD7Dbd50XnRzjN3Lop8CJ8fcUfxbSh+TETgis7ydSn
	UcQqk3I1EfujEB9x/pyZrj9jbdpzybwHwzxCnm3sQpEvO/Vodpgq6eET21/FsqDOUemHYV3d2SM
	lSYQAIdwwU36SFqopcR4ch2t0DrSl37vSOvsXwtVn8a/Dw==
X-Received: by 2002:a05:600c:4692:b0:4a2:167a:c939 with SMTP id 5b1f17b1804b1-4a9667756c9mr37809275e9.21.1793184493557;
        Wed, 28 Oct 2026 03:48:13 -0700 (PDT)
Received: from stukan.bbrouter ([46.201.91.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a9733d48b4sm42241755e9.0.2026.10.28.03.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 03:48:12 -0700 (PDT)
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
Subject: [PATCH net v2] bonding: fix missing down path on speed/duplex failure after FAIL->UP
Date: Wed, 28 Oct 2026 12:47:57 +0200
Message-ID: <20261028104758.299129-1-timur.stukan.linux@gmail.com>
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

Fix this by not committing UP proposals in bond_mii_monitor(): UP is
already committed by bond_miimon_commit() once speed/duplex are valid, so
leaving it there means slave->link still holds the previous state at
that point. When speed/duplex update fails for a slave coming from
BOND_LINK_FAIL, take it through the regular down path, including
failover. Slaves coming from BACK/DOWN keep the current behaviour.
The down path is moved into bond_miimon_slave_down() so both callers share it.

After the fix:
  bond0: (slave enp0s3): failed to get link speed/duplex
  bond0: (slave enp0s3): link status definitely down, disabling slave
  bond0: (slave enp0s4): making interface the new active one

Fixes: 1899bb325149 ("bonding: fix state transition issue in link monitoring")
Signed-off-by: Timur Stukan <timur.stukan.linux@gmail.com>
---

Notes:
    Changes in v2:
    - Drop link_prev_state. Instead, don't commit UP proposals in
      bond_mii_monitor() and let bond_miimon_commit() commit them after the
      speed/duplex check, so no extra state is needed (Jay)
    - v1: https://lore.kernel.org/netdev/20261022103821.89552-1-timur.stukan.linux@gmail.com/
    
    Sashiko pointed out on v1 that the 802.3ad netdev notifier can set
    BOND_LINK_FAIL on a slave that is already down, which then goes through
    the full down path again. That is pre-existing and reproducible on an
    unpatched net tree:
    
      ip link add bond0 type bond mode 802.3ad miimon 100 lacp_rate 1
      ip link set enp0s3 down
      ip link set enp0s4 down
      ip link set enp0s3 master bond0
      ip link set enp0s4 master bond0
      ip link set enp0s3 up
      ip link set enp0s4 up
      ip link set bond0 up
      (wait for LACP to settle)
      ip link set enp0s3 down
      ip link set enp0s3 up
    
    "link status definitely down" is logged twice and enp0s3 ends up with
    "Link Failure Count: 2" instead of 1. I will send a separate fix for it.

 drivers/net/bonding/bond_main.c | 58 +++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7019e5d8fdc8..9bafcddbb453 100644
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
@@ -2807,10 +2828,21 @@ static void bond_miimon_commit(struct bonding *bond)
 			err = bond_update_speed_duplex(slave);
 			netdev_unlock_ops(slave->dev);
 			if (err && bond_needs_speed_duplex(bond)) {
-				slave->link = BOND_LINK_DOWN;
 				if (net_ratelimit())
 					slave_warn(bond->dev, slave->dev,
 						   "failed to get link speed/duplex\n");
+				/* Coming from FAIL, the slave is still in
+				 * use and may be curr_active_slave, so take
+				 * it through the full down path. Coming from
+				 * DOWN/BACK, it was never brought up, so just
+				 * revert it to DOWN.
+				 */
+				if (slave->link == BOND_LINK_FAIL) {
+					if (bond_miimon_slave_down(bond, slave))
+						do_failover = true;
+					continue;
+				}
+				slave->link = BOND_LINK_DOWN;
 				continue;
 			}
 			bond_set_slave_link_state(slave, BOND_LINK_UP,
@@ -2839,24 +2871,8 @@ static void bond_miimon_commit(struct bonding *bond)
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
@@ -2919,6 +2935,12 @@ static void bond_mii_monitor(struct work_struct *work)
 
 		if (commit) {
 			bond_for_each_slave(bond, slave, iter) {
+				/* UP state is committed by bond_miimon_commit()
+				 * after the speed and duplex check, so that it
+				 * can still see the previous link state.
+				 */
+				if (slave->link_new_state == BOND_LINK_UP)
+					continue;
 				bond_commit_link_state(slave,
 						       BOND_SLAVE_NOTIFY_LATER);
 			}
-- 
2.43.0

