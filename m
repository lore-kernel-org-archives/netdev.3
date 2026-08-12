Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE33750C9;
	Wed, 12 Aug 2026 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564710; cv=none; b=F7+bsCnvx12ffJuFP35cLufp/qD0ATcFw5wUeCCzMlDnwCikR+Q+l7i9z0WTeYPZnwLIdoTCijUrfRDfENv9jh8slfrevMsACntUZAAHmsEci5NkOp4uex6XMt1mpidRNNUlEvVOOLGYgJ6NY9cbc6mQYYwzXOl9s/E8E51yJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564710; c=relaxed/simple;
	bh=tlSpxz+pW7sfd36IenC9YoBYnuzs+CeW4u1TCEPMS2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2KT+AaCPtbficzQAjPlSo8p91yECFVQJHcmX7/X8FFNkj55Xv08ROUl/WduL9JMzxabkUWaxg2peNMsYeafGuI/ITiGbLNdVwqFVvz71ZQ0jtSivAk1ZLZtMOg7c9hwD4rpSZjq29fx+TTkaCvI8Ww3GwWeIAst7ZoWU1aU2q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0G6wWDJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0G6wWDJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A961F000E9;
	Wed, 12 Aug 2026 19:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786564709;
	bh=o5YPmFtZG2zCjcC2+M+V37X7Um8tsyR4j5Qh/i/e6B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O0G6wWDJgixYjcOQrMbQk1Fo/DFF///H43Kl8QWgfl7n+/i5tL3jyK0DktmBNGysU
	 3EMifcz1MRRuluG5BqMrZWRfNvQlfrjfRI4/qf4b9ytD0mTUtUKERiTO18UNKMu5Ib
	 WrbjJESeb3ze4StqJTuycpgAO7C/tpdl+2gPGJOlHbH/bx5YKOiWxRFrSdk92pqvN+
	 6J1HxC1oULa+HFZeVXt4z+z0rsKCJD1TQvtiP5SLe9yPWo6HhSm1CQgaaWYryb8wz6
	 sFdtij7FEupcU8lL4ZSsJ6H/eJ+Yl2lDBcVKTN51CQK6odN1LHmyJ5kSUrrqtH8bTQ
	 mvlcUaqU8c6qw==
Date: Wed, 12 Aug 2026 14:58:28 -0500
From: Rob Herring <robh@kernel.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linusw@kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next,PATCH v2 1/5] dt-bindings: net: add phy-supply
 property for stm32
Message-ID: <20260812195828.GA724768-robh@kernel.org>
References: <20260812091122.566439-1-christophe.roullier@foss.st.com>
 <20260812091122.566439-2-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812091122.566439-2-christophe.roullier@foss.st.com>

On Wed, Aug 12, 2026 at 11:11:18AM +0200, Christophe Roullier wrote:
> Phandle to a regulator that provides power to the PHY. This
> regulator will be managed during the PHY power on/off sequence.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> index 987254900d0da..0c7eb1ccadd47 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -99,6 +99,9 @@ properties:
>        encompases the glue register, the offset of the control register and
>        the mask to set bitfield in control register
>  
> +  phy-supply:
> +    description: PHY regulator

Which phy? There can be multiple for ethernet. In any case, doesn't 
really matter because either is wrong. The supply(ies) for a device go 
in that device's DT node. This node is not a PHY.

Rob
