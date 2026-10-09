Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2DB36CDF2
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581229; cv=pass; b=Tz+0lkn0TSLmK6UHV8gtg15LkbcIx5UgFn2Pi0/7uzg1lS6m0sB6JNZQXodrJdxl+Wq67SZyN2EAo4r+/NMN/ge5ItZBKs923su682uCxclTUOBysSjvnbjvm/ivJ9EbDN1KTEFthUb1aY/Cj7Ag7KyzqwzVqnD3APpWGshmpMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581229; c=relaxed/simple;
	bh=QvfOev/kNjrTzZlcRux0/BJPGnCOibnkboeSn0C8BYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A87N3dd/qnPfxMBQ3jnIOqGHn9jWbZRwTJLb9v7bcshIdq2q6ULb+33J4udXLU08sNF2dCJHyRTCKEIpwj2sYtPfPR0CzueYDks/K3khv7EWNTHv8bHTLT9ruYrXO2H2/RfsJW6rnuVZOddxGU6RbaGz4YCa0gEhk8vlB1Tad7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ohPkeVS6; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohPkeVS6"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1438d9363fbso101545c88.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 14:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791581228; cv=none;
        d=google.com; s=arc-20260327;
        b=Bpboiz0dmtQUHtHRC7hMpo56rhaSHdjmcJ76I0PCUTbq26n5yWhSqsJTMFECVH0zIl
         gO3TLT1kFYm0NZnNJbxUvYyglQuy7X5SoktuAVer2BDmjg1Z10eo6nvegyIT0febJE3W
         fweMdPD+FOZBxEiokD9NzoXKJBrFKyIdu36FHSiWk3s6mZcfCzPPvDy0ve9num5HeyWg
         u/TTPulp4bXoDmhjnpcp6b9e1cFJKmKiKnNWBTa+t70VgaFyZYlaZMlZOQitsajcf5eB
         7SP/dLEMH3rBhKqgerefFO1h8QNNzXHZKmidCADR7E+x0ojuav7kHTSi13FaxRReH0TT
         g66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K9rEvNwhZL8B/Lev+DyJhGgCFb2qdLa9TXCpr4AiRWM=;
        fh=mRAL/CzDVef/17IM78rmFWk6JAWP4XmDdrf6Sk+CqLY=;
        b=fcaXNfemX9OBpL14FRvSR8E01y0C7kIdrzmrGqgu5vHlt8+gJ8YQ0STBo7K1yHwehF
         HlijYpdVMo3VZQOQDt6/93MB3oi/XiRe+rDxYScbftXFM8PAVoi5KGpAUyOwl/Inz9Zg
         N7ipA1C5YOanQt3B1GKhiBtQJrxM+igplsn/QPqfAad7w1gpu1ajFGW/Y2cfNSi6gDdZ
         ZWVKas69HVGSaLBa8bxcoYDww7wv/RZEoNQHEsca9Wxas+eNZgW2wOyRwXPi1fObm0fE
         WfZ2dROrSfp933ayUONMGXDErQ218piIpyCkbZZpnU/kj/9PF5RXjjgUYze6eGOk2/6o
         ICBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791581228; x=1792186028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K9rEvNwhZL8B/Lev+DyJhGgCFb2qdLa9TXCpr4AiRWM=;
        b=ohPkeVS6nHqSHXwvmMp2FW3zabkBY+YXhBguoYsb6H5SB/kzOCFpkDxQZqG7V7s38N
         5WU5fna9s4mUsH4rSsTPlefeoKYW12Pv7PGQgkZ61eOtl0/so56R3b4U/Sfn6SSKue6K
         g5759USyTc6oa0lqigiT/OywMNItd94b+6H8ds6TR1E3XBpTW1FWghpE84wFxqgsl6tR
         viyN5hfb6TUe+ZIEG9D1b/wZL2FhsNpSlaW3AUXnNsAC2lAr8nW36sx8GdLT9ehZOAlU
         dVD8sk54WLjMgXMmVV+K11zPpSo97us29df3BxDxQ/YyPltLFEZu3FLZfs/l8fugOrHY
         sATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791581228; x=1792186028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K9rEvNwhZL8B/Lev+DyJhGgCFb2qdLa9TXCpr4AiRWM=;
        b=J3viM0odx0rEWki9c6UafeIIE+xBiq1IHQj0u5B+qGKQJQbjo3a9c+8s5B+AkgGNOZ
         a1rrzEsvbK/HGdcb/XuGDYbuGL3fs66e1fbRZPZldyjHn8FKLqWzpfOTGnL8bDoQKg4X
         8gcjlKIwj0HNRbjdqHynuoBTKnqZ/oLdJlL6lxwPisoiDsCcHjUn/uj0u9JdUwE2BOtt
         tFvZ/wnIteO8ZdLswxDZnPI1ev7o2s4d7y3WPMTDqa8zf4Pf5mhveL3BNtX3wrMfxHZ0
         WsL3UuQYQ8VZZZM7VNT5ap4O/oB6+j7FsuzaEEKJc1gmPHd8nNcCRwo16Bx6qzvHYiZD
         oWqA==
X-Forwarded-Encrypted: i=1; AKwUvBwdNWWkInY0z/ieKccBxd4FsVGjyxQjsz5+speI+0KdcUG1A1/id/0RteFYd+JWyxXVVW3H0nY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrLvyXsKD1KLcynZEBfMies9ZR8dZr50rfcjJ2qgJiI2ohSHTd
	YbZo4a7HYwjKRC2g52HlVFXe27ecmNTYdj4jn+KCvUaPwlbUwUx9Jn9MMFFomE+aBgcmt4Rh9LG
	E9wD+R0qsb9dCdXWbhBpvWUbE/7KXiAArNZn2ziIA
X-Gm-Gg: AYBFou2uUuFSoaK5K26Wq4Mt98rT05D9IttigPJXAvCdjRhRd9yzf4STId6tDRtiBQ2
	WZcSuILNK2l3Oj/xB8eA4EZuftt/gvzO3YZEHQFpcxZ85lPENqafHN9Ip01/LWn35lXMl7k68ef
	k0tKR2l97+x0mZb492TAv/nk7i5R0JGNaFiIH0zf10qA0vkUTLoDurM9AE3O9zKxk06NZzcJJ7g
	zSEcxCNXPQ9pvW2eRpToRLGrTKKAC93FAHBdVXjtOVT1h6U9YcF42bHHQqk/N0IjbSkLtV1vy8s
	o9nvotEeV+yyiCLYHpwnAUtkgiXPv5oz/0515mSKGk78L0g9XsR4oQk9+jrsF9ESYiRfeo2rsGt
	2Knm65uDxAy8DxUf7SEBwRWIS8zGq67yvJ1Ucvthb+3sPoZMLbXSx6PoVXhLkYAt89eGXjnTQgB
	WVZ2dcL4hZPIfMGm2N+tUKji4zsorU57ts7MM=
X-Received: by 2002:a05:7022:6ba1:b0:143:f79:f679 with SMTP id
 a92af1059eb24-16a550ac0d8mr5397500c88.1.1791581226784; Fri, 09 Oct 2026
 14:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009091941.5837-1-qiang.zhang@linux.dev>
In-Reply-To: <20261009091941.5837-1-qiang.zhang@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 9 Oct 2026 14:26:55 -0700
X-Gm-Features: AclHuK_J95wJd0bWuoFvKLXCYzd1NhAAgTupAiZXo-_Ua7w7PO5ZgOC0Fqxyfzk
Message-ID: <CAAVpQUAeHP7M07uMweRePtuzPPUo-99dL6jOYUiVf7CSVUxNDQ@mail.gmail.com>
Subject: Re: [PATCH] neighbour: Move the netdev_put() out of RCU callback
To: Zqiang <qiang.zhang@linux.dev>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 2:19=E2=80=AFAM Zqiang <qiang.zhang@linux.dev> wrote=
:
>
> For builts with CONFIG_NET_DEV_REFCNT_TRACKER=3Dy kernels, netdev_put()
> records the caller's stack trace via ref_tracker_free() for debugging
> reference leaks. however, the netdev_put() is within pneigh_destroy()
> RCU callback, this recorded stack is uninformative, it does not reveal
> which code path initiated the deletion.

Have you seen pneigh double-free ?  What motivates this change ?


>
> This commit therefore move netdev_put() from the RCU callback into the
> caller's process context, and replace call_rcu() with kfree_rcu().
>
> Fixes: d539d8fbd8fc ("neighbour: Free pneigh_entry after RCU grace period=
.")

Please elaborate why your change is safe in the commit message
and remove the tag.


> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

nit: full name

> ---
>  net/core/neighbour.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 6ed8eb075146..4263689fc415 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -818,14 +818,6 @@ int pneigh_create(struct neigh_table *tbl,
>         return err;
>  }
>
> -static void pneigh_destroy(struct rcu_head *rcu)
> -{
> -       struct pneigh_entry *n =3D container_of(rcu, struct pneigh_entry,=
 rcu);
> -
> -       netdev_put(n->dev, &n->dev_tracker);
> -       kfree(n);
> -}
> -
>  int pneigh_delete(struct neigh_table *tbl, const void *pkey,
>                   struct net_device *dev)
>  {
> @@ -849,7 +841,8 @@ int pneigh_delete(struct neigh_table *tbl, const void=
 *pkey,
>                         if (tbl->pdestructor)
>                                 tbl->pdestructor(n);
>
> -                       call_rcu(&n->rcu, pneigh_destroy);
> +                       netdev_put(n->dev, &n->dev_tracker);
> +                       kfree_rcu(n, rcu);
>                         return 0;
>                 }
>         }
> @@ -891,7 +884,8 @@ static void pneigh_ifdown(struct neigh_table *tbl, st=
ruct net_device *dev,
>                 if (tbl->pdestructor)
>                         tbl->pdestructor(n);
>
> -               call_rcu(&n->rcu, pneigh_destroy);
> +               netdev_put(n->dev, &n->dev_tracker);
> +               kfree_rcu(n, rcu);
>         }
>  }
>
> --
> 2.17.1
>
