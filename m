Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377558;
	b=ubhLdecWhFH4hwf8kz7Gr/IE5PESq+FKklcHlV0W8U6PmFMECZC761jPPe1gp9BUnQlx
	 +UUazzVgV2/nEWxKpWoF/r/XvwifvxOfuYLCbVPKbGJ5ea/r6kbuquwAw9jRkH1ExlDDm
	 HLfbwnkVFQDcaXpbNxBpe67/WhTrclYjYL1F7ADlyF7Q+l1mxsiAiSxk4A9tH88Pyp8Cs
	 X3om6pulkEDbBW5Y6jc3KmLDV82K5V7985OuALHHvhnQpPxPLpYs0z99uFx/q2HB+nL3+
	 AH+Hp2eig+vP2KDb4AaNqeltF1A5Tx7VoLXrALi/nIfCW2/ROe6S7OeDNfSiIlid3RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377558;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Debian-User;
	bh=SrUZ38ePJApaZU4hoq5eNn9g57aKohpG6k5NTQ4aDfc=;
	b=Ac8touHuy/YB3MPWtEbF7l3fxOsKYWJeICXynvMs/ANYPfJTifp94tPdXQBi5ijKP/fx
	 3QIL2D1rbNHA/pxMQUxlvf3/OkUNomTwdc2UjNNGiJTdDfGKJq/rs4chze4RUy0BKAgsi
	 dmI5qkBF7r1TczX2dn4f1gWBUQ71lIzinKpJWI//ofrWMaCnYRuu0CiFyl5TPU2q5Wf64
	 m/6WVaYK43gaBPs020inw1fFga1E8p1GYmmS62KAb6dFY6jLx6B+eG7ovloKOQAso5Yr5
	 Nu5GW67kHsdSuJMNOaZMiIEYbX4dfitdQWK/NdGM5oXsIfZCoM4y5cR3wDJFLJ7QzzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=XMEbPqNh;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83169606A31C;
	Fri, 30 Oct 2026 16:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83169606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=XMEbPqNh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=SrUZ38ePJApaZU4hoq5eNn9g57aKohpG6k5NTQ4aDfc=; b=XMEbPqNhTfg407uIlVFC5re7LV
	eaMgc8aelmzljGcTc1/Zz4fcCw+Opf3OiNmXuMlBkSNQ4JaLxoqvg/52lywl++RDwbjdK+CMj3Z9Z
	STdy0hbaW7hHU8TRW25Nm5CgeQJT6JDcDEcVbcLUpag4kBwLF779ZUDwOIfkkk1y+ruEZMfBl+/MV
	lQD26Joue4/fWBC3DWtT/PMU2gQLBETyaymSoGPIOnlmsqHC27xtTsLccUXuxFc3/o69SYQK8ZbLg
	X7ZI8V5hZKH5VApjeU/39CO52dKqW47wSAb1x2JpCMO60PrMcEMTYK5BX+3kImM1xwcxoV5bNHs4z
	3189/WbA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xMpQJ-003wqP-1o;
	Fri, 30 Oct 2026 16:25:48 +0000
Date: Fri, 30 Oct 2026 09:25:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 3/3] netconsole: recheck device registration after
 waiting for carrier
Message-ID: <auTEc5tS4-YZ3tYf@gmail.com>
References: <20261021-netcons-fixes-v4-0-3857120c6340@gmail.com>
 <20261021-netcons-fixes-v4-3-3857120c6340@gmail.com>
 <auBrysA0RUkVlTOA@gmail.com>
 <CAGSyskX4mJJT=VTrS43pWG4UyoJur3hxQ56Qe9MMRL5-c2nnXA@mail.gmail.com>
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
In-Reply-To: <CAGSyskX4mJJT=VTrS43pWG4UyoJur3hxQ56Qe9MMRL5-c2nnXA@mail.gmail.com>
X-Debian-User: leitao

On Thu, Oct 29, 2026 at 09:10:48PM +0000, Gustavo Luiz Duarte wrote:
> On Tue, Oct 27, 2026 at 9:19 AM Breno Leitao <leitao@debian.org> wrote:
> >
> > On Wed, Oct 21, 2026 at 03:19:07PM +0100, Gustavo Luiz Duarte wrote:
> > > netcons_netpoll_setup() drops RTNL while it waits for carrier when the
> > > device is not yet up. If the device is unregistered in that window, the
> > > NETDEV_UNREGISTER notifier runs before np->dev is set and has nothing
> > > to match.
> > >
> > > We might then end up setting up netpoll on a device that is being
> > > unregistered while holding a reference to it, stalling
> > > unregister_netdevice() in netdev_wait_allrefs_any().
> > >
> > > Add a check to confirm the device is still registered once we retake
> > > RTNL. Release the device reference and return -ENODEV otherwise.
> > >
> > > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-netcons-fixes-v3-1-1aac85ed7665@gmail.com
> > > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> > > ---
> > >  drivers/net/netconsole.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > > index be7eb632ee42..bd36ebd334aa 100644
> > > --- a/drivers/net/netconsole.c
> > > +++ b/drivers/net/netconsole.c
> > > @@ -534,6 +534,16 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
> > >               rtnl_unlock();
> > >               netcons_wait_carrier(np, ndev);
> > >               rtnl_lock();
> > > +
> > > +             /* Check that ndev hasn't been unregistered when we released
> > > +              * the RTNL above.
> > > +              */
> > > +             if (ndev->reg_state != NETREG_REGISTERED) {
> > > +                     np_err(np, "%s was unregistered while waiting for carrier, aborting\n",
> > > +                            netcons_egress_dev(np, buf, sizeof(buf)));
> > > +                     err = -ENODEV;
> > > +                     goto put;
> > > +             }
> > >       }
> >
> > I think there is a better way to do it, inside netcons_wait_carrier().
> >
> > netcons_wait_carrier() loops waiting for the carrier, and exit if in
> > time_after(). I think it will be cleaner to exit there.
> 
> Yes, I think it makes sense to bail out of netcons_wait_carrier() if
> we detect that the device is being unregistered. It doesn't replace
> the check under RTNL, though, since the device can still be
> unregistered after the loop exits and before we retake RTNL.

Agree, but we probably don't need to print inside RTNL?

> > then netcons_wait_carrier() would return a bool, and you goto 'put' in
> > both case (ndev->reg_state != NETREG_REGISTERED) or in the
> > time_after() exit.
> 
> Do we really need to check the return value of netcons_wait_carrier()?
> If it detected that the device is being unregistered, then
> (ndev->reg_state != NETREG_REGISTERED) will still be true here, since
> reg_state never goes back to NETREG_REGISTERED, no?
> 
> Or do you mean to fail netcons_netpoll_setup() not only when the
> device is being unregistered but also when the carrier times out? That
> would be a considerable behavior change, because then a slow link
> would fail netconsole completely instead of only losing the messages
> sent before the link comes up.
> 
> I'll keep this patch as the fix for the missed NETDEV_UNREGISTER and
> add a separate patch to bail out of netcons_wait_carrier() early.

Cool, thanks, bonus point for not printing (np_err) inside the lock. :-)


