Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792665520;
	b=IFUTB4ru0WBImBTCya+tDb4nGMl69rUDeNKnQdSp77wYUVrCWzf/7sp0Ad5ohhr95Hqn
	 vqOo1tCd/lA+rsV+ROcVug5tPXFHOK6Pcv+Jg6cJM/XtxMLUWBRathBoXDB1TUKoan7oc
	 VxLvLm8WQkvLthuN1GVl45bVYx3/T5rQYHqua25RZoSuKDtioktFgp8BVFpMuV+v8iHZb
	 PovnaPtTPFLqKAY9nRYB4rez1N8ieyypuXKGcXoto+NajN7I/XnzWRiFaqj+6zOvKfZIR
	 7Uoc8Asmnwkq9AlEY5e++eO2BU1TGqKnJba8ckvSTSjGJQOkguwmv43lKo6fe8DgUUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pVMLwxSCpD/ytFzS+nn7Bl0k4R6JGoce3kfN9Q3T/gw=;
	b=YveZkmra0e9La/5BHMzEAsJMJNWFpWGDeOTYPzpdhbxMFWREn4f7OE/Iqqy5b9hqV3p4
	 RlfDBb99Eupz2SnM7DnU1eXRfgoKgM++fOBcu+5OGFyDF94X0xsQXE8ZwLLa4b7UquByx
	 2rKa5aBMD6uZ0CUcbJrriUlxXvQ6NLKE25Xjd+3re2Bjs2uC5VMENiriI/tDTDwHbxcHm
	 OVWNiUiMkIZ/b+7v0rS2B4pA4IXRJoY51hFHMCpge4WBHbHCW0HF5PFS/HkFISUYkDdbv
	 f4kLdHOg1YD1Yqc+PoGtw2qzyrB4MKILYt1dzNIEkharG4xTEaGlP5kkHNECfCaxuIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UtzxzJsb;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776FD606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 776FD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UtzxzJsb
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48df8fe8513so1587746f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792665519; x=1793270319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pVMLwxSCpD/ytFzS+nn7Bl0k4R6JGoce3kfN9Q3T/gw=;
        b=UtzxzJsbudrr2qENNOpIb/DQSaek2Lte0iA7WVnmAhe++JCzDY4NETk3cY5qG1iF28
         jD00fXy5tX9Bia9+j25Cvn1nmc92x/8ejbXORmkNUH4smbpOF9RDErn+77ON+zG9B3O6
         Xt9SFf0RdU2L4sY9jljEiY2J8B9tGEyJUjlalWRODeYV2kD4XrxgZU1nNnMOVq3cDiyM
         aoCiMFU7cfHKlawnMe7yn9l3/s9QP+whZGlTynnKtlAhARncxOPux0u6gLAO8IRH0HDQ
         soflXpobOeGb+BNCIK28cOMg4N7ahUtPi2VaGs0vUbuE54PO/BUaMt0Ivc4jx+4oa4Rd
         zMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792665519; x=1793270319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVMLwxSCpD/ytFzS+nn7Bl0k4R6JGoce3kfN9Q3T/gw=;
        b=jFixvDFr7JvIESrVjSqXdG7m9kWF76HvVRjAB4Qyod5kI6+zJ+hCXKjimQyWSrvDt8
         PCKOdxrJf7OdAumUyTbXs/IhCIg+s6HkHa2IbU/VO9Oz/BKQy7qOYywf/ck7LuIy92rb
         bftl9iVcT35uuOJsAFFVkHDUxVbh8N91Qb9TQo5wkBaQduLMgHvLkSa926PUcklOgG5G
         RbY7EuBx8LyEz/uLktxYFLfVm+wchO41rdJEnGv8iEMTDdFteDeUC4DfKMmkQjD2ZzHe
         w1GiuqMQBzD5z4HA6YFkEnh7n1bKGhNvoGaw7yJAs6IWuWrFcPYfWGhdMB14w7tCKVum
         9DSw==
X-Gm-Message-State: AFq9FYK/KGZHEesYVRtpssyMBYQJ2E2Iqli6LRY0L0BOJfMTTRSsMQ46
	R02ve5h2ogw2Ty4Abgxrwb1Kbk+sMTDR3hTHKQKHQItxYWFhrZteqLvKdjnSSw==
X-Gm-Gg: AYBFou1yYWhNdLrkUlIObSaWpG6ZVRqjECq5toS55+DkyFJrR3yeBfdyuDcXhsoQ6sU
	wkgbjA+ZTfdoNjtHEXAASVxy7ln13qiGU28wjdNYULIRSgbJmonco0hnouGEatzVGjfpklkOn+b
	XtaxeNCheeDO0zUDM1x45RcTS6kXIoTIyFQmXHVnJFXJW+e/UXxv7EsdKwT6zMgImJpF1vx+nl2
	Yg57XCXhpyYnXZg/pcFQ92qOObi68UEme302dkjux8c6D594PXgOtTnDkUlNqMviiZd40tOrIc0
	GuFIautg6Et+RPEUV9HGXOpMYCmRSXCx3poRESydWm5dyu9kNqqnUNUHHy82fOhNOY3SM/KfsTU
	uc1Ke80+RgIiqfayX564YO4MwID2QwtLPMmZYkX/Keupoxy9DbxnW3t3+ViiWmAOwutuJi8RiNi
	rRmku6JIQ6yYzOChXwWcH5Klcy3LgAlReu74DbJZFhfHiDtSlJEfQAxVsAAd9hUUn0NetatCyOj
	WfEGNQLvdztX78wcsLq2uIcsBqsi2TE0a0w3DQp311bMc7yQYT467a6hLz745Z9Fe8HKttRMMWa
	R/5NIhCzhc+dWGD69wumdEigWQ==
X-Received: by 2002:a05:6000:1789:b0:48d:ffcb:28e1 with SMTP id ffacd0b85a97d-48e264a6351mr10425346f8f.11.1792665518651;
        Thu, 22 Oct 2026 03:38:38 -0700 (PDT)
Received: from stukan.bbrouter (224-91-201-46.pool.ukrtel.net. [46.201.91.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f02f1sm12757371f8f.3.2026.10.22.03.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 03:38:38 -0700 (PDT)
From: Timur Stukan <timur.stukan.linux@gmail.com>
To: netdev@vger.kernel.org
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Timur Stukan <timur.stukan.linux@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] bonding: fix missing down path on speed/duplex failure after FAIL->UP
Date: Thu, 22 Oct 2026 13:38:21 +0300
Message-ID: <20261022103821.89552-1-timur.stukan.linux@gmail.com>
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

Fix this by recording the link state before the miimon commit and when
the speed/duplex update fails for a slave coming from BOND_LINK_FAIL,
taking it through the regular down path, including failover. The
BOND_LINK_BACK case keeps the current behaviour. The down path is moved
into bond_miimon_slave_down() so both callers share it.

After the fix:
  bond0: (slave enp0s3): failed to get link speed/duplex
  bond0: (slave enp0s3): link status definitely down, disabling slave
  bond0: (slave enp0s4): making interface the new active one

Fixes: 1899bb325149 ("bonding: fix state transition issue in link monitoring")
Signed-off-by: Timur Stukan <timur.stukan.linux@gmail.com>
---

Notes:
    sizeof(struct slave) grows from 608 to 616 bytes due to padding.
    I kept link_prev_state next to link/link_new_state for readability;
    it can be moved into the hole after 'delay' if preferred.

 drivers/net/bonding/bond_main.c | 53 ++++++++++++++++++++++-----------
 include/net/bonding.h           |  1 +
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 09aa45d71fab..602ad697a9c2 100644
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
+				if (slave->link_prev_state == BOND_LINK_FAIL) {
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
@@ -2919,6 +2935,7 @@ static void bond_mii_monitor(struct work_struct *work)
 
 		if (commit) {
 			bond_for_each_slave(bond, slave, iter) {
+				slave->link_prev_state = slave->link;
 				bond_commit_link_state(slave,
 						       BOND_SLAVE_NOTIFY_LATER);
 			}
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 598d56b1bc97..b2b102946fe1 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -165,6 +165,7 @@ struct slave {
 	unsigned long target_last_arp_rx[BOND_MAX_ARP_TARGETS];
 	s8     link;		/* one of BOND_LINK_XXXX */
 	s8     link_new_state;	/* one of BOND_LINK_XXXX */
+	s8     link_prev_state; /* one of BOND_LINK_XXXX */
 	u8     backup:1,   /* indicates backup slave. Value corresponds with
 			      BOND_STATE_ACTIVE and BOND_STATE_BACKUP */
 	       inactive:1, /* indicates inactive slave */
-- 
2.43.0

