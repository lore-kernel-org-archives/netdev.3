Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B9372EF3
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 06:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791441148; cv=none; b=HEggW9HGdidCfIpqXZ2ZYQ5wK47XmMuc6FlUEr8JY0iKCKTME6Wr534liZdfKFy1o+XfdPeF1ecvq9RpuhOvz2EiIMbRyh9HSDK7V36c9uxlnv9qmlbbUZVBFgidghO0rLVlSNhEKCFI3r/J4j5XDs7RwxyxjMJ8G8bYUNS1qHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791441148; c=relaxed/simple;
	bh=fXmx+nGIvpnbd8pe1FIdZyIWo74jnyWSmg4x2wEcVuk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EIdEkgBSFfAIX5Qew/CBCz8MuKr6dlrrVJ2CMBJR0rpI9Bf36UK9RbEpnex/MOECnWKcSzCYkIOHOcDy7/yfPbtvDMFCXmXH0C+LSPz+e2bgtPTpwy/kUHFTnOmyWOGdBgxSdw41kWgvf94s2X3e3UmmGBEobwKzx1H8UgiQbsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYUq83FT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYUq83FT"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3a80d1c98f5so2889387a91.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 23:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791441147; x=1792045947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gm+ycg3N8xZsnvvFcj4//dpA7uaGdP+7wCmofLbeyyQ=;
        b=SYUq83FTW6jbz/hJ9sGNmBZWy6TrLZ7xhIRiOsYXvCPCENo/yoEzHzuHY83bkx26mq
         cU1P37rQmm0jVRR0hSTqXaWucQRH/+g1IlpPE0uYyB69PdHQjruC6na3LTkKlWSUPt8B
         EYXdRW3fwPZiM+xQxOigdfTVL2atXMRTLSE9pAxCBGtQUu+BjRXjwK1RZrOuOy2VaIoS
         iqRlFUX7xsWITt9ySnLLEb0jtklO2mak8UDT2zmhxmoS7+FLFgaXw8eY1eMwbc14GqwM
         PFOput95x6YVXhQ7B9t0INPUObmaPDA/E7lFUow6QiH2niVZYmvZT/sD+eBnZ/RtSRCQ
         wwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791441147; x=1792045947;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gm+ycg3N8xZsnvvFcj4//dpA7uaGdP+7wCmofLbeyyQ=;
        b=VvoDiAcIfmEW6zy6BzmLYKM+xUWgit+lWrOUFky/Bjs8RagbPN7QTXO/lDePTYW+xL
         i8rgtz27STSeAKDLLI18DYsIl7s+5UU/34s8lzN35OGt01bJUUxx+6qVy7DlUcjAQQ7A
         83lvEjWlWnMZYbSrTSnnELgAdzx233tLHRFMfOgMuY8XItXoZ/1jp4BBuqZWkwg/EJTS
         qvZjR11i8n/kGB02ZE8aZ6pgzv4hCoP1OC3+G4xqC+tUgG4vyBqHmCpXmGLKz34+c3IS
         Xq2lTxY7tZL1+GQo1n4vPib70byKpTcgZYRDJtnaAjx0VfpWTtl3bfeGWkz0zEJNvPz8
         TF3Q==
X-Gm-Message-State: AFq9FYJzlManN2A3b6tF0j0NOjuBZv5VPj7Y73OgqvUyDucxrnxlwBII
	QfX+b8CUi/zC3kY1uwdUGxfz6EQRYNP68PG0G+L2miXd94dTtiYJqGHR
X-Gm-Gg: AYBFou0ijbfLS/EnBwViDW/t4MnVht8udK5cZG5zFhnITSNLalo4OKqjLn8dWItDquU
	vS7Spl6oLocFvxzQKUCfLxQNIgJqzUlxS1S19avXUIEQY1nUF4IlWIWyPiCkgRtivc1xnmFHUGu
	VGbv6DRn3il8QvJFwzfaJYWAHGXKqT7eOXsgan4BELha7cbYbrXFbhlF0VUcsZUEdFzYjQ6TB3s
	ulrnmxfUkoY74X4ppz+G7OKrKMeRsK0uZV5TY/fhokv5N0etUX6BN9Alrcnt+Xp6ww1MjAOWTLR
	qjfIPLzDxke9OuQvx8LeinaBhTh3eJdjYNQE89HdaMR1bzVNli4sd+1uV007q9bGljNY45RLgGy
	/Y1O1JtsCP/w7PWynLlAp8fGOKaYRjLV7BQ6GdyZcGyvPYVSJ1a/csWAXQgxvouhmecaLVs8k8H
	Jil4Vl2eW2zigz+8PAD++Yf2Bab9Bg9Iabdem6PNNzmLrcZDcv3ZCzqhY0XWwr840tWw==
X-Received: by 2002:a17:90b:4ccc:b0:3a8:6a2f:3ee3 with SMTP id 98e67ed59e1d1-3a8a1be4d13mr4369691a91.49.1791441146478;
        Wed, 07 Oct 2026 23:32:26 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff8669eesm2717780a91.10.2026.10.07.23.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 23:32:26 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] ipv4: Serialize netconf GET requests with RTNL
Date: Thu,  8 Oct 2026 14:32:18 +0800
Message-Id: <pm-ip-core-objects-candidate-0002-v3-4af089192b0b62b40b9c@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An in_device returned by in_dev_get() must stay alive until
inet_netconf_get_devconf() finishes reading its cnf. However, the helper
samples dev->ip_ptr under RCU and unconditionally increments refcnt,
then returns the pointer outside RCU without checking whether the count
was already zero. The net_device reference held by the request does not
retain the separately allocated in_device.

A down interface without IPv4 addresses or multicast owners can have
only the ip_ptr publication reference. Lowering its MTU below
IPV4_MIN_MTU invokes inetdev_destroy() through the RTNL-held
NETDEV_CHANGEMTU notifier. RTM_GETNETCONF runs without RTNL, allowing
the final put to follow its pointer sample but precede its increment:

  RTM_GETNETCONF                   MTU change (RTNL held)
  in_dev_get():
    rcu_read_lock()
    sample dev->ip_ptr
                                  inetdev_destroy():
                                    clear dev->ip_ptr
                                    in_dev_put(): refcnt -> 0
                                    call_rcu(in_dev_free_rcu)
    refcount_inc() from zero
    rcu_read_unlock()
                                  in_dev_free_rcu(): kfree()
  inet_netconf_fill_devconf():
    read in_dev->cnf

The zero-count increment warns and saturates the refcount, but cannot
cancel the queued free. Once the request leaves RCU, the callback can
free the attachment before the configuration read, causing a
use-after-free. Restoring a valid MTU can publish a new attachment on
the same device while the request still holds the old pointer.

Drop RTNL_FLAG_DOIT_UNLOCKED so rtnetlink holds RTNL from lookup through
reply construction and reference release. This serializes the request
with inetdev_destroy(), preventing the publication reference from being
dropped during acquisition or use. The dump handler already holds RCU
through its configuration reads and keeps RTNL_FLAG_DUMP_UNLOCKED.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in inet_netconf_fill_devconf+0x748/0x790
    Read of size 4 at addr ffff88811d70b958 by task ip_core_fixture/498

    CPU: 1 UID: 0 PID: 498 Comm: ip_core_fixture Tainted: G        W           7.2.0-rc5-pmb-bt-functional-v1+ #1 PREEMPT(lazy)
    Tainted: [W]=WARN
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? inet_netconf_fill_devconf+0x748/0x790
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? inet_netconf_fill_devconf+0x748/0x790
     kasan_report+0xe0/0x110
     ? inet_netconf_fill_devconf+0x748/0x790
     inet_netconf_fill_devconf+0x748/0x790
     ? __pfx_inet_netconf_fill_devconf+0x10/0x10
     ? inet_netconf_get_devconf+0xaef/0xe40
     inet_netconf_get_devconf+0x41c/0xe40
     ? __pfx_inet_netconf_get_devconf+0x10/0x10
     ? __pfx_inet_netconf_get_devconf+0x10/0x10
     ? rtnetlink_rcv_msg+0x795/0xce0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x280
     ? __pfx_inet_netconf_get_devconf+0x10/0x10
     rtnetlink_rcv_msg+0x7b9/0xce0
     ? __pfx_rtnetlink_rcv_msg+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __lock_acquire+0x466/0x2260
     ? lock_acquire+0x17b/0x2f0
     netlink_rcv_skb+0x133/0x390
     ? __pfx_rtnetlink_rcv_msg+0x10/0x10
     ? __pfx_netlink_rcv_skb+0x10/0x10
     ? netlink_deliver_tap+0xdf/0xbd0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? netlink_deliver_tap+0x173/0xbd0
     netlink_unicast+0x504/0x840
     ? __pfx_netlink_unicast+0x10/0x10
     netlink_sendmsg+0x7f7/0xcf0
     ? __pfx_netlink_sendmsg+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? selinux_socket_sendmsg+0x160/0x280
     ? __pfx_netlink_sendmsg+0x10/0x10
     ____sys_sendmsg+0x88b/0x9d0
     ? __pfx_____sys_sendmsg+0x10/0x10
     ___sys_sendmsg+0x125/0x1d0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx____sys_sendmsg+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x280
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? netlink_bind+0x518/0x900
     ? srso_alias_return_thunk+0x5/0xfbef5
     __sys_sendmsg+0x13e/0x1e0
     ? __pfx___sys_sendmsg+0x10/0x10
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    RIP: 0033:0x7f8ea8b31687
    Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
    RSP: 002b:00007fff83200d90 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
    RAX: ffffffffffffffda RBX: 00007f8ea8a9f780 RCX: 00007f8ea8b31687
    RDX: 0000000000000000 RSI: 00007fff83200e50 RDI: 0000000000000003
    RBP: 00007fff83202ed0 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
    R13: 00007fff83203070 R14: 00007f8ea8cdd000 R15: 0000559d62722c80
     </TASK>

    Allocated by task 496:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x630
     inetdev_init+0x60/0x550
     inetdev_event+0x71e/0x1780
     notifier_call_chain+0xbb/0x330
     call_netdevice_notifiers_info+0xa2/0xf0
     register_netdevice+0x17b0/0x2090
     rtnl_newlink+0x1a30/0x1f40
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
     kfree+0x12b/0x530
     in_dev_free_rcu+0x51/0x90
     rcu_core+0x661/0x1d10
     handle_softirqs+0x201/0x930
     __irq_exit_rcu+0x110/0x1e0
     irq_exit_rcu+0xe/0x20
     sysvec_apic_timer_interrupt+0x6c/0x80
     asm_sysvec_apic_timer_interrupt+0x1a/0x20

    Last potentially related work creation:
     kasan_save_stack+0x33/0x60
     kasan_record_aux_stack+0xa7/0xc0
     __call_rcu_common.constprop.0+0x76/0xbd0
     in_dev_finish_destroy+0x12e/0x190
     inetdev_event+0xa37/0x1780
     notifier_call_chain+0xbb/0x330
     call_netdevice_notifiers_info+0xa2/0xf0
     netif_set_mtu_ext+0x47d/0x6a0
     netif_set_mtu+0x8b/0x120
     dev_set_mtu+0xb9/0x180
     dev_ifsioc+0x3b8/0x1820
     dev_ioctl+0x301/0xf80
     sock_do_ioctl+0x1dc/0x2b0
     sock_ioctl+0x41b/0x670
     __x64_sys_ioctl+0x163/0x1d0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    The buggy address belongs to the object at ffff88811d70b800
     which belongs to the cache kmalloc-512 of size 512
    The buggy address is located 344 bytes inside of
     freed 512-byte region [ffff88811d70b800, ffff88811d70ba00)

    The buggy address belongs to the physical page:
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11d70b
    flags: 0x200000000000000(node=0|zone=2)
    page_type: f5(slab)
    raw: 0200000000000000 ffff888100042780 dead000000000122 0000000000000000
    raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff88811d70b800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff88811d70b880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    >ffff88811d70b900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
     ffff88811d70b980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff88811d70ba00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    ==================================================================

Fixes: bbcf91053bb6 ("inet: do not use RTNL in inet_netconf_get_devconf()")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 5b6b11c943e453742b4893f1c9bd9e70d3d37a6f..4e9de0c6b2c1426c4b4c8638a0a6da4be9c2034d 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2958,7 +2958,7 @@ static const struct rtnl_msg_handler devinet_rtnl_msg_handlers[] __initconst = {
 	 .flags = RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
 	{.protocol = PF_INET, .msgtype = RTM_GETNETCONF,
 	 .doit = inet_netconf_get_devconf, .dumpit = inet_netconf_dump_devconf,
-	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
+	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
 	{.owner = THIS_MODULE, .protocol = PF_INET, .msgtype = RTM_GETMULTICAST,
 	 .dumpit = inet_dump_ifmcaddr, .flags = RTNL_FLAG_DUMP_UNLOCKED},
 };
