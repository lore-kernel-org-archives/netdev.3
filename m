Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F7F1A23B1
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323122; cv=none; b=D/KNzqNzz+Ussm7ZpIMDy1WG0AmMaP/3xsByU83KOZQUEH5J+a/hp1Mzy5F4ZTDMOUDkRpRcOvIurAQsbI9rmr9waYNvm9J+WSaMAgMIwis8shyxpCEQ5YFvUkXK9qkchjPXMhqC2uZnAWQlWRsPZqnTVORpj60nLPAfsZ+Oku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323122; c=relaxed/simple;
	bh=1tD5pPrvMnoCHzCtJiuVn5kZFGViWPXFoe6999PS/To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9ZYtEsWv1XXEIbrPJXRDPXHYTD2Oa4E2gjMiCuD/p03x3z9M91vjEaRVeq515Y8xts7KmukajJCDAvpZfnUG12SGfgrdpT8HmR5sVtoWACZ0GY56Iav4VqYrLB6wdosbCwC97MVYJCJMKHggE8KySJ+cBgfOb0ppN14LlkyYgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCzbkQnJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCzbkQnJ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso1077016f8f.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773323119; x=1773927919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/MzT9OXjxJMGmMrqTMakhYaBCjsIpZiUbODg9e6XnE=;
        b=eCzbkQnJYFpB6tkUtprN5SkiVZK1pdfH8+sZAgLKDpwpF6RnYSnm5ctNVkDz8sLAFP
         7AtQGYEfKVrbWGOSb0UwYNluYtFrZqSdXm1fDI4wfgsdhQ17Lpz7BiK/CIwWPIO80glU
         lM39fphWPQLImWtp4bsctGSlhBPxbLIHlo8CQuBTMhR0W3lZLtMHs6yfEpc3NJOg6QU3
         nXD9L+MMfveoTaWOn/qy4mr/IKqeeDHoNAn5mtl36FeNZ0QhCLO4EiMEb3/V07KT2JbQ
         B079rIQker7ZnlLWX2ZRHVfkSQKq7VSHknrTy3tJNAuR8dxVyF8vhIVsspUwolsDGoVQ
         jJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773323119; x=1773927919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/MzT9OXjxJMGmMrqTMakhYaBCjsIpZiUbODg9e6XnE=;
        b=uJUlQkDuJkIZfWmLyUwpK0ySXZVi8sUClLkTMdB8p+8CWNZWcAggrP0Dj5o8qVzeS5
         NeLXybOSRYOykfGk3Im+mv2GjRkqXrVGyISOH9SE6oTwdgP8eRMR0VPKm5E2BQjzLQog
         lDxDGo24/3RQLlhA9htdEHnUqOTvO4E3eYdDinGuivXaOA1uQi114KeMXIdrz2AHv0rK
         8qOEoEnRDzp8eJZUw4RMb4PCVKL5pdj/pM/YpfSxqEGKbfou4JAz0ab4/5q3oxnuPjal
         PW/b++YCpNoM0giKSddry6qvoYWYvvYlRo7Vw47X0XhYBJD9MBwF/K0EvDIS0eVm2JYe
         1bbg==
X-Forwarded-Encrypted: i=1; AJvYcCVXADTX4JqdEIOn6eQMIt5hNcNWZ+OWB5F5P9xTar7pD8K4A1zH+Hdcl8FVyOoww8fQEQI212A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb5mrFUExf0mt6GV0ucSP+L7FX0/hqZn18GoPrzKSc4veVscqK
	6pkmOmMomvRf159yKSAJTX1jg/xmBs3VXM6unSlgy25i8qvj6Uz/iQ4I
X-Gm-Gg: ATEYQzzy4qStObn2bylE+3hrZzgWKDp1oSjKASgM7PEDM64+wDkq65TTisOQq15OzV2
	kh6oOb+ro6CYV0iOnT/FvVQN0efknj7OUDVfFaF0Sp/Jw0tp5vRyQIfoP0t3HE43EYkGWzumCUF
	QyyT1sMR3MlNc+RugldxRYYiRmMEDrEBydu3tFZYu0mwFTMOo4DsLzQN4ETOkZuSv7sE4D1oCF5
	LlUGwbkV/yFFWXBI8RKZZWWyhHCt4ke17G7pcg3u0XMke9/lS/NspB6yRGDEwH9hA6CGh6mOpNA
	Kd9y9kJAqojAgsziJpEQPORo/LCRlMudXYTd59tnd404vWh7mMmQ39+gHaopyW/q63+ERlagahN
	Y85AhG6d7B9umFF2MmCFxIeYdVsgOwHylu2pEeG8MxofewdTuiudP/WnXZEPm8gmrLce45Uk+0h
	iGzzSJklxjSQ4LoKi6x1qqsKsoTdncA1fnSg==
X-Received: by 2002:a05:6000:2204:b0:439:b940:8bfb with SMTP id ffacd0b85a97d-439f81ec76cmr12353254f8f.15.1773323119226;
        Thu, 12 Mar 2026 06:45:19 -0700 (PDT)
Received: from eichest-laptop ([77.109.188.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19ac34sm9090650f8f.3.2026.03.12.06.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:45:18 -0700 (PDT)
Date: Thu, 12 Mar 2026 14:45:17 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: net: micrel: KSZ8041RNLI supports LED
 mode
Message-ID: <abLDbbgox24m76Fw@eichest-laptop>
References: <cover.1773321267.git.geert+renesas@glider.be>
 <6ccda7a00f250e87b0457e276ac1070cb0708d71.1773321267.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ccda7a00f250e87b0457e276ac1070cb0708d71.1773321267.git.geert+renesas@glider.be>

On Thu, Mar 12, 2026 at 02:27:36PM +0100, Geert Uytterhoeven wrote:
> Micrel KSZ8041RNLI supports LED mode, just like KSZ8041.
> 
> This fixes (a.o.) the following "make dtbs_check" warning:
> 
>     arch/arm/boot/dts/renesas/r8a7791-koelsch.dtb: ethernet-phy@1 (ethernet-phy-id0022.1537): False schema does not allow 1
> 	    from schema $id: http://devicetree.org/schemas/net/micrel.yaml
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/net/micrel.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
> index 5d25f0d0a508a6df..7fb61c78d16cd801 100644
> --- a/Documentation/devicetree/bindings/net/micrel.yaml
> +++ b/Documentation/devicetree/bindings/net/micrel.yaml
> @@ -54,6 +54,7 @@ properties:
>        KSZ8021: register 0x1f, bits 5..4
>        KSZ8031: register 0x1f, bits 5..4
>        KSZ8041: register 0x1e, bits 15..14
> +      KSZ8041RLNI: register 0x1e, bits 15..14
>        KSZ8051: register 0x1f, bits 5..4
>        KSZ8081: register 0x1f, bits 5..4
>        KSZ8091: register 0x1f, bits 5..4
> @@ -80,6 +81,7 @@ allOf:
>              contains:
>                enum:
>                  - ethernet-phy-id0022.1510
> +                - ethernet-phy-id0022.1537
>                  - ethernet-phy-id0022.1550
>                  - ethernet-phy-id0022.1555
>                  - ethernet-phy-id0022.1556

Looks also good to me, thanks for the fix.

Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
