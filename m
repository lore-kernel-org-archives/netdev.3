Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10273655C7;
	Fri,  9 Oct 2026 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534976; cv=none; b=p2DyTgnKoCC8nwOi/IenQcQcOt+jnusxhJm0CaztDhLHeo2BzlF+yd+xD1W2VkhPk5DEvbM5QLju5HdIfWKM1ie6+GDpoUx104wwly3fgnYxBmbgH5AG4sqD2FLUxb0K/INDfpjB6TuvJ5rrr3Tw5phmI8qMlG6uu87B8o019wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534976; c=relaxed/simple;
	bh=1SqIwN6JU8buHKv38WL4LisHd0/TXPfSwZ3bIQLWeYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXG4qrp6O8ZIbxIx99xzozfqn4L7MIVyl0TIGn61gnpeoa1BJwK3GKB5UAJxUdsqVXcLce6nEROkA35EzLABq5y5loJrOQzZmB2BGb02iYp+/QLUoEurKFG+dLPV8JyYqAL6CEokFghYhagl5NciLG3NaAiPKQ9osPJ0SaS+9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nja6rhOw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nja6rhOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C546F1F000FF;
	Fri,  9 Oct 2026 08:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791534974;
	bh=4WlGPZ54svZCU+yv4o/S7va6SD9ZRUbV9dZirPNS7H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nja6rhOwRtngSNzSsyeys9Yd+p+RazzEke4KP+S3a/h6htMCqVc5Z8zUe9sTqWZZj
	 +84nXC0t1qwaXXMcUtGcRv1AGS2VTeFPVwhIkx4FcZrYBJSFKxIkNJrb9VLTcx/+qn
	 1MpMSBrfLzj8uC8blj2VF7NYTHNOM+Y5dstHbytswbnX8VDPSZtDjCItT/5117Tkxy
	 xyy/Fd36dsOlQ4q+Nuf5cwDX4rpG434X0DR7Xgs+WMnZguIVnLn5gVrGIFzFhEmPpa
	 S2KuKEr41WYpIQJ22/6jNAs863WBh2j5VMnP0MBWVv4su/J+QpBoWDzYotAehKAoQi
	 YXalqsbBjiJXg==
Date: Fri, 9 Oct 2026 10:36:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Til Kaiser <mail@tk154.de>
Cc: netdev@vger.kernel.org, Luo Jie <jie.luo@oss.qualcomm.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Lei Wei <quic_leiwei@quicinc.com>, Suruchi Agarwal <quic_suruchia@quicinc.com>, 
	Pavithra R <quic_pavir@quicinc.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] dt-bindings: net: qcom,ipq9574-ppe: Tighten
 ethernet port node constraints
Message-ID: <20261009-glittering-fresh-squid-e2fcc8@quoll>
References: <20261005152915.101780-1-mail@tk154.de>
 <20261005152915.101780-3-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005152915.101780-3-mail@tk154.de>

On Mon, Oct 05, 2026 at 05:29:13PM +0200, Til Kaiser wrote:
> The port node pattern "^ethernet-port@[1-6]+$" also matches multi-digit
> unit addresses such as ethernet-port@11, which the reg property does not
> allow. Drop the stray '+'.
> 
> Also restrict the ethernet-ports object to its declared properties.
> Without this, nodes outside the port pattern are accepted through the
> generic ethernet-switch schema.

Simple test shows that it is not true, so I do not get how you
reproduced it.

Are you sending some LLM output?

> 
> Signed-off-by: Til Kaiser <mail@tk154.de>
> ---
>  .../devicetree/bindings/net/qcom,ipq9574-ppe.yaml     | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> index 6d0b21a10732..1a78e2c82b90 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> @@ -174,8 +174,17 @@ properties:
>        - interrupt-names
>  
>    ethernet-ports:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +      '#size-cells':
> +        const: 0

No need for any of these.

Best regards,
Krzysztof

