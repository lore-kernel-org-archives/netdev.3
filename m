Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560753D300D;
	Sun,  9 Aug 2026 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786293936; cv=none; b=nSqjl5UKCIiblLViNARDChBw7yDsBXhllurKQ62LOh3Sgzdyn5lQKSaxxUC8+1YI/1BoVkGRHIeWmlVyM/0+Wy/jfWNQ81jf/Q7R3kyHNxLyUPZH7ByllmtPS93YXtDSI/afN1oJ2dRbZ4fxYQUBbE5MmlZf88msCWbP2ZmjbuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786293936; c=relaxed/simple;
	bh=xaKtpNrQ2ZC5g8uTgJNJfptobQ4iIHrX4s7sE8Nkjeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvgTz2yxSJOj0gssjeG2XMegubGMzaMvvFHUG4bMBAG+pNPgtkLMn8N7TlA4ZCa3vT3XcGNjAkkbROb84DfZhuW/ZGpo4DNH7vV/97vPrrWlNslv2keaTOwWP50w+AP7ilzBW3ugqQIaAv6OrVglePEHCvFiQrpKPGm/mfg1RRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mEYdu1wV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mEYdu1wV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JUSn4jUiUVjPqW/j0ZRCjaW7aWRkY2lThiJAjSZSnd4=; b=mEYdu1wV9f2AAbAFVdhMsYqhwN
	v8DjHXzJSelhv1tSgvzKLUfKCVkrz75x6eBUKfBsXBdwKsgERzcdRMh2t504FwhIJ0+TWe9ZNee0V
	clQRsvs0Mej9zjLvpkUcBr4MQtaEb9IIUCM3rx5LI1edl2S8nbOOeJ6++relqwale0ww=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wt6eA-00GpV3-T0; Sun, 09 Aug 2026 18:45:14 +0200
Date: Sun, 9 Aug 2026 18:45:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH net-next] selftests/net: Introduce a selftest for
 ethtool flow control
Message-ID: <68f569df-fa57-4f94-962e-f3eea20ab7ba@lunn.ch>
References: <20260731162812.4118413-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731162812.4118413-1-maxime.chevallier@bootlin.com>

On Fri, Jul 31, 2026 at 06:28:11PM +0200, Maxime Chevallier (Netdev Foundation) wrote:
> From: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> As part of work started by the Netdev Foundation, introduce a skeleton
> of a selftest to stress the ethtool pause APIs. The goal is to catch
> common mistakes done in drivers by allowing these tests to be run on
> real hardware, and derive potential implementation issues from the
> behaviour observed at the userspace level.
> 
> This is just the skeleton of the tests, most implementation details are
> stubbed, the goal is to validate the test definitions, flow and results
> here.
> 
> A separate documentation such as the one written by Oleksij will be sent
> as a complement for the next iterations.
> 
> Signed-off-by: Maxime Chevallier (Netdev Foundation) <maxime.chevallier@bootlin.com>
> ---
>  .../testing/selftests/drivers/net/hw/pause.py | 716 ++++++++++++++++++
>  1 file changed, 716 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/net/hw/pause.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
> new file mode 100644
> index 000000000000..c5cf81f48011
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/pause.py
> @@ -0,0 +1,716 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""
> +Driver-related behavior tests for Pause-based Flow Control.
> +
> +Requires a controllable link-partner, with configurable autoneg parameters
> +as well as support for Pause and Asym_Pause.
> +"""
> +
> +from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, ksft_in, ksft_not_in, ksft_true
> +from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx, ksft_raises
> +from lib.py import defer, ethtool, CmdExitFailure
> +from lib.py import EthtoolFamily, NlError
> +from lib.py import NetDrvEpEnv
> +from lib.py import ip
> +import errno
> +
> +# Linkmodes to Pause params :
> +# Pause bit is set if rx == 1
> +# Asym_Pause bit is set if rx != tx
> +pauseparams_to_linkmodes = [
> +    {"rx": 0, "tx": 0, "linkmodes": []},
> +    {"rx": 0, "tx": 1, "linkmodes": ["Asym_Pause"]},
> +    {"rx": 1, "tx": 0, "linkmodes": ["Pause", "Asym_Pause"]},
> +    {"rx": 1, "tx": 1, "linkmodes": ["Pause"]},
> +]
> +
> +def pause_to_linkmodes(rx, tx) -> list[str]:
> +    """ Convert rx/tx pauseparams to the corresponding linkmodes
> +    """
> +    if rx:
> +        if tx:
> +            return pauseparams_to_linkmodes[3]["linkmodes"]
> +        else:
> +            return pauseparams_to_linkmodes[2]["linkmodes"]
> +    elif tx:
> +        return pauseparams_to_linkmodes[1]["linkmodes"]
> +    else:
> +        return pauseparams_to_linkmodes[0]["linkmodes"]

I don't want to get into the weeds, but if you have nested dict, you
should be able to do

	return pauseparams_to_linkmodes[rx][tx]["linkmodes"]

but then you cannot reuse the pauseparams_to_linkmodes as a list of
test variants.

> +def get_peer_lp_advertising(cfg) -> tuple[int, list[str]]:
> +    """ get the lp_advertised linkmodes on the link partner
> +
> +    Raise an error if the return is not 0 or EOPNOTSUPP
> +    returns ENODEV if there's no LP
> +    Prints a warning if LP is present but doesn't report lp_advertising
> +
> +    :param cfg: test config
> +    :returns: tuple containing :
> +              - return code of the ethtool command
> +              - list of linkmodes
> +    """
> +    #TODO
> +    raise KsftSkipEx("Not implemented")
> +
> +def wait_for_link(cfg) -> bool:
> +    """ Wait for both ends of the link to be up.
> +
> +    :param cfg: test config
> +    :returns: True if link is UP, False if timeout
> +    """
> +    #TODO
> +    raise KsftSkipEx("Not implemented")

When we are considering this as Documentation of what tests we want to
implement, this is fine. But when it comes to the real implementation,
i think many of these methods can be put into a library, since they
will be used for EEE testing, and hopefully other classes of tests in
the future.

> +def pause_test_support(cfg, pauseparams) -> None:
> +    """ Verify that the supported linkmodes Pause and Asym_Pause match the
> +        ability to configure the rx and tx pauseparams.
> +
> +    Drivers are expected to reject pauseparams they don't support, and
> +    accept the ones they support. The supported modes are exposed by
> +    the MAC to the PHY layer through phylink mac_capabilities MAC_SYM_PAUSE
> +    and MAC_ASYM_PAUSE, or through phylib directly with the
> +    phy_support_sym_pause() and phy_support_asym_pause() helpers.
> +
> +    The expectation is for drivers to refuse setting pauseparams that don't
> +    match the Pause and Asym_Pause bits in the supported linkmodes with a
> +    -EOPNOTSUPP return value. Unsupported pause params must be rejected.
> +
> +    Failing this test likely means the MAC driver doesn't implement the
> +    set/get_pauseparam, but still sets flow control as supported through
> +    phylink mac_capabilities or phylib's pause API. Conversely, the MAC driver
> +    may have omitted to indicate its supported Pause modes. Finally, the PHY
> +    driver may incorrectly override the Pause and Asym_Pause bits in its supported
> +    fields.
> +    """
> +
> +    rx = "on" if pauseparams["rx"] else "off"
> +    tx = "on" if pauseparams["tx"] else "off"
> +    linkmodes = pauseparams["linkmodes"]
> +
> +    # Run ethtool {cfg.ifname} and extract the "Supported pause frame use"
> +    # Run ethtool -A {cfg.ifname} rx {rx} tx {tx} autoneg off, store the return code

The autoneg off is buried in this text. On first reading, i did not
notice this was testing forced pause configuration. I would mention
that in the method documentation, and maybe the method name.

Should we be being this twice, once with ethtool -s autoneg on, and
then with ethtool -s autoneg off? Maybe that is covered in a later
test i've not got to yet...

> +def pause_advertising_test(cfg, pauseparams) -> None:

...

> +    # Wait for link parameters to re-negotiate and link to come back up. It must
> +    # come back up, otherwise that means changing pauseparams can bring the
> +    # link down.
> +    ret = wait_for_link(cfg)
> +    ksft_true(ret, "Link din't come back up after setting pauseparams")

typo: didn't

> +
> +    _, linkmodes = get_local_advertising(cfg)
> +    for mode in adv:
> +        ksft_in(mode, linkmodes, f"rx {rx} tx {tx} must advertise {adv}")
> +
> +    for mode in not_adv:
> +        ksft_not_in(mode, linkmodes, f"rx {rx} tx {tx} must not advertise {not_adv}")
> +
> +    # It's better to double-check on the LP that we are indeed correctly
> +    # advertising these modes, but if we don't have a controllable LP let's
> +    # just rely on what we say we're advertising
> +    returncode, remote_linkmodes = get_peer_lp_advertising(cfg)
> +    if returncode == errno.ENODEV:
> +        return

I think we should be suggesting to vendors to implement returning the
LP values. And i _guess_ most vendors with use a pair of their own
devices, rather than a 3rd party device. So printing a warning here
that LP is not supported would be a good hint it should be.

I think the level of details is good now. We can start the
implementation.

> +def main() -> None:
> +    with NetDrvEpEnv(__file__) as cfg:
> +        cfg.ethnl = EthtoolFamily()
> +        ksft_run([pause_test_support,
> +                  pause_advertising_test,
> +                  pause_aneg_resolution,
> +                  pause_autoneg_state_adv,
> +                  pause_autoneg_state_params,
> +                  pause_autoneg_off_while_link_autoneg_on,
> +                  pause_autoneg_link_autoneg,
> +                  ],
> +                 args=(cfg, ))
> +    ksft_exit()
> +
> +if __name__ == "__main__":
> +    main()

An implementation detail: How robust is the test framework, getting
the device back into a working state? The test is turning autoneg off
and on, we might loose link. If we fail a test, throw an exception, is
there cleanup to get the device back into a known good state?

Maybe before we run the test, we check we have link. If there is no
link, fail the test, basic requirements are not met. Then make a note
of the current configuration. At the end of the test, even if it
fails, or throws an exception restore that configuration. We have to
be careful of systems like automotive which often don't support
autoneg. So our cleanup cannot be as simple as turn autoneg on.

	 Andrew
