Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2776B242D88
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481188; cv=none; b=EfOncavSF79ko1Pk/xLz0XHGrTjVpvvnHNQHi3tc5ne339gliu40mZ8LMaKlDA04Vr2hKWjL++ewr6GDeA7j8FyHYZiAG1pgnovZU/T3NM7JOYHsxQvLTynsIcmtGZkB3CyKvMyoAvSCCHYaPLIfiJOj1dyo2HSOv46XIo431R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481188; c=relaxed/simple;
	bh=S5b9cE6IVjRghJhOuf0gO1dXu0kaJRiR1Z2+j5tugOs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VpY32ao5IQuY3uGC9xZrJEMYzdIs9dgS6QgQq1Xk/WVqiLEhrORiz/nN3GoJjxBGLg66pWIiXvJyRdyvYxTyESjhp7JMeLIOAvpqc4zwcObEsjrj+aypZQC52FbMCtXPcsRx4rSaEIMzfPs9Q/6fgAEyxqaGNcZ/WRyXkBMIAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVbDT5j9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVbDT5j9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5361F00A3D;
	Fri,  4 Sep 2026 00:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788481186;
	bh=7sEXya2YhZwQMXDSQINK8GLZgaRQOxWcceBjGrE2VMw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cVbDT5j9xWPv5k8dglbb2YbcQqZn3OZpgThk/0lxx43ZZrGmeqEzbnswzX0yJvpEy
	 ZA9kmafte7hgXMQFfJAuCo34owZEkXJCprADI1TiRXX6NhbIi1B407J6UgWchcB+ni
	 YUuVp3DvitiSoh26Soh424tXKlqC3BcH3UltSEjTDB2IklXJdJR6SbLDkeAW1kAsep
	 NTS4lSjIWkufoRoXtQ+GTtBipLLrP1WiDZfndOIG144C6f2g44phqXVMNZ9GLAWqcv
	 7d9RaS+3K6PBndMZQ7SUxesEtKaDDZRUpzHAgS8tBn9AUoA/ymuaRbHLY99RwMTScP
	 wkm0SDmOVZ3Yg==
Subject: Re: [PATCH net-next v8 5/6] selftests: drv-net: in so_txtime tell
 apart sw from hw pacing
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com
Date: Fri, 04 Sep 2026 00:19:45 +0000
Message-ID: <178848118595.4131868.12345570677231457601@kernel.org>
In-Reply-To: <20260902181747.2483351-6-willemdebruijn.kernel@gmail.com>
References: <20260902181747.2483351-6-willemdebruijn.kernel@gmail.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Claim: the new '-H' mode (cfg_verify_hw_offload) added to
  tools/testing/selftests/drivers/net/so_txtime.c is dead code because…

--

selftests: drv-net: in so_txtime tell apart sw from hw pacing

This adds an optional '-H' mode to so_txtime.c that enables
SO_TIMESTAMPING with SOF_TIMESTAMPING_TX_SOFTWARE, measures the software
transmit delay reported on the error queue, and flags software pacing when
the delay is too large or timestamps are missing. It also extends the error
queue receive deadline by cfg_variance_us and reorders the getopt string
and usage text alphabetically.

No regressions to report on this one.

The one thing that came up during review was whether the new '-H' path is
reachable at this point in the series:

> diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
> index f6f3253ed174..9ebe9f91227c 100644
> --- a/tools/testing/selftests/drivers/net/so_txtime.c
> +++ b/tools/testing/selftests/drivers/net/so_txtime.c

[ ... ]

> @@ -251,12 +286,20 @@ static void recv_errqueue_msgs(int fdt)
> +	if (cfg_verify_hw_offload && num_ts != cfg_num_pkt) {
> +		fprintf(stderr, "missing timestamps: expected %d, got %d\n",
> +			cfg_num_pkt, num_ts);
> +		if (!cfg_machine_slow)
> +			errors++;
> +	}
>  }

[ ... ]

> @@ -488,21 +548,24 @@ static void parse_opts(int argc, char **argv)
> +		case 'H':
> +			cfg_verify_hw_offload = true;
> +			break;

Nothing in the tree passes '-H' as of this commit, so setsockopt_txtimestamping(),
do_recv_errqueue_timestamping() and the new "missing timestamps" check in
recv_errqueue_msgs() are not exercised yet. That is resolved later in the same
series: the following patch adds test_so_txtime_fq_mono_hw() and
test_so_txtime_pfifofast_mono_hw() to so_txtime.py, both of which pass '-H' in
args_tx and are registered in main()'s ksft_run() list, and args_tx is placed
before the payload operand in cmd_tx so getopt() picks the flag up. So no
action needed here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902181747.2483351-1-willemdebruijn.kernel%40gmail.com
