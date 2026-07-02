Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCC237E2EC;
	Thu,  2 Jul 2026 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972972; cv=none; b=Fjwqy2zAa7cb06Yt49NDAVovtKe+YmJWQxvD/7YgeuA61IruyIAqmp2z2GfBPMZknFog3TSzZaSEgFG1yhWpvQ61etzuF4Isk//5d2SmHcAtU9Oxkdjcwe6iV8IaQMJjO9QGj3s+3tRPWj7BHa7Jg/1dLfZwHEGc615nzrZJgoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972972; c=relaxed/simple;
	bh=KQcL/jbUKpbgVAGTr89hlzik4SO/VeQT0VFcjYCNB8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrwmAvHRY1R+a20V4oTZIWnh22sptFyZXtzzau2DfRj3y1hRl428muxnxM+YDmNVf8eBxabYSBqA6GTNyvs5JcNhsIMafsjHCNSYeuustufafonD/YU4rfeNP2YMT/vZwCnGyuwtPrZh59OCphrf9Z4KJMS5t6OtTv/v9RgnebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgOrK9hW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgOrK9hW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482BF1F000E9;
	Thu,  2 Jul 2026 06:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782972971;
	bh=3eBn6yYPLH2ipNnA672FRtzi3xFVI7UPgps+ZwTDFzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AgOrK9hWFVZdG7FQCX01vljrn7ocPX3JQbiQA6nbxE6oXhRyf8ZcyWAgYu7FZkoA0
	 76+h1enpAdnMpRJEF5JTOElp5ebvnL1CPOZD8o6NBhFjzwHydCczUqbhr2p1G1atSS
	 6SUw86jYT5IYk9OtFbDyINO+5reMP5nfigVeFLwMHwn6gI/FznrIXgdSx7ouoh+obH
	 2QKD288wDD77Q7kABTMiO/T+BXtY1CbWEOevEwATu3IAeSwDxf6k06VawImAu42s5L
	 FreGrS86Zq9VHYVfuWeLdda39dG693hFm4VNR0eXjUo5GeZjWZ64eOxOD4sfuc+6tm
	 94XBuU9R/c42A==
Date: Thu, 2 Jul 2026 08:16:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: pratyush@kernel.org, mwalle@kernel.org, takahiro.kuwano@infineon.com, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, srini@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	linux@armlinux.org.uk, richardcochran@gmail.com, linusw@kernel.org, arnd@arndb.de, 
	michael@walle.cc, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP
 to be exposed via NVMEM
Message-ID: <20260702-utopian-termite-of-perfection-f1f3ec@quoll>
References: <20260630092406.150587-1-manikandan.m@microchip.com>
 <20260630092406.150587-2-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630092406.150587-2-manikandan.m@microchip.com>

On Tue, Jun 30, 2026 at 02:54:00PM +0530, Manikandan Muralidharan wrote:
> Add an optional "sfdp" child node (compatible "jedec,sfdp") that
> describes the SFDP as a read-only NVMEM provider via nvmem.yaml, so its

What is SFDP?

> contents (e.g. a vendor EUI-48/EUI-64) can be read through NVMEM cells.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  .../devicetree/bindings/mtd/jedec,spi-nor.yaml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index 587af4968255..98fd954598ab 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -103,6 +103,20 @@ properties:
>    spi-cpol: true
>    spi-cpha: true
>  
> +  sfdp:
> +    $ref: /schemas/nvmem/nvmem.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      The Serial Flash Discoverable Parameters (SFDP) tables exposed as a
> +      read-only NVMEM device. This allows standard or vendor-specific SFDP
> +      data (for example a factory-programmed EUI-48/EUI-64 identifier) to be
> +      consumed through NVMEM cells.
> +    properties:
> +      compatible:
> +        const: jedec,sfdp
> +    required:
> +      - compatible

Where are any resources? What sort of sub-device is represented here by
an empty device node?

Best regards,
Krzysztof

