Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792567803;
	b=KS5WUg0rtYMSX+ZjATAgXrmwoXTDyqx4kxfpNPs1SOq4SfioGNVXURP5dJUWiRT/qR1N
	 gQvhGiqjPJJLaKsRt6W/zfakzN/VDBeaCbikIHAbWcQU+l3FCSwDrtWIjCocQ/lrpKair
	 RtGcJffjDuAxQWKPsFFXp7U3eCfibJEeAVZfJu+2uknz1446drm3syRE3OU1rJ/rXzuSU
	 sOz8eketEcebWCeQMO0wOdW0FpkyVXNgllLANAbWFRCL6AwBCD6HiIDvnq/KtcSS5Dz07
	 0qlkYDaEFcM84TeoipUuaOBDzWmnQgk8NGZFj4l89gzAKKJLZrJJDhlyYRSdh87fObw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567803;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
	b=jFrCjB6MvAj3Lg9JJbt3KoP1Fj0bsZgDmi6M5NpPSTX5ZdJtb1NgWOMGYZkPhHsXM8Rm
	 pVrSyOFXS6uTDJryFUDImzpX6yfesOGRHzNKZA6bd+cNx8CQ2m2p2t9079fxLcz/MhjOK
	 pq1Wi23yy/oMqqryH7tFsqEx3AoqDk/bMxllv6aLZSWQO4HCYrw7pmFpMptTISfT0a6eK
	 n94NoVMp44rhiyTcvFbtwC3U+XbcUcUkHn7duUZhbuVlZcf+1cm6xh/bB/Dgcea3DBTZp
	 joyTequ9ZFTFe2leQW7E5kj+0jH753CHqUTpzanXCz73R4jzEbRho2oYK3ETIXdWvYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MEo0p6wi;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iPKj99OK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FC7606A320
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82FC7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MEo0p6wi;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iPKj99OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792567801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
	b=MEo0p6wiV0/R/3nHv0Agn6BGUrhqJa+uywYRPZFlq/M0cClJEonQ+FFpq6WLkNWGVgpWdb
	S2FnjkfHj2uAcqsUlCXxqr7bIOLV9xlDVAnLeP6MuVE4dGRbuB6elm8N5ogmYrALCYSi0o
	ucKS4A/+IfSTynEDj0VRe5X2a+ffBpc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-Ol6hW2gGNcmCZwOFQdVY0Q-1; Wed, 21 Oct 2026 03:29:59 -0400
X-MC-Unique: Ol6hW2gGNcmCZwOFQdVY0Q-1
X-Mimecast-MFC-AGG-ID: Ol6hW2gGNcmCZwOFQdVY0Q_1792567799
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b0a8c1b87dso6462727b3.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 00:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792567799; cv=none;
        d=google.com; s=arc-20260327;
        b=sQadjPEA8sTPqtsEjKfVTU/HrhOA2cniX7Pa+IVDi4CE4ibFLXkE0++JtmruUi69/K
         Xt76CnzpKcNEySjFPYmq2mds+2X23Org1kVspbIcgrH4IuOdIzJpSHTjapnIHm0/01EI
         abPjN+M1N00qEkNG4O5QyTpKTBGd/pLWP/2EjFliNRbPnAdD7fTFwbdImzoWwkJDdZwg
         PqBgHJZIk18w88TnO8FB/940XKW+xEe/X2LAUjNckeTux6XDymSo/40Y5rm+hSPc1yLg
         gLENtlvFcNVrxuoQjWmnCa47ZaiUS4P030/nsdh9jg1CFOKmYWi2/RBY7jSPmp89EcWZ
         WXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
        fh=K2qylNGwA0jhmNqucxwJRTEyH9CLdaBdOCFkeolJOdI=;
        b=C1mhLi1A5dtykaVv5rJGQaEecqGJNlw8t9OX78VEPBCnXImtG8GM40ZJCLbb4ABl2F
         xIzsiHfvOC+YrhUmXfTSZiCrTbBgzL72APf0epNmcGFw9Vhe58J3P+FZM5BGdDwRUpuh
         dVbtz7SeRdGhhjriPjNw742mOZfaZBPHSQb1QRXUCnLq82yYCFkGjqnws/UVM1PvrdDJ
         oP0e4Xm8fD0CKjvUl6E+xQE1rFZK93WRrOUSI2kyZgU9uN/PKC66FstOXV2UVRs8o+vJ
         2TNB9hFI0jOijlF7vZu6o6AXLjvGF3/Zap3I2lCe9kWFK8eDM7Ys/DrNRnjBFKYXCbBK
         Nm3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792567799; x=1793172599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
        b=iPKj99OKCYBLxKoFRZQf2Hg6XfmZny80yGZlMAmrHp5kx5XGo0TgWwOm1D8U1+QkFs
         UERYQore2pDeV1iNLK/bRlznsPf785W4T+NrHK/BAf18mYAiDfpZM/nVmxT27tawAbFd
         XsQVcFDBnTpT0wR8MAtQ9B/oS0eK085+i7rMB0YbRIyFnv7lD6qH+ZNDHWZeuKxmXnri
         EboiCCaMxHi9C1T91+RZpQUHX2EfDuCBuWDo7KFZ7OLZdbcK5IpbHsC4PpR5r5GXnYzx
         rT1z5IzF+foNu4wQnWwAjH9ek8D/VK41l8kXhSuAsNfYzEv/SS3IVpywD7hRuiA9z/rL
         AJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567799; x=1793172599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
        b=aetC18MNZPtb6o5WLL1BfBqkc3/BX/Yf1qRZYi2kXs1N10LyAt7EcHGHVf4MFS0+mp
         UEkyTwspDwSM56oNq0ZGaU+iqDk2QC2qRHGgM/JNv/jKoalQmnod6V62ED34fVnuZyGp
         mc81hnDLep7j2Et7smjlu3WYUaK/fsbD35L5J85u63K9MoV5Jb2qaXJ0PyQ3AVUYl/j6
         TEjd4VJ1ud6+zy0KNZP1arSizRdlb3xiN+gqLsAolHPpUE9HMpuTJK3w4hh+/O+7azdO
         +SCzUSzu3IA1b2n4tZB6lmedL/q8fJOCo6GeR1DrqvmygGiThWcREAlcDE7//ZzrVBT2
         s67Q==
X-Forwarded-Encrypted: i=1; AKwUvBwpIA4xEjA0r9QXt+fi7pqBbUjs1q5obdjqM9MDwluydFIBU0DJUIJQ08upa+kf59PhhdkRXV0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfnyPFNZ6WMnJe4N19HyQwh/xw1tqAneJHScq6U8AxAFMGGcz9
	pSKRRNcnueyz0YhdD0TP1460flilUKyYr09l4ypEdSeVfa6dzSMZb/acW47TgJUZvunDGvwWf4z
	Uy2HkAnT3udzUL++2mJjsW1JnwqUXffAqrY1Lf9CPje8qlF+5Wn1CEIDxVrjjz0enMrPp+JRA9K
	6m0lAYB1mLg77RJ2aXoQiv05vPYFLe3lU7
X-Gm-Gg: AYBFou02xr57dMg1/CX1cRP9/yiAOTaAKInzRPUlN66Lq+SYRCxfL+aki/CmaCHaqP6
	F7sWCrYyw/fCSIWhax1yi60PjciAZbCdei0PrjLe5//DMHfr6+Z0UWSlXU6wKEYpWDp/Hlo/UvH
	nR5EnaPGDkWggokSRQnVT3LwPAqKjA8sODPke/mkb0lg98x/lnvG/KP730BeUqU9HvTnNCpmWwy
	ychNYLVFYOATCQEjuPz6GW5uhLsuTwFCQCEGlGRTnEDFpF3j1XMT09kWNM=
X-Received: by 2002:a05:690c:a909:10b0:8b0:e238:2719 with SMTP id 00721157ae682-8b133fff1d6mr5006427b3.31.1792567798921;
        Wed, 21 Oct 2026 00:29:58 -0700 (PDT)
X-Received: by 2002:a05:690c:a909:10b0:8b0:e238:2719 with SMTP id
 00721157ae682-8b133fff1d6mr5006297b3.31.1792567798485; Wed, 21 Oct 2026
 00:29:58 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020232956.99970-1-fangxy@xiaopeng.com>
In-Reply-To: <20261020232956.99970-1-fangxy@xiaopeng.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 21 Oct 2026 09:29:21 +0200
X-Gm-Features: AclHuK-PqFWCN8ST8zFxglfpmVJtYh8ceAExLMaLATIvJ8UfZfghlr_8jg8ahUM
Message-ID: <CAJaqyWdoQXHiWEh6aCGt7T+U4U4S8Z79hhp5=QYzzkODeDVyOw@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix used ring index wrap in vhost_add_used_n_in_order
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Weibin Liu <liuwb@xiaopeng.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 1:30=E2=80=AFAM Fang Xieyan <fangxy@xiaopeng.com> w=
rote:
>
> vhost_add_used_n_in_order() advances start by nheads[i] but wraps it
> with a single subtraction.  If start + nheads[i] >=3D 2 * vq->num, start
> can remain outside the ring.
>
> With used-ring logging enabled, start > vq->num makes (vq->num - start)
> underflow.  log_write() then sets bits beyond the dirty-log bitmap,
> potentially corrupting adjacent userspace memory.  This is reachable on
> the vhost-net TX path with VIRTIO_F_IN_ORDER: done_idx can reach
> VHOST_NET_BATCH (64), triggering the issue with a 32-entry ring.
>
> Wrap start with a mask to keep it within the ring.  VHOST_SET_VRING_NUM
> enforces a nonzero power-of-two ring size, allowing start to be wrapped
> using & (vq->num - 1).
>
> Fixes: 67a873df0c41 ("vhost: basic in order support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
> ---
> Reproducer (verified on a kernel containing commit 67a873df0c41 with a
> temporary WARN_ON_ONCE probe in log_used(); the probe is not part of
> this patch):
>
> With VIRTIO_F_IN_ORDER, num=3D32, and used-ring dirty logging enabled, th=
e
> TX batch reaches done_idx=3D64.

Can you send the reproducer? I'm very curious about how vhost_net
reaches to done_idx=3D64. It seems some bound needs to be added there
too, isn't it?

The patch itself looks good to me, even if we will need to modify it
for packed vqs, so

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>  In the observed run, the initial index is
> 3, so the single subtraction leaves start=3D35.  The resulting length
> calculation wraps to 34359738344 bytes, as confirmed by the log_used()
> probe.
>
> A 64-byte canary immediately after the 512-byte log bitmap changes from
> 0xA5 to 0xFF, confirming the out-of-bounds write.  The used-ring canary
> remains intact because vhost_put_used() runs before start is advanced;
> the demonstrated corruption is in the dirty-log bitmap.
>
>  drivers/vhost/vhost.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 44cac11b68d2..0226c4c59709 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -3172,8 +3172,7 @@ static int vhost_add_used_n_in_order(struct vhost_v=
irtqueue *vq,
>                 }
>                 start +=3D nheads[i];
>                 new +=3D nheads[i];
> -               if (start >=3D vq->num)
> -                       start -=3D vq->num;
> +               start &=3D vq->num - 1;
>         }
>
>         if (unlikely(vq->log_used)) {
> --
> 2.50.1
>

