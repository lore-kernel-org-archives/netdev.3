Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999286;
	b=NWhTcSL1petLgSnEiZhbEatn7CKKXZCl4ggR6YdBIa+B2mBLhh7aJxg07vWABPveaUTO
	 nuimzCNsmY6LI3n8HYRUkukiDHnPk5cNsemmaL4jsbRVLGDiAYQNmTh3hCp8St+OGQJzX
	 iF+Wq5NZ8g6WYOTf0qQgCf+yOL8dWisJaRc4oQp8/AA6uIQi9RZSAUkjFVj62C6D8LglF
	 cSnM6CVWmsaFRxhsu//1iw7SqQYaIYetvF518ItfcHse0Mrenxx5LNoZ6ef6G86Qogxvi
	 WaFOp9A5bJ4C5qX6NFFDCmFxpuuXu0cDQ/4d3i6ExsxkppwDITKirqXNTSzFNzTSe1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999286;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lGqCJEPmCHjwS+9InBoxh6IJW7PY0GNrepEuSe4ehcA=;
	b=LPnjxJpiqKsZLD8SaNvQtBd0Cbc3N/tGDjbFddc4rmp/49t9d0TbV5cxHaCodRf3FqRj
	 2uBt22cdTXZMUk5pLeZb2JQH8Gyhbo2pn+Z8WD1u+kbQSYSmzFPDmMdJa64x1VMz2GMKl
	 /gK0gYr8wuiDwXaJfIVY9dz6HRLNxSags3+pry8qjOuHMbEhdSyGDuj1AYiUygO/f+w4w
	 pt2IAIISv6M7QLk/iG2T4YkfGjPNlE4zSad3TNsW1E6+W4FKelYieVWJN5dgezTZzfKzI
	 sXX+RpW9GwTA38yTa9FB6FDciz2mE4mbCw8aO1Hi01HMUAyWgMnODnsmFa5sW7BY9Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3diF+55;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ED4606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3diF+55
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FECE1F01825;
	Mon, 26 Oct 2026 07:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792999284;
	bh=lGqCJEPmCHjwS+9InBoxh6IJW7PY0GNrepEuSe4ehcA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X3diF+55P5qf3drlp3QSrHrhWZpNSy4az+sPc6THoSR60uMBTVq1ZfobsxHbS4WkS
	 8KC7QHf1IzTwmlIn5LQtttqoe5bsDgEeIkRT5xrz9Vg0ZetrfMolTKvRzy4vKxpDL6
	 hwfhcVEFmD/pGUA/ZfcdxH2wqJ2Sfd1q/DlgSQvQ7+L8+mg9pm9wBEEFvd5OsNpN98
	 lLgo+3f1K1n3KpMI3O0VqeN9WtBgp7Zim1hywTRAxRAMr7EP3tYfFr+vdys3t8PEBt
	 KC79RGRT46DJWf6MfzbzBGLrnqbHigUShyHH6dKFswDw6Ae7jUjc+H357gM3aN6rIq
	 M7OTh+dGmuMcg==
Subject: Re: [PATCH ipsec] xfrm: state: use the fallback SA while a per-CPU
 acquire is pending
From: netdev-bot+sashiko@kernel.org
To: matthewzhaocc@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Mon, 26 Oct 2026 07:21:23 +0000
Message-ID: <179299928386.3134.2456399859261919198@kernel.org>
In-Reply-To: <20261025064524.74618-1-matthewzhaocc@gmail.com>
References: <20261025064524.74618-1-matthewzhaocc@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 0 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not cover fallback SAs with a wildcard (all-zero)
  source address, so the drop the commit claims to close is still…
- [High] xfrm: pending per-CPU acquire suppresses acquires on other CPUs
- [Low] The commit message says in its body that OpenAI Codex and
  Anthropic Claude were used to find the bug and draft the fix, but it…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it sits on the
  exact line the patch changes.
- [Medium] This problem wasn't introduced by this patch, but it weakens
  the RFC 9611 rationale the patch cites.

--

xfrm: state: use the fallback SA while a per-CPU acquire is pending

With XFRM_POLICY_CPU_ACQUIRE, xfrm_state_find() selected the non-CPU
fallback SA only inside the new-acquire block. Once a per-CPU larval
state existed, later packets on that CPU got -EAGAIN and were dropped.
This patch uses the best valid state when an acquire is already in
progress, without adding the fallback to the policy state cache.

> The problem was found and the fix drafted with AI coding assistants
> (OpenAI Codex and Anthropic Claude) while testing per-CPU SAs for a
> VXLAN-over-IPsec deployment. The analysis, reproducer and fix were
> reviewed by the submitter.

[Severity: Low]
This isn't a bug, but should there be an Assisted-by: tag in the trailer
for this? The section "Using Assisted-by:" in
Documentation/process/submitting-patches.rst asks for the tag when coding
tools are used. Documentation/process/coding-assistants.rst gives this
format:

  Assisted-by: LLM [TOOL1] [TOOL2]

> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 0555e5d796ede..dec528f98d514 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1518,7 +1518,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
>  
>  found:
>  	if (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) ||
> -	    (best && (best->pcpu_num == pcpu_id)))
> +	    (best && (best->pcpu_num == pcpu_id || acquire_in_progress)))

[Severity: High]
The new condition seems to assume that acquire_in_progress means an
acquire is pending for this CPU. Is that guaranteed? In
xfrm_state_look_at(), an XFRM_STATE_ACQ state sets the flag for any
CPU's larval as long as best is still NULL:

	} else if (x->km.state == XFRM_STATE_ACQ) {
		if (!*best || x->pcpu_num == pcpu_id)
			*acq_in_progress = 1;

XFRM_STATE_INSERT() puts a new software state in front of the first
existing software state in the bucket. So the larval that CPU A
creates in xfrm_state_find() sits ahead of the older fallback SA
(pcpu_num == UINT_MAX) in state_bydst. The fallback is not in
pol->state_cache_list. When CPU B does a lookup, best is therefore
still NULL when the bydst walk reaches CPU A's larval, and
acquire_in_progress gets set. The fallback is then picked as best
later in the same walk.

With this change CPU B takes x = best and skips the
"if (!x && !error && !acquire_in_progress)" block. No larval is
created and no km_query() is sent for CPU B. B's per-CPU SA is not
requested at all while A's acquire is pending.

B's traffic stays on the fallback SA until A's larval resolves, or
expires after sysctl_acq_expires. Only a later lookup on B can then
start B's own acquire. If xfrm_lookup() caches the bundle built from
the fallback in the meantime, could that keep B on the fallback even
longer?

Before this patch those CPUs did not send an acquire either, but
their packets were dropped, so the problem was visible. Now it is
silent.

This also looks like what the "one packet per CPU right after the
fallback SA is up" test was hitting. The CPUs other than the first
one saw CPU 0's larval ahead of the fallback. The patch stops those
packets from being dropped. Did the test also check that each CPU
ended up with its own SA, and how long that took?

Would it be better to take the fallback here only when the pending
acquire belongs to pcpu_id? For example, xfrm_state_look_at() could
record a pending acquire for this CPU separately from a pending
acquire on another CPU. Other CPUs would then still go through the
new-acquire block and pick up the fallback there, as the existing
comment in that block intends.

[Severity: High]
Does this handle a fallback SA whose source address is a wildcard (all
zeros)? __xfrm_state_insert() hashes SAs by props.saddr, so that kind of
fallback sits in the h_wildcard bucket. xfrm_state_find() only walks that
bucket in the second bydst loop.

On the first packet on a CPU, the exact-saddr walk finds nothing. The
wildcard walk then finds the fallback, which has pcpu_num == UINT_MAX. A
larval state is created with x->pcpu_num = pcpu_id.
xfrm_init_tempstate() gives the larval the concrete flow saddr, so it
goes into the exact-saddr bucket.

On the next packet, the fallback is not in pol->state_cache_list,
because the cache add still requires x->pcpu_num == pcpu_id. The
exact-saddr walk finds the larval and sets acquire_in_progress. This
early exit then skips the wildcard walk:

net/xfrm/xfrm_state.c:xfrm_state_find() {
    ...
	if (best || acquire_in_progress)
		goto found;

	h_wildcard = __xfrm_dst_hash(daddr, &saddr_wildcard, tmpl->reqid,
				     encap_family, state_ptrs.hmask);
    ...
}

best is still NULL, so the new "best && (... || acquire_in_progress)"
test can't fire. x stays NULL, and the lookup returns -EAGAIN. With
xfrm_larval_drop=1, won't packets still be dropped until the per-CPU SA
is installed or the larval expires?

xfrm_state_look_at() sets acquire_in_progress for any CPU's larval while
best is NULL. So other CPUs look like they would take the same path.

That would also go against the existing comment in the acquire block:

		/* Use the already installed 'fallback' while the CPU-specific
		 * SA acquire is handled*/

This needs a wildcard-source fallback SA under a CPU_ACQUIRE policy.
That setup is unusual, since IKE daemons install concrete addresses, but
copy_from_user_state() does not seem to reject it.

Would a complete fix also need to change the early exit? One option is
to go on into the wildcard walk when acquire_in_progress is set and best
is NULL.

>  		x = best;

[Severity: High]
This issue was not introduced by this patch, but it is on the line being
changed. The x = best assignment is conditional and has no else branch.
That means x keeps whatever the last hlist_for_each_entry_rcu() loop left
in it. Can x end up pointing at a state that was never validated?

With CONFIG_XFRM_OFFLOAD and a packet offload policy, both the bydst walk
and the wildcard walk break out at the first non-HW state:

		if (pol->xdo.type == XFRM_DEV_OFFLOAD_PACKET) {
			if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
				/* HW states are in the head of list, there is
				 * no need to iterate further.
				 */
				break;

After that break, x points at a SW state. That state was never checked
against the template, addresses or selector, and was never passed to
xfrm_state_look_at().

Take an XFRM_POLICY_CPU_ACQUIRE policy where the condition above is
false. One example is a HW fallback as best, with pcpu_num == UINT_MAX
and no acquire in progress. Another is best being NULL after the
wildcard walk broke out. In both cases x stays non-NULL, so the
"if (!x && !error && !acquire_in_progress)" block is skipped. out: then
calls xfrm_state_hold_rcu(x) and returns the unrelated state.

Could xfrm_tmpl_resolve_one() then use that state for the flow, with the
wrong SPI and keys, and in tunnel mode the wrong outer destination?

Nothing seems to reject XFRM_POLICY_CPU_ACQUIRE combined with packet
offload. The conditional assignment came in with 1ddf9916ac09 ("xfrm:
Add support for per cpu xfrm state handling."). This patch narrows the
window, since best && acquire_in_progress now assigns x.

Would an explicit else x = NULL, or resetting x before found:, be
safer?

>  
>  	if (!x && !error && !acquire_in_progress) {

[Severity: Medium]
This isn't a bug introduced by this patch, but it affects the RFC 9611
behavior the commit message cites. In xfrm_state_look_at(), an ACQ state
sets acquire_in_progress whenever best is still NULL, whatever its
pcpu_num is:

	} else if (x->km.state == XFRM_STATE_ACQ) {
		if (!*best || x->pcpu_num == pcpu_id)
			*acq_in_progress = 1;

XFRM_STATE_INSERT() puts new larval states ahead of the existing software
states in the bydst bucket. So on a CPU without its own SA, the walk
usually sees another CPU's larval before the fallback. acquire_in_progress
gets set and this block is skipped, so no km_query() is sent for this
CPU.

With this patch that CPU now uses the fallback without any warning. But
doesn't its own per-CPU SA negotiation still wait until the other CPU's
larval resolves, or expires after sysctl_acq_expires?

With several CPUs, wouldn't per-CPU SA setup end up serialized?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025064524.74618-1-matthewzhaocc%40gmail.com
