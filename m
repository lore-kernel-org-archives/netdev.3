Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C724A5EB3
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146802; cv=none; b=s8O8LbAPvsXcxWBMKISBCmKaT5At1qkMdCmUkxtiSLf5+Z0dsW2sdVB6vUbYvFCVwciqsNK6xSiwCITwal438oNski9tp9g+nUxW6Sn7qjvIQ8Uhf1fPheqC2IR6Inia6C8CwLHkM9s3zfXqWaL7DMIzcYXHVSgd1JVsIOKxB0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146802; c=relaxed/simple;
	bh=2nr5ER1+UurrG6DCq58oP9UZH1Vqtz2hHuxXUzFuAGw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cQMRGkisLRZkEaJPmPImh/vmLn04+yxH6r/deOdU37+tdpjeLAVbcewt6R6rkCV0umMbU2t/q3roJ3BTLxnFAbzWlgnojY1REAWsjPj02qmDY01ESq3E3DDPFhc0LsRV2OSuIKmFQWpjT/eeyEaZdt+rm/4LacRTvw4uhxJjd64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEGNVUrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEGNVUrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD451F00898;
	Fri, 11 Sep 2026 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146800;
	bh=wzlo1cX2PE9lclwc8HGe1RMaGNw8gtx1QsomjoNeCq0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aEGNVUrfMiJo/L7XzPsdBXYAs4ItaTDiFfl1isk+vFE6mPKd6xY/sfEsPUWoF+6ee
	 Hkg7FXK+egarqPpYhpS/juTOyVGHDqLMUeoOADcLXv/tdYvJhOoeGXpzHeJcXT91hS
	 6vkEieEqnW209yZ72uTtHLLqmJ/XYVsMkrqucBQW2q7FUGRY16ZHFiBMr/9ToE8pot
	 F0H27hOqntqrlYegm001JVQYO8dJC8iA0X2KaW4uYlYTQjVfkc80zEVU5XvNxZ4RcS
	 sFdmVyC+Rb2gop743F/vnu2GAHIyBkH/iSamkokqu0syJ/DyZKmDmaDbA/0+lbOmN+
	 +qsraA5MKhGTg==
Subject: Re: [PATCH net-next v9 7/7] selftests: drv-net: extend so_txtime with
 hw offload
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com
Date: Fri, 11 Sep 2026 17:13:19 +0000
Message-ID: <178914679956.219967.16464715915916154727@kernel.org>
In-Reply-To: <20260910171131.2532487-8-willemdebruijn.kernel@gmail.com>
References: <20260910171131.2532487-8-willemdebruijn.kernel@gmail.com>
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

- [Medium] The new `beyond_hw_horizon` variant hard-codes a 70ms txtime,
  but `_dev_setup_pacing_offload()`…

--

selftests: drv-net: extend so_txtime with hw offload

Adds two hardware pacing offload variants of the so_txtime driver test, one
on fq with an offload_horizon and one on pfifo_fast, plus a new
beyond_hw_horizon testcase with a 70ms txtime. Also raises the receive
timeout and switches the final empty-queue check to MSG_DONTWAIT.

> diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
> index a097fae0b335a..66a87205e02db 100755
> --- a/tools/testing/selftests/drivers/net/so_txtime.py
> +++ b/tools/testing/selftests/drivers/net/so_txtime.py

[ ... ]

> @@ -33,12 +35,42 @@ def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
>      expect_fail = not expect_success
>      if slow_machine:
>          expect_success = False
> +        if timing_sensitive:
> +            expect_fail = None
>  
>      with bkg(cmd_rx, host=cfg.remote, fail=expect_success,
>               expect_fail=expect_fail, exit_wait=True):
>          cmd(cmd_tx)
>  
>  
> +def _dev_setup_pacing_offload(cfg):
> +    """Configure pacing-offload."""
> +    rtnl = RtnlFamily()
> +
> +    try:
> +        link = rtnl.getlink({'ifi-index': cfg.ifindex})
> +    except NlError as e:
> +        raise KsftSkipEx('getlink not supported by device') from e
> +
> +    if 'pacing-offload' not in link or \
> +       'max-pacing-offload-horizon' not in link:
> +        raise KsftSkipEx('pacing offload not supported by device')
> +
> +    horizon = _HW_OFFLOAD_HORIZON_MS * 1000_000
> +    if link['max-pacing-offload-horizon'] < horizon:
> +        raise KsftSkipEx('pacing offload max horizon too small')
> +
> +    cur_offload = link['pacing-offload']
> +    rtnl.setlink({
> +        'ifi-index': cfg.ifindex,
> +        'pacing-offload': 1,
> +    })
> +    defer(rtnl.setlink, {
> +        'ifi-index': cfg.ifindex,
> +        'pacing-offload': cur_offload
> +    })
> +
> +
>  def _qdisc_setup(ifname, qdisc, optargs=""):

[ ... ]

> @@ -61,6 +93,7 @@ def _test_variants_fq():
>              ["one_pkt", "a,10", "a,10"],
>              ["in_order", "a,10,b,20", "a,10,b,20"],
>              ["reverse_order", "a,20,b,10", "b,10,a,20"],
> +            ["beyond_hw_horizon", "a,70", "a,70"],
>          ]:
>              name = f"v{ipver}_{testcase[0]}"
>              yield KsftNamedVariant(name, ipver, testcase[1], testcase[2])
> @@ -74,6 +107,41 @@ def test_so_txtime_fq_mono(cfg, ipver, args_tx, args_rx):
>      test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, True)
>  
>  
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
> +    timing_sensitive = not expect_pass
> +    test_so_txtime(cfg, "mono", ipver, f"-H {args_tx}", args_rx, expect_pass,
> +                   timing_sensitive=timing_sensitive)

[Severity: Medium]
Is the beyond_hw_horizon expectation guaranteed on all devices that pass the
capability gate in _dev_setup_pacing_offload()?

That helper only checks a lower bound on the device horizon:

    horizon = _HW_OFFLOAD_HORIZON_MS * 1000_000
    if link['max-pacing-offload-horizon'] < horizon:
        raise KsftSkipEx('pacing offload max horizon too small')

so a device advertising, say, 100ms or more is accepted. In
test_so_txtime_pfifofast_mono_hw() the root qdisc is pfifo_fast, so there is
no qdisc offload_horizon gate and the immediate-send decision is left to the
driver's own horizon check, for example in idpf_tx_splitq_set_txtime():

    /* beyond offload horizon? set overflow bit only */
    if (ts > now + horizon) {
            tx_params->offload.desc_ts[2] =
                    IDPF_TXD_FLOW_SCH_HORIZON_OVERFLOW_M;

On a device whose reported max-pacing-offload-horizon covers 70ms, the packet
is paced in hardware, arrives on time, the receiver exits 0, and with
expect_fail set by:

    expect_pass = args_tx != "a,70"

cmd.process() in tools/testing/selftests/net/lib/py/utils.py turns that into
a failure:

    elif self.proc.returncode == 0 and expect_fail:
        raise CmdExitZeroFailure("Command succeeded (expected fail)", self)

The timing_sensitive escape only clears expect_fail under
KSFT_MACHINE_SLOW, so on a normal machine the failure is unconditional.
Would it make sense for _dev_setup_pacing_offload() to also skip when
max-pacing-offload-horizon is at or above the 70ms txtime used by
beyond_hw_horizon?

Related, in test_so_txtime_fq_mono_hw() the same case drops the -H flag:

    hw_only = "-H" if args_tx != "a,70" else ""

If fq incorrectly handed the 70ms packet to hardware and the device horizon
covers 70ms, the packet still arrives on time and the subtest passes, so is
the intended 50ms fq offload_horizon boundary actually asserted here?

The commit message states this as a fact:

    The pfifo_fast beyond_hw_horizon testcase expects a failure because
    the packet exceeds the hardware horizon and is transmitted immediately,

which appears to hold only when the device horizon is between 50ms and 70ms.
Could that constraint be spelled out, or enforced in the capability check?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910171131.2532487-1-willemdebruijn.kernel%40gmail.com
