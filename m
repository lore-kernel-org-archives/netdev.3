Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE54A3AFAE7;
	Mon,  7 Sep 2026 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814156; cv=none; b=YpLMq/pcAbJat2eDB5J4uQIf5Ff/uhQ7LnGXMf1K4fdHlyb206dHLhir951OExty3o9Te58ESVCOqME9s+CX2rdErg0iCHfbLsH6LO7yQUEWP5xvLNeY0vcU8sY1XEPluJMUP+IYI2ZZzTSGtNEy9UvSVbspCeZyBmMW0vv+TpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814156; c=relaxed/simple;
	bh=4h+qmM0WACq2ITmnp607pQge5ogECSR4UrtWkzCyjmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VridhhALxInZar9fPTZOOrySzzU3IKxBNtoCPcYbI9bH2v62UaEt4riCTKOmE85Wx1jqW1FuYbkjjPoWAJInRCJd9gSozb6HKjeA3KspUwelP8ZNG9Ue4Jm/uihTOLQQzXrlu48Yz97I48kBFhoCN5oo23pKV86XADZlOZe+yR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lOBdB6BM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lOBdB6BM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ixgnVD7QubPjJlZnelXYaQ1qrDYJnDYcUNq6P1sl4DU=; b=lO
	BdB6BMfJk/DWrDx2Ml+HnRWtEv2FyxlXh0+9CMzsDzFyFGKVfNRkw+NGoqAZFtgvr0/OdkX19hmkH
	WLcGafhcRyXC4D5QuT6jxqDdbVo06SUQ9P2O4nID0pJbt5yVhp78DXn/EY4iRozS0+dSJeAzdqcr/
	d0FT9b6mjiyprn8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3gGz-003dlr-0r; Mon, 07 Sep 2026 22:49:01 +0200
Date: Mon, 7 Sep 2026 22:49:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: khendry@reliablecontrols.com,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: pcs: rzn1-miic: Verify port number from dtb
Message-ID: <81f2b455-7df7-4aae-8b67-d7cc9a7039d4@lunn.ch>
References: <20260902-rzn1-miic-fix-array-v3-0-3f7dccffaf5a@reliablecontrols.com>
 <20260902-rzn1-miic-fix-array-v3-2-3f7dccffaf5a@reliablecontrols.com>
 <CA+V-a8tOLKxFEKF+yZ0Asf_KYb=_hrFuJagkdzHPxZ_zf3MNRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+V-a8tOLKxFEKF+yZ0Asf_KYb=_hrFuJagkdzHPxZ_zf3MNRw@mail.gmail.com>

On Mon, Sep 07, 2026 at 08:39:27PM +0100, Lad, Prabhakar wrote:
> Hi Kyle,
> 
> Thank you for the patch.
> 
> On Wed, Sep 2, 2026 at 7:55 PM Kyle Hendry via B4 Relay
> <devnull+khendry.reliablecontrols.com@kernel.org> wrote:
> >
> > From: Kyle Hendry <khendry@reliablecontrols.com>
> >
> > Add check to make sure port number is in range before writing
> > to dt_val array
> >
> > Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
> > ---
> >  drivers/net/pcs/pcs-rzn1-miic.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
> > index c50b65d064fa..3ee40eb9d545 100644
> > --- a/drivers/net/pcs/pcs-rzn1-miic.c
> > +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> > @@ -692,6 +692,12 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
> >                 if (of_property_read_u32(conv, "reg", &port))
> >                         continue;
> >
> > +               if (port < miic->of_data->miic_port_start || port > miic->of_data->miic_port_max) {
> > +                       dev_err(miic->dev, "Port number out of range: %d\n", port);
> > +                       kfree(dt_val);
> > +                       return -EINVAL;
> > +               }
> > +
> Query to maintainers, what policy should be followed? Since the
> dtbinding check complains if the port is out of range should the code
> also check it?

Yes, the kernel should check it. Running the checker is
optional. Crashing the kernel because of an invalid DT blob is not
something you want to allow.

	  Andrew
