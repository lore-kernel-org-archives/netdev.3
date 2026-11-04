Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788681;
	b=VigsNstbpoj38YeJ1GolCWXYwVqOjsvDJnx1ndBcu5k+uzGkJV7HOla29CnBSc0GCHWO
	 FqzLlCFowxmfiwacz8HzSr6lzduzcR+OGETbUDOZvwG2e7DkHcwKc4V7/EReEwIagqtP4
	 3EbLm9r/p79D70Qk1wsWf4vtRGxr3xNGF7OZhdlxHRoFHNXJVgSM7rznz2jRvVD/2chOr
	 5YM9LD11AVr8rjsROX4QFe8oPjDtltjQkUS3ParN9e+zpp+dCrXiquWYxAOIElvhbJxtr
	 eALOReiD92ySuW3e60aw98HzmkiUmH9kOZyC38tXdl/t1ACa+XABQWgnhtnw5CyKnFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788681;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Hg5P+ZRZSjSwStS0M8368HqB4GPBayyeLSUkGa3qSME=;
	b=OBWz5Y9uEjO6//OBNmNowsbTOoNwoX8cy3v5++3OFcvXYDGV/QmG0uCF+TgMYwl1x65o
	 Gyzvomo4s3/dZppts3EpJMvAbi9VP7l5l8eTy9bh/PTGe6d1d9rkDJaPecLs0cAFJnlZ1
	 GsjaKSAGF+9j498RSDK1iodLjKZxwdj2PBfw+93PrbOmAlDE5uWJlgXhUVkl9Eg/tibX3
	 n6Ke7LzBlpn1cfIOq9htduol1ogyAosriDvH5MXc+jV8ChvQ+zJ6aWYaTco2FmC7AEbNw
	 pY5u535x95OiZeciPG+10RDYOaNOQnfQol3XYFR6p0OaHpA5JTdra+VWkHRBP+MUbkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O8nd1Zka;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F703606A32C;
	Wed,  4 Nov 2026 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O8nd1Zka
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74CD1F000C1;
	Wed,  4 Nov 2026 10:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793788680;
	bh=Hg5P+ZRZSjSwStS0M8368HqB4GPBayyeLSUkGa3qSME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O8nd1Zka7C4i6ewawjLjcddUeG3m8bZYQTmFTBmk/+OSb7FdN5sU12nkrWhgYZcgz
	 GnRz6AIzDwexyIMonClnB2PM9db3ZcM1qW2pIVB2NghnEAzVkx2HZ3UdAgBi7roAtg
	 PjSEnPvMwkJfHrQflndEzJAd/hGX4TWlKe/HBiVGBgyvtdmbRNebpoaqA9rmRfzv5G
	 JlaWRa1v1OU/oIcRa1ukKkM3ecX/NepNa3UjEyD4pi0S4S+noVezeXKITaobe/FLgg
	 zrOZp3YzVb2YXD78yPGXTH0Uy9hTohsJ/ahpieajshCLogepHwJvYYdGfzQU1M1n1A
	 5r6rjGwKsGTSg==
Date: Wed, 4 Nov 2026 11:37:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Po-Yu Chuang <ratbert@faraday-tech.com>, Eric Dumazet <edumazet@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/7] dt-bindings: net: ftgmac100: Make Aspeed
 compatibles standalone
Message-ID: <20261104-helpful-courageous-hedgehog-f05bbf@quoll>
References: <20261104-support_ast2700-v5-0-44057f4dde75@aspeedtech.com>
 <20261104-support_ast2700-v5-1-44057f4dde75@aspeedtech.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104-support_ast2700-v5-1-44057f4dde75@aspeedtech.com>

On Wed, Nov 04, 2026 at 01:13:54PM +0800, Jacky Chou wrote:
> The aspeed,ast2400-mac, aspeed,ast2500-mac, and aspeed,ast2600-mac
> compatibles are currently only valid when paired with the generic
> "faraday,ftgmac100" fallback: if a node ever bound through the
> generic entry alone, ftgmac100_probe() would set
> rxdes0_edorr_mask/txdes0_edotr_mask to BIT(15) instead of the Aspeed
> BIT(30), skip Aspeed clock setup, and leave the DMA mask too narrow.

And device would work or not? If device still works after all these
steps above, then why isn't fallback applicable?

Be explicit, because I have no clue whether Aspeed clock setup is
necessary for device to operate.

> 
> Make each of them a standalone compatible instead, so none of the
> Aspeed compatibles require the generic fallback alongside them.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> 
> ---
> ftgmac100_of_match[] has had dedicated entries for AST2400, AST2500,
> and AST2600 since commit 03a2aba50b2c ("net: ftgmac100: List all
> compatibles"), so there is no known kernel + devicetree combination
> where a node has actually bound through the generic entry and gotten
> the wrong EDORR bit. This part is a binding correctness fix, not a fix
> for an observed failure.
> 
> Note that arch/arm/boot/dts/aspeed/aspeed-g4.dtsi, aspeed-g5.dtsi, and
> aspeed-g6.dtsi still declare their MAC nodes with the two-string
> "aspeed,astXXXX-mac", "faraday,ftgmac100" compatible, so this will make
> dtbs_check warn against those files until the redundant fallback
> compatible is dropped there as well. That .dtsi change will be sent as
> a separate series through the Aspeed/arm-soc tree, since dt-bindings
> changes don't go through that tree.
> ---
>  .../devicetree/bindings/net/faraday,ftgmac100.yaml         | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index d14410018bcf..c870dd0bda7b 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -13,12 +13,10 @@ properties:
>    compatible:
>      oneOf:
>        - const: faraday,ftgmac100

This const goes to your new enum

> -      - items:
> -          - enum:
> -              - aspeed,ast2400-mac
> -              - aspeed,ast2500-mac
> -              - aspeed,ast2600-mac
> -          - const: faraday,ftgmac100
> +      - enum:

here.

Best regards,
Krzysztof

