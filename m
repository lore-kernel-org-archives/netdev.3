Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE62D7DDB
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784166667; cv=pass; b=LV6DIN9HLkBUQ9lIdm9can7Tlb2J9YZG/xXaBJG6hIyNDO66mitQtz34OuQ9Q+35mIV8utJ+RXvT2AACFaG1UiQ+LOw84F1wWY7VW+xoL0eprYeQZYKM37wqlSvp7JczXIBKpHmb6fx2/El9zaA7tfuixv4hLAfdDkeZj+Sa1CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784166667; c=relaxed/simple;
	bh=nACmHTDY2OLa3FOVi7G6szULZFHAXIYxugSkzxfMz7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkqD5p1r5PG35Q87kBOuE+IO4i/CIXWQ/gB0CwhtYiwtzELLfrDqxyKuDu+GPDpltIUQyXqsuFxLJe7A3WCbhT7jCtcmpqB4nF5EwQ64/kJlK0cw3lev/jGPJA50CXh7tZS3QNADAvlINu77+BAomsg/Xm15HEv+8jNCRYtMfPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J61gaGUI; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J61gaGUI"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ef7b7651ecso950536d6.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 18:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784166665; cv=none;
        d=google.com; s=arc-20260327;
        b=FcC3r12xx+MivaOnpS85gCIHfDVH1fV7uNJfDsA6DAjhZzDLK70Bctwse16D/OeeMk
         6UIy8cx0AQ7HTKjaBzUb+83sXZYEWrK6CQIKHWiFtW8+6KFn08Vgt9Az2O5+1Fwv01Mg
         Ku2Z2RVNrwxqFS6Z9JhWWNweNo4JNqmYooOwhZ60geRCrdApILuOTz9QVvMePSqToZm5
         tmQPb8xmtsZYksjxOnLLD8UFVnvkjewkkhF2g2/4UMIZkP1ggzUUCtxmBMYSYQfTqwfC
         5ov05J1/j2RnMnY+qihJiU2F1aJuxnoVkavflWVZ5OmPOJFRwBLTA+D9vVHeyWSkAxF9
         usiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lqzuLrRqKDfcHYWXSc/XrClq8nB2qDc82jG9fiImsb4=;
        fh=urv/pz6bt+BMahSrX1HrZABFfnMLrtiWnWpJVr/WJ7Y=;
        b=MSDOBNKFLuCXMV/sKmGMMrIG3KcDVaH9f3TXKTu6M0tLrvVs0xpmUBAKsXo7wMLy32
         qQnVL5jK8JkEZ1dRtYh+mQ011rPWf0z2YcS5LVjHUtERWndlPz8T9YWO7WhA2icN3InA
         q89kGhO1ffN5xWLGpKhxEY9Tc9iEBs4lriU2cToR6uRSf38zhd37AoNKVlzuLkDABnM8
         xwYvI0i60LJC74zlWE20FlbBA/PrnVYsPN3yBqnEMtcjxpLE5AD1ZC448WLWv9t+gAUj
         D83RKTTGwWXY0eJn/7vYDQhH+hgXQenuu8WEJBWBX0OXOmJhoLhxzl/34ofQ6BCnT2iq
         Wb+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784166665; x=1784771465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lqzuLrRqKDfcHYWXSc/XrClq8nB2qDc82jG9fiImsb4=;
        b=J61gaGUISyQ0qrjlYCUZjfPgKYfcna3X/lfQMQ+QblxsazOK17detjR6DzAUMAWlpw
         HRb+4NLcwoibKHSLYNcZfx9bXk0b3Fe+4aJdc5jkxTcOLklP6Eba3AWEp591fGqL3h04
         v6UIVgIRHldxrVzwVUf8+7N6jJf/5yHi/DHzK5NlRST3taC7KQHNFm42LaV1HAENLnZY
         nYknVBhySCZZJY1STxhXg2k/YGnYKEzY6Yw8elWRLpGwJKaclyqiFM2CcBQCnEwWt5j2
         oag2mTN3U47AGpfrWBuvadnEOlW/wOQ/xfJrfjolZWuNReytNDAYt09iRxJDoyu9NGXs
         lxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784166665; x=1784771465;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lqzuLrRqKDfcHYWXSc/XrClq8nB2qDc82jG9fiImsb4=;
        b=P4eUVZIwbstTiJ5rPhba2i+T16OX8+u8rT1/HYcq59iQUlxxyQLhnCCm+JRduPEPhu
         Noa5pS6JHylNDkuFInixQydqRrirXn3saIA7pidcAghlxY2IJL3egkLYSm7hDp2XgQ/G
         3+r6SuuMGyRqo8AEb5qB9voc4EAOQhPIzVgnWocw0uRIJ8/yEJ5HnewO1HOu93Q54DA2
         qJbLy1QFUajpnrZ7PtLczB5ZdBfnjtoy6quxi68yUc5LeZ508NPtidv73kDYgKt4Cc9h
         /zvrZAW42XIYmyzpv3q7pD8rsXltE4YLLwZPN359kn5Gwkl26Kh7ro+KT0Lf7iRjn88r
         8mHQ==
X-Gm-Message-State: AOJu0YyAA4cJXGX7hyQfP5IXAzVu0ZkisMGUZNL/If1HyGohj6JfgsVN
	6+vgzohV+D6YIMW5BEreFdBzZiLEcbcYlApP5AKbit3Xh5Xl1yKwzxPSxsNBj2bU58RwnYe7TuP
	VxoGWorrJExxRQh4a51ENX1jp3PqLize59fGfiGgm
X-Gm-Gg: AfdE7cn6+U18PkKrNK3F2YLB7j+19idbSPQNFXRh3Aw1JgN736DuwNno6gXtxTihdyH
	hdna+cp/25DJz6cvgOLZkADb5O1xhVCRVecm6PAImdclOTpaC7bzjz+k51v8v22EsK2FPKUJt0p
	vvjkAugMOjwlbTTQuL0xqcy9ksswK8YbtNEeZWzD2Yhm21gHKJlABqKiQRplBxkU02i39GPxX9k
	ItRQ5QdYNwZ9uldfC9VLAcUySc8XylFAjlyMMkz5Xrzz+VRu6uARMtlDOH3evaa3nZ9qbeuio4A
	ZDbG0Q9xs9lKmjfauYL/BdqTFTBHNz1cn0G6YedxcWFl7MFK9JihgbhaHLYa47jD5+KAMyqzLg=
	=
X-Received: by 2002:a05:6214:226f:b0:903:faf8:a93f with SMTP id
 6a1803df08f44-90768e88bb4mr7299446d6.30.1784166664025; Wed, 15 Jul 2026
 18:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOAwikA60AYKdFr_UDLyja3oU4hqyAE7uFZWqum5uRdaQsgRYg@mail.gmail.com>
 <CANn89iLizNO3MZ4jEfkMkLOhrJUzLW=xDocOHR_mUgb+5BycJw@mail.gmail.com>
In-Reply-To: <CANn89iLizNO3MZ4jEfkMkLOhrJUzLW=xDocOHR_mUgb+5BycJw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Jul 2026 03:50:52 +0200
X-Gm-Features: AUfX_mxQDkJa_Wi8Jg7R--KDsXv2JgL3Hd9mDUXbZOrEF6mHNjw3VbtOKpSVjMw
Message-ID: <CANn89iK8JzQ9cUf+81yCTqo+AXeJFiKZ1B4xBu34Njaih5+viw@mail.gmail.com>
Subject: Re: ipv4: icmp: icmp_route_lookup() relookups pick wrong netdev with
 policy routing + strict rp_filter
To: Muhammad Ziad <muhzi100@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 5:43=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jul 15, 2026 at 5:30=E2=80=AFPM Muhammad Ziad <muhzi100@gmail.com=
> wrote:
> >
> > Hello,
> >
> > There appears to be a bug in mainline Linux in ICMP reverse-path
> > relookup logic inside icmp_route_lookup() (called by __icmp_send())
> > when strict rp_filter setting is in place.
> >
> > When Linux forwards a packet between two interfaces and needs to
> > generate an ICMP error, icmp_route_lookup() performs a "secondary"
> > reverse-path lookup to find a suitable route back towards the original
> > source via ip_route_input(). To simulate the reverse path, the kernel
> > derives the incoming netdev by calling ip_route_output_key() with a
> > decoy flow that has *only* daddr assigned in it:
> >
> >     struct flowi4 fl4_2 =3D {};
> >     fl4_2.daddr =3D fl4_dec.saddr;
> >     rt2 =3D ip_route_output_key(net, &fl4_2); /* no saddr */
> >     ...
> >     ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
> >                     dscp, rt2->dst.dev);
> >
> > This can lead to a mismatch between rt2->dst.dev and the netdev the
> > real reverse packet would use once routing policy rules are in
> > effect. With strict rp_filter, passing the wrong netdev to
> > ip_route_input() causes the relookup to fail and a "martian source"
> > message to be logged, after which icmp_route_lookup() falls back to
> > the earlier output route lookup (relookup_failed).
> >
> > In such a scenario, I would expect the relookup to use a canonical
> > netdev and the kernel to not produce spurious "martian source" log
> > messages as a result. This suggests the decoy flow would possibly
> > need to carry saddr too so that ip_route_output_key() is able to
> > resolve the right netdev.
> >
> > I tested this on: Ubuntu kernel 6.17.0-35-generic.
> >
> > Here is a reproducer script that sets up two net namespaces: a
> > "forwarder" with two routes to the same dst in separate routing tables
> > picked according to saddr, and a "sender" netns behind it which sends
> > a ping with ttl=3D1 via the forwarder forcing it to generate an ICMP
> > error as a response which leads to the result explained above:
> >
> >     #!/bin/bash
> >
> >     if [ "${forwarder_ns:-}" !=3D "1" ]; then
> >     exec env forwarder_ns=3D1 unshare -Urn bash "$0" "$@"
> >     fi
> >
> >     SRC=3D10.0.1.2
> >     DST=3D198.51.100.5
> >
> >     # Current netns is the "forwarder".
> >     # Create a second namespace for the sender.
> >     unshare -n sleep 120 &
> >     cpid=3D$!
> >     trap 'kill "$cpid" 2>/dev/null || true' EXIT
> >     in_ns() { nsenter -t "$cpid" -n "$@"; }
> >
> >     # veth r0(router) <-> s0(src)
> >     ip link add s0 type veth peer name r0
> >     ip link set s0 netns "$cpid"
> >     ip link set lo up
> >     ip link set r0 up
> >     ip addr add 10.0.1.1/24 dev r0
> >     ip link add dumA type dummy
> >     ip addr add 203.0.113.1/24 dev dumA
> >     ip link set dumA up
> >     ip link add dumB type dummy
> >     ip addr add 192.0.2.1/24 dev dumB
> >     ip link set dumB up
> >
> >     sysctl -q -w net.ipv4.ip_forward=3D1
> >     for c in all default r0 dumA dumB; do
> >     sysctl -q -w "net.ipv4.conf.$c.rp_filter=3D1"
> >     sysctl -q -w "net.ipv4.conf.$c.log_martians=3D1"
> >     done
> >
> >     # Destination reachable two ways.
> >     # Policy rule diverts traffic FROM src to dumB
> >     ip route add 198.51.100.0/24 dev dumA
> >     ip route add 198.51.100.0/24 dev dumB table 100
> >     ip rule add from "$SRC" lookup 100
> >
> >     # sender namespace setup.
> >     in_ns ip link set lo up
> >     in_ns ip link set s0 up
> >     in_ns ip addr add 10.0.1.2/24 dev s0
> >     in_ns ip route add default via 10.0.1.1
> >
> >     # This will trigger a "martian source" log.
> >     in_ns ping -q -c1 -W2 -t1 "$DST" &>/dev/null
> >
> >
> > Happy to test patches or provide additional traces, if needed.
> >
> > Thank you,
> > Mohamed Ghazy
>
> Thanks for the report.
>
> It seems we are lacking more than saddr setting :/
>
> Could you test
>
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 23e921d313b36b00d8ae5e14846527220c9db32b..6277e1bf85f304678ff167e8f=
d2b9239f155ce42
> 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -548,10 +548,17 @@ static struct rtable *icmp_route_lookup(struct
> net *net, struct flowi4 *fl4,
>                 if (IS_ERR(rt2))
>                         err =3D PTR_ERR(rt2);
>         } else {
> -               struct flowi4 fl4_2 =3D {};
> +               /* TODO: populate
> +                       .flowi4_dscp =3D dscp,
> +                       .flowi4_mark =3D mark,
> +                       .flowi4_uid =3D sock_net_uid(net, NULL),
> +               */
> +               struct flowi4 fl4_2 =3D {
> +                       .daddr =3D fl4_dec.saddr,
> +                       .saddr =3D fl4_dec.daddr,
> +               };
>                 unsigned long orefdst;
>
> -               fl4_2.daddr =3D fl4_dec.saddr;
>                 rt2 =3D ip_route_output_key(net, &fl4_2);
>                 if (IS_ERR(rt2)) {
>                         err =3D PTR_ERR(rt2);

I have tested the following fix, PTAL, thanks.

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 23e921d313b36b00d8ae5e14846527220c9db32b..2259f643cb0d43ea54819dd831c=
79807413e0d69
100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -548,10 +548,16 @@ static struct rtable *icmp_route_lookup(struct
net *net, struct flowi4 *fl4,
                if (IS_ERR(rt2))
                        err =3D PTR_ERR(rt2);
        } else {
-               struct flowi4 fl4_2 =3D {};
+               struct flowi4 fl4_2 =3D {
+                       .daddr =3D fl4_dec.saddr,
+                       .saddr =3D fl4_dec.daddr,
+                       .flowi4_dscp =3D dscp,
+                       .flowi4_proto =3D IPPROTO_ICMP,
+                       .flowi4_mark =3D mark,
+                       .flowi4_uid =3D sock_net_uid(net, NULL),
+               };
                unsigned long orefdst;

-               fl4_2.daddr =3D fl4_dec.saddr;
                rt2 =3D ip_route_output_key(net, &fl4_2);
                if (IS_ERR(rt2)) {
                        err =3D PTR_ERR(rt2);
