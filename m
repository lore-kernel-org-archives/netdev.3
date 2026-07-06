Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F73F86FA;
	Mon,  6 Jul 2026 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327595; cv=none; b=kTl5XFJrNe+t8xYBWKX/TAsS2ZLAuEjlmj+VlpAXEDXxrT54lF2LxcSMs2KrLfRyWhaNbj0cr9S1dyoooquieseGJ1x45me/L1jfHitnVLFqn/Z/PB1863bubLtL6+BYL+M6Kx9k0RbaaTMwlLjvH8snbX7RvghzWCcybMSkZ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327595; c=relaxed/simple;
	bh=Aq7XpudnAcKaS81HjDJDNYPswQh+BUSNaYY8W66620A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4u+4Do6/I1EJVnn+tUXEy4tpD1d6geRI06JLZ3h2hq/ETbxkKOxOtUouknq+n53uJs0GbLhNoueMbLIJ10bm8cv3DcAUNSIKsDvIw2KO7njhCCuQkjMd0n4Lc8V1QiFjTOzp/HawR978caHBW4DZ0BlkNN8TXQZKIrRrw/5t3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ng7yDoUh; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ng7yDoUh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=O/
	yofhFvHkov23hY7UUkFz/6GuSRZ5PQqaEKBSq6uK8=; b=ng7yDoUh9xzk+cI9Db
	Jkm295TPDyA7NxLvxh82tF9kWXjAqMiuzTX4BHjfbT8nszLuvR1QC3M2EKVWboMc
	zMykFNW3zprDTKdjh6yIaEL7PPteRP26F7wwhizIHtw+Cl816Tx1oWKdxGQYB1yr
	LO9foGgCt/dWm87l40PqKZB+E=
Received: from LAPTOP-M8806FGF.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3958pa0tqWi0WCw--.19204S2;
	Mon, 06 Jul 2026 16:45:30 +0800 (CST)
From: zhangzl2013@126.com
To: Zhaolong Zhang <zhangzl2013@126.com>,
	Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qianheng Peng <pengqh1@chinatelecom.cn>,
	Zhaolong Zhang <zhangzl68@chinatelecom.cn>
Subject: [PATCH] bonding: fix devconf_all NULL dereference when IPv6 is disabled
Date: Mon,  6 Jul 2026 16:45:30 +0800
Message-ID: <20260706084530.447402-1-zhangzl2013@126.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3958pa0tqWi0WCw--.19204S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4xAF1DZw4ktry5tFyrWFg_yoW8tF15pr
	Z3KrW5ur1ktr1UAF4UX3W093s5Za18XFZFkrWIkr95Zan5Ka1DAFy7Jr109F15trWrCFZI
	va1Uta90gwn5Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE4SoPUUUUU=
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/xtbBogpSImpLayog3wAA3H

From: Zhaolong Zhang <zhangzl68@chinatelecom.cn>

When booting with the 'ipv6.disable=1' parameter, the devconf_all is
never initialized because inet6_init() exits before addrconf_init() is
called which initializes it. bond_send_validate(), however, will still
call bond_ns_send_all() even ipv6 is indeed disabled. It will lead to
NULL derefence of net->ipv6.devconf_all in ip6_pol_route().

 BUG: kernel NULL pointer dereference, address: 000000000000000c
 [...]
 Workqueue: bond0 bond_arp_monitor [bonding]
 RIP: 0010:ip6_pol_route+0x69/0x480
 [...]
 Call Trace:
  <TASK>
  ? srso_return_thunk+0x5/0x5f
  ? __pfx_ip6_pol_route_output+0x10/0x10
  fib6_rule_lookup+0xfe/0x260
  ? wakeup_preempt+0x8a/0x90
  ? srso_return_thunk+0x5/0x5f
  ? srso_return_thunk+0x5/0x5f
  ? sched_balance_rq+0x369/0x810
  ip6_route_output_flags+0xd7/0x170
  bond_ns_send_all+0xde/0x280 [bonding]
  bond_ab_arp_probe+0x296/0x320 [bonding]
  ? srso_return_thunk+0x5/0x5f
  bond_activebackup_arp_mon+0xb4/0x2c0 [bonding]
  process_one_work+0x196/0x370
  worker_thread+0x1af/0x320
  ? srso_return_thunk+0x5/0x5f
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xe3/0x120
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x199/0x260
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Fix this by adding ipv6_mod_enabled() condition check in the caller.

Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
Signed-off-by: Zhaolong Zhang <zhangzl68@chinatelecom.cn>
---
 drivers/net/bonding/bond_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e044fc733b8c..522eab060f9e 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3455,7 +3455,8 @@ static void bond_send_validate(struct bonding *bond, struct slave *slave)
 {
 	bond_arp_send_all(bond, slave);
 #if IS_ENABLED(CONFIG_IPV6)
-	bond_ns_send_all(bond, slave);
+	if (likely(ipv6_mod_enabled()))
+		bond_ns_send_all(bond, slave);
 #endif
 }
 
-- 
2.52.0

