Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283FA2E739C
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773120; cv=pass; b=l4bUAkjFZGAS+ccunVK8CRYaZv4NUMiH+b3si9fbjsS6KHMkQafaqo3eHQ3K6muAsF40pJHvkomYDWltL2Y+TELH9E1Rcv87h46lDJV2A7QqdoiUoislt3Ws1fzy1qTxo2JqUCpVv+smQPj7dQCTFBjmXMtYyvyxkijfcz5AtbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773120; c=relaxed/simple;
	bh=T9mM2MOrl1vYGVqgK2olZmdiNcgVUiSe/7K9bejIraM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LV+/dIkVCzusXXZ7/MviNKBAGHU6gEN8I4A3Jokear/y31H59lB6TKRDBGH7l6ebr42z65fYM2Xu90/SVmHaJkrxlBpyWwIZ7ILOgAawI4yqC/rNcVzghVbnZY17x6ntWdte4SNqB/RIsOvRnQV6u9GN41o2RnXMvcc+yL+Iou0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HNaVsBiU; arc=pass smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNaVsBiU"
Received: by mail-qk2-f39.google.com with SMTP id d75a77b69052e-5332de6f6d4so16094231cf.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 05:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790773109; cv=none;
        d=google.com; s=arc-20260327;
        b=mLkNBkKxoNJg2M68S2uocP9rec/7myb3mdAHu1wOW6B/BhiJFTVn9ze2Y41oiNWLXV
         O2GcwM4uZk12cRfq7LxnljMQd47BXKUEhk56aMM1OuFBioy6IY92rg+U0SvCUdhwvkXP
         n+LwEXxVWBk10SwSbhb3y3d9lPCWqGRkgaiBR5QHWOTE4n7aVivAvOwmBuGwZxuTFwNV
         MnT9hrcFeaizyZQMW+MVEv1uyHMB4PapNXUswP+owpnABpKNJGVbgsb4Wq86RPl++p9C
         eVjwx7NRsWmFBWRnl1gRSAIvhj0SQXeM3ecAVM5MpHtkDjR7NwXVXtqENbZ69APN2Bet
         NJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qPOuFroTrtWpw6MUmzkNEUwgYkUHCYkGSZvYe8PwGd4=;
        fh=oPwbYhRrdgU1KQvaagjda+5NmB8FIf4BKRM1n4QRhMI=;
        b=Iyxzj0ry6jx1u9M+SRfBIyM/Qk9J1HTdYxi1Mzh0Oyp6RSeP6tyZRVh3F7tyOGt5HR
         aMiCsAd+fn+BdsNBg+PsDwEJAJila4JhLkOgx91pjNWgxuLxOvs30TRMGQbKkF8nBuwf
         aODqIfICfI1FK/FcOQhpTX6tfn20l/1m4neRah/H1ZJMP5YVdhW8FJ1ftPVIb4EKe9ml
         xuhyGxa2wbI5lVivscKiNW/RrQRiiWSRuJvHN7cipDKnaAGfLVdWM8cuZdakVfXJPd0p
         cWqXFzd9c9hykRCpgwJHS+3UwKxpH8yaFVTfpMaW0Xhyfpn/LRHpwgcq5nEqDsmhuFkm
         HxkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790773109; x=1791377909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qPOuFroTrtWpw6MUmzkNEUwgYkUHCYkGSZvYe8PwGd4=;
        b=HNaVsBiUKa+G/RJkmY14U/TdFl2anS71RaEHC1+P++wYlN8qI9hcPgEnQB0+Q90FhY
         Ft7962f0qxvMCqpi4/zXYzQm3MPZEy7ooPaY3EZhQbt6ZucNF5p/ZXhkVWDVkRUqFS/5
         7HCF5NjKgQ05IO6nyJ5/v0vY85DISW/BaNDSNC9PjtHua77mVauBcT51qlfpbi1/EmJF
         EO6BwaE+ry5ML9GhV4upf8kg4o2/mylxPOuDrPd1iCs+WARYxTMgCrjGOvjxv531gG5g
         Hp5zPp4Lr4TK8k+8Ib/GpZb33cwdBPoKpj9KdcSUo8A+i2NmDpBavCBW/pLF70d3c8m7
         k+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790773109; x=1791377909;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qPOuFroTrtWpw6MUmzkNEUwgYkUHCYkGSZvYe8PwGd4=;
        b=2e6h+s6XMZEYPXezM9KsXHTBZoZMwU+HLblQminS/2bnzVxxNSg+FVhQrwl/+Pdjvu
         3L6OwYJeDKZ7+cWqItA5GFh6QaemYagdBZUW/5CgUZ7NvBANG3yX2bGQr5WOrjiTkBSP
         5J6rDO4ZQ2ogzkTwLrg/3vbgf70CMkTw+vVs/jIFnqZ+gS6LLl68yLN/jhFLFVTa3K12
         KfIQNnDpOifwYllb0U6YnSiVFKhh9kAlHAiqE5h48nXEay6ioLwuIdwsyrGe3f9JGncB
         AxtsKsCk7WMPgwtQUNRL7HOHiHxFfyndtdWK/0LQvkg+BkMa7gJyS5+UJ4K0EklmEh3R
         lIIA==
X-Forwarded-Encrypted: i=1; AKwUvBzKTlWM+FyglAxTATy9CfiBBfqFa5GSgnqrxoZCZ1tSj64j+td6G85zNv/6+Gk9GX0LSVBEryE=@vger.kernel.org
X-Gm-Message-State: AFuF++msmn6NmHpopZ3hzttf38KwuDZvpvIy1fiiEUTx13yLUxrMbl9P
	pTu/JWaJM7JKNV7bOHexkLvaitAllOP/3FG7xOGKlqyPuJABdAk+AxDQQXyiruzD1II+UIclJsv
	FdE0qWX5BztWG+XpVrTBQVMe7xGJ3Zr1TDneFOneZ
X-Gm-Gg: AYBFou0YNGS6dgEp8y4Ix6htuGlR8tlswRvK+TREnBmdmmC+RDsOKaqtCmyyb/FTgT7
	5xpoQD1p+5CRdfrDBXK5iDmY+IFzpuunJHobiKk1aj2eJ7QzbvpGzaCneFpQ2s3bLi9J5xv0Uim
	m/NX5ao/6HlrTwKnMLH162qhuJXpL0R0Neyt1UzkG8iO4RpizNNgJ3qWPzjgQorwkUdcd96aqGn
	+gen8pDUORwMjf6/okcGoeNNHAdl3kkKgp0KfOpFj6+/4eanSi6TdRuwik9s6ulvST5f9FIvFwf
	TGYLSc0KEyRsB/t2scw6WULjo0p8D0vSQhSnHHgpS9Ok8prE3lADbYLOnAB08LYUxcp5Fd0XDa+
	sDd6tKZ4m94w2PYbm1JImBpGhk7Nrov/d4HyekEAyd24X96hauASB4MVkd6H2japXBJLV
X-Received: by 2002:a05:622a:4d09:b0:530:e5f8:7f5b with SMTP id
 d75a77b69052e-5337453fcf5mr21909201cf.3.1790773104745; Wed, 30 Sep 2026
 05:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929131247.401104-1-edumazet@kernel.org> <20260929131247.401104-3-edumazet@kernel.org>
 <a6f0e657-8674-4216-a1aa-88045c19643b@kernel.org>
In-Reply-To: <a6f0e657-8674-4216-a1aa-88045c19643b@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Sep 2026 14:58:13 +0200
X-Gm-Features: AclHuK8rBuh5PIDERxjyAl2jHeqyFg_MyQD2c05KOkjJVJZ9ucoR6668qTFE_M4
Message-ID: <CANn89iJ3KgVOYKD-dT0M=ZOpCJzuOcrG8BWvSKrX0eO1VN7Tpw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ipv4: reserve one IP ID per segment for UDP GSO packets
To: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:29=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 9/29/26 8:12 AM, Eric Dumazet wrote:
> > @@ -1464,7 +1465,19 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
> >       iph->ttl =3D ttl;
> >       iph->protocol =3D sk->sk_protocol;
> >       ip_copy_addrs(iph, fl4);
> > -     ip_select_ident(net, skb, sk);
> > +
> > +     /* UDP GSO packets are segmented later (see udp_send_skb()):
> > +      * reserve one IP ID per segment.
> > +      */
> > +     segs =3D 1;
> > +     if (cork->gso_size) {
> > +             int datalen =3D skb->len - skb_transport_offset(skb) -
> > +                           sizeof(struct udphdr);
>
> hard coding a specific transport header in L3 code is crossing layers.
>

Only UDP sets cork->gso_size, so this is UDP specific code in
__ip_make_skb(), like the existing sk_is_tcp() case in the same
function.

I can make this explicit in v2 with:

if (cork->gso_size && sk_is_udp(sk)) {

Selecting the IP ID from udp_send_skb() instead would either burn
one extra IP ID per packet (50 % more for 2-segment GSO packets,
making wraparound faster), or require __ip_make_skb() to leave
iph->id unset for UDP GSO packets, with a simlar kayer violation concern.

Would this be acceptable, or do you have another suggestion?
