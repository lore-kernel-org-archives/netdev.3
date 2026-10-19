Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3874AA599;
	Mon, 19 Oct 2026 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404526; cv=none; b=DfbYwcdvT2FDou0VfHnEFjCEkcVRNSM/NKJovdaXxGqvXvqPlCqJL/ydZqsYS/neWey5AMyMb/hJYaCswIkqFwrV2zXLpCtA/dqrte38YxU6N+MlrPWFwQucLq3DdOfEOFvZaQKs6wWmWt+JBkyeR8R4DdEljFh8zF0yHsyQjHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404526; c=relaxed/simple;
	bh=+j4aBWaFE3EEqKu01aEfpRIqsr8LSwapavjZTWLvM04=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sLMo4K71aKaJhizMgBauXk8tPmGzo4D9ZE18RS7dOukxmkn9v1vVagJzNnrdEePoAIoNCtCAIUIxkN5tDKQHURwlbTPozQGh5hj3tholAJ0DTww5C9fO2ZoOFsdOJ6Z3qb0uhHdALuas6ljIspLd8leRP5W6iD/hE3/0jMgUAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8b+iv0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8b+iv0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2EA1F000C4;
	Mon, 19 Oct 2026 10:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792404525;
	bh=ArdEgbrCGBGMGYce2Qlhk4Ey/N2hHIrxMkK6qXgWZIo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S8b+iv0thFHrrEEnNVAQCw1O6uEKPRto/U3zmTlYwvIl7qtiba69oNIJmRT1w49VC
	 isiXmb92Te/LzD+YDRVEqz2NC4pccOsNFVi6tgfJ10RxX7IdFYxOzEiNl1Kn+/3iN1
	 nYQrSwDSoJZ+/rtJ+DcwdQTA1bis9G/IMGtlZRYZ9JPMmGN6LIT2GUjsw9ilUO3Hl7
	 /QLe0yTbx+1GP+8+tqvxNbLF8kNS7WRoAp53o0SsCbYwZD9P1ltJf277FOZ8Lap4wU
	 /1KBqEPBXKwMLHhzvLestRDHqBw1xCEXiTq9kiW1pvoQ5hzKxp+u8YU7Rl6gc3xJtI
	 k/h+y3Cdf56+Q==
Subject: Re: [PATCH net-next v15 2/9] dt-bindings: net: dsa: add Microchip
 LAN9645x switch
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, edumazet@kernel.org,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Mon, 19 Oct 2026 10:08:43 +0000
Message-ID: <179240452378.3135.9892080157783163049@kernel.org>
In-Reply-To:
 <20261015-dsa_lan9645x_switch_driver_base-v15-2-562f316f78b9@microchip.com>
References:
 <20261015-dsa_lan9645x_switch_driver_base-v15-2-562f316f78b9@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The binding (microchip,lan96455s-switch.yaml) and its RGMII
  delay design contradict the in-tree RGMII contract in ethernet-…
- [Low] The binding (microchip,lan96455s-switch.yaml) does not reject
  port nodes beyond port 8, and those nodes escape its RGMII delay…

--

dt-bindings: net: dsa: add Microchip LAN9645x switch

This adds a YAML binding for the Microchip LAN9645x DSA switch family,
with microchip,lan96455s-switch as the fallback compatible. The switch
registers are described with one reg entry per register target. RGMII
ports may set a fixed 0 or 2000 ps MAC internal delay.

> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
> new file mode 100644
> index 0000000000000..517bc4c00de30
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
> @@ -0,0 +1,208 @@

[ ... ]

> +  ethernet-ports:
> +    type: object
> +    additionalProperties: true
> +    patternProperties:
> +      "^(ethernet-)?port@[0-8]$":

[Severity: Low]
Can port nodes above port 8 get past this schema?

The local pattern only matches port@0 through port@8. However,
ethernet-ports has additionalProperties: true, and the inherited
dsa.yaml#/$defs/ethernet-ports checks "^(ethernet-)?port@[0-9a-f]+$"
against dsa-port.yaml. That means port@9 through port@f are evaluated
and pass.

Those nodes also skip the local RGMII if/then. For example, port@9 with
phy-mode = "rgmii" and rx-internal-delay-ps = <5000> passes, because
ethernet-controller.yaml only types that property as uint32.

The hardware has only 9 ports, so these nodes are rejected only at probe
time:

net/dsa/dsa.c:dsa_switch_parse_ports_of() {
    ...
		if (reg >= ds->num_ports) {
			dev_err(ds->dev, "port %pOF index %u exceeds num_ports (%u)\n",
    ...
}

The description says the last SKU digit gives 5, 7 or 9 usable front
ports. No compatible-based if block limits which port@N nodes the 5-port
and 7-port SKUs may declare, so a bare microchip,lan96455s-switch node can
describe all nine ports.

renesas,rzn1-a5psw.yaml, which the changelog names as the model, has the
same pattern.

Should the schema reject port nodes outside the range each SKU supports?

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
Does this delay definition conflict with the RGMII rules in
ethernet-controller.yaml?

The if/then above applies this 0/2000 ps enum to all four RGMII modes.
That means the schema accepts phy-mode = "rgmii" together with
tx-internal-delay-ps = <2000>. The informative section of
ethernet-controller.yaml says:

  # be used to indicate fine tuning performed by the MAC. The values
  # expected here are small. A value of 2000ps, i.e 2ns, and a phy-mode
  # of 'rgmii' will not be accepted by Reviewers.

That section also says delays not added by the PCB are software
configuration and are not described in DT. If the MAC adds the delay, it
has to remove that delay from the phy-mode it passes to the PHY.

The schema also accepts rgmii-id, rgmii-rxid or rgmii-txid with a 2000 ps
MAC delay. In the driver added later in the series ("net: dsa: lan9645x:
add basic dsa driver for LAN9645X"), nothing seems to remove that delay
again. lan9645x_parse_mac_delay() in lan9645x_port.c sets the flag only
from the DT property:

	*out = val == 2000;

lan9645x_phylink_mac_config() in lan9645x_phylink.c then calls
lan9645x_rgmii_dll_config() for any RGMII mode. That function enables the
DLL delay whenever the flag is set:

	if (phy_interface_mode_is_rgmii(state->interface))
		lan9645x_rgmii_dll_config(p);

Meanwhile phylink passes the unmodified phy-mode to the PHY.

Take port 7 or 8 with an external PHY, phy-mode = "rgmii-id" and
tx-internal-delay-ps = <2000>. Both the MAC and the PHY would add 2 ns,
for about 4 ns of skew. Wouldn't that give a non-working link, even
though the DT passes dt_binding_check?

The if also has no else branch. Non-RGMII ports (gmii, rmii, BASE-X,
QSGMII) therefore accept any uint32 value for rx-internal-delay-ps and
tx-internal-delay-ps.

Could the MAC delay be derived from phy-mode instead of these properties,
with the phy-mode passed to the PHY adjusted to match?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9%40microchip.com
