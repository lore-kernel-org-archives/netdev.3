Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360503BFACA
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196295; cv=pass; b=nyhQ9Qha3vzpDXigbkjncKD64RggeWn55u7aRGq83tWnlcKYwy3TTwd8hRTm/M9u8C+FzoV73hY0HbZQLPjp5T2ckPfcpp0q0qX7YaqZvLr7LnG2IMLR0ewYsAEuaC7U4c5/BhVix8QpyG5/zI7MHwx03+1IOokH4oqM7W/mZbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196295; c=relaxed/simple;
	bh=BCB33d83n81ftt+P6iijBAgJ18dpo1QXcSXfEldMbso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fR3U+vyyRtWEa7VbJoltqx+SJwHjNME8eJ/aLEavLmMr+aXFyMv9WbmEQLQr1dQ2nlBKt8Ofq7BM2vPrQh8ZiEgKj2OWSS5jFcYmNkjYgWsIQVkJQcU9l7+r7Z5Uf4A8PdpLFsdQ9rRfCCLdATGPqxIQrjqyCT8yevaB6LWarOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEHaN+zJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=acLK9BTp; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEHaN+zJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="acLK9BTp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784196293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQt8yS/PdstDJXEvnchALJjULr9f9l02ImmRKvduirw=;
	b=XEHaN+zJOgzogYfvfV6KCilGkV5fNoXzFqa5mSozY3cq624mYvR21rA9+RWVXMWTwX4IRv
	FmnSlBZSi36sKPiiIxBtBhGDQyawAbmH0UqWlPhcEbkwgQ5UHdp6lN6DGYc/Bkgzzecb+4
	/PzmRkNh3F/ljSoY0Ux21bxZxHjeIq0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-zZDkPQdxMDWeA6NUUSh0Yg-1; Thu, 16 Jul 2026 06:04:51 -0400
X-MC-Unique: zZDkPQdxMDWeA6NUUSh0Yg-1
X-Mimecast-MFC-AGG-ID: zZDkPQdxMDWeA6NUUSh0Yg_1784196291
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81ebb5e11caso48944887b3.2
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 03:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784196291; cv=none;
        d=google.com; s=arc-20260327;
        b=s+rle8v42BBJst/tSvOxFzPz9SXOA+nOTwyYBeBA8TzmKBtXT2qyY6SVuNT/T8QaYj
         cuwh+YkYZHYmEcspC43zE3sY1MVxu8ynmJ+qKjQCJhjfbCzvArvhLf1vEtCCX1JANMSv
         a/45oSQleVJGj4OlKO2xrJ/B1540s5N0n2g1naLa0rMOK64WQVQB7/riwc68HIbeYPZ+
         SQWoiWyNXcOa92+U/8VUk/+ox6AwyCNoymkol0Pp0gCpQVi4lLb+iylDjO18eBweX3f3
         p6Zvymumps9xbDsJDTfVgVoazRuyTRTRZlKQBKvHVSoxEtu7h7UYFmedG9TVkZn3qk8u
         oL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rQt8yS/PdstDJXEvnchALJjULr9f9l02ImmRKvduirw=;
        fh=n9PgaZqtLfVqoRxQ6dDHDJLb2sxFqLXFrWfQVQDN7r0=;
        b=OC7E9Qb1taAYjSXWYrzMGQqDGyHI2HNR56YiWzUVIlXNyidfV7fLXDzaG+9gI8AI7X
         CbFX/DxGi2rw+TdeHoXHViur9V/l4FTTaRXBlpc1gjZQtEYofgaQ3R36U/IPS746TtQw
         gAI0OORnHfHXAVfyH2he1wncLaZCASnuWPrT9/FebRH5w2/jqbuOs/Mkis5Ts9hvtw1x
         Imno3pvRrj/JeH1AaACI0l3wCLjR5DOROJnQ9IA1DU7sAv8Ap+24lwDT78i3LNlK2XNN
         v1tO4FxT6tCl6M88Go38jFam2459HIguxe4Z2JKsrtxZLZkSLvccSKRCymw2RazO2GjX
         iT6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784196291; x=1784801091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rQt8yS/PdstDJXEvnchALJjULr9f9l02ImmRKvduirw=;
        b=acLK9BTp77Te5vOQDrek787iyM8AKN+jEdAT+OULFHLdw1h4abSfyivduFNrTiZVwl
         KHjtd2p4OKGPe96YCAMMLXDNA/abq1CIHUEMlr6lCPzlBDCQ1IZ39aLiEK0QfkEBuFKO
         b6aEBQdT8OTWWCkAe5D7vwa0W5wCPIAO862C5uFOJ0YRRsLn81aODGa+n0s1pegfWPU/
         RjIXy6/pyONIGdRk3vp3k+ld4ShhWObdHeR1lQaDC07PktG/N2ccL2PPUcKI8J+5g4UW
         6PpjSWGsvTnROE10+xw6Ce7CEcoTpF8IMSqB34vAqjxpZ2yy2kX08Ye6c8+Uu/eDetlS
         KfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784196291; x=1784801091;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rQt8yS/PdstDJXEvnchALJjULr9f9l02ImmRKvduirw=;
        b=Too7kGYFFpAHhXyhI+cg25TEB1om0rMgFY7uLmz/6ujCx9apKoPcGJhHAlXbUTwBko
         ZUCb+HANAANe/zR5oxB4fxK8Ym8UhX9Qg5YFg9VP/KHSRg39L6885wxeh0OjYyy3dnvf
         E5XCEsTqFI36N6NU6g5YjvGNXHxWwQFRkOiOJUOKhlRtEO+6sh2JOL6pxdz7ewyuI5Ja
         2RMGVHD9jkZX53z0anI/q9bKw9mO4FoNx0UqctpBmJLA9wnHiW1K/5XA+UarU1oXeruf
         aTbIbnVw9mj5fkT39AdB+0ceqbJMoVlJjbCU8QkPTaL4ZieA/o+XQv8KUdOCfd3H3vzj
         PaBQ==
X-Forwarded-Encrypted: i=1; AHgh+RovgKUtClYELLRg05vw0jXGKhm2yjxCld3d9+Ulb6IGoyE6oVWaomLyGZM03cesbfToFEzgCqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTU670iaVXHtmztjFd3goOCS2KBNHsoB7katTe0l2JVmRAgI9h
	/5TIdvH040xjdVzTludsnZZ3wGFxY0u/N6AFGDpY1100T0rhWlhHrra+bSAWPlMyR5tdMCM3oP0
	EhvrEDsmy2wUa/vIxTRu1BYKKAs0PYjFy7I5VHVfcJDVRGvX6jblC00CY5C0VT1euBuYE1C52uV
	b4HilOtkOvodmwQcdABjkTr2A+R5NaZj7B
X-Gm-Gg: AfdE7cl9pSj5YqDy4vKp//S1tFFlJMtq4BsIoTbmVmUJoUo0PSM4gr39KUdV6+p0mrW
	g5LSXplzkCrIjXWJhSe5MZbD+ON0H2Gh1tBVTLGhyw0T6r+0n1qLMJGVOqtw716rQWnIqdqKFoc
	QAcau7U5/rQufcBcPWbYMNNJnpWwPnusB/bXS8F5XNAdgZpw2F/p2aCx2V1o7p/Gls0AGS8dmlZ
	vsadCmSZxd2VYj4q8K53Zq2IQSZhONr+ZhiszCg4tkolncsBbKz8SS98LHJMtsmrJYUIW10hqiZ
	aXJ06wXGTVfjX6w=
X-Received: by 2002:a05:690c:6a0c:b0:81e:69fe:a594 with SMTP id 00721157ae682-81ecfa37cf0mr48093947b3.42.1784196291274;
        Thu, 16 Jul 2026 03:04:51 -0700 (PDT)
X-Received: by 2002:a05:690c:6a0c:b0:81e:69fe:a594 with SMTP id
 00721157ae682-81ecfa37cf0mr48093747b3.42.1784196290871; Thu, 16 Jul 2026
 03:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716030238.124368-1-xiongwm2026@163.com>
In-Reply-To: <20260716030238.124368-1-xiongwm2026@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Jul 2026 12:04:14 +0200
X-Gm-Features: AUfX_my1PDjF2_brAd_JA5jz3TnFGBqbcce5MlVt-5iITb1GzEuz4iCkoFmeE4U
Message-ID: <CAJaqyWdXReDxp-nbz2ydHrNHegEFjm4eGoKYQGYmmdt5e_gjaQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: reject zero-size unmap
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
> Reject unmap requests with size =3D=3D 0 to prevent iova + size - 1
> from underflowing to U64_MAX, which would incorrectly unmap the
> entire IOTLB range.
>
> This fix also covers the error rollback path in vhost_vdpa_va_map:
> when the first VMA lookup fails, map_iova equals iova, resulting
> in a zero-size unmap that would otherwise clear the whole IOTLB.
>
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  drivers/vhost/vdpa.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bb96b1aa5..f49bf1cfb 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1035,6 +1035,9 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
>         const struct vdpa_config_ops *ops =3D vdpa->config;
>         u32 asid =3D iotlb_to_asid(iotlb);
>
> +       if (!size)
> +               return;
> +
>         vhost_vdpa_iotlb_unmap(v, iotlb, iova, iova + size - 1, asid);
>
>         if (ops->set_map) {
> --
> 2.39.3
>

