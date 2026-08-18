Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395473EEAE1
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078663; cv=none; b=NHUpmOLz9VTBcYA5z4L4bVKl3N5MC8RJ/HTP1CQzh0frxDWaQsUBaIC2tC4beew9FmqnpP4IQc2pwYVNV+i219FbEBnSKWTq2u31M5X4RNQP2DovpIPLBTVY3cO5sHSyCHipLt/7IO53bDCD7ktbUBST9Puklzvwsi6x/PZi9sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078663; c=relaxed/simple;
	bh=cVmvvrAhLxK8LpETFFWCDtl4kYegphODIL5+5nWPt+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8ZRPa9P+iRo9T4T15sf+UIkzKbkY1+KkuBzY5fvYxly6Fp6riG97+3aRqRXZmUzfXzX9r6ZPVvcrhCfl2GcNdAWlm/YpifnDITGCLxavPTwVnW6oATa/ghd0ofJMRFmDoNTlSFKqEUJySVS5gFpZWCEeV+kBVAu9LCiYRIiomw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FgLXHQ5m; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FgLXHQ5m"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 78A941A1707;
	Tue, 18 Aug 2026 18:44:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 43EC560355;
	Tue, 18 Aug 2026 18:44:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB77211C74E6F;
	Tue, 18 Aug 2026 20:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787078654; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/8GvVSs8iI9IF9gyksrUqRLSI+MEzqcRDCycP7bwOuA=;
	b=FgLXHQ5mpW4mfNWV5N9/0Ibk3HSxH/O6/bV/NlS8l8GJqZTL0kBHpD8+GzSjZY2drpKKuj
	kD6++OWekVsfltY3ZzYg4nQZZQZ8VkrOsmODfbaLVBl3dKWyBvWxoqJVqh4IoBJfLG/vbR
	1KCGQCy7dyrS+Xh00FWLPInaWETGfzAXX02Rv8/7CxBOXWhc5OMDT5yIIHz5FDALgPuDDJ
	F2l3gqr2E6+EZM59PIwybLvgjogkyJ1U5ctEsgDxMzvxHJI2ELmWU8rD9e4/xTAWiJi/P5
	ztFWw6Jr1whwZTqeNUcQcCDzhX+w7dR2j3FH/PDMIvwigNvrksDesgcy4jz7tw==
Message-ID: <e3450128-f189-42a2-87cc-07d3d240fda6@bootlin.com>
Date: Tue, 18 Aug 2026 20:44:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] selftests/net: Introduce a selftest for
 ethtool flow control
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260731162812.4118413-1-maxime.chevallier@bootlin.com>
 <68f569df-fa57-4f94-962e-f3eea20ab7ba@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <68f569df-fa57-4f94-962e-f3eea20ab7ba@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrew,

On 8/9/26 18:45, Andrew Lunn wrote:
> On Fri, Jul 31, 2026 at 06:28:11PM +0200, Maxime Chevallier (Netdev Foundation) wrote:
>> From: Maxime Chevallier <maxime.chevallier@bootlin.com>
>>
>> As part of work started by the Netdev Foundation, introduce a skeleton
>> of a selftest to stress the ethtool pause APIs. The goal is to catch
>> common mistakes done in drivers by allowing these tests to be run on
>> real hardware, and derive potential implementation issues from the
>> behaviour observed at the userspace level.
>>
>> This is just the skeleton of the tests, most implementation details are
>> stubbed, the goal is to validate the test definitions, flow and results
>> here.
>>
>> A separate documentation such as the one written by Oleksij will be sent
>> as a complement for the next iterations.
>>
>> Signed-off-by: Maxime Chevallier (Netdev Foundation) <maxime.chevallier@bootlin.com>

Thanks for the review ! Sorry for the delay, I took 2 weeks off
expecting to be able to be somewhat active on netdev, but I ended-up
not being very present. Back to work now :)

[...]

>> +def pause_to_linkmodes(rx, tx) -> list[str]:
>> +    """ Convert rx/tx pauseparams to the corresponding linkmodes
>> +    """
>> +    if rx:
>> +        if tx:
>> +            return pauseparams_to_linkmodes[3]["linkmodes"]
>> +        else:
>> +            return pauseparams_to_linkmodes[2]["linkmodes"]
>> +    elif tx:
>> +        return pauseparams_to_linkmodes[1]["linkmodes"]
>> +    else:
>> +        return pauseparams_to_linkmodes[0]["linkmodes"]
> 
> I don't want to get into the weeds, but if you have nested dict, you
> should be able to do
> 
> 	return pauseparams_to_linkmodes[rx][tx]["linkmodes"]

True, that's a better idea yes :)

> 
> but then you cannot reuse the pauseparams_to_linkmodes as a list of
> test variants.
> 
>> +def get_peer_lp_advertising(cfg) -> tuple[int, list[str]]:
>> +    """ get the lp_advertised linkmodes on the link partner
>> +
>> +    Raise an error if the return is not 0 or EOPNOTSUPP
>> +    returns ENODEV if there's no LP
>> +    Prints a warning if LP is present but doesn't report lp_advertising
>> +
>> +    :param cfg: test config
>> +    :returns: tuple containing :
>> +              - return code of the ethtool command
>> +              - list of linkmodes
>> +    """
>> +    #TODO
>> +    raise KsftSkipEx("Not implemented")
>> +
>> +def wait_for_link(cfg) -> bool:
>> +    """ Wait for both ends of the link to be up.
>> +
>> +    :param cfg: test config
>> +    :returns: True if link is UP, False if timeout
>> +    """
>> +    #TODO
>> +    raise KsftSkipEx("Not implemented")
> 
> When we are considering this as Documentation of what tests we want to
> implement, this is fine. But when it comes to the real implementation,
> i think many of these methods can be put into a library, since they
> will be used for EEE testing, and hopefully other classes of tests in
> the future.

Absolutely, I agree with that, I'll put these into a shared lib

> 
>> +def pause_test_support(cfg, pauseparams) -> None:
>> +    """ Verify that the supported linkmodes Pause and Asym_Pause match the
>> +        ability to configure the rx and tx pauseparams.
>> +
>> +    Drivers are expected to reject pauseparams they don't support, and
>> +    accept the ones they support. The supported modes are exposed by
>> +    the MAC to the PHY layer through phylink mac_capabilities MAC_SYM_PAUSE
>> +    and MAC_ASYM_PAUSE, or through phylib directly with the
>> +    phy_support_sym_pause() and phy_support_asym_pause() helpers.
>> +
>> +    The expectation is for drivers to refuse setting pauseparams that don't
>> +    match the Pause and Asym_Pause bits in the supported linkmodes with a
>> +    -EOPNOTSUPP return value. Unsupported pause params must be rejected.
>> +
>> +    Failing this test likely means the MAC driver doesn't implement the
>> +    set/get_pauseparam, but still sets flow control as supported through
>> +    phylink mac_capabilities or phylib's pause API. Conversely, the MAC driver
>> +    may have omitted to indicate its supported Pause modes. Finally, the PHY
>> +    driver may incorrectly override the Pause and Asym_Pause bits in its supported
>> +    fields.
>> +    """
>> +
>> +    rx = "on" if pauseparams["rx"] else "off"
>> +    tx = "on" if pauseparams["tx"] else "off"
>> +    linkmodes = pauseparams["linkmodes"]
>> +
>> +    # Run ethtool {cfg.ifname} and extract the "Supported pause frame use"
>> +    # Run ethtool -A {cfg.ifname} rx {rx} tx {tx} autoneg off, store the return code
> 
> The autoneg off is buried in this text. On first reading, i did not
> notice this was testing forced pause configuration. I would mention
> that in the method documentation, and maybe the method name.
> 
> Should we be being this twice, once with ethtool -s autoneg on, and
> then with ethtool -s autoneg off? Maybe that is covered in a later
> test i've not got to yet...

Ah true yes

> 
>> +def pause_advertising_test(cfg, pauseparams) -> None:
> 
> ...
> 
>> +    # Wait for link parameters to re-negotiate and link to come back up. It must
>> +    # come back up, otherwise that means changing pauseparams can bring the
>> +    # link down.
>> +    ret = wait_for_link(cfg)
>> +    ksft_true(ret, "Link din't come back up after setting pauseparams")
> 
> typo: didn't
> 
>> +
>> +    _, linkmodes = get_local_advertising(cfg)
>> +    for mode in adv:
>> +        ksft_in(mode, linkmodes, f"rx {rx} tx {tx} must advertise {adv}")
>> +
>> +    for mode in not_adv:
>> +        ksft_not_in(mode, linkmodes, f"rx {rx} tx {tx} must not advertise {not_adv}")
>> +
>> +    # It's better to double-check on the LP that we are indeed correctly
>> +    # advertising these modes, but if we don't have a controllable LP let's
>> +    # just rely on what we say we're advertising
>> +    returncode, remote_linkmodes = get_peer_lp_advertising(cfg)
>> +    if returncode == errno.ENODEV:
>> +        return
> 
> I think we should be suggesting to vendors to implement returning the
> LP values. And i _guess_ most vendors with use a pair of their own
> devices, rather than a 3rd party device. So printing a warning here
> that LP is not supported would be a good hint it should be.
> 
> I think the level of details is good now. We can start the
> implementation.

Great, next round will be something we can actually run then :)

> 
>> +def main() -> None:
>> +    with NetDrvEpEnv(__file__) as cfg:
>> +        cfg.ethnl = EthtoolFamily()
>> +        ksft_run([pause_test_support,
>> +                  pause_advertising_test,
>> +                  pause_aneg_resolution,
>> +                  pause_autoneg_state_adv,
>> +                  pause_autoneg_state_params,
>> +                  pause_autoneg_off_while_link_autoneg_on,
>> +                  pause_autoneg_link_autoneg,
>> +                  ],
>> +                 args=(cfg, ))
>> +    ksft_exit()
>> +
>> +if __name__ == "__main__":
>> +    main()
> 
> An implementation detail: How robust is the test framework, getting
> the device back into a working state? The test is turning autoneg off
> and on, we might loose link. If we fail a test, throw an exception, is
> there cleanup to get the device back into a known good state?
> 
> Maybe before we run the test, we check we have link. If there is no
> link, fail the test, basic requirements are not met. Then make a note
> of the current configuration. At the end of the test, even if it
> fails, or throws an exception restore that configuration. We have to
> be careful of systems like automotive which often don't support
> autoneg. So our cleanup cannot be as simple as turn autoneg on.

From my initial tests, we definitely have to deal with recovery. We can
lose link, get the whole interface completely stuck (crash/stall requiring
a reboot), etc.

It's more of an infrastructure thing here, people running the selftests
while developping a driver will be able to manually recover, but for NIPA
or other setups, usually reboot is the safe way.

Maxime

Pause isn't the wo

> 
> 	 Andrew

