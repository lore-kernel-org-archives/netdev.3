Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D47A248F64
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 04:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788495080; cv=pass; b=MJEzHc0U9vpcIJ+C/Brr0MjgFY9RLfB4XU8XxCC23bonQqrrDkEOMJpZZpLDI/xGnPf63NC3aFvcDWzcWXhn/e6OA7BB6/WrNuTHOfmxwT46iXj1u7ll0P7Ke9BCJZ/i+BEd7BIa97MEmhdHrjE144st86tBHwVHQav4QLej3Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788495080; c=relaxed/simple;
	bh=88lNGGQqmJQuvk6lmqGfyRCMMIUuWaRHc5m75KELlew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FryK5vRRuU90FB7+0iMz5qdP5rEwuf2CzCV5mLqYb1BR8ocZ+KPdMdO+oH7isMdOPqLploWj2dHA4vyn4ajFAK1yVh9OLSgat0q4Hr/QM4RMmEq3BhtdGsqOE1eZsEPZbH1fPwWdjJR9YVnxZLnlKy/BUK7aHm5Xuu4Rl4EyvrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfUu6qkC; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfUu6qkC"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a2b4743936so6085361fa.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 21:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788495076; cv=none;
        d=google.com; s=arc-20260327;
        b=T72dbLh4bIChorLrPjOGEFk905SUBRtgzzk45K3aSDzN9lc6fgrSzN7akeUmS13jPz
         SGe0dE2WhpaGygdUJgJtxNOuV9+prsgRtGdrsYo8s5OAzI97tXL/9eIIdYEZdSw2OImJ
         oYOdytbGWGQ858F4hNBLFtiaESPQE5wSgeCBf7DVtNJnReSqQTzUCJxE3T7VsZjZklvY
         +a1BaBudMBQE8KfsIEzkd69G/OIPjCjroQA56XhmWI/uJozgdVr/Aa/Bw4myumAJvzsX
         gbz1hvz8g+OjUR8JiqgQn2rgAinBljaS/I2Of6bWvGDc36pYTmy85M0f0STiGVN9BnJJ
         I1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VXvq9khyin7MWNqGKypIxV8mtE6/GRXW4VTkw95seb4=;
        fh=67K3ZEAkX83eU7PjauRBwmKFRp0fLqEUkYb6RmM8F4Y=;
        b=sWUGHpmJRfcp5Br10+8rE34axGXHP6CIPzW67qdC7P1hD6NbGxmJMbyk1R6iZLl09P
         /JItFLygGNvkz2nHHQQMnYv4XEharzu77R3uY/X9cNEzI+bKJzd3SYwxFBynhNGR2R/0
         bVXBYvbp7Sz0GKtkaakjAAO2VuvGm1W4ymCGps2L44jiN+QpPTmFcaTTE6JbD6OwkUaV
         +fQQlBG7euGfLIrTcqts+bhUQ0W/GsD3Kcl6w6q6nYtdObFYgkEtIXQbWWRnh3Z2yHBH
         poAjJuyqRO90UIROK+H0L/2qxQVJceiARsSHCbhJkD11Sw4SfMjZf1eU5yonncGN53Mm
         Ad7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788495076; x=1789099876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VXvq9khyin7MWNqGKypIxV8mtE6/GRXW4VTkw95seb4=;
        b=CfUu6qkC5GzkQyYA2Xodw8gpHLH39r62ZoOV16qNl4yeyTXnAAqkZsQO51CEe7Ug5f
         Ebk3kfqYW2EJ0Bc47OWjNaDnBEoUn1bxaD4wvy12/wDFZbe8FUhRxQOX3Ju6q3MaH8T7
         yNOtFPbdStBMdpQrjYWHMf7cY8LTAx0i7tMTOKB0MutITjOqdmFSkEOnbD+ZbQJOf3Yr
         L1cU+GYm7REAEghpP14WmKUs5ApNUQqfy30k+cVrArGUZ8GOv16r7ljBqmEv+AskDN/s
         wNF/PNRuog1t7dMjz5hAEwQ0vXXoKTSHPK+bbHCJxb3tmms5TIwxAE98r4SZUjujHrQI
         J14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788495076; x=1789099876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXvq9khyin7MWNqGKypIxV8mtE6/GRXW4VTkw95seb4=;
        b=a4adYuFzbNzS97819OfNTvsbh4GWDw8mX4AP7kUnbnG7A5CxnbtnAlkgBlMa0NDEe5
         ioi8xD/h8VrVm+13Rs4rK/+5kV9VkBAGbFXETPlOYcM2CVvQsa2TzToa1iKDjf9WUeZl
         ZPHrFXdl9y1B03itFp75yFNdCk9ZxGPsGaO3cjf+RenBmaerxd4RNFKnPN2+TnElWp8q
         Ld5atzO3otNbUApK3KCSQaCQGnkV3HAmKRSfkvER8jphuoEfGqac3cXf8Ek0tM+0HklV
         7IgscVqq20AkTUzadj5UVg6LyHpD1TJKOYQXiJMEWFfL7kRrK+VL8oCxKggn6Jy3S7wS
         Q2vg==
X-Forwarded-Encrypted: i=1; AKwUvBxYNyaLlld1eAYsfcd/yL3Hs0CKF1sPFLiy/Gbxn1zjhaAiljbhM45rSf9ydlR74y9qGwZBvyk=@vger.kernel.org
X-Gm-Message-State: AFuF++mHAi2uVpidHxNJzgf5u+NN7F6HsSVXL1EwQoScexQpxUxs3DsP
	/rGib6FI26UqdejMjGOgSMSevnz2Ni2YMMuffUij7dXZ2Cm04p9/TNLiBCTBVEx+M0VFvfHaE32
	PHRPgVv4c2a3pOrC157zxQR/En7hKML0=
X-Gm-Gg: AYBFou2B0aK52sXsmiLL30YuBIZUWffVlQnCtL4f0MMTpuOvWIhzxHcTPKJ34vOSDaD
	z82ddJHPPP/779V6rGFXytmRnduggMbdcKDNWM9swOWWJlLTpM5toaOcifpLJkwukW0ohfUlpQ9
	6hv8dREQQSDou4N8uVvV5yPFtVHluC17Vj84Cfx1dTjRwnJ6lifGHTaihDISrj8f2JmNfAWagdh
	l7EOxgz84M8jj+NT1RNtDXCxTOsbnrQgyNdiH3TUCSiLZBbYPEfuQIk4YJ5nU6HMoqGU3GxBR96
	1HoOTjkn/8x6Y/OCFVLOWh7s05Y8MBc8AK94mzvZ8UAqpnOOQSdbaJ7DPNyF2okiI2wnp017Y/P
	Azueb9BJHvZf3QZ5kyIKuK450VBu30MX87jHOWHV/J10SEjVaZp7bQMgmTkqsdv6Kkd0YFbec
X-Received: by 2002:a05:651c:154e:b0:3a3:7682:499d with SMTP id
 38308e7fff4ca-3a376824d18mr457841fa.18.1788495076168; Thu, 03 Sep 2026
 21:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901083325.3445-1-kerneljasonxing@gmail.com>
 <178847847848.4131868.16090144540850507396@kernel.org> <CAL+tcoDpyG-Hy9mtDnLSGu0nvU_VDqTjs-k51r2+OPwVyHtABA@mail.gmail.com>
In-Reply-To: <CAL+tcoDpyG-Hy9mtDnLSGu0nvU_VDqTjs-k51r2+OPwVyHtABA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 4 Sep 2026 12:10:37 +0800
X-Gm-Features: AcwNN1U7qrdMhO3WzIb2nu4aq_2ku6u5_VJLZoBIdHsafUbQ6kE3CWIZQkgruoA
Message-ID: <CAL+tcoC=w6j+1p8ovjbLxgb1QdL3ipic0nMOvX_9OJrspSQS2Q@mail.gmail.com>
Subject: Re: [PATCH net v2] xsk: set network header on skb at generic transmit
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, aleksander.lobakin@intel.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 11:53=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Sep 4, 2026 at 7:34=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
> >
> > - [Medium] net/xdp/xsk.c: the new skb_reset_network_header(skb) in
> >   xsk_skb_init_misc() (net/xdp/xsk.c:950) anchors the *network* header=
=E2=80=A6
> >
> > --
> >
> > xsk: set network header on skb at generic transmit
> >
> > The XSK generic transmit path never reset the network header, so after
> > skb_reserve(hr) the stored offset was left behind skb->data and
> > skb_network_offset() returned -hr, which tripped the
> > DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason() when th=
e
> > skb reached a tunnel device. This adds skb_reset_network_header() in
> > xsk_skb_init_misc() so the offset is 0.
> >
> > Closes: https://syzkaller.appspot.com/bug?extid=3Df16c1b285c9f63994eec
> > Link: https://lore.kernel.org/all/20260826012052.51028-1-kerneljasonxin=
g@gmail.com/
> >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 33475b180ea6f..2077bb6299ca9 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -947,6 +947,8 @@ static int xsk_skb_init_misc(struct sk_buff *skb,=
 struct xdp_sock *xs,
> > >  {
> > >       int err;
> > >
> > > +     skb_reset_network_header(skb);
> > > +
> >
> > [Severity: Medium]
> > The negative offset does look closed by this: xsk_skb_init_misc() runs
> > after skb_reserve(hr) in xsk_build_skb() and xsk_build_skb_zerocopy(), =
so
> > skb_network_offset() becomes 0. Two parts of the reasoning look off
> > though.
> >
> > First, the commit message says:
> >
> >   "Note this anchors it at the start of the frame (L2 for an ethernet
> >    device), which is the same convention AF_PACKET uses on TX."
> >
> > Is that what AF_PACKET does? packet_parse_headers() anchors the MAC
> > header, not the network header:
> >
> > net/packet/af_packet.c:packet_parse_headers() {
> >         /* On TX skb->data is the L2 header; anchor it for all socket t=
ypes. */
> >         skb_reset_mac_header(skb);
> >
> >         if ((!skb->protocol || skb->protocol =3D=3D htons(ETH_P_ALL)) &=
&
> >             sock->type =3D=3D SOCK_RAW)
> >                 skb->protocol =3D dev_parse_header_protocol(skb);
> >         ...
> > }
>
> I'm going to remove this part.
>
> >
> > and packet_snd() for SOCK_RAW resets network_header before moving
> > skb->data back over the hard header, so network_header stays at the L3
> > boundary:
> >
> >         skb_reset_network_header(skb);
> >         ...
> >         } else if (reserve) {
> >                 skb_reserve(skb, -reserve);
> >
> > So after this patch an AF_XDP skb differs from an AF_PACKET one by
> > hard_header_len in network_header, and mac_header is still at the unset
> > sentinel left by __finalize_skb_around(), i.e. skb_mac_header_was_set()
> > is false.
> >
> > Second, the commit message says AF_PACKET "supports GSO/checksum
> > offload; none of that applies here". Does checksum offload really not
> > apply? xsk_skb_metadata() in the same file does:
> >
> > net/xdp/xsk.c:xsk_skb_metadata() {
> >                 skb->csum_start =3D hr + csum_start;
> >                 skb->csum_offset =3D csum_offset;
> >                 skb->ip_summed =3D CHECKSUM_PARTIAL;
> >
> >                 if (unlikely(pool->tx_sw_csum)) {
> >                         ...
> >                         err =3D skb_checksum_help(skb);
> >         ...
> > }
> >
> > The software fallback only happens when the user opted in via
> > XDP_UMEM_TX_SW_CSUM, so a CHECKSUM_PARTIAL AF_XDP skb does reach the
> > driver through __dev_direct_xmit(), and drivers take the L2/L3 split
> > from network_header:
> >
> > drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_tx_csum() {
> >         vlan_macip_lens =3D skb_checksum_start_offset(skb) -
> >                           skb_network_offset(skb);
> > no_csum:
> >         /* vlan_macip_lens: MACLEN, VLAN tag */
> >         vlan_macip_lens |=3D skb_network_offset(skb) << IXGBE_ADVTXD_MA=
CLEN_SHIFT;
> >         ...
> > }
>
> After digging into the probing logic, I strongly feel that Jakub is
> right to consider whether to add the probing logic.
>
> >
> > With skb_network_offset() now 0 on an ethernet frame, does this program
> > MACLEN =3D=3D 0 and an IPLEN that swallows the ethernet header, so the =
NIC
> > inserts a checksum derived from the wrong header layout?
> >
> > Would it make sense to also call skb_reset_mac_header() and place
> > network_header at the real L3 boundary here? Alternatively, if the
> > minimal reset is the intent, could the commit message describe
>
> The minimal reset doesn't help with the checksum problem mentioned above.
>
> Adding simple logic like resetting l2/l3 headers doesn't guarantee
> that csum problem won't be triggered. Adding complete probing hurts
> perfomance for sure.
>
> Maybe we can cook two patches:
> 1. Fix the current bug syzbot reported as is.
> 2. Fix offload logic by adding complete probing
>
> @Jakub, Maciej, Stan
> Do we need a complex logic like af_packet to handle this?

Until now, it seems we've got three fixes in the queue:
1. reset mac header:
https://lore.kernel.org/all/20260817153957.3177627-1-poros@redhat.com/
(commit 35fcde7f8deb "xsk: support for Tx")
2. reset network header like this patch. (commit 3914d88f7608 "xsk:
Respect device's headroom and tailroom")
3. handle csum offload issue by adding probing code. (commit
48eb03dd2630 "xsk: Add TX ... checksum offload support")

Thanks,
Jason

>
> Thanks,
> Jason
>
> > network_header as a placeholder and drop the claims about the AF_PACKET
> > convention and the absence of checksum offload?
> >
> > --
> > Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20260901083325.3445-1-kerneljasonxing%40gmail.com
