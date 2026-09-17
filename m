Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123543939A4;
	Thu, 17 Sep 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656872; cv=none; b=rS66Kai/SnYEInZ+mMXKDDubWg2WJbLoljtufxm4qgYbz8n7hAArKK89nRaAxRwvGXdj2okahaWgCSoh7VGxAGynUIkUU06Kt6uDPgbbz7BM1oXZ16oWrAT03VzdTOi6QTiArvvM3W5Slrrc+ox4Dcu7+u0rwkrgJ+eydcxKP10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656872; c=relaxed/simple;
	bh=neXxLjLm07T/5uBNw3MIaIA4Z7Fgm8FkKivipIur184=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWo94n9ulXwkWUVabavbWrNcDnBNoDiVzVntBG/WSz/wihIk2XrqRFBdueiDltCM5zQvTocIr1YyGmb4VlM3p7YjYLdLXHtrLgsV+uAgTSPJKv4iMjtiqxk6j2PSMLQPsHgtPJirCXPBCj0lOBdxhcCQyRyBH304CibhffXqBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dfB2KTNt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dfB2KTNt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=A67JsCta3pDpgt91UwwATGFxcmWXa4GKAYCKCqCfNGM=; b=df
	B2KTNtQm2y1vfPsKWRY3hu6XBsKBZt2AntbCPnuYQvrvYtp8pcgyCGPbYFsiEPWAm67wiW5/Hm9V6
	34HrLVvW+orTF4naFU99gXstv08S+lOzoqWJSaW9K4WnqN4GZw8bEsjtcJSkKBoShPu+6OvQdgf3i
	4jddyEWkkZUzZNs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7DUt-005hAF-QU; Thu, 17 Sep 2026 16:53:59 +0200
Date: Thu, 17 Sep 2026 16:53:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: fec: gate MPC52xx driver on PPC_MPC52xx
Message-ID: <f29b58c2-1d11-42e9-b920-2272d2c21ed4@lunn.ch>
References: <20260916220931.262932-1-rosenp@gmail.com>
 <CAKxU2N-T3urb8Wv3sW1=YaT6AjoicgJ95msTDA8cdsivkiR5vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N-T3urb8Wv3sW1=YaT6AjoicgJ95msTDA8cdsivkiR5vg@mail.gmail.com>

On Wed, Sep 16, 2026 at 03:29:25PM -0700, Rosen Penev wrote:
> On Wed, Sep 16, 2026 at 3:09 PM Rosen Penev <rosenp@gmail.com> wrote:
> >
> > The FEC MPC52xx driver only applies to the MPC52xx family of SoCs,
> > but only depended on PPC_BESTCOMM. Restrict the driver to MPC52xx
> > platforms so it is not offered if COMPILE_TEST is applied to
> > PPC_BESTCOMM. Otherwise the following errors happen during linking:
> >
> > ERROR: modpost: drivers/net/ethernet/freescale/fec_mpc52xx.ko: symbol 'mpc5xxx_fwnode_get_bus_frequency' undefined!
> > ERROR: modpost: drivers/net/ethernet/freescale/fec_mpc52xx_phy.ko: symbol 'mpc5xxx_fwnode_get_bus_frequency' undefined!
> >
> > Assisted-by: LLM
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/freescale/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
> > index b34c0fcfddea..d81984fcec64 100644
> > --- a/drivers/net/ethernet/freescale/Kconfig
> > +++ b/drivers/net/ethernet/freescale/Kconfig
> > @@ -38,7 +38,7 @@ config FEC
> >
> >  config FEC_MPC52xx
> >         tristate "FEC MPC52xx driver"
> > -       depends on PPC_BESTCOMM
> > +       depends on PPC_BESTCOMM && PPC_MPC52xx

> oh this is against local changes. Please ignore.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#updating-patch-status

  pw-bot: changes-requested

  As a result the bot will set the entire series to Changes
  Requested. This may be useful when author discovers a bug in their
  own series and wants to prevent it from getting applied.

    Andrew

---
pw-bot: cr
