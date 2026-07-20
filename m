Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF538D014
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590641; cv=none; b=qe6BNKXKJKpCB8sTf5cRmx9U9vF85NJR9yJN32CVP74Kt+5tYQAaadZuTevSRuiypBGMEWvhalecPmpEZdDLgwhnC0ncZGTzk9UvFs1eZJC2loOb5Bm0sSvkxJGraZAhQYE2FPlmYgiksDvFIF7qO6pj9vSkubnmG3zRz9e6BjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590641; c=relaxed/simple;
	bh=R1UxikRLhnbC2hTqM3Kybxfnf3TuLKUNYT5emxV+AX4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oTtK0wu/WG3AcmdJfsmNytgc2yCv+iRgaBVXLXf7qyviszWL0ok69mrnYr6p1jVO7nD+GIRs2VRGPT9piNE1gSc72EmzUMdCqMnWL0s9g0JcTs0/WRC7YwDVJZL+q/s2MQvLFudFvrr9JKHIeMIJfhV+tDa8/yba7s85R3OA5Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wugCydgj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wugCydgj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E7D1F00A3D;
	Mon, 20 Jul 2026 23:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784590640;
	bh=rLMx0ar7b0lxai0YpsdWOCNTjVsTBwIx6QYBGi9QgL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=wugCydgjbFkOX1X8s2L0G8BC59o+L7FeQRMsK90BS42DzpyYFsR3XqKs/EHsq5SYe
	 pzcutjFOunkVfV9psYybzH7iIHgJ0AmqCsK93isi2OKRkxbyLalNdbDoBdhRjhy+ws
	 JcJYP95kfcNHSPa+Ueg9TyGvO/O3CKVEoGw97nas=
Date: Mon, 20 Jul 2026 16:37:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei
 Xu <weixugc@google.com>, Brendan Jackman <jackmanb@google.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Lance Yang
 <lance.yang@linux.dev>, SeongJae Park <sj@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v11] mm/page_alloc: boost watermarks on atomic
 allocation failure
Message-Id: <20260720163719.cf37f6be63bfd88a06965761@linux-foundation.org>
In-Reply-To: <20260720-feat-mm-page_alloc-v11-v11-1-7376b02c27b3@gmail.com>
References: <20260720-feat-mm-page_alloc-v11-v11-1-7376b02c27b3@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 16:15:48 +0800 Qiliang Yuan <realwujing@gmail.com> wrote:

> Atomic allocations (GFP_ATOMIC) are prone to failure under heavy memory
> pressure as they cannot enter direct reclaim.
> 
> Handle these failures by introducing a watermark boost mechanism for
> atomic requests. Refactor boost_watermark() using an internal helper to
> support both fragmentation and atomic paths. Apply zone-proportional
> boosts (~0.1% of managed pages) for atomic allocations, while
> decoupling it from watermark_boost_factor.

Thanks for persisting with this.

You didn't retain Vlastimil's Reviewed-by: from v8?

This is very much a networking thing - they must have considered
similar things.  But my not-very-energetic attempts to get input from
networking people have thus far failed.

> This failure signature keeps recurring in production: a host running
> a downstream 4.19 kernel logged 144 order-0 GFP_ATOMIC failures over a
> 4h15m window, all through the same NIC driver receive softirq path,
> across several unrelated network-facing services on the box. This
> confirms the underlying problem is real and ongoing. It does not by
> itself measure this patch's effect, since the fix has not been
> deployed on that fleet yet.

We'll of course be very interested in these results.  Do you know
if/when they'll be available?

Anyway, let me get this into mm.git and linux-next so we can at least
parallelize wider testing with ongoing review.

