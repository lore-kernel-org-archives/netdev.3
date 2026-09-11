Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AAB4A5C4D
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146800; cv=none; b=bisCX1f3hTLsOwyklHYMe5dV5Q0AolosLSxFkENtHtVR7MYtoVjZoCTA36919R7GvByxqT2PiP4HEkgG0ytl+Hc/y/M01a2qsJCJR5QTGs05FAkNuCu00+DwBzKlhaGxIAYD3ZX+fGRQhfs4Vj1XvwQD06BzojmvIgxmoTmhQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146800; c=relaxed/simple;
	bh=Q0EARY4UzwL5dehYWqyD+K3wev0W857BNNYvS1+Nf7w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SVnmJALVFP0bYjAIO1NjYQ9A8UvDdG215VnieqQ45lSCtBpYvX9oRXsAYE1IsT7YpfgU8B2sJnS8SzWfXqBa87MIgMW63R6IKAZfR0B0meNNz1b0msjo4lxn4BlzZQOrAl8QHU+GEePG1Vd66Z/h2X2/Lv6LjKpM0zI4QgtOEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tqsy5EDP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqsy5EDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B1E1F00893;
	Fri, 11 Sep 2026 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146799;
	bh=8s8U70Kt3d3UOvVTcVdIf8BidwpjIldfFSixMc5skaA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tqsy5EDPo4XZrZZ271MOI0eAA/WvXVYD/CN1HG8/xGpNuffVSLoURXo9TF5kiftAo
	 NxyCoNvXV5f8ioV9txKM/7WLDb5W/+pAVLpyuabGC1EGhxKLNdvejR+PY1/gBkChWY
	 Y3bPTV8gDBdtcwvH3OGDbULvERTQegoiR3/79/sXnKc5vD62gtWMFJ0B3G1C6ntW3I
	 aZJtq3pW1KKK82j25s+JYFn7VM/UO3uP5sjy7CPNly3M1cfr3W+a+Uj8sPRhLz9hnQ
	 PhuYWxcNzSGJwouhogQqjABCaibsV633bzVMxKsBwpLveBWd1Jbxpm5otNdWqUPq8a
	 z3la4Zuc9u25w==
Subject: Re: [PATCH net-next v9 6/7] selftests: drv-net: in so_txtime tell
 apart sw from hw pacing
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com
Date: Fri, 11 Sep 2026 17:13:18 +0000
Message-ID: <178914679853.219967.10930030898097751336@kernel.org>
In-Reply-To: <20260910171131.2532487-7-willemdebruijn.kernel@gmail.com>
References: <20260910171131.2532487-7-willemdebruijn.kernel@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] `-H` is documented in usage() as 'verify hardware offload
  (tx)' and the commit message claims it tells software apart from…

--

selftests: drv-net: in so_txtime tell apart sw from hw pacing

This adds a '-H' flag to so_txtime.c that enables SO_TIMESTAMPING with
SOF_TIMESTAMPING_TX_SOFTWARE, and flags an error if the software transmit
timestamp is more than cfg_variance_us after the send start time.  It also
extends the errqueue polling deadline by cfg_variance_us and sorts the
getopt string and usage text alphabetically.

> diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
> index f6f3253ed1748..9ebe9f91227c7 100644
> --- a/tools/testing/selftests/drivers/net/so_txtime.c
> +++ b/tools/testing/selftests/drivers/net/so_txtime.c

[ ... ]

> @@ -191,12 +193,32 @@ static int do_recv_errqueue_txtime(struct sock_extended_err *err,
>  	return 1;
>  }
>  
> -static int do_recv_errqueue(int fdt)
> +static int do_recv_errqueue_timestamping(struct scm_timestamping *tss)
> +{
> +	int64_t ts;
> +
> +	ts = tss->ts[0].tv_sec * 1000ULL * 1000 * 1000;
> +	ts += tss->ts[0].tv_nsec;
> +	ts -= glob_tstart_real;
> +	ts /= 1000;
> +
> +	if (ts > cfg_variance_us) {
> +		fprintf(stderr, "sw delay %" PRId64 "us exceeds bounds\n", ts);
> +		if (!cfg_machine_slow)
> +			errors++;
> +	}
> +
> +	return 1;
> +}

[Severity: Medium]

Can this check actually tell software pacing apart from hardware pacing for
every workload the next patch runs with '-H'?

The only positive criterion here is that the software transmit timestamp
lands within cfg_variance_us (8000 us) of glob_tstart_real.  For a request
with no delay or a negative delay there is no pacing interval to observe at
all.  do_send_one() does not even attach SCM_TXTIME when delay_us is
negative:

	if (ts->delay_us >= 0) {
		...
		tdeliver = glob_tstart + ts->delay_us * 1000;
		...
		cm->cmsg_type = SCM_TXTIME;

So for the 'a,-1' and 'a,0' variants that the follow-up patch passes '-H'
to, ts comes out near 0 and the ts > cfg_variance_us test can never fire,
whether the transmit was hardware paced, software paced, or not paced at
all.  Would it make sense to skip or reject '-H' when the requested delay
is not positive, so those variants do not report a pass without having
verified anything?

For the 10 ms variants there are only 2 ms between the requested delay and
the 8 ms threshold.  Is that margin intentional?

A related question on cfg_variance_us: it is also the receiver side
delivery jitter tolerance used in do_recv_one():

	if (llabs(tstop - texpect) > cfg_variance_us) {
		fprintf(stderr, "exceeds variance (%d us)\n", cfg_variance_us);

Reusing it as the sender side software pacing threshold means changing one
tolerance silently changes the other.  Would a separate constant for the
sender side threshold be clearer?

[ ... ]

> @@ -446,10 +505,11 @@ static void usage(const char *progname)
>  			"  -6            only IPv6\n"
>  			"  -c <clock>    monotonic or tai (default)\n"
>  			"  -D <addr>     destination IP address (server)\n"
> -			"  -S <addr>     source IP address (client)\n"
> +			"  -H            verify hardware offload (tx)\n"

Given the above, is "verify hardware offload (tx)" an accurate description
of what the flag does?  The implemented behaviour is a heuristic on the
software transmit delay, and it degrades to a no-op for zero and negative
delays.  Would wording that describes the software delay check be closer to
the code?

> +			"  -m <mark>     socket mark\n"
>  			"  -r            run rx mode\n"
> +			"  -S <addr>     source IP address (client)\n"
>  			"  -t <nsec>     start time (UTC nanoseconds)\n"
> -			"  -m <mark>     socket mark\n"
>  			"\n",
>  			progname);
>  	exit(1);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910171131.2532487-1-willemdebruijn.kernel%40gmail.com
