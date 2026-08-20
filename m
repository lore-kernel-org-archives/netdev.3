Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E538E8A8
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250589; cv=none; b=rsoquNLbnApsWi7/uUaPkaJ+GZs3CVAlTH0/INXGDGiLAlAbJMANSr8B06sejjH+B6XG8NV/EmRm8Vf/vB5zNp72t3MkgDE7ZpVwiPu4KeqVEMeVpjTrwZt9BcxCcDNltlroMcfVHJZqRbnyqAe2akQ09YiiQHGmpq2uqz964Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250589; c=relaxed/simple;
	bh=3geQAe9kqZ10eQb2rB0/VdE7ePfN7rKJW5XRHr1e+OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kysWmTlYs6xm8dP31aIzhxdNwUJ00EQQH9bREcvVK/KRo4j+CNVSb36tX/N9GZOjQg+rPRm8dSzGyXG4JgD7YpKghIBL8BWwnRnnAwa8CDBhnpnS/z/DMWEzfpJcH1KkbBL5BCMF3l0B2ExpGQFStGKqih1q8HgT1HXFHeXtGMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faCh49lQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faCh49lQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66DC1F000E9;
	Thu, 20 Aug 2026 18:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787250587;
	bh=4lhEvpReNR1F6vb7P5sN7p73jY+EwKXnHgSNkyV0KWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=faCh49lQRGX8XBMzqZmReCWKsQe96fyxlTcKljMAsBDopDE/Gj8rSX/UKRMTZ0XoT
	 3sXmSXLcOUxdchIAEZvnHxCz3XtD4T3F12252fS3Xk8mv3zV6IBb+3mL/smtSQcPc9
	 2A3G0zs+97jhVd9AyiYF53N4qEcB0nSEF2ao2pyEkRFeAb+V75QHB6b8iMFqAWnIik
	 VZvYiHOKwZHRPzeFgqp+2SM+3vsXtiq266oS3eC2O+6VD6nGfrWdnGQgBAJzh91xxv
	 3q7BuMCarsSTFKozdhOyNgQCs5NfCsMc8OZcur4O7+/Hj/fJqdqW3wBknB38PZ0b7/
	 ykD+YrmIApXJA==
Date: Thu, 20 Aug 2026 19:29:43 +0100
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2] net: libwx: protect ring accesses with RCU
Message-ID: <20260820182943.GD265046@horms.kernel.org>
References: <20260818100841.37483-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260818100841.37483-1-mengyuanlou@net-swift.com>

On Tue, Aug 18, 2026 at 06:08:41PM +0800, Mengyuan Lou wrote:
> During queue teardown or channel reconfiguration (e.g. via ethtool -L),
> ring pointers in wx->rx_ring[] and wx->tx_ring[] can be cleared to NULL
> and freed asynchronously via kfree_rcu().
> 
> Concurrency between interface reconfiguration and background tasks
> (such as service tasks or dev_get_stats) can result in NULL pointer
> dereferences or Use-After-Free (UAF) issues when accessing per-queue
> structures. Specifically:
> 1. wx_update_stats() accesses per-queue Rx, RSC, and Tx rings without
>    RCU read-side protection, and lacked NULL checks in the RSC
>    accumulation loop.
> 2. wx_update_xoff_rx_lfc() walks wx->tx_ring[] and modifies ring->state
>    without RCU protection or NULL checks, risking a kernel panic when
>    flow control pause frames are received during queue teardown.
> 3. Queue assignment in wx_alloc_q_vector() used plain stores without
>    release barrier semantics needed for lockless RCU readers.
> 
> Fix these by:
> 1. Enclosing queue statistics gathering and wx_update_xoff_rx_lfc() inside
>    an rcu_read_lock() / rcu_read_unlock() section in wx_update_stats().
> 2. Adding READ_ONCE() and NULL checks when traversing wx->rx_ring[] and
>    wx->tx_ring[] in wx_update_stats() and wx_update_xoff_rx_lfc().
> 3. Using rcu_assign_pointer() when publishing or clearing ring pointers in
>    wx_alloc_q_vector() and wx_free_q_vector().
> 
> Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
> Changelogs:
> v2:
> - Moved rcu_read_unlock() after wx_update_xoff_rx_lfc() in wx_update_stats()
>   to ensure flow control processing remains fully protected within the RCU
>   read-side critical section.
> - Replaced WRITE_ONCE() with rcu_assign_pointer() when assigning and clearing
>   ring pointers in wx_alloc_q_vector() and wx_free_q_vector(), providing
>   proper release memory barrier semantics for lockless RCU readers.
> - Added __rcu annotations to tx_ring and rx_ring in struct wx (wx_type.h) to
>   align with Linux kernel RCU coding standards and fix Sparse warnings.
> v1: https://lore.kernel.org/netdev/20260813095141.88227-1-mengyuanlou@net-swift.com/

Although this patch does apply to net now (at least in my local testing),
the CI failed to do so the time it ran.

So I think this needs to be reposted.
