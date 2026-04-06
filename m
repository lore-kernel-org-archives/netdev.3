Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0303909B2;
	Mon,  6 Apr 2026 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498058; cv=none; b=Q7T9iO0yIuoc1x28acu5LCTP3ZlnJZfCeI+q7x2yyyZAYZqKMIzNRbTXKCRH3FruM2FzMGYwnnhfnDj17uvb8LMI4O2vvjGGn008YQmTaJfVSZNzwxZtPZxSYkv/uqj8vOb4XyebwaFrE9JmpRe6VbKUHYAqGIL2gdBojbFn8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498058; c=relaxed/simple;
	bh=bJaqfa/gqe5hwOumVtDeoBhAL1x7A6nlQ0A9z2WKb6U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FUlicY5WX8DLSOZRsnVplUe/X0UuM5WijUGCvUr8jeO6IHfoaBX6CsT65TspydtsK1TQfIfMpO60gPWwb3MsdPue96y40XPPLwRi6Ke9zqiLXqjWWj6yJDfewTg/+UbbUEBUp7IKa5r0yo/YwV0EG6oP3Cw8qfrR3FWTnMDWYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K61I7HDy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K61I7HDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBD5C4CEF7;
	Mon,  6 Apr 2026 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775498058;
	bh=bJaqfa/gqe5hwOumVtDeoBhAL1x7A6nlQ0A9z2WKb6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K61I7HDy5O7GcGISve4miyGDAiyRNr8PSrYE1uJUq3cKg+RzdTcLuQ4n2sXaWeSK/
	 l9q5xzvMPUduw5G32AGCokoXyk3bIGihJtBI0dQE4wU9xq0C9I6ENYIdgz8fwXMZ8u
	 MlxXw8nUNNAWHKWp0u/3U0pEcm//25OMWBNdTEeY=
Date: Mon, 6 Apr 2026 10:54:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: linux-mm@kvack.org, willy@infradead.org, hannes@cmpxchg.org,
 david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, riel@surriel.com, kuba@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] mm/vmpressure: skip socket pressure for costly order
 reclaim
Message-Id: <20260406105417.28fda9587146a011af2fb876@linux-foundation.org>
In-Reply-To: <20260406174425.61692-1-jp.kobryn@linux.dev>
References: <20260406174425.61692-1-jp.kobryn@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Apr 2026 10:44:25 -0700 "JP Kobryn (Meta)" <jp.kobryn@linux.dev> wrote:

> When reclaim is triggered by high order allocations on a fragmented system,
> vmpressure() can report poor reclaim efficiency even though the system has
> plenty of free memory. This is because many pages are scanned, but few are
> found to actually reclaim - the pages are actively in use and don't need to
> be freed. The resulting scan:reclaim ratio causes vmpressure() to assert
> socket pressure, throttling TCP throughput unnecessarily.
> 
> Costly order allocations (above PAGE_ALLOC_COSTLY_ORDER) rely heavily on
> compaction to succeed, so poor reclaim efficiency at these orders does not
> necessarily indicate memory pressure. The kernel already treats this order
> as the boundary where reclaim is no longer expected to succeed and
> compaction may take over.
> 
> Make vmpressure() order-aware through an additional parameter sourced from
> scan_control at existing call sites. Socket pressure is now only asserted
> when order <= PAGE_ALLOC_COSTLY_ORDER.
> 
> Memcg reclaim is unaffected since try_to_free_mem_cgroup_pages() always
> uses order 0, which passes the filter unconditionally. Similarly,
> vmpressure_prio() now passes order 0 internally when calling vmpressure(),
> ensuring critical pressure from low reclaim priority is not suppressed by
> the order filter.

Thanks.  I'd prefer to park this until after next -rc1.  I could be
argued with, but....

What I'm not understanding from the above is how beneficial this patch
is.  Some description of observed before-and-after behavior, preferably
with impressive measurements?


