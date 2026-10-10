Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1633E40BCA1;
	Sat, 10 Oct 2026 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645058; cv=none; b=FHQMsMlsJinpcb9w39VWKZ35N1kqDbSbR5EZpXPv13iF9f6kON1DppjTCOu+kMQvXypJQ4co/RQ8hXPg+MWWQVDij5LwXusBaXgPA36SBQOCi6LUt01358Gfs51vsjMl2Olz7cjh/ILg/+eNm4H+OKpknarfUe6H2T1FS169X/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645058; c=relaxed/simple;
	bh=0oaSZXavh0VPywhkz9FM89pdvE52NHwD0aRS4G1mjoE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Icxp+dfEnHgcQntSjv1XbwcLWhV5wJeveddUbazno7HzIWAmJxfuFGP/HMjoee3Neob4pbquQPdDxqFI65SJgG1RUnEsh03peb0Is4rkTkkuyqYdvCjpzzl6AinN4zXCgANkqDaZeNEEC2PbMXHTl+aqmYBo8aUCJfDg94Pa72U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyL0LUwh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyL0LUwh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5E71F00893;
	Sat, 10 Oct 2026 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791645057;
	bh=nPBRX1gqtm+aEE4hdxbhlP1G5u0gwwOkBFQuWDmB0Es=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dyL0LUwhktifT3hRLEuyuhGlJ+GR1xplBs1Zr/uABXSWIqYZBWYdI7iopxK/mdq9h
	 1ZZ9IaFCvt8mWw10GL/3y6pe7Uv05L1RT1STBmk5gXChv9XknG3+WEZXO/PM62AHA1
	 HgLz9IBkizBWaBSGmljZkHVPdTLpJgXPoHbT7FrOm/iKPv3P7QWdAe5E66cm74dHqn
	 0gifM/ygIyw3aUyjZeGRgM2B5VbzgbBKwt9SuiPa8A9OA7fCxRd5OYEYt0RNTOTJ8l
	 dIurdksdBwGvJDNTysgLToUAMeqSxD7dgt6WsPmBgxlfT85XbwsZMbJv5t0GUwM/xt
	 RrnFZN7QEcnwg==
Subject: Re: [PATCH net-next 2/5] net: phy: broadcom: use timestamped MDIO
 writes in gettimex64
From: netdev-bot+sashiko@kernel.org
To: jjc@jclark.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
 richardcochran@gmail.com, florian.fainelli@broadcom.com, opendmb@gmail.com,
 nb@tipi-net.de, theo.lebrun@bootlin.com, linux@armlinux.org.uk,
 conor.dooley@microchip.com, bcm-kernel-feedback-list@broadcom.com,
 tglx@kernel.org, mlichvar@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 15:10:55 +0000
Message-ID: <179164505534.434549.5615465330719880368@kernel.org>
In-Reply-To: <20261009143506.2507607-3-jjc@jclark.com>
References: <20261009143506.2507607-3-jjc@jclark.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In bcm_ptp_framesync_ts() the new branch uses the bounds from
  bcm_ptp_framesync_sts() -> bcm_phy_write_exp_sts() ->…
- [Low] At this commit, no MDIO bus controller implements bus->write_sts.

--

net: phy: broadcom: use timestamped MDIO writes in gettimex64

This patch adds bcm_phy_write_exp_sts() to bcm-phy-lib, which uses
__phy_write_sts() for the EXP_DATA write. When the MDIO bus supports
timestamped writes, bcm_ptp_framesync_ts() now uses it, so the gettimex64
system timestamps only bracket completion of the write that triggers the
framesync. Otherwise the existing prets/postts path is still used.

> diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
> index 65d609ed69fb4..2d8b377010bdb 100644
> --- a/drivers/net/phy/bcm-phy-ptp.c
> +++ b/drivers/net/phy/bcm-phy-ptp.c
> @@ -214,22 +214,34 @@ static void bcm_ptp_framesync(struct phy_device *phydev, u16 ctrl)
>  	bcm_phy_write_exp(phydev, NSE_CTRL, ctrl | NSE_CPU_FRAMESYNC);
>  }
>  
> +static int bcm_ptp_framesync_sts(struct phy_device *phydev, u16 ctrl,
> +				 struct ptp_system_timestamp *sts)
> +{
> +	return bcm_phy_write_exp_sts(phydev, NSE_CTRL,
> +				     ctrl | NSE_CPU_FRAMESYNC, sts);
> +}
> +
>  static int bcm_ptp_framesync_ts(struct phy_device *phydev,
>  				struct ptp_system_timestamp *sts,
>  				struct timespec64 *ts,
>  				u16 orig_ctrl)
>  {
>  	u16 ctrl, reg;
> -	int i;
> +	int i, err = 0;
>  
>  	ctrl = bcm_ptp_framesync_disable(phydev, orig_ctrl);
>  
> -	ptp_read_system_prets(sts);
> -
>  	/* trigger framesync + capture */
> -	bcm_ptp_framesync(phydev, ctrl | NSE_CAPTURE_EN);
> -
> -	ptp_read_system_postts(sts);
> +	if (sts && bcm_phy_supports_write_exp_sts(phydev)) {

[Severity: Low]
Can this branch be reached at this point in the series?

bcm_phy_supports_write_exp_sts()->phy_supports_write_sts()->
mdiobus_supports_write_sts() just returns bus->write_sts. In this tree,
the only place that sets write_sts is mdio_mux_init(), and it only
forwards the parent bus's callback:

drivers/net/mdio/mdio-mux.c:mdio_mux_init() {
    ...
		if (parent_bus->write_sts)
			cb->mii_bus->write_sts = mdio_mux_write_sts;
    ...
}

So bcm_ptp_framesync_sts() is never called yet, and gettimex64 behaves
the same as it did before this patch.

Later patches in the series add real implementers ("net: macb: implement
timestamped MDIO writes" and "net: mdio: bcm-unimac: implement timestamped
MDIO writes"), so this resolves once the whole series is applied.

Could the commit message say that the tighter bounds depend on those bus
drivers?

> +		/* cannot ignore error since sts may be uninitialized,
> +		 * but still poll for any triggered capture
> +		 */
> +		err = bcm_ptp_framesync_sts(phydev, ctrl | NSE_CAPTURE_EN, sts);

[Severity: Medium]
Can the PHC capture land after post_sts here?

This path is bcm_ptp_framesync_sts()->bcm_phy_write_exp_sts()->
__phy_write_sts(), and the bounds it produces are used unchanged as the
bracket around the PHC capture. The kernel-doc for __mdiobus_write_sts()
defines those bounds as bracketing completion, where:

    a transfer is considered complete on the rising edge of the MDC
    that clocks the last data bit.

The commit message says "The PHY captures its time a short delay after
the end of the write". However, nothing here adds that delay to post_sts
or shifts both bounds by a known offset.

struct ptp_system_timestamp documents post_sts as:

    @post_sts:	system time snapshot after capturing PHC

The bus implementations later in the series make this window about one
MDC period wide. unimac_mdio_sts_delays() uses 63.5 and 64.5 MDC periods
for the pre and post bounds, and macb shifts both bounds by the same
delay_ns.

If the MDC edge falls within the PHY capture delay of the upper end of
that window, the actual heartbeat capture happens after post_sts. Would
that give phc2sys or chrony a biased offset with an error bound that is
too small?

Until Broadcom confirms the delay, should post_sts be extended by a
conservative upper bound, such as the measured few tenths of a
microsecond?

> +	} else {
> +		ptp_read_system_prets(sts);
> +		bcm_ptp_framesync(phydev, ctrl | NSE_CAPTURE_EN);
> +		ptp_read_system_postts(sts);
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009143506.2507607-1-jjc%40jclark.com
