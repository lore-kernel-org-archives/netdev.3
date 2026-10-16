Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960B26C385
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138348; cv=pass; b=CVEf9DUQLwfHD1kYrU/jfzKK9twW2hGLP0OVD4JjweDFgxKF8MR0N6itXB7KVcJdVX16Wdk+8D4iOu6fXT7lPGTmLQIETvRbscP7tDfF1ht96R9ShPZC7i9jYXr2CLxH5Xp5GAWEvpudzsCRkfFj0Y3UOxJ4+Yq2UXj1ldU4apw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138348; c=relaxed/simple;
	bh=WxuziSkYi5UPMb7ZUMtI9i1smM4fxMt4RUkXbggiHKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUuxTHBxakodM1i9B5F1KSijuQDITPF/IKE2x1NQ62PjZpQoPfF1YnxG5OtDCmL5qxnhII5UMjqWc0AcYBclNyAQbvtzcSRFeUklyyWn9kuut4iDnPF9SuSuf4RobVU9IS/34hlw9OcZ/yIqM9OfaZW7ivE+5tZth8dqTOGtN9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6ouA4Qd; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6ouA4Qd"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bcf21cfbdaso1380257e87.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792138345; cv=none;
        d=google.com; s=arc-20260327;
        b=RPk3zRgBwemhWI60yVCF7YoUWAvl2C4qeJah0I/fK2azLfoEe/vtko0MMbAMlAx1yO
         It26fm0T13s5yMwzP9zE3fQFFYEvfj7G18Mhb0wCoYb5A3rO7VctixkQHlo1VOWXAnn5
         V1tR2TchvC7xJ0OuqsWR3tdYjqYF/ttOcW2/JanRoUapVPjFqUTbC8pwQVV2v1p1CqYL
         oWVj15YNRFeL7Jw/gKMBJgW62nZa/09PE4u5gxfuTtEcZLyIqJNCf3uulHCqwd4cDUBH
         poka5XSmupC5nIy4prhyemoAQBapPv6OMoq1YMznrDnGSrSbDKFIW7popZwnDL3L68Ug
         yJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8sW/Cx8Xj7p1FXHUG1g9UmSn6q7zYA66/GXPT4c8TOs=;
        fh=/thiD/OH9iraE6Oja3Titmam2IPxt7HwTJBZPco4o+M=;
        b=AUowFL9vSH4HDoQTya1Yl0LXekA+TQydQJXNLJvPRFjC7DihrDiCxXISc36nvxyVgu
         AxazWvXDiFBdsH3pJ4bPm5yXxJk+2yOTlxYJqBIJRiHCKNv0xkJiu3k+R2D8B3rP+1dJ
         S+jH/HkMJU7j0K+NKCNQPyJNRrJdrhYVNWIyMDDtm5g6oEqEycu0VqL/Imoil4WtPKg1
         0DgY/sgey+cbvFCZpdezWWJ2q6MUkLBHGw4Z9J25V2AGbmydQt/bwEQySQ4oFTFf9IQW
         MRhgq8oByxw7/5XSteIyrNkA/QM54KpMiT1eFNy0e09crTSZjpliHIWBvIAfxGBFTE0+
         yecw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792138345; x=1792743145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8sW/Cx8Xj7p1FXHUG1g9UmSn6q7zYA66/GXPT4c8TOs=;
        b=B6ouA4QdZ3+1zSORpZ/R8T/IZGS+FUt7T//8Cu0ifZBJnVOJafo6fhzFs1iUPK/6um
         OIVccgMt6PRUaGFG+WXVnjmPyyWuVU/pF83QOI+bdzo4gKrqcJWtX8w3CtV1NOVSAHXi
         j8pJXfYreXthX4CyOfayvdTbPpFh3LS7MePfFZUkwOEb/ll3vaTM6Siua+V3//Eh1sI0
         h1MTXr2h+PeVYwZi3ltoUi93r8ZdnfM97312Zp7qHeBFCOijnl6rcPRKvy3RH8TsKW0m
         zsO0Dr29BXCpZlF2b7rOxanS0F3WT6Wxqnwlha67mD6hsP7pbHOCgKWqQq5qTLgOSHef
         zIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792138345; x=1792743145;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8sW/Cx8Xj7p1FXHUG1g9UmSn6q7zYA66/GXPT4c8TOs=;
        b=Yr89BoyVn44B6GU3KOgeKoV2UAy/jznybxab4L41XRQeY8b5GzeKfrlGIdjFKlUzd/
         rA/v0wi8PggzaDbWypBirmex5Bt7hG1m6DqwFKR4oTmadv70MjvK1cfRQWuJI5mcDyCV
         2wOgnjNPbt432Aux22/l33iZWgsiJzTgiJlRcnVMiexrfEem4PT6TfPxnEyYlsN2y5a0
         +L5822YfgEnMuWltC2x3y+E8o+c/QuRv6G6L0CypkUQ2ZO5xuNt8PqH+qnNz/A78HUMp
         3fKFs6ZrVFjy5LQRfWJCDHm0d70q2QGvwrO1eSU7FKduawlThm5508zsseKGsFSVGdmx
         iJJA==
X-Forwarded-Encrypted: i=1; AKwUvBxexOKbh2t5tZDY7aqpg7355lMfQfQ23zUQWe+vsNoDG65AOzeSGqarr7hVri8XT0KgmQEcDFw=@vger.kernel.org
X-Gm-Message-State: AFq9FYItWjf2YP9RTlnysQ6X/HrQjUlJyJ/hPcB5D5XDF1AvTqfvCCUl
	aeVa5K2MQchOTApIkDOZjY3x63+CSYus1gTzbyGjvXr/GfiQBTdjts66Vx8MCKCpuZ1MFAo8ASj
	6jagTMZJkfMKnK65NhXnQ1wBlCcDolMk=
X-Gm-Gg: AYBFou0YgCMdLo2Oe/xklDKtq9fycGMVD167EfDqgWDaw02W1Ee61Asq2CYjssCoqCN
	92yeuOzgvRM1/QpOq6b6EA2NyqqlgYq13I8uJzU1llQjI9PMPCMiHz8ynZAyQpqiCFBz6MgPByV
	VAa1c47fK22zfivNBJLWH100yla60Xx6V3LnkJCMrtTc6lUv69WgmbfDx+KDvPIZY6UjGuHgn+R
	3ksxoEjzE1ZFzG1uuB9w7wG6lMueFwxnWBXDqKGHdiyu/gXPCqNBdMeJwuOeDJdZV8bW2OMkJz1
	HSBTWYwp3ZjHShqKNOklI1LoKCoH03Hgiu3a+ozJz6Gesz0UB2ZXQU66tUrZDhVG5jlYpo7fa2/
	4nqUnLShSjQfmJ8TGmYGzqCVpjQG6/BTCrcAoWKBchdCDz0/1f+0EnY3UErAd0wVjBp9jdg==
X-Received: by 2002:a05:6512:661b:b0:5bc:e75a:ad0e with SMTP id
 2adb3069b0e04-5bce75aaee3mr6847097e87.34.1792138344385; Fri, 16 Oct 2026
 01:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013155658.2196020-1-cjubran@nvidia.com>
In-Reply-To: <20261013155658.2196020-1-cjubran@nvidia.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 16 Oct 2026 16:11:47 +0800
X-Gm-Features: AclHuK_08bO7B8AupJ6RMIQbh6Nj3KnKYvBWqnQ0pvWBvdmWxJyLg91T1rBv4tk
Message-ID: <CAL+tcoDJx+suVKWjuHDMVMNThK1SS_a=0t1FkUninHnsAkraGg@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: skbuff: don't copy alloc_cpu in skb header copies
To: Carolina Jubran <cjubran@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 11:59=E2=80=AFPM Carolina Jubran <cjubran@nvidia.co=
m> wrote:
>
> Commit 68822bdf76f1 ("net: generalize skb freeing deferral to
> per-cpu lists") added alloc_cpu to struct sk_buff and placed it in the
> headers group copied by __copy_skb_header().
>
> This is wrong for newly allocated skbs. For example, skb_segment()
> allocates a new skb and records the current CPU in alloc_cpu, but
> __copy_skb_header() overwrites it with the value from the original skb.
>
> If the original skb was allocated on another CPU, the segment may later
> be treated as remotely allocated and unnecessarily deferred there when
> it is freed.
>
> Move alloc_cpu out of the headers group so it is preserved across
> header copies. Initialize it explicitly in skb_clone(), which allocates

nit: s/Initialize/Copying

> the skb object directly instead of going through __alloc_skb().
>
> This was discovered while investigating a throughput regression with
> software IPsec. The load used 512 IPsec tunnels carrying traffic over
> VXLAN, with 512 parallel iperf3 flows and an MTU of 4500.
>
> Before the fix:
>
>   16.09%  queued_spin_lock_slowpath
>              |
>              --15.90%--_raw_spin_lock_irqsave
>                        |
>                        --9.37%--__slab_free
>                                  kfree
>                                  skb_release_data
>                                  napi_consume_skb
>                                  mlx5e_poll_tx_cq
>
> After the fix:
>
>    6.84%  queued_spin_lock_slowpath
>              |
>              --6.57%--_raw_spin_lock_irqsave
>                       |
>                       --5.00%--__slab_free
>                                 kfree
>                                 skb_release_data
>                                 napi_consume_skb
>                                 mlx5e_poll_tx_cq
>
> Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lis=
ts")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

Thanks. Overall it looks good to me:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  include/linux/skbuff.h | 2 +-
>  net/core/skbuff.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> ---
> V2 log:
> - Move alloc_cpu after the headers group and fix the indentation. (Eric D=
umazet)
> ---
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index a3ff380d43f01..b3272d379409e 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1036,7 +1036,6 @@ struct sk_buff {
>         __u16                   tc_index;       /* traffic control index =
*/
>  #endif
>
> -       u16                     alloc_cpu;
>

nit: no blank line here after you remove it

>         union {
>                 __wsum          csum;
> @@ -1088,6 +1087,7 @@ struct sk_buff {
>
>         ); /* end headers group */
>
> +       u16                     alloc_cpu;
>         /* These elements must be at the end, see alloc_skb() for details=
.  */
>         sk_buff_data_t          tail;
>         sk_buff_data_t          end;
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 41beaf625421a..3d82eb87f4582 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1593,7 +1593,6 @@ static void __copy_skb_header(struct sk_buff *new, =
const struct sk_buff *old)
>  #ifdef CONFIG_NET_RX_BUSY_POLL
>         CHECK_SKB_FIELD(napi_id);
>  #endif
> -       CHECK_SKB_FIELD(alloc_cpu);
>  #ifdef CONFIG_XPS
>         CHECK_SKB_FIELD(sender_cpu);
>  #endif
> @@ -1618,6 +1617,7 @@ static struct sk_buff *__skb_clone(struct sk_buff *=
n, struct sk_buff *skb)
>         C(len);
>         C(data_len);
>         C(mac_len);
> +       C(alloc_cpu);

One minor question: does it affect the following two cases:
1) skb_morph()
2) else branch in skb_clone()

Looking at the above logic, I think as to #2 point it seems the impact
doesn't matter...

And I'm a bit confused reading the allocation process because there
are two possible split allocations for the skb structure itself and
the head/data area. They might run on different cpus, which means it's
hard for 'alloc_cpu" to choose appropriate one to free under this
condition.

Thanks,
Jason

>         n->hdr_len =3D skb->nohdr ? skb_headroom(skb) : skb->hdr_len;
>         n->cloned =3D 1;
>         n->nohdr =3D 0;
> --
> 2.38.1
>
