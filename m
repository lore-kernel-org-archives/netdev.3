Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A613AAF43;
	Wed,  7 Oct 2026 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406500; cv=none; b=eppUp9eNViV++Tt0r28IdRP24JaFQR08xw0/qj8PP5k4cw9BqzLiQnpQ2pco6bdBN4Jp/arvlo0fWBIOjdjVAl5TUN/+FQ6kkrRycvxjsuiIfkiXGRMC60d0xa7qnPhjlhAWQuqBQp1T/sc8embegr5vKhmDUvYVsKYI5F9shVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406500; c=relaxed/simple;
	bh=dR+Xtoko4L+nnIcn1O5Scejhui0soBawQ5MqimbEJFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqOAcdmeqSKpRJj1FGaaM/bVw1D3UKVMtN+U655ve3kJ+KkvhOGes1956mRhSFInu4Fykz9ZI713ecD5ODNi7bpgggWli/ZK665KUCZKIQqPQP4MaUeFKV6vJijAmW+jC7yKX2OiTZrv31c1ip/ZO2pUWlgX+g/QGG1zYPPtMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/Ngthpb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/Ngthpb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDF21F000FF;
	Wed,  7 Oct 2026 20:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406498;
	bh=QY0h4ABM1Lsl5S3xmOqk4ruDmgs7pu94V8J2UpImWYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b/NgthpbP5KxHn0r8bi5jUIcatR2v+xFhRF6TH89riTegb06UWSwp74nuIrsx+nGJ
	 doGXmQlBB8SU5Hgfeviy9j0TV/jDmrQcwse5nd+99nf+OW6jsEkXVckCLICQ7wCC/G
	 vNl7L3H9soFJlGi76krCVl1vAx0ntoaRaKY9klgGLLEjPhVRNB2mWl+loUuAG2dYcm
	 yRICId+Le90LCrmOkvzvx4roEf3N2CX/iEmAx1/MHsSmTqvkV1tn2rXGdxfE+rKLAn
	 0Gb3eHkC7sKfvAPSUJnywYVl7uwiC2S7+cejXdbBDmh4D+pXyn/2YyH47tbguSU787
	 Em1lDwhHHXC6Q==
Date: Wed, 7 Oct 2026 15:54:57 -0500
From: Rob Herring <robh@kernel.org>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v3 3/8] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
Message-ID: <20261007205457.GA244932-robh@kernel.org>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-3-ddebafcb9ba7@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-3-ddebafcb9ba7@linutronix.de>

On Wed, Sep 23, 2026 at 12:39:30PM +0200, Vasilij Strassheim wrote:
> Add a binding for SoC-e FPGA-based Ethernet switch IP cores.
> 
> The compatible identifies a register layout characterized by the core
> and feature identification registers at the encoded offsets. The
> concrete synthesis-time configuration is then autodetected from these
> registers.
> 
> Describe the Ethernet ports and the optional integrated MDIO controller
> with its generic MMIO mux and child buses.
> 
> Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> ---
>  .../devicetree/bindings/net/dsa/soce,swip.yaml     | 162 +++++++++++++++++++++
>  1 file changed, 162 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml b/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml
> new file mode 100644
> index 000000000000..d614fb2a29d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml
> @@ -0,0 +1,162 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/soce,swip.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SoC-e ethernet switch IP core for FPGAs
> +
> +maintainers:
> +  - Vasilij Strassheim <v.strassheim@linutronix.de>
> +
> +description:
> +  SoC-e Ethernet switch IP cores are FPGA-based switches whose features
> +  and number of ports are selected at synthesis time. Ports can connect
> +  to CPUs, external PHYs, FPGA logic, or other switch cores. An integrated
> +  MDIO controller accesses the per-port external buses through a mux.
> +
> +$ref: dsa.yaml#

Doesn't look like you use any DSA properties. Can you use 
ethernet-switch.yaml instead. Also, if you don't have any custom 
properties, you need to ref "dsa.yaml#/$defs/ethernet-ports" instead.

> +
> +properties:
> +  compatible:
> +    const: soce,swip-00-04-0c-10
> +    description:
> +      Register layout with the core version register at offset 0x00 and
> +      feature identification registers at offsets 0x04, 0x0c, and 0x10.

Do you expect these to change? Kind of an odd compatible, but okay...

> +      Switch instances using this register layout are autodetected from
> +      these registers and use this compatible regardless of their
> +      synthesis-time feature and port configuration.
