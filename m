Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A184DA9B2
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791415010; cv=none; b=lXvgSA5AK8kXATYAgBdotWnr3NswT/PG1DGGerCWZMzMcwTYNFJVuvDqnDHAesmXzUjKQaIV9aqoIYGfv5drPMvUzOCTYnfenwsMnMnsHFL6l6vikGMIlK6IzrKJlwNLAkFlTeYDlYieRS7jXmjEfxQ7KWyMJD+D0wJKE8ZOBRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791415010; c=relaxed/simple;
	bh=uEMRGprhGK3gOK+J+4v+YP4a9g8GsUtR8OVjUm1uOog=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uUZfEYvGJbbZEvfyPmIEyWl0kFG5OVc1JV1+QiQMxJG8Uf0gA1kNzm9X6mYsPeqT0ECljkAL+Agtct/UadzwkoYnO4uIrdOIig+tdkX3znHridF+4YrPNLMAMfXEW/zPvYF93UV8J7yZ3Dxh880QEmScVlI6MdF0JUa3lzt8JlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmiL9VF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmiL9VF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD3E1F000FF;
	Wed,  7 Oct 2026 23:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791415008;
	bh=D/haLzSFv/N6ASa/0W018HsJfzdyz7CRv3a/6X7Swqo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PmiL9VF+g1A9fQu5VZlDp0lFNAFh0woRRj2tVsKaJuAD6RFBWAMueuridXp/J81UC
	 9jjLBZHqaQxJrTy+++EYixpDWetFi330x2Z6ugGyAD170IJnHHRJOB5misCfHeamYf
	 SnwIOdGk+jMjPm74PM5E0uNJzGGhiLZCRk/pvwJcRavSg65xgKIRLOSXY8OmEkyUPw
	 4nDXQCU5HyuWhaLhrxlebUS6lMa3GY7nytOfM6JOmI3em1NsgSKWe3BC1q+C60MZzl
	 xrpIYtPg9QkJgybe2rO5yfohJjmkGMUmGd2fdiJAsX7GMUktcsmTmuvvec6We07c1E
	 PYIriujEgkEJA==
Subject: Re: [PATCH net-next 2/3] ipv4: Pass netns to fib_table_lookup()
From: netdev-bot+sashiko@kernel.org
To: idosch@nvidia.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, dsahern@kernel.org, horms@kernel.org,
 petrm@nvidia.com, rostedt@goodmis.org, daniel@iogearbox.net, ferenc@fejes.dev
Date: Wed, 07 Oct 2026 23:16:47 +0000
Message-ID: <179141500789.434549.13454267658228381768@kernel.org>
In-Reply-To: <20261006155454.853588-3-idosch@nvidia.com>
References: <20261006155454.853588-3-idosch@nvidia.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds `const struct net *net` as the new first
  argument of the fib_table_lookup tracepoint.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but the
  fib_table_lookup trace event's TP_fast_assign leaves `__entry->gw4` (4…

--

ipv4: Pass netns to fib_table_lookup()

This commit adds a struct net argument to fib_table_lookup(). It passes
that argument as the new first argument of the fib_table_lookup
tracepoint and updates all callers. The next patch will use it to report
the netns cookie in the tracepoint.

> diff --git a/include/trace/events/fib.h b/include/trace/events/fib.h
> index feb28b359eff2..9a88060aa92e1 100644
> --- a/include/trace/events/fib.h
> +++ b/include/trace/events/fib.h
> @@ -14,10 +14,10 @@
>  
>  TRACE_EVENT(fib_table_lookup,
>  
> -	TP_PROTO(u32 tb_id, const struct flowi4 *flp,
> +	TP_PROTO(const struct net *net, u32 tb_id, const struct flowi4 *flp,
>  		 const struct fib_nh_common *nhc, int err),
>  
> -	TP_ARGS(tb_id, flp, nhc, err),
> +	TP_ARGS(net, tb_id, flp, nhc, err),

[Severity: Medium]
Does the raw_tp_null_args[] table in kernel/bpf/btf.c need to change
along with this prototype? It still has:

kernel/bpf/btf.c:raw_tp_null_args[] {
    ...
	/* fib */
	{ "fib_table_lookup", 0x100 },
    ...
}

btf_ctx_access() applies this mask by argument position. It does this
after skipping the hidden __data argument:

	if (raw_tp_null_args[i].mask & (0x1ULL << (arg * 4)))
		info->reg_type |= PTR_MAYBE_NULL;

Now that net sits at position 0, 0x100 marks arg 2 (flp) as
PTR_MAYBE_NULL. nhc has moved to arg 3 and is no longer marked nullable.

nhc can be NULL at runtime. fib_table_lookup() in net/ipv4/fib_trie.c
passes NULL for it on both -EAGAIN paths and on the out_reject path:

	trace_fib_table_lookup(net, tb->tb_id, flp, NULL, -EAGAIN);

For tp_btf programs, the verifier would then treat nhc as a trusted
non-NULL pointer. It would accept code that uses nhc without a NULL
check.

The verifier would also reject valid programs that read flp fields
directly. check_mem_access() only allows direct PTR_TO_BTF_ID access when
!type_may_be_null(reg->type). Programs would be rejected even after they
are updated for the new argument order, as the commit message asks.

Should the entry become { "fib_table_lookup", 0x1000 } in this patch?

The later "ipv4: Report netns cookie in fib_table_lookup tracepoint"
patch in the series does not seem to change it. This also seems to
contradict the "No functional changes intended" line in the commit
message.

>  
>  	TP_STRUCT__entry(
>  		__field(	u32,	tb_id		)

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. In
this event, TP_fast_assign() seems to leave gw4 and gw6 unset when nhc
is non-NULL and its gateway family is neither AF_INET nor AF_INET6:

	if (nhc) {
		if (nhc->nhc_gw_family == AF_INET) {
			...
		} else if (nhc->nhc_gw_family == AF_INET6) {
			...
		}
	} else {
		p32 = (__be32 *) __entry->gw4;
		*p32 = 0;
		...
	}

This happens for gateway-less routes, such as the local and connected
routes that fib_magic() sets up. For those routes, fib_nh_init() copies
a gateway family of 0 into the nexthop.

TP_printk() always prints both arrays with "gw %pI4/%pI6c". The event
payload is not cleared when it is reserved, so can this print stale bytes
left by earlier events?

trace_buffered_event_enable() also allocates its per-CPU buffered-event
page without __GFP_ZERO. Can up to 20 bytes of old page contents reach
trace readers that way?

Would it make sense to zero gw4 and gw6 before the family-specific
assignments?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006155454.853588-1-idosch%40nvidia.com
