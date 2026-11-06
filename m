Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979899;
	b=yzTTYI7NlpEu9zUOOBnTsVUGKAk+VNABmpKYDhoIQEQXrDA6Urj/G9vhGZUqG9GNQMdz
	 AAGF9VEem4KAHvEpnneiyhjzGLahQ/p2HRJcTpv7Qe1Il3uOd7Ml8FOHELNmEggPpNG0e
	 JWTWqDdqzerDgJ6rR2+hXBJSfNUNi4r+cKNQA9tST57mJ5bHUI6JDzcORbM+X2ckbwaVs
	 emDX8sABQFQ8auvyTqObK3jMjBPJlkLF/GruS7GtG42fLnnW1guUiHwkvQbBolr6AVREK
	 tV2dni90ebb2kM7X5QkIJ2rVNDzXtLkKGPKS8RSJLJZ5fiq9R2rgjUnrMcfBY5B6SXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979899;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=m7TGBcFGJ25PzS3E5FjcY3XCx1Va4AtTHtI7meNpbaU=;
	b=B+dZ88Zv8TcK9q/QNVB/170OI8zJGz9wMvBg/4VPrZbINgCrfHGNyetYSfdEK377cgG+
	 q/Ox4kU02wfejhQo3lWP2xQZDds4O46VE/zSQVsCwOfu7hjRmqteTIVUEr7lNSS39fnKA
	 5RilJ4mhfp0poFaUbS9NjnL4C08VW+A1K8byAl0ZS7QmxUU/nc73sg1ZHLB7cKgKZcVl1
	 RZDnu/Czx/rKJP1nb6z/tZwfsLD+KN/OgStgXfzC+5kfktPzH9EURGgYHXIBWfCii8shj
	 0bVBbgEHSh3Cnncea+V0jOXnL40gQjRfLIQyMqb4tsYQFCjGloXXuBhcmTaNP5ZqLAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxXy4qR8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A972606A326;
	Fri,  6 Nov 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxXy4qR8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128ED1F0089F;
	Fri,  6 Nov 2026 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979898;
	bh=m7TGBcFGJ25PzS3E5FjcY3XCx1Va4AtTHtI7meNpbaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KxXy4qR8Ki5rez09gboTTO/asVqsZh7bhqaj7H0ubtK5UcVhdVXNvVphmGw+crUeU
	 jBgvKz0u4gwBCPv+/f09/WHCQs5SflTaYwnT4ZYM/k/+0d9it6wH8PZV9SL0E9byYm
	 9jf3V4E/IrxVIZUhQZp0f6K4TDhF6nx42wiM3ede/LBZTtNXgYwT0S+xg/sQGwY1u0
	 ocU9HjN8/KCTBJZAGYUyXn+gS0o473ZB/9dR7w3NQbiK9sc2wje7dDl2BwEsSrKs75
	 GMFOIzeF0YKp8IcSkK3bndx1ysdn0TUnAxFXTzFeTRtkQXn/KsJ+pGzJgMMab+JzId
	 PItBYW1yiZ2mA==
Date: Fri, 6 Nov 2026 09:44:54 -0600
From: Rob Herring <robh@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH net-next v4 05/14] dt-bindings: net: dsa:
 renesas,rzn1-a5psw: Disallow ports beyond port@4
Message-ID: <20261106154454.GA3654918-robh@kernel.org>
References: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261104182105.1102555-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104182105.1102555-6-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Wed, Nov 04, 2026 at 06:20:53PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Restrict the A5PSW ethernet-ports node to ports 0 through 4, matching the
> hardware configuration of four external ports and one CPU/management port.
> 
> Although the schema pattern limits port nodes to port@0 through port@4,
> additionalProperties: true allows other port nodes to pass validation.
> Set additionalProperties to false and explicitly allow #address-cells
> and #size-cells so that ports beyond port@4 are rejected.
> 
> Existing in-tree device trees describe only port@0 through port@4 and
> are unaffected by this change.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3->v4:
> - Added reg items validation for ethernet ports
> 
> v2->v3:
> - New patch
> ---
>  .../bindings/net/dsa/renesas,rzn1-a5psw.yaml         | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
> index 9c477ceb170b..250c59e58439 100644
> --- a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
> @@ -63,12 +63,22 @@ properties:
>  
>    ethernet-ports:
>      type: object
> -    additionalProperties: true
> +    additionalProperties: false
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +      '#size-cells':
> +        const: 0
> +

Drop all this.

>      patternProperties:
>        "^(ethernet-)?port@[0-4]$":

And make this "^(ethernet-)?port@". Then any node will get the 'reg' 
schema applied. That doesn't check the unit-address, but the way to 
check that is comparing it to the reg value (not yet implemented except 
for specific buses in dtc).


>          type: object
>          additionalProperties: true
>          properties:
> +          reg:
> +            items:
> +              - maximum: 4
>            pcs-handle:
>              maxItems: 1
>              description:
> -- 
> 2.56.0
> 
