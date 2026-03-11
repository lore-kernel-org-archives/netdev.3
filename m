Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCB030DEBA;
	Wed, 11 Mar 2026 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773212457; cv=none; b=RcHsNFGiU3Qc1GRRcX+i1QcIw8gPd1Aj/Cn5acEVz/oYHEYYachDtC9QHPNmAkzasoNrS7uPitXapbpUju1iP0O0X/Eis5ebQ1Ss6s8PocgvyhfbcDeQmnEaMXNluVOlC6m16/O+9c4HxF+7zp7SeiTo70TFMzyATfRDJAhoVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773212457; c=relaxed/simple;
	bh=ldYxWyiCUErDf/diI7OR5Y7gAgKmC1R5YPOLvmXtAPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBMYgKX5PglctzstFiBSXLrhpB3ZcuVgWnOaSKdTcTNhfnw8uRiq2rmjru8hTFARtqvDQBlrRbVYHqyZ/0fnXQZducCiZd8gVdsFgveBPlzmN2amkd8SGJfs0jNhEHHvnpNXq/cw8zmVU1EUqDdEBnEUO3sdXcUgiunF1ZuvfjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EU67Hbs0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EU67Hbs0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C41C4CEF7;
	Wed, 11 Mar 2026 07:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773212457;
	bh=ldYxWyiCUErDf/diI7OR5Y7gAgKmC1R5YPOLvmXtAPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EU67Hbs01r/pkU5O/Py6ad23GAhy+ZGGwxpxur2UEUhrVBOwMLY80JR2kPoyWbomh
	 IusC09HffaQCgVwusSeDqeBqUmRiF3bO2foESPYjXHx2FJ/KVf4ZDNFIwxfv3vaiAP
	 JZSDG2anFJbi4SAxCEOPT0wKXq2dkA1Z5YTmXQCmLK5yw1EcD6YUHbyrtTaKJNd1vV
	 TQxqal+GVFlWX1met5HtXaEqmSQxarp5EkfUY1FxGiifxW5QPMywYMh2P318181SpI
	 28x2X0jhjrZ3+bLixTPLRVGeLwfIhjCrl0dOc26g8xE0u+U3mDTX+OYSxLkFrGMRNp
	 Rw2LYDFjd3vKA==
Date: Wed, 11 Mar 2026 08:00:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Valentina.FernandezAlanis@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Richard Cochran <richardcochran@gmail.com>, 
	Samuel Holland <samuel.holland@sifive.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Sean Anderson <sean.anderson@linux.dev>, Vineeth Karumanchi <vineeth.karumanchi@amd.com>, 
	Abin Joseph <abin.joseph@amd.com>, =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>, 
	Ryan.Wanner@microchip.com
Subject: Re: [PATCH net-next v3 03/10] dt-bindings: net: cdns,macb: replace
 cdns,refclk-ext with cdns,refclk-source
Message-ID: <20260311-horned-dexterous-caribou-3a46fb@quoll>
References: <20260310-moneyless-dispense-7bce14b16388@spud>
 <20260310-sneak-handclap-c150d8f1236b@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310-sneak-handclap-c150d8f1236b@spud>

On Tue, Mar 10, 2026 at 05:17:10PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Ryan added cdns,refclk-ext with the intent of decoupling the source of
> the reference clock on sama7g5 (and related platforms) from the
> compatible. Unfortunately, the default for sama7g5-emac is an external
> reference clock, so this property had no effect there, so that
> compatibility with older devicetrees is preserved.
> Replace cdns,refclk-ext with one that supports both default states and
> therefore is usable for sama7g5-emac.
> 
> For now, limit it to only the platforms that have USRIO controlled
> reference clock selection, but this could be generalised in the future.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/net/cdns,macb.yaml    | 39 ++++++++++++++++---
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> index cb14c35ba9969..a492357570edd 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -120,12 +120,14 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> -  cdns,refclk-ext:
> -    type: boolean

This is already an implemented ABI, so you cannot drop it even if some
devices works fine on default. Instead please deprecate it and keep
drivers backwards compatible for whoever is using it.

> +  cdns,refclk-source:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - internal
> +      - external
>      description:
> -      This selects if the REFCLK for RMII is provided by an external source.
> -      For RGMII mode this selects if the 125MHz REF clock is provided by an external
> -      source.
> +      Select whether or not the refclk for RGMII or RMII is provided by an
> +      internal or external source. The default is device specific.

Best regards,
Krzysztof

