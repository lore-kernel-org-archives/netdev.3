Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73B3B4E80;
	Thu,  6 Aug 2026 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786000814; cv=none; b=WvWpcvdDQ78hoJ0hm7M81+dVQFwEeE8yp1V64eH9X1r8hwGDxWdpnZHRaztH6vpZO+Wbh9xar0zo7R69yKRB2cJShFX/wwWJ9VCWEw53OWjSIMskqWQFHx7I4GPC+baYOD8SChu24Z+4XxBVMIBzBSUpmM66ioT5mptsVYW+/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786000814; c=relaxed/simple;
	bh=+dRPDtCrMWsO247xWfrwD/ldRBUMeNV71XPB0+e22XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwuGKsukV9La83Xi5xOF+Ad3BvxwtCUrp6BYjnv2KRsb7vZc0jSrKwKmWI++eGgIlkc1KMefm71bnZsof2iiIHCrYLAQti/aeOse8cH9HGHAEcshQyGCniBjfTDs6VUFh7ARfysZn4dp+4F6YFa50Za10zI5vKUukGkmKbSexNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXM+4Mll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXM+4Mll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E356C1F000E9;
	Thu,  6 Aug 2026 07:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786000813;
	bh=liv2AYrrsHaRgqAOM9dW8AvvrFCiRk/DORj6vqfDl/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZXM+4Mll2Tt/gGcdQhKKSz0MItxJN2nvBsbl6R/sPQFjOCoS7vxxwOthFl9jiSfcd
	 i2fK3zQLABTZ9ZCLsWr+O4m3iWyf4gs5GqFdOTyF4PBs6apTP8R8XEWY26mOms0nwt
	 S0K2X4RC2G9osqUNvTUqgXOCI+xtBJfQOPbuaD2jZSrO0eDvNKrKej3i5xDZrlNR8P
	 3TwGS82l6TBeomdNyvk+f8PSzWElYDqgaom3kXil73UtxpY7R6MymA67Oj84RVezUj
	 tDPOIrio8lvAtNLHU1MQyZ0Sl8I8e7khmsEhS90O6LptkHiGifqCfr1iZFfOgvT1WZ
	 or7RBV27eM+ww==
Date: Thu, 6 Aug 2026 09:20:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/3] dt-bindings: vendor-prefixes: add
 Guangdong Dapu Telecom Co., Ltd.
Message-ID: <20260806-classy-cuddly-limpet-9e6d8a@quoll>
References: <20260805085540.452260-1-a.shimko.dev@gmail.com>
 <20260805085540.452260-2-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260805085540.452260-2-a.shimko.dev@gmail.com>

On Wed, Aug 05, 2026 at 11:55:38AM +0300, Artem Shimko wrote:
> Add vendor prefix for Guangdong Dapu Telecom Co., Ltd. [1], a manufacturer
> of Ethernet PHYs, networking and other equipment.  The prefix will be
> used in the DAP8211R(I) Gigabit Ethernet PHY binding.
> 
> [1] https://www.dptel.com/
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

