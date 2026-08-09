Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CF1360EDE;
	Sun,  9 Aug 2026 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786308227; cv=none; b=lVo5qqz6E+KPPzAiTqGf+JOfla75rr+MyJiFtFXv4BLKeB92s5hjgHYIS9RwOhDoYElV2TXd53P3OUNhpvbqUJLrnRFPuxfp1viElCnAZi2ge+QrOCjRKScTeGLgDBUmrTEGEFxUxweDAxmDfHzaXj80IStVtn6/7gmpjNHpXLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786308227; c=relaxed/simple;
	bh=NN4fmwr30I2d3j/4sXosL/rzXBe/r2eQxSij+UsIgaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjgDa2ewmKb9tGgvhHIML4rnfywqs03rQN4s/1Ig4j4zJwWZYgdpGQh0RGhgt/+3JCoS+Ebbx5RsAPBndiA0YQS32j1K63hOpLQ4ZbUG4YIrIYPTSmQj0SeO2ya3OaOi1cuCXs3flvxNHtWiEiKT8K58G95Fkk0OBHFpWrGuuvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UIgSVgZn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UIgSVgZn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8CwAOv7AuOU3VUGki+Bi2QHHT2yAfq3OZkA/qLdvJjM=; b=UIgSVgZnmz+5WlFSwJJZKiT824
	DTiu0zX3/mLBpv7/M4Fkbq45gPPjyiHRXTm8asKXEmk7uxC7vQm/8rhOCKd40QleKyr5XUiHF5buE
	wQHcnC6j6UjP7/D6iGx6E6NoQJvPr9lQ3QLMxVVuwslBI+UX7/YKdezQ5cihWe6CLaH0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtAMh-00Gqw3-H1; Sun, 09 Aug 2026 22:43:27 +0200
Date: Sun, 9 Aug 2026 22:43:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v11 00/12] net: pcs: Introduce support for
 fwnode PCS
Message-ID: <f9151481-7dcf-4c9e-9507-7eb0c217851d@lunn.ch>
References: <20260807131301.192060-1-ansuelsmth@gmail.com>
 <4c595c15-17d9-4c23-bb44-344c48d36e9a@lunn.ch>
 <6a78bdc6.89544747.3fcae.b8e0@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a78bdc6.89544747.3fcae.b8e0@mx.google.com>

> I think the most annoying one will be stmmac with the 3 different PCS
> implementation but we already handled that in a upcoming ipq50xx driver
> currently present in OpenWrt mainline.

stmmac is always annoying :-(

If this can make it more uniform, make internal and external PCS look
the same, that would be great.


> @@ -6808,7 +6792,10 @@ static void mvpp2_acpi_start(struct mvpp2_port *port)
>         };
>         struct phylink_pcs *pcs;
> 
> -       pcs = mvpp2_select_pcs(&port->phylink_config, port->phy_interface);
> +       if (mvpp2_is_xlg(port->phy_interface))
> +               pcs = &port->pcs_xlg;
> +       else
> +               pcs = &port->pcs_gmac;

I thought the point of new API was that phylink picked the PCS. Why
this if? Why not register both and let phylink pick?

> +static int mvpp2_port_fill_pcs(struct phylink_config *config,
> +                              struct phylink_pcs **available_pcs,
> +                              unsigned int num_possible_pcs)
> +{
> +       struct mvpp2_port *port = mvpp2_phylink_to_port(config);
> +
> +       available_pcs[0] = &port->pcs_gmac;
> +
> +       if (mvpp2_port_supports_xlg(port)) {
> +               if (num_possible_pcs < 2)
> +                       return -EINVAL;

This seems like defensive programming. If we said there was two, we
should assume available_pcs has room for two. I would not even pass
int num_possible_pcs as a parameter.

    Andrew
