Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE14FD28C;
	Thu,  8 Oct 2026 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791491383; cv=none; b=ERTlw7aKJC4RWU6MPHUtDZqnJSTVK0E59zFwd+I+5ZITpvxvYUlR3/qnheYY5JA4r8qcqcik3XsUOaxiB/eSOD2o2lutu/HfF0oTJ0HzQglK5ueNJsuFsPfhUNdBCTc3ppG8tgLNfBuLnGN1ME4iBd5XU05HmkOmb2QqqTfg3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791491383; c=relaxed/simple;
	bh=NC7dNyTajbmMXFoJJp2t8diqeBigLr4Nw/Gr9EM4jWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAyQnpoiJTr0cQthxNW/Nm/+B9nmKmagIg15giDOm7VMFEwPbDHR/NCcvOyNmtgbRKimm12UEZCoVLlIfv5YWoOm3FAKdXDLBPwI2ntgJ2+dKA1D7HNzZgw0T1lKbEICc5eydR/XAlhGw5RYxO3cj9xOLu/1qfLcDDkivHjDjc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hemd2IZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hemd2IZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38611F000FF;
	Thu,  8 Oct 2026 20:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791491379;
	bh=Xwl0RGPd+ei1IZo+jlKcRN1N2ZJo6fvaXUFegRPV+LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hemd2IZK0YK4B5ygibg2JMJzrN1L2zeB0GkxTbichy5C46qSmuQI6VTpHJG3zrrkN
	 uh74Vnv88QEhxxsWrp7WljJH24yyPsqWu5EE6ZRch98AKD9z3tHfgHHFqfRBrffYWw
	 8DgOKh7NnZAvl1RBWMZyipMbbOvQ9O//XXeKZ9LPi3HYtSSt+Tcr2D0WI/QCstHEYg
	 bUfjvKzTt31S5rC5dAz8LF8Uc4OQvt6nSIRegcH669D9iXxwFYFyyLEkxvqKzy/1Kb
	 rsAICxWiR/MvMBpoY++KvIXM2ESasjnTMe9PJAz+mbjysUusxEwT93J1z1OWJWFsLL
	 +lWONomah8ykw==
Date: Thu, 8 Oct 2026 15:29:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, Jakub Kicinski <kuba@kernel.org>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v14 2/9] dt-bindings: net: dsa: add Microchip
 LAN9645x switch
Message-ID: <179149137855.1158657.10114176594900619381.robh@kernel.org>
References: <20261008-dsa_lan9645x_switch_driver_base-v14-0-3d2a72661213@microchip.com>
 <20261008-dsa_lan9645x_switch_driver_base-v14-2-3d2a72661213@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261008-dsa_lan9645x_switch_driver_base-v14-2-3d2a72661213@microchip.com>


On Thu, 08 Oct 2026 11:05:21 +0200, Jens Emil Schulz Østergaard wrote:
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
> Changes in v14:
> - Use the dt-bindings: net: dsa: subject prefix and do not repeat
>   "bindings" in the subject.
> - Describe all switch register targets in reg, and the analyzer and
>   PTP interrupts.
> 
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
>  .../net/dsa/microchip,lan96455s-switch.yaml        | 208 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 209 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

