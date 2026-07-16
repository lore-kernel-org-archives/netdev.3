Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303FE3A5436
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194922; cv=pass; b=gg5u6AU3hIKBra0StG5HZ0WJOS4NRwZMyZycd4ddL+oKZq/f5xnk6DVENf+yF4W0o9ZUMrf+688uH3n7WR6kvf3xxV6rdwF2XZHh2t0m+RFO8J2fcadpnoCmWksXro/aqK+XL5yngmjjsZlnZq/PflIVWHATr8jtP8mjJJwcU/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194922; c=relaxed/simple;
	bh=LqqsdM1x0Zd6TudpeBiM7tPh+032sxPHxb49LL/o6kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/yC99LcpGNsRc1xZqSCRVWo3rquhAaq4BWEv2PPzEEya1zZ1rJ59+Z44F9qAu9ruu6Gv4fluD4uz1g15xcRztjn4lIQLoicxRP1oW4nFbsqtN3Btoec4dJMsUnBKNF7lh+pMFlouMH5F/s5It9Y6SmFMiMJfG1/1198EKg/T9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0HJvOaW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhJCKv9T; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0HJvOaW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhJCKv9T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784194916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXu8rj/Lq4zKxTkQDISmUqipyXnuZss0b7jMIW5OWBE=;
	b=S0HJvOaWGyDwPBKwCLNMWIWxD72EhMGYK5Q5upmidzxYpP2pHNgYb14SctLXHe0t5Gc5BC
	dHchjpVYZf/5CN9iM/UQ2OwxCjsxjFqdLOZEKKLlGkzuWHsKTn2XcRbMTBuWclti2ALPmL
	sOttTvJMrOzAla7xj3TGmvBho2XTmI0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-E-6Ps3_gOfaaV_6tO-qxcQ-1; Thu, 16 Jul 2026 05:41:51 -0400
X-MC-Unique: E-6Ps3_gOfaaV_6tO-qxcQ-1
X-Mimecast-MFC-AGG-ID: E-6Ps3_gOfaaV_6tO-qxcQ_1784194910
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-80ee3cb097eso191911787b3.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 02:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784194910; cv=none;
        d=google.com; s=arc-20260327;
        b=Zxz49GKqdE7ndUL/Hb5T63eXcbo1xbdopKMnRfMogdeFusYNXM+IQ0i4bR0Yx7ymIQ
         fsker7dpDrLeOSPEq0hbma+3kpy23P0ittOwKrvd787Caw8jgqdW+N/BSIvJTA43J1XP
         hAWWw9tIH6sZS3GtQGa4lo+NhX5gYPwNbzMoVtbo6pafzbVJmDLBxyKnPrAGYbQ/RwMa
         to1XLPcEGb3wVh3RLPNu3/1SB/+ElfPfv0e2bCfFNNFKYTK7BntnKqa0BYsAVZsKqxVb
         7LnGfX4KgGSCwIYuvHb8xQFi5NsK/uYs+T+Jkm4z0lfdiklPpfWoWtMMs0muLwfLQA0i
         kyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EXu8rj/Lq4zKxTkQDISmUqipyXnuZss0b7jMIW5OWBE=;
        fh=N72YIsU28Z+4Yld0bnNgAjY3tNCCEmM0gVXO7fDaMMM=;
        b=RJOiiLQIwBnUo7Wvq7BhXIO6cFDPTKvWMt9oIMsqvKHmFWQNPpnpkojZQv3Gw+MiuN
         D4JV3/98+oBSeQNTfZG8TgaS1tzqxk85/x3RyuttKkW3wWp+DoDB7Xg8eCgx3q2vKjvF
         WNZqcPl0AdJSJIs4PelhR4T1kZTcT9E3QiHr3keCV/9HbV9noRd59c9lgRIUFYqitX5S
         ryUi3UcNRVsziZtGuH1CBUNBdgfGkxc7jf9wQT1I+IrMMOB1gMR8awio1wufuPCTWmNB
         gaS1MYCVdURT7XzQdJCFMwS3q7PfLwiZJiGMhkBHXzhtjFAJKWNqNneCda/c8LmJZYVX
         8AzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784194910; x=1784799710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EXu8rj/Lq4zKxTkQDISmUqipyXnuZss0b7jMIW5OWBE=;
        b=BhJCKv9TXVDrgois5zsqTO0a+cs4+RQmeCu9YW20l+GA5pGHySFacdMFdbXyAOXEkx
         mPSJ10Y5ydJSFRH/UQCyclDY5QlmNcvTPZgub51ohs8llDG/3sDzkh1XiiWaNedpSLwl
         W6J3UYTXSG+lvu7WPkPIQypiVMnaOgC/cjV5RK6sZkAGWkgOQxMstSAa/QdcNuwwlxSJ
         RBcbzisv5yzmF2wxwIxYbUHKguiCvKvvIJVEdYlFtTMnKBEXgv0Ymp0Kf4eH8CqAME4G
         oPypXdiyE031+gnsPnLs7ipryj9O+fIHrJmT+s64vdKUlpAyh9FuFFZM4ZS509Phqb7E
         ORXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784194910; x=1784799710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXu8rj/Lq4zKxTkQDISmUqipyXnuZss0b7jMIW5OWBE=;
        b=lbZs/Jx0SNtB9OpUIJsetwc9rx2BK2PvEiO7GNf4q13s0igwboWlZPf5hgRnKCquZt
         PX2aJ8oWjzEginK+TYcts5sGkG7KNIYoEbrTMGo7ZgHdWR1aql6fOdfuiTMSwN9DlSW1
         K31W6iHQ9TZRkmAYxR8MTWH0gThBmngs1k58mO7gJoy6J258JmRkPS1ts+BFevePvdLZ
         5o0NgD9yCsZ3zOa9FpWEUCqUlq1xzXnrR6eGOeflhpSClAlB/KShHWfEnt0mN62bDkUI
         8ZX3pvFV2TdgpP2ZG7jaj2zfUZrIpe/1aVtLZNqdwQy+5m4LsUnjwJa0b7McZhSQsOk2
         JAhw==
X-Forwarded-Encrypted: i=1; AHgh+Rpw9CIISPYndJ2jhqinrULGhT592J7a4RUXA9KduMVvDhNhDcKo4pp3KkaD5bFotVT2ZsIw+hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCuM46cvl7SA6tu6x5Qk6ZP1mtn/B+cQCt76p8uSCjotmGgAFS
	FEZLJMsMUszJzvY7ebMFp4HddITmSw/zoF+ge+JZnt35unvsABk9gseAlUn8TgugUkve+6iUIyg
	3p3fol17KRhUAbVb7FzSgq68f7rSrLQlOFDK/trez+/qKivkZxHHXzt0ztVfLazzgX+PkCW4zNc
	fI5+fw1hgchZnBVSymiegTKMXpL0O5gmDP
X-Gm-Gg: AfdE7cnxbqTQVGdbJ/wS3scnGeiktI2N+xZAkeknPIeJQ4vcypzK1SGyktgTWCnspuz
	R+I/mK72BveUHjaFAZpyWDdd2g4NbEtOgJYavt9qbzjqEnL3CiFFE8YoImOyTE2ucz/AB0zbk6/
	QSlhiaJT8/09eC/MdRiNwS9up7sHq71EW/sYZ1FKFDYUdQ3tUHoYr38ULy+IsX8qzRBV5TCiH+1
	mXm5DoU1yH7fwB7JjMqhwK3HfK1cD2Q5sy8T82bpCs5qHKxqdGmaA8zFAbEeU9IZt9JqFwdKH12
	nmt7y2AuGgFGWAI=
X-Received: by 2002:a05:690c:6a12:b0:809:fd83:a88b with SMTP id 00721157ae682-81ebfda0fedmr73234497b3.3.1784194910373;
        Thu, 16 Jul 2026 02:41:50 -0700 (PDT)
X-Received: by 2002:a05:690c:6a12:b0:809:fd83:a88b with SMTP id
 00721157ae682-81ebfda0fedmr73234217b3.3.1784194909834; Thu, 16 Jul 2026
 02:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716030236.124322-1-xiongwm2026@163.com>
In-Reply-To: <20260716030236.124322-1-xiongwm2026@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Jul 2026 11:41:13 +0200
X-Gm-Features: AUfX_myzajePn8mltUINphDNuq-00hOZMHHFFuGnRbdhRoWqlQATXfpqP4mVDnA
Message-ID: <CAJaqyWfW9n5o+ojrEjK-m+6cwH_TSxWckjkvEXowZA8r=vDmdQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: reject zero-size IOTLB INVALIDATE
To: Weimin Xiong <xiongwm2026@163.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowangio@gmail.com, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	xiongweimin <xiongweimin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 5:02=E2=80=AFAM Weimin Xiong <xiongwm2026@163.com> =
wrote:
>
> From: xiongweimin <xiongweimin@kylinos.cn>
>
> Reject VHOST_IOTLB_INVALIDATE messages with size =3D=3D 0 to prevent
> iova + size - 1 from underflowing to U64_MAX, which would
> incorrectly delete the entire IOTLB.
>
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> ---
>  drivers/vhost/vhost.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3c080c454e374cabd7321416ed92c5f7d3135254..xxxxxxxxxx 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1656,6 +1656,10 @@ static int vhost_process_iotlb_msg(struct vhost_de=
v *dev, u32 asid,
>                 if (!dev->iotlb) {
>                         ret =3D -EFAULT;
>                         break;
> +               }
> +               if (!msg->size) {
> +                       ret =3D -EINVAL;
> +                       break;
>                 }

I think the issue is real, but how about adding the condition to the
caller vhost_chr_write_iter? It is already the

if (msg.type =3D=3D VHOST_IOTLB_UPDATE && msg.size =3D=3D 0) {
        ret =3D -EINVAL;
        goto done;
}

So it should be somthing in the line of:

if ((msg.type =3D=3D VHOST_IOTLB_UPDATE || msg.type =3D=3D
VHOST_IOTLB_INVALIDATE) && msg.size =3D=3D 0) {
        ret =3D -EINVAL;
        goto done;
}

With that, please add my acked-by.

>                 vhost_vq_meta_reset(dev);
>                 vhost_iotlb_del_range(dev->iotlb, msg->iova,
> --
> 2.39.3
>

