Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954442;
	b=BE9rx9OLlK6/W9s/96HmuIxw0vOyqA9+sZ2PbEeiaCxg7JIb8loX+7fAJ7alNlNXfPU3
	 0rAGDwHI/LiNh9I8z1vrPIomYgjwPICtnsC8lTPkzISH65MEkDvFpguFd/9x8WAc3w29o
	 rOW38U3FeamGL18b91VZUHBfgb5KM6YxUC/9z+ioPNwhZmrxqRKfTYMjU7DjnidqReMWX
	 7dbZVg7TCVqp5hg1tHne8ygR8vOpk2G5iw0OXJ8/YdHRXfMH9my7tSyD/9wOHmcg8OT7O
	 Xe3zORcnfko7p8d4mi4ikOiKlZulG4YtnzqvJoxMfS45bHTY+0mB+noDuXAv3TW3UDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954442;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/55Dkn2zgwsP+rRdZdivaJ+Q4DO3a0dA94mr7obYiso=;
	b=ZZDG5EY0tFtl7oiYrp0zbtDw9j7QQfWtCPdVtdpjt52S4ViJiUypAoQiJ4C99arfrmtG
	 Np6fo8pbyWayGG0cblWc0t5opZb4zBHpuga/fNztPe/Njx41CVMY8bR+ziMUhsGrtNNC9
	 JpgmxTvjLMNTm2jcq4rO+KyLNLqeWwyglSBTYaAiC0NnoSzuRPnrGUwFT6vikPh0DYy+d
	 /anKjfKfUMcNTybiD8RiVYklJFu/5fai3UKfKUW1JxqLrZVT8cDCqpQVUgdCf45I+jTJx
	 6FDr1w41yiyYEXv8SSNvefr26XwgBNW8gmJUiPFlFiTdbaCkjTeRqSeGZNn91vWEo6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccTflIib;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF99606A326;
	Fri,  6 Nov 2026 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccTflIib
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74D41F0089F;
	Fri,  6 Nov 2026 08:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793954442;
	bh=/55Dkn2zgwsP+rRdZdivaJ+Q4DO3a0dA94mr7obYiso=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ccTflIibXrpGdVo7tJurhvDJ01Sq1lQfBhwS8mFsurogFtzNR91NFv2UlnJqYYZPS
	 Xx14iDYNyd1i6lH0WAPJ9lu6Vj6shM2lDcwtmZqV97dN4UB9neq8Jx4wm9zxnPm3Ds
	 ejE4+EdIWqz2NcZEEqGBiQhpYvp4/QJQqsB39A3C4qhF6ILqbtfpw7E7+Ex+IY7iNr
	 oJcko4KR9pkCLEBO5fWNlQD3NSZotNJy9cJPlTXPFFm2NuKXYlYhvxXlKyeL5Wsxga
	 sUC9Cl5+iAjmlFrn0vbm7DKvy+/lOO2YOKVxh+9RmShxdWhejFBt1mRjY/8YkJKIR/
	 hvgu4B/i/I7DQ==
Subject: Re: [PATCH] net/sched: reset sch_plug epoch state
From: netdev-bot+sashiko@kernel.org
To: shawnq1@163.com
Cc: jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Fri, 06 Nov 2026 08:40:41 +0000
Message-ID: <179395444115.994134.1488731096234208258@kernel.org>
In-Reply-To: <6AEA1C24.11E1A7.00008@m16.mail.163.com>
References: <6AEA1C24.11E1A7.00008@m16.mail.163.com>
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

- [Medium] plug_reset() (net/sched/sch_plug.c:205-215) always sets
  `q->unplug_indefinite = false` and `q->throttled = true`.
- [Low] The commit log is a bug-report email pasted in as-is: - It opens
  with 'Hello,'.

--

net/sched: reset sch_plug epoch state

This patch replaces sch_plug's reset callback, qdisc_reset_queue, with a
new plug_reset(). The new function purges the queue, clears the epoch
counters, clears unplug_indefinite and sets throttled. The aim is to stop
a stale pkts_last_epoch from being used as release credit by a later
TCQ_PLUG_RELEASE_ONE after a link reset.

> Hello,

[Severity: Low]
This isn't a bug, but the commit log looks like a bug report email pasted
in as-is. It opens with a salutation and carries reporter environment
metadata:

> HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
> Git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
> Source version: Linux 7.3
> Compiler:       gcc 11.4.0, GNU ld 2.38

It also has five external Gist URLs and a multi-step clone/build/run
script. None of this describes the change itself, and the external links
may not stay available.

Could the log be cut down to a self-contained description of the problem
and the fix?

The log also doesn't mention that plug_reset() now clears
unplug_indefinite and forces throttled to true, which users can see (see
below).

> diff --git a/net/sched/sch_plug.c b/net/sched/sch_plug.c
> index b60ddfee6a68a..def95e8243ba9 100644
> --- a/net/sched/sch_plug.c
> +++ b/net/sched/sch_plug.c
> @@ -202,6 +202,18 @@ static int plug_change(struct Qdisc *sch, struct nlattr *opt,
>  	return 0;
>  }
>  
> +static void plug_reset(struct Qdisc *sch)
> +{
> +	struct plug_sched_data *q = qdisc_priv(sch);
> +
> +	qdisc_reset_queue(sch);
> +	q->pkts_current_epoch = 0;
> +	q->pkts_last_epoch = 0;
> +	q->pkts_to_release = 0;
> +	q->unplug_indefinite = false;
> +	q->throttled = true;

[Severity: Medium]
Is it intended that plug_reset() also takes the qdisc out of pass-through
mode? Fixing the stale epoch credit described in the commit message only
needs the three counters cleared.

After TCQ_PLUG_RELEASE_INDEFINITE, plug_change() already zeroes every
counter:

	case TCQ_PLUG_RELEASE_INDEFINITE:
		q->unplug_indefinite = true;
		q->pkts_to_release = 0;
		q->pkts_last_epoch = 0;
		q->pkts_current_epoch = 0;
		q->throttled = false;

plug_enqueue() doesn't count packets while unplug_indefinite is set, so
release credit can't go stale in that mode. With the old
qdisc_reset_queue callback, pass-through mode survived a reset.

With this change, a reset on carrier loss goes through this path:

linkwatch_do_dev()
  dev_deactivate(dev, true)
    dev_deactivate_many()
      dev_reset_queue()
        qdisc_reset()
          plug_reset()

The same happens on ifdown/up or a parent qdisc reset. In each case the
qdisc is left throttled with unplug_indefinite cleared. dev_activate()
reattaches the same qdisc instance and doesn't restore these fields.

>From then on plug_dequeue() returns nothing:

	if (q->throttled)
		return NULL;

plug_enqueue() counts new packets into pkts_current_epoch and buffers
them up to q->limit. After that, qdisc_drop() tail-drops the rest.

Doesn't this contradict the uAPI comment in
include/uapi/linux/pkt_sched.h?

	 * TCQ_PLUG_RELEASE_INDEFINITE: Dequeue all packets from queue.
	 *   Stop buffering packets until the next TCQ_PLUG_BUFFER
	 *   command is received (just act as a pass-thru queue).

If the controller has only ever used TCQ_PLUG_RELEASE_INDEFINITE, or has
exited, would egress traffic stay stalled after a link flap until another
release command is sent?

Would it work to leave unplug_indefinite unchanged and set
q->throttled = !q->unplug_indefinite, or to leave both fields alone?
plug_dequeue() already re-throttles on its own when pkts_to_release is 0.

The reproducer described in the commit message only exercises
TCQ_PLUG_RELEASE_ONE epoch mode, so it wouldn't catch this.

> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/6AEA1C24.11E1A7.00008%40m16.mail.163.com
