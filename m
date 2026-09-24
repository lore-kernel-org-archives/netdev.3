Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F2D45C71C;
	Thu, 24 Sep 2026 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289394; cv=none; b=GWU/sIZWsx1IIxuwov24VQv9oLZRWlHTi5V0AC/9iBeCngbNTZt2x31Qd8rM4873Lo3/MeYATmyUdHqH4hj7GNEU7NvrrahXcf8iukycuJJ8p9UkJHTlDsh0uAc9PoVDZq6uPq2EtcOIlx5CHkyW8dDYWlcsr6oovdkOxKgUpw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289394; c=relaxed/simple;
	bh=OivxaqTavPlzXwYQJzOeniUtRbf2zYnNvEEYSA6HuQc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FjvhF7bsPy2KqheXtUzV4YzxW+mACTcimBmbGucx+CRX3O7uLz7A1CgflDhTSmvKYZbRfIgOaVVZOASC7T1tDjL7OMLOazBLOgGkw/nEs/hLMASIba2lCLNIWs9/36CJ/5D/kobXEvPDSbNcKiAtc6Q3LMlUapVKI4AR4L2uPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP11fXVm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP11fXVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3148F1F000FF;
	Thu, 24 Sep 2026 22:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790289392;
	bh=9ea983eeKPl1/7pykNWDiee95bcmGUYAovPHRVRm1Hc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LP11fXVmsC1rt8p4JEhW9j5hAaykMGqCOZigc2wesdVX3BsywOPa6O4vx/x1xLZP/
	 KpVh6Bwn7vpoZr1zmcCCtDaM66WxQx2wZsh9au4SJ/2yteeluWgiMfw3SzG3LoJ5Rr
	 PAU7qxge0QlYzxkeyRL+YcPymSevbrXtv0hf213Oange18PefKfvNnSOCuX+OMCEOu
	 fk7lEsnuPaDICYfv4+UJNUMEG1Z21NJZM9DkqJVParDzIySHDRrdHZeIkJyrGKhaM2
	 AB4rfPWHEwSgXAD+dPOo2nQRTK9v4rhsyL1xZgjEGYIfxCL5MDIBviX7PsXRS19G3w
	 P9J8b5S/Ij9FQ==
Subject: Re: [PATCH net-next] net: devmem: use page_pool_put_netmem_bulk
From: netdev-bot+sashiko@kernel.org
To: kaifengw@google.com
Cc: netdev@vger.kernel.org, almasrymina@google.com, edumazet@google.com,
 kuniyu@google.com, pabeni@redhat.com, willemb@google.com, davem@davemloft.net,
 kuba@kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 22:36:31 +0000
Message-ID: <179028939171.2160803.706522228583664641@kernel.org>
In-Reply-To: <20260922193356.542922-1-kaifengw@google.com>
References: <20260922193356.542922-1-kaifengw@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] sock_devmem_dontneed() (net/core/sock.c) now releases the last
  page_pool reference of devmem net_iovs via…

--

net: devmem: use page_pool_put_netmem_bulk

This converts sock_devmem_dontneed() from a loop of napi_pp_put_page()
calls to a single page_pool_put_netmem_bulk() call per batch, so the
page_pool ring producer lock is taken once per batch instead of once per
netmem.

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 2948dffcc3e1b..a6b6d5b2051df 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c

[ ... ]

> @@ -1123,8 +1124,7 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
>  			netmems[netmem_num++] = netmem;
>  			if (netmem_num == ARRAY_SIZE(netmems)) {
>  				xa_unlock_bh(&sk->sk_user_frags);
> -				for (k = 0; k < netmem_num; k++)
> -					WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> +				page_pool_put_netmem_bulk(netmems, ARRAY_SIZE(netmems));

[Severity: High]
Can this reintroduce the page_pool use-after-free that commit
271683bb2cf32e ("page_pool: Fix use-after-free in
page_pool_recycle_in_ring") addressed, when CONFIG_PAGE_POOL_STATS=y?

The old path went through napi_pp_put_page() ->
page_pool_put_unrefed_netmem() -> page_pool_recycle_in_ring(), which
updates the stat while still holding the producer lock:

net/core/page_pool.c:page_pool_recycle_in_ring() {
	in_softirq = page_pool_producer_lock(pool);
	ret = !__ptr_ring_produce(&pool->ring, (__force void *)netmem);
	if (ret)
		recycle_stat_inc(pool, ring);
	page_pool_producer_unlock(pool, in_softirq);
}

The bulk path touches the pool after the unlock:

net/core/page_pool.c:page_pool_recycle_ring_bulk() {
	...
	page_pool_producer_unlock(pool, in_softirq);
	recycle_stat_add(pool, ring, i);

Once the netmems are published into pool->ring, does the setsockopt
thread still hold anything that keeps the pool alive?  The barrier in
page_pool_release() only covers work done inside the producer lock:

net/core/page_pool.c:page_pool_release() {
	page_pool_scrub(pool);
	inflight = page_pool_inflight(pool, true);
	/* Acquire producer lock to make sure producers have exited. */
	in_softirq = page_pool_producer_lock(pool);
	page_pool_producer_unlock(pool, in_softirq);
	if (!inflight)
		__page_pool_destroy(pool);
}

so the sequence would be:

CPU0 (setsockopt SO_DEVMEM_DONTNEED)
  page_pool_put_netmem_bulk()
    page_pool_recycle_ring_bulk()
      __ptr_ring_produce()          /* last inflight refs published */
      page_pool_producer_unlock()   /* spin_unlock_bh(): BH/preempt window */

CPU1 (page_pool_release_retry() worker after deferred destroy)
  page_pool_release()
    page_pool_scrub() -> page_pool_empty_ring() -> page_pool_return_netmem()
    page_pool_inflight() == 0
    producer lock taken/released uncontended
    __page_pool_destroy() -> page_pool_uninit()
      free_percpu(pool->recycle_stats); kfree(pool);

CPU0
      recycle_stat_add(pool, ring, i);   /* this_cpu_add on freed memory */

Since the release is driven here by returning the last outstanding user
tokens, would it be better to move recycle_stat_add(pool, ring, i) inside
the producer-lock section of page_pool_recycle_ring_bulk() (matching
page_pool_recycle_in_ring()) before converting sock_devmem_dontneed() to
the bulk helper?

>  				netmem_num = 0;
>  				xa_lock_bh(&sk->sk_user_frags);
>  			}
> @@ -1134,8 +1134,7 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
>  
>  frag_limit_reached:
>  	xa_unlock_bh(&sk->sk_user_frags);
> -	for (k = 0; k < netmem_num; k++)
> -		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> +	page_pool_put_netmem_bulk(netmems, netmem_num);

[Severity: High]
This final flush is the common case for a SO_DEVMEM_DONTNEED call that
releases fewer than 16 frags, so it has the same exposure as the batch
call site above: the last outstanding niov references can be published
into pool->ring here, and the stat update in
page_pool_recycle_ring_bulk() happens after the producer lock is
dropped.

Does anything else pin the pool across that window?  The dmabuf binding
refcount taken by mp_dmabuf_devmem_init()/destroy() protects the
binding, not the page_pool, so only the inflight accounting plus the
producer-lock barrier appear to keep the pool alive.

>  
>  	kvfree(tokens);
>  	return ret;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922193356.542922-1-kaifengw%40google.com
