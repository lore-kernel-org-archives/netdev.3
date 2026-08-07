Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F447A0C3;
	Fri,  7 Aug 2026 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108336; cv=none; b=YOBAcEfpRgodt/FWWupdjaLjVqISwFwJAfw/hMeMyLBLMzFOenh+rPk7slon2W8Dhil8+GDkQ+N7l2kNeEGMAsoyVD5pUntwlEfEgkleb1LIua7X1hk1H5xn1VtvPTj9+xKoq/7QajukR3WAxge7/G1oa2kkk0qd5FT6rhLLdcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108336; c=relaxed/simple;
	bh=Sm1ZTlkwxRVVTkIitbmYJS9dm7aSbE94ilVK0AWaVE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nr/9unwJqsCw9sMXpPBXJrWU/zGOsxScUvnCKTzS3rwleAbgaHp1A0qk3UMwNe4IyClWxD8Gi53k3H2QA78Go2lUtNfHTaVvPGfqHWf+Ip36UR48dQT13jD5jVpNZO1LtNDd1oRJac3hcXZKmAopHL8F9MFwd8/CiN7SG8KvzWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=wYK6HgwX; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="wYK6HgwX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=ziu+Fcd6E+lf+L5u/C2gboILzXsqzImH3sl/bESmKEE=; b=wYK6HgwXDu/LqzHg/ss6o4ddB0
	50AnUYFt6QuGRo7na9ETHxqRFhZTi2/O89xxYIPBKFL8Ns4HXFY4UikAZCg1pE2PptnTBnOobJv7X
	/Gf3Uss8lDzVe/dtWzKV16sfp2WHMUPOw/aO43iGWUt5hnexGy98pFqWIAW7G1NPfo7h+8SIe+Q3n
	INGJ959IO4Z4QouL7qAAtI8xyIVveV2rnLmDChsyxaZpiM4RnvOlpc+vFwztsj31BZUQFJbATAype
	lAwjgyCjpV7/SvyrYIUpK3y5wJlgast71sHaNK7RST2xad86xFuaB/SfcZCJwBNLRN0Sp/RjuAB6i
	UJHWmLAg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wsKMb-000S4A-1u;
	Fri, 07 Aug 2026 13:11:53 +0000
Date: Fri, 7 Aug 2026 06:11:49 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] netconsole: use the address family instead
 of the ipv6 flag
Message-ID: <anXZJCDJtt-iTHy4@gmail.com>
References: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
 <20260805-netcons_ipv6-v1-2-170a35b92da1@gmail.com>
 <anSte7-WkTYU4MnC@gmail.com>
 <CAGSyskWn8N-h=r-ePd23Kc19m3aiN5Bm04rYOhYPqV=roj4Y9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGSyskWn8N-h=r-ePd23Kc19m3aiN5Bm04rYOhYPqV=roj4Y9g@mail.gmail.com>
X-Debian-User: leitao

On Fri, Aug 07, 2026 at 01:00:51PM +0100, Gustavo Luiz Duarte wrote:
> On Thu, Aug 6, 2026 at 4:55 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > On Wed, Aug 05, 2026 at 10:33:02PM +0100, Gustavo Luiz Duarte wrote:
> > > Now that we have the address family in inet_addr, use that and remove
> > > nt->ipv6.
> > >
> > > We no longer need netcons_local_ip_unset() to check that all bytes are
> > > zeroes, as that is now denoted by (family == AF_UNSPEC).
> > >
> > > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> > > ---
> > >  drivers/net/netconsole.c | 82 ++++++++++++++----------------------------------
> > >  1 file changed, 23 insertions(+), 59 deletions(-)
> > >
> > > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > > index d615a9256787..070bae7b4fd7 100644
> > > --- a/drivers/net/netconsole.c
> > > +++ b/drivers/net/netconsole.c
> > > @@ -181,7 +181,6 @@ enum target_state {
> > >   *           local_mac       (read-only)
> > >   * @local_ip:        Source IP address of the target (read-write).
> > >   * @remote_ip:       Destination IP address of the target (read-write).
> > > - * @ipv6:    Whether the target addresses are IPv6 (read-write).
> > >   * @local_port:      Source UDP port of the target (read-write).
> > >   * @remote_port: Destination UDP port of the target (read-write).
> > >   * @remote_mac:      Destination ethernet address of the target (read-write).
> > > @@ -213,7 +212,6 @@ struct netconsole_target {
> > >       bool                    release;
> > >       struct netpoll          np;
> > >       struct inet_addr        local_ip, remote_ip;
> > > -     bool                    ipv6;
> > >       u16                     local_port, remote_port;
> > >       u8                      remote_mac[ETH_ALEN];
> > >       /* protected by target_list_lock; +1 gives scnprintf() room for its
> > > @@ -463,23 +461,6 @@ static int netcons_take_ipv4(struct netconsole_target *nt,
> > >       return 0;
> > >  }
> > >
> > > -/*
> > > - * Test whether the caller left nt->local_ip unset, so that
> > > - * netcons_netpoll_setup() should auto-populate it from the egress device.
> > > - *
> > > - * nt->local_ip is a union of __be32 (IPv4) and struct in6_addr (IPv6),
> > > - * so an IPv6 address whose first 4 bytes are zero (e.g. ::1, ::2,
> > > - * IPv4-mapped ::ffff:a.b.c.d) must not be tested via the IPv4 arm —
> > > - * doing so would misclassify a caller-supplied address as unset and
> > > - * silently overwrite it with whatever address the device exposes.
> > > - */
> > > -static bool netcons_local_ip_unset(const struct netconsole_target *nt)
> > > -{
> > > -     if (nt->ipv6)
> > > -             return ipv6_addr_any(&nt->local_ip.in6);
> > > -     return !nt->local_ip.ip;
> > > -}
> > > -
> > >  static int netcons_netpoll_setup(struct netconsole_target *nt)
> > >  {
> > >       struct net *net = current->nsproxy->net_ns;
> > > @@ -525,16 +506,13 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
> > >               rtnl_lock();
> > >       }
> > >
> > > -     if (netcons_local_ip_unset(nt)) {
> > > -             if (!nt->ipv6) {
> > > -                     err = netcons_take_ipv4(nt, ndev);
> > > -                     if (err)
> > > -                             goto put;
> > > -             } else {
> > > +     if (nt->local_ip.family == AF_UNSPEC) {
> > > +             if (nt->remote_ip.family == AF_INET6)
> > >                       err = netcons_take_ipv6(nt, ndev);
> > > -                     if (err)
> > > -                             goto put;
> > > -             }
> > > +             else
> > > +                     err = netcons_take_ipv4(nt, ndev);
> > > +             if (err)
> > > +                     goto put;
> >
> > nice, that is much clearer.
> >
> > >               ip_overwritten = true;
> > >       }
> > >
> > > @@ -716,22 +694,22 @@ static void netconsole_print_banner(struct netconsole_target *nt)
> > >       struct netpoll *np = &nt->np;
> > >
> > >       np_info(np, "local port %d\n", nt->local_port);
> > > -     if (nt->ipv6)
> > > +     if (nt->local_ip.family == AF_INET6)
> > >               np_info(np, "local IPv6 address %pI6c\n", &nt->local_ip.in6);
> > >       else
> > >               np_info(np, "local IPv4 address %pI4\n", &nt->local_ip.ip);
> >
> > Any chance it can be UNSPEC?
> 
> Yes. Since this is a refactoring patch, I didn't want to change behavior here.
> So I kept the original behavior which is print "0.0.0.0".
> 
> I was planning to send a separate patch set to change this:
> a) Print an empty string if unset (AF_UNSPEC).

Please add it to this patchset. 
> b) Allow the user to write an empty string to local_ip or remote_ip to
> denote unset.
> 
> This can be useful in case the user is reconfiguring the target and
> wants to make use of the local_ip automatic discovery logic from
> netconsole.

Cool, this could come later.

> > > @@ -755,7 +733,7 @@ static int netpoll_parse_ip_addr(const char *str, struct inet_addr *addr)
> > >           in6_pton(str, len, (void *)&addr->in6, -1, &end) > 0 &&
> > >           (!end || *end == 0 || *end == '\n')) {
> > >               addr->family = AF_INET6;
> >
> > Why not setting family for for IPV4? In
> >
> >         if (in4_pton(str, len, (void *)addr, -1, &end) > 0 &&
> >             (!end || *end == 0 || *end == '\n'))
> >                 return 0;
> 
> I did that in the previous patch. Here we are just changing the return code
> convention for netpoll_parse_ip_addr(). We no longer need to return the address
> family because it is now baked into inet_address. So instead of returning 0 for
> ipv4, 1 for ipv6, and -1 for failure, we just return -1 for failure and 0 for
> success.

Would it make sense to change it here, together and close to the
detection?
