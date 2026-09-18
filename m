Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714F4D17A9
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729171; cv=none; b=MEyp1aClbJk797zBqt4esBFexzYod0NhH2ZrjP0K9c7d6aIZMW1PhfAAu9FSy+dn9xreycL/4wrtpxCx59xwabEHnENVZjbIg+JhaFWI8YL7MFC5q7iSgg1WCNmoVkW5xUSw6CjZCjagMHuYaNeI47lIJbyntCYrWm8RbYJpyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729171; c=relaxed/simple;
	bh=IPmchnQ/Z0yMO/GV+DkdinpjjofYNs5SCvaTlPwl2hU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R+PjeIdKg3nD6Gj8DdyebLVbnmIkONrT9zxf5OWYKg0W9u2aseXlrfbDlIFiOQtH9tpuSfXQ2du9y4AAYcHNinAhIaKCDbAHyPkR2IG4Ei9giam+kCngbeCg2iM5Y44TG6pZOs7gqefnwYGJRN54NxlGTZQw8pV0+AjiuI1j3z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMOAloPG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMOAloPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A528D1F000FF;
	Fri, 18 Sep 2026 10:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789729169;
	bh=LxV3ZLOmVQI62Slczz0H9oeQOvMK0rVuSBj9Qwa3DVI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cMOAloPGJ9bsnO5MXn8tcuQvXu9YmZzXFTMARdUZ5z27+7XZc38H8xQQTzvL3MZd3
	 aCsU29spDpMxIi2wLUuUjsJZtsKYK7l/KlM4ID42MtyP4KiN5Q3hqhQv03brq/pdJQ
	 2Kf8XmS0QsTWHRqzXorOM3bwyZ3a/t86fN0zosaR9NMBf0o/KxO6rJ57Uabvud2V+B
	 S7JS0YPDoV5qXVVWVqyyQCh8Iy6IQ7vh/47DWRTCIZADZ3Suir+JYP1sPJFR5Q4h9V
	 6fzYGaRz7Bftuo0/qNZBStIyKZyxGnxqQsc0CDomHP//hp6S/AdoIcve3UXmRFVuef
	 G+j15awpuXUkg==
Subject: Re: [PATCH net v3 2/2] selftests: tc-testing: add a lateral-drift
 hfsc classify-walk test
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, hybris@mojatatu.ai, sashiko-bot@kernel.org
Date: Fri, 18 Sep 2026 10:59:28 +0000
Message-ID: <178972916822.22033.1837892067044749195@kernel.org>
In-Reply-To: <QDISC-CTUU.v3.20260916184908@mojatatu.com.2>
References: <QDISC-CTUU.v3.20260916184908@mojatatu.com.2>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] The commit message of "selftests: tc-testing: add a lateral-
  drift hfsc classify-walk test" misdescribes the kernel behaviour it…
- [Medium] The hop guard this test is written to validate
  (HFSC_CLASSIFY_MAX_DRIFT in hfsc_classify(), added by the immediately…
- [Low] The new setup step invokes a bare `ip` binary (`"ip link set lo
  up"`) instead of the `$IP` keyword that tdc_config.py exists to…

--

selftests: tc-testing: add a lateral-drift hfsc classify-walk test

This adds tdc case 8c39 to tools/testing/selftests/tc-testing/tc-tests/
qdiscs/hfsc.json.  The setup builds a two-hop lateral chain by binding
each filter while its target is still a leaf and only then adding
children to deepen it, then pings 127.0.0.1 and checks that class 1:31
counted packets.

No Link: tags present in the commit header.

Two notes are about the changelog and about the coverage the case
provides, and one is about the harness keyword used in setup.

> The default class is 1:30, distinct from the asserted leaf, and the
> verify pattern is anchored to the 1:31 stats line, so neither a
> fall-through to the default nor a nonzero count on another class can
> satisfy the check. On the patched kernel the test passes; with the bound
> forced to zero the walk falls to the default and 1:31 stays idle, so the
> test fails.

[Severity: Medium]
Is "the walk falls to the default" the actual behaviour when the bound is
exhausted?  In hfsc_classify() the budget arm returns NULL rather than
breaking out of the loop:

net/sched/sch_hfsc.c:hfsc_classify() {
	...
	if (cl->level >= head->level && drift-- == 0) {
		pr_warn_ratelimited("hfsc: classify hop budget exhausted, dropping packet\n");
		return NULL;
	}
	...
	/* classification failed, try default class */
	cl = hfsc_find_class(TC_H_MAKE(TC_H_MAJ(sch->handle),
				       READ_ONCE(q->defcls)), sch);
}

The default-class lookup sits after the while loop, so it is only reached
from the two break paths (invalid classid, or a non-descending hop with no
bound class), not from the drift branch.

hfsc_enqueue() then turns that NULL into a drop:

net/sched/sch_hfsc.c:hfsc_enqueue() {
	cl = hfsc_classify(skb, sch, &err);
	if (cl == NULL) {
		if (err & __NET_XMIT_BYPASS)
			qdisc_qstats_drop(sch);
		__qdisc_drop(skb, to_free);
	...
}

So with HFSC_CLASSIFY_MAX_DRIFT forced to 0 the first lateral hop
(head = 1:1 level 1, cl = 1:2 level 1) discards every ICMP packet and
ping -n -c 10 -W 1 127.0.0.1 exits nonzero.

tdc.py compares exit_code != int(tidx["expExitCode"]) in test_runner() and
marks the case failed before running verifyCmd, so the negative control
fails on the ping exit status and the 1:31 stats pattern described as the
discriminator never gets evaluated.

Could the changelog describe the exhaustion path as a packet drop instead
of a fall-through to the default class?

> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
> index c98c339424d4e..4f6bbb8b57f93 100644
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

[Severity: Low]
This isn't a bug, but should this use the $IP keyword like the rest of the
suite?  replace_keywords() in tdc.py only substitutes $-prefixed names from
NAMES, and exec_cmd() runs commands with:

	proc = subprocess.Popen(command,
		shell=True,
		stdout=subprocess.PIPE,
		stderr=subprocess.PIPE,
		env=ENVIR)

with ENVIR = { } in tdc_config.py, so a bare ip resolves through the
shell's built-in default PATH rather than NAMES['IP'].  A tdc_config_local.py
that points 'IP' at a locally built iproute2 would not affect this step.
This appears to be the only bare ip invocation under
tools/testing/selftests/tc-testing/tc-tests.

> +            "$TC qdisc add dev lo handle 1: root hfsc default 30",
> +            "$TC class add dev lo parent 1: classid 1:1 hfsc rt m2 100kbit",
> +            "$TC class add dev lo parent 1:1 classid 1:10 hfsc rt m2 50kbit",
> +            "$TC class add dev lo parent 1: classid 1:2 hfsc rt m2 100kbit",
> +            "$TC filter add dev lo parent 1: protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:1",
> +            "$TC filter add dev lo parent 1:1 protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:2",
> +            "$TC class add dev lo parent 1:2 classid 1:20 hfsc rt m2 10kbit",

[Severity: Medium]
The bind-then-deepen construction used here is repeatable, so should the
case also cover the point where the guard starts dropping legal traffic?

hfsc_bind_tcf() only rejects a bind when the target is not deeper:

net/sched/sch_hfsc.c:hfsc_bind_tcf() {
	if (cl != NULL) {
		if (p != NULL && p->level <= cl->level)
			return 0;
	...
}

so binding 1:k -> 1:(k+1) succeeds while 1:(k+1) is still a leaf, and the
later class add raises that level through hfsc_adjust_levels() with no
revalidation of the existing bind and no error to the administrator:

net/sched/sch_hfsc.c:hfsc_adjust_levels() {
	do {
		level = 0;
		list_for_each_entry(p, &cl->children, siblings) {
			if (p->level >= level)
				level = p->level + 1;
		}
		WRITE_ONCE(cl->level, level);
	} while ((cl = cl->cl_parent) != NULL);
}

Repeating the same two setup steps for ten sibling interior classes gives
nine lateral hops of level 1 -> level 1.  Hops one through eight consume
HFSC_CLASSIFY_MAX_DRIFT and hop nine hits:

	if (cl->level >= head->level && drift-- == 0) {
		pr_warn_ratelimited("hfsc: classify hop budget exhausted, dropping packet\n");
		return NULL;
	}

which hfsc_enqueue() turns into qdisc_qstats_drop(sch) plus
__qdisc_drop(skb, to_free), i.e. all traffic on that chain is discarded
with only a rate-limited warning, on a configuration where every tc
command succeeded and which classified to its leaf before the guard.

That chain is finite and cycle-free, which does not match the comment
above HFSC_CLASSIFY_MAX_DRIFT:

	 * legal at bind time can become lateral once hfsc_adjust_levels()
	 * raises a class level; a few such hops are legitimate, an unbounded
	 * run means the chain cycles.

The new case builds two lateral hops out of the budget of eight, so it
does not exercise the boundary.  Would it be worth extending the case past
eight hops, or making the exhaustion arm break to the default class the way
the neighbouring misconfiguration exits do?

> +            "$TC class add dev lo parent 1: classid 1:3 hfsc rt m2 100kbit",
> +            "$TC filter add dev lo parent 1:2 protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:3",
> +            "$TC class add dev lo parent 1:3 classid 1:30 hfsc rt m2 10kbit",
> +            "$TC class add dev lo parent 1:3 classid 1:31 hfsc rt m2 100kbit",
> +            "$TC filter add dev lo parent 1:3 protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:31"
> +        ],
> +        "cmdUnderTest": "ping -n -c 10 -W 1 127.0.0.1",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC -s class show dev lo",
> +        "matchPattern": "class hfsc 1:31 parent 1:3 rt[^\\n]*\\n Sent [0-9]+ bytes [1-9][0-9]* pkt",
> +        "matchCount": "1",
> +        "teardown": [
> +            "$TC qdisc del dev lo handle 1: root"
> +        ]
>      }
>  ]

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-CTUU.v3.20260916184908%40mojatatu.com
