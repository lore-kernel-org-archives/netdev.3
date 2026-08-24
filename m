Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E1382397
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595773; cv=pass; b=XBN9Pwea08k/qcN0esZAgqe0iaqDr06MjuAGjBuHivuN0FpqLaNxD5lEGShGfGBwlemIpga8eavNsvlXInyqYzGW8sy1Zx4jCDgxhsR+422HigjaGBbgC19jnkaowi+O+B+mSn3BY2InL31rtmpQXtYoeD9U1AZQz5otQ/yXgsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595773; c=relaxed/simple;
	bh=1h7+5SdSR5g5oWKqRm0UyCzSJRi1vMseV9lOc1BqdN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIVFkoI2TYoIH2Ju8IT4oZFHu3LlN6Sc6E9kvhdfAmEM6VEMOiJBMDRzekfQwjiAtvIWLvmPeCpeXIkedk0O/yFPsos/hxAkAwmYD3U5uahRKGvKbmOlvx0mSszUB/B71hVT8R/gioCDvYEuE69tBiHqOIWrIU37mlp7r7NL1c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hcCOGBt/; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcCOGBt/"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceab75934dso51980415ad.2
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 11:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787595771; cv=none;
        d=google.com; s=arc-20260327;
        b=IFCU0sM8k351gUQi5wV4/Ijqt8u4UamL8ZDRwepxQWH1T5+tA4gCtQoL3ObqpRgRQp
         oBrFGBUMW4KhGZv5Fmg2mJPp61SnTEILJfMSNnUyjDZ6ZlFzp6E1WxTiUt84xM0uf7k0
         SsJAYzDzjoBmh7msXJ604rC6mSBCsfQHEPr9Pq8RBNCuopNKZ2NlrEXxNIZ6DMypV2AX
         eDxu9nPtYjwovF/4aZIhJKq82s6/szctqL+2K8YEFzWvlYgUN2mW7eJ9QXB9Nk61tIdr
         a4/OuRcabNsG1ejR5VRnesj1nm842QqpZdO3b4kQyELZwZ8VmUCkhvDMLkJST335gtfu
         T7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CMsomiXlkv8l2V0OZC02rc+ZeIqlCAWy3EWkF+bVKPY=;
        fh=XDtm/5d+kvRmsxN/HbTiW9l+AnAth9b1kGIYIfgoyJs=;
        b=FilVrK8UBoPr02U1xhbmNqMcdRCJqLErwAqaRA9AMGPR6ZztcBIVa+9ATOLbbCHLM8
         DVgCgfbalkxxCtsiNUrh3noSR299MoanQPDqnPlnSYfVUPxgnSEQYLfDBC4NEfHYhb04
         YD53oLe2a/MdXFa2HHTj8Kz2Fnfjk83jQYPdiswtm957cd5m9u/4iCm9/Z63nrU0v/Cl
         BDDUQNPVw+wgqL9JO606GJGITXqjPxqpZ3AOWUTfnGQmMY2AnBUy6TRr0C5ZTPvCzLQr
         LFCgIHs9aCjUvSo+FDK+FOjxQd1TsIvxo7udMA31+NDAAs9VqLmOVPHCiWTJN850/L5k
         k0ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787595771; x=1788200571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CMsomiXlkv8l2V0OZC02rc+ZeIqlCAWy3EWkF+bVKPY=;
        b=hcCOGBt/vumZi0WXqE50raHwr0VhsYvxl58wI9Y+VZT3C70o/LnbM9cx3Fm3n3fBpg
         0yZ6eiHDVbRlu5FMxEQsZ8T3HDbp76m95ZuzeJKdHi4xkNV2r2ZjbhWxIH+l8xZQC8y9
         yDJ8nnlPrqIN1nmatFwJ/2qzPmN+1b0pYWNMX9BiNSEQzokH143CbBE8fKCvXxtlmZKg
         PA0KQXw157mrzqfOjJV95ARQZM+I5tG8xIJCU4goggD6FLVsYYecAaeOX0OCGwIKKvtU
         HbYpF6YbPk7FoY/GR4qNQNG5rRYDy0E2R2yVGqKyF56wB6ty3tLT/Bnd/pXBc9HjJHXA
         RDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787595771; x=1788200571;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMsomiXlkv8l2V0OZC02rc+ZeIqlCAWy3EWkF+bVKPY=;
        b=hRxqRDMaJee/djxwLXmIyRJlc4VOY69KfdTTNGmP01D9f+SzBCUZ/UO8wuBVZ2ryu+
         qlv8l2Y/9AEXiihA3KdYKBxBhN3dnHfdzBdIHlhrPZTvM5PJjfc5WsReH4D35gaU6g57
         SvBkmZlZ1Q5b+WhjVOsVMUMraB6PZpmBpVZv5PcrTv7ln1iZhqnkLhg4Nc+Rvbu+lbtG
         UbK7vfmkhoes+m6APZsdF1iGrfMaL/PT+I1//oKavB4k/ZiIZtNSY9Opc/K/j7pEsllN
         EuoaRIH/Y8HYrA3yfu98qfNHVpU/uKDq/444xdCskQy3S9Q4encx04aItVHYblB3w1EY
         VURg==
X-Forwarded-Encrypted: i=1; AHgh+RqFuvj/WXPDB6ypP1X6tv5s25rcTUxiMSYtdp7P7bwUiO3hvY5f3h8lcG+Ywuy0kPb796yCDvY=@vger.kernel.org
X-Gm-Message-State: AFuF++lXr7gqRq4HVlp31+1fVbNa9iiAvqe4/QAUOFaLxvsh902OwUkU
	eYMsBnLPhI/DG5y2ZkRm0ht/a+lumtgSJxttYpS2RVNQA5Z7LYT+2o7Nqn2XwmRKf0OY0+0i5MX
	0+qILnSQToCRl/17g8OE5wrr6V4hzVgCvwG/A6wwU
X-Gm-Gg: AR+sD111pSeggOTzF2TkuqKXVYcgy1nkPp9F0IlBgbzc7QZcenjHT6pVv6CieiCVfZG
	KsFVLUCQCDeLgxjh+a7AbJ/xerlAtZJPqvubBMmUUUZ1YRReU33X/fxEEKPS5pldmlwZV95qyyT
	lsoJYwd9HU2yDZ6MUnHCbSa3dAjIeiS1ICM5zBsI5IlVhHcjKEO03Ia1ubWSoGRsOkz3WE3syCM
	xitKJkrlxy7OWt6R2Paoszn1YM++W6+Vix/YMHoVXJYTgV1DUbF3bX6DPh4QtHA81MxoO3uhTYH
	GVcgG15SLOwr58JWnqf5RhHsA6YSQI9gQampPdorHTVxlXTSa0+h0U7GMNa6iH9l3wbm+txiiMk
	yKURUT/A1fuv2Q4qvXxVNKETgoJcWXgrSUAsCEvdsXMV0xmB3rsJu1wofZ+q0l40nCplho273tc
	avtkCStT2/qDvCbFYcSsYFuQ==
X-Received: by 2002:a17:90b:3811:b0:393:288:29e3 with SMTP id
 98e67ed59e1d1-395df24f20cmr34888338a91.10.1787595770675; Mon, 24 Aug 2026
 11:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823171311.3857087-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260823171311.3857087-1-nicoyip.dev@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 24 Aug 2026 11:22:39 -0700
X-Gm-Features: AcwNN1VSZLYcZjBQm5hSVMCTVl1bVSQ-ufx1mFWI5AReSPKrzbgP1iQ2TR2WFHk
Message-ID: <CAAVpQUAaCuwYyC97xXAwry=0QAWLo7+AM1ct2xqq45PkwJKKOw@mail.gmail.com>
Subject: Re: [PATCH net] net: pin protocol module before socket allocation
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Frank Filz <ffilzlnx@us.ibm.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 10:13=E2=80=AFAM Chengfeng Ye <nicoyip.dev@gmail.co=
m> wrote:
>
> sk_prot_alloc() reads prot->slab and starts allocating the socket
> before it gets a reference to prot->owner. A protocol module can begin
> unloading after its protocol was selected but before the reference is
> taken, allowing this interleaving:
>
>   CPU 0                                CPU 1
>   slab =3D prot->slab
>                                        proto_unregister(prot)
>                                          kmem_cache_destroy(prot->slab)
>   kmem_cache_alloc(slab, ...)
>
> kmem_cache_alloc() then dereferences a freed struct kmem_cache and can
> crash or corrupt memory. The kernel reported:
>
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: maybe wild-memory-access in range
>   RIP: kmem_cache_alloc_noprof+0x63/0x370
>   Call Trace:
>    sk_prot_alloc+0x74/0x2c0
>    sk_alloc+0x2b/0x6c0
>    inet_create+0x2cd/0xd40

inet_create() rather looks broken.

inet_unregister_protosw() calls synchronize_net(), but the following
proto_unregister() might be done after rcu_read_unlock() and before
WARN_ON(!answer_prot->slab) in inet_create().

Which module did you use to trigger the bug ?


>    __sock_create+0x1c3/0x430
>    __sys_socket+0x116/0x1d0
>
> Take the module reference before reading prot->slab so module removal
> cannot destroy the cache during allocation. Drop that reference after
> freeing the allocation on either failure path; on success sk_prot_free()
> continues to release it as before.
>
> Fixes: a79af59efd20 ("[NET]: Fix module reference counts for loadable pro=
tocol modules")
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/core/sock.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 1ad41904db25..59f4b15fd594 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2240,33 +2240,34 @@ static struct sock *sk_prot_alloc(struct proto *p=
rot, gfp_t priority,
>         struct sock *sk;
>         struct kmem_cache *slab;
>
> +       if (!try_module_get(prot->owner))
> +               return NULL;
> +
>         slab =3D prot->slab;
>         if (slab !=3D NULL) {
>                 sk =3D kmem_cache_alloc(slab, priority & ~__GFP_ZERO);
>                 if (!sk)
> -                       return sk;
> +                       goto out_module_put;
>                 if (want_init_on_alloc(priority))
>                         sk_prot_clear_nulls(sk, prot->obj_size);
>         } else
>                 sk =3D kmalloc(prot->obj_size, priority);
>
> -       if (sk !=3D NULL) {
> -               if (security_sk_alloc(sk, family, priority))
> -                       goto out_free;
> -
> -               if (!try_module_get(prot->owner))
> -                       goto out_free_sec;
> -       }
> +       if (!sk)
> +               goto out_module_put;
> +
> +       if (security_sk_alloc(sk, family, priority))
> +               goto out_free;
>
>         return sk;
>
> -out_free_sec:
> -       security_sk_free(sk);
>  out_free:
>         if (slab !=3D NULL)
>                 kmem_cache_free(slab, sk);
>         else
>                 kfree(sk);
> +out_module_put:
> +       module_put(prot->owner);
>         return NULL;
>  }
>
> --
> 2.43.0
