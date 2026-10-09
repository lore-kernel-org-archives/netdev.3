Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596337F00D;
	Fri,  9 Oct 2026 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537516; cv=none; b=e0SvkDL+YEikV285f4xYjnOTkSL8Q5edrUZqS+jPE3ttivksKdIMBHLCHoSM0ehI6WifcDbYgHdMJDF1oPY4AlW8kawidWj6+gCp+s3BoXau7l5g048fPa1rX9KeUqoWTN46fbTRdwT2x9xvRvAzPt23XhuZrE2yk5Aj85ySZik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537516; c=relaxed/simple;
	bh=wZGfux+RJCBoEcaO2QXcXedF6RI/XWSgw2HK/SNfAL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr4CzfJ3DNNryfMfSmXLf2jDAEtsZvzFJqJR005i3kPdmWlyh5LxHRTwFx5LFW5nj6oMqLvlakKcfOJO8zzDncO/0lS437hSFGl1ZNst6qWeOS84wKZQasnxRrvVJ82SgBN9Nc3nXn+azCnPyFZxIMpbEQrjXqCjkjUPCDAWZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWCpTL3C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWCpTL3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502DD1F000FF;
	Fri,  9 Oct 2026 09:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791537514;
	bh=8V2ERjKtSLfKnEPamcJI6FnYs8kOZCA7Itt0xiEdW4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dWCpTL3CraRR6djZDPxbnrRJwPegxCucLpT7dDue9wYchS4Zfmj9Ta6aOJZEvB3b/
	 VwPqP3lIQQRVPvkJ/S8PG5lOh7OkYd5mSi4xw5++B4lMfJ33210jPnxV5QiaNWz9/u
	 KjVN7PeF2ZejaqO1yU/xSllHVuYclBPm525QI/2BxhxC76BW0tN4pf0oApK0bku5jK
	 08v/UGBZZtrBqWaYmA8/ZZhSZaK/fSrGUttenBUq73z/gyiZ9JVwa0P6oSKjaU3AXW
	 xY8MqDBj4u53o1hDoyPLlDQTXaLbbPIfV0Wt/jw9y/Mt+/qEg5ZlxXqeDWhMq3NR/0
	 K+9DWayjYGj6w==
Date: Fri, 9 Oct 2026 11:18:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Oskari Lemmela <oskari@lemmela.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
	Javen Xu <javen_xu@realsil.com.cn>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Aleksander Jan Bajkowski <olek2@wp.pl>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Issam Hamdi <ih@simonwunderlich.de>, Chukun Pan <amadeus@jmu.edu.cn>, Jan Hoffmann <jan@3e8.eu>, 
	Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Manuel Stocker <mensi@mensi.ch>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: realtek,rtl82xx:
 document RTL8224 packages
Message-ID: <20261009-tentacled-magnificent-okapi-d5a173@quoll>
References: <20261005201540.913977-1-oskari@lemmela.net>
 <20261005201540.913977-2-oskari@lemmela.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005201540.913977-2-oskari@lemmela.net>

On Mon, Oct 05, 2026 at 11:15:39PM +0300, Oskari Lemmela wrote:
> RTL8224 packages contain four PHYs at consecutive MDIO addresses,
> but the first address need not be a multiple of four. Document how
> to describe these packages using the existing ethernet-phy-package
> binding so their base address is explicit.
> 
> Clarify that child PHY addresses are absolute and that MDI pair
> order and polarity properties describe the individual ports. Add
> an example with a package starting at address 1.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  .../bindings/net/realtek,rtl82xx.yaml         | 52 +++++++++++++++++--
>  1 file changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> index 07b39ef1fc62..ca52c3ae19f7 100644
> --- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> @@ -12,7 +12,17 @@ maintainers:
>    - Heiner Kallweit <hkallweit1@gmail.com>
>  
>  description:
> -  Bindings for Realtek RTL82xx PHYs
> +  Bindings for Realtek RTL82xx PHYs.
> +
> +  The RTL8224 contains four PHYs at consecutive MDIO addresses. Its PHY
> +  nodes may be grouped under an ethernet-phy-package node as described
> +  in ethernet-phy-package.yaml. The package reg must identify the first
> +  PHY's MDIO address, even if that PHY has no child node. This address
> +  need not be a multiple of four. Each child PHY reg is its absolute
> +  MDIO address, not an offset from the package base.
> +
> +  The enet-phy-pair-order and enet-phy-pair-polarity properties belong
> +  to the individual PHY nodes and describe each port's MDI wiring.
>  
>  properties:
>    compatible:
> @@ -90,9 +100,45 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        ethphy1: ethernet-phy@1 {
> +        ethernet-phy@1 {
>              reg = <1>;
> -            realtek,clkout-disable;
>              realtek,aldps-enable;
> +            realtek,clkout-disable;
> +        };
> +    };
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy-package@1 {
> +            reg = <1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            ethernet-phy@1 {
> +                compatible = "ethernet-phy-ieee802.3-c45";

I don't fully get why you are adding to the example generic compatibles,
not relevant to this binding.

> +                reg = <1>;
> +                enet-phy-pair-order = <0>;
> +            };

Best regards,
Krzysztof

