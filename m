Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454F2DECC2
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368202; cv=none; b=o1kQRTg6l1SzvxFqkw/djo8L1it2fhvm5zvOBuS4CtS5N9PVdZCTZcu9kckuKzxFyvr8esqSaS7wPotBAibMq/XOTZdAx0CPBvRcXoi/JNVasI0AUXA3QQaRduYHwNGj8UK8kNhi/vlvmP7/3cGj4qen5M5Jz5fh7tyITlvUJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368202; c=relaxed/simple;
	bh=SKZt+ayUSCTuRumRsFqB9wLA4N9rIlZ/RoTT4PFHuHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tJaLFt7TV/4qAcR2OnhFdYkM/XB9VFniuL0ZHLBS8Npbuh8ilXZzMqaX0XUY2jPWq8Vw2MP1SH9SuXk6yfJXskMvza4wSu/KD7l7VntD9G7+k6DLz5pGl+3FiOMMHEU2nvNG0dobEwSqbcVXoMbqAVmm2tY0hb4OtlG+C4uOCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CpAN85Jl; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CpAN85Jl"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c7eefa8f93so6086565ad.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 23:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782368200; x=1782973000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lk0bV8WkRC+OR9Z7n7Ljwn1YzQFmz8/4oLWZZDNXuQ=;
        b=CpAN85Jlca+7CaoQAJi1q1ziNdCQxnURTFfWN4lt8H/oTj/qt36xKnekmoCYkgIgPd
         8Vb/jTxwKRxovWaiXUw2wjfhW4+TrvQUH7pCZcFhmKvR30xDf35i4dAiQBJ2p41dZEK8
         jxxiTyeVuy6reOmxL8cO5V3zjY6rW2Dmju2teSinh8twGgoJtxJDLpDE08VwKeGKVSuC
         yhbs2CtahFmywv7G/0GPyYxrgGYVVp+/sXfedGJI/3J2ifORshuDVp6MAFDyamokB78R
         79xwzNAP+2csCae4helnmhxDS/kjExGNSE3ncUP3XSJCgxKkRhP7hGgy6b34fM50KArj
         uc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782368200; x=1782973000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lk0bV8WkRC+OR9Z7n7Ljwn1YzQFmz8/4oLWZZDNXuQ=;
        b=bvOPwhAbaTHOwAqpJwb2pG1USWJiJmyeo+TCYxuz95AsFXybVshl/BBXE6chv39Xgh
         BSiq/neu5l6viy9CItm1UPqGCSNSdXYTV5C1O6qR2QLxB4XFnAxPMFpSu0Jk5R/3rAci
         FqELrTEdfU52uQ+88gsPLjPa0TdH0rGE384grSALCn3Wq7OI/CQfcdD2+MhQZWHxKNAJ
         5k47uXzxtTkeDBsypPHj24WaZB4oo+3IWGpcwnH1u2iiPIFox4ebDGyQTwpnk2hcwcAN
         6W7TepsGYVdayf86NcbqJ8I4C4PHjC8n4Gx1OhizlZUxLIuRbwxzGu4dy9Pboz6E5tpV
         Ny4A==
X-Forwarded-Encrypted: i=1; AHgh+RoHB2TS/HIcFcarhHlxz0gXEjLwff+lGOk9SFRKeHH9tomfrQAyJ4Z2Y9g9UHxuFX8BhAG64rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVDb/z3toZBFDAaxzBdSRiHcDJ2hI1Ep5rOtZdGP60+9fLndjj
	v0uWg4Ow5wew3oH0BoKIHV1YFqJUiQg6BGwW8SF1HeNhMbq4QMcJQioin1xS0dPunRDGRqwWM0M
	JLLF72g==
X-Received: from plmt4.prod.google.com ([2002:a17:903:3d44:b0:2c7:ed23:f48b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2441:b0:2c0:d29b:34ff
 with SMTP id d9443c01a7336-2c7c3d5fe99mr88048745ad.10.1782368199653; Wed, 24
 Jun 2026 23:16:39 -0700 (PDT)
Date: Thu, 25 Jun 2026 06:15:07 +0000
In-Reply-To: <20260625044101.939070-1-zhangfeionline@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625044101.939070-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625061639.407719-1-kuniyu@google.com>
Subject: Re: [PATCH v2 net] ipv6: fib6: fix NULL deref in fib6_walk_continue()
 on multi-batch dump
From: Kuniyuki Iwashima <kuniyu@google.com>
To: zhangfeionline@gmail.com
Cc: baohua@kernel.org, chenzhangqi@xiaomi.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org, idosch@nvidia.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, zhangpengfei16@xiaomi.com
Content-Type: text/plain; charset="UTF-8"

From: Pengfei Zhang <zhangfeionline@gmail.com>
Date: Thu, 25 Jun 2026 12:41:01 +0800
> From: Pengfei Zhang <zhangpengfei16@xiaomi.com>
> 
> inet6_dump_fib() saves its progress in cb->args[1] as a positional
> index within the current hash chain.  Between batches the RTNL lock
> is released,

nit: RTNL has been removed from IPv6 FIB, simply say like

  Between batches, a concurrent fib6_new_table() can insert ...

> so a concurrent fib6_new_table() can insert a new table
> at the chain head, shifting all existing entries.  The saved index
> then lands on a different table, causing fib6_dump_table() to set
> w->root to the wrong table while w->node still points into the
> previous one.  fib6_walk_continue() dereferences w->node->parent
> (NULL) and panics:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   RIP: 0010:fib6_walk_continue+0x6e/0x170
>   Call Trace:
>    <TASK>
>    fib6_dump_table.isra.0+0xc5/0x240
>    inet6_dump_fib+0xf6/0x420
>    rtnl_dumpit+0x30/0xa0
>    netlink_dump+0x15b/0x460
>    netlink_recvmsg+0x1d6/0x2a0
>    ____sys_recvmsg+0x17a/0x190
> 
> Fix by storing tb->tb6_id in cb->args[1] instead of a positional
> index.  On resume, skip entries until the id matches; a concurrent
> head-insert can never match the saved id, so the walker always
> resumes on the correct table.
> 
> Fixes: 1b43af5480c3 ("[IPV6]: Increase number of possible routing tables to 2^32")
> Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>

SOB does not match the Author of the patch (the first From: line).


> ---
>  net/ipv6/ip6_fib.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index fc95738de..bda492634 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -636,11 +636,11 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
>  	};
>  	const struct nlmsghdr *nlh = cb->nlh;
>  	struct net *net = sock_net(skb->sk);
> -	unsigned int e = 0, s_e;
>  	struct hlist_head *head;
>  	struct fib6_walker *w;
>  	struct fib6_table *tb;
>  	unsigned int h, s_h;
> +	u32 s_id;

nit: please keep the reverse xmas tree order.
https://docs.kernel.org/7.1/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs


>  	int err = 0;
>  
>  	rcu_read_lock();
> @@ -701,23 +701,22 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
>  	}
>  
>  	s_h = cb->args[0];
> -	s_e = cb->args[1];
> +	s_id = cb->args[1];
>  
> -	for (h = s_h; h < FIB6_TABLE_HASHSZ; h++, s_e = 0) {
> -		e = 0;
> +	for (h = s_h; h < FIB6_TABLE_HASHSZ; h++, s_id = 0) {
>  		head = &net->ipv6.fib_table_hash[h];
>  		hlist_for_each_entry_rcu(tb, head, tb6_hlist) {
> -			if (e < s_e)
> -				goto next;
> +			if (s_id && tb->tb6_id != s_id)
> +				continue;
> +			s_id = 0;
> +
> +			cb->args[1] = tb->tb6_id;
>  			err = fib6_dump_table(tb, skb, cb);
>  			if (err != 0)
>  				goto out;
> -next:
> -			e++;
>  		}
>  	}
>  out:
> -	cb->args[1] = e;
>  	cb->args[0] = h;
>  
>  unlock:
> -- 
> 2.34.1
