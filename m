Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356324;
	b=MEJo3scfnazvq8stEi/Td5CqPLHnn3/la6PO5RqjC3GQTcWjzr2jEvkpRUb0ljiYMYNw
	 FgD3jV2lXbLGsxDGjQTfOuogn6QFZXZXhf7RgUCHdC+svMUgkgX5/p9YXOgaBCjIq4IPc
	 M7k25HSBjsNlQZZkNUQHrVGXqYQ7Wbi90I12FMdAmv+wLJHIxQZj9hEjdC098BC3EkbVQ
	 e9ne1AzpJd+Un/nY8AFeW44ilSEe5NnF/TAp/lXEBZpdY6498lIpVLsHbMx6JeV5qewqE
	 bkC3zpCtZnMyBPJkKtGiiFmIp+tUZopIxtLIauEqwz/W7ceHr+Ms1hpLZ/A3LZlR44g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356324;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nXUAbONJWRbquGCrN98cTAy0A6Q5wUJFUZ/ZLpsBupo=;
	b=fwqxQ4YSAdcvTVY9Y5b+g0R/JuFf/EQyDrjdkgNUi34bwmkocunsrcn7kH1s9Yers3a5
	 DiKDZ3Gc+k6Fo66JUGkxoc+kh7GZE1xcO/cLU70O3gVwBmwY+YKo/DPGJ5tCEuL7Fp6nv
	 YLbX8HGeVMcacfUub/LmB6RE4IrOMxmNufbagZ12RlEbQjQDgspf/QXAChDKiknQFpFjP
	 yW5d5ylpu8yhbmbcPxOV0xBnyfb6M+AUgav/jBB0CZLyG8hJOXU1CFOYFNMQ3RkQJg7Bb
	 tRfWR/YhGQs7+X7ndLZcbGrDKY5G3mDy32b/MLHD+dWHrIo3RIydV7FwxpIrbkMlHGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1dBIOD2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEA6606A329;
	Fri, 30 Oct 2026 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1dBIOD2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E854F1F0093A;
	Fri, 30 Oct 2026 10:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793356323;
	bh=nXUAbONJWRbquGCrN98cTAy0A6Q5wUJFUZ/ZLpsBupo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z1dBIOD2lh0LvbFGjTNSaBTojwZKcKH02oVkBbLAmLRX9FAWDQEQSN/GGe94emKks
	 ovQ9aC3wNoBJeAfOdoUbQahebkMoaGHZtgMHownJl6elghjCgi/1JMyQ4UwAT8rjht
	 RweWEN6fw95SAcz0pSoEvAhw8NEoUYdsV99+KkV7/pTVIwWcYEd1bkcCxxGqSumt0o
	 m+sGa8CP30mEb1eZBvWzhVtVuNJMA6Cs79aMtS364Iv3YnpBbIlgykDd/BCfkJs+HM
	 lK8Veu0exd/9/p2PiUGjNNz12Mrs9lnnTy4LA5KTBE/b05EMEQ9tLdUHCJMAj1yrlb
	 w6b8siy4xKn9Q==
Subject: Re: [PATCH net v3 3/4] net: phy: as21xxx: force C45 OPs for AUTONEG
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 10:32:02 +0000
Message-ID: <179335632249.3134.18407266279899843480@kernel.org>
In-Reply-To: <20261028073024.25175-4-ansuelsmth@gmail.com>
References: <20261028073024.25175-4-ansuelsmth@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] as21xxx_config_aneg() (drivers/net/phy/as21xxx.c) never
  applies the requested master/slave role, and it clears any existing…
- [Medium] The commit message says the fix is only about configuring and
  restarting ANEG over C45.
- [Medium] net: phy: as21xxx: C45 forced setup in as21xxx_config_aneg()
  mismatches C22 read

--

net: phy: as21xxx: force C45 OPs for AUTONEG

This commit clears the C22 bit from devices_in_package in as21xxx_probe()
so the generic PHY helpers use C45 accesses. It also adds a custom
as21xxx_config_aneg() that configures and restarts autonegotiation through
the C45 MMD registers, and sets it as .config_aneg for all AS21xxx variants.

> diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
> index f5968eec11c85..81e9827873bf2 100644
> --- a/drivers/net/phy/as21xxx.c
> +++ b/drivers/net/phy/as21xxx.c

[ ... ]

> @@ -633,6 +640,56 @@ static int as21xxx_probe(struct phy_device *phydev)
>  	return aeon_dpc_ra_enable(phydev);
>  }
>  
> +static int as21xxx_config_aneg(struct phy_device *phydev)
> +{
> +	bool changed = false;
> +	u16 ctl = 0;
> +	int ret;
> +
> +	if (phydev->autoneg == AUTONEG_DISABLE)
> +		return genphy_c45_pma_setup_forced(phydev);

[Severity: Medium]
With autoneg off, this now programs the forced speed through the C45
PMA/PMD registers (MDIO_CTRL1 and MDIO_CTRL2 in MDIO_MMD_PMAPMD) and
turns AN off in MDIO_MMD_AN. Nothing in the driver writes the C22
MII_BMCR any more. Doesn't the read side still assume the C22 setup?

as21xxx_read_status() handles AUTONEG_DISABLE by calling
genphy_read_status_fixed(). That does a plain phy_read() of MII_BMCR
and derives phydev->speed and phydev->duplex from BMCR_SPEED1000,
BMCR_SPEED100 and BMCR_FULLDPLX. The VEND1_SPEED_STATUS switch after
it only overrides the 2.5G/5G/10G cases. For 10/100/1000 the reported
speed and duplex come straight from that BMCR read.

Since config_aneg no longer writes BMCR, those bits keep whatever value
was left there before, unless the PHY mirrors the PMA control into the
C22 BMCR. as21xxx_read_link() already says the normal C22 BMCR reports
inconsistent data on this PHY, which is why it reads the mapped copy at
AS21XXX_MDIO_AN_C22 + MII_BMCR. After something like
"ethtool -s <dev> speed 100 duplex full autoneg off", wouldn't
userspace see a stale speed or duplex that doesn't match what was
programmed?

On an MDIO bus that only implements C45 accesses, phy_read() of
MII_BMCR returns -EOPNOTSUPP. as21xxx_read_status() would then fail for
every forced speed, even though the forced configuration itself was
done entirely over C45.

Should the AUTONEG_DISABLE branch in as21xxx_read_status() use
genphy_c45_read_pma() instead, so the read path matches what
as21xxx_config_aneg() now programs? Or does the hardware keep the C22
BMCR in sync with the PMA control registers?

[Severity: Medium]
The commit message only talks about using C45 to configure and restart
ANEG. Does this also change what happens when autoneg is disabled?

Before this patch, phy_config_aneg()->genphy_config_aneg() handled forced
mode in __genphy_config_aneg():

drivers/net/phy/phy_device.c:__genphy_config_aneg() {
    ...
	} else if (phydev->speed < SPEED_1000) {
		return genphy_setup_forced(phydev);
	} else {
		linkmode_zero(fixed_advert);

		c = phy_caps_lookup(phydev->speed, phydev->duplex,
				    phydev->supported, true);
    ...
}

So a forced speed of 1000 or more was emulated through autonegotiation
with a single advertised mode. Forced 10/100 half duplex was accepted by
genphy_setup_forced().

A forced 1000 Mb/s link now writes the PMA speed/type and then turns AN
off through genphy_c45_an_disable_aneg(). 1000BASE-T needs AN to resolve
master/slave. Could something like "ethtool -s <dev> speed 1000 duplex
full autoneg off" stop getting a link, when it worked before?

genphy_c45_pma_setup_forced() also rejects half duplex:

drivers/net/phy/phy-c45.c:genphy_c45_pma_setup_forced() {
	/* Half duplex is not supported */
	if (phydev->duplex != DUPLEX_FULL)
		return -EINVAL;
    ...
}

phy_ethtool_ksettings_set() accepts DUPLEX_HALF with autoneg off, and the
PHY lists 10/100 half in phydev->supported. For a request like "speed 100
duplex half autoneg off", the error would propagate like this:

phy_state_machine()
  _phy_start_aneg()
    phy_config_aneg()
      as21xxx_config_aneg()
        genphy_c45_pma_setup_forced()   /* returns -EINVAL */
  phy_error_precise()
    WARN(1, ...)
    phy_process_error()

Would this trigger a WARN and leave the PHY in PHY_ERROR until the
interface is restarted?

> +
> +	ret = genphy_c45_an_config_aneg(phydev);
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		changed = true;
> +
> +	switch (phydev->master_slave_set) {
> +	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
> +		ctl |= CTL1000_PREFER_MASTER;
> +		break;
> +	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
> +		break;
> +	case MASTER_SLAVE_CFG_MASTER_FORCE:
> +		ctl |= CTL1000_AS_MASTER;
> +		fallthrough;
> +	case MASTER_SLAVE_CFG_SLAVE_FORCE:
> +		ctl |= CTL1000_ENABLE_MASTER;
> +		break;
> +	case MASTER_SLAVE_CFG_UNKNOWN:
> +	case MASTER_SLAVE_CFG_UNSUPPORTED:
> +		break;
> +	default:
> +		phydev_warn(phydev, "Unsupported Master/Slave mode\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ctl = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);

[Severity: Medium]
Doesn't this assignment throw away the master/slave bits the switch above
just set in ctl? Was |= intended here?

linkmode_adv_to_mii_ctrl1000_t() only returns ADVERTISE_1000HALF and
ADVERTISE_1000FULL. The phy_modify_mmd_changed() below has
CTL1000_ENABLE_MASTER, CTL1000_AS_MASTER and CTL1000_PREFER_MASTER in its
mask. That means the role bits in the mapped CTRL1000 register always
get written as 0.

A role can be requested through the DT timing-role property:
of_set_phy_timing_role() runs from phy_probe() and sets
phydev->master_slave_set, for example to MASTER_SLAVE_CFG_MASTER_FORCE.
With this code, the requested role would be ignored and cleared on every
config_aneg.

There is a second problem that remains even with |=.
MASTER_SLAVE_CFG_UNKNOWN and MASTER_SLAVE_CFG_UNSUPPORTED also break into
the same masked write. The generic code being replaced returns early in
those cases:

drivers/net/phy/phy_device.c:genphy_setup_master_slave() {
    ...
	case MASTER_SLAVE_CFG_UNKNOWN:
	case MASTER_SLAVE_CFG_UNSUPPORTED:
		return 0;
    ...
}

Could this wipe a role set by straps or firmware every time autoneg is
configured?

As a side effect, as21xxx_read_c22_lpa() can no longer reach this branch,
since it reads CTL1000_ENABLE_MASTER back from the same register:

	if (adv & CTL1000_ENABLE_MASTER)
		phydev_err(phydev, "Master/Slave resolution failed, maybe conflicting manual settings?\n");

The commit message doesn't mention any master/slave change. Is this
behaviour intended?

> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN,
> +				     AS21XXX_MDIO_AN_C22 + MII_CTRL1000,
> +				     ADVERTISE_1000FULL | ADVERTISE_1000HALF |
> +				     CTL1000_ENABLE_MASTER | CTL1000_AS_MASTER |
> +				     CTL1000_PREFER_MASTER, ctl);
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		changed = true;
> +
> +	return genphy_c45_check_and_restart_aneg(phydev, changed);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028073024.25175-1-ansuelsmth%40gmail.com
