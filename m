Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A044D9F68
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969342; cv=none; b=sHmSWbevuCeOqFY070nKKlWs39BZBObbrW8tOOuw57xvdJmgF0j9JWiTJTdE9okqjFDTuT5ggksk8JY7GQMVvJlLchwiUc8eWqiUY7cjmsf75mZV7z370bwTqMuRDwwFwn7EqK0LEdz7wXF0wZbl30ytZjTujxsfLYBP1/4skJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969342; c=relaxed/simple;
	bh=Z9lgZiZ+Dm1gbZ6+toZQhvK9uM+qGbMxCRdF/bmR+yU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJ4e7/39z7l3QP+niixsuYU5LCSB8fVSZKCkKJUOZfP2RzI0Bm5UvfWuyX78Ggy0apJpDR7iY4WJanwOCk3ALogpKE9hDHPITpMHKlLpDqrPgc0EVxvkPxOxAgcERO1AlpIfjpItXHncJ/bvWURIo69Ehyn4AtEbD6ZXYFHqW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFXgu78R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFXgu78R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B26B1F0089A;
	Wed, 14 Oct 2026 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791969341;
	bh=GfcRfLqWpOGkFEvjiEIeRXNKEXsHBfm1DqUqtI06JDE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mFXgu78RMDvkCSv73Q0UjU/3cQkvQiRjoJFNx68fkn2e0/mrQHXvafemiqcroJ9Qw
	 UsmIniZTUMbreIF3IBnK5/6JD+mQKz2a+5Di2MUDWJZ9cARiKm97Z22+hYabx6a08i
	 gy7M6XEEVctTG4k+swJ2Vc9HBMjbpObx2gg8QQNzBQT6/QbTWhRg6JGra+lUaVEaF8
	 T+wtxPyCEPhVLyxN2iWWs8HNVwCRgIfZkoPWj+0WOihxfqbFXH2zu7BlJZ0OL7eeZu
	 ZhdRnWO/g6F/Ej+H29RSLM+gOOhpuGZbP2kVr6qFW+TZckbW8Yk0ZggQ6j2Pn5CAci
	 37lhU0JPwCyDA==
Subject: Re: [PATCH net-next v3 2/5] net/sched: act_api: keep an add that
 created its actions from failing
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, p@1g4.org
Date: Wed, 14 Oct 2026 09:15:40 +0000
Message-ID: <179196934011.434549.12057895051142885770@kernel.org>
In-Reply-To: <QDISC-H19Z.v3.r0.20261012193813-2@mojatatu.com>
References: <QDISC-H19Z.v3.r0.20261012193813-2@mojatatu.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says the change is "net-next hardening ... not
  a regression".
- [Low] The "Conditions to recreate the bug" section leaves out a
  required precondition.

--

net/sched: act_api: keep an add that created its actions from failing

This commit changes tcf_action_add() so it no longer passes the result of
tcf_add_notify() back to user space. After this change, an RTM_NEWACTION
whose actions are already in the idr reports success even when the event
notification cannot be built or sent. The failure is reported as an extack
warning instead.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v2.20261007062551%40mojatatu.com

> This is net-next hardening: it corrects the reported result of an add
> that already took effect, not a regression.

[Severity: Low]
Is "not a regression" accurate? The message names a "realistic trigger"
and uses it in its reproducer: an action list whose aggregate TCA_ACT_TAB
exceeds a u16 nest. That trigger seems to make the add fail only after the
preceding patch in this series, "net/sched: act_gate: reject oversized
dumps instead of wrapping them".

Before that patch, tca_get_fill(), tcf_action_dump() and tcf_gate_dump()
all closed their nests with plain nla_nest_end(). nla_nest_end() cannot
fail: it warns and writes a wrapped length. Since cfa165cbfbed,
tcf_gate_get_fill_size() budgets every entry, so the skb was large enough.
An oversized add therefore returned 0, although its notification was
corrupt.

The preceding patch switched those closes to nla_nest_end_safe(), so
tca_get_fill() now fails:

net/sched/act_api.c:tca_get_fill() {
    ...
	err = nla_nest_end_safe(skb, nest);
	if (err < 0)
		goto out_nlmsg_trim;
    ...
}

tcf_add_notify_msg() then turns that into -EINVAL:

net/sched/act_api.c:tcf_add_notify_msg() {
    ...
	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, n->nlmsg_flags,
			 RTM_NEWACTION, 0, 0, extack) <= 0) {
		...
		return ERR_PTR(-EINVAL);
	}
    ...
}

Before this patch, tcf_action_add() returned that error to user space even
though tcf_action_init() had already inserted the actions into the idr.

This opens a one-commit bisect window. In it, an RTM_NEWACTION with
oversized aggregate gate actions installs the actions but reports -EINVAL.
This requires an RTNLGRP_TC listener or NLM_F_ECHO. A retry with the same
index then fails with -EEXIST.

The preceding patch fixed this "build failure vetoes the request" pattern
for both delete paths but not for the add path.

Should this change be squashed into the preceding patch, or ordered before
it, with the message saying so? An in-series Fixes: tag would not work,
because the hash is not stable yet.

There are also triggers that predate this series: -ENOBUFS from
alloc_skb(), or any action whose get_fill_size underestimates. They cause
the same user-visible symptom that cfa165cbfbed described. That commit
went in as a net fix with a Fixes: tag.

If this stays a standalone patch, is a Fixes: tag for the long-standing
error propagation in tcf_action_add() worth adding?

> Conditions to recreate the bug:
> CONFIG_NET_CLS_ACT=y; CONFIG_NET_ACT_GATE=y. Send an RTM_NEWACTION whose
> actions create an aggregate TCA_ACT_TAB larger than a u16 nest, so the
> notification cannot be built; before this change the add reports -EINVAL
> although the actions were installed, after it the add reports success and
> the actions are present.

[Severity: Low]
Does this reproducer leave out a required condition? tcf_add_notify() only
builds the notification when rtnl_notify_needed() is true:

net/sched/act_api.c:tcf_add_notify() {
    ...
	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC)) {
		skb = NULL;
	} else {
    ...
}

rtnl_notify_needed() is defined as:

	return (nlflags & NLM_F_ECHO) || rtnl_has_listeners(net, group);

With a NULL skb, rtnetlink_maybe_send() returns 0. So if there is no
RTNLGRP_TC listener (for example, no tc monitor running) and the request
does not set NLM_F_ECHO, the oversized RTM_NEWACTION returns 0 even before
this change.

The preceding patch in the series states this condition for the delete
paths ("only when a notification was actually needed (rtnl_notify_needed():
an RTNLGRP_TC listener or NLM_F_ECHO)"). Could the same condition be added
here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v3.r0.20261012193813%40mojatatu.com
