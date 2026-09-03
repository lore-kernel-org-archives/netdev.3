Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954449482E;
	Thu,  3 Sep 2026 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438617; cv=none; b=SdLFnoQIR9/+V/qNLNArVoIQb6StRByqiuXaVluLj2SsYGhHkiAU+rmUV8jWYpz2MfEOvyduHe2ujPzshP4/fAVFbi0+l7ewbbKpt2UfQQdbiOFkvXM5ALMxpag8APAt8LUBuSUQcP7lR4i2acTOypU6fmXAc15MBxczQoCHhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438617; c=relaxed/simple;
	bh=1meer1S+mfXtIILxfELgKfL/Qaui+5xDZpM3yaXIdrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaNgObSvhyYGz4QzI39jjb5H2IHOxqaXmN1rkF22bcu1LhRg4do4MQ1MfMNQH1bvgWpG8th1/FXGhOViKPYj2DhzBww8SCbSKb0GcnH8BQKgpTaLmCp2sRh+Eqli6EsGt4unYhikZkfhdDZt3r5JVNbjHpNEbYzyVRj/7WDCMFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6PLw+WtQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6PLw+WtQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2LEdP5WEkOAstHLEOeG6RIPT++CaVDSMM+uGfZsMQQw=; b=6PLw+WtQZd4vnfA5YVSfF4w5i4
	po6LXl0ErCCFr1g0Fj5SJjtMiP/oiVpdCRINNPV6tlueBlslcvXfnposatsciyJEW0KqG/s18S+17
	HTDgRikUYbiBC1PMyYHpokJ93QROcU7CfmIq3DXIBnPeUNxbtkT10gOrJGPf670OYCMs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x26Zv-002ijF-Ls; Thu, 03 Sep 2026 14:30:03 +0200
Date: Thu, 3 Sep 2026 14:30:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: realtek,rtl9301-mdio: Add
 clock-frequency
Message-ID: <6dac1467-969d-47e9-ab51-770b4ba481b3@lunn.ch>
References: <20260903122119.2638354-1-markus.stockhausen@gmx.de>
 <20260903122119.2638354-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903122119.2638354-2-markus.stockhausen@gmx.de>

On Thu, Sep 03, 2026 at 02:21:17PM +0200, Markus Stockhausen wrote:
> The Realtek Otto Switch ethernet MDIO controller supports different MDC
> speeds ranging from 1.25MHz to 10MHz. Document the clock-frequency
> attribute for the device tree.
> 
> There is neither an offical documentation nor any obvious registers that
> indicate a dependency to one of the hardware clocks. The usable setup bits
> are more like hardcoded values than dividers. Without further details do
> not add a clock reference.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> ---
>  .../devicetree/bindings/net/realtek,rtl9301-mdio.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> index 67e0b23a8470..6db3315ce96b 100644
> --- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> @@ -56,6 +56,9 @@ patternProperties:
>        reg:
>          maxItems: 1
>  
> +      clock-frequency:
> +        default: 2500000

Please list the supported values.

The fact this is messy, different devices supporting different
frequencies, makes the validation more important.

	Andrew
