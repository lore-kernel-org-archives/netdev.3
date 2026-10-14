Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685544DAFA4
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969343; cv=none; b=U3I6AYNGkojNHztP3whyWLdpk+VsbG18hU+9rJ9MLFtF43ub0G9ZQw6qEXeOTbAsBOo6EAq3QP235d4UClehM4ULeB4s09tf3aVh8ZhzI4m6PqGCtVm8s7IkF89oZqq3QD8CCGn52r33QMhPBvjIpavFc0EMt41UEbr5X+R3FaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969343; c=relaxed/simple;
	bh=eFS4WGjshVW0iSf0gzlUevaCStY5cAzFApLu6ZgiaMQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i0Snfvc7amjok6/lZpvakW3GoVKhXjQuZeQT+rXVcqdI10r10Vg2b2NH59sOlbs6hDbOV/RypP5MPhYkffex66WcbE7DkwKRWiq6+yGbesXdgp5zhF5jWw2p6dULOoi0q2dOM00dI0EQc54VaeLXC1nKJM96ORM4iCchRw5mw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFXUFNt0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFXUFNt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98C61F00893;
	Wed, 14 Oct 2026 09:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791969342;
	bh=GIDUS6d2r7efNFQ1jZ188R1FBA28+YoXE7UkaDSBCjs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RFXUFNt0qbozeczGzcDVzDJ/UuglXaG9LirYfL7UWLp6l3LDsa+N//mP6ThbRkYc7
	 1wcIFxnVSEWKxMgpStjBycZ92dbLwdDVui8VaretXhZZlg+8Lxw5YFkBVo4FVphR0W
	 PM5ac8IVKyfGq2EJHLzbK6039kwLbStKMs10XSafd6fqIt0m5PNQ54i6YrQBlDHs/U
	 l9U8gc3jHkmE8Em7KjP20L3wE5vDxVfOeb0ABK1noobc/0GT5s+Z+wo/STX3r5Ueip
	 hgFWOg5ag86Q+jyp9K8PkFnml1f6aH4PjqSVFcFXsFFHAU28mnFdm7Y4t3NQOdAhQh
	 Jg3y2Sc5gIilA==
Subject: Re: [PATCH net-next v3 3/5] net/sched: act_gate: cap the number of
 scheduling entries
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, p@1g4.org
Date: Wed, 14 Oct 2026 09:15:41 +0000
Message-ID: <179196934128.434549.15511109301116224136@kernel.org>
In-Reply-To: <QDISC-H19Z.v3.r0.20261012193813-3@mojatatu.com>
References: <QDISC-H19Z.v3.r0.20261012193813-3@mojatatu.com>
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

- [Low] Concern (rejected after checking): the commit message relies on
  "net/sched: act_api: report an oversized action dump instead of…

--

net/sched: act_gate: cap the number of scheduling entries

This commit caps the number of TCA_GATE_ONE_ENTRY elements that
parse_gate_list() accepts at GATE_ENTRIES_MAX (1024). Larger lists are
rejected with -E2BIG and an extack message. The limit is based on the
SJA1105 schedule-table capacity and on the 16-bit nla_len limit of a
nested attribute.

Link: https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatatu.com/

> Why 1024 despite the dump budget:
> 1024 is a SJA1105 schedule-table capacity, not a dump-budget value. The
> kernel clamps a dump skb to SKB_WITH_OVERHEAD(32768), so only ~800-890
> entries of this list fit "tc actions ls"; the top of the admitted band
> therefore installs but is not listed. That is accepted deliberately:
> a unicast RTM_GETACTION reply is pre-sized from the action's advertised
> size (budgeted per entry since the parent fix), so "tc actions get"
> enumerates the whole band, and "net/sched: act_api: report an oversized
> action dump instead of silently truncating it" makes the list view fail
> loudly with -EMSGSIZE and an extack rather than silently truncating.

[Severity: Low]
This is a minor point about the commit message, not about the code.

The paragraph reads as if the -EMSGSIZE behaviour is already in place.
The referenced commit is the last patch of this series, though. At this
commit, tcf_dump_walker() in net/sched/act_api.c still drops an action
that does not fit:

net/sched/act_api.c:tcf_dump_walker() {
    ...
		if (err < 0) {
			index--;
			nlmsg_trim(skb, nest);
			goto done;
		}
    ...
}

So at this bisect point, a gate with roughly 890-1024 entries is still
silently left out of "tc actions ls". That is not a regression: the
truncation already happened before this patch, when gates of any size
were allowed. This patch only narrows the range that triggers it, and
the final patch of the series makes it fail loudly.

Could the message say that the act_api change comes later in this
series?

Could "the parent fix" also name the commit it means, presumably
cfa165cbfbed, which added the per-entry get_fill_size budget?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v3.r0.20261012193813%40mojatatu.com
