Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7BE33939D
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347631; cv=pass; b=h6Jt4jurulhYxyzJMqaGiycPPm1EtZaT2ldJlieehZFCcWFt9KArq2BeNp/r9MdJdYI5gIoIA0gUogivaHGyOfXF9gp7JgARDNq0aG8YcAhALM/5sqw1Bpvum5Uob9/CJgIr5soO2bT17/itgGNobAbBY4SyxU/QzZFF7KmQ6a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347631; c=relaxed/simple;
	bh=yKFseSxbvqkQ37lsyJ8ydV8cajeiwO3LOvkh0ZNm+5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huPFL8T1bcYaPaQicqtwSw/EcV59hqEeQja702d/GdwFld11AeG9Zr+TB9McH13JR0T0fR0/QaHyYMhsKtX1WhMThPviRtkC3KMe0bQJCuNC5sNzler2HlRlsR+si61hD3ezoMDWQwiNnEdIYR9LoqcIZmXOCQhCb7SyXUk5Wg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AyfpWSyO; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AyfpWSyO"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6aae147ef9dso12013a12.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790347626; cv=none;
        d=google.com; s=arc-20260327;
        b=ocjbG0vvQqJ4O1lKys9eyUutARkC5SUc0OWvTx0oLmMMWlhlEFzqr7b1VKR2OYinR1
         pQSKOAqtnvD2086S2iyZuC8Ug3nobSdbhK/m2jeVZQCqjFTrwzkYVxqEGZk3bxpCTX59
         sobuCtslyrYCf9vtAYjH6krnzmWO8D3EfBkzvlijWQi3NibexuwfAV9TS8yum9CQdG6G
         dptiFrBXXTrG7vP3Rpg6mu3V/9Tb1x/Sh3HHPfCXwnpaKV6Y4s4b1gVevk42riuXq3J7
         MtvXNmSfOh1uGgLBmJQUTAIjqroFyAD5+3rVclAuTXKKo3cvNruscrvtN30aOFbfpyRx
         qvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DeNdJdkPVhDPKyuk+P1Stj7C+vr163EhKJxuVpsloPQ=;
        fh=F2PZ4MSoOXa7hr700WDgVgcesOoDPWYtkjknwDe3G7k=;
        b=m8FExLy+XDQ8HWQLsxbOEdG05qCp7w+zlCefNfNruBPCGJyWYFsdz/h5+8c/ngWmJB
         cXenHgd8hc10MkWXX7pvcNHOUKk7F9YWURcnX0V6XQfDNdZFp4odHAoYjCORHFuoU5Sa
         RM0V2+AKTaFH67NhLVStiyaI6MCOINeGwShZ/Hxy0BQRA4sF3/0RB5e5B6ioks74pqTg
         oJU+Uw0XhrphxqLOuiddcVcyIDd4NDXB23y6h2muR1/EQroYpKuCpW4/lxkslru4H0uX
         o4TAW3eBVqvoLafAwOKE2xCd6bnhiSh25aAbWl5cpFIIslov0++gEQchiH77cbHDuaA+
         5dPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790347626; x=1790952426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DeNdJdkPVhDPKyuk+P1Stj7C+vr163EhKJxuVpsloPQ=;
        b=AyfpWSyOheNMH9eJTgyxz7sGm+zfjWNhUJl+jQEjcLVwDMkQ16bL1YP7OJCnmwxex3
         JyN272VIHM3rQ4otNByOolfZys9VOmeDbD7oOJMV0vSBBB2A3dQGfBZbwjgnaFQxPz6x
         bq8sRte3daTmljFU0gP95N0hAl3u5Gpa9kDM8mqznhp+Sl18WmAob2aKC9nMFGDWgDc6
         SCSygbMJFRq9el0iLJOeuafOyLVXPdoZqD7+FCeN7QFKFn/JEyZo9Pcl0csQyhyFkIoV
         WxhaRziZHQ8jGfhEyPYS7wcUuBiNlLe2c/kQPY2rxgRxTQFlLytHh3/2la+keYBLNsYY
         JDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790347626; x=1790952426;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DeNdJdkPVhDPKyuk+P1Stj7C+vr163EhKJxuVpsloPQ=;
        b=kNawqIHhzBjoU1B+Gh2tC64/cobvbLZlgIU2+S/vuxM9k39REybFlvYj5swPz4HCOC
         f+GSFs0C5fbM5/bS8Fx/GamraSJZQ/Uhlk8B4b7k6iMMSvpnlTpyX8c7DS64MrPoQvm6
         YpiAqQ5htei/gYk2b2n330+2r77CtrTNknTvTGJy2gF6kQ+98BDiDRG0dTKFVwMl6TAj
         845Q+3oOCDjdX5jMv06UhW6V9k+Jf2bRdhkmxrqhbA68SuB9l/T0E4pjS2Hc5N1fLsnv
         2giJHwZw8ldRM50RxO/oQDMXKLYbommmX8Wm1IHsVzNSntFyyO7dJOZkaNb08R9furf5
         F3NA==
X-Forwarded-Encrypted: i=1; AKwUvBxOM6Xkk90F/EbBPR/M9m6+5mNzvfs6fnOq52Qh2NfSFbZeJZbzGg/pF/4fpqukbPdHeoNvgcw=@vger.kernel.org
X-Gm-Message-State: AFuF++ndhLp55EbEC3BdJI/oplYzoqoI4A4ovcw7030M7GUf2r8NAeZD
	KzGDco+zHJeLD3p8nuXjDiEr3odvQtNlImw6zigJtmFaUS2vF1ECbKPKPPSVwdlBR197fBJ4UoJ
	EcXRK84N4ZO9mjzrErEGfmSdL3PA2+TY/jRghLFec
X-Gm-Gg: AYBFou1CZruQDnqRfRSRfHQxnoE1Az+D6X/p3lSl9S1YBVRLSMyyvFFdy5YtNTD4trN
	v5/bsqAxALRiCJ70SjrxNsWKh9sjC9HgtaUrkRtKXUc5Pg7f9VLeAMtXYizlnKRZ3m2nrZUmoTt
	bjb5/+sykL0lUCqMlZtDY+KJdQ9c+fb0InYjJgrYFQ2szW3NUjZpVcioY5z5m9glBDaIq1AI7hW
	a6CZcHcHMkgeC4lvVY1CevCMQQVBpJy4KYKfV61U1Uq7k4wxgl8KilGnnybftmj7J1MUajpkjL6
	1a6Sr/RxZ3gTBX0qKf1/3UffsEAHXjStuZYnaQHJEp2VqNw7OI9UUCWuZW1O1Hw14NPN4EEP1PJ
	5f646xw3w9cH76w==
X-Received: by 2002:a05:6402:534b:10b0:6a1:4eba:f09e with SMTP id
 4fb4d7f45d1cf-6aaf843be15mr13138a12.7.1790347625614; Fri, 25 Sep 2026
 07:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922193356.542922-1-kaifengw@google.com> <179028939171.2160803.706522228583664641@kernel.org>
 <CAHS8izP+ZdYM_rApxjDAhtb+jyAHLqTNKhj80p1YSNgTbBmuEA@mail.gmail.com>
In-Reply-To: <CAHS8izP+ZdYM_rApxjDAhtb+jyAHLqTNKhj80p1YSNgTbBmuEA@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 25 Sep 2026 07:46:54 -0700
X-Gm-Features: AclHuK_Zcj-dUypO2VUbWQf8N-SDxNjE-ZUtLZ9G1EmN8ON_VL9maaoPKWiW9z0
Message-ID: <CAHS8izOOutv+NU-BEgxB4Yq+bGfzMAG_SBk8-f1eUeoDt6MZnA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: devmem: use page_pool_put_netmem_bulk
To: netdev-bot+sashiko@kernel.org
Cc: kaifengw@google.com, netdev@vger.kernel.org, edumazet@google.com, 
	kuniyu@google.com, pabeni@redhat.com, willemb@google.com, davem@davemloft.net, 
	kuba@kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 5:49=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Thu, Sep 24, 2026 at 3:36=E2=80=AFPM <netdev-bot+sashiko@kernel.org> w=
rote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [High] sock_devmem_dontneed() (net/core/sock.c) now releases the last
> >   page_pool reference of devmem net_iovs via=E2=80=A6
> >
> > --
> >
> > net: devmem: use page_pool_put_netmem_bulk
> >
> > This converts sock_devmem_dontneed() from a loop of napi_pp_put_page()
> > calls to a single page_pool_put_netmem_bulk() call per batch, so the
> > page_pool ring producer lock is taken once per batch instead of once pe=
r
> > netmem.
> >
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index 2948dffcc3e1b..a6b6d5b2051df 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> >
> > [ ... ]
> >
> > > @@ -1123,8 +1124,7 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t=
 optval, unsigned int optlen)
> > >                       netmems[netmem_num++] =3D netmem;
> > >                       if (netmem_num =3D=3D ARRAY_SIZE(netmems)) {
> > >                               xa_unlock_bh(&sk->sk_user_frags);
> > > -                             for (k =3D 0; k < netmem_num; k++)
> > > -                                     WARN_ON_ONCE(!napi_pp_put_page(=
netmems[k]));
> > > +                             page_pool_put_netmem_bulk(netmems, ARRA=
Y_SIZE(netmems));
> >
> > [Severity: High]
> > Can this reintroduce the page_pool use-after-free that commit
> > 271683bb2cf32e ("page_pool: Fix use-after-free in
> > page_pool_recycle_in_ring") addressed, when CONFIG_PAGE_POOL_STATS=3Dy?
> >
> > The old path went through napi_pp_put_page() ->
> > page_pool_put_unrefed_netmem() -> page_pool_recycle_in_ring(), which
> > updates the stat while still holding the producer lock:
> >
> > net/core/page_pool.c:page_pool_recycle_in_ring() {
> >         in_softirq =3D page_pool_producer_lock(pool);
> >         ret =3D !__ptr_ring_produce(&pool->ring, (__force void *)netmem=
);
> >         if (ret)
> >                 recycle_stat_inc(pool, ring);
> >         page_pool_producer_unlock(pool, in_softirq);
> > }
> >
> > The bulk path touches the pool after the unlock:
> >
> > net/core/page_pool.c:page_pool_recycle_ring_bulk() {
> >         ...
> >         page_pool_producer_unlock(pool, in_softirq);
> >         recycle_stat_add(pool, ring, i);
> >
> > Once the netmems are published into pool->ring, does the setsockopt
> > thread still hold anything that keeps the pool alive?  The barrier in
> > page_pool_release() only covers work done inside the producer lock:
> >
> > net/core/page_pool.c:page_pool_release() {
> >         page_pool_scrub(pool);
> >         inflight =3D page_pool_inflight(pool, true);
> >         /* Acquire producer lock to make sure producers have exited. */
> >         in_softirq =3D page_pool_producer_lock(pool);
> >         page_pool_producer_unlock(pool, in_softirq);
> >         if (!inflight)
> >                 __page_pool_destroy(pool);
> > }
> >
> > so the sequence would be:
> >
> > CPU0 (setsockopt SO_DEVMEM_DONTNEED)
> >   page_pool_put_netmem_bulk()
> >     page_pool_recycle_ring_bulk()
> >       __ptr_ring_produce()          /* last inflight refs published */
> >       page_pool_producer_unlock()   /* spin_unlock_bh(): BH/preempt win=
dow */
> >
> > CPU1 (page_pool_release_retry() worker after deferred destroy)
> >   page_pool_release()
> >     page_pool_scrub() -> page_pool_empty_ring() -> page_pool_return_net=
mem()
> >     page_pool_inflight() =3D=3D 0
> >     producer lock taken/released uncontended
> >     __page_pool_destroy() -> page_pool_uninit()
> >       free_percpu(pool->recycle_stats); kfree(pool);
> >
> > CPU0
> >       recycle_stat_add(pool, ring, i);   /* this_cpu_add on freed memor=
y */
> >
> > Since the release is driven here by returning the last outstanding user
> > tokens, would it be better to move recycle_stat_add(pool, ring, i) insi=
de
> > the producer-lock section of page_pool_recycle_ring_bulk() (matching
> > page_pool_recycle_in_ring()) before converting sock_devmem_dontneed() t=
o
> > the bulk helper?
> >
>
> Thank you my dear bot. This seems like a real issue, a latent bug in
> the *_bulk() put. Let me use my pet LLM to develop a fix for this,
> send to net, and then respin this.
>
> Lets hold onto this for now Kaifeng, and resubmit after my fix goes into =
net.
>

I submitted a fix to net:

https://lore.kernel.org/netdev/20260925144127.1445667-1-almasrymina@google.=
com/

I guess I want to make sure the fix goes in before we adopt _bulk in
devmem tcp, so defer this one I guess and repost when the net fix goes
in:

--=20
Thanks,
Mina

pw-bot: cr
