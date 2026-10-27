Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793137714;
	b=RLgUOJzqCe27EPGnj5sgV/zJ4nQJZSAFzTUWhuc+ij7jrRbflGC67461WFQUzjsUkElx
	 UE1ZlnoYbdtvrNyiEflOIcPMkpoHRzzy5AzVPh2yGOPAnasf7hRl6uSohwaQEA2maDVaz
	 AS4cXFKVCrbBDCJTxdEFO0ky/2FqCVP4c55tNUpY93kjg1C9jZXpuDLwWqPuE7D+wYd1M
	 /AMq9IWM+0q+4LTjnaf1iPjjeZMSnlA7n9v+uEzOLjKESmMn2XAv6Myh6HGtQWacLiXhx
	 sjTwG/w5RTBFaRxIx4sFL+qP/kgnY+wk6qL1i6EgEkVo5KTkMyzNvvVXEvkSDbLSR1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793137714;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iZPro0Zetz+CfLgJB9N6QxpD/1Z6TlyduqwjCEpWEDA=;
	b=mjjbXCbKvD5lDSkeWebDn+RI7lMi0BGTph0YuDd1P199l1aEAGVqdwwoWXotFcutqEJS
	 JcyziZiE2kNMFogJ/8niVFyggechAJ1/E2ssYGix1TtxelYkbHIesVfaWoJ6LEHWkvbER
	 Mbalntd39J1Hhp1NOH6zze5qMBDdu2OOgiucuicUgJVnk8b7sseVcnwa4hZOu7/Pq1jeY
	 xycEmG2uDOKf7mKW9kXyxPgfp2LrM8zVenYEgQ0+GAVUPnr17HZDmwn9uUouCiFpOPnel
	 6W3Z9+rNvJ16jJIBPKLch8Sw4nmSSKJSm7N3UUfRe/D1r6MU8IXLStWhqnDZ/1LDSWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frurcEEY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27387606A325;
	Tue, 27 Oct 2026 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frurcEEY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F37F1F01825;
	Tue, 27 Oct 2026 21:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793137713;
	bh=iZPro0Zetz+CfLgJB9N6QxpD/1Z6TlyduqwjCEpWEDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=frurcEEYXOjzDEHQAq29BDBpzxuur7lknBF06mjH2ouf6yf1jbsOG87mTDnHD9Iq9
	 FBvEbozbz7L6dTDak0dBzX4S333EiTHlQHphpv2Y/nqS0P+m6j6tidyznWz8feoifE
	 V6TCaEO/yhxN58AM8FtIfCVGwChnhXjJltgNlFDmyjtICbDgdGVs0Ik3U4fjlsdNRZ
	 PqwlsEjMIcYoJIZciLGWZM+nIV8w+uKqMUHouanS/pTrSQNjFE4JFN5AEJ9RRj0tHM
	 FGsHndDLwJXRZt67DVrhZLY4USBQs2T/dHJEZnkXlbLi4bGzDnAnt/6lkm+4EDlvM4
	 zVp+21+x0Natw==
Date: Tue, 27 Oct 2026 16:48:30 -0500
From: Rob Herring <robh@kernel.org>
To: Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	stefandoesinger@gmail.com, krzk@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/24] dt-bindings: net: Add ZTE ZX279128S Ethernet
 switch
Message-ID: <20261027214830.GA1267186-robh@kernel.org>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
 <20261014072109.1759502-18-ghahramani.navid@gmail.com>
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
In-Reply-To: <20261014072109.1759502-18-ghahramani.navid@gmail.com>

On Wed, Oct 14, 2026 at 08:20:57AM +0100, Navid Ghahremani wrote:
> Describe the switch, receive interrupt and per-port PHY modes and MAC
> addresses.
> 
> Signed-off-by: Navid Ghahremani <ghahramani.navid@gmail.com>
> ---
>  .../bindings/net/zte,zx279128s-gmac.yaml      | 125 ++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/zte,zx279128s-gmac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/zte,zx279128s-gmac.yaml b/Documentation/devicetree/bindings/net/zte,zx279128s-gmac.yaml
> new file mode 100644
> index 0000000000..fcbdbafa76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/zte,zx279128s-gmac.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/zte,zx279128s-gmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ZTE zx279128s Ethernet switch
> +
> +maintainers:
> +  - Navid Ghahremani <ghahramani.navid@gmail.com>
> +
> +description:
> +  The ZTE zx279128s has a five-port gigabit Ethernet switch with a traffic
> +  manager, a buffer manager and a DMA engine that connects it to the CPU.
> +  Each port is described by a child node of ethernet-ports and becomes its
> +  own network interface, with the MAC address given in that node.
> +

Use the ethernet-switch.yaml schema here.

> +properties:
> +  compatible:
> +    const: zte,zx279128s-gmac
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description: The traffic manager's interrupt, which signals frames
> +      received for the CPU.
> +
> +  ethernet-ports:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "^port@[0-4]$":

ethernet-port is preferred for new bindings.

Rob
