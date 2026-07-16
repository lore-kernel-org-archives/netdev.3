Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A648539EF27
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196117; cv=pass; b=ms6ejKPCppQdZmGGBl9wwUVeXXVOg+vhU0005FTDxCZQVsa/PTTiB1BLdQLoRm3mdPyQVJ+T11hmIT8+aCMsTbYG0l4fh3rVrS58emD1BHF175AhcE78LTyWcwm5EC1a53RiXL0+hDItD0vxsoSpPyDaN5gWeUDD3iK7rhBPNLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196117; c=relaxed/simple;
	bh=4J+LRl1E31ETdtySJs91tQOjUybYz/e/7NrIdVDeAbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMDZ4yUJV4+LYXh8NHopqs2Joq2mqiTpeLr/qpBSiCNZZGYMyfNBbFDo5d+HUJg2FdrIYBi5kEmUKwOINgKVPW+5XxJVFIM2dfmry/dhZBkBB59jASWJduD2qQT9TrNGcoCuAjJWQPoorVMXvWZ9A85s8HZlPPUP7hEhnQWLbrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AtLmSLiS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkCfhEgi; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtLmSLiS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkCfhEgi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784196113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kte+O5lQxSAWFzdWKKSzuAvAp1/LhbKZS7adJyPOIok=;
	b=AtLmSLiSBfTA3Ojh2HsjnDHOfApmvP7u8zfKbHbWC3wIwtaaKZUbRhW5ubSA0jq0408wJl
	6AV7u1uE8JB5qb0aVeqxi3cEeDLDcQShDZGl/Lvc3gZF+kQbWrabNmytDLsSIE7P3uKPZP
	F56HL5Vxgx0xgFU6DWWqothCf/NlU9U=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-p7Hw_0iMOxWhySufVQ_cqA-1; Thu, 16 Jul 2026 06:01:52 -0400
X-MC-Unique: p7Hw_0iMOxWhySufVQ_cqA-1
X-Mimecast-MFC-AGG-ID: p7Hw_0iMOxWhySufVQ_cqA_1784196112
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81e735bcceaso62504717b3.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 03:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784196111; cv=none;
        d=google.com; s=arc-20260327;
        b=OEnqCLI3usGJCv2rISls0AYr3jyIgO6+8sbuRCgjBLnr3Pbt0a8cFBfvXMfScY57yK
         bJqEay9YPnnpWnl7L2ZROLtiIys2EBcQ6PMrqRC2Z0aQoGdbvLT3qtA2bWl2zJlrqaQS
         NItUmlsXp+oiwN0XIkfCeZUIkOxcQsL4ouZMNNknccKQVqwVtH6xfoDZvPEcFSW876ta
         SKb2iySNZycKcTATVJg0CcojTs7RS4Ch2/80QGq/eSbz3ipekiDJBgbHCTWstAWWquI5
         wDJHeYqZ+tgMQjVkpCjaOTGjBPtXVzNJQKAkvulfTX2PgrlZwwdT6+sQ7mVs3b3p7XFJ
         Bvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kte+O5lQxSAWFzdWKKSzuAvAp1/LhbKZS7adJyPOIok=;
        fh=BlE6kakFDXN5B9S4Vu7yJTE4e4qOSMOHdKIA+VRLmcE=;
        b=GTtNEgJKEIqUWMejAdVzi2qi2H1y5CVc1agFbfSwFQXiyFPQqgKfNa9NZFkF95cktC
         VENubDFbn/pKcWKjaxFZU3ARECkNRI3mBKxxrtfQDJaGZSTUm4kHo0tAFij8tasjfMH3
         QPSd+zPu2/mRH14sMDzNI076qKQNuHrcWvsXrOEb6b56k0qkUYhFSaOtTjqH0HpG2GcU
         dRKV9qGOUwPID8HWvMzT9E4cYcvGy/0/KalEKvhudQ4r3poCobWNl82BH0KIxJ3gpDDP
         obH8b3/pobUjkAIqT0LuPIrbexukfIXLVNenT5wHTLMjrLnkyD65kziyV/E0OfFrJYGv
         39Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784196111; x=1784800911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kte+O5lQxSAWFzdWKKSzuAvAp1/LhbKZS7adJyPOIok=;
        b=PkCfhEgizwycGdLUuyPL2Bz45cHVLtpUIDjBBHHB312XfSAc/luYvF9ha8e8tC9ym3
         zQHcLn13heIi3PDcarAAQlSTytX5WipioEihVr88TKoXBxCiM6oGqr/xv3i/Q8T+AZgO
         WAsiTVl5zsDNvRgM5mszPBYKEG7FvtVn/PuI2j9pT8OtYuiEUvUYyseko4bWswQffod0
         qNXPOWPA1tSBzRXZfGA7Ts+7PwmeI7yZUMq7tqHfWYdALPRy+6sXlBf5GUJ1Qkk7zRaN
         97Pq0pIf8OeC1zud9n5jPAJOBiU5xsXE0xzb5oPz/QNLv/GfvmDM9YRL+7shMLO8utzY
         WB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784196111; x=1784800911;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kte+O5lQxSAWFzdWKKSzuAvAp1/LhbKZS7adJyPOIok=;
        b=Ipe4oVhOQvcqmVrvPK675ZbQnmVz05Vbz8HtOhqf/01jxosAEHfU3qzeZ4t41xKURw
         absoHAcNaHuaQD8gaeHDZ4bpPUYq+rdq2D0jxmownAYqF+grnkbt8qIJBIY15wIb/HTF
         jfW4MwmJnY7j3GTChLxV8KEmTDBmh/I4/JDjf1iEn5S6jbrr2mFufMExZGAFMFO5Ggmu
         q/2aKGW8et/FPKTnn/X3Be0O1WE3K8cJ2/Bm1r4NudsTYki3OWbNU1hhpiTvBWovc/3D
         sVrNMIhRlUxL1wpUk4E9FqT5wd4DV+D/Wa4ZJQjwyoVS6+2D7D3JA9NEPpjfH9w7GO2W
         klSg==
X-Forwarded-Encrypted: i=1; AHgh+RrKRiaCFqFuhWEqFESjK0YVbFF5fIluTHwYziqU/sVJN5bpGXraJ9ctbrBZpccGsNA8nkjRR5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIMKN3XEiST3cHrQEWuuhPAr8fO8QOq9i/DrhOv1E/vAE+hP3
	mV7/Rj6CvCyJSQ3zGr1cy7Hdo13ePyvSBgN1+EwnTIgxZDQnoGciTsV6WdBwykXaivLo4RQc2J3
	Ee8gPaOTekH32EGIL/s3WYtbpNvDmW2cgxcMOEl4wfHz7z7Fo80+JtF7S9/ZnBJtBbYFcUxWUxc
	S52zglqS7GEawEnu9pwoFWCMfX1FahqXVcEa0fXeVb
X-Gm-Gg: AfdE7ckqyXE6SMlLfTB8XatHXXKqxIJYmoEvxPc5sXvQ0VXyKm7HEC/DsOH5xa3kMRh
	ZBcM291FliDgdS5FythaHv4Xu+jM5iP/HpZMWTVzV9WKNmlS6PlgQGIMMj45dq/Ys7phGb1YVT2
	Iuw5gVnNUSp4r/nbrAdY4UrdEZKzMfo+I4OhJL1fiD9rCO1N9TvXny5Eteb8Zg6WDc7O9XFT6C6
	eKBI0KGqV+69a9fnrB81ce/0ArHLFmOwmi7d+g2+kWiWlGoyKMAJMOu3Dm8aRprCdPb/FWjXbzo
	+z8remXHgi/BltQ=
X-Received: by 2002:a05:690c:e212:20b0:81e:c5ba:b052 with SMTP id 00721157ae682-81ec5bab97emr51788247b3.39.1784196111561;
        Thu, 16 Jul 2026 03:01:51 -0700 (PDT)
X-Received: by 2002:a05:690c:e212:20b0:81e:c5ba:b052 with SMTP id
 00721157ae682-81ec5bab97emr51787967b3.39.1784196111105; Thu, 16 Jul 2026
 03:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716030242.124455-1-xiongwm2026@163.com>
In-Reply-To: <20260716030242.124455-1-xiongwm2026@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Jul 2026 12:01:14 +0200
X-Gm-Features: AUfX_mx1UNEXbgfju8J4YPpG9wOazGi-4uMhtWJ0TvC5HjB07XmtqFhXc3IuHh0
Message-ID: <CAJaqyWeNJwVNUihL8MAEH+-a5OsoaDGsgaPnP0BqQd6YH4ZhYg@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: propagate set_map error to caller
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
> The return value of ops->set_map() is currently ignored when handling
> VHOST_IOTLB_BATCH_END. If the backend fails to program the IOTLB,
> the VMM incorrectly believes the operation succeeded and may continue
> with stale or incorrect mappings.
>
> Save and propagate the error from ops->set_map() in BATCH_END.
>
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> ---
>  drivers/vhost/vdpa.c | 6 +++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bb96b1aa5..ffbb10a92 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1297,8 +1297,10 @@ static int vhost_vdpa_process_iotlb_msg(struct vho=
st_dev *dev, u32 asid,
>                 v->in_batch =3D true;
>                 break;
>         case VHOST_IOTLB_BATCH_END:
> -               if (v->in_batch && ops->set_map)
> -                       ops->set_map(vdpa, asid, iotlb);
> +               if (v->in_batch && ops->set_map) {
> +                       r =3D ops->set_map(vdpa, asid, iotlb);
> +                       break;
> +               }
>                 v->in_batch =3D false;

Maybe this needs to be discussed, but v->in_batch should be set to
false even in failure case.

>                 break;
>         default:
> --
> 2.39.3
>

