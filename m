Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516352D6E5A
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227547; cv=pass; b=qdXwKzxSLB9ix6fc/KTZjxpqH39vETtr6NEqwNNJAVrcOpySYQFo5PJIs2fkornqOFxzvqcKqCjNLfaLv11uZLOe7Y71rSouWQAZDeTpf0MgHNEfX+EzJqNmyrOVG7Vl1pEdYR5sMeUmVuBTMQQNism/qvtIrqGr4SBhLzWh46A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227547; c=relaxed/simple;
	bh=pFfxZK9lGPotJLMrVCTotkrjsr0MN/yP6OYGGXtfcRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5G+YgjwixaXmcyAB+NPDoL2NmazHUCkk/RZAFyUqUrMl5fnpDqnyXCggFTx7YkBA/dLajcIBo3nc1zNQn32YcDvwsOIbZrbAIfqWLGj/nYAfZJF1FuimT1GnJ+7riOdO9l6xjXrrcLrhGOX8SjvKpFTH58rk+EiKNvGUMLWRkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=R3RgMk32; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="R3RgMk32"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ce98cb8165so10056755ad.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 11:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784227545; cv=none;
        d=google.com; s=arc-20260327;
        b=etZvZKrFI9KIrcLASFkDNle8IFnbSUio5PaVNTgAfk5MdK0ep/NmDHwSngXUXisI94
         eugwsTLMcBY6rEzZDjkxZQSuqQYSQ+G1MHWHGuxYK0f1ejQm/dVSUssWnolNDtpgS6U2
         esSZ0M+jfFhUweZdtM6dDyDLrSvtvd7tgsA+v3ui4HW44b3F1r6C6BXvm02FgrIwpBXz
         JpEyvGf+zY/j6+gxP5OMDBSUA/iYDRbXWQg0V/+auSx9UqSxmmKAZRhXMJz7Y8FcCmwO
         MiLpwOKiYJWprPWCXbw8T9wP5doz1gQwhC2KeO68EJMFs8fEK4TxgWv4/07LhcURtg1v
         YNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h5ybI5HJjOUi136pJ8MM8b9ff5G7zzP65amCAnLsIss=;
        fh=HnY1yoyF0ZtL778zPoC3VTXSwjNZ0U9wUxJm76ywr+E=;
        b=FWFFD6wHVceXuC6tn/6tsu6Lm2v38SImCrXduuDbsjaXsxu4t/C/5gQRuzHnCYiGcr
         GGaU7inuKLCq1Vr8OjJOzpvQzDIj2IiQSaqfVQnviROmQ4F9nbp1XViyg5ZS7Rg1sAc3
         KpF1KI6vyrus8/1YruSg3PdKs49BF0F2ZWHgTwdSO6yV27C96P52mAHeMkjvITFrkFOK
         wVRd/w6e67/vWXI7QszWc7q+mHVrgxTO24D+ELuCHkbnLq8yhd9OfkNwLV5bHwsGRWPB
         l7CtGCc7pRyb5c5mK0ECDsskljJR0t3jiNnaiEA/8edzqsTktVjuOYs/eohJVSCdy3/L
         SbfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1784227545; x=1784832345; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h5ybI5HJjOUi136pJ8MM8b9ff5G7zzP65amCAnLsIss=;
        b=R3RgMk32RnYN+oEecPtUOra49iWA+jycLiL7XMNaXirkz+23Hye8/p6ivgz5/mxt8z
         qUVEZ7bRfKBqWPYb0G6c1hJEf26PjI3I6ApZgTqvQTOWxsL6iGnnmaIaIY7WIRGOB7ZT
         hQQ3thZBsUnga591ol4zJ8nFQJzHFAOd+47c0pn8tXkZibIMPZki0EYCIKP7bsV/ZVPi
         3b7X/PGcxyJB8PzOwsAhVdvlcfFzbUVQzIYSzsjNaOMBOVdeRCBmBOvhaJ+DlV+8JBQw
         tZybvzYpMEuvlUIVq3RDdDLTUAFzxVe3x2weH5Sg12meZni/pRcVMQpMLdsEFTSEVq8e
         Nrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784227545; x=1784832345;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h5ybI5HJjOUi136pJ8MM8b9ff5G7zzP65amCAnLsIss=;
        b=nZWrdN01Lo7tJeE4fPKXJDOPIO3qqQGrUF7sv3PwuqNXwmlEG1nB9k+xle8fgstqgj
         cvIhuVnNTVlp4iWDW3abRy7aPBKbp1q4YITFPOAcn6uF7Tb3r1MEn+wvrey3Su09T5WB
         rITalPLJ8e5Shf1LcJe4DOHz6VVnRcO5dDSc3WMA11pEG8dND7gNg5YA3lQcULKsXuJY
         ZWWlz6G+EeHHPqXvH56FcECqOSE7iMZ8ldwmKnK5gjwsp9TY7Fe5A4PbJ5ZtLHu6igKf
         MFEDyBiObldqhIl65x+UsE/mmkBnzZd18jRsOgRPr6HKPKZHpFjUq5Ttin5FAx1X8oMn
         XgWQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpx6KrYm68wA9oVNuWNJVoiSbZlo0apKCeW8RHFc05VyB6msRo2/nbrYYPm4wryj1+79rLipSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/YWo1EpKyMExZt2ZvhnX58RmIuuO0mY4U4VJBB0edjPQXKa3
	wZ5uVmekXBu90XBcBbxXvAKGT6eothubpLQ1uY/y0REwWh9HnnNqKFHRvRSUj84UZhzd0hmNpOy
	0X26gxWgGE6QqO83RdshG+jyAWClPtj077SiZCDIPwg==
X-Gm-Gg: AfdE7cmHrigS7zAB+Q+DnKvKUqbbUSdCUipQqeW1Amr2aMT+c+v3Kb/JV7Erc77/f5l
	jUdpyc1hsniFcsz/oAih2IOOAN0tA4xioZt7TLPywTlC1rSqfzsXvsTgFWw2uovDwsBUTWuJ7hk
	cjQr4D9N+4prOEd3a4c2wWvSyrcGJQ348O/01/piF7fune8vpWRtZvFudUJJCLe8X0y8YQLO7QN
	JgYt/SQy+Xg595npeNo1dISLTdjvqK/eAuBK5bgAh5QMhDdi/bg10hMbN8ByMgoOI4nFcRYbGbY
	wEFJ4VN3Mc3dzWBA9FmhBDgJz+CpwvmR3sSCkh3Jce8FFJoZ
X-Received: by 2002:a17:902:d54f:b0:2c9:b90b:8448 with SMTP id
 d9443c01a7336-2cf1f599c3bmr41298095ad.27.1784227545372; Thu, 16 Jul 2026
 11:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710134242.216538-9-alice.kernel@fastmail.im> <20260716144830.337991-2-horms@kernel.org>
In-Reply-To: <20260716144830.337991-2-horms@kernel.org>
From: Alice Mikityanska <alice@isovalent.com>
Date: Thu, 16 Jul 2026 21:45:28 +0300
X-Gm-Features: AUfX_mw0lNMCLxfLoWUYDbY8GGV0eMPak-mSoEJPzaZ-GDhvVdCXEpqL0BviPOY
Message-ID: <CAD0BsJVygjPcoBgmYMyDQPjMY52ytbWzeO39YQoDDSb+TAhYXg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 8/9] geneve: Enable BIG TCP packets
To: Simon Horman <horms@kernel.org>
Cc: alice.kernel@fastmail.im, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lucien.xin@gmail.com, 
	willemdebruijn.kernel@gmail.com, willemb@google.com, dsahern@kernel.org, 
	razor@blackwall.org, shuah@kernel.org, stfomichev@gmail.com, 
	andrew+netdev@lunn.ch, fw@strlen.de, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 at 17:48, Simon Horman <horms@kernel.org> wrote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> --- Patch [8]: [PATCH net-next v9 8/9] geneve: Enable BIG TCP packets ---
> commit d560b2b7c8bd97bea9e23790fdfc21cfe031b961
> Author: Alice Mikityanska <alice@isovalent.com>
>
> geneve: Enable BIG TCP packets
>
> In Cilium we do support BIG TCP, but so far the latter has only been
> enabled for direct routing use-cases. A lot of users rely on Cilium
> with vxlan/geneve tunneling though. The underlying kernel infra for
> tunneling has not been supporting BIG TCP up to this point.
>
> > diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> > index 011bf9d833caf..a1639ad53077e 100644
> > --- a/drivers/net/geneve.c
> > +++ b/drivers/net/geneve.c
> > @@ -1745,6 +1745,8 @@ static void geneve_setup(struct net_device *dev)
> >       dev->max_mtu = IP_MAX_MTU - GENEVE_BASE_HLEN - dev->hard_header_len;
> >
> >       netif_keep_dst(dev);
> > +     netif_set_tso_max_size(dev, GSO_MAX_SIZE);
> > +
>
> [Severity: High]
> This is a pre-existing issue, but by enabling BIG TCP on Geneve, will it
> expose a bug where valid BIG TCP packets are incorrectly dropped?

BIG TCP on Geneve is not broken (and the selftest shows that), but see below...

> In geneve_post_decap_hint(), there is a legacy size check that rejects
> packets aggregated by GRO to sizes >= 65536 bytes:
>
> drivers/net/geneve.c:geneve_post_decap_hint() {
>         ...
>         total_len = skb->len - gro_hint->nested_nh_offset;
>         if (total_len >= GRO_LEGACY_MAX_SIZE)
>                 return -E2BIG;
>         ...
> }
>
> When BIG TCP is enabled and the Geneve tunnel is configured with gro_hint,
> large flows are aggregated by GRO into packets exceeding 64KB. This will hit
> the legacy check and return -E2BIG, causing packet loss for large flows.

...This concern looks valid: in the double Geneve setup with gro_hint
enabled BIG TCP aggregate packets will be dropped.

Since this is an incompatibility between two opt-in features (BIG TCP
and GRO hint), which doesn't affect single Geneve, can it be addressed
in a follow-up? I can see how geneve_post_decap_hint may be altered,
but it sure needs testing.

Thanks,
Alice

> >       dev->priv_flags &= ~IFF_TX_SKB_SHARING;
> >       dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
> >       dev->lltx = true;
