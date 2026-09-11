Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DD2BDC0B
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789088312; cv=pass; b=jSzwnMzls5bMH1gZZTwAiqy9xlB0GR0LQX35t5G0Yus05vOTyLJcCF/jCqoLKolVZyo34MBfIyb3YB9ovb7UWrUxeZT67A4Fi4xIqjLaRNG0S4khEVl3+b3TUrIOb8JfEJ7GYxJM4mElRZNNOmNPFF8vV4fqnJVV8KZFPJy6u8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789088312; c=relaxed/simple;
	bh=4drBGv6YyhxyX+VShit8G9MBohafzwBZaOD9UZFnRQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEOMhRXX5BY/mrTfkopgGLjr2jX8NT+5k/pKMNh/X6bPx+ob5VkOJkZMOppZg/A1CItcHhRyqaVtjXS0iWqygIZNSwIC7AGxU6wuubTxaLD8sNWDobHLh9FUOakMhewBhWk9dXuXq1DR78sPRMRHE25H+lluK4lib/0NmZBaKls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kw0wluWR; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kw0wluWR"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff390a6cso17515ad.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789088310; cv=none;
        d=google.com; s=arc-20260327;
        b=UXOG8mFEW4OmKPXuwi4dP9yJcqdp4yypD2zZwdESQHFm1dlNiX0XdPfO8fLQrXLNo3
         P5Fn4WX2fGCq47Ucz5o90p7MB/uTzvJYhnku9qq99xYmccbF6iXQAcROj9R9FPWTSTJO
         k4qHVtaXf7CnaejPiPYAkqs1YAB+VT0miUzpZwE4mTZRkrBluzKboGIXuR8SDIgJRybS
         i0VxeJO7r5LbwvXCe97s/ilORkArlPEIQT3werq0KsPtM/iDPK1p9LemZ+KKtqI4sTam
         i+qPFnJWWxOatAeuHqzSNLH38GvA7ZXViXHRvo9CuSswbINq0spk+a9c9niTNcDBD7RS
         tRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nMOObWcWSTTmBPNIJxB9A2ZkbRi5NCB7Xm1BYtKAyac=;
        fh=tbZNW/+yd/aYY4xXSCzHlSvxAezAtCerzA4AUpUnXZw=;
        b=Yqn/KHhszpchivCaX36pH4Xr0NIfMCpLUUw/sjn0ghcc57K1sQEo/gu7jUctrxjv6K
         8tHuabIDbIacdPsphypK9kT1CDy0ED57brtq4Ti3EQTctCV2Y4HlzXHAxPdInLBM/JNV
         JNGr/1iPU5rF15k+uToM/Td7I72LmUcTPuMYXzNmi25LwX3k5iwX/RBYaGYxoMdQ08yh
         KWJwjOQNGMJ8YuVdwniu8vaxbj1x/GgLxdCn7gXS1RcXBdejDzZvHWzoKjW/Kf6SLj0T
         hvn/H/YBkQ0FvhwqlQ4u7I8gBV31zFdhmfmxjUWuzKCatLBSuTgPCGx1F8q6ZwgvJ0R5
         jSRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789088310; x=1789693110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nMOObWcWSTTmBPNIJxB9A2ZkbRi5NCB7Xm1BYtKAyac=;
        b=Kw0wluWRedRrcMdEgZz1C7knjgl71xNhzL+jxjanDdyM3D7bOb+S26t01D7taZgTPU
         MQ2YH3d70/sl2e70XaiN6xocyXFTC/VsIioObNmqpSaaxSIW+E69a/DJuCR77GsilF+L
         XqRdSRtt3Ey5Nv+W0OBTSndKKZ4/cseeK/HULMHhPFYAXyEBiKGudu50KA0nvUgc3BTj
         0QNtoZVoFccm1VVOtosWf2+lPAzVzLtHzSF4aoRSmEvgNweAXgrNkO2K/OwPgip03OEk
         kHcC+qZe3q5E3h4s+AINILraJaQwkX+wbFr5wPAnwAKXGWOvSqTW3uYebqsKKpyQRTcA
         emkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789088310; x=1789693110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMOObWcWSTTmBPNIJxB9A2ZkbRi5NCB7Xm1BYtKAyac=;
        b=Z3l18d5JuywQlf9YDOB+avX9l5TKkTBQiBqkwShulAl8vbblUugd3DMdACRfvhxafO
         eUSvJNQjfFLOYoNt71MdYdv51kz+jjt3MEwiPC7AWRkjh4+tf8zW955Y7MeLj4TFyH7O
         qTu25r2RyGrLFf8QAE9M3QAtHBsWcDlmPtc/f4R5cdLH/1grAfTEamCRiVlqVre7eqgd
         z6ADK3ndz7K6O/Rxtu02EL5F2BN1m5FnbQYwMdgl21k/13PtysHiQ6RYEsFQwqvhYnb3
         Vrufmgd5b63KmIzpAXz5qz3hpOl/sx/KX0gWohHI43ks5HeMebrNwoJ9lviuK3xrh1O8
         z9PQ==
X-Gm-Message-State: AFuF++kAmgd531YxHukjixFIJlN8qULIxq+WefU6GBUKDZVJSEcww03u
	iBcimNl2dC3DZrm8dT/JtVkTXF/Y4IV8vRTZ5g0O29O24+R+vw4sJVJsv+iyp4fksGs6rkJ0J6K
	ZujrolIKvAuqbmqpOV/mmz4wr2RhKWbMux1EqCKxf
X-Gm-Gg: AYBFou18k8ZBYlS6pW/9meBtKnZYBadDZQU4C8wqy3/Nx1HvRMiSLWMkLjfrmSd3kpV
	7/1UMkuD1LU6srXkeQ6GC7569ADNx/KOU8p3fxHEOIfEO8Of6pnXXy6FPmegM1j/XXL6h/Iwcxr
	P/EXo/mVQs6rqXW0WbywxeAKzNco9ou/Crt9m1pM2W3VyUdzzq+uszfOQwiJgn5RWztiSYeyI7R
	MVM6OBbnRowULymeLcA/ABHZvwlY+uFqJLs4sWog2mpEwV6GawfbyNN7V/QNKiOTHkCcTFFfRyV
	E8BSOy7LONWyHR7kGh7jiNwyCcWXDpdfieK3eh6Y1AVPZ1iTZQ/aq5hO4bo2gQJwTGJYRgOE55i
	CK4NSpxD+y30YXPMPCVD3SYUPra2ELmH11Q==
X-Received: by 2002:a17:902:f686:b0:2db:a1c:be59 with SMTP id
 d9443c01a7336-2dd2f53925emr1750545ad.7.1789088309766; Thu, 10 Sep 2026
 17:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909191136.3811892-5-hramamurthy@google.com> <178907843138.219967.17268659724650641980@kernel.org>
In-Reply-To: <178907843138.219967.17268659724650641980@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 10 Sep 2026 17:58:18 -0700
X-Gm-Features: AcwNN1VDb-6nUoUNVsNwOs9BNQUF7tG5NDKWvlmE8TeyMwOHffTvadhBRirJUzo
Message-ID: <CAEAWyHf63MgBXY2UvdyUx4M=Kb_73rBmwD2rUBGfAk1XOFMPmQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 04/12] gve: introduce gve_adminq_get_device_properties()
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 3:13=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 0 (1) =C2=B7 Low: 1
>
> - [Low] gve_adminq_get_device_properties()
>   (drivers/net/ethernet/google/gve/gve_adminq.c:1148) bundles=E2=80=A6
>
> Pre-existing issues:
> - [Medium] gve_adminq_verify_driver_compatibility()
>   (drivers/net/ethernet/google/gve/gve_adminq.c:1264, moved verbatim=E2=
=80=A6
>
> --
>
> gve: introduce gve_adminq_get_device_properties()
>
> This adds gve_adminq_get_device_properties(), a helper that runs the
> VERIFY_DRIVER_COMPATIBILITY and DESCRIBE_DEVICE admin queue commands in
> sequence, and moves the driver-info allocation and fill-in from
> gve_main.c into gve_adminq_verify_driver_compatibility().  The commit
> message describes it as pure code movement with no functional change.
>
> No Link: tags present in the commit header.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net=
/ethernet/google/gve/gve_adminq.c
> > index 046155ae7d669..f420a8e1dd3df 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
>
> [ ... ]
>
> > @@ -1143,6 +1145,27 @@ int gve_adminq_describe_device(struct gve_priv *=
priv)
> >       return err;
> >  }
> >
> > +int gve_adminq_get_device_properties(struct gve_priv *priv)
> > +{
> > +     int err;
> > +
> > +     err =3D gve_adminq_verify_driver_compatibility(priv);
> > +     if (err) {
> > +             dev_err(&priv->pdev->dev,
> > +                     "Could not verify driver compatibility: err=3D%d\=
n", err);
> > +             return err;
> > +     }
> > +
> > +     /* Get the initial information we need from the device */
> > +     err =3D gve_adminq_describe_device(priv);
> > +     if (err) {
> > +             dev_err(&priv->pdev->dev,
> > +                     "Could not get device information: err=3D%d\n", e=
rr);
> > +             return err;
> > +     }
> > +     return 0;
> > +}
>
> [Severity: Low]
> Should this helper also carry the state handling that gve_init_priv()
> currently performs around the same two commands?
>
> gve_init_priv() in gve_main.c does this before calling
> gve_adminq_describe_device():
>
>         priv->num_registered_pages =3D 0;
>
>         if (skip_describe_device)
>                 goto setup_device;
>
>         device_info->queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
>         /* Get the initial information we need from the device */
>         err =3D gve_adminq_describe_device(priv);
>
> The queue_format reset matters because gve_adminq_describe_device()
> consumes the incoming value:
>
>         } else if (device_info->queue_format =3D=3D GVE_GQI_RDA_FORMAT) {
>                 dev_info(&priv->pdev->dev,
>                          "Driver is running with GQI RDA queue format.\n"=
);
>
> A caller that invokes gve_adminq_get_device_properties() with a stale
> non-zero device_info.queue_format would keep the previous format and end
> up with supported_features_mask left at 0, silently disabling jumbo
> frames, buffer sizes, modify-ring, flow steering, RSS and timestamps.
>
> For the record, this does not appear to be reachable anywhere: at this
> commit gve_adminq_get_device_properties() has no callers, only the
> prototype in gve_adminq.h and the definition, and gve_init_priv() still
> calls gve_adminq_describe_device() directly with the reset in place.  By
> the end of the series the concern is resolved rather than left latent:
> the single call site in gve_probe() does
>
>         priv->device_info.queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
>         err =3D gve_adminq_get_device_properties(priv);

Like the AI notes, when gve_adminq_get_device_properties() is actually
used later in the series, things are setup to run properly.
>
> skip_describe_device no longer exists in the driver, and
> priv->num_registered_pages =3D 0 has moved into gve_setup_device().  Woul=
d
> it be worth a note in the commit message that the surrounding state
> handling stays with the caller?
>
> > @@ -1205,20 +1228,53 @@ int gve_adminq_report_stats(struct gve_priv *pr=
iv, u64 stats_report_len,
> >       return gve_adminq_execute_cmd(priv, &cmd);
> >  }
> >
> > -int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
> > -                                        u64 driver_info_len,
> > -                                        dma_addr_t driver_info_addr)
> > +int gve_adminq_verify_driver_compatibility(struct gve_priv *priv)
> >  {
> > +     struct gve_driver_info *driver_info;
> >       union gve_adminq_command cmd;
> > +     dma_addr_t driver_info_bus;
> > +     int err;
> > +
> > +     driver_info =3D dma_alloc_coherent(&priv->pdev->dev,
> > +                                      sizeof(struct gve_driver_info),
> > +                                      &driver_info_bus, GFP_KERNEL);
> > +     if (!driver_info)
> > +             return -ENOMEM;
>
> [ ... ]
>
> > -     return gve_adminq_execute_cmd(priv, &cmd);
> > +     err =3D gve_adminq_execute_cmd(priv, &cmd);
> > +
> > +     /* It's ok if the device doesn't support this */
> > +     if (err =3D=3D -EOPNOTSUPP)
> > +             err =3D 0;
> > +
> > +     dma_free_coherent(&priv->pdev->dev,
> > +                       sizeof(struct gve_driver_info),
> > +                       driver_info, driver_info_bus);
> > +     return err;
> >  }
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but is it safe to hand
> driver_info back to the DMA allocator when the admin queue timed out?
>
> The identical sequence lived in gve_verify_driver_compatibility() in
> gve_main.c before the move, so this is only being relocated here.
>
> On the timeout path gve_adminq_kick_and_wait() has already rung the
> doorbell and gives up without quiescing the queue:
>
>         gve_adminq_kick_cmd(priv, head);
>         if (!gve_adminq_wait_for_cmd(priv, head)) {
>                 dev_err(&priv->pdev->dev, "AQ commands timed out, need to=
 reset AQ\n");
>                 priv->adminq_timeouts++;
>                 return -ENOTRECOVERABLE;
>         }
>
> The VERIFY_DRIVER_COMPATIBILITY descriptor still carries
> driver_info_bus, so after gve_adminq_execute_cmd() returns
> -ENOTRECOVERABLE the buffer is released while the device may still
> fetch it.  Can the NIC read driver_info after dma_free_coherent() has
> returned it to the allocator?

This is a non-issue. If there is a timeout and the device is not
responding, the driver resets the device and frees the AdminQ.
>
> The same unconditional-free-after-execute pattern is used by
> gve_adminq_register_page_list(), gve_adminq_execute_extended_cmd() and
> gve_adminq_describe_device(), so if this is worth addressing it looks
> like a separate change rather than something for this code movement.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260909191136.3811892-1-hramamurthy%40google.com
