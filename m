Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D118C008
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460253; cv=none; b=NIUPORA1UAC7jlyZ7exSq5twa1NCwKBTsDrD52DeJBAyepGybMOEaEilu2ng6zypwKlS9YirwY5vYv1ixFo0BnMompMDeJFsUeIlPEqTIAmQzV5pkN+K7ntqwYwCnb/YC0YCHuU/dE/Of79ukN5P9jAbWwEhSqwBtBOZpXerbs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460253; c=relaxed/simple;
	bh=t6J5OZWIvTUaqy/7KhwIUWN7G5u4T54vKkhDWEYXVBA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxOBoY0ip/67JqZLFCer9P25IZyA9YgA3Tf3cOzpVxLmCjOe9ygMJI0s9/eyOgvRv+VzumfbZuL1AOKBNmE552R3EmEzF9dBpNqRHbO6K5rxvsRHJDS+GnkQ9CTu22SoM0LpWkHO4+aGeZ30eF18s7tkZW+cIFfklvwmZV3U3xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiaW3Dhu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiaW3Dhu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627E71F00893;
	Tue, 15 Sep 2026 08:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789460251;
	bh=FcpBABitAheCommJ1z31YXuwo9rxXU52GQazYeAgYI8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XiaW3Dhu/XUDG8ig6k/zIe8ysERMgsLn03SUNUP/HAPyk29y3ERhp2fxl0E2bGAE7
	 yRElf5piTycQCNdgmWVhlgNzkb1s11the3lGiE5gYss77aq618G5ZagzDPvEDkiGri
	 DsEftsH66NCODY0NDNqwV4rEtta26cY/gF9Y7HlNsAgZ0KwpW7FAkeZ3DiajopiT9P
	 SnJe1KqoxtNj86nHoYwysjpSfeo0G2Ro8RosERwtxpnZ3ZTwXEsPEnVaVvMgGr8bNH
	 GmQA50QASVszQJBVJzPT/MfUkm/mJ85xCjkMtWpdfiSh0jb9zklWckxuznDcCmsKnK
	 eSegdrPb0TGnQ==
Subject: Re: [PATCH net v2 2/2] selftests: tc-testing: add a lateral-drift
 hfsc classify-walk test
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, sashiko-bot@kernel.org, hybris@mojatatu.ai
Date: Tue, 15 Sep 2026 08:17:29 +0000
Message-ID: <178946024991.22033.9851836059395249894@kernel.org>
In-Reply-To: <QDISC-CTUU.v2.20260913192615@mojatatu.com>
References: <QDISC-CTUU.v2.20260913192615@mojatatu.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 0

- [High] Test 8c39 ("HFSC classify walk still reaches leaf after lateral
  drift") never exercises the new lateral-hop drift budget in…
- [Medium] Test 8c39 makes the qdisc's default class the same leaf it
  asserts on: the root qdisc is created with `hfsc default 31`…
- [Medium] Test 8c39's cmdUnderTest is the compound shell command `ping
  -n -c 10 -W 1 127.0.0.1; sleep 1` with expExitCode "0"…

--

selftests: tc-testing: add a lateral-drift hfsc classify-walk test

This adds tc-testing case 8c39, which builds an HFSC hierarchy with
lateral filter binds (root -> 1:1 -> 1:2 -> 1:3 -> leaf 1:31), pings
through it, and checks that packets are counted on class 1:31.  The
intent is to show that the new classify-walk drift budget does not
misfire on a legal lateral chain.

> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
> index c98c339424d4e..82d2f8af1460d 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
> @@ -169,5 +169,39 @@
>          "teardown": [
>              "$TC qdisc del dev $DUMMY handle 1: root"
>          ]
> +    },
> +    {
> +        "id": "8c39",
> +        "name": "HFSC classify walk still reaches leaf after lateral drift",
> +        "category": [
> +            "qdisc",
> +            "hfsc"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "ip link set lo up",
> +            "$TC qdisc add dev lo handle 1: root hfsc default 31",
> +            "$TC class add dev lo parent 1: classid 1:1 hfsc rt m2 100kbit",
> +            "$TC class add dev lo parent 1: classid 1:2 hfsc rt m2 100kbit",
> +            "$TC class add dev lo parent 1: classid 1:3 hfsc rt m2 100kbit",
> +            "$TC class add dev lo parent 1:1 classid 1:10 hfsc rt m2 50kbit",
> +            "$TC class add dev lo parent 1:2 classid 1:20 hfsc rt m2 10kbit",
> +            "$TC class add dev lo parent 1:3 classid 1:30 hfsc rt m2 10kbit",
> +            "$TC class add dev lo parent 1:3 classid 1:31 hfsc rt m2 100kbit",
> +            "$TC filter add dev lo parent 1: protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:1",
> +            "$TC filter add dev lo parent 1:1 protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:2",
> +            "$TC filter add dev lo parent 1:2 protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:3",
> +            "$TC filter add dev lo parent 1:3 protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:31"
> +        ],

[Severity: High]
Does this setup order actually build the lateral chain the test needs?

All of the child class adds (1:10, 1:20, 1:30, 1:31) come before the
filter adds, so by the time the lateral binds are issued 1:2 and 1:3 are
already interior classes at level 1.

For "$TC filter add dev lo parent 1:1 ... flowid 1:2", the class 1:1 is
passed as the bind base, and hfsc_bind_tcf() rejects the bind:

net/sched/sch_hfsc.c:hfsc_bind_tcf() {
	...
	if (cl != NULL) {
		if (p != NULL && p->level <= cl->level)
			return 0;
		qdisc_class_get(&cl->cl_common);
	}
	...
}

With p = 1:1 (level 1) and cl = 1:2 (level 1), p->level <= cl->level
holds, so 0 is returned.  __tcf_bind_filter() then stores that as
res.class:

include/net/pkt_cls.h:__tcf_bind_filter() {
	cl = q->ops->cl_ops->bind_tcf(q, base, r->classid);
	cl = __cls_set_class(&r->class, cl);
	...
}

Nothing is propagated back to userspace, so the tc command still exits 0
and the setup step looks like it succeeded.  The same applies to the
1:2 -> 1:3 filter.

At classify time the second hop therefore has res.class == NULL and the
walk stops at the pre-existing downward-only check rather than at the new
drift check:

net/sched/sch_hfsc.c:hfsc_classify() {
	...
	cl = (struct hfsc_class *)res.class;
	if (!cl) {
		cl = hfsc_find_class(res.classid, sch);
		if (!cl)
			break;	/* filter selected invalid classid */
		if (cl->level >= head->level)
			break;	/* filter may only point downwards */
	}
	...
}

1 >= 1 breaks the loop, so the drift budget is never consumed and the
test would pass identically with a bound of 0.

Related to that, the commit message says the chain is built "with 1:2/1:3
deepened to interior level 1 after the binds", but in the setup list the
deepening class adds precede the binds.  Should each deepening add follow
its corresponding lateral bind instead, i.e. bind 1:1 -> 1:2 while 1:2 is
still level 0, then add 1:20; bind 1:2 -> 1:3 while 1:3 is still level 0,
then add 1:30 and 1:31?

The commit message also states "on a too-tight bound it would drop the
packet instead" - with the current ordering, is that still true?

> +        "cmdUnderTest": "ping -n -c 10 -W 1 127.0.0.1; sleep 1",
> +        "expExitCode": "0",

[Severity: Medium]
Which command's exit status does expExitCode compare against here?

tdc runs cmdUnderTest through a shell:

tools/testing/selftests/tc-testing/tdc.py:exec_cmd() {
	proc = subprocess.Popen(command,
	    shell=True,
	    stdout=subprocess.PIPE,
	    stderr=subprocess.PIPE,
	    env=ENVIR)
	...
}

Because the ';' is a shell separator, proc.returncode is the status of
sleep 1, which is always 0.  Does that make the expExitCode "0" check
unable to fail even if ping is missing or loses every echo request?

There is a second effect from the compound command.  nsPlugin prepends
the netns wrapper only to the head of the split command:

tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py:adjust_command() {
	cmdlist = command.split()
	...
	cmdlist.insert(0, self.args.NAMES['NS'])
	cmdlist.insert(0, 'exec')
	cmdlist.insert(0, 'netns')
	cmdlist.insert(0, self.args.NAMES['IP'])
	...
	command = ' '.join(cmdlist)
}

So does "sleep 1" run in the initial namespace rather than in the test
namespace?  Would putting the delay in the verify step, or dropping it,
keep the whole command inside the namespace and let the ping status be
the one that is checked?

> +        "verifyCmd": "$TC -s class show dev lo",
> +        "matchPattern": "class hfsc 1:31 parent 1:3 rt.*\\n.*Sent [0-9]+ bytes [1-9][0-9]* pkt",
> +        "matchCount": "1",

[Severity: Medium]
Can this assertion distinguish a successful lateral walk from a failed
classification?

The root qdisc is created with "hfsc default 31" and the pattern counts
packets on class 1:31, which is the same class the default fallback
selects:

net/sched/sch_hfsc.c:hfsc_classify() {
	...
	/* classification failed, try default class */
	cl = hfsc_find_class(TC_H_MAKE(TC_H_MAJ(sch->handle),
				       READ_ONCE(q->defcls)), sch);
	if (cl == NULL || cl->level > 0)
		return NULL;

	return cl;
}

Any classification failure - a rejected bind, an early downward-only
break, or a future misfire of the drift guard - still credits the packets
to 1:31, so the tc output looks the same either way.

Would a default class distinct from the walk's terminal leaf (for example
default 30), or a default that is not a valid leaf so failures drop, make
this test able to fail when the guard misbehaves?

> +        "teardown": [
> +            "$TC qdisc del dev lo handle 1: root"
> +        ]
>      }
>  ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-CTUU.v2.20260913192614%40mojatatu.com
