Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39734331A57
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198455; cv=pass; b=UKnFrW8XWJMQuV4DowDK30V7ZHcj/YTND8+QZeO8uOsT2e7AESfKv/ThPIK6W66nNpT4yuv5eaf28gySj4odAPOWRgE6KLf2koPZaq0hDb1qVrQVjrVYFOBTXlz9kbRWENS0zqp21C4LGtZ48Np+KyMdV4W6iQPbKX7tYEl4seU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198455; c=relaxed/simple;
	bh=fE/eBu/GERDY4cVxS3h7WSngibJ//2PsTSSbA1iSQCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3mlhiBTdaaR9FddcOl6HQgxZCez26E/fGrL7l7T5wms5NbSK+nEoTmacbmkhNuQ2O5IdpD3d52Fgp9/uLBSTPzABiUHxFUcICs8DAAX+eq+RO11zo9FLTJjxycrbLFmizKnx/Pz/3KrD7LJQNkE+WrpcQO5zNB3nSXueovHxig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHofZ4LB; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHofZ4LB"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15c1f1be0bso82979066b.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 03:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784198452; cv=none;
        d=google.com; s=arc-20260327;
        b=f0ntvUSwoeMMnIQhRE65n2Bi5Mx9o0Gvwx7aaXjNEMgYbhwvVG55YM3qHRmM8QGOPN
         LnpV19M9Mii3ePJRa7NFYUm9RKSDxBm4kwfCGufOp3r7M3qMB7d4WbYdB5kMGzvy/3fq
         27QEwoCsVkip5l8vSWi7JrvLSq3dCrM/s1wLmVGF8mYuxZ9Ub7W5+rS6XHJKKKbYtAk/
         0b2MNBcdJ7m+63EbfQu8XTOpYJ0sJYwg0zKHCM+bGrFvBLCsnlwdov9eNeZgpWwVlF49
         p8O/g6d8hPy6B2FWdSYrjOoKg4FOyogUMyRy3R6LF/QXIr+HGb6W9dOHdR89pn1g5aNG
         rv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3xyuKuLZPDb1kewdGiu8DMKfmy6sX4V6i46I2loA08g=;
        fh=MhzmHF+05TQ3DvoScPn02/uTgxU6Rg62DLgLgqxCb3Y=;
        b=ct1tF0win6oeAN+ZRDJ9B5FXkaS6WoEbG0LPLkvXvffRXL6Goe5nwzciavK+ZERO1h
         3ZBrKNJthqbAfQpEDRgxtvxRCvPzcMjLtKrp7fzkgPxFhzFC49jR0AEzGTXOtRdgwtat
         8kYLOIWkCYiqGVwXA+2CqvkSJXNi8dWTbqV2RUg4HDrVgR1mbEhcdzA9eiuLjE9d7Cj7
         00/rWUgWLPiNg9a4Nor26D6yBaUSIOcYMJ52Z6ySvp6dZbYZbZCBCmXOLYvEa9OhXtbJ
         9eMSxsohLH2e/AyRNetht2SNqLKeiKVL5fuH9ryhN7tCcVa3nMaNiEsuUVnwaOjKKonO
         UxCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784198452; x=1784803252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3xyuKuLZPDb1kewdGiu8DMKfmy6sX4V6i46I2loA08g=;
        b=NHofZ4LBWsdjAGiROIZOaYhtkL5WJ1nXCErZFO0wTGKaHluX+/GWo9mfZ/R/X/CAQT
         zHjyW8M8KvxPMC/guo6/OVo9qfUHWWO+uJlhJWarDd9ezuTgt/sPV1DaMueocPxdyyXA
         XbpRSIF8qrgiOYPv2jfMLBoRjBBADtyiAmWbgRwC/nENLXYXxh8YInU7qubSR5mvCGol
         +/wf5dqh29llxwQF3UoaEMO5kl4Vq4IZ/Bb+fkzfeQ9LyYXh7sktRyi63ExLnzEwpSaT
         AVi3crEi8Clnt9OPvR9ycHMAcfScHFmr2smAquGG5bSL2OljEIijM8S7PMXiLVJWWxIo
         H7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198452; x=1784803252;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3xyuKuLZPDb1kewdGiu8DMKfmy6sX4V6i46I2loA08g=;
        b=cBc0DEZwf9j7oq9Y4EuYVYXJHrlQjYQ6VHYZlvtL8Al28aodXrrZ1RNsEzQ8WFbG5J
         kudGMXm10ll+BvuFyDWvgP+ldy2XIt/g8QUbwNvlr6BQBSx40xf1yXgU7C/NzZeZDQ5o
         B6JZFmdglfdj1fDJUVGMK7hG7xgDvP5iqdja4kg+DAxNIAZxwDm+QIgRlTtKvliGwqz2
         O1L49GgHBkkiulDflWe+jgLOJK1I7vzEFpFoqHsd+3Fi79+5hDSn0mxUOCo1d6Ah5pGd
         X7wv/YM+jQmn1OosIm0LHCqsO32bX8OlqdJu1jMDhjlg/9W1JCx2q66OIdA7V5T5ebfG
         vnQg==
X-Gm-Message-State: AOJu0YzThBv3ywQB6+arLVr9q8YcvuRxFbf4po5LXGeGyfIxP0muIA0P
	rOGTQyRwqFPl77WI4hNEypK2gest+wR0tnirbbJTd6ghnubMRluaHc9cR5jvrQujMbR/b93hd74
	u+mSaLsMRU6TKc1UofcV9DGkDp8o9Zh8=
X-Gm-Gg: AfdE7clz7LoFuOJCgfE522fA1BBypeklrgOFiFLCoIrq7k8r1Z3a+R4BNdTzXILL3s+
	S87XuELZUuGRgcxbFGq85/du9pdJF5CFDP/A2XmT1LknmKsVH57/9k93E9XZ+Tb3EZlBtvvFBQC
	pKI7HGQ7F/vZ+gs5xjdHWwrDO4KQA8AXdj1iJi9YfWLY5h3C8X9uU+pjmnlauBDbjnR2I+I07Al
	bh3PgHH+/COUKvQcauWeRRDS5ERyUJXcNnuYTmE91USK1Cjr1vIJ6rSHLKTIH6Yw5FUcQ8=
X-Received: by 2002:a17:906:f587:b0:bed:5a4f:9fdb with SMTP id
 a640c23a62f3a-c161ea8ece8mr633528366b.7.1784198452191; Thu, 16 Jul 2026
 03:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOAwikA60AYKdFr_UDLyja3oU4hqyAE7uFZWqum5uRdaQsgRYg@mail.gmail.com>
 <CANn89iLizNO3MZ4jEfkMkLOhrJUzLW=xDocOHR_mUgb+5BycJw@mail.gmail.com> <CANn89iK8JzQ9cUf+81yCTqo+AXeJFiKZ1B4xBu34Njaih5+viw@mail.gmail.com>
In-Reply-To: <CANn89iK8JzQ9cUf+81yCTqo+AXeJFiKZ1B4xBu34Njaih5+viw@mail.gmail.com>
From: Muhammad Ziad <muhzi100@gmail.com>
Date: Thu, 16 Jul 2026 12:40:50 +0200
X-Gm-Features: AUfX_mzHhXFDFJ9kKYqAhpD8bRuvtvjLefGvfo_gDSm0gX-vBmL9uB76qpkPjcI
Message-ID: <CAOAwikBYp7AAxFAZgyLaOZEG6Eoomq3aqU9ViMS8nrO82PD2rw@mail.gmail.com>
Subject: Re: ipv4: icmp: icmp_route_lookup() relookups pick wrong netdev with
 policy routing + strict rp_filter
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the fix, Eric. Applying the other selectors from skb_in
makes sense to me, but I'm not sure if instead we should copy them
from fl4_dec?

The mark param e.g. is gated by IP4_REPLY_MARK() on fwmark_reflect,
which could be different from skb_in->mark.


On Thu, Jul 16, 2026 at 3:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jul 15, 2026 at 5:43=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Jul 15, 2026 at 5:30=E2=80=AFPM Muhammad Ziad <muhzi100@gmail.c=
om> wrote:
> > >
> > > Hello,
> > >
> > > There appears to be a bug in mainline Linux in ICMP reverse-path
> > > relookup logic inside icmp_route_lookup() (called by __icmp_send())
> > > when strict rp_filter setting is in place.
> > >
> > > When Linux forwards a packet between two interfaces and needs to
> > > generate an ICMP error, icmp_route_lookup() performs a "secondary"
> > > reverse-path lookup to find a suitable route back towards the origina=
l
> > > source via ip_route_input(). To simulate the reverse path, the kernel
> > > derives the incoming netdev by calling ip_route_output_key() with a
> > > decoy flow that has *only* daddr assigned in it:
> > >
> > >     struct flowi4 fl4_2 =3D {};
> > >     fl4_2.daddr =3D fl4_dec.saddr;
> > >     rt2 =3D ip_route_output_key(net, &fl4_2); /* no saddr */
> > >     ...
> > >     ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
> > >                     dscp, rt2->dst.dev);
> > >
> > > This can lead to a mismatch between rt2->dst.dev and the netdev the
> > > real reverse packet would use once routing policy rules are in
> > > effect. With strict rp_filter, passing the wrong netdev to
> > > ip_route_input() causes the relookup to fail and a "martian source"
> > > message to be logged, after which icmp_route_lookup() falls back to
> > > the earlier output route lookup (relookup_failed).
> > >
> > > In such a scenario, I would expect the relookup to use a canonical
> > > netdev and the kernel to not produce spurious "martian source" log
> > > messages as a result. This suggests the decoy flow would possibly
> > > need to carry saddr too so that ip_route_output_key() is able to
> > > resolve the right netdev.
> > >
> > > I tested this on: Ubuntu kernel 6.17.0-35-generic.
> > >
> > > Here is a reproducer script that sets up two net namespaces: a
> > > "forwarder" with two routes to the same dst in separate routing table=
s
> > > picked according to saddr, and a "sender" netns behind it which sends
> > > a ping with ttl=3D1 via the forwarder forcing it to generate an ICMP
> > > error as a response which leads to the result explained above:
> > >
> > >     #!/bin/bash
> > >
> > >     if [ "${forwarder_ns:-}" !=3D "1" ]; then
> > >     exec env forwarder_ns=3D1 unshare -Urn bash "$0" "$@"
> > >     fi
> > >
> > >     SRC=3D10.0.1.2
> > >     DST=3D198.51.100.5
> > >
> > >     # Current netns is the "forwarder".
> > >     # Create a second namespace for the sender.
> > >     unshare -n sleep 120 &
> > >     cpid=3D$!
> > >     trap 'kill "$cpid" 2>/dev/null || true' EXIT
> > >     in_ns() { nsenter -t "$cpid" -n "$@"; }
> > >
> > >     # veth r0(router) <-> s0(src)
> > >     ip link add s0 type veth peer name r0
> > >     ip link set s0 netns "$cpid"
> > >     ip link set lo up
> > >     ip link set r0 up
> > >     ip addr add 10.0.1.1/24 dev r0
> > >     ip link add dumA type dummy
> > >     ip addr add 203.0.113.1/24 dev dumA
> > >     ip link set dumA up
> > >     ip link add dumB type dummy
> > >     ip addr add 192.0.2.1/24 dev dumB
> > >     ip link set dumB up
> > >
> > >     sysctl -q -w net.ipv4.ip_forward=3D1
> > >     for c in all default r0 dumA dumB; do
> > >     sysctl -q -w "net.ipv4.conf.$c.rp_filter=3D1"
> > >     sysctl -q -w "net.ipv4.conf.$c.log_martians=3D1"
> > >     done
> > >
> > >     # Destination reachable two ways.
> > >     # Policy rule diverts traffic FROM src to dumB
> > >     ip route add 198.51.100.0/24 dev dumA
> > >     ip route add 198.51.100.0/24 dev dumB table 100
> > >     ip rule add from "$SRC" lookup 100
> > >
> > >     # sender namespace setup.
> > >     in_ns ip link set lo up
> > >     in_ns ip link set s0 up
> > >     in_ns ip addr add 10.0.1.2/24 dev s0
> > >     in_ns ip route add default via 10.0.1.1
> > >
> > >     # This will trigger a "martian source" log.
> > >     in_ns ping -q -c1 -W2 -t1 "$DST" &>/dev/null
> > >
> > >
> > > Happy to test patches or provide additional traces, if needed.
> > >
> > > Thank you,
> > > Mohamed Ghazy
> >
> > Thanks for the report.
> >
> > It seems we are lacking more than saddr setting :/
> >
> > Could you test
> >
> > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > index 23e921d313b36b00d8ae5e14846527220c9db32b..6277e1bf85f304678ff167e=
8fd2b9239f155ce42
> > 100644
> > --- a/net/ipv4/icmp.c
> > +++ b/net/ipv4/icmp.c
> > @@ -548,10 +548,17 @@ static struct rtable *icmp_route_lookup(struct
> > net *net, struct flowi4 *fl4,
> >                 if (IS_ERR(rt2))
> >                         err =3D PTR_ERR(rt2);
> >         } else {
> > -               struct flowi4 fl4_2 =3D {};
> > +               /* TODO: populate
> > +                       .flowi4_dscp =3D dscp,
> > +                       .flowi4_mark =3D mark,
> > +                       .flowi4_uid =3D sock_net_uid(net, NULL),
> > +               */
> > +               struct flowi4 fl4_2 =3D {
> > +                       .daddr =3D fl4_dec.saddr,
> > +                       .saddr =3D fl4_dec.daddr,
> > +               };
> >                 unsigned long orefdst;
> >
> > -               fl4_2.daddr =3D fl4_dec.saddr;
> >                 rt2 =3D ip_route_output_key(net, &fl4_2);
> >                 if (IS_ERR(rt2)) {
> >                         err =3D PTR_ERR(rt2);
>
> I have tested the following fix, PTAL, thanks.
>
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 23e921d313b36b00d8ae5e14846527220c9db32b..2259f643cb0d43ea54819dd83=
1c79807413e0d69
> 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -548,10 +548,16 @@ static struct rtable *icmp_route_lookup(struct
> net *net, struct flowi4 *fl4,
>                 if (IS_ERR(rt2))
>                         err =3D PTR_ERR(rt2);
>         } else {
> -               struct flowi4 fl4_2 =3D {};
> +               struct flowi4 fl4_2 =3D {
> +                       .daddr =3D fl4_dec.saddr,
> +                       .saddr =3D fl4_dec.daddr,
> +                       .flowi4_dscp =3D dscp,
> +                       .flowi4_proto =3D IPPROTO_ICMP,
> +                       .flowi4_mark =3D mark,
> +                       .flowi4_uid =3D sock_net_uid(net, NULL),
> +               };
>                 unsigned long orefdst;
>
> -               fl4_2.daddr =3D fl4_dec.saddr;
>                 rt2 =3D ip_route_output_key(net, &fl4_2);
>                 if (IS_ERR(rt2)) {
>                         err =3D PTR_ERR(rt2);
