Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793420108;
	b=fO+wfeSkqfSa8Yy6ZF6NWIYuAF2hcHU6D30fEWPmjyOOXWhyEW3y8ZUaaOUxZ/BQZOkC
	 aVHJMv+SOblpDD/cwrZdaY5AEbyaq2MBV6cNjAgA6H1AUlBWmJiZ4RlYG7dL/BB0iiphl
	 BRQsgpHG0FgvGQiduWicXXUrmX8i5g80tl9qfwDrwCepVvmj4kRIU0AZT4hg6Yj8mXV6K
	 +a2XdA3Ec1Xp36+1vjI3gqcyyckDnIIjBKAl/uGjSQjieFV4WRqX6bTUEs4cV65osGT3J
	 33u9SRWAQ18VviSq0/wgnPmM0iUuKp9ecyRuHPJMjlW0wk+/85SQsAUzDqwy0q5RoOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793420108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=x+rKubYkXxcZT25UjjjDd0EB0AlXDRKncuYtQO1X0EY=;
	b=O47TkvQ8lxp9OJMezhl9Krh2GBY6NEIS+n3HDVrLepuMBmOaLXwbzWbor1XiTUuDWWiK
	 DLEmU7VTcB3W9hvdjI3RH0kMGTFpcUxEvKLTWfc1fw7RPGCyWE+6UNU3VxczXiy26JZ3O
	 PWZ/GWHuJHKaS5npK7gIAvVDjPJmHthnDxG1N5yLXX3nxu5Qn/PKHBK8NQLexEq+GOlnT
	 zMoKTW+C0o9kzWkiy8VhGUi31Ff/0/HiZ0XTSmED5qcdN99dJnrnoeUMhVzyeHZOFMvGl
	 pp4DhLeHSFFUHO9/QEao4M0diBfgKT4xeoeEJsTjpcJJD1PyQyKS+rpw1LvuCXAWVOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MGbp6Tj7;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D178606A324
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 04:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D178606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MGbp6Tj7
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so1050741a91.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793420107; x=1794024907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x+rKubYkXxcZT25UjjjDd0EB0AlXDRKncuYtQO1X0EY=;
        b=MGbp6Tj7sBgV/c4qhrOC+rP4piSwHUf3eGhuIy2qs0O1IvLbfjzKt5DXkzWf0U7/Dc
         Q5zfR2XueryaaivGuSgnLzm+d5yXMdT0BVan7fK27WHUKQlxgWUwuJmxrhPwtx7qK32X
         YPKI5lIxeaTsZAHRZ/BVqlAlPmvkJWcm+wyqGnjJcTRj4mvlmMXTjc7l9fWsne2OXUnc
         9Y+7cfVxOeMkyN7Iiqd6i3P1gFfwFRR7arMtXj7NIfBRcIQ3IfAHFXxB82R1q/90gaAG
         YeLxoXZYEdM/nQILri2lan8wQGi+9G8n+zyyTkOr5ldKOphz/RCVyV6tJmjGDJS1x6Na
         i3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793420107; x=1794024907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x+rKubYkXxcZT25UjjjDd0EB0AlXDRKncuYtQO1X0EY=;
        b=n0J95LfnrqY4efbvIZx9Vy4sy7RqfQ6o9UvbveeEC1+sJSGC67AcNOAi9RhMDrRvoP
         jjcMjoZylVXleod5+N58+LhG8kqm28NiXjJqJjOOpIGLIV0tIMt8zJLqRycRJXc4h+R6
         NUf3FG49BF9vLZ2wepkoShyR2ZBTVqwv401lzXGYvcjIK++folVQik/UwPoasknWZ0if
         Tvs97f1BWyCs50vGq5p5rR7p6VWL92HMQeQKJjx5klPbWaTeC3ZIoc89w5nZr0j9l4Ip
         +ni6ROEhZaerVdpgtjbcEEFfzIBwJ+W0xVKIz6KfdqXPuOiBW6yRyduIPMzzLs1mPXUx
         eK/g==
X-Forwarded-Encrypted: i=1; AKwUvBzjsDnqCtNe7kab69j16zAPL+IUFmsEF9hPSkBeOwdoyL1O20EwWffkYpRQwAzzttxId8WbDmY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQRhtmaHIyD5eAJckQs1VJR8hqh6lTViS65f0pKmE715t2g8nU
	Jb+DLGVAgmyk3IXc/1bSQ/jSKym1G6O3dBoBHvSCdUyiDWTRcW4PUINx
X-Gm-Gg: AYBFou0YI966uKi5BEhCqy/EY3p7RMAfKUie0G+urwiyJycxTFs5tb3pu0Cj7uPGk7p
	7jUG+Uc01Uq4xJ7mgYluOviEwScLEQLtMN1VQO58A7AbkM7l5UhB9k8shD7VNbJN+HWUNW8PoMj
	KZx0pVK5ahu16XjmIzK7K3rOsMHkr49+00r0GzBr6k7rj2kRJZgOFs585k1y/ss7n8VxH6MsRUp
	pvnpW9fJBN56ZJDRpdQXkYvvf/KqVAL3h5yXqT41iTRf9FbIcw/Uecd/bufN2qGhdVkNl8x4z8W
	yk938IbI8xn/kcITLNXV+XNYdaJGiBhxWAfHexx2/HAbNmMVfm1j1qLCHpLAFwq1wVM+WhU1woe
	+GQQm2LCDo3nV1PfrJZlz5xrr6x+Gjkq0kRa40aBvOm8tr06mhB3Jk1CdHnAi3/bl2ZufXzeY4q
	m9ZO54F3rgx6DewFCD//hB3ZqMjhlf0RGpQPW8t0GWOMbXymDm6ZIUcGj53tFQ6uNjUZl3HxC3i
	FDPmgmImOk1KcDR2jBnQbddPu2111XayTAnXybNtPBL1M36Rz9EOnWTlPr4RdwLbj8VoYuB3ZEQ
	Qy2Cx42ISsbjoopezDSoZC00OECcth7RyOICxIBNYNmGjg==
X-Received: by 2002:a17:90b:2ccf:b0:3a7:9adb:2a18 with SMTP id 98e67ed59e1d1-3ae8984df8emr3658152a91.62.1793420107576;
        Fri, 30 Oct 2026 21:15:07 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845d5e62sm6384937a91.13.2026.10.30.21.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 21:15:07 -0700 (PDT)
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
Subject: [PATCH ipsec 1/2] xfrm: keep old state references until migration deletion completes
Date: Sat, 31 Oct 2026 12:14:54 +0800
Message-Id: <pm-xfrm-core-objects-candidate-0027-v3-cb1e033bff1976f510c9-1@gmail.com>
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

xfrm_migrate() must retain the references returned by
xfrm_migrate_state_find() until it finishes using the old states. The
successful migration path instead calls xfrm_states_put() before
xfrm_states_delete(), leaving the latter to use unreferenced pointers
from x_cur[].

With CONFIG_XFRM_MIGRATE enabled, a privileged XFRM_MSG_MIGRATE or
SADB_X_MIGRATE request can reach this path for an SA with a finite hard
lifetime and no other users. If migration is preempted after the put,
the old SA can expire and be reclaimed before deletion resumes:

  Migration task                 Hard-expiry timer / GC worker
  --------------                 -----------------------------
  xfrm_migrate_state_find()
    hold old SA in x_cur[]
  migrate state and policy
  xfrm_states_put(x_cur, ...)
    drop lookup reference
                                 xfrm_timer_handler()
                                   __xfrm_state_delete(old SA)
                                     drop SAD reference
                                 xfrm_state_gc_task()
                                   synchronize_rcu()
                                   free old SA
  xfrm_states_delete(x_cur, ...)
    xfrm_state_delete(old SA)
      spin_lock_bh(&x->lock) /* use after free */

The configuration mutex does not serialize migration with the timer or
GC worker, and migration holds no RCU read lock across this interval.
xfrm_state_delete() accesses the freed lock before it can check whether
the state is already dead. Expiry before the migration put can open the
same window, with that put dropping the last reference.

Delete the old states before putting their lookup references. Each state
then remains allocated through the lock access and the dead-state check,
including when expiry has already removed it from the SAD.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in _raw_spin_lock_bh+0x38/0x50
    Read of size 1 at addr ffff88810967af48 by task python3/443

    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     kasan_report+0xe0/0x110
     __kasan_check_byte+0x36/0x50
     lock_acquire+0x113/0x2f0
     _raw_spin_lock_bh+0x38/0x50
     xfrm_state_delete+0x26/0x60
     xfrm_migrate+0xd26/0x1950
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

    Allocated by task 424:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_slab_alloc+0x89/0x90
     kmem_cache_alloc_noprof+0x20b/0x5f0
     xfrm_state_alloc+0x28/0x5d0
     xfrm_add_sa+0xb81/0x5660
     xfrm_user_rcv_msg+0x3b3/0xc20
     netlink_rcv_skb+0x133/0x390
     xfrm_netlink_rcv+0x76/0x90
     netlink_unicast+0x504/0x840
     netlink_sendmsg+0x7f7/0xcf0
     ____sys_sendmsg+0x88b/0x9d0
     ___sys_sendmsg+0x125/0x1d0
     __sys_sendmsg+0x13e/0x1e0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 66:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kmem_cache_free+0x242/0x580
     xfrm_state_gc_task+0x534/0x780
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    The buggy address belongs to the object at ffff88810967aec0
     which belongs to the cache xfrm_state of size 936
    The buggy address is located 136 bytes inside of
     freed 936-byte region [ffff88810967aec0, ffff88810967b268)
    ==================================================================

Fixes: 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Assisted-by: LLM

 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 0f6fcea28bcd..55f6bacc4e51 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4726,8 +4726,8 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 
 	/* Stage 4 - delete old state(s) */
 	if (nx_cur) {
-		xfrm_states_put(x_cur, nx_cur);
 		xfrm_states_delete(x_cur, nx_cur);
+		xfrm_states_put(x_cur, nx_cur);
 	}
 
 	/* Stage 5 - announce */
