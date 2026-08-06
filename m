Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC112BD022
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786012254; cv=pass; b=QKXY475SFRPw7zh/XSnVYBXn3WgIcDI0Jd6HlkWkHDxs1oN+5sl7yDPohBO99gfru8G5ux2eDx0vgXLqQvNQzxe6F1FCLwnqRqJi4jZ9ymbM1HRurIG9SXvBNguiG3p7AfAjulgXT2hmhMtaKunDejPnob25Vl92SBHVad0TCZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786012254; c=relaxed/simple;
	bh=yNODrHMOxqtsepyb3/L6hnh/XsDj3IikQhu/sC8GM7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dt6Vbl41X0E6BPORoCMRn1ymY/W4WqFe2dRQx4vlUlCTiWFqitp7RPLOpXKogGsqdkznWs3q7f3elIL4yzG5QObMkBBIMHVXU3X/0N7JZm9Yo/7KpjWO1y9c4KuduqAewhlyi/7HdRZiiH4yZucCdaZDkASVo7oTr1w0vCF2o9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UXnif/gD; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXnif/gD"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-529a1ee0e62so13069841cf.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 03:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786012252; cv=none;
        d=google.com; s=arc-20260327;
        b=Tk6gyB3oZIvYCZY24EpfeFHnwzCyWnlzyECF5+GgCyT7qg6uTPc/ly7LzJKf40csod
         ACYW3Hg8IA53qH1ysHxgopWyHuO5LMTvCft+Jwim1OU0t8qvyhfx1RS3Ojkcco7u5m7S
         qfntxvYWXxrvyyJLjVEANQSHDDbvDmfftBq2q5k+why771GrFiiHB33An82JJUBY2tRM
         lLUXD6EDvFN9g1QTOH/4Q6n+9mSLD8szm4d9wBysAYxAy6+BL3Df5DpZ2jq8mc7h175y
         nV5aG5Ov3zZPHFA/vYfLmpCFI2UaMGera9+tsQgQHD2CCY57wJjBq99sZFbpFySKusuG
         afGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kpmfGa9DySgqH1p+t3aSoi4fYsVddD61gTFSw31rqcc=;
        fh=11rvjRW6voaPKktfp638TcMvFDyng7+9kH2N8nHlEV8=;
        b=a9AfRm/n3k7dedEi7WkCx9cMIEbmCQXeaCuP9IjTDAXIOu/QUDQYEd3A1hNS8kzmpw
         vlf8CgiA9IBPN1eoptb3T/HVjM4tT5npcadDqhVdEzWdNnZnJD+mCm+SkShGja/nKn6u
         DN1aTqTef4URs1CxuOPyC8GTqa5T0pjwUGlR5NeW95sP9RLRx6DPQUudjckrZciMnlkC
         4FAL6+Hf93JWGGguqojfqHtl5KRPBndZ7TUxhFixR6YjrMVrtxDhpiEhhSLl1W4TLX4D
         R0CV8Gss4AsIesluNLJ7kgecXpty0WXzXUYaUrfvE4wGOOS0qJIp5BBeG+mgF40r8YlW
         fS3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786012252; x=1786617052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kpmfGa9DySgqH1p+t3aSoi4fYsVddD61gTFSw31rqcc=;
        b=UXnif/gDI3vSAF58JTc6Cfy4QMeJc2GCbwZEvKZy1SteKajtmJU2uvdAKwj1yPfOY2
         SusR/QbEKkJzmJ1sP99tWfo0DTy5AV9zXKQ48SFhgPJGFNJ9gVTk1VmUIfN+sthOsjoi
         5fzewhJMJcNZv+IMXLNLIDjE45wok+2MFqUUNxmgAnXV/jchW9RGyPzh5MiTAnXJUYrO
         cxAy+nR5sncSZxZYQ01XRZEFh9fOUSCer6xVXf1IrurRWmTo4LX2TKO6DwQGTsawejp+
         e41TzwYFSF4kiOUSWXpEjsXvdOFpDQXdgBR54KYm5qO9b/gpQqcGEbbNzGBlwZpS5vkD
         x81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786012252; x=1786617052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpmfGa9DySgqH1p+t3aSoi4fYsVddD61gTFSw31rqcc=;
        b=mzuqepB2vaoo+U0elRcwLbWGWd/wV1LefHjveSwCUXaFEtajVAkDqMCwYRM1PaDa6E
         ZH2mzqXwyDMd9hXOQBTLh/EDUDlE6slEezncdTmJuAYKjrtlXM8fwnhhjLX9VVGdlFrY
         pUyRvpzfnYyKiD1e/C3gkaiIId3wYUgSQZKJKTESnp4tpIIIF9gUwDKpjeKG7QB5CTFO
         Bf+BG2sxfYsb6IM1qwTkacnORgx1FS+1Y/K+KNv5WwGAhPV8xUR4tafUSGAIUJCppu56
         X3uDbLSyzjDuWOlLPJ+k9oywCREe9L2buc++XJOO1btyNM2hUz7wuSwW5ItH5VZz/g12
         FVkQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVhKf/2PHR45v71YGcPtOcARv9R2/PKHD3lG1VdhFmLcrirJvEFX2qAHt5XTfRmKsjyTzDyak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdRS2bNPDegxPHp+AeU0idZSD0B6S8r00x1jmgUzYH51VCs3vH
	jRqsa9Qstmamv+fZKhJOEA+vC/yP+yFj29T4Lx8ErdR5j249xDKLbrWVLLCWW/+L2LY9V+wgeGd
	WBXNc9sHtcOBHh24shCMr6s65wlO5W2B+nD6u7FBp
X-Gm-Gg: AR+sD13/2k8iEqLw/XC7CYmGE7KywtvJ/GMJtGELhspKYVh2RVGdml2Fh9u3DUAVqDL
	sNAEp1SmvUrsv6wDqz3GVGIvOja1QPT9nd+FF5Pfxom+ENk8bmYBPE1HgCJUiIeaDKOoiLBRex8
	HQr8k0WWrQvXJNpWQTW1WdG7Zxie7O/rVxYCL+Um4hxvoafyvx81CtZP2vDQ+kz1tEeeXhTrVPF
	QSUgIrsEqav8xtizZRcehIYH6tbZBK8NhKKoQdfs/rIAn1YdDeMJg9xwFnP2inJv4fvU3XpD0ne
	BABtHxHSxa0gDWUBMOdFeBghfECcOxld04nYEeDnJZ0DeXKYIGoqrkEM8tFqUtLt1iRLssflYs+
	9b5l2khqi+LpojphSCMZhaL+NzyjzzzKOdYdulCjsL8tif7i1KIPieaAq2etLlPdgIzg9iZM7jh
	1yOQ==
X-Received: by 2002:a05:622a:4083:b0:51c:2190:3b56 with SMTP id
 d75a77b69052e-52ce6144dc8mr150061011cf.21.1786012251418; Thu, 06 Aug 2026
 03:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804155416.2168523-1-edumazet@google.com>
In-Reply-To: <20260804155416.2168523-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Aug 2026 12:30:40 +0200
X-Gm-Features: AUfX_mwDlha8y5wKNg_BJLLkzQR9LM5N4YybbebPTeMasjnVz6Z5VJCBy402zPs
Message-ID: <CANn89iLr4EQxBAKikZCeXbXEk-pjmT4mq3d=D2P01MtNSUgwrg@mail.gmail.com>
Subject: Re: [PATCH net] ipvlan: inherit needed_headroom from phy_dev
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+1f9fd0f4b601cf88d6e6@syzkaller.appspotmail.com, 
	Tangxin Xie <xietangxin@h-partners.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 5:54=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> ipvlan devices inherit hard_header_len from phy_dev during ipvlan_init(),
> but leave needed_headroom set to 0.
>
> When the underlying phy_dev (or stacked lower device) requires extra head=
room
> for headers (e.g. macsec, ipsec, wireguard, tunnels, or veth with rx head=
room),
> upper layers calculating packet headroom via LL_RESERVED_SPACE(dev) fail =
to
> reserve sufficient headroom.
>
> This can result in reallocation failures, skb headroom underflows, or KAS=
AN
> slab-use-after-free crashes when dev_hard_header() / ipvlan_hard_header()
> prepends header data.
>
> Fix this by:
> 1. Inheriting needed_headroom from phy_dev in ipvlan_init().
> 2. Propagating needed_headroom updates to attached ipvlans in
>    ipvlan_device_event() when receiving NETDEV_FEAT_CHANGE events.
>
> Note that a similar issue exists in macvlan and will be handled in anothe=
r
> patch.
>
> Fixes: 2ad7bfab3016 ("ipvlan: Initial check-in of the IPVLAN driver.")
> Reported-by: syzbot+1f9fd0f4b601cf88d6e6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a720a21.40259c87.584f4.04bb.GAE@g=
oogle.com/T/#u
> Reported-by: Tangxin Xie <xietangxin@h-partners.com>
> Closes: https://lore.kernel.org/netdev/CANn89i+1EW-sFNK8xoq98gMbPCeLS7e=
=3D+rs9gHfLg5Wj+4x0sw@mail.gmail.com/T/#mcc6307f115e500df23ea2980d5669fe95f=
20b6b4
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/net/ipvlan/ipvlan_main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan=
_main.c
> index ed46439a9f4eb1dd8bfaf6c83476ba4f2aff31bc..7513c005a5121676d3f8edb08=
98492ad434a9fab 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c
> @@ -146,6 +146,7 @@ static int ipvlan_init(struct net_device *dev)
>         dev->lltx =3D true;
>         netif_inherit_tso_max(dev, phy_dev);
>         dev->hard_header_len =3D phy_dev->hard_header_len;
> +       dev->needed_headroom =3D phy_dev->needed_headroom;
>
>         netdev_lockdep_set_classes(dev);
>
> @@ -773,6 +774,7 @@ static int ipvlan_device_event(struct notifier_block =
*unused,
>         case NETDEV_FEAT_CHANGE:
>                 list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
>                         netif_inherit_tso_max(ipvlan->dev, dev);
> +                       ipvlan->dev->needed_headroom =3D dev->needed_head=
room;
>                         netdev_update_features(ipvlan->dev);
>                 }
>                 break;

Sashiko suggests to also inherit  needed_tailroom.

I will add this in V2, although I think devices having a non zero
needed_tailroom handle the case just fine,
since TCP never cared.

This is a pre-existing issue, but since we are inheriting needed_headroom t=
o
avoid reallocation failures, should we also inherit needed_tailroom here?
If the underlying device requires tailroom for trailers or ICVs (like MACse=
c
or IPsec), failing to set needed_tailroom will cause packets to be realloca=
ted
and copied on the fast path. It could also potentially trigger skb_over_pan=
ic
if the driver appends data without checking.

pw-bot: cr
