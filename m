Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D93F410E;
	Sun, 18 Oct 2026 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792350082; cv=none; b=VAWYsB9M1W/7nI97XS/Z4An5JzhwxbElk0yz/BzZErVveBsjdWTXiSxbws8gVNCTxUGPWKDSiOS+X4KLBbytMF8/n4L4LE4ogaLivIC+p8dupRHW6mODpEJk03luAL9rXIjlEU5Rbd2zFZgDvAecHdG9VsBBykVmVphK67p35x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792350082; c=relaxed/simple;
	bh=DajREmf6gnxnZz2P6DQGY1B3eHVlpZSD5AGRvYgYrPI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L/yJHETA8/vki/CT3WWRkCOS/HRLzh5+UmzvFghAq7J5rOqx8/On7JP4i+ljlQXbKHhXKrtI3kobBrpD/gSWBM+ctQi2BWrufAkU08twdngMVhhtHFtiZomu//12g7QfV7vPcFw9AGbIISBpqWEQX0Jgfx4I71VDxYGx1gJVkt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVRjMM+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVRjMM+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193211F000C7;
	Sun, 18 Oct 2026 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792350081;
	bh=RngNa/7A0yrotjKseWwu5SRNO2yG0Y+0quB9mkU/wR4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BVRjMM+okMs3ihSu6DLHyrT1VuCxv+h/iy2VPpruy0bGRYrf+ugTmjv0mGuxBXRzb
	 k9G5reqCHka92x70Nz1dYAYyKCGAp0KcnfukcZS44ipwO/XzCDiUF4ML+ND977NFlI
	 1Ypx3OEIHHHOEkBM1pgyQs3oWlovym2A68C2BLMDd9wKK0d0+j5mm2N1CJ1mZtNokO
	 fi/clNkgo8RWvMqf5KZPtOsDTqXY+E5Am84qNlrMJynVtJGd0DsyHFFmi0S2te0q7o
	 37wihaTGpUVuu1OC2cXkNLb25BDlw0QcxTlntziyGR5mP5nUaF4+tHYbL9etFcj4vX
	 Fh/XVZeFE6ETg==
Subject: Re: [PATCH net-next v3 2/3] selftests: drv-net: pause: Validate the
 pause autonegotiation with a partner
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 hkallweit1@gmail.com, corbet@lwn.net, skhan@linuxfoundation.org,
 o.rempel@pengutronix.de, vladimir.oltean@nxp.com, f.fainelli@gmail.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Sun, 18 Oct 2026 19:01:19 +0000
Message-ID: <179235007968.3135.3196549965949091381@kernel.org>
In-Reply-To: <20261015134350.629593-3-maxime.chevallier@bootlin.com>
References: <20261015134350.629593-3-maxime.chevallier@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In pause_aneg_resolution()
  (tools/testing/selftests/drivers/net/hw/pause.py), the '# Check…
- [Medium] This patch makes the existing pause_advertising_test() depend
  on a link-partner probe.
- [Medium] controllable_lp() decides whether the remote is the direct
  link partner from one timing-sensitive sample.
- [Medium] pause_advertising_test() (new remote lp_adv check, line 490)
  and pause_aneg_resolution() (remote lp_adv check at line 651, remote…
- [Low] The docstring of require_peer_pause_supported_allof()
  (tools/testing/selftests/drivers/net/hw/pause.py, line 282) says 'Skip…

--

selftests: drv-net: pause: Validate the pause autonegotiation with a partner

This adds a pause_aneg_resolution test to the drv-net pause selftest. It
runs all 16 combinations of local and link-partner rx/tx pause settings
and checks the advertised, lp_advertised and negotiated pause state. It
also adds a controllable_lp() probe to detect whether the remote is
directly connected, and extends pause_advertising_test() to check the
peer's lp_advertising.

> diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
> index 854428e19f55f..cd117296be333 100755
> --- a/tools/testing/selftests/drivers/net/hw/pause.py
> +++ b/tools/testing/selftests/drivers/net/hw/pause.py
> @@ -84,6 +84,41 @@ def wait_for_aneg(cfg, link_drop=False, timeout=15):
>  
>      wait_for_link(cfg, timeout)
>  
> +def controllable_lp(cfg):

[ ... ]

> +    controllable = getattr(cfg, "lp_controllable", None)
> +    if controllable is not None:
> +        return controllable
> +
> +    before = int(cmd(f"cat /sys/class/net/{cfg.remote_ifname}/carrier_changes",
> +                     host=cfg.remote).stdout)
> +
> +    ret, _ = ethtool_ret(f"-r {cfg.ifname}", is_get=False)
> +    if ret != 0:
> +        raise KsftSkipEx(f"ethtool -r {cfg.ifname} failed: {errno.errorcode.get(ret, ret)}")
> +
> +    wait_for_aneg(cfg, link_drop=True)
> +
> +    cfg.lp_controllable = int(cmd(f"cat /sys/class/net/{cfg.remote_ifname}/carrier_changes",
> +                                  host=cfg.remote).stdout) > before
> +    return cfg.lp_controllable

[Severity: Medium]
Is a single read of the remote carrier_changes reliable enough here?

wait_for_aneg() only watches the local carrier, and nothing waits for the
remote to notice the flap. A polled phylib/phylink remote only sees
link-down on its next state machine poll (PHY_STATE_TIME, 1 s).

If the AN restart is fast (in-band SGMII/1000BASE-X) and the local link is
interrupt-driven, the local carrier can be back up before the remote has
counted the flap. In that case carrier_changes hasn't moved and the remote
is classified as not directly connected.

That False is then cached in cfg.lp_controllable. Wouldn't every
pause_aneg_resolution variant then skip with "not directly connected", and
the peer checks in pause_advertising_test() be skipped for the rest of the
run?

Would retrying, or polling the remote carrier_changes for a short time,
help? Later patches in the series don't seem to change controllable_lp().

[ ... ]

> @@ -163,6 +278,18 @@ def require_pause_supported_allof(cfg, linkmodes):
>          if lm not in pause_support:
>              raise KsftSkipEx(f"Local device doesn't support {lm}")
>  
> +def require_peer_pause_supported_allof(cfg, linkmodes):
> +    """ Skip if local device doesn't support all of the passed modes """

[Severity: Low]
This isn't a bug, but the docstring looks copied from
require_pause_supported_allof(). This helper checks the remote device, not
the local one.

[ ... ]

> @@ -330,6 +457,7 @@ def pause_advertising_test(cfg, pauseparams):
>  
>      require_pause_supported_allof(cfg, pauseparams["linkmodes"])
>      pause_setup(cfg)
> +    lp = controllable_lp(cfg)

[Severity: Medium]
Doesn't this make the existing local advertising checks in
pause_advertising_test() depend on the link partner probe?

controllable_lp() raises KsftSkipEx when ethtool -r fails:

    ret, _ = ethtool_ret(f"-r {cfg.ifname}", is_get=False)
    if ret != 0:
        raise KsftSkipEx(...)

On a driver without .nway_reset (-EOPNOTSUPP), or where
phy_ethtool_nway_reset() returns -ENODEV, every variant would now skip its
local ksft_in/ksft_not_in checks. Those checks don't need a partner.

ethtool -r can also succeed without the local carrier ever dropping. One
example is phylink_ethtool_nway_reset() with no phydev and a PCS that
doesn't restart AN. In that case wait_for_aneg(cfg, link_drop=True) lets
the TimeoutError from wait_file() escape. ksft_run() records that as a
failure, so a test that used to pass would now fail.

In both cases cfg.lp_controllable is never set. The probe, with its link
flap or 15 second timeout, then repeats for every pause_advertising_test
variant and all 16 pause_aneg_resolution variants.

In pause_aneg_resolution(), the same TimeoutError turns what should be a
"not directly connected" skip into a failure.

Could controllable_lp() return False, and cache it, in these cases? Later
patches in the series don't seem to change this.

[ ... ]

> @@ -356,11 +484,191 @@ def pause_advertising_test(cfg, pauseparams):
>          ksft_not_in(mode, linkmodes,
>                      f"rx {rx} tx {tx} aneg on must not advertise {not_adv}")
>  
> +    if not lp:
> +        return
> +
> +    returncode, remote_linkmodes = get_peer_pause_lp_advertising(cfg)
> +    if returncode == errno.EOPNOTSUPP:
> +        return
> +
> +    for mode in adv:
> +        ksft_in(mode, remote_linkmodes, f"PHY does not advertise {adv}")

[Severity: Medium]
Could the remote's lp_advertising still be stale at this point?

wait_for_aneg() only polls /sys/class/net/{cfg.ifname}/carrier. The
remote's phylib state machine runs on its own schedule. In polled mode it
only updates phydev->lp_advertising on its 1 s poll, and while AN is
incomplete genphy_read_lpa() clears the bits:

    if (!phydev->autoneg_complete) {
        mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
        mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
        return 0;
    }

Right after the local carrier comes up, the remote may still report the
previous variant's lp bits. The ksft_in/ksft_not_in checks below would
then fail intermittently.

If the bits are cleared instead, linkmodes.c omits
ETHTOOL_A_LINKMODES_PEER. get_peer_pause_lp_advertising() then returns
EOPNOTSUPP and the remote checks are silently skipped.

pause_aneg_resolution() has the same problem. After set_peer_pauseparams()
it waits only on the local carrier before checking the remote lp_adv and
negotiated values.

Would waiting for /sys/class/net/{cfg.remote_ifname}/carrier on
cfg.remote help? Later patches in the series don't seem to add such a
wait.

[ ... ]

> +@ksft_disruptive
> +def pause_aneg_resolution(cfg, settings):
> +    """ Verify that rx and tx pause parameters are negotiated according to 802.3

[ ... ]

> +    Failing this test can happen if :
> +     - The MAC accepts the pause parameters but doesn't trigger a link
> +       renegotiation
> +     - that the PHY driver manually overwrites the Pause negotiation result
> +     - that the MAC driver ignores the Pause resolution and sets its own
> +       pause parameters regardless
> +    """

[ ... ]

> +    # check lp_adv if available
> +    _, linkmodes = get_local_pause_lp_advertising(cfg)
> +    ksft_eq(linkmodes, required_remote_linkmodes,
> +            f"local lp_adv must show the remote's {required_remote_linkmodes}")
> +
> +    # check lp_adv on remote
> +    ret, linkmodes = get_peer_pause_lp_advertising(cfg)
> +    if ret == 0:
> +        ksft_eq(linkmodes, required_local_linkmodes,
> +                f"remote lp_adv must show our {required_local_linkmodes}")
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
Do these resolution checks test what the kernel actually resolved?

The kernel's PAUSE_GET reply has no resolved pause attribute.
pause_fill_reply() only puts ETHTOOL_A_PAUSE_AUTONEG, RX and TX, and
phylink_ethtool_get_pauseparam() reports the configured
pl->link_config.pause.

The "negotiated" object in the ethtool -a JSON output is computed in
userspace by the ethtool tool. It comes from LINKMODES_OURS and
LINKMODES_PEER, the same advertised and lp_advertised bits that the
"# check adv" and "# check lp_adv" blocks above already compare with
ksft_eq(). Once those pass, these asserts can only fail if ethtool itself
is buggy.

With that in mind, can the test catch the PHY overwrite and MAC override
cases listed in the docstring above?

Nothing here reads the tx_pause/rx_pause passed to mac_link_up() or
phydev->pause/asym_pause. Pause frame stats and traffic aren't checked
either.

The ethtool userspace resolution also ignores duplex. A half-duplex link,
where phylink disables pause, would still pass.

The commit message says:

    Introduce a test that validates we're correctly resolving pause
    parameters according to 802.3.

Should the commit message and docstring be narrowed to what is actually
checked? Alternatively, could the test look at the pause state actually
programmed into the MAC? Later patches in the series leave this code
unchanged.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015134350.629593-1-maxime.chevallier%40bootlin.com
