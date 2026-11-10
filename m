Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329706;
	b=CouCR6l3ZQJXo4jLf5tV9V+tqVyKI2Bm9oTgGsBvaVrHSqO3gpb5Hk9mOWiJKRcN90gT
	 RiGX6EGPWpVB73hpMBzK79vKOtDEQMokhpLPMHcDYvKZDFwCkZRstua0KkUCBlaXKN8bS
	 vIE/boj6vgPv7XH24qxSgnGF216ETqEG8HA2+loPUethv/1zpRidYNTdmbJa/bpY8+urF
	 DX33HaHqmuyJXbiI7OQLQmKYrJ2B3C2hAP0ItGV0ew+NP8/3v+CUbvz4q4AGCzPC1M/j6
	 o9vZIF8b0dFcDRWqs68zVywyh6Y65NZ2x3WJ3oCH+efu/bHMeclxG7wwmnbp0UHeE3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329706;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=isbxfz3UiMS6BAGuDcHb2c74CT9ZqDd3FKMUcfnnh9A=;
	b=MUEjb33PBc9jM9Rxr8OKmSCe4ANhEFkwlqOq1rzGB5L8vMYCHLjWwu9g1/79aUXsIsDn
	 uLJV2HDirMfbSF4+9MQd9Zc1UV2GIdVndgDBta5qJzjvALIE+N941EU1rPKUC71a8u6Pj
	 +MhTKz8I8MAGd/mM+fDKKWysJ4YoSVsb/3L1XIIbcBNnEeWJWPbzQgIv9hewQSi4YSZsR
	 q2MMWZ2LgykcFju51jRZL0czWXooWQb4tz2ezjv9wXQvq0GBCuRzC2tLidrgLasuy2Jxt
	 75eZFrexhk2VWYvW1OdAoCPLBtAPwfhx+EL2VB9lNxoQ9y75NKgzud7AH/N6TVhFGxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bku+3inp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB8606D205;
	Tue, 10 Nov 2026 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bku+3inp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD65D1F008A1;
	Tue, 10 Nov 2026 16:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329705;
	bh=isbxfz3UiMS6BAGuDcHb2c74CT9ZqDd3FKMUcfnnh9A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bku+3inpB6s40xCKruZ8rioHXG6AM10HcnKmAuxtHfMChVaSgU4+sSnK+iMHNZNOZ
	 /VpKsWGyYVrNy79lIEWm5FYWTxHL11EL8TrWdBiW3lkfb81bepZmw6KMWBYj012ZM8
	 cQxmJkDtoMvzXR7bHG93pvlsm046LIzpW+ve5VoPYt/Quqwv7RNkWpAuaZPgYU7+QO
	 wh1oQT8LaljJ9RDVIBsyB0dTP/BlaN1j0kGoFR9+u2mE/Tu1Xek458Ohouy51ssXuw
	 ifBsc42loeQbKicxn16BEJaceCnv1UN+NTzAQwxIzObPZX82/8lesTmZKGxB7JWW11
	 l1JDxnwxOcA6Q==
Subject:
 Re: [PATCH net-next 3/5] net: rnpgbe: Support copper link configuration
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, yaojun@mucse.com
Date: Tue, 10 Nov 2026 16:55:04 +0000
Message-ID: <179432970434.994134.8609700736232950683@kernel.org>
In-Reply-To: <D2E577671FEE0E12+20261106112533.44065-1-dong100@mucse.com>
References: <D2E577671FEE0E12+20261106112533.44065-1-dong100@mucse.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In the forced (autoneg disabled) branch of
  rnpgbe_set_link_ksettings(), `mode` is computed from…
- [Low] The commit message says only that set_link_ksettings support is
  added for copper ports.
- [Low] rnpgbe_set_link_ksettings() never checks the requested
  cmd->base.port or cmd->base.phy_address.
- [Low] When the requested autoneg is disabled,
  rnpgbe_set_link_ksettings() never reads or validates…

--

net: rnpgbe: Support copper link configuration

This adds a set_link_ksettings ethtool callback for copper ports in the
rnpgbe driver. It covers autonegotiation, advertised link modes, forced
10/100 Mb/s speed and duplex, and MDI/MDI-X selection. It also switches
mucse_mbx_set_link() to send PHY_LINK_SET through
mucse_write_mbx_coalesce_event().

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c
> index 3ff01a15961e3..cd3cca1474ec1 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c
> @@ -131,6 +131,93 @@ static int rnpgbe_get_link_ksettings(struct net_device *netdev,

[ ... ]

> +static int rnpgbe_set_link_ksettings(struct net_device *netdev,
> +				     const struct ethtool_link_ksettings *cmd)
> +{

[ ... ]

> +	err = rnpgbe_get_link_ksettings(netdev, &settings);
> +	if (err)
> +		return err;
> +	if (settings.base.port != PORT_TP)
> +		return -EOPNOTSUPP;

[Severity: Low]
This tests the port in the driver's own freshly fetched settings, not the
requested cmd->base.port. Should cmd->base.port and cmd->base.phy_address
also be checked here?

ethnl_set_linkinfo() in net/ethtool/linkinfo.c loads the current settings,
applies the user's changes, and passes the result to the driver:

    ethnl_update_u8(&lsettings->port, tb[ETHTOOL_A_LINKINFO_PORT], &mod);
    ethnl_update_u8(&lsettings->phy_address, tb[ETHTOOL_A_LINKINFO_PHYADDR],
                    &mod);

So "ethtool -s ethX port fibre" or "ethtool -s ethX phyad N" on a copper
port seems to return success. The requested port and PHY address are
silently dropped, and PHY_LINK_SET is still sent with the other fields. A
later get still reports PORT_TP and the old phy_addr.

For comparison, phy_ethtool_ksettings_set() rejects a phy_address mismatch
with -EINVAL.

> +
> +	supported = rnpgbe_fw_link_modes(settings.link_modes.supported);
> +	advertising = rnpgbe_fw_link_modes(settings.link_modes.advertising);
> +	if (autoneg) {

[ ... ]

> +	} else {
> +		if (cmd->base.duplex != DUPLEX_FULL &&
> +		    cmd->base.duplex != DUPLEX_HALF)
> +			return -EINVAL;
> +		switch (cmd->base.speed) {
> +		case SPEED_10:
> +			mode = cmd->base.duplex == DUPLEX_FULL ?
> +				RNPGBE_FW_ADV_10_FULL : RNPGBE_FW_ADV_10_HALF;
> +			break;
> +		case SPEED_100:
> +			mode = cmd->base.duplex == DUPLEX_FULL ?
> +				RNPGBE_FW_ADV_100_FULL : RNPGBE_FW_ADV_100_HALF;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		if (!(supported & mode))
> +			return -EINVAL;
> +	}

[Severity: Medium]
In the forced branch, mode is used only for the supported check and is
never assigned to advertising. Is it intended that advertising keeps the
old cached mask from settings.link_modes.advertising?

That mask can still contain RNPGBE_FW_ADV_1000_FULL and other modes. It is
sent to firmware as adv_speed_mask along with autoneg=0 and a forced speed
of 10 or 100.

The existing forced-mode caller narrows the mask to the forced mode before
sending PHY_LINK_SET:

rnpgbe_chip.c:rnpgbe_setup_default_link() {
    ...
	if (!autoneg) {
		advertising &= RNPGBE_FW_ADV_1000_FULL;
		speed = SPEED_1000;
		duplex = DUPLEX_FULL;
	}
    ...
}

The mucse_mbx_set_link() kernel-doc says only that firmware ignores speed
and duplex when autoneg is true. Nothing says adv_speed_mask is ignored
when autoneg is false.

For example, "ethtool -s ethX autoneg off speed 100 duplex full" on a port
that was autonegotiating with a 1000/100/10 advertisement would send the
whole stale mask. On success, that mask is also cached into
hw->link_config.advertising. A later get_link_ksettings then reports
1000baseT_Full as advertised while the link is forced to 100.

Should advertising be set to mode in this branch?

> +
> +	err = mucse_mbx_set_link(&mucse->hw, advertising, autoneg,
> +				 autoneg ? 0 : cmd->base.speed,
> +				 autoneg ? 0 : cmd->base.duplex, mdix);
> +	if (!err) {
> +		mucse->hw.mdix_ctrl = mdix;
> +		mucse->hw.link_config.advertising = advertising;

[Severity: Low]
When autoneg is disabled, cmd->link_modes.advertising is never read or
validated. The old cached mask is written back here and the call returns
success. Can a user-requested advertising mask be silently lost this way?

ethnl_update_linkmodes() applies ETHTOOL_A_LINKMODES_OURS to
ksettings->link_modes.advertising whatever the autoneg state is. So
"ethtool -s ethX advertise <mask>" on a port in forced mode returns 0, but
the new mask is thrown away.

A later "ethtool -s ethX autoneg on" builds cmd from
rnpgbe_get_link_ksettings(), which returns the old cached mask. The
requested advertisement therefore never takes effect.

Also, bits outside the supported set get -EINVAL in autoneg mode but are
silently accepted in forced mode.

> +		mucse->hw.link_config.speed = autoneg ?

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> index 469818b83d70f..7af56fce2e229 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> @@ -236,7 +236,7 @@ int mucse_mbx_set_link(struct mucse_hw *hw, u32 advertising, bool autoneg,
>  
>  	len = le16_to_cpu(req.r.datalen);
>  	mutex_lock(&hw->mbx.lock);
> -	err = mucse_write_and_wait_ack_mbx(hw, req.dwords, len);
> +	err = mucse_write_mbx_coalesce_event(hw, req.dwords, len);

[Severity: Low]
This isn't a bug, but the commit message only describes adding
set_link_ksettings. It doesn't mention this change to the mailbox
transport used for PHY_LINK_SET.

mucse_write_mbx_coalesce_event() goes through
mucse_write_mbx_pf_coalesce_event(), which calls mucse_ack_pending_event()
before writing the command:

    err = mucse_ack_pending_event(hw);
    if (err)
        goto release;

This acknowledges any pending firmware LINK_CHANGE_EVT without consuming
its snapshot. It also adds a new -EIO return path for when the firmware
request counter reads 0.

It also changes the behaviour of the existing probe-time caller,
rnpgbe_setup_default_link().

The change is probably needed. PHY_LINK_SET can now be issued at runtime
while link event reporting is enabled, which is the same case as
mucse_mbx_phyup() and mucse_mbx_link_report(); both already use the
coalescing variant.

Could the reason be stated in the commit message, or the change split into
its own patch?

>  	mutex_unlock(&hw->mbx.lock);
>  
>  	return err;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/FB722C2F25FE9005%2B20261106112420.43050-1-dong100%40mucse.com
