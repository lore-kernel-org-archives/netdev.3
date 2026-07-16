Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD2040D58E
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784200951; cv=pass; b=cSBtORte2KJV4aEs27OeVyOVUVTCPodsTgOCUIuloSDGT/o0vzJ/4SYJQhqEDq764QzyXG9E38x+mD9GLz/EhMg/DT2i/7zYqm4/GiVJh7hpnwCo+I3XmMAyek0ZSCdt+yvQ0r1Lpr1a+KVo7QIYB3+PNU7ebG/eJRs2VwLfz3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784200951; c=relaxed/simple;
	bh=Q+FYPDlZgwpe6Fj3BPFnuCMsv6bqlOcAxIFYFoAEwbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjIN6/4e9y/Ml40MrKJoy1mQtgqSV5GLRnOeHGiyYdZCuApJ+DFttzbWoQcCHEvTnbFNzsOtN6tYfNCdx4EEJrx89U7BSw3knRKorXUaQHV06AzgrGTIO03HbqDbJkZW9BORxWKGFTNwrlrsw3YO00JfJTwTPBH6gRBILE63/QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6PVVJ4o; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6PVVJ4o"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c5382806fso25142591cf.2
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 04:22:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784200948; cv=none;
        d=google.com; s=arc-20260327;
        b=audHfEkGAZcfkQGGVwJZU7s1kTX2eSFcB7KH3liJXw5epgrZLs/8mq2az2LSCuzqFH
         Y+r6nHjbTM0vgfTMJZkXhcZhSzrk0U9bm7v9B9XAv4I6xbN26yqi+o7pMYkUNMeXadvX
         t+oh9iOqLuQ86lhdkj9s5vWT2E3xEM8Q3Whr13J77CI6uMFBXetru6/ExIYI5dh9wMay
         nGChmvkA961Tfkm/2uNIMDcpHgbG2IFfo/im6vFi3dVsCgA42WKlMsfSgjWKjht8PVkQ
         MEoBVsaQjnrRH8Z5fM5pfGvlOMIc/sA5dBoKj3F/kjBXlQYCUZzVgON96EGcuMKAX4Lw
         SmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0KAWeywyeRjt2KPsAcPZ9n3jE+Llz50s64Jvh7IEU24=;
        fh=urv/pz6bt+BMahSrX1HrZABFfnMLrtiWnWpJVr/WJ7Y=;
        b=g/pVrzbkoCHFMXY4Tx++9x4bnvmkLqxRtk1K/+43kFRbsFTe0yJA8Viw5ZeO5R2Xha
         CeeQayPmUDFxYzXCVecyh7zp5SadXNdOp0iSZ3V7W5yoAX/oxdF11CNXSsl1/kgccw4e
         AKffbBLIyYRYLykhjAfbKXhtb8PXG2QZ0ZeSEq0pyispWdVq1Z4o67AqP2CSTAlExJwv
         I8M+pX7DNbe0lHuTGxcfT8mF78A80j6Ii/zdIDoxf7wd8WCWKoB+S1AcCiUfiPlOL/ke
         /RZVigMF9+RgYtn/d/viHYI5vAwqb7AHMppbRfg2JjdUEl+uh6gqVbJQ4xMyAWtr/cjF
         gH+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784200948; x=1784805748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0KAWeywyeRjt2KPsAcPZ9n3jE+Llz50s64Jvh7IEU24=;
        b=a6PVVJ4okGw4NWodv+zK+pa96hrQtolWetof3SjIgG0aro05RUZbV64MdxyehBbaRD
         +I2ddehMwY0a/HyMflSAJPLOTKDrUWByZWIV9dk/OtALbGWnBUa2ypDtjLJrrEQLsili
         UGDz8uYv+rjkTF7VqGubWpM6MnaURdIZzHsHQ05D1uYQ/UfW39CyZ6yD4BidWdBaVQns
         qoIo3Mgtl09PMHP3ObC9HbUNHJjKF4XqFEx7LTC0Ec9ZlbwsJ/cQHUayiBEsMLrle9VT
         HHCh4JgEeBo+wjAK9Wwzo2bQS+gAsqREaOZa7uqa+qlfJoAQllYPNe9GlU9V7++99GV1
         qU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784200948; x=1784805748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0KAWeywyeRjt2KPsAcPZ9n3jE+Llz50s64Jvh7IEU24=;
        b=LpA4jbv9yFzp1onEwK7y2eXHIyUBGW+3k86cB2zDKKZR7fYqlG2a+zGfU5k3FxzPOA
         ZwJl71aerYywef+ErejYbnrEzzBLP4GVnxDlQWTtoIWoxhk3jUX4Twdp66UT6doVyXB6
         cxMSlDUnZWpm3V+v/MLE0qR66D7DvkeQvCD2hdFOR8/n2KODaN6KvDsUIgQULN4UmI65
         Fx+Ir3+ZRROfKNMQPEzTx9CPqTA9bmiIHT7qidFe8LW6LEl0mjfqbsgdW12mY9j6o5EW
         Sg/Kj9RzO9mGLIaWohj1PeCKPw/Wf6aIQwb3SWvMzpi2ngzhE4zuTufLK56rvzH97OTZ
         4XGg==
X-Gm-Message-State: AOJu0YwSknJBJcrrMrajhP8NiQd3AMTymqYoiav358HA2ZGTyE3v7B1E
	NzIpt53+Id/oh5PD4lWBDKJro9Jq5bP0y334i7qYD6EPqKc5LWp7ST/IQ29FjYlO8wysvNPe2CH
	MgkQUlPFgZATA5GzKVUhKwxeO2tfD6jxu1GEK2toedFQkdl0lUhGt0lEqf9Q=
X-Gm-Gg: AfdE7clUfLumTNbTvwyp87b9ms5eDTSijwTo0ChlZ5B06MhHiZ3zAH6Z8URT3RNCyyo
	8087cm6Qu9odh7CZ8YParpPi4VvLLeG1VykjGgOjmSlnfIalM6OOIAYigxeL+dGkInmhmp08KqN
	oWHB3hS9zHN5HyuqrT5Qm2vDylQyz/znKm3T8v7ttkQRE5f0SyfZ46tiaq5B8563a69P0BWVyQW
	lgR9sZ9czSBANuiHsocd3p0gp04kvR9IZAnXcmdBQ1IxNT5hMD9zTkiZbo8woVkYjRcTYgM7cTb
	C484fBp6m9p8G9vaUMveRCv0Lmd7vcmts++dnmNCCWzkV44CrrlN0gipCtZGuIGbuHupKH/xXOl
	n
X-Received: by 2002:a05:622a:ce:b0:51c:22c5:daf5 with SMTP id
 d75a77b69052e-51cbf1b4ae3mr225826241cf.38.1784200947347; Thu, 16 Jul 2026
 04:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOAwikA60AYKdFr_UDLyja3oU4hqyAE7uFZWqum5uRdaQsgRYg@mail.gmail.com>
 <CANn89iLizNO3MZ4jEfkMkLOhrJUzLW=xDocOHR_mUgb+5BycJw@mail.gmail.com>
 <CANn89iK8JzQ9cUf+81yCTqo+AXeJFiKZ1B4xBu34Njaih5+viw@mail.gmail.com> <CAOAwikBYp7AAxFAZgyLaOZEG6Eoomq3aqU9ViMS8nrO82PD2rw@mail.gmail.com>
In-Reply-To: <CAOAwikBYp7AAxFAZgyLaOZEG6Eoomq3aqU9ViMS8nrO82PD2rw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Jul 2026 13:22:16 +0200
X-Gm-Features: AUfX_mzG6kLItyOMfbn03Lop1cOnHvk-lh69unLZGIRNlN57q4I_HlDCYtZL8vw
Message-ID: <CANn89iJ+M_r-c3iGK1o7_pLBTVF-s5_R-8MjL3=Q0Aj=1a4deQ@mail.gmail.com>
Subject: Re: ipv4: icmp: icmp_route_lookup() relookups pick wrong netdev with
 policy routing + strict rp_filter
To: Muhammad Ziad <muhzi100@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 12:40=E2=80=AFPM Muhammad Ziad <muhzi100@gmail.com>=
 wrote:
>
> Thank you for the fix, Eric. Applying the other selectors from skb_in
> makes sense to me, but I'm not sure if instead we should copy them
> from fl4_dec?
>
> The mark param e.g. is gated by IP4_REPLY_MARK() on fwmark_reflect,
> which could be different from skb_in->mark.
>

Yes, sashiko had some remarks.

I have been playing with:

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 23e921d313b36b00d8ae5e14846527220c9db32b..b0eb4f8ff9867499dc3a96c92a4=
14440b2d3a115
100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -548,10 +548,12 @@ static struct rtable *icmp_route_lookup(struct
net *net, struct flowi4 *fl4,
                if (IS_ERR(rt2))
                        err =3D PTR_ERR(rt2);
        } else {
-               struct flowi4 fl4_2 =3D {};
+               struct flowi4 fl4_2 =3D fl4_dec;
                unsigned long orefdst;

                fl4_2.daddr =3D fl4_dec.saddr;
+               fl4_2.saddr =3D fl4_dec.daddr;
+               fl4_2.flowi4_oif =3D l3mdev_master_ifindex(route_lookup_dev=
);
                rt2 =3D ip_route_output_key(net, &fl4_2);
                if (IS_ERR(rt2)) {
                        err =3D PTR_ERR(rt2);


>
> On Thu, Jul 16, 2026 at 3:51=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Jul 15, 2026 at 5:43=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Jul 15, 2026 at 5:30=E2=80=AFPM Muhammad Ziad <muhzi100@gmail=
.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > There appears to be a bug in mainline Linux in ICMP reverse-path
> > > > relookup logic inside icmp_route_lookup() (called by __icmp_send())
> > > > when strict rp_filter setting is in place.
> > > >
> > > > When Linux forwards a packet between two interfaces and needs to
> > > > generate an ICMP error, icmp_route_lookup() performs a "secondary"
> > > > reverse-path lookup to find a suitable route back towards the origi=
nal
> > > > source via ip_route_input(). To simulate the reverse path, the kern=
el
> > > > derives the incoming netdev by calling ip_route_output_key() with a
> > > > decoy flow that has *only* daddr assigned in it:
> > > >
> > > >     struct flowi4 fl4_2 =3D {};
> > > >     fl4_2.daddr =3D fl4_dec.saddr;
> > > >     rt2 =3D ip_route_output_key(net, &fl4_2); /* no saddr */
> > > >     ...
> > > >     ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
> > > >                     dscp, rt2->dst.dev);
> > > >
> > > > This can lead to a mismatch between rt2->dst.dev and the netdev the
> > > > real reverse packet would use once routing policy rules are in
> > > > effect. With strict rp_filter, passing the wrong netdev to
> > > > ip_route_input() causes the relookup to fail and a "martian source"
> > > > message to be logged, after which icmp_route_lookup() falls back to
> > > > the earlier output route lookup (relookup_failed).
> > > >
> > > > In such a scenario, I would expect the relookup to use a canonical
> > > > netdev and the kernel to not produce spurious "martian source" log
> > > > messages as a result. This suggests the decoy flow would possibly
> > > > need to carry saddr too so that ip_route_output_key() is able to
> > > > resolve the right netdev.
> > > >
> > > > I tested this on: Ubuntu kernel 6.17.0-35-generic.
> > > >
> > > > Here is a reproducer script that sets up two net namespaces: a
> > > > "forwarder" with two routes to the same dst in separate routing tab=
les
> > > > picked according to saddr, and a "sender" netns behind it which sen=
ds
> > > > a ping with ttl=3D1 via the forwarder forcing it to generate an ICM=
P
> > > > error as a response which leads to the result explained above:
> > > >
> > > >     #!/bin/bash
> > > >
> > > >     if [ "${forwarder_ns:-}" !=3D "1" ]; then
> > > >     exec env forwarder_ns=3D1 unshare -Urn bash "$0" "$@"
> > > >     fi
> > > >
> > > >     SRC=3D10.0.1.2
> > > >     DST=3D198.51.100.5
> > > >
> > > >     # Current netns is the "forwarder".
> > > >     # Create a second namespace for the sender.
> > > >     unshare -n sleep 120 &
> > > >     cpid=3D$!
> > > >     trap 'kill "$cpid" 2>/dev/null || true' EXIT
> > > >     in_ns() { nsenter -t "$cpid" -n "$@"; }
> > > >
> > > >     # veth r0(router) <-> s0(src)
> > > >     ip link add s0 type veth peer name r0
> > > >     ip link set s0 netns "$cpid"
> > > >     ip link set lo up
> > > >     ip link set r0 up
> > > >     ip addr add 10.0.1.1/24 dev r0
> > > >     ip link add dumA type dummy
> > > >     ip addr add 203.0.113.1/24 dev dumA
> > > >     ip link set dumA up
> > > >     ip link add dumB type dummy
> > > >     ip addr add 192.0.2.1/24 dev dumB
> > > >     ip link set dumB up
> > > >
> > > >     sysctl -q -w net.ipv4.ip_forward=3D1
> > > >     for c in all default r0 dumA dumB; do
> > > >     sysctl -q -w "net.ipv4.conf.$c.rp_filter=3D1"
> > > >     sysctl -q -w "net.ipv4.conf.$c.log_martians=3D1"
> > > >     done
> > > >
> > > >     # Destination reachable two ways.
> > > >     # Policy rule diverts traffic FROM src to dumB
> > > >     ip route add 198.51.100.0/24 dev dumA
> > > >     ip route add 198.51.100.0/24 dev dumB table 100
> > > >     ip rule add from "$SRC" lookup 100
> > > >
> > > >     # sender namespace setup.
> > > >     in_ns ip link set lo up
> > > >     in_ns ip link set s0 up
> > > >     in_ns ip addr add 10.0.1.2/24 dev s0
> > > >     in_ns ip route add default via 10.0.1.1
> > > >
> > > >     # This will trigger a "martian source" log.
> > > >     in_ns ping -q -c1 -W2 -t1 "$DST" &>/dev/null
> > > >
> > > >
> > > > Happy to test patches or provide additional traces, if needed.
> > > >
> > > > Thank you,
> > > > Mohamed Ghazy
> > >
> > > Thanks for the report.
> > >
> > > It seems we are lacking more than saddr setting :/
> > >
> > > Could you test
> > >
> > > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > > index 23e921d313b36b00d8ae5e14846527220c9db32b..6277e1bf85f304678ff16=
7e8fd2b9239f155ce42
> > > 100644
> > > --- a/net/ipv4/icmp.c
> > > +++ b/net/ipv4/icmp.c
> > > @@ -548,10 +548,17 @@ static struct rtable *icmp_route_lookup(struct
> > > net *net, struct flowi4 *fl4,
> > >                 if (IS_ERR(rt2))
> > >                         err =3D PTR_ERR(rt2);
> > >         } else {
> > > -               struct flowi4 fl4_2 =3D {};
> > > +               /* TODO: populate
> > > +                       .flowi4_dscp =3D dscp,
> > > +                       .flowi4_mark =3D mark,
> > > +                       .flowi4_uid =3D sock_net_uid(net, NULL),
> > > +               */
> > > +               struct flowi4 fl4_2 =3D {
> > > +                       .daddr =3D fl4_dec.saddr,
> > > +                       .saddr =3D fl4_dec.daddr,
> > > +               };
> > >                 unsigned long orefdst;
> > >
> > > -               fl4_2.daddr =3D fl4_dec.saddr;
> > >                 rt2 =3D ip_route_output_key(net, &fl4_2);
> > >                 if (IS_ERR(rt2)) {
> > >                         err =3D PTR_ERR(rt2);
> >
> > I have tested the following fix, PTAL, thanks.
> >
> > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > index 23e921d313b36b00d8ae5e14846527220c9db32b..2259f643cb0d43ea54819dd=
831c79807413e0d69
> > 100644
> > --- a/net/ipv4/icmp.c
> > +++ b/net/ipv4/icmp.c
> > @@ -548,10 +548,16 @@ static struct rtable *icmp_route_lookup(struct
> > net *net, struct flowi4 *fl4,
> >                 if (IS_ERR(rt2))
> >                         err =3D PTR_ERR(rt2);
> >         } else {
> > -               struct flowi4 fl4_2 =3D {};
> > +               struct flowi4 fl4_2 =3D {
> > +                       .daddr =3D fl4_dec.saddr,
> > +                       .saddr =3D fl4_dec.daddr,
> > +                       .flowi4_dscp =3D dscp,
> > +                       .flowi4_proto =3D IPPROTO_ICMP,
> > +                       .flowi4_mark =3D mark,
> > +                       .flowi4_uid =3D sock_net_uid(net, NULL),
> > +               };
> >                 unsigned long orefdst;
> >
> > -               fl4_2.daddr =3D fl4_dec.saddr;
> >                 rt2 =3D ip_route_output_key(net, &fl4_2);
> >                 if (IS_ERR(rt2)) {
> >                         err =3D PTR_ERR(rt2);
