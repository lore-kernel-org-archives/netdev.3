Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479631;
	b=ca3PwApfY00wlFoxo3M6uqs1we1IfGtcIhch54gmQlRY8j6mYfLJY0dVHgDLLOYbiUzy
	 7YrTc9bSzUaEettD15t8pBUgNIRZKRfHloxBYNU5Mqyv1X5/E5eHIei6A7mQFJLiQyhtn
	 1Q3ywZOcH/sXBXG6bqmQzVo5DgceWzegODwbZRzkSaNAk8Brq4kxUgA3L1W840sN3u5SN
	 rJeLG6x20IoA/L91k2nu/OGgg9ZVWSO9mjRbAUGbuq8O4ftokBOoRMscUyX15LtiyaAbC
	 /wsl6dlkTiSFYXmbdha8gLB7gYN8W1xaL/wentb+fQLoX7Si0mScEOb2ZSGq9vcuULA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479631;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+aHQkk84/jyWq1Sa4aXoN8rFXFkbow5EARyg7OTXn+Y=;
	b=ELMFMhoEvZcfKQnoXol2jKqDlED5b89LftrrYbBkBTXZBCGqREzAJiV03N3zt5u6PA+m
	 udKCB6UsL103Azio2PlPKRDlciZ+B7lCm0pBwBv1VS+vfxW3l219JlscYvVU5AV4hXDpF
	 440vwWfVYPj5snUuqV47RAImjSyOrpbPqW4lA3LdMXbEx/FbiBqdWVHJn6ZQCn6CL2B3m
	 LDAW+x+ux8f2rMFiZElKHt8mWuTfLsItjRKClVLR6tBZEdYsJaKrUqHR+r+Atg/gZ8Iwf
	 Uxkota5HCV++Cjz4Cs4Y1afMmhYLsvggibMRQalRCZJWcd1ZdGDdjLCAcFvfL1aaH+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIhTJaMD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA1606A323;
	Thu, 12 Nov 2026 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIhTJaMD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E211F00A05;
	Thu, 12 Nov 2026 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479631;
	bh=+aHQkk84/jyWq1Sa4aXoN8rFXFkbow5EARyg7OTXn+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WIhTJaMDCbntg/CKE6hWj2qG9UcfTu46mxNfCVJd3PM6nU2CwAnfD/rNIw9+0TXgr
	 2x3EfnnydyDZORVGf8LIfESmomjDLYhisRnb7MsqgTxiN3iT2I8fkb+riKRJIruKW0
	 Dhgg6D525FZZ+jCQfzTSujfaG+WCFZFnKdsV8bBaQrMpjHPsv+CTTeFsiB7tBnVz9f
	 bJMUFS9r8VnIllKNetZUbAsHSpeYDV5Ibnrcp8yF7Cwnnk51v77a0NqQBiYmRL9Hap
	 B/5/u2etmF8B8ZrDDl6Z6bZY+9uGl/eMSnu73BTlhYk4LcrhEhKrB6wKTy47CUFf2E
	 /X42EBe/uwcOg==
Date: Thu, 12 Nov 2026 11:33:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Eric Dumazet <edumazet@kernel.org>, Lee Jones <lee@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	mfd@lists.linux.dev, Martin Kaistra <martin.kaistra@linutronix.de>, 
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v4 3/8] dt-bindings: net: dsa: Add SoC-e SWIP
 switch function
Message-ID: <20261112-unselfish-congenial-waxbill-c7f9e3@quoll>
References: <20261105-devel-vstrassheim-soce-dsa-ml-v4-0-02f3cde2afa1@linutronix.de>
 <20261105-devel-vstrassheim-soce-dsa-ml-v4-3-02f3cde2afa1@linutronix.de>
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
In-Reply-To: <20261105-devel-vstrassheim-soce-dsa-ml-v4-3-02f3cde2afa1@linutronix.de>

On Thu, Nov 05, 2026 at 03:16:47PM +0100, Vasilij Strassheim wrote:
> Add a binding for the Ethernet switch function integrated into SoC-e
> SWIP cores.
> 
> Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> ---
>  .../bindings/net/dsa/soce,swip-switch.yaml         | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/soce,swip-switch.yaml b/Documentation/devicetree/bindings/net/dsa/soce,swip-switch.yaml
> new file mode 100644
> index 000000000000..daac779c466d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/soce,swip-switch.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/soce,swip-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SoC-e SWIP FPGA Ethernet switch function
> +
> +maintainers:
> +  - Vasilij Strassheim <v.strassheim@linutronix.de>
> +
> +description:
> +  Ethernet switch function of the SoC-e Switch IP (SWIP) FPGA core. The port
> +  count and presence of VLAN and STP register blocks depend on the FPGA
> +  synthesis configuration.
> +
> +$ref: dsa.yaml#/$defs/ethernet-ports
> +
> +properties:
> +  compatible:
> +    const: soce,swip-switch-00-04-0c-10
> +    description:
> +      This compatible identifies the register layout; its suffix gives
> +      the offsets of the core version and feature identification
> +      registers (0x00, 0x04, 0x0c, and 0x10). Port counts and optional
> +      features depend on the FPGA synthesis configuration and are
> +      detected at runtime using this register layout.
> +
> +  reg: false
> +
> +  reg-names: false

I don't get why do you need these two above?

> +
> +  ethernet-ports:
> +    type: object
> +    patternProperties:
> +      '^ethernet-port@[0-9a-f]+$':
> +        type: object
> +
> +        properties:
> +          reg:
> +            maximum: 30
> +            description: Switch port index, from 0 through 30.
> +
> +          phy-mode:
> +            enum:
> +              - mii
> +              - gmii
> +              - rmii
> +              - rgmii
> +              - rgmii-id
> +              - rgmii-rxid
> +              - rgmii-txid
> +
> +        required:
> +          - reg
> +          - phy-mode

Best regards,
Krzysztof

