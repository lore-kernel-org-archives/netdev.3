Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7F39A04B;
	Fri, 21 Aug 2026 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787297590; cv=none; b=jFF3PP5IHcw89ZePBpARvSWG2+TdUCc5eQQo9rP2UnpjUOfbK2k7zVng+jvHMfkKabZqSV/lLi/9mRt9UTCrxMUPXt2sjFsRDI1R78lP1K5VLIyJGPkJsXQXK+jv0szoWc6Fv/lGNlszYujdIBGn06r1v7ZiGKdnihesB2jHqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787297590; c=relaxed/simple;
	bh=b9OB2gG3blDM9bwepMDA1I9B8qFV8yrMSWdiBO6lhSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2C9yUdBOouJQpIBsuETWMJUnx4DpokWdhAqrWe/oXJdzC0rkTyIH0KaOkiwWZNDrFp9UhwSfmAV3/TimIW/VKxydu4q+dcGYIImondthohvmhP6nRLffQxs0oIIciy2GqI/X3rX3JSLfvAfxgj2/jm3iv9eeSFngdG9gTf+g7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjuA2IpM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjuA2IpM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04221F000E9;
	Fri, 21 Aug 2026 07:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787297574;
	bh=BWMPNzaVcGUTkbFZ01H2Fyc2EgomV1eK16oTZyHdxL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OjuA2IpMdtrnj/Hj5XBAE/Fk2LinEY9swHHebdeSdd6Ktczo3fxnmArbDZqA4nr+K
	 C3hHco5kr33d8U+j/2wVLBLKfYawlaUf954D2Riud8HvmgvTxsvOzwMTAF8zKXokxE
	 stOlJ+/ZL1bG6q24gViatyZ3z6H/iALvbK+C8vcGKC2YeL83ISHQBp8+4GN0oMUF1R
	 E5QlsmdxxCdLTUensw5MYiD03HBHbJmEj1i5+GhbY6jWFE8Lgwoj/YLWRJ9B/LHiCJ
	 wqWo5bmL6zCDcNoNV3r78LnK0j3jfzIsmXvJcUoq0Wh8l5EA/QDB4P7diGw8r0SDSB
	 w+FcHFf0c2MEw==
Date: Fri, 21 Aug 2026 09:32:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 4/4] dt-bindings: net: dsa: yt921x: Add LEDs
 definition example
Message-ID: <20260821-stalwart-convivial-moose-8537e6@quoll>
References: <20260816193905.218112-1-mmyangfl@gmail.com>
 <20260816193905.218112-5-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260816193905.218112-5-mmyangfl@gmail.com>

On Mon, Aug 17, 2026 at 03:38:59AM +0800, David Yang wrote:
> Add LEDs definition example for yt921x to describe how they should be
> defined for a correct usage.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  .../bindings/net/dsa/motorcomm,yt921x.yaml    | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

