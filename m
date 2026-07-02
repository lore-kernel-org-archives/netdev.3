Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A123386579
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019952; cv=none; b=CH7VEjksV82wiv6VEfp8qSW7+uwA11LXsb2+O3O8i6JzDJXx7iyXIqdIQQe+Rm7CYePhR5rIkj+EOPcm0PS6vzlMMQwlth8wroBVJ1zHu4RzLYCL9/IncVd2zwf98HjTMwP+0M23HSTb+VN2ZsqSxkaTO9EH9QS2HhA4Vy9cG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019952; c=relaxed/simple;
	bh=BXFEv4+ZyyVGIZZ2caJJocv825e7NCyvtXtm/toI+Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y64DtXgZ1ePEZTV3Y2siaJMKQLJ0+aKmE35IwTS5Pi0jA+ckP/0AzuGOU9lm7yh09bZSgg3/0ApvlBIRjWnCjzSUxV9OxGk1N0CG7utCqCLLVadbz8KkSz3y1ACpirlgd8hBLeVnlb2yOrS+v8hqDGGsQxp15FeYVzCG/hft0jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 65D9460218; Thu, 02 Jul 2026 21:19:07 +0200 (CEST)
Date: Thu, 2 Jul 2026 21:19:03 +0200
From: Florian Westphal <fw@strlen.de>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, netdev@vger.kernel.org, horms@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: Re: [PATCH ipsec] xfrm: policy: use hlist_del_init_rcu in
 xfrm_hash_rebuild to avoid bydst poison
Message-ID: <aka5pwAGGI56QrrS@strlen.de>
References: <20260702185805.615241-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702185805.615241-1-xmei5@asu.edu>

Xiang Mei (Microsoft) <xmei5@asu.edu> wrote:
> xfrm_hash_rebuild() unlinks each policy from its bydst chain with
> hlist_del_rcu() and re-inserts it. For an inexact policy the re-insert goes
> through xfrm_policy_inexact_insert(), which can fail on a GFP_ATOMIC
> allocation; on failure the error path only WARN_ONCE()s and continues, so the
> policy is left with a poisoned bydst node (LIST_POISON2). The next rebuild
> calls hlist_del_rcu() on that node again, dereferences the poison, and takes a
> general protection fault.
> 
> Use hlist_del_init_rcu() instead, so a failed-reinsert node is left unhashed
> (pprev == NULL) rather than poisoned. The next rebuild's hlist_del_init_rcu()
> is then a no-op for it, and the non-failing case is unchanged.
> 
> The reinsert allocation is GFP_ATOMIC (it runs under xfrm_policy_lock), so in
> practice this is only reached under memory pressure; the crash below was
> reproduced deterministically by forcing that allocation to fail with fault
> injection (failslab).
> 
> Crash:
>   Oops: general protection fault, probably for non-canonical address
>   0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
>   KASAN: maybe wild-memory-access in range [0xdead000000000120-0xdead000000000127]
>   ...
>   Workqueue: events xfrm_hash_rebuild
>   RIP: 0010:xfrm_hash_rebuild+0x5b3/0x1190
>   RAX: dead000000000122   (LIST_POISON2 + offset)
>   ...
>   Call Trace:
>    hlist_del_rcu (include/linux/rculist.h:599)
>    xfrm_hash_rebuild (net/xfrm/xfrm_policy.c:1365)
>    process_one_work (kernel/workqueue.c:3322)
>    worker_thread (kernel/workqueue.c:3486)
>    kthread (kernel/kthread.c:436)
>    ret_from_fork (arch/x86/kernel/process.c:158)
>    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>    ...
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> Fixes: 563d5ca93e88 ("xfrm: switch migrate to xfrm_policy_lookup_bytype")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> ---
>  net/xfrm/xfrm_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 7ef861a0e823..2612a405542b 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -1362,7 +1362,7 @@ static void xfrm_hash_rebuild(struct work_struct *work)
>  		if (xfrm_policy_is_dead_or_sk(policy))
>  			continue;
>  
> -		hlist_del_rcu(&policy->bydst);
> +		hlist_del_init_rcu(&policy->bydst);

This patch is dubious.  I looks to me as if it papers over the
actual bug.

Why is there a memory allocation error?

The first loop -- before unlink -- is supposed to preallocate the new
bins and chain heads.

This is also why there is a WARN. No memory allocations are supposed to
occur after the hlist_del_rcu(), there is supposed to be a guarantee
that the insertion succeeds.

