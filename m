Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25CD3CC314;
	Fri, 10 Jul 2026 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676367; cv=none; b=OwDYcfOGseuwaYvyiOwyXsXCdwpe9xOa7HwjXfyNPjwXy1sbL3+4suMInKEA6hlUNkY5vn90UFaavjwXbQpsWJm27d11+Ztwf9MY/lHhMI34oBUNULGTKLmCoO4SZI0ELov9VkXbA9Va1gpfYYKo2hGecf7Yw+dB4kifL+tdyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676367; c=relaxed/simple;
	bh=lfEvmS0TvmN/PlDpVYAATcTxy/m6FfyvxxRHOSUUGIQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=EF8PQKerebrzBr+ZexYbIf//ToDL9A6B+EIi3fs4xeWb4zTeYbcJVrIgA15Zs+fBiN7DrRfS1NUScgE+SxVW7JPpZuPZvIsoqAjIkg8eUCfOab424lSDp8DCKnuKEmmELtpAYt/Ej7nC7sXSBmiEyW2aJlN3theP24wa4FyrLaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 532F03B7;
	Fri, 10 Jul 2026 11:39:16 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 11:39:16 +0200
Message-Id: <DJUSHXVKZ0OC.1VDMPW228IYHO@kernel.org>
To: "Sean Anderson" <sean.anderson@linux.dev>, "Madalin Bucur"
 <madalin.bucur@nxp.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Subject: Re: [PATCH net] net: dpaa: always set a valid mode I/F mode
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260706121011.1948906-1-mwalle@kernel.org>
 <cbfa2b2b-0ae8-9c96-f177-b503239edbd0@linux.dev>
In-Reply-To: <cbfa2b2b-0ae8-9c96-f177-b503239edbd0@linux.dev>

Hi,

On Fri Jul 10, 2026 at 1:45 AM CEST, Sean Anderson wrote:
> On 7/6/26 08:08, Michael Walle wrote:
>> Before converting to the phylink interface, the init function would have
>> set the correct mode in the maccfg2.
>
> So for reference, the old logic is
>
>         if (iface_speed < SPEED_1000)
>                 tmp |=3D MACCFG2_NIBBLE_MODE;
>         else if (iface_speed =3D=3D SPEED_1000)
>                 tmp |=3D MACCFG2_BYTE_MODE;
>
> which changes between nibble/byte mode depending on the max link speed
> (e.g. phylink_interface_max_speed). Notably, neither is set for 2.5G.

Ahh you're right, I totally missed, that the speed parameter was
actually max_speed, which was set by

  priv->speed =3D phy2speed[macdev->phy_if];
  priv->max_speed =3D priv->speed;

FWIW, in the DPAA RM I have, there is no 2.5G speed. Are you sure,
there are DTSEC controllers with 2.5Gbps support? The only board I
found in the device trees is the T1023RDB which is using the memac.

> Can you try moving this write to dtsec_mac_config?

That worked! At least for SGMII. I don't have a board with another
interface to test tough. I'll prepare a new version, making
phylink_interface_max_speed() public and setting the correct value
in .mac_config(). Alternatively, we could move
phylink_interface_max_speed() to the header as static inline, but
that function isn't that small.

> And check in the RM
> whether this is configured based on the interface (in which case we shoul=
d
> remove it from dtsec_link_up) or the link speed. And please also check wh=
at
> the correct behavior for 2.5G should be.

This is an excerpt from the RM:

I/F Mode (bits 22-23):
 This field determines the type of interface to which the MAC is
 connected. Its default is 00.
  00 Reserved
  01 Used for all 10Mbps and 100Mbps speeds
  10 Used for all 1Gbps speeds
  11 Reserved

So you could read it both ways? But since the older driver was using
the maximum interface speed..

> At one point I had the P-series RMs downloaded, but it appears I've mispl=
aced
> them...

FWIW, I think it's freely available as long as you're logged in with
your NXP account.

-michael

>
> --Sean
>
>> After converting, init will just
>> set 0 as the mode. According to the "QorIQ Data Path Acceleration
>> Architecture (DPAA) Reference Manual", this is a reserved value. In
>> fact, this will prevent the PCS to establish a link to a connected SGMII
>> PHY. In turn, mac_link_up() is never called. Fix it by setting a
>> non-reserved mode; mac_link_up() will then set the correct mode later.
>>=20
>> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> ---
>> FWIW, I've tested this with a Marvell 88E1112 PHY.
>>=20
>>   drivers/net/ethernet/freescale/fman/fman_dtsec.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/=
net/ethernet/freescale/fman/fman_dtsec.c
>> index fe35703c509e..566921d3a884 100644
>> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>> @@ -402,7 +402,10 @@ static int init(struct dtsec_regs __iomem *regs, st=
ruct dtsec_cfg *cfg,
>>   	tmp |=3D MACCFG1_TX_FLOW;
>>   	iowrite32be(tmp, &regs->maccfg1);
>>  =20
>> -	tmp =3D 0;
>> +	/* write a non-reserved mode, otherwise the PCS won't establish a link
>> +	 * and .mac_link_up() is never called.
>> +	 */
>> +	tmp =3D MACCFG2_NIBBLE_MODE;
>>  =20
>>   	tmp |=3D (cfg->preamble_len << MACCFG2_PREAMBLE_LENGTH_SHIFT) &
>>   		MACCFG2_PREAMBLE_LENGTH_MASK;

