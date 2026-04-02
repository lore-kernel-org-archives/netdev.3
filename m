Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53D1C84BB;
	Thu,  2 Apr 2026 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114898; cv=none; b=IiB1Ay8GtiYQXR69dgB09NCIsIWkTDsPuLDHD6+TjgaLE1Cu0R23lfgfx3eNI2raVWd4z6Rkh8WI1nb3WGfqIb+t3NKHDgrQxbYxKd6xV8YeFzbpk1bTM/TobB9rZa6KKpohOrcgSnw7wd/w/ztGLulydmp+ToT99YN1oxv8pkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114898; c=relaxed/simple;
	bh=9coRbM7iQYguurCkJbtaZbv43ox1qglRLQ+Jv/1pW3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs975+2kQE4bqJ0DSRflGL47gA/OYRnCAebw3Ye+wLa4nj+AGxziAnMujqkVp2zhGIDityf+uJRp81B5JB5sd8Vifocba59DsDgWjyfLaeOeiRgVd+XfY2pLqRqT9mQEXPFZq/r7I51OOhe9yma1JqZqECS3YUsSOBnO/MuZfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEYzy0dC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEYzy0dC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22974C19423;
	Thu,  2 Apr 2026 07:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775114898;
	bh=9coRbM7iQYguurCkJbtaZbv43ox1qglRLQ+Jv/1pW3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEYzy0dCdgAZaeFtTncS/0Geo14pHpbUm5TiDpNQtlPXUCbv7gf3Cu6a9AFE5CORR
	 gQJtqGMe+xBph2gKQkEuyOBqWThpV4rbo1PuWIoejFYI+1B60pUUovzHFrlf3Hr3zT
	 86kUT6sGKnx1btgom069H3GvuYCbq0aUkD438RejcRaroutMR6/A0XTi+rPWBDzubT
	 PGbpAH2vOAiVcf0+Zqj0Il4DBSdXL6PD5luQbYQB1sEMJibWPztODvDxOCEYZRzC8X
	 d66YxKw+b5c8ESxW0sMtqQ1yOM/jDLY/BVaqwj6LE7fNWt5JXXKQqjiNbdNkqGFOoD
	 vhMnw0LHusSAg==
Date: Thu, 2 Apr 2026 09:28:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Tero Kristo <kristo@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH v3 1/5] dt-bindings: phy: ti: phy-j721e-wiz: Add
 ti,j722s-wiz-10g compatible
Message-ID: <20260402-unnatural-polecat-of-promise-31fbde@quoll>
References: <cover.1775045279.git.nora.schiffer@ew.tq-group.com>
 <b9d6a9322ce4f7dc3363dc00d93ab0256e12a8af.1775045279.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9d6a9322ce4f7dc3363dc00d93ab0256e12a8af.1775045279.git.nora.schiffer@ew.tq-group.com>

On Wed, Apr 01, 2026 at 02:25:21PM +0200, Nora Schiffer wrote:
> The J722S WIZ is mostly identical to the AM64's, but additionally supports
> SGMII. The AM64 compatible ti,am64-wiz-10g is used as a fallback.
> 
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> ---
>  .../bindings/phy/ti,phy-j721e-wiz.yaml        | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> index 3f16ff14484d2..283e3eedc0f31 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> @@ -12,13 +12,19 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - ti,j721e-wiz-16g
> -      - ti,j721e-wiz-10g
> -      - ti,j721s2-wiz-10g
> -      - ti,am64-wiz-10g
> -      - ti,j7200-wiz-10g
> -      - ti,j784s4-wiz-10g
> +    oneOf:
> +      - items:

Same comments as for netdev patch.

Best regards,
Krzysztof

