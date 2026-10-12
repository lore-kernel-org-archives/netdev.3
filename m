Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143DB49B5C2
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820285; cv=none; b=lj35Pz2zOMC6WhUfuIIUGNNzF7k+/5CXuPVMR3HZDlbbr30XlW9hOaOsQKsPVE1932K1HwHAgHxeERVAD5+6DmkOsTINZo3X/E9flySiefuldkkBBWhsmeEwciXHfHApIxdZmGBlyXcq/tQ2cJFqDNRopKn+/MppWiaWQnJ3ge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820285; c=relaxed/simple;
	bh=C5SCJZoK5UcouByAp0+ZeIIqJRd25nkmh3Q/2YtmiRQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mxthl0B03AAJScLYK8FbWkWkx0VE81tAlvhDCcx1sNOYNY/SakrCj1IGahQC2lR2Osz9DmpmzG6u5xVthe71A0qBUmX4OEATuLq3Gk8mQnD2ObAy7ox5Ipc1tmMqDNkbAa3r8SrdHndAJqBAJ+/RQv3l/vFDuerHiTBBFImnikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJIEnP0c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJIEnP0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0D31F0089C;
	Mon, 12 Oct 2026 15:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791820283;
	bh=U/ihydZnnr6jBYp16IZgRDVGbQrWmnhNVlzD4JRrywA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FJIEnP0cU8Z3MO+KjClQZWiuJYL8wf68L1KMdMEVGPpDp3a79JiufmULoM4AyksfX
	 tkvwZAYvp9W8FsIMmZLVeKCthRJhZ9rYCAL9I0cagh9Al05zrjPUQ7Ov3IorYLEwSj
	 pr1h044rxgJRHBSsTU5pBsZ4qcjRit9hqMyifsIVYuZNO+nAwhONNj+AqEJvWR+QoX
	 2bQRvF5fJWksmLIEMy9zTRfileE/SqkOaOIjsX99qIEskngwiDr1cC6UEDcOn5LbIH
	 2csvfAtxNrh1z/WKPcF1KHKUCkGKn635WiC5XOS46KCBpQzT3WFaAvwGTl9+u3CO8b
	 TM8xHK6AoL2mw==
Subject: Re: [PATCH net-next 2/2] selftests: tc-testing: add DRR deficit
 refill regression tests
From: netdev-bot+sashiko@kernel.org
To: victor@mojatatu.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 horms@kernel.org, sashiko-bot@kernel.org, shuah@kernel.org
Date: Mon, 12 Oct 2026 15:51:22 +0000
Message-ID: <179182028286.434549.16253622180736690555@kernel.org>
In-Reply-To: <QDISC-TIAE.v1.20261008110502-2@mojatatu.com>
References: <QDISC-TIAE.v1.20261008110502-2@mojatatu.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Both new tdc cases in tools/testing/selftests/tc-testing/tc-
  tests/qdiscs/drr.json only pass if the verify command lands inside a…
- [Medium] Test 57a1 is meant to catch a 'per-class bulk refill that
  advances each class to its own eligibility point', as the commit…

--

selftests: tc-testing: add DRR deficit refill regression tests

This adds two tdc cases to drr.json. The first checks the deficit left on a
quantum 256 class after one 1514 byte packet is served (22 bytes), while a
second packet is still queued behind a netem child. The second checks
service order: with two active quantum 256 classes, the 514 byte packet
should be dequeued before the 1514 byte packet at the list head.

> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
> index 2b61d8d79bde8..bb0995d8358fc 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
> @@ -86,5 +86,87 @@

[ ... ]

> +    {
> +        "id": "3f3e",
> +        "name": "DRR deficit refill converges to the loop-equivalent value",

[ ... ]

> +        "setup": [
> +            "$IP addr add 10.10.11.10/24 dev $DUMMY",
> +            "$TC qdisc add dev $DUMMY root handle 1: drr",
> +            "$TC class add dev $DUMMY parent 1: classid 1:1 drr quantum 256",
> +            "$TC qdisc add dev $DUMMY parent 1:1 handle 10: netem delay 2s limit 10",
> +            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match u32 0 0 flowid 1:1",
> +            "ping -c 2 -s 1472 -i 1 10.10.11.11 -I $DUMMY -W 0.01 >/dev/null 2>&1 &"
> +        ],
> +        "cmdUnderTest": "sleep 2.5",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC -s class show dev $DUMMY",
> +        "matchPattern": "deficit 22b",

[Severity: Medium]
Can this case fail on a kernel that is behaving correctly, purely because of
timing?

The pattern only matches inside a window about one second wide. Say ping
sends packet 1 at T0 and packet 2 at T0+1. With netem delay 2s, they are
released at T0+2 and T0+3:

  before T0+2:        deficit is still 256, tc prints "deficit 256b"
  T0+2 .. T0+3:       packet 1 served, deficit is 22
  after T0+3:         packet 2 dequeued, child qlen drops to 0

Once qlen is 0, the dump reports zero:

net/sched/sch_drr.c:drr_dump_class_stats() {
    ...
	memset(&xstats, 0, sizeof(xstats));
	if (qlen)
		xstats.deficit = READ_ONCE(cl->deficit);
    ...
}

so tc prints "deficit 0b".

The verify command runs at the end of setup, plus the sleep 2.5, plus the
cost of spawning cmdUnderTest and verifyCmd through ip netns exec. That
leaves about 0.5s of slack either way for the difference between that
overhead and ping's startup time.

Test 57a1 below has the same shape. B1 is released about two seconds after
the first python3 sends. B2 is released about two seconds after the second
python3 sends. At that point 1:2 is at the head with a deficit of 254 and a
514 byte packet. The refill then serves both B2 and A1, which changes every
bytes/packets/backlog/qlen value in its matchJSON.

The verify at setup end plus sleep 1.5 has to land between those two
releases. That again depends on python3 startup and spawn overhead staying
under about 0.5s.

tdc.sh runs ./tdc.py -J"$(nproc)", so these cases run in parallel with
other tests. That adds fork/exec, python3 startup and scheduling jitter,
especially on debug kernels with KASAN or lockdep.

Most existing sleep based tdc cases only need a lower bound. These two need
both a lower and an upper bound.

> +        "matchCount": "1",
> +        "teardown": [
> +            "$TC qdisc del dev $DUMMY root"
> +        ]
> +    },
> +    {
> +        "id": "57a1",
> +        "name": "DRR skips only rounds where no class can dequeue (keeps order)",

[ ... ]

> +        "setup": [
> +            "$IP addr add 10.10.11.10/24 dev $DUMMY",
> +            "$TC qdisc add dev $DUMMY root handle 1: drr",
> +            "$TC class add dev $DUMMY parent 1: classid 1:1 drr quantum 256",
> +            "$TC class add dev $DUMMY parent 1: classid 1:2 drr quantum 256",
> +            "$TC qdisc add dev $DUMMY parent 1:1 handle 10: netem delay 2s limit 10",
> +            "$TC qdisc add dev $DUMMY parent 1:2 handle 20: netem delay 2s limit 10",

[Severity: Medium]
Does this case reliably catch the regression the commit message describes?

  A per-class bulk refill that advances each class to its own
  eligibility point would dequeue the head class instead.

To tell the two refill styles apart, A1 (in 1:1, the list head) and B1 (in
1:2) both have to be ready in the same drr_dequeue() pass.

Both netem children use delay 2s. netem_dequeue() compares time_to_send
against ktime_get_ns() at peek time. So B1 becomes sendable a small delta
after A1, where the delta is the gap between the two sendto() calls in the
same python3 process.

What happens if the hrtimer -> NET_TX softirq -> drr_dequeue() latency is
shorter than that delta?

1. At A1's release, 1:1 peeks A1 and 1514 > 256. first is set to 1:1, its
   deficit becomes 512, and list_move_tail() leaves the list as [1:2, 1:1].

2. 1:2 peeks NULL, and drr_dequeue() bails out:

		if (skb == NULL) {
			qdisc_warn_nonwc(__func__, cl->qdisc);
			goto out;
		}

   1:2 is now the list head.

3. At B1's release, 1:2 goes 256 -> 512 and 1:1 goes 512 -> 768. The bulk
   refill scan, with 1:2 at the head, computes
   rounds = min(DIV_ROUND_UP(2, 256), DIV_ROUND_UP(746, 256)) = 1. That
   gives 1:2 = 768 and 1:1 = 1024, and B1 is dequeued.

In that state, a per-class variant would give 1:2 = 768 and 1:1 = 1536. It
would still visit 1:2 first and dequeue B1, so the matchJSON below would
still match.

The test only fails as intended when B1 is already sendable at A1's
release. Then the scan starts with 1:1 at the head and both classes at 512.

The ratio between that delta and softirq latency varies across bare metal,
KVM and TCG. Could netem 20 use a slightly shorter delay than netem 10? That
way B1 is always ready when child 10's watchdog fires.

> +            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip dport 1111 0xffff flowid 1:1",
> +            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip dport 2222 0xffff flowid 1:2",

[ ... ]

> +        "matchJSON": [
> +            {
> +                "class": "drr",
> +                "handle": "1:1",
> +                "root": true,
> +                "stats": {
> +                    "bytes": 0,
> +                    "packets": 0,
> +                    "backlog": 3028,
> +                    "qlen": 2
> +                }
> +            },
> +            {
> +                "class": "drr",
> +                "handle": "1:2",
> +                "root": true,
> +                "stats": {
> +                    "bytes": 514,
> +                    "packets": 1,
> +                    "backlog": 514,
> +                    "qlen": 1
> +                }
> +            }
> +        ],

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-TIAE.v1.20261008110502%40mojatatu.com
