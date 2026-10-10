Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39741379F;
	Sat, 10 Oct 2026 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661227; cv=none; b=HAdC3Ui0C6flJs76Eq1YPWgN59yvlPdZi3pjPR0DZh3nf5CepIdi+0CXO1FYJgdpqAmXkQJwuyC56WojHHyGcdbrDbyAiffmf9yCHmpkJMxZJ5s3ZqUZsiNd2/nre/ikmqeKO8rlq2M4OKYkLl78g0tk9ik0GG8BH7Y0wDIkQrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661227; c=relaxed/simple;
	bh=0EQU+GkSZWhtoqKEffihQbnwwfbBCaOl1+VHw3H0SXA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IjxsVjQcIWlJyP5p+t2vm2pQe+hVhjQKZdOclFF40Ni+e+PFYwS/AWM/c4k0TyvU+XDNwhYAdRwgqk4KnGZ+YPo14kZK1j6vjaDiV9pJh1nn3sJhB0D4Bm7K09T0bDP//nDaE6BKYEOkG7SNa0bmCSrmscYv2Np7QreWM38ZsU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAZJc6/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAZJc6/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20951F000FF;
	Sat, 10 Oct 2026 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791661222;
	bh=n7FMgQsJG0JL9AdaioBY80t6GhB51/Hn9e06noNEV04=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cAZJc6/fzXXLwSYclmzJMMdU6YTT23kj9hQSYATYBjTi0amp5lG+JCH3SSZgpMjNP
	 VLXBEUxf9Zdpi0hlgjIH2PFmpFHvRjNToL50zmOnWt5R343PfbUQzaaN3SO1bQtwcW
	 +SURBJIOJ3xqNqdfG5nz+H4GtPrJ5/uvO1Fic+Xz0eFRr5Cid1iwfceJ0F5pJBj/or
	 wtvqAXUD7h/3pmWjwNVMnP7UPSD2Qo1RoCFdc2nzPWB7nsHQOPNnhUeKWmyhcP0g/d
	 dJpZJ4qhzzz9c2r5pSbDGPkHuFf0puVMR0rNyII0zGlQw8zuDzBbE9fUmvx9AufQjF
	 FAExO+Gesn6Ig==
Subject: Re: [PATCH net-next v9 07/11] net: phy: ncn26000: Enable enhanced
 noise immunity
From: netdev-bot+sashiko@kernel.org
To: Selvamani.Rajagopal@onsemi.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 parthiban.veerasooran@microchip.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, richardcochran@gmail.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 edumazet@kernel.org, piergiorgio.beruto@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, jerry.ray@microchip.com, ciprian.regus@analog.com
Date: Sat, 10 Oct 2026 19:40:20 +0000
Message-ID: <179166122031.434549.452402723237040482@kernel.org>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-7-dcefe1d0bf0d@onsemi.com>
References: <20261009-s2500-mac-phy-support-v9-7-dcefe1d0bf0d@onsemi.com>
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

- [Low] ncn26000_c45_plca_set_cfg() (drivers/net/phy/ncn26000.c) changes
  PLCA_EN (through genphy_c45_plca_set_cfg) and ENI (PHYCFG1 BIT(7)) as…

--

net: phy: ncn26000: Enable enhanced noise immunity

This commit wraps genphy_c45_plca_set_cfg() in a new
ncn26000_c45_plca_set_cfg() for the NCN26000. The wrapper sets the
vendor-specific ENI bit in PHYCFG1 when PLCA is enabled and clears it when
PLCA is disabled.

> diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
> index cabdd83c614f0..6d433f4e2c45d 100644
> --- a/drivers/net/phy/ncn26000.c
> +++ b/drivers/net/phy/ncn26000.c

[ ... ]

> @@ -100,6 +104,24 @@ static int ncn26000_read_status(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +/* Intercept PLCA enable/disable request to
> + * set the proprietary, ENI mode accordingly
> + */
> +static int ncn26000_c45_plca_set_cfg(struct phy_device *phydev,
> +				     const struct phy_plca_cfg *plca_cfg)
> +{
> +	int ret = genphy_c45_plca_set_cfg(phydev, plca_cfg);
> +	u16 eni_cfg = 0;
> +
> +	if (ret || plca_cfg->enabled < 0)
> +		return ret;

[Severity: Low]
Can PLCA_EN and ENI end up out of sync here when an MDIO access fails?

For a disable request (enabled == 0), genphy_c45_plca_set_cfg() clears
PLCA_EN first and only then does the other writes:

drivers/net/phy/phy-c45.c:genphy_c45_plca_set_cfg() {
    ...
	if (plca_cfg->enabled == 0) {
		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
					 MDIO_OATC14_PLCA_CTRL0,
					 MDIO_OATC14_PLCA_EN);
    ...
}

Suppose a later write in the same request fails (PLCA_CTRL1, TOTMR or
BURST). The early return above then skips the ENI update. The PHY would
run CSMA/CD with the PLCA-only ENI bit still set.

> +
> +	eni_cfg = (plca_cfg->enabled) ? NCN26000_PHYCFG1_ENI : 0;
> +	return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> +			      NCN26000_REG_PHYCFG1,
> +			      NCN26000_PHYCFG1_ENI_MASK, eni_cfg);

For an enable request (enabled > 0), genphy_c45_plca_set_cfg() sets
PLCA_EN as its last step and returns 0. If this phy_modify_mmd() on
PHYCFG1 then fails, PLCA stays enabled with ENI clear. Userspace still
gets an error.

genphy_c45_plca_get_cfg() does not report ENI, so ethtool cannot show the
mismatch. A later request that leaves out enabled (enabled == -1) will not
fix it either.

genphy_c45_plca_set_cfg() already leaves partial state behind on failure,
and resending the same request would bring both bits back in line. Even so,
would it make sense to roll back PLCA_EN (or ENI) on the error paths so the
two bits stay consistent?

> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d%40onsemi.com
