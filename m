Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ACE30C60C;
	Wed, 10 Jun 2026 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781077708; cv=none; b=dL5utnP3sQ4WCEDdcrgX333+Wilk2Fat5TCeW1vfebUt4iPLw162WH/haZtFFbi40Bs8g3mUCJHLpQYo9d13qUqVScCDCWy4GC4cY5y2ACsBdgt3fNu94L2h1U+yQTjqebBqYTO0FfRRRNDvVmkI4D8r24y9dkUeLXRrhplGmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781077708; c=relaxed/simple;
	bh=AP0KvO7FRfIaPrQuLAGpmKUfEUalxOS01TFwrGE3Jww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHQrUoZX021DQK3nTUR30wajQRPCVBrgeZOu0OX65SGqGBtT7/y6H66hIWj6m9cb0tLhdedBlrajiuqqvFkwAxGlTcuSb6WojjweF/DP6rr/U16vpRws1U9wmIHDRmVK0czIg1Hagt4XjnbyYwdmtYTJ1RL9hw1PXgDrUh3V+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK0bOpYz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK0bOpYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638011F00893;
	Wed, 10 Jun 2026 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781077707;
	bh=BpByu+4r0Jil7SYcQMOmxaSrcuGydaoH1G97vA7TyoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FK0bOpYzoKJfCd+JrVcWYUAIFZoIBh4UCnTtHQCKR4logrCAnDloZBixOMfssTwe7
	 g+LWVyrPK9AYBKWe1wnFVgfnjdOy9s6JpAK7L7E3LC4Y2+IjqXY0iQP0RTP0Mngybu
	 JEl6eBIX2Koz3bm0VnYqi7LvTZ09aWkdz5kAzQbLt20ZJmIydbIx81Ss7+3VWKUWkx
	 aR/Q+lQsxDzk7BlmNB+9OQYITyG8SmsYoue7CN4g3NZPaJyETnsb9hTAth7WfTnGPf
	 GIfLdSdU0RarWauHvFD4y4p73vExRvAphu1LaPhWc8p8JcSPL5jvLGtlKYVxEDUEGL
	 l/LQIljbn7N8g==
Date: Wed, 10 Jun 2026 09:48:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz, daniel@makrotopia.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] dt-bindings: net: realtek,rtl9301-mdio:
 Add RTL931x series
Message-ID: <20260610-prompt-aquatic-bison-ceedd8@quoll>
References: <20260609052856.3142922-1-markus.stockhausen@gmx.de>
 <20260609052856.3142922-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609052856.3142922-2-markus.stockhausen@gmx.de>

On Tue, Jun 09, 2026 at 07:28:52AM +0200, Markus Stockhausen wrote:
> The 10G Realtek Otto switches are divided into two series
> 
> - Longan: RTL930x up to 28 ports
> - Mango : RTL931x up to 56 ports
> 
> The Mango based devices have 3 different SoCs RTL9311, RTL9312 and RTL9313.
> The MDIO controller of these switches works like the existing RTL930x
> logic but has different characteristics and different registers. Add new
> compatibles in the device tree.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> ---
>  .../devicetree/bindings/net/realtek,rtl9301-mdio.yaml    | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

