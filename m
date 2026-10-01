Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B7F285061;
	Thu,  1 Oct 2026 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790834125; cv=none; b=KieEVmfRn0s+gfquw5RIyc9Vg+XHgeqY35M0nAR4vqdpiN9iKF+bt1TU2u63g1LF3ck0sp3w00vdBzOvhPoBdE3VCNxLlX/4hG+tVCX5AeItKJTGoae19GIsQgj0TjYGojxu7khTZ+cFO9QAB2466l3QA1ruqp11jJiT2z75BVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790834125; c=relaxed/simple;
	bh=VQG+6RcC/UsuL2/qrcC/BDhzj7sv0ZbL4XvPJR6d2jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUeATx3ApMTkb+gxCxzMaGJz9Mh/UTkcDRefEB/EJjwXyWbvmLMTC7z+3FzMSkr1+cVJc7oyV0ru8HK3o8KAUbLQHx0hOqIlxybM4WFVSAp1g2ozNi86PbePkerWhuFUtigQnx/r8jeWE6SJExW9TsANQoeRJiqDF0u2lwPrC1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3H20qSC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3H20qSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282C81F000FF;
	Thu,  1 Oct 2026 05:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790834124;
	bh=SuoBxeaHJ3VQHpgg7ms0oKOBF2/YqGb3bzdAb6NYIPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U3H20qSCQl6zLIBDuN61dLVoK42L6GfH+GmiGJ6NBiqDLBHhAULlUwEr0NDllviLG
	 iw8hMoPnZcfMo02DL6Rxt2wDiuh1YVRQuFB+7tGgE0KP2DkO/Z/dSAvdHcNEER7mMN
	 wupLvbkfMoPhpDTer+kGxkQDX2gv/4hZlzhcKBp+uKRLoa5ljHEO49mER6PvDq7jtU
	 GuIReX1+dFOrnoatRFH3txzTBAmzZ20fuTZAqTmAXz3IfImAambdZA56msn2KWdlqK
	 WNxgiXF6TY0FxstMYP12a+vyscqswvuQyGYWH0jhOUeCoaH8GzjgbdzQEbWh9VzB8A
	 gz+MuSYTf4Y0Q==
Date: Thu, 1 Oct 2026 07:55:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, hkallweit1@gmail.com, lxu@maxlinear.com, michael@walle.cc, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luka.perkov@sartura.hr
Subject: Re: [PATCH 4/5] dt-bindings: net: maxlinear: add MxL86211C lane
 mapping support
Message-ID: <20261001-splendid-athletic-coot-1bbbb6@quoll>
References: <20260930122305.293686-1-robert.marko@sartura.hr>
 <20260930122305.293686-4-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930122305.293686-4-robert.marko@sartura.hr>

On Wed, Sep 30, 2026 at 02:22:16PM +0200, Robert Marko wrote:
> Describe the optional lane-to-ASP mapping for the MxL86211C PHY.
> 
> The mapping accounts for board-level swaps between its physical TPI
> lanes and analog signal processing lanes.
> 
> MxL86211C supports per lane mapping.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  .../bindings/net/maxlinear,gpy2xx.yaml        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> index 0645e885f1747..b98cb3c3e6d49 100644
> --- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> +++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> @@ -22,6 +22,21 @@ allOf:
>  
>      then:
>        properties:
> +        maxlinear,lane-asp-map:
> +          description: |
> +            Mapping of the physical TPI lanes A through D to the PHY's
> +            analog signal processing lanes (ASPs). The array index identifies

Are there other lanes as well? Not ASP? What sort? data-lanes does not
fit here?

> +            physical lane A, B, C, or D, while its value identifies ASP A, B,
> +            C, or D, encoded as 0 through 3. Each ASP must be mapped exactly
> +            once. Omit the property to retain the hardware reset mapping.
> +          $ref: /schemas/types.yaml#/definitions/uint32-array

Best regards,
Krzysztof

