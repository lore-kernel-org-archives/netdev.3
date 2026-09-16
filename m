Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2446A4F648B;
	Wed, 16 Sep 2026 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565723; cv=none; b=um7aDdV+WMMdh9wwdHuGm/5DWyelPLo85BRgHtXa9ozjNOJjyK5ScpzFVpqnH3YWZ7MLoOSIpnjGP9SeTq5cGAtpA/LcH4P0fWcFrN2+dSwO7gUp4eV5KagoMSB+Y03g7EsItzVSXk/C7wnSf7kRUuuURoRcZvp8rj2KwnkCy48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565723; c=relaxed/simple;
	bh=6GNYi9fFvXcnPHyYMwVSf9NoWeVn7YAVyxgOL8RCFwE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZjPBlHLrsWcVa6UwQx2hqeMvIJkUfTQIQuYHy7UReXm1/SuWpItjphc8LUTxlSxj/u52qK6DFNMBYiezCb1dd2+ZoYkJO1ly1jwzx41l9hyEwiKrrBhm51BX3I3sy2mTzU8X2ymh0Mbex91EgwTvMndYHqRu0+3xcvvZIBAhTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKtgtExr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKtgtExr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080831F00898;
	Wed, 16 Sep 2026 13:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789565714;
	bh=cc9GfLgeyPAevFfrx21pEcMbdwwC0JZpWEVgGm40IH0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VKtgtExrwrKIYdN+ur3YoNfd/AFndxwrHmWbnPNXuoncOqVZ6IfffXNs4AgThvO5t
	 8yKQMF7Zbna7cwCqr25JODgL7EZxo9bFT4aDdl7bPg2osxk3iE0B8mNZQdrHzLE4Gk
	 EVBj4+xKFqMNoGM87eaWbrRGccuAceAfgYTUCYrflyXTt9JrlPXrMsCTR7NlnOibb7
	 AqHsQpp3LiLPfNLFzrtnhVURJ2dY9rdtBUSD+GKxQyim3iuXZNShpYkuOF5NYp0Ck4
	 +P9VOBDndviRUeVXr9WzUsy3xz33Mdq/yYI+/Z1MNGKvLilT1tvIpOigHQm92ncGLu
	 +gj+/oUMdUSyA==
Subject: Re: [PATCH net-next v4 4/5] net: mdio: realtek-rtl9300: reject
 duplicate MDIO bus IDs
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Wed, 16 Sep 2026 13:35:13 +0000
Message-ID: <178956571358.22033.5636304813155390985@kernel.org>
In-Reply-To: <20260912130451.3757276-5-markus.stockhausen@gmx.de>
References: <20260912130451.3757276-5-markus.stockhausen@gmx.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Claimed DT-binding-vs-driver mismatch: the series patch "dt-
  bindings: net: realtek,rtl9301-mdio: add clock-frequency" documents a…

--

net: mdio: realtek-rtl9300: reject duplicate MDIO bus IDs

The patch makes otto_emdio_probe_one() reject a second mdio-bus child node
that reuses an already registered reg value, instead of relying on the later
failure inside MDIO bus registration. The previously unused priv->bus[] array
is now filled in after a successful registration and used as the duplicate
check.

> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index 8ca917d9aea3c..45cbefc52100a 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c

[ ... ]

> @@ -868,6 +871,8 @@ static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_priv *priv
>  	if (err)
>  		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
>  
> +	priv->bus[mdio_bus] = bus;
> +
>  	return 0;
>  }

[Severity: Low]
This is only an ordering observation about the series, not a bug in this
patch.

At this point in the series, the earlier binding patch "dt-bindings: net:
realtek,rtl9301-mdio: add clock-frequency" already documents a per-bus
clock-frequency property (2.5/10 MHz for RTL838x, 1.25/2.5/5 MHz for
RTL839x/930x/931x, plus the RTL839x shared-selector rule), while
otto_emdio_probe_one() still reads only the reg property, so a device tree
setting clock-frequency would be silently ignored on these commits.

The gap closes at the end of the series in "net: mdio: realtek-rtl9300:
support non-default clock frequencies", which adds the consumer in
otto_emdio_probe_one():

	if (of_property_read_u32(node, "clock-frequency", &freq))
		freq = 2500000;
	err = priv->info->set_bus_frequency(bus, freq);

and otto_emdio_8390_set_bus_frequency() relies on exactly the priv->bus[]
bookkeeping added here to program the shared RTL839x selector only once:

	if (priv->bus[0] || priv->bus[1])
		return 0;

Would it be worth mentioning that dependency, or moving the binding patch
next to the driver patch that consumes the property, so that no intermediate
commit documents a property the driver ignores?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912130451.3757276-1-markus.stockhausen%40gmx.de
