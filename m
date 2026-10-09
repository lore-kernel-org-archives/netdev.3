Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0E4E2F38;
	Fri,  9 Oct 2026 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549367; cv=none; b=FDDvJ+K/s7cFZtzjnj3yPIcoTJbFI1XQYG4J2FnaEp2k+AzAlu15KqJBLA01lEpGyiYBoZddAucYecP+I1b92nOVKq38oRDIKfo9Hdm1MMegwbcp9a0KJh2+EJkkFN1btJ4j4qtnLcI+k8EWILDj2osj01XCn5XPCmLjDeeWJPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549367; c=relaxed/simple;
	bh=ZoEgLlQXgjvR976vonkPHE/c0NVcyVT+vCdOuPZBLA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNkXIQ/1OKQeNzmvD5ZrvkXb1WoEiPJXMZglZ7HGSdfZC005APx9U0B1H0TgZa570PuJzMG+dLGaPGlpFJXCeDz1T0zHai2OtK/LrCuCO87owzPn9l1Bp5zE1U3mGTEM32mK0FCAbldnOwsnRxOMdsD2tFEGw9aNI3r36R6dKl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gd7yVdJu; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gd7yVdJu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=OoNr0eJSlC1132OcivsXjvqHboh6Dd/pPa+EV/p82Go=; b=gd7yVdJuWCwG3bKIVeGc8KNrhj
	i9PqNr2ISCUuDeWNMSdNmiFKIwoHgJU4/W3a2Ma+A5CaXrvVkpMfsnxllcMsHS4MlKI3ijX56XLHd
	o9tS2/3qlVMQUphqwwyKpoOgFlg2l0RxH9jbq9B8kpILhXLKFKTh7k8w4rVzRrKZ8pxPcuKG2Y7Tu
	BIgd3B1gpvgbSEx1Z/UCNVfibXZfwIIn5tB4QjVr4aBnwyu1FfmpY2f1jArVEGNyn/fgwXerR/QHJ
	Xcmq6nb9eM/AzvKjgHgIMdSQiCtceM4aGRsGc9w0APVtWEfDl0hUkvSdXNhPA44WOqAC2amr5uDcU
	+rkzcQ0w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xF9pF-000XDD-2o;
	Fri, 09 Oct 2026 12:35:51 +0000
Date: Fri, 9 Oct 2026 05:35:45 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <netdev-bot+sashiko@kernel.org>
Subject: Re: [PATCH net-next 1/2] netconsole: avoid printing partially
 updated target attributes
Message-ID: <asjfY79OetvGy4an@gmail.com>
References: <20261006-netcons-fixes-next-v1-0-231cd26f8c51@gmail.com>
 <20261006-netcons-fixes-next-v1-1-231cd26f8c51@gmail.com>
 <afc14b81-32b3-4f91-8b0c-0152889f80f6@kernel.org>
 <CAGSyskUE2CM_i_+o2Dtf+_OriRyad+UzG4S-rzOeTL18LnZheQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGSyskUE2CM_i_+o2Dtf+_OriRyad+UzG4S-rzOeTL18LnZheQ@mail.gmail.com>
X-Debian-User: leitao

On Thu, Oct 08, 2026 at 08:55:40PM +0100, Gustavo Luiz Duarte wrote:
> Hi Eric, thanks for the review!
> 
> On Tue, Oct 6, 2026 at 9:35 PM Eric Dumazet <edumazet@kernel.org> wrote:
> >
> >
> >
> > On 10/6/26 20:58, Gustavo Luiz Duarte wrote:
> > > The configfs store callbacks all serialize on dynamic_netconsole_mutex
> > > but not on the read side, so reading an attribute while it is being
> > > written returns a partially updated value.
> > >
> > > Hold dynamic_netconsole_mutex on *_show() callbacks to avoid racing with
> > > writers.
> > >
> > > The dev_name_show() callback can also race with
> > > netconsole_netdev_event() writing to np.dev_name due to
> > > NETDEV_CHANGENAME. So it needs to hold RTNL in addition to
> > > dynamic_netconsole_mutex.
> > >
> > > Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> > > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com
> > > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-netcons-fixes-v1-0-bb5ffe5e698a%40gmail.com
> > > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> > > ---
> > >   drivers/net/netconsole.c | 62 +++++++++++++++++++++++++++++++++++++++---------
> > >   1 file changed, 51 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > > index 267254f046de..188beacb308d 100644
> > > --- a/drivers/net/netconsole.c
> > > +++ b/drivers/net/netconsole.c
> > > @@ -859,7 +859,19 @@ static ssize_t release_show(struct config_item *item, char *buf)
> > >
> > >   static ssize_t dev_name_show(struct config_item *item, char *buf)
> > >   {
> > > -     return sysfs_emit(buf, "%s\n", to_target(item)->np.dev_name);
> > > +     struct netconsole_target *nt = to_target(item);
> > > +     int ret;
> > > +
> > > +     dynamic_netconsole_mutex_lock();
> > > +     /* Hold RTNL to prevent racing against netconsole_netdev_event()
> > > +      * changing np.dev_name.
> > > +      */
> > > +     rtnl_lock();
> > > +     ret = sysfs_emit(buf, "%s\n", nt->np.dev_name);
> > > +     rtnl_unlock();
> > > +     dynamic_netconsole_mutex_unlock();
> > > +
> > > +     return ret;
> > >   }
> >
> > Please do not add rtnl_lock() in a _show() sysfs handler unless there is
> > no other way?
> >
> > Something like:
> >
> >      dynamic_netconsole_mutex_lock();
> >      strscpy(name, nt->np.dev_name, sizeof(name));
> >      if (nt->state == STATE_ENABLED) {
> >          struct net_device *dev = nt->np.dev;
> >
> >          if (dev)
> >              netdev_copy_name(dev, name);
> 
> This could lead to a use-after-free if we race with NETDEV_UNREGISTER
> and 'dev' gets freed.

Any chance you can get the lock (either dynamic_netconsole_mutex or
target_list_lock) in netdev notifiers, so, it doens't conflict with this
one?

