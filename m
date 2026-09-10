Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC48339375;
	Thu, 10 Sep 2026 01:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005354; cv=none; b=gfAkI1pnPUI15KG73M/y8JwrkZ5ui108DGYrriI+8TsxXwE5Ao1txKExO/jiip/Pm9gvNnmrJzqHVhHRmLUl/D3ztf6JLNWsMjs22XDs1YOR9lcGHSdNrBpCfsd7MfPxfSl87BogUtGlXX7FXLd5X3ecfhTDND5Z8pnWSNLB4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005354; c=relaxed/simple;
	bh=KDPx5k8bHAGBgI/m4RVY+ihNOs1pdyNOlaqlg6Fav04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opMWH7kEEocOGIvGuzyq3wjyL+8ObiwJbOhRJKh3Rv+yfZfjF/OwA3vTXpp4NZhS0/vVq0y+SryIx9CUxVYE1l/QRxQcb3q/ldA+7krkiVL7w2rUWKtjc7wKFTbi7R2Hse8Iuw3LfLJQergb7SqmvBTPyzC22JJwqeYyzcTaZd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x4U0t-000000006Qn-0xnF;
	Thu, 10 Sep 2026 01:55:43 +0000
Date: Thu, 10 Sep 2026 02:55:38 +0100
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
Subject: Re: [PATCH net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
Message-ID: <aqIOGgVujIKT7H2H@makrotopia.org>
References: <20260909213250.3184238-1-cjd@cjdns.fr>
 <aqHlfmYa249e3HRM@makrotopia.org>
 <7a3479c8-45cc-4b88-b111-c35d59f370e1@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a3479c8-45cc-4b88-b111-c35d59f370e1@cjdns.fr>

On Thu, Sep 10, 2026 at 01:26:14AM +0200, Caleb James DeLisle wrote:
> 
> On 10/09/2026 01:02, Daniel Golle wrote:
> > On Wed, Sep 09, 2026 at 09:32:50PM +0000, Caleb James DeLisle wrote:
> > > The EcoNet EN751221 multi-chip module implementation of the MT7530
> > > requires some additional configuration of the PHYs on startup.
> > > The reason for this is not known, but it is possible that it has
> > > to do with the fact that the EN751221 MCM implementation of the
> > > MT7530 runs at an abnormal PLL frequency (362.5Mhz).
> > > 
> > > Detect whether the MT7530 PHY is attached to the MDIO bus of an
> > > EcoNet EN751221 switch and if so, apply the necessary register
> > > updates.
> > > 
> > > Co-developed-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
> > > Signed-off-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
> > > Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> > > ---
> > >   drivers/net/phy/mediatek/mtk-ge.c | 61 +++++++++++++++++++++++++++++++
> > >   1 file changed, 61 insertions(+)
> > > 
> > > diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
> > > index 73d9b72f9d9e..42b06c40d703 100644
> > > --- a/drivers/net/phy/mediatek/mtk-ge.c
> > > +++ b/drivers/net/phy/mediatek/mtk-ge.c
> > > [...]
> > >   static int mt7530_phy_config_init(struct phy_device *phydev)
> > >   {
> > > +	int ret;
> > > +
> > > +	if (mt7530_phy_is_en751221_companion(phydev)) {
> > Please introduce a `.match_phy_device` operation for both, actual
> > MT7530 and EN751221, similar eg. to `ksz8051_match_phy_device` in
> > micrel.c.
> 
> Sounds good, since this will certainly collide with
> https://lore.kernel.org/netdev/20260827065930.2618729-2-cjd@cjdns.fr/ would
> you prefer them in the same patch, or as a patch set? If you'd like I can do
> this and the FE phy as a common patch set. Let me know what you prefer.

I'd do it one driver at a time, starting with mtk-ge.c, already adding
the .match_phy_device logic so it would also avoid binding the MT7530
driver to an ECONET_FEPHY.

The econet-fe-soc.c driver is much larger and may require more rounds
to make all bots and humans happy, so I'd not have the independently
useful mtk-ge.c changes depend on that.

Dumping the PHY register space and comparing it with MT7530 could also
help to indentify any better way than relying on the parent DT
compatible which *is* a bit of a stretch (but could well be
unavoidable, of course).
