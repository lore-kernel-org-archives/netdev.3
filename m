Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792762244;
	b=BLgT6EfZ9IwVH1tpNJJmoBcG0ERsmYhFQbspHy2URP6QISn4cJdbcATM2Deb6cfds3hf
	 I/bgd2hIEq0L6ze0qtDVkDkFI6NJ+lm8z2QbsS8aOvBBjxRVjNWuFkvph7JpsPV2BUhpe
	 a/3YrvY64Q970tV9sM+RTZwlTH3aSSlA5OJY6JS1rMMel6iEI3o7g32vOHi0oqeurygRw
	 5QwkZUgon60xCqx1rrQ/cTLJxIeKgLeYfX2C/uSEdKydCGzWYNcYoaAJ1kkfAYS8B7DiG
	 F650QcfpaEXt/8gciCOCzi8v+e2PSaWE6fIAeFqT34KTy35/eecwSzMiZYpmqrL7c0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=EzyUwj4JVUO6rIYPoKDgIaRZk8W7xi8lTeg5fGqGBVQ=;
	b=cYQV5iRge5W/mH80nj1qF7svAUJ9C47KEdz67D6bMSVzeuNsBQkiWhT/Ik1CyOfNm6rM
	 PFli6+epCi5K0F+fgTcRTB1ffBx48Reg/Kv3MnF+sEd2sPQ6y2KF8GVd1i5n7cTtH+PzN
	 BTXcFULqa3cdV7Bnc264EDz30xZ4+0V6OQOtTCjBQdBJbAneU+gaRvdxWXYdF/a649RHz
	 n2QNo+dF3DkLltR2VA37BgLgsJ0dr7M3nYbeXDmgPO2gm/dpqoQDxhciQNhlJ0yOF2t+s
	 JviN9Ne+e0INiA8GAdNDPuG1xIn4tsyM4uRNrbeZlZsl64I50wj02w7dG5ldQGrI2EQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="fs6Y/1ZR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F85606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5F85606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=fs6Y/1ZR
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso598447a91.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 06:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792762243; cv=none;
        d=google.com; s=arc-20260327;
        b=OzY2kcMFaBz56oUxF26rK5hzo80gcotkELbq3fINKRGKuPetJCGUVaIjSrxDeo701T
         YcNf43STZRqpyD/HVmr1aGTpau/4ZE7ipTgaPzWDnhEbykSfsdQbwQaPWDNEYVMoRoey
         uCnZEx8OrP9/jU0x/cMjMC2gu+D/peCfQQ0OGn56ksFbHUHMBe+Rm5dJFliRe4opt2Jj
         RJ1GUl6jIkHWIkwIvlG2zk6TmsYVY7ZFetPLdyTw1VPqprJStjso4D9D2D1N6++uCZmn
         HkMxZzlDIf++qZRITLWAjkl7QsU4UU1ycB6sz+RPeOC4GgGb6NWVlrUXvQL/006JwrgC
         APRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EzyUwj4JVUO6rIYPoKDgIaRZk8W7xi8lTeg5fGqGBVQ=;
        fh=HWSE11/8Tl8bzQtUm1zUaABiO+SGGnAq5YkMhh9kPBE=;
        b=Pu3JRBsXAExCZjrlnLAtsTAzPN0I5UqYXo/hMBLi9eTnFJekTeDxXWA2qmeUQ76nan
         OdrlDay2UjTxUvHTOmCMwNvlDWbROT9hoSXvBD9zYRL2HtGlz+8jKoj0RMWcAtAnFySN
         tzW2u7+wsJtvmq4FNyeiXISMqsXwxPc4OUzkZxhb3v2NO729VHI71KUeMCYg7dwui6Ur
         Y8Y7VeR+3m3gOL8Zu7yDnQJMON0zFESkPmqvbWJJOIwXhJX7QQ47tNfKDxkzmmdQgZOh
         MGlUJ34g6/fR2MLS69Fdx4WFofLHrSZfp9l3eY+x3ttREVa2GkGnbzaGChtxsiDtnpzF
         rlIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792762243; x=1793367043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EzyUwj4JVUO6rIYPoKDgIaRZk8W7xi8lTeg5fGqGBVQ=;
        b=fs6Y/1ZRnc/bW5mPINgu5toojKOWvH2+D0bLnUiuVCaR7JrSN0hq4FJCZqSGq0/mMk
         H+0svpBzSzGnciiCRb8xn+HS3tpNU0eQJZUAqxjqDHor+Z+IupsOv2sqFzPB67N8yFzM
         netOzE5HSuKx4tJni6HSW8RVrumn0ir7oxASo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762243; x=1793367043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EzyUwj4JVUO6rIYPoKDgIaRZk8W7xi8lTeg5fGqGBVQ=;
        b=FBH8KBSImFeEJvf10oSdRstKXO5nNNc8bsQRAMXWeSp3LitxROEUWl3Dwe/7klIWcW
         r4uEpAuxSClVToTtGtszI2q4Byp7xeo/PbUueYPdb8NARLkKdU2LfYQtEmP4Pqcf1zuo
         z34tTzMTtIHsiS4RLFJ3mBsdIYbAMJeb17AqQVBXi/wuTrwFExhzuQ+5Uv/W3sNi/tuQ
         rrCRqWXqTgDYDJkbWDRIyYhAOXNigGH8fEV1G9+RQKzdRQR5rfi9Abr71phtdLn65Y26
         ERumwPSH4DzZz2dA5nPutZG8HySodVDrBA8pFDitwIby5gAwQAgpt42zoCISQCjuB+hq
         e9hQ==
X-Gm-Message-State: AFq9FYJ5ypLVfPBLasGvQrYYBhgC1RqNwx9Vi54hi5vRw0SEFmDuDFMs
	No6ou40xiWsv78lFL3Z4LQDNZ1LJ/rBiBxhsfw2t68JpjVWDsGk+L4lXHsdAnW+c1VeX70q4pIF
	SMx10sPzVajtSoaoIwY4yiWLhXSehtwHn/seY2KQt
X-Gm-Gg: AYBFou2tX5t0g38DNcPG62PCU3gn2fNwUv1xwoSL+qz1kTybMBlm0Fq5MNHCzEKNAgU
	Y2cM/Lmz/gSHkHPexJUnmblfwRw2XVjTg/qBLj/qKRSyjIuoZL46EiI0Xz5cmqXvSXvW9DH1Cqx
	A5tPzdUDjtl9sbXbeBqKebrZxb9Ug3gk4lA1CsZs6MNRqk0/AE8REQEVJc0iI6KdKcSm0g7u2nL
	hS2LQ+o0vFSOBH8OE3/JjsRTWE8xL1n5MrBb63nj7cTZSgvmmENzsodD8JGI8LwnY/Zjv0jux1w
	N8B8ENcYpek9USDjGACWQ2iUUHS9RUhgCL/ZV4bKUYiQj6Rkr+Ztd9G5YO+BcCC0m/v13qLSh1I
	LslzsRyqWpsHzjyMglz3RCHSnmQJ1jzist7SDJRysehwEP369tbb9Htejfw4OyDCagz/7f45n3l
	T8vt7amXhpO6E+rqs=
X-Received: by 2002:a17:90b:5586:b0:3ad:53e2:78c1 with SMTP id
 98e67ed59e1d1-3adce3cabc0mr1925448a91.10.1792762242957; Fri, 23 Oct 2026
 06:30:42 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
 <CAL4Wiiq3h_OoVo9BpBy0pqFe=AeyN25QxsU86h63qEf05uCJRA@mail.gmail.com>
In-Reply-To: <CAL4Wiiq3h_OoVo9BpBy0pqFe=AeyN25QxsU86h63qEf05uCJRA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 09:30:31 -0400
X-Gm-Features: AclHuK-AtjMVPTuxOQIAGGLhH7jsTp8sIy1-bsoXjryMRSrFvhxDPlKmWOEc5gU
Message-ID: <CAM0EoM=T4TNbkj98y=65OZnppkZ=5b7q=Kvk2k7A982pApSZ8g@mail.gmail.com>
Subject: Re: [PATCH net v2 3/6] net/sched: act_mirred: reject redirects
 without a link-layer header
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 9:17=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> Le ven. 23 oct. 2026 =C3=A0 13:59, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
> >
> > The issue:
> > tcf_mirred_to_dev() may redirect a packet that has no link-layer header=
 to
> > a device that expects one.  TUN builds a valid L3 skb with mac_len =3D=
=3D 0;
> > mirred then pushes zero bytes and the IP header is parsed as Ethernet b=
y
> > eth_type_trans().  The same happens after a VLAN POP_ETH or MPLS POP ch=
ain
> > whose producer did not leave a full inner Ethernet header.
> >
> > The Fix:
> > After the existing push/pull adjustment, when the target expects data a=
t
> > the MAC header, require a link-layer header of at least
> > dev->min_header_len bytes and pull it into the linear area.  Drop the
> > packet otherwise.  This mirrors the check bpf_redirect() already perfor=
ms
> > and keeps the legitimate push_eth-then-mirred case working.
> >
> > Conditions to recreate the bug:
> > - create a TUN device with IFF_TUN | IFF_VNET_HDR | IFF_NO_PI;
> > - attach egress mirred redirect to an Ethernet device (for example lo);
> > - write a virtio_net_hdr with hdr_len=3D1 and an 8192-byte payload.
> > The unfixed kernel parses the IP header as Ethernet and can BUG in
> > eth_type_trans() via loopback_xmit.
> >
> > Fixes: 53592b364001 ("net/sched: act_mirred: Implement ingress actions"=
)
> > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/act_mirred.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > index 553342c55cf7..e3e0e4aa70a1 100644
> > --- a/net/sched/act_mirred.c
> > +++ b/net/sched/act_mirred.c
> > @@ -316,6 +316,11 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, =
struct tcf_mirred *m,
> >                 }
> >         }
> >
> > +       if (!expects_nh &&
> > +           (unlikely(skb_network_offset(skb_to_send) < dev->min_header=
_len) ||
> > +            !pskb_may_pull(skb_to_send, dev->min_header_len)))
> > +               goto err_cant_do;
> > +
>
> Oops, sorry this breaks tools/testing/selftests/net/forwarding/tc_mpls_l2=
vpn.sh
>
> My bad, the skb_network_offset() part I suggested in v1 is wrong.
>
> Please remove it:
>
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index b0390b08600c4a709b18f6d92aebe6629081c735..0bd73c5072a90d3e952d0a724=
461adcf0307592e
> 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -317,8 +317,7 @@ static int tcf_mirred_to_dev(struct sk_buff *skb,
> struct tcf_mirred *m,
>         }
>
>         if (!expects_nh &&
> -           (unlikely(skb_network_offset(skb_to_send) < dev->min_header_l=
en) ||
> -            !pskb_may_pull(skb_to_send, dev->min_header_len)))
> +           !pskb_may_pull(skb_to_send, dev->min_header_len))
>                 goto err_cant_do;
>
>         skb_to_send->skb_iif =3D skb->dev->ifindex;
>
> Keep only the pskb_may_pull() which is enough to prevent
> eth_type_trans() from crashing on a short linear part.
>

Grrr.. Eric, you are not allowed to comment after this.
I should include running those tests going forward when appropriate. I
only test tdc and reproducers.

cheers,
jamal
> Thanks!
