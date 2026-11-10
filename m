Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306223;
	b=vDifNiN4Cc26+PKilUXKOIOJu6oU6sWQUMIcsw9kniVBA48pdh+pmpBSKwy9nbYfxfn3
	 iLCQHKWw4j1M4q72LQDBVk10kY3CNCNi6sbuo9hIfvnrydTrYS/VRKKQpwryO+AfZnVCw
	 XUyoNbZW88nzLTFN6Faq2jbbtSv9ATWxwTyPe8ynsl/tWum5Xdj1MkJ//XCdxlUBgYBxC
	 6/YCX+6c5JUo+WWL/mW0iquiGc+1DU3b3Pt1JSsLTx1/5x0MTK1mZFVnA0+yDthgekVKW
	 +9h1DmfqqfJJruxEUOZU/heQPQZmDLdjcPlyILP7FD6RJNmXguxO5BGSs7XlMgQbSrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306223;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jg2+rzX5//wzQlrSA93Hv1wCdPwb/nOi8lpYf6/Rec4=;
	b=LlxJolGJn9LONCKFC0jIJznjnWxjfqGkRfoBiut19lPEL2oMCnlLJHQBoTYe/AxBmYq8
	 8Bkbckr7MGxMKizMCb6rzqfx+PDiAzVSLWeaHxCfpKKplibG+k6LtyqKZJys4J6KliacN
	 qGwOXx12E6eQGyFcc6Biw77KRZpUOToNOzj9FRilSkPhsHlyeOv3K01o2YMPYiX4m2IIp
	 DTQpH5VjUa2axgBAloHXqJ+YT2HcNFzzQLBW3QyTq0ZS15BaqP4wjP/tRJ8mjP/HlMsXP
	 vAcXPF37uNLrS2yQJ+HhpZkJlZ4Ambk0Hm/Y93Yyxn2wEKmc11UqZSCbw5u91AIwryg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OEtRIXC/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F0606A330;
	Tue, 10 Nov 2026 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEtRIXC/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1271F0089F;
	Tue, 10 Nov 2026 10:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306222;
	bh=jg2+rzX5//wzQlrSA93Hv1wCdPwb/nOi8lpYf6/Rec4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OEtRIXC/aStoOlSbkD+83cEGOo3/ajoFaxcyJycZxC9le+rmWlGUHz0C+EOEwRCCq
	 EDbN82wsI5hCOJjAhLwOc6VB44zF/dfnvMdefumMH2d8XYWheUOukGYRXEe0PQB0gp
	 wbnRFAU8EIcLhBmwwP2OKmd20ILT7BlbBnq78su+eQzgpBvmR3xmkVlWKLhGLxfWw8
	 FTiDBPpcB56ve2QCY7/fS0lto5xCkAkWcXc1QhWBQqP8wTwAnW60MQ93MMCggIXZdw
	 IRMkYGMZd4FtcCYz50N5kQWvJXtxmUsOQMCH18kGzQFw4M4m9ZQpELwgEs3zMjUuaD
	 bBYRjCNKEAWwg==
Date: Tue, 10 Nov 2026 11:23:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Michal Simek <michal.simek@amd.com>, 
	Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 2/5] dt-bindings: net: dp83867: add
 compatible and reference ethernet-phy.yaml
Message-ID: <20261110-prophetic-arboreal-locust-8515c7@quoll>
References: <20261106-v7-2-topic-dp83867-v3-0-45e1d3adf1bf@pengutronix.de>
 <20261106-v7-2-topic-dp83867-v3-2-45e1d3adf1bf@pengutronix.de>
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
In-Reply-To: <20261106-v7-2-topic-dp83867-v3-2-45e1d3adf1bf@pengutronix.de>

On Fri, Nov 06, 2026 at 08:47:26AM +0100, Steffen Trumtrar wrote:
> The binding has neither a compatible nor a select, so dtschema never
> applies it to a node: neither the example nor any devicetree is checked
> against it.
> 
> Add the compatible of the PHY ID, optionally followed by the generic
> ethernet-phy-ieee802.3-c22, which several devicetrees use. Select on the
> PHY ID only, as the fallback alone would select every clause 22 PHY.
> Nodes without a compatible stay valid, but are not checked.
> 
> The binding also references ethernet-controller.yaml, which describes
> MACs; its node name pattern does not match a PHY node. Reference
> ethernet-phy.yaml instead, which also describes reset-gpios and the
> other generic PHY properties existing devicetrees use.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/ti,dp83867.yaml | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

