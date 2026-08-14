Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07B33D093A;
	Fri, 14 Aug 2026 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713265; cv=none; b=bmyDq6RMUix5h1rsLPxLJj1xW5WMWukosfPnQiTlvMBfRnv6SrQr5ko7wgrQEfChkzOBOGkjwM2dAoU5hfMlhb4S2vRgO92E4JH2R/kzwn/GKvVvyBPcYEmtR924SCB1/nBPfBy1G3um6h0a603uwsIhZ6diV5iHn0hiwc+by3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713265; c=relaxed/simple;
	bh=MCsRnKPK7Xrcy6k2+UWao+EWejDpA+uMzHn8h+OWvWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWz389+bOfmDKuGJhMFR/6UoiV3ZJzrhAIQOWRtaw2G+alj6RMrybFrCV87ejtxtwXTQJJoW1GUo2Dalt6fiycgsNr3gwCe4a9lCq5e+uWlIe0xmc8TbfPEqfSyQwannFU3XS+PywDReU3T5MpRlO2HNtkja+7MCmiamNLFZewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pAJSDYnm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pAJSDYnm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nOehYTPM3XlWF1ndOI06YkQZmp/k5mlTvQLBty13qiM=; b=pAJSDYnmoVJiEdQlnEiyWAdD0U
	3godsa1s8xIedN1064NWQBP5w3YovNePCXkkwUKrGZVyUgpBsig/pAdl22ddJSC93RZr7qT/QLbSy
	ukrKauEIFpacSgmoog92JD/EA5uAquIotGdkj4A1KBrSNNbN4NuDzgLTmmK/bCE+wNEg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wurjg-00HaMb-Nt; Fri, 14 Aug 2026 15:14:12 +0200
Date: Fri, 14 Aug 2026 15:14:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: khendry@reliablecontrols.com,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] net: pcs: rzn1-miic: Fix config array initialization
Message-ID: <c933264e-151f-455e-81ee-6c16a5f11d84@lunn.ch>
References: <20260813-rzn1-miic-fix-array-v1-1-b58cafcc917e@reliablecontrols.com>
 <CAMuHMdWUrabJOWLAiSrSm=r7KbuZn4CrVZiswJsf96U3STaNTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWUrabJOWLAiSrSm=r7KbuZn4CrVZiswJsf96U3STaNTw@mail.gmail.com>

On Fri, Aug 14, 2026 at 10:11:28AM +0200, Geert Uytterhoeven wrote:
> CC Prabhakar
> 
> On Thu, 13 Aug 2026 at 20:09, Kyle Hendry via B4 Relay
> <devnull+khendry.reliablecontrols.com@kernel.org> wrote:
> > From: Kyle Hendry <khendry@reliablecontrols.com>
> >
> > Fix memset parameters to initialize the entire DT value array
> >
> > Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
> 
> Fixes: f39e968dc168a7bd ("net: pcs: rzn1-miic: Move configuration data
> to SoC-specific struct")
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/drivers/net/pcs/pcs-rzn1-miic.c
> > +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> > @@ -683,7 +683,7 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
> >         if (!dt_val)
> >                 return -ENOMEM;
> >
> > -       memset(dt_val, MIIC_MODCTRL_CONF_NONE, sizeof(*dt_val));
> > +       memset(dt_val, MIIC_MODCTRL_CONF_NONE, miic->of_data->conf_conv_count);

Sorry for hijacking your reply, i already deleted the original email.

This is correct, but could maybe be better. dt_val is allocated with.

     kmalloc_objs(*dt_val, miic->of_data->conf_conv_count)

This allocates objects. It just happens your objects are s8, so size
of 1. But the memset() would be "more correct" with:

memset(dt_val, MIIC_MODCTRL_CONF_NONE, sizeof(*dt_val) * miic->of_data->conf_conv_count);

And i checked, there is no memset_objs().

       Andrew
