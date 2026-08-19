Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3F26F288;
	Wed, 19 Aug 2026 21:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787176040; cv=none; b=bwSX7BCfvsHae7cgcSx3mIRJZ1OAMFBDpI99MHsnNGsyX+VbO35h3y/i6w1rkUlaOnSLB+zIlNad5t92EtAMSKMoiBRYMejmmXD7vrmSQsLjzDfQ4dW21L9gcPXHz80WnQyCZM/84Hy/khxyD3u4hSHRuXL5xqc0AhjN6CIDcj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787176040; c=relaxed/simple;
	bh=A0SwSTtGZWqgKUg5fZ7Z7avuv5nMrNbjtK6QYDyjNAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBNsca4wmv/3+MZna9d4Re5FJFOG12OCVv0+7baEkXgMjdudreTtV6gCfPkBbBAAKjRnO09Tkdc+AIPueDaqvtaXvHWaCmyuyaW9ui7AGB0EPuSERhQC7QrE3Vw3noCVYpFxpTk7oEhEg5c+TpdKyZJ+wI6fqdszQ3paEEVFVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=YdSPfwbV; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="YdSPfwbV"
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 2280953401E3;
	Wed, 19 Aug 2026 23:47:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1787176035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ci/dzom+Y7I8mrGm8hDBfv8OTssxZBW6Cswzv+7RVPU=;
	b=YdSPfwbVp2Huuwz+QCOeDiSAVGObaSQ0odMk0zIf8bkXw4adutrCqpONJ7JcXiW1/f0C4K
	MfSycL1fj+FaFdeoYMTpbwY61CACn+RWFMZwrG9dOFPZzSlqtdcWkM4vqaLpTc88c2/0Vy
	WeDvCs14dpGGUQbzSjjZ1dY2iMExoLA=
Message-ID: <40161970-ae7b-497d-a0ee-98721b0ce6d3@ixit.cz>
Date: Wed, 19 Aug 2026 23:47:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: net: nfc: add st,st21nfcd
To: Kristian Brox <isyourbrainfoss@proton.me>, oe-linux-nfc@lists.linux.dev
Cc: krzk+dt@kernel.org, devicetree@vger.kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, luca.weiss@fairphone.com,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org
References: <20260818205940.1973944-1-isyourbrainfoss@proton.me>
 <20260819210906.2500789-1-isyourbrainfoss@proton.me>
 <20260819210906.2500789-2-isyourbrainfoss@proton.me>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260819210906.2500789-2-isyourbrainfoss@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2026 23:09, Kristian Brox wrote:
> The ST21NFCD (e.g. Fairphone 5) speaks raw NCI on I2C. Existing
> st,st21nfcb-* and st,st21nfcc-i2c compatibles stay NDLC. Add a
> separate compatible so those boards are not switched to the wrong
> framing.

No, this is not reason why do you introduce new compatible. You do it because 
it's different HW. The fact it shares the driver is irrelevant in the dt-binding

> 
> Also document the optional SYS_CLK (clocks) and VPS_IO (vdd-io-supply)
> used on Fairphone 5, and add an I2C example.
> 
> Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
> ---
> diff --git a/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml b/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
> index 1dcbddb..4bdbb36 100644
> --- a/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
> +++ b/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
> @@ -11,10 +11,14 @@ maintainers:
>   
>   properties:
>     compatible:
> +    description: |
> +      st,st21nfcb-* and st,st21nfcc-i2c use NDLC on the wire.
> +      st,st21nfcd is ST21NFCD with raw NCI (no NDLC PCB).

I think you can omit this description completely here, but if someone had better 
idea where to put it, I'm open to it.


>       enum:
>         - st,st21nfcb-i2c
>         - st,st21nfcb-spi
>         - st,st21nfcc-i2c
> +      - st,st21nfcd
>   
>     reset-gpios:
>       description: Output GPIO pin used for resetting the controller
> @@ -36,6 +40,15 @@ properties:
>         Specifies that the uicc swp signal can be physically connected to the
>         controller
>   
> +  clocks:
> +    maxItems: 1
> +    description:
> +      External reference clock connected to SYS_CLK.
> +
> +  vdd-io-supply:
> +    description:
> +      Digital I/O supply (VPS_IO).
> +
>   required:
>     - compatible
>     - interrupts
> @@ -49,6 +62,7 @@ if:
>           enum:
>             - st,st21nfcb-i2c
>             - st,st21nfcc-i2c
> +          - st,st21nfcd
>   then:
>     properties:
>       spi-max-frequency: false
> @@ -81,6 +95,27 @@ examples:
>           };
>       };
>   
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        nfc@8 {
> +            compatible = "st,st21nfcd";
> +            reg = <0x08>;
> +
> +            interrupt-parent = <&gpio5>;
> +            interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;

use interrupts extended (interrupt-parent + interrupts in one line).

As a last point (for the series), never send a new series with Reply-to (as a 
followup to existing one). It looks messy, we have tools to track series :)
see: https://patchwork.kernel.org/project/oe-linux-nfc/list/

David

> +            reset-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
> +
> +            clocks = <&clk>;
> +            vdd-io-supply = <&vdd_io>;
> +        };
> +    };
> +
>     - |
>       #include <dt-bindings/gpio/gpio.h>
>       #include <dt-bindings/interrupt-controller/irq.h>
> 

