Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316131;
	b=Z5F+GbtMgMODTObO2sSBiO9D/r0J3x3bNio9ZtGVcsv1cz2f0CiFADxwvbcPS/eoI7mA
	 rIh0Jqgg+OvYKc/vo9B5SWvI3LCPr5Zxwd9mE0/hTt5OF/XH7GGNeqNxTpmGyMxF8X3N0
	 E4WKtTUUqvD6ZyFb9H0Zc1cQ0tq8M28+pBZOJbDf5AoEHrfCzCYanJupzc2qzWdcMIdgt
	 utxlxo7e+FWZSLaxJOh1Cpt5IGCK5zEGE67t2XwZgRNkGKJBNUPQbEl0oXRAUYDlAki77
	 qWlD7h2zKxs0uvy55U4xTaQQFRhvMuza+of8Yqd+LTRTnAOSt66+wZa34+L75mNGBQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316131;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=iydFZJoGqhyO/k/DLJ8mL411l6d6tNvyIk7ou9fRBkI=;
	b=qTB2dgpg0FmSX0zvT3b9RXWFAwnjQLisweGMJceDrLqBzqRDKMvHPgNnrF3rCc7YD39t
	 YTzFGo1T7vuT6D4EAJYg6lDxttO5pmVI3vXKXZiKwTVJbSuQbZMna52J722e5cUTgQcVo
	 f9v1tgA3ie3yIpoFuAcK1WdPBSsjzoQfjExu9g8YLS969lpZ1aE1RDYZvG6UGvcl1EFL5
	 rLw5nIa3mpolVrxwWbX0DBVilKi6pGVDK0fuRzCccMDeZ/vFGD+2GaVAh7ECNP0jLYnCK
	 uR10Xx5GOIWvnMY7mLu2NE7qDL5UZDHs0O2glskKPL5r9/GXb0DV/nwodZOGGGgK/IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=f4iSLxER;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F79606A76E;
	Tue, 10 Nov 2026 13:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18F79606A76E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=f4iSLxER
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iydFZJoGqhyO/k/DLJ8mL411l6d6tNvyIk7ou9fRBkI=; b=f4iSLxERH0pNwm+hI1lQTI1UQ9
	N/Uh8yEXcREuDUlIvJHBy+0fT4o40Wzo8LyNt8l9q2zzqkJFhf7gxBqS/bCKLIncCFyhYRi3akAUD
	UV9WrTxAqAfnFp5pKwZYZGwJ0PN2P7LNXb1T1op3Sm/iRaG9UDDQBb8yENLVp1KxX+xI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQlaO-00FTqg-Go; Tue, 10 Nov 2026 14:08:28 +0100
Date: Tue, 10 Nov 2026 14:08:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Michal Simek <michal.simek@amd.com>,
	Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 3/5] dt-bindings: net: dp83867: make
 exclusivity explicit
Message-ID: <dd8bc868-06e1-4f9b-9e1d-70eb0bcd8f0d@lunn.ch>
References: <20261106-v7-2-topic-dp83867-v3-0-45e1d3adf1bf@pengutronix.de>
 <20261106-v7-2-topic-dp83867-v3-3-45e1d3adf1bf@pengutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-v7-2-topic-dp83867-v3-3-45e1d3adf1bf@pengutronix.de>

On Fri, Nov 06, 2026 at 08:47:27AM +0100, Steffen Trumtrar wrote:
> The io_impedance_ctrl nvmem cell and the properties
> ti,{min,max}-output-impedance are mutually exclusive, as noted in the
> ti,max-output-impedance description.
> 
> As this is only stated in the description and not made explicit in the
> schema, the binding checker will not catch if this condition is ignored.
> 
> Make it explicit in the schema that only one of them can be used. With
> that, drop the note, which also described a precedence for device trees
> that the schema now rejects.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/ti,dp83867.yaml | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> index 2cd8311ece5e..833540743bdf 100644
> --- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> @@ -7,9 +7,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: TI DP83867 ethernet PHY
>  
> -allOf:
> -  - $ref: ethernet-phy.yaml#
> -
>  # only the PHY ID, not every PHY with the c22 fallback
>  select:
>    properties:
> @@ -67,11 +64,6 @@ properties:
>      description: |
>        MAC Interface Impedance control to set the programmable output impedance
>        to a maximum value (70 ohms).
> -      Note: Specifying an io_impedance_ctrl nvmem cell or one of the
> -        ti,min-output-impedance, ti,max-output-impedance properties
> -        are mutually exclusive. If more than one is present, an nvmem
> -        cell takes precedence over ti,max-output-impedance, which in
> -        turn takes precedence over ti,min-output-impedance.
>  
>    tx-fifo-depth:
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -133,6 +125,15 @@ properties:
>        Transmitt FIFO depth- see dt-bindings/net/ti-dp83867.h for applicable
>        values.
>  
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +  - not:
> +      required: [nvmem-cells, "ti,min-output-impedance"]
> +  - not:
> +      required: [nvmem-cells, "ti,max-output-impedance"]
> +  - not:
> +      required: ["ti,min-output-impedance", "ti,max-output-impedance"]

This is not very readable or obvious. So i suggest keeping the text,
and moving it here.

    Andrew
