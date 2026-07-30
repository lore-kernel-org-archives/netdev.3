Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462483F822B
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407307; cv=pass; b=Zo6wZKS2rAR24McLP0IEfWNJXJI1c9+cWlI9PI1hAdhroP8hc8s9W41vgTUd4Uv4BgdCz60L00mWOceF78ptmcgs8sLFOCCtSpEmEQ+sFdYMnhhZAGrJl9T4POpsYRqt7jyXtBp80UJtnp8Bv4lWEUnS3oiMbqj4vZYPxdnxcfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407307; c=relaxed/simple;
	bh=gWxIpwYxIVNdq9btL+3O+1+adez6OPA97GMba0U7GtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESEP30ZwJ5eVzQIUye1ZnYcQYp3jEFZ6i7Mh6WFczknLjJZN1GJ4kuk9Ohs5CWATKYcISOSGRqU0gtbeFZ9rnX6E6IaMJxFeAgTwLh5Eu7cfJS2pzJX7rAawzOk1SF+FJW7zA7nJ7XRpSW1q8E9vH7S7pPJWWZQgTft64ifUqgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksmCxs29; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksmCxs29"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69fe1df830fso353376a12.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785407304; cv=none;
        d=google.com; s=arc-20260327;
        b=RtqrGlRxqlohnGV3cnBQPFSWVHNLamktwXgd/6w08AXpH0JVU+TqcuxEl9jiRQEjYB
         Lvw4DHbgyR+xa610cd5HNiyUb0q5UNVaW3qNQYvAF6cqknw+tArXaommP8a4uQ4VDuDK
         Am/VyyWcWsrSzlD6neSgahcxvwawV5+1uK/0dM/KOWTb6y02FjqWb2NEs5c8wSE4pBby
         Hi8Wfivsj6SnzD0F3GSbSfsMkvTkTJSXehMMR22mxNURxge2DMDN9IQRy5w92sqej94W
         I60lnsk5HpRdp2CDmykXAu+234TsOvQLIoDCbNdpG8e4oCrMPPH0I/xERgn/Xba7etVa
         vnTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6QXxKqfQ1KFWWVEQdtVCU1CqxX/OD+MUCly4H9utyfo=;
        fh=l1KO5mQcBmuENqaNH02JlRqOCiDN3NAHQZu47fkFiO4=;
        b=q4r6/ppdUWz6DIj2Gr9GsicYu8xGSdPYuIHoa0AeUnJRJjCLRX/krzXyjQ+PeE+amf
         7pqd8MJaT9+2Z5O4Svsh0yHP/LqnKJzHQA2Qp2AN1FLWlwtAm/wMDqRIV8oC+pxPWFiZ
         aqUXAEe/+xQ0OCyuif/nmE0rhRLChRSxlXMHY5QPaNI2lzOmjdGMCXW2UQP7JlMGgS1R
         z008mAMyuj8HlzgYXXOHcw4br+bL+bgvoSv5fYUuqfd/XZLts5Pc6FXvUxL2C8dPzvE2
         MSer0PiXqsj1V+55wC5SjJ7fc4q1gAwKqO1YU3VUAGP82BotauatbBY/qbs3Hyv9J/GL
         eSSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785407304; x=1786012104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6QXxKqfQ1KFWWVEQdtVCU1CqxX/OD+MUCly4H9utyfo=;
        b=ksmCxs29vnQ6BrGIiWbWq7Gn4l5lKgqu3/J5xoYlyY4QDdqHEWh/SvNJ+CsqnCOyC9
         7x7adpCC7uyQaHLoXzNNi3A/5lSidS0D0Oj6siGYTLUw5hRWvSf8kjSre7tcC5ZSOeVr
         gvYUTb7PR6N+1VXLbbqFnUHAmN6czQbAtUl5I1elPVfnljWff8MFJkqYskYyl/jKXvcl
         Ssl/f689POigfBR9Tn9cH7d75olYFm+AMM+mJSQ8oUCXi2z84KiN94Uodvf3NC9XX0z9
         C4mugiRIvkxfGNZ8BMnnnPt+RV11KqTsNATSnTlLbOW+NNXRFS39Ejscb0kGNf+b7tBp
         5B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785407304; x=1786012104;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6QXxKqfQ1KFWWVEQdtVCU1CqxX/OD+MUCly4H9utyfo=;
        b=jllcLZgMC+CoOdazQO0CNwi/Ad5rrm9mTN1D2RGCy8S+vwGUgk+ARh5Gefa0kwNOLt
         fksdCZXa8lfrT3S+lZN2numtuYEY3pJOnORYt8rBVKiWnDOrSnLQeyAA9zIxMa4XJXcN
         MiNISJ9/fMgNKJjbH5RLdCQ3/2LweI1iGxsBeZFzox4fsg7PbdnXSPA8EO95hhMtRq4L
         7JB0G57b6e/RSkadMTE0ZFNw/UiZ1YWvbepV/5lvAhN97U3nYe/+IHOVhqLLha4lLuqT
         bHH5gd6ivx+00gE3JL0iNpK99boSvoUnoSkUpB37Cgw0HaE66bTjucSwXDYOqx/tvW4H
         SzrA==
X-Forwarded-Encrypted: i=1; AHgh+Rpo4ZdU23YpcOW1cVIoZZOnHiT+bvtBZ5LezJQpRontqCe0H0r5q8ygCPu8jCPw1Wce20XaOx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtPKcyo9/gN5kHhmIPG7s5QT6U6AwIFOQGANsHi+mh0XsOr4rt
	xDALWyXydPvhJmHP3OEypodod5wt4SOFR5FM9zQ7Xl2OHZr+gVHlr6Ze/yjsGujqdZmnPXCU/pg
	12t83KTRF7zSdgqqyGOiiz9xGX9g6GwBF1UlDHFw=
X-Gm-Gg: AR+sD10bbBOX44o5JN3BwfVwI4U4BPCrmNSfF9i2/sM4rluWfNYoD0LTiRsQoLltCZg
	NOJvFbWzGlQ6zaUQMrQqb7ho5iKV4y+AAD4Aser6oTWoCK8RlybHSg8Do01vr7gHV9BEqt0wcpU
	OtxWs4l/+sgtHSBZNqyCVLkoQ+oiYRtCitF6vClX99Yl8nEohhd1D+VRsdSXjjU9DGq5d0DWeap
	LSxSOrpcXjwUA+8icwUme1qHYbkMBLQKfVKyQCJgkBaLVwzieyeH6x4t9cvkCFzq/eWaXKbjMdT
	S4pqBfmumk3ZK263lKKpY2gREuepkC5JWg70CDZPOfAxGVi5fgxpSvNd5mSdRkEKVhK3RtGcVg=
	=
X-Received: by 2002:a05:6402:5191:b0:68e:4c0:f59a with SMTP id
 4fb4d7f45d1cf-6a07b851903mr1040959a12.2.1785407304296; Thu, 30 Jul 2026
 03:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720184955.3008978-1-nicoyip.dev@gmail.com>
 <20260727174826.135662-1-nicoyip.dev@gmail.com> <26c1ea30-e6cb-4f3f-ab88-6d00f0ed2117@redhat.com>
In-Reply-To: <26c1ea30-e6cb-4f3f-ab88-6d00f0ed2117@redhat.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 30 Jul 2026 18:28:12 +0800
X-Gm-Features: AUfX_mxYT1x8uX62KawheLXfNHW3ozwMozJnaYpC63DKgR1SHsZfZifetC9okBs
Message-ID: <CAAo+4rXxnQFBsAtHuTNKiU60dMUnw5u+A_=EsQn8ntzJNV_++A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] rds: synchronize info callbacks with module unload
To: Paolo Abeni <pabeni@redhat.com>
Cc: Allison Henderson <achender@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Santosh Shilimkar <santosh.shilimkar@oracle.com>, Ka-Cheong Poon <ka-cheong.poon@oracle.com>, 
	Dan Carpenter <error27@gmail.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 6:02=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> It looks like I was too optimistic in my previous reply.
>
> On 7/27/26 7:48 PM, Chengfeng Ye wrote:
> > @@ -78,8 +80,13 @@ void rds_info_register_func(int optname, rds_info_fu=
nc func)
> >       BUG_ON(optname < RDS_INFO_FIRST || optname > RDS_INFO_LAST);
> >
> >       spin_lock(&rds_info_lock);
> > -     BUG_ON(rds_info_funcs[offset]);
> > -     rds_info_funcs[offset] =3D func;
> > +     /* Validate the latest published slot value. */
> > +     if (WARN_ON_ONCE(smp_load_acquire(&rds_info_funcs[offset]))) {
>
> This read is under the same lock that perform the store. It's totally
> unclear why smp_load_acquire() would be needed here. Very reasonably
> it's not.
>
> > +             spin_unlock(&rds_info_lock);
> > +             return;
> > +     }
> > +     /* Pair with lockless callback lookup. */
> > +     smp_store_release(&rds_info_funcs[offset], func);
> >       spin_unlock(&rds_info_lock);
> >  }
> >  EXPORT_SYMBOL_GPL(rds_info_register_func);
> > @@ -91,9 +98,15 @@ void rds_info_deregister_func(int optname, rds_info_=
func func)
> >       BUG_ON(optname < RDS_INFO_FIRST || optname > RDS_INFO_LAST);
> >
> >       spin_lock(&rds_info_lock);
> > -     BUG_ON(rds_info_funcs[offset] !=3D func);
> > -     rds_info_funcs[offset] =3D NULL;
> > +     /* Validate the latest published slot value. */
> > +     if (WARN_ON_ONCE(smp_load_acquire(&rds_info_funcs[offset]) !=3D f=
unc)) {
>
> Same here.
>
> /P
>

Hi Paolo,

You are right, that two smp_load_acquire() are unnecessary. Should I
send a v3 patch to change that two smp_load_acquire() under locked to
use back plain read?

Thanks, Chengfeng
