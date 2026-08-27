Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6733B2FD6;
	Thu, 27 Aug 2026 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826495; cv=none; b=C4dYsvl6hw9Rp62ro7l9fczadHusVdK4D71Ex/83y4RxJbcKQzGGUJzeFeXcUURp4SmvZ8PCTzzDgatIaN+92TG4XWqPRfdG1oXOjjA1t7DS5RCbIlDYIPBi8gHgt3I0PVdt6zSRe5IZJrkmhuMvxqof/VJ7HEnQCp8DGBvMCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826495; c=relaxed/simple;
	bh=nChn4rlQUCtdSr8nIfgF2EfaL1lNFIZKDySapoehtSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaOmdEZsgU3yvI7C128d7cW9ycpVjAtj3XxGZU3KrRZb20nUkiLRBBZjbrSevY0Q/tEeh/P1pr/jfy+iv1Uk03mk3Q6nvgSKJACJaiwELjIgSTG8YSKrz2yZ0vTZ6OMA5g7cKKPyMb8w8VMgvXlZZjY9O94jpPdu5zC97u4sw9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3DR6EXA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3DR6EXA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C6B1F000E9;
	Thu, 27 Aug 2026 10:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787826485;
	bh=uFhyXk1BQkFc4FNjXEieU96lgniqpaJCjHWk5HxsK6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L3DR6EXAnjt4at1go/HAAn0WHCJlLJjRGGzhdDVpN6m5KDc9qnbl9eRCrdeCxVA/D
	 evete4cL/sF8VUC4sDBmTJ9DpeYa1A34Y/Lfhg9OUVS2qzX3A1QIij1pmtood+SD8c
	 ITpGNsVeps/6C4d1cN67gK9tQ/6MA6KLItRDcOMRVM1A1JZ+JNo+TAmAh+KOCo7i2J
	 8WmIy2RQcgX9ynW0U+64PHNYK8TcVIM3k+OrehyyzAuubF4F6+FWIrBLJ5SijkDPcC
	 JeCccd0DGzc84Rrbajwyb4UHVQTm/6v+Edj+caXLGpN/6r8bxc4SJKz1gVAEN5pNQj
	 Mn1lHaWHLpkwg==
Date: Thu, 27 Aug 2026 12:28:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kristian Brox <isyourbrainfoss@proton.me>
Cc: Luca Weiss <luca.weiss@fairphone.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: net: nfc: add st,st21nfcd
Message-ID: <20260827-slick-mahogany-ara-bdbd1c@quoll>
References: <20260820-fp5-st21nfcd-v3-v3-0-5ee0a7f44d04@proton.me>
 <20260820-fp5-st21nfcd-v3-v3-1-5ee0a7f44d04@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820-fp5-st21nfcd-v3-v3-1-5ee0a7f44d04@proton.me>

On Thu, Aug 20, 2026 at 08:56:07PM +0000, Kristian Brox wrote:
>    reset-gpios:
>      description: Output GPIO pin used for resetting the controller
> @@ -36,6 +37,15 @@ properties:
>        Specifies that the uicc swp signal can be physically connected to the
>        controller
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
>  required:
>    - compatible
>    - interrupts
> @@ -49,6 +59,7 @@ if:
>          enum:
>            - st,st21nfcb-i2c
>            - st,st21nfcc-i2c
> +          - st,st21nfcd

This is not true. Please open datasheet - it clearly says SPI interface.

>  then:
>    properties:
>      spi-max-frequency: false
> @@ -81,6 +92,26 @@ examples:
>          };
>      };
>  
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {

Both clocks and vdd-io supply are valid for other devices, so just add
them there and drop the new example.

Best regards,
Krzysztof

