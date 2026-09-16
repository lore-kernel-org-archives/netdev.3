Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640DD449997;
	Wed, 16 Sep 2026 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543575; cv=none; b=DKA/ebNzz8+jtMdPTUFsZweKkFxsfDlhPMny/l3WKoTvApOeFzeoARaZ4HlPBTZwPzFQlZcy2lE5WKhS7xU3AcSpVWu3iBQXAXpD4jmC4JjC0MomNwI4ExXn3iWRryzuvmBYJXylubkmut04/L2IzNRdY9LEkkS66OBEXOrsbhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543575; c=relaxed/simple;
	bh=foDlmXzagcnq0TuBy/I4u4vrUx5zgn4ysYSm4+mVIwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWluNL8SyHcKO53n+pv0/Y5r+CTThy1iSqP7rsnFkeWaQV4iV2/mxMISzdoaV25dB0Jj60jMryjPK7XKpmmHTaYaOCMnz4DHtYQ2ixI/ev10WZVrAhu1+Q0VHXVu7WeF6zlji7tcxPmxw9UyWCqgzCee3CexZCOVvSiy26EqCU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z/Eg90f6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z/Eg90f6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E35CF152B;
	Wed, 16 Sep 2026 00:25:59 -0700 (PDT)
Received: from [172.18.224.124] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D05E3F86F;
	Wed, 16 Sep 2026 00:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789543563; bh=foDlmXzagcnq0TuBy/I4u4vrUx5zgn4ysYSm4+mVIwE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z/Eg90f6uwGEDIvEfkh49fsNWBjrHX58Aao+Yv5AbA+pcP+bPZiOIoZup+Woecv3i
	 GJkg5PTVbYIT8UpdFTmTjnFWg767JJUfA1l0m3Hvh6a5HznwtU67FOgAVrJvYGj8R/
	 hJFwNXgUgOgoOeUMBtzCwJO51RcRDM41QdRgnfto=
Message-ID: <14e61e7a-29ad-4cc6-8993-dea7a8d7c846@arm.com>
Date: Wed, 16 Sep 2026 09:25:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: allwinner: add H616
 EMAC1
To: James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260915-submit-h616-emac1-v1-v2-0-322b32e40eb9@gmail.com>
 <20260915-submit-h616-emac1-v1-v2-1-322b32e40eb9@gmail.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260915-submit-h616-emac1-v1-v2-1-322b32e40eb9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/16/26 05:07, James Hilliard wrote:
> The H616 secondary EMAC uses a separate system-control clock register
> and supports only RMII at 10/100 Mbps. Add its distinct compatible
> without an older fallback, since using the primary EMAC clock register
> would not work.
> 
> Constrain the PHY interface mode to RMII, matching the hardware.
> 
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Where does this come from? If Richard is the author, then please reflect 
this in the patch (git commit --amend --author ...), so a From: line 
appears in the body of the email.
If not, it's unclear why this line is here.

The actual patch looks good to me:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   .../devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml  | 13 +++++++++++++
>   Documentation/devicetree/bindings/net/snps,dwmac.yaml       |  2 ++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> index 323a669fa982..2cae0133b3cd 100644
> --- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> +++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> @@ -21,6 +21,7 @@ select:
>             - allwinner,sun8i-r40-gmac
>             - allwinner,sun8i-v3s-emac
>             - allwinner,sun50i-a64-emac
> +          - allwinner,sun50i-h616-emac1
>             - allwinner,sun55i-a523-gmac200
>     required:
>       - compatible
> @@ -33,6 +34,7 @@ properties:
>         - const: allwinner,sun8i-r40-gmac
>         - const: allwinner,sun8i-v3s-emac
>         - const: allwinner,sun50i-a64-emac
> +      - const: allwinner,sun50i-h616-emac1
>         - items:
>             - enum:
>                 - allwinner,sun20i-d1-emac
> @@ -91,6 +93,17 @@ required:
>   
>   allOf:
>     - $ref: snps,dwmac.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun50i-h616-emac1
> +
> +    then:
> +      properties:
> +        phy-mode:
> +          const: rmii
> +
>     - if:
>         properties:
>           compatible:
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 2ed4564ae99d..b20149c3e850 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -57,6 +57,7 @@ properties:
>           - allwinner,sun8i-r40-gmac
>           - allwinner,sun8i-v3s-emac
>           - allwinner,sun50i-a64-emac
> +        - allwinner,sun50i-h616-emac1
>           - amlogic,meson6-dwmac
>           - amlogic,meson8b-dwmac
>           - amlogic,meson8m2-dwmac
> @@ -623,6 +624,7 @@ allOf:
>                   - allwinner,sun8i-r40-gmac
>                   - allwinner,sun8i-v3s-emac
>                   - allwinner,sun50i-a64-emac
> +                - allwinner,sun50i-h616-emac1
>                   - loongson,ls2k-dwmac
>                   - loongson,ls7a-dwmac
>                   - ingenic,jz4775-mac
> 

