Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE03D88F2;
	Sun, 18 Oct 2026 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792350084; cv=none; b=CktF0z+xBwhNG1bDKIl1P/qtDOlcV4fYptb0N62td3KM/xw8zDeaPCGFxEZTaWb0KwJnP2M7uK4vBYb04T7zqBSvNd00L94tzDscXWxTu7xzjmk9DkBp5eg89q/VJoenZAGftVD286axY8a5Xog8xxXaFiD+Nk5EYCYeHE+nzv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792350084; c=relaxed/simple;
	bh=iWJG779yOuxF9lIWVVKE3yiLd3Z3jYZQJzScMH5sPK8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XvVhjB8xKPkjGlpdmXiN7DA5bBNfG1AJOb1f+YFWIl5t+k2rlH/buew8wP0tMPbCdsc5uI5DWmN867NkCH/+I0XbXgGBNpQW45rmvDE2ym5UzfORP0B+Np3juyN71ZQBwcU5fhi1rxF4lNzMAyyRIaLzhoDaN2v9a/GxoQZ6ysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht/NiUdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht/NiUdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909131F000C4;
	Sun, 18 Oct 2026 19:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792350082;
	bh=1/PiK1yxGcnIDZlYmYqoPQmryik+z+AWLSMwNlikbBw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ht/NiUdEvCwYshvmFt2PDa6DtD5Ta1XQ/3vbSy9go+k4FTloGl8d55IsD8A68yDNE
	 bMduZCrtwF+HJ2LgHaG3w2Woy0bm7oPCml4/gYVBZKY3EBk8T6KVsQN91eZYLlkdqW
	 J8x535+qdY4X/mQrAw1tO5SkoBwMV3radDDtIaH9AS2Cioo0Jk0Gc4KUeTxyn0QmNb
	 VEiHdmOf81piVkURmO8BCUzNotdA/WTGx0n8Hla/3o4V1H7hS7FrwAgRRWGl3mATrh
	 Asy5vqc0k1PCqRU/5Gqaha+mwIO1ryBNieAzmsZ1t2zkH7GWH+Bxh0bdI+RO/i6MY5
	 hSnDQPERoAx/w==
Subject: Re: [PATCH net-next v3 3/3] selftests: drv-net: pause: Validate pause
 autoneg interactions with link autoneg
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 hkallweit1@gmail.com, corbet@lwn.net, skhan@linuxfoundation.org,
 o.rempel@pengutronix.de, vladimir.oltean@nxp.com, f.fainelli@gmail.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Sun, 18 Oct 2026 19:01:21 +0000
Message-ID: <179235008114.3135.14318594489781607533@kernel.org>
In-Reply-To: <20261015134350.629593-4-maxime.chevallier@bootlin.com>
References: <20261015134350.629593-4-maxime.chevallier@bootlin.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says the tests check two invariants: (1) if
  pause autoneg is on, it stays on when link autoneg is disabled; (2) if…
- [Low] Two test docstrings claim more than the tests check.
- [Low] The supported_pauseparams() docstring says it returns 'The rx/tx
  params covering every mode the local device supports', and callers say…
- [Low] require_link_autoneg() reads `ethtool(f"{cfg.remote_ifname}",
  json=True, host=cfg.remote)[0]["supports-auto-negotiation"]` (lines…

--

selftests: drv-net: pause: Validate pause autoneg interactions with link autoneg

This commit adds four tests and some helpers to the drv-net pause.py
selftest. The tests check that toggling pause autoneg keeps the user's
rx/tx intent and advertising. They also check that pause autoneg and link
autoneg do not override each other.

> diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
> index cd117296be333..ca4a55e59c30f 100755
> --- a/tools/testing/selftests/drivers/net/hw/pause.py
> +++ b/tools/testing/selftests/drivers/net/hw/pause.py
> @@ -119,6 +119,17 @@ def require_controllable_lp(cfg):
>      if not controllable_lp(cfg):
>          raise KsftSkipEx(f"{cfg.remote_ifname} is not directly connected to {cfg.ifname}")
>  
> +def require_link_autoneg(cfg):
> +    """ Skip if local or remote device don't support link aneg """
> +    # Does local device support link aneg
> +    if not ethtool(f"{cfg.ifname}", json=True)[0]["supports-auto-negotiation"]:
> +        raise KsftSkipEx(f"{cfg.ifname} doesn't support link autoneg")
> +
> +    # Does remote device support link aneg
> +    if not ethtool(f"{cfg.remote_ifname}",
> +                   json=True, host=cfg.remote)[0]["supports-auto-negotiation"]:
> +        raise KsftSkipEx(f"Remote {cfg.remote_ifname} doesn't support link autoneg")

[Severity: Low]
What happens here if the remote doesn't report link modes at all? ethtool
prints supports-auto-negotiation together with the other link mode fields.
If the key is missing, this raises KeyError instead of KsftSkipEx.

In pause_autoneg_state_adv(), the only guard before this call is
require_pause_supported_anyof(), and it looks only at the local device.
pause_setup() would skip cleanly in this case:

    if "auto-negotiation" not in link:
        raise KsftSkipEx(f"{cfg.remote_ifname} doesn't report its link modes")

but pause_setup() runs after require_link_autoneg(). ksft_run() counts any
exception other than KsftSkipEx/KsftXfailEx as a failure.

Would pause_autoneg_state_adv() then fail instead of skip on such a setup?

The other three new tests call require_peer_pause_supported_allof() first,
and it already skips when the remote reports no link modes.

[ ... ]

> @@ -290,8 +315,51 @@ def require_peer_pause_supported_allof(cfg, linkmodes):
>          if lm not in pause_support:
>              raise KsftSkipEx(f"Remote device doesn't support {lm}")
>  
> +def supported_pauseparams(cfg):
> +    """ The rx/tx params covering every mode the local device supports """
> +
> +    _, pause_support = get_local_pause_supported(cfg)
> +    if "Pause" in pause_support:
> +        return 1, 1

[Severity: Low]
This isn't a bug, but does the docstring match what this function returns?
In pauseparams_to_linkmodes, rx=1/tx=1 maps to Pause only:

        1: {"rx": 1, "tx": 1, "linkmodes": ["Pause"]}},

On a device that supports both Pause and Asym_Pause, this returns (1, 1).
So pause_autoneg_state_adv(), pause_autoneg_off_while_link_autoneg_on() and
pause_autoneg_link_autoneg() never advertise Asym_Pause on that device. Only
rx=1/tx=0 advertises both modes.

The caller comments "Enable all possible pauseparams" and "Enable all
possible pause modes" describe the same wider coverage.

> +    if "Asym_Pause" in pause_support:
> +        return 0, 1
> +
> +    raise KsftSkipEx("Local device doesn't support pause")

[ ... ]

> @@ -663,12 +731,211 @@ def pause_aneg_resolution(cfg, settings):

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
> +    wait_for_aneg(cfg)
> +
> +    ethtool(f"-r {cfg.ifname}")
> +    wait_for_aneg(cfg, link_drop=True)
> +
> +    # Pause autoneg must still be off even after a link renegotiation
> +    check_local_pauseparams(cfg, False, rx, tx)

[Severity: Low]
Can this check detect what the docstring describes? check_local_pauseparams()
only compares the autonegotiate, rx and tx fields from ethtool -a. For
phylink drivers those fields hold the stored request, not what was
programmed into the MAC:

drivers/net/phy/phylink.c:phylink_ethtool_get_pauseparam() {
    ...
	pause->autoneg = !!(pl->link_config.pause & MLO_PAUSE_AN);
	pause->rx_pause = !!(pl->link_config.pause & MLO_PAUSE_RX);
	pause->tx_pause = !!(pl->link_config.pause & MLO_PAUSE_TX);
}

Many non-phylink drivers also return their cached rx/tx values. Suppose the
peer moves to rx 0 / tx 0 and the MAC wrongly applies the resolved all-off
result. It would still report the forced values here and pass. The check
does catch drivers whose get_pauseparam reports the resolved state.

The pause_autoneg_link_autoneg() docstring has a similar gap:

    is the user intent. When link autoneg is re-enabled, pause params must be
    derived from the negotiation.

After link autoneg is re-enabled, that test only checks the cached intent
and the local and link partner advertising. Unlike pause_aneg_resolution(),
it never reads params["negotiated"]. Nothing checks pause frame counters or
traffic to confirm that the MAC applies the negotiated flow control.

ethtool also seems to compute its negotiated output in userspace from the
local and link partner advertising. If so, pause frame statistics may be
the only way to see what the MAC is really doing.

Should the docstrings be narrowed to what is actually checked? Or could the
tests verify the applied state, for example through pause frame statistics?

[ ... ]

> +@ksft_disruptive
> +def pause_autoneg_link_autoneg(cfg):

[ ... ]

> +    # Enable all possible pause modes and autoneg
> +    set_peer_pauseparams(cfg, 1, 1, True)
> +    ksft_eq(set_local_pauseparams(cfg, rx, tx, True), 0)
> +    wait_for_aneg(cfg)

[ ... ]

> +    # Re-enable autoneg
> +    ethtool(f"-s {cfg.remote_ifname} autoneg on", host=cfg.remote)
> +    ethtool(f"-s {cfg.ifname} autoneg on")
> +    wait_for_aneg(cfg)

[Severity: Low]
The commit message lists two invariants:

     - If Pause autoneg is on, it must stay on when link autoneg is disabled
       (even though Pause won't actually be negotiated)
     - If Pause autoneg is off, it must stay off when link autoneg is
       enabled

It also says the tests verify "that the user intent is correctly cached when
toggling link autoneg".

Is the second invariant covered when link autoneg is toggled? This is the
only test that toggles link autoneg, and pause autoneg is always on when it
does.

pause_autoneg_off_while_link_autoneg_on() is the only test that runs with
pause autoneg off. It keeps link autoneg on the whole time and only
restarts negotiation:

    ethtool(f"-r {cfg.ifname}")

pause_autoneg_state_adv() and pause_autoneg_state_params() never change
link autoneg. The steady state with link autoneg on, including a
renegotiation, is tested, but an explicit link autoneg off -> on transition
with pause autoneg off is not.

Suppose a driver's set_link_ksettings copies cmd->base.autoneg into its
cached pause autoneg. Wouldn't that driver pass every test in the suite?

Could a pause autoneg off variant of this test run the same link autoneg
off -> on cycle?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015134350.629593-1-maxime.chevallier%40bootlin.com
