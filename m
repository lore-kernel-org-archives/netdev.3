Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794153591;
	b=IJAkGV67g90PnJ+a7FvgBFQvl86pUarD0uVW4x70bZDWa0n6f6/qPscAPNc3MAefUuZH
	 k2CjPOxps9LlrVylA5pS7N2oTVDzrqWX3ykQb8jP96ahsNIMJlHgCdgyk2u0W6Sqkb50i
	 JPhkAKUQ5bWjuFHoHwB4QDw8FCfkulGX6IEFNeRoTQ+8b6yavzpZvZgTJyqh3dnKJ3EZq
	 UZ+4tOh3P7o46/BaYFKO7xKuxIrEjMxrS08QYzeKBGJHMGfjhdlNwpcMQSdM/AFxDhwbW
	 rErVRuHRHsQOhh3WMaPSk0SO1ZTnJLAr5PYjonjk5//0P1uT5gVwC0C79w6oho5c+hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153591;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=gmmnE20VOV7unbjlnQvICJNfs/oFQnztiZcF+e1SVDY=;
	b=UxyRaIWSoLCdMu5zaaqVd3cSIHchh1NWsGuXr15J9e/FB/aemRvHLbrUj/yL5uJoJzJJ
	 zk3OPHA0rfki5XzqBlaXNAACpGFEh8qQ0rjq3PupHHD55YnLN+lzTAN94YpveDxXPjDI5
	 12OLGJK8PmtmIPuPHth5TWv/ckgK6KMiQ8s3Ddxaey9U+vYHqc1pNzyW5BWiogFPYrdcG
	 YO2azDJvB3RsJkuePvo5qZVeRoaV79JjwUvgjRs1sd8zX7EY/d0TM1i8hHxagqA8yhk89
	 2Gld/zOZO1kbIZzRCY8wvQYAyGix/hRtrstuRNOovRZGcxsbd7Bn96LZz6qo98ejS8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Wqo5XS+U;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD96606A330;
	Sun,  8 Nov 2026 15:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDD96606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Wqo5XS+U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=gmmnE20VOV7unbjlnQvICJNfs/oFQnztiZcF+e1SVDY=; b=Wq
	o5XS+UjmPeP7zY2/Y63pr6F8evgpBjKhvDki/5HMxXppu+4xmqiDBCmNUOdMXJSiLSofmDrAe6xe6
	uv7xVAaLlvD7phdNyXk4E3hRvbuF39/rA0WjMCbfLGMMDGICCTV1unKzEf+Z7K2CY7v4L5q+C8ckB
	8O0pFO78WNSTu6c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQ5Ie-00F6mM-Mf; Sun, 08 Nov 2026 16:59:20 +0100
Date: Sun, 8 Nov 2026 16:59:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ibm: emac: fix MR0 write in emac_rx_enable()
Message-ID: <d8c2c58e-ebdb-4b43-a372-64edcecb7bf3@lunn.ch>
References: <20261105231417.119930-1-rosenp@gmail.com>
 <59326527-5002-483a-b418-fef18eeab5d4@lunn.ch>
 <CAKxU2N_wqu_HmX59B-M4htLq2HbBpdcd_f2cChn1QayANPUTFw@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N_wqu_HmX59B-M4htLq2HbBpdcd_f2cChn1QayANPUTFw@mail.gmail.com>

On Sat, Nov 07, 2026 at 04:07:04PM -0800, Rosen Penev wrote:
> On Sat, Nov 7, 2026 at 9:35 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Thu, Nov 05, 2026 at 03:14:17PM -0800, Rosen Penev wrote:
> > > When an asynchronous RX disable is still in progress, emac_rx_enable()
> > > waits for MR0[RXI] with
> > >
> > >       while (!(r = in_be32(&p->mr0) & EMAC_MR0_RXI) && n)
> > >
> > > which assigns only the RXI bit to r, as & binds tighter than =. The
> > > following write of r | EMAC_MR0_RXE then clears every other MR0 bit,
> > > including TXE, and TX stays stopped until the watchdog resets the EMAC.
> > >
> > > This path is taken when RX is restarted after an RX descriptor error.
> > >
> > > Tested on a Cisco Meraki MX60.
> > >
> > > Fixes: 1d3bb996481e ("Device tree aware EMAC driver")
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  drivers/net/ethernet/ibm/emac/core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> > > index 640618c0a09e..b676b286e339 100644
> > > --- a/drivers/net/ethernet/ibm/emac/core.c
> > > +++ b/drivers/net/ethernet/ibm/emac/core.c
> > > @@ -249,7 +249,7 @@ static void emac_rx_enable(struct emac_instance *dev)
> > >               if (unlikely(!(r & EMAC_MR0_RXI))) {
> > >                       /* Wait if previous async disable is still in progress */
> > >                       int n = dev->stop_timeout;
> > > -                     while (!(r = in_be32(&p->mr0) & EMAC_MR0_RXI) && n) {
> > > +                     while (!((r = in_be32(&p->mr0)) & EMAC_MR0_RXI) && n) {
> > >                               udelay(1);
> > >                               --n;
> >
> > This sort of code should really make use of iopoll.h
> I agree. Is it appropriate for net?

Yes, that is fine.

     Andrew
