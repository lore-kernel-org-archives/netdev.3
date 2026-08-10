Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964838BF72;
	Mon, 10 Aug 2026 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385007; cv=none; b=BjlvUuCN76kYvQIMylwOw+KclS4zz1Tq+HzlmVKDn768J+agKD15BypL2tDuYEXAaeTOp5az1NrttjOdSAYJURsXlFVCABo+uTsj/jxNCeGik6xywNR8hb20cg8albRPBufGUs+7Gx3T1nUWbpTZ3amgU+3xYZ/qLdfJLYDL+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385007; c=relaxed/simple;
	bh=MPk28tW9IaFNravdfW+vVd7/hzQhHKSQLveQ5Z7BM+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON78by7uae+6GZKc4Lf8hZliKBFGqg792YCONewCBickI/s7zst3PA85zlpjkroUc2QzEo+pFa/Wi/ATfDmBmOrdwlm7ovGUrfbawNLRwtzuHJUdcJWkt7Khsat6cQ1Vd0Y2sy816S62MRWYB9pKzKLP3n/bv3aj4MgIEijVxb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5SrZ72V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5SrZ72V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08F21F000E9;
	Mon, 10 Aug 2026 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786385005;
	bh=+47nB+ymVQpumJdoiL7i0y+0QEYSSwSbPBEdZ3OfrBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E5SrZ72VDXJbAtd0U9iOidzNeHCawXN+u5dsLBP7qBo2pJzTegMWiPiO/SjD33Dl0
	 0s7LAwspsNl+NzMXa2B+Seg1OtoD/Hc0tN3twuQ/GTBUjfV8v8N6PnY3lKuTXpYQPf
	 HfS9exE/RtVdAcJW8p30pJpDeQN88wOINYcwDqZR4jhKNTRShG/aYTsGrqptP909RK
	 2yXqp0EHNeyHRkyOMJfP5FlGajUUj/AFHG3l5XnWP8/Mdlvn4c5MObzjufaSxi6uv/
	 M5ojLqlXtohKQzlRWmJlxd1HHLiXIP18Ituk5+RVZ7VjHFWDnBGekuLRko6lnDMHo7
	 d2qz0ZNuIsIyQ==
Date: Mon, 10 Aug 2026 13:03:24 -0500
From: Rob Herring <robh@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: pratyush@kernel.org, mwalle@kernel.org, takahiro.kuwano@infineon.com,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, srini@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux@armlinux.org.uk,
	richardcochran@gmail.com, arnd@arndb.de, linusw@kernel.org,
	michael@walle.cc, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP
 to be exposed via NVMEM
Message-ID: <20260810180324.GA2352629-robh@kernel.org>
References: <20260729043026.1811147-1-manikandan.m@microchip.com>
 <20260729043026.1811147-2-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729043026.1811147-2-manikandan.m@microchip.com>

On Wed, Jul 29, 2026 at 10:00:20AM +0530, Manikandan Muralidharan wrote:
> Add an optional "sfdp" child node (compatible "jedec,sfdp") that
> describes the SFDP as a read-only NVMEM provider via nvmem.yaml, so its
> contents (e.g. a vendor EUI-48/EUI-64) can be read through NVMEM cells.
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>
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

blank line

> +    properties:
> +      compatible:
> +        const: jedec,sfdp

blank line

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
