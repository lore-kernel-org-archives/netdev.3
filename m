Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7F1A275
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787256072; cv=none; b=YSWCF3wYaiLhnm98Wi7M9P/09nxD4rwfL8xaHKBbHna1SN3DdJpWRujZT+eTHlpA/cOTwGcvYZBVm6agdkCR8h/t1f5pN7K9r3SvCdtjgsQaBKyw7NDMy58xgwlj/q8eq4sDyEFAx6wmDZYIdbD1ENekkHL06gsagORr76gAoK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787256072; c=relaxed/simple;
	bh=KoFr3KfLiNqU+qjLrUuEUF8tX0xJv0sQLRNGQLly9cc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B1lCXq/XQ7HvHQMuPTAnn9VIJo6zOYdpWaTsrA2MW9986NqXX3juVPSR1a2dvuWz4lmUnz8BUQvv4C2YUvp+58gZC3n14IuIDGCwGX2sMriFYwVz2HVfmXCA1fUDXXsVuXOQZqHTacFR/q+hbgUc1Xng7CSjnVkn0C57du4fThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjPaIUIY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4urwWsv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjPaIUIY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4urwWsv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787256069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pD3DvaT7nTesVJaJoaCJAapcyGMzv8MlmrIcmgKcTBU=;
	b=TjPaIUIYe3am/HJHCXonWurS4jOA8Qg4RXBX56iicGy2l69thoNsG+EnnfzLBq3pe1zh2e
	2g6P6+x2OPIkOX9XuqrzL/TH/9lfLFtoajw4J/tsHr0JpZTIV29ZWiIdqiCxjXY+73ulKj
	WYsz57Vh3DFbvK36gCxb/ciCfBjDQmA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-hagXp1-ZPKWhKAfp3JMZxg-1; Thu, 20 Aug 2026 16:01:08 -0400
X-MC-Unique: hagXp1-ZPKWhKAfp3JMZxg-1
X-Mimecast-MFC-AGG-ID: hagXp1-ZPKWhKAfp3JMZxg_1787256067
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15e82278cbso13805766b.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787256067; x=1787860867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pD3DvaT7nTesVJaJoaCJAapcyGMzv8MlmrIcmgKcTBU=;
        b=a4urwWsvTn7tXFcC1ty7mV0cHqsh1MHhJ/sxIXbbUW86RczMBWPBjLw7YYFaiR69tq
         rM10tw/o66Jjo60goQVFzk1Mcs4nIl/uJP8kI9jL8hNerq1Ia4SWgna1UzJN3+1eKXDn
         j2ARq+q7AzqGSQlKaVu/hIBGAT84VNUEO7iiYDBsGhG2Nt7bQyyJkUh7qvJYDWIu49sN
         lN6QneEJicg3OqWyaMz23Kjgy9iGkVtist5zaoZE80iu/FwrWB56OPoePZKJU85NkIRA
         j1dfVV0QLkQd8LfdONqKHfzB7FhEWou5aQgVgDrqlOSTs/irtHgNxyirPPUIqDo57cG3
         zHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787256067; x=1787860867;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pD3DvaT7nTesVJaJoaCJAapcyGMzv8MlmrIcmgKcTBU=;
        b=NxbPtUeERO9U9YRgRnCgUXhrc8It2+L6w9rH71F7BMjZhPbxvz/x4SeVzjgniMijwq
         YVc8gbiRRtZzob0M7JCSHr9B/W+RW6etmNviyKc2NIGLZyAHXlsuNbUsgoem20Xty8Ea
         zFus7PjtLnQq8RwpB5GBUOpyuk4Aat/WbZ+OApOaDxbSPi2CY8QJmh4mGdDIKhfZ7FBU
         em8gkS2w/FYIiB7fmQ0Z/m44KPL+berMWNCOOBaRKHtQXer/H/Ym1ovvTyEjGWhnEXV1
         9ftj4PF3JOwgyxTW8tEqlkiK0lRVOnlIb9UVLuBysvtOsfZpTVE9YH2sbqLxO/X3nNIe
         i8Sw==
X-Gm-Message-State: AOJu0YxvORv/d7W8UKqz1XZYJ94SNz160jU97lC1WOsagdf4ilQaVkPZ
	a8O+X1kBl+Ywgl7oJSZGfTY1sPFmPiNIl5iTWico5oHfsLSJUZiWN12iXkM544i2xuXcdTx9Htn
	kxTS3iS7ul2bE34zcAO+EV4FB5zFB1iqgUUJkCYXcZVBxk/GZMfD0InlmTQ==
X-Gm-Gg: AR+sD11Y8cNdujC3L7VVRO3KE2fADQtQSpe3x9QdrvqmrOkr+BakTlNcqrVS95GAP3s
	Q1YHTN9e9IiQ/2lVbvJqkYQ98w0jXDm3Ie7Wf7yAEEyhfff594GYqjosp0PCGteiCTev8B/i1mR
	OTugR4EZ3ukO31+DlLCFvBMupjOG2Y97hVBTtj4XyLooqXhuu7hVrMG75T4aWoMSEvmmrMpVARN
	Y7CJseu/P4QjV3VqGk+D2/PXO0tTuiTZhmJ1Tmiz3tZsdNwVq6PDpfE0M5LZ5wryDmfZoYBEAjT
	UPzyN8IH0d/Ss0U9GuOLMl4ZLkLZ2zqEa9eaJ9ZvfOMKaLzWGnwg7aM9jkb6y9FXVJF4K1AqI7K
	lIQYjZnP4yHb59BZ9a7mPBFCJMo0=
X-Received: by 2002:a17:906:fe44:b0:c20:7457:5383 with SMTP id a640c23a62f3a-c2469f99e72mr80630666b.0.1787256066804;
        Thu, 20 Aug 2026 13:01:06 -0700 (PDT)
X-Received: by 2002:a17:906:fe44:b0:c20:7457:5383 with SMTP id a640c23a62f3a-c2469f99e72mr80625466b.0.1787256066377;
        Thu, 20 Aug 2026 13:01:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2458b0b00esm120551666b.23.2026.08.20.13.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 13:01:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CA04E940E7C; Thu, 20 Aug 2026 22:01:04 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Rong Zhang <i@rong.moe>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Rong Zhang
 <i@rong.moe>
Subject: Re: [PATCH] net: page_pool: Remove zone/policy GFP flags when
 allocating XArray entries
In-Reply-To: <20260821-page-pool-xa-drop-dma32-v1-1-6eab295c3478@rong.moe>
References: <20260821-page-pool-xa-drop-dma32-v1-1-6eab295c3478@rong.moe>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 20 Aug 2026 22:01:04 +0200
Message-ID: <87cxvcftof.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rong Zhang <i@rong.moe> writes:

> Net drivers request GFP flags according to both the current context and
> the device constraints, but the XArray entry itself is by no mean used
> by the device. Passing though device constraints to XArray allocation is
> a bug and will be warned and fixed up by slab, e.g.:
>
>     Unexpected gfp: 0x4 (GFP_DMA32). Fixing up to gfp: 0x82820 (GFP_ATOMI=
C|__GFP_NOWARN|__GFP_NOMEMALLOC). Fix your code!
>     CPU: 2 UID: 0 PID: 1071629 Comm: kworker/u80:1 Not tainted 7.2.0-rc7+=
 #1 PREEMPT(lazy)
>     Hardware name: LENOVO 21Q4/LNVNB161216, BIOS PXCN27WW 10/20/2025
>     Workqueue: mt76 mt792x_pm_wake_work [mt792x_lib]
>     Call Trace:
>      <TASK>
>      dump_stack_lvl+0x6e/0x90
>      kmalloc_fix_flags+0x4d/0x6a
>      refill_objects+0x10a/0x330
>      __pcs_replace_empty_main+0x292/0x5c0
>      kmem_cache_alloc_lru_noprof+0x4c2/0x680
>      ? __xas_nomem+0x3a/0x120
>      __xas_nomem+0x3a/0x120
>      __xa_alloc+0xd4/0x190
>      page_pool_dma_map+0xef/0x400
>      __page_pool_alloc_netmems_slow+0xed/0x480
>      ? lock_release+0x280/0x490
>      page_pool_alloc_frag_netmem+0xe0/0x3a0
>      page_pool_alloc_frag+0xe/0x20
>      mt76_dma_rx_fill_buf+0x1f6/0x580 [mt76]
>      mt76_dma_rx_reset+0x1cf/0x230 [mt76]
>      mt792x_wpdma_reset+0x183/0x1b0 [mt792x_lib]
>      mt792x_wpdma_reinit_cond+0x5e/0xa0 [mt792x_lib]
>      mt792xe_mcu_drv_pmctrl+0x28/0x60 [mt792x_lib]
>      mt792x_mcu_drv_pmctrl+0x3e/0x90 [mt792x_lib]
>      mt792x_pm_wake_work+0x2d/0x1d0 [mt792x_lib]
>      ? process_one_work+0x20e/0x600
>      process_one_work+0x230/0x600
>      ? process_one_work+0x256/0x600
>      worker_thread+0x1ec/0x3c0
>      ? rescuer_thread+0x610/0x610
>      kthread+0xf2/0x130
>      ? kthread_affine_node+0x140/0x140
>      ret_from_fork+0x2a5/0x380
>      ? kthread_affine_node+0x140/0x140
>      ret_from_fork_asm+0x11/0x20
>      </TASK>
>
> Currently mt76 and stmmac may allocate page pool pages with GFP_DMA32.
>
> Fix it by removing zone/policy GFP flags when allocating XArray entries.
> This is inspired by commit 96d578088085 ("iommu/dma: Use the gfp
> parameter in __iommu_dma_alloc_noncontiguous()").
>
> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them wh=
en destroying the pool")
> Signed-off-by: Rong Zhang <i@rong.moe>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

