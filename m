Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061653DD503;
	Fri, 17 Jul 2026 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283206; cv=none; b=f6pPj24uIDWzWEppQ8GrjM9IBBZyFqNxHGVZC/w/7OP+4N+u7sE5C9JMfaJyn9Zpk8l/iGqpdn4aR+6KyC+TdU84ZFZKVhqz2l+ZCp8QLyb6szkHUAzm7UkWyOAi9BDY8QAR3rUbr6CbssilKtk5DN/Girctmrh3r/sxSf3Uk5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283206; c=relaxed/simple;
	bh=NUDLhNU0cH5W51yMWSOmqTceiw8CjDcNSEHEUcLiW4M=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=Wcf2lfwETa8b/K4AAA9a+KvsANP0Furx4emCm9Ps5Of/ysvrZTCtqRaLtilMD/8ooXWyV0fjcRzizVNyyoeZ3gTFwhs8EkqodnbNTkfZtUeW5LRh6q/0AzGObzLmeICnX/HQV0gTP2zmksoP/uOxhdS1jkVACDy8DGdXCrKZJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ghh9U393; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghh9U393"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 250171F000E9;
	Fri, 17 Jul 2026 10:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784283204;
	bh=1lLq0UYWgzE5wPZezyYaUbWQqszAIJGtPsskcQ/iwvM=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To;
	b=Ghh9U393rjYaCJuOIz4l4k9twsxflbke8mCHjtLhQzOvIj8f4qxMlPkNCx6xk1x1U
	 zoktCZLJRDQ3qE9mCfUsUgWIqt06qgGJndih+Tuqhg8FRzbHmmtjcWllxvmj6tOLmg
	 9HaP0eej5Jqce6rEN/Unv7d/u+lCuplmi0wAdM0Qe9olJBilljqcmY8mjL2LxVCQUv
	 jCenTnrk35pK/uBuU9EL8RYrMQqY78R1eAuuhyTv66ziSub8BJvMAQsXE93r3Udg0T
	 Qu1Kbrxk2v7HYKDifiEFx5eHD79Edt7GH0rGe4oEBQCdT+2AGloCfgA1G98K4eOitI
	 Eo+DpDW/dxaUQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=78a08f9f452e204ecc02be00c5dbafbb530578c24d97049daa16d0472d34;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 17 Jul 2026 12:13:20 +0200
Message-Id: <DK0RLUBEKFVS.168UHY5BP8D4E@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Paolo Abeni" <pabeni@redhat.com>, "Sean Anderson"
 <sean.anderson@linux.dev>, "Madalin Bucur" <madalin.bucur@nxp.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>
Subject: Re: [PATCH net v2] net: dpaa: fix mode setting
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20260710143430.2276141-1-mwalle@kernel.org>
 <a5c5b8a6-85a8-7830-e19b-ffd5de750e3c@linux.dev>
 <DJUZ1VG8U9SL.2W0CJM7NSMK2@kernel.org>
 <2c8f63f5-f04a-4abc-9508-4c47a80da543@redhat.com>
In-Reply-To: <2c8f63f5-f04a-4abc-9508-4c47a80da543@redhat.com>

--78a08f9f452e204ecc02be00c5dbafbb530578c24d97049daa16d0472d34
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Jul 17, 2026 at 12:01 PM CEST, Paolo Abeni wrote:
> On 7/10/26 4:47 PM, Michael Walle wrote:
>> On Fri Jul 10, 2026 at 4:39 PM CEST, Sean Anderson wrote:
>>> On 7/10/26 10:22, Michael Walle wrote:
>>>> Before converting to the phylink interface, the init function would ha=
ve
>>>> set the correct I/F mode depending on the maximum link speed of an
>>>> interface. After converting to phylink, the established link speed
>>>> is used to determine this setting and is set in the .link_up()
>>>> callback. The callback isn't called because the link is never
>>>> established between the PCS and a connected SGMII PHY.
>>>> To fix it, don't use the current speed, but set the mode depending on
>>>> the interface (which implies the maximum speed) in .mac_config().
>>>>
>>>> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
>>>> Suggested-by: Sean Anderson <sean.anderson@linux.dev>
>>>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>>>> ---
>>>> FWIW, I dropped setting a non-reserved mode in init(). The hardware
>>>> default is 0 and the mac_config() will set a valid mode anyway.
>>>>
>>>> Changes in v2:
>>>>   - the setting is/was based on the maximum speed, not the current
>>>>     speed. thus, move the setting into mac_config().
>>>>   - Link to v1: https://lore.kernel.org/r/20260706121011.1948906-1-mwa=
lle@kernel.org/
>>>>
>>>>   .../net/ethernet/freescale/fman/fman_dtsec.c  | 26 ++++++++++-------=
--
>>>>   1 file changed, 14 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/driver=
s/net/ethernet/freescale/fman/fman_dtsec.c
>>>> index fe35703c509e..7075f93bab49 100644
>>>> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>>> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>>> @@ -900,22 +900,28 @@ static void dtsec_mac_config(struct phylink_conf=
ig *config, unsigned int mode,
>>>>   {
>>>>   	struct mac_device *mac_dev =3D fman_config_to_mac(config);
>>>>   	struct dtsec_regs __iomem *regs =3D mac_dev->fman_mac->regs;
>>>> -	u32 tmp;
>>>> +	u32 ecntrl, maccfg2;
>>>> +
>>>> +	maccfg2 =3D ioread32be(&regs->maccfg2);
>>>> +	maccfg2 &=3D ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE);
>>>>  =20
>>>>   	switch (state->interface) {
>>>>   	case PHY_INTERFACE_MODE_RMII:
>>>> -		tmp =3D DTSEC_ECNTRL_RMM;
>>>> +		ecntrl =3D DTSEC_ECNTRL_RMM;
>>>> +		maccfg2 |=3D MACCFG2_NIBBLE_MODE;
>>>>   		break;
>>>>   	case PHY_INTERFACE_MODE_RGMII:
>>>>   	case PHY_INTERFACE_MODE_RGMII_ID:
>>>>   	case PHY_INTERFACE_MODE_RGMII_RXID:
>>>>   	case PHY_INTERFACE_MODE_RGMII_TXID:
>>>> -		tmp =3D DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>>>> +		ecntrl =3D DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>>>> +		maccfg2 |=3D MACCFG2_BYTE_MODE;
>>>>   		break;
>>>>   	case PHY_INTERFACE_MODE_SGMII:
>>>>   	case PHY_INTERFACE_MODE_1000BASEX:
>>>>   	case PHY_INTERFACE_MODE_2500BASEX:
>>>> -		tmp =3D DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>>>> +		ecntrl =3D DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>>>> +		maccfg2 |=3D MACCFG2_BYTE_MODE;
>>>>   		break;
>>>>   	default:
>>>>   		dev_warn(mac_dev->dev, "cannot configure dTSEC for %s\n",
>>>> @@ -923,7 +929,8 @@ static void dtsec_mac_config(struct phylink_config=
 *config, unsigned int mode,
>>>>   		return;
>>>>   	}
>>>>  =20
>>>> -	iowrite32be(tmp, &regs->ecntrl);
>>>> +	iowrite32be(ecntrl, &regs->ecntrl);
>>>> +	iowrite32be(maccfg2, &regs->maccfg2);
>>>>   }
>>>>  =20
>>>>   static void dtsec_link_up(struct phylink_config *config, struct phy_=
device *phy,
>>>> @@ -948,15 +955,10 @@ static void dtsec_link_up(struct phylink_config =
*config, struct phy_device *phy,
>>>>   	iowrite32be(tmp, &regs->ecntrl);
>>>>  =20
>>>>   	tmp =3D ioread32be(&regs->maccfg2);
>>>> -	tmp &=3D ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE | MACCFG2_FULL_DU=
PLEX);
>>>> -	if (speed >=3D SPEED_1000)
>>>> -		tmp |=3D MACCFG2_BYTE_MODE;
>>>> -	else
>>>> -		tmp |=3D MACCFG2_NIBBLE_MODE;
>>>> -
>>>>   	if (duplex =3D=3D DUPLEX_FULL)
>>>>   		tmp |=3D MACCFG2_FULL_DUPLEX;
>>>> -
>>>> +	else
>>>> +		tmp &=3D ~MACCFG2_FULL_DUPLEX;
>>>
>>> Did you test this when forcing 10/100 speed?
>>=20
>> No I didn't. Well I can't. I have a very weird board which only
>> supports 1000base-X (and copper SFPs in 1000basex autoneg mode). On
>> top of that there is a Marvell 88E1112 in between the SFP and the
>> MAC, for which the PHY driver is completely broken. Long story
>> short, I'm not able to test that (yet/at all? Not sure).
> FTR, sashiko suspect this patch will broke such setup:
> https://sashiko.dev/#/patchset/20260710143430.2276141-1-mwalle%40kernel.o=
rg

I've seen that, but.. that was the actual change between v1 and v2
as suggested by Sean. It does not depend on the actual link speed,
but the maximum link speed. So it is not relevant if the link
negotiates to a slower speed or not. At least that now matches the
behavior prior to the phylink conversion. If that was working -
that I can't tell you.

> I think we need either an explicit test from a 3rd party or a new revisio=
n.
I'm not sure what you mean with a v3. Going back to v1?=20

-michael

--78a08f9f452e204ecc02be00c5dbafbb530578c24d97049daa16d0472d34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaloAQBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/imbgGAl6emj98p4alddUGLjwyeaZ4La/pMFzpc
fySIbLIvVjaUdR1D3Ya1Air+xasyLSF4AX0cVQOnLLaipyDtzyNeyCMokluNtPYy
AQAgnG+qfXL44tEgxXdxE62/swKLxbMS4UY=
=2rY0
-----END PGP SIGNATURE-----

--78a08f9f452e204ecc02be00c5dbafbb530578c24d97049daa16d0472d34--
