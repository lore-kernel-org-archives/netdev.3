Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C4924E4B5
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481189; cv=none; b=T/JU0OIdZBJoTc9+neSgh11uVRFiPv0kBPHEQOEHnmSsh0moXjtiF2YD8wiSN9o4diX6lXZkgc87GujDFP+ti/qc6WYTOW/50+UbeUXKk1xp2sAlN7lK2x2HCSg4lliF50si7uJD7pJqpzBgcM4LM3w6O99X6XMaqugTVrmkQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481189; c=relaxed/simple;
	bh=y4pmH8VRjq90/3aIRaSXvIpEXbIE7V2sFJTyXn46LF8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pST+HJsqjf/oTxwSF+j3WdSI+SmEP0jHK9HJaYF5z0wVVxdBPKvwA9rdEKG0y8T0xzeSFFGrMjDQbYFaDgE3Xeqqd661ZEklYlycd3BknhbddUf0QI+TlOkzm9pVCgKU9uN6+/UYk5gnPFztlUglYBOOC1s2/xVCrI4vKrLLP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs/CRAyj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs/CRAyj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6225A1F000E9;
	Fri,  4 Sep 2026 00:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788481187;
	bh=cYi+rzX09ADm2TgPPu/7jWwqOh0lEF/ZplUYYi4x0Hk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Fs/CRAyjy0IY04QSFjrpSCNCRn+ZjwRd3JsVg8BlsQk1pcoqGVAR930SZV794wqJP
	 swtDNn3k5dxFTJp0q4bKDGsTbqzRmJC9km4AYLWeYoXgICgJqb9IeFwElPJneyrxMj
	 F9/Qnv9vKnbYaEP7xY+v2fnd9s13jONHQ+XU5k21cKwP0C031ZdAGSO0gMcIo0c5dK
	 jUq496v3Orbydwzv2kCjflkZv00mOQaiMMFmH4tU5FkruOF67xLQl62gCqjc7VRzXg
	 bQy1fuvroyc/wxjHalzHbFa/VxGGS3hOiKADKm6xFva78XGnJt6C3pXqQAkktaR1LO
	 nHdaeSl4WLX0w==
Subject: Re: [PATCH net-next v8 6/6] selftests: drv-net: extend so_txtime with
 hw offload
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com
Date: Fri, 04 Sep 2026 00:19:46 +0000
Message-ID: <178848118698.4131868.7314407935459883328@kernel.org>
In-Reply-To: <20260902181747.2483351-7-willemdebruijn.kernel@gmail.com>
References: <20260902181747.2483351-7-willemdebruijn.kernel@gmail.com>
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

- [Medium] In `test_so_txtime()`
  (tools/testing/selftests/drivers/net/so_txtime.py:34-37) the patch…

--

selftests: drv-net: extend so_txtime with hw offload

Adds two new so_txtime.py variants that exercise EDT pacing offload, one
on top of fq with offload_horizon and one on top of pfifo_fast, together
with a new beyond_hw_horizon testcase. Also raises the receiver socket
timeout to 600ms and makes the final emptiness check non-blocking.

> diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
> index a097fae0b335..873d5fd6a8eb 100755
> --- a/tools/testing/selftests/drivers/net/so_txtime.py
> +++ b/tools/testing/selftests/drivers/net/so_txtime.py

[ ... ]

> @@ -33,12 +34,41 @@ def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
>      expect_fail = not expect_success
>      if slow_machine:
>          expect_success = False
> +        expect_fail = None
>  
>      with bkg(cmd_rx, host=cfg.remote, fail=expect_success,
>               expect_fail=expect_fail, exit_wait=True):
>          cmd(cmd_tx)

[Severity: Medium]

Is this new expect_fail = None intended to apply to every caller of
test_so_txtime(), or only to the new pfifo_fast beyond_hw_horizon case?

With slow_machine set, both fail and expect_fail become falsy, and
cmd.process() in tools/testing/selftests/net/lib/py/utils.py then takes
neither branch:

    # Fail on unexpected test failure if fail.
    # Fail on unexpected test success if expect_fail.
    # Fail on negative returncode if either:
    # Set by subprocess on crash or signal, this is never expected failure.
    if (self.proc.returncode != 0 and fail or
        (self.proc.returncode < 0 and expect_fail)):
        ...
        raise CmdExitFailure("Command failed", self)
    elif self.proc.returncode == 0 and expect_fail:
        raise CmdExitZeroFailure("Command succeeded (expected fail)", self)

So the remote receiver's exit status is not checked at all, including the
negative returncode from a crash or signal that the comment above says is
never an expected failure.

Does this silently drop the only assertion the pre-existing ETF negative
variants have? test_so_txtime_etf() passes expect_fail through for:

    ["no_delay", "a,-1", "a,-1", False],
    ["zero_delay", "a,0", "a,0", False],

Those failures are deterministic rather than timing related: sch_etf drops
the packet in is_packet_valid(), and the receiver then hits the
error(1, EAGAIN, "recv: timeout") path in do_recv_one(), which is not
guarded by cfg_machine_slow. Previously expect_success was cleared but
expect_fail stayed True, so a receiver that unexpectedly succeeded was
still reported. Would clearing expect_fail per-variant, or only for the
new hw variants, keep that coverage?

> +@ksft_variants(_test_variants_fq())
> +def test_so_txtime_fq_mono_hw(cfg, ipver, args_tx, args_rx):
> +    """Run all variants of monotonic fq tests, with offload horizon."""
> +    cfg.require_ipver(ipver)
> +    cfg.require_nsim(nsim_test=False)
> +
> +    _dev_setup_pacing_offload(cfg)
> +    try:
> +        _qdisc_setup(cfg.ifname, "fq", f"offload_horizon {_HW_OFFLOAD_HORIZON_MS}ms")
> +    except Exception as e:
> +        raise KsftSkipEx("netdev does not support offload. skipping") from e
> +
> +    # Expect all tests to use only hw pacing, except beyond_hw_horizon.
> +    # Do not pass -H to that test so that with sw pacing fallback it passes.
> +    hw_only = "-H" if args_tx != "a,70" else ""
> +    test_so_txtime(cfg, "mono", ipver, f"{hw_only} {args_tx}", args_rx, True)
> +
> +
> +@ksft_variants(_test_variants_fq())
> +def test_so_txtime_pfifofast_mono_hw(cfg, ipver, args_tx, args_rx):
> +    """Run all variants of monotonic tests, without fq pacing sw backup."""
> +    cfg.require_ipver(ipver)
> +    cfg.require_nsim(nsim_test=False)
> +
> +    _dev_setup_pacing_offload(cfg)
> +    _qdisc_setup(cfg.ifname, "pfifo_fast")
> +
> +    # Expect all tests to pass, except beyond_hw_horizon without sw fallback.
> +    # It will send immediately, failing the receiver arrival bounds check.
> +    expect_pass = args_tx != "a,70"
> +    test_so_txtime(cfg, "mono", ipver, f"-H {args_tx}", args_rx, expect_pass)

On the positive side of these new tests, do they still verify anything on
a KSFT_MACHINE_SLOW run? Both checks the -H flag relies on skip the error
count when cfg_machine_slow is set:

tools/testing/selftests/drivers/net/so_txtime.c:do_recv_one() {
	if (llabs(tstop - texpect) > cfg_variance_us) {
		fprintf(stderr, "exceeds variance (%d us)\n", cfg_variance_us);
		if (!cfg_machine_slow)
			errors++;
	}
}

tools/testing/selftests/drivers/net/so_txtime.c:recv_errqueue_msgs() {
	if (cfg_verify_hw_offload && num_ts != cfg_num_pkt) {
		fprintf(stderr, "missing timestamps: expected %d, got %d\n",
			cfg_num_pkt, num_ts);
		if (!cfg_machine_slow)
			errors++;
	}
}

Combined with expect_fail = None, would test_so_txtime_fq_mono_hw and
test_so_txtime_pfifofast_mono_hw report pass on such a machine even if the
device performs no EDT pacing at all?

One more note: the reason for relaxing the expectation (the timing
sensitive pfifo_fast beyond_hw_horizon case) appears only in the changelog
below the --- line. Could that rationale move into the commit message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902181747.2483351-1-willemdebruijn.kernel%40gmail.com
