Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45A21FF2A;
	Mon, 12 Oct 2026 00:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791763329; cv=none; b=Nvlh+iwh2Ie23GVH6s0DgfMD/3f8RILUjAGEElQS48j8DThAmfvQ4g8GCWMbOGQUYplvMVRVChnjJvaml8OSbCRfzkpUsSdZFC5wBYOISE2iVFKHKuGh24KJIiS2QEcZTVGqyoer2KPA5LcjQj8O1M2zNtMrn1r2p6z0qcQXpa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791763329; c=relaxed/simple;
	bh=q7xHYe+k0mPe1R+mJYS433as71ocv2X4aSPPcqnLYvI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2HhorM0iec6j/fFWw93RRwLjAzXjdISNdrmiPGKpRx9TgBww0KS1h9cwuVHYN3vNlAv9dRgTCFpdI8nRuOG7pTzokr/4f6o9jkMKrbu+FXgFvEnGEcKbTQD6vH/kf7q07IfiLjdOt/jlWDzv+Vtr/6I/AqJLJ5dWvnsTlQzTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqFLIEAE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqFLIEAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7A41F0089C;
	Mon, 12 Oct 2026 00:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791763327;
	bh=UOBLYemmNMySix3BY2EnTEqYJu43hmHq/DXqqMBM8PE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lqFLIEAEHlPW4cfy1h+9Kf9T4Z10wWPgq2PVKAzXmqJ/RFOQP2VuYM4FmH/99GOYW
	 aHjALvaU0lZUx1D9ZdwGPkS92L7ZHxWpS/QegI68SuVDDotExHIFSoY/RSLHHak4dJ
	 lO/0RKs60cP5sDWxYw/YvCZ6qUMdNaV6itD6uS0r5xdpG+XjvaPkDv0I34eKSvEGYh
	 c091zi9moFHz+Z6eyMhXYQ9eAR8LMYsX239Ldi9W8trsCYQTUs8L8RWpkJuXJTqkmf
	 kViIyINhffiNztV3/BEk2RBdbMw25goa+UxvIqUkZCOX/ljYICiYYnCeaPZrrOcwQA
	 93exXXblq0X1Q==
Subject:
 Re: [PATCH net v2 3/3] ptp: qoriq: fix support for PTP_EXTTS_REQUEST2 ioctl
From: netdev-bot+sashiko@kernel.org
To: vjardin@free.fr
Cc: yangbo.lu@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, jacob.e.keller@intel.com, kory.maincent@bootlin.com,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, ioana.ciornei@nxp.com
Date: Mon, 12 Oct 2026 00:02:05 +0000
Message-ID: <179176332574.434549.17881202126873427960@kernel.org>
In-Reply-To:
 <20261009-for-upstream-qoriq-ptp-extts-flags-v2-3-0f4eeff2295d@free.fr>
References:
 <20261009-for-upstream-qoriq-ptp-extts-flags-v2-3-0f4eeff2295d@free.fr>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says that making the legacy
  PTP_EXTTS_REQUEST ioctl strict "cannot be avoided", because the core…

--

ptp: qoriq: fix support for PTP_EXTTS_REQUEST2 ioctl

This patch sets .supported_extts_flags in ptp_qoriq_caps to
PTP_RISING_EDGE | PTP_STRICT_FLAGS, so that the PTP core stops rejecting
every PTP_EXTTS_REQUEST2 request. Because of this, the legacy
PTP_EXTTS_REQUEST ioctl now also rejects falling-edge and both-edge
requests.

> This also makes the legacy PTP_EXTTS_REQUEST ioctl strict: a request for
> the falling edge, or for both edges, now fails with -EOPNOTSUPP instead
> of being timestamped on the rising edge. That cannot be avoided: the core
> adds PTP_STRICT_FLAGS to every PTP_EXTTS_REQUEST2 request, so a driver
> has to declare it to accept them, and once declared it applies to both
> ioctls.

> diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
> index 76272e5ac5b85..bcd29104effe7 100644
> --- a/drivers/ptp/ptp_qoriq.c
> +++ b/drivers/ptp/ptp_qoriq.c
> @@ -355,6 +355,7 @@ static const struct ptp_clock_info ptp_qoriq_caps = {
>  	.n_per_out	= 0,
>  	.n_pins		= 0,
>  	.pps		= 1,
> +	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,

[Severity: Medium]
Is the "cannot be avoided" part of the commit message accurate?

In ptp_extts_request() in drivers/ptp/ptp_chardev.c, the strict bit is
only added for PTP_EXTTS_REQUEST2. For the legacy ioctl it is always
removed by the mask:

drivers/ptp/ptp_chardev.c:ptp_extts_request() {
    ...
	if (cmd == PTP_EXTTS_REQUEST2) {
		/* Tell the drivers to check the flags carefully. */
		req.extts.flags |= PTP_STRICT_FLAGS;
    ...
	} else {
		req.extts.flags &= PTP_EXTTS_V1_VALID_FLAGS;
    ...
}

PTP_EXTTS_V1_VALID_FLAGS contains only ENABLE, RISING and FALLING. The
.enable callback can therefore tell the two ioctls apart by checking
PTP_STRICT_FLAGS in rq->extts.flags.

Drivers in the tree already do this. mv88e6xxx declares
RISING | FALLING | STRICT and rejects the unsupported edge combination
only for strict requests:

drivers/net/dsa/mv88e6xxx/ptp.c:mv88e6352_ptp_enable_extts() {
    ...
	if ((rq->extts.flags & PTP_STRICT_FLAGS) &&
	    (rq->extts.flags & PTP_ENABLE_FEATURE) &&
	    (rq->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
		return -EOPNOTSUPP;
    ...
}

sja1105 does something similar in sja1105_ptp.c.

Could qoriq do the same? It would declare PTP_RISING_EDGE |
PTP_FALLING_EDGE | PTP_STRICT_FLAGS in ptp_qoriq_caps. Then
ptp_qoriq_enable() would return -EOPNOTSUPP when STRICT, ENABLE and
FALLING are all set. That fixes PTP_EXTTS_REQUEST2 and leaves the legacy
ioctl lenient. enetc_ptp.c also uses ptp_qoriq_enable(), so the same
check would cover enetc.

As written, with the Fixes: tag, this is going to stable. Legacy
PTP_EXTTS_REQUEST calls on QorIQ timers that ask for the falling edge or
for both edges now fail with -EOPNOTSUPP. Before this patch they
succeeded and were timestamped on the rising edge. Commit 7c571ac57d9d
calls the legacy edge flags hints that are not expected to be enforced.

testptp hits this path. Running it with -e and -E 2 or -E 3 sends
PTP_EXTTS_REQUEST with PTP_FALLING_EDGE set.

If the stricter legacy behaviour is intended, could the commit message
say that a lenient alternative exists, rather than saying the change
cannot be avoided?

>  	.adjfine	= ptp_qoriq_adjfine,
>  	.adjtime	= ptp_qoriq_adjtime,
>  	.gettime64	= ptp_qoriq_gettime,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-for-upstream-qoriq-ptp-extts-flags-v2-0-0f4eeff2295d%40free.fr
