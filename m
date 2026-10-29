Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793243893;
	b=sRSUkceerD+JslY/09dNjt/L/i1G9+GB84A/vGvDfoSVybg78S1dilhM0+21kxurOwIx
	 /xXpGMwDqOsumiZJHBO79Ewx27oD1Rh1EfbHk4UYqFL9Ol/YWf5sXdnW/nbS7wEy12nuN
	 SaOF5eDeZU0A79D/vwNLYHxiYM3fbAixrxQFac6jjR5d2xY1FvvXixrT1jK/8R70DP/Kq
	 2BUQA9v55bKEHpLHOBMdKKUrucPlSgZgL7d808Crq2p5WjOxXPMBxUNI0Lm0D9CNJ+x95
	 qaVfL6eMFo3Lq7H5//TxeMXxYpU88OLcNeQULTr086RRfAWjnCZARAc4+TMrVXUJ1KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sVpMhQ7sjjPYMREctOOsXa7G2vPJRFVFewpef6DspX8=;
	b=c6lPfr+SWDTJHImWaZC4sy9csEvH85CcgZPFB88CkRL6UqYnt5aqrriF1go209/N7BFa
	 QAxXDWSU3qwchmLJ3FAPDANldykFqByD7j/Ph/x5Xu23CpacXOAJF3QhX08GaOhyp38V+
	 j9qoQ5vCCHMddkEcGm643yEA+r1XL6oRr37QfUEi4ONYE4DIQShfrl7c9ViEQJ9m39qGk
	 e9IZGLErvuw2QAqOGWZrBzMVSrKhsHvewaqtgRclm+UPm8YyGcQS5loOCCfeP8QY5H+Jp
	 3shIGkPrYTcRk47nca4kFsda/wZ5LxjKDKxVzYM26SUshX1SOdEjmAr7D7Ura/hUQHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyJ7QUHq;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA22606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CA22606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyJ7QUHq
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e608cd460eso9925105ad.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 20:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793243892; x=1793848692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sVpMhQ7sjjPYMREctOOsXa7G2vPJRFVFewpef6DspX8=;
        b=LyJ7QUHqFetBHNPOi7UdJZ5NT5h/pMYlKH1GF84cspaPr0ORv5XRi5jtTA/DR6i1T8
         DlHPDG/5mpPthtIu+gSWBgXzJHYlOjKdXQ60SfDRx4Idd5BrsJv2Wi8AORe9a58QPddp
         Ti02NkQXQICLl5WY42ZOFL2kBeZqf25vaE7Kh9ovcPIBTzK65GJiFF11+rCuLqgfhyjK
         hd+r1IcLUW6Hve56AT6anZjhcTAW9Rt6c/LSBdHKk15vZ2MoUj5T7dtZgejvMucqAE7I
         ZnL0Qm2geUz+pr+N3fqJyPslNivqVJrlUfUCdP2OX1hLesmtvkUEEX8YTbUyiX1X7FC8
         EccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793243892; x=1793848692;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sVpMhQ7sjjPYMREctOOsXa7G2vPJRFVFewpef6DspX8=;
        b=LAPi8RijdPJXnsjC7PjQRfDGLCNDpTh8JuJEoWkF3t2sEJIP3EgDTkk2iq/20yDf+d
         qoUAue3bXo55dkLzlHbwGV7ig6yEhAUVQ/U/3cq6tPCAI32WjgoJdnRYhkodWFEBptFV
         3nh90bPPZ7QTuzFRoQmDbXkJdJtuUPRnxfgdx5OpO/PgR7hcbg9S3lPQUuAqqEuLdlCO
         HfJLHrxZpesayCGWLEDTMvYMywuC/8ZUsSSOY+JKezXojJHMC7xUXvsa+247W1nyc20Q
         VJ1Po+JNDypBH99scSMAElkrwOhEcdO+aW8Qmmp7KajZZRNHNlFrZLj+0jKYvB7jC1rs
         S+sg==
X-Forwarded-Encrypted: i=1; AKwUvBxCn6r5PFqPVdWHurGIcDQxqGBnpSQQgEn+PMsFcON1zK1Gi7ZmQCPZMjT3VS9KKGta/02BCcw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdwHVV0l/EYkD9XLpytEGIXwcplIXvGxvUuSlPFzJqxqoSQbOl
	nM7QLopvyIYlufjMLHuSx7VBUt7sUzYDE4Rvr6zgBuqIUTaegfBeYbao
X-Gm-Gg: AYBFou1qaGfo/eShQ/2aFXz6Sd18CfAIgfPDMgu+ElZaSenlP3GJXEwReByVJvqetVz
	CkW7DB8M7eg9cH94WbkCi/KvxDHznvQDMP8dSlLcx55AyktWBtwOaFzPf1DGebG4+HzZC1j7KAP
	BxQsDmo+Ih2dkgC1rbTiKdzqcN8uP2w8Ko+PcbfUW2utb1uZehNW772zOhuloQiIign6oI15S0m
	vezkHIlshxuYpwAdYesyosPc0mCmV6OgQM1fuI41FQpKRi/YG09mlUE1VNhHArV9K7jsyoTHtHz
	J/LQjG2y+V4yG3bwTfbF60iJuxAfMOxpq5qYgZfhqWs4k8In+tEYrUPXN9Vl4Gke/OT5gfqvlpx
	wuTDFg4cFSt3fv830JyyE8osOrrFPpiC1grSZNn26ltehWS2YuOtSeEnTziKWWRNh0IP9zXviFc
	DYzhGr1fgAOMIa/rTPRlHanFr2ztNhIF6oxXYyJV+DkRO6GR5f81wAFKJ7YDmT4/UuCOn21oku1
	xqt+Ve5SKBgtyoi4gsSi9h3f1FM4NtGv3QO5gAEJyV64GMbHIWb8B1v4z5GvMrKJRiHuXf7rCvU
	PnMwDtePbS6UHRjPfYaDUh8Ljw==
X-Received: by 2002:a17:903:3c43:b0:2e2:c55c:90c with SMTP id d9443c01a7336-2eb0052f293mr33111045ad.64.1793243892404;
        Wed, 28 Oct 2026 20:18:12 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c34c1csm26620915ad.46.2026.10.28.20.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 20:18:11 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH ipsec] xfrm: protect offload statistics device access with RCU
Date: Thu, 29 Oct 2026 11:18:05 +0800
Message-Id: <pm-xfrm-core-objects-candidate-0050-v3-dbfb7194ffb750193d02@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The offload device must remain alive while copy_to_user_state() reads
its operation table through xfrm_dev_state_update_stats(). GETSA holds
a reference to the xfrm_state, but device teardown can release the
state's device reference before that state reference is dropped.

With an offloaded SA, GETSA can sample xso.dev while another task takes
the device down and unregisters it. For example, deleting a netdevsim
port through sysfs can overlap a GETSA request for an accepted crypto
offload SA. The XFRM configuration mutex does not serialize the request
against the netdevice notifier:

  GETSA                              Device teardown
  -----                              ---------------
  look up and reference x
  copy_to_user_state(x)
    sample dev = x->xso.dev
                                     xfrm_dev_state_flush()
                                       xfrm_state_delete(x)
                                       xfrm_dev_state_free(x)
                                         clear x->xso.dev
                                         put device reference
                                     synchronize_net()
                                     finish unregister and free dev
    read dev->xfrmdev_ops

The sampled pointer does not hold a device reference or participate in
the unregister grace period, so the last read can access freed memory.

Wrap the serializer's statistics update in an RCU read-side critical
section. Device unregistration calls synchronize_net() after the XFRM
notifier has cleared the binding and before releasing the device. A
reader that sampled the old binding must therefore finish its device
access before final release; a later reader finds the cleared binding.
The helper already runs from atomic contexts, so this section does not
add a sleeping operation.

The report below was collected on an earlier kernel with a built-in
pmbdxfrm test endpoint supplying no-op offload add/delete callbacks.
Scheduling probes paused GETSA after sampling the device, then ran
normal link-down and link-delete requests before resuming the read.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in copy_to_user_state+0x6ce/0x6e0
    Read of size 8 at addr ffff888104be0308 by task ip/446
    
    CPU: 3 UID: 0 PID: 446 Comm: ip Not tainted 7.2.0-rc5-pmb-xfrm-functional-v1+ #3 PREEMPT(lazy) 
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? copy_to_user_state+0x6ce/0x6e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? copy_to_user_state+0x6ce/0x6e0
     kasan_report+0xe0/0x110
     ? copy_to_user_state+0x6ce/0x6e0
     copy_to_user_state+0x6ce/0x6e0
     copy_to_user_state_extra+0x8a/0x1450
     ? __pfx_copy_to_user_state_extra+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __asan_memset+0x23/0x50
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __asan_memset+0x23/0x50
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __nlmsg_put+0x157/0x1c0
     dump_one_state+0x1fd/0x440
     xfrm_state_netlink+0xda/0x150
     ? __pfx_xfrm_state_netlink+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? xfrm_user_state_lookup.constprop.0+0x28e/0x330
     xfrm_get_sa+0x12d/0x320
     ? __pfx_xfrm_get_sa+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __nla_parse+0x40/0x60
     ? __pfx_xfrm_get_sa+0x10/0x10
     xfrm_user_rcv_msg+0x3b3/0xc20
     ? __pfx_xfrm_user_rcv_msg+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? stack_trace_save+0x93/0xd0
     ? __pfx_stack_trace_save+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? stack_depot_save_flags+0x29/0x9a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_lock+0x182c/0x2590
     netlink_rcv_skb+0x133/0x390
     ? __netlink_lookup+0x5e4/0x7e0
     ? __pfx_xfrm_user_rcv_msg+0x10/0x10
     ? __pfx_netlink_rcv_skb+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? netlink_deliver_tap+0xdf/0xbd0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? netlink_deliver_tap+0x173/0xbd0
     xfrm_netlink_rcv+0x76/0x90
     netlink_unicast+0x504/0x840
     ? __pfx_netlink_unicast+0x10/0x10
     netlink_sendmsg+0x7f7/0xcf0
     ? __pfx_netlink_sendmsg+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? selinux_socket_sendmsg+0x160/0x280
     ? __pfx_netlink_sendmsg+0x10/0x10
     ____sys_sendmsg+0x88b/0x9d0
     ? __pfx_____sys_sendmsg+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __lock_acquire+0x466/0x2260
     ___sys_sendmsg+0x125/0x1d0
     ? __lock_acquire+0x466/0x2260
     ? __pfx____sys_sendmsg+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? do_getsockname+0x130/0x1b0
     ? __pfx_do_getsockname+0x10/0x10
     __sys_sendmsg+0x13e/0x1e0
     ? __pfx___sys_sendmsg+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __sys_getsockname+0xbc/0x110
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    RIP: 0033:0x7f74d2c0b687
    Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
    RSP: 002b:00007ffee6b82680 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
    RAX: ffffffffffffffda RBX: 00007f74d29de840 RCX: 00007f74d2c0b687
    RDX: 0000000000000000 RSI: 00007ffee6b82730 RDI: 0000000000000004
    RBP: 00007ffee6b82730 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000202 R12: 000055cc4cbea909
    R13: 00007ffee6b82870 R14: 00007ffee6b82800 R15: 00007ffee6b83e13
     </TASK>
    
    Allocated by task 420:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kvmalloc_node_noprof+0x353/0x930
     alloc_netdev_mqs+0xa0/0x1250
     rtnl_create_link+0xb8e/0xeb0
     rtnl_newlink+0xb7b/0x1f40
     rtnetlink_rcv_msg+0x7b9/0xce0
     netlink_rcv_skb+0x133/0x390
     netlink_unicast+0x504/0x840
     netlink_sendmsg+0x7f7/0xcf0
     ____sys_sendmsg+0x88b/0x9d0
     ___sys_sendmsg+0x125/0x1d0
     __sys_sendmsg+0x13e/0x1e0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    
    Freed by task 451:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     device_release+0xd7/0x280
     kobject_put+0x1ad/0x610
     netdev_run_todo+0x927/0x13d0
     rtnl_dellink+0x3aa/0xa30
     rtnetlink_rcv_msg+0x7b9/0xce0
     netlink_rcv_skb+0x133/0x390
     netlink_unicast+0x504/0x840
     netlink_sendmsg+0x7f7/0xcf0
     ____sys_sendmsg+0x88b/0x9d0
     ___sys_sendmsg+0x125/0x1d0
     __sys_sendmsg+0x13e/0x1e0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    
    The buggy address belongs to the object at ffff888104be0000
     which belongs to the cache kmalloc-4k of size 4096
    The buggy address is located 776 bytes inside of
     freed 4096-byte region [ffff888104be0000, ffff888104be1000)
    
    The buggy address belongs to the physical page:
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x104be0
    head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
    flags: 0x200000000000040(head|node=0|zone=2)
    page_type: f5(slab)
    raw: 0200000000000040 ffff888100043040 dead000000000122 0000000000000000
    raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
    head: 0200000000000040 ffff888100043040 dead000000000122 0000000000000000
    head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
    head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
    head: ffff888104be1f50 0000000000000000 00000000ffffffff 0000000000000000
    page dumped because: kasan: bad access detected
    
    Memory state around the buggy address:
     ffff888104be0200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff888104be0280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    >ffff888104be0300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
     ffff888104be0380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff888104be0400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    ==================================================================

Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM

---
 net/xfrm/xfrm_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a5fbe38839c4..e9dd98c387da 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1179,8 +1179,11 @@ static void copy_to_user_state(struct xfrm_state *x, struct xfrm_usersa_info *p)
 	memcpy(&p->id, &x->id, sizeof(p->id));
 	memcpy(&p->sel, &x->sel, sizeof(p->sel));
 	memcpy(&p->lft, &x->lft, sizeof(p->lft));
+	/* Pairs with synchronize_net() in netdevice unregistration. */
+	rcu_read_lock();
 	if (x->xso.dev)
 		xfrm_dev_state_update_stats(x);
+	rcu_read_unlock();
 	memcpy(&p->curlft, &x->curlft, sizeof(p->curlft));
 	put_unaligned(x->stats.replay_window, &p->stats.replay_window);
 	put_unaligned(x->stats.replay, &p->stats.replay);
