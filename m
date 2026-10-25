Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792896713;
	b=W4IfVZcuRnClCn0vbiU6+iKJlvGiZQyS0o/9hoD21luMqa/ETzbk/atoYSFV5NVV4Qol
	 qQNMYLBN5c4+Skm/w23tWn8n+nnDXV+CFHTobE2Hjjtmyi6Bids+ZrCYk4KMv4TpknUgq
	 eMzmNOTptyj+G3RPDJY3EiDsRXh/H1D2RBKqVjp7SIfg0g+8hjNtl7xk1ncZaX+NGdA4N
	 FE60gj3vWHSemAhN6OdTHKkZRBaobK8mjMcMOBT3dnjVtAkfzf9cJ4ySozLtgz3yr+zWS
	 zIwDSxyfTL5W9vQJrchLE3jQbl+n444b7o5+DInAHdLh0ajjEamuy0H9RhJmubdxKJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FU5RTsamiHXtFoFdGVctPWi31ZfViWT4/lAqub7SSi4=;
	b=PewNc1hOpM2gu3k0cc0P2okKwtSHXD47p/3u/Bt4iWp4BdX/4g605gciqawUT6OpFF9K
	 ErOpX2r4QoN/T3h2nV1idCR46/yksCwkYKw+HCQm4/O2kYH7by+SDji+9sVQ4DHucE5cA
	 Gw4dGdnr9oyoBHzuqHHfG9mjputIZstj+cQyffAt/Rzkj9fSUtDVNdq30mGzv6Z1j0TIN
	 EeSbWCSpYaoVxOixzm0AiM26HtDYbJBadqz9o3qA3k5tpEqhDQ5JwNMQQJwxoKjPHiyN3
	 20ZnTj3O9vr5VkZNPUdzcv3w3Fk9Hort3XgL5mxfsQHUaxKW3uP1KoMZqBgejtPVPxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aTtfRWF7;
	arc=fail smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49F606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 02:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E49F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aTtfRWF7
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5ba36cc21cdso2202700e87.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 19:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792896711; cv=none;
        d=google.com; s=arc-20260327;
        b=ZBZiOpIaujUaJCCfIXY98opB8QfOWcHh4MhfEJGyoc4cDvS8wrhauyCneIrSUWKmdC
         PEgSZmIAtzA6gf+451C9zvdWcpSzmxCYJeVur7ocwGsUoygFc+Vvolt3DMIQTly9kTd4
         3TbX/ajBA4UIfzgdAwWKYmoVnR5Deui9TV8jBHhUWb0B8ylzIVhZ5UOGhEwp3lvDW2WE
         ouGCI7Ik3udOX3VvO79J4mW8/uJH0V2rJg8PF+V1TRAcHLVDjwn1qm53cdr7a+HTv2VO
         VpVBx1H/j3KMbEs+b/9+xbfPmO7bnPpHuST8/QS1R5JvqV9ftqQ/3A1VnJznEdRFXXj9
         RlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FU5RTsamiHXtFoFdGVctPWi31ZfViWT4/lAqub7SSi4=;
        fh=SbIM7P4xWTgCC9FGjPS/Z5m+2TG8ydRUUqGNQ/sKj1U=;
        b=Wq1s4q9c2o0uUMgcq+9yBnfduHOVXrF6il2/KXD31RU7PkQtTJhyxii37adY2yCEvc
         rcx66Xf6GR6wl4WuUUbVizsqpG0xvMn9I8ybzVSNEFkDMSalfKZFr1midRExNczanklM
         B1ETQ/NfOJfmN6eQKT4H9vMIoQAuujNTZny4WRW3eyWm/ch4wZ7KBu/PmBnGeZ+YBAkh
         NrVLgamdiTxmgC5lsYZs/xGlwTURV7te9jFlAY8xja09JVbXy/JJHHd6q5tQyKJbpbw1
         uAyNxpIlL1uShu0oHH5neKQLvaF4avcp8aBd+Nu6gFgshCCBSghg1K3SuveUo4lKBwqr
         J8dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896711; x=1793501511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FU5RTsamiHXtFoFdGVctPWi31ZfViWT4/lAqub7SSi4=;
        b=aTtfRWF7LQ4aK7mY7nYUpzL3kyQ6x7PsBZmvPrbianfoppIvuf0nfUQKIpNnpVKJ1s
         MpAAKClCDQ0ycO8erRcVLScqW7Xnx9gmwbimL69V5ZlKrdetpWfYxJ0tHpHAlB8i4gSO
         8ulg2HkHqkZRnHit0VKY1gmWFyplDc6TZHpAgP5btHf2fYtDBQjsO8ajz00B9Yh8hBT+
         er/+xI/iSMvlfdZrhUF2NLOz3Jno6+jX7o9ZZKLskp/x5q4pUyNJ9eWFwmohXeWDxdzQ
         xWT3yv7UFlCgIazWEP23ahkjiPvGh0HVvXZuLLpookcU4mz6FkGhJlZ4v0U4h+sKgo5+
         P1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896711; x=1793501511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FU5RTsamiHXtFoFdGVctPWi31ZfViWT4/lAqub7SSi4=;
        b=szaQzvT6bOAu+vaoC4WWS9UkNqNb2+suk1XuK6OT/GBOwTbmsmZROB4sBlbVNVvEzu
         n3I2odhXoBfglVzezk72gTwyL9qgRmg/M2Rr/3biypm5iydfgeBqs0g3aeKjOznvIbhb
         lBRK1g4NWEWZL56rMTBP7/XPeeHVkSmn6MsOMgkwnqfTGqOPh7NBE2h7Zkuvja0CSabg
         zGBj6cq8WgjgqF7dhWrAdiR5f0CqdKtaQZHNlUhSL2nqdEyWLdSfBF56/8/175HdU/ND
         J3aQ/fqKL3PbkxYKBbNILgyIIyxy8+YrgVJjONk+j0X35RZB3ChV2Dw6RqQ8PKfF/W4z
         9jyg==
X-Forwarded-Encrypted: i=1; AKwUvBwePr0/HhShBZxScYlu6nGr1DSoWkxaoKG1sNRd3yLySEb+6yG31ktY5FdeDYPyf5zObpbXrdk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxAM3qQdhT9jCE1G3ChGhZgWT3K/HalWs8YtgX4K2+Oyd7aiD6
	y7F/j3KC9SaVi7YQyHSrtDy6OXXLk1vPGDSqPtrBhuVZHhfaH+ILz7gvRKqFUKJe4ASojTHRfBB
	I3jYhE7oxAGcfCnVKuLoPhxPxjLLOjV4=
X-Gm-Gg: AYBFou0fQS9bvdY0wcVuINNe4SENp4OoORX7W+iV6NjBIYdYPlX8arUJFFia6gdKYXI
	+RYVSerrAlzxGFb0xJCErPgsPTZQmEuPxDsvUUPitW2VOf9m9RfQud9VOYrxi5krRiTZiPJ/yfA
	RbHZYZojvRfo16fP0hTgk6bfMYATF2aYtOBaxydOJjAIr37NphoPxggg1GQB1yG+aSNAhoZGVK+
	kF7/35HMViTDzmvKwZUlZHHfUS++YmAG2k6e0SjCEYW1zeZG4bwxBBQjyWN1JkSRLk3KK3M8fwf
	Nia+crptnQRyhVis8qK8qWItc7G/+jhH1JOu7A99Aa15nhw+N3JMlb7Gdg3aofEYMhSlXqUbcOF
	V8x4FKa1mC/p6eX6rolkTW2coNLbfk8ROCVVHUi3GCSXYT0S4ZdC2rXb1F62eE4/iUIL2xoqG8p
	Jkux5yoQ5mshja0NXXafzP/h/ppnTn2T85MEh1GriV+84IB4oEHKNe
X-Received: by 2002:a05:6512:2345:b0:5be:4386:8072 with SMTP id
 2adb3069b0e04-5bfb71efc33mr1010116e87.56.1792896711058; Sat, 24 Oct 2026
 19:51:51 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <20261024141157.59301-1-testwrzwrz@gmail.com>
 <20261024141157.59301-2-testwrzwrz@gmail.com>
In-Reply-To: <20261024141157.59301-2-testwrzwrz@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 25 Oct 2026 10:51:12 +0800
X-Gm-Features: AclHuK8kPBK2Oi4nOLhCm4MhUs2zF2fhZ4bu5005K1BW9G6XUx9rptsm45CJV3A
Message-ID: <CAL+tcoBQHudeQC+B0J0mwqbh1CH82XQWfQrtyXqVMF3ybopr3w@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] xsk: defer software checksum until the skb is complete
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 10:12=E2=80=AFPM Rongzheng Wang <testwrzwrz@gmail.c=
om> wrote:
>
> When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
> calls skb_checksum_help() while only the first descriptor has been added =
to
> the skb. The checksum therefore covers just the first fragment, and
> skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
> fragments are never included in the checksum.
>
> Move the software checksum calculation to the point where the last
> descriptor has been added to the skb.
>
> On a checksum failure the packet is now dropped instead of being returned
> to the application for a retry. This path is not reachable with the
> existing metadata validation, but the behavior change is intentional.
>
> Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>

Please do not post patches within 24 hours; we need more time for
other maintainers to give feedback, especially for weekend.

Do not reply to the old version patch if you're trying to submit a new one.

You didn't respond to my questions. At least, discussions there are
obviously welcome and needed.

Thanks,
Jason

> ---
>  net/xdp/xsk.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6..65be2a368325 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
>                 skb->csum_start =3D hr + csum_start;
>                 skb->csum_offset =3D csum_offset;
>                 skb->ip_summed =3D CHECKSUM_PARTIAL;
> -
> -               if (unlikely(pool->tx_sw_csum)) {
> -                       int err;
> -
> -                       err =3D skb_checksum_help(skb);
> -                       if (err)
> -                               return err;
> -               }
>         }
>
>         if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> @@ -1030,6 +1022,14 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
>         return 0;
>  }
>
> +static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *po=
ol)
> +{
> +       if (!pool->tx_sw_csum || skb->ip_summed !=3D CHECKSUM_PARTIAL)
> +               return 0;
> +
> +       return skb_checksum_help(skb);
> +}
> +
>  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>                                               struct xdp_desc *desc)
>  {
> @@ -1275,6 +1275,12 @@ static int __xsk_generic_xmit(struct sock *sk)
>                 if (xp_mb_desc(&desc)) {
>                         xs->skb =3D skb;
>                         continue;
> +               } else {
> +                       err =3D xsk_skb_sw_csum(skb, xs->pool);
> +                       if (unlikely(err)) {
> +                               xsk_drop_skb(skb);
> +                               goto out;
> +                       }
>                 }
>
>                 err =3D __dev_direct_xmit(skb, xs->queue_id);
> --
> 2.39.5 (Apple Git-154)
>
