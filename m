Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF43A1684;
	Thu, 17 Sep 2026 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656579; cv=none; b=KfV9a76cub7ZnD+Bd2JG0ODAsxvK4GN3hxjHPfyndMEo8QrW5kT1excT6Ns7uUUipkKfcXNpRSPi1WfQrvQdGJUR5qu8+kjlLQEMJMAssK2XRr/BASqxunhBozPX4QnfdP87T/Cmxp/kQ8BQy/gPy7jd30aHNwiZDuIox0tFKsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656579; c=relaxed/simple;
	bh=Bm97bs0tZCtN5NkrXaGPV6koqm+2fuz4r/vQ0Sg6b80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFhv75JJ4X+K2tNzFQcCQSAECb4vmdbfN37T3OTtGIZcAOgYPqXwPt/8v12ZpZzm9Yj8eWLy053IyrF/kyVhIG8qQmS7xAZemk36kTyu/sJNBxTOpA6zJwAD9oTHtiwr2RuNVcrAudAmNPXNPXq6QLiGLKEXiU6xSVSeiI0nPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x7DQ5-000000008HR-1vZr;
	Thu, 17 Sep 2026 14:49:01 +0000
Date: Thu, 17 Sep 2026 15:48:58 +0100
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
Message-ID: <aqv92pZsobVEdipZ@makrotopia.org>
References: <20260915113427.113296-1-cjd@cjdns.fr>
 <aqkwYd5dTmHDCIW9@makrotopia.org>
 <2a7edfd0-b784-4b60-b9f9-769fe00286b7@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a7edfd0-b784-4b60-b9f9-769fe00286b7@cjdns.fr>

On Tue, Sep 15, 2026 at 02:01:29PM +0200, Caleb James DeLisle wrote:
> On 15/09/2026 13:47, Daniel Golle wrote:
> > On Tue, Sep 15, 2026 at 11:34:27AM +0000, Caleb James DeLisle wrote:
> > > @@ -135,6 +199,23 @@ static struct phy_driver mtk_gephy_driver[] = {
> > >   		 */
> > >   		.config_intr	= genphy_no_config_intr,
> > >   		.handle_interrupt = genphy_handle_interrupt_no_ack,
> > > +		.match_phy_device = mt7530_phy_match,
> > > +		.suspend	= genphy_suspend,
> > > +		.resume		= genphy_resume,
> > > +		.read_page	= mtk_phy_read_page,
> > > +		.write_page	= mtk_phy_write_page,
> > > +	},
> > > +	{
> > > +		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),
> > I'd suggest to actually use phy_id and phy_id_mask assigned by the
> > PHY_ID_MATCH_EXACT macro by calling genphy_match_phy_device() in your
> > match functions above instead of open-coding the ID match.
> > Or drop PHY_ID_MATCH_EXACT from *both* drivers.
> 
> I suppose the latter is easier because then I don't have to re-think
> mt7530_is_gphy() which would be lying if it wasn't actually checking ID is
> MTK_GPHY_ID_MT7530.
> 

I would have preferred to call genphy_match_phy_device() in your match
functions instead of open-coding phy_id_compare() which is best
reached via genphy_match_phy_device() in this situation -- that would
express the code intent in the most obvious way imho.
