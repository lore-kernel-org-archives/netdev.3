Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8B368282
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440907; cv=none; b=nDJfvaL1liiUlW8DSdDK1c6f1D7kOHOsLgKA/xw0PEY6xdIctZGNs984HVbNaSvbYsmdUKhcOaG36ionUdV75BXXQJnmAKt9pulSR60b+LQRU621Ny57mdhmwWvzqQRMNN0taW+MxW6fJiLbwYaG4Uav0LkbxIloAgvDKwbZOWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440907; c=relaxed/simple;
	bh=qT1ApMN67FAl49r3eZXNoECQB2vHEWXg3tsEboZQnYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=us6GHKpPNAARlRZr6ax9pVivLVp7KgA9WvvH58KU+NtF1U0f7OOrEt7drK0f44vflOvJ/f+NSDvKqPXDGp8bJZxaw03tJEDnue+/cvpm/weH1+J/3f+pHwF/easLSgTDEwOvrpdU9s+qsXyt5IOb9J0o9yCFdKMrqLW0B9RcofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA9v/XF2; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA9v/XF2"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4d192643dso1161350a12.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 23:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791440905; x=1792045705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U5JwFoCLBlceY3GnHhr8EwznFrHNwv6ytANdj+M7B2w=;
        b=PA9v/XF29wMwN9cqkI9uURpoczP7yXbPjaIw1oBdshF7hXCgM4rK7KXpcz4+5ko1zd
         EDkWtz82aZ+59dHyyB/4z2DcsBxv0ZrfZ2T+LKd9+LBh5WBTLk22+TPmBUkPynMpJxgG
         /p5rBoqUvbKf9N4dUBiCHhQ/W6cat3gaAhZ4oWHrvQiL0dYaY/FIHpiQ6z4NROcwl5dX
         weBhkxdvcbigrr7TvxqAwgiureGg/1diZn93hjMVPhoWSDLmHDpO3z7lUCF2mfF1r26e
         YeFRWkTgtCFyu9umWulClS04T69DaWSmhfLuvAxO3y32DcrQKPJLmkiSfw7MIPmOfZ7h
         UJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791440905; x=1792045705;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U5JwFoCLBlceY3GnHhr8EwznFrHNwv6ytANdj+M7B2w=;
        b=dFGpmukaMldMyCC03lzt+kRIJObtQd71mJ/krGAYapaekPbbyReRrxTUzJjAyurPEt
         nyATpdnJ92s/IrohQV5FZONRUL6MUUQONli94bOVPZtdQIHThPRtB0h+vO5BG/0Gi+1/
         GKlOn/30sKdT8e/tb6HFdkaX79MLYqlUEm4TRGShedK+ZtLACVF/6CsGfZl/3hdEnClA
         iEfpzr6iNygw8+VUyedjgk/5JTUa1SbkjjOCIw/sYImiD9SblZhdz4FNgPuaa/VCn9q1
         WcREF5LWOjK6dIBqJURglBntv340lt4mpQ8o2qPtOjZMD2ydTK+dpY7RdvUObaeDSXT5
         b2gw==
X-Gm-Message-State: AFuF++k0NX+tJbEuaZ0DJHo44priGYAfq6eg59VJuQDKdmVtB6/mzv64
	oN2LkWXyYOouxTGRJA2TiR1ZLyTqmcVqtHsCaaLxEKNGafQfT9bGEQdo
X-Gm-Gg: AYBFou2CTVE44GatepK0DiaFj4glTzp73c/2Jl8Pnf7e4ByqQRstCaVRNy9JrDm9Ja0
	w3u1C1y4F4SVcJpDwg1wS+PilDSlCWg7g/9DxrHjT224/9stmrjqdBgWcBLpeq9DVwScswvoeEu
	IrUiUsUxRElZbsizi+Xb82PTEcJ/bkXJ97q8Q287bExekfjv4gXXydzORqajbfwgthdUtlPjcBw
	8g3GgF9IBJocqyig6p2/w0ZrTYiqYoFXRLQbuZtR6im/IJyeHP3uGySzT2zc8p7lCAmOVtZo1Gx
	M5eFCQEvPUlTnbGDoRh8/NMTSFndy4vAlH2ojA+wJHN6zDdCqw+rZ+ovViCWFheVC5ntIutcBGY
	ROVkEbVNVcRfTIGDqUdo7lreNab1ljOXxBB04BAEDHtKDxIjSq7Y8SpPFglgSVMG8rmdr4tff2L
	vO4n/1OJraeYpk5Xv3lLxUOd4nV+sDNEQPhMp5shCTSgF5xuRx3X5d5/nkhfOxAlkAfg==
X-Received: by 2002:a05:6a20:c905:b0:3e0:da23:874a with SMTP id adf61e73a8af0-3e134053904mr4449875637.18.1791440904887;
        Wed, 07 Oct 2026 23:28:24 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892b86fc748sm1142143b3a.7.2026.10.07.23.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 23:28:24 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] ipv6: Protect the cork MTU read with RCU
Date: Thu,  8 Oct 2026 14:28:18 +0800
Message-Id: <pm-ip-core-objects-candidate-0007-v2-46f5bb8aa2cc9824a047@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ip6_setup_cork() must keep the metrics image alive until the MTU read
completes. Its destination reference protects the rt6_info allocation,
but dst6_mtu() reads the metrics through a raw pointer outside RCU.

A route with dynamically allocated metrics can share them with a
Redirect-created RTF_CACHE exception. This also happens when RTAX_MTU
is zero, for example on a route with an RTT metric. A UDP send using
that exception can overlap a Packet Too Big update for the same flow
and deletion of the owning FIB route in the following order:

1. udpv6_sendmsg() calls ip6_make_skb() and ip6_setup_cork(). The MTU
   lookup loads the old metrics pointer in dst_metric_raw().
2. icmpv6_err() calls ip6_update_pmtu(), which finds the same exception.
   rt6_do_update_pmtu() calls dst_metric_set(); COW installs private
   metrics and drops the destination's old metrics reference.
3. After Packet Too Big processing returns, fib6_del_route() purges the
   exception. ip6_dst_ifdown() clears rt->from and releases its FIB
   reference while the send still holds the destination.
4. After the remaining owners drain, fib6_info_destroy_rcu() drops the
   last reference to the old metrics and frees them.
5. The send reads RTAX_MTU through the saved pointer to freed memory.

The MTU helper's existing RCU section starts after the raw metrics
read, so it cannot prevent this use-after-free. Enclose MTU selection
in an RCU read-side critical section in ip6_setup_cork(). Since COW
replaces the metrics pointer before route deletion, the existing FIB
and destination RCU callbacks must wait for this read before releasing
the remaining old metrics owners.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in ip6_mtu+0x6c8/0x790
    Read of size 4 at addr ffff888101348c84 by task pmbd-send/551

    CPU: 2 UID: 0 PID: 551 Comm: pmbd-send Not tainted 7.2.0-rc5-pmb-bt-functional-v1+ #1 PREEMPT(lazy)
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? ip6_mtu+0x6c8/0x790
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? ip6_mtu+0x6c8/0x790
     kasan_report+0xe0/0x110
     ? ip6_mtu+0x6c8/0x790
     ip6_mtu+0x6c8/0x790
     ? __pfx_ip6_mtu+0x10/0x10
     ip6_setup_cork+0xf50/0x1470
     ip6_make_skb+0x228/0x390
     ? __pfx_ip_generic_getfrag+0x10/0x10
     ? __pfx_ip6_make_skb+0x10/0x10
     ? find_held_lock+0x2b/0x80
     ? ip6_dst_hoplimit+0xd1/0x450
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x280
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? udpv6_sendmsg+0x1f5e/0x2a00
     udpv6_sendmsg+0x1f5e/0x2a00
     ? __pfx_udpv6_sendmsg+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __lock_acquire+0x466/0x2260
     ? __lock_acquire+0x466/0x2260
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? sock_has_perm+0x278/0x320
     ? ip6_datagram_release_cb+0x26d/0x510
     ? __pfx_udpv6_sendmsg+0x10/0x10
     ? inet6_sendmsg+0xff/0x140
     inet6_sendmsg+0xff/0x140
     __sys_sendto+0x320/0x470
     ? __pfx___sys_sendto+0x10/0x10
     ? __pfx___do_sys_prctl+0x10/0x10
     __x64_sys_sendto+0xe5/0x1c0
     ? lockdep_hardirqs_on_prepare+0xea/0x1a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? trace_hardirqs_on+0x18/0x160
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    RIP: 0033:0x7fbdea3b3687
    Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
    RSP: 002b:00007ffd43d66d40 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
    RAX: ffffffffffffffda RBX: 00007fbdea31f780 RCX: 00007fbdea3b3687
    RDX: 0000000000000017 RSI: 00007fbdea10bbd0 RDI: 0000000000000003
    RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
    R13: 0000000000000000 R14: 00000000006fe390 R15: 0000000000a83590
     </TASK>

    Allocated by task 542:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x630
     ip_fib_metrics_init+0xc1/0x6b0
     ip6_route_info_create+0x1a0/0x8c0
     ip6_route_add.part.0+0x29/0x150
     inet6_rtm_newroute+0x16a/0x180
     rtnetlink_rcv_msg+0x7b9/0xce0
     netlink_rcv_skb+0x133/0x390
     netlink_unicast+0x504/0x840
     netlink_sendmsg+0x7f7/0xcf0
     ____sys_sendmsg+0x88b/0x9d0
     ___sys_sendmsg+0x125/0x1d0
     __sys_sendmsg+0x13e/0x1e0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 0:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x236/0x5a0
     fib6_info_destroy_rcu+0x1fa/0x240
     rcu_core+0x661/0x1d10
     handle_softirqs+0x201/0x930
     __irq_exit_rcu+0x110/0x1e0
     irq_exit_rcu+0xe/0x20
     sysvec_apic_timer_interrupt+0x6c/0x80
     asm_sysvec_apic_timer_interrupt+0x1a/0x20

    The buggy address belongs to the object at ffff888101348c80
     which belongs to the cache kmalloc-96 of size 96
    The buggy address is located 4 bytes inside of
     freed 96-byte region [ffff888101348c80, ffff888101348ce0)

    The buggy address belongs to the physical page:
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x101348
    flags: 0x200000000000000(node=0|zone=2)
    page_type: f5(slab)
    raw: 0200000000000000 ffff888100042280 dead000000000100 dead000000000122
    raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff888101348b80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
     ffff888101348c00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
    >ffff888101348c80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                       ^
     ffff888101348d00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
     ffff888101348d80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
    ==================================================================

Fixes: f5b51fe804ec ("ipv6: route: purge exception on removal")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 5509650589915cac54ea7767f0cb237c6c1d71e5..0440acc3dec0b0bdb8fe484810a9c84f1af67881 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1421,12 +1421,14 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	v6_cork->hop_limit = ipc6->hlimit;
 	v6_cork->tclass = ipc6->tclass;
 	v6_cork->dontfrag = ipc6->dontfrag;
+	rcu_read_lock();
 	if (rt->dst.flags & DST_XFRM_TUNNEL)
 		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
 		      READ_ONCE(rt->dst.dev->mtu) : dst6_mtu(&rt->dst);
 	else
 		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
 			READ_ONCE(rt->dst.dev->mtu) : dst6_mtu(xfrm_dst_path(&rt->dst));
+	rcu_read_unlock();
 
 	frag_size = READ_ONCE(np->frag_size);
 	if (frag_size && frag_size < mtu)
