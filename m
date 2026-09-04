Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5651A747
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545215; cv=none; b=EGhWKUTOLmUpJVq3a2E2jY+xzFf28JmgKmVmkd0qqqR2shITk+JZHzjA3D5i2onGg1PRBeYz51ulFRlpnsbFz7s8zkIjGMghKpcY43SzSqSIrEo9O0Cg5Y2bhZZYVt7PNqFdCFxi6Ut99eE494EzwBO2eJzOoVsZ1YsA1DPauH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545215; c=relaxed/simple;
	bh=GxYA4iKznjI636cFMJTo4pS5K5Cg5h7A9ZfCiLargbw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Tfh8nA+AHmOqvL4sNE9qN4Ij1IRI4mXuq4t43KgCr8iAfKLr5yB2GUJRlcSFcqajcouM0M253ujHzmzMiyeV7Leb3sN08/vHV2rP5K/+W8msrJkrjuLw2sXBOKYQIzVQ+xXvpG2c8YsEnVvV+ULvCkq+k9/hDpZvibgqSX7jPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i8C7OUt1; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8C7OUt1"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e820609d9so267888585a.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788545212; x=1789150012; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DH/M4TRPzR+41f2BvooKoO573DASe14kbYFRV4oxAKQ=;
        b=i8C7OUt14QXBbSWAKPZGlxrNuJiFbALwh2PnX/pujlq7mL1t2lx5xCaTbvgDgr3NNN
         dxVi7R+V3gjvSBeBiavSUuT/FVkJRxIvZFPhb/Z2VJzrQDAebxwWqCIAy86Jt8EdLjZy
         u026KNrSl+qdS5lKa1Lnhd7PFJfFrNURUnxhN93L7bLchIuMk7eiflqGBtacpnsooYyR
         Ak/7fA1aY8fG0XURjm45P4tDXZ2QCK8CCYjQKksb3n9h44D+0OE6+zh5z2HQfrOCKRk5
         O8DWe0gD3dZWA/xcdC++bQLNwUhGEwctXN+F/5ARyucwLF1T0jKrStXdmiw5L0EX5lzy
         dtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788545212; x=1789150012;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DH/M4TRPzR+41f2BvooKoO573DASe14kbYFRV4oxAKQ=;
        b=CkVemnRgab/bdU4qPdEbGVngU6QpsnBxIhLNILxI1oxUgTeHbyYXZb8Iyya2+bKhMW
         XE5QutPwsUOo0uqhX41cvcgqmtwwx9dAyIT2BBg4zynIeInkS9YbRmWShoFxJz3IoDCg
         6L9taahJPUniOka9Z5BoDglEvLANSrJhyMSZx6HRDHp5rcgEVw0GU5ygaRAbYzo49Tfp
         xH/2cAmMKraGJNmDuPcnwgrACPPTYlz8NpO/17oqmgz7Ah4iEyd6oUHEsTuKiJB2+NDc
         TQmhVMazBHOGlJLvWYqA/mTecCqTPsWnZBPZRwLN6DicIE80oMK7CHBeEBm90577uK90
         l5Qg==
X-Gm-Message-State: AFuF++nuNJjvQmwdD5ckj+PpIZ+qCwpvHpUgg3RO10u/Mmto1hlkIc4i
	J5WZRAcW1RDS4wFpwgLcZ+mN0l7XHikF69gdpb3uXUZyRcmKRYKJkSaMiq6WyL/F6mdt6eCiz0v
	vpB+cpd2i5bwhgMpP02zK6GHlLw==
X-Received: from qvbx9.prod.google.com ([2002:a0c:e0e9:0:b0:905:b14f:3f1a])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6089:b0:938:d7e4:7fe with SMTP id af79cd13be357-939804536d0mr869291585a.37.1788545211916;
 Fri, 04 Sep 2026 11:06:51 -0700 (PDT)
Date: Fri,  4 Sep 2026 18:06:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904180645.706425-1-namangulati@google.com>
Subject: [PATCH net] ipv6: null-check fib6_node before accessing in __ip6_del_rt_siblings()
From: Naman Gulati <namangulati@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, syzbot+a73e5ee0fd534fed75bd@syzkaller.appspotmail.com, 
	Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported a null-ptr-deref in __ip6_del_rt_siblings() [0].

The stack trace hinted towards a null dereference of rt->fib6_node when
fn->leaf is accessed in __ip6_del_rt_siblings(). With
RTNL_FLAG_DOIT_UNLOCKED set, inet6_rtm_delroute() operations run
concurrently without acquiring the RTNL lock. In ip6_route_del(), the
route lookup happens under rcu_read_lock() without acquiring
table->tb6_lock.

Between ip6_route_del() looking up the route and __ip6_del_rt_siblings()
acquiring table->tb6_lock, another thread can modify the routing table.
For example, when an ECMP route is replaced via RTM_NEWROUTE with
NLM_F_REPLACE, fib6_add_rt2node() unlinks all old siblings and sets
iter->fib6_node = NULL. A reproducer was found that triggers this [1].

Add a check to ensure rt->fib6_node is non-null before accessing it.

[0]
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
RIP: 0010:__ip6_del_rt_siblings+0x31e/0x7c0 net/ipv6/route.c:4056
Call Trace:
 <TASK>
 ip6_route_del+0x1054/0x1110 net/ipv6/route.c:4232
 inet6_rtm_delroute+0x5d7/0x6d0 net/ipv6/route.c:5669
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7132
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7f5/0x990 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 ____sys_sendmsg+0x565/0x870 net/socket.c:2713
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2767
 __sys_sendmsg net/socket.c:2799 [inline]
 __do_sys_sendmsg net/socket.c:2804 [inline]
 __se_sys_sendmsg net/socket.c:2802 [inline]
 __x64_sys_sendmsg+0x1b7/0x290 net/socket.c:2802
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

[1] https://gist.github.com/NamanGulati/0766a1159b6ca61928faaf87425ff899

Fixes: bd11ff421d36 ("ipv6: Get rid of RTNL for SIOCDELRT and RTM_DELROUTE.")
Reported-by: syzbot+a73e5ee0fd534fed75bd@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a9b03f9.04649fcc.10325f.0003.GAE@google.com
Signed-off-by: Naman Gulati <namangulati@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/route.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 9658939511e0..08bd68f1b5bb 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4019,6 +4019,7 @@ static int __ip6_del_rt_siblings(struct fib6_info *rt, struct fib6_config *cfg)
 	struct net *net = info->nl_net;
 	struct sk_buff *skb = NULL;
 	struct fib6_table *table;
+	struct fib6_node *fn;
 	int err = -ENOENT;
 
 	if (rt == net->ipv6.fib6_null_entry)
@@ -4026,9 +4027,13 @@ static int __ip6_del_rt_siblings(struct fib6_info *rt, struct fib6_config *cfg)
 	table = rt->fib6_table;
 	spin_lock_bh(&table->tb6_lock);
 
+	fn = rcu_dereference_protected(rt->fib6_node,
+				       lockdep_is_held(&table->tb6_lock));
+	if (!fn)
+		goto out_unlock;
+
 	if (rt->fib6_nsiblings && cfg->fc_delete_all_nh) {
 		struct fib6_info *sibling, *next_sibling;
-		struct fib6_node *fn;
 
 		/* prefer to send a single notification with all hops */
 		skb = nlmsg_new(rt6_nlmsg_size(rt), GFP_ATOMIC);
@@ -4051,8 +4056,6 @@ static int __ip6_del_rt_siblings(struct fib6_info *rt, struct fib6_config *cfg)
 		 * and emit a replace or delete notification, respectively.
 		 */
 		info->skip_notify_kernel = 1;
-		fn = rcu_dereference_protected(rt->fib6_node,
-					    lockdep_is_held(&table->tb6_lock));
 		if (rcu_access_pointer(fn->leaf) == rt) {
 			struct fib6_info *last_sibling, *replace_rt;
 
-- 
2.55.0.979.g7e5102b832-goog

