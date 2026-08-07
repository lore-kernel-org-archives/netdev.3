Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D928B43CE44
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104097; cv=pass; b=jzy7I4cO2duSxXrTovMfv/dWCxbYsGmCylXijFTqsSNc5Z9umeYx286z/4j+wF9SGClC8uUq69ty/8oGdprja8H9kzal2kqvdr7P3uZEv5Xv31ma/6qU/zvORwY+ARQ9JcG6X7wFzNjQa8CGCWP9cB+j2NdAha4zgI1G4zoctyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104097; c=relaxed/simple;
	bh=LDXV91UKv+qIkR10gBDcM0HADZlVlz91eFPCwdTLcyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxDNZQSgODfNyxeSSZU5OlHXWksqrh2AgA4oOUhX9Rmhzr7Ei7459XRRdI+NDP7lZ5CVZrbgJsbd+fNOHtIEEGElW/naBy4Vj+VbWjW3ZkKz47FJh946hByHL2479qcXqq1XfmAH8Q47gWmUAYgGkUmByxSRJLAb4BSHk1GSFO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oAdGEj0D; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAdGEj0D"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4a453848173so357978b6e.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 05:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786104063; cv=none;
        d=google.com; s=arc-20260327;
        b=O3iXFnRXF7Jx8KfTDxXoNFGxB0EFrI+rKRGpvw5nnmsLMY8S982JNl7LvQR6RwBgrm
         dqVazYjeIT7KKOE4KXlPBeGC3kiKxu34utazOrnPnxWVViYJz5pdsL6VGSEMN4OaStcw
         EV2GSQDPLg4uo8jk8BjJzRDIZ2KciRSe2kPEPI5TD1aipBzubB+czWbFl5oLhtBTQv/A
         uyj1GgBUVSlvHUUh1wbACUICzJWBn2+G8YQUkh5D/5n8WPKBrl5K8lMXzhqwg9FsW6iS
         DSz+zCTlF7XXFSl9rV6/3YMbyR9x+mKI5eT+mlQ0Ht7qHGEXpoUmwnlX564IdvXaQO9G
         86Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E+ZG4Dw9S1oedCUDvLeLIhC8Bfnnx/tq9316jRr2RSg=;
        fh=VTDfmQjUJzPdaLY8RVfsADYuG0Py1oZDQHPItay1XVk=;
        b=P5YPKLJ5wcRYvkACOoc0pn+ANj+0UM5lvrOOBErV/wGreYGM7YtiPD11lT/H7/zy49
         tL9UgImy76SOlipRucDNqVuJ57KJIwGuPLlxp0Oy0nAtQBHrQYSaSvBwsWR3mDoG202s
         /adPwgTeM+YQ++BJednkiUPDv8pC0IqEPp03Yg/3ri9kjdWJH4P9OxwNhoBZIdQBSt4N
         //YLMUaWVkuNhomfKGyhVJvWOINOigcH0Sr5Qb77IssF31TX2Q0sdkCh74xxNd2ByfH8
         eLM4tXJDalzMD7qDDPk3B4jcHD0e94mKYhgtAoueJLYg4B5WJPY+0Q3bRjFWSz3/erUH
         gZZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786104063; x=1786708863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E+ZG4Dw9S1oedCUDvLeLIhC8Bfnnx/tq9316jRr2RSg=;
        b=oAdGEj0DVkfYRKo7Nbb0LiUsUkjwfG3iWHGm+VgHGDMAYbkfjqRIW7b1X3YmW3Wp51
         OoeP/obyqMLKC3phNunMRq8AjcwcUlnBnJu3xe/4I4UA74I9hf27s8O02Gl5KCuVCka0
         wr7DWdiV1H9QA4B6hizKzPf6wBEGej4KPb+xYkdEOGbI4BWjNk7+btXeEcGoC/5lrKBZ
         WbE12qI0/LcRbX++1m8bK2E5fF+YJFB9/ak1uBriOyQho6DqZpHJsLElrM5EzmALZOFB
         O4dE3Q7/Ks885U2g6NttWRiSqbYk0B8X+aNeUyZJoF0WwFJ1GT3k3PATsaIFZIAIvhBM
         +xhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786104063; x=1786708863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E+ZG4Dw9S1oedCUDvLeLIhC8Bfnnx/tq9316jRr2RSg=;
        b=OYH0w9W82z23AYzqN57DxTqKONh2jpeydBkYOjLOAXKHzTvMvHkxhEtYju9AEX1Bg0
         t3TvOwGvF2hKnEX4ndxk5zgOcOlZ8tBdcEiboyF9CvIy3cgXXytvyDl4pwV+9RDnN3eA
         WZU5N7Odd39RNt0Gg2nnhLB+zDnVSqk7rRDXVRgDnYTwmvPWxdz9LbVdU7T0VShTbiOe
         vn70m03NUa86sobpuyMdyi1/SdJPOFm9S6jGMHiIGO2TUxjTpPEXO751/Jgeq1H0iKOF
         4yoMk1vr29JQ+zND9z7DbMoX0IaVPEhCUOnWctNNS1m0k4Vj+rnuPxyW4dimcahvmhpi
         ib2g==
X-Forwarded-Encrypted: i=1; AHgh+RqDNkm2lo7zlfs5Fj/q+v0nP1h4DtNAA6ii2/kOkwXnT72pgJ7JPpJFLPPG4HczpkJb3fdwafg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy++IZyeIP14PaZc06xclFtzgoZZPbSzXYGBNFHLQVF84PWMl4a
	P7BsFRG2x+UCAZCMrtdoAIMhkPUZTp38zRhgGlW+PF2OEqihddRKwCqNCONePv/Wbt932lEhmDk
	2CHzTUqlOfVb3NRp/DWZ5SJGa666bi7Q=
X-Gm-Gg: AR+sD138yNlDgZ4ZJVLwijiOdIDfvQRK55xb3FNzdslfxSs/8cJEJ60mg+wvEi1xwOO
	CQf3r7Rd/5wv2RAQCeoA7ujgdflYonZp/++QZ5Jq8Z+gWNmBlEYeVTXHFxxNYt2pGe65UhWuqiP
	ldatGWvgVtG/ObqkpTbxLC527yecK32c1KRXdTPM1LE5DkVwNKyJGYalaZlyBW300szOJBi2G8+
	Z++RNZvHcLwC5haKgM8BVQ92e8U+3bkY6zuLS0XUIWM2TRz7JFq52MksBna+bCKo+LirtvAdOC8
	kLwHONyevI8VBYWZhn4Q/tZhbGc0s06NVpyYOcFEy2lcIg7osv9JojIwLZN07yf0H/2Mx+8=
X-Received: by 2002:a05:6808:50a7:b0:496:d5:7b22 with SMTP id
 5614622812f47-4afadef5d74mr8159288b6e.1.1786104062548; Fri, 07 Aug 2026
 05:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
 <20260805-netcons_ipv6-v1-2-170a35b92da1@gmail.com> <anSte7-WkTYU4MnC@gmail.com>
In-Reply-To: <anSte7-WkTYU4MnC@gmail.com>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Fri, 7 Aug 2026 13:00:51 +0100
X-Gm-Features: AUfX_myu7mhaknNZ8SfZsF147-ts9iX6fK_Qg1bl8L5m-HkL3ZZmGIm0sXP-n10
Message-ID: <CAGSyskWn8N-h=r-ePd23Kc19m3aiN5Bm04rYOhYPqV=roj4Y9g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] netconsole: use the address family instead
 of the ipv6 flag
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:55=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> On Wed, Aug 05, 2026 at 10:33:02PM +0100, Gustavo Luiz Duarte wrote:
> > Now that we have the address family in inet_addr, use that and remove
> > nt->ipv6.
> >
> > We no longer need netcons_local_ip_unset() to check that all bytes are
> > zeroes, as that is now denoted by (family =3D=3D AF_UNSPEC).
> >
> > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> > ---
> >  drivers/net/netconsole.c | 82 ++++++++++++++--------------------------=
--------
> >  1 file changed, 23 insertions(+), 59 deletions(-)
> >
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index d615a9256787..070bae7b4fd7 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -181,7 +181,6 @@ enum target_state {
> >   *           local_mac       (read-only)
> >   * @local_ip:        Source IP address of the target (read-write).
> >   * @remote_ip:       Destination IP address of the target (read-write)=
.
> > - * @ipv6:    Whether the target addresses are IPv6 (read-write).
> >   * @local_port:      Source UDP port of the target (read-write).
> >   * @remote_port: Destination UDP port of the target (read-write).
> >   * @remote_mac:      Destination ethernet address of the target (read-=
write).
> > @@ -213,7 +212,6 @@ struct netconsole_target {
> >       bool                    release;
> >       struct netpoll          np;
> >       struct inet_addr        local_ip, remote_ip;
> > -     bool                    ipv6;
> >       u16                     local_port, remote_port;
> >       u8                      remote_mac[ETH_ALEN];
> >       /* protected by target_list_lock; +1 gives scnprintf() room for i=
ts
> > @@ -463,23 +461,6 @@ static int netcons_take_ipv4(struct netconsole_tar=
get *nt,
> >       return 0;
> >  }
> >
> > -/*
> > - * Test whether the caller left nt->local_ip unset, so that
> > - * netcons_netpoll_setup() should auto-populate it from the egress dev=
ice.
> > - *
> > - * nt->local_ip is a union of __be32 (IPv4) and struct in6_addr (IPv6)=
,
> > - * so an IPv6 address whose first 4 bytes are zero (e.g. ::1, ::2,
> > - * IPv4-mapped ::ffff:a.b.c.d) must not be tested via the IPv4 arm =E2=
=80=94
> > - * doing so would misclassify a caller-supplied address as unset and
> > - * silently overwrite it with whatever address the device exposes.
> > - */
> > -static bool netcons_local_ip_unset(const struct netconsole_target *nt)
> > -{
> > -     if (nt->ipv6)
> > -             return ipv6_addr_any(&nt->local_ip.in6);
> > -     return !nt->local_ip.ip;
> > -}
> > -
> >  static int netcons_netpoll_setup(struct netconsole_target *nt)
> >  {
> >       struct net *net =3D current->nsproxy->net_ns;
> > @@ -525,16 +506,13 @@ static int netcons_netpoll_setup(struct netconsol=
e_target *nt)
> >               rtnl_lock();
> >       }
> >
> > -     if (netcons_local_ip_unset(nt)) {
> > -             if (!nt->ipv6) {
> > -                     err =3D netcons_take_ipv4(nt, ndev);
> > -                     if (err)
> > -                             goto put;
> > -             } else {
> > +     if (nt->local_ip.family =3D=3D AF_UNSPEC) {
> > +             if (nt->remote_ip.family =3D=3D AF_INET6)
> >                       err =3D netcons_take_ipv6(nt, ndev);
> > -                     if (err)
> > -                             goto put;
> > -             }
> > +             else
> > +                     err =3D netcons_take_ipv4(nt, ndev);
> > +             if (err)
> > +                     goto put;
>
> nice, that is much clearer.
>
> >               ip_overwritten =3D true;
> >       }
> >
> > @@ -716,22 +694,22 @@ static void netconsole_print_banner(struct netcon=
sole_target *nt)
> >       struct netpoll *np =3D &nt->np;
> >
> >       np_info(np, "local port %d\n", nt->local_port);
> > -     if (nt->ipv6)
> > +     if (nt->local_ip.family =3D=3D AF_INET6)
> >               np_info(np, "local IPv6 address %pI6c\n", &nt->local_ip.i=
n6);
> >       else
> >               np_info(np, "local IPv4 address %pI4\n", &nt->local_ip.ip=
);
>
> Any chance it can be UNSPEC?

Yes. Since this is a refactoring patch, I didn't want to change behavior he=
re.
So I kept the original behavior which is print "0.0.0.0".

I was planning to send a separate patch set to change this:
a) Print an empty string if unset (AF_UNSPEC).
b) Allow the user to write an empty string to local_ip or remote_ip to
denote unset.

This can be useful in case the user is reconfiguring the target and
wants to make use of the local_ip automatic discovery logic from
netconsole.

>
> >       np_info(np, "interface name '%s'\n", np->dev_name);
> >       np_info(np, "local ethernet address '%pM'\n", np->dev_mac);
> >       np_info(np, "remote port %d\n", nt->remote_port);
> > -     if (nt->ipv6)
> > +     if (nt->remote_ip.family =3D=3D AF_INET6)
> >               np_info(np, "remote IPv6 address %pI6c\n", &nt->remote_ip=
.in6);
> >       else
>
> Same question
>
> > @@ -755,7 +733,7 @@ static int netpoll_parse_ip_addr(const char *str, s=
truct inet_addr *addr)
> >           in6_pton(str, len, (void *)&addr->in6, -1, &end) > 0 &&
> >           (!end || *end =3D=3D 0 || *end =3D=3D '\n')) {
> >               addr->family =3D AF_INET6;
>
> Why not setting family for for IPV4? In
>
>         if (in4_pton(str, len, (void *)addr, -1, &end) > 0 &&
>             (!end || *end =3D=3D 0 || *end =3D=3D '\n'))
>                 return 0;

I did that in the previous patch. Here we are just changing the return code
convention for netpoll_parse_ip_addr(). We no longer need to return the add=
ress
family because it is now baked into inet_address. So instead of returning 0=
 for
ipv4, 1 for ipv6, and -1 for failure, we just return -1 for failure and 0 f=
or
success.
