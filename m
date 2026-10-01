Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358663F104F;
	Thu,  1 Oct 2026 04:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829931; cv=none; b=mllJ5j0r/A7wUWqfYwp9mxy4CzoW+rNK9jsTX7bNRAp4J3zdO2MwTXl+F7mVnfXGeCLCozzTHa+qE+4CCmbYTLbtWeTNy+wbgoY8bGYG5yh5qfF5n7Ctzn2PkKnudxdXr1h6i+tXB4ZMxINQkfqsl2hj/mJ3VB2cvbratqG1msU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829931; c=relaxed/simple;
	bh=A9Q/WCwDoDvXnw5oNfjvS2tbLVGeRf83RF6Eq0wItHM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=shTS+Vxaz3MJsIzZc4/fi89/6GA10sJ2YFyZyc7ct/F7PZpB1gVN0oFjoVC/h7DDqOnuGvgf485Ogxd3mhbwF6SzeQYdbM5HLqvZ0bPTmFjMao1TRax+c2ry3aeEePOsvZIZ05NW56t9HAf7nWvw4HA78dmQ+zAMcU/5oG9m/fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZtJESE+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZtJESE+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B89B1F000FF;
	Thu,  1 Oct 2026 04:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790829927;
	bh=NKNnYWlZ4y0T7QFRMYOGoByQhzd8uC503fuBr3CdBm4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FZtJESE+BWot7p5Ro5S53bhfOHS/d90XihLGl4ORxXaFnpZaZ8Y+AVbqp/eAPgj4h
	 eWWFyEgqQy+q4c6Hq/YZS3/PYhfVUd6HoToVW/Xhb+dJCNPbuIuiFOpJWHZCZ8E6Bm
	 LQTWoK82V8/DkcHXYprDNo2olbZBEkgacbGrkIX3F+RgVji2ycf+AJ3nCSWIDvtXCT
	 F/hCUMlkmWJVMdnv+KJntrtIv3IR5a+IkuA1dnPdByzAlMmvH8rGNANHrDaiYY8FX1
	 u91k9XZtQs0HrmiXxeOK2ni6VYGpva0a0rSvrzo7XTwGYfo5LFBZTXnhkLqrCYiq9U
	 LmzsM7c5rbugw==
Subject: Re: [PATCH net-next v24 01/10] dt-bindings: net: dsa: Document
 support for Airoha AN8855 DSA Switch
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, joey@tinyisr.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew@lunn.ch
Date: Thu, 01 Oct 2026 04:45:25 +0000
Message-ID: <179082992577.434549.3218874144788071107@kernel.org>
In-Reply-To: <20260928194511.41878-2-ansuelsmth@gmail.com>
References: <20260928194511.41878-2-ansuelsmth@gmail.com>
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

- [Low]
  Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml…

--

dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch

This commit adds a YAML binding for the Airoha AN8855 5-port Gigabit
Switch. The binding references the generic DSA ethernet-ports
definition and adds a single compatible string.

> diff --git a/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> new file mode 100644
> index 0000000000000..5ad9b9e139831
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml

[ ... ]

> +description: >
> +  Airoha AN8855 is a 5-port Gigabit Switch.
> +
> +  It does expose the 5 Internal PHYs on the MDIO bus and each port
> +  can access the Switch register space by configuring the PHY page.
> +
> +$ref: dsa.yaml#/$defs/ethernet-ports

[Severity: Low]
Should the port unit addresses be limited to what the hardware has?

This binding inherits the generic port node pattern from
dsa.yaml#/$defs/ethernet-ports without narrowing it:

Documentation/devicetree/bindings/net/dsa/dsa.yaml:
          "^(ethernet-)?port@[0-9a-f]+$":

The AN8855 has 6 ports. Ports 0-4 are user ports with internal PHYs and
port 5 is the CPU port, and the driver later in the series sets
ds->num_ports = AN8855_NUM_PORTS.

As a result, a DT with port@7 or port@1f still passes dt_binding_check
and dtbs_check. It is only rejected at probe time, and then the whole
switch fails to probe:

net/dsa/dsa.c:dsa_switch_parse_ports_of() {
    ...
		if (reg >= ds->num_ports) {
			dev_err(ds->dev, "port %pOF index %u exceeds num_ports (%u)\n",
    ...
}

Other DSA bindings with a fixed port count narrow the pattern under
ports: patternProperties. For example, mediatek,mt7530.yaml and
qca8k.yaml use "^(ethernet-)?port@[0-6]$", and renesas,rzn1-a5psw.yaml
uses "^(ethernet-)?port@[0-4]$".

Would something like "^(ethernet-)?port@[0-5]$" make sense here? This
file is unchanged at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928194511.41878-1-ansuelsmth%40gmail.com
