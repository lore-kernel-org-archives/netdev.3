Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541AE4DEC2D
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606292; cv=pass; b=Yxi7B7cPO6cbqT7eFdHQ2UnClR7bTCR08buk/XPn2n5btgOtCpP5hzegwXIMFFGoR8W3LXwnSXa8nfYBk3QqscCT335fATrMbLdjbx5em4d6IVo0BcZlnneNZgfBfxyC2ZCBlKWjFosecKeWy76ZPCXBn5iJJLRePeckoNCQjF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606292; c=relaxed/simple;
	bh=4k0LHDyoypKSpDOQPhxiCmgZgeyWFuLEb9lB5rabey0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPgb5seBBZdXcGw4A+XatzN3AnsJRfgDHYkVJ9c10MUvXriWCt1w+I9dZycxkLD6aO4ak03rPxdf16SI6ViRx/htR0RVkLL1DTP7IJDkUpc5xGM/gzC0rjPMqy6CZoXbsWDutiUa6UebRBhLTe/RbmxslaLCCmTYrN9SBR95u2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jOdtLm98; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOdtLm98"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb769ca17so26986271cf.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790606281; cv=none;
        d=google.com; s=arc-20260327;
        b=SroyUo4CnDfuk2hA5VmhfxN8VmQtmjeXiSRxigdqMZLJCqzg2UU7VXONrs4/X10U2F
         V2sJmF67plOwvGhNIzpdw+daQlSqhifNji2dVhvepIiH32Iw7CanUpOikTa3VXZnVpX0
         ZHdQVmvm40vYkFW4kScZkQwB0dp5kuQ1wTrNOg2mnyRSlN6vwPs1BP1ie6MNOQWQ7QsG
         PTKUfKcXzSusGFJEEz61DSDsjYzTmE/zBsLuIUlNg7NWLljJGUlJlYbkonon+kkNObiW
         objCTAWBL2+DMpfS6a0BkE7q0yoLpdoxAemMDFjzv47FsorfChhBdo/rOPuqJc50Fyeh
         VyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MCXHheHbyEgrdJrYIEQeYJBtiFQx6U5h1CpDGebQRFU=;
        fh=1Oso9/lzZ5LY6Zrj2xWgINLLXb3B/rIH0HPAAkLUCLo=;
        b=X5UZsvxh+gPITyHwS5b681lijRHeeLwFIHRdP+302qE0zfLj7vBhkjqxh1t10I9KDd
         IDRlMfPkRttohVZe8stYJWKFsW2XBHgzDBt2lRW8QFBahLcXul8kM4pS6zn8THUPferk
         YpThbQhMTkbE/2RoPI3yB058STXMJqEX8X3bm0BHJjfuU1UXpa4u/XBwk/6z/v8h65Wj
         Orjzhevaqg1fjRoEZtJaHTn2cuFcIHk8Y85ATsMxV6PZTey7kTHlNDMk1vvCtr9PteaX
         +HJxlaMy0V/ARJwH/L8yhtchh6PnpMLJ0GyDn0MNk7b4yKAws6jOBsDcYE7GZ+GGunw+
         VkIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790606281; x=1791211081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MCXHheHbyEgrdJrYIEQeYJBtiFQx6U5h1CpDGebQRFU=;
        b=jOdtLm987ZRhomvhYN0rn7mut+ZnrOKI2qM00j+VZUTz43hU9Ntr2YT2NDvTnyR47R
         cs31K2NbuG9zMlSLQi3B+1VENtOS/SC9EM6weqzxEEWfPwXBfnpWLiR1COEjv0oAd3KG
         h/qUiuWMvCNcQjqUaSOA6n7kJQbW/fQWq/WWGjxLYtOJxTVytq73SfoXCh6J2mN7Y+up
         mUwAtA7QZUE2zybzI3tCko6paaFu0VOndULV8eZw72OHd2tGNWNR/KKsQJhiGuRYfOYx
         6GzD7xZHfHRJQDmfaS9AlAdezc8+latWLEoDuN5843XiBRLnQqo66GyAiGv6P5b61/9L
         VECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606281; x=1791211081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCXHheHbyEgrdJrYIEQeYJBtiFQx6U5h1CpDGebQRFU=;
        b=cfTsX1EmTWaOP+AAa0GHKcR+EQVivMtGeG/a4i8PfPKMz+FUVFaRWRF1KriMjmZM/J
         OcGcCD82ixzORFZsnYEjrxPUg1jAitJGT8D1kikEbGV3SqgJ5iKTIi+fyje/gj0NL5yO
         MbtiuxMx9fYRw2p7IE+M9ZEr4EQ12+PpexgSOY3Uc+bB2wUqPkrk0LLwwuQRNcPNJbaq
         a/5DRIN8YlTnUnqp4mEOC4EpUh4+pfiiT59uNx431QfKoyop7NPXKGCZRfFcsFo0+11i
         ujD3qgKrSKN8/6bB3t56Rm5xoV5BxVlNB2FZHbgC8Zr6HdaJFpPJZBfmq52X2Doasjpz
         z1qw==
X-Forwarded-Encrypted: i=1; AKwUvBxTRfx9yRt9IpL+3lKc1og2C43F7VCyr4e3yjaQuNh9NFaYiKFPFetv193gke1g9nliMPXOhkQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n/mBIuM33WqLcgdUlDiupE9E55ALqErrRC1QpDXq/QiYb8/HrX
	otxfqCWroVcwIsLDokO4LjvcCRpcyeZ4P9YXhNh/xR894ob9NDDZLjHzh2PTVu7lP3QsuHieLXu
	wX2JsBnREkI3/g8GaQDKi55KycPlg6YlbnvcUqcdi
X-Gm-Gg: AYBFou3f+X4wAaT4+zMq2u/Y6AN42T/QHK1Fjh6yOOkO0n3SjQK1rhFLtN+rU01rijz
	GHEGqAu2Pj17x8o+289U1zi6oFJSWB/4rBMaFymu/Y7zAG4K1OOglAz9aXV2Mrxkg2xdfE5UkTM
	rhVCFQmSUiTo2PNJXZXsRZYY8tPInlLxKD0bFJfguWsAMZX0uaJ9xxH+Ebgh1ihRAGZzvMWYT1N
	L/S1YceL77aQfL3f3YP+9nKEFILRjDphO8nSTAKKMNEzGuSlp8UlI0CmXDqBoovLfKQCMCagj/S
	QgorIGQKvTi7YtPgefK/ZGXdaHZUTw8VP7ZVmYXM7NUeWWaycLJswW2bmZ+APuO10s0x4/ZJT+P
	ePY58RGqSv3yDPc6mWLEoMlbbhSilyyXCdpToonSMoiJELRAQ0ciY9Z3pyere/tBoesx4
X-Received: by 2002:a05:622a:1ba4:b0:532:9e8c:ba4f with SMTP id
 d75a77b69052e-5330b6cac1amr208393701cf.49.1790606280418; Mon, 28 Sep 2026
 07:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928142233.1131459-1-adrianox@gmail.com>
In-Reply-To: <20260928142233.1131459-1-adrianox@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 Sep 2026 16:37:49 +0200
X-Gm-Features: AclHuK-tFW16D2bS4l9__sm1qQjTQdo5G6viOvl0vzKP-fuo1ANAfrNb4VqhQ10
Message-ID: <CANn89i+dFQjW4vnTBWjtVGFmwY5KQZctrUrNYq=VYsOZz8okFQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: sched: revert tx_queue_len on partial qdisc
 resize failure
To: Adriano Cordova <adrianox@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 4:22=E2=80=AFPM Adriano Cordova <adrianox@gmail.com=
> wrote:
>
> Pass the old length to dev_qdisc_change_tx_queue_len() and, when a queue
> fails to resize, use it to restore the queues already handled.
>
> Fixes: 48bfd55e7e41 ("net_sched: plug in qdisc ops change_tx_queue_len")
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  include/net/sch_generic.h |  2 +-
>  net/core/dev.c            |  2 +-
>  net/sched/sch_generic.c   | 15 +++++++++------
>  3 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index f35bd06a6bad..0ce97b4b2da1 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -720,7 +720,7 @@ void qdisc_class_hash_remove(struct Qdisc_class_hash =
*,
>  void qdisc_class_hash_grow(struct Qdisc *, struct Qdisc_class_hash *);
>  void qdisc_class_hash_destroy(struct Qdisc_class_hash *);
>
> -int dev_qdisc_change_tx_queue_len(struct net_device *dev);
> +int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int o=
ld_len);
>  void dev_qdisc_change_real_num_tx(struct net_device *dev,
>                                   unsigned int new_real_tx);
>  void dev_init_scheduler(struct net_device *dev);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f660fccfc0db..57e1fa320d53 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10002,7 +10002,7 @@ int netif_change_tx_queue_len(struct net_device *=
dev, unsigned long new_len)
>                 res =3D notifier_to_errno(res);
>                 if (res)
>                         goto err_rollback;
> -               res =3D dev_qdisc_change_tx_queue_len(dev);
> +               res =3D dev_qdisc_change_tx_queue_len(dev, orig_len);
>                 if (res)
>                         goto err_rollback;
>         }
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 6f6a6f0d5eb0..8fd0fce23cc4 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -1422,13 +1422,14 @@ void dev_deactivate(struct net_device *dev, bool =
reset_needed)
>  EXPORT_SYMBOL(dev_deactivate);
>
>  static int qdisc_change_tx_queue_len(struct net_device *dev,
> -                                    struct netdev_queue *dev_queue)
> +                                    struct netdev_queue *dev_queue,
> +                                    unsigned int len)
>  {
>         struct Qdisc *qdisc =3D rtnl_dereference(dev_queue->qdisc_sleepin=
g);
>         const struct Qdisc_ops *ops =3D qdisc->ops;
>
>         if (ops->change_tx_queue_len)
> -               return ops->change_tx_queue_len(qdisc, dev->tx_queue_len)=
;
> +               return ops->change_tx_queue_len(qdisc, len);
>         return 0;
>  }
>
> @@ -1465,7 +1466,7 @@ void mq_change_real_num_tx(struct Qdisc *sch, unsig=
ned int new_real_tx)
>  }
>  EXPORT_SYMBOL(mq_change_real_num_tx);
>
> -int dev_qdisc_change_tx_queue_len(struct net_device *dev)
> +int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int o=
ld_len)
>  {
>         bool up =3D dev->flags & IFF_UP;
>         unsigned int i;
> @@ -1475,13 +1476,15 @@ int dev_qdisc_change_tx_queue_len(struct net_devi=
ce *dev)
>                 dev_deactivate(dev, false);
>
>         for (i =3D 0; i < dev->num_tx_queues; i++) {
> -               ret =3D qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
> -
> -               /* TODO: revert changes on a partial failure */
> +               ret =3D qdisc_change_tx_queue_len(dev, &dev->_tx[i],
> +                                               dev->tx_queue_len);
>                 if (ret)
>                         break;
>         }
>
> +       while (ret && i--)
> +               qdisc_change_tx_queue_len(dev, &dev->_tx[i], old_len);
> +

Ah... Probably driven by the TODO  comment and a LLM ?

One caveat is that pfifo_fast_change_tx_queue_len() is currently the
only ->change_tx_queue_len() implementation, and it only fails on
-ENOMEM (inside skb_array_resize_multiple_bh() after freeing the
previous ring arrays on already-processed queues).

Trying to revert queues 0..i-1 back to old_len will therefore have to
allocate new ptr_ring arrays right after an -ENOMEM failure (which is
especially likely to fail again if old_len > new_len), and cannot
recover packets already dropped if the ring was shrunk.

pw-bot: cr
