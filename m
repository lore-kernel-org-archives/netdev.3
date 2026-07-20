Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A899244CAF9
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569495; cv=none; b=BJfCTbmjXlfPBEqBYvDDLJMVlpPV/EqmbSULoFBAQ9E22BKnrlaZlPGyhkcySzjhYdXdRRPT//NqvvO1ul9WX8ybenQ6IYDzjx0yXuA0LGkLOOyuEuo2Bmom11ryoAfGoEyMgD71Fz9HQF3WFYJvKbKjC/5Gy/iEg9PpVYX7Xd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569495; c=relaxed/simple;
	bh=eQwLG50FQTlGIaxFUWOZqCCOrmund6wJNcAiP3xOaXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfSxCUJ4EmHhbBR7cFpkV+/7AJ9USbYuI4qBXD66x6KJkYcER9/J0KVaFhWTbL5VPuOp9avRvBBpKxuLL6zqjZsrE9BGG6+la5idxP4zSoUUEa/17WbWrH7ISnWSehfrii7RsdhR45ly5Uo4O9sT3TpCYOm+Qq1SxR43+jwQhbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=X8U6zM0w; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="X8U6zM0w"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51bfbe05683so94789101cf.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784569485; x=1785174285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fh0Ky+WC8JAb92VghcxhTRFBn6Go7CAcxa18f3039ho=;
        b=X8U6zM0wVzqBdPhme0rKH4934jbpYW7yQmUifhqTtQKugUMzjxrbWR2V0nbPkyGBQh
         9oEanJic11w4rFy7w4bJsWVLEdr5NvOH86f28My6ZAYChA3qDKSCIEKL9wDJXpQdy6MA
         H70tVAM4f0rgUzOwqE/Go3xFdHmvfIoFSdCaNE9AkeSJmHlr/FzvKsEoOo/ZSMe3xXi9
         A87GeIdVUoGCBJOZzbmTRjuSVMq8uoC9GucP2CSIV8hxiP9i0t4b3LQ0tUi9aik56pEM
         TPyyrvqsTIyBTT46XV/wt8ZLbanNjaaKY0I4Y79+bo8Uwas/HcYEKSSZM3SWmQXQgoIx
         R51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784569485; x=1785174285;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fh0Ky+WC8JAb92VghcxhTRFBn6Go7CAcxa18f3039ho=;
        b=mcI3tC4TfMf3KdjKUuOMwc2jVd3ybCDjlEh8Yg9RIt6RnhZOYs+6R+KppNulMVFndS
         okO3ndVAiqL3RhwTrelTExgg6BRu47GBF2Beb2xcHPoWTmZmmd2u9YHffqWGX7DVdaoE
         jDSpHW4xQR9eD3LJHEJvyqdZXhOooiQrIkhP2ibpnEXOmZ7k4c8ziWCSqJfGUQhSbD2p
         ELuOFt7VnwA/k7RDxkFBOYTowsZmKkNORDAhpK4n/nQQwxgy5hjBW2lvZgnYC7Ss54KO
         5DE5X2NRLpr1nVWdIezEnyeJyEH3v5CfKXiBsvFx2CM8NDlLmazMt9KZX91ECckPVZdW
         TAXQ==
X-Forwarded-Encrypted: i=1; AHgh+RqBzEIMqZ8uXh+c3oWARHZc2RE5lkOLnemf7/lV+VJb3+XckYesOPgLMLZCLrYExyFCnusw3F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIVTe5D4McSO1gmIgYTtQrwR8yU3ajz6X2UelJ5aaKjJgSCQjX
	Au63f3i1F5HEKMnUB8SY/rV3gm08OhBEYiQrFvD7HdnOOeaNQDBdGCOjeHojwNjefmE=
X-Gm-Gg: AfdE7ckAXQtK3afHC+WMxGgMchp1vWtLBYd8Qxkad7EWEqenlF3TR5NICwuE4EOSc4U
	ZJIauPcZKvRoio4gs+qpBkJm/a/1eJsB4q3NC7wwkaG5gsXBCSbdmbBvMQm5k43aREq7ybxr98/
	DN0UfPj2cZWGbgRQ088fNC48itG0lAoOGPyYLc4m3Vc96y1CJLfGWnPvNNC28rI0CN8zH3+BbkY
	Yvgljxo/2FoCL9wsHt8Ii1RyS9bOsVPD3u/5v4Y/pEx5pKhQzJMslaKxmsTQwqJfoFBx4Mo3zmV
	C72vPtIte+MBclgynQSfOk+1+JygKKT0l0D4exeNn35r1ZhVVtM8FhIrN52IKFSgyYNc7acGuCm
	+nB2sYzJnpC+kuhM2/L+LhTgkbkZohA9tSubegWIO3io3obr+XVjLvGz+Mla79hiAb7Ggbb8BKl
	DmaBMH5QAC6pXDGZnnz7HfWmGRl7I6ZKvePeELHny9hF4fLtbxIW7CGNi+Tw==
X-Received: by 2002:a05:622a:1107:b0:51b:fddc:1de8 with SMTP id d75a77b69052e-5213e67e2c1mr141645811cf.65.1784569485065;
        Mon, 20 Jul 2026 10:44:45 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214cda7dbfsm77462971cf.9.2026.07.20.10.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:44:44 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:44:39 -0400
From: Gregory Price <gourry@gourry.net>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev, loongarch@lists.linux.dev, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: move __folio_alloc() to page_alloc.h
Message-ID: <al5eCOfvXR3OZjVi@gourry-fedora-PF4VCD3F>
References: <20260716-folio-alloc-cleanups-v1-0-5363b8e92d33@google.com>
 <20260716-folio-alloc-cleanups-v1-3-5363b8e92d33@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-folio-alloc-cleanups-v1-3-5363b8e92d33@google.com>

On Thu, Jul 16, 2026 at 02:30:12PM +0000, Brendan Jackman wrote:
> This is no longer used outside of mm so reduce the scope.
> 
> Ulterior motive for the move to mm/: A later patch will add an
> alloc_flags arg here.
> 

I have a similar commit that is coming in on my next private node rfc,
i'll reference this, but i wanted to make sure i hit a solid mm-new base
so sashiko picks it up and people can actually apply it.

> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by:Gregory Price <gourry@gourry.net>

