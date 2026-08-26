Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9E430FC26
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758465; cv=none; b=DgGvJqIAiJr68k8zS3RgFE3DzREvySKyiUlM4QIMSogPXv0eMN1xNdLLIgzTeKrYrZMQNrGmlwz+VtleE7yitbwfGWN8b569UyLGfrA6SQJkFjgUbTp/aqCbcnI15RZdVZ4XC7j8G1UEv96A63KpyemE9XWp8nAzrwqmVCs2m9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758465; c=relaxed/simple;
	bh=CXcXXF6evusfDNrfoIxuy8GGfi92zMZxmaR+7rDcqak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id8dMlOcVSOau1aWfWMN8prm8Gg+PtbAUrzsBk5Cm+pioT631N+HN3FlzL5nV6Qf13q9mJlIMEo9hmnoSB4X4oi/z3JBayMLOi0NUhRkvVEJVg+sbZI92FZUKybOQlCt87OeYHChlclDXb3yIINwMYgHqSUbye2F5jXEfY/aQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNXzdDcx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNXzdDcx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB4C1F000E9;
	Wed, 26 Aug 2026 15:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787758456;
	bh=AN5JSJXOCZYxWV4/YTmkMFfYYGgoGi4xSwdCFDobM4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dNXzdDcxOOkV07jHTQL82FasWrMkjHZsZEZwxCmX1UumKUd3xwD1dAaQNMMFpOp47
	 7+YwvUNAgx5MG38HnHnj2txPzKc7bcrx6YeAtotcsfTqL34CKcQV5VCssbasOkT+N3
	 qVpFnLrop+N5s+n7qcpVJR4T3qz538bymgQo9VzaC4UEYdBXorDGn++o1GfODjqdOf
	 OK/A3/FluL9wB88ymUcGMgelHoYE7YQI/whdUINbbqllUCnxlP+XDokjrWVW6i06Ti
	 kquVgtM4pdzcs0qHtaZfMtURGbCmuSdH7wIKmWrwCUL7DOa3MjZlux9k3zYl+A41TF
	 NO6qltZKqippw==
Date: Wed, 26 Aug 2026 16:34:12 +0100
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v3] net: libwx: protect ring accesses with RCU
Message-ID: <20260826153412.GE22033@horms.kernel.org>
References: <20260824103606.303-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260824103606.303-1-mengyuanlou@net-swift.com>

On Mon, Aug 24, 2026 at 06:36:06PM +0800, Mengyuan Lou wrote:
> During queue teardown or channel reconfiguration (e.g. via ethtool -L),
> ring pointers in wx->rx_ring[] and wx->tx_ring[] can be cleared to NULL
> and freed asynchronously via kfree_rcu().
> 
> Concurrency between interface reconfiguration and background tasks (such
> as service tasks or dev_get_stats) can result in NULL pointer dereferences
> or Use-After-Free (UAF) issues when accessing per-queue structures.
> Specifically:
> 1. wx_update_stats() accesses per-queue Rx, RSC, and Tx rings without RCU
>    read-side protection, and lacked NULL checks in the RSC accumulation
>    loop.
> 2. wx_update_xoff_rx_lfc() walks wx->tx_ring[] and modifies ring->state
>    without RCU protection or NULL checks, risking a kernel panic when flow
>    control pause frames are received during queue teardown.
> 3. Queue status checks in wx_err.c and PTP watchdog in wx_ptp.c dereference
>    ring pointers without RCU read-side critical sections or NULL checks.
> 4. Queue assignment in wx_alloc_q_vector() used plain stores without
>    release barrier semantics needed for lockless RCU readers.
> 
> Fix these by:
> 1. Enclosing queue statistics gathering in wx_update_stats(),
>    xoff processing in wx_update_xoff_rx_lfc(), error handling in wx_err.c,
>    and PTP status checks in wx_ptp.c inside
>    rcu_read_lock() / rcu_read_unlock() sections.
> 2. Replacing unprotected accesses with rcu_dereference() and adding NULL
>    checks when traversing wx->rx_ring[] and wx->tx_ring[].
> 3. Using rcu_assign_pointer() when publishing or clearing ring pointers in
>    wx_alloc_q_vector() and wx_free_q_vector().
> 
> Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
> Changelogs:
> v3:
> - Replaced READ_ONCE() with rcu_dereference() when reading __rcu annotated
>   rx_ring and tx_ring pointers to fix Sparse static checker warnings and
>   enable Lockdep runtime validation.

Hi Mengyuan,

As you may be aware the change above has introduced a large number of new
Sparse warnings (~50). However, I believe that the approach taken here is
correct and those warnings do not reflect bugs added by this patch.

So I would like to suggest that they should not impede progress of this
patch. And that, rather, as a follow-up an audit is conducted of them.
Any latent bugs can result in patches for net. And non-bugs can be
addressed as follow-up for net-next.

> - Wrapped wx_update_xoff_rx_lfc() with its own rcu_read_lock() and
>   rcu_read_unlock() section to ensure self-contained protection regardless
>   of caller context.
> - Extended RCU read-side critical sections and NULL pointer checks to other
>   background tasks accessing ring arrays, including wx_ring_tx_pending(),
>   wx_detect_tx_hang() in wx_err.c, and wx_ptp_rx_hang() in wx_ptp.c.
> - Updated commit message to accurately reflect the use of rcu_dereference()
>   and the expanded scope of protected functions.
> v2: https://lore.kernel.org/netdev/20260818100841.37483-1-mengyuanlou@net-swift.com/
> - Moved rcu_read_unlock() after wx_update_xoff_rx_lfc() in wx_update_stats()
>   to ensure flow control processing remains fully protected within the RCU
>   read-side critical section.
> - Replaced WRITE_ONCE() with rcu_assign_pointer() when assigning and clearing
>   ring pointers in wx_alloc_q_vector() and wx_free_q_vector(), providing
>   proper release memory barrier semantics for lockless RCU readers.
> - Added __rcu annotations to tx_ring and rx_ring in struct wx (wx_type.h) to
>   align with Linux kernel RCU coding standards and fix Sparse warnings.
> v1: https://lore.kernel.org/netdev/20260813095141.88227-1-mengyuanlou@net-swift.com/

Reviewed-by: Simon Horman <horms@kernel.org>

