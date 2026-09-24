Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8BB49F133;
	Thu, 24 Sep 2026 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264999; cv=none; b=BKMewxBAoNcdRAkY69glZskfCYoLhkw8SQ4nFagVIfsrtWAFRlL5mykY6Bxxpk7ZW1bhK1QF2m86CIU8TucgOLpaWPKOosrzOOjeAyPxx6aDw6At5gCEzDRrGSIL5DOjTF+oxvKWHDFsTXxtMxl5iODYhVhOViM7HP6K/Mpa200=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264999; c=relaxed/simple;
	bh=9+uqdxtcu6rBegFoKpvshXCzSay83nFMY5uyI1rBSAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9SFKaPpTceRvVPZgdBBngFTYzKDxVllgyYF2lmp5ym1GM4rNcmHBCoSKlvd5Ht46ck0OUoMSSRKkchLI0SnlfjypKy+B810BByJ8jQo5Ip7I4g8FniuWSOMhXeElWTRuob7qGJfKV09Y42frzqkztGYkxXpk+tJtrj1o/baqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtXtATge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtXtATge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD26B1F000FF;
	Thu, 24 Sep 2026 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790264997;
	bh=adX4Y7r/DWNGOUOGLuLi9FeUPsBpo9HjSjYThCKsYbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QtXtATge/W7X1F2Ei72Hf74vg2JjbkFPhXOpPkdoRM8Am/OBoTB9RCP1v9YcJFvhx
	 jvFhZ/DnQzwb9qCQpXxR1kpwO7u6skpqsEe1FfppoRjcEi3WLdY5fiCLjnCXd4HUHk
	 Hi1aC5nUBKoVXs3b58jwbSw9fqQd6HEptgZ5yFj8hy6T2ZRQhjpYVgOo0pIOGymFVm
	 ETlbFNVSEn1ymefhIaAzE+5GmtezyjM+bTtC0e0VNA7CYWwWvYsKMaHiVQwZbKmDS4
	 yJcLCQDXO4elf66tJe77EoZs7q1Prz+vZjHeZEuOJmWRoyNpX85R3xJOcPbSAtZqKf
	 YFEqH01/szJ8Q==
Date: Thu, 24 Sep 2026 10:49:55 -0500
From: Rob Herring <robh@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: cjd@cjdns.fr, netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com, daniel@makrotopia.org,
	linux@armlinux.org.uk, arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, naseefkm@gmail.com,
	b.larsson@gmx.com
Subject: Re: [PATCH v2 net-next 6/7] dt-bindings: net: dsa: mediatek,mt7530:
 add econet,en751221
Message-ID: <20260924154955.GA337010-robh@kernel.org>
References: <20260915174643.253660-7-cjd@cjdns.fr>
 <178967820050.22033.18093714968849770785@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178967820050.22033.18093714968849770785@kernel.org>

On Thu, Sep 17, 2026 at 08:50:00PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 7 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 4 · Low: 2
> 
> - [High] net: dsa: lockless child_bus access causes MDIO race condition
> - [Medium] The new switch-device compatible `econet,en751221`
>   (mediatek,mt7530.yaml line 126) is the identical string already…
> - [Medium] The new `econet,en751221` conditional (mediatek,mt7530.yaml
>   lines 369-377) applies only `$ref: "#/$defs/mt7530-passthrough-dsa-…
> - [Medium] The series patch "net: dsa: mediatek: support MDIO switch
>   downstream of MMIO switch" moved `mt7530_setup_mdio_irq()` out of…
> - [Medium] In passthrough mode `mt753x_cpu_port_enable()` (added by the
>   series patch "net: dsa: mediatek: add support for passthrough mode")…
> - [Low] The paragraph added to the binding description
>   (mediatek,mt7530.yaml lines 32-36) states that "EcoNet EN751221 SoCs…
> - [Low] Concern that neither `econet,en751221-switch` nor
>   `econet,en751221` has any consumer: at this commit…
> 
> --
> 
> dt-bindings: net: dsa: mediatek,mt7530: add econet,en751221
> 
> This adds two compatible strings to the MT7530 binding: econet,en751221-switch
> for the memory mapped switch built into the EcoNet EN751221 SoC, and
> econet,en751221 for the MT7530 multi-chip module that some EN751221 packages
> attach to port 5 of the on-die switch via TRGMII. A new $defs block constrains
> the DSA link port of the multi-chip module.
> 
> A few questions on the schema below, plus two observations about other
> patches in the same series.
> 
> > diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > index e29fb86934981..106c4087528d7 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > @@ -29,6 +29,12 @@ description: |
> >    and the switch registers are directly mapped into SoC's memory map rather than
> >    using MDIO. The DSA driver currently doesn't support MT7620 variants.
> >  
> > +  EcoNet EN751221 SoCs have a memory mapped MT7530 with 3x 10/100 PHYs and 1x
>                                                           ^^^^
> 
> [Severity: Low]
> Should this be 4x 10/100 PHYs?  The commit message of this patch says
> "ports 0..3 are 10/100 only, port 4 has a gigabit PHY", which is four fast
> ethernet PHYs, and en751221_mac_port_get_caps() in the later driver patch of
> this series agrees:
> 
> 	/* EN751221 ports 0..3 are connected to the integrated FE PHYs. */
> 	case 0 ... 3:
> 		__set_bit(PHY_INTERFACE_MODE_INTERNAL, config->supported_interfaces);
> 		config->mac_capabilities |= MAC_10 | MAC_100;
> 
> Since there is no in-tree EN751221 switch DTS yet, this paragraph is the only
> port reference a DT author has.
> 
> > +  gigabit PHY. Some EN751221 chips such as EN7513G and EN7526G have a multi-chip
> > +  module implementation of the MT7530 as well as the on-die switch. In these
> > +  packages, the multi-chip module is connected to port 5 of the on-die switch
> > +  via a TRGMII link.
> > +
> >    There is only the standalone version of MT7531.
> >  
> >    Port 5 on MT7530 supports various configurations:
> > @@ -111,6 +117,14 @@ properties:
> >            Built-in switch of the EcoNet EN7528 SoC
> >          const: econet,en7528-switch
> >  
> > +      - description:
> > +          Built-in switch of EcoNet EN751221 SoC
> > +        const: econet,en751221-switch
> > +
> > +      - description:
> > +          Multi-chip module MT7530 in EN751221 SoC
> > +        const: econet,en751221
> 
> [Severity: Medium]
> Can this string collide with the existing SoC compatible?  econet,en751221 is
> already documented as the EN751221 root node compatible in
> Documentation/devicetree/bindings/mips/econet.yaml:
> 
>   properties:
>     $nodename:
>       const: '/'
> 
>     compatible:
>       oneOf:
>         - description: Boards with EcoNet EN751221 family SoC
>           items:
>             - enum:
>                 - smartfiber,xp8421-b
>             - const: econet,en751221
> 
> and arch/mips/boot/dts/econet/en751221.dtsi uses it on the root node:
> 
>   / {
> 	compatible = "econet,en751221";
> 
> dtschema derives the select clause of a binding from the strings enumerated
> under properties:compatible, so after this patch mediatek,mt7530.yaml is also
> selected for that root node.  The switch schema has required: [compatible,
> reg], unevaluatedProperties: false, and via the new conditional below also
> required: [mediatek,mcm] (which in turn pulls in resets and reset-names).  Does
> make dtbs_check on arch/mips/boot/dts/econet/en751221_smartfiber_xp8421-b.dtb
> now report the root node as an invalid MT7530 switch node?
> 
> The reverse direction looks affected too: a switch@... node carrying
> compatible = "econet,en751221" is selected by mips/econet.yaml and fails its
> $nodename: const: '/' and its two-entry board/SoC compatible list.
> 
> The analogous MT7621 case does not collide because the SoC root uses
> mediatek,mt7621-soc.  Since the SoC compatible is already released, would a
> distinct string for the switch, e.g. econet,en751221-mcm-switch, work here?

This needs to be addressed.

Rob
