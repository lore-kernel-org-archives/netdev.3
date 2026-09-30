Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D331356770
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 01:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733232; cv=pass; b=VDvK1iHYDnC9TKPVeQiYx6rWLZ0xhdR3U1+NiTI/H5VcPD9+jujOYkcpI0JfEA1y87MRI27g7piXqdCtJu0ynt7rNzOtbTK25Dm6NebUwG7JUQv4KVKBP36b+PgqEWVFgBxVn2KRH/C6Jwq/mcZZobknuJF+fWFVjnQncInvG9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733232; c=relaxed/simple;
	bh=rz3PBX9N+BAd/eBIFVTae5D5GD1xc+G7K4xDL5DNelo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmPTCBsnR+rh+2D9KdmzO6WzACfSYjk4HTtkWEeKisytdviYgCb8Dh8xBFClBEuxDXaslrolIFZqV+1jJC5YFKBN/qmY4OIbnCUhoUghwykHg41dLbc6hwDq3XfjUzZbRFOnh2XNX4gaDApHP/0u4LrZhNTdIiOIDbPkeXcB9qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQa4pnCS; arc=pass smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQa4pnCS"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a76a5a5d4cso9836821fa.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 18:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790733229; cv=none;
        d=google.com; s=arc-20260327;
        b=LLzrfMYYq4tEGMM51BRzgoZYPLFtcqi2850egZnP71kyaYoetHEFSFVOtMoOw/IBKf
         ACk0VsTP9jORMSu+DAfBJIKO4LNmmsOEqWwDodKcqB9zbsDGF4nkfg6hXzwFq0Clv7b6
         xE0y6YLrjAm4qdKKkJnLqWha9SbHmvUI+e4fTimvSoFmfSNqv0DoH5CeHVI8JNUl+3/q
         MJgJsLyuhEGCUh0wcwtTpI/uB1utRfqf6slF4nLmOat0KlZiEUfJEn5cJMt9fjVBH/k8
         5qm8rNbkIOsh2bQdFPZ832kz56u0c7jtrulwrQzuIffzBriu2aL1ENuI0Jf1vWrYWwlR
         JCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=spOmHjNOaypZuYVLaKMrhSzE4VciUVBWIcJjbAzki+A=;
        fh=PaUsRiqLZOjC3m4LpC7s3KA8CujjgH5K3SBZvW6FB3M=;
        b=Gew3uqyneXK6xSdaBgc91wOBLrMVgIe6TbFDrV/do3IgFA7Mz/9cQ5It2C42vepJkL
         wkOlwxW73WawprPGQnCcLhemyMQynkq36rGSqsCAwMDirSCghewlXZmoW+EAYsAoNV7+
         I21rcsfheNosUeCaKRtpoKEowSjW4xd4WTkQHvNf6YzD2GT0eyCi2qLZlXkz7THpN4f6
         Vt437gyLe4KX6P8W4gdoG9MC5FmAtYGUQ8a3dNBntkLD8zffblvFpg/Em+oKpHQ4oPpI
         d3AW64ksojbxgj1hDhiGoawYV3FiTnz2tLU/kxImNKpDJoWppHnGOgLrIWxDXYdYbpME
         Ub1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790733229; x=1791338029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=spOmHjNOaypZuYVLaKMrhSzE4VciUVBWIcJjbAzki+A=;
        b=cQa4pnCSXnytan6jeGcgPz5Wezp4KKnYb0SZoT2CWvpp+kh3STJWS7C87+qoZdUvpp
         kOsLv7THeRx1VsWRNdv+qY71CDhSwwvxEpwh3fbBSW9mjKuEac/3TynX0U+4dvuKuun5
         y6EWAf0C4BfExrcDp+5soXBqVaFaQ8xOoQXJWCSl0kw8JvUesmvtdlN+W3CS/Emij58H
         EK3PqJnCI9IBAiVrezKsfSfByiqe1DGIZWPkDf7R6nQ42LRiKECwuzqWZ4ahX6SEW6ja
         ausrw5aXi1DsvIGH/JiNWZm/yzYaOust+otErEOL6BkTXysC3UkMkaUZbgm5tfo72GlE
         7hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790733229; x=1791338029;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=spOmHjNOaypZuYVLaKMrhSzE4VciUVBWIcJjbAzki+A=;
        b=tA3gAKSY3UewtQbL+mmr+OxNxZj3jbBtx9TvxQkiqYOtkkyP4DgJYrhuK/KS5OVcJo
         RaKb7jlZcar3raaaN3aaCw4S5eujLQcbKDlveuI+CCaZqXk7zLYZ/h+Uo9j6mTSkwhGL
         G8ITPgeOogeCbTX/p9XbMv5lfRI+hZysr7S1WkPLR7Z3LYHXvWMuISXpx9xHSDCtUYNP
         gl7N25NCEe6+O0nxIYMNt64ibZkL+/PLg4137vixkjtmjr0DaFd2HN261aNIIINRUGSd
         tNrrOu9r9pQ0glhsExa9lM9BnguI/KZK3vSTJYC0GWhJXS9GfqVFMEtgpLpN51AV1BK/
         zU3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzHWWy2vk9UvsmYtG2d/GNY3a5eQQj50XItcO6rpxuDElm0K4zrqnaUPQru8FUaiTp+vnQspzw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLquCnIWi85bSQcJoaNLYJCSmW1ECH5xX0UP0KJEWrICDZBRlVu
	M1gNeVSvVqojtkZhlbalsmdepDmkOVQ/ejSxrSRkZ+p7KF/wKn8tswna5ewvf10RuwmAlnc30a6
	wXYB2ro++Blo2ruy40TQc4XmEw9yzOZQ=
X-Gm-Gg: AYBFou0PnKst7yZf1/ScfGwyRA4pp0UJt5jSXE9Ty+7KAMohwciNTCYWOeU9bc3bQFm
	EGOZu8zlfpYK/OpeDbmCw6AV/u6Uff4RkVjippit2/0colvIcLjg3j6kZkBgWqBahPBiaJgmgMY
	dSKQNQpz393EPMmRkdv8b9k26Wq3UaXlD2SrAXp/UG6TO+knDUyW5ldTbrfnr6FH2AGyd54CNBg
	YY0zboqdnYQ5HZuFtaqm1MAcc7Qe/L9IM1Bh0yylqmtw79iNB2w0tSj9rgeVRD1BNlqwy21O3Fa
	sYa56IAJpNSTqo4t/hOjEIPLIRDMTQNJ6NWL1Sfa+lh9lxxScCplKoNj4+lZ5tLHm/m49gjF8MU
	wohonjlSqcFuLParsv9LGStDqO1PuxYSSkQoW3G2zIjloxqKt63BAZeLDMybxoAOYSQhE9vs=
X-Received: by 2002:a2e:bc02:0:b0:3a5:b0f1:a2a4 with SMTP id
 38308e7fff4ca-3a777d41013mr209761fa.0.1790733228989; Tue, 29 Sep 2026
 18:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924152529.5689-1-kerneljasonxing@gmail.com>
 <20260929165318.6690d427@kernel.org> <20260929165425.53ee002c@kernel.org>
In-Reply-To: <20260929165425.53ee002c@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 30 Sep 2026 09:53:11 +0800
X-Gm-Features: AclHuK-Kr19vr3K_iHSP_46WRhuccUGAnNsulfgCYcl-sFeZiHyF7jbFaAO7_MI
Message-ID: <CAL+tcoD4MmRxD_5b06u5toAmBv=6HsbetEk3oZY337DjSS14sg@mail.gmail.com>
Subject: Re: [PATCH v3 net] tcp: preserve timestamps across receive queue collapse
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 7:54=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 29 Sep 2026 16:53:18 -0700 Jakub Kicinski wrote:
> > On Thu, 24 Sep 2026 23:25:29 +0800 Jason Xing wrote:
> > > When tcp_collapse() rebuilds skbs under memory pressure, the copy
> > > process doesn't include the right tstamp and hwtstamp from the
> > > old skb. And memcpy(nskb->cb, skb->cb, ...) copies has_rxtstamp,
> > > but nskb->tstamp and hwtstamps are left at zero, so
> > > tcp_recv_timestamp() ends up emitting no cmsg at all.
> > >
> > > In net timestamping case, if such an skb happens to be the last
> > > one consumed in a recvmsg() call, the application receives no RX
> > > timestamp for that call.
> > >
> > > Fix this by copying both tstamp and hwtstamp of the last skb to
> > > the new skb, matching tcp_try_coalesce()/tcp_add_backlog().
> > >
> > > Note that the has_rxtstamp flag can still be inherited through
> > > the cb memcpy from an skb that contributes no bytes (fully covered
> > > skb left in the ofo tree by the tcp_ooo_try_coalesce() ->
> > > coalesce_done path), so set TCP_SKB_CB(nskb)->has_rxtstamp to false
> > > which makes the new block the only place setting it.
> > >
> > > Fixes: 98aaa913b4ed ("tcp: Extend SOF_TIMESTAMPING_RX_SOFTWARE to TCP=
 recvmsg")
> > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > ---
> > > V3
> > > Link: https://lore.kernel.org/all/20260917132742.87117-1-kerneljasonx=
ing@gmail.com/
> > > 1. revise the commit message with more accurate description (Eric)
> > > 2. fix a corner case (where a skb can contribute no bytes if OOO happ=
ens)
> > >    spotted by AI and Eric
> >
> > Looks good now, Eric?
> > https://lore.kernel.org/all/20260924152529.5689-1-kerneljasonxing@gmail=
.com/
> >
> > (Jason, please see net for the up-to-date email addr for Eric)

Will do.

>
> I meant to also say - I'm leaning towards net-next on this one.
> Please LMK if you disagree

I'm okay with net-next. Seems like I need to repost.

Thanks,
Jason
