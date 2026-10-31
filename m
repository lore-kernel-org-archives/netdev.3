Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793420113;
	b=UVYzDAPkJyoBhxM/Q29ibRHBfgVPvW+NRqmNA4h3G6Pe5TI1/rhgqkrZYBZ+pibCsGdA
	 oxQ5T45eVqY9zPks9W9if1w311sNmrhWgnoWQg93lqSSrLfjVAPvznn/ISDpb7OoQrXXq
	 qA5QiFJ9nlz2cJEu7umdZBzbYmxNtCMcdSGOtgdMePWTmbpecMtMdXtINLthRoaASu4Cf
	 tbwqKA0M8GATD1n8PXSkiYupKxdQEZ7zPGHkrFmqLhpVQCm6c/8vYzai16Zrbv0w1hKQ7
	 uzwKxn5epraZtPXc17H98XqTdngLy43hTkVcoiqayVaBxy1Z8SAD9XvNiw6N0N5rGjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793420113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/Vfz1DbncV56dq7v1HZ9cnjldjr/F1zhzitP90vTq5E=;
	b=cG8TKNBwMKL7VMgPsmOmwZZPgFk0Z1WVdKk6RCPCsNgJAmv3bOJT429q1EGU1YIdBgg7
	 dBMfHxyvpbSaN0GNV0peoc5mSShET9ythpsgV50unjqaxf9PDo/vnpL2J+/OShzPIWXvQ
	 2rft1avJo0GSITM+sFXXLRGcMSlv6uIrXA2t2Wk3oRN5lfSen77xjOwQPirgr5G0G9QHF
	 cNy+yih/bSywW4Z1fRJRzraI2Mq2EXCMTYS2dMGmmgTnE0Qv9Zet9oGhgGQolgz1+OAYi
	 /8VTkwyyuXTDEMFPHR9/GFoE0xbjbCYhNbtsOFcwOGxtRbbvOu+tO9nfrG1KPaGOA8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PtuNSwpR;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCB2606A322
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 04:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFCB2606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PtuNSwpR
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9d7791b00so10858065ad.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793420112; x=1794024912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Vfz1DbncV56dq7v1HZ9cnjldjr/F1zhzitP90vTq5E=;
        b=PtuNSwpR3ysNvmiW+q/tlsTu4jOW75gUujD8UbzX1v7pUhK+RSfzJMQBhtE6J5na9c
         mcNffw61u1pcSIW/IxLmxN6pSmT5B8ejj/5iq8fSnal/6UFByzGPLZ/3mRamIhvoFf4G
         mpCYVhu7kKTOAfJiFhRwJi8MwX+8ECyBVLXnbmIohocckP7YsqGl1l/0SRNWoqIVeYXw
         Ay/djVDy+4lYU62+TcAxbyE9Yy9MTSwa7wVjleUjCavFeHK4islIn/knOstApN9JKUWs
         IRaml2IZ5ytz2qOoIi7/MazAhCnMt+35ETTioiVGoYurhDX1ooHM9giwZTV9bY3QfuBN
         hnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793420112; x=1794024912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Vfz1DbncV56dq7v1HZ9cnjldjr/F1zhzitP90vTq5E=;
        b=mh3ArL9oiF2rDuu9YsCNdNs983YkE27CHuaFS77T13v6aT/NVtvQ6sf6RgBObKazRB
         epVx+2bUnqatRo1uPE8eTO5Ck+NgVWTd5L1iZr0RNhUkIiok4bXikIgBhBVUVFyuHXLh
         uS5DhZo/km6xx8jZQdTK2TncYEiI8YsaPu/Tm5ABEnO/uV9gw7cpSY2jxZxiyK4p0lUh
         qEmjZ1nFXRQrgXP0cFs309R5rx8DLqqM299eRjer2aC0Q7uFpsljJl3SNVTb57wYkQG8
         d7lPvQGwe36C1wJ8EZ+jR+fd3LTzM0Orc2BL2s/P5SxtJyn8Gz2cVof1MKnsUUexEVZQ
         iF+A==
X-Forwarded-Encrypted: i=1; AKwUvByXXVm7ctcwOpK8U2oguI2HAai0DEcZEXcwNV9q5a7XA84IScTaVP4p4ffi/Ask76WYjIFM9fY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxgbRUSlp5uzBaeSAneGdsrOJHSeZMwsNistRtgtWMBC8O/INx
	wg6gywg5HbrtAM5bcqn/H1bvRkYTJ/PhWHPX/ZcQnZAXgxWJ3H7J1M+C
X-Gm-Gg: AYBFou10OwswWkbsZzco4spNuz0lXTPQYnifTvYBqa1RU9yHzYKv4bWd7H7ylDYyTgx
	vX53q5GcBzd/3EslvvMBOrG/kzI2jXZ7pXs2tAuvTrUU+oSwJqf6FfZZWn9HXsmLIwi6U4Nl5Ar
	QZ/kn9L56OMn4js4n83AWaCXnjD79SnuXPBlGKe4nZ2fppl9UFEfduAjtfpjy2kJd36XHAfF/Pl
	5xbYpkFa6+F+MZN8JHZ/HBkxSSoK4ut8MjzmO92iaWC39aee7ic21aa3xVzR3Uqm4jvRA7a1kYd
	tPCiwpF/eKcblqDR3a0APzG5Lt+ZvIHCdCO7dkxi1HnJqf+BREj7xfwX1wHzqonnOxbOFKxiMuG
	VKpJRdcP6f1KhvfyflxHmdPajLdsYt5EfPiWBkK0Clywunu23JU2mWxIwIRRzZoJX8tlrs+rL7B
	XTfC80dLj2Ln+udGj20liu+WNBVzucWO2kUukIHpPmbjZmUAtT1c1fshkTgtoCN+HrBSQxBDWMU
	raYK60zH4Qu1aJy+lM1cqs/EQIpdwvt4U/1x0dV0z+ta+QRgl6UXBzTKogtD32Ypx4ioek7wuba
	43eV+igLvs32z2v7bbrQTLhg
X-Received: by 2002:a17:90b:580d:b0:3ac:7378:be04 with SMTP id 98e67ed59e1d1-3ae891717d5mr3495257a91.0.1793420111634;
        Fri, 30 Oct 2026 21:15:11 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845d5e62sm6384937a91.13.2026.10.30.21.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 21:15:11 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH ipsec 2/2] xfrm: hold migrated states through rollback
Date: Sat, 31 Oct 2026 12:14:55 +0800
Message-Id: <pm-xfrm-core-objects-candidate-0027-v3-cb1e033bff1976f510c9-2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-xfrm-core-objects-candidate-0027-v3-cb1e033bff1976f510c9-0@gmail.com>
References: <pm-xfrm-core-objects-candidate-0027-v3-cb1e033bff1976f510c9-0@gmail.com>
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

xfrm_migrate() needs to keep each new state alive until it either commits
or rolls back the migration. xfrm_state_migrate() publishes the successor
using its initial reference as SAD ownership, then returns it without a
caller reference. The pointer saved in x_new[] can therefore outlive the
state.

A legacy migration can find an existing policy with no matching templates,
install a successor and then fail xfrm_policy_migrate() with -ENODATA. If
the successor inherits a finite hard lifetime and the migration task is
delayed before rollback, expiry and GC can finish first:

  Migration task                  Timer / GC
  xfrm_state_migrate()
    publish xc, arm mtimer
  save xc in x_new[]
  xfrm_policy_migrate()
    return -ENODATA
  <task delayed>                  xfrm_timer_handler(xc)
                                    __xfrm_state_delete(xc)
                                    drop SAD reference
                                  xfrm_state_gc_task()
                                    synchronize_rcu()
                                    free xc
  xfrm_states_delete(x_new)
    xfrm_state_delete(xc)
      spin_lock_bh(&xc->lock)

The control mutex does not serialize the timer or GC, and migration holds
no RCU read lock across this interval. Rollback consequently accesses the
freed state's lock. This also affects the PF_KEY migration entry, which
uses the same helpers.

Take a caller reference before installing the successor, and release it
on installation failure or after the transaction succeeds. On rollback,
delete the successors before dropping their caller references. This keeps
each allocation alive even if its timer has already removed it from the
SAD.

The reported execution used trace probes and paused the netlink migration
before the rollback lock access while the normal timer and GC ran. The
userspace setup installed an SA with a five-second hard lifetime and a
policy without templates using ordinary XFRM requests.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in _raw_spin_lock_bh+0x38/0x50
    Read of size 1 at addr ffff8881076d6248 by task python3/417

    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     kasan_report+0xe0/0x110
     __kasan_check_byte+0x36/0x50
     lock_acquire+0x113/0x2f0
     _raw_spin_lock_bh+0x38/0x50
     xfrm_state_delete+0x26/0x60
     xfrm_migrate+0x11af/0x18a0
     xfrm_do_migrate+0x797/0xad0
     xfrm_user_rcv_msg+0x3b3/0xc20
     netlink_rcv_skb+0x133/0x390
     xfrm_netlink_rcv+0x76/0x90
     netlink_unicast+0x504/0x840
     netlink_sendmsg+0x7f7/0xcf0
     __sys_sendto+0x425/0x470
     __x64_sys_sendto+0xe5/0x1c0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
     </TASK>

    Allocated by task 417:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_slab_alloc+0x89/0x90
     kmem_cache_alloc_noprof+0x20b/0x5f0
     xfrm_state_alloc+0x28/0x5d0
     xfrm_state_migrate_create+0x55/0x2470
     xfrm_state_migrate+0x37/0x450
     xfrm_migrate+0x80b/0x18a0
     xfrm_do_migrate+0x797/0xad0
     xfrm_user_rcv_msg+0x3b3/0xc20
     netlink_rcv_skb+0x133/0x390
     xfrm_netlink_rcv+0x76/0x90
     netlink_unicast+0x504/0x840
     netlink_sendmsg+0x7f7/0xcf0
     __sys_sendto+0x425/0x470
     __x64_sys_sendto+0xe5/0x1c0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 11:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kmem_cache_free+0x242/0x580
     xfrm_state_gc_task+0x533/0x730
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    The buggy address belongs to the object at ffff8881076d61c0
     which belongs to the cache xfrm_state of size 936
    The buggy address is located 136 bytes inside of
     freed 936-byte region [ffff8881076d61c0, ffff8881076d6568)
    ==================================================================

Fixes: 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Assisted-by: LLM

 net/xfrm/xfrm_policy.c | 5 ++++-
 net/xfrm/xfrm_state.c  | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 55f6bacc4e51..cced7928e980 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4733,6 +4733,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	/* Stage 5 - announce */
 	km_migrate(sel, dir, type, m, num_migrate, k, net, encap);
 
+	xfrm_states_put(x_new, nx_new);
 	xfrm_pol_put(pol);
 
 	return 0;
@@ -4744,8 +4745,10 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		xfrm_pol_put(pol);
 	if (nx_cur)
 		xfrm_states_put(x_cur, nx_cur);
-	if (nx_new)
+	if (nx_new) {
 		xfrm_states_delete(x_new, nx_new);
+		xfrm_states_put(x_new, nx_new);
+	}
 
 	return err;
 }
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 0555e5d796ed..b9db6e903292 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2238,8 +2238,12 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 
 	xfrm_migrate_sync(xc, x);
 
-	if (xfrm_state_migrate_install(x, xc, m, extack) < 0)
+	/* Hold a reference for the caller before publishing the state. */
+	xfrm_state_hold(xc);
+	if (xfrm_state_migrate_install(x, xc, m, extack) < 0) {
+		xfrm_state_put(xc);
 		return NULL;
+	}
 
 	return xc;
 }
