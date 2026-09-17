Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD7A4D957E;
	Thu, 17 Sep 2026 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674595; cv=none; b=M9NYs4HO4UZh1oKeMC/CpVgLQp8Y5dXzPtFpnetdUklz+lS9+v3E6ty2T1nFlKYVlCw73yUteWx6BQ671lqsaiVlTwQt75H9mJnM1a275j6f/MPgu4UNvlkfm4AwdPYhKywL3gXiRTn1XL48iYOQuLMWXCAjJh7GMp+qMFGQ7is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674595; c=relaxed/simple;
	bh=oN2+M0QJeAms4H0OPguBJyBQQvy8vbt5nXobYd9dPWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1oMnW53s1SWnnm8QMcmghgEWpr7kbl8LK9OFMuk9DAjLUJISlwloBYaTfxngkX8hkcZazW9Dl5lHDovN2TUADDn6rfvWOzGVJ3v1AoCMQ4DhQK+0IBCspLL99TrpM+02LXj8TUsl0nCsWGF8mHt3aXdy6VBmaIqH2qVtnxCIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oy6+YVh5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy6+YVh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF67F1F000FF;
	Thu, 17 Sep 2026 19:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789674594;
	bh=o3O8qnCiUPlZCVh+c2xR8Mss83VS2GxJa195dqxdn+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oy6+YVh5TVgt4sSryor3AO8Bcffid6cySAWQOQjzX0ukB+4WVBqyqLZECaVqsGQL+
	 ty3IN3/JN7koqzSCNKKoiQige0PXYEENWsjyj1UVISIWOwcALP/fx+IdB9gcJUIJpH
	 v4lDXfcP7QFfCLh99xtXanp8kjZ2wZDXM56S3iEcf/UB6LYjoSQxiiCcy+7V+mD+R7
	 6fTtkrE9YY1QQwY6CpJ4ScxgN2f5jJLvf9ADC94so+KVz7DIqZWIZ95BlHnyHPtYnu
	 GaIPcfqA8tvtAMZ4r0JjWRqKot87B/282OAW1Nn444MyXBnSdOvUvezeWu17HK0TGS
	 pZDiJ+BGHAOFQ==
Date: Thu, 17 Sep 2026 14:49:52 -0500
From: Rob Herring <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	tony@atomide.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com,
	simona.toaca@nxp.com
Subject: Re: [v3] dt-bindings: net: ti,davinci-emac: Convert to DT schema
Message-ID: <20260917194952.GA3457763-robh@kernel.org>
References: <20260901-ti-davinci-emac-v3-1-db41e32f3f6d@gmail.com>
 <178844863252.3394541.10006643092711574384@kernel.org>
 <CAOWyW_6qRhoUts2MtvDL3JiBx74UOBs73Fye=1FKrky-brmS8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOWyW_6qRhoUts2MtvDL3JiBx74UOBs73Fye=1FKrky-brmS8Q@mail.gmail.com>

On Fri, Sep 04, 2026 at 01:13:54AM +0530, Bhargav Joshi wrote:
> Hi,
> 
> On Thu, Sep 3, 2026 at 8:47 PM <netdev-bot+sashiko@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider:
> >
> > Critical: 0 · High: 0 · Medium: 1 · Low: 1
> >
> > - [Medium] The new schema lets `ti,dm816-emac` nodes carry either 1 or 2
> >   `reg` entries with no further constraint, while the driver derives…
> > - [Low] The schema makes `clocks` required (justified in the commit
> >   message by 'driver probe fails without it') but leaves `power-domains`…
> >
> > --
> >
> > dt-bindings: net: ti,davinci-emac: Convert to DT schema
> >
> > This converts the DaVinci EMAC text binding to YAML, documents clocks,
> > clock-names, syscon, power-domains and ti,hwmods, and adds per-compatible
> > conditionals restricting reg, syscon and clock-names.  clocks becomes a
> > required property and ti,hwmods is marked deprecated.
> >
> > > diff --git a/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml b/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml
> > > new file mode 100644
> > > index 0000000000000..f0c539d1bac79
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml
> > > @@ -0,0 +1,127 @@
> >
> > [ ... ]
> >
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - ti,davinci-dm6467-emac
> > > +      - ti,am3517-emac
> > > +      - ti,dm816-emac
> > > +
> > > +  reg:
> > > +    minItems: 1
> > > +    items:
> > > +      - description: EMAC core
> > > +      - description: EMAC control module
> >
> > [Severity: Medium]
> >
> > For ti,dm816-emac this leaves reg free to be either 1 or 2 entries, but the
> > driver derives hardware semantics from the entry count.  In
> > davinci_emac_probe() the presence of the second region is the only signal
> > used, both for the control module base:
> >
> >         res_ctrl = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> >         if (res_ctrl) {
> >                 priv->ctrl_base =
> >                         devm_ioremap_resource(&pdev->dev, res_ctrl);
> >                 ...
> >         } else {
> >                 priv->ctrl_base = priv->remap_addr + pdata->ctrl_mod_reg_offset;
> >         }
> >
> > and for the SCM eFuse MAC-ID instance:
> >
> >         rc = davinci_emac_try_get_mac(pdev, res_ctrl ? 0 : 1, priv->mac_addr);
> 
> This driver logic relies on the reg entry count to determine the port
> instance. This is a software implementation detail and not hardware
> detail. I believe it is bad idea to rely on the number of reg entries to
> get instance, It's better to use of_alias_get_id() to get instance of port.
> 
> >From a hardware perspective, eth0 requires 2 reg entries because MDIO
> node occupies the 0x800 to 0x8FF.
> 
> >
> > which flows into ti_cm_get_macid()/cpsw_am33xx_cm_get_macid() and selects the
> > register pair at offset + slave * 8.
> >
> > Given that, can a schema-valid DM816x node land on the wrong hardware?  Two
> > cases seem possible:
> >
> > A single-reg EMAC0 node with a 0x800 core window (as in dm816x.dtsi, where
> > MDIO at 0x4a100800 is a separate node) plus ti,davinci-ctrl-mod-reg-offset =
> > <0x900> would make ctrl_base point 0x900 past the end of the ioremap.
> >
> To resolve this I can either:
> 
> Use nodename to hardcode exact address for eth0 and eth1 something like
>   if:
>       properties:
>         $nodename:
>           pattern: "^ethernet@4a100000$"
>   then:
>       properties:
>         reg:
>           minItems: 2
> or
> Enforce 2 reg for both eth0 and eth1, For eth1, even though there is no
> MDIO, the base+0x800 to 0x8FF is simply unused, so describing it as
> split regions is still accurate. But this will require a driver fix
> for getting port
> instance.

Just leave it as-is. This is for ancient h/w.

Rob
