Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782F3FE344
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585921; cv=pass; b=G/kfLvKEwRhHBP3/f6z28KBPXoluElZvdNY9CIFQlkUb4VM7Zx9ei+v9ZmsJ/uez6TsaYlHEWyV/1HOPZRwz+/VDXiBTbNZ0gxziexU57UI+PmZ5EWbDpeLrsPw4RBNlt1i9D18t2xW3SNqHQ0+56pEYI4YVvPIw/j4qS1x0GRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585921; c=relaxed/simple;
	bh=r/rBsZLsnbKK56csNU7DLUDOFSeqrsm9xyXckzSU3y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGwLH3bxm1AlAHi/zJUPv0dRn2gOtzcPAFypdvSwy+t0f01JN5UV8Nna1zy/paDQdxbxI6dY6sMiarAbhcRJEMj6M6pEEf3D9yJGud6RFU3HxxpaxXN5cTTm50etmVv8s+LQMfHfotB/o+9/kv50ubVOqpXEAJ9RagCt9imsd3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ggDpm/5s; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggDpm/5s"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8200b55dc47so56380707b3.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787585918; cv=none;
        d=google.com; s=arc-20260327;
        b=BHJuHc062ukGA1a27Iv60+N9lSpUBVwXvDmUXqur3ivudpkpmUQIq5BgxxNgS/rwQA
         aGk5xpDCaGJ25bisPEzJy/ZdcDcSLmZdih9pCQec4oE6nxmiwcFrKtW7T5l9fCbxrgjd
         EjsZVT/OktyO/bb8eYXpmrTApjJFZqeS0q72Un6NR/vok4Amuv0HWEZiAAVcc/8dMJSE
         S0cyqFXVmdSFF0f/4FQMLmQ6HCblKd1IB8j/+AFOc1FxJ7N32YZ1aaq/fx4fnNc8k7l7
         6Dz7lBw+1MaAyypM/cuR+MbcwFoEf/D3tHSX5f9Nlc4PV340vNN62d8wlzYOmNgTHOuR
         x2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=US8S+/vV4WhR6o6yHvOZ5lAXa57QYwX5/z8fvhYXu9s=;
        fh=KXQ/3wQTMCv3D4dg0lfhVVKGw+kQRgKz5uy3XkHqZN4=;
        b=FMjgnIR6PPicrKaYXPdncpFv5YN8MLbLphp0CSrlmu0drmBb6fZhY1TgXrN0p7fJPM
         RPsSJg+A3HD0xFfh6GcLt72nJ0ZbvAhQwScRaSXKNnXe204ked8bLSFLDT3k4K1MsdWj
         LLq6MA6ax3Q/H1AXgfYDrmx7XqGZpZnTu2bgONueoxawggfM+ewvVU75+/8VdcthSCuq
         kEtNNiJV5KXRUdVbK+yiJ5UfLui3ko4y1+1Paa67N71lsF7I0mtjNLN+djlj/yk6gnbJ
         qAoJX2maR7QT65WeqG/takXLhsL1jVnY1amqat7lmmRkw1QycO7Q57G8vTKB9QrA/kSN
         KZiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787585918; x=1788190718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=US8S+/vV4WhR6o6yHvOZ5lAXa57QYwX5/z8fvhYXu9s=;
        b=ggDpm/5s4hYiD0nBQLHIv80vgLEL3P28ee8wEizRCrlGbo+qFYujhEFtwYb9G3eJZo
         6ULamtk43RdjNjFndOdW8NQe3EBWydsigJIHXYFhZPzYSck1L16pqo5gmyrVI75BOqEL
         0eJZuI3ab9LvdNHQkSqz1euZEfpJRKkVMjtOiAz5CFPwKlq6T7+Y4+MYVxcZN3lsXxwZ
         gvZq0iLNQsOCFEYAamCwQJP4+bw1Z9PORTJYgnIXl4DeNmM0oenEW15Px3RLD2Khisr4
         +q7XabsvqCAhabFe2GVvdEGcDZvddSPCvop69Pnc7Dx58tH+hXZ1BizilYY3h3BZGXlA
         fwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585918; x=1788190718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=US8S+/vV4WhR6o6yHvOZ5lAXa57QYwX5/z8fvhYXu9s=;
        b=pRN4oduvtU7hmeiAOl9LM0hsrWHtzeV+7xIaN60UkfgZmLvBopxr8jIEQ5Ri+xBn3E
         015UfPs8swBruJuKTuGDA7e6J0ik9/oRINR2cM8IWQjQRF6RxzH4gb3qOXhB0a05F2mF
         +JW6pzLkPunkwbg47ZOBxyknTrb6mF/YkXdob+WMQapZ65ZjxQuAsR+k13jle2rNaTR1
         a0pfL43TDGqVnMLFxECPIBBLF67+dvlhfpcLDjGxRDR6Ngaacc8hkx5FhlcjAX8TCGxk
         OC/ADbs5jMoAnGBQdlAZYkwvqOku/TufLEEykY352ixj8a6qL3z0gwq1kvCdwIdJ/RAV
         wkSA==
X-Forwarded-Encrypted: i=1; AHgh+RoZaIPxGh3mbNVsNHkGHzPb412gNAJzWQlfcAYlkawepC3u0F310HD34wpojsM5M17ZhBCu4h0=@vger.kernel.org
X-Gm-Message-State: AFuF++lxfHjHg+6m/DFn/FvJLSx0AA45LtTP3p0FSom57ZqcaAtx2/vT
	0PG+a8ZJBbFeN/RmT5t+3zm3TfnZpYGAEzV6MQOFIusjo2uvBWiaJnQe2BQRBmf4hPmdOoPUN47
	IHylSVNVMU6axrTRnABsthCC16gVZQo5B09sm9YZe
X-Gm-Gg: AR+sD138+VjVSxOYN8wqh6dA0j63JRWi7Fk1ARJtlVWF5Cz85/Fmth81PBzHOnwQzot
	NUpdd+l11AxrRN3BojYndnORw21PlWc3n/jx8tM1yJ1dvlgvhvWT+cLGe/0hooDgh3ihcs0TVPW
	IaxsnkAwfvdHCOsC+tFMBJnPaUjtezgEUuQX5jHwLn4i4qgNjYlPeluoX6ZAis8VDBH+Mxkcd+Y
	y36WJJ9kF6qYL3qvDt3KZL0T3kYVSMFbYKyPypr2v0udIu6ck7aqkpGOiWuSzCeYwZpxqIh2WgY
	1/k4gdhgOLWTdly+sFej7PSLeaQbi//8uvPhWoTHMKgqXtzRukMRYGrf+d3O2OQcaWaq1s9qPs7
	+AuBV3HMEaQXqGJLM1E++oZiTPDIrgIZG7dCD6iqQMg7bnVq7JxUYBQlb
X-Received: by 2002:a05:690c:4c0c:b0:81e:ae6f:ac0a with SMTP id
 00721157ae682-84c9ab40a13mr67850447b3.24.1787585917172; Mon, 24 Aug 2026
 08:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824152331.216494-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260824152331.216494-1-nicoyip.dev@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Aug 2026 17:38:25 +0200
X-Gm-Features: AcwNN1VGaZ8jX-9PNXsGat8z4kM1LdecEHINx1LTgqGE9iX3p6f8jiKqC3XBxpk
Message-ID: <CANn89i+Ms_cWNb-EhVi+A+VekBEJPy1kNvm65y3BwJ0k3q5QLA@mail.gmail.com>
Subject: Re: [PATCH net] net: pktgen: keep device lookup under RCU protection
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Qi Zhang <marsy12010123@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Alice Mikityanska <alice.kernel@fastmail.im>, Florian Westphal <fw@strlen.de>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 5:23=E2=80=AFPM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> pktgen_find_dev() releases its RCU read-side critical section before
> returning pkt_dev. __pktgen_NN_threads() then sets removal_mark through
> that unprotected pointer.
>
> The worker can concurrently remove the device and queue it for RCU
> freeing:
>
>   CPU 0 (netdevice unregister)     CPU 1 (kpktgend)
>   rcu_read_lock()
>   find pkt_dev
>   rcu_read_unlock()
>                                    list_del_rcu(&pkt_dev->list)
>                                    kfree_rcu(pkt_dev, rcu)
>                                    RCU grace period ends
>   pkt_dev->removal_mark =3D 1
>
> The mutex held by CPU 0 does not cover the worker and does not delay an
> RCU grace period, so the final write can access freed memory. KASAN
> reported:
>
>   BUG: KASAN: slab-use-after-free in __pktgen_NN_threads+0x241/0x280
>   Write of size 4 at addr ffff88810dab804c
>   Call Trace:
>    __pktgen_NN_threads+0x241/0x280
>    pktgen_device_event+0x24e/0x3d0
>    unregister_netdevice_many_notify+0xde8/0x1ec0
>    rtnl_dellink+0x35d/0xa90
>   Allocated by task 92:
>    __kasan_kmalloc+0x8f/0xa0
>    pktgen_thread_write+0x498/0x14e0
>   Freed by task 0:
>    __kasan_slab_free+0x43/0x70
>    rcu_core+0x50a/0x1850
>
> Move the existing RCU read lock into the sole caller and release it only
> after setting removal_mark. The object therefore remains alive through
> the dereference, while lookup order and control handling remain
> unchanged.
>
> Fixes: 8788370a1d4b ("pktgen: RCU-ify "if_list" to remove lock in next_to=
_run()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
