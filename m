Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BBB1F4631;
	Thu, 17 Sep 2026 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639470; cv=none; b=GamU/uujxuHkHgpB2oUd/07NkTJH3/ldRXr0ZS1q5V+4Uz6RQ3nvdBHhpAwqnT17++C8dboLu86HnRjqgqVVyiUi0dO9S20KHY2Tz6QKJSSPwXr17SxP0YCPe4mCuUcJd1f4QQwaOUC8HDeGRxVa3sRw4b9SppbyWUilObVvrK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639470; c=relaxed/simple;
	bh=tqUsQnVQ6+0AGejYyjS3eeE+jYuqzZYYt2aVEmhleFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biJS5UPZaPbpaKY1L3fgWBv/Hql80NBYbRd6VqFGCDqy3QHzSbcRwZ/prBM8muMh2UJm1DvXo6UItFxKySMDzrf8IGT9hp99sJ8h0ZwfheId6FQTt3TnKIQ817HM7veDTrVy86RVPBv2sfJW6AA02DMvguJLOUX9pXwltE3rSeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCWO23E7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCWO23E7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3A81F000FF;
	Thu, 17 Sep 2026 10:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789639456;
	bh=9RJR2h0qHtxMiw9TYA3+iKS1eMqprIRMDs4v7Dy4PLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oCWO23E7KxKz8qfc36onezw+s4uvcvZKbFDjGYlDb9R8zOZq2Hpb9UHIJDysoVhuK
	 rz5Nsh6zw8RPtmNi4ZbevYC/BPq2HOe2kyarxeIDM6bFM4zfJsOM8CnjwICuA+Vd70
	 yVM8iugGHOZRDzsjPJG9BEdSgRnrm1F0riet0B7I7FEdjLl3HgAVAtX82w7NXooGoS
	 CZx/02xumAQgM7OfTNzbyol1MS0eBVrEB278ZG5Y52zpsoTIQUkqVajQ7VwBbqGLqu
	 rx0/XdbHnk5wOkjOC12XSxkvoM32sXzukSLanuBifqEhpFD9Yd2Ura6A/iAReeFK0K
	 MV4p5XuYiPHdA==
Date: Thu, 17 Sep 2026 12:04:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arthur Crepin Leblond <arthur@marmottus.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Message-ID: <20260917-sexy-quixotic-ermine-138eab@quoll>
References: <20260915-wiznet-link-gpio-v8-0-d173622474cc@marmottus.net>
 <20260915-wiznet-link-gpio-v8-2-d173622474cc@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915-wiznet-link-gpio-v8-2-d173622474cc@marmottus.net>

On Tue, Sep 15, 2026 at 10:06:03AM +0200, Arthur Crepin Leblond wrote:
> Add an optional link status interrupt which can be connected to the
> LINKLED pin on the device to detect link status changes. This second
> interrupt is only supported on wiznet,w5500.
> 
> Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
> ---
> v8:
>  - Remove Krzysztof Kozlowski reviewed-by tag after Sashiko review
>    changes
>   - Make the interrupts property conditional
> 
> v7:
>  - No changes
> 
> v6:
>  - Fix DT error: use minItems
>  - Remove conditional properties
> 
> v5:
>  - Make the DT interrupts property dynamic from the compatible one
>  - Fix DT bindings errors
> 
> v4:
>  - Update interrupts in DT bindings
> 
> v3:
>  - Fix DT binding errors
> 
> v2:
>  - Convert device tree binding to YAML
> ---
>  .../devicetree/bindings/net/wiznet,w5100.yaml      | 38 ++++++++++++++++++----
>  1 file changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> index 25098308eb6e..da03f4e07f29 100644
> --- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> +++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> @@ -12,10 +12,6 @@ maintainers:
>  description: |
>    This is a standalone 10/100 MBit Ethernet controller with SPI interface.
>  
> -allOf:
> -  - $ref: /schemas/net/ethernet-controller.yaml#
> -  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -24,8 +20,11 @@ properties:
>        - wiznet,w5500
>  
>    interrupts:
> -    maxItems: 1

Broadest constraints always stay here.

I already asked for proper syntax here:
https://lore.kernel.org/all/688f57cd-a098-4904-b8cd-965470a89386@kernel.org/

https://elixir.bootlin.com/linux/v6.11-rc6/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L127

Best regards,
Krzysztof

