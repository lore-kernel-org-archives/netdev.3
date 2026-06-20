Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8DC18EFD1;
	Sat, 20 Jun 2026 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781942643; cv=none; b=kPqOT5ytxU5gmm6MYlnzCq77zf9yHAxmWKCsTNNPMI9XTcRELbJtpV+MIL/+OdfEsDlF3MWUvzO4vcXDLqmCQ5oPJ/nRe2v4nvaI69Jky/1qcT0HG0YOYo1UlINinCWQCnIdFWO1XSwofMO9E7/YoThSZ6WZjE5Jc92cIuSWWWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781942643; c=relaxed/simple;
	bh=dse7SYszSg3Jlnq5lHfSFp77L84duHmVVEKC5zjH7kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5FyjmPSUSjAyLTKJZyXQKkepZq5QW9dAmnjYq6AqTf/trmsJ/kuOwPm94vnipfsZbHIAheoDr53PqjYBYr1RGFczy8LGWquw16YoKMR/Y9sJS49NfMZJlqONqZqODhIk5AeXDOaWslJh2IwiWs9FOTSoPjdvSmCUZ441QJzeRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hgBU+SZd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hgBU+SZd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=TpBfbDE6ulH2Pjr37Nyu6gVgrN1MUttbzTfMKK6uXyE=; b=hg
	BU+SZdbTdcICq19hQozITwbVEJtsme39PaW67ARYai6a9YaSqQ+B1cWjK0e1bSKq6SVe47LSYeeh/
	zQX+X0RM6VdrxwdcRNpCxTez9y8dsc7RdAeDLxAHxcL6rYjkIjNjXZKgF0fwlylaR9UeJUjDroOgB
	z7JOAhE0jsv07oM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1waqgC-008Zfb-Ev; Sat, 20 Jun 2026 10:03:52 +0200
Date: Sat, 20 Jun 2026 10:03:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 3/4] net: dsa: motorcomm: Dynamically allocate
 port structures
Message-ID: <fc82aaa6-ff6b-4d17-beb2-e6f156e64059@lunn.ch>
References: <20260618202716.2166450-1-mmyangfl@gmail.com>
 <20260618202716.2166450-4-mmyangfl@gmail.com>
 <f9234e83-e9e1-488d-93f5-1f3c20634c87@lunn.ch>
 <CAAXyoMN9a6nncr-C1UDuUQMf4i5FR-9s-sfhSpYLYs5nmh9Uhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMN9a6nncr-C1UDuUQMf4i5FR-9s-sfhSpYLYs5nmh9Uhg@mail.gmail.com>

On Fri, Jun 19, 2026 at 02:46:24PM +0800, David Yang wrote:
> On Fri, Jun 19, 2026 at 2:06 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Fri, Jun 19, 2026 at 04:26:31AM +0800, David Yang wrote:
> > > With support for LED introduced later, struct yt921x_priv will be 17k
> > > which is not very good for a single kmalloc(). Convert the ports array
> > > to a array of pointers to stop bloating the priv struct.
> > >
> > > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > > ---
> > >  drivers/net/dsa/motorcomm/chip.c | 95 ++++++++++++++++++++++++--------
> > >  drivers/net/dsa/motorcomm/chip.h |  3 +-
> > >  2 files changed, 75 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> > > index 6dee25b6754a..d44f7749de02 100644
> > > --- a/drivers/net/dsa/motorcomm/chip.c
> > > +++ b/drivers/net/dsa/motorcomm/chip.c
> > > @@ -548,11 +548,14 @@ yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
> > >  /* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */
> > >  static int yt921x_read_mib(struct yt921x_priv *priv, int port)
> > >  {
> > > -     struct yt921x_port *pp = &priv->ports[port];
> > > +     struct yt921x_port *pp = priv->ports[port];
> > >       struct device *dev = to_device(priv);
> > >       struct yt921x_mib *mib = &pp->mib;
> > >       int res = 0;
> > >
> > > +     if (!pp)
> > > +             return -ENODEV;
> > > +
> >
> > Are all these tests actually needed? If you cannot allocate the
> > memory, i would expect the probe to fail, so you can never get here.
> >
> >         Andrew
> 
> Dummy ports are no longer assigned control blocks (in yt921x_dsa_setup).

This seems pretty error prone. A missing check will result in an
opps. At least it will be obvious. How big is each port structure? Is
the memory saving worth it?

    Andrew
