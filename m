Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188552E061
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201545; cv=pass; b=s3KcpuLuMGr+uRUvvZ7gy2bVXkSgVXfQGIXcPi4Vy9G+CeT1k1Jamz6ETz8tIuq4zaZ0b8LREFBobMRV3RtYpnKJb1vU1dUUFyDz1oiJE/WaVK9jL4eaFI+fgpHRsMNSv0jIEuqHQN0nuEx0clyE2WMaiY5axZC4tW086qpv90U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201545; c=relaxed/simple;
	bh=RF09cE7ioD8j+xL9e6cVzbwze+m4bkJrefwNTRLCmd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtLczW+Z3odzxErDlGnA/lCwNuXalvjJWs/ulKaFBsGUzw3J8z8pMGkWv8VHI3OoopawSg+GrLHzWGhsJnEivjJrVcnfCXTZ8bpp7RrJ05HBFkyZZ7WL4HPZwwvGYKzg2KgFUj0eJx4St2P9t3vyPolU3uIcIW/EchaPiagqufc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/orQXpd; arc=pass smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/orQXpd"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04f7f2so1604578c88.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790201543; cv=none;
        d=google.com; s=arc-20260327;
        b=GEKPa0FBnnDpD2p9UuZsZTC3f6v9tXE3BX8BG/cAMAD/cppSVDdjF7EJX2vTT7Kh9Y
         8BOAr9dtTzYloNlPSQui+TT47rzZKGo0wypJTATzAOdEbZUUIdWKKjg5Qra5QG6dmsox
         Msm1yugwMN+YAD3ZGoqe4O/BkmOub8dpDHJGj1OKY4KVQIzlrAygfQF657PK5YkdSjjy
         urN23g9xBjFPv+SvbhUwtSosNPd5L9k7okebKLCkUmtrvTlxvJxqYobarYDd+FyEO/bg
         MIG81pfrSIPznCRal5yr63qVqJtKvo5XboYv2lJ+oEseCkcDdnvPrJG1qNRsb8w8YaX2
         wTQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NjZO/0op0Il8fdlo4Q38ShHr57bjfTGXucOfCAVH0b0=;
        fh=UaU4dYmSdUUizSOtgLsZHc7UVcsvgG/jXVqkdleIyJc=;
        b=CR0TrliRI/w3mxMjK1IcejRjUpCc8+aiASuqMlwsakGm/NgZ03IPvlgU4jICn2c+rT
         jQuc0eVwbX1hD0hvv2HdFLyFlRcqTEJLyKyRPjE9qIPsNygsWb6KXtxsjIaQ1xzZ58Gq
         6cU/N3OqRk5HJ1gLx5QLhepAWLl768uyTUA4Jr7zFTXlCasCKMDDKXjq5Qlt4jbMz9bO
         DwzzFsF2IuAKQpqnWqgEQyHqKtS4a0v9gu49+uIpS0Lo9ikk+ppz4k3EhvXZuHmCvxn5
         eQuO6SZy63TDr8wTI0fa6oqYpOYsQIHGaefnoKcrzLaMLzImx0QKm4RP4+e1C0/aJeTU
         5ubA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790201543; x=1790806343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NjZO/0op0Il8fdlo4Q38ShHr57bjfTGXucOfCAVH0b0=;
        b=G/orQXpdNRHGJd2hyo0vRTQhIuy/C7d08OkwZKq1RTNaj2SAK5hxKTNZLH0hNTUN79
         14IbbvgH3dl0qSkpMwnnQ78sbO7OKBUtlZXyOox0IuaCI+gQGT6gQZlF0CT5kvfNhULE
         3159AFsMSGH/wuUpshV69r2qIYTv7XDF87zul4kiWn3pzXlsMWcftEQlCH7Q5d5nyDZ2
         TQQUazcaRHfIrLnxRNb72Yj51rvbKNJfQFBfyhkwAwJeotw+bIm1HVUnldhHS44yYgXE
         /BBj+KKimJ/ljcGgKq4XMCh0TSqJPIe9h8IuTyXIYvV2xXE/IufXans/SZBdZGvo/0YR
         AasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201543; x=1790806343;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NjZO/0op0Il8fdlo4Q38ShHr57bjfTGXucOfCAVH0b0=;
        b=ZNxFNGISAnbePuUETu4Zb1RVqFVIuzBq3d3vRRheBFmfCRYhHYLBZwoxQAv3d2sdqg
         SJU4xSpQSNGx3oTf34/L9W0CAmr4MvpyHVHdOpWlOcgALCRlIILUwRrqcbczfItzkKtd
         hhON4NeT8ql3560WZlXzLdCB6Oen1rpjbmV5Hikrs4OqoPVXXy6StvHpB3qbtZ39DUIe
         aKPpyikH829/gvRDxiW/sUWhwwllQ4zXiQ/SDqMBs0W25qdX7Br7u4pfxa4SlnroZFKs
         oib2FuRhb6BZS1SZDesqRVy1bOLocMSSeqpDf/jCefCJJpQQXnJwb0B3aXRIppWzHrgY
         Jrag==
X-Forwarded-Encrypted: i=1; AKwUvBzjEN29z2e8lHc+7QREv7K8NfHnA7YjNyiWgihnBf3GcUobw/geydzvn2YmEDylNekFkltqndA=@vger.kernel.org
X-Gm-Message-State: AFuF++k8T5z/i+H+sSN8VjzlO2hTD8xCFwThrSfFLTz3ImuPffpqv3Xm
	JjpY+KISmbzG7CeL5uBTsyrt1ihECXRc6PkhxwXprAv9Wu25cGDUlUjcw7lrY5Wspp3Z35gAXGU
	x3Ak1rwWQCLVg/Cmjkd2vUYwqxL3/fYfTX8NmJvU2
X-Gm-Gg: AYBFou0Xiaq3XGDS0VoKcbhyyuPJD2lyyRXkDf2UrdjfqwV13SQ+/mneq4MatEziwTu
	5mVrFCzWJ/6VTVM6Thh/e/JCadaqgGWnVSEcCtZ984fJuNjwcyUcRySIdu3SO3Fl0rhCqbCQgwZ
	MC29hnimgpZhTTJiRc2PCNU4VvbHPMJcq7783M2GZUKdYM/x3m1hAwUDmWN94LrqbKBI5540SDP
	JIrxd2fFgOIvf2LkQAv9YbOSkdMtna+CeDdSlVfZzX5AMHlrh8PYBpWmLYfarBgKJkJQkaVL2JT
	WxUm9GroVP6SDUHEJM4C1osaMAu0FGaVKzplcJT/RPs1kRrsHMg+0pSxgnsghBAZ8FybX+cyeG8
	eBYDgQ/jDfI+kN0PXEcFRhETcnJWm0KsPruHZa2wFj3suc0ayZP+zqw4HZKmyy4B/+n9p8HOxqQ
	JBaJce1Cy+Gah6FcgivxPHxsvByCmKRmUy
X-Received: by 2002:a05:701b:204b:20b0:144:c123:4033 with SMTP id
 a92af1059eb24-14503fd9160mr398713c88.32.1790201542213; Wed, 23 Sep 2026
 15:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921070127.42998-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260921070127.42998-1-runyu.xiao@seu.edu.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 23 Sep 2026 15:12:10 -0700
X-Gm-Features: AclHuK_cX28lFH9a-TsHKKsw7xvTUTDBMSfKJR-vi5UaPqx05gP3xNIFwct14dQ
Message-ID: <CAAVpQUBK09EfvhQfAztFzQsXD6-A-30fkG=ShjYN_CPBtthh9A@mail.gmail.com>
Subject: Re: [PATCH net v2] net: neighbour: Serialize proxy timer teardown
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>, "Denis V . Lunev" <den@openvz.org>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Jianhao Xu <jianhao.xu@seu.edu.cn>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 12:01=E2=80=AFAM Runyu Xiao <runyu.xiao@seu.edu.cn>=
 wrote:
>
> __neigh_ifdown() purges device-specific entries and then checks whether
> the shared proxy queue is empty before deleting proxy_timer. A concurrent
> ARP or NDISC request can enqueue a delayed proxy response between the che=
ck
> and timer_delete_sync(). The timer deletion can then leave the new skb
> queued without a timer to process it.
>
> Serialize proxy queue insertion and timer rearming with the purge, empty
> check, and timer deletion. The timer callback does not take the new lock,
> so timer_delete_sync() can still wait for an in-flight callback. Keep
> timer_delete_sync() rather than timer_shutdown_sync(), since the timer is
> reused after per-device and carrier teardown.
>
> A check of netif_running() in pneigh_enqueue() alone would not serialize
> the insertion with the purge, empty check, and timer deletion. An enqueue
> can pass that check while the device is still up and then be delayed unti=
l
> after __neigh_ifdown() has observed an empty queue. Also, __neigh_ifdown(=
)
> is used by neigh_carrier_down(), where netif_running() can remain true.

By "dev is down" I meant whatever that creates ordering between
the teardown thread and insertion, but I missed it's still racy by multiple
devs.

But still, I think adding a spinlock is not worth it, see below.


>
> Tested in an x86_64 QEMU guest with proxy ARP, three network namespaces,
> and veth pairs. An AF_PACKET helper sent valid broadcast ARP requests whi=
le
> the proxy-ARP ingress interface was repeatedly brought down and up. A
> temporary test-only build flag added a 5 ms delay before pneigh_enqueue()
> and after the empty-queue check before timer_delete_sync() to amplify the
> narrow scheduling window.
>
> The unfixed kernel reached both paths and observed a non-empty proxy_queu=
e
> with proxy_timer not pending 772 times. The fixed kernel reached both pat=
hs
> under the same workload without observing this state. Natural-load runs
> reached both paths but did not hit the narrow race without the temporary
> delay.
>
> Fixes: 66ba215cb513 ("neigh: fix possible DoS due to net iface start/stop=
 loop")
>
> Assisted-by: LLM Codex
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
> v2:
> - Add the QEMU reproduction and buggy/fixed results.
> - Explain why a device-state check does not serialize carrier teardown.
>
>  include/net/neighbour.h | 2 ++
>  net/core/neighbour.c    | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> index 8860cc2175fc1c9eb6b67f2c5ef149188c9feb16..15107c00b4df473e53e6cf2e7=
57fb2ef3c4fd3f7 100644
> --- a/include/net/neighbour.h
> +++ b/include/net/neighbour.h
> @@ -239,6 +239,8 @@ struct neigh_table {
>         struct list_head        gc_list;
>         struct list_head        managed_list;
>         spinlock_t              lock;
> +       /* Serializes proxy timer rearming with teardown. */
> +       spinlock_t              proxy_timer_lock;
>         unsigned long           last_rand;
>         struct neigh_statistics __percpu *stats;
>         struct neigh_hash_table __rcu *nht;
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 1349c0eedb642539b28391390fd82f543e004353..1ea794a541efb6852700062da=
2e25efac6c060e8 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -471,10 +471,13 @@ static int __neigh_ifdown(struct neigh_table *tbl, =
struct net_device *dev,
>         spin_unlock_bh(&tbl->lock);
>
>         pneigh_ifdown(tbl, dev, skip_perm);
> +       /* The callback does not take this lock, so sync deletion can wai=
t for it. */
> +       spin_lock_bh(&tbl->proxy_timer_lock);
>         pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
>                            tbl->family);
>         if (skb_queue_empty_lockless(&tbl->proxy_queue))
>                 timer_delete_sync(&tbl->proxy_timer);

I'd simply remove these two lines.

In net.git, arp_tbl/nd_tbl is still global, and we do not need to worry
about timer touching the table after being freed.  Even if skb was
put into the queue after pneigh_queue_purge(), it's harmless
since skb holds dev refcnt and neigh_proxy_process() will just free it.

In net-next.git, we call timer_shutdown_sync() in neigh_table_clear(),
where prior synchronize_rcu() guarantees there are no inflight arp/ND,
and then neigh_ifdown() is called and pneigh_queue_purge() purges
the queue.



> +       spin_unlock_bh(&tbl->proxy_timer_lock);
>         return 0;
>  }
>
> @@ -1729,6 +1732,7 @@ void pneigh_enqueue(struct neigh_table *tbl, struct=
 neigh_parms *p,
>         NEIGH_CB(skb)->sched_next =3D sched_next;
>         NEIGH_CB(skb)->flags |=3D LOCALLY_ENQUEUED;
>
> +       spin_lock_bh(&tbl->proxy_timer_lock);
>         spin_lock(&tbl->proxy_queue.lock);
>         if (timer_delete(&tbl->proxy_timer)) {
>                 if (time_before(tbl->proxy_timer.expires, sched_next))
> @@ -1740,6 +1744,7 @@ void pneigh_enqueue(struct neigh_table *tbl, struct=
 neigh_parms *p,
>         p->qlen++;
>         mod_timer(&tbl->proxy_timer, sched_next);
>         spin_unlock(&tbl->proxy_queue.lock);
> +       spin_unlock_bh(&tbl->proxy_timer_lock);
>  }
>  EXPORT_SYMBOL(pneigh_enqueue);
>
> @@ -1858,6 +1863,7 @@ void neigh_table_init(int index, struct neigh_table=
 *tbl)
>                 WARN_ON(tbl->entry_size % NEIGH_PRIV_ALIGN);
>
>         spin_lock_init(&tbl->lock);
> +       spin_lock_init(&tbl->proxy_timer_lock);
>         mutex_init(&tbl->phash_lock);
>
>         INIT_DEFERRABLE_WORK(&tbl->gc_work, neigh_periodic_work);
> --
> 2.34.1
