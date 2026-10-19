Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EE427FB37
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 04:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792382631; cv=pass; b=MEinIoOx+lCfEwRHKCsNaUHn6yMIW7cqhhHdTq5DNJTMm4XxOJC2m6t8qWsPMThDR9XytyNZAogrw+9y+PL37tVMah8BaXMByyK2XCbCXBbXRSPrFaGBg2EqwW42ko6A7NB6Udfq8f1o1ornBAbSbP8SCtOQZSoLb/17CzYpjIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792382631; c=relaxed/simple;
	bh=CIW+ToTVbqQoaNVdlwiwfKJlcQBOE+geoDENw1qF2M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGHTlx3DZTi9FaxTwwQWhzTIxgfwWe5/WiwP0tHtbaP034kCj2glK/oBdmNQqh9H6ZNOdOkL3IDsfAzj7cLNXITtBqp0POZyQMMlwmWzDiUZ/IexXgMfZLD4YYg3mkzCaldOxCCPVS5DtR2BSQh3OQeMklSBfDHUXfRsE2sGpmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqSgv3s4; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqSgv3s4"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-483c607ccb4so1085289fac.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 21:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792382629; cv=none;
        d=google.com; s=arc-20260327;
        b=rz4Ud6yh6+ImurDVAbLQ78EaGly7rhbLSRvYez+Xd10oVrktYL3k4LE1JUC4xBuApx
         TIDYeFaMkCmk3fPaeA/NjdIeNicDlOZd4QOItvcxZF4rtp7U/ahP/6Y+Jil+vkW94w+5
         qcOEm95IJfGjaEvOv/CkSYsMDtGq/tKU9oVQ96bmNqWkfA/o27Tv/vt68sOvvaj9E0pS
         WL4PXH62rd15P4OCgINsE50CamxwXcQGFqMbn3PGcFAJR0rtOB7mt9bKoL+L1Ok3GHHl
         FwhLsAEAPZelmEaz2g6j4qdkZxqgUv4TJNse+gXopwo8eg6tg8wuyf97GpEWeO0QdYjl
         7X0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CIW+ToTVbqQoaNVdlwiwfKJlcQBOE+geoDENw1qF2M8=;
        fh=122vTSsTbIy+cdqO9+6+9OmkLqtslp0LIs05sSsYSYI=;
        b=ifVXtg1NACCD0A6PwOYcBFYXe5Zcy46TvUPOLYxnZLIlbAp5CUGySuF3KhtMg7sErN
         qa5+6lhHaN3m2S6MbQ3gt5U5X1I/eKgvmWHWGQPFagx/zHTjkCL6OyKlr63W8HfTfV1O
         eJFWYMPLuZGJNXmM0zyOv6NqjwCmromLX/2NL21FMAHzQ6HnEAy1jjfbPJEiOSZDbmjr
         u8Ka5BPKi5AxyIi2S/Tf2d3ZNhGVEr5WMOxEQh4zd47HK7qsHUb16H/OiGER838bKUj0
         a1QpdOymwrS0Uh0oIR5gR9yRWXqreZmPWh8lsA7IyRh8KQ7NyeGR2Oj7zoSxNe1Xnw6b
         mOsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792382629; x=1792987429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CIW+ToTVbqQoaNVdlwiwfKJlcQBOE+geoDENw1qF2M8=;
        b=YqSgv3s4dSUP0vM4KZF89nMkcpCECDRnwk0k2waM6RwPPDH+gmvtTNcK4dCjjt2Hkb
         4Wj577mpQAWgRog4dYC+1ScnrwY4rvZc8P3Vqszovz5OLqMbjvqrAR/3Cl+012bXrfo6
         5OTMaGj1n3J48NwDX3O0MMjiMLIghr75tbnhLXkA2xt1+D4BVviuq+bzNZ1RO8wdZHDL
         zAwn0rexXIoDs+z8GJPclP9AIwclx5iKiNHuYXwDOWgTIURbiqWGnhuC9ljYl+cM8WPi
         nlx0En4SuSj/QcmiiSZhj+XzjlNlhAHAZ1cIUfY1VCnKUq/IIYby8jNwZ3StCOAtGNC9
         8RAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792382629; x=1792987429;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CIW+ToTVbqQoaNVdlwiwfKJlcQBOE+geoDENw1qF2M8=;
        b=1XFXhJ2FDuPuXLn3kbRzDEIebGnAOkGwaMnz7aPVqPmmmjpSqNie9P+FEvT0FXemcZ
         jyL7p4cix4mqGT9GhdsnaYMZ3cJlTU3xVXRVT5C1geKVTDsQq1RtKnpU6KxpbeqRIou0
         fBzPO4xEH4+HsQAHOM6s2Vh7Euc63pLabTb6QL+nlyTJYHLraskCeVW/1HsttB8+J8Mw
         UEHdL5m8OKmKhZyNqw9N8s4f0tisWgP+dN68w73ZUjQhrIKThallH14JcZL1uJeCjOPg
         puqFzbdkde8cnXarn+/qn7+NOGxrguAx4nC1VVkPpZ9jUH71nH5uy9MK0qNuZwmv0PVn
         lMug==
X-Forwarded-Encrypted: i=1; AKwUvBy/XaziXyBYnRYlkpmh+2Bpir5C33kixOEg5+nTeyktAgyrM+8/xZKsCQbdnSXoQnwtyRwPXYY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+QRAeTN1yRK59dW4fpyIofjmLpqMFnvdICSavlf0+/xp1UYWB
	i1mtNqtQqYE2YuItWFGaEEcl148fezzoGJSaJGndf5aJ95w3FEre7HFGSjJtyIoGLd00EygXrGw
	t3IcyxO7Rcl0xDYuyiZKLLB8SBTdIcnQ=
X-Gm-Gg: AYBFou3vfBiBAvTWVE0pHFoOgdNLIqVenkfA0cLi/3Neu38x32VkiDQ+gA/POATI/4e
	g1Wmxra5IOkQ8SDuLOGeIw2UPwC7S2NauFFU37J0ntugnVjPDT7NjSsKxoEH3XREpIM7JcfLhMv
	CVOIhLq+XCCldyK9Spt5tDbSB/0cBhUInwj90awChSyWjvGN34ncgnOnBgcdH1/hXGZ8gpdh+le
	Kl37bdaWMn1UGFDesDd/a8ZcIwvVXymLBsQYznScFqMvqwATxSU39nzo9W5/TdvEt3bdSNOP87I
	5n3JHwP2x9ecHTRJw4QE1LeWQfnj8RhT6fi669hBQq5HxO0iYpH/pdVEOxDQGK51o5cXn+hmEyJ
	IcB7ywWHUC98=
X-Received: by 2002:a05:6870:ebc7:b0:48f:e0f6:bd65 with SMTP id
 586e51a60fabf-4a757b88c1dmr4939128fac.54.1792382629017; Sun, 18 Oct 2026
 21:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de>
 <20261002115850.962676-6-o.rempel@pengutronix.de> <CAD++jLmPfzi6FqF+xYFJoAjqz+Q9Ax9vhUp-MjUSFNTwOPAn4g@mail.gmail.com>
 <CAD++jLnYB2ec6yOF2so7W8kkq3PR-+c2kCscTSxPuGVC-L5G4Q@mail.gmail.com> <CAJq09z4KZ6kpF+VCTiezEVO5QU0fmYfdLNwn0gR7sjo2mHXh1A@mail.gmail.com>
In-Reply-To: <CAJq09z4KZ6kpF+VCTiezEVO5QU0fmYfdLNwn0gR7sjo2mHXh1A@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 19 Oct 2026 01:03:35 -0300
X-Gm-Features: AclHuK9naO_zjEXSAv6PCgSCRLxnEU2QjLcGyFLY4_gQv1lLumh-xoIf8M2jgmM
Message-ID: <CAJq09z5rWdb8SZCEpKesN1w+_7e8HreVO9aZd=EY4aWwkXtWOw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 5/8] net: dsa: realtek: rtl8365mb: store the
 egress queue count per chip
To: Linus Walleij <linusw@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > On Mon, Oct 5, 2026 at 5:10=E2=80=AFPM Linus Walleij <linusw@kernel.org=
> wrote:
> > > On Fri, Oct 2, 2026 at 1:58=E2=80=AFPM Oleksij Rempel <o.rempel@pengu=
tronix.de> wrote:
> > >
> > > > Store the number of egress queues in the per-chip info structure an=
d
> > > > advertise it through ds->num_tx_queues, following the ksz driver
> > > > (struct ksz_chip_data.num_tx_queues).
> > > >
> > > > The queue count is a per-chip hardware property, and this driver su=
pports
> > > > several chips of the rtl8367c family. All currently-supported chips=
 expose
> > > > eight queues, but keeping the count in chip_info lets the QoS code =
that
> > > > follows program the priority-to-queue map via the ieee8021q helpers=
 for
> > > > whatever queue count a chip carries, so the 802.1Q collapse is corr=
ect
> > > > rather than hard-coded to eight.
> > > >
> > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > >
> > > RTL8366RB has 8 queues so it's fine to keep this separate
> > > per-subdriver.
> > > Reviewed-by: Linus Walleij <linusw@kernel.org>
> >
> > I meant RTL8366RB has 6 queues. Hm maybe you rather want to
> > store this in struct realtek_variant and have the core
> > helper instead?
>
> Hi Linus,
>
> Right now, the common realtek core doesn't handle any queue or QoS
> logic yet. In rtl8365mb, this property is primarily used internally by
> the driver. Moving it to struct realtek_variant felt premature since
> rtl8366rb doesn't implement this functionality yet. Unless we want to
> refactor both drivers to share QoS helpers right now, keeping it
> private to rtl8365mb's chip_info seems cleaner for this series. We can
> always promote it to the variant when rtl8366rb gains similar support.
>
> What do you think?

Never mind. I only saw your review on the next patch asking for shared
helpers after sending this. In that context, your point definitely
stands.

Best regards,

Luiz
