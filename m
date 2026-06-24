Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE902F7F09;
	Wed, 24 Jun 2026 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782324462; cv=none; b=Pc6Ee9Q/Gjo9l9LdJEl2doswAL2gLq+vA6Eh//LMo4X8PIbHAZlqazGlRTMWRKIICMfjkLUhr1fHY2JcqRgTApkZvX5s9+dSGO/YhomadRFKUbw3lN3ht2pBm5dTjNUkvfW2o3CfaiImL64jbdSOS3wTqeidSAIp3yne5KOlYA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782324462; c=relaxed/simple;
	bh=vIeB7hTO5R/q0aGnn0P1wUkQqXgjBEKmTnkptIBTn4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7oUKYlukfj9TXv+zvs+ubnm8AE0XsNassN4aOhx6IlPLY8o2DwZ04RcoTd8a/noyYfnBhjbyHwnvjf1yrnBfMsr8u8uVSMYnkz6HqsgU9TU+ZJfzDfiOJgJtss6NuShKME4jYc1z1LTHpSF0a5chMjBVt/lXcv3U6ns9r5lEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=ojDgyyR2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MGVcnImH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="ojDgyyR2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MGVcnImH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D35CEC036B;
	Wed, 24 Jun 2026 14:07:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 24 Jun 2026 14:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782324459;
	 x=1782410859; bh=CBO7oDIF3KnSR35ayUSjsvhUhbG+HEgdxE0c1Pcve5M=; b=
	ojDgyyR2piSWwyY0BBWcUHxyjknFlE3Kpt8VQlguGF66HW7MqXjU4q1Zxr8I5NMI
	9oC6B4gPkclwXe3pRxI30fd0KIz1clenNBI3zLdTpEC8DLtidAWmWVNXJOfrRMD0
	OADZCGpVhpl859hVQKgRTNd0E1XzPvE3rXBWWyJhQAnzGKUX9hmv1D9Sa23uz6yg
	MT06Hk4zemB4hvFEJS+Jgs5WCiZh9nxzGmcnSP8hDE/RuMIu3lQGN5IobaTdyAwj
	zrHeDWBgatclAZ13DBdN+QeO6QtPjhEFbjlN2vk2mfL7Y8mBHMTNyymSLE4FlPsg
	l/OajZHk8rbsgE2u+DTL8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782324459; x=
	1782410859; bh=CBO7oDIF3KnSR35ayUSjsvhUhbG+HEgdxE0c1Pcve5M=; b=M
	GVcnImH5Ud4D54TCcaTcUS5zjyf39hm2O+1/JhvafZflyN7yhU6SsHEMkcL0bQ5J
	9tLyV65f7xn+KKt2lXESUNX9SWMqNDDsFn5Pdyf3ONHrxw7UiYszMxIeRYAbWlD2
	VP0uKHpPAqU110Vqg5VE+iwCeOiZmTeLdtFIGXhhsyOuHxR8enGzLM6uBRQx4jvj
	hPhC4OMvlQN21n+92XYA6P0K6uAboTXL4Ts6KjWe3fN8ViwGgFgmbTK1YCQMUHO5
	2MWb7qeAZug02QW45V+PwN0dmvRNq9Alf+CsS9jLNHxqvAgz+V8Ut4stUwsDkiIl
	rRHwQdciZHMp2POnsc4vw==
X-ME-Sender: <xms:6xw8ajFZBMygWtrg-ng1sLp0HhclCeb4XfAi4Qicc-2x4FX9_lXDZw>
    <xme:6xw8agxz0rAB0YWfD-lEYSfrsbz-NNGz_1z8qBMr9LbQk8pMUWWuc39fL82dJGlNI
    pUEG8r7keWwZ5dK4b8zJpVGA43V-9KE6avyYl2JBWS71RS3efZC2Bs>
X-ME-Received: <xmr:6xw8ak406zSTfrj5VnAJ1MYQ2nkbNJd0p3dFPMVKZ3J49NOYB60ZJ1phamFOkOj1Yy2r1hFPU5hSDmhB6mrGnGVLtImQVNc>
X-ME-Proxy-Cause: dmFkZTEpiQERQE3oBq7W0Xaj6SLWgPNdfBzbhu5hBuzlRNrQlkNxGpmHkE1xEmeA+g4SjJ
    BkJd5R8x21Bb038jK6ybX27YfQJorZaN5a8EsCH1J3yxIhqTRVYYQxxGGt5lVK+x3mtfza
    P5K3IMou3hL2332QWy2d1R7Y1CTBR/L7mukqke7KwWH3j0TxZG0KSI8tEhhiHfPzliRmwa
    6Vb5fZhTypDmHFzDyE9G0/DXZSxP+o9lIk2w+30C4F54KpqaZwvTZpAO8YYN/RJpFbWHvH
    /c2SQOM6ZFKa1HEyUdA/RRBzvIUJoM8oac96K9zzf2qVbP7cdgfLPqrUj6iE1IeES5ADcC
    CGIriOv/FU86n5/Jmusd0Bh+v5gF9auojoR31QeLgsrz5kByM5riE8thbA2qqX0IDsIIYj
    uaNvqY5JlrwGXOKXB6vF0SkPJLf/ZEyWv+ATtJPAHqO64+L4Z9oI6tNF8ebQHc0cfGf/0M
    yXfeGtYkOhiefhLc/ZFbcnDTdswxZO6NJdhIFSMiXC0i1lorTuCUrfBxVQdeT3n+A5vgEb
    5cdSanhL1DuG8DxqFKmRJZRV08VFIQhDXK9dqlygwKw5YFafOmV6fV63ov6S2wV+8D1agx
    bUwhEaks5/CQbH64P9Ve7l25XRgfReevibxq6ShZwOcVTAxeFLB6KAP78eGQ
X-ME-Proxy: <xmx:6xw8atconQuw6tmIf5UphSWSwJZIKry9iroatgOFGZYticpwL-QwWg>
    <xmx:6xw8ajGYeld6oNub300c--FvDHcEyWEf39rkfbgGZ-4KhR9VtZ5gNg>
    <xmx:6xw8al4yzuIFjgwoMMuJ7nYnt68HVBQYinSV2PjmwC_5rwPijW3hzA>
    <xmx:6xw8auttBdp3hIjE2zqHDX_5ucao1aDnukHPyyB6e4VXJsP3UPWnmQ>
    <xmx:6xw8agg2aVWzW4HDPGx2XBn81Hlhm5Ne4qLLOyZJqRoOGxlRYsasKL37>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 14:07:38 -0400 (EDT)
Date: Wed, 24 Jun 2026 20:07:36 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] dt-bindings: net: renesas,ether: Drop example
 "ethernet-phy-ieee802.3-c22" fallback
Message-ID: <20260624180736.GA1325538@ragnatech.se>
References: <20260624150250.131966-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624150250.131966-2-robh@kernel.org>

Hi Rob,

Thanks for your patch.

On 2026-06-24 10:02:50 -0500, Rob Herring (Arm) wrote:
> Fix the Micrel PHY in the example which shouldn't have the
> fallback "ethernet-phy-ieee802.3-c22" compatible:
> 
> Documentation/devicetree/bindings/net/renesas,ether.example.dtb: ethernet-phy@1 \
>   (ethernet-phy-id0022.1537): compatible: ['ethernet-phy-id0022.1537', 'ethernet-phy-ieee802.3-c22'] is too long
>         from schema $id: http://devicetree.org/schemas/net/micrel.yaml
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  Documentation/devicetree/bindings/net/renesas,ether.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/renesas,ether.yaml b/Documentation/devicetree/bindings/net/renesas,ether.yaml
> index f0a52f47f95a..dd7187f12a67 100644
> --- a/Documentation/devicetree/bindings/net/renesas,ether.yaml
> +++ b/Documentation/devicetree/bindings/net/renesas,ether.yaml
> @@ -121,8 +121,7 @@ examples:
>          #size-cells = <0>;
>  
>          phy1: ethernet-phy@1 {
> -            compatible = "ethernet-phy-id0022.1537",
> -                         "ethernet-phy-ieee802.3-c22";
> +            compatible = "ethernet-phy-id0022.1537";
>              reg = <1>;
>              interrupt-parent = <&irqc0>;
>              interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> -- 
> 2.53.0
> 

-- 
Kind Regards,
Niklas Söderlund
