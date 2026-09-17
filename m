Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FB74DEC39;
	Thu, 17 Sep 2026 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672884; cv=none; b=fPK4Y5czqTeykqqwIDdFte1JPcODtn7ciyDyanvJPN2wC/Arnw6aULXLQw++fEGxOzmKhxXTC3DthjIYsGEOa8tfQDBcTOWkDTsSlVbaJSHLf/wDcc4aEuWHv+NZNn8nm3RDLKg382jMNkjADh0tkXQITPgyf2cWRp2OLYbC8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672884; c=relaxed/simple;
	bh=uSEumnYFunQQnmUN6qo3BBiP8xYeDXP6NosN8NmzVYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu8K2v6Vv4JktLEAn4CVApMdWARBuh+gIPKALuAynD/XFwDRdHaoA5PVAXq4EQ5o3ZUNrjGrTYrqmpo8zhHLqiKU7+AanF4xJNyh2koC9nT/fVRhr7ztPDfDJefmhHXy9fxGD1aK4h93ZK8YUZprQHe4xt9lFqoGwAWpnRsZ8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x7HfV-000000001Pv-3V9V;
	Thu, 17 Sep 2026 19:21:13 +0000
Date: Thu, 17 Sep 2026 20:21:10 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Subject: Re: [PATCH v5 net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
Message-ID: <aqw9ptzAZBmdHy1S@makrotopia.org>
References: <20260915113427.113296-1-cjd@cjdns.fr>
 <aqkwYd5dTmHDCIW9@makrotopia.org>
 <2a7edfd0-b784-4b60-b9f9-769fe00286b7@cjdns.fr>
 <aqv92pZsobVEdipZ@makrotopia.org>
 <95202df5-fdbb-4325-b77b-5f45ac8b1732@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95202df5-fdbb-4325-b77b-5f45ac8b1732@cjdns.fr>

On Thu, Sep 17, 2026 at 05:11:50PM +0200, Caleb James DeLisle wrote:
> 
> On 17/09/2026 16:48, Daniel Golle wrote:
> > On Tue, Sep 15, 2026 at 02:01:29PM +0200, Caleb James DeLisle wrote:
> > > On 15/09/2026 13:47, Daniel Golle wrote:
> > > > On Tue, Sep 15, 2026 at 11:34:27AM +0000, Caleb James DeLisle wrote:
> > > > > @@ -135,6 +199,23 @@ static struct phy_driver mtk_gephy_driver[] = {
> > > > >    		 */
> > > > >    		.config_intr	= genphy_no_config_intr,
> > > > >    		.handle_interrupt = genphy_handle_interrupt_no_ack,
> > > > > +		.match_phy_device = mt7530_phy_match,
> > > > > +		.suspend	= genphy_suspend,
> > > > > +		.resume		= genphy_resume,
> > > > > +		.read_page	= mtk_phy_read_page,
> > > > > +		.write_page	= mtk_phy_write_page,
> > > > > +	},
> > > > > +	{
> > > > > +		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),
> > > > I'd suggest to actually use phy_id and phy_id_mask assigned by the
> > > > PHY_ID_MATCH_EXACT macro by calling genphy_match_phy_device() in your
> > > > match functions above instead of open-coding the ID match.
> > > > Or drop PHY_ID_MATCH_EXACT from *both* drivers.
> > > I suppose the latter is easier because then I don't have to re-think
> > > mt7530_is_gphy() which would be lying if it wasn't actually checking ID is
> > > MTK_GPHY_ID_MT7530.
> > > 
> > I would have preferred to call genphy_match_phy_device() in your match
> > functions instead of open-coding phy_id_compare() which is best
> > reached via genphy_match_phy_device() in this situation -- that would
> > express the code intent in the most obvious way imho.
> 
> 
> I did it this way because the name mt7530_is_gphy() implies "Is this an
> MT7530 gigabit PHY?" which if it doesn't match on MTK_GPHY_ID_MT7530 then
> that's not what it does so there's a little bit more thought involved.
> 
> 
> If I'd have known this was really your preference I'd have done that, but I
> already just sent v6 so I guess I can send v7 tomorrow.

It's also fine for me like it is now, just a light preference, not
worth a resend just for that.

However, I'd also still like to see the OF parent walk replaced by
register evidence, which requires that you dump the registers more
than once to understand if any difference are things like counters or
temperature, or actually identify the PHY variant.

It can of course be that the actual silicon is really the exact same
MT7530 MCM as eg. on MT7623, just driven by a different clock
frequency and the observable register differences are things like
clock devidors -- if we manage to understand that and just apply the
resulting tuning accordingly, even better.
