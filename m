Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C8365A13;
	Tue, 29 Sep 2026 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790652403; cv=none; b=aA6XO4eGxcjq8yUn5MtJ+/DJxc3y+qCG0eg9kwGZo0iAAvXT3ZnFJn1uBoy0ZKRBoTsHV4ZspIl41cVfIeOaOQ6/1oPYZ/gUQc+usTVLb5VSF+CQ5h16Ye5m3bGBEuAgrwPd3EjvBYJZhyR0rdRjXgREmrjt9ojtplb8ChImMag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790652403; c=relaxed/simple;
	bh=aNmMH9UoWg9koiU8OnS+iAcds6PWfCjyGyKtq7VWTsA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aM4mWUWPEQ/D/avN4/0XVtlRbpiO/i7bQ41ZFBlMd9uWSMIbnJzG3IATe5v3Q2Ui17IAq07mikxYV6zdX+xcGu6gNkPUbjmVFqBZl/Li6SlIl/MTYEq/gs9saBwUvpJ0+/Vl5nWdcWj48LyEvqsdbsOH7QqdFOTSENQmBKEEYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BY9jFTks; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY9jFTks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB041F00893;
	Tue, 29 Sep 2026 03:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790652401;
	bh=GcqGzNKkn7duUvILJ1IqvAu0ACzTtlSdbgKMt9WRG6U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BY9jFTks51WoebUU72hbh+2Vk/R/MOGJAWbmhqzmAbDOyTi8Rip5oS1MQXbMS5CY+
	 U6n+XPo41+yme480TnrJyBfy5aQfVISGI+aEM/sr2GaNOKh1Xxsf5l2tieimEbk6DG
	 Urg/gNbOxGBnClEQkvVydA2JFCp5RdTCW4WLYYfzlRYZIoenWKq+23aru8zVUjKYsA
	 qGsyqla9eQ4QDzsvIrj4Qie703b3cOUoa6pX9vglCsLMaynqUSVedcf5NqAfq3oQIQ
	 e/fI5RlbLgqKED6AsfIfm9Pi7rTu6vKFZHHNpFe0z+IVQdZd4qR1PbO076kKrXgUNM
	 jvrfse23BmcDg==
Subject: Re: [PATCH net-next v2 2/3] selftests: drv-net: pause: Validate the
 pause autonegotiation with a partner
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 hkallweit1@gmail.com, corbet@lwn.net, skhan@linuxfoundation.org,
 o.rempel@pengutronix.de, vladimir.oltean@nxp.com, f.fainelli@gmail.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Tue, 29 Sep 2026 03:26:40 +0000
Message-ID: <179065240018.434549.346139764454021625@kernel.org>
In-Reply-To: <20260925182628.214667-3-maxime.chevallier@bootlin.com>
References: <20260925182628.214667-3-maxime.chevallier@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tools/testing/selftests/drivers/net/hw/pause.py, the
  docstring of pause_aneg_resolution() says the test fails if 'the PHY…
- [Medium] controllable_lp() in pause.py runs `ip link set {cfg.ifname}
  down` (line 152), then a remote `ethtool --json` poll loop, then `ip…
- [Medium] controllable_lp() only treats the remote as the direct link
  partner if `ip link set <local> down` makes the remote lose carrier…
- [Medium] selftests: drv-net: pause: false test failure for unsupported
  devices on no-op changes
- [Low] Several new peer helpers in pause.py have docstrings or messages
  copied from the local helpers that do not match the code.
- [Low] pause_aneg_resolution() only handles EOPNOTSUPP from
  set_local_pauseparams() (lines 693-695).
- [Low] All four advertisement checks in pause_aneg_resolution() (lines
  715-738) only test that required bits are present (ksft_in over…

--

selftests: drv-net: pause: Validate the pause autonegotiation with a partner

This commit adds a pause_aneg_resolution test to pause.py. The test sets
pause parameters on both the local device and the link partner, then
checks the resulting 802.3 pause resolution for all 16 combinations. It
also adds helpers that detect whether the remote is the direct link
partner, and extends pause_advertising_test to check the remote's
lp_advertising.

> diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
> index f07db32715003..96ee730074f8c 100755
> --- a/tools/testing/selftests/drivers/net/hw/pause.py
> +++ b/tools/testing/selftests/drivers/net/hw/pause.py
> @@ -124,6 +124,62 @@ def wait_for_link(cfg):
>      # the remote to report link up, let's wait a bit less
>      return wait_for_link_remote(cfg, timeout = 3)
>  
> +def controllable_lp(cfg):

[ ... ]

> +    # Set both ends up, wait for up
> +    ip(f"link set {cfg.ifname} up")
> +    ip(f"link set {cfg.remote_ifname} up", host=cfg.remote)
> +
> +    # No link established
> +    if not wait_for_link(cfg):
> +        ksft_pr(f"{cfg.remote_ifname} is not the link partner: no link with both ends up")
> +        cfg.lp_controllable = False
> +        return False
> +
> +    ip(f"link set {cfg.ifname} down")
> +
> +    deadline = time.monotonic() + 3
> +    dropped = False
> +    while time.monotonic() < deadline and not dropped:
> +        dropped = not ethtool(f"{cfg.remote_ifname}", json=True,
> +                              host=cfg.remote)[0]["link-detected"]
> +        time.sleep(0.1)
> +
> +    ip(f"link set {cfg.ifname} up")

[Severity: Medium]
What happens to cfg.ifname if something raises between the link down and
the link up here?

ethtool() goes through tool() and cmd() with the default fail=True. So any
of these would skip the "link set ... up" call:

- a failure or timeout of the remote command
- a KeyError on "link-detected"
- a JSON parse error
- a KeyboardInterrupt

Nothing like try/finally or defer() protects this window.

ksft_run() flushes defers when a test raises, but pause_setup() never
defers an admin-up. In pause_aneg_resolution(), require_controllable_lp()
also runs before pause_setup(), so that test has nothing deferred at all.

lp_controllable is not cached on exception, so a later test would retry
and bring the link back up. But if the exception happens in the last
caller of controllable_lp() in the run (pause_autoneg_link_autoneg by the
end of the series), or on an interrupt, is the DUT interface left
admin-down after the selftest exits?

Other drv-net tests restore the link with a defer. For example, queues.py
and stats.py use:

    defer(ip, f"link set dev {cfg.dev['ifname']} up")

Also, both ends are forced admin-up here, and their original admin state
is never recorded or restored.

> +
> +    if not dropped:
> +        ksft_pr(f"{cfg.remote_ifname} is not the link partner: "
> +                f"it kept its link through {cfg.ifname} going down")
> +        cfg.lp_controllable = False
> +        wait_for_link(cfg)
> +        return False

[Severity: Medium]
Does taking the local interface admin-down reliably drop the physical
link on directly cabled setups?

In phylib, phy_suspend() leaves the PHY active on purpose in some cases:

drivers/net/phy/phy_device.c:phy_suspend() {
    ...
	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
		return -EBUSY;

	if (!phydrv->suspend)
		return 0;
    ...
}

Firmware-managed NICs such as ice also keep the link on close by default.
In drivers/net/ethernet/intel/ice/ice_main.c, the PHY is only taken down
on close when ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA is set:

	if (test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, vsi->back->flags)) {
		int link_err = ice_phy_cfg(vsi, false);

On this kind of hardware, a directly connected peer would be cached as
cfg.lp_controllable = False. pause_aneg_resolution(), and the four later
tests in the series, would then skip with "is not directly connected".
That message points at cabling, when the real cause is that the PHY
stayed powered.

The new remote lp_advertising checks in pause_advertising_test() would
also be skipped without any notice.

This detection is not changed later in the series.

[ ... ]

> @@ -170,6 +230,33 @@ def get_local_pauseparams(cfg):
>      """
>      return ethtool_ret(f"-a {cfg.ifname}", is_get=True)
>  
> +def set_peer_pauseparams(cfg, rx, tx, aneg):
> +    """ set pauseparams : ethtool -A
> +
> +    Raise an error if the return is not 0 or EOPNOTSUPP
> +    """
> +    rx_param = onoff(rx)
> +    tx_param = onoff(tx)
> +    aneg_param = onoff(aneg)
> +
> +    ret, _ = ethtool_ret(f"-A {cfg.remote_ifname} rx {rx_param} tx {tx_param}"
> +                         f" autoneg {aneg_param}",
> +                         is_get = False, host=cfg.remote)
> +
> +    if ret != 0:
> +        raise KsftSkipEx(f"Can't set pauseparams on peer: {errno.errorcode.get(ret, ret)}")
> +
> +    return ret
> +
> +def get_peer_pauseparams(cfg):
> +    """ get pauseparams : ethtool -a
> +
> +    Raise an error if the return is not 0 or EOPNOTSUPP
> +    """
> +
> +    return ethtool_ret(f"-a {cfg.remote_ifname}", is_get=True,
> +                       host=cfg.remote)

[Severity: Low]
This isn't a bug, but the docstring of set_peer_pauseparams() says it
raises an error unless the return is 0 or EOPNOTSUPP. The code instead
raises KsftSkipEx on any non-zero return, EOPNOTSUPP included. A real
peer error such as EINVAL or EIO is reported as SKIP.

Several other new peer helpers have docstrings or messages that don't
match the code:

- get_peer_pauseparams() says "Raise an error if the return is not 0 or
  EOPNOTSUPP", but it only returns the ethtool_ret() tuple.

- get_peer_pause_lp_advertising() says "Return the errcode and the local
  pause lp_advertised linkmodes", but it queries cfg.remote_ifname.

- require_peer_pause_supported_allof() says "Skip if local device doesn't
  support all of the passed modes", but it checks the remote.

- require_peer_pause_supported_anyof() checks the remote, but its skip
  message is "Local device doesn't support any of ...". Nothing calls it,
  in this patch or by the end of the series.

[ ... ]

> @@ -398,11 +561,198 @@ def pause_advertising_test(cfg, pauseparams):

[ ... ]

> +@ksft_disruptive
> +def pause_aneg_resolution(cfg, settings):

[ ... ]

> +    # Set pauseparams
> +    ret = set_local_pauseparams(cfg, settings["rx"], settings["tx"], True)
> +    if ret == errno.EOPNOTSUPP:
> +        raise KsftSkipEx(f"RX {settings['rx']} TX {settings['tx']} not supported")
> +
> +    ksft_eq(wait_for_aneg(cfg), True)
> +
> +    set_peer_pauseparams(cfg, settings["lp_rx"], settings["lp_tx"], True)
> +
> +    # Wait for link to re-negotiate
> +    ret = wait_for_aneg(cfg)
> +
> +    # Fail if it doesn't
> +    ksft_eq(ret, True)
> +
> +    if get_local_pause_lp_advertising(cfg)[0] != 0:
> +        raise KsftSkipEx("Local device doesn't report the LP's advertising")
> +
> +    ret, local_pauseparams = get_local_pauseparams(cfg)
> +    if ret != 0 or "negotiated" not in local_pauseparams:
> +        raise KsftSkipEx("Local device doesn't report the negotiated pause params")

[Severity: Low]
Should errors other than EOPNOTSUPP from set_local_pauseparams() fail
the test?

set_local_pauseparams() returns the error code without raising, so
EINVAL, EIO and similar errors fall through to the checks below.

In the "local rx off tx off" variants, required_local_linkmodes is empty,
so the local advertising loop checks nothing. If the state left by
pause_setup() happens to give the expected resolution, the variant can
pass even though configuring the DUT failed.

pause_test_support() does catch such a driver through
expect_pauseparams_set(). A later patch in the series ("Validate pause
autoneg interactions with link autoneg") also uses ksft_eq(ret, 0) for
the same setter. This call site is unchanged at the end of the series,
though.

The same pattern shows up with get_local_pauseparams() above. Any failure
there is reported as a missing capability, although the same call already
succeeded in require_pause_supported_allof(). Would it be better to fail
when ret != 0?

> +
> +    # check adv
> +    _, linkmodes = get_local_pause_advertising(cfg)
> +    for mode in required_local_linkmodes:
> +        ksft_in(mode, linkmodes,
> +                f"local rx {settings['rx']} tx {settings['tx']} must advertise "
> +                f"{required_local_linkmodes}")
> +
> +    _, linkmodes = get_peer_pause_advertising(cfg)
> +    for mode in required_remote_linkmodes:
> +        ksft_in(mode, linkmodes,
> +                f"remote rx {settings['lp_rx']} tx {settings['lp_tx']} must advertise "
> +                f"{required_remote_linkmodes}")
> +
> +    # check lp_adv if available
> +    _, linkmodes = get_local_pause_lp_advertising(cfg)
> +    for mode in required_remote_linkmodes:
> +        ksft_in(mode, linkmodes,
> +                f"local lp_adv must show the remote's {required_remote_linkmodes}")
> +
> +    # check lp_adv on remote
> +    ret, linkmodes = get_peer_pause_lp_advertising(cfg)
> +    if ret == 0:
> +        for mode in required_local_linkmodes:
> +            ksft_in(mode, linkmodes,
> +                    f"remote lp_adv must show our {required_local_linkmodes}")

[Severity: Low]
These four checks only confirm that the required bits are present. Should
they also reject Pause or Asym_Pause bits that ought to be absent?

When a required list is empty, the loop checks nothing. Take "local rx
off tx off, remote rx off tx off": the resolution is 0/0 either way, so
two faults would go unnoticed:

- a peer that keeps Pause after a successful set
- a local PHY that reports extra lp_advertising bits

pause_advertising_test() uses ksft_not_in() for absent bits, and a later
patch in the series compares advertising lists with ksft_eq(). However,
pause_aneg_resolution() is unchanged at the end of the series.

> +
> +    # Check resolution
> +    _, local_pauseparams = get_local_pauseparams(cfg)
> +    ksft_eq(local_pauseparams["negotiated"]["rx"], expected_local_rx)
> +    ksft_eq(local_pauseparams["negotiated"]["tx"], expected_local_tx)
> +
> +    ret, remote_pauseparams = get_peer_pauseparams(cfg)
> +    if ret == 0 and "negotiated" in remote_pauseparams:
> +        ksft_eq(remote_pauseparams["negotiated"]["rx"], expected_lp_rx)
> +        ksft_eq(remote_pauseparams["negotiated"]["tx"], expected_lp_tx)

[Severity: Medium]
Where does the "negotiated" object come from?

The PAUSE netlink uAPI only has the HEADER, AUTONEG, RX, TX, STATS and
STATS_SRC attributes. pause_fill_reply() in net/ethtool/pause.c sends no
negotiated or resolved RX/TX result.

The ethtool utility builds "negotiated" in userspace from the
ETHTOOL_A_LINKMODES_OURS and PEER bitsets. Those are the same advertised
and lp_advertised bits checked just above.

On the kernel side, phylink_ethtool_get_pauseparam() in
drivers/net/phy/phylink.c reports the configured intent, not the resolved
state:

	pause->autoneg = !!(pl->link_config.pause & MLO_PAUSE_AN);
	pause->rx_pause = !!(pl->link_config.pause & MLO_PAUSE_RX);
	pause->tx_pause = !!(pl->link_config.pause & MLO_PAUSE_TX);

So once the adv and lp_adv checks pass, these asserts are a pure function
of those bits. Would a MAC that programs its own flow control still pass
all 16 variants? What about a PHY driver that overwrites phydev->pause or
asym_pause without touching lp_advertising?

If so, the test can't detect the failure cases its docstring lists:

     - that the PHY driver manually overwrites the Pause negotiation result
     - that the MAC driver ignores the Pause resolution and sets its own
       pause parameters regardless

The same applies to the docstring's "This test also verifies that the peer
resolved the parameters correctly". It also applies to this line in the
commit message:

    Introduce a test that validates we're correctly resolving pause
    parameters according to 802.3.

In practice, these checks test ethtool's userspace 802.3 resolution table.

This is not addressed later in the series.

[ ... ]

> @@ -200,6 +336,32 @@ def require_pause_supported_allof(cfg, linkmodes):
>          if lm not in pause_support:
>              raise KsftSkipEx(f"Local device doesn't support {lm}")
>  
> +def require_peer_pause_supported_anyof(cfg, linkmodes):
> +    """ Skip if remote device doesn't support any of the passed modes """
> +
> +    ret, _ = get_peer_pauseparams(cfg)
> +    if ret != 0:
> +        raise KsftSkipEx("Remote device doesn't allow getting pauseparams")
> +
> +    _, pause_support = get_peer_pause_supported(cfg)
> +    for lm in linkmodes:
> +        if lm in pause_support:
> +            return
> +
> +    raise KsftSkipEx(f"Local device doesn't support any of {linkmodes}")
> +
> +def require_peer_pause_supported_allof(cfg, linkmodes):
> +    """ Skip if local device doesn't support all of the passed modes """
> +
> +    ret, _ = get_peer_pauseparams(cfg)
> +    if ret != 0:
> +        raise KsftSkipEx("Remote device doesn't allow getting pauseparams")
> +
> +    _, pause_support = get_peer_pause_supported(cfg)
> +    for lm in linkmodes:
> +        if lm not in pause_support:
> +            raise KsftSkipEx(f"Remote device doesn't support {lm}")
> +
>  def expect_pauseparams_set(ret, linkmodes, supported, note):
>      """ Whether ethtool -A had to work or to be refused, given what the local
>          device supports

[Severity: Medium]
expect_pauseparams_set() comes from the previous patch, but it shows
up in the context here. Can the empty supported branch fail on a
driver that behaves correctly?

ethnl_set_pause_validate() in net/ethtool/pause.c only returns
-EOPNOTSUPP when get_pauseparam or set_pauseparam is missing. After
that, ethnl_set_pause() reads the current state with get_pauseparam()
and merges the requested attributes with ethnl_update_bool32(). If
nothing changed, it returns without calling the driver:

	if (!mod)
		return 0;

Take a phylink MAC with neither Pause nor Asym_Pause in pl->supported.
phylink_ethtool_set_pauseparam() would reject a real change with
-EOPNOTSUPP. It is never called, though, when the requested rx, tx
and autoneg values match what get_pauseparam() already reports.

For such a request ethtool -A succeeds and ret is 0. The
ksft_eq(ret, errno.EOPNOTSUPP, note) check then reports a failure,
even though the device has no pause support and the kernel did
nothing wrong. On that hardware pause_test_support() would fail in
CI instead of passing or skipping.

Should expect_pauseparams_set() get the pauseparams before the set
and accept 0 when the request is a no-op? Or should the no-op
variants be skipped on devices whose supported list is empty?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925182628.214667-1-maxime.chevallier%40bootlin.com
