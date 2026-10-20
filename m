Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480786;
	b=o1cBU1lWBj99MF8/0Q6EBOuKrtp4Q8BSe+se3rhgtcZfaKbOBobqvE9yxevUqE22jcKu
	 ba2RORWbY3J9DrDtDhB+o05KXDEpaXjoy7bquzCA6cyfFGz5MxRmO7HUG4yw8HqcPyF+1
	 IUaSrSsd8EFRDLFfI+/dYAi3xBtTBfJsffLqGCdgJIKBpYF0Xc8NlmoqScQ8Skv4+2unK
	 gsVFgrInbPLfXTKA5ibkMNwbaxR2RNaQUv1PriglSjMwDtJBWm00YuLLk0uD+PJbCeAcM
	 /3iNY6iwCNwiY+YWyqHIDjT3K178Z4dAu5veS40GL8dZZQL0zgHfkIiX985Hzsi6vBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480786;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ui9p0aimwq/+/RaSYtQ2u41VZdG+ZsDq8umW+9wZaS4=;
	b=09hdO7oXGG/thPhZJi1PMLzHi+6TyXrSWduKrtKavj2P+edR3YMRCM6/XDLMjEjI1jlh
	 BAxApYoxj/L4FoTPW57CwLKwW8JJdczOwXHY3DHQtBEbVCTjKdgbUeDepkLYeNh+vwjks
	 FEZxfx2Rm6lvj0Ql73OpYEk5fPB4hSVNbhl7bjoMALh06SKy6/Z/f6qNsdj3AQsH9xmyU
	 SO5WYuzpBEdrT0sw0+mKiPtVoR1EU9Fv9O67hdtqVSwC8HVZ7nfRH1cavXGxJajvIpQw0
	 tYnAXLrh3uAD9hCnzKndxcnnEcFSukB0TFXh/jbo8Ev0JpSCcaP/e61mBNHP2yumO1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmhphRlQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056A3606A31D;
	Tue, 20 Oct 2026 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmhphRlQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3891F000C4;
	Tue, 20 Oct 2026 07:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480785;
	bh=Ui9p0aimwq/+/RaSYtQ2u41VZdG+ZsDq8umW+9wZaS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bmhphRlQyGNivJZ2bRFw490m+bzd+aOVK65B1oyiPPtuQXMzdhK0g2z/iZWZ9Kcul
	 Gol0ybzQ/r8yunYwcOIhjtHNKBzER+g0WyC88B3iscvFFBAb1kYaSoxHuSMgveVP8g
	 4xw5fGx27Q2qIgO4gffRsp1uA2lzysm9UTlycvBubs5A9dsnQOM7iSLrblyaPV7fVa
	 q8kP6Xk3a0P4PPdYjqKUiLnTqJ0EN/jqqyMpAcHZAw9g6xOh3P9XmfyFg4sEjiu3PA
	 2az9SUj3RhqeTiY774C1suCjXfn3eKwLgAJeAL8+J8wPodJDhjFi5FO/Xh9c7ZiVvg
	 Q0wt4OWx9tYRw==
Date: Tue, 20 Oct 2026 09:19:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Richard Cochran <richardcochran@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 2/9] dt-bindings: net: qcom,ethqos: add
 qcom,shikra-ethqos compatible
Message-ID: <20261020-hopeful-delectable-dove-62f1d1@quoll>
References: <20261017-shikra_ethernet-v3-0-26a8beb44b8f@oss.qualcomm.com>
 <20261017-shikra_ethernet-v3-2-26a8beb44b8f@oss.qualcomm.com>
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
In-Reply-To: <20261017-shikra_ethernet-v3-2-26a8beb44b8f@oss.qualcomm.com>

On Sat, Oct 17, 2026 at 03:15:13PM +0530, Mohd Ayaan Anwar wrote:
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 6
> +        clock-names:
> +          items:
> +            - const: stmmaceth
> +            - const: pclk
> +            - const: ptp_ref
> +            - const: rgmii
> +            - const: axi-noc
> +            - const: pcie-tile-axi-noc
> +        operating-points-v2:
> +          description: |
> +            The OPP table specifies the rates for the NOC access
> +            clocks in "stmmaceth", "axi-noc", "pcie-tile-axi-noc"
> +            order.

Drop property here and move description to the top-level part.

> +      required:
> +        - operating-points-v2

Best regards,
Krzysztof

