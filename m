Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6223B1009;
	Thu, 30 Jul 2026 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400040; cv=none; b=rm3v5WbHZuuM0Orzzy26dPMnZWGHcgumLFdY3RG1GVIHyzTt24WI74JSEy3VHeJzTtP+0d3lqfmMnspIsv87IavrNq4/HtvqS3AU1eCanmjY8zOvgj1GiYf+fCCpAWcSR5xtL4JipM+3I4GwkBlDQ8tyNQLhyG1skGczhrua0Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400040; c=relaxed/simple;
	bh=MC3/HWMmjm0uJwMQVHVAl2Y+ib9jRwwMSKlUO4GcHhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNdketCU80+C1onBOiEisjgFjGPe7ImhLxH/FlzoLTVycaXoHiweNH1bGJ5TuuX6Q4nIxD/eL3yQbbrWHaVkSeT+Apo6gR5Db+IYkgaRKcRTt0JqqZo/WHETIjlbnvGLpwPie7Ytmp65k+1sOAXhWTTOus7kBp0TQ4WI5Xg7n/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGORvmoo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGORvmoo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093921F000E9;
	Thu, 30 Jul 2026 08:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785400036;
	bh=ynUIE+OmGITuTnDcYm4pdy5E15n1t8RviFFzWHgFPBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YGORvmoonkdoewLciDAteO2KJ+3ljKDoXhdVceRx1MQblS/hxzAlNumE6DegrAgoM
	 Zcgtg9bNa35V4lD6OvtC/bJa4Z7nda/TOHETtITwT7n6yrGNGehZdcG1sB+o47Y9e1
	 OS086oRjJUHJWz4uPDrgOA1ayuR6dtb055dWa2CBfO+4mFHchvXsZ/BFuvaEOyTSc4
	 R+rItOGG9z9ZbrYGU9AAdwtKpigwvUn3L43zXnIYTqaImXFcOQjfA2wA/qd53xC92n
	 0SGAoJVhIS/hrew2ODhgZWXv3Por6U7OXARoHqlz94+wVqdycwyeJNVrolpawBJV4B
	 GGgtCRyXc2A0A==
Date: Thu, 30 Jul 2026 10:27:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gavin Gao <attinagaoxu@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, richardcochran@gmail.com, nicolas.frattaroli@collabora.com, 
	sebastian.reichel@collabora.com, sashal@kernel.org, alchark@gmail.com, chaoyi.chen@rock-chips.com, 
	amadeus@jmu.edu.cn, rmk+kernel@armlinux.org.uk, horms@kernel.org, 
	alok.a.tiwari@oracle.com, david.wu@rock-chips.com, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: rockchip-dwmac: Add 25M
 refout clock
Message-ID: <20260730-lucky-strict-oryx-9ce8de@quoll>
References: <20260727021048.3375444-1-attinagaoxu@gmail.com>
 <20260727021048.3375444-2-attinagaoxu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727021048.3375444-2-attinagaoxu@gmail.com>

On Mon, Jul 27, 2026 at 10:10:45AM +0800, Gavin Gao wrote:
> Some Rockchip GMAC instances can provide a 25 MHz reference clock output
> for an external RGMII PHY.
> 
> Add a clock name for this 25 MHz reference output so SoC dtsi files can
> describe it separately from the existing MAC reference clocks.
> 
> Signed-off-by: Gavin Gao <attinagaoxu@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index 0ac7c4b47d6b..074ac274f2e0 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -81,6 +81,7 @@ properties:
>          - pclk_mac
>          - clk_mac_ref
>          - clk_mac_refout
> +        - clk_mac_25m_refout

That's the same as clk_mac_ref and clk_mac_refout. clocks are not
outputs but inputs, so explain how does the device take three SAME
clocks: clk_mac_ref, clk_mac_refout and clk_mac_25m_refout?

Best regards,
Krzysztof

