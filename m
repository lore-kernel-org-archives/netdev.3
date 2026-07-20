Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598513E5EC4
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 22:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586849; cv=none; b=Q6Hn8t9KLEUJ3LjoGTV1oFnIPF9zCcTGbsaAuef4Cp+sSj0CTfmKwx/7j9nHDtQaSTuZOdD67Hdd8s6UIxqvViH+L+mrxZVohFVC0affhGS13zM/Wurj+IZWsOvUNUPk+9oVt4bF8zn7MAFO/ZMSXbef+uwnDvG7EP7xAVTqYMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586849; c=relaxed/simple;
	bh=dlRjBnXzN6CQJk18cJLEFzwZk6Rv5Ax2epHDma2e/ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAjabDlgXh+M1Rf/mhnsY8lhcNLHVi1AFBldhmUnMjj7aUlPmqzXDrsA4W/DCalj3PCRkLjyi2iyDLUgUluDBvkvZTrybH+kq1yGeH6zj6zc+CdwlaTeS8kywo06MCUlpB3xG6ZPP6oRW9zOgvT8dOZemzNP3QjSLAWT7HqvDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=VIFdlGyH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="VIFdlGyH"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ce98cb8165so45413745ad.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784586845; x=1785191645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A2TPUjqiIPkxhL/mDAlf7qxw7OdM1Z6fcLVNvTrXGec=;
        b=VIFdlGyH5ElzE7oTSew/PZyiF/g0KFjzrGiQkSXxWT9Zqsu1q6aHa5w7HuLF2jYz7C
         jXavQCe14xjUNpahTrtctvndpWd0u4YMuwNsLmWlnaOPZEJes8P6dptsNIwPPJL/wJdM
         UsL3+RYcMziqVuPtQ13xVdrTLu9qfiJbdqPNBHlXHgoRATvdLcybmA2SaYhhwlzS5buj
         /zKDFHL4H3mMovaNCSvnH+uYeeI82bgBlJ2BcLPQl64ByI+IlAuvOZWoVBOhB3RafudW
         khwkXlSDQ0W+yMWxYd1GeN/VVKIAfcmD9GjolgGuWVcAwndcCLsyd6vyRptSYz53k6rb
         Hjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784586845; x=1785191645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A2TPUjqiIPkxhL/mDAlf7qxw7OdM1Z6fcLVNvTrXGec=;
        b=fDS8PVN9AaHP1uuQaOCBaY5x2p/41cR95Yi9jr1K6nCnuWLE64JcrxKX7uQ2DN67SQ
         qio/m7NyBbtr3OXbxv1dLzHFNI6cU5zIFY0i0zeqAXDSr0hpDH6k7vVXGlnTwK3+ndqY
         ANsbRMyx6Po0GoWH/oXy9eiYTc/jV/TQMkJSm5gJ0g1X7zy4a2HWZ4KAoA3wfmHOexfo
         mV1jgR5aQPKXcKXTBuTQ5jYEaGCQRgzOnpmwRgJkviBSa6X4kxmbMEUI6+W5ecuNDZ+P
         JFiiyROpu7BKANW80HcUpiR6pIyr+0RpU+JOPqujGu4tMxxUrpQLOvNiLFh+zTee9DPb
         tbvQ==
X-Gm-Message-State: AOJu0YzZMzLRu8TPDrBhYOJUXwGOUXDyDeRhuHYezR0R4h7ABwZ3u2wd
	4e+TmOlU3vC9mLCgfAvCM0XzUBXyvsVVqMv8AtDOEhm4PElAMwLQgy8tWxCyGPx3cSqeGlTa/EY
	qq9E=
X-Gm-Gg: AR+sD13I8M99+5rxwbvFqOphuwfxOmzMhMSa+CKJBrX2YSSQp/+UY5kVfgR8ij1t9Yf
	vW5dXv9l4cQVdjmWamiauzvCKLrSAYwHmqrBPaLkvC/uwePe591ewUaWMQaw7DQwWeOEc7M6yLK
	oAgFFWGx5k1ksAMrNeoMsZY8Nku6e2zaU5YLqhP8rE07mp27o80BcXC/DETYa4VqojcdUDeaq+s
	hlnLScXhAC9KwEmKId7UijYsnG3kaJRw/Sjy/Dkq/VpEnz6Kv4polUmLPBTKnS3YGPQk04qYols
	QsfYSY/HnQ8az3/HhnW/CxSeTtgtj8vsfBwK0FBvc7dgAIvzndmOWM4KFapPBgwO90yO3hW0M8Q
	uKAPNadqahTWsNC25xCxq6y+t92iWRDAdW2Dz5pr6YWNSNhmQ6Y1Kr8gbZdmHl2xPxLmLrPqaBt
	Q+hMHg6sKgiUvV4bn1Xw==
X-Received: by 2002:a17:903:2ac6:b0:2ce:a6a4:451b with SMTP id d9443c01a7336-2cf1f2e71eamr219797525ad.11.1784586845226;
        Mon, 20 Jul 2026 15:34:05 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9bcd9sm41078761eec.3.2026.07.20.15.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 15:34:04 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Jay Vosburgh <jv@jvosburgh.net>,
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
Subject: [PATCH net] bonding: alb: re-check primary_is_promisc under RTNL in bond_alb_monitor
Date: Mon, 20 Jul 2026 22:34:00 +0000
Message-ID: <20260720223400.1939998-1-xmei5@asu.edu>
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
 drivers/net/bonding/bond_alb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 2d37b07c8215..70458c5b23cc 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -1535,7 +1535,7 @@ void bond_alb_monitor(struct work_struct *work)
 					    alb_work.work);
 	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
 	struct list_head *iter;
-	struct slave *slave;
+	struct slave *slave, *curr;
 
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

