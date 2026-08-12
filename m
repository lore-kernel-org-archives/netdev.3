Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF61409604
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532328; cv=none; b=YAGrJgi//tmIYsDeESOPsqH57JwEWa59h89+bwIK/uOAivt/CVoRDPFTaSQmEwM87/wWAwtK7HXsOvPFikGp/bErAAuLnruHmaYqIiYgQPs7nrHfedyHgRsZbr0V7lgKy0kpAaHbKfSVhUD65jE+xasYfNps32FPqUYXi+Tr4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532328; c=relaxed/simple;
	bh=guDqS5DOTl1ciw9GW8z+w6XQKajOgZNYIcMeYJn03WU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qk3nN7RGoYg4KhQYQc/kSKqOsU9zKenlXd59OtFeWGwkX2toSbQi619Bcs1hPPkGM4JG9drDyoaldrt8L02rn7wRu+OL8lRuwSgI+ZQ/AQSBJooJD3jI6/YZf146eWzR43F6eM10YZ3tSVPTbmqAiAsv/knVAy/ZwSvQm4P5D+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9hWEd32; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fyS18MAW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9hWEd32";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyS18MAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786532325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1uqKHvIWqRNQVhAsr7RSW/rn4d1OBxET/ZaNqcZkjg=;
	b=N9hWEd32UqUk2WUzxSj8/FPXdK6LU5stem2Fc2hgIvBBBNJ++YsMJCh4++CpveEY53RP72
	t+7ygBfuIZTKR5CbVcUIIGNOx+3apB3z66dWIE1DvKeEvI2dAqqimqawTWfuA9t8C5/Kxa
	Icu5UAbptpvNCAvCvw0Py9gWFNp+EjE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-W-j0To0QPGmp1SwDCwW1Aw-1; Wed, 12 Aug 2026 06:58:44 -0400
X-MC-Unique: W-j0To0QPGmp1SwDCwW1Aw-1
X-Mimecast-MFC-AGG-ID: W-j0To0QPGmp1SwDCwW1Aw_1786532323
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a171a3be39so1110898a12.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 03:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786532323; x=1787137123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x1uqKHvIWqRNQVhAsr7RSW/rn4d1OBxET/ZaNqcZkjg=;
        b=fyS18MAW8xLJdudmlA5LtWfh/Y5fGkbC6VFs9CBwF1OOLR+DjyPqP34rvaQMUabCys
         HyxszAexqb4q7IZbys+qwzTQM1EnTyzDoWehLZAHE+pJL3wIOeljYmYmWTccHfRYbdzR
         HuEgEJOuQo58s7iZaAAWRJRz9DJ3LAiTVXwwPbHiIwDOMtxxo8jIGoiPT1ll7sP0rUFQ
         KQpYZ/i1qD0ustjxsrdP6/yyfM/uAs6JAKjArkIhHI0+mi9M827i49hX58ku3vHJg/Du
         U1dpwaggwEF2kQDKejcOe40NNUO/tF3VJ+JVTmqhZLk5y8MGd4Q7WmwO7XHDzc6rworZ
         WgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786532323; x=1787137123;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1uqKHvIWqRNQVhAsr7RSW/rn4d1OBxET/ZaNqcZkjg=;
        b=pLRp6JTnUFg/HnVOO+VysmT7jYwuHARHk8J34gBlfIkOVOxAD2npmUcEawalZHmdfP
         XdGeBLxPoqRTHu7w0P/3B738HtO4QRMevU7RV8lpZ0d/wsUkosdEDXQ5CoDKr0Xv7Psy
         T8UYGhgrQpfu2kR91bxQxhIDpHrE19VGcVYNNYCpK5LHuZniN29Tu2oWdyNCDreBVDOP
         4xRpGRcPeWzYOTfU8LLl5Ook6yOG7+6Hb1Si2uUK0tZDnjIlrQXyGbsjvF7EXLz2TQ+v
         Q5NFjik/qMDS98iBEqFUYzZdCJwG90PNLJ8XcJ/fQzMZ6KX9uI8vS94y6xxmaHql89he
         FU/w==
X-Forwarded-Encrypted: i=1; AHgh+Rr7T0fUjJMJSLZhAFAumrKsoqpFak+WKZ9cwSY9TgEF+MMntphxKgGcx13HnJCgK448ZwzAw4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVzG6DKMSm23SQivrnLyt6ZcVRn6l6fgz2vA6OBBv9bDEF4o+n
	3rRPY2efsJ+uYH+L+J5kidOWkQGfR6w1sYe8FYNHVB/jETK3kx3r3CIp9sA4Up0kWq9/zlaeJbY
	fHxMJ7q65yqFCPuKfOc7EVVmZyNCQa7Jz4i4+OsMIjiBkLX34bftwAYaBuA==
X-Gm-Gg: AR+sD13VhR+avtuBe0ytNVm0cjP20qlr1QVcFi1AO4UWw84utl5wzZh9kXbxU95vQ0B
	FdA4wMfyPHKM708dcsT7xpqLDi5QdsBMyzCyi2khJIS61kIfZAZ2cWE57A9iuxrrrJ6LH8lx0XZ
	mKS6AyAWEMgsU5YM/i0ZJ3uwybmZck7O11ul5vukcHgCyb8ptIi2MvydMkra4FW+EPcOArMBmq8
	DMH9eiE1cT7YnAH4M1eJ7YcQc/7os1T3MBRhJHHr/NaLU4swld0U34WuBQllVxuricyRV3vwpwa
	VCUf21A4IC44swXMBA5MmpUdnEsJHjHl/p1V6hTJfEytSQvIBhe0dHrIV6wQQHKTEhv7h+s39En
	6qZU7esWtRBDaUBP8NWFEGlmv
X-Received: by 2002:a05:6402:44d8:b0:6a3:6683:ed6b with SMTP id 4fb4d7f45d1cf-6a375eaed0amr1588954a12.6.1786532322759;
        Wed, 12 Aug 2026 03:58:42 -0700 (PDT)
X-Received: by 2002:a05:6402:44d8:b0:6a3:6683:ed6b with SMTP id 4fb4d7f45d1cf-6a375eaed0amr1588931a12.6.1786532322316;
        Wed, 12 Aug 2026 03:58:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a376a08faesm523758a12.23.2026.08.12.03.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:58:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3938A8FDCDA; Wed, 12 Aug 2026 12:58:40 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, almasrymina@google.com
Cc: shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 yangshuaisong@h-partners.com, ningwei15@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, shaojijie@huawei.com
Subject: Re: [PATCH v5 net] net: page_pool: fix UAF in
 __page_pool_release_netmem_dma on xa_cmpxchg race
In-Reply-To: <20260807114830.344336-1-shaojijie@huawei.com>
References: <20260807114830.344336-1-shaojijie@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 12 Aug 2026 12:58:40 +0200
Message-ID: <87a4qra9lr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jijie Shao <shaojijie@huawei.com> writes:

> This bug was discovered while testing the hns3 driver under channel
> reconfiguration (`ethtool -L` / `ethtool -G`) with iperf3 traffic on
> arm64. The race is intermittently triggered when page_pool_destroy()
> runs page_pool_scrub() concurrently with page return via
> page_pool_put_netmem() on a different CPU. A WARN in
> page_pool_clear_pp_info() surfaced the dangling DMA index bits left
> by the cmpxchg loser, which led to the investigation.
>
> page_pool_scrub() iterates pool->dma_mapped via xa_for_each() with no
> page ref held. __page_pool_release_netmem_dma() currently reads and
> writes netmem fields (dma_addr, DMA index bits in pp_magic) after
> xa_cmpxchg() returns. The unref path calls put_page() unconditionally
> regardless of the cmpxchg outcome; when it loses the cmpxchg, it still
> frees the page before the scrub winner finishes these netmem accesses,
> so scrub touches a freed page -- a Use-After-Free.
>
> Fix this by splitting the DMA release into two functions:
>
> 1. __page_pool_unmap_netmem_dma() caches dma_addr before xa_cmpxchg(),
>    does the cmpxchg to remove the DMA mapping, and calls dma_unmap on
>    the cached address. It never touches netmem fields after the cmpxchg,
>    making it safe for the scrub path which holds no page ref.
>
> 2. __page_pool_release_netmem_dma() wraps the above and additionally
>    clears dma_addr and DMA index bits in netmem fields. This is safe
>    only when the caller holds a page ref, so it is used by the return
>    path (page_pool_return_netmem).
>
> The scrub path calls __page_pool_unmap_netmem_dma() directly; the return
> path calls __page_pool_release_netmem_dma().
>
> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them wh=
en destroying the pool")
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Assisted-by: OhMyOpenCode:GLM-5.2
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> Changes in v5:
> - Replace goto label with if block per Jakub's review.
> - Add bug discovery context to commit message per Jakub's request.
> - Add Reviewed-by tag from Mina.
> - Link to v4: https://lore.kernel.org/r/20260731111507.2355601-1-shaojiji=
e@huawei.com
>
> Changes in v4:
> - Restructure per Mina's review: merge page_pool_remove_dma_mapping()
>   into __page_pool_unmap_netmem_dma() with dma_unmap inlined via goto
>   label; simplify __page_pool_release_netmem_dma() to a thin wrapper.
> - Link to v3: https://lore.kernel.org/r/20260729110249.2824835-1-shaojiji=
e@huawei.com
>
> Changes in v3:
> - Fix unlikely() to likely() for PP_DMA_INDEX_BITS to match
>   file convention.
> - Link to v2: https://lore.kernel.org/r/20260727132612.3277927-1-shaojiji=
e@huawei.com
>
> Changes in v2:
> - Redesign the fix per Mina's review: v1's unconditional
>   netmem_set_dma_index() introduced a UAF when the scrub path
>   (no page ref) writes to a page freed by the unref path.
> - Cache dma_addr before xa_cmpxchg; move dma_addr/DMA index
>   cleanup to page_pool_return_netmem() which holds a page ref.
> - Rename page_pool_release_dma_index() to
>   page_pool_remove_dma_mapping() to reflect its new role as a
>   pure cmpxchg wrapper.
> - Link to v1:
> https://lore.kernel.org/r/20260724092135.414699-1-shaojijie@huawei.com

A bit late to the game (just got back from vacation), but LGTM:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

