Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53A165F16;
	Sun,  4 Oct 2026 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119862; cv=none; b=uIqFShqDfRqcoKje0qVOdu1lb/jaSVLcejU6paMOuyhmqvBer2ap/8xJQZgQsyF+VnUUNQIZRAk9LkinyhEhWhUgmQTOWTfy3AEXzGkV+kT3e3pWjWxAmkDoXSH/gb2O/fauNpZJFxk5NPsh+cxSq4SsLI6Gbw4M0/XYrcyaM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119862; c=relaxed/simple;
	bh=uKUtgp3jE+4ANEL5yoY+Rr/yE0d820Pi3gSXza0ifiQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oFWL6ITorcvsRyP72NaVh0A8owchPfGtvDXpfpBA4Z7uPvT6mJh1Fp9cVNDKG7HI1j6zG05qo6H5zS9sdEztkmpy2Kha3Va+ksM8pYol2J3NostfkbfelkSBcegSQy6jD+mT7j3Wnm6KDWlQxWDmjnl6BhXAxX+LEyNBa408eLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaYwCSg9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaYwCSg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9A31F000FF;
	Sun,  4 Oct 2026 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791119860;
	bh=g65T79RycfGBPFDP9ipFK4/Z5E9Ksmqd/BMM3ESiGXo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JaYwCSg9ps7wxO8h2EuB05+IAN74N1nEaoRdluLgoB/FhZ6VvGHoSNm5GpFp+x0Ru
	 j8VuL1GNr/biHF4zse6xk5aZuo0C/peoaD7aHuBZm6fHKR2HIDz2MRDa6HZyTglvSF
	 buC7ppeR/azXD2Vkd7Zu1xQxCDuN7JKIQ020q/5oKjsNbeWm1LfrIeUjKaAi5fwWj0
	 7il4Gj23+/jsn9UHpKwyIm5M81eyrikuVCtVWwlQkHm7pQP89GiSxNzgW5KFk8rmpg
	 KM3aCj4BS0stOIM7BDcTbQiK1UUqAok3ZKM4bvRPxCAD8ciGoYgM+nvspT+2vwVfh5
	 fltldoW9Oc5Hw==
Subject:
 Re: [PATCH 1/5] dt-bindings: net: maxlinear: add MxL86211C MDIO I/O regulator
From: netdev-bot+sashiko@kernel.org
To: robert.marko@sartura.hr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, lxu@maxlinear.com,
 michael@walle.cc, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Date: Sun, 04 Oct 2026 13:17:38 +0000
Message-ID: <179111985895.434549.7748161913149195975@kernel.org>
In-Reply-To: <20260930122305.293686-1-robert.marko@sartura.hr>
References: <20260930122305.293686-1-robert.marko@sartura.hr>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the patch will "Restrict the regulator
  subnode to the MxL86211C PHY ID".
- [Medium] The binding models the MxL86211C MDIO/MDC/MDINT pad I/O-level
  selection (the VSPEC1_PM_CTRL.MDIO_VOL bit) as a regulator provider…
- [Low] In Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml,
  the `mdio-regulator` subnode is defined only as `type: object`, `$ref:…
- [Low] dt-bindings: net: maxlinear: schema property 'mdio-regulator'
  lacks top-level definition

--

dt-bindings: net: maxlinear: add MxL86211C MDIO I/O regulator

This commit adds an mdio-regulator child node for the MxL86211C PHY
(ethernet-phy-idc133.5400) to the gpy2xx binding. The node references
regulator.yaml and selects a 1.8 V or 3.3 V level for the MDIO, MDC and
MDINT pads. An allOf if/then/else is meant to forbid the node on other PHY
IDs, and a new example is added.

> diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> index 8a3713abd1ca9..0645e885f1747 100644
> --- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> +++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> @@ -12,6 +12,29 @@ maintainers:
>  
>  allOf:
>    - $ref: ethernet-phy.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ethernet-phy-idc133.5400
> +      required:
> +        - compatible
> +
> +    then:
> +      properties:
> +        mdio-regulator:
> +          type: object
> +          description: |
> +            Initial data for the MxL86211C MDIO I/O voltage regulator. Set
> +            this to 1.8 V or 3.3 V to configure the MDIO, MDC, and MDINT
> +            pad voltage. The board must supply the VDDP pin at the selected
> +            voltage.
> +          $ref: /schemas/regulator/regulator.yaml#
> +          unevaluatedProperties: false

[Severity: Low]
The mdio-regulator node is defined only inside the then: branch of
this conditional.

The usual dt-schema convention, as shown in example-schema.yaml, is to
define every property once in the top-level properties: block. The
if/then/else blocks are then used only to narrow a property, or to set
it to false for the compatibles that do not have it.

As written, the properties: section of maxlinear,gpy2xx.yaml does not
mention mdio-regulator at all. Its type, its description and the $ref
to regulator.yaml sit inside a conditional. Readers and documentation
tooling looking at the top-level properties will not find it.

Could the full definition (type: object, the description,
$ref: /schemas/regulator/regulator.yaml# and
unevaluatedProperties: false) move under the top-level properties:,
next to maxlinear,use-broken-interrupts?

The allOf entry would then only have to disallow the node for other
PHY IDs. That could be done by keeping the current else: and dropping
the then:. Another way is an if: that negates the
ethernet-phy-idc133.5400 match, with then: mdio-regulator: false.

If maxlinear,lane-asp-map in the later lane mapping patch is defined
the same way, it would need the same change.

[Severity: Low]

The description says the pads can only be set to 1.8 V or 3.3 V. Should
the schema enforce that?

regulator.yaml puts no bounds on regulator-min-microvolt or
regulator-max-microvolt. So this node accepts values like 2500000. It also
accepts a range such as min = 1800000 / max = 3300000, which does not fix
the pad level.

The driver added later in the series supports only two levels:

drivers/net/phy/mxl-gpy.c:
static const unsigned int mxl86211c_mdio_voltage_table[] = {
	1800000,
	3300000,
};

With an unsupported fixed value, mxl86211c_probe() would presumably fail
in devm_regulator_register(), even though the DT passes the schema.

With a 1.8-3.3 V range, no voltage would be applied at registration. The
pads would stay at the 3.3 V reset default, even on a board where VDDP is
1.8 V.

Could regulator-min-microvolt and regulator-max-microvolt be limited to
enum: [1800000, 3300000], and possibly required to be equal?

The commit message also says:

  The regulator configures the MDIO, MDC, and MDINT pad voltage
  between 1.8 V and 3.3 V.

That reads like a continuous range, but the binding text says "1.8 V or
3.3 V". Should the commit message use the same wording as the binding?

> +
> +    else:
> +      properties:
> +        mdio-regulator: false
>  
>  properties:
>    maxlinear,use-broken-interrupts:

[Severity: Medium]

The commit message says this will "Restrict the regulator subnode to the
MxL86211C PHY ID". Is this conditional ever applied to a real device tree
during make dtbs_check?

This schema has no select: block. Its top-level properties contain only
maxlinear,use-broken-interrupts, with no compatible or $nodename.

dt-schema builds a default select only from compatible or $nodename, so
maxlinear,gpy2xx.yaml ends up with select: false. The $ref to
ethernet-phy.yaml does not carry over that schema's select.

That leaves real PHY nodes matched only by ethernet-phy.yaml:

Documentation/devicetree/bindings/net/ethernet-phy.yaml:
select:
  properties:
    $nodename:
      pattern: "^ethernet-phy(@[a-f0-9]+)?$"
...
additionalProperties: true

So an mdio-regulator child under any PHY node (a GPY211, a Marvell part,
and so on) would pass. The node's contents would also never be checked
against regulator.yaml. The if/then/else seems to run only against the
examples in this file.

Other PHY bindings with per-PHY-ID constraints, such as
marvell,aquantia.yaml, add an explicit select: on the
ethernet-phy-idXXXX.XXXX compatibles. Is something similar needed here?

The maxlinear,lane-asp-map restriction added later in the series, by
"dt-bindings: net: maxlinear: add MxL86211C lane mapping support", looks
like it has the same gap.

[ ... ]

> @@ -45,4 +68,21 @@ examples:
>          };
>      };
>  
> +  - |
> +    ethernet {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy@0 {
> +            compatible = "ethernet-phy-idc133.5400",
> +                         "ethernet-phy-ieee802.3-c45";
> +            reg = <0>;
> +
> +            mdio: mdio-regulator {
> +                regulator-min-microvolt = <1800000>;
> +                regulator-max-microvolt = <1800000>;
> +            };

[Severity: Medium]

Is a regulator provider the right model for this hardware?

The binding description says "The board must supply the VDDP pin at the
selected voltage". The driver commit message says the PHY powers the MDIO
pins from the external VDDP, and the MDIO_VOL bit in VSPEC1_PM_CTRL only
has to match it. So the PHY does not supply any power itself.

The example gives the node a phandle label:

  mdio: mdio-regulator {

That suggests other nodes could use it as a *-supply. Any such consumer
would get a regulator that supplies nothing.

The real dependency, the board's VDDP rail, is described only in prose.
Without something like a vddp-supply consumer property, neither dt-schema
nor the driver can check that the programmed pad level matches the actual
VDDP voltage. A DT that sets 1.8 V while VDDP is 3.3 V, or the reverse,
would not be flagged.

Would a vddp-supply property be a better fit, with the driver reading its
voltage to program MDIO_VOL? A plain vendor property is another option.
Once DTs ship with the mdio-regulator node, it becomes DT ABI.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930122305.293686-1-robert.marko%40sartura.hr
