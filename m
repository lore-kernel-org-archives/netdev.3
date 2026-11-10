Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306570;
	b=GI/LcRLZStIz3p7jifA8jgugMUXn7Mos/YMYaLhmdjk7xmZQXRv5rhpcFTlPweovqABk
	 wCU8psQRRRc4TLgIaEg5wCB9olajtE5S3XY2X6CCsyg1O+Kj3/0Jzjm/DrUgPVfODL82X
	 YTjxaAKJP3ivPIEZx1TFr1/WFrLKJDCy861rb0CTTAkWSzDK8QY5mCUYWzB8DrvWvSBQS
	 TpRHEWia0UwEVsj+UVtoV4setiXNr1PjPtsxqESfkIkVgC7kxMA+BqWmJMDu4pqA4YMO/
	 ZZEuaPBAqwfkoKltbQIf23OlvIE4UT5+5MaqFuc5Fluh8PFBgbmTt3D7H4gz7S0fY5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306570;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=v2xg6hOG8tJYsiUIo+rhQhOmRkcdSZdLofEQMTd+hPQ=;
	b=DFV292m8Go6vgKVSYdMPB+Uv15j5TlDVnhsNhrEbfoACAqnr/9j6ucOkY/KMLwvdMwkt
	 /49luA8zTX2/MKXiDVutjkr49znN0BIdaOa6C4PT8se6S7AedlsVEUnynvLrCCeatm2XV
	 BlxBf1SexkMCtNg5+8i+3ecVs2bVpF3hCQaqLk7aYa8zNxE3Fo9FTkvtFis2Du75UYFw9
	 76OI61eWsmMEk20AXveMXMsVItfVgBecRcz164GCX6fLALTnpVdoA2ft/Uu7YfHXAvlFs
	 phkNHpoUEirmWSGCLv1iEVySB9syw7K2+3yIzNUacTQE3o3CpICD5tjMgDztUK2Gvbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRDbb0vQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C227606A321;
	Tue, 10 Nov 2026 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRDbb0vQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F74D1F0089F;
	Tue, 10 Nov 2026 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306570;
	bh=v2xg6hOG8tJYsiUIo+rhQhOmRkcdSZdLofEQMTd+hPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dRDbb0vQ8jSYjC/bRQf5405AJBZL/knalNcpL9AkFq7HXcvXtq4nkKhO35Gs4hbY5
	 3yos0alKhziqWixpucq823yVO0RzTwVZBZGU3jiaQLIiIoOy7j3Tjy2CXrsr4xSP9G
	 BX1h41irrZGGIYJH1TQl1ttMvIvpkS4OFMf0lVuscQMFR4Y2pQHZxmaEEnxJddMX+3
	 vxptwezsMREU31A22+c2g22+J00h3AfRub4F7RNuZICQ+k8vSC76EEjvJkRK9BMH8w
	 I2GjP3kDUPBTYTHzAK1HMqhBBL0M4RgIgZUh+F/iE81fapMH5EmohVwystsgplRTf3
	 ZaYQGiosXqrug==
Date: Tue, 10 Nov 2026 11:29:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Michal Simek <michal.simek@amd.com>, 
	Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 3/5] dt-bindings: net: dp83867: make
 exclusivity explicit
Message-ID: <20261110-ecstatic-affable-mackerel-db9cb7@quoll>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106-v7-2-topic-dp83867-v3-3-45e1d3adf1bf@pengutronix.de>

On Fri, Nov 06, 2026 at 08:47:27AM +0100, Steffen Trumtrar wrote:
> The io_impedance_ctrl nvmem cell and the properties
> ti,{min,max}-output-impedance are mutually exclusive, as noted in the
> ti,max-output-impedance description.

But it also said it is allowed and one will be chosen over other, if
both present.

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

You just added it, so instead place it at the end in previous patch.

Best regards,
Krzysztof

