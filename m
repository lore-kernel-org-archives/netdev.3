Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254616;
	b=04gguFm1UgUT36zflzoOsJXF4nLc3Vbp7zyMB86pfZC7CNFyxxzHh9elThS8GEapKYDp
	 gU/W+0w8t2oLoeIjPGLDFJNL/bxvp48CDiYMm/pqkEnDolA4JyXcvgRXu2FtUhUbEO1VZ
	 ef+Ay8AuEIiJiRCgwZMFW4uvGMrebsy7e0hb+THPBwWay7cplcMQwKiW3WePN2duhZ80P
	 Pe2I0XZfBIx2/iaRrqQbtVMihHID3mmNmqGlg4XqfYU4Thupzw4wUGqDbfRDb4nLWenPV
	 II/4El7J5tSXMNyB+jun0X9IlFK6Z9s9Fq7e8KnQ8Y76c2H1lzqNN9A4D3gGj7+U9iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hO10aJTqcdq/ahujE/caCvdQLD1fV3nWWuPROud/Q5U=;
	b=1rtngS4/mxQu2wvq+pQR1JOi5ZvInEexiNKDr0lYQh8HOX0Q7FZm9vOwJoM+RubiY0/r
	 wrjLiLRlL2a7Hudtn3n5TjQsrBRUqRxxu2/6JcB/IeElsmXpONPmdRHdnzwBZQblo/Nsn
	 E6qarspYoL9/AmyvcV7iWkt1RCxZFxpccgya7JxUAFo9nV5GyhXshTqC0yuPaJmZW5Vuf
	 NiQyKJ3WXht6gOhpHgoa+PpTHc8Od4jLJm6baD8ogRnXgUcE1vlF6ld+jmeTjrUNDRY7W
	 LaQar/Iize6VDyyk/JFX5TpPVg7o2LWMzkMdtWY61txt3+oLnq+EHhsS3SlW+R9TXOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="oNKxcVI/";
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E5606A335
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 20:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF6E5606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNKxcVI/
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-492fcbfaa87so842628f8f.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 12:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794254614; x=1794859414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hO10aJTqcdq/ahujE/caCvdQLD1fV3nWWuPROud/Q5U=;
        b=oNKxcVI/TeeQxBDAuMqyCn+ZfQQO8blhqL8KlxBC30V65fOpcWXvZ9dfBeAjWf1Q6K
         oHTBAEMwWh6UGyNWf1v8Ni2+oKmyI+4ri+9bcL/uQ3x6gc+0YuDaIXjQtdQvIChf8gDt
         NfWoxLCmHPs79FMm+7QWr3wbPyBqSHGn1ZApTHXLNVJrLlNI/RdxjZskVe0gkDGQTabd
         SEeESi4NtDlXaSfooFQNoTJ/fNUCHE3ElQm674W72D/i0yv+wUB/ZzxPvKFoUy9HslKc
         2SaNu+jt8xZjWbTP4vo3TFQ+/9ZJPM3XToLKH6q7Vf3meq1ldiOeAMbs6gDvxC5GDgrS
         Q4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254614; x=1794859414;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hO10aJTqcdq/ahujE/caCvdQLD1fV3nWWuPROud/Q5U=;
        b=hK1SddNmrVXsy1AfB4Ckz0qQ96X3QKSt0+Rwa/7UOVdqr+a0/xaWgYHiCBAJ95TKFU
         uVovLJ6xwmmh8kCqpWZcq1HqL19kzFQu3GB4lqaJx+D8/p0/n3d/eiMMEsmM2hBp0d74
         K0/Be4Pbx1Ug7VcdKNP3r2QDpqci33URbbGS2loD1Y4HxD74BA/1lbfFuVB9QS7MdCvy
         ElbCGYeTyqs6vI4SRE/iroZDNXUw7vssBrqeZkbn5UtX19yxI71wQ7wuHUaiBRoufXPt
         08Q81gD1xvVGkXLT3tpxuO7NJK5F7WOTR+uJwq5PzlFmnvLtJIoAdH84t+gvQ4qtJEW7
         JMnQ==
X-Forwarded-Encrypted: i=1; AL+hErFIhD33vN/GzAKXY56eY3+0s+mtzEA2fCWnV2W1qvYg9Z+R/V6rMZNjo9Mfxpqq6QTQjrk5TCw=@vger.kernel.org
X-Gm-Message-State: APuU4Z90GjjDVHTuW20vIOmaoyQhyXqeUfvHnxjQ8aoAOiu7wuRDNpAu
	fs3l1KCmr+OHpcG63iuhKlpxiZi/WhXzZsaDqXFmnk00RnePhVbFQ1lU
X-Gm-Gg: AYBFou0tQCnKXu7HllrctdlHl40ge6nA2ffDfWOhEtkIf0/jysGGEJHdnVaXF8WnHTX
	s/INe6cC64fjLZj9lotSV8teD+16+kAQJXYSf9hB4BtXujJ/X08M8IAMKsqzKKoXzjmdgWbMCxv
	uijE3xaIl9sul2gB6ljfG/fSn/SPyF7k/ZRy5MTa4X9zcLhGKCqTfSPrZgFUVQvcRvABZn9/Tub
	9gCuyAYxSZFZ8iUdxlBPGXCtbK6WQ0dXdpr8im7km9VuW4+K/3h0fK3cCDxcQ05pGUYEf9FsRN+
	fqgKseIhp4sqkvzxOYGVqvz4oAxadeYFCkGrpjdXvJY5WcFJ3i+9kX1SVhRkLuqpJLNvAqfJ8Ys
	x3gR0bqmBqpR51FdHfO5LrETwFdbh+hnYwNb4IBT9NabH1bwMmHjhxnJ5iMMC+tVO955tnf7tfW
	Q1QP6B9Ud3uHgCRp+G9sMEHXTuCLzyTpiJ0zbsFIpwOKOpdCyy1mazh6xycZA+CKbb5mht64BlL
	ilVqjMqjM5K9Jvxo/ir5s0oXI9Fof1Apl1ewIymw3Y/Q2A/lvJZCI7ysyK8y9o701SD22/xUiTT
	rK3kkYl746EgEGRjT6mOUG9Bp0F7xsGi5CxcCn/l98rlfq83616UNGiT7Dbkn2xh
X-Received: by 2002:a05:6000:4549:b0:492:b5e9:4916 with SMTP id ffacd0b85a97d-4982f874041mr553519f8f.24.1794254614069;
        Mon, 09 Nov 2026 12:03:34 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835858f64sm874068f8f.16.2026.11.09.12.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 12:03:33 -0800 (PST)
Date: Mon, 9 Nov 2026 20:03:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 rostedt@goodmis.org
Subject: Re: [PATCH v3] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
Message-ID: <20261109200332.52e2fc0e@pumpkin>
In-Reply-To: <20261109180748.33682-1-haoranwangsec@gmail.com>
References: <179241614797.5916.13928836073297916808@whr>
	<CANZ3JQQrrntu0TefPZC79pKSmsOfwAngRJyuaVm81DYaJNFHFQ@mail.gmail.com>
	<20261109180748.33682-1-haoranwangsec@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Nov 2026 18:07:48 +0800
Haoran Wang <haoranwangsec@gmail.com> wrote:

> ppm_get_cpu_entries() disables preemption with get_cpu(), reads the
> current CPU's pool with per_cpu_ptr(), then acquires the pool's
> spin_lock_bh() while preemption is still disabled, and finally put_cpu().
> 
> On PREEMPT_RT kernels spin_lock_bh() becomes a sleeping lock
> (rt_spin_lock), so the task may sleep with preempt_count elevated:
> scheduling while atomic, reported as a BUG by CONFIG_DEBUG_ATOMIC_SLEEP
> and a deadlock once the lock is contended.  Any iSCSI offload I/O
> through a Chelsio NIC that reaches ppm_get_cpu_entries() triggers it.
> 
> Read the current CPU with raw_cpu_ptr() without raising preempt_count,
> and derive the global index base from pool->base (initialised when the
> pools are allocated) instead of cpu * pool_index_max, so the base
> always matches the pool that was locked.  The owning CPU remains in the
> debug output, now derived from pool->base.

I think you really need to explain why it doesn't matter that the pool
for the 'wrong' cpu is used.

You don't need a big explanation of why you can't call spin_lock_bh()
with preemption disabled, it is probably enough just to say that you
can't (the most reason would be 'can sleep on PREEMPT_RT kernels).

This is separate from any issues of acquiring the wrong lock.
I'm not sure about the trace, if you are tracing the cpu the data belongs
to - then that should be what you call it.
Once you hold the lock I think the cpu is fixed (even under PREEMPT_RT)
so you could trace the actual cpu as well - especially if anything 'funny'
might happen because the data wor the wrong cpu is being used.

Of course, it the code is just trying to avoid lock contention (and maybe
reduce cache line bouncing) it may not matter at all which copy of the
data you get.
In fact one for each cpu may be excessive - think of systems with 1000s
of cpu not single digits.

David


> 
> Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>
> 
> ---
> (Resent with the complete Cc list; the earlier copy reached only you.)
> 
> Hi Sebastian,
> 
> thanks for the review.  v3 below addresses your comments:
> 
> - The commit message now describes what the patch does; the review
>   rationale moved into the changelog below the --- separator.
> - PREEMPT_RT spelled out.
> - pr_debug() keeps printing the owning CPU of the pool, derived as
>   pool->base / ppm->pool_index_max; the global index stays
>   i + pool->base.
> - Tested on: x86_64, compile-tested with CONFIG_PREEMPT_RT=y and
>   CONFIG_DEBUG_ATOMIC_SLEEP=y; no Chelsio hardware at hand, so the
>   change is not exercised on real offload I/O.
> 
> Changes since v2:
> - Keep the owning CPU in the pr_debug() output, derived from
>   pool->base / ppm->pool_index_max (suggested by Sebastian).
> - Reword the commit message to describe what the patch does and move
>   the review discussion into this changelog; spell PREEMPT_RT.
> 
> Changes since v1:
> - Drop the cpu variable: read the global-index base from pool->base
>   (initialised at pool allocation) instead of a cpu captured before
>   the lock, so the base is always consistent with the pool that was
>   locked.  The per-CPU pools are shards of the global ppod index
>   space and not tied to the running CPU (ppm_unmark_entries() derives
>   the owning pool from the index itself), so locking another CPU's
>   pool after a migration is a cache-locality matter, not a
>   correctness one.
> 
>  drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> --- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> +++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> @@ -119,16 +119,13 @@
>  			       unsigned long caller_data)
>  {
>  	struct cxgbi_ppm_pool *pool;
> -	unsigned int cpu;
>  	int i;
>  
>  	if (!ppm->pool)
>  		return -EINVAL;
>  
> -	cpu = get_cpu();
> -	pool = per_cpu_ptr(ppm->pool, cpu);
> +	pool = raw_cpu_ptr(ppm->pool);
>  	spin_lock_bh(&pool->lock);
> -	put_cpu();
>  
>  	i = ppm_find_unused_entries(pool->bmap, ppm->pool_index_max,
>  				    pool->next, count, 0);
> @@ -145,10 +142,10 @@
>  	spin_unlock_bh(&pool->lock);
>  
>  	pr_debug("%s: cpu %u, idx %d + %d (%d), next %u.\n",
> -		 __func__, cpu, i, count, i + cpu * ppm->pool_index_max,
> -		pool->next);
> +		 __func__, pool->base / ppm->pool_index_max, i, count,
> +		i + pool->base, pool->next);
>  
> -	i += cpu * ppm->pool_index_max;
> +	i += pool->base;
>  	ppm_mark_entries(ppm, i, count, caller_data);
>  
>  	return i;
> @@ -375,6 +372,7 @@
>  
>  		memset(ppool, 0, alloc_sz);
>  		spin_lock_init(&ppool->lock);
> +		ppool->base = count;
>  		count += ppmax;
>  	}
>  
> 

