Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58921DC198
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 03:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785901862; cv=pass; b=ow2c/Kc55gwsk2pZ2ywhe20fM7QClLEjrx1PLlJfRNeET0skumc5uF7GtaH0x9wtqvEowI0bl3CN7jb6MaNZEsx7z4v6+/gby1TRkrdIZX/kV8tfh+flCK/DYl9pMTS2J0VipJK45ejj0nBbWieE1Ip+Jzyv/3X9dk4ltS+Xsls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785901862; c=relaxed/simple;
	bh=RT0hDIqN75cmywbHP2fDE8uW020jzwTzWkeUpaNFKd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOp7zhizWd/zmDtuTZ1uRsNeMcHbY8fc+ItRG/gJOQgipzizuaX4d0ygsnrPW1I4enh+WdbYWAa/3oVEqJ7ZMCFEHFHwHCfuCURktw3BF1f8vgRLsr6CLEqZNiBiRbhyALAntssPKwKqqjs5u//LHHIPzokNawPT4VisrPEhVpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mk/O3vs6; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mk/O3vs6"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cede6375caso63895ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 20:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785901860; cv=none;
        d=google.com; s=arc-20260327;
        b=o2q9qUucicW8NVsl7R2K+6jAFHk/FuKj9os2aojxLrYavWajs5MEhB2xu1AVITce18
         qzd12PEX/Y6S8T3O5QyyMkxUk3Su+dPJTqP9O8phpuEjqT0wWOHhz1FCZD8+JavUipXq
         vCQCZatsZb0wWkxyvrw23LQvb6kbL82Gmy9cS83fgz72SKRYkLxyeiyGUgxdsQ7FPa51
         SMPsxeDOuEewDq2U2BHgMYQndvGJwY935/KPIbpR9sseOYvKnLcTCIXfPuCh+g8Mw69E
         hdCekbWUalKAlSddKj95aaFlDnDTfoWUSIn6ng7YMBqJhAwRZma1PxTcPbUhbHv/hMvE
         mz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fmi7y/J+AnH4wZb4ZPK6SvsLYlD8bbyAIu61k4b59H8=;
        fh=3uBQ4Cd7oMNHNFAcWlTqa6gIL22JqH3ViRPvlu4NddY=;
        b=NMeQh08thrAn7LTmfw0J0ageMvGqm3SvFolru39spBGFFFmt8jj4KrJq1KXtQlde1S
         1s3QelYrOFHYoe4Y4v7xd9GEjzUW0u5CSC7b+F7W+oYFL4fsRriTRq/KuVJNs3NDla1m
         sXmdvJj/nK3QHzCtSxlh0eCLmld5sxRVF5MTnFexEs3ulGvzOAJjCuENc/TiiB1Y51xp
         8cRTAGhFj96uZzDXMwTSOA22KLa0LmhsWiGL9Ql0ktl2n5jWxBLBSeabIMiXavnO2OH5
         oCap/MH+GOT2eTIVeFCqKwoZDTbkPpPwhMCK+wbr5G6oYvznlyuuboRKEUuuaQNfnjJn
         jPVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785901860; x=1786506660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fmi7y/J+AnH4wZb4ZPK6SvsLYlD8bbyAIu61k4b59H8=;
        b=Mk/O3vs6A+/MhlxGEAw8y2WfukSO+bmZCx1kFfYHkZ/NPPgJayEkHvEwO1IibJ7py4
         g4UYnsyn+j/YZVRVN0zaTRzQGc9r4Rjz2/dkG83QKxJKfD9isLAC3bIkITsLdEDA/arT
         oFSF/aEqG1CrH8ZhaiH6GlSy56737EQzsxpS8i0xW54XD00yCwztgyAJTGST9ZWWhelr
         KWrgN1nsFsmvO4L0S5bAvQoN2meVFyNnUBvj8BUenBHcQL5rqv3tAmed4l/vEOyMBlBn
         +vFa8u1UTm4dYDPiUuuo4fT4+ChLhdy+Th0Yp7s0tekvleywQO1ZLsgUYwjLE/5zWOrH
         Nrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785901860; x=1786506660;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fmi7y/J+AnH4wZb4ZPK6SvsLYlD8bbyAIu61k4b59H8=;
        b=R5VwghxNmvf1h3i/gU50rSSS7BzZ6rkqQUUdkHWrO2MT4NKEPG08THLgE+mVFWSdQF
         b90sik6Nf4+uxGwtC8rVOLGFhbm2j+iG6kx+GJ4i1PWaym8TRexmnprd1ZNKXnTBftbG
         Yzqudzb6B2P0BZwp3hBYrp14lsufMqIZNsY7rRjGSkNgC7PRJSmGuq/v+zGpocZ9jHfE
         bFb2g0au0TaJW5ewP9YcOxnv3CdO97itFycqN61GaP+UgOXIj/b3tFe7c8eBY3yd9FsS
         8bRDJuiEqTsKzso0LwToVZLppmKBqwYbgBcPe2SVy98Ix0LY7aEnFP9Z7r/aMtRdI52f
         4t1w==
X-Forwarded-Encrypted: i=1; AHgh+RryXUs8Tp7ZXdDirOZRli10aAecTVR7h0puXh2M19Ba38utVNqw6jDA6HL/0LREK4M6vpUvw48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWAy0sry86LZII4lgszsPn8lWgABVsX5FXcdtKDhs7KZ7hbyBo
	wvNadwS10aWZCbguQwVXsJlf4GdXDeesgqObmHDcII0QoOW591EfAf20ih5pkf5CYyniE7UjTQf
	UDbtrOLttdmAxq4OQuSjjpaUR6UlkObtQg5wdRs8L
X-Gm-Gg: AR+sD122l71cS8JMXVgJpKuZfoG6z/qfNfMaKq4IBEHpKxt/J9/iu+CD6FAGwmY9Ued
	e8lNAggfwZMQE/gvIoCdYyNWHlNAYcYCvbPAp/VuHOufn3ISCVLuS271R0EhTwP8WU2KytPlg9D
	7o8z3QGAIT4owf5CDgQSYUwjzygQ+H10c6tshbGdUJs5VbZzH7UQC/freNqN4lqtrEUXQH5F6j6
	noR+d5WcVuR0qia/BkvHOfCZPS3z7E2G2jTZfSudRn8TPx4tI1kzjmFfbS8AOX6ke4EXlu8qBjc
	LJ4jSiGymOzzK9oGXqUxrEy7rny7PIUzTCSs0+c2EqMr0Z5N+t8t6uwP
X-Received: by 2002:a17:903:384d:b0:2c7:f0cc:dafa with SMTP id
 d9443c01a7336-2d0d0702da5mr5773225ad.5.1785901859579; Tue, 04 Aug 2026
 20:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731111507.2355601-1-shaojijie@huawei.com>
 <CAHS8izPpwz=swSXJZhnVFvTeu43WBhtRv7PmC_OQ0XzG8no8bQ@mail.gmail.com> <20260804191628.762ec7eb@kernel.org>
In-Reply-To: <20260804191628.762ec7eb@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 4 Aug 2026 20:50:46 -0700
X-Gm-Features: AUfX_mxjUTDLa3RYzoYG80F8I31Eoy11lwHA9PZzsLvT730uyu0bLmqw3WiRd58
Message-ID: <CAHS8izMVqidVkiVHNWZMqP4Eoi5N_M3Wv1Cnn4jjxHf3=cWNQA@mail.gmail.com>
Subject: Re: [PATCH v4 net] net: page_pool: fix UAF in __page_pool_release_netmem_dma
 on xa_cmpxchg race
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, toke@redhat.com, shenjian15@huawei.com, 
	liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 7:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 31 Jul 2026 10:37:58 -0700 Mina Almasry wrote:
> > > +       __page_pool_unmap_netmem_dma(pool, netmem);
> > >         page_pool_set_dma_addr_netmem(netmem, 0);
> > > +       if (likely(PP_DMA_INDEX_BITS))
> > > +               netmem_set_dma_index(netmem, 0);
> >
> > I now notice that maybe another cleanup we could have done is open
> > code __page_pool_unmap_netmem_dma() in this function to cut down 1
> > helper, and just have the scrub function call
> > __page_pool_release_netmem_dma() to reduce some code. But this is more
> > than fine too I think, especially since this is a fix the stable trees
> > are going to want I guess.
>
> Not sure this is a good idea? scrub is trying to touch just the DMA
> mapping, right? It shouldn't try to update the page itself because
> it has no reference to the page, the page may get freed in parallel.
> Hopefully DMA unmap on a freed page is legal..

Scrub actually frees the page in the loop in
page_pool_empty_ring(pool), so it's not true AFAIU that it 'shouldn't
try to update the page'.

My mental model (roughly) is that the pp has a ref and that single
last ref can be dropped in the page_pool_destroy() path or the
page_pool_put_netmem() path, but the ref can't be dropped twice and
the same goes for dma unmapping.

Now that i look closer at the code I have no idea why we didn't 'just'
put the dma-unmapping inside of page_pool_return_netmem(). That code
path is already common between scrub() and put_netmem() and does the
synchronization between these 2 paths.

When I have time I'll take a look to see if an LLM can find a better
way to do this.

--
Thanks,
Mina
