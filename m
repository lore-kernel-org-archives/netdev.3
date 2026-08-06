Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B23B813D
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030515; cv=none; b=lWlUGMQrS3ZixOrPtXs9BtHuioJWiriMVBnp7IM2/4yCr1JTkiimgclSX2mVXXfgzGzhAaAZW1yL6lLd8BVxnO7Eiogr4mdn6B4iX8XZst0rFJofOObHouat/GA+4P9PfZPKt4n+HcOouWCIxWIeCisH1ycjlvfy0KXkwBW9aWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030515; c=relaxed/simple;
	bh=6MpZAmKCnaTFEUYOeRHIyoXsk2TQrrkSY7I2+2IPwpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6DM+oeFlQEhGjdpdBr8ay0ye7kaxwSxsGDFj++1/OGCEm6E77zsEl27psMN7D1esy+gk0Bq8QLCnRxV7hanRUj2AToUyig3vAzTB0mnnun42TxCTzrIkhFyFpN6qTdk8XPI15xaAkZiEuNZ9Sz9VnOltFqDBOLscT8d3ok5hyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RC9jN06W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RC9jN06W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC00D1F000E9;
	Thu,  6 Aug 2026 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786030514;
	bh=z81iDCvEtAUn45b7QgIlKUHRAo7Uy9sZorFcjNIGNPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RC9jN06WTIrVSU3KvKJbFUy2InscT+qkuX4VRMOKf6VTU9/YFmtML84BaXkRte/WV
	 2hzkhV8q5PcUx7wBlPXdFwKdZ3ZTLWYV5pp63Co3PZFRHipzbsChR5jbADIvZBFs7K
	 LR6IUcUlWKtWL/0kHGZ1hEgrih4g1wbrZ9Lq/aVmZSS1cRffYk1GhgUrgCsdGWV9kq
	 JQoNgY2oZniL/KdwZuo8+JOLw5z4laS2S0UfqUy7ClUeapCGTitMCfYqeSZFC4QI+U
	 DmytezK4sgmoUHzbr1AfF9lVZv9miKbFEaj/fnpioV5b3q8LZHU5d2N9lGeuDgDMIn
	 qsqQ0I/xJBAaw==
From: Jakub Kicinski <kuba@kernel.org>
To: zhilinz@nebusec.ai
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai
Subject: Re: [PATCH net 1/1] ipv6: flowlabel: enforce the per-socket lease cap on reused labels
Date: Thu,  6 Aug 2026 08:34:47 -0700
Message-ID: <20260806153447.2591671-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cf4fdc79ae4dc46bd4eb7eeb57e5de2091c13cd3.1785746178.git.zhilinz@nebusec.ai>
References: <cf4fdc79ae4dc46bd4eb7eeb57e5de2091c13cd3.1785746178.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please trim the hash in the Fixes tag.

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ipv6: flowlabel: enforce the per-socket lease cap on reused labels

This adds mem_check_dup() and calls it from the recheck/reuse path in
ipv6_flowlabel_get(), so that re-acquiring an already existing flowlabel
also has to pass the FL_MAX_PER_SOCK per-socket lease check. The
linger/expires refresh of the existing label is made conditional on that
check passing.

A few questions on the changelog and on the new check below.

[Severity: Low]
The changelog says:

  "mem_check() only counts socket leases after fl_size falls below
   FL_MAX_SIZE - FL_MAX_PER_SOCK. Reusing an existing flowlabel does not
   increase fl_size, so duplicate GET requests can keep taking the
   recheck path and grow one socket's lease list without ever hitting the
   FL_MAX_PER_SOCK limit."

Is that description of the mechanism accurate?  Two things look inverted.

First, the early return in mem_check() is:

	room = FL_MAX_SIZE - fl_size;

	if (room > FL_MAX_SIZE - FL_MAX_PER_SOCK)
		return 0;

which is room > 8160, i.e. fl_size < FL_MAX_PER_SOCK (32).  So the lease
count is skipped while fl_size is small, not "after fl_size falls below
FL_MAX_SIZE - FL_MAX_PER_SOCK" (8160), which is true nearly all of the
time.  Was room confused with fl_size here?

Second, before this patch the recheck block in ipv6_flowlabel_get() had no
mem_check() call at all, so the per-socket cap was not consulted on the
reuse path regardless of fl_size.  Should the message describe this as an
unconditional absence of accounting on the reuse path rather than a narrow
fl_size window?  That distinction matters for the stable tag, since the
reproducer is just: create a label with share != IPV6_FL_S_EXCL, then
repeatedly call setsockopt(IPV6_FLOWLABEL_MGR, IPV6_FL_A_GET) on it.

> diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> index 1ab5ad0dcf24f..e295f85bcc604 100644
> --- a/net/ipv6/ip6_flowlabel.c
> +++ b/net/ipv6/ip6_flowlabel.c
> @@ -493,6 +493,24 @@ static int mem_check(struct sock *sk)
>  	return 0;
>  }
>  
> +static int mem_check_dup(struct sock *sk)
> +{
> +	struct ipv6_fl_socklist *sfl;
> +	int count = 0;
> +
> +	lockdep_assert_held(&ip6_fl_lock);
> +
> +	rcu_read_lock();
> +	for_each_sk_fl_rcu(sk, sfl)
> +		count++;
> +	rcu_read_unlock();

[Severity: Low]
Is ip6_fl_lock the right lock to assert here?  The only data
mem_check_dup() reads is the per-socket list inet_sk(sk)->ipv6_fl_list, and
this file documents that list as being guarded by ip6_sk_fl_lock:

	#define socklist_dereference(__sflp) \
		rcu_dereference_protected(__sflp, lockdep_is_held(&ip6_sk_fl_lock))

and fl_link() inserts under it:

	spin_lock_bh(&ip6_sk_fl_lock);
	sfl->fl = fl;
	sfl->next = inet->ipv6_fl_list;
	rcu_assign_pointer(inet->ipv6_fl_list, sfl);
	spin_unlock_bh(&ip6_sk_fl_lock);

ip6_fl_lock is described as:

	/* FL hash table lock: it protects only of GC */

and guards fl_ht[], fl_size and net->ipv6.flowlabel_count, none of which
mem_check_dup() touches (unlike mem_check(), which reads fl_size).  So the
assertion advertises a contract that is unrelated to the data being
walked, and the lock that actually serializes insertion and removal is not
held across the count and the following fl_link().

As far as I can tell there is no actual race today, because
ipv6_flowlabel_get() and ipv6_flowlabel_put() both run under
sockopt_lock_sock(sk) taken in do_ipv6_setsockopt() before
IPV6_FLOWLABEL_MGR is dispatched, and fl6_free_socklist() only runs at
teardown.  Would it be clearer to drop the assertion (and the new
spin_lock_bh(&ip6_fl_lock) around the call) and instead note the socket
lock invariant in a comment, or assert ip6_sk_fl_lock if a lock is wanted?

As written, the global ip6_fl_lock is held across an O(n) list walk that
needs none of the state it protects, which contends with
ip6_fl_gc()/fl_intern()/fl_release().

> +
> +	if (count >= FL_MAX_PER_SOCK && !capable(CAP_NET_ADMIN))
> +		return -ENOBUFS;
> +
> +	return 0;
> +}
> +

[Severity: Medium]
The count here is over all leases the socket holds, not over duplicates of
the requested label, and the check omits mem_check()'s room/fl_size and
net->ipv6.flowlabel_count gating.  That makes the reuse path strictly
stricter than the create path.  Is that intended?

Concretely, while fl_size < FL_MAX_PER_SOCK, mem_check() returns 0 early:

	room = FL_MAX_SIZE - fl_size;

	if (room > FL_MAX_SIZE - FL_MAX_PER_SOCK)
		return 0;

so the same unprivileged socket may still intern brand-new labels past 32
leases, while mem_check_dup() refuses to share an existing one at the same
count.  For example: create label L, take 31 further leases of L so
count == 32 with fl_size == 1, then IPV6_FL_F_CREATE a new label — room is
8191 > 8160 and mem_check() allows it, but a plain IPV6_FL_A_GET of an
existing label returns -ENOBUFS.

Should mem_check_dup() count only leases of the requested label, or reuse
the same gating that mem_check() applies?

>  static inline void fl_link(struct sock *sk, struct ipv6_fl_socklist *sfl,
>  			   struct ip6_flowlabel *fl)
>  {
> @@ -679,10 +697,17 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
>  			err = -ENOMEM;
>  			if (!sfl1)
>  				goto release;
> -			if (fl->linger > fl1->linger)
> -				fl1->linger = fl->linger;
> -			if ((long)(fl->expires - fl1->expires) > 0)
> -				fl1->expires = fl->expires;
> +			spin_lock_bh(&ip6_fl_lock);
> +			err = mem_check_dup(sk);
> +			if (err == 0) {
> +				if (fl->linger > fl1->linger)
> +					fl1->linger = fl->linger;
> +				if ((long)(fl->expires - fl1->expires) > 0)
> +					fl1->expires = fl->expires;
> +			}
> +			spin_unlock_bh(&ip6_fl_lock);
> +			if (err != 0)
> +				goto release;

[Severity: Medium]
This block changes user-visible behaviour in ways the changelog does not
mention, since it says only that it keeps "the duplicate-acquisition path
consistent with the long-standing per-socket cap".

An IPV6_FL_A_GET that re-acquires or shares an existing label, which
previously always succeeded, now returns -ENOBUFS once the socket holds 32
leases of any labels.

When the cap fires, the fl1->linger / fl1->expires refresh is skipped, so
a GET-based refresh loop stops refreshing with no error path that
distinguishes it from a full failure.  Is IPV6_FL_A_RENEW meant to be the
only remaining way to refresh here?  Would it be better to keep the
refresh unconditional and only reject the new fl_link()?

The create branch is also affected.  After:

	err = mem_check(sk);
	if (err == 0)
		fl1 = fl_intern(net, fl, freq->flr_label);
	...
	if (fl1)
		goto recheck;

a plain IPV6_FL_A_GET|IPV6_FL_F_CREATE that merely loses a create race
against another socket re-enters this block and is re-adjudicated by the
stricter rule, so it can now fail with -ENOBUFS even though mem_check()
already approved it under ip6_fl_lock.  Is that acceptable?

Leases are only dropped one at a time by an explicit IPV6_FL_A_PUT in
ipv6_flowlabel_put(), or at teardown in fl6_free_socklist(), so a socket
that reaches the cap stays capped until it puts labels back.

>  			fl_link(sk, sfl1, fl1);
>  			fl_free(fl);
>  			return 0;
-- 
pw-bot: cr
