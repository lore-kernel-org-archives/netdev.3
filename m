Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E883B67E;
	Sat, 13 Jun 2026 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781377627; cv=none; b=dSCx/srJ2SAmr9ggqmD1SsqxmvZTu9eUVdXrQwRR36TxcJ5Nt6oc1WcKX++8cRatSs/Z9triRILrGKnjmBqZLrDy6xTeU8b8mwTiRqOMZWnQT9vupYD8fHciU1prEJsY8/IbU78FWIyiUcnOnRRIEqGZYfieOZjWO/Q/6tusZMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781377627; c=relaxed/simple;
	bh=rRamYDko3skFoXf/T8kTN2L6k28IYyl2C8pmLRKYw9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXm5Y6Op+7NT84CklQi7ccr9pQdXjVZ1MUvFUCQcoht5CBnXXpfhqCx8XnES7sfVWaRJUJZZewFpy3tLKwqDsAQl8EOAQeYJ/+e3YW7QowafbZ4Q2YjUsugaumDxZffKyqLf2XoBfFDpalPrn7Oj8Iw4dQQniB5JQbJm/NF9bqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8DvUjUl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8DvUjUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86DA1F000E9;
	Sat, 13 Jun 2026 19:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781377626;
	bh=CuAWXykF7BQHKNBBvJx6xNE5z4keORn4vghIBe7B4U4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j8DvUjUlRc+PmWW8KbjgMzQDsTWKNzrxE+y67B0BJpLV/QcjdeMxfliOnT48gAtIH
	 y+1oPJYuMsIiRuZIeJk2ybXbbrfqUp2JNUvqf7UT5jJ6fwnjt8PJtG22t2rsheH7Q1
	 VAwPiaFHOC+d+JTU9lAFqQJW1wyjnM3GiW1E7dvBx6i71qZNlNpyM7FHWtWG8KZqMl
	 Kg4UMxk4dGIEZjQ2TXMfyqdUSYfYBh0elzi2OFScgDXlbe5hbRa39Rjlm7pX7dKYNf
	 1RXOYI00xxnat+nvbWnoQNqC3AKRBuJxGEBJPXIqYG9q/xp+500p5klZySWkpI+n/1
	 FytWNybqU6Img==
Date: Sat, 13 Jun 2026 21:07:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz, daniel@makrotopia.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/8] dt-bindings: net: realtek,rtl9301-mdio: Add
 RTL83xx series
Message-ID: <20260613-natural-spiked-chupacabra-b2fd5f@quoll>
References: <20260613112946.1071411-1-markus.stockhausen@gmx.de>
 <20260613112946.1071411-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613112946.1071411-2-markus.stockhausen@gmx.de>

On Sat, Jun 13, 2026 at 01:29:39PM +0200, Markus Stockhausen wrote:
                - realtek,rtl9302b-mdio
> @@ -24,6 +34,8 @@ properties:
>                - realtek,rtl9313-mdio
>            - const: realtek,rtl9311-mdio
>        - enum:
> +          - realtek,rtl8380-mdio
> +          - realtek,rtl8391-mdio
>            - realtek,rtl9301-mdio

I don't have that context in my recent next, but anyway looks correct.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

