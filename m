Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6079639184B;
	Tue, 29 Sep 2026 03:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790652402; cv=none; b=DDTnUAeup/SLRer35+EMew86vX10X4H6Lc0/MTUGAPOLCuaGqQfrdUzM1AXTBtLlCm94XFm44OKvFraPSH8PWQN4fe5eEwn/meoialW3nwgYEiim7fu+HKv9Q1UM6ZNYgJMPI0+0dlRCBX/9FkoCyhysTixwVxxU42dr3hntgOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790652402; c=relaxed/simple;
	bh=sc+6dFfIMqC+5kYwvwBCRtXe7Uq65P2fUPcsdqQKOhk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sb98whGvXRIw3kGKv11xxMXf1OE0HQkkz/48HKEUVVWYQyIXAMVTdSXbIbXJy9acowry3oxDqA4OLDaLAhwbFXdvF1vfvan8psB0r8wf1nzRkIehXLsyMYEVEt7xkUp1Sw7fa7/kwSDjaM1M5xHkj5mXZff4zHng+RVOA2DNyZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cerLbt4x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cerLbt4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021ED1F000FF;
	Tue, 29 Sep 2026 03:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790652400;
	bh=rWWb5yESNkPNmpbyreOYnKIR9p9QninZFRzLn3r1s9k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cerLbt4xaIaIspiEjTQ8CBOmUu8ztqegLpNX6pXchR+ts2gFWfJwT0wq3rkox+8L8
	 W0aQS5sa1HSkuaBQlGd4WijwUyb8keiL6Fma4wEkt77Wojf+uD4QshgEGHcE3wIybF
	 hGjJ8Ff5vxuGtFNW7aRJ3NlkZlKbjSEENUbLLTB3KEs9cb8EBdu8atXZ7ErIlOf/5s
	 SdhuueXTrShZl4Zf2uUEvkEzgQ1FrLge1LdeNFnWIMGhLsMX+sUmSRKmfhwbvjWyNS
	 30Z67XmAWsvPlVHN32i/ZktV7U2IC7bSyk8CgH+S/2AIUF5BJ2+SwmYd6hqMDm1R3k
	 7zke0KNCbu/AA==
Subject: Re: [PATCH net-next v2 1/3] selftests: drv-net: Introduce a selftest
 for ethtool flow control
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 hkallweit1@gmail.com, corbet@lwn.net, skhan@linuxfoundation.org,
 o.rempel@pengutronix.de, vladimir.oltean@nxp.com, f.fainelli@gmail.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Tue, 29 Sep 2026 03:26:38 +0000
Message-ID: <179065239849.434549.14198730559380952270@kernel.org>
In-Reply-To: <20260925182628.214667-2-maxime.chevallier@bootlin.com>
References: <20260925182628.214667-2-maxime.chevallier@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 12 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 6 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The accept/reject rule in expect_pauseparams_set()
  (tools/testing/selftests/drivers/net/hw/pause.py) does not match…
- [Medium] The docstrings of set_local_pauseparams() (pause.py:154) and
  get_local_pauseparams() (pause.py:169) say 'Raise an error if the…
- [Medium] When the device supports no pause modes,
  expect_pauseparams_set() requires every 'ethtool -A' to return…
- [Medium] pause_setup() changes link autoneg without always registering
  a restore.
- [Medium] pause_test_support() uses expect_pauseparams_set() to require
  that 'ethtool -A' returns 0 for every rx/tx pair covered by the…
- [Medium] The defer queue is LIFO (ksft_flush_defer() pops from the end,
  ksft.py:233).
- [Low] In this patch, pause_advertising_test() only checks the local
  'advertised-pause-frame-use'.
- [Low] The pause_test_support() docstring says drivers are expected to
  refuse unsupported pauseparams 'with a -EOPNOTSUPP return value'.
- [Low] Two timing comments don't match the code.
- [Low] pause_setup() and
  get_local_pause_supported()/get_local_pause_advertising() index the…
- [Low] pause_test_support() can report PASS without running a single
  pause-parameter assertion.
- [Low] main() assigns cfg.ethnl = EthtoolFamily().

--

selftests: drv-net: Introduce a selftest for ethtool flow control

This commit adds a new drv-net hardware selftest, pause.py. The test checks
that the Pause/Asym_Pause bits in a device's supported link modes match the
rx/tx combinations that "ethtool -A" accepts, with link autoneg on and with
the link forced. It also checks that the locally advertised pause modes
follow the configured pause parameters.

> diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
> new file mode 100755
> index 0000000000000..f07db32715003
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/pause.py
> @@ -0,0 +1,411 @@

[ ... ]

> +def wait_for_aneg(cfg, link_drop=False, timeout=15):
> +    """ Wait for a renegotiation to complete.
> +
> +    :param link_drop: Set to true if the link HAS to flap.
> +    :returns: True if link is UP, False if timeout
> +    """
> +    deadline = time.monotonic() + timeout
> +
> +    # Link has 2 seconds to come back up
> +    restart_by = time.monotonic() + 2

[ ... ]

> +def wait_for_link(cfg):
> +    """ Wait for both ends of the link to be up """
> +    if not wait_for_link_local(cfg):
> +        return False
> +
> +    # Local link is UP, we shouldn't have to wait for a whole 8 seconds for
> +    # the remote to report link up, let's wait a bit less
> +    return wait_for_link_remote(cfg, timeout = 3)

[Severity: Low]
This isn't a bug, but do these two timing comments match the code?

wait_for_link_local() and wait_for_link_remote() default to a 15 second
timeout, and this call lowers it to 3 seconds. No 8 second value appears
anywhere.

In wait_for_aneg(), restart_by is the window in which the link is expected
to drop when link_drop is False. The time allowed for the link to come back
up is set by wait_for_link().

[ ... ]

> +def get_local_pause_supported(cfg):
> +    """ Return the errcode and the local pause supported linkmodes """
> +
> +    ret, data = ethtool_ret(f"{cfg.ifname}")
> +    if ret != 0:
> +        raise KsftFailEx(f"ethtool {cfg.ifname} failed: {ret}")
> +
> +    return ret, _ethtool_pause_use_to_linkmodes(data["supported-pause-frame-use"])

[Severity: Low]
What happens here on a device without get_link_ksettings?

ethtool only prints "supported-pause-frame-use", "advertised-pause-frame-use",
"auto-negotiation" and "supports-auto-negotiation" when the link modes reply
succeeds. Plain "ethtool <dev>" still exits 0 when other replies, such as
link-detected, are present.

In that case this line raises an uncaught KeyError. ksft_run() reports that
as a failure with a traceback, not as a skip.

require_pause_supported_allof() calls this function before any capability
check. pause_setup() also indexes link["auto-negotiation"] and
link["supports-auto-negotiation"] directly, for both the local and the
remote interface.

Speed and duplex are already guarded with "in" checks. Could these keys be
guarded the same way?

[ ... ]

> +def expect_pauseparams_set(ret, linkmodes, supported, note):
> +    """ Whether ethtool -A had to work or to be refused, given what the local
> +        device supports
> +    """
> +
> +    # If supported is empty, ethtool -A must return -EOPNOTSUPP
> +    if not supported :
> +        ksft_eq(ret, errno.EOPNOTSUPP, note)

[Severity: Medium]
Can any driver pass this for the RX off TX off variant?

ethnl_set_pause() returns early when a request changes nothing, so the
driver's set_pauseparam is never called:

net/ethtool/pause.c:ethnl_set_pause() {
    ...
	dev->ethtool_ops->get_pauseparam(dev, &params);

	ethnl_update_bool32(&params.autoneg, tb[ETHTOOL_A_PAUSE_AUTONEG], &mod);
	ethnl_update_bool32(&params.rx_pause, tb[ETHTOOL_A_PAUSE_RX], &mod);
	ethnl_update_bool32(&params.tx_pause, tb[ETHTOOL_A_PAUSE_TX], &mod);
	if (!mod)
		return 0;
    ...
}

pause_test_support() sends each rx/tx pair twice, first with "autoneg off"
and then with "autoneg on". After the first request is correctly rejected,
the state is unchanged. For rx off / tx off, one of the two requests then
matches the current state and returns 0.

Take a phylink MAC without MAC_SYM_PAUSE/MAC_ASYM_PAUSE, such as ksz88x3
port 0. It starts with link_config.pause = MLO_PAUSE_AN and rx/tx off:

- "-A rx off tx off autoneg off" gets -EOPNOTSUPP, as expected.
- "-A rx off tx off autoneg on" is a no-op and returns 0, so
  ksft_eq(0, EOPNOTSUPP) fails.

The forced link phase runs the same sequence and fails the same way.

> +    elif set(linkmodes).issubset(set(supported)) :
> +        # The configured pauseparams are supposed to be supported,
> +        #ethtool -A must have worked.
> +        ksft_eq(ret, 0, note)
> +    else :
> +        # We tried to configure parameters that aren't supporteed,
> +        # ethtool -A must have failed.
> +        ksft_in(ret, (errno.EOPNOTSUPP, errno.EINVAL), note)

[Severity: Medium]
Does this subset rule match phylink_ethtool_set_pauseparam()? The commit
message names phylink as the layer that gets pause right.

The rule here matches phylib's phy_validate_pause(), which rejects rx_pause
when Pause is not supported. phylink behaves differently:

drivers/net/phy/phylink.c:phylink_ethtool_set_pauseparam() {
    ...
	if (pl->req_link_an_mode == MLO_AN_FIXED)
		return -EOPNOTSUPP;

	if (!phylink_test(pl->supported, Pause) &&
	    !phylink_test(pl->supported, Asym_Pause))
		return -EOPNOTSUPP;

	if (!phylink_test(pl->supported, Asym_Pause) &&
	    pause->rx_pause != pause->tx_pause)
		return -EINVAL;
    ...
}

With supported = [Asym_Pause], phylink accepts "rx on tx on" and
"rx on tx off", but this test requires both to be rejected.
include/linux/phylink.h documents that case explicitly: "If you set
MAC_ASYM_PAUSE, the user may request any combination of tx_pause and
rx_pause." I could not find an in-tree phylink driver with pause ops that
sets only MAC_ASYM_PAUSE, so the fixed link case below is the more concrete
one.

For fixed links, phylink_fill_fixedlink_supported() sets Pause and
Asym_Pause in pl->supported, so ethtool reports pause as supported. Yet
phylink_ethtool_set_pauseparam() returns -EOPNOTSUPP for every request.

In the forced phase, phylink_ethtool_ksettings_set() accepts "autoneg off"
when speed and duplex match the fixed link. Every variant this function
treats as supported would then fail.

Is the test meant to encode a stricter contract than phylink, or does
phylink need fixing? As written, the two disagree.

> +def pause_setup(cfg):
> +    """ The starting conditions every test counts on, restored on exit:
> +        - both ports admin up
> +        - link autoneg on on both sides ifsupported
> +        - link actually up (carrier on)
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
> +    if link["auto-negotiation"]:
> +        defer(cmd, f"ethtool -s {cfg.ifname} autoneg on")

[Severity: Medium]
The defer queue is LIFO (ksft_flush_defer() pops from the end), so at
teardown the link restore runs first. The pause restore follows right
after it, with no wait for autoneg to complete.

Can the pause restore be refused in that window? i40e ties pause autoneg
to the link autoneg state:

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:i40e_set_pauseparam() {
    ...
	is_an = hw_link_info->an_info & I40E_AQ_AN_COMPLETED;
	if (pause->autoneg != is_an) {
		netdev_info(netdev, "To change autoneg please use: ethtool -s <dev> autoneg <on|off>\n");
		return -EOPNOTSUPP;
	}
    ...
}

On a negotiated link, the saved original is "autoneg on". If the forced
phase of pause_test_support() ran, AN_COMPLETED is still clear right after
"ethtool -s <if> autoneg on" restarts autoneg.

The restore is then rejected, and the device keeps the test's last rx/tx
pause settings. The deferred cmd() uses fail=True, so ksft_flush_defer()
also marks the case as failed.

I haven't confirmed the exact firmware timing, or that i40e accepts the
forced link on every PHY type.

> +    elif "speed" in link and "duplex" in link:
> +        defer(cmd, f"ethtool -s {cfg.ifname} autoneg off speed {link['speed']} "
> +                   f"duplex {link['duplex'].lower()}")
> +
> +    # Local interface admin up, link aneg on
> +    ip(f"link set {cfg.ifname} up")
> +    if link["supports-auto-negotiation"] and not link["auto-negotiation"]:
> +        ethtool(f"-s {cfg.ifname} autoneg on")

[Severity: Medium]
Is the original forced link configuration lost if autoneg is off but speed
or duplex is missing from the JSON?

In that case no defer is registered, but "ethtool -s <if> autoneg on" still
runs.

The patch already expects both keys can be missing. forced_link_settings()
falls back when duplex is missing. Speed is omitted when unknown, for
example while the port is admin down, and this function only brings the
port up after reading the settings.

The remote side below has the same if/elif with no fallback before
"ethtool -s <remote_ifname> autoneg on". That can leave a shared peer in
autoneg mode after the test exits.

[ ... ]

> +def pause_test_support(cfg, pauseparams):
> +    """ Verify that the supported linkmodes Pause and Asym_Pause match the
> +        ability to configure the rx and tx pauseparams.

[ ... ]

> +    The expectation is for drivers to refuse setting pauseparams that don't
> +    match the Pause and Asym_Pause bits in the supported linkmodes with a
> +    -EOPNOTSUPP return value. Unsupported pause params must be rejected.

[Severity: Low]
This isn't a bug, but expect_pauseparams_set() also accepts EINVAL for
unsupported combinations:

    ksft_in(ret, (errno.EOPNOTSUPP, errno.EINVAL), note)

phylink_ethtool_set_pauseparam() also returns -EINVAL for rx != tx when
Asym_Pause is not supported. Should the docstring mention EINVAL too?

[ ... ]

> +    # We check that what we can configure in the pause params matches what we
> +    # support under various contditions : Link aneg on/off, pause aneg on/off
> +    ret, _ = ethtool_ret(f"-s {cfg.ifname} autoneg on", is_get = False)
> +    if ret != 0:
> +        ksft_pr("link autoneg on refused, not tested")
> +    else:

[ ... ]

> +    if not forced:
> +        ksft_pr("link speed unknown, the forced link is not tested")
> +        return
> +
> +    ret, _ = ethtool_ret(f"-s {cfg.ifname} autoneg off {forced}", is_get = False)
> +    if ret != 0:
> +        ksft_pr(f"link autoneg off {forced} refused, not tested")
> +        return

[Severity: Low]
Can a variant be reported as passed without running a single pause
parameter assertion?

If "ethtool -s <if> autoneg on" fails, the first group is skipped and only
logged with ksft_pr(). If forced is then empty, or the forced
"ethtool -s ... autoneg off" fails, the function returns normally.

ksft_run() sets KSFT_RESULT = True before each case and does not check
whether the case made any assertions. The case is counted as a pass rather
than a skip.

Should these paths raise KsftSkipEx when nothing was tested?

> +
> +    ret, _ = ethtool_ret(f"-A {cfg.ifname} rx {rx} tx {tx} autoneg off",
> +                         is_get = False)
> +    expect_pauseparams_set(ret, linkmodes, supported, "link autoneg off")
> +
> +    ret, _ = ethtool_ret(f"-A {cfg.ifname} rx {rx} tx {tx} autoneg on",
> +                         is_get = False)
> +    expect_pauseparams_set(ret, linkmodes, supported, "link autoneg off")

[Severity: Medium]
Does this require pause autoneg to be accepted on a forced link? That goes
against the uAPI documentation for struct ethtool_pauseparam in
include/uapi/linux/ethtool.h:

 * Drivers should reject a non-zero setting of @autoneg when
 * autoneogotiation is disabled (or not supported) for the link.

expect_pauseparams_set() decides success only from Pause/Asym_Pause. Those
bits describe the MAC's pause frame abilities. They don't say whether pause
can be negotiated, or forced while link autoneg is running.

Several drivers fail at least one of the four link autoneg / pause autoneg
combinations:

  bnxt_set_pauseparam() returns -EINVAL for pause autoneg without
  BNXT_AUTONEG_SPEED, which is what the uAPI describes.

  mlx5e_ethtool_set_pauseparam() returns -EINVAL for any pause autoneg
  request.

  ixgbe_set_pauseparam() returns -EINVAL when
  !ixgbe_device_supports_autoneg_fc().

  i40e_set_pauseparam() returns -EOPNOTSUPP whenever pause->autoneg !=
  is_an. That already fails the link autoneg on / pause autoneg off step.

pause_advertising_test() has a related problem because it only skips on
EOPNOTSUPP. It treats an EINVAL refusal of pause autoneg from mlx5, bnxt or
ixgbe as applied. It then checks the advertisement against a configuration
the device never accepted.

[ ... ]

> +def pause_advertising_test(cfg, pauseparams):
> +    """Pause advertisement

[ ... ]

> +    The validation is made by looking at the advertised modes locally, as well
> +    as what the peer's 'lp_advertising' values report.
> +    """

[Severity: Low]
Is the lp_advertising part of this docstring accurate for this patch?

The body never queries the peer. It only reads the local
"advertised-pause-frame-use", which phy_ethtool_ksettings_get() copies from
the software phydev->advertising bitmap.

wait_for_aneg(cfg) also returns success if the link hasn't dropped within
2 seconds:

        if not link_drop and time.monotonic() > restart_by:
            return wait_for_link(cfg)

Together, these mean a MAC that never restarts autoneg, or a PHY that
misprograms its advertisement register, would still pass.

A later commit in this series, "selftests: drv-net: pause: Validate the
pause autonegotiation with a partner", adds controllable_lp() and a
get_peer_pause_lp_advertising() check to pause_advertising_test(). That
closes the gap by the end of the series.

[ ... ]

> +    # It's OK to skip here, we're already validating the EOPNOTSUPP behaviour
> +    # the pause_test_support test.
> +    ret = set_local_pauseparams(cfg, rx, tx, True)
> +    if ret == errno.EOPNOTSUPP:
> +        raise KsftSkipEx(f"RX {rx} TX {tx} not supported")
> +
> +    # Wait for link parameters to re-negotiate and link to come back up. It must
> +    # come back up, otherwise that means changing pauseparams can bring the
> +    # link down.
> +    ret = wait_for_aneg(cfg)

[Severity: Medium]
What happens when set_local_pauseparams() fails with something other than
EOPNOTSUPP?

The docstrings of set_local_pauseparams() and get_local_pauseparams() say
"Raise an error if the return is not 0 or EOPNOTSUPP". Neither function
raises. Both just return the result of ethtool_ret(), which uses
cmd(..., fail=False).

Here, an EINVAL, an EBUSY, or ethtool's raw exit code 1 is silently dropped,
and ret is overwritten by wait_for_aneg(). The advertising checks then run
against whatever state was there before, because pause_setup() does not
put the pause params into a known state.

require_pause_supported_allof() has already confirmed that the modes are
supported. So the result is either a false pass, or a failure with a
"must advertise" message that blames the PHY. For example,
mlx5e_ethtool_set_pauseparam() returns -EINVAL whenever pauseparam->autoneg
is set.

[ ... ]

> +def main():
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> +        cfg.ethnl = EthtoolFamily()

[Severity: Low]
This isn't a bug, but cfg.ethnl doesn't seem to be used anywhere in
pause.py, since everything goes through the ethtool CLI. Can this
assignment and the EthtoolFamily import be dropped? As it stands, if the
ethtool genl family can't be resolved, the whole test aborts even though it
doesn't need that family.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925182628.214667-1-maxime.chevallier%40bootlin.com
