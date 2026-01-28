Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16FD37C117
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769677131; cv=none; b=p/BtBdfc9jkHesWFNP+Hrks59pUf8dTlv6olZDj0QE4iwR00B8QjL+X94tuZPL/Q4XhCFB7zzR0aq++KDdb4+r5nQpUTjTUp0QkD4DiJ3frj4gx1KE9de1yr+aNgiMQZhL/gMEe7eV/Nsosd7+fXnQuPdN0WEpkfzojRf5TvL8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769677131; c=relaxed/simple;
	bh=vGP1YcOzisZFk3goy+byrCsiUTgc94En+9zxANd8jHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxGe62C0Z7c4uqUOXJVP7txBE2NYqQxR4e16/wan050Iz9ZXOKBzB3ZYCfRRxSigLhdn010USsdbxqUy7cV6dkds/LjGz0z0Ooeu0Trg0ClREFtUu5sagIOpa30PRFMR7SCpnSGYufEt2utd3lieXo8DVl4/CqB/bKwMX/gCNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rkgg6Ksu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rkgg6Ksu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 883434E42312;
	Thu, 29 Jan 2026 08:58:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D1F8606B6;
	Thu, 29 Jan 2026 08:58:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 53D20119A884F;
	Thu, 29 Jan 2026 09:58:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769677127; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0lpsejodSfO2xeC8iceURSJ0Dhu9I3pcZF7RZAekES0=;
	b=Rkgg6Ksuvq7N4GdoXrmEAVQhA4PKZDw5xC9FSmu/4I1vTUxzbBp94GByBQzvuOZKeqEM8V
	Ww701W29KEVD+G0O/E9U/efovoa6xg+lfxLefejJguK6nexr2sacrYJGTPHW2b4GPY3EnE
	GAaGqO9uKqxgQ1IltJESEyPtcS6kYtYxXjP3jAzvvemBtNqy6n/W7qGphU58XDR+o+CqIS
	NcgqVY3ztdcVNhFvFzFYsyG0TMUpbP64rykuALRIb4M3SUYnp0Qzq/NJSRs/GMUytm2zyX
	8lfbaXWp92KOYFvZoIp4y1nKArsgFWyuebITTozZ16PYBWGLz7u70TZTcmO2AQ==
From: Romain Gantois <romain.gantois@bootlin.com>
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
 Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject:
 Re: [PATCH net-next 08/13] net: phylink: Represent PHY-less SFP modules with
 phy_port
Date: Wed, 28 Jan 2026 17:01:24 +0100
Message-ID: <3029118.e9J7NaK4W3@fw-rgant>
In-Reply-To: <20260127134202.8208-9-maxime.chevallier@bootlin.com>
References:
 <20260127134202.8208-1-maxime.chevallier@bootlin.com>
 <20260127134202.8208-9-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3394203.aeNJFYEL58";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart3394203.aeNJFYEL58
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Wed, 28 Jan 2026 17:01:24 +0100
Message-ID: <3029118.e9J7NaK4W3@fw-rgant>
In-Reply-To: <20260127134202.8208-9-maxime.chevallier@bootlin.com>
MIME-Version: 1.0

On Tuesday, 27 January 2026 14:41:56 CET Maxime Chevallier wrote:
...
> @@ -1786,13 +1787,31 @@ static int phylink_create_sfp_port(struct phylink
> *pl) else
> 
>  		pl->sfp_bus_port = port;
> 
> +	if (pl->mod_port) {
> +		ret = phy_link_topo_add_port(pl->netdev, pl->mod_port);
> +		if (ret)
> +			goto out_bus_port;
> +	}
> +
> +	return 0;
> +out_bus_port:
> +	phy_link_topo_del_port(pl->netdev, port);

This seems strange to me. Why clean up after phy_link_topo_add_port() if it 
returned an error code? Presumably phy_link_topo_add_port() cleans up after 
itself if it encounters an error doesn't it?

> +	phy_port_destroy(port);
> 
>  	return ret;
>  
>  }
>  
>  static void phylink_destroy_sfp_port(struct phylink *pl)
>  {
> 
> -	if (pl->netdev && pl->sfp_bus_port)
> -		phy_link_topo_del_port(pl->netdev, pl->sfp_bus_port);
> +	if (pl->netdev) {
> +		if (pl->sfp_bus_port)
> +			phy_link_topo_del_port(pl->netdev, pl->sfp_bus_port);
> +
> +		/* Only remove it from the topology, it will be destroyed at
> +		 * module removal.
> +		 */
> +		if (pl->mod_port)
> +			phy_link_topo_del_port(pl->netdev, pl->mod_port);
> +	}
> 
>  	if (pl->sfp_bus_port)
>  	
>  		phy_port_destroy(pl->sfp_bus_port);
> 
> @@ -3998,6 +4017,49 @@ static void phylink_sfp_disconnect_phy(void
> *upstream, phylink_disconnect_phy(upstream);
> 
>  }
> 
> +static int phylink_sfp_connect_nophy(void *upstream)

I'd name this "phylink_sfp_connect_no_phy" just to keep the name formatting 
consistent.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart3394203.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAml6MtQACgkQKCYAIARz
eA6u3w/+N/ctzBbYD6Ll0Ehaf69tTIzVqSV6sLi7X3t7ODunMDatH8KKVJc+zO17
XtwU+N2KCLU75+oEj8xL/k/kfdJILn/abR2JNvaIyKd43skyI3g7kpXGxjfA/0zp
tJmBqbW3IdQhMFulDfzvKd7Dm7L07zKGM0oP5HmY8loBEdzjKSLLN6aG5CPsx/7x
93zL9D7XYNvmyMdzt4vBQiSaTGG7swxs2oBmSewO5TjrrtMFHkG5RRqC5T4++WyF
e9VpENxEvnNB20MrYDYZ9Zt51id3mGurVgMyE5cGIQeBdG1xkPfdkJTml9bywMTv
HmJGJ6DQkqMSFD9v62+GD2e5l8KcnRSNPmJJMRsVnsDD3B03mYqmsVMnSgVHxbqx
A2P7GBMTaWrqUqwM2GyD/FQKnKIhooTJXPitNwwN14PFrEz0ShR56WAOfXoPRSRX
sVoiCipaSoL2+fj1Z6Wp7uiJzRKFDprw25GxFTUn2IDn/Fw+4F8QGzq5OPk5R6dN
SF5171FMUSCXXgRpkado2Q9TiEb3S+fF/hJrI54NkLM7MLjx5okYju8+jK+UcPMK
Pp2/QrcWg2KjGHnCE5X2m9G56/nfl7bS0SQcgqrOgZzcR/hN9fvYAArrxcHy9xDB
UfltOo7Oum1LEPx57Mq+Nmu//jeqbGjSfvSpcsaUSHKscSOK+DI=
=qqwZ
-----END PGP SIGNATURE-----

--nextPart3394203.aeNJFYEL58--



