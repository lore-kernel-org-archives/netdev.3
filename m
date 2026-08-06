Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971FA47F785
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048139; cv=pass; b=SiX7Za7oKZU/eeDz94QlWRC3M7K+tNVLY0mWhTaB9jOBkPp6kXqObVnkROsLJzRzNad5i0/q+ZeEnpCeLRs1AA7isOfp08YLsyfLaKFIRqQvXm9LkP3O2cYpQEj///ddUOW0xLOlqn0UZD3HFe20gviriYofxj731k3ncuJfjYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048139; c=relaxed/simple;
	bh=e+OVLcYmfJKSaX9v0jthduZBCfvXxQCz4XexYnsjGgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FV8Fgf0U16VqM8Fp9xG/EjtkAgp1j2knt+cNVrUemTNCncdFiJ/DpA3EImExzaYEb3N4m2+OmYwoDp+JgDVCFrBGRodSpqCZ8pZnUg+/Xlv2LWeqywViZ9GM5WArbGZ20OQFsf97OoVxjexYC0b9xTnwe5UaKXFizcwzgFdj1R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKw4yOg2; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKw4yOg2"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccdf36f63dso35565ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 13:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786048135; cv=none;
        d=google.com; s=arc-20260327;
        b=lUHWtJPp3/Kv0Pv+kqXyacs2IHzXSqo/1f0/JMO0W40i+rxXaYoQwRNL8Hb235sFuG
         Ibw1jDGCQ9EhJH5GSYjMFOZPnpbclWHHImm57AdEQKenVxKXPijV8PCe5hToC0A4flo9
         QrazY3ZPiL2DDso9rY4Rg7AhdOtioxNG8IcUbqkiMnUMnjBFWTMhT1lNFLh88q1KFYGF
         6E55fHp248B5WK/9zVgLmQRWeiVEXDeva4y1GWczmLM36U6nvneB6keI4JX+xNmDsqL0
         7dZL7o69aj4Ks6wNPdsTuX1+z4DXgUJdU+eAokcNA9exhcmswPQoDWD9NhZtxuT2b609
         cvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0ii6rT4/dBxviSRNantJXQAi0R6n4bfb+K27oBpIuTs=;
        fh=lIN5V9TeB1//R6pMvhxrvs6kPIonMqbNtoyTX1KBWWA=;
        b=DgVema4x+QCokTgGUYUuqISTup6uWzaoBSEElKsM1SHE0PqkECDS8AKe5ZKyFb0nLb
         SFyCB+DAbtMOiJz04KZ+d2GxUWpkUdYQPJHEYckT9F3bzRaoxElHn0mggwcvfwOJxlld
         QYuB+dDuDCEDo0ZQG1vqMKjVIdlxw1tfggCl3iB2CKWMMKvBMA5KuiqhhflLY//i4Lvw
         InyOFwfJhFS36FC46CkHThXUl8mT0Yvrjx6R+6tOnREmqtwsqywrmC8iHDHczIsxZCFs
         2vj65yE78d3q8lHBs0krW5vXNh03p+2vFytgwUPfADfBzHBIY97ZPNJ9tTlnAFmh2dmo
         cB4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786048135; x=1786652935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0ii6rT4/dBxviSRNantJXQAi0R6n4bfb+K27oBpIuTs=;
        b=iKw4yOg2leaa8g7n3VE46ERjs8RtO5vYJ6lrwezSlvDEysJBDNWATIp30lBjWnK6IZ
         +IZMr1YiTspNEjnPKq2FvMcJi4xY1FVh7BK+c2+B+G8Oq2VCyIqo5HSTTYaCYnBKNmsa
         I9LlujjhhEIt9G/h2oK7lQ05gV+L9v1qvfenz+hCZ4GTzvsZk68ShnlpYPP+1HfOmcNG
         RvvepqmmAbHjqgul9nrHfH5PtAu+4s9214MRC/eHwN7QBLp0GRv2AJea654ilTlpcfyf
         IzPlV9qe3PnAGKxb0B6KKLr2akfD2cp9NwU4xyi2q6yiRCGRRfS1dLnYJP/YYdaS0UEC
         qwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786048135; x=1786652935;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ii6rT4/dBxviSRNantJXQAi0R6n4bfb+K27oBpIuTs=;
        b=rd7iqyKcIO2cNGfZztLoydrJVe+5fBA8dBUhSGaaFECy6rFCb380+x6OFRJKsfyLHc
         yO7CqgpLTWyDh54R0gL1OohdR+YqJjqu5kLa66SeAA1McjlMypjhs0CL6g0fP2hb3OXB
         7IY+lZz9FZK2mlNj+dkTaV4AASBPTBUDqqmvUmm3ZWtH2eMpQW9b9iGVhBxa4aBJtvyH
         n05UOoO01Ub75/Z7GE0zdVEBfrOusSQtNrJLU+R7bseJ1BBjF+Rg3XH76+eox7p/lII7
         eRkjzRk0JPNleF5J6m0OUuLWPQMK199PsXNpMVbwsf7EQTTePzS054xtmXzXQFJdiDno
         oOXQ==
X-Gm-Message-State: AOJu0YzAsM+rj4uTwawQGaJyysqAfMIqRqBj4zA+faZ+ZERZtGHfjWm2
	l7J3ysXfijowFxPFHsvZoROaCkvyAhGzhg0oyIOitY9aS37MwdF2S2oVNW9HOv3B4OVh3pvHLJA
	99PLzKQMIOPuT202Al0itjK/uJ4N3R2Cd90sj8EaNor0F7qYEc3cngK2Yo8A=
X-Gm-Gg: AR+sD13flNhFsmH+sN9dvsRfO2JorkThu6c+99lqwKQv15ovo8dSqe0jT9+Sn7ZQARd
	X+lhlV20C+zmOKMPwqMW42W7Vf1ZAIeiPeEuFky1xj7GOiAlybK8NaoYZuXAMQAW9ne0HcLFgKl
	4Ab2jQXXjOb1SPPtY9TNvAubWLSLwy4c0tjVYKJZ57VGOfW0d9Dc/lCncThO/Lr46/NnMMQACZg
	zAuDseuHbL7xY5QrhVFWGSZaViQo6U9YPOItN3z+LGk4+KkhwKuTzcw86lNfKJ6nk8jN2+C5Ch3
	aK+1L+t7SNrMa5cJuQFDu885nyCoKB3+RDxU/LbpxjZgY48OXws+i5Ahefx5+/Gzp8oheXy8kA2
	04g8bybEIIBEmkff8DHkVH5L2U5Sre0eMG0ZC3uzIgdE=
X-Received: by 2002:a17:902:ef0f:b0:2bf:1000:d3ac with SMTP id
 d9443c01a7336-2d1204cb838mr2156335ad.11.1786048134930; Thu, 06 Aug 2026
 13:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806085112.385934-1-renich@woralelandia.com>
In-Reply-To: <20260806085112.385934-1-renich@woralelandia.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 6 Aug 2026 13:28:43 -0700
X-Gm-Features: AUfX_mwkk-lOepwDdeZynuOmB7zUfWqM-Nk7TO_Se3F_z9LAUz7m3WLmnp31ljA
Message-ID: <CAEAWyHe9FCTpu3qhrqjVP8chdMpekB_+1Th0jdZ6OeR1fb4Z2w@mail.gmail.com>
Subject: Re: [PATCH net] gve: use gve_schedule_reset() on AdminQ flow rule timeout
To: =?UTF-8?B?UsOpbmljaCBCb24gxIZpcmnEhw==?= <renich@evalinux.com>
Cc: netdev@vger.kernel.org, Joshua Washington <joshwash@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	=?UTF-8?B?UsOpbmljaCBCb24gxIZpcmnEhw==?= <renich@woralelandia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 1:51=E2=80=AFAM R=C3=A9nich Bon =C4=86iri=C4=87 <ren=
ich@evalinux.com> wrote:
>
> When an AdminQ command to configure a flow rule times out in
> gve_adminq_configure_flow_rule(), the driver currently calls
> gve_reset(priv, true) synchronously.
>
> When flow rule configuration is invoked under netlink or ethtool
> callbacks, gve_reset() attempts to acquire rtnl_lock while already
> executing within an inner driver lock context. This violates the driver's
> lock hierarchy and causes an AB-BA circular lock inversion deadlock.
>
> Resolve this lock inversion by replacing synchronous gve_reset() with
> gve_schedule_reset(). This defers reset execution safely to
> gve_service_task out-of-band under the proper lock ordering.
>
> Fixes: 8ffade77b633 ("gve: Flow steering trigger reset only for timeout e=
rror")
> Link: https://github.com/GoogleCloudPlatform/compute-virtual-ethernet-lin=
ux/issues/93

Hi Renich,

Did you encounter this issue on the upstream net kernel? Because the
Github issue you have linked is referencing the CentOS Stream 10
kernel version 6.12.0-248.el10.x86_64. We scanned our backend within
Google to see if this reset causing error is encountered on VMs and we
did not see such an occurrence, at least recently. If you ran into
this on a non-upstream kernel, would be great if you could provide
more information on the Github issue or file a support ticket so we
could look into it off the mailing list.

If you did hit this issue on an upstream kernel, could you also please
provide a splat here?

Thanks,
Harshitha

> Signed-off-by: R=C3=A9nich Bon =C4=86iri=C4=87 <renich@woralelandia.com>
> ---
>  drivers/net/ethernet/google/gve/gve_adminq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 08587bf12345..2037b1767890 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1322,7 +1322,7 @@ gve_adminq_configure_flow_rule(struct gve_priv *pri=
v,
>
>         if (err =3D=3D -ETIME) {
>                 dev_err(&priv->pdev->dev, "Timeout to configure the flow =
rule, trigger reset");
> -               gve_reset(priv, true);
> +               gve_schedule_reset(priv);
>         } else if (!err) {
>                 priv->flow_rules_cache.rules_cache_synced =3D false;
>         }
> --
> 2.45.2
