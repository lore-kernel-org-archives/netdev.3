Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51AE49B21B
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340587; cv=pass; b=mrAZKLoiQ1fSNYfQAPRBX4uWJhSu0Nl6OQP6GhVbdwB3CFdGDOjN7uREQOIzlzqTfOscLEfMLoQS/cKJSAIDkhvL2YIWSBMca//Eg1rb5d8BNDDueL/ctGnZhqan7nKo8YUWn/ptybloM2DXtvZ+vdIV1/enZMMDA2p7KutnvjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340587; c=relaxed/simple;
	bh=2Gz2UeRKZ24g45wBnk1gIJDu8zb1+RkJBTqudMiS5n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFtLtuR2Hn7Fs9aZgW1zOL3QpzudEUdqEzCVngRHDlO+Vj4bVBo+lCRuj5/tLXxsNvVqiJqQYVrP0W7IiG8Kiu3znxzjJxaJUTnkOuJWygMNiNC+A+E3DwGRlnUR3nP7k/0lkIqm6vpf00K+IVCTcY2cbMe/tcdqpwo3yrbQUsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JkY+frEa; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkY+frEa"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6aafd2c326aso290a12.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 05:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790340584; cv=none;
        d=google.com; s=arc-20260327;
        b=sQxOJ+Nw6qHSDGzsKfbaC6Udy8wOK/IVINLikP15RUPUQUwRCQ08VeM8ePK7jWuofq
         CGKeUbTptXooGLaEc92D3Axv6SU5/Tx96JO5lv6j8ABcZUo9H1OUviAtc3G8d4TGbnSG
         P6qmk/gKGo7xyKBZAoTMlfkyDLxasfMC2B9TxFl7Wl/t/wcjhTx6gtm/cI1XxDQk9XjD
         qBkZB0SDcwOPjkPnSq4Q9DCx5jbeKTvIFtabAeqD6Ep0OwkH0CXTeAuzLrbjedCC0K3J
         MbgspjPnFnztq5Zm4H+vtKXOUuGojoY+cB0xPbSRiUMXacfsXzBhZx/eBORLlYrLQIdr
         mjOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JEaNxzWMP8zBe2t/2kfrudklKHVc3TEq0coVkXXGBbA=;
        fh=CH3WlrfAzFAqb1E5zJ+d2ZmFZE4SjyLNb2LWFWlx+WM=;
        b=SfuHcS5LAVxImZJJu5RXA0KuLV5Cfp1nVKbgziqiCh6pEGKjk4TtGNOwioek9AWAFm
         0lqX5FoLhY7VAQUBwGz57SDM53WkeE2fhHQu3U/sD048g/p6dG2eMiVZfNY8rJXSC+wp
         pTkYno6oHLYDS87/t7X+/pt3K8Uq0+ky20y/ODawjDAcszsrU9Mdg9/YCi6STGl6n5CY
         z9r9zvUGaNV6JdMEsT6vqwgDDf4ljMGAIzZ9xSdE+ZRxE0lYQ/RsRU0L0UcCu06pVRUV
         5LoWuIljQKRtuAwBF+15I30NZpJWKzU+oxzKBNSw4qWzO9496dL/kEC/yd1q/49jApyI
         R28w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790340584; x=1790945384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JEaNxzWMP8zBe2t/2kfrudklKHVc3TEq0coVkXXGBbA=;
        b=JkY+frEaxPzU0XEr0lRnayQhtQBSuDlM8DGj41U5TpW7yuFZzlsk2i/HqbzqBfiOGn
         KMln75CN0/sEua7QefZwkZ7frBYu+eL3UBDJytmd4cvZXRQf/lRCGoO9Bjk6P5QN60EL
         hNyVbC+sALgZzTeAhxbnDLGMDvFl/AH2DpiJZVjm5w2ch62bMeI5eLFykDb3bM3WgApM
         d1mjY9DNhNPd6ggxESRj9Y1s4q06ralnXf5virLuaIUeKLLbKNKdPR2o2xs3Huf6mNHx
         /b7Y4KHKCG+IVpytc9IpJIaVjd5WqyLT6TN/UMPgtNvw/fDqS93McfhMtEGqKNTe5dKj
         cZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790340584; x=1790945384;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JEaNxzWMP8zBe2t/2kfrudklKHVc3TEq0coVkXXGBbA=;
        b=CDZY5W6bLG9X9UzVpBMcEuLtOM0HrH+7KMgwIyRu4AaV9UFQCjUAA5aIgnlAKnzmh+
         8xI+RfAs2z7/ZyNjp4d+EbosXjQy94Wmw1Ya6IR2BMAW9HkHgGWrqaw9ocaBSx2lWBxA
         uUWJ/dpgs217n4zfuBJekon2ueR+9vk0g8aLMhtJd41Uiap/8mGYPB2iCQ35dnhQVlXE
         0Qh0u41haK70tNC/+M3gZEZHtNZ4WKNC6uZzCV9IOxUDgKeZbK0GkoSWCGOr1vObpRhr
         W9v4R0LEcFImp9DFnCaMjiNjRQkfPDDjlzkgL8HS3zKpVhBNV3BDPqnVGznTTOxFzlsN
         t56w==
X-Forwarded-Encrypted: i=1; AKwUvBwIqoXgu8urlWWU5HSOez3a0fT9XtCdxfL4rRR+zmkfeOMp3gq6/Bkprqfpkm3TCIRG7Eac/6Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kCtHtLGTXxiUe0CpQnWGeNRZvPeKtVGpMJuNNadJm6TkvI/e+d
	jdSx9IC33NjieCQhxE6kjKKQIUdmQYs13adhaiT6Hit2nGxy26YPOQSGsDvpZwUoceQgr74Kg6r
	0wqLeD9yjxNtcxQlGxrAhJ5vWOBwwcqcbkp4ydOp3
X-Gm-Gg: AYBFou21yeRKtW1lvKnQfgLHMePJfYzm05AIOrk5VwAyhKr81RzT1y0CO6JObuw5iI/
	3prttX/bb2Yl/s272BQ7NRpwNdXam6dHe+18HraL3uJ5HrgLTauuGzXDpV8Ie+ZF7wrY9jusWRI
	D4gF00+S2qX5Vk1xudQtimtQR3yHxTCPnNvLASEOFScY3c94U1JCEGhuyfxt+C5fn74HuSM8s6o
	9/HV/qmvqd6Y5WmoDDKT2RHzGNbIgNZPx58MPAirFiObcnZWz9jY7sbDgayU72dNXs6CK7/Mk0Q
	jsYQclTDKIuuBTIBmtV12NXwt9fQYQ4pBEIVeE50w5hNsfRnTIjcDVao/WE8EH8VGrktJFppg2g
	Rw1a4XET3K9W8uac=
X-Received: by 2002:a05:6402:a50e:b0:6aa:128c:36ad with SMTP id
 4fb4d7f45d1cf-6aaf8475cd6mr3116a12.10.1790340583030; Fri, 25 Sep 2026
 05:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922193356.542922-1-kaifengw@google.com> <179028939171.2160803.706522228583664641@kernel.org>
In-Reply-To: <179028939171.2160803.706522228583664641@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 25 Sep 2026 05:49:31 -0700
X-Gm-Features: AclHuK8EGd49bkj4acT1-UozI1H1RBoepM97mY3Mb4oTcfAxodBew5rvHOkNTmQ
Message-ID: <CAHS8izP+ZdYM_rApxjDAhtb+jyAHLqTNKhj80p1YSNgTbBmuEA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: devmem: use page_pool_put_netmem_bulk
To: netdev-bot+sashiko@kernel.org
Cc: kaifengw@google.com, netdev@vger.kernel.org, edumazet@google.com, 
	kuniyu@google.com, pabeni@redhat.com, willemb@google.com, davem@davemloft.net, 
	kuba@kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 3:36=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] sock_devmem_dontneed() (net/core/sock.c) now releases the last
>   page_pool reference of devmem net_iovs via=E2=80=A6
>
> --
>
> net: devmem: use page_pool_put_netmem_bulk
>
> This converts sock_devmem_dontneed() from a loop of napi_pp_put_page()
> calls to a single page_pool_put_netmem_bulk() call per batch, so the
> page_pool ring producer lock is taken once per batch instead of once per
> netmem.
>
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 2948dffcc3e1b..a6b6d5b2051df 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
>
> [ ... ]
>
> > @@ -1123,8 +1124,7 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t o=
ptval, unsigned int optlen)
> >                       netmems[netmem_num++] =3D netmem;
> >                       if (netmem_num =3D=3D ARRAY_SIZE(netmems)) {
> >                               xa_unlock_bh(&sk->sk_user_frags);
> > -                             for (k =3D 0; k < netmem_num; k++)
> > -                                     WARN_ON_ONCE(!napi_pp_put_page(ne=
tmems[k]));
> > +                             page_pool_put_netmem_bulk(netmems, ARRAY_=
SIZE(netmems));
>
> [Severity: High]
> Can this reintroduce the page_pool use-after-free that commit
> 271683bb2cf32e ("page_pool: Fix use-after-free in
> page_pool_recycle_in_ring") addressed, when CONFIG_PAGE_POOL_STATS=3Dy?
>
> The old path went through napi_pp_put_page() ->
> page_pool_put_unrefed_netmem() -> page_pool_recycle_in_ring(), which
> updates the stat while still holding the producer lock:
>
> net/core/page_pool.c:page_pool_recycle_in_ring() {
>         in_softirq =3D page_pool_producer_lock(pool);
>         ret =3D !__ptr_ring_produce(&pool->ring, (__force void *)netmem);
>         if (ret)
>                 recycle_stat_inc(pool, ring);
>         page_pool_producer_unlock(pool, in_softirq);
> }
>
> The bulk path touches the pool after the unlock:
>
> net/core/page_pool.c:page_pool_recycle_ring_bulk() {
>         ...
>         page_pool_producer_unlock(pool, in_softirq);
>         recycle_stat_add(pool, ring, i);
>
> Once the netmems are published into pool->ring, does the setsockopt
> thread still hold anything that keeps the pool alive?  The barrier in
> page_pool_release() only covers work done inside the producer lock:
>
> net/core/page_pool.c:page_pool_release() {
>         page_pool_scrub(pool);
>         inflight =3D page_pool_inflight(pool, true);
>         /* Acquire producer lock to make sure producers have exited. */
>         in_softirq =3D page_pool_producer_lock(pool);
>         page_pool_producer_unlock(pool, in_softirq);
>         if (!inflight)
>                 __page_pool_destroy(pool);
> }
>
> so the sequence would be:
>
> CPU0 (setsockopt SO_DEVMEM_DONTNEED)
>   page_pool_put_netmem_bulk()
>     page_pool_recycle_ring_bulk()
>       __ptr_ring_produce()          /* last inflight refs published */
>       page_pool_producer_unlock()   /* spin_unlock_bh(): BH/preempt windo=
w */
>
> CPU1 (page_pool_release_retry() worker after deferred destroy)
>   page_pool_release()
>     page_pool_scrub() -> page_pool_empty_ring() -> page_pool_return_netme=
m()
>     page_pool_inflight() =3D=3D 0
>     producer lock taken/released uncontended
>     __page_pool_destroy() -> page_pool_uninit()
>       free_percpu(pool->recycle_stats); kfree(pool);
>
> CPU0
>       recycle_stat_add(pool, ring, i);   /* this_cpu_add on freed memory =
*/
>
> Since the release is driven here by returning the last outstanding user
> tokens, would it be better to move recycle_stat_add(pool, ring, i) inside
> the producer-lock section of page_pool_recycle_ring_bulk() (matching
> page_pool_recycle_in_ring()) before converting sock_devmem_dontneed() to
> the bulk helper?
>

Thank you my dear bot. This seems like a real issue, a latent bug in
the *_bulk() put. Let me use my pet LLM to develop a fix for this,
send to net, and then respin this.

Lets hold onto this for now Kaifeng, and resubmit after my fix goes into ne=
t.

--=20
Thanks,
Mina
