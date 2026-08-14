Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07C31813A;
	Fri, 14 Aug 2026 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730656; cv=none; b=pvd7TfFoxpw3X5vinuAfjQiJvxXU3azgU3VVb/VD8zDxpZISSjpLOF6gzSukk7gosfjTAturSwMozyscznkrK+Jx6p384VhkK0kJ8AXBWLBBKdnUvJQ0WgCwldF/lWEFIPHqvgNRpKDXBINEM7m4KwJS5aq+mD4RRvsHQQrR+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730656; c=relaxed/simple;
	bh=0ZKZ5jySEEJEV5qsbPIioMhFsdBHIiJ9xZchvIeeUpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gqex3Weway8s/K/FK+XInwkZT701ZKYyi3GpKQt3pjPU1rB4H4zzdgGRKcxVzTI/f3wSCY5Ii+gDfcac54aZnTEoFr5pzfur/1JMpWxvbHU4fBOWqRbKA1Wy0Mjhtt8m/lMSITxp4tEUK92Q6JkOWK7POuh84ktoH5TkpzB2ARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jubd+W1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jubd+W1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4081F000E9;
	Fri, 14 Aug 2026 18:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786730654;
	bh=lJGYR95OzBj8QQrlKrddVqSXRN2vXQMzoaoigQ4hsXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jubd+W1NfLbtm6lAdMzClqirXNT6srtJHwF3bT3W3ckPhpJ9UESTWVxCB29x4ZPL6
	 uILMjE3VnYiLS0JnIvquRq/8A96z4UAS33vieWjkGE3tRzSZqCqQV2qPKmlBri0kOQ
	 ZKkrI6zT5HtNmJMnbdQSV9GGc81InAaSpdqwD8FB0xWMV6CLoaxhydpnP07yd1DAuD
	 bKGKc3Ws9DgmTQ+yrZfV0jkOKTNr7R/Ux1aciFjPxUAUSQBUy6fZ6XZ2OX40zocjFE
	 qZcHdlAiP+bVfGMfISAddMV6i6GbhvOqprelXrjq486McTmoeANEiMssh6dXm0Akwo
	 rEPqjJEuGZCMg==
Date: Fri, 14 Aug 2026 13:04:13 -0500
From: Rob Herring <robh@kernel.org>
To: "Neeli, Srinivas" <srneeli@amd.com>
Cc: Jakub Kicinski <kuba@kernel.org>, nagadheeraj.rottela@amd.com,
	srinivas.neeli@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
	andrew@lunn.ch, olteanv@gmail.com, horms@kernel.org,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, git-dev@amd.com
Subject: Re: [PATCH 01/20] dt-bindings: net: add Xilinx TSN Endpoint Ethernet
 MAC
Message-ID: <20260814180413.GF1981719-robh@kernel.org>
References: <20260807104431.157230-2-nagadheeraj.rottela@amd.com>
 <20260808194815.132344-1-kuba@kernel.org>
 <ba624013-e8e2-4262-a451-650c29dc6b8f@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba624013-e8e2-4262-a451-650c29dc6b8f@amd.com>

On Fri, Aug 14, 2026 at 03:59:27PM +0530, Neeli, Srinivas wrote:
> Hi Jakub,
> 
> On 8/9/2026 1:18 AM, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > ---
> > dt-bindings: net: add Xilinx TSN Endpoint Ethernet MAC
> > 
> > This adds a new binding for the Xilinx TSN Endpoint Ethernet MAC IP,
> > describing a wrapper node that owns the six IP clocks and
> > xlnx,num-priorities, plus an endpoint MAC child and a three-port switch
> > child.  A MAINTAINERS entry is added for the new file.
> > 
> > A few questions about the schema below.
> > 
> > > diff --git a/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
> > > new file mode 100644
> > > index 000000000000..00f52b7b623c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
> > > @@ -0,0 +1,343 @@
> > [ ... ]
> > 
> > > +properties:
> > > +  compatible:
> > > +    const: xlnx,tsn-endpoint-ethernet-mac-3.0
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > [Severity: Low]
> > Should the wrapper node have a reg at all?  It is listed in the top-level
> > required list alongside ranges, and in the example the two describe the
> > same window:
> > 
> >      reg = <0x80040000 0x40000>;
> >      ranges = <0x0 0x80040000 0x40000>;
> > 
> > Every child window (mac1 0x0+0x14000, ep-mac 0x16000+0xa000, mac2
> > 0x20000+0x14000, switch 0x38000+0x8000) falls inside the parent's own
> > reg.
> > 
> > The commit message says the wrapper only owns the six shared clocks and
> > xlnx,num-priorities, and the wrapper driver in this series never maps
> > that region:
> > 
> > drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c:tsn_ip_probe() {
> >      ...
> >      ret = devm_clk_bulk_get(dev, TSN_NUM_CLOCKS, w->clks);
> >      ...
> >      return devm_of_platform_populate(dev);
> > }
> > 
> > Would it be cleaner for a bus node that translates its children through
> > ranges to either drop reg or describe only a wrapper-private register
> > block that no child window overlaps?
> Thanks. We would prefer to keep reg as a required property of the wrapper,
> for two reasons.
> 
> First, reg describes the whole TSN IP register window, which is a hardware
> property of the IP, and ranges translates the child offsets within it. The
> child windows do not fully cover the IP window, mac1, ep-mac, mac2 and the
> switch fabric account for 232 KB of the 256 KB window, leaving 24 KB
> unmapped by any child (0x14000..0x16000 and 0x34000..0x38000). That reserved
> space is where the IP places top-level registers that are not owned by any
> child node.

Why not describe those 2 ranges in reg? Otherwise, you are mapping the 
child addresses twice potentially.

> Second, we intend to use that space. A planned use is a wrapper-level
> build/configuration register that tells software which sub-blocks the IP
> instantiates, so the wrapper can decide which children to populate. For
> example, an endpoint-only build has no switch block, and the wrapper would
> read that register to skip the switch node instead of relying on the child
> nodes alone. That register lives in the wrapper window, not in any child, so
> the wrapper needs its own reg to reach it.
> 
> Because reg is in the required list, making it optional later and then
> requiring it again would be an ABI change. Keeping it required now avoids
> that
> churn once the wrapper starts reading its own register. The wrapper driver
> in
> this series does not map reg yet, which is a driver limitation rather than a
> reason to drop the hardware description.

If there are registers outside of the child nodes, then absolutely you 
should have 'reg'. But please describe what registers and functionality 
are there.

[...]

> > > +      mdio-mac1:
> > > +        $ref: /schemas/net/mdio.yaml#
> > > +        description:
> > > +          MDIO bus controller for MAC1. Registers reside inside the mac1
> > > +          reg-names window.
> > > +        unevaluatedProperties: false
> > > +
> > > +      mdio-mac2:
> > > +        $ref: /schemas/net/mdio.yaml#
> > > +        description:
> > > +          MDIO bus controller for MAC2. Registers reside inside the mac2
> > > +          reg-names window.
> > > +        unevaluatedProperties: false
> > [Severity: Low]
> > This isn't a bug, but the child node names contradict the $nodename
> > patterns of the generic schemas this binding references.
> > 
> > mdio.yaml documents:
> > 
> >      pattern: '^mdio(-(bus|external))?(@.+|-([0-9]+))?$'
> > 
> > and -mac1 / -mac2 matches none of the allowed suffixes (-bus, -external,
> > @<addr>, -<digits>).  Similarly the patternProperties key "^ep-mac@"
> > forces names like the example's ep-mac@16000, while
> > ethernet-controller.yaml documents:
> > 
> >      pattern: "^ethernet(@.*)?$"
> > 
> > Other in-tree bindings that $ref mdio.yaml for a child use a conforming
> > name (qca8k.yaml, realtek.yaml, renesas,rzn1-a5psw.yaml,
> > renesas,etheravb.yaml, faraday,ftgmac100.yaml, microchip,lan7800.yaml).
> > Would mdio@<offset> (or mdio-0 / mdio-1) and ethernet@<offset> work here
> > instead?
> > 
> > Related: the mdio-mac<N> nodes carry no reg, so nothing in DT locates the
> > MDIO block inside the parent mac1/mac2 window.  The offset is instead
> > hard-coded in the driver added later in this series:
> > 
> > drivers/net/dsa/xilinx/xilinx_tsn.h:
> >      #define TSN_MDIO_MC_OFFSET		0x00000500
> > 
> > Could the buses be described as mdio@500 with a reg so the offset comes
> > from DT?
>  Thanks, accepted. In next version renames ep-mac@ to ethernet@ and
> mdio-mac1/mdio-mac2 to
>   mdio-1/mdio-2 to match the referenced schemas. The MDIO registers sit at a
>   fixed offset inside the per-MAC window the driver already maps and have no
>   standalone address, so the mdio-1/2 nodes keep that form without a reg
>   rather than mdio@500.

If there is a register address associated with them, then using that is 
strongly preferred over mdio-N.

Rob
