Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F63D49B1F3
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969341; cv=none; b=dZ2mw96amjuol7dy0HvyU0ya8CaGCJxtJDrhM051hQvZlF8+fpRZRCtgtywF4QBoKpyMwLETIyUWT2bz2uvPm6vg06EyO4PPEQDja78H2MEYDO2fnTdvPQTH8Bb9wmnp1AXqQ+XrHM32zWeoFJK6WeN7rS83HKCOO3iPUT8c9RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969341; c=relaxed/simple;
	bh=Vt4kWfTtwYhKzt8WY0Xm+e+zpniOnDVJFejFHuXAsCU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rBsFTQiBMkw4UVsenGs94/+ndcERR2ifTx332P0YjJfrWce9pZUPtHrK/tgDaB61WxS5GqA6c9WKUH5Y4WkHV4rNxrB48rJFP7YIf2XTBJRYeF4C9Dd980O/evocmx9GqQ4K2MMV97HTpVWf2lpy0UFQk6JdFY5ZoGpwUpxkPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPzwLAEz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPzwLAEz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606341F000FF;
	Wed, 14 Oct 2026 09:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791969339;
	bh=1lMCixwvmT6QFNNcv7lquI18T7wsZfG550Pq/JmrKHI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kPzwLAEzKTJp+j72jpmQV5ZFtuwb5SnmkTwuAs6a7csNIVfOjhaWxBrNjWF0/wdd+
	 0ce32QXcLfRUK8kQ/p+Qx75FMfA41jMMeCPZ91r/wmwHL+nx/0gBCyO8JNkIzXiW2i
	 IEN60welYD3XzWHrdte6gbHJXEYkhJPxSKAinfuntV1kz8zb/c+gB6r28tggXQ2UCx
	 4ug/ycBWg26buOcEqJpFl1uDB2iCgkGzn8AJW1k/ClZruLgDBaBwUoFyqPHW1U4h7T
	 KpxIyGx6copzjU9qK2mWWaMTXqnnsdcKuTZ08x+8qvpUEXzgl0OnK9ZlprSpl4rvMq
	 46vDCLPS4mk5w==
Subject: Re: [PATCH net-next v3 1/5] net/sched: act_gate: reject oversized
 dumps instead of wrapping them
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, p@1g4.org
Date: Wed, 14 Oct 2026 09:15:38 +0000
Message-ID: <179196933894.434549.7501304667128193160@kernel.org>
In-Reply-To: <QDISC-H19Z.v3.r0.20261012193813-1@mojatatu.com>
References: <QDISC-H19Z.v3.r0.20261012193813-1@mojatatu.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In this commit, when an RTM_NEWACTION notification is needed,
  tcf_add_notify_msg() (net/sched/act_api.c) turns the new -EMSGSIZE…
- [Medium] The commit message describes several failures as pre-existing
  when they only appear once this patch adds nla_nest_end_safe().
- [Low] tcf_del_notify() (net/sched/act_api.c) now treats every -EMSGSIZE
  from tcf_del_notify_msg() as "Such a dump can never be serialized".

--

net/sched: act_gate: reject oversized dumps instead of wrapping them

This patch closes the action and classifier nests with nla_nest_end_safe(),
so a dump larger than a u16 nest fails with -EMSGSIZE instead of writing a
wrapped length. It also puts a bound on the tfilter_notify_prep() retry
loop. On the filter and action delete paths, an -EMSGSIZE notification
build failure now drops the notification and lets the delete go ahead.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.4143642-1-victor@mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v2.20261007062551%40mojatatu.com
Link: https://lore.kernel.org/netdev/QDISC-H19Z.v2.20261007062551@mojatatu.com/
Link: https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatatu.com/
Link: https://lore.kernel.org/netdev/179111893181.434549.13449660670267048994@kernel.org/

> The oversized dump also reaches the filter notification path through
> tcf_fill_node(), which reports the failure as -EMSGSIZE.
> tfilter_notify_prep() treats that as socket-buffer exhaustion and
> retries with an ever larger alloc_skb(); a dump that does not fit a u16
> nest cannot be built at any skb size, so the loop only spins until the
> allocation itself fails.

[ ... ]

> The same shape as two standalone gate actions is hit on the action path
> by RTM_DELACTION with NLM_F_ECHO; before this change the fill fails and
> the delete is refused, after it the actions are removed and only the
> notification is dropped.

[Severity: Medium]
Does this describe the behaviour before the patch correctly? Before this
patch, nla_nest_end() cannot fail:

include/net/netlink.h:nla_nest_end() {
    ...
	DEBUG_NET_WARN_ON_ONCE(diff > U16_MAX);
	start->nla_len = diff;
	return skb->len;
}

Also, net/sched had no nla_nest_end_safe() callers before this patch.

Before the patch, tfilter_notify_prep() grows the skb until the dump fits.
It then succeeds, and the TCA_OPTIONS length is wrapped. It does not spin
until alloc_skb() fails.

On the action side, tcf_gate_get_fill_size() already budgets each entry.
So tcf_del_notify_msg() gets a large enough skb, and tca_get_fill()
succeeds with a wrapped TCA_ACT_TAB. The delete goes through rather than
being refused.

The Context note has the same issue. It says "a filter whose dump cannot
be represented in a u16 nest could be created but never removed" and "an
action list whose TCA_ACT_TAB exceeds a u16 nest could not be deleted
either". Both behaviours only appear once the new checked closes are in
place.

The only defect that exists before the patch seems to be the wrapped
(structurally corrupt) reply or notification, plus the DEBUG_NET warning.
The retry bound and the delete path changes look like follow-ons that the
new nla_nest_end_safe() calls require.

Could the commit message be reworded? As written, a backporter might
conclude that current kernels refuse deletes or spin in
tfilter_notify_prep().

> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 6e48b4bc2d75d..4b4b5d37d2206 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c

[ ... ]

> @@ -1673,27 +1676,42 @@ static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],

[ ... ]

> -	if (tcf_action_dump(skb, actions, bind, ref, false) < 0)
> +	err = tcf_action_dump(skb, actions, bind, ref, false);
> +	if (err < 0) {
> +		/* Report any inner dump failure as -EMSGSIZE so
> +		 * tcf_del_notify() drops the notification, not the delete.
> +		 */
> +		err = -EMSGSIZE;
>  		goto out_nlmsg_trim;
> +	}
>  
> -	nla_nest_end(skb, nest);
> +	err = nla_nest_end_safe(skb, nest);
> +	if (err < 0)
> +		goto out_nlmsg_trim;

[Severity: Medium]
How does the RTM_NEWACTION path handle this new failure? tca_get_fill()
can now fail once TCA_ACT_TAB exceeds U16_MAX. On the add side,
tcf_add_notify_msg() still turns that into -EINVAL:

net/sched/act_api.c:tcf_add_notify_msg() {
    ...
	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, n->nlmsg_flags,
			 RTM_NEWACTION, 0, 0, extack) <= 0) {
		NL_SET_ERR_MSG(extack, "Failed to fill netlink attributes while adding TC action");
		kfree_skb(skb);
		return ERR_PTR(-EINVAL);
	}
    ...
}

tcf_add_notify() returns that error, and tcf_action_add() passes it to
userspace:

tc_ctl_action(RTM_NEWACTION)
  tcf_action_add()
    tcf_action_init()        <- actions already created or replaced
    tcf_add_notify()
      tcf_add_notify_msg()
        tca_get_fill()
          nla_nest_end_safe() -> -EMSGSIZE -> -EINVAL

This happens when an RTNLGRP_TC listener exists or NLM_F_ECHO is set. The
add then reports failure for a change that was already committed. A retry
gets -EEXIST, and with NLM_F_REPLACE the old configuration is already gone.

Before this patch the fill could not fail here and the add returned 0. The
delete side is handled in this patch, but the add side is not.

The later patch in this series, "net/sched: act_api: keep an add that
created its actions from failing", resolves this. With it, tcf_action_add()
ignores the tcf_add_notify() result, sets the extack "Action created; event
notification could not be sent", and returns 0. Since this patch alone
exposes the problem, would it make sense to fold that change in here or
order it earlier?

A smaller leftover remains at the end of the series. tcf_get_notify()
(RTM_GETACTION) still maps any tca_get_fill() failure, now including the
new -EMSGSIZE, to -EINVAL:

net/sched/act_api.c:tcf_get_notify() {
    ...
	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, event,
			 0, 1, NULL) <= 0) {
		NL_SET_ERR_MSG(extack, "Failed to fill netlink attributes while adding TC action");
		kfree_skb(skb);
		return -EINVAL;
	}
    ...
}

The filter GET path returns -EMSGSIZE for the same condition, and the
extack text still talks about adding a TC action.

[ ... ]

> @@ -2016,8 +2036,14 @@ static int tcf_del_notify(struct net *net, struct nlmsghdr *n,
>  	} else {
>  		skb = tcf_del_notify_msg(net, n, actions, portid, attr_size,
>  					 extack);
> -		if (IS_ERR(skb))
> -			return PTR_ERR(skb);
> +		if (IS_ERR(skb)) {
> +			/* Such a dump can never be serialized: drop the
> +			 * notification rather than refuse the delete.
> +			 */
> +			if (PTR_ERR(skb) != -EMSGSIZE)
> +				return PTR_ERR(skb);
> +			skb = NULL;
> +		}
>  	}

[Severity: Low]
Is the "can never be serialized" claim accurate for every -EMSGSIZE that
reaches this branch? tcf_del_notify_msg() allocates a single skb of
max(attr_size + warn, NLMSG_GOODSIZE) and calls tca_get_fill() once. Unlike
tfilter_notify_prep(), it has no grow-and-retry loop.

tca_get_fill() also reports every tcf_action_dump() error as -EMSGSIZE.
That includes transient failures, for example in tcf_pedit_dump():

net/sched/act_pedit.c:tcf_pedit_dump() {
    ...
	opt = kzalloc(s, GFP_ATOMIC);
	if (unlikely(!opt)) {
		rcu_read_unlock();
		return -ENOBUFS;
	}
    ...
}

That error becomes -1 in tcf_action_dump_1() and tcf_action_dump(), and
tca_get_fill() then reports it as -EMSGSIZE. An ops->get_fill_size()
underestimate, the bug class fixed by cfa165cbfbed, would also land here.

Before this patch these failures refused the delete with -EINVAL. Now the
delete commits, and RTNLGRP_TC listeners such as tc monitor never see the
RTM_DELACTION event. NLM_F_ECHO callers get no echo, and nothing signals
the lost event.

Should the comment be reworded, or should transient failures be kept apart
from the size-overflow case? This code is unchanged at the end of the
series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v3.r0.20261012193813%40mojatatu.com
