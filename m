Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782921;
	b=jrSKSY6l8MX5/fggLOrcdNfRV2VsLBSRnkf8VAj2sKft9FZAkObspfjG1nvT5aSaZAr0
	 U+BiUTIVddcpiRj4UN9MGqkQqM+GCPw4BBkyLGa4Nl16ueXMD0tTXJkuhB+4b/eA3dCnu
	 rZj4/+I/nX2Bq51g7XEN5L7yaKrK0u4eC3dcOzaoXZiHPzttg/Rp3n3O8pz6NbA+LcAz3
	 WgdPgEiBITh0caVuc91qRunxvMGgTqMLQ2VF96VmRMl0qmAKcl9fgQJ2zUS9szrNIs5iL
	 YkwCh1uMhO2K4JFNnHpCIZ+vJRVkb7zoAyQYvAOAD//C4SoU8/nhADy4sXOk4FSsc3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=VrWeh5Ivr8SIscu8A3ccoxULSjeZPMCk6NPGAMBpCDc=;
	b=QXAysWUconvHVWASCySLTd5Jbj+YHB5uDLscurR7Z0BgZnQg4MyB6CUNGh//u0CN0AsS
	 Pm2TzhP1YluS/OJg0pZ2c0g1mPtGnyva9xnUZfDGlT55EQCV1EJekUF1cOi/Nos3r5qGH
	 mOV+SEoQ6smge0yerifztcVmSvlVlpHKdHt6t/dalihMO7xp6yueJAMCZxJZh6B6pjBcN
	 ACDsJ+Vd+Yux1pQLquCoXHPJ0RHHgQ+rwmMQySJDHpgn9m16uyn7EOrtZbmLMnqlZQjNv
	 apM6Di2BxMjeYiM5/FjJQaCbXIv95YpoEcuugtNzQ/mrLk6HAJ9tFGqZTzOf/b3aYRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mOSRy9Kf;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D75E606A325
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 19:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D75E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mOSRy9Kf
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ea0fe07201so8194595ad.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792782920; x=1793387720; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VrWeh5Ivr8SIscu8A3ccoxULSjeZPMCk6NPGAMBpCDc=;
        b=mOSRy9Kf1kt3cRXtKvthqwrKJwOSJ0ngJech3E7a57k/BvLcKPUB3NH8GzcTAG+LCt
         ZI8oN4YULSCmgeEmZlP7jpbEORcd+QOOK0AeefTdIDBCS7K7ESnhAEefKpwKxs4GmB01
         fVddGkegEEUGjIKyInandK0w78qQcuX2hMvvRXqnhhUwsbrRhjvGP5vIeQlBXouoquXQ
         Cri8Y5cNl8jIiBX1T51NKAhoQqyfW7LOcUD0cuq/XQ2yhEns75e4vmfkbrtmxuMNJ6mX
         5gsttr1VDaDR012hDjC7NIpFdeXMDh7Uaksh2h3DYWIRldBN/4dO5C0Tpe3IEC06atJq
         p7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782920; x=1793387720;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrWeh5Ivr8SIscu8A3ccoxULSjeZPMCk6NPGAMBpCDc=;
        b=e4sukuOxpql2xEMj92HN+lMv65NS7u6jlIxdC7QV9Bbu5OkMa+3lcMmIMELOWGQVd0
         ZLtnhkbwefVTqw7P7uXiyu8nzm5q5GiGs+cYOn6AD1ePSwUlvKfwdj7PB3+Bpk4FRNPP
         q+LV20X+4bGsgDJDuZD5hvf9ylJoxFr5daz31GrE5M8of+MVY1GZ43Bv3Nq4lOUNHDJw
         ImiaSi/8XvMM6zgIXloh15v+WmLO4RX4FkT+P3sygECro2OFqk4mRM7bP5ah7ZB1pVoB
         VKERBUoSjH+lYnjXjidaDhKdK4vu19tjQkPI4Myj+Q/5ZYaatacDtWsVtppJrBZsq8yS
         hXYA==
X-Forwarded-Encrypted: i=1; AKwUvByhRVP9sLqL+l3FwCfZgK75mblHT30PdUJIg9c+gr4TQVxY/KL18pbT/1kPLKjAIIxdfPpKmgo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSCLNZbGx2p6ieY2lIaOsr7lRF3wJNzbJnxHmp9JNe8gxtDQec
	aBvK6qT2cXKsaIzsVHzZogYmJ+wJXm1ow9BT0DzFO62EzjJZBTaF5qXSUC+xC8pijLrt5BiptUM
	pY6uL7A==
X-Received: from plot4.prod.google.com ([2002:a17:902:8c84:b0:2df:8ce6:d461])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccc8:b0:2df:9a7e:d41b
 with SMTP id d9443c01a7336-2ea7ceebb6emr27478895ad.37.1792782920211; Fri, 23
 Oct 2026 12:15:20 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:15:12 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023191517.607834-1-kuniyu@google.com>
Subject: [PATCH v1 net] ipv6: Protect multiple routes insertion by table lock.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+751b587577d0ebca10f2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported the warning below. [0]

While call_fib6_multipath_entry_notifiers() is called locklessly,
fib6_siblings could be changed concurrently, leading to the
warning (and later null-ptr-deref).

Let's protect multiple routes insertion with tb6_lock.

[0]:
i != fen6_info->nsiblings
WARNING: drivers/net/netdevsim/fib.c:831 at nsim_fib6_event_init drivers/net/netdevsim/fib.c:831 [inline], CPU#0: syz.0.157/6279
WARNING: drivers/net/netdevsim/fib.c:831 at nsim_fib6_prepare_event drivers/net/netdevsim/fib.c:947 [inline], CPU#0: syz.0.157/6279
WARNING: drivers/net/netdevsim/fib.c:831 at nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1003 [inline], CPU#0: syz.0.157/6279
WARNING: drivers/net/netdevsim/fib.c:831 at nsim_fib_event_nb+0x1029/0x11d0 drivers/net/netdevsim/fib.c:1043, CPU#0: syz.0.157/6279
Modules linked in:
CPU: 0 UID: 0 PID: 6279 Comm: syz.0.157 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:nsim_fib6_event_init drivers/net/netdevsim/fib.c:831 [inline]
RIP: 0010:nsim_fib6_prepare_event drivers/net/netdevsim/fib.c:947 [inline]
RIP: 0010:nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1003 [inline]
RIP: 0010:nsim_fib_event_nb+0x1029/0x11d0 drivers/net/netdevsim/fib.c:1043
Code: eb 0d 4d 89 fd e8 b7 c5 6c fa be 01 00 00 00 48 89 df e8 5a 38 85 fd 4d 89 ef 4c 8b 6c 24 20 e9 4a f3 ff ff e8 98 c5 6c fa 90 <0f> 0b 90 e9 db fa ff ff 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c df f0
RSP: 0018:ffffc900047bef10 EFLAGS: 00010293
RAX: ffffffff875b59a8 RBX: 0000000000000002 RCX: ffff888079770000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffffc900047bf0a0 R08: ffff88805c0bb02f R09: 1ffff1100b817605
R10: dffffc0000000000 R11: ffffed100b817606 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000001 R15: ffff88802c792000
FS:  00007f334ba076c0(0000) GS:ffff888123ad0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f334ba06ff8 CR3: 000000007a5b2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 atomic_notifier_call_chain+0xda/0x180 kernel/notifier.c:223
 call_fib_notifiers+0x31/0x60 net/core/fib_notifier.c:36
 call_fib6_multipath_entry_notifiers+0xf5/0x160 net/ipv6/ip6_fib.c:428
 ip6_route_multipath_add net/ipv6/route.c:5542 [inline]
 inet6_rtm_newroute+0x14f5/0x1a30 net/ipv6/route.c:5664
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7163
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2572
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1916
 sock_sendmsg_nosec+0x14e/0x190 net/socket.c:800
 __sock_sendmsg net/socket.c:818 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2715
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2769
 __sys_sendmmsg+0x273/0x4d0 net/socket.c:2858
 __do_sys_sendmmsg net/socket.c:2885 [inline]
 __se_sys_sendmmsg net/socket.c:2882 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2882
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f334ab9e1d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f334ba07028 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f334ae26090 RCX: 00007f334ab9e1d9
RDX: 04000000000001f2 RSI: 0000200000000000 RDI: 0000000000000004
RBP: 00007f334ac35888 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000000fc R11: 0000000000000246 R12: 0000000000000000
R13: 00007f334ae26128 R14: 00007f334ae26090 R15: 00007ffd96688aa8
 </TASK>

Fixes: 169fd62799e8 ("ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.")
Reported-by: syzbot+751b587577d0ebca10f2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6adbaed6.67317f00.38c4bc.001b.GAE@google.com/T/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
syzbot found a way to abuse 1ms sleep in netdevsim and pile up
10000+ routes w/ the delay, so it might report this with this
fix applied:

  unregister_netdevice: waiting for syz_tun to become free. Usage count = 10

I have two patches to fix it, but I think this is net-next
material.

  https://syzkaller.appspot.com/text?tag=Patch&x=15923c21580000
---
 net/ipv6/route.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 94e5ef1c4f83..5926ddbd4349 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5416,6 +5416,7 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	struct fib6_info *rt_notif = NULL, *rt_last = NULL;
 	struct nl_info *info = &cfg->fc_nlinfo;
 	struct rt6_nh *nh, *nh_safe;
+	struct fib6_table *table;
 	struct fib6_config r_cfg;
 	struct rtnexthop *rtnh;
 	LIST_HEAD(rt6_nh_list);
@@ -5502,10 +5503,12 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	 */
 	info->skip_notify_kernel = 1;
 
+	table = rt->fib6_table;
+	spin_lock_bh(&table->tb6_lock);
+
 	err_nh = NULL;
 	list_for_each_entry(nh, &rt6_nh_list, list) {
-		err = __ip6_ins_rt(nh->fib6_info, info, extack);
-
+		err = fib6_add(&table->tb6_root, nh->fib6_info, info, extack);
 		if (err) {
 			if (replace && nhn)
 				NL_SET_ERR_MSG_MOD(extack,
@@ -5560,11 +5563,12 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 
 	/* success ... tell user about new route */
 	ip6_route_mpath_notify(rt_notif, rt_last, info, nlflags);
+	spin_unlock_bh(&table->tb6_lock);
 	goto cleanup;
 
 add_errout:
 	/* send notification for routes that were added so that
-	 * the delete notifications sent by ip6_route_del are
+	 * the delete notifications sent by fib6_del() are
 	 * coherent
 	 */
 	if (rt_notif)
@@ -5574,8 +5578,10 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	list_for_each_entry(nh, &rt6_nh_list, list) {
 		if (err_nh == nh)
 			break;
-		ip6_route_del(&nh->r_cfg, extack);
+		fib6_del(nh->fib6_info, &nh->r_cfg.fc_nlinfo,
+			 RT_DEL_REASON_UNSPEC);
 	}
+	spin_unlock_bh(&table->tb6_lock);
 
 cleanup:
 	list_for_each_entry_safe(nh, nh_safe, &rt6_nh_list, list) {
-- 
2.56.0.307.g5fe7bd680c-goog

