Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECAF286A4
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 00:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787098179; cv=pass; b=JFtmGGA9C5yH7S3cGG8xkhHMEZNtQhflNujN873urOagoOUDAxcbJJsRGW8fakR1793HEpAR0ECeRVt1Tv2bQPk8U5X0uW9v2qmME3h4KRq3uImaTkIedGj0+rP1JLKkO5NPjr8QqYcSQyQYiEuPqkDT0CzqLUq68XikzIom07w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787098179; c=relaxed/simple;
	bh=r3zTW45nsyUnnxRg7xoJ7zODVVjB0nkyf2mk8yr4AGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ojz1KJJRViwhKL2d7f3NyUBJACu5jCHdYwEjp2UxkX2y4NTFTm67ey5GbKrmb/LrRxp2rhvXPQt/5AmpW+N2IfdvGJv1ash4UDE/EZy1t1YQc+uCxc8Ftm37B2Zm4I9Ej4FgZ2kEsfFmyO5QZCmM8AdULmiFlbpSX5o1lskdpHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBgw9oaP; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBgw9oaP"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39c8ee87f7eso4606681fa.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 17:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787098175; cv=none;
        d=google.com; s=arc-20260327;
        b=HY+bJLazulZ0SEDORF6jLib141+hQEdr9Y4DqI6Rg41+WcWzpPIzy+duprTWFQT8hb
         W3YoD1tI2OK6lJciMSEMIhI3cZLCPeJ4iwbAsLgHitUDpFKiw3v/vN5b9dD2VDXc50Ca
         enYBUk/4kKgOEi2s8CyDIUXTa8SvUR1VLC4WaTEN8i9PwKkiforKk7tvIf2tWhjIByV0
         Q9UafnGmMN3llHcx4N5MGJpHA9LDKRvqwOoGAAZxyLPRMPzDaNH69MyM+5uk7y4KjaS4
         NP251t3C95rJhGCDY9kvU4JtF9F8nhJ6x9BriZnE9/Vl4scfpJ2SiUgl0G1uQm4GeD5Z
         e/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=beYAJ6rd8hONAU+/B3i9DJe4/3st3v+JHwH8VcyoAzM=;
        fh=GqZbg16oNCAmBPHWv0Iz9CjF9vS7/FA7fuLAiaWwUlE=;
        b=MSa3duZJ9RwPn8wtsYRSsbv4u52LnQtbMgJdJcFduFWMT91gUIBqn7BEoE2/zSyX8N
         WogDbIz/EHKGUq1LzAAD7sIYMS0HWtlzxzK+SSgs63cNQDA+l2d9RyreQbO2LfwJgZSe
         1FYYKEdHuggKoZY22/o+pqmC7/ndiP62+P4xxzg7UCopznimIcaZFigy8R9FX8mAVsXO
         EpOmyubOcyxPudX3h7IGPBcFvQMzECESZ6/rHjEEj9XpPd3jJOFGMzQ3W4bchUpoEdgB
         FV5bG4yfMI/oSAKbTcoGHHoEDzB3Np0bFpzbFHQCz6AR6m4Dt3TFHChOkFG4l5wMKSVD
         S5yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787098175; x=1787702975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=beYAJ6rd8hONAU+/B3i9DJe4/3st3v+JHwH8VcyoAzM=;
        b=UBgw9oaPdtT3oKAngrgfLc2GX8XoKzE1oz5pN+iZeFb8vDFx/fVfXXp8iqashYQHk1
         AdoxI6E22/IrjA9hyIXEX+MFIruN1gEHUmT8Rt/WAaf7Sy4klNZNf2Cq8cXKgXBcjOcQ
         4wACiXY8JndQdSKcgmC/SQcWbP8YMDXkN5O9hSxy+t6/zviY5hkOKH2mMG8TRUmwoKOV
         gcD7eOZaaGFDZrf1vqHeCxLBLDgcpBkOv/FmnpiaI8iaVmK/+B9N88DsZ+EY3iFvdWOz
         Jmt0ocE058R0bDI7LBfdEq4eGeCKYUJh+51DpubBCs8niZBZ0nIsF2EDSSbyY9YG45aI
         JSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787098175; x=1787702975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=beYAJ6rd8hONAU+/B3i9DJe4/3st3v+JHwH8VcyoAzM=;
        b=dY1FlrKv9SFV45Q/19EyqtjEnXc6b3x2xSSfd4wugG1cRGWE7RKQim/x0PRPHfFU15
         jpytu27MzZXWz8wKruCRoSacrGmLXxKytDtNluWu4/hHKwb5l0+itWp9FebroAhtgsok
         bZ/sXgyjOHFZg7dYh0DgrmO0idiLkhUl36G6fgm0PkCXTTDA9bmHFegh/T/ZmG4nzhe8
         5Jz6OuoRYTcK/dmMOnvR+fXzwe1Zh16LyEm4buE0QocsXVBeBjuchshNXbk0aIXhjfod
         0sr60h8gTw3W9PSS2Sim81mj6viEHCZrBsdrwDUsImfcFKZKRQsTZ0hS2cH5E1EbOisw
         DI7g==
X-Forwarded-Encrypted: i=1; AHgh+Ro2K9cRSX49UdomYj9lm/H22RHr2FkkIkg2cteib+wkYLCbuQRzT9E991e2fZU/7LZ5shhnxkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHasj24XtJzjYmwPwPtKp7v0NyBMn43b9hUcSAyCrapVcPhxCt
	8cvTywDvMrhOb2KmwIucAeRjIiqlm72d6ck2taaCKwPRDku4YCAGZmMPDnjcJWd0QA4vP/UNJ9P
	n1hX+LGWZ7eyG0dTrjC0Rg7cRzy231bw=
X-Gm-Gg: AR+sD12ldjiDm4mQvYDB9tdSbLHceuzYn7x428d2QskJcdxI7Z6cdbf9Nv77HxSu/V/
	6aGs9XHYavLkY/kAF5OyibTjkcZB2ft5MP1jkSqhPu/99qYCGrmhuZD0g75cH8HhFQx0IczkWia
	vZxaoV7U1bwALGcQlUQngFanG4+/XADcQtxFIpgtdUrp4FnncpaOivKkEatbwX728CUo63cypZe
	ttdRgkdaay4G+KUCj4G2194PrsZtn/offy+UqzchL7JqN1Mn+Y8WqsmLYsKdJOjp/4cqdQz5JH0
	JBZ1BfSTTiGo8cqfsbgsbrs54iIn+atZYpkXyCR8gTUVdeHntw5HZJNikwnIIK9SS2kdypU7Gu3
	IW6LjkP9UAgbf1Y38I1WmO3fwbKsVzxTdcqEFGBp1AQBEUwkh1bXaL6Ftqik=
X-Received: by 2002:a05:651c:222c:b0:39c:a346:8a36 with SMTP id
 38308e7fff4ca-3a189974b61mr660931fa.8.1787098174857; Tue, 18 Aug 2026
 17:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813215328.99311-1-blbllhy@gmail.com>
In-Reply-To: <20260813215328.99311-1-blbllhy@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Aug 2026 08:08:57 +0800
X-Gm-Features: AcwNN1W1pQE8vAeWnxc8X4qegJxfs2j5BNbiyglHNl_l4Fi90vnFBfcdT9VQ4FE
Message-ID: <CAL+tcoBCsSuN_+uypBoP5KdKUkto7X0T8A7qN2Vx6TqqGe-Ymw@mail.gmail.com>
Subject: Re: [PATCH net v4] xsk: fix NULL pointer dereference in __xsk_rcv()
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 5:53=E2=80=AFAM Cen Zhang (Microsoft) <blbllhy@gmai=
l.com> wrote:
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

Thanks for working on different approaches!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---

I think it'd be better to put the previous discussion links like [1]
here and then explain a bit about what you've changed through
iterations next time. It would be beneficial for network folks to
effortlessly trace your patches.

[1]: https://lore.kernel.org/all/20260806204757.47817-1-blbllhy@gmail.com/

Thanks,
Jason

>  net/xdp/xsk.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7855ee09c4b6..33475b180ea6 100644
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
> @@ -343,23 +345,45 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xd=
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
> +
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
> 2.52.0
>
