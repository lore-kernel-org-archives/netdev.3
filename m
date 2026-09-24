Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AD33CFF55
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235639; cv=none; b=D1vbbhYbM0/BGsJdpahyM/PWHTYAOAUCF7oxnD6mgoEvpTBL72M4G77y9Q+UYI3Yf7fISXguQ4ZSxRWMlF2KQL/bBg4qNNoWw3i/fbp/grGbYjpCD/QOXJ4/dvf8i+zUoGdGJclXhOlKbwl2A57F+bvrIULPMIJ9YIZxWaIn5bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235639; c=relaxed/simple;
	bh=HuXQKiXyqwaRIBRj0PWqB0UDG6ZRZs0Xpx3ujiYeORA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZ4c5EQkXt9N6yXKmR8A9cqO5t9GiwK9BYjIPs7ltuA0SvEYuxz74RrMw84a+wSjqIjQ96XpXmYPFAOyVoaS0d1kcdRlOLC2nejYBkI3pWdKZcXea1/SLnvQp983yjqfM0ruEsZu4O9j+pw0ZyuF44FsKvxXVWMwP4CUgCgkjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcAoZHQQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcAoZHQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB491F0089A
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790235637;
	bh=8AXPyPJEZm+l0/8/rdpy4BGeo6Dn2mK+9EBmXUewfmY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QcAoZHQQxulc5CRRUbV2qouMDvRRkrt3vabYElNj9cOokDiQwsWNzJsbDBT2WdY5E
	 am+NMesaI4GXBOlnBv9lEGUJyqPjJG4k7gDz2VV+LT3FYqM43H9g8oXRhNXnqmcnI5
	 7TikjYJY+LUaPPa2V7I52kJzvdjBpW0nS7wqNc6oOqDMoLNprxD39f7znYhsMfzhM8
	 TKtY8zsavcDWi/jR6PbRWHgsFF4LmlkdNTl3sxVknU1YDxN9KRI2SL+7FwKQHPpaAU
	 5c0ApFpjUg1rN+MgJcEb7UGlMySVCcEjFgzJ3LIBAZYj/23RAKyi8blitaS7Kcyfai
	 1lsHfyo9Kft3g==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f16f15so1616773e87.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:40:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByat3jtpB4NWdxiNarYorQBVVmNw0zCIUEW14DSgQu3kW2YujHNsMfWZWh0dUO0yP3a80Vj78I=@vger.kernel.org
X-Gm-Message-State: AFuF++k5HtcTEWOTjWFfgTMGekedTzVPZMyLG/MAaxorezZKiWsElldJ
	hRopQ9hcfDxBCx4rTheqkFwhlnnBU086HK3KPpwBj/NF8sqcs2OxPYxFMQq7WY6trU7btzSoUoZ
	I5OaeNCwc1eUlS0jeQammJ4MWCStd+Do=
X-Received: by 2002:a05:6512:3401:b0:5b8:bc5e:d0fe with SMTP id
 2adb3069b0e04-5b8df09adb0mr498247e87.40.1790235636377; Thu, 24 Sep 2026
 00:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920-gemini-ethernet-fixes-3-v1-0-3a2a50a83d89@kernel.org> <20260923182830.4f9ddc2a@kernel.org>
In-Reply-To: <20260923182830.4f9ddc2a@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 24 Sep 2026 09:40:24 +0200
X-Gmail-Original-Message-ID: <CAD++jLn_3CS92uSenowXOk+WidorPQKDHy6qQsG-z9xMOv_-og@mail.gmail.com>
X-Gm-Features: AclHuK8KE-VQeeyiAlcmXGXgy9XCBR4E2ZmMvogi2gsCzEgTGARuk-AYfvMKF8s
Message-ID: <CAD++jLn_3CS92uSenowXOk+WidorPQKDHy6qQsG-z9xMOv_-og@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] net: ethernet: cortina: Use page_pool for
 Gemini RX buffers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Myeonghun Pak <mhun512@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Thu, Sep 24, 2026 at 3:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:

> > Move the Gemini RX buffer management to a parent-owned page_pool.
>
> TBH sounds like weird piece of HW. IDK if we want to burden the generic
> page pool code with weird, 20+ yo drivers+HW :/ Well, I know that
> I definitely don't, I don't know if others agree :)

The current AI reviews actively encourages people to go and fix
really old bugs,  or code that hasn't seen a lot of love in recent
years, pre-existing issues you know.

That's how the patch came about that this patch is a "let's do it
properly in that case" reply to:
https://lore.kernel.org/netdev/20260917192835.58126-1-mhun512@gmail.com/

We have had, for years, a debug print in this driver:

                /* Freeq pointers are one page off */
                gpage =3D gmac_get_queue_page(geth, port, mapping + PAGE_SI=
ZE);
                if (!gpage) {
                        dev_err(geth->dev, "could not find page\n");
                        continue;

and it seems this patch set actually finally fixes that bug that was
bugging me (heh) for years and years.

So there is a bit of incentive to actually fix it.

(I also have actual users of the code, it's not therapeutic coding.)

> Also, please never put Fixes tags from Linus's tree on net-next patches.
> Either net or not a fix.

OK I get it.

Yours,
Linus Walleij
