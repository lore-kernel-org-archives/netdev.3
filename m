Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3203B4423;
	Sat,  8 Aug 2026 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786179721; cv=none; b=Ibh0QPCjgIApjXl1xBpmPYs2XxjS3je+s2BfVjP+A+F7+itz7Y0EABaSCW/z+59zt2yxN+/RAzl4pHlEovDM0P84wC3+bI1WrvSaBO1Tq9kgLO8vE10nddt8ci7Y+B6NmFJY6GkCRad78g/7OiDTqlmExv05CPNuw6e6dGBupMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786179721; c=relaxed/simple;
	bh=62QgIjRPmuHGLS2qksqEprqJ+VnHH88j0ClesfgjsMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4/C6bR6pPr2SX21QtorHrBHQ0DpbFlwKV7A2OzdZoxnp8lPYIaoukiD1FVupllYvTnqVahv2DwT4M8LZQXxcmysuA3Jo6ABcJwy3f2E2WeCxCQ5ngcuJNRCTGwDLB84sOU3hsSxSzYrvsZ9wINXGhzt7ZVV7anG+wke/0GU6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QvRzy2ed; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QvRzy2ed"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=62QgIjRPmuHGLS2qksqEprqJ+VnHH88j0ClesfgjsMo=; b=QvRzy2edg7+BtT1irb+jWs+xZg
	WKG3JADZsgD5983Kjk/ygeoKuAkatqmMqlNpRgw4tmHcqbtk5RvpWf+Tj7w2qX7wKq116yMHHFxca
	sjWHI8/4trMi5q/7wYFkOHpOQWmd2pw8Et7oQycCa/bpsDof/8hbJQxXhHcdQsGsnVveofDFKoC5U
	tOlK4kph/jqAF9ehvB22UxBpDyhq/8h2moL8x1VU9XRtWn2istQMt7XHZGxY9U0cdjxSuN0TfbiD6
	cF3i0wAxo5WRxIg73TC8qkdMzJfAOVNcMPrXlltaj5Au1L8jmTUwuNf3lnnZiholtlUq9DRzhfut3
	82VD2ocQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsbRu-00000004kIM-15Cw;
	Sat, 08 Aug 2026 07:26:30 +0000
Date: Sat, 8 Aug 2026 08:26:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com,
	Liam.Howlett@oracle.com, ljs@kernel.org, david@kernel.org,
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com,
	aliceryhl@google.com, arve@android.com, cmllamas@google.com,
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org,
	davem@davemloft.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 5/5] tcp: Remove mmap_lock fallback path
Message-ID: <anbaJuYXEoldvtPn@casper.infradead.org>
References: <20260806200548.3124802-1-surenb@google.com>
 <20260806200548.3124802-6-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806200548.3124802-6-surenb@google.com>

On Thu, Aug 06, 2026 at 01:05:48PM -0700, Suren Baghdasaryan wrote:
> Previously, the per-VMA locking could fail in the face of writers
> which necessitates a fallback to mmap_lock. The new
> lock_vma_under_rcu_wait() will wait for writers instead of failing.

It's not called that any more ...

