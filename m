Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6136F434;
	Thu, 24 Sep 2026 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790288257; cv=none; b=m/UyBjP1CqiSI88PtjMBxX9oiV2gS8Ihwf30UavTzPuJNZsRoV7yUvb8Zp5bYkuLI2iEAjfkin3bpz+wrLA8rL0qI0r23dAXcRyE6+Ke/leH4BpQGg75l8TBxf+qRUitwvy+Nj4MQlfB0XRqe6/LysVEKPaluEvTRqLBfZu15eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790288257; c=relaxed/simple;
	bh=h24SNJIaEn/tZnDu27CzuWnpCkIP1oZYET8feUpQlg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZleeNcNENyevgYoed5nrTA25aYXfodkonuqYw115VQ3F4Jsaus4E6Y2VKE8SCra9dsSMOOvs5XQK6FVJ/cVmlZIgij8VHDpI2AGxSicf7UGH0CxQ8y3SkX6H6bHQK0fSXOSQxw5dW9dPMrd81vwS6uMrwXqGdJI4Q1rts6MExI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvWc07eO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvWc07eO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392D01F000FF;
	Thu, 24 Sep 2026 22:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790288255;
	bh=eVPtgm7IGqpAuXlkLAQsbQji9h6wA6eT15yAS4IHfrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nvWc07eO0bnDGeGZuw1bOITomT3EOv21j81RnAlImoKv1ug63di5lZfpkNK7baFW7
	 TxMVegoRlSRKU5sLlligGO7Hk55Wh/WleaTQEcRWjMocToLarz/2UuPNDRy0Uo6PSB
	 GsSiSJHtgDiJUzu4PvCeYy64ijF4WABznalX4Js1I/cLPe6UnPXGKQV5ufnJuMAls0
	 qx0s0/T/59FVL0yPQV0koqByPK0WA2leP56KM31nRKjZW82IwJonsf9MhVcFCh8YuC
	 bMBjrIlFkrHHpb1sUKRgWURATNK0pjog/kDOTwNUAIjnYYys/mia+C0olaWb5YZe3J
	 Vknl2iwJS6O2Q==
Date: Thu, 24 Sep 2026 17:17:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Justin Stitt <justinstitt@google.com>,
	linux-mediatek@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Simon Horman <horms@kernel.org>, llvm@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH net-next v16 10/12] dt-bindings: net: pcs: Document
 support for Airoha Ethernet PCS
Message-ID: <179028825241.2006083.15037022287865565001.robh@kernel.org>
References: <20260916235200.20712-1-ansuelsmth@gmail.com>
 <20260916235200.20712-11-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916235200.20712-11-ansuelsmth@gmail.com>


On Thu, 17 Sep 2026 01:51:36 +0200, Christian Marangi wrote:
> Document support for Airoha Ethernet PCS for AN7581 SoC.
> 
> Airoha AN7581 SoC expose multiple Physical Coding Sublayer (PCS) for
> the various Serdes port supporting different Media Independent Interface
> (10BASE-R, USXGMII, 2500BASE-X, 1000BASE-X, SGMII).
> 
> This follow the new PCS provider with the use of #pcs-cells property.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/net/pcs/airoha,pcs.yaml          | 261 ++++++++++++++++++
>  1 file changed, 261 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

