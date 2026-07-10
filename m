Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91822423A71;
	Fri, 10 Jul 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694849; cv=none; b=cjxZuYWxvMm9/Muzi0c55dclI+i7QgzSjgXLByfk73T7ge1RbBfCIAj1WLyzjpnFeSZ8rxFE+DMJdzlcQH9b+EQ7Tr6COz59QuXsWC/xxLhIdcZzYYf3CiHmDTxeaytwNLrXf0rCYQ/lKkUSS5FOw4T35rfMbW9LdszS7YcYpN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694849; c=relaxed/simple;
	bh=0jxv2UVmjG4b3H5M8fybUYp7q+5N7UU6o2pQTgtkXtc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=GYiy1/WgHPMg9EJWx5jQqOza/lOZAGe0Zi2baGHBFs2aiLZXwd77ZDoCM5ucdqvd18IO306ndBW7mGK+uBAPqnfzB85M3Q4VtO2CINUUzlVGSOmzQJFs2sWV+31zZvYsXCq40bX7Ei6dLKn+ZFTue+nJiAFpVsoE5QNvoxe8dCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 028853B7;
	Fri, 10 Jul 2026 16:47:24 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 16:47:24 +0200
Message-Id: <DJUZ1VG8U9SL.2W0CJM7NSMK2@kernel.org>
Subject: Re: [PATCH net v2] net: dpaa: fix mode setting
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Sean Anderson" <sean.anderson@linux.dev>, "Madalin Bucur"
 <madalin.bucur@nxp.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Russell
 King" <linux@armlinux.org.uk>
X-Mailer: aerc 0.20.0
References: <20260710143430.2276141-1-mwalle@kernel.org>
 <a5c5b8a6-85a8-7830-e19b-ffd5de750e3c@linux.dev>
In-Reply-To: <a5c5b8a6-85a8-7830-e19b-ffd5de750e3c@linux.dev>

On Fri Jul 10, 2026 at 4:39 PM CEST, Sean Anderson wrote:
> On 7/10/26 10:22, Michael Walle wrote:
>> Before converting to the phylink interface, the init function would have
>> set the correct I/F mode depending on the maximum link speed of an
>> interface. After converting to phylink, the established link speed
>> is used to determine this setting and is set in the .link_up()
>> callback. The callback isn't called because the link is never
>> established between the PCS and a connected SGMII PHY.
>> To fix it, don't use the current speed, but set the mode depending on
>> the interface (which implies the maximum speed) in .mac_config().
>>=20
>> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
>> Suggested-by: Sean Anderson <sean.anderson@linux.dev>
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> ---
>> FWIW, I dropped setting a non-reserved mode in init(). The hardware
>> default is 0 and the mac_config() will set a valid mode anyway.
>>=20
>> Changes in v2:
>>   - the setting is/was based on the maximum speed, not the current
>>     speed. thus, move the setting into mac_config().
>>   - Link to v1: https://lore.kernel.org/r/20260706121011.1948906-1-mwall=
e@kernel.org/
>>=20
>>   .../net/ethernet/freescale/fman/fman_dtsec.c  | 26 ++++++++++---------
>>   1 file changed, 14 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/=
net/ethernet/freescale/fman/fman_dtsec.c
>> index fe35703c509e..7075f93bab49 100644
>> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>> @@ -900,22 +900,28 @@ static void dtsec_mac_config(struct phylink_config=
 *config, unsigned int mode,
>>   {
>>   	struct mac_device *mac_dev =3D fman_config_to_mac(config);
>>   	struct dtsec_regs __iomem *regs =3D mac_dev->fman_mac->regs;
>> -	u32 tmp;
>> +	u32 ecntrl, maccfg2;
>> +
>> +	maccfg2 =3D ioread32be(&regs->maccfg2);
>> +	maccfg2 &=3D ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE);
>>  =20
>>   	switch (state->interface) {
>>   	case PHY_INTERFACE_MODE_RMII:
>> -		tmp =3D DTSEC_ECNTRL_RMM;
>> +		ecntrl =3D DTSEC_ECNTRL_RMM;
>> +		maccfg2 |=3D MACCFG2_NIBBLE_MODE;
>>   		break;
>>   	case PHY_INTERFACE_MODE_RGMII:
>>   	case PHY_INTERFACE_MODE_RGMII_ID:
>>   	case PHY_INTERFACE_MODE_RGMII_RXID:
>>   	case PHY_INTERFACE_MODE_RGMII_TXID:
>> -		tmp =3D DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>> +		ecntrl =3D DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>> +		maccfg2 |=3D MACCFG2_BYTE_MODE;
>>   		break;
>>   	case PHY_INTERFACE_MODE_SGMII:
>>   	case PHY_INTERFACE_MODE_1000BASEX:
>>   	case PHY_INTERFACE_MODE_2500BASEX:
>> -		tmp =3D DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>> +		ecntrl =3D DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>> +		maccfg2 |=3D MACCFG2_BYTE_MODE;
>>   		break;
>>   	default:
>>   		dev_warn(mac_dev->dev, "cannot configure dTSEC for %s\n",
>> @@ -923,7 +929,8 @@ static void dtsec_mac_config(struct phylink_config *=
config, unsigned int mode,
>>   		return;
>>   	}
>>  =20
>> -	iowrite32be(tmp, &regs->ecntrl);
>> +	iowrite32be(ecntrl, &regs->ecntrl);
>> +	iowrite32be(maccfg2, &regs->maccfg2);
>>   }
>>  =20
>>   static void dtsec_link_up(struct phylink_config *config, struct phy_de=
vice *phy,
>> @@ -948,15 +955,10 @@ static void dtsec_link_up(struct phylink_config *c=
onfig, struct phy_device *phy,
>>   	iowrite32be(tmp, &regs->ecntrl);
>>  =20
>>   	tmp =3D ioread32be(&regs->maccfg2);
>> -	tmp &=3D ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE | MACCFG2_FULL_DUPL=
EX);
>> -	if (speed >=3D SPEED_1000)
>> -		tmp |=3D MACCFG2_BYTE_MODE;
>> -	else
>> -		tmp |=3D MACCFG2_NIBBLE_MODE;
>> -
>>   	if (duplex =3D=3D DUPLEX_FULL)
>>   		tmp |=3D MACCFG2_FULL_DUPLEX;
>> -
>> +	else
>> +		tmp &=3D ~MACCFG2_FULL_DUPLEX;
>
> Did you test this when forcing 10/100 speed?

No I didn't. Well I can't. I have a very weird board which only
supports 1000base-X (and copper SFPs in 1000basex autoneg mode). On
top of that there is a Marvell 88E1112 in between the SFP and the
MAC, for which the PHY driver is completely broken. Long story
short, I'm not able to test that (yet/at all? Not sure).

-michael

>
>>   	iowrite32be(tmp, &regs->maccfg2);
>>  =20
>>   	mac_dev->update_speed(mac_dev, speed);
>
> If so,
>
> Reviewed-by: Sean Anderson <sean.anderson@linux.dev>



