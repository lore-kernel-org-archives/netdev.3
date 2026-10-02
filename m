Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E707414A04;
	Fri,  2 Oct 2026 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975659; cv=none; b=GxMW8ouuto5aK/LfjQQaLUKDPaFyqN+g+kiX+smFpH5tQUTlyQLWb+5B2ssMucF4d0G3DRkvKsiEoNSjfxxQA2mjMNoTTTy1SXgqnQCkCcshfdErVf+CkUR/1k3oxETDT2yx/fyGfx2x/u9v/wkS+j7Cx7Pqjax8Dy7qhciAdro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975659; c=relaxed/simple;
	bh=c3/I+3EiRWm4Keni4NWY6tfCt39GqDRQ764APKiF3D8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gh2mCjb0tnsZdtsx6nMrRxhfA7eW91YOKbL2u/Ml9OHe4hk/Lssi0kXISFAnO8U4oG4fdMAQh5Eh7Cq+e1ydQZvlgcYfMqnv+gZu3rce2O6jdOaFmKxIULPml0Mt7QzZX6guC0geYI8Yg4gnRtccRgBOAe9h71nZQJHfc7pI/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpzpxIrl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpzpxIrl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEA81F00893;
	Fri,  2 Oct 2026 21:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790975658;
	bh=TjSxxrW9giS60tvX1xmtmsGwcTNi/bavTFOqpgQ6jcA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DpzpxIrlH6QfLU37q6piO2Jq0MLVHm0cdu1+dp5B51pTw3X2exZQ6DXUSUSDVQ8M2
	 OGPYHCGNlZgmrOWDkFVwyTEb8CgdNGkDPc8zIqoF8T8TJz54Go2FRr7uE4mbCBAQaC
	 VTNzbYNp/ED4DaGxpb+ltezG11MSGg2CjJgOsCZG+4htg52nYmkGsLGo9g33jntGz6
	 0pBygAx6DJ52R6lPFrCeJiDlMJjH9H7iz9eYiVgHgKIut2kBUtXdK49suDWLYlKG9R
	 C6hGRnvulz9cwF7oS+UqTuSr4LqJ3DuEIcnpkqhwUtodhSJebX6/6719kOSKfyRyFI
	 SwyD5ROgQbV9g==
Subject: Re: [PATCH net-next v13 2/9] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Fri, 02 Oct 2026 21:14:16 +0000
Message-ID: <179097565632.434549.4502209637975152299@kernel.org>
In-Reply-To:
 <20260929-dsa_lan9645x_switch_driver_base-v13-2-827c2d3617f2@microchip.com>
References:
 <20260929-dsa_lan9645x_switch_driver_base-v13-2-827c2d3617f2@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The binding makes rx/tx-internal-delay-ps on the MAC-side
  switch port nodes an on/off switch for the full 2 ns RGMII delay…
- [Low] The per-port pattern "^(ethernet-)?port@[0-8]$" in
  properties/ethernet-ports does not actually limit ports to the 9…
- [Low] The subject "dt-bindings: net: lan9645x: add LAN9645X switch
  bindings" does not follow…

--

dt-bindings: net: lan9645x: add LAN9645X switch bindings

This commit adds a DT binding for the Microchip LAN9645x DSA switch. The
smallest SKU, microchip,lan96455s-switch, is the fallback compatible. The
switch register targets are described through reg and reg-names, following
mscc,vsc7514-switch.yaml.

> dt-bindings: net: lan9645x: add LAN9645X switch bindings

[Severity: Low]
This isn't a bug, but the subject doesn't match what
Documentation/devicetree/bindings/submitting-patches.rst asks for. That file
says "Repeating "binding" again should also be avoided". Its example form is
"dt-bindings: iio: adc: Add ROHM BD79100G".

The file lives under net/dsa/, so the usual prefix is "dt-bindings: net: dsa:".
Something like "dt-bindings: net: dsa: Add Microchip LAN9645x switch" would
fit better.

> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
> new file mode 100644
> index 0000000000000..9deb7a427804f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml

[ ... ]

> +  ethernet-ports:
> +    type: object
> +    additionalProperties: true
> +    patternProperties:
> +      "^(ethernet-)?port@[0-8]$":

[Severity: Low]
Does this pattern actually restrict port nodes to the 9 hardware ports
(dev0..dev8)?

ethernet-ports has additionalProperties: true, so nodes that don't match
"^(ethernet-)?port@[0-8]$" are not rejected here. The inherited
dsa.yaml#/$defs/ethernet-ports and ethernet-switch.yaml both accept any
"^(ethernet-)?port@[0-9a-f]+$" node through dsa-port.yaml.

So a node like ethernet-port@9 { reg = <9>; ... } or ethernet-port@a passes
dt_binding_check and dtbs_check. It also skips the local RGMII delay
constraints. The problem only shows up at probe time:

net/dsa/dsa.c:dsa_switch_parse_ports_of() {
    ...
		if (reg >= ds->num_ports) {
			dev_err(ds->dev, "port %pOF index %u exceeds num_ports (%u)\n",
				port, reg, ds->num_ports);
    ...
}

Should the schema reject port nodes outside 0-8?

> +        type: object
> +        description: Ethernet switch ports
> +        additionalProperties: true
> +
> +        allOf:
> +          - if:
> +              properties:
> +                phy-mode:
> +                  contains:
> +                    enum:
> +                      - rgmii
> +                      - rgmii-rxid
> +                      - rgmii-txid
> +                      - rgmii-id
> +            then:
> +              properties:
> +                rx-internal-delay-ps:
> +                  $ref: "#/$defs/internal-delay-ps"
> +                tx-internal-delay-ps:
> +                  $ref: "#/$defs/internal-delay-ps"

[ ... ]

> +$defs:
> +  internal-delay-ps:
> +    description:
> +      Disable the delay line using 0 ps, or enable the 2000 ps delay. The
> +      delay line is not tunable, so no other phase can be selected.
> +    enum: [0, 2000]
> +    default: 0

[Severity: Medium]
Is it intended that rx/tx-internal-delay-ps on the MAC side port nodes turns
the full 2 ns RGMII delay on and off, for all four rgmii phy-modes?

Documentation/devicetree/bindings/net/ethernet-controller.yaml says these
MAC node properties "should be used to indicate fine tuning performed by the
MAC. The values expected here are small. A value of 2000ps, i.e 2ns, and a
phy-mode of 'rgmii' will not be accepted by Reviewers."

The same document says that when the MAC adds the delay, it "must modify the
phy-mode it passes to the PHY, removing the delay it has added. Failure to
remove the delay will result in a non-functioning link."

This schema accepts phy-mode = "rgmii-id" together with
rx-internal-delay-ps = <2000>. In the driver later in this series,
lan9645x_parse_mac_delay() in lan9645x_port.c only checks for 0 or 2000.
lan9645x_rgmii_dll_config() in lan9645x_phylink.c then enables the delay line
directly from the parsed value:

drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c:lan9645x_rgmii_dll_config() {
    ...
	HSIO_DLL_CFG_DLL_ENA_SET(p->rx_internal_delay) |
	HSIO_DLL_CFG_DELAY_ENA_SET(p->rx_internal_delay),
    ...
}

Nothing there checks phy-mode or removes the delay from the interface that
phylink passes to the PHY.

Take port 7 or 8 with a phy-handle, phy-mode "rgmii-id" and
rx-internal-delay-ps = <2000>. Wouldn't the MAC and the PHY each add 2 ns,
leaving a DT that passes validation with a link that doesn't work?

The example also uses phy-mode = "rgmii" on the CPU port. For any RGMII mode
other than 'rgmii-id', ethernet-controller.yaml says it "is probably wrong"
unless justified.

> +
> +examples:

[ ... ]

> +            ethernet-port@7 {
> +                reg = <7>;
> +                ethernet = <&cpu_host_port>;
> +                phy-mode = "rgmii";

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2%40microchip.com
