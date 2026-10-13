Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA4542EE3
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923586; cv=pass; b=ua3gb2XT7pDzm/enCCjtcUCMjiduMDC2G2Sz1xMHZ2ozvYbd4k9k+qzJqZACb58LuNBh15lSYU8GEZtgZE6jw2jthCirlDu9gUk4rmGeQyqoNB2fG58PxnrpGrYmoer6r2FrqfzmCtQsKZORYdiw13BF6h9olH+H034RT3W9cX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923586; c=relaxed/simple;
	bh=guoFD20zEk9cIM8OGpiI6ZacaO2x+w0vW/appO61b84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjJarnz14oQhiqc3L04oPtFBlSO9qWN8+0uuHGfrxpTFmyLx3I3k5JjjfvCGdbcSzXpfYdwU5pb+0GtwpvZUFYd8Czt6xcltk9VaGsRssNqikcKTix+acwezrsGfciFRsKt/7tCbYkVciYg7JrBiH6KfIynFp8RVOgBYHRkzBJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sCfdEhry; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCfdEhry"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6740e7ae219so2689878d50.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791923584; cv=none;
        d=google.com; s=arc-20260327;
        b=HzjlTSzp5Q9puJZh52f/BqgoWIIGqyQjJIavXdKixWtDM/w9Xh6mqZvTjrpk8aJE/F
         KTKfMHwOGtvbXHPVSwtI83V3BCUBUe+sZJahvzoTXGA5lZM6/z1bRxfKnc6quKNLV/2p
         oj1DkH1XGVaoSU9AJuIjectCxsTsvIbn49sHxFdO34M9eVf7kqdNVsWHofLWsMBPS/cM
         PRD6+1NbIsfQaql9N2J3lq/7mgXWTMg7pY3mU42LT6E8FwafVfdDuxg7ZOoT/9kLb1nZ
         PDEsX2QT1RRK6WU5e4a4zYAUQkn3/wtbRowOTRlsBFqJ5S4FCl3pmZxuMgK/I+L+Bdah
         rAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fjZWNfknzV1F6JAInAE8o3x3W3fwqE841SsbudO4cc8=;
        fh=SsbNRHZaRTXR1wZjX7uY8V/hyCciNjaUsQlb9Wd7Zec=;
        b=hoYooxp/3/DKZGK+MN5PWxB8kuuBUaUwSHr0ENM/Aqaz8yPwLYj0mv9402eKfHuDMq
         xRMEAawZZpmrXik0/gUuD0yCe4tNCkhy7k+yfXnvHrDGTlCi2EJjRD0ciSOv3JuwzM5I
         WGdNfOQz37BquA1temKrKWDLqyJyuBbM2b+iL73im/pS6omzTADzy0o/17rBIYj2C30o
         +m0h9g+zJg9XfGQ6Bnh9Z5N70ATwNugZKc8W5UfOGffPcBX6l4IqZT+MaZ37y8OQ0nqA
         zoUYMxZNnhRPSSfOXM3QkJcVV8/sqmHkYs6Q1HIvNdkdfTZ/xgUvPQx5K4cn++XpUmnz
         epjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791923584; x=1792528384; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fjZWNfknzV1F6JAInAE8o3x3W3fwqE841SsbudO4cc8=;
        b=sCfdEhry7kUMkf8k5wxJjj4TkkJhUY/4aIduFykUdOoGmj4tu4TgmXXNR+WMyjctS5
         L5RvSWMrLfxAsVZjSGmXYcsf6j75eJfGq9BqeCKu3zfPidhRVTDLris++A2DhOU6fG3/
         CB5nRdY7foqKxUgrpZPW2teKWAi+WKTr1jmX2xr7OZ0XsvAZ4PoSBshWmbt+LwDxrMiw
         ys0UTFde17SkQz3X2M/dJ75W/OwxotQQheBI0iEto77knza4pU4ZpztmpFN7P+C9vlsY
         bhlPuGevilXOBGjNxAGxP34RX7wDviazB9wEwCvZNycFIu98M+B/EJi5+tSX/f1gQFiy
         pOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923584; x=1792528384;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fjZWNfknzV1F6JAInAE8o3x3W3fwqE841SsbudO4cc8=;
        b=RBrRoH0hWx0nkgm6uoG3GSyzdq2GqVyZJ45tNDwmhC/SOwmHQnf2N81y1tgGETDss+
         nr1/ZASb2pvnK9GdCrVu64cYRWvlDCoAdEZRWWk9EP31HpYHSP+H74WNLe95qRF3TcU+
         Lcr7/VOnGmz4wVnTIhhXXqIJSHrAb4FPDGlK9OWUWf6PoLKiITCManeycJsbPVxqEzsZ
         zcYkaJHjQ5+MJX7/0z7iSPKa9lkeEdqoMLg30EF4k+FlB0hf/EmbZVHQn683i6GtxJ7g
         CE1vDmXWDc0lbA89MAXvEHzKnYd/QSKJ/8W9jm+3spO6WfQdOQfNu0vsNrbn027Ee9KW
         MFDA==
X-Forwarded-Encrypted: i=1; AKwUvBwVUpHfGz+l32hyJz1oa+uQGb4RcyWLGYWNLH0qfD9n+/0Dzx+3KZpxSAfCLnuT35V5eTyADpU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3+AFEMecckrVpEMi7yDRFH8oZ1306Fk1Ogwo3qmz9QPTDlEQo
	AiNvSbp40WdrtK0wH3yJCivsz/y1K1Q2s4uDo5J+z3/y2iZFvKz38FW9F3KXV4T6DIt/IhsTCe5
	PkYU7XtBD1YorlcbC9YHvEP7xHw82quE=
X-Gm-Gg: AYBFou2M3NB3ytCjZiDy+T+3DQuKg7mxXkCfDr2u7y1CtNe2ibPl+CwPUkzXyhGda/M
	bRTsgivg4OSSWyhRh/Xk5RfVGBQx7rOsKbb5Fk6uKUrbw5xVbCtHUmdzN3QFUt+Eq/DI/HdLLyF
	IxGIfgdK/AnYSqnm8FZy/TNy8SB2ToXv98ChvtPKpAfgIpwlOqci2a2w+Di3XLROpmqcYi40BAa
	3V2ezkh16Gz1Gw6c+81XXNYt7lPbDq+YGz3VKtrEMR2JE7PrGZQu6bEBK3cvhBsuBmXn8h96fiD
	DsuH5hOeroBpbk/RPo/BTS5rAehqEAVTujY3AqE/IW48erpDoyKRxS5kAQ5At31TrniOaGvGRoW
	vbyZV2VWXNycPtDrjyQWZw915a28rJOdbzuW5yGpe
X-Received: by 2002:a05:690e:168b:b0:675:b778:a423 with SMTP id
 956f58d0204a3-679362bf517mr4886393d50.142.1791923584078; Tue, 13 Oct 2026
 13:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791887415.git.mst@redhat.com> <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
 <20261013070549-mutt-send-email-mst@kernel.org> <CAF=yD-KdTn2rHyp_j8ORr9F5hpm=TzaPRan5+gvLiYBd9HP-sg@mail.gmail.com>
 <20261013143335-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261013143335-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Oct 2026 14:32:26 -0600
X-Gm-Features: AclHuK_AY3efVdSO1MP2W2AAhlxVTMjkmeXG8cBqCPBuysQoPjuKaPNm0xvEtb8
Message-ID: <CAF=yD-Lz92nGVFab1Dq8M9VusDsKf-ioda8KrZoyh28x3Xtg4Q@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] net: resolve uncommon partial checksums at ingress
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Max Krasnyansky <maxk@qualcomm.com>, 
	Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"

> > > > +
> > > > +     if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > > > +                                            inner_proto))
> > > > +             return 0;
> > > > +
> > > > +     if (skb_is_gso(skb))
> > > > +             return -EINVAL;
> >
> > This is a risk the commit message will have to call out.
>
> I tried with this:
>
>         > > > We can't easily "complete the checksum" for GSO we don't recognize - GSO
>         > > > assumes knowledge of the protocol. We could segment ignoring the
>         > > > checksum then do whatever csum_start and csum_offset say, but that
>         > > > seems like an overkill for something that should happen.
>
> I guess I can add a more detailed explanation about what the risk is?

Let's just explicitly mention the consequence: non-standard GSO
packets that previous would be sent may now fail.

>
> > I don't see a simple way around it. We discussed segmenting here too,
> > but that requires intrusive changes to all callers too.
> > Alternatively,
> >
> > 1. call segmentation, but only to see it remove the SKB_GSO_DODGY and
> > thus verify that the TSO/USO packet is valid. Still drop otherwise.
> > This also does not add overhead, because it would be called later
> > anyway.
> >
> > 2. a failsafe off-by-default sysctl + static_branch that skips the
> > drop when set. Messy, but so is the situation we're dealing with.
>
> Tack this on top or do you feel it's needed straight away.

Not urgent. Can even wait until a report appears. But worth taking a
look sooner if either of us gets around to it.
