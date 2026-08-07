Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF213783C3
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 05:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786080250; cv=pass; b=uE0h4QYb5vdWqtrq9k7VZd91mN0j/y/XPqWFA1xgQH6z9rBDRv2iMdDRjPYwqoqxmE6P+HgJRu3C0SO/vT0poAKGuwU0h8K0aqCjrulor/QR4WxIOz+u7jITdDE468iCpm4KZh6/fwxlwzHP8irpZLguFd686GzlNi2SfBwiiIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786080250; c=relaxed/simple;
	bh=/qvEecEMyOi542WJRYMMRzy+QAliMqatuH7VPufRODw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+WsTuUcl9sf6sfoq+1bRgZWkvts1RQ2b9rStQO75WkFyWBiiVCG7HMii54HGp6zqTso26J1nv9tJxAvc8zBQexebV2kX19IVn/KRYBIn4yLi7LmWQ30Nsska3tv7qmqZdkm/jMKwus7bSFEkjMh5MHZWq6U88YxaUp3YAstHjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW3wSyAA; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW3wSyAA"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b14d1f9315so2398657e87.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 22:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786080244; cv=none;
        d=google.com; s=arc-20260327;
        b=JalAMfrixuFtVkgj9r+Acp1/mywmYTSAZ1HjLoyVZeD3fjtLd4+Us7KXxfJIbZqRlN
         1ImeuQn9Csn1x/30Eeuz+KGwvX1gGrYuvPKVH5WVdVKd95L7gN0PPSvpS+25pGNsdg5u
         kOq52avGCOFLChUFdyL+xXcyJSlSV2nyQ5ijHhZ/Fsx8o8KrYEYF+CcMFCfwaBCoJ7PH
         iPKmwWO1yzChcbaf0D9wNxezbYxt6WMiaQuznhECtjFksvogIqRF3QLBENPKFZmFNbMf
         POj4+M+ey5dXQbxIT9dcHYuOpKISu9SMQ3XHmHPW0OneshSJMcfKcD/tMI/3rBb3KyDw
         Gwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uijGZVvSATzvrVnVp0OH7XFf3Ki325iqaFC2kD6QkJ8=;
        fh=vMepP4Yu8v/UghFKFY+tE6nMi5zX0Nr49LD9aLt2a/0=;
        b=X6agg4HJ2MmmR0mGH82yIlQgwwTRVlpuWsfW4MeIYhtYTBcFKuN8viMgy/i7G1/Bsu
         caORanMU9hSzHoGg+JqiFuQpz3BDyQeIJuf+v9AjziHhSojOOO1/Pa8NMsCIy1zT0WiJ
         JqiXPfo633/MuKUXwQaWRUvOFkYKH0IVvPU5cWG4H+CIxgEGtbYObdsTF5vb/Q1ZrPuT
         fP7wqbmRLhSPrXu1v9uxh7ZApmOLWfS+NEh5nTaRNOO1trH7GrllwcMSDWnx6nGWFz3c
         rqaHuhbJQbLMyY94DtJJltSLyXTA0pH0/+1q8ZfRTvLJZGFjqZnw0y+CG5ISCs3dvceC
         ibAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786080244; x=1786685044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uijGZVvSATzvrVnVp0OH7XFf3Ki325iqaFC2kD6QkJ8=;
        b=aW3wSyAAi78+D23Sdek5zfMxHIz0k5EUrrc2YshlmiJ/zL+f/Py/Qb9LTZgS8ADWle
         MiyXm6MNtsIWgGGVZihNpAknx5n8sK+8Yz0ei488iZv8Q8dIupmKXLmPQXdPEsCiMA4f
         OxAH87ip2O2NuNCHmWIUAE779Dz/Ej7iV1znLFmMCAOnie/HuVimaffT94wH2/wjkRFu
         0mU64G5ilIF1Kpxjix1drjGIwHahfaiwM4ol/eXKqzMI+3i6pYV/F+0E9gt1AHVuCCsG
         O6hRBM3d3XMVnrbqRK9HGRL+K6vTcUi36cKd6SHQWstcg7JaNnreL47Y/QoKuD5xgp7O
         gWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786080244; x=1786685044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uijGZVvSATzvrVnVp0OH7XFf3Ki325iqaFC2kD6QkJ8=;
        b=Ekld1LUadWBIY/70qM9UJyTl69bx32tB0LzHuvyeFy6BD/Ti3o4MzmkUs7dRZHBRr/
         oAiwb76FeuSnm39zuIwFpd49Qlf5R91n3n2uQppr4FNv57BmWj76M+wd449MF2Gk2+1R
         L6XL3k5LKC86PPyuvFqO63euYdEZIb9IrqUFl5AIS2p6r62UtVYSc0BNCesvk3SlNiSx
         iT82jR11ibwOQC6f6xaqlrpMmUEl6xmjjsynRwwRxu1h+vpUmFAzs396iT+Ok237Gme9
         gGm9i1yxtn0SJ6ZLvs8froVxild22nP70PgGKQlbOJKaK+zOPtZR5GA/7HXu7S7Ti7Rd
         i3mw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6M9piqlsuFNu3wJ9Mya6WkzEX884Vq7d6Ob0+kkOpiz1yldYlF0K2eGlgrwnObxIQiHrzTxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTVQfoH7HmZ9oc8g/17mJZPvKX6CwwCJJu2g+SsAxSL3eXIcHH
	U6i50Hy6h8Vlbldu/fFVhIhp1CSivuondzQ+kJytab0qtP2FjZ5Uzgjp5tx4hUt/nDKeNRAuAPz
	bErshd22q+XqgJG5i+hVIqKHRSXExOMY=
X-Gm-Gg: AR+sD11BLaaL6BmOnabbzhHYPYjsRTCN+b9hRi28AdnLMILcvGOWoBLO/2ZrBJXTk94
	XnInt57QznYmzVrbV125BUFImzRfhgcCWfyDuIke5rRrkT5qFPj887o9rQOtkDfI6tYg+LtHIbc
	KUai9qloZor5/RfuZOEzpQln6EByn8M2k+DMq0ieJ1aXVYc7PMxfQLkyPvgxW//Sd9jLP0YEEYj
	16gasDNiorpJu4tUH08dat2DpjPCnvG5JK0YGLegr9p9tL8MmCfL8k8d+q5O5QFGLgkkA3iWGXu
	46dD3Rifr8/zA1cmddcj4+TWiPvU1t/7heEjzryGQzeAat2lAGYc84oUtmkoS+5HAXYkk3RO9QN
	1rAlyjiL/h+3jOsFw2QXGtZEqp0RLq6GeyfkaelAp/1qjwbjseqC4bmVgkFI=
X-Received: by 2002:a05:6512:31c7:b0:5ae:bcc4:c071 with SMTP id
 2adb3069b0e04-5b2f4ae81a7mr2718810e87.0.1786080243491; Thu, 06 Aug 2026
 22:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804085330.1333242-1-xiongweimin@kylinos.cn> <20260806160410.2689091-1-kuba@kernel.org>
In-Reply-To: <20260806160410.2689091-1-kuba@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 7 Aug 2026 13:23:24 +0800
X-Gm-Features: AUfX_mx4bReQpJiFf032E4v-MIpmmPYimASFStvuaH9sZiJsUvBsJhvKU5xM0ZM
Message-ID: <CAL+tcoBR3Nn8KE=pGOUg+ey1X_sqcFkkOjAJHrnU-BDA2=HP7g@mail.gmail.com>
Subject: Re: [PATCH net 1/2] virtio_net: check AF_XDP queue index before use
To: Jakub Kicinski <kuba@kernel.org>
Cc: xiongweimin@kylinos.cn, mst@redhat.com, jasowangio@gmail.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 12:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> virtio_net: check AF_XDP queue index before use
>
> This moves the qid >=3D vi->curr_queue_pairs test in
> virtnet_xsk_pool_enable() so that it runs before the vi->rq[qid].page_poo=
l
> check instead of after it.  The rest of the function is unchanged.
>
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 3e2a5876c6c8c..6160aa8ba595e 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -5896,15 +5896,15 @@ static int virtnet_xsk_pool_enable(struct net_d=
evice *dev,
> >       if (vi->hdr_len > xsk_pool_get_headroom(pool))
> >               return -EINVAL;
> >
> > +     if (qid >=3D vi->curr_queue_pairs)
> > +             return -EINVAL;
> > +
> >       /* In big_packets mode, xdp cannot work, so there is no need to
> >        * initialize xsk of rq.
> >        */
> >       if (!vi->rq[qid].page_pool)
> >               return -ENOENT;
> >
> > -     if (qid >=3D vi->curr_queue_pairs)
> > -             return -EINVAL;
> > -
>
> [Severity: Medium]
> The changelog says this "keeps an out of range queue id from reaching
> vi->rq[qid] while checking page_pool".  Was an out of range qid actually
> reachable here?
>
> vi->rq and vi->sq are sized max_queue_pairs in virtnet_alloc_queues():
>
>         vi->sq =3D kzalloc_objs(*vi->sq, vi->max_queue_pairs);
>         ...
>         vi->rq =3D kzalloc_objs(*vi->rq, vi->max_queue_pairs);
>
> and the netdev is created with alloc_etherdev_mq(..., max_queue_pairs), s=
o
> dev->num_rx_queues =3D=3D dev->num_tx_queues =3D=3D max_queue_pairs.
>
> The only path into virtnet_xsk_pool_enable() is
> xp_assign_dev() -> ndo_bpf(XDP_SETUP_XSK_POOL) -> virtnet_xsk_pool_setup(=
),
> and xp_assign_dev() first goes through xsk_reg_pool_at_qid() in
> net/xdp/xsk.c:
>
>         if (queue_id >=3D max(dev->real_num_rx_queues,
>                             dev->real_num_tx_queues))
>                 return -EINVAL;
>
> real_num_rx_queues/real_num_tx_queues can never exceed num_rx_queues/
> num_tx_queues, so any qid that reaches the driver is already inside the
> allocated arrays and vi->rq[qid].page_pool was an in-bounds read.
>
> For a qid in [curr_queue_pairs, max_queue_pairs) the old ordering still
> rejected the request before sq/rq were used, so the only visible differen=
ce
> after the reorder appears to be -EINVAL instead of -ENOENT.  Could the
> changelog describe this as a defensive reordering rather than as preventi=
ng
> an out of range dereference?  As written it reads like a memory safety fi=
x
> and may attract a stable backport.

Point taken. Sashiko is good at finding things like this stuff...

I don't see the necessity to keep this patch then.

Thanks,
Jason
