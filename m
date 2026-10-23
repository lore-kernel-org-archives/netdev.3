Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792726620;
	b=u30eaKABYeK3/6Qu7iRhWDbe5vbpkutoWjJ3A4Y21zK/UQpei6iieNxXSRM6hCiJGSxM
	 +Djiz3MWUtgcrh/sQwJgyzATOk9i7yXHiv1iCrGUuFbLZRTVrICy8bO7wJ4b2O1Fys4s8
	 EXjjSrmADMp1uGhMT1J3zyZYSY8CHnZ7y9XKQbo8LiCncv1nO93kDPXiSN1EfK9AzHq1+
	 pfDQo5RyjcPiIG1eiAtAOCvrcsuANRsa8My4Kjq7jn5fbq14UcMd9wCRUtL5fVBjM8NoV
	 XZ81b4JJgMTiG+u+9+AwBhU6T2G93jcOszW+bKe6vJ2XkRRjCby84qwO3Vni7S1fylw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792726620;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VSK4iD4EjmWjiJtf5thjnzIVIhrJkHR4uoGySQ3KmKQ=;
	b=C48AbL+qSEH0ofeTp2SvGK2APWDINMf+jBm4wL6dt4Pl3zurGIap9OI9HJL5WFHT4fkr
	 ySfC8uy8WLShmHmBiwn5PvDHjHMO66ioFOD6DaRhXwM1IB6ReHIfd9s87ChviBwTi1zuC
	 FbKsHtAbn5XSXecv13wKoLfhMEUwpstMhPzbugZS+0en4//7E10gKVLCuRcKEYoHoHL/Y
	 2OH9hfukb4V9YCx1JwfoHZDriN9K6Q8o0fB7NXYiw5pNKamJif1S8AfJVFpqFOYiLshmI
	 kMou3HsecEZDT9dxnmHE5UZZ81zKD/GJIA1deqwEE4wO0eMc6l8oVoBBF/cNAGj+6NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRdsaRgc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC29606A330;
	Fri, 23 Oct 2026 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRdsaRgc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2474E1F01825;
	Fri, 23 Oct 2026 03:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792726619;
	bh=VSK4iD4EjmWjiJtf5thjnzIVIhrJkHR4uoGySQ3KmKQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VRdsaRgcfj0KcfjXaQr4A0LJ6XX4Te5ZtCCC8ZU+2EVT9M1nYY8h2tdyTBQE/Cp5H
	 +FXdHoWM4dXRjDHQNaH6xEruMGubQ97hosWp74B367r2d7wDv7fQRL9CEAbbEHzQ6g
	 b3M7HeMgdnEgRLzcs8jtgi1x1Kgz2tlXQ2vD3boWGq3mLmzgbGnM+3P9dFOkk3r3z+
	 SMn007fBWnqidmrrr157SMNrt7aVP5/dW7QhnpJXi3qHpqUmRo4iWOwHEeCJGYwMyj
	 qEq/dzaS2AiQglMap3SfnPFdrfjunFUY3HlLu3go7vzyQnQcqlsPuLURNJ2MKGIsnB
	 EUc1s8SduggFg==
Subject: Re: [PATCH net-next v3 3/5] net: phy: mxl-gpy: release MxL86211C
 Super Isolate
From: netdev-bot+sashiko@kernel.org
To: robert.marko@sartura.hr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org,
 michael@walle.cc, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lrosu@maxlinear.com, luka.perkov@sartura.hr
Date: Fri, 23 Oct 2026 03:36:57 +0000
Message-ID: <179272661768.3134.14209307065475581355@kernel.org>
In-Reply-To: <20261020093655.344585-3-robert.marko@sartura.hr>
References: <20261020093655.344585-3-robert.marko@sartura.hr>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The concern is that the patch lacks a Fixes: tag.

--

net: phy: mxl-gpy: release MxL86211C Super Isolate

This patch releases Super Isolate mode on the MxL86211C PHY in
mxl86211c_probe(), before gpy_probe() reads the firmware version. It
also adds a new mxl86211c_config_init(), which reapplies the optional
VDDP MDIO voltage and releases Super Isolate again after each hardware
reset.

> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> index 952272faac1e..dba0777158b2 100644
> --- a/drivers/net/phy/mxl-gpy.c
> +++ b/drivers/net/phy/mxl-gpy.c

[ ... ]

> +static int mxl86211c_config_init(struct phy_device *phydev)
> +{
> +	struct gpy_priv *priv = phydev->priv;
> +	int ret;
> +
> +	if (priv->vddp) {
> +		ret = mxl86211c_configure_mdio_voltage(phydev, priv->vddp);
> +		if (ret)
> +			return ret;
> +	}

[ ... ]

> @@ -456,6 +481,10 @@ static int mxl86211c_probe(struct phy_device *phydev)
>  			return ret;
>  	}
>  
> +	ret = mxl86211c_release_super_isolate(phydev);
> +	if (ret)
> +		return ret;
> +
>  	ret = gpy_probe(phydev);
>  	if (ret)
>  		return ret;

[Severity: Low]
This isn't a bug, but should this patch have a Fixes: tag?

Commit 9d844da693d6d ("net: phy: mxl-gpy: add support for MxL86211C")
added MxL86211C support without any Super Isolate handling. Boards
strapped into Super Isolate would never have come up with that driver.

That said, this looks more like support for a strap configuration the
driver never handled than a fix for a regression.

There is also a dependency. mxl86211c_config_init() uses priv->vddp
and mxl86211c_configure_mdio_voltage(), which come from the previous
patch in the series ("net: phy: mxl-gpy: add MxL86211C VDDP supply").
A Fixes: tag pointing at 9d844da693d6d would trigger a stable backport
that does not apply on its own.

Leaving the tag off seems reasonable for a net-next feature series.
I am raising it only in case the maintainers see it differently.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020093655.344585-1-robert.marko%40sartura.hr
