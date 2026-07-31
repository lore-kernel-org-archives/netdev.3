Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6036998C
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528183; cv=none; b=eQ2V7n6UL83THEx3q99O/aUk0OAy1vZTu/TLkFIDbLKEMTuazNST4q5l08xcdm/zfmjoMIRDme9kXtNUUPNdH5GN2727v3FDU15tu5KNxexZ5ngLUKKUMDALO9g3BYhxVkibRkUzbTmD0jHQ3AmLyXBPNaSlI3rRqlzq9AVe+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528183; c=relaxed/simple;
	bh=CJE8GVvkniAQqCaYsAR2gmJYmQ8gaUT7KofGyLTuXh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmDcAdsz2SkmQdK8nLTdIFyZaWomj53kqYFCsb0YJQRj800RK+7sZU73elWvQDz0kNt/9wYnMfzyIwOa2Jtq84AqwdOFrRvbLJcVzfOc0tG8VVzqlmhP4Fyz0ZPhdNbycfXDgNTL2h/e75XHnwmNMoXKyeKK0P0+5u+8CugOPCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYOOdbQY; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYOOdbQY"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc2c6e0688so9716255ad.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785528181; x=1786132981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4O9q9bJyh69H6ktbFtFylGU/5hkkYd5RvJo0zQWtYpM=;
        b=MYOOdbQYkmHfDjb86sAl03Q1PFN9QMgoK4mFLpQhcKgLz9xNsp5cYBrWmNjocBWZFu
         GamQuaULQ3W9J2GNviac2s4g4iF2iWd4h1Um6HBjnBr342paVcJ83Zyw6gO7iQdBV9wS
         EJ9iWwxNHSbp8qsy3gBRIihTh1aoEn9mzDImjfo4KvElc4Hg/HDesWyFeTOC7fsEzL0n
         vyDHMIIuBaupb9beZ/sZG5c4c+M11PK9dFYEsIkfhZwdBN6QNlmhkPr9eY7gSI+4nH2h
         C6GFGTQRXcBUzMa5Zm3WYa5QXHJM/MNWtJoHcFPIfT0Bu2eT0QWDymZrh5YYRlRp8qNI
         vx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528181; x=1786132981;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4O9q9bJyh69H6ktbFtFylGU/5hkkYd5RvJo0zQWtYpM=;
        b=bQhh4EZFmUY1mZDl4WdKZUMDWf7sKC5zaShPzfZ+iH2THfej8WHisTmSuOIuJpkhHG
         NenhMWogAhujcakg4m+29ggbFqKRS+VwXdglR0S4QNo6veZfr2Puq69p2akJC2GTWYe4
         beH3pQodnXgh7vEaIHkbJEH5h5EVyTs+dHS7Bwo2uJomnJ8VtLBPJO6DBXFYM1UA94bU
         B8iX/vNEz4ulM35/7IQ64ZZ4wvi1x7lOZ9je2IJH61/UeeJSJf8zKRY2cz4nW8nSI5Kb
         3XDrwFndGC0+UXrz+XETvnFLmmiFs2QkjEYByOpIJbSInllSK0Pv8MV4jTj2fzVJzQsN
         /H+Q==
X-Gm-Message-State: AOJu0YyMm88mUmPAlx5rFi6uN4ClF6q2CfbF/56ENNdQi2OXgEIU35FV
	f6v1wdghj5WZ0HNwjiluoOkYr++c0hjnhMnTd1cV6LBuF0YFG9jhWfgJ
X-Gm-Gg: AR+sD12CREd4/yyCTCIVsGSjtA1ZBHa5lgg2xRkOfLvAydXn2460WdxnmT2vLgIbOh5
	rrNysJH4VJ0zS8iBcXADdGm/fB3bTjB0PVGZ/4IocH6YeXLFh8JZMb+Na7np/tfKE+ipEcFNgdK
	2P9Q5MudPxJ3KNzlf17gU0fuJPPfDEwZn9dhLRxW+4GqivFq+hQivra7tOyKzP3CuvgFh3W9Ivy
	Xo2Tlkb977mxGcTiGcRzXAGrIa1uqDX2RGhPpGAOEt0cSPbrnCQlD4x3c+EFiB3cN9BvRQrQVWl
	KsYEwRfr7nWU3wdsGt2vo2hXcBKLM1540s4JGhpDKxL4iV7xr8XD7g6kQzg9o6xAWBD3/D4F1/o
	uGLnBLCe6y7tvs1enfeiLbhm1IxY8oiMbv1zXM3aAyMETRVZRvhDLLQm9W5Oq8whQ4OQywMtRf+
	mn3pX10Psewg8e/VMxhb4ZFBBFXoLhxaflalLUPxL8aUQ3RFF/hKRtgg==
X-Received: by 2002:a17:902:dac4:b0:2cf:8131:75e8 with SMTP id d9443c01a7336-2d05221d386mr11733105ad.13.1785528181495;
        Fri, 31 Jul 2026 13:03:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19b9asm10138675ad.1.2026.07.31.13.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 13:03:01 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:02:53 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v3 1/1] xsk: account ring allocations to memcg
Message-ID: <amz-5UfOV4OZuj3C@devvm7509.cco0.facebook.com>
References: <20260731164623.4694-1-zihanx@nebusec.ai>
 <20260731164623.4694-2-zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731164623.4694-2-zihanx@nebusec.ai>

On 07/31, Zihan Xi wrote:
> AF_XDP rings are allocated from setsockopt() and can be mapped into user
> space.  The shared xskq_create() helper allocates the ring backing memory,
> but the user-controlled and long-lived allocation is not charged as kmem
> to the allocating memory cgroup.
> 
> The current implementation uses vmalloc_user(), which allocates the
> backing pages with GFP_KERNEL | __GFP_ZERO.  Use the same VM_USERMAP
> vmalloc path, but pass GFP_KERNEL_ACCOUNT so the ring backing pages are
> attributed to memcg/kmem and can be constrained by existing cgroup memory
> limits.  This keeps the existing zeroing and mmap semantics while avoiding
> AF_XDP-specific optmem or RLIMIT_MEMLOCK accounting.
> 
> Fixes: 423f38329d26 ("xsk: add umem fill queue support and mmap")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
> changes in v3:
>   - drop the v2 RLIMIT_MEMLOCK / user->locked_vm accounting approach
>     after review feedback
>   - switch the AF_XDP ring backing allocation to the memcg/kmem model by
>     using a VM_USERMAP vmalloc path with GFP_KERNEL_ACCOUNT
>   - include <asm/shmparam.h> explicitly for SHMLBA, matching the
>     vmalloc implementation's dependency
>   - retarget Fixes to 423f38329d26, the original mmapable queue
>     allocation that introduced the missing accounting root-cause fact
>   - v2 Link: https://lore.kernel.org/all/20260730153832.11238-1-zihanx@nebusec.ai/
> changes in v2:
>   - replace the socket optmem limit proposal with RLIMIT_MEMLOCK /
>     user->locked_vm accounting via mm_account_pinned_pages()
>   - drop the earlier socket/pool lifetime coupling changes and keep the
>     final code diff limited to xsk_queue.c and xsk_queue.h
>   - retarget Fixes to 423f38329d26, the original mmapable queue
>     allocation that introduced the missing resource boundary
>   - v1 Link: https://lore.kernel.org/all/cover.1785313094.git.zihanx@nebusec.ai/
>  net/xdp/xsk_queue.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

From Documentation/core-api/memory-allocation.rst:

  * Untrusted allocations triggered from userspace should be a subject
    of kmem accounting and must have ``__GFP_ACCOUNT`` bit set. There
    is the handy ``GFP_KERNEL_ACCOUNT`` shortcut for ``GFP_KERNEL``
    allocations that should be accounted.

I don't like that we are calling (seemingly) low level
__vmalloc_node_range, but commit 041de93ff86f ("mm: remove
vmalloc_user_node_flags") removed the previous wrapper and open-coded
it in bpf verifier, so I'm assuming calling __vmalloc_node_range here
is ok as well.
