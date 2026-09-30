Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9647E4E2F05
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778286; cv=none; b=dGMuC167y457C/ftZ6SVLlz/aN9D7qMVV/nBhADUaFOlRLMq0Ri6mGDLyw9u2gQLn6+hluhTpXHih+9AqNkLWlnc+N/F8M/+8gjcxuQ0quYf6CZjHCrBAAOBY83s66W4DT4hkl3usHJV4GsrkkeELnyPAUvuunSp5WsSCZpgXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778286; c=relaxed/simple;
	bh=Mj/HAe620sTBBS9VbfY21Om4vxRjayR5ElGpzBAzsTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzZRl3POqouflr+9sqWVRSqhu3U6t5dOeEJpUHP5I1UPEAZpniu99YLoAFkhmdpMCMRFajGjB6imoY2A9MYCuGUAXVrxPqe65eTgHe8NrvRUSqA0upk2ujStoZ9GS42hWnx8ysRqmZOvzQdQUANtPdtO/RbYLLtBF7z/vUhJIeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vka8YpBJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vka8YpBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACB91F0089B
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790778273;
	bh=NHAnP3G1nRnDaWyy9fYdEFL1izoF1oTFi/w1QTvF7+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Vka8YpBJFYXw0o0npbLMeeqr8l0V6e4sSU1nb6bhimBAKNQdDmo18SNB7O3xOfZOq
	 OkWPwH5TJeGc8xCqfhSR5CYDu8u45Q1M1nCVa2GxH8kqPl0lgrVOW9Du+Q75h8EZys
	 cYhwF/Ky54068OpJsihhBxGIZVGYm53rX++k1HTlJxVCvkeCeC1uM0uF1l0yLgmaCe
	 cdhUlckX8yoCAxjW2gbhe1/C7id9Lg7IqdrglBeNSJ5hGVNPMlNGGMPiud4il4rGWP
	 nw3zep4sO+adespeu2c36ZT48iRCVE8Tv9/o+LAonv57fcZMsraFW7eL9Afwcf0pj9
	 tLIKF6dfrbFHQ==
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-81be5042c56so2802644a34.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:24:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzFL8WkxKpbcBd4j/uwW2tGSaBskFPteb6X5DHuo91wLz/xLz5f4SCeKjQMxaiqkLdYfMYPGh0=@vger.kernel.org
X-Gm-Message-State: AFuF++mgwT/WgoTk4leFXiPXL9FI4WuSBst/6pQ2pdb465D0DMhT8inN
	nu0RD/nDzIN5TadM/AmrsGopybjgimS2grx0yme/DMVl1fMS6vkiY4LKA3nAM1BQM3G8XDWrCq4
	dnQMfeXfRizwn+O76kPd/kgoBtyUNp3c=
X-Received: by 2002:a05:6808:23c2:b0:4b9:e5fa:8a1f with SMTP id
 5614622812f47-4f1b688941fmr1530807b6e.36.1790778272437; Wed, 30 Sep 2026
 07:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929131247.401104-1-edumazet@kernel.org> <20260929131247.401104-3-edumazet@kernel.org>
 <a6f0e657-8674-4216-a1aa-88045c19643b@kernel.org> <CANn89iJ3KgVOYKD-dT0M=ZOpCJzuOcrG8BWvSKrX0eO1VN7Tpw@mail.gmail.com>
 <16cb8491-c7d9-422a-b3cc-c0225f12b7ba@kernel.org>
In-Reply-To: <16cb8491-c7d9-422a-b3cc-c0225f12b7ba@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 30 Sep 2026 16:24:20 +0200
X-Gmail-Original-Message-ID: <CAL4Wiiohuv5QjapmbaVo288kXjN3jZL9fJaha+Xs2kdWxz43Ng@mail.gmail.com>
X-Gm-Features: AclHuK9l8Hi_DaJHQk9G7oM8tRrNfbY54mt86CqGG0xZyvcbTn3snxVbF8hmLes
Message-ID: <CAL4Wiiohuv5QjapmbaVo288kXjN3jZL9fJaha+Xs2kdWxz43Ng@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ipv4: reserve one IP ID per segment for UDP GSO packets
To: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 3:50=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 9/30/26 7:58 AM, Eric Dumazet wrote:
> > On Wed, Sep 30, 2026 at 2:29=E2=80=AFPM David Ahern <dsahern@kernel.org=
> wrote:
> >>
> >> On 9/29/26 8:12 AM, Eric Dumazet wrote:
> >>> @@ -1464,7 +1465,19 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
> >>>       iph->ttl =3D ttl;
> >>>       iph->protocol =3D sk->sk_protocol;
> >>>       ip_copy_addrs(iph, fl4);
> >>> -     ip_select_ident(net, skb, sk);
> >>> +
> >>> +     /* UDP GSO packets are segmented later (see udp_send_skb()):
> >>> +      * reserve one IP ID per segment.
> >>> +      */
> >>> +     segs =3D 1;
> >>> +     if (cork->gso_size) {
> >>> +             int datalen =3D skb->len - skb_transport_offset(skb) -
> >>> +                           sizeof(struct udphdr);
> >>
> >> hard coding a specific transport header in L3 code is crossing layers.
> >>
> >
> > Only UDP sets cork->gso_size, so this is UDP specific code in
> > __ip_make_skb(), like the existing sk_is_tcp() case in the same
> > function.
>
> I went looking for other transport references in L3 code and missed this
> one.
>
> >
> > I can make this explicit in v2 with:
> >
> > if (cork->gso_size && sk_is_udp(sk)) {
> >
> > Selecting the IP ID from udp_send_skb() instead would either burn
> > one extra IP ID per packet (50 % more for 2-segment GSO packets,
> > making wraparound faster), or require __ip_make_skb() to leave
> > iph->id unset for UDP GSO packets, with a simlar kayer violation concer=
n.
> >
> > Would this be acceptable, or do you have another suggestion?
>
> sure. I went down the path of adding an input arg to __ip_make_skb, but
> this is simpler.

Great, thanks, I will send V2 shortly.

pw-bot: cr
