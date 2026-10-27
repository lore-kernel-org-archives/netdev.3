Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793081174;
	b=l+92CiZr+NWgGeaTgU+3CIw4FfM+dy1IEfDaQ2+y/G8hBj+CG1lCktT0qilkxLjWIqju
	 WXQg6+QukSE/bjCx/XOnpjcQRe4GTYU9wyvQmtwcye0vJqIUqodS/D2K3BDkeJb+FyfOi
	 XW34JCP1oeVVC7j5iphDg1CW8kdf7lyPJ3/yXAjJzieGdd8rnDp20h/WJfwKe77eFZFdx
	 JyH3YUMzBVNHSYQA3zv265x60FwzW+6KUJe3XtCKAAWTvkkiftjsQYEIjwH8zIarhOK3I
	 3nMbHmk99oUQMU9TL81l8AVOPLHKdBSNCemqwRvR6BGzY1fmTqZdTm6w/u8aJ9oKrqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793081174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=HugHoNwV0a8ZVG74tvhwsfKr72+xwItQRmOVGQ+j3x0=;
	b=KUhGCe/wybSoeS4/G3QnUCK5XqbKhZehHTfA2NKqQGYUTWOmzEhtcBGNoh8AmbnLJzKV
	 xoNlhkQMrSVKKpiUSOvbKzb4hlFeVJHYDY/yLMR0uHkf1Jn+IDs1MayyYbLbp3HcXZ+yl
	 y+hOXZYFfnCp2gNc6HY+Z/+09TPWbExbFxD4l/zbsLK9zrwiThyy9QmjxLChi8d5jU3F1
	 Zy5udXURIif9rRIx01/CeKMHv5c6rGjBavOptlX78uinlmMLcggVBBD3qvKWIupEhucZ6
	 Ufmn6SFHUNPJaVHN2wU9MZXTaLhvKbJJtyxDfHm+c3OaxN7C0Txtks75JDkmWkQLigg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cEpOAlTK;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C436606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C436606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cEpOAlTK
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a073778890so2815700b3a.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793081174; x=1793685974; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HugHoNwV0a8ZVG74tvhwsfKr72+xwItQRmOVGQ+j3x0=;
        b=cEpOAlTKRS692cOYsGmdfNzNGRBrUIzQb7NkpOQbe23rh8ebpyMXjO+7TI2wcgUYut
         pgvo7YA+zJS33QY9MTZPpCsmhYlr4IuSSG+jYuB3ICUEzdGd29+9tpLnOKLQiuyuZpYJ
         V5AM5R9Ujjeqivt5rvmcq8nPbO6QbbOG5E9bpPdBjAYchxLpsiB6n3gVFWZwbTA4wep4
         KDiUlzUOHp0cF9bR5PeFr8fXbMdGaUC+xl4ksWXmXkNsHYFCB6og6Xfzd+GS/0HjSz/O
         BrgrmVpCm/YDzL6QipeLq0FdsZqwHcYRlf/FNTCgvPN5JZFbctneJfeOBjK/i+x18w6h
         vbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793081174; x=1793685974;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HugHoNwV0a8ZVG74tvhwsfKr72+xwItQRmOVGQ+j3x0=;
        b=XK/WbzoQMPtxUzEUT8p49IY1xR/AW6bgYuFv5dv0X5iizKVlPO3Gf0gy79/COE6VLt
         Md4pjdKpjY8VjUBjIWyHYtb+mtQKvH1VT/m1JJsS22OvzoddddhEWwbjUNLk2b4jup/8
         RNfSkuINIUH6Sz7pu9qUqlYxWvYPf5Gh4D3U/N2ZMh3G0k7x8zB+VeeuJhGyqmEc4TkQ
         PJpdQpZ+rnqpsHkak1BM2Ua4zjFwhjbllU26k/qwIYc5KgCjvpBRUqhdVZLfsO3QvrqF
         5oX8NkcCwsZ2bSLCCRfN7pIZEbwtaEToYZkGE02Tv2M47De3F8rp4w63n+er9lNWGB2I
         L8cg==
X-Forwarded-Encrypted: i=1; AKwUvByKGbOC2ND/6yfzeKvtHWEHv9gnG8+sYrS7E4DQGngYcuJLkPEq0/QvJQ3qor5K4b41/Cg3fG0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyaFBA2ZyRYGEMQjw8/vRb/KRJkrobyYWglWyfG/pljvfKZJkx
	fFo6unCIT5pR3N9xZZkKW6u5QUOEPq+ATH7cavKvqm4u2dfLEkbrolBWLkzhR8+vPvcbrk1+xG4
	WwWNgRw==
X-Received: from pfwz19.prod.google.com ([2002:a05:6a00:1d93:b0:899:728c:3031])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a16:b0:869:9298:ba50
 with SMTP id d2e1a72fcca58-8a3630d0a68mr6531030b3a.0.1793081173421; Mon, 26
 Oct 2026 23:06:13 -0700 (PDT)
Date: Tue, 27 Oct 2026 06:06:12 +0000
In-Reply-To: <6adce850.a26421ad.3bb4f4.0011.GAE@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023191517.607834-1-kuniyu@google.com> <6adce850.a26421ad.3bb4f4.0011.GAE@google.com>
Message-ID: <auA-0DznRAdDQR6D@google.com>
Subject: Re: [syzbot ci] Re: ipv6: Protect multiple routes insertion by table lock.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: syzbot ci <syzbot+ci1c0f05215dd3ab6b@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@kernel.org, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, kuni1840@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzbot@syzkaller.appspotmail.com, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Sat, 24 Oct 2026 10:18:08 -0700, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v1] ipv6: Protect multiple routes insertion by table lock.
> https://lore.kernel.org/all/20261023191517.607834-1-kuniyu@google.com
> * [PATCH v1 net] ipv6: Protect multiple routes insertion by table lock.
> 
> and found the following issue:
> WARNING: suspicious RCU usage in rt6_multipath_rebalance
> 
> Full report is available here:
> https://ci.syzbot.org/series/7d878fa2-f84a-4468-85e2-c2a5e263aeff
> 
> ***
> 
> WARNING: suspicious RCU usage in rt6_multipath_rebalance
> 
> tree:      net
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
> base:      7076f684d5132e6a6145e1da2fa74771ecd052e5
> arch:      amd64
> compiler:  Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
> config:    https://ci.syzbot.org/builds/bbb3053f-f23f-4fe3-a9e9-85396428119d/config
> 
> IPv6: RTM_NEWROUTE with no NLM_F_CREATE or NLM_F_REPLACE
> IPv6: NLM_F_CREATE should be set when creating new route
> =============================
> WARNING: suspicious RCU usage
> syzkaller #0 Not tainted
> -----------------------------
> ./include/net/addrconf.h:351 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> locks held by syz.2.3386/18922: 1, last CPU#0:
>  #0: ffff888177df3430 (&tb->tb6_lock){+...}-{3:3}, at: inet6_rtm_newroute+0x3dc/0x1ab0
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 18922 Comm: syz.2.3386 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150
>  lockdep_rcu_suspicious+0x140/0x1d0
>  rt6_multipath_rebalance+0xf11/0x1080
>  fib6_del+0xada/0x15a0

Similar to 8e5f1bb81274 ("ipv6: Narrow down RCU critical section
in inet6_rtm_newroute()."), I had to wrap rt6_multipath_rebalance()
with RCU.

Will squash this:

---8<---
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 0dc6ebee6e56..f7c69c9df411 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1228,9 +1228,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 			fib6_nsiblings++;
 		}
 		BUG_ON(fib6_nsiblings != rt->fib6_nsiblings);
-		rcu_read_lock();
 		rt6_multipath_rebalance(temp_sibling);
-		rcu_read_unlock();
 	}
 
 	/*
@@ -1274,9 +1272,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 						   sibling->fib6_nsiblings - 1);
 				WRITE_ONCE(rt->fib6_nsiblings, 0);
 				list_del_rcu(&rt->fib6_siblings);
-				rcu_read_lock();
 				rt6_multipath_rebalance(next_sibling);
-				rcu_read_unlock();
 				return err;
 			}
 		}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 5926ddbd4349..9618e7b635e9 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4875,8 +4875,10 @@ void rt6_multipath_rebalance(struct fib6_info *rt)
 	if (WARN_ON_ONCE(!first))
 		return;
 
+	rcu_read_lock();
 	total = rt6_multipath_total_weight(first);
 	rt6_multipath_upper_bound_set(first, total);
+	rcu_read_unlock();
 }
 
 static int fib6_ifup(struct fib6_info *rt, void *p_arg)
---8<---

Thanks
