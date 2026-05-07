Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2109B3E6DE8;
	Thu,  7 May 2026 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154054; cv=none; b=FfIZTE3+qLKPp5W+JjiYsKGDnSrXUBPi42U3sNgBP8WPjy8tnGsHDG1pgsGgXsUlOWJWzJRCMqr+wRscSQSTR+8MiJ0TBJ/3Z2Dqf+0XpqYLnEL3jEwjmPpVcStMX2kcdo546UZGIbfHfiCRXpXyBkyQX9hKf3M9cDXLyuBee3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154054; c=relaxed/simple;
	bh=Ljcv0sP7OdGRzGMPcPlzo4vL4eqkqZAH0pJ3yD8mQhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nklplnKFDNU7YNZS2EV2NhDGbBa8HfJtWzK6X1hkuVpDjSvMtDiXcnT1ZpIJlZVbGXMmZJfN68ESm/bJjXufv/nr+zgqdxRkxWLlEOHaGwCAEHcInHabOC3JvA/DdDA5j1NtXiOCxncZEHAK3A/fT7BxGQIfBT0qMMhe/hoWSKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yNwAi/22; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yNwAi/22"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 31E0CC5DC5B;
	Thu,  7 May 2026 11:41:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7C9DB60495;
	Thu,  7 May 2026 11:40:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CBE60107F2392;
	Thu,  7 May 2026 13:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778154049; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gSfYtuWjOT5LpDJ9EwdjiU/eoXSwkeYgp7LEVAKYAY8=;
	b=yNwAi/22GAOgUTY7IDGlhuTyl/C9azi9u+uNGSW8DRy34dzEDh2IFZ70mQdWmcynISc8EZ
	AUysPvzK+kRGwD7hLdT26aHsxWQFMs+HtDQ5YqyKQNW9QvnpumZZF5fcUN33UjjjYWWe3F
	mfUaX2R+zvpqWw6ZgWallNYc7o52dzJno9RGvX1s2FLlbM18eLUPbce7WzpFI4yEvmTaj1
	xyws+mroWGdWUcwADZqQK+HSumuyf5Q2k1qxkPoeJ5lgy7b+R9q6AuSHEoQzsS5HIFARpz
	rEXHPRVYwuBUjhKNyyvgbfBphVPjzRDXwPcoZ+AFkY2cUBKd8wYkndQbCH9SEg==
Date: Thu, 7 May 2026 13:40:43 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: lan966x: Accept standard ethernet
 prefixes
Message-ID: <20260507134043.35fdb1b9@bootlin.com>
In-Reply-To: <20260507-lan966-binding-v1-1-e99293d2a4ec@kernel.org>
References: <20260507-lan966-binding-v1-1-e99293d2a4ec@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Linus,

On Thu, 07 May 2026 11:26:01 +0200
Linus Walleij <linusw@kernel.org> wrote:

> The dsa.yaml and ethernet-switch.yaml bindings recommend
> prefixing ethernet switches and ports with "ethernet-" so
> make the LAN966x do the same.
> 
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  .../devicetree/bindings/net/microchip,lan966x-switch.yaml      | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
> index 306ef9ecf2b9..0f0f35865ef4 100644
> --- a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
> +++ b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
> @@ -17,7 +17,7 @@ description: |
>  
>  properties:
>    $nodename:
> -    pattern: "^switch@[0-9a-f]+$"
> +    pattern: "^(ethernet-)?switch@[0-9a-f]+$"
>  
>    compatible:
>      const: microchip,lan966x-switch
> @@ -70,7 +70,7 @@ properties:
>      additionalProperties: false
>  
>      patternProperties:
> -      "^port@[0-9a-f]+$":
> +      "^(ethernet-)?port@[0-9a-f]+$":
>          type: object
>  
>          $ref: /schemas/net/ethernet-controller.yaml#
> @@ -138,7 +138,7 @@ additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> -    switch: switch@e0000000 {
> +    switch: ethernet-switch@e0000000 {
>        compatible = "microchip,lan966x-switch";
>        reg =  <0xe0000000 0x0100000>,
>               <0xe2000000 0x0800000>;
> @@ -151,14 +151,14 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        port0: port@0 {
> +        port0: ethernet-port@0 {
>            reg = <0>;
>            phy-handle = <&phy0>;
>            phys = <&serdes 0 0>;
>            phy-mode = "gmii";
>          };
>  
> -        port1: port@1 {
> +        port1: ethernet-port@1 {
>            reg = <1>;
>            sfp = <&sfp_eth1>;
>            managed = "in-band-status";
> 
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260507-lan966-binding-0df62a018509
> 
> Best regards,
> --  
> Linus Walleij <linusw@kernel.org>
> 

With those changes, dtb_check will not be happy when following dtsi/dts are
involved:
  - arch/arm/boot/dts/microchip/lan966x.dtsi
  - arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt.dtsi
  - arch/arm/boot/dts/microchip/lan966x-pcb8290.dts
  - arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
  - arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt-8g.dts

IMHO they should be updated as part of the series.

Best regards,
Hervé
