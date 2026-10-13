Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB543CAE8D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882312; cv=none; b=ZRVHfrJqbod0oYaGLmHHwUMKPsly6jLZM6GzG2ZPW6ttagtYFH/xt6HToHMOWyufDCtxTEf6fKIqQgcejv8zCxLQJdzoakFDfRhpaQlbdbkt6IxtmflVZ1Y9Y9bEWRtSL9pfKE6L0lQze4mzC43epvpDQuUVh8MRvJ5RONiy9sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882312; c=relaxed/simple;
	bh=FWphfVI7mjsyJQ8I6Mlj28S6c8u7xWbdAeuTFZuIGT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p56z/Eygt8QlaZqeUG5Wol10itmJy3s/izdTYihRhltNOlQ4xG/PdtDjgJCZEPO2EDiduPbGFde5/RQejQkw4IKVTx4eZNZ+9Z8/Axfptlv0oIuUVClATCPhFqGhIEPnz4m3UCqWusCMkJJO6g/RQ9bgFt1csVom3/rJDnd3K1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G6/Vclg6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G6/Vclg6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2B0261A1145;
	Tue, 13 Oct 2026 09:05:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E90FF60362;
	Tue, 13 Oct 2026 09:05:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C846711D70DA6;
	Tue, 13 Oct 2026 11:04:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791882306; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=R/XKbb75qHSPALWx5OZ4L1xUz8ST9rnW1ArtvCZ7Zgc=;
	b=G6/Vclg6xIDatCguDn6jX3wDaaekxJf/HhTjZ9QyAye+xC7JC4G5Px3x+06I8pBEzSHBKL
	qKIt1bux1Tzx1ZppNoDI/AxB9kALBi4vzuITa2ViZ4XfCgiqcSTZWVgyMR7A0a+BNx1+nl
	mgrhtYXYoCCoT75Z6TUAUZXIzyDOM2lWcBXhKYC/sj7mT/zpxJNbSwKlDBB8CqLw/fGKqM
	RTnDldZmglnQ604EpQPfXMmCbaBSfOloCQ2oF4q2Q1WomiGudm0M70DWbn+kk9L8LkRWQy
	7YKazdzif5RJNWVq97P3YlO1Jd1DUW51gxDpzPdiyMey2m4i/Rvl1YhlLIRJ1w==
Message-ID: <f06aba7f-0e5f-4c9e-b53a-b5b817b3e6c6@bootlin.com>
Date: Tue, 13 Oct 2026 11:04:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] selftests: drv-net: Introduce a selftest
 for ethtool flow control
To: netdev-bot+sashiko@kernel.org
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, hkallweit1@gmail.com, corbet@lwn.net,
 skhan@linuxfoundation.org, o.rempel@pengutronix.de, vladimir.oltean@nxp.com,
 f.fainelli@gmail.com, thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260925182628.214667-2-maxime.chevallier@bootlin.com>
 <179065239849.434549.14198730559380952270@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <179065239849.434549.14198730559380952270@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/29/26 05:26, netdev-bot+sashiko@kernel.org wrote:

>> +def get_local_pause_supported(cfg):
>> +    """ Return the errcode and the local pause supported linkmodes """
>> +
>> +    ret, data = ethtool_ret(f"{cfg.ifname}")
>> +    if ret != 0:
>> +        raise KsftFailEx(f"ethtool {cfg.ifname} failed: {ret}")
>> +
>> +    return ret, _ethtool_pause_use_to_linkmodes(data["supported-pause-frame-use"])
> 
> [Severity: Low]
> What happens here on a device without get_link_ksettings?
> 
> ethtool only prints "supported-pause-frame-use", "advertised-pause-frame-use",
> "auto-negotiation" and "supports-auto-negotiation" when the link modes reply
> succeeds. Plain "ethtool <dev>" still exits 0 when other replies, such as
> link-detected, are present.
> 
> In that case this line raises an uncaught KeyError. ksft_run() reports that
> as a failure with a traceback, not as a skip.
> 
> require_pause_supported_allof() calls this function before any capability
> check. pause_setup() also indexes link["auto-negotiation"] and
> link["supports-auto-negotiation"] directly, for both the local and the
> remote interface.
> 
> Speed and duplex are already guarded with "in" checks. Could these keys be
> guarded the same way?

There are a few of these drivers, will address.

> 
> [ ... ]
> 

> 
>> +def pause_setup(cfg):
>> +    """ The starting conditions every test counts on, restored on exit:
>> +        - both ports admin up
>> +        - link autoneg on on both sides ifsupported
>> +        - link actually up (carrier on)
>> +    """
>> +
>> +    # Get init pause parameters
>> +    ret, params = ethtool_ret(f"-a {cfg.ifname}")
>> +    if ret == 0:
>> +        defer(cmd, f"ethtool -A {cfg.ifname} rx {onoff(params['rx'])} "
>> +                   f"tx {onoff(params['tx'])} "
>> +                   f"autoneg {onoff(params['autonegotiate'])}")
>> +
>> +    # Get init link parameters
>> +    link = ethtool(f"{cfg.ifname}", json=True)[0]
>> +    if link["auto-negotiation"]:
>> +        defer(cmd, f"ethtool -s {cfg.ifname} autoneg on")
> 
> [Severity: Medium]
> The defer queue is LIFO (ksft_flush_defer() pops from the end), so at
> teardown the link restore runs first. The pause restore follows right
> after it, with no wait for autoneg to complete.
> 
> Can the pause restore be refused in that window? i40e ties pause autoneg
> to the link autoneg state:
That's a i40e driver issue :) The tests aren't build around the HW behaviour.

> 
>> +    elif "speed" in link and "duplex" in link:
>> +        defer(cmd, f"ethtool -s {cfg.ifname} autoneg off speed {link['speed']} "
>> +                   f"duplex {link['duplex'].lower()}")
>> +
>> +    # Local interface admin up, link aneg on
>> +    ip(f"link set {cfg.ifname} up")
>> +    if link["supports-auto-negotiation"] and not link["auto-negotiation"]:
>> +        ethtool(f"-s {cfg.ifname} autoneg on")
> 
> [Severity: Medium]
> Is the original forced link configuration lost if autoneg is off but speed
> or duplex is missing from the JSON?
> 
> In that case no defer is registered, but "ethtool -s <if> autoneg on" still
> runs.
> 
> The patch already expects both keys can be missing. forced_link_settings()
> falls back when duplex is missing. Speed is omitted when unknown, for
> example while the port is admin down, and this function only brings the
> port up after reading the settings.
> 
> The remote side below has the same if/elif with no fallback before
> "ethtool -s <remote_ifname> autoneg on". That can leave a shared peer in
> autoneg mode after the test exits.

Ok I'll add a restore step here

> 
> [ ... ]
> 
>> +def pause_test_support(cfg, pauseparams):
>> +    """ Verify that the supported linkmodes Pause and Asym_Pause match the
>> +        ability to configure the rx and tx pauseparams.
> 
> [ ... ]
> 
>> +    The expectation is for drivers to refuse setting pauseparams that don't
>> +    match the Pause and Asym_Pause bits in the supported linkmodes with a
>> +    -EOPNOTSUPP return value. Unsupported pause params must be rejected.
> 
> [Severity: Low]
> This isn't a bug, but expect_pauseparams_set() also accepts EINVAL for
> unsupported combinations:
> 
>     ksft_in(ret, (errno.EOPNOTSUPP, errno.EINVAL), note)
> 
> phylink_ethtool_set_pauseparam() also returns -EINVAL for rx != tx when
> Asym_Pause is not supported. Should the docstring mention EINVAL too?

Docstrings are gonna be shrunk down as pylint says the file's too big... I'll
update.

> 
> [ ... ]
> 
>> +    # We check that what we can configure in the pause params matches what we
>> +    # support under various contditions : Link aneg on/off, pause aneg on/off
>> +    ret, _ = ethtool_ret(f"-s {cfg.ifname} autoneg on", is_get = False)
>> +    if ret != 0:
>> +        ksft_pr("link autoneg on refused, not tested")
>> +    else:
> 
> [ ... ]
> 
>> +    if not forced:
>> +        ksft_pr("link speed unknown, the forced link is not tested")
>> +        return
>> +
>> +    ret, _ = ethtool_ret(f"-s {cfg.ifname} autoneg off {forced}", is_get = False)
>> +    if ret != 0:
>> +        ksft_pr(f"link autoneg off {forced} refused, not tested")
>> +        return
> 
> [Severity: Low]
> Can a variant be reported as passed without running a single pause
> parameter assertion?
> 
> If "ethtool -s <if> autoneg on" fails, the first group is skipped and only
> logged with ksft_pr(). If forced is then empty, or the forced
> "ethtool -s ... autoneg off" fails, the function returns normally.
> 
> ksft_run() sets KSFT_RESULT = True before each case and does not check
> whether the case made any assertions. The case is counted as a pass rather
> than a skip.
> 
> Should these paths raise KsftSkipEx when nothing was tested?

OK

> 
>> +
>> +    ret, _ = ethtool_ret(f"-A {cfg.ifname} rx {rx} tx {tx} autoneg off",
>> +                         is_get = False)
>> +    expect_pauseparams_set(ret, linkmodes, supported, "link autoneg off")
>> +
>> +    ret, _ = ethtool_ret(f"-A {cfg.ifname} rx {rx} tx {tx} autoneg on",
>> +                         is_get = False)
>> +    expect_pauseparams_set(ret, linkmodes, supported, "link autoneg off")
> 
> [Severity: Medium]
> Does this require pause autoneg to be accepted on a forced link? That goes
> against the uAPI documentation for struct ethtool_pauseparam in
> include/uapi/linux/ethtool.h:
> 
>  * Drivers should reject a non-zero setting of @autoneg when
>  * autoneogotiation is disabled (or not supported) for the link.
> 
> expect_pauseparams_set() decides success only from Pause/Asym_Pause. Those
> bits describe the MAC's pause frame abilities.

No, MAC + PHY.

> They don't say whether pause
> can be negotiated, or forced while link autoneg is running.
> 
> Several drivers fail at least one of the four link autoneg / pause autoneg
> combinations:
> 
>   bnxt_set_pauseparam() returns -EINVAL for pause autoneg without
>   BNXT_AUTONEG_SPEED, which is what the uAPI describes.
> 
>   mlx5e_ethtool_set_pauseparam() returns -EINVAL for any pause autoneg
>   request.
> 
>   ixgbe_set_pauseparam() returns -EINVAL when
>   !ixgbe_device_supports_autoneg_fc().
> 
>   i40e_set_pauseparam() returns -EOPNOTSUPP whenever pause->autoneg !=
>   is_an. That already fails the link autoneg on / pause autoneg off step.

That's why we write those tests

> 
> pause_advertising_test() has a related problem because it only skips on
> EOPNOTSUPP. It treats an EINVAL refusal of pause autoneg from mlx5, bnxt or
> ixgbe as applied. It then checks the advertisement against a configuration
> the device never accepted.
> 
> [ ... ]
> 
>> +def pause_advertising_test(cfg, pauseparams):
>> +    """Pause advertisement
> 
> [ ... ]
> 
>> +    The validation is made by looking at the advertised modes locally, as well
>> +    as what the peer's 'lp_advertising' values report.
>> +    """
> 
> [Severity: Low]
> Is the lp_advertising part of this docstring accurate for this patch?
> 
> The body never queries the peer. It only reads the local
> "advertised-pause-frame-use", which phy_ethtool_ksettings_get() copies from
> the software phydev->advertising bitmap.
> 
> wait_for_aneg(cfg) also returns success if the link hasn't dropped within
> 2 seconds:
> 
>         if not link_drop and time.monotonic() > restart_by:
>             return wait_for_link(cfg)
> 
> Together, these mean a MAC that never restarts autoneg, or a PHY that
> misprograms its advertisement register, would still pass.
> 
> A later commit in this series, "selftests: drv-net: pause: Validate the
> pause autonegotiation with a partner", adds controllable_lp() and a
> get_peer_pause_lp_advertising() check to pause_advertising_test(). That
> closes the gap by the end of the series.
> 
> [ ... ]
> 
>> +    # It's OK to skip here, we're already validating the EOPNOTSUPP behaviour
>> +    # the pause_test_support test.
>> +    ret = set_local_pauseparams(cfg, rx, tx, True)
>> +    if ret == errno.EOPNOTSUPP:
>> +        raise KsftSkipEx(f"RX {rx} TX {tx} not supported")
>> +
>> +    # Wait for link parameters to re-negotiate and link to come back up. It must
>> +    # come back up, otherwise that means changing pauseparams can bring the
>> +    # link down.
>> +    ret = wait_for_aneg(cfg)
> 
> [Severity: Medium]
> What happens when set_local_pauseparams() fails with something other than
> EOPNOTSUPP?
> 
> The docstrings of set_local_pauseparams() and get_local_pauseparams() say
> "Raise an error if the return is not 0 or EOPNOTSUPP". Neither function
> raises. Both just return the result of ethtool_ret(), which uses
> cmd(..., fail=False).
> 
> Here, an EINVAL, an EBUSY, or ethtool's raw exit code 1 is silently dropped,
> and ret is overwritten by wait_for_aneg(). The advertising checks then run
> against whatever state was there before, because pause_setup() does not
> put the pause params into a known state.

Ok will address

> 
> require_pause_supported_allof() has already confirmed that the modes are
> supported. So the result is either a false pass, or a failure with a
> "must advertise" message that blames the PHY. For example,
> mlx5e_ethtool_set_pauseparam() returns -EINVAL whenever pauseparam->autoneg
> is set.
> 
> [ ... ]
> 
>> +def main():
>> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
>> +        cfg.ethnl = EthtoolFamily()
> 
> [Severity: Low]
> This isn't a bug, but cfg.ethnl doesn't seem to be used anywhere in
> pause.py, since everything goes through the ethtool CLI. Can this
> assignment and the EthtoolFamily import be dropped? As it stands, if the
> ethtool genl family can't be resolved, the whole test aborts even though it
> doesn't need that family.

Ok

Maxime
