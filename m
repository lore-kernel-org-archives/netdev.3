Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6B73B19DB;
	Wed,  8 Apr 2026 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662433; cv=none; b=hySvmVSS9nvCakK2MP/e0oeqx6pASEBo2rBFHiOM1MKIxCuAlziFlO0qnVnt0mJOl6M5E+8BMxustyGyrQ/GiyZratV7W3AYuSPzbL49qM8WWRCGEy43D3o6+x2pKlMkoKD05ft0fMOSRwEu6TNkJCh3NOMaoGeId5cfuQLOjGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662433; c=relaxed/simple;
	bh=gWqgbchWPm9z6SNfknKsis8mTRWKzpW40RhbUqEb7pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLFWTX4x5bIMQcQ3PNwnUzaMQV+5QLzVGX8eej+Wa3gbr2V9aCc+gThz8cTEU73VzypI7MRmia8TpFG5Urof7EWE85qLX3A3NahAKXJOB5jNrwk8q5vKHYEbgRol731E1MpoazazGNVoZqUt+ztgT1AI73yTg/pSarHhGBKJox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uwY/XJNm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uwY/XJNm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8Uykcwf1/jusGhi677ao2PaEFHdQ0GoTAXYWwBrCb1c=; b=uwY/XJNme/3LLDWPW0fICklwUX
	gLM4Z9OEfOBDB+8/hHkBi9lXWLMW5MC7UxUhvNHwp8OwdBzH/XTQJEGbsL3v+SqufRslh8JYlqHSl
	+VjWve28F8N0vEku4zKPWRk/execLBSp7SuSDPJtU9qYc7sKGI3Dp2wSgIHfgdQfjZFA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wAUuQ-00FJF6-IT; Wed, 08 Apr 2026 17:33:38 +0200
Date: Wed, 8 Apr 2026 17:33:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v1 v1 3/5] dt-bindings: net: starfive,jh7110-dwmac:
 Add JHB100 sgmii rx clk
Message-ID: <c69cf692-87be-43b5-93ee-38040d5cb1bf@lunn.ch>
References: <20260408084416.29753-1-minda.chen@starfivetech.com>
 <20260408084416.29753-4-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408084416.29753-4-minda.chen@starfivetech.com>

> +      - description: SGMII RX clock
>  
>    clock-names:
> -    items:
> -      - const: stmmaceth
> -      - const: pclk
> -      - const: ptp_ref
> -      - const: tx
> -      - const: gtx
> +    minItems: 5
> +    maxItems: 6
> +    contains:
> +      enum:
> +       - stmmaceth
> +       - pclk
> +       - ptp_ref
> +       - tx
> +       - gtx
> +       - rx

If this is only used for sgmii, maybe it should have sgmii in the
name?

	Andrew
