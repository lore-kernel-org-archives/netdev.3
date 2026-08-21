Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FAACA6B
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325013; cv=pass; b=Qu3ofwhFE2V10jgAuMNlEfgXKPt36cyaOdQP3kqqm+2TN3AM63IJy40xrFZqP93dtTLZolSozoh6yKnJ6fxdycvLfYj60zGOJke+W8w4jt0qZ+FMdw2rT9suVaBJmt8/348s/xg0V6jxt3pOksJmjlm1oZFK0NsoZLQn6JTCp1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325013; c=relaxed/simple;
	bh=5oI+xBtZUfUH2mDLNrZZfcQFDI05XaHkReknNpyfc8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXamIzM3ZXXhS0v4M5JkR1E4eCTCbRdsaFcJoQbgSihDwOvUmRrxmJ48Ba9cvMWQHV4PKcwG7+KWJdjXDJcQPC+VswcGga9OMsDzO3Zm5OMD+MnrKbeG1lA1T+ZRCbiBiGjWHZ/+k18bxzg7Q7fFG1sEnAlqIYjm0qT8ep1u6w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BV8n4E4t; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV8n4E4t"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66ce4a63e17so1258735d50.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 08:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787325011; cv=none;
        d=google.com; s=arc-20260327;
        b=deFC5Is2TGEKCNO9lwMR2LgVYuxtH12I4Ysn1AxAEwm9BaFivTR8xW27s8OxhuPec5
         ra+xzvLMPnnVfjGp3FEfVXAgCCc5Si83sBAYE56HvKyHxbOyAkNYQf3SGqCc8XscC0gs
         D2lDGq+ctgJTumHX6zGOgRL0/jY23Eu99kghzR7oH4O579PHZhrNQ26ArBh1HP8yNlsS
         WtM4Lu9W9b5JsSmVTR8I/1olQu/EmnLyOdzmEbnyAKIeoAJR1pau6MpAQpvRxA301oB0
         q58gXIdx5NThDqVfNhmDOfnuvxhGxYUYzzJ08u/+17xwphJ0J8um9vGU7xeHPBr8H6ow
         WM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h8jP/MvrXSs70WMEBo5IA2IeHY9qdWxXWvVO2bIo13w=;
        fh=jlLvnORIoN/gqn15ogYl1A/oitJs+f0Uk9RkGjyA2m8=;
        b=mfXOrTWi/u+/p8JddsLCtUeTNGS3HC6rT5MoTkZJRlAlAwenunq5phtjwppAotQny9
         VU5t12ih/GKxXlwUvBKWo8uakG9BEAq5s2OYjtVrFDeY2cuLxt8JcyqFjJUkq8P5VORH
         Cqb59Xml/P4qAuVopUxyV+DLTIfnUQqoP/hLmZH1B4WhHA9ig54SKwqdxjjyQdBFdlnk
         EpWPTXsEhsK3RtBBlc9uimS1Vg+u62bzxsTjDc7udjd+TRbO2tuErLHSAJ9M/N70epGM
         Y4XKLsOu7FwCKk2NbAsaHBZ5vkENZ2VWxB3mHUzhBdlSmGhaVj3odkQIHQwwjKTZFTnf
         r4oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787325011; x=1787929811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h8jP/MvrXSs70WMEBo5IA2IeHY9qdWxXWvVO2bIo13w=;
        b=BV8n4E4tWabUTPsdhYWmRU21KTh7b0UER3ZUz0U6SwBHQqCZEHojGXfqnttNOwiUhI
         Mp9dOElALFTqydOSVNjBaf74JfyPmWMfXszBSzeS+diI6RIQwzSM2NCJK/nLhaLSuzAJ
         shOYHjHGvKRLZJ1X3K0Quk6t2o+OJk0UsMpBhRdqzI3zY0RGkHyV6fR0an6vN6hU3g6l
         ceJtA63ANFo9RU5+tt4HjPQ+r2WEHmYp/YOb9j3J6okW8T4HhNd36HgE6pc6irJEIhu9
         UU3QaeDvYfLaLZfB5nZEzwU+/xK3N4M+isQD56ucDm2sWzSkaP23NDpj+8Yd8yAtsZD2
         wi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787325011; x=1787929811;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h8jP/MvrXSs70WMEBo5IA2IeHY9qdWxXWvVO2bIo13w=;
        b=LLHGOWlE0RJjkBdC96wIwujKZU1ihBHSoHBwoMn2IAXCOqSWhsiXeewLqOwX0oVUAB
         8OWS1ShTo9Eg4tQhyH59CMuVgjV058FAJlL1pKZcZ/N4F6jMgFGf6Vj5gHxtwMWcZQaz
         hLbZeq0kRmJyQ7UmdIFEYLX08vHIhhQgoLJnj/NzLBF+D1DuigF+OnfGPZigmHiqyxm3
         NVps48xIDqrGkPrQQtevbhNjpZfyLq3nGcUX7GlWG6FZKszqNUZLcaJLw9Xl3K0dTQtO
         Q7r/Tt4P46MoZQHLtC9eXb+pFGJsb2yLE8kPYSglel6BlOw4m0atEzA/eYgiPXBAXSnW
         tGDA==
X-Forwarded-Encrypted: i=1; AHgh+RrkajKrr8tsv71WSPfPJbBGclkBQwNxXapzqjGKw/sZL8AnZPXgHXGECx5P53Swffix5UCBAy0=@vger.kernel.org
X-Gm-Message-State: AFuF++nSeZrv/R/Vn+HbJ4XDUO+JiwzOQtiX1ba5C3AjYj5bZvsLOhks
	Ybfg0PmS/FSW47zG28tQMmb2R7O33xZ+cnI3+1THSO5g4LvrwZ05MO5PWSZjhSfmcoOeQFqSMBl
	RVNPiINMHnXpYx2+nSJ6Y9GRwdToNGfc=
X-Gm-Gg: AR+sD10Wd9qIsth8ono6zunkYlYsKbZSgn5G65TTY65ju1uovTfRQA7Sek5uGNOGjAg
	Qk1OE5CXEc+zA7Ui/FbpTUSBIBn9BCNFobL9n3LWjP9x8gyMjOX5ttaWmxUpIWKPSr/i5jTiQXC
	+gPJgQNDKa2KkXB0U+b7bTIja/NmgsXR+q1f1wW8sB045LpAeXqng3I8jjALzH+Hn2T51s1c+oA
	UbT+Zer84FV3s4UgV4FIW/ECnQacZsoOZPT8LEa4jn+eMwhLDKYHDluXdAGpVeYkgVHQhqkvcfr
	vIC3TcSjm+1seBrpjU+ZBLYKHz0abuiGORfttjYW38CU8R0aZsPuGGFiKRS2R2aNH1hsCHH5hZN
	cNxw=
X-Received: by 2002:a53:dccc:0:b0:66b:ee21:4852 with SMTP id
 956f58d0204a3-66ce4a1321amr1957781d50.13.1787325010568; Fri, 21 Aug 2026
 08:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819093226.193385-1-zhaoping.shu@mediatek.com>
 <CAF=yD-Lx7aHQEr6MN7D8LBp9ctZz3B3dmfsyhLbPxWaiK1UBzw@mail.gmail.com> <ef026015528638cb69404f22976479515251e4d5.camel@mediatek.com>
In-Reply-To: <ef026015528638cb69404f22976479515251e4d5.camel@mediatek.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 21 Aug 2026 11:09:33 -0400
X-Gm-Features: AcwNN1WIhUj4DkwKagzxOfTG0D1RVHOFkdHA6O1sbDTgVBzQt97XErr-O1wBuek
Message-ID: <CAF=yD-JOVSLoasxQHnRE-mvS_oQZ7f=wHeCc7nxBgw2g_4-C8g@mail.gmail.com>
Subject: Re: [PATCH net v4] net: gro: Fix nesting of TCP GSO SKBs in skb_gro_receive_list()
To: =?UTF-8?B?Wmhhb3BpbmcgU2h1ICjoiJLlj6zlubMp?= <Zhaoping.Shu@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, =?UTF-8?B?SFcgSGUgKOS9leS8nyk=?= <HW.He@mediatek.com>, 
	=?UTF-8?B?SGFpanVuIExpdSAo5YiY5rW35YabKQ==?= <haijun.liu@mediatek.com>, 
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	=?UTF-8?B?WGlheXUgWmhhbmcgKOW8oOWkj+Wuhyk=?= <Xiayu.Zhang@mediatek.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, 
	"willemb@google.com" <willemb@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	=?UTF-8?B?TGFtYmVydCBXYW5nICjnjovkvJ8p?= <Lambert.Wang@mediatek.com>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kuniyu@google.com" <kuniyu@google.com>, "ncardwell@google.com" <ncardwell@google.com>, 
	=?UTF-8?B?SXZlbiBZYW5nICjpmLPlhYkp?= <Iven.Yang@mediatek.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > @@ -395,12 +396,20 @@ static void tcp4_check_fraglist_gro(struct
> > > list_head *head, struct sk_buff *skb,
> > >         struct net *net;
> > >         int iif, sdif;
> > >
> > > -       if (likely(!(skb->dev->features & NETIF_F_GRO_FRAGLIST)))
> > > -               return;
> > > -
> > >         p =3D tcp_gro_lookup(head, th);
> > >         if (p) {
> > > -               NAPI_GRO_CB(skb)->is_flist =3D NAPI_GRO_CB(p)-
> > > >is_flist;
> > > +               /* flist GRO applies to consecutive non-GSO skbs */
> > > +               if (!skb_is_gso(skb) || !NAPI_GRO_CB(p)->is_flist)
> > > {
> > > +                       NAPI_GRO_CB(skb)->is_flist =3D
> > > NAPI_GRO_CB(p)->is_flist;
> > > +                       return;
> > > +               }
> > > +
> > > +               /* Fall back to the regular GRO path */
> > > +               if (NAPI_GRO_CB(p)->count =3D=3D 1)
> > > +                       NAPI_GRO_CB(p)->is_flist =3D 0;
> > > +
> > > +               NAPI_GRO_CB(skb)->is_flist =3D 0;
> > > +
> >
> > This reduces the chance to have to flush, by downgrading fraglist GRO
> > packets if a hardware GRO packet is detected at the stage (count =3D=3D
> > 1)
> > where fraglist is not enabled in practice.
> >
> > This is quite a bit of complexity. And if hardware GRO is enabled,
> > what
> > are the odds in practice that the device does not produce any
> > hardware
> > GRO packets, yet the software GRO stack is capable of assembling
> > signficant GSO packets. I suspect low.
> >
> > The solution is technically correct. But would simply disabling
> > fraglist
> > GRO when hardware GRO is enabled not be simpler? Or only keeping
> > the flush and avoiding this micro-optimization.
>
> In V2, for the tethering scenario, we directly flush GSO packets.
> This is the simplest way to address the reported issue,
> but those packets can no longer be aggregated by regular GRO.
> This is the main difference from V4 and Jakub pointed out this issue.
>
> V3 disables fraglist GRO when hardware GRO is enabled.
> The additional suggestion for V3 is =E2=80=9Creplace these
> datapath checks by disabling it at configuration time in
> netdev_fix_features.=E2=80=9D
> However, if we disable NETIF_F_GRO_FRAGLIST in netdev_fix_features,
> UDP packets will also can't aggregate by fraglist. This will affect
> UDP performance.
>
> V4 is more complex than V2, but it can maximize the number of
> packets aggregated by GRO. It works similarly to how regular
> GRO tries to further aggregate TCP GSO packets.
>
> This is a trade-off between code complexity and
> the GRO aggregation rate. You can choose either approach.
> If you have another solution in mind, please let me know.

So this code is there only to allow UDP to use fraglist software
aggregation mode while HW-GRO handles TCP aggregation
And fraglist aggregation is only really useful in the forwarding
case.

The benefit over non-fraglist aggregation is moderate. I'm
a skeptical that maintaining extra code for this edge case
targets a significant workload and is worth it. Open to other
opinions. But i'd just fall back onto non-fraglist broadly.

If keeping the optimization, the patch needs to be respun with
both the commit-msg clarifications, and a Link to this discussion.
