Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF03F65E6;
	Tue, 13 Oct 2026 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887743; cv=none; b=ReOAhOKVNypbFEXBaQPzqEJoPC+Ar0YAL1CgpARQUWnbgblX+jpP/z5AHDE0cFCKoUNHkIWpwGRdsxbHLzAxDnP6IuHrAR3mG42C1DkmxcOjUEE45nmPW3sNKCSp+N26jCJ2wPqNB0V7JsKq/CzCLzEy9FH3Sk/izjlhKLPCVZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887743; c=relaxed/simple;
	bh=mTyd3PhUElHUVUBqe9hhUBYvWwKltnX4KUT3qFnptbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAR1wjMSGwzNVY0od3yYaly6YUDVW6ihKY1INF6XcLE/Mrj1XuaWBn3Ek68r/UOoJUpzyQSvgsdWxAKJ+O6bdkiFSyGVW9YwZsAE2I3dWLFsp5b2GQcfznKDMpjQqcgklLHlj3u/NPVzSH6a+7fSfRaGqCPipsi2fmRq9xsF3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p1zOaNkA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p1zOaNkA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w+3fStK7hRjLi1V48B6LtaGduvjwdLOV+yd6wwqyTCY=; b=p1zOaNkA5Usi4UWE7aCti/rl0v
	DJc1bl084NZdBWbc9W14cG8GgQouHaThwIh7xjDMaqqW3rlPWlSDV+QJdcSyAU9kZaw8pgNzNsFHP
	iyh8QQR6EIw8ghIXwPFM0kssWYhW7yXmlj/AfTMNvqjsc1PZ3npsr7uQygoPYQIFLsXKCTxgyUPfS
	Jd3m6G3BqJ1lqqh6huV0cV463M5ZJ+5LgDwyQbSM7dfEaOrh4l1zveBxNRNfLOhBZNAC0YRGr2X8D
	Uxw44MNh+K7CGrXjzHk2fqsUTm64oB9aRb/HSbcO4l4dHBEyVyl9ncWpklA8MrOm0N2rCucbRpJkm
	Hu2t0LrQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGZr5-0000000Co2B-0MX5;
	Tue, 13 Oct 2026 10:35:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7761A30015F; Tue, 13 Oct 2026 12:35:34 +0200 (CEST)
Date: Tue, 13 Oct 2026 12:35:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yiwei Lin <s921975628@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Jon Maloy <jmaloy@redhat.com>,
	netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] rbtree: declare augmented callbacks per field,
 fix rb_add_augmented_cached() descent
Message-ID: <20261013103534.GX4121339@noisy.programming.kicks-ass.net>
References: <20261005093236.62702-1-s921975628@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005093236.62702-1-s921975628@gmail.com>

On Mon, Oct 05, 2026 at 05:32:32PM +0800, Yiwei Lin wrote:
> Peter Zijlstra (Intel) (1):
>   rbtree: declare augmented callbacks per field with RB_AUG()
> 
> Yiwei Lin (3):
>   rbtree_test: use rb_add() and rb_add_cached() for the basic tests
>   rbtree: update augmented data on the way down in
>     rb_add_augmented_cached()
>   rbtree_test: use rb_add_augmented_cached() for the cached augmented
>     test
> 
>  Documentation/core-api/rbtree.rst |  27 ++++-
>  include/linux/rbtree_augmented.h  | 194 +++++++++++++++++++++---------
>  kernel/sched/fair.c               |  70 ++---------
>  lib/rbtree_test.c                 |  62 ++--------
>  net/tipc/name_table.c             |   7 +-
>  5 files changed, 181 insertions(+), 179 deletions(-)

These look good to me; thanks!

I've stuck them in queue/sched/core for the robots to have at and will
push them out to tip/sched/core soonish.
