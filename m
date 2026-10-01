Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB51737CD40;
	Thu,  1 Oct 2026 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842168; cv=none; b=bxakfptas0NbMoBYejZsoa7QfMN4HEyiI8LW+/MBxdrkq2r2KwJi3XBHRWilg4JJioNmUPHfMZ44WgHbEcII7p33ZBONh2DqmCGkJt6s4oTD25KQsG0WmY0QrXKXo0me+8N8PdT5+PTkeCqEqtmC3nkMhSWvkl9kxpuust+6svo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842168; c=relaxed/simple;
	bh=+igb1aSb3V35gXBFnjDgPt3Ucw8mEijGa8jQk8RYU14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/yoe4AY8+HVpP7eVCMTLeotjohFxiAN5/UAb8r7y1cWH7wfrIvrd9cTI8SS2EePoJJy39ZdHdipKeJlaWW4D1LA8nmu5zVxg9jpeon+fzC/+DIo0PS5GGNJPvECYgo+uq5oiP4s5zQsMnFYiNJ6t4WWFFvIkPdXk+pxGq7ayGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCcPxnKY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCcPxnKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801621F000FF;
	Thu,  1 Oct 2026 08:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790842166;
	bh=FQXFB5CJ9p1R7R+1lxx2Mup+Y0yp9x/tWRHvoPiTk40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jCcPxnKYG4vKAWKRz0xj50Il7/xhWvdgRJPZ1UjX4Yj1m2p3vjoPFXBl6heVc5prG
	 1g5A1LDd2ekiJbh3Od7h1kRyi/XJAceBKALg4ekluZu58/BKZYFo6uzjdAvQ6UAvOA
	 MzZ4zxVZWbmytQALoWXxij1WfLFwHB9OwjLGDumTJS/3iyHUDyqL+AVncT2rx5HdVN
	 HutARDjLEslB1s7vQUYvQp2RyPU/CxnLRMv5DszIt9ZvVyr5RUCUDZNpBUlQ4eZaCd
	 0jOw7wiKWYj9U0FwN/gjQsENm7a/0ghzexJcJxVyvgpOsIERLEQo/HofBP3DHS0zN1
	 nRY3kPMfRIPNw==
Date: Thu, 1 Oct 2026 10:09:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	pierluigi.p@variscite.com, Stefano Radaelli <stefano.r@variscite.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, Joseph Guo <qijian.guo@nxp.com>, 
	Josua Mayer <josua@solid-run.com>, Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
	Mehmet Fide <mehmet.fide@screeningeagle.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Markus Niebel <Markus.Niebel@ew.tq-group.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 03/13] dt-bindings: arm: fsl: Add Variscite i.MX6ULZ
 board variants
Message-ID: <20261001-immortal-wild-wallaby-23de50@quoll>
References: <cover.1790693249.git.stefano.r@variscite.com>
 <1e6f9e01bd9e0e0801b18ddc9eb44bde200ea984.1790693249.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e6f9e01bd9e0e0801b18ddc9eb44bde200ea984.1790693249.git.stefano.r@variscite.com>

On Tue, Sep 29, 2026 at 05:17:30PM +0200, Stefano Radaelli wrote:
> From: Stefano Radaelli <stefano.r@variscite.com>
> 
> Document VAR-SOM-6UL configurations on the Concerto and Symphony
> carriers and DART-6UL configurations on VAR-6ULCustomBoard with
> i.MX6ULZ.
> 
> The compatibles identify the SoM storage, wireless and audio options
> followed by the carrier, module and SoC compatibles.
> 
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> ---
> v3->v4:
>  - Split the board binding by SoC and add separate VAR-SOM-6UL and
>    DART-6UL entries for i.MX6ULZ.
>  - Drop the redundant -board suffix from new Concerto and Symphony
>    compatibles and use sorted items/enum lists.
> 
>  .../devicetree/bindings/arm/fsl.yaml          | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 9b1224091e01..42d12624c1db 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -944,6 +944,50 @@ properties:
>            - const: fsl,imx6ull # This seems odd. Should be last?
>            - const: fsl,imx6ulz
>  
> +      - description: i.MX6ULZ Variscite DART-6UL board variants
> +        items:
> +          - enum:
> +              - variscite,dart-6ul-imx6ulz-emmc-sd-card-6ulcustomboard
> +              - variscite,dart-6ul-imx6ulz-emmc-sd-card-wm8731-6ulcustomboard
> +              - variscite,dart-6ul-imx6ulz-emmc-wifi-brcm-6ulcustomboard
> +              - variscite,dart-6ul-imx6ulz-emmc-wifi-brcm-wm8731-6ulcustomboard
> +              - variscite,dart-6ul-imx6ulz-emmc-wifi-iw61x-6ulcustomboard
> +              - variscite,dart-6ul-imx6ulz-nand-sd-card-6ulcustomboard
> +              - variscite,dart-6ul-imx6ulz-nand-sd-card-wm8731-6ulcustomboard
> +              - variscite,dart-6ul-imx6ulz-nand-wifi-brcm-6ulcustomboard
> +              - variscite,dart-6ul-imx6ulz-nand-wifi-brcm-wm8731-6ulcustomboard
> +              - variscite,dart-6ul-imx6ulz-nand-wifi-iw61x-6ulcustomboard
> +          - const: variscite,dart-6ul-imx6ulz
> +          - const: fsl,imx6ull
> +          - const: fsl,imx6ulz

Is this the right order? Which one is superset of which?

Best regards,
Krzysztof

