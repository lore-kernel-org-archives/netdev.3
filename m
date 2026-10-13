Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBCA1A238F
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880884; cv=none; b=I5Rhmv2v6C8NHKe+MOMoF5SmTMkK6e5kQVxv2aBexppRPkAu0w57zQ7V5otDEyO2mHoH6Z0KKEFFXO9/s1aos43P5j4r4wmBxy1pdNEbh10xmgWGbVBEZE4gonqSEKX6E5GJu4QtXwx4P/W/FzyENl484Nkglq/4d4R2tBtMOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880884; c=relaxed/simple;
	bh=v2DasoO2yAXxzc9ATTk7hF2Uow7L0fdKI6GDbCv4FMc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Chqa1Fc2bzWJ2IRt54EECSPKqga0LLQKn/O7ImVTuI0F16jh/FvHV3CFdMmSOCiy7byFGPguKcSGizAOW9nATfJ/cVu8sVT4hlr5n9KeujodTZWTp03sZIGiSuN4g1R4sKUdzFJdth605eSU+8N9eASSlVFhgcSp79YMolvxNZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hmc/3TQw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hmc/3TQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D581F000FF;
	Tue, 13 Oct 2026 08:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791880882;
	bh=+vkNYEAdUk8Z1MuKxaiXSstM/OCFpRh0ql2+mbQMQ3Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hmc/3TQwZCo1UnFLazAFHHRHQI6FfKM0sYQhBcUiHoyzFv6EsZYtvXkfEqPYJVOmZ
	 S/Gf6ChUGvZX08jLaXDpy0ErMK35+JqAzXUKfuoGPf6xUGPv70Gh40srwp/LVLUsHK
	 n3GngcVso64etOtR5UwspeM2RvdKqZ8uudIwVWmwnjINmsv0UtkeyVmKWaYR0MjzF0
	 EgJbK2ls1DZeMmaYa1+IEMd2UGjjjsAuY1KfDO1NYV14VFTG3PX6+lfkORaCFqq7Sc
	 R/dakIhnx84qETw27PcBQQ1ZiCw2v+VWrlHb0SbN2lbJFdMlMEf/ofzTikq8w8xdvw
	 i/LLUa/BToFmA==
Subject:
 Re: [PATCH net] ipv6: take tb6_lock across the fib6 dump sernum snapshot
From: netdev-bot+sashiko@kernel.org
To: juny24602@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kaber@trash.net, netdev@vger.kernel.org, junvyyang@tencent.com,
 stable@kernel.org, corvus@tencent.com
Date: Tue, 13 Oct 2026 08:41:21 +0000
Message-ID: <179188088139.434549.10492707337424928971@kernel.org>
In-Reply-To: <20261012083843.60510-1-juny24602@gmail.com>
References: <20261012083843.60510-1-juny24602@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch makes the fn_sernum snapshot and compare in
  fib6_dump_table() atomic under tb6_lock.
- [Medium] The patch does not take a reference on the route parked in
  w->leaf while the dump is suspended.
- [Low] The commit message says the use-after-free happens at both ends
  of the sernum check: "…or passes the compare and only then takes the…

Pre-existing issues:
- [Medium] This was already broken before the patch.
- [Medium] This was already broken before the patch.

--

ipv6: take tb6_lock across the fib6 dump sernum snapshot

This patch takes tb6_lock once at the top of fib6_dump_table(). The
fn_sernum snapshot after the first walk, the compare on continuation and
the walker call now all run in one critical section. The aim is to stop a
concurrent NLM_F_REPLACE from freeing the route parked in w->leaf without
the dump noticing.

> That check is done outside tb6_lock at both ends: the snapshot after the
> first walk is taken after spin_unlock_bh(), and on continuation the
> compare runs before spin_lock_bh(). A writer that slips in between, e.g.
> RTM_NEWROUTE with NLM_F_REPLACE on the route the walker is parked on,
> frees the route via fib6_info_release() (the replace path has no
> FOR_WALKERS fixup, unlike fib6_del_route()) and bumps fn_sernum, yet the
> dump records the new serial next to the stale w->leaf, or passes the
> compare and only then takes the lock. Either way the restart is skipped
> and fib6_walk_continue() hands the freed route to rt6_fill_node():

[Severity: Low]
Is the continuation half of this description accurate?

The first-walk half matches the old code. cb->args[5] was read after
spin_unlock_bh(), so a replace in that window stores the new serial next
to the stale w->leaf.

On the continuation side, inet6_dump_fib() holds rcu_read_lock() for the
whole fib6_dump_table() call, and fib6_info_release() frees through RCU.
A route replaced between a passing compare and spin_lock_bh() cannot be
freed before that call returns.

The else branch also writes cb->args[5] only when it restarts:

	int sernum = READ_ONCE(w->root->fn_sernum);
	if (cb->args[5] != sernum) {
		/* Begin at the root if the tree changed */
		cb->args[5] = sernum;
		...
	} else
		w->skip = 0;

If the walk parks again, args[5] still holds the old serial. The next
recvmsg() then sees the mismatch and restarts.

So that window can show a stale route once, but it does not seem able to
hand a freed route to rt6_fill_node(). Could the changelog say that the
use-after-free comes from the post-unlock snapshot in the
cb->args[4] == 0 branch, and that the compare moved only for consistency?
Stable backporters will probably rely on this when they look at older
trees.

> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 9ff761962b45c..70482381165fe 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -592,14 +592,13 @@ static int fib6_dump_table(struct fib6_table *table, struct sk_buff *skb,
>  	w = (void *)cb->args[2];
>  	w->root = &table->tb6_root;
>  
> +	spin_lock_bh(&table->tb6_lock);
>  	if (cb->args[4] == 0) {
>  		w->count = 0;
>  		w->skip = 0;
>  		w->skip_in_node = 0;
>  
> -		spin_lock_bh(&table->tb6_lock);
>  		res = fib6_walk(net, w);
> -		spin_unlock_bh(&table->tb6_lock);
>  		if (res > 0) {
>  			cb->args[4] = 1;
>  			cb->args[5] = READ_ONCE(w->root->fn_sernum);

[Severity: High]
The snapshot is now taken under tb6_lock, but the unreferenced w->leaf is
still guarded only by an equality compare on the root fn_sernum. Can the
root fn_sernum go back to the value saved here?

In net/ipv6/route.c, ip6_link_failure() writes a fixed constant while
holding only rcu_read_lock(), not tb6_lock:

	fn = rcu_dereference(from->fib6_node);
	if (fn && (rt->rt6i_flags & RTF_DEFAULT))
		WRITE_ONCE(fn->fn_sernum, -1);

A ::/0 route lives in table->tb6_root, and that is w->root here. That
allows this sequence:

  ip6_link_failure()                  /* root fn_sernum = -1 */
  dump parks                          /* args[5] = -1, w->leaf = R */
  RTM_NEWROUTE|NLM_F_REPLACE on R
    fib6_add()
      fib6_purge_rt()
      fib6_info_release()             /* frees R via RCU, no fixup */
      __fib6_update_sernum_upto_root()  /* root fn_sernum = S */
  ip6_link_failure()                  /* root fn_sernum = -1 again */
  recvmsg()
    fib6_dump_table()                 /* -1 == -1, no restart */
      fib6_walk_continue()
        fib6_dump_node()
          rt6_dump_route()
            rt6_fill_node()           /* reads freed R */

That looks like the same KASAN use-after-free shown in the changelog. The
fixup in fib6_del_route() does not help here, because it only matches a
route that is still live:

	if (w->state == FWS_C && w->leaf == rt) {

The changelog calls the sernum check "the only thing standing between the
walker and a freed route". Would it be more robust to pin w->leaf while
the dump is suspended, or to add a walker fixup to the replace/purge path
in fib6_add(), instead of relying on fn_sernum equality?

[Severity: Medium]
A related question about the same compare: can wraparound of the serial
also defeat it?

fib6_new_sernum() wraps on purpose:

	new = old < INT_MAX ? old + 1 : 1;

and __fib6_update_sernum_upto_root() writes the shared per-netns value
into every node up to the root:

	WRITE_ONCE(fn->fn_sernum, sernum);

Suppose a dump parks with args[5] = S and w->leaf = R. R is then replaced
with NLM_F_REPLACE, which frees it through RCU without a walker fixup.
Roughly 2^31 more operations that consume a serial in the same netns then
bring the root back to S. On the next recvmsg() the compare passes under
tb6_lock and w->skip is set to 0. fib6_walk_continue() then passes the
freed R to rt6_dump_route() and rt6_fill_node().

CAP_NET_ADMIN in a netns owned by a user namespace is enough to drive the
counter, but the number of operations makes this expensive. Pinning
w->leaf across the suspension, or a walker fixup in the replace path,
would cover this case too.

[ ... ]

> @@ -616,14 +615,13 @@ static int fib6_dump_table(struct fib6_table *table, struct sk_buff *skb,
>  		} else
>  			w->skip = 0;
>  

[Severity: Medium]
This isn't a bug introduced by this patch, but the restart branch just
above this resyncs by position:

	if (cb->args[5] != sernum) {
		/* Begin at the root if the tree changed */
		cb->args[5] = sernum;
		w->state = FWS_INIT;
		w->node = w->root;
		w->skip = w->count;
		w->skip_in_node = 0;
	}

Can this skip or repeat routes when the tree changes between recvmsg()
calls?

Say an RTINFO node before the cursor is emptied, which a plain fib6_del()
does without bumping the root fn_sernum. A route is then added after the
cursor, and __fib6_update_sernum_upto_root() does bump it. The restart
then skips one node too many, and the unsent routes of the partly dumped
node are lost. An add before the cursor sends some nodes twice.

Nothing in the IPv6 FIB dump path sets cb->seq, calls
nl_dump_check_consistent() or sets NLM_F_DUMP_INTR. inet6_dump_addr() in
net/ipv6/addrconf.c does. As a result, user space can get incomplete or
duplicated RTM_GETROUTE output with no consistency signal.

[Severity: Medium]
This is also a pre-existing issue and was not introduced by this patch.
Is w->skip_in_node still valid when this non-restart branch is taken?

When a dump is suspended partway through a route's exceptions,
fib6_dump_node() records:

	w->skip_in_node += res;

If that route is then deleted, the walker fixup in fib6_del_route() moves
w->leaf to rt->fib6_next, or sets FWS_U, but does not touch
w->skip_in_node. A plain fib6_del() does not change the root fn_sernum,
so this branch is taken.

rt6_dump_route() then applies the old skip count to a different route.
That route and some of its exceptions are left out of the dump, and
NLM_F_DUMP_INTR is not set.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012083843.60510-1-juny24602%40gmail.com
