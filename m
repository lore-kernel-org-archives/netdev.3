Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D924908B7
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637784; cv=pass; b=cYS+y+jpck5Wb4uVWjfQZDU6v0soa/J4GUj6TBbcRArwvelvYgbl8voQum0S3iHB1v92oM1nNTTcasZ3D7gue95XLSyKxARUMLKTUQ2NsCi55jO7miux6vyZqRTO9Em2MjUSqlNr4plwYcE3gHkA1ODmfmJQitUJ45lXPss9+Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637784; c=relaxed/simple;
	bh=yXT4hLGt7i769MHmM0jT0+BLhbDOMzT/s5tyqBFLnb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqtRNtMxcTqqwC7zHE7YMMefvxowyN/VE18iP/d7nnKjEuKf6PqEvITzTP1DswYaSlcOjgnWsNBCt6VIxtpfOQeyOnbsIsJJiNtxUy76dQUEuw5J2OLMtmoesUm4qMNbRcta25IYY34VDboo6Gdej4FTO3MDPDb1QxUpO+tCV38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/akhVTI; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/akhVTI"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbeeaac53a9so1865801a12.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 09:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786637779; cv=none;
        d=google.com; s=arc-20260327;
        b=lAAUQ+cuY+7m4W1VAYcGWzAbmjnZUIJDXY0gil8nqZiLiMewB1Et3VUGTaINycGsA3
         No05f6EZuPK7sJ+eaa+mJO4EQST2xjDAQB3SJPZzER+quf5CtqoxIK5SyGgtCB1/yktO
         noTt9e7Q1egjbubTWz5JQFG2nK4+hQVkrGatWPpRv87PYCFp8gf9niSDu7O6sB2bqxD3
         7mPvC2BaOkxTDMkNDQHKWxF0Zsz2TdfwiH22I2+paenBAV679GpGcWj8LVW77NNja4yh
         /opBHw4ekbljnI/SuXekOamyWTsz/DXrlwTaRzBZmdaOXfWzp/Q21txOKtEp3Po87ig4
         5fiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WKTV2ZTSUoxL0x2hN/gj5r+kKUiy8iekG3jkXHZrZMA=;
        fh=ep6FBfCZQvhZvp5iweazYBMI/tXZAKfnV/TZGDpCbgs=;
        b=Nn85hdLyT42FhCf1Jb0rzOVbBs2sjdRnfbDxZ1m3vxhQrBs97DzwIUSiakToJixfM9
         GDlup6kmZrxvRXKe3u4L+kSbJnPP1J8OxVUVJb5bv7juFmVEOtCIQG8filRshhoiZzS2
         4pvOqOhrHbJLbXX4Ik3Ae2G6yDQ3reeiMAnSyK5pQSssOEtytyMlF3Twy0QRu9ORPzLQ
         7hB5jT5Gy/K6ccCKsDi2b+0Cn9fZncqgCPHDM0ow0uYZvH1HkEUG9mTDFqenkWjP00WJ
         p6QMwkbZwZmdW4umGe7td2tXvGdKBvovygGF1ezCWjx2wSUzZuQxiCJP/p0dR5jVSr8G
         9cfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786637779; x=1787242579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WKTV2ZTSUoxL0x2hN/gj5r+kKUiy8iekG3jkXHZrZMA=;
        b=m/akhVTI5BJIly6i96PXCZntNCESth4cJId9UsP4qlyexrh2SIG4k9G3kC8TNS7f4r
         CfegBSjnIMvZy4DnLHirwqtZVu1t2CQY5gmEj4pqfCfJgjTVTOSFGsGbecKfWzINR1Dm
         /MQtPkdJnPYaNpJe3ZLJ2Lh/40E/1YdCucvYa1McLaCWxysmRArUP6jbAKrGMhayrIx6
         YGI0RwJltJb0Oh2kg9lq1fHARRpF3ZX/jRBxx19mpA1zCDhucFoGeeRRuLMSVqjElwq/
         O/gUmmdR3aT3v8CfSVvcss3vJRN212ifkr8u3sP8ygZrpqvyHv5hXz3GABMlMQn9XU1X
         BYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786637779; x=1787242579;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WKTV2ZTSUoxL0x2hN/gj5r+kKUiy8iekG3jkXHZrZMA=;
        b=r9HueRkxcgEZ/gFJyIOKclSLTyrxyNE+Hy9TGpove5k9wV5LtxaJipM8V5I5wTBtau
         uqh2ki/z5edbF2z8OK7FfI8AMJ8VHaeZ+2mtyXVxiUnFubiivrxmNttdxRaLpoBrCSMD
         yL7zyN85KyNOeXVWuhNogPA6th+Ww+OwQLO5PfjBcaBNz8PXhU/gJNW/AEBWHXq6i9d5
         X6VoWl8NRhWn3vqq+sarAlVi9vhBJS82YEEzLEkOBNoXVw7gKL4r0dcNDIPa783O1TLM
         Lg19tr9mKF/UxrG9ZgzkAzIjfAu0/rEaA5VahXRlDadZ8/VrLmsi8B+KJRtcWWE4P4R8
         PLjQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbJrE+/hmPxf85W5gR+3+mmP44eJq3KrJjAR4oKs3LssVz6eGiHbaijyBCc7XDeLk0RbRK6NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5gCtN14EvIliM3Na0ateYKEI6VNpcQYMaTKprgbphWhHwlYR
	eVvtLlx3OQTEQZ59sD4vNunHOPYrh9VD1GDRkZ0zJzAuA1r5zSb7nvqtCdGx0VIEE75EGyhQjKW
	fVEr5ohHSD7rEmVKuQhf5jPn6LRBDbzo=
X-Gm-Gg: AR+sD11VsPp8FvTP2jFXgoJAoFqY+uBLGZb4eDSgf3zGdQRf3RKYYETZjn7MdUkAbmb
	lIhmbnPAKZ34JLcMcn+UBAd+rCtwnjoa5BLH3UVo+D2yiWfW+zyQ6yoviXRUZL+4g0NVV2JtQrA
	lIvi5GDQcjZxyKWbbz+emGtr/Zs4oCWsBfLq8p2rBHb/svegp509Jnl3FOFrxrWJLn/5phhwRYR
	FyGxfyAcWoHbwY5RUaRUwGyFon5CRlrHSiP3W1DIemMwvm8iZcpnIiUpmhA5VGbo5kwR/LZam7e
	6s1RwJzaeTteeQnkvQCh8lYX3CsZuEj0IB/ozUGFeCoVo7RGlL7JAyIoQt1rqTwyEHJvnjQ7RKf
	g6B8=
X-Received: by 2002:a05:6a00:94f8:b0:848:4754:28e4 with SMTP id
 d2e1a72fcca58-84fc6dd20d5mr7964377b3a.15.1786637778230; Thu, 13 Aug 2026
 09:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813014056.160533-1-zhaoping.shu@mediatek.com>
 <willemdebruijn.kernel.1372b82f50882@gmail.com> <0e1f71c4417099399eda78fd2a082b2444e42af9.camel@mediatek.com>
In-Reply-To: <0e1f71c4417099399eda78fd2a082b2444e42af9.camel@mediatek.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 13 Aug 2026 12:15:40 -0400
X-Gm-Features: AUfX_mznkHuU-cF144mVumH8tZacn1_Y1N_Jk90APs0ZCVnzLy3r3jqX6yEARUw
Message-ID: <CAF=yD-+AF1aW5D5H_QPKE1yxyU2wLxOmT8c2Fm4CJsPY=BjW-g@mail.gmail.com>
Subject: Re: [PATCH net v3] net: gro: Fix nesting of TCP GSO SKBs in skb_gro_receive_list()
To: =?UTF-8?B?Wmhhb3BpbmcgU2h1ICjoiJLlj6zlubMp?= <Zhaoping.Shu@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"sd@queasysnail.net" <sd@queasysnail.net>, "imv4bel@gmail.com" <imv4bel@gmail.com>, 
	"alice@isovalent.com" <alice@isovalent.com>, 
	"eilaimemedsnaimel@gmail.com" <eilaimemedsnaimel@gmail.com>, =?UTF-8?B?SFcgSGUgKOS9leS8nyk=?= <HW.He@mediatek.com>, 
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, 
	"willemb@google.com" <willemb@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kuniyu@google.com" <kuniyu@google.com>, "ncardwell@google.com" <ncardwell@google.com>, 
	=?UTF-8?B?SGFpanVuIExpdSAo5YiY5rW35YabKQ==?= <haijun.liu@mediatek.com>, 
	=?UTF-8?B?WGlheXUgWmhhbmcgKOW8oOWkj+Wuhyk=?= <Xiayu.Zhang@mediatek.com>, 
	=?UTF-8?B?TGFtYmVydCBXYW5nICjnjovkvJ8p?= <Lambert.Wang@mediatek.com>, 
	=?UTF-8?B?SXZlbiBZYW5nICjpmLPlhYkp?= <Iven.Yang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 4:40=E2=80=AFAM Zhaoping Shu (=E8=88=92=E5=8F=AC=E5=
=B9=B3)
<Zhaoping.Shu@mediatek.com> wrote:
>
> On Wed, 2026-08-12 at 22:29 -0400, Willem de Bruijn wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >
> >
> > zhaoping.shu@ wrote:
> > > From: HW He <hw.he@mediatek.com>
> > >
> > > A device supports GRO_HW, and the device driver enables the
> > > NETIF_F_GRO_FRAGLIST feature. During a tethering test,
> > > skb_gro_receive_list() reaggregates the GSO packet. However,
> > > skb_segment_list() cannot segment this packet back into
> > > the original packets, which leads to IP fragmentation or packet
> > > drop.
> > >
> > > Scenario (Tethering/Forwarding):
> > > 1.Driver submits a single TCP packet, P1. P1 is kept in the
> > > gro_list as the first packet.
> > >
> > > 2. The driver submits a TCP GSO skb, P2. P2 has already aggregated
> > > multiple TCP packets by HW_GRO, and its non-linear data is stored
> > > in
> > > frags[].
> > >
> > > 3. P1 and P2 match the GRO rules, and since there is no local
> > > socket,
> > > they are aggregated by skb_gro_receive_list(). The resulting skb,
> > > P3, has a frag_list entry that still contains frags[]:
> > > P3: [ Linear Data ] -> frag_list -> [ Linear Data ]
> > >                                     [ frag[1] ]
> > >                                     [ frag[2] ]
> > >                                     ...
> > > 4. Later, tcp4_gso_segment() or tcp6_gso_segment() calls
> > > skb_segment_list() to segment P3. However, skb_segment_list() only
> > > segments the entries in frag_list. It does not segment the frags[]
> > > inside P2, so P3 is not restored to the original packets, which
> > > leads
> > > to IP fragmentation or packet drop in the following path.
> > >
> > > When NETIF_F_GRO_HW is enabled, do not set NAPI_GRO_CB(skb)-
> > > >is_flist.
> > > Fall through to the regular skb_gro_receive() path instead of
> > > skb_gro_receive_list().
> > >
> > > Fixes: 8d95dc474f85 ("net: add code for TCP fraglist GRO")
> > > Signed-off-by: HW He <hw.he@mediatek.com>
> > > Signed-off-by: Zhaoping Shu <zhaoping.shu@mediatek.com>
> > > ---
> > > [2]:
> > > https://urldefense.com/v3/__https://patchwork.kernel.org/patch/147060=
32__;!!CTRNKA9wMg0ARbw!kigb147-G9EgNqdWMhaQ43udYOvN90SG6bVjeM-GxTsPo3E07_tb=
ysuoEieszr5CbCqT94AYpt1b_M7VsgNaZcjtBS_AnYo$
> > > [1]:
> > > https://urldefense.com/v3/__https://patchwork.kernel.org/patch/147022=
09__;!!CTRNKA9wMg0ARbw!kigb147-G9EgNqdWMhaQ43udYOvN90SG6bVjeM-GxTsPo3E07_tb=
ysuoEieszr5CbCqT94AYpt1b_M7VsgNaZcjtu0bQPNI$
> > > ---
> > >  net/ipv4/tcp_offload.c   | 7 +++----
> > >  net/ipv6/tcpv6_offload.c | 3 ++-
> > >  2 files changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> > > index 3b1fdcd3cb29..641c47fb1ea2 100644
> > > --- a/net/ipv4/tcp_offload.c
> > > +++ b/net/ipv4/tcp_offload.c
> > > @@ -395,9 +395,6 @@ static void tcp4_check_fraglist_gro(struct
> > > list_head *head, struct sk_buff *skb,
> > >       struct net *net;
> > >       int iif, sdif;
> > >
> > > -     if (likely(!(skb->dev->features & NETIF_F_GRO_FRAGLIST)))
> > > -             return;
> > > -
> >
> > Interesting that ipv4 and ipv6 diverge here. Nice to try to make them
> > more alike.
> >
> > >       p =3D tcp_gro_lookup(head, th);
> > >       if (p) {
> > >               NAPI_GRO_CB(skb)->is_flist =3D NAPI_GRO_CB(p)-
> > > >is_flist;
> > > @@ -430,7 +427,9 @@ struct sk_buff *tcp4_gro_receive(struct
> > > list_head *head, struct sk_buff *skb)
> > >       if (!th)
> > >               goto flush;
> > >
> > > -     tcp4_check_fraglist_gro(head, skb, th);
> > > +     if (unlikely((skb->dev->features & NETIF_F_GRO_FRAGLIST) &&
> > > +                  !(skb->dev->features & NETIF_F_GRO_HW)))
> >
> > Would it be better to test skb_is_gso(skb) and only skip fraglist GRO
> > for HW-GRO skbs, rather than disabling it for all skbs?
>
> Yes, for tethering packets, HW-GRO skbs are aggregated by
> skb_gro_receive(), while others go through fraglist GRO. However, care
> must be taken to avoid packets arriving out of order. I will work on
> it and submit V4.

Oh right.

As long as the choice is only between fraglist GRO or not fraglist
(rather than GRO or bypass GRO), it should not introduce any new
reordering concerns.

But the decision cannot be made based on skb_is_gso(skb) of an
arriving skb. Because when such a HW-GRO skb arrives a SW GRO context
in fraglist mode may already have been opened, and it is too late to
convert that to non-fraglist.

So essentially HW-GRO and fraglist are mutually exclusive.

> >
> > If treating the features as mutually exclusive, another option would
> > be to replace these datapath checks with disabling one at
> > configuration
> > time, in netdev_fix_features.
> >
> If V4 work well, there will be no need to check netdev->features.
> Linux kernel GRO will be more robust and able to handle scenarios
> where both NETIF_F_GRO_HW and NETIF_F_GRO_FRAGLIST are enabled.

What is your plan for v4?
