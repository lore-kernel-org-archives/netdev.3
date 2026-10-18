Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3993C09EE;
	Sun, 18 Oct 2026 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792350081; cv=none; b=BONEW6D0cfrh5Fb/31T1reYN9R6K5J7nkFC+xa5xTQWzt37qTwDAILpAFZrUzbCHoa5WFtDO2sJycqTUUI9r07hPvsNPz5oXncmCJxrv7tDegpRv2pi9ny1Ed6AodkvHZcJRQ5XU4Ey2br14v/oWsjyAY6sIPwtT9kW0m99U93w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792350081; c=relaxed/simple;
	bh=3CIO2HJLWXrH7r8jIWPmMCgbV7jrBfRDyzv+HKsH5sU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=npVLZss4OhDRjGGQKJy2109+KEXF7GHxd4Mp+VfNLFs4IYDvefcQIeGFf0MlNuEsnEQAYgQlaL+MBsmD6d5Wpp/uBbt7fGT0UoFVjH1OMgEdfSoOWXM7fyWWKS8n4bVR/t+BplIOo2Jpd4TSIRvIq6afxiaJ6iwB6FlgHEKyFIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh1ywyRk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh1ywyRk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750751F000C4;
	Sun, 18 Oct 2026 19:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792350079;
	bh=ZnREktjNHOLgpx05svV6/r/fQZfjWxSx5lslANF3cZE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oh1ywyRk/ajNvn8yE3rwD26+JnZkJMBtOr6gc0EsbgT030YtyYIZ4gsnULcpmJjuq
	 T3mwYw51L4hL7dUdwJLnBD+kYIrY60mEPzTtXFmKSs48bYy8LQFiyHfNF93VIn1tpG
	 1cqjJsi9AN9uM4JY5MbyAc9Mci69ZpHrQGiuDIwxTZ6QetKpakTBVy27P7Txpz4QYX
	 OqcQpAfx2xML1ojeRIHAwYIiG+GJN+a4Bsgy9AvndB+eppLSP2MA8A3klO8c0+eBXU
	 Yztjgffj6fn3DFAZMQEA/DV9T7nEW8rHmTCtp1+wCay/4mUKujW+v0R51FDOV3lLBI
	 0s8cm/wYWcx/g==
Subject: Re: [PATCH net-next v3 1/3] selftests: drv-net: Introduce a selftest
 for ethtool flow control
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 hkallweit1@gmail.com, corbet@lwn.net, skhan@linuxfoundation.org,
 o.rempel@pengutronix.de, vladimir.oltean@nxp.com, f.fainelli@gmail.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Sun, 18 Oct 2026 19:01:17 +0000
Message-ID: <179235007797.3135.5270356581388570027@kernel.org>
In-Reply-To: <20261015134350.629593-2-maxime.chevallier@bootlin.com>
References: <20261015134350.629593-2-maxime.chevallier@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 5 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tools/testing/selftests/drivers/net/hw/pause.py,
  expect_pauseparams_set() takes an `aneg` argument but only uses it to…
- [Medium] expect_pauseparams_set() decides acceptance by checking
  whether the 802.3 advertisement encoding of a request (Pause = rx,…
- [Medium] expect_pauseparams_set() checks the 'noop' case first (lines
  182-183): requested rx/tx/autoneg equals what `ethtool -a` reports.
- [Medium] pause_setup() queues restore commands with defer(cmd, ...),
  using cmd's default fail=True, whenever the GET succeeds.
- [Medium] pause_test_support() treats phylink fixed-links as having
  writable pause settings whenever their supported mask contains Pause…
- [Low] In this patch, pause_advertising_test's docstring (lines 327-328)
  says validation uses "the advertised modes locally, as well as what…
- [Low] pause_test_support's docstring (lines 262-264) says drivers must
  refuse unsupported pauseparams "with a -EOPNOTSUPP return value".
- [Low] pause_test_support() can return normally without making a single
  assertion, and is then reported as PASS.
- [Low] pause_setup()'s docstring says the starting conditions are
  "restored on exit".
- [Low] wait_for_aneg() with link_drop=False (the default, used by
  pause_advertising_test at line 348) waits a hard-coded 2 s for carrier…

--

selftests: drv-net: Introduce a selftest for ethtool flow control

This adds a pause.py driver selftest. It checks that the Pause and
Asym_Pause bits in the supported link modes match the rx/tx combinations
that "ethtool -A" accepts. It also checks that setting pause parameters
with autoneg on is reflected in the locally advertised pause modes.

> diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
> new file mode 100755
> index 0000000000000..854428e19f55f
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/pause.py
> @@ -0,0 +1,369 @@

[ ... ]

> +def wait_for_aneg(cfg, link_drop=False, timeout=15):
> +    """ Wait for a renegotiation to complete
> +
> +    :param link_drop: Set to true if the link HAS to flap.
> +    """
> +    try:
> +        wait_file(f"/sys/class/net/{cfg.ifname}/carrier",
> +                  lambda x: x.strip() == "0",
> +                  deadline=timeout if link_drop else 2)
> +    except TimeoutError:
> +        if link_drop:
> +            raise
> +
> +    wait_for_link(cfg, timeout)

[Severity: Low]
pause_advertising_test() calls this with link_drop=False. In that case the
carrier is only watched for 2 seconds and the TimeoutError is swallowed.

The PHY or firmware may report link loss later than that, for example
with polled phylib PHYs or firmware-managed links that report
asynchronously. Carrier then still reads the stale "1", and
wait_for_link() returns right away.

If so, is the "It must come back up" condition in pause_advertising_test()
actually verified? Could the next test case also start while
autonegotiation is still running, so a failure is blamed on the wrong
case?

[ ... ]

> +def expect_pauseparams_set(cfg, pauseparams, aneg, supported, note):
> +    """ ethtool -A must work or be refused depending on what the local
> +        device supports
> +    """
> +    rx = pauseparams["rx"]
> +    tx = pauseparams["tx"]
> +
> +    # Measure current pauseparams, re-setting the same params as the current
> +    # ones returns 0 even if unsupported.
> +    _, cur = get_local_pauseparams(cfg)
> +    noop = cur and (cur["rx"], cur["tx"], cur["autonegotiate"]) == \
> +           (bool(rx), bool(tx), aneg)
> +
> +    ret, _ = ethtool_ret(f"-A {cfg.ifname} rx {onoff(rx)} tx {onoff(tx)}"
> +                         f" autoneg {onoff(aneg)}", is_get = False)
> +
> +    if noop:
> +        ksft_eq(ret, 0, note)

[Severity: Medium]
Is the comment about re-setting the same parameters accurate for drivers
that implement get_pauseparam but not set_pauseparam?

The validate step runs before the no-op shortcut in ops->set:

net/ethtool/pause.c:ethnl_set_pause_validate() {
    ...
	return ops->get_pauseparam && ops->set_pauseparam ? 1 : -EOPNOTSUPP;
}

net/ethtool/netlink.c:ethnl_default_set_doit() {
    ...
		ret = ops->set_validate(req_info, info);
		/* 0 means nothing to do */
		if (ret <= 0)
			goto out_dev;
    ...
}

Take a get-only driver such as mlxbf_gige. It reports rx on, tx on and
autoneg off, and has no .set_pauseparam. The variant that matches its
current state gets noop=True, and then ksft_eq(EOPNOTSUPP, 0) fails.

The noop branch is also checked before "elif not supported". A get-only
driver with an empty supported mask fails here, even though the test's
own expectation for that case is EOPNOTSUPP.

Should the noop case only apply when the driver can actually set pause
parameters, or be checked after the "not supported" case?

> +    elif not supported:
> +        ksft_eq(ret, errno.EOPNOTSUPP, note)
> +    elif set(pauseparams["linkmodes"]).issubset(set(supported)):
> +        ksft_eq(ret, 0, note)

[Severity: Medium]
The aneg argument is only used to detect the no-op case. Here ret == 0 is
required whatever the pause autoneg request and the link autoneg state.

The struct ethtool_pauseparam documentation in
include/uapi/linux/ethtool.h says:

 * Drivers should reject a non-zero setting of @autoneg when
 * autoneogotiation is disabled (or not supported) for the link.

pause_test_support() calls this with aneg=True after forcing the link
with "autoneg off speed X duplex Y". Several in-tree drivers reject that,
as the uAPI documentation says they should:

  xgbe_set_pauseparam() returns -EINVAL when pause->autoneg is set and
  link autoneg is off.

  bnxt_set_pauseparam() returns -EINVAL when BNXT_AUTONEG_SPEED is clear.

Some drivers also reject combinations with link autoneg on:

  mlx5e_ethtool_set_pauseparam() always returns -EINVAL for pause
  autoneg, but always reports Pause as supported.

  i40e_set_pauseparam() returns -EOPNOTSUPP whenever pause->autoneg
  differs from the link autoneg state, so aneg=False with link autoneg on
  is rejected.

Won't these drivers be reported as failing pause_test_support()?

pause_advertising_test() has the same issue. It hardcodes aneg=True:

    ret = set_local_pauseparams(cfg, rx, tx, True)

and set_local_pauseparams() turns anything other than EOPNOTSUPP into a
hard failure:

    if ret != 0 and ret != errno.EOPNOTSUPP:
        raise KsftFailEx(f"ethtool -A {cfg.ifname} failed: {ret}")

On mlx5, the RX off/TX off and RX on/TX on variants would then fail with
"ethtool -A ... failed: 22".

The commit message describes only the Pause/Asym to rx/tx mapping. It
doesn't mention a requirement to support pause autoneg. The last commit
of the series says "Pause can't be negotiated if the link autoneg isn't
enabled", but expect_pauseparams_set() is still unchanged at the end of
the series.

Should the expected result take into account the requested pause autoneg
value and the link autoneg state?

> +    else:
> +        ksft_in(ret, (errno.EOPNOTSUPP, errno.EINVAL), note)

[Severity: Medium]
Does this match the rule phylink applies? This branch decides acceptance
by whether the 802.3 advertisement encoding of the request is a subset of
the supported bits. phylink_ethtool_set_pauseparam() checks something
different:

	if (!phylink_test(pl->supported, Pause) &&
	    !phylink_test(pl->supported, Asym_Pause))
		return -EOPNOTSUPP;

	if (!phylink_test(pl->supported, Asym_Pause) &&
	    pause->rx_pause != pause->tx_pause)
		return -EINVAL;

include/linux/phylink.h also documents:

 * If you set MAC_ASYM_PAUSE, the user may request any combination of
 * tx_pause and rx_pause. You do not have to support these
 * combinations.

Consider a phylink device whose supported set is only Asym_Pause
("Transmit-only"). The RX on/TX on (["Pause"]) and RX on/TX off
(["Pause", "Asym_Pause"]) variants are not subsets, so this branch
expects EOPNOTSUPP or EINVAL. phylink returns 0 for both.

I couldn't find an in-tree phylink MAC that implements set_pauseparam and
ends up with an Asym-only supported mask. macb uses MAC_ASYM_PAUSE without
MAC_SYM_PAUSE, but it has no pauseparam ops.

The pause_test_support() docstring cites phylink mac_capabilities as the
reference. Should the expectation follow phylink's rule?

> +
> +def pause_setup(cfg):
> +    """ The starting conditions every test counts on, restored on exit:
> +        - both ports admin up
> +        - link autoneg on on both sides ifsupported
> +        - carrier on
> +    """
> +
> +    # Get init pause parameters
> +    ret, params = ethtool_ret(f"-a {cfg.ifname}")
> +    if ret == 0:
> +        defer(cmd, f"ethtool -A {cfg.ifname} rx {onoff(params['rx'])} "
> +                   f"tx {onoff(params['tx'])} "
> +                   f"autoneg {onoff(params['autonegotiate'])}")
> +
> +    # Get init link parameters
> +    link = ethtool(f"{cfg.ifname}", json=True)[0]
> +    if "auto-negotiation" not in link:
> +        raise KsftSkipEx(f"{cfg.ifname} doesn't report its link modes")
> +
> +    if link["auto-negotiation"]:
> +        defer(cmd, f"ethtool -s {cfg.ifname} autoneg on")
> +    elif "speed" in link and "duplex" in link:
> +        defer(cmd, f"ethtool -s {cfg.ifname} autoneg off speed {link['speed']} "
> +                   f"duplex {link['duplex'].lower()}")

[Severity: Medium]
These restores are queued with cmd()'s default fail=True whenever the GET
succeeds, even if the device has no matching setter.

A restore to identical values still fails when the setter op is missing:

net/ethtool/linkmodes.c:ethnl_set_linkmodes_validate() {
    ...
	if (!ops->get_link_ksettings || !ops->set_link_ksettings)
		return -EOPNOTSUPP;
    ...
}

ethnl_set_pause_validate() does the same when set_pauseparam is missing.

The failing cmd() raises inside ksft_flush_defer(), which sets
KSFT_RESULT = False, and the case is reported as "not ok".

For example, iavf has get_link_ksettings, reports AUTONEG_DISABLE and has
no set_link_ksettings. Wouldn't every pause_test_support variant fail on
iavf, even when no assertion ran?

The remote side follows the same pattern. The remote "ethtool -A" restore
is deferred even though no test in this patch changes the remote pause
parameters. A remote that only has get_pauseparam would make every case
that reaches pause_setup() fail.

Could these restores be registered only when the setting is actually
changed, or not be treated as fatal?

> +
> +    # Local interface admin up, link aneg on
> +    ip(f"link set {cfg.ifname} up")
> +    if link["supports-auto-negotiation"] and not link["auto-negotiation"]:
> +        ethtool(f"-s {cfg.ifname} autoneg on")

[Severity: Low]
The docstring says the starting conditions are "restored on exit". Is the
admin state restored? No defer brings the interface back down if it
started admin-down. The remote "ip link set ... up" works the same way.

Autoneg is also turned on here whenever it is supported and currently
off. A restore was only registered above when the original state was
autoneg on, or autoneg off with both speed and duplex reported.

If the interface started with autoneg off and no speed/duplex (for
example with the link down), would autoneg be left on after the test? The
remote side has the same pattern.

[ ... ]

> +    The expectation is for drivers to refuse setting pauseparams that don't
> +    match the Pause and Asym_Pause bits in the supported linkmodes with a
> +    -EOPNOTSUPP return value. Unsupported pause params must be rejected.

[Severity: Low]
This isn't a bug, but the docstring requires -EOPNOTSUPP, while
expect_pauseparams_set() also accepts EINVAL:

        ksft_in(ret, (errno.EOPNOTSUPP, errno.EINVAL), note)

phylink_ethtool_set_pauseparam(), which this docstring refers to, also
returns -EINVAL for rx != tx when Asym_Pause is not supported. Could the
docstring mention EINVAL too?

[ ... ]

> +    pause_setup(cfg)
> +
> +    forced = forced_link_settings(cfg)
> +    _, supported = get_local_pause_supported(cfg)
> +
> +    # We check that what we can configure in the pause params matches what we
> +    # support under various contditions : Link aneg on/off, pause aneg on/off
> +    ret, _ = ethtool_ret(f"-s {cfg.ifname} autoneg on", is_get = False)
> +    if ret != 0:
> +        ksft_pr("link autoneg on refused, not tested")
> +    else:
> +        expect_pauseparams_set(cfg, pauseparams, False, supported,
> +                               "link autoneg on")
> +        expect_pauseparams_set(cfg, pauseparams, True, supported,
> +                               "link autoneg on")

[Severity: Medium]
How does this behave on a phylink fixed-link DUT?

phylink_parse_fixedlink() keeps the MAC pause capabilities in
pl->supported:

	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mask);
	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, mask);
	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, mask);
	linkmode_and(pl->supported, pl->supported, mask);

so ethtool reports pause as supported. However,
phylink_ethtool_set_pauseparam() refuses every change on fixed links:

	if (pl->req_link_an_mode == MLO_AN_FIXED)
		return -EOPNOTSUPP;

Re-applying the current link settings, either here or through the forced
"autoneg off speed X duplex Y" below, succeeds without reaching the
driver, because ethnl_set_linkmodes() returns early:

	if (!mod)
		return 0;

The test then reaches expect_pauseparams_set(). Every supported-subset
variant that differs from the current state expects 0 there, but gets
-EOPNOTSUPP.

The commit message presents phylink as the path that "deals with the
complexity". Would a phylink fixed-link interface be reported as a driver
bug here?

> +
> +    if not forced:
> +        ksft_pr("link speed unknown, the forced link is not tested")
> +        return
> +
> +    ret, _ = ethtool_ret(f"-s {cfg.ifname} autoneg off {forced}", is_get = False)
> +    if ret != 0:
> +        ksft_pr(f"link autoneg off {forced} refused, not tested")
> +        return

[Severity: Low]
Suppose "ethtool -s autoneg on" was refused above and one of these returns
is taken. The function then returns without running a single assertion.

ksft_run() counts a normal return without a failed ksft_* check as a pass,
and ksft_pr() doesn't mark a skip:

        if not cnt_key:
            cnt_key = 'pass' if KSFT_RESULT else 'fail'

If the device started with autoneg off and no speed/duplex, pause_setup()
registers no link restore, so a defer failure doesn't turn this into a
fail either.

Should this raise KsftSkipEx when neither configuration was exercised?

[ ... ]

> +    The validation is made by looking at the advertised modes locally, as well
> +    as what the peer's 'lp_advertising' values report.
> +    """

[Severity: Low]
The docstring mentions checking the peer's lp_advertising values. The body
of pause_advertising_test() in this patch only checks the local
advertised-pause-frame-use:

    _, linkmodes = get_local_pause_advertising(cfg)

The later commit in this series, "selftests: drv-net: pause: Validate the
pause autonegotiation with a partner", adds the
get_peer_pause_lp_advertising() check, so the docstring matches the code
by the end of the series. Could this sentence move to that patch?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015134350.629593-1-maxime.chevallier%40bootlin.com
