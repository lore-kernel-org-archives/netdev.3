Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E6282F1C;
	Tue,  9 Jun 2026 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994938; cv=none; b=Bm/Osyjyhi4sb4aGGae6sBg63YkFsUVUY+FsG6+hgKFkLn/itp+Ck7ydPaU0OXxYxSz2/dprWoSW819iO9fWcT3tAot1aLNAou3rj3VbBjoVd3elta1hsmSwcwIZBBi06flo5e0o9/tHeDrrKLTwAtvYkWcBliFSB6VZVI3QoWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994938; c=relaxed/simple;
	bh=jhi+GYkP22BAlzCfEIzQhy6k2kA6Euzht3gB2Wmg81I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRfdjYPjUTtE1IO6Q4847V6fqcy2FOtp9VSNlrn+QxNQPDGLQdUD7o1ZoiEUQL4K1D0oBEIVTkaWh/kF9LfKW0sighm/b7vRajZdKCR5pVTU8Cf1/BqLlu5sC1Ljy2HGLRhfwA3pw2411RimZfk1ymYTTW4zCyOAQgFu/co3rJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wI+ks+qB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wI+ks+qB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TA5bQGYH0khJJakxZgCr1WkzP74B5Wv+ze7eYIMpH5E=; b=wI+ks+qBsSD1nbpUUSq9vE6xYS
	+SNb+PoQUkLv++srtcyqnACxBgeSJKjM1r8yW/6Jve0OIL7qERQuxzKWyk3TyWH1PrpVvpFzMbSIB
	So9e7k5fVij3Q7LX7Pjh8zUTR0vN4JMh9kHpAcQoIWAqp6IX0o9Q+vxtA/9V+d9B7v10=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWs8Q-006lZL-IF; Tue, 09 Jun 2026 10:48:34 +0200
Date: Tue, 9 Jun 2026 10:48:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/9] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
Message-ID: <44c635f8-e17e-44bf-b34b-60abcde29577@lunn.ch>
References: <20260603-dsa_lan9645x_switch_driver_base-v7-0-b2f90e676707@microchip.com>
 <20260603-dsa_lan9645x_switch_driver_base-v7-4-b2f90e676707@microchip.com>
 <9ee993d0-9a71-48ff-b368-fcebe1ee9e48@lunn.ch>
 <a9ab4d129f2e3158c1a7b01d0a975fac00a05893.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9ab4d129f2e3158c1a7b01d0a975fac00a05893.camel@microchip.com>

On Tue, Jun 09, 2026 at 09:08:13AM +0200, Jens Emil Schulz Ostergaard wrote:
> On Mon, 2026-06-08 at 20:00 +0200, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > > +     dsa_switch_for_each_user_port(dp, ds) {
> > > +             if (dp->cpu_dp->ds != ds) {
> > > +                     dev_err(ds->dev,
> > > +                             "NPI port on a remote switch is not supported\n");
> > > +                     return -EINVAL;
> > > +             }
> > > +
> > > +             if (first_cpu_dp && dp->cpu_dp != first_cpu_dp) {
> > > +                     dev_err(ds->dev, "Multiple NPI ports not supported\n");
> > > +                     return -EINVAL;
> > > +             }
> > > +
> > > +             first_cpu_dp = dp->cpu_dp;
> > 
> > The reason i asked about NPI ports is because this is looping over
> > user ports. Yet you say one of these user ports is a CPU port. That
> > cannot be correct.
> > 
> > The first port returned by dsa_tree_for_each_cpu_port() would be
> > first_cpu_dp.
> > 
> >         Andrew
> 
> 
> I tried to mimic the approach in drivers/net/dsa/ocelot/felix.c:
> 
> static int felix_tag_npi_setup(struct dsa_switch *ds)
> {
> 	struct dsa_port *dp, *first_cpu_dp = NULL;
> 	struct ocelot *ocelot = ds->priv;
> 
> 	dsa_switch_for_each_user_port(dp, ds) {
> 		if (first_cpu_dp && dp->cpu_dp != first_cpu_dp) {
> 			dev_err(ds->dev, "Multiple NPI ports not supported\n");
> 			return -EINVAL;
> 		}
> 
> 		first_cpu_dp = dp->cpu_dp;
> 	}
> 
> 	if (!first_cpu_dp)
> 		return -EINVAL;
> 
> 	felix_npi_port_init(ocelot, first_cpu_dp->index);
> 
> 	return 0;
> }
> 
> Perhaps I misunderstand you, but there could be confusion about
> terminology. The chip designers have a concept of CPU port, which is
> used liberally in the datasheet, and in this driver code.

> However, the concept is different from the DSA concept of a CPU port.

And that is a problem because somebody reviewing this code is likely
to know DSA concepts much more than the individual devices concepts.
To aid overall Maintenance of all the DSA drivers, the driver should
try to keep with DSA meanings.

> Let us call the first switch CPU port, and the second DSA CPU port.
> 
> The port we want to use as a DSA CPU port, i.e. the port with the
> 'ethernet = <&host_port>;' property in the device tree, will be
> configured to be an NPI port for injection/extraction for the switch CPU
> port (which is not a physical port on the device).

> Therefore, this NPI port is not iterated by
> dsa_switch_for_each_user_port. The switch CPU port (index 9) is also not
> iterated by it. It is a chip internal construct with no representation
> in the device tree, and no struct dsa_port.

So first_cpu_dp is not a DSA CPU port. It is also not a NAPI port,
since that is a DSA CPU port. Then what is it? Why do you need the
concept of a switch CPU port?

	Andrew
