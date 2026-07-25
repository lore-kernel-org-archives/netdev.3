Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD538F947
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970853; cv=pass; b=d0A3SqrXBCoEIQNNX9Sw0fbYFHYsW+AbIKnS2l0DxtqP1li7yNv9zvEInVdG5cRDe+xhYrj/ZKvrrZuBvwBTttMYGNSsQPtrGGkP6WLiV/TrYOlXyF8gaYCDqqCcZ4g74/vl1giBaZd4ku5wxpLAY5cVV5Etd6AN2ai+/vvNuAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970853; c=relaxed/simple;
	bh=b86w1Hfbxe6xSAgB/lj5BiWyVXB4U+5oiASYMA0EXeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXm/pnipMciFGG1p8AW458ATxoCbSMa4fzURQHXVtwrJQQw6wtdpjz70S4x0dSn3ESut0xmN5SSrRzALaN9GWVcXmJKRkN0XjKwAotbX6GCF7iGeUrCOcgUgn4+IBeMMOWU1N7AvhM5V5gtOwX2QtFDv+86u3M98mZAgZS7ipFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+MDvqIp; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+MDvqIp"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b2a44a3b66so1184843e87.1
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 02:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784970850; cv=none;
        d=google.com; s=arc-20260327;
        b=aQfVUvsmj7TefaOcg/dHGyttmKA1kK4u/uFQHHnEsPM0P7xtY5upAy7qKbrpb7ufih
         jeuE67nWL4kmz0LFoq7VI6IRkP3pYc4U5uhkSdY5XzOwrLzBqwSJjeqYFNR7/Ovqzgj2
         F51bWy4gIx3pW2lJO1RE9wNdRA1FqEz1fImdm5mTcKnyhW/1d/DWm+WM5C9WlgjJZZWv
         cvZD6aTtp5Sv8xal2v6P0/FHIAzVqGWQuhClwkdoTOX+QoUad3gCy88dUGVlzYp3sfDq
         LuRl3qKzw/d5RNVuB9TggUkHXcFLrWvYv9/eqr2u5CmQ+W2EPDk/RUncKDj5AgiBkA/N
         BiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rFSKBs58ICJvc3f7BylS3e76h+CIlOceHYfnXTfuT9s=;
        fh=/DjhHshUjbb/E/b8+xWGdvEhrhGj5oGCC/Qb1d/kMqw=;
        b=UoycQI5qvGuq3L8/sBzHf4QVVx7nhvV2O2jvTJRDRmj9hbEMPyKMCn0ySUwRz4nfwb
         C0738Lk20wbCH2ZAEDaZuU05uMwBozrkjiv1GfPkc6HJyyyD93ZxM1PAmR29WJeeop0Y
         5FBfTDdZC5bnbkBSMcLd65H3N6QF6A7VXui0MjY3U24oPTI8r+ZIN1q0fiTsmTegR1uC
         3w3JWC5tB8pj9dvM2N+3DM7dbonyN9xvjcKgFxeM8dXjpT27zKEfP9gvA2Toe70HfkCs
         FTbxUp6mN1/ge3lpjaYHhBZyyvscnuUSipbpGr0ZRbsfUqZLwqrH4ZGfWTB7R/WS+/t6
         0aJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784970850; x=1785575650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rFSKBs58ICJvc3f7BylS3e76h+CIlOceHYfnXTfuT9s=;
        b=P+MDvqIp1rRQowkhh3LNzTLhx5m9EVaw+L+BOBOXhjIWzAUZE7gs0kbVHMBSp2SrZ5
         IaC2XENcbqaoRbCXkJxHMciY0yUpj5qJXUsoIHVweBLopnC+N/uImIoZ6zWWCB4f4qc3
         KRYV53o2j0k4b8panq30xAB5wtyBbA7t+kijf+aN6jI5oI9JnhfuR/FF31n3hLAbJwzC
         xRlcM2etJ2UfDUTOzhh0EqBvTSy/gxnAzWZSG8Z5Z/Z2Ov+8q4QTHZkG2Z5orHuvlMS6
         B+uK+GAxrCsFRX766Al/9IVfhfojlGLHmp/7oqqUp+vzevL7kF9+7PaRISgoc+UDkZRk
         wuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784970850; x=1785575650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFSKBs58ICJvc3f7BylS3e76h+CIlOceHYfnXTfuT9s=;
        b=IGB8sSTqo9chAmnS58cYy83U+saxcKrETSA4rVDvQcOxlpfYVAaFNvbeat071VGf+b
         FYy+G6xvYsvQ98OsPyit4GW84UPvbEDF7EeC2aSPIxL8+V9rWEDHzOzoPhNgweW0XmlU
         nEMPkumSKF2kWr11qIiWlW50tzyW7FL0ceNXcDaXQCEOwzfnWQtK78xQ0srCmSFx3bqW
         NEmOp0KmAWmSSMQqVoL+WjfYLVffep09bAaXTrQC8tct3gxk3UVXSFaPCmdiRuIq6fOy
         SO/OXpQY4mKsrHoZtJtaLLe42tKxmlELC166s/iZQu94ybKI2ESXhivIH24beiHh4sqy
         bOUA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1daMPDi78uX4hwZDtggkAEkLEJbCp2JO7XRpRgH11ZEcIc9ZDi3GepxAlIPo6XcYH4TsruLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7/GBCPIfoWanO3FUNLX64PqLlzNalu/a084tPeAenrYMbwldh
	BCQb+49ig4TWnQXn0kXGJbqQkaj4P7zOFQCwiOmG4jFjzY5Zt7bf3OcrSNuQfI/hlepuvKdPLNX
	TSkzHjH9lYpm9rCqMfpsxSbAiLBekyUs=
X-Gm-Gg: AR+sD13H/B7DUCs7oWtLVa+BEIS9GDgF5+/FNmvPtYnoLtFSeY6PEoVeO0qLt/Uh6aC
	wE80pdSzxJle2+ypzGzLmjJT230IwCRZkHnd17FLgwKd1sUCnRHOZEaEvqsvSTHM+/uYNT6wJ4D
	CtTglo6EyYpRqHyuUMkeCYL4usOi3kfwys112Ykld+qPUIBlCn18p8zr+0cklGm4agzA+srAjJ7
	6fvkmFee1BZlIP9tdgEfkqVK1W9jdzKh/Vgk/+cxBhQ8YsSwWRuwnqO5ij+CKoVdfOfgmCWbU10
	KzXs6Dtnex5FpnRabqN0cCN33nE52JzABB6251ccBgZsao1q5K8HryBUUbqzWX5JZ8cpYmX+NhE
	=
X-Received: by 2002:a05:6512:23a5:b0:5ae:b13d:e715 with SMTP id
 2adb3069b0e04-5b2c1b2ef0bmr253239e87.31.1784970849731; Sat, 25 Jul 2026
 02:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725034246.192091-1-blbllhy@gmail.com>
In-Reply-To: <20260725034246.192091-1-blbllhy@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Jul 2026 17:13:31 +0800
X-Gm-Features: AUfX_myO98SfNL040OjEUMr3hPrhGaMGef1Ueqf8lgr8fc9mEHJKOewqJMQwgG8
Message-ID: <CAL+tcoDKuJ0QcLXpZg4ROZ=RxRg+FwM+wzdJzmuwQ_5EPPHTaA@mail.gmail.com>
Subject: Re: [PATCH net v2] xsk: fix NULL pointer dereference in __xsk_rcv()
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 11:43=E2=80=AFAM Cen Zhang (Microsoft)
<blbllhy@gmail.com> wrote:
>
> In the __xsk_rcv() multi-buffer path, xsk_buff_alloc() is called in a
> loop without checking its return value. xsk_buff_can_alloc() only
> counts fill queue entries without validating their addresses, so it
> can succeed while xsk_buff_alloc() rejects all remaining entries and
> returns NULL.
>
>   Oops: general protection fault, probably for non-canonical address
>    0xdffffc0000000000
>   KASAN: null-ptr-deref in range
>    [0x0000000000000000-0x0000000000000007]
>   RIP: 0010:__xsk_rcv+0x426/0xc20 (net/xdp/xsk.c:350)
>   Call Trace:
>    xsk_generic_rcv+0x26d/0x5f0
>    xdp_do_generic_redirect+0x3c5/0xcf0
>    do_xdp_generic+0x92f/0xe70
>    __netif_receive_skb_core.constprop.0+0xf7e/0x2b30
>
> Fix this with a two-stage transaction. First allocate and stage all
> buffers required for the packet, recycling all staged buffers with
> xsk_buff_free() if any allocation fails. Only after this stage
> succeeds, copy the data, reserve the RX descriptors, and release the
> buffers in an error-free loop.
>
> Fixes: 804627751b42 ("xsk: add support for AF_XDP multi-buffer on Rx path=
")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>

You sent two patches within 24 hour, which obeys the basic rule of the
netdev community.

Please wait.

Thanks,
Jason


> ---
> v2:
>  - Allocate all packet buffers before reserving RX descriptors.
>  - Recycle partially allocated buffers instead of only cancelling the
>   RX producer reservations.
> Link: https://lore.kernel.org/netdev/20260724164719.99563-1-blbllhy@gmail=
.com
>
>  net/xdp/xsk.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f906d51b6699..383fc2b1de48 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -298,9 +298,11 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp=
_buff *xdp, u32 len)
>         u32 frame_size =3D __xsk_pool_get_rx_frame_size(xs->pool);
>         void *copy_from =3D xsk_copy_xdp_start(xdp), *copy_to;
>         u32 from_len, meta_len, rem, num_desc;
> -       struct xdp_buff_xsk *xskb;
> +       struct xdp_buff_xsk *xskb, *tmp;
>         struct xdp_buff *xsk_xdp;
> +       LIST_HEAD(xsk_buffs);
>         skb_frag_t *frag;
> +       u32 i;
>
>         from_len =3D xdp->data_end - copy_from;
>         meta_len =3D xdp->data - copy_from;
> @@ -343,23 +345,44 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xd=
p_buff *xdp, u32 len)
>                 frag =3D  &sinfo->frags[0];
>         }
>
> +       for (i =3D 0; i < num_desc; i++) {
> +               xsk_xdp =3D xsk_buff_alloc(xs->pool);
> +               if (!xsk_xdp)
> +                       goto err_alloc;
> +
> +               xskb =3D container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> +               if (unlikely(!list_empty(&xskb->list_node)))
> +                       goto err_alloc;
> +               list_add_tail(&xskb->list_node, &xsk_buffs);
> +       }
> +
>         do {
>                 u32 to_len =3D frame_size + meta_len;
>                 u32 copied;
>
> -               xsk_xdp =3D xsk_buff_alloc(xs->pool);
> +               xskb =3D list_first_entry(&xsk_buffs, struct xdp_buff_xsk=
,
> +                                       list_node);
> +               list_del_init(&xskb->list_node);
> +               xsk_xdp =3D &xskb->xdp;
>                 copy_to =3D xsk_xdp->data - meta_len;
>
>                 copied =3D xsk_copy_xdp(copy_to, &copy_from, to_len, &fro=
m_len, &frag, rem);
>                 rem -=3D copied;
>
> -               xskb =3D container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
>                 __xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
>                                   rem ? XDP_PKT_CONTD : 0);
>                 meta_len =3D 0;
>         } while (rem);
>
>         return 0;
> +
> +err_alloc:
> +       list_for_each_entry_safe(xskb, tmp, &xsk_buffs, list_node) {
> +               list_del_init(&xskb->list_node);
> +               xsk_buff_free(&xskb->xdp);
> +       }
> +       xs->rx_dropped++;
> +       return -ENOMEM;
>  }
>
>  static bool xsk_tx_writeable(struct xdp_sock *xs)
> --
> 2.53.0
>
>
