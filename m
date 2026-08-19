Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B443CFF6A
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787120594; cv=none; b=qFp5yj7JLz0/9xw7H1pAnUwfiEawIOCVouxCQq+p84aanpFfyWU1A2jrQXYJd2QJjTEAj8e5LZHzioSJZlI4p9DhzKkKK9Yp2RuBOpP7HPT/6OANiFCFXee+Hzilb2oHkztVq0/LCC19/k5aFpvOJE4fBqs4Tjiip6TU4Ht5PBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787120594; c=relaxed/simple;
	bh=P6eYlkBWwIPGJuOM/q70fjyMyB2WG6Uu0OmAA4GgGD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVCWFLGe5+jjtWC2RsJTgcn4zxFw1wm94S3tHZlVR0Dirn23AUQlTysErhWV5/fdAT6H/TaWhTzeY5MAkNJ1ty7lidLhh49+mMh9wcgVfIO3w4Qz0k4geHaPZbsht+y5ISQLHPStWU/8ks682cg7HpcIohTDKYcnsmLZJB2M5ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kT8rqLnZ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT8rqLnZ"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso5330646d6.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 23:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787120592; x=1787725392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UJM9hm9DanwCuIofHIFBgFLlZuKrizitIWMTacTXE+E=;
        b=kT8rqLnZcgs1MYXYnjYbHTzR28EGzHIOZLZ/Q2b4IebpE4fRLPqLDIijgORW8Zxf+n
         rWHfByZ8zRVK47aKRPu4MzScH/GnLHbJ8bIVcHhwmab5TTIQ+0lv1afLy8FWUIKwLPJi
         td0afX/fx/M7IdHRX4JMm8RTT+tlYvVTNwTa2kDb/TC5XyO5lwjbBh/F3wbtJQ7zAWbT
         UKFiBSiohhOu9NVHk2oouMhzUAUNEqUa/l7wO9ylsU07UxA6bz92ecaYW3fX4u1rTVr9
         EYN7cmQekZOrNGOJzMEeMnCx/dCnR7vKiXO7zHNjWUAN8MR9uDxv/1v9SY1pC+mF8EgH
         HJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787120592; x=1787725392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UJM9hm9DanwCuIofHIFBgFLlZuKrizitIWMTacTXE+E=;
        b=kAXM5wLJbbyemLnIrB7C75zWYDjdP+cSBzSvHORYmuEf5jiEkb2BZBJU9M1bM1Hrmw
         3QpZ1QWCM7TFPhyLlA2ofPWT/AB6aEkIOJZ+IXozDux+gtczTueiJJ6DHxVfophAa/7m
         szRec4iPcL9O/F+Iq3JQINtI01+n/NaJByLC9YKuwdm01U40cz+CW71chWsAeeQUDZZ7
         Zx4BQtzJPqhsWIOiWWTn6DROX0mGkk/EVBtfwdv6sM/LDESX8W65GTr1eSJ7n4k9AsUB
         OVPG9AaODKTduemAREaJ7M49YvjnOGTU6Cd7uKaveLMZOdc0WKKIBalxndslQs1lywwh
         MXuQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbxyG7JQXOPT1CwnP3RQmCZ0f0oRMrjpgJ3Va9gWcJ082dWFbZ199sKRAf0Af7VaOi+JmZO8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1l2pzSVsC2m/U0H98ry3sLzEIcWFyMwpOzM3F6DTURE1dMME
	rvjH40lwq8H0KY7hsgzRECxx29y/yZuGcvVsRX55vuhaA13hRrPWSHvj
X-Gm-Gg: AR+sD10S1zWbKjFjASlhf4KpvDDJuIj6NewqbqAp+jKV1U9S/RfxHETT9ndWdYWFQWu
	GLqK+8m3BdmqDD+FaHXOFX917N7F8ii4C3n1HoGqkW2Ebl32IJ0VT4gtEEnLgBd7RKs+5uhBBcL
	wC4sHgURmZa7eNvePB0JbjCXie4B2iTLOM79W6OJOkNdzDXKIN7DUw5g9m80rriBkbeYE7SaHPN
	YP+/oLv95iQfp2uTs6wHxyHHF4h5PcVpbszGdzBBUexHN12+yT6AFp1YnRnEmYVC10QE1K4KZR6
	2csQ8wPD6cC+RN9Gy7IJln/WnLiKJEe23Lka+GB4MirMgLbT7ep1dJSeaVETM+zChi9eAvPgHwU
	q06WO3MZKPyPMZnbcr68xLAzDajmN19PCvrbnlCcw8aNTS/ed7r85Bn/Lv0jpy2shryewGi6mDV
	A+DExt5GpoVX1e95Y6JocN4hPIO8ZcXJl9yKOqIQHiFJQU3fo5oCKZXAnGcNMpVX2Wsta9yxgxc
	sov6FiDPoJX1G4DMA==
X-Received: by 2002:a05:6214:27e2:b0:901:7300:c82 with SMTP id 6a1803df08f44-90c5eac458bmr21371246d6.25.1787120591810;
        Tue, 18 Aug 2026 23:23:11 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2b5a1bsm7374056d6.45.2026.08.18.23.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 23:23:11 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: ipv6: KASAN: slab-use-after-free in ip6gre_tunnel_xmit
Date: Wed, 19 Aug 2026 02:22:20 -0400
Message-ID: <20260819062224.3197349-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in ip6gre_tunnel_xmit

on commit: bd5f485f3f026225b86573e559af0b7254ef4184 (2026-08-18)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/63aa087b3e843c7a4e98a42c0f130aeb

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[  127.142568][ T8310] BUG: KASAN: slab-use-after-free in ip6gre_tunnel_xmit (./include/linux/skbuff.h:1162 .net/dst_metadata.h:46 .net/dst_metadata.h:57 net/ipv6/ip6_gre.c:711 net/ipv6/ip6_gre.c:910)
[  127.143319][ T8310] Read of size 8 at addr ffff888118f856d8 by task ip6gre_uaf_repr/8310
[  127.144052][ T8310]
[  127.144281][ T8310] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  127.144284][ T8310] Call Trace:
[  127.144286][ T8310]  <TASK>
[  127.144287][ T8310]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[  127.144311][ T8310]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[  127.144342][ T8310]  kasan_report (mm/kasan/report.c:595)
[  127.144349][ T8310]  ip6gre_tunnel_xmit (./include/linux/skbuff.h:1162 .net/dst_metadata.h:46 .net/dst_metadata.h:57 net/ipv6/ip6_gre.c:711 net/ipv6/ip6_gre.c:910)
[  127.144405][ T8310]  dev_hard_start_xmit (./include/linux/netdevice.h:5397 ./include/linux/netdevice.h:5406 net/core/dev.c:3889 net/core/dev.c:3905)
[  127.144408][ T8310]  sch_direct_xmit (net/sched/sch_generic.c:372)
[  127.144419][ T8310]  __dev_queue_xmit (net/core/dev.c:4214 net/core/dev.c:4836)
[  127.144476][ T8310]  sch_frag_xmit_hook (net/sched/sch_frag.c:156)
[  127.144582][ T8310]  tcf_mirred_to_dev (net/sched/act_mirred.c:242 net/sched/act_mirred.c:?)
[  127.144585][ T8310]  tcf_mirred_act (net/sched/act_mirred.c:489)
[  127.144594][ T8310]  tcf_action_exec (.net/tc_wrapper.h:59 net/sched/act_api.c:1150)
[  127.144599][ T8310]  tcf_classify (.net/tc_wrapper.h:178 net/sched/cls_api.c:1779 net/sched/cls_api.c:1875)
[  127.144603][ T8310]  tc_run (net/core/dev.c:4415)
[  127.144610][ T8310]  __dev_queue_xmit (net/core/dev.c:4549 net/core/dev.c:4812)
[  127.144643][ T8310]  packet_sendmsg (net/packet/af_packet.c:3107 net/packet/af_packet.c:3139)
[  127.144686][ T8310]  __sock_sendmsg (net/socket.c:775 net/socket.c:790)
[  127.144689][ T8310]  __sys_sendto (net/socket.c:2252)
[  127.144722][ T8310]  __x64_sys_sendto (net/socket.c:2259 net/socket.c:2255 net/socket.c:2255)
[  127.144726][ T8310]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[  127.144730][ T8310]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  127.144733][ T8310] RIP: 0033:0x7fd922eb8fa6
[  127.144737][ T8310] Code: 0e 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 72 c3 90 55 48 83 ec 30 44 89 4c 24 2c 4c 89
All code
========
   0:	0e                   	(bad)
   1:	0d 00 f7 d8 64       	or     $0x64d8f700,%eax
   6:	89 02                	mov    %eax,(%rdx)
   8:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   f:	eb b8                	jmp    0xffffffffffffffc9
  11:	0f 1f 00             	nopl   (%rax)
  14:	41 89 ca             	mov    %ecx,%r10d
  17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  1e:	00 
  1f:	85 c0                	test   %eax,%eax
  21:	75 11                	jne    0x34
  23:	b8 2c 00 00 00       	mov    $0x2c,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 72                	ja     0xa4
  32:	c3                   	ret
  33:	90                   	nop
  34:	55                   	push   %rbp
  35:	48 83 ec 30          	sub    $0x30,%rsp
  39:	44 89 4c 24 2c       	mov    %r9d,0x2c(%rsp)
  3e:	4c                   	rex.WR
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 72                	ja     0x7a
   8:	c3                   	ret
   9:	90                   	nop
   a:	55                   	push   %rbp
   b:	48 83 ec 30          	sub    $0x30,%rsp
   f:	44 89 4c 24 2c       	mov    %r9d,0x2c(%rsp)
  14:	4c                   	rex.WR
  15:	89                   	.byte 0x89
[  127.144740][ T8310] RSP: 002b:00007fff703c61d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[  127.144745][ T8310] RAX: ffffffffffffffda RBX: 00007fff703c6200 RCX: 00007fd922eb8fa6
[  127.144748][ T8310] RDX: 0000000000000080 RSI: 00007fff703c6200 RDI: 0000000000000003
[  127.144749][ T8310] RBP: 0000000000000001 R08: 00007fff703c61e0 R09: 0000000000000014
[  127.144751][ T8310] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
[  127.144753][ T8310] R13: 00007fff703c61e0 R14: 000056446288e032 R15: 0000000000000000
[  127.144779][ T8310]  </TASK>
[  127.144780][ T8310]
[  127.201576][ T8310] Allocated by task 8310 on cpu 1 at 127.141516s:
[  127.202164][ T8310]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[  127.202606][ T8310]  __kasan_slab_alloc (mm/kasan/common.c:340 mm/kasan/common.c:366)
[  127.203055][ T8310]  kmem_cache_alloc_noprof (./include/linux/kasan.h:253 mm/slub.c:4584 mm/slub.c:4917 mm/slub.c:4931)
[  127.203567][ T8310]  skb_clone (net/core/skbuff.c:2116)
[  127.203962][ T8310]  tcf_mirred_to_dev (net/sched/act_mirred.c:295)
[  127.204420][ T8310]  tcf_mirred_act (net/sched/act_mirred.c:489)
[  127.204861][ T8310]  tcf_action_exec (.net/tc_wrapper.h:59 net/sched/act_api.c:1150)
[  127.205304][ T8310]  tcf_classify (.net/tc_wrapper.h:178 net/sched/cls_api.c:1779 net/sched/cls_api.c:1875)
[  127.205738][ T8310]  tc_run (net/core/dev.c:4415)
[  127.206102][ T8310]  __dev_queue_xmit (net/core/dev.c:4549 net/core/dev.c:4812)
[  127.206560][ T8310]  packet_sendmsg (net/packet/af_packet.c:3107 net/packet/af_packet.c:3139)
[  127.207001][ T8310]  __sock_sendmsg (net/socket.c:775 net/socket.c:790)
[  127.207426][ T8310]  __sys_sendto (net/socket.c:2252)
[  127.207843][ T8310]  __x64_sys_sendto (net/socket.c:2259 net/socket.c:2255 net/socket.c:2255)
[  127.208269][ T8310]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[  127.208688][ T8310]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  127.209223][ T8310]
[  127.209441][ T8310] Freed by task 8310 on cpu 1 at 127.141774s:
[  127.209993][ T8310]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[  127.210418][ T8310]  kasan_save_free_info (mm/kasan/generic.c:584)
[  127.210883][ T8310]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[  127.211316][ T8310]  kmem_cache_free (./include/linux/kasan.h:235 mm/slub.c:2677 mm/slub.c:6377 mm/slub.c:6504)
[  127.211753][ T8310]  ip6_tnl_xmit (net/ipv6/ip6_tunnel.c:1249)
[  127.212175][ T8310]  __gre6_xmit (net/ipv6/ip6_gre.c:787)
[  127.212587][ T8310]  ip6gre_tunnel_xmit (net/ipv6/ip6_gre.c:873 net/ipv6/ip6_gre.c:900)
[  127.213046][ T8310]  dev_hard_start_xmit (./include/linux/netdevice.h:5397 ./include/linux/netdevice.h:5406 net/core/dev.c:3889 net/core/dev.c:3905)
[  127.213513][ T8310]  sch_direct_xmit (net/sched/sch_generic.c:372)
[  127.213950][ T8310]  __dev_queue_xmit (net/core/dev.c:4214 net/core/dev.c:4836)
[  127.214404][ T8310]  sch_frag_xmit_hook (net/sched/sch_frag.c:156)
[  127.214871][ T8310]  tcf_mirred_to_dev (net/sched/act_mirred.c:242 net/sched/act_mirred.c:?)
[  127.215328][ T8310]  tcf_mirred_act (net/sched/act_mirred.c:489)
[  127.215764][ T8310]  tcf_action_exec (.net/tc_wrapper.h:59 net/sched/act_api.c:1150)
[  127.216199][ T8310]  tcf_classify (.net/tc_wrapper.h:178 net/sched/cls_api.c:1779 net/sched/cls_api.c:1875)
[  127.216622][ T8310]  tc_run (net/core/dev.c:4415)
[  127.216988][ T8310]  __dev_queue_xmit (net/core/dev.c:4549 net/core/dev.c:4812)
[  127.217448][ T8310]  packet_sendmsg (net/packet/af_packet.c:3107 net/packet/af_packet.c:3139)
[  127.217906][ T8310]  __sock_sendmsg (net/socket.c:775 net/socket.c:790)
[  127.218332][ T8310]  __sys_sendto (net/socket.c:2252)
[  127.218765][ T8310]  __x64_sys_sendto (net/socket.c:2259 net/socket.c:2255 net/socket.c:2255)
[  127.219197][ T8310]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[  127.219614][ T8310]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  127.220147][ T8310]
[  127.220364][ T8310] The buggy address belongs to the object at ffff888118f85680
[  127.220364][ T8310]  which belongs to the cache skbuff_head_cache of size 232
[  127.221685][ T8310] The buggy address is located 88 bytes inside of
[  127.221685][ T8310]  freed 232-byte region [ffff888118f85680, ffff888118f85768)
[  127.222919][ T8310]


Best,
Shuangpeng
