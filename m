Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794163344;
	b=rsVXCKMXP86+1YbHXCCZShc166ILeSBLXcTZWPo1EsrbiWf4L44XIvkkCw9Zs3eeWvkQ
	 fE6ZX6jTjY//EvetCZvcBgyR6NYDpkW8PMIoRO6/Aixxt7o7cv1tgq5nD/eAKcOJd70NN
	 ym25EjG2+Yv241akpJEFfJkjJUYcAg0FVAMZ86YJTZY0WK80wU85dZuNLDF7fNQA3tgSp
	 pAGJpIxw27PeFxIeLIyd0FjHzq3iQ6FUL1FQjF5MAXu4yxykSlYssgOFRtzHGxN1KYcqR
	 q07XHWX3EqDRTnCBMoctbsFlxoGfnwGEJN2wUnOT+fjpHZiOAAc7MnGI/7MrJczHNZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794163344;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EM+BKWt4qwzUpc6TxNvTqkkxw5pmvwQIxEMFwIpwtx0=;
	b=AUYzDRBOX59gaqhQZHw11QnnDmqwd9XzcrdlUiKFbprniPyYFWva1FISO514/nJMhpOs
	 kJ8x2quz3PfjMj8XY6Fri07aiCRffwg20wOuR31naxRfr8RergOu3XvE4Re8gca9i6P30
	 Sy/tJsuKqkr7uQFfwMjcxhCh+fbemk4Lq20xAEmTaMeN70G/ez2nkZVaNlDIoloPyRYRM
	 b36lcGmnd7GbUp7cFJkx7GZW8r1OF1e5DVDjWB1Mfa8T2MTWgaz6BdTcj9wQ7BIDOHUKQ
	 B20sNXfkcCSwooMbxmwDcz5IkhNbdDbgJoUjjLeGjEcBQKge9rruvpUdiODsW9IM1bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cbk7Jl0C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA59606A31C;
	Sun,  8 Nov 2026 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cbk7Jl0C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195541F0089F;
	Sun,  8 Nov 2026 18:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794163343;
	bh=EM+BKWt4qwzUpc6TxNvTqkkxw5pmvwQIxEMFwIpwtx0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cbk7Jl0CHUlbf6HkaoU3Gff0oNVHqfbuurTq1I36kg3ktZZRmbeh3bhCJmz9/X4VP
	 NSE893k/yJ4p66Lqlx3JqYLeAXRzc05D1Ip4PHiCEC5x0UbxfhL7DWW6J1yHWStf9V
	 VA+wbHWuRakTi+juvqgaqyxrI64nScLc6I0N3e4LBgHMAKUDtbhX3su532zEO7nguI
	 YnfKMxwi0DAcZwzZNQ5d2v5Rs6wHi1rmjPH9in49vAUw3YMg+3N5t2gPC60UZ+Qqn7
	 vz4hViHObYP6T+fk5h8Q9doaIWVS0tzhO8yuH+Tym4S72bUEKvMQSWJ0Q6VCds7b9N
	 fLkBDVFzAqoiQ==
Subject: Re: [PATCH net] ipv4: route: don't blackhole in-use routes when
 retiring fnhe routes
From: netdev-bot+sashiko@kernel.org
To: me@chasehil.tz
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, weiwan@google.com, linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 18:42:22 +0000
Message-ID: <179416334264.994134.10564853189016691004@kernel.org>
In-Reply-To: <20261104182058.2673882-1-me@chasehil.tz>
References: <20261104182058.2673882-1-me@chasehil.tz>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] One fnhe retirement path still calls dst_dev_put() on routes
  that may be in use, and it comes from the same Fixes target.
- [Low] The commit ends with a "Co-authored-by: Claude Opus 5.5
  <noreply@anthropic.com>" trailer.

--

ipv4: route: don't blackhole in-use routes when retiring fnhe routes

The patch stops calling dst_dev_put() on routes retired from a nexthop
exception in rt_bind_exception() and fnhe_flush_routes(). The new
fnhe_retire_route() helper instead marks the route DST_OBSOLETE_DEAD,
puts it on the uncached list and drops the reference, so CPUs still
using the route are not switched to blackhole_netdev.

> Co-authored-by: Claude Opus 5.5 <noreply@anthropic.com>

[Severity: Low]
This isn't a bug, but checkpatch.pl doesn't recognise the Co-authored-by
tag. It isn't in $signature_tags, so checkpatch warns about it with
BAD_SIGN_OFF "Non-standard signature".

Documentation/process/coding-assistants.rst says an AI-assisted fix "must
pass the checkpatch.pl checks". Documentation/process/generated-content.rst
asks for tool use to be disclosed in the changelog or cover letter, not in
a custom trailer.

Switching to Co-developed-by would not fix this. checkpatch requires a
matching Signed-off-by right after Co-developed-by, and
coding-assistants.rst does not allow AI agents to add a Signed-off-by.

Could the trailer be removed and the tool use disclosed in the changelog
text instead?

> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 3a90c8d28b940..cd69242afab07 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -573,6 +573,17 @@ static void ip_rt_build_flow_key(struct flowi4 *fl4, const struct sock *sk,
>  
>  static DEFINE_SPINLOCK(fnhe_lock);
>  
> +/* Other CPUs may still be using @rt, so don't dst_dev_put() it.
> + * rt_flush_dev() handles it if its device is unregistered.
> + * Marking it dead makes ipv4_dst_check() fail for users that cached it.
> + */
> +static void fnhe_retire_route(struct rtable *rt)
> +{
> +	WRITE_ONCE(rt->dst.obsolete, DST_OBSOLETE_DEAD);
> +	rt_add_uncached_list(rt);
> +	dst_release(&rt->dst);
> +}

[Severity: Medium]
Is there one more fnhe retirement path that still blackholes in-use
routes? Commit 95c47f9cf5e0 ("ipv4: call dst_dev_put() properly"), the
Fixes target, also added dst_dev_put() to rt_fibinfo_free() in
net/ipv4/fib_semantics.c. That function is used on fnhe routes when the
owning fib_info or nexthop is freed:

free_fib_info()
  call_rcu_hurry(free_fib_info_rcu)
    fib_nh_release()
      fib_nh_common_release()
        free_nh_exceptions()
          rt_fibinfo_free(&fnhe->fnhe_rth_input)
          rt_fibinfo_free(&fnhe->fnhe_rth_output)

net/ipv4/fib_semantics.c:rt_fibinfo_free() {
    ...
	dst_dev_put(&rt->dst);
	dst_release_immediate(&rt->dst);
}

The RCU grace period before free_fib_info_rcu() covers noref users.
However, __mkroute_output() hands out fnhe_rth_output with a reference:

	rth = rcu_dereference(*prth);
	if (rt_cache_valid(rth) && dst_hold_safe(&rth->dst))
		return rth;

Also, __nf_queue() calls skb_dst_force() on queued skbs. Both of those
holders can outlive the grace period.

For example, a UDP sender could get the dst and then sleep copying user
data in ip_make_skb() while the route is deleted. Its later
ip_send_skb()->dst_output() would then go to dst_discard_out().

Another case is a forwarded skb queued to NFQUEUE at POSTROUTING and
reinjected after rt_fibinfo_free(). It goes through
ip_finish_output()->__ip_finish_output()->ip_skb_dst_mtu(), sees the
blackhole_netdev MTU of 68, and ip_fragment() can send ICMP_FRAG_NEEDED
with mtu 68 to the remote source. That is the symptom described in the
commit message.

The commit message says "Do the same for routes retired from an fnhe",
and the comment above says not to dst_dev_put() routes other CPUs may
still be using. Could rt_fibinfo_free() handle fnhe routes the same way:
mark them DST_OBSOLETE_DEAD, add them with rt_add_uncached_list() and
drop the reference?

Commit 5018c59607a5 also left the matching dst_dev_put() calls in
rt_fibinfo_free_cpus() and for nhc_rth_input, which affect non-fnhe
cached routes.

> +
>  static void fnhe_flush_routes(struct fib_nh_exception *fnhe)
>  {
>  	struct rtable *rt;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104182058.2673882-1-me%40chasehil.tz
