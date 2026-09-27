Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671D13C09E8
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512094; cv=pass; b=GynrlpSocOCcEM/E5VBeHjNfZjdeeG11nwxpFbnxt1nsj+aAo/7S3T2zINcTIlLiEoMSTs+jux2zrOuphRJn0ok9mCkoegl9RTIICnPm6/xHVS78S1tryqcANE/sfvCiyERaLNgcHVj31zrWBEJ8+NYjliHEPGhQVoVIctGZofQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512094; c=relaxed/simple;
	bh=aZ8d2LKjoUbC3Vb82drSDlRzbG1SJVf7W9U8iAuF1kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+IKhQgzueogKzjdxYa/9OH++vETuxHoRkdxGZit0t0fVTifvk/7403O0IQ6Z9mHNKPu9AaqSMSGmaK6cGXqIu5wDYFqfAHLXi2/fifaKJoB2j4okyQhRJVBm1q60gvxNyXsMxTNHyO45Hk9bImynXn/wj8cLP+2XHjvLmXtPyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbYbyO4z; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbYbyO4z"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac6fb4b2a3so52920a12.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 05:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790512090; cv=none;
        d=google.com; s=arc-20260327;
        b=ZEYsjyXh3XihvWEtV6J/+LXBHvGc4kleDHcOhqVht3wBzVrcMYp0xJSts+qCNkMzh+
         Pr4h3uFjwTFxenLdnfdw0rCirAlOuVnUDnSrP7sJ+1SldAxowJU0tw8fAePCvls/Q0ZH
         N6dI+Gw2Ppz+6bL1lxmYk9+/psxqcsn+q4tiNQHwDbzkq9pGjrfEx3GH8Cwpq4mEDah3
         8VjRii2tA5i5NAfW4XV2F3lFJmWL4r6DYDNfU4upS6xCFj9dqs6ce0v09h9KyA6YTpEp
         i0MSk2bZa4Ofq7yWcv82+quDDLTMtpxyPFNwDUv49H9raoW+tuFACfy2MCte9yvKFuNU
         5xlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DcickMSZi9tlx6KRNzjylAz8LM/Bp4ZoL8EqqOqvY5M=;
        fh=v8DvyE6iZ2MoLOxizMube096wYgNPVfN37AIPLcibDE=;
        b=KsUAVJ7iauTa2aXO86z4EV1g8+nc8Q5GxDxJ/fJjsSk4js4u1tdjXSn3NXaOQqa1In
         jfzoVvzMHNjfdG10Da/b6MaH2+PRZ6PojkJi+CwzId4ZRoyeCvRrZtSDxyRSKIFiegsl
         rei+Lx2t+F+F4ZexSO8R3LIXmug7rpmzmsY5tXn3gGUs+0UVZShUwAy6NuWykPEJ8bCf
         T1QI2TjDPb00x04dG7qi1sNIk8BqIseEIgNCLRk6c/aum+89KOygyuGIKyNmu8V016V9
         akpNWsEXlDDTcJ7pbrFG8F2zUhJoFXxIsaBVlNe36yYSBv7ob+TpNtJtXkc4reiWpN4B
         a95w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790512090; x=1791116890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DcickMSZi9tlx6KRNzjylAz8LM/Bp4ZoL8EqqOqvY5M=;
        b=BbYbyO4zlw/+BTGHKQQEDaUnBXdhSKiFufGWhPQGalR09kCBhBbY3TriGkr0pmOPrK
         jpGVWj64dFgd6IeyioCjgoYlt4oiyO/Ssndsll9WXCAlvbDhXMBI8vdgbFBqJovO7WCA
         +KZODJN05DMQo10vbauLBRol7+r5GNHXNest5rdg2R0F4A2AwRJCcHryUJj+He8lO+IU
         g8QdEeWWXP0hE0M3dChuXjzTD/A8KgqXgkWjwaISNGFF4vVrtnHi3/w2Tmr2bHAYdohw
         teHxsEa0D9jkXnrOrApMXadeMUhIxJkyu+OIsIZybxFmKfnuPvkdIE5BjOWqggfLJdhu
         a8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790512090; x=1791116890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DcickMSZi9tlx6KRNzjylAz8LM/Bp4ZoL8EqqOqvY5M=;
        b=tYqbKZVBFywTmmdkhRN6/Vbzh5QVEDZaI46XU2A+RHwjVKBoxxHuWqLd4zGx6F7ch1
         kv49svNX2bbhcdRE69p/+Bc6Y8N34sgYEFxRk3H0acpvc+y+GtJMmq6mmLliUH3q3lUF
         G+1HHH/LSXJF5kLOCGhZ2ZuklseL4uk1twUBYeMhG8gWrxqOrBFSmr4s6ecM8IT5ztYo
         tsDBUymkN9zHNBd9rplgaBniDx/opA9RBbp3gO+qbLYY0JBElBTHkATfIVr5dKcMJAcX
         0ed/SifUuudRt3H7p5WEW5yMIaMzdSlaBryufDZyW39+y27ymFJHl664Kle8G6+kW+1h
         2+sg==
X-Forwarded-Encrypted: i=1; AKwUvBzI34kKfzaRzUmB9QncC7wMkXbwrvanMHkWLaDP6vr8cwJvAdFWgG7hbfErdYq8S/sGrYA7/dM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLC2AesTZa4mp/iN0l5r/8O3hQTBbLEnAOu5Fhkn0a5TtZYFtmA
	X/tg7ziFDJLE0280dx4xrB5DVqOwI489Yr7SSDFlL+gjpWT+QN7tE5DwDu9jK83q0pu5YroxzAq
	yYYnO18X78Hc8PR+vt57bEd0GRQGdro4=
X-Gm-Gg: AYBFou1gY+tsqXFpmHYouAO9xyU9jK1sPLIzSpCEImX2oqdcatsx1OnqlFs8WBh053X
	xThG9I44hUhrYTnSQfof72uer5LB1H9/+8XbBQyt/G23fl/wv5vT3ElFwds2vRX1gg4cEVu3PXk
	aXo+KPgoE22wqMVyrNvrp+mtmXDoW6BEhr1cPjRLebxwu8PiLYy1rwTMnad6eABeEI3FDeVOag6
	GaBIeQnCeRSxFfik9nVvF4LuASx7P9qhumE7xgdu+iCKOIJHICVzQhmFKWWwB7QAwItvXtit77B
	69p1GNdxtQjjByECiCS52KFK+C/qL5OqRm/H5m5DraEavfOI4tKFXrnijBXqn1NS/+Bx0HhyAuo
	WvRnrtjw1q5M=
X-Received: by 2002:a05:6402:84c:b0:6aa:a78a:6a05 with SMTP id
 4fb4d7f45d1cf-6aae1a75d8amr6810931a12.0.1790512090262; Sun, 27 Sep 2026
 05:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731151426.3194039-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260731151426.3194039-1-nicoyip.dev@gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sun, 27 Sep 2026 20:27:59 +0800
X-Gm-Features: AclHuK_N5TNcjl4ycZyFw4hCS9apkoJ8loGQgOYKm-VCZRyzq2zwxDrXoe9gA5U
Message-ID: <CAAo+4rWo3Ok=7Qu__Hfc9JsFHNNy7vCU8KL7QX8nMbkAt20Nng@mail.gmail.com>
Subject: Re: [PATCH net] rxrpc: Prevent poking connections after final put
To: David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:14=E2=80=AFPM Chengfeng Ye <nicoyip.dev@gmail.co=
m> wrote:
>
> rxrpc_poke_conn() unconditionally gets a reference before adding a
> connection to conn_attend_q.  This is unsafe for the connection timer
> because timer deletion cannot stop a callback that has already started.
>
> The following interleaving can occur:
>
>   I/O thread                         Timer softirq
>   rxrpc_put_connection()
>     refcount reaches zero
>                                      rxrpc_connection_timer()
>                                        rxrpc_poke_conn()
>                                          rxrpc_get_connection()
>                                            increment from zero
>                                          list_add_tail()
>     timer_delete()
>     rxrpc_clean_up_connection()
>       timer_delete_sync()
>       call_rcu()
>
> The refcount increment saturates instead of resurrecting the connection,
> so cleanup continues after the timer callback exits.  The RCU callback ca=
n
> then free the connection while attend_link remains queued, and the I/O
> thread later accesses the stale queue entry.
>
> The kernel reported:
>
>   refcount_t: addition on 0; use-after-free.
>   WARNING: lib/refcount.c:25 at refcount_warn_saturate+0xc0/0xe0
>   Call Trace:
>    <IRQ>
>    rxrpc_get_connection+0x185/0x1d0
>    rxrpc_poke_conn+0x12e/0x2b0
>    call_timer_fn+0x2b/0x220
>    __run_timers+0x561/0x8d0
>    run_timer_softirq+0x144/0x250
>    handle_softirqs+0x18d/0x5b0
>    </IRQ>
>    <TASK>
>    rxrpc_put_connection+0x2fe/0x3f0
>    rxrpc_discard_expired_client_conns+0x396/0x670
>    rxrpc_io_thread+0xbfc/0x1640
>    </TASK>
>
> Use rxrpc_get_connection_maybe() while holding the attend queue lock and
> only enqueue the connection if a live reference was acquired.  The normal
> path for a live connection is unchanged.
>
> Fixes: 4241a702e0d0 ("rxrpc: Fix the rxrpc_connection attend queue handli=
ng")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/rxrpc/conn_object.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
> index 0ece717db0f8..3f4516115d37 100644
> --- a/net/rxrpc/conn_object.c
> +++ b/net/rxrpc/conn_object.c
> @@ -33,10 +33,8 @@ void rxrpc_poke_conn(struct rxrpc_connection *conn, en=
um rxrpc_conn_trace why)
>
>         spin_lock_irq(&local->lock);
>         busy =3D !list_empty(&conn->attend_link);
> -       if (!busy) {
> -               rxrpc_get_connection(conn, why);
> +       if (!busy && rxrpc_get_connection_maybe(conn, why))
>                 list_add_tail(&conn->attend_link, &local->conn_attend_q);
> -       }
>         spin_unlock_irq(&local->lock);
>         rxrpc_wake_up_io_thread(local);
>  }
> --
> 2.43.0
>

Hi David,

I noticed that an equivalent patch from Seungwon Bae, =E2=80=9Crxrpc: fix
use-after-free in rxrpc_poke_conn()=E2=80=9D, was included in your fixes
series:

https://lore.kernel.org/r/20260923133706.1496540-18-dhowells@redhat.com/

It appears to address the same race using
rxrpc_get_connection_maybe(). Since I reported this race and submitted
an equivalent fix on July 31, I would appreciate it if there could be
a Reported-by tag, or Co-developed-by tag for me.

Thanks.
Chengfeng
