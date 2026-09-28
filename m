Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96AD49738C;
	Mon, 28 Sep 2026 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590077; cv=none; b=NKbdJJBWrOWIW5d9+KHnhwn7rYTcgKdS3Duo4MSlmYP4nz+E9ESf6udQtxJFJvLlHDDSQTvVXeEi3+4lb5ZHfDsAnKe6YnHbgyo7f8UDr5hgLj9nH2xepkbBtgxtB1H1/CnmY095EVgmWaNArggTtaMNLUqIqjXhaUYQYkumwLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590077; c=relaxed/simple;
	bh=X5m5Fot/RqIdhE4//wzeHwQKhkiyhsdddWzInFmXIpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3ym1+clO9uM7CxAkafFI4Drp8Cjf6R4gcugn7an1Cyd3X2QjG2ve8HGYs7ZfU/+3+Y6riVlxPkps5Uhg4mp09FRxWGAB/u6+mfULoUrXPxurQRoR9L8P1LdRwsKen0uoyC5WHLRJRr2HwtfSlC4k8uxjRdrIMgvi5qEVlJIlHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/PkV9UZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/PkV9UZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C1D1F000FF;
	Mon, 28 Sep 2026 10:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790590076;
	bh=MQuPb454HWvayvbhkhIV9J03lpD+/nxJIOYytBBlONM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=M/PkV9UZsxZEV3S+L5muyc6Nza5gh9fs4sqZj2j2huWhhGpQckwZ3uWXw4SnntILh
	 dZzqWhsSk1LtuJCzSgxTUzlSjDSYWgD1YO0gqSrpiSbt0LCRETu/eITXpXWbT+iE0W
	 +wY/VcF23ri1wYfHhwo34uiWvGPqnKZ0NtjK/MDVFP5dhHPmDy5tMcXF62RxpMg+RA
	 A+gABTW1h5WJIHmvot1nPQLwsjiTrlYgLfFXG56VhU6Z8ZY+uhO9ZsQWjNS5haFxjj
	 mBmK2Oqg6rEwpD/BgqOqyEuNAc016MEHvieCRVvispO+2sXDvGdYep/yxU/nD68Nl+
	 NnvgDWmh/0sQw==
Message-ID: <9d6f2d3f-ce3d-4123-8bc3-a5e4aed5ad53@kernel.org>
Date: Mon, 28 Sep 2026 12:07:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 10/10] Documentation: networking: Update the
 phy_port infrastructure description
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>,
 Pietro Ameruoso <p.ameruoso@live.it>, Aleksei Sviridkin <f@lex.la>
References: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
 <20260927133619.955236-11-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260927133619.955236-11-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/09/2026 à 15:36, Maxime Chevallier a écrit :
> With SFP now properly supported with phy_port, add some details in the
> documentation. Fix a typo along the way (driver -> driven).
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Aleksei Sviridkin <f@lex.la>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   Documentation/networking/phy-port.rst | 26 +++++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/networking/phy-port.rst b/Documentation/networking/phy-port.rst
> index 6e28d9094bce..2a9b1ec93b70 100644
> --- a/Documentation/networking/phy-port.rst
> +++ b/Documentation/networking/phy-port.rst
> @@ -99,13 +99,29 @@ will eventually be able to report its own ksettings::
>               (_____)-----| Port |
>                           +------+
>   
> +SFP ports
> +=========
> +
> +SFP interfaces involve 2 distinct components, each represented by
> +a :c:type:`struct phy_port <phy_port>` instance :
> +
> + - The SFP cage itself is a :c:type:`struct phy_port <phy_port>`. It's special
> +   in that it's not an MDI interface, but rather a hot-pluggable MII.
> +   The :c:type:`struct phy_port <phy_port>` associated to it lists the different
> +   MII interfaces we can use on the cage.
> +
> + - The SFP module, when inserted, will also be associated to a
> +   :c:type:`struct phy_port <phy_port>`, that represents the various linkmodes
> +   that it gives access to. The module's :c:type:`struct phy_port <phy_port>`
> +   doesn't supersede the cage's port, it references it through
> +   the :c:type:`struct phy_port <phy_port>` :c:member:`upstream_port` field.
> +
>   Next steps
>   ==========
>   
> -As of writing this documentation, only ports controlled by PHY devices are
> -supported. The next steps will be to add the Netlink API to expose these
> -to userspace and add support for raw ports (controlled by some firmware, and directly
> -managed by the NIC driver).
> +As of writing this documentation, the port's presence and information can only
> +be queried, and it's not possible to change any of the port's settings or select
> +which one should be used.
>   
>   Another parallel task is the introduction of a MII muxing framework to allow the
> -control of non-PHY driver multi-port setups.
> +control of non-PHY driven multi-port setups.

