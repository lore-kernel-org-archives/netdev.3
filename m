Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150FF36D51B
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130204; cv=pass; b=HKYkEu9YNDAYgY2vZ3YpBIksTDCReWwcGg0eQ1p+rDIGheMcl20B2rJvC38NlGH2FW35yF/rmXj3b7OeKwrt0Pbk9lCLdswALeGMPYoEqZvjx6YbYJnkcC5Iud0AYIgaclA8m/6QYrZ3e3LyAlvRprjM2HhtAV/KYPj3FXq/eZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130204; c=relaxed/simple;
	bh=aCGYFmqlBmW56LpNUPggYMxop9XqBshbUL7JxMrzlQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2eg+GwDkzh3wy1rXMZaTPYJlwD53gsHt34IKmQQIolg3PIfOEdPq5fL1s0e39ExDnY7C4lDXjW7bvDUxc7u7gTpPdzoh0Wjrkdr6v0pRUP/F64FKSLXLNwP6r0XFSEitv0rA03WylnF+i8RL9sEcEynUcJkwUuzf49Ziv6aOMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=COaXVwU6; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="COaXVwU6"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c2b2c9eccso40861941cf.2
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784130200; cv=none;
        d=google.com; s=arc-20260327;
        b=avFtp3PXVG+l0PrrOWAn3OBVX96w5NdcreyixJAYFdeqqYot1RP/adMkKiUYYP6prf
         GJzXItDKzTNSJVwiqE5k+9Gy4ZZr/Cj1i9uHoACod+2AXKs1JZqgpCeK+PwJ7EqYhqjA
         hq4dpNVMlPaWqwPgpDtJD+wR1cKwloBPtc3ryg/VKunlf4e/3xLjws5h4jGKVZtteepW
         VeLCGyLacxXwhNL18A4uiRqie9owBF4XYK+v+QoWwx/E1q7aklhV75ozcygJPtS2fMzf
         xWrexnq2dT06a0MqbeusfQNwFT3rD/8af7xZuEHH0bpxnwbTbHKcbNU5Lsm40hVZiSDw
         2eiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vpr6XmAto9nuWfu1vR6GvJS2M2easSCC2kv28BCSeIw=;
        fh=urv/pz6bt+BMahSrX1HrZABFfnMLrtiWnWpJVr/WJ7Y=;
        b=SukRbm8pk9Z2tdYi8po7PUVltcH3dcKpj96xo+HcpOreawEG4Eve+Kp+B9RJf9WwYt
         RZm6PqGVVuN49WLqthIIFl/GKL0roGkxVGTK4bI2My28rthmH52/H1Xk6k8WaMUijxhv
         2yHX49h+nETN6X+XSn9aVYWPqbMeZMm+RAVYogPBzXZ5sIDanePR3luW2Yi1+b7lCRV5
         wKsDJavG/i+OvMOlXe/r0Klm29E2gkJ/BdRbI0sJqjo1WeziD85FvtsS/VhakfnD7m7o
         HYc/uGBcuqj6rztoNaFFRoQLEM4a9RoOPnYF2qHDV6T4Xyft3Z4Vg+t+KJ7vQgZXjLR7
         Ymvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784130200; x=1784735000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vpr6XmAto9nuWfu1vR6GvJS2M2easSCC2kv28BCSeIw=;
        b=COaXVwU6GRDIZ017UWoHetRcent7hrp6Fa9GSmq/uEM/lkcktyQWFRJMLKPICI5mec
         XOWttoK/670dG6JyrjsI1MW9e0GglgYVIO4Ljg5o3/kPRAlDqoVHTO7cLwp4/+ArILrL
         rplfj0+SkxRDMXyOy2zDecPv7E3xPxZoCKBWcAM5DVOwh2OWbABbJg3ExoNeDkdQjUyK
         B25yccg9M50Q+kTIUk3m4Xm788TMuZ/zG8FksxuRKgXixqIgj/y5n6Nhj3HOOZMj1y3v
         HSdG8sAMm28AXXSeXeAJwjS78WKy1VV2cIj2d26Jx8d6L1rVUu0Ni3Ae4suxZ5kr5M7Z
         5ayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784130200; x=1784735000;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vpr6XmAto9nuWfu1vR6GvJS2M2easSCC2kv28BCSeIw=;
        b=ilT6c0jKINENSv8b/L/05j5lHGaDt+l5NwwtujfNr368jnYswjJOu0TF9PO21ier3j
         M7jLzPUvlMnrxnbeXc18ByVEnfjx2xWR/CXjd4WNppm5WtJcXoo91eGhKxJ1KlFdyt9q
         eeB8BIYhBkgzpvF1yhaODGgAQBPQwhpLNw8SdUv8B3mQDXxlk39356PNti7+JQjTLa42
         4S/Dj99/6yG90Z6uKf/GLTcXJ1+jPOOn0CwbVx3kXSmLSBFFJiuXt/BPUCORWTdE/QOb
         gc1mZBA34/yhYfj0RBzO3MhROtXOurX3kH7HyGhOOgAUv4a0+JOYzUcFAbppM9agVjnH
         Zthg==
X-Gm-Message-State: AOJu0YyJI1VU8VRdQdcsw3BdYHjKKWfWj8P3MkPZC49JpyHR9i9XkbDD
	Zbc0pu+RECS8yxdCS/FjUsKHYxljVq3i9fKcRfXmUaB+bbFte43KLxKXUKROcatfduSlowiixZT
	AY53jSfEJ1hb/0ijegElLEPP34VcdlAr/gKovtzjy
X-Gm-Gg: AfdE7ckTrXcVXEXPDtb/8r+VTm1GY180tXuNpCPkqITl7kt7Vf37EXaIYyb2UrKQpOz
	Ltzo7WZmYaBlwE0lz5gvrAmQ01JldI66QxhXwoECEW5qEQmG8wqlJ641tk4iq0sarWiAqIoOeEj
	4utcL24GlBNtwYwlDUnzLCK0ysZR1pYGpycJMX7UYXnLlwBKHy11CSP8fprnq27/TGhNewsaOIf
	aMb2fVT/1Qyuh+RqNEakec2yXkn/i8QXcJLukEk2+BsnTpvTSShRX/RrjTE46LYAYsMlbrZESSD
	8FiP9yca6XUNsCVpAJcbJp20y8sa+5LpY+fKaUg+w9xUltSAiM3cMmizVXaUyaCCph9EebFchlI
	DOEiB4cjqNYElo/zYDwUI4g==
X-Received: by 2002:ac8:57d6:0:b0:51c:b6d:740b with SMTP id
 d75a77b69052e-51e423a015cmr65675811cf.34.1784130199093; Wed, 15 Jul 2026
 08:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOAwikA60AYKdFr_UDLyja3oU4hqyAE7uFZWqum5uRdaQsgRYg@mail.gmail.com>
In-Reply-To: <CAOAwikA60AYKdFr_UDLyja3oU4hqyAE7uFZWqum5uRdaQsgRYg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Jul 2026 17:43:07 +0200
X-Gm-Features: AUfX_myGV9-uU0T94UhqrSNy3stAwM0-69hp-weOghuxBbYFxm-gHKvcE_s1Aa4
Message-ID: <CANn89iLizNO3MZ4jEfkMkLOhrJUzLW=xDocOHR_mUgb+5BycJw@mail.gmail.com>
Subject: Re: ipv4: icmp: icmp_route_lookup() relookups pick wrong netdev with
 policy routing + strict rp_filter
To: Muhammad Ziad <muhzi100@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 5:30=E2=80=AFPM Muhammad Ziad <muhzi100@gmail.com> =
wrote:
>
> Hello,
>
> There appears to be a bug in mainline Linux in ICMP reverse-path
> relookup logic inside icmp_route_lookup() (called by __icmp_send())
> when strict rp_filter setting is in place.
>
> When Linux forwards a packet between two interfaces and needs to
> generate an ICMP error, icmp_route_lookup() performs a "secondary"
> reverse-path lookup to find a suitable route back towards the original
> source via ip_route_input(). To simulate the reverse path, the kernel
> derives the incoming netdev by calling ip_route_output_key() with a
> decoy flow that has *only* daddr assigned in it:
>
>     struct flowi4 fl4_2 =3D {};
>     fl4_2.daddr =3D fl4_dec.saddr;
>     rt2 =3D ip_route_output_key(net, &fl4_2); /* no saddr */
>     ...
>     ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
>                     dscp, rt2->dst.dev);
>
> This can lead to a mismatch between rt2->dst.dev and the netdev the
> real reverse packet would use once routing policy rules are in
> effect. With strict rp_filter, passing the wrong netdev to
> ip_route_input() causes the relookup to fail and a "martian source"
> message to be logged, after which icmp_route_lookup() falls back to
> the earlier output route lookup (relookup_failed).
>
> In such a scenario, I would expect the relookup to use a canonical
> netdev and the kernel to not produce spurious "martian source" log
> messages as a result. This suggests the decoy flow would possibly
> need to carry saddr too so that ip_route_output_key() is able to
> resolve the right netdev.
>
> I tested this on: Ubuntu kernel 6.17.0-35-generic.
>
> Here is a reproducer script that sets up two net namespaces: a
> "forwarder" with two routes to the same dst in separate routing tables
> picked according to saddr, and a "sender" netns behind it which sends
> a ping with ttl=3D1 via the forwarder forcing it to generate an ICMP
> error as a response which leads to the result explained above:
>
>     #!/bin/bash
>
>     if [ "${forwarder_ns:-}" !=3D "1" ]; then
>     exec env forwarder_ns=3D1 unshare -Urn bash "$0" "$@"
>     fi
>
>     SRC=3D10.0.1.2
>     DST=3D198.51.100.5
>
>     # Current netns is the "forwarder".
>     # Create a second namespace for the sender.
>     unshare -n sleep 120 &
>     cpid=3D$!
>     trap 'kill "$cpid" 2>/dev/null || true' EXIT
>     in_ns() { nsenter -t "$cpid" -n "$@"; }
>
>     # veth r0(router) <-> s0(src)
>     ip link add s0 type veth peer name r0
>     ip link set s0 netns "$cpid"
>     ip link set lo up
>     ip link set r0 up
>     ip addr add 10.0.1.1/24 dev r0
>     ip link add dumA type dummy
>     ip addr add 203.0.113.1/24 dev dumA
>     ip link set dumA up
>     ip link add dumB type dummy
>     ip addr add 192.0.2.1/24 dev dumB
>     ip link set dumB up
>
>     sysctl -q -w net.ipv4.ip_forward=3D1
>     for c in all default r0 dumA dumB; do
>     sysctl -q -w "net.ipv4.conf.$c.rp_filter=3D1"
>     sysctl -q -w "net.ipv4.conf.$c.log_martians=3D1"
>     done
>
>     # Destination reachable two ways.
>     # Policy rule diverts traffic FROM src to dumB
>     ip route add 198.51.100.0/24 dev dumA
>     ip route add 198.51.100.0/24 dev dumB table 100
>     ip rule add from "$SRC" lookup 100
>
>     # sender namespace setup.
>     in_ns ip link set lo up
>     in_ns ip link set s0 up
>     in_ns ip addr add 10.0.1.2/24 dev s0
>     in_ns ip route add default via 10.0.1.1
>
>     # This will trigger a "martian source" log.
>     in_ns ping -q -c1 -W2 -t1 "$DST" &>/dev/null
>
>
> Happy to test patches or provide additional traces, if needed.
>
> Thank you,
> Mohamed Ghazy

Thanks for the report.

It seems we are lacking more than saddr setting :/

Could you test

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 23e921d313b36b00d8ae5e14846527220c9db32b..6277e1bf85f304678ff167e8fd2=
b9239f155ce42
100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -548,10 +548,17 @@ static struct rtable *icmp_route_lookup(struct
net *net, struct flowi4 *fl4,
                if (IS_ERR(rt2))
                        err =3D PTR_ERR(rt2);
        } else {
-               struct flowi4 fl4_2 =3D {};
+               /* TODO: populate
+                       .flowi4_dscp =3D dscp,
+                       .flowi4_mark =3D mark,
+                       .flowi4_uid =3D sock_net_uid(net, NULL),
+               */
+               struct flowi4 fl4_2 =3D {
+                       .daddr =3D fl4_dec.saddr,
+                       .saddr =3D fl4_dec.daddr,
+               };
                unsigned long orefdst;

-               fl4_2.daddr =3D fl4_dec.saddr;
                rt2 =3D ip_route_output_key(net, &fl4_2);
                if (IS_ERR(rt2)) {
                        err =3D PTR_ERR(rt2);
