Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC15B2E4257;
	Tue,  5 May 2026 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988676; cv=none; b=HSXbCwDV0ZSZNcJXjHO+iahM5pKHuhvDtuixgBk1rAqq3KGo58aAQosduowBsumxrGlGqiutpebx1sVQx1UYda8xak4TJ1PEdylh6bimkOxkZshfOnSxCIuo/ljJ1g3RqNHMZTRvjx/yfIUSYk/p1hWiU8TDd27LnqVm3aEsRoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988676; c=relaxed/simple;
	bh=A7dS5/876ollr6/HQZkXxu+8WFQ9pc0wzz5UdXRE8wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5lFKeNI0ymkchVhTANU52UXohqtAxdab2ZlNdxtMXAtWrRUFxo5t2viw90uraEejzR7nXJz53ppFgaZqewn9nqDwITvvfDL72tpOvX8sCadOnFR/KDqXSu/ajUg9rVMh6NkHpPnmlxZBfxzfaAjm9jyskx5xWXEhuZr/l7J+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF67CaYS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF67CaYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC934C2BCB4;
	Tue,  5 May 2026 13:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777988676;
	bh=A7dS5/876ollr6/HQZkXxu+8WFQ9pc0wzz5UdXRE8wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gF67CaYSmcllcUMuR96x34F//N9Luw2NCMgkPGa+/4mZzOzK2cEpJjYgcFc/47+5r
	 Kt5kYdk00K2fD2ltmBnCp1HrL9N4uS0aWieA4AeQDG10rpt65mYrHLq8VU1XADqPZS
	 m1o+qBK+btQAVFUmhEj38cvl708bpqVWlmiIPBWDcYTMlbAkN/xLEWz4xbyg/nl93T
	 HNgaaruzN5is6r0z7lgOXChRpZnI9QvdYG6TKy7aeYEzKWn6SKZBSl38mC/4b4NLQ2
	 406InDwYarn9x5026nwNPPcr0r66jbrQ1269+tFwb9UyV7zGLBNdVhAMRUqfeqyn7B
	 jq/uwETy5FB1w==
Date: Tue, 5 May 2026 08:44:34 -0500
From: Rob Herring <robh@kernel.org>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] dt-bindings: net: add onsemi's
 TS2500/NCN26010 10BASE-T1S MACPHY
Message-ID: <20260505134434.GA2493310-robh@kernel.org>
References: <CY8PR02MB9249D083B637477C254F9B0583322@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY8PR02MB9249D083B637477C254F9B0583322@CY8PR02MB9249.namprd02.prod.outlook.com>

On Fri, May 01, 2026 at 07:15:17PM +0000, Selvamani Rajagopal wrote:
> Add YAML device tree binding for the onsemi NCN26010 and TS2500
> IEEE 802.3cg compliant Ethernet transceiver devices.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> ---
>  .../bindings/net/onnn,ncn260xx.yaml           | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/onnn,ncn260xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/onnn,ncn260xx.yaml b/Documentation/devicetree/bindings/net/onnn,ncn260xx.yaml
> new file mode 100644
> index 000000000..198cd7e9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/onnn,ncn260xx.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/onnn,ncn260xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: onsemi NCN26010/TS2500 10BASE-T1S MACPHY Ethernet Controllers
> +
> +maintainers:
> +  - Piergiorgio Beruto <Pier.Beruto@onsemi.com>
> +  - Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>
> +
> +description: |
> +  The NCN26010 and TS2500 combine a Media Access Controller (MAC) and an
> +  Ethernet PHY to enable 10BASE‑T1S networks. The Ethernet Media Access
> +  Controller (MAC) module implements a 10 Mbps half duplex Ethernet MAC,
> +  compatible with the IEEE 802.3 standard and a 10BASE-T1S physical layer
> +  transceiver integrated into the NCN26010. The communication between
> +  the host and the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x
> +  MACPHY Serial Interface (TC6).
> +
> +  Specifications about the NCN26010 can be found at:
> +    https://www.onsemi.com/download/data-sheet/pdf/ncn26010-d.pdf
> +    https://www.onsemi.com/products/interfaces/ethernet-controllers/t30hm1ts2500
> +
> +allOf:
> +  - $ref: /schemas/net/ethernet-controller.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: onnn,ncn260xx

Don't use wildcards in compatible strings.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |

Don't need '|'.

> +      Interrupt from MAC-PHY asserted in the event of Receive Chunks
> +      Available, Transmit Chunk Credits Available and Extended Status
> +      Event.
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    minimum: 15000000

A minimum is strange. What if you have a board issue requiring lower 
frequency?

> +    maximum: 25000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - spi-max-frequency

Normally this is not required. It's only for boards which can't operate 
at the maximum frequency of the device.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ethernet@0 {
> +        compatible = "onnn,ncn260xx";
> +        reg = <0>;
> +        pinctrl-names = "default";
> +        interrupt-parent = <&gpio>;
> +        interrupts = <25 2>;
> +        status = "okay";

Drop. Examples are always enabled.

> +        spi-max-frequency = <25000000>;
> +      };
> +    };
> --
> 2.43.0
> 
> 
> Public Information
