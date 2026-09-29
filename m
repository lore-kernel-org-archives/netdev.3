Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67F3DAADE;
	Tue, 29 Sep 2026 03:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790652405; cv=none; b=H03O2BXwtunBlMIv8MaYoSQOFuuZZE221ix0zmSbA75DxkLaFR0y5HUwlfUwuRNqLWQ1GNKDEjsGMiJtijtSxDF9ZE4fH22a1i8podS7lVyeYU9E1FbP7JWxzUR3OjcTzVcDltamIKksf8Ni9ryzptLGX9ULJtd2MJAQwpGnB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790652405; c=relaxed/simple;
	bh=LMPwhXWzoyA4CT0vfKDyCz6d337/b/7difhhKULPGtE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ljvLg+sdxPXpomSrMLULXo5ELJ9Io5WOFoEvbKorDuYERwoMHSxG0yxYH9asF6HN8yAiEHU0ILPg6FbheseONEXxqAickPgoonDkT8aB0U3sb/cEdY5oHOpw7y8Uf6TydcgAhNvss7NY6OgVW+Sciqb6z1BVHMHRqWXH5yPwaus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQMaKOpJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQMaKOpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED821F000FF;
	Tue, 29 Sep 2026 03:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790652403;
	bh=7ykcN9t5xnpHUVwPxTl9FBG3rX4MmVDJf3PpotSZZPY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZQMaKOpJcUmaD3LcIa44TShrbM5KSGyDInLkZr6kbPONT9S1BBzxKkoNqmTkUv3rE
	 kY5aGmBPErlpCCs5vuvrDwpryWY/oztEOKRJkkw3NNC3pz6kitu4kx/Mlzbf5VBMvk
	 pBq2Cu8/E1hkiApmyotXswaXKehasRU+fUJWBqP1XnO3qXXQ4omUWUzZ9HYHt2rP7Q
	 c5BUqtfshPRHVFMFYD1jJEscUX7kKRrw7Ji/fMYnnp5RVuvp+DA2WeMG+AVu+1pYub
	 dheipDyRXdJ4h3aWqBxVq0Ro8u0gB+N3zil0RyZZj2QXyj/yaqVo5ENuIm4sRJ6pCc
	 6bt1ExZ8nmkUg==
Subject: Re: [PATCH net-next v2 3/3] selftests: drv-net: pause: Validate pause
 autoneg interactions with link autoneg
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 hkallweit1@gmail.com, corbet@lwn.net, skhan@linuxfoundation.org,
 o.rempel@pengutronix.de, vladimir.oltean@nxp.com, f.fainelli@gmail.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Tue, 29 Sep 2026 03:26:41 +0000
Message-ID: <179065240183.434549.13444478594975358421@kernel.org>
In-Reply-To: <20260925182628.214667-4-maxime.chevallier@bootlin.com>
References: <20260925182628.214667-4-maxime.chevallier@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] pause_autoneg_state_adv() turns pause autoneg off with
  `ethtool -A <if> rx R tx T autoneg off` (rx/tx unchanged, link autoneg…
- [Medium] pause_autoneg_off_while_link_autoneg_on() calls
  wait_for_aneg(cfg, link_drop=True) twice and treats a missed carrier…
- [Low] The commit message says the tests cover 'If Pause autoneg is off,
  it must stay off when link autoneg is enabled' and 'that the user…
- [Low] pause_autoneg_off_while_link_autoneg_on() says it checks that 'we
  do not use negotiated pause parameters' when pause autoneg is off, and…
- [Low] In pause_autoneg_state_params(), the comment at line 899 says
  'Peer advertisiong Pause + Asym and us advertising Pause'.
- [Low] pause_autoneg_link_autoneg() makes several soft ksft_eq checks
  first: set_local_pauseparams at line ~982, wait_for_aneg, and…
- [Low] pause_autoneg_state_adv() checks pause advertising, including
  what the link partner sees, but unlike the other three new tests it…
- [Low] pause_autoneg_off_while_link_autoneg_on() runs `ip link set
  <remote> down` then `ip link set <remote> up` (lines 954-955) as bare…

--

selftests: drv-net: pause: Validate pause autoneg interactions with link autoneg

This adds four disruptive tests to the drv-net pause selftest. They check
how pause autoneg interacts with link autoneg, and whether the user's rx/tx
pause intent survives changes to either autoneg setting. The commit also
adds helpers that check link autoneg support and pause support, and that
verify the local pauseparams and pause advertising.

> Pause autoneg and link autoneg settings must not interfere with one
> another when user is configuring them :
>  - If Pause autoneg is on, it must stay on when link autoneg is disabled
>    (even though Pause won't actually be negotiated)
>  - If Pause autoneg is off, it must stay off when link autoneg is
>    enabled
>
> Introduce a set of tests to verify that pause and link autoneg are
> behaving correctly, in particular that the user intent is correctly
> cached when toggling link autoneg.

[Severity: Low]
Do the new tests cover the second bullet, or the part about toggling link
autoneg?

pause_autoneg_off_while_link_autoneg_on() never runs "ethtool -s ...
autoneg", so link autoneg stays on for the whole test. The only things that
change are the peer's pause settings and the remote admin state.

pause_autoneg_link_autoneg() is the only test that forces the link and then
turns link autoneg back on. It starts with pause autoneg on.

No test runs this sequence: pause autoneg off -> link autoneg off -> link
autoneg on -> pause autoneg still off, with rx/tx kept. Wouldn't a driver
that turns pause autoneg back on whenever link autoneg is enabled pass the
whole suite?

> diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
> index 96ee730074f8c..74bc21c606958 100755
> --- a/tools/testing/selftests/drivers/net/hw/pause.py
> +++ b/tools/testing/selftests/drivers/net/hw/pause.py

[ ... ]

> @@ -747,12 +815,218 @@ def pause_aneg_resolution(cfg, settings):
>          ksft_eq(remote_pauseparams["negotiated"]["rx"], expected_lp_rx)
>          ksft_eq(remote_pauseparams["negotiated"]["tx"], expected_lp_tx)
>  
> +@ksft_disruptive
> +def pause_autoneg_state_adv(cfg):
> +    """Validate that toggling pause advertising changes the advertised linkmodes
> +
> +    When disabling pause autoneg, we enforce the pause params based on what user
> +    asks, instead of relying on the negociation process (which may not be what
> +    the user asked for). In forced pause settings, we don't advertise pause and
> +    asym_pause bits.
> +
> +    Failing this test means that .set_pauseparam in the MAC driver doesn't
> +    forward to the PHY (in charge of advertising these bits) that we are in
> +    fixed pause mode.
> +    """
> +
> +    require_pause_supported_anyof(cfg, ["Pause", "Asym_Pause"])
> +    require_controllable_lp(cfg)
> +    pause_setup(cfg)
> +
> +    set_peer_pauseparams(cfg, True, True, True)
> +    ksft_eq(wait_for_aneg(cfg), True)
> +
> +    rx, tx = supported_pauseparams(cfg)
> +
> +    # Enable all possible pauseparams with pause autoneg
> +    ret = set_local_pauseparams(cfg, rx, tx, True)
> +    ksft_eq(ret, 0)

[Severity: Low]
Should pause_autoneg_state_adv() also call require_link_autoneg()? The other
three new tests do.

pause_setup() turns on link autoneg only when "supports-auto-negotiation"
is true, and it doesn't skip when that's false. The test then requires
the pause autoneg set above to succeed.

The struct ethtool_pauseparam kernel-doc tells drivers to "reject a
non-zero setting of @autoneg when autonegotiation is disabled (or not
supported)". On a non-phylink driver that follows the doc and has no link
autoneg, wouldn't this report FAIL instead of SKIP?

phylink_ethtool_set_pauseparam() doesn't reject this case, so phylink
drivers aren't affected.

[ ... ]

> +    # Disable pause autoneg
> +    ret = set_local_pauseparams(cfg, rx, tx, False)
> +    ksft_eq(ret, 0)
> +
> +    # This may trigger a link renegociation
> +    ksft_eq(wait_for_aneg(cfg), True)
> +
> +    # We shouldn't be advertising anything anymore
> +    ret, adv = get_local_pause_advertising(cfg)
> +    ksft_eq(ret, 0)
> +    ksft_eq(adv, [])
> +
> +    # Validate on the LP that we aren't advertising anything
> +    ret, adv = get_peer_pause_lp_advertising(cfg)
> +    if ret == errno.EOPNOTSUPP:
> +        return
> +
> +    ksft_eq(ret, 0)
> +    ksft_eq(adv, [])

[Severity: Medium]
Do these two ksft_eq(adv, []) checks match the uAPI contract? The struct
ethtool_pauseparam kernel-doc in include/uapi/linux/ethtool.h says:

 * If the link is autonegotiated, drivers should use
 * mii_advertise_flowctrl() or similar code to set the advertised
 * pause frame capabilities based on the @rx_pause and @tx_pause flags,
 * even if @autoneg is zero.

phylink does this. phylink_ethtool_set_pauseparam() calls
phylink_update_pause_state(), which sets the advertisement from rx/tx
without checking MLO_PAUSE_AN:

drivers/net/phy/phylink.c:phylink_update_pause_state() {
    ...
	linkmode_set_pause(config->advertising, tx_pause,
			   rx_pause);
    ...
	if (pl->phydev)
		phy_set_asym_pause(pl->phydev, rx_pause, tx_pause);
}

phy_set_asym_pause() in drivers/net/phy/phy_device.c also sets the
advertisement from rx/tx alone.

The test runs "ethtool -A <if> rx R tx T autoneg off" with rx/tx unchanged
and link autoneg still on. After that, won't every phylink driver, and
every phylib driver that uses phy_set_asym_pause(), still advertise Pause
(or Asym_Pause) and fail both checks?

The docstring also says a failure means ".set_pauseparam in the MAC driver
doesn't forward to the PHY ... that we are in fixed pause mode". That
points driver authors toward behaviour the uAPI doc rules out. Also, the
pause_advertising_test docstring earlier in this file says phylink handles
the PHY reconfiguration correctly.

[ ... ]

> +    # Set peer user intent to RX on TX on, with Pause autoneg on
> +    set_peer_pauseparams(cfg, 1, 1, True)
> +    ksft_eq(wait_for_aneg(cfg), True)
> +
> +    # Set the local intent to RX on TX off with pause autoneg
> +    ksft_eq(set_local_pauseparams(cfg, 1, 0, True), 0)
> +    ksft_eq(wait_for_aneg(cfg), True)
> +
> +    check_local_pauseparams(cfg, True, 1, 0)
> +    # Peer advertisiong Pause + Asym and us advertising Pause means we are
> +    # actually using RX on TX on here, which is different than the intent.
> +    check_local_advertising(cfg, ["Pause", "Asym_Pause"])
> +    check_local_lp_advertising(cfg, ["Pause"])

[Severity: Low]
This isn't a bug, but in pause_autoneg_state_params() the comment has the
two sides swapped.

The peer is set with set_peer_pauseparams(cfg, 1, 1, True), so it
advertises Pause. The local side is set with set_local_pauseparams(cfg, 1,
0, True), so it advertises Pause + Asym_Pause. The asserts right below
match the code, not the comment.

The comment also has a typo: "advertisiong".

[ ... ]

> +@ksft_disruptive
> +def pause_autoneg_off_while_link_autoneg_on(cfg):
> +    """ Validate that when link autoneg is on but pause autoneg is off, we do
> +        not use negotiated pause parameters.
> +
> +        Failing this test means the MAC driver incorrectly accounts for the
> +        negotiated pause parameters even with pause aneg off, likely due to
> +        confusion between link autoneg and pause autoneg.
> +    """

[ ... ]

> +    set_peer_pauseparams(cfg, 0, 0, True)
> +    ksft_eq(wait_for_aneg(cfg, link_drop=True), True)
> +
> +    ip(f"link set {cfg.remote_ifname} down", host=cfg.remote)
> +    ip(f"link set {cfg.remote_ifname} up", host=cfg.remote)

[Severity: Low]
If the "up" call fails after "down" succeeded, what brings the remote
interface back up?

These are bare ip() calls, and no defer() restores the remote admin
state. pause_setup() only defers restores for the ethtool -A and ethtool
-s settings, even though its docstring says the ports being admin up is
restored on exit.

The next test, pause_autoneg_link_autoneg(), brings the port up only inside
pause_setup(), and it can skip before it gets there. If it skips, or if
this is the last test to run, the remote interface stays admin down.

Would registering something like this before the down call help?

    defer(ip, f"link set {cfg.remote_ifname} up", host=cfg.remote)

> +    ksft_eq(wait_for_aneg(cfg, link_drop=True), True)

[Severity: Medium]
Can the two wait_for_aneg(cfg, link_drop=True) calls in this function fail
on a correct DUT?

With link_drop=True, wait_for_aneg() no longer returns early for a link
that is already stable:

        if not link_drop and time.monotonic() > restart_by:
            return wait_for_link(cfg)

It returns True only if it sees the local "link-detected" go false.
Otherwise it waits the full 15 seconds, returns False, and the ksft_eq()
fails.

Neither trigger here reliably causes a local carrier drop that the test
can see:

- Not every peer driver restarts AN when only its pause advertisement
  changes. An in-band 1000BASE-X restart through
  phylink_change_inband_advert() and pcs_an_restart can also finish well
  within the 100 ms poll interval.

- Admin-down on the peer doesn't always drop the physical link. Examples
  are i40e/ice with link-down-on-close off (the default) and PHYs kept
  powered for WoL or NC-SI. controllable_lp() only checks the other
  direction, where local down drops the remote carrier.

- Polling starts only after both remote ip commands return, so a fast PHY
  or PCS can drop and recover before the first poll.

The first link_drop wait also adds no coverage, because the remote bounce
right after it already forces renegotiation.

> +
> +    # Pause autoneg must still be off even after a link renegotiation
> +    check_local_pauseparams(cfg, False, rx, tx)

[Severity: Low]
Can this check detect the bug the docstring describes? The docstring says
a failure means the MAC "incorrectly accounts for the negotiated pause
parameters even with pause aneg off".

check_local_pauseparams() only reads the configured autonegotiate/rx/tx
values from ethtool -a. On phylink, those values come straight from the
stored user intent:

drivers/net/phy/phylink.c:phylink_ethtool_get_pauseparam() {
    ...
	pause->autoneg = !!(pl->link_config.pause & MLO_PAUSE_AN);
	pause->rx_pause = !!(pl->link_config.pause & MLO_PAUSE_RX);
	pause->tx_pause = !!(pl->link_config.pause & MLO_PAUSE_TX);
}

This test would still pass in either of these cases:

- mac_link_up() applies the negotiated pause anyway.
- phylink's resolve path stops replacing state->pause with
  link_config.pause when MLO_PAUSE_AN is clear.

pause_autoneg_link_autoneg() has the same gap. Its docstring says that once
link autoneg is re-enabled, "pause params must be derived from the
negotiation". It never reads the "negotiated" section that
pause_aneg_resolution() checks.

> +
> +@ksft_disruptive
> +def pause_autoneg_link_autoneg(cfg):

[ ... ]

> +    # Enable all possible pause modes and autoneg
> +    set_peer_pauseparams(cfg, 1, 1, True)
> +    ksft_eq(set_local_pauseparams(cfg, rx, tx, True), 0)
> +    ksft_eq(wait_for_aneg(cfg), True)
> +
> +    check_local_pauseparams(cfg, True, rx, tx)
> +    check_local_advertising(cfg, adv)
> +    check_local_lp_advertising(cfg, ["Pause"])
> +
> +    # Disable link autoneg, at the speed and duplex the link runs at
> +    forced = forced_link_settings(cfg)
> +    if not forced:
> +        raise KsftSkipEx("Can't tell what to force the link at")
> +
> +    ret, _ = ethtool_ret(f"-s {cfg.remote_ifname} autoneg off {forced}",
> +                         is_get=False, host=cfg.remote)
> +    if ret != 0:
> +        raise KsftSkipEx(f"Can't force the peer's link at {forced}")
> +
> +    ret, _ = ethtool_ret(f"-s {cfg.ifname} autoneg off {forced}",
> +                         is_get=False)
> +    if ret != 0:
> +        raise KsftSkipEx(f"Can't force the link at {forced}")
> +
> +    if not wait_for_aneg(cfg):
> +        raise KsftSkipEx(f"No link when forced at {forced}")

[Severity: Low]
What happens to failures already recorded in this test when one of these
skips is raised?

Before this point pause_autoneg_link_autoneg() has already run several
ksft_eq() checks: set_local_pauseparams(), wait_for_aneg(), and the
check_local_* helpers. ksft_run() in
tools/testing/selftests/net/lib/py/ksft.py handles the skip like this:

        except KsftSkipEx as e:
            comment = "SKIP " + str(e)
            cnt_key = 'skip'

That skips the later pass/fail choice based on KSFT_RESULT. The test is
then reported as "not ok ... # SKIP". KTAP consumers treat that as a skip,
and the totals count it as a skip instead of a fail.

This path looks likely. Forcing 1000BASE-T copper usually gives no link,
and forced_link_settings() returns an empty string when the speed is
unknown. ksft_exit() still exits non-zero, but the per-test result hides a
real pause or advertising mismatch.

Could these skips be raised only when none of the earlier checks has
failed?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925182628.214667-1-maxime.chevallier%40bootlin.com
