Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2516243498C
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791716276; cv=none; b=WgLgSniYec7wLezWBC/XFqXAP3xEYvOQzSMu0yTo67VYj/RnTvh6TynaElmEanZg1T3rKuDhX9tSWTu7twnt2fK01HXjeR1tVVHGyUtGlECupVTn/7pg62HqUouBreoEe/Lxcs2/jVNa2ifMStRGMVSvNFOjuVlLGngRAW3sOUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791716276; c=relaxed/simple;
	bh=m6E0m6NvNzK4Qq6gQgXPGfKfnmJGivi9gSrulwox1Z0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/JxM2VNC+QG0aKbAFSNQviXUjh4uk9Pzi15qabK16+5B7A7nvwqkhoB6EAn9YiA38l0Jz5g7lUWsGaS4rYruiBv1ss1VU//uxJgTCT5KG2bLfwBrpCihUvA4Worh1/1beT84+4rDJ1guQHeDofql2GgNPTrxZ/QQpcxYz/lIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWoTejUi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWoTejUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C581F0089B;
	Sun, 11 Oct 2026 10:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791716275;
	bh=qKA4NXD9C+s5AK+TvomnwKBq6jJUyIjSrqijefcbJj8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gWoTejUi4y0kdAdAYAGrkRF9Pd/e7mtSMMF6KFduQxL07DP6knqq9nmO3krlJJoDH
	 GhCcEFEwHYrP4a1qqhSJ1INPsrvMZx5oegt1Pb/IjggXs/97NfRUqBVUhwsTzYXLHB
	 8MgTI1bTKiKWgOXiukXw3uvMM3BWR13pxT3r+2SOxLRsrubyqF/aTEi/dVNpMKOWsw
	 4M5hTi3si+a+rFbiYLs00E6KpPnN7cYa/W4Y8GfGi12a3j3Jvam4jQTIxrnhpoIFQD
	 01bpXRffxnHQPPA253IJOfnhuW9WmziMz7KoLKS8Nf5+MFwvEkT07b0KjDt9XzO7f3
	 PNYK5UEcK/puQ==
Subject: Re: [PATCH net-next 1/2] net/sched: act_gate: reject oversized dumps
 instead of wrapping them
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, olteanv@gmail.com, vladimir.oltean@nxp.com, p@1g4.org,
 eadavis@qq.com, dcaratti@redhat.com, dsahern@kernel.org,
 stephen@networkplumber.org, sashiko-bot@kernel.org
Date: Sun, 11 Oct 2026 10:57:53 +0000
Message-ID: <179171627364.434549.1472397105608939135@kernel.org>
In-Reply-To: <QDISC-H19Z.v2.20261007062551-2@mojatatu.com>
References: <QDISC-H19Z.v2.20261007062551-2@mojatatu.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch makes an unbuildable notification block
  RTM_DELACTION.
- [Medium] RTM_NEWACTION for an action set whose dump exceeds U16_MAX now
  returns -EINVAL even though the actions have already been created or…
- [Low] On the -EMSGSIZE branch, tfilter_del_notify()
  (net/sched/cls_api.c) sets the extack message "Filter deleted; del…
- [Low] The commit message misdescribes what the code did before the
  patch.
- [Low] In tfilter_del_notify(), -EMSGSIZE is taken to mean that the dump
  cannot be represented in a u16 nest ('no notification can ever be…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  tfilter_del_notify() still returns without calling ->delete() when…

--

net/sched: act_gate: reject oversized dumps instead of wrapping them

This commit switches the nest closes on the tc action and classifier dump
paths to nla_nest_end_safe(). A dump larger than U16_MAX now reports
-EMSGSIZE instead of writing a wrapped nla_len. It also bounds the
tfilter_notify_prep() retry loop, and makes tfilter_del_notify() drop a
notification it cannot build and delete the filter anyway.

Link: https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatatu.com/
Link: https://lore.kernel.org/netdev/179111893181.434549.13449660670267048994@kernel.org/

> tfilter_notify_prep() treats that as socket-buffer exhaustion and
> retries with an ever larger alloc_skb(); a dump that does not fit a u16
> nest cannot be built at any skb size, so the loop only spins until the
> allocation itself fails.

[Severity: Low]
Does this describe the code as it was before this patch?

Before, nla_nest_end() could not fail:

include/net/netlink.h:nla_nest_end() {
	unsigned long diff = skb_tail_pointer(skb) - (unsigned char *)start;

	DEBUG_NET_WARN_ON_ONCE(diff > U16_MAX);
	start->nla_len = diff;
	return skb->len;
}

Nothing under net/sched used nla_nest_end_safe(). So tcf_fill_node()
returned -EMSGSIZE only while the skb was short on tailroom. Once
tfilter_notify_prep() had grown the skb enough, the fill succeeded with a
wrapped length and the loop stopped.

The loop that runs until alloc_skb() fails seems to exist only after this
patch turns the u16 overflow into a fill failure. That makes the new bound
in tfilter_notify_prep() a requirement of the nla_nest_end_safe()
conversions, not a fix for an existing loop.

Could the commit message say this? A backport that takes the conversions
without the bound would bring in the allocation escalation loop.

> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 6e48b4bc2d75..747d91ae6446 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c

[ ... ]

> @@ -1693,7 +1696,8 @@ static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
>  	if (tcf_action_dump(skb, actions, bind, ref, false) < 0)
>  		goto out_nlmsg_trim;
>  
> -	nla_nest_end(skb, nest);
> +	if (nla_nest_end_safe(skb, nest) < 0)
> +		goto out_nlmsg_trim;

[Severity: High]
With this change, tca_get_fill() fails for an action set whose TCA_ACT_TAB
is larger than U16_MAX. Before, the same fill succeeded with a wrapped
length. Does this make a failed notification build refuse an
RTM_DELACTION?

tcf_del_notify() builds the notification before it deletes anything:

net/sched/act_api.c:tcf_del_notify() {
    ...
	} else {
		skb = tcf_del_notify_msg(net, n, actions, portid, attr_size,
					 extack);
		if (IS_ERR(skb))
			return PTR_ERR(skb);
	}

	/* now do the delete */
	ret = tcf_action_delete(net, actions);
    ...
}

tcf_del_notify_msg() turns any tca_get_fill() failure into -EINVAL:

	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, RTM_DELACTION,
			 0, 2, extack) <= 0) {
		NL_SET_ERR_MSG(extack, "Failed to fill netlink TC action attributes");
		kfree_skb(skb);
		return ERR_PTR(-EINVAL);
	}

The full path is:

tc_ctl_action(RTM_DELACTION)
  tca_action_gd()
    tcf_del_notify()
      tcf_del_notify_msg()
        tca_get_fill()
          nla_nest_end_safe() < 0

tcf_action_delete() is never reached.

With the 1024-entry cap applied, "tc actions del action gate index 1
action gate index 2" on two 1024-entry gate actions looks like it would
fail with -EINVAL and leave both actions installed. The commit message
says this two-action shape survives the cap.

The cap patch later in this series only adds GATE_ENTRIES_MAX in
parse_gate_list(). It does not touch tcf_del_notify(). Without the cap
patch, a single gate action with about 1815 or more entries could not be
deleted by index.

This needs rtnl_notify_needed() to be true, meaning an RTNLGRP_TC
listener or NLM_F_ECHO. rtnetlink allows non-root receive, so an
unprivileged listener in the netns seems to be enough to make an admin's
delete fail.

The commit message says "A notification that cannot be serialised must
not veto the state change the caller asked for", and tfilter_del_notify()
is changed to match. tcf_reoffload_del_notify() in this file already
drops a notification it cannot build:

		if (IS_ERR(skb))
			skb = NULL;

Should tcf_del_notify() be changed the same way? tca_get_fill() returns a
bare -1, so -EMSGSIZE would also need to be passed up. Otherwise the
delete path cannot tell the structural overflow from other failures,
which tfilter_del_notify() now relies on.

[Severity: Medium]
The same failure also shows up on the add side.
tcf_action_add()->tcf_action_init() has already inserted or replaced the
actions by the time tcf_add_notify()->tcf_add_notify_msg() calls
tca_get_fill():

	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, n->nlmsg_flags,
			 RTM_NEWACTION, 0, 0, extack) <= 0) {
		NL_SET_ERR_MSG(extack, "Failed to fill netlink attributes while adding TC action");
		kfree_skb(skb);
		return ERR_PTR(-EINVAL);
	}

The commit message notes this case and leaves it for later. However,
before this patch an oversized set still filled (with wrapped lengths)
and the add reported success. Isn't the "-EINVAL after the actions were
created" result new for these sets?

For example, with the cap applied, adding two 1024-entry gate actions in
one request now returns -EINVAL with the actions installed. This happens
when an RTNLGRP_TC listener exists or NLM_F_ECHO is set. A retry would
then hit -EEXIST.

>  
>  	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
>  
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index a9f54988561f..3f0ce567fa2d 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c

[ ... ]

> @@ -2200,8 +2209,16 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
>  	skb = tfilter_notify_prep(net, oskb, n, tp, block, q, parent, fh,
>  				  RTM_DELTFILTER, portid, rtnl_held, extack);
>  	if (IS_ERR(skb)) {
> -		NL_SET_ERR_MSG(extack, "Failed to build del event notification");
> -		return PTR_ERR(skb);
> +		if (PTR_ERR(skb) != -EMSGSIZE) {
> +			NL_SET_ERR_MSG(extack, "Failed to build del event notification");
> +			return PTR_ERR(skb);
> +		}

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. This
branch still returns without calling ->delete() when
tfilter_notify_prep() fails with something other than -EMSGSIZE, such as
-ENOBUFS from alloc_skb() or -EINVAL. Does that leak the flower filter
reference taken during the lookup?

In tc_del_tfilter(), fh comes from tp->ops->get(). For flower,
fl_get()->__fl_get() takes a reference:

	if (f && !refcount_inc_not_zero(&f->refcnt))
		f = NULL;

fl_delete() normally drops it with __fl_put(f). On this error path,
tc_del_tfilter() does:

		err = tfilter_del_notify(net, skb, n, tp, block, q, parent, fh,
					 &last, rtnl_held, extack);

		if (err)
			goto errout;

errout releases tp, chain and block, but never calls tfilter_put(tp, fh).
After that, even a later successful delete would not free the filter or
the actions bound to it.

The alloc_skb() failure seems realistic here. The retry loop grows the
skb toward U16_MAX + NLMSG_GOODSIZE, which needs order 4-5 allocations.

> +		/* The filter's dump cannot be represented in a u16 nest, so no
> +		 * notification can ever be built for it. Drop the notification
> +		 * rather than refusing to delete the filter.
> +		 */

[Severity: Low]
Does -EMSGSIZE always mean the dump cannot fit in a u16 nest?
tcf_fill_node() starts with:

	int ret = -EMSGSIZE;

and returns that for every ->dump() failure. Some dumps fail for reasons
that have nothing to do with size. One example is tcf_pedit_dump():

	opt = kzalloc(s, GFP_ATOMIC);
	if (unlikely(!opt)) {
		rcu_read_unlock();
		return -ENOBUFS;

u32_dump() also allocates with kzalloc_flex(), and tcf_action_dump_1()
reduces any error to -1.

If such a failure repeats through every retry in tfilter_notify_prep()
(about 17 with 4K pages), the loop returns ERR_PTR(-EMSGSIZE). This
branch then drops an RTM_DELTFILTER event that could have been built. The
comment in tfilter_notify_prep() only mentions structural overflow and
genuine capacity exhaustion.

> +		NL_SET_ERR_MSG(extack, "Filter deleted; del event notification could not be built");
> +		return tp->ops->delete(tp, fh, last, rtnl_held, extack);

[Severity: Low]
The extack text is set before ->delete() runs. If ->delete() then fails
without writing its own extack message, won't userspace get "Filter
deleted" together with a negative errno?

Flower, for example, runs without rtnl on an unlocked qdisc. Two
concurrent RTM_DELTFILTER requests for the same oversized filter can both
get through fl_get() and both hit -EMSGSIZE in prep. The second one then
reaches __fl_delete():

	if (f->deleted) {
		spin_unlock(&tp->lock);
		return -ENOENT;
	}

That path does not set extack. fw_delete() can return -EINVAL the same
way.

Could the message be set only after ->delete() returns 0?

>  	}
>  
>  	err = tp->ops->delete(tp, fh, last, rtnl_held, extack);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v2.20261007062551%40mojatatu.com
