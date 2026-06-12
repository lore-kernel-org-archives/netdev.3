Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8E37A498;
	Fri, 12 Jun 2026 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260206; cv=none; b=CY9Izw579mHVVIEBkP53HpAxXzBvoTIqzTJgSNoJsYo7RXUpY3DM0Lx9wWOvJYsqNOQ0gd/+Ccr7powdwJxMyop7CAhqMDyorHJUqlZKOvKbHljcgCkb4mzDePxzHmWIrSFaQMTTDsgyuvvEsoXH6XvT/MHbBNwegFHAG/0xzNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260206; c=relaxed/simple;
	bh=oNWNxabB5hgyepv/nXrP1Motmluk3pvzLgN4LIjRzMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNrWGhVM5KKJHjjZCyxO6BTNgvW872zL0eYFzr6OgJBzB5mDLPjtsYYl+ScsqmIy4RdA99Zd8QFNkukrCOWs38sKItrD8vmJ6Gn+U1QnQmyU9A9DqPa0WacQZcvqjml8lHhA1AJpaGTHpxIWHV+nwiIjaWvgiYnsLhZZcGDJl30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wXz92-0000000030H-3xgm;
	Fri, 12 Jun 2026 10:29:49 +0000
Date: Fri, 12 Jun 2026 11:29:45 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 8/8] net: dsa: mt7530: implement
 port_change_conduit op
Message-ID: <aivfmaWBpTw6LwFp@makrotopia.org>
References: <cover.1781119435.git.daniel@makrotopia.org>
 <91ae0f87a6ca2cce3d072dba548545e02347bf13.1781119435.git.daniel@makrotopia.org>
 <02ad5de0-ea6a-4267-8686-72e3f98fce4e@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ad5de0-ea6a-4267-8686-72e3f98fce4e@arinc9.com>

On Fri, Jun 12, 2026 at 07:36:35AM +0000, Chester A. Unal wrote:
> On 10/06/2026 20:56, Daniel Golle wrote:
> > Allow changing the CPU port affinity of user ports at runtime via
> > the IFLA_DSA_CONDUIT netlink attribute. This updates the port matrix
> > to forward to the new CPU port instead of the old one.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> Fabulous!
> 
> Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>
> 
> > ---
> >   drivers/net/dsa/mt7530.c | 29 +++++++++++++++++++++++++++++
> >   1 file changed, 29 insertions(+)
> > 
> > diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> > index c96420c291d5..2f3e734b9f53 100644
> > --- a/drivers/net/dsa/mt7530.c
> > +++ b/drivers/net/dsa/mt7530.c
> > @@ -3206,6 +3206,34 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
> >   	return 0;
> >   }
> > +static int
> > +mt753x_port_change_conduit(struct dsa_switch *ds, int port,
> > +			   struct net_device *conduit,
> > +			   struct netlink_ext_ack *extack)
> > +{
> > +	struct dsa_port *new_cpu_dp = conduit->dsa_ptr;
> > +	struct dsa_port *dp = dsa_to_port(ds, port);
> > +	struct mt7530_priv *priv = ds->priv;
> > +
> > +	if (priv->id != ID_MT7531)
> > +		return -EOPNOTSUPP;
> 
> Why do we limit this to MT7531 only?

I could test it only on MT7531 (BPi R64), and that's also where it
makes most sense imho: On MT7530 we got PHY muxing, on the MMIO
switches we physically got only a single CPU port.
