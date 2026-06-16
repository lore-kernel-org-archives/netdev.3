Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D11EB5C2;
	Tue, 16 Jun 2026 00:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570263; cv=none; b=mXs+TTvg/ShTcA//vf8qx65f4gBWt1kJ9ZswbCnWlObqtQawxCREkLxEGIeghHSdEWEd4mlA3WYcPTs6VjooddJWjhmmqy61odH1O/r5FonUUBT1K26whUueD3CsakUU7IXvoshOBlBp+uuf5QO+Ad2anXsSN47uDEppliZjY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570263; c=relaxed/simple;
	bh=oDCsuCMb0UZskrnrhT93t4U6IJbXFvEYkSZJB+lCOTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrphi/4tOJJSXRFkEJMFW0Wc2IBQq1i498lQajI4uVfUbQdqytAPH5ecEHu1+hBuE6dG9CaCCEDwvtJ3WveJQc/08OfG6DXU5ulTnCUbaaG79t4T3WNlBYmnp9WeHjtPryE9IIw3sD73fjxiDCDeqphSkDhYzVhGMha/WoNA7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxY9AAxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxY9AAxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7931F000E9;
	Tue, 16 Jun 2026 00:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570262;
	bh=pwlfq9NsxzvBQnFHajGag7dZWGEpN/7xc03Xb09HCsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XxY9AAxNnPNz4OWCqKeqPTzktqgpClS279HKXuZWG02T1gng//GoRRLFl3uM21O3b
	 jBqgGY1FNhA4vTxmnbdz0Z1oLIsb3yBVxg1Qi1onXxmBOYFa6+RwODvNBlUBR6XmI1
	 eovEIzVNE3QEvhSq6cQKYAlKiRrnY+i27KfOglFwNloJ/PwJrCi8W0qn/0gtyrOf5S
	 lZs7Eldnw83o7Tv56BiZoBaV1cOQ3TOVA4B1692KmGjrFxPzuCVaoOz+2/VtlX4TiT
	 b1sYt98COLjJCCdG+bS5nvRimrYIwr8YjqZECpOX9oDdb9Kc/bbrv03q9dPthG4/SP
	 A3OXRedtmd3CQ==
From: Jakub Kicinski <kuba@kernel.org>
To: markus.stockhausen@gmx.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/8] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Mon, 15 Jun 2026 17:37:39 -0700
Message-ID: <20260616003739.1104538-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613112946.1071411-2-markus.stockhausen@gmx.de>
References: <20260613112946.1071411-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series

This commit extends the realtek,rtl9301-mdio binding to cover the
lower-end Realtek Otto switch families: Maple (RTL8380/8381/8382) and
Cypress (RTL8391/8392/8393). New compatible strings are added for these
SoCs alongside the existing RTL9300/RTL9311 entries.

> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> index 271e05bae9c5..de33364b67ef 100644
> --- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> @@ -12,6 +12,16 @@ maintainers:
>  properties:
>    compatible:
>      oneOf:
> +      - items:
> +          - enum:
> +              - realtek,rtl8381-mdio
> +              - realtek,rtl8382-mdio
> +          - const: realtek,rtl8380-mdio
> +      - items:
> +          - enum:
> +              - realtek,rtl8392-mdio
> +              - realtek,rtl8393-mdio
> +          - const: realtek,rtl8391-mdio

[Low]
With this change the binding now describes three distinct SoC families
(RTL83xx Maple, RTL839x Cypress, and the existing RTL93xx), but the
file still carries:

  title: Realtek RTL9300 MDIO Controller

Should the title (and the top-level description, if applicable) be
updated to reflect the broader scope now that RTL8380/8381/8382 and
RTL8391/8392/8393 are covered by the same schema?

> @@ -24,6 +34,8 @@ properties:
>                - realtek,rtl9313-mdio
>            - const: realtek,rtl9311-mdio
>        - enum:
> +          - realtek,rtl8380-mdio
> +          - realtek,rtl8391-mdio
>            - realtek,rtl9301-mdio
>            - realtek,rtl9311-mdio
>
-- 
pw-bot: cr
