Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4D41A4F6;
	Mon, 12 Oct 2026 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804282; cv=none; b=d8CYWFNp8SIME3qdqi+5lcrBdqiG0IVhVp3+ODrgYoppiyq8Z+NsbEQz1zRPdxQzsekRerPtIC0+nvXHvho1dkOwNcGAvE1Fv6fljU5X5mimsQTwyLQb6Rg1xynMskpVG5A+dNiqWTZJcD11wgFt5glR+N5s7Jooh4f1RgLIeB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804282; c=relaxed/simple;
	bh=KwcSL0Ujr13dGBFaCalJCs7dV5ByXKYqrgHcCru0RYY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LduLEuNlZaVr67aagYJt3jw8N/z27RZilSM4YZGHEVd30OYLpZQoUoi/GxeVQcjcllG88m4JC6gGxsfwMJcPQPwkrZ1uJEbTtHsZ7tXQrqKepJvmtWhuUcamcIRSJabJrOyauxAP120EOfk2HftOBpgG+vKlvCV9UoCxhz7fSRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=girBEufT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="girBEufT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A3E1F0089C;
	Mon, 12 Oct 2026 11:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791804280;
	bh=y8ICW819kjlrNkL/gnlrEjA94xZv9r+LgSwby0ivnCk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=girBEufT+4vBAjRFW7wIDWXgyhXCwscm994VZTYFn4brHH2bI5PyzwH3lwxtNhiXH
	 KdkWAl8wcWKv1JYZsF9WqPIlb5R0fKsF/ehuWkxx1a0DRFnurbdB4r9kp3ghnixHed
	 /ZSXa1a773x9S5iD1jiFP5KqeGWfE/SWZ1z5jxroLHwrtxHhq9pLcj86Wr93+Wns6m
	 /rHRGr+7dVjeMzpJdE6WeoHtsvo0oYJM1SZQwGfB5rgf226mxjgKlbBzG1zEde29Du
	 NYvaA36lfQmxwGlUkOykqHND9O0ObWnvHnOwa/O2sgnq9nyTTb7RQ1li97LRBJli7j
	 khioj0wvw9WeQ==
Subject: Re: [PATCH net-next v14 2/9] dt-bindings: net: dsa: add Microchip
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
Date: Mon, 12 Oct 2026 11:24:38 +0000
Message-ID: <179180427893.434549.12279127363487577059@kernel.org>
In-Reply-To:
 <20261008-dsa_lan9645x_switch_driver_base-v14-2-3d2a72661213@microchip.com>
References:
 <20261008-dsa_lan9645x_switch_driver_base-v14-2-3d2a72661213@microchip.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In microchip,lan96455s-switch.yaml, the port-level allOf/if
  (lines 113-128) applies $defs/internal-delay-ps (enum [0, 2000], lines…
- [Low] In microchip,lan96455s-switch.yaml, properties/ethernet-ports
  (lines 104-111) uses the pattern "^(ethernet-)?port@[0-8]$" but sets…

--

dt-bindings: net: dsa: add Microchip LAN9645x switch

This patch adds a DT binding schema for the Microchip LAN9645x family of
DSA switches, with microchip,lan96455s-switch as the fallback compatible.
The switch sits under an externally controlled parent, and reg/reg-names
describe its register targets in the same way as mscc,vsc7514-switch.yaml.
On RGMII ports, rx/tx-internal-delay-ps are limited to 0 or 2000.

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
ethernet-ports has additionalProperties: true. Will nodes such as port@9,
port@a or port@10 still pass validation?

The inherited dsa.yaml#/$defs/ethernet-ports matches any hex index:

    "^(ethernet-)?port@[0-9a-f]+$":
      description: Ethernet switch ports
      $ref: dsa-port.yaml#

So these nodes are accepted and checked only against dsa-port.yaml. They
also skip the local allOf/if below. For example, phy-mode = "rgmii" with
rx-internal-delay-ps = <1500> would validate on port@9, even though the
hardware only supports 0 or 2000.

The binding lists only the dev0 to dev8 register targets. An out of range
port is therefore caught only at runtime, in dsa_switch_parse_ports_of():

    if (reg >= ds->num_ports) {
        dev_err(ds->dev, "port %pOF index %u exceeds num_ports (%u)\n",
                port, reg, ds->num_ports);

and the switch probe then fails with -EINVAL.

renesas,rzn1-a5psw.yaml, which this binding copies for the ethernet-ports
constraint, has the same gap.

Should the local schema reject port nodes outside 0-8?

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

[Severity: Low]
Does this allow combinations that ethernet-controller.yaml says are
invalid?

The if block above applies the 0/2000 enum to all of rgmii, rgmii-rxid,
rgmii-txid and rgmii-id.

For phy-mode = "rgmii" with 2000 ps, ethernet-controller.yaml says:

    # be used to indicate fine tuning performed by the MAC. The values
    # expected here are small. A value of 2000ps, i.e 2ns, and a phy-mode
    # of 'rgmii' will not be accepted by Reviewers.

The description here also calls this a fixed, non-tunable 2 ns delay line,
not a fine-tuning value.

For phy-mode = "rgmii-id" (or -rxid/-txid) with 2000 ps on a port with an
external PHY, ethernet-controller.yaml says:

    # ensure that the PHY does not also implement the same delay. So it
    # must modify the phy-mode it passes to the PHY, removing the delay it
    # has added. Failure to remove the delay will result in a
    # non-functioning link.

Later in the series, lan9645x_parse_mac_delay() accepts the value for any
RGMII mode without checking it against phy-mode:

    if (val != 0 && val != 2000) {

lan9645x_rgmii_dll_config() is called from mac_config for any RGMII
interface, and it then turns on the MAC delay:

    HSIO_DLL_CFG_DLL_ENA_SET(p->rx_internal_delay) |
    HSIO_DLL_CFG_DELAY_ENA_SET(p->rx_internal_delay),

Nothing changes the interface that phylink passes to the PHY. With
rgmii-id, the MAC and the PHY would both add 2 ns. Would that give a
non-working RGMII link on ports 7/8 that still passes dtbs_check?

There is in-tree precedent for this pattern. vitesse,vsc73xx.yaml uses a
similar enum that allows 2000 on rgmii. The realtek.yaml examples use 2000
with 'rgmii' on fixed-link CPU ports.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-dsa_lan9645x_switch_driver_base-v14-0-3d2a72661213%40microchip.com
