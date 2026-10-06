Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F362AE76;
	Tue,  6 Oct 2026 03:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791256782; cv=none; b=DmEvwHJmRHIItJaro97utApYcdkalupDyg2KvsddgPk0q/z3PBNv22Q45SF0NlwOYEkf49pI/n4cv2rf/JE6Hmm3BIfDppFXQBdB3uW0opaYD0aifNKRdwx6x7rjKuix/aovm52gEeGeCFhVODobBablg91ekAG/fhLXauZ8vtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791256782; c=relaxed/simple;
	bh=Agw2RhQklfgIBib4EAvdg2pid0xbqBA/hVsPpmqP5vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFOMoGV7pFOj/kkVQf6+KO9vXXb4MqJr4f9MXFQ9eoUWs/SewCSs6b3orjNIPhYk8hhwanz85pdvcTtEehqzTi2Do9r5ys3i727llqSRd1HMXG5mjjo/c2u/+u4urBTSIO5N1dtO5/icLkGI5nLwemOP7pTxFR6zxYEJmZyg3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJs22g9v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJs22g9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE79A1F000FF;
	Tue,  6 Oct 2026 03:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791256781;
	bh=frSziYbGcXy/fyBE3c+wNGZd5VBCdtrpJH2rxB4+k2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jJs22g9v2cljL64y+pJ8FRGQdw5+fK9+dEOdCAnISbmdhFfrnu8Ey1rDQQRq01NlI
	 E0q2OtOMaCs0AELJtjNsHPLMdyvv9JO/xG7dKjMAsh1jdPTl2x65STq/dwLmhyXw4A
	 aeuWPrUpiMcEchKMtm1y2Aqgrooeb3KIU0HkxfuCcBiCp0iAIHXzI422kdlAD3sIp+
	 JQAyv2Ks6jvQO7LmLdAncPviRTkdqWYVTf6o0UoRmclz/SM7UdW4YAHAtZR5e3sTq4
	 /bnQKkEegQIA7QOoBbUhfwK967UcV1MvRWXq6JQDcGIhYkXBFEx01Qf7m5tboP1/Lv
	 jhxfEISu6+2cw==
Date: Mon, 5 Oct 2026 22:19:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>, devicetree@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-renesas-soc@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v13 2/9] dt-bindings: net: lan9645x: add
 LAN9645X switch bindings
Message-ID: <179125677205.3531384.13185008704922350230.robh@kernel.org>
References: <20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2@microchip.com>
 <20260929-dsa_lan9645x_switch_driver_base-v13-2-827c2d3617f2@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260929-dsa_lan9645x_switch_driver_base-v13-2-827c2d3617f2@microchip.com>


On Tue, 29 Sep 2026 09:48:23 +0200, Jens Emil Schulz Østergaard wrote:
> Add bindings for LAN9645X switch. We use a fallback compatible for the
> smallest SKU microchip,lan96455s-switch. The last digit of the part number
> is the number of usable front ports and the letter is the feature set.
> 
> The switch is a child of an externally controlled parent that hands out
> one regmap per register target, so reg and reg-names describe the target
> layout the way mscc,vsc7514-switch.yaml does for the equivalent
> mscc,vsc7512-switch node. That binding, and the mfd parent it hangs off
> in mscc,ocelot.yaml, is the model this driver and its parent follow.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
> ---
> Changes in v13:
> - Remove section quoting Documentation/networking/phy.rst from commit
>   message.
> - Remove rx/tx-internal-delay-ps from example.
> 
> Changes in v12:
> - Remove Rob's Reviewed-by
> - Match both the port@ and ethernet-port@ spellings, so the per port
>   constraints apply. dsa.yaml accepts either, and the local pattern only
>   matched the long form.
> - Allow 0 as well as 2000 for rx/tx-internal-delay-ps, matching what the
>   driver accepts, and restrict them to those two values on RGMII ports.
> - Constrain the ethernet-ports node the way renesas,rzn1-a5psw.yaml does,
>   with additionalProperties instead of a local dsa-port.yaml $ref.
> - Put the example properties in canonical order, so dt-check-style
>   --mode=strict is clean.
> - Describe the switch register targets in reg, with a matching reg-names,
>   following mscc,vsc7514-switch.yaml.
> - Document the default of rx/tx-internal-delay-ps, as
>   microchip,lan937x.yaml does.
> - Describe the SKU naming in the binding description.
> 
> Changes in v5:
> - No changes.
> 
> Changes in v4:
> - No changes.
> 
> Changes in v3:
> - remove additionalProperties: true
> - remove unnecessary | from description
> - change top level $ref to dsa.yaml#/$defs/ethernet-ports
> - use ethernet-ports and ethernet-port
> - move ethernet-ports under properties instead of patternProperties
> - move unevaluatedProperties: false after $ref
> - update example to use ethernet-ports and ethernet-port
> 
> Changes in v2:
> - rename file to microchip,lan96455s-switch.yaml
> - remove led vendor property
> - add {rx,tx}-internal-delay-ps for rgmii delay
> - remove labels from example
> - remove container node from example
> ---
>  .../net/dsa/microchip,lan96455s-switch.yaml        | 177 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 178 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

