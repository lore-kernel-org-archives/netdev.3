Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338B93B3C17
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469162; cv=pass; b=gfOsmUC8JloctQmfzKtCYss/7cZ14lC4mcL/JQOKSA1dZ7Jb7yoOXkglg0QL0rIb/JZXr+/uk+HFXz2hDH2BA/PXfzf4KHSaMJHwOGUwFdIYSyU+0CZZP3y8AQQML9EWzTAOXqPjvAPRa3GM+paGrjhRTsAEAoZ9/GwLVZOI6Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469162; c=relaxed/simple;
	bh=z3p62sv8iuyO382QUxDR5nSCmlxpeKqu16eEfm0/Sm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leYTmI40qZBTOAK81GKI7ikKZoMDE5c/Ep1GSxJUCGlI6NThMwWSDkUFMZSLpWvNGdUn91xJMOZotxJdMYgXDfIEBDZT/01rplORPwuq3zRWfHMlqB2yeJGfihFizRftRmIRVRiOx0j3dL1Bo9Lz+uG1nkCSKL5Y7POWgEuUhms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kot+6o1d; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kot+6o1d"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cacef7d299so5825ad.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 10:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786469160; cv=none;
        d=google.com; s=arc-20260327;
        b=imEp6AlElyLbMSw42TV/XztKbqBH0N4WX17Ln6d1Y3tSC2hoAzR+2FfhTU/cAEtky+
         i3nMZJv9GC4qTLsLwxBIOfoHHXV2SXB7gxWgySvN98+zIOnaaeqQU5M8NFpk+f0OTv7G
         SB9PTwEvNercmlSxH92SK/1otLCG9N/Fxka3/hJbSp9yxMW3ShsVgjxXnKJFuXgGPl0c
         UeXMMefJmjzbzlJ9qBN6lZt8Hiv5n/nG9zp/IJPZEIz6SJe9KbZbmnu+eVtTJLJBGS+8
         CiFaIfNinaGG1TboEK0KHFlqAOnnFUl611l+UKYP2533kOvw3/V5jNH9upb9Vnv9Rs62
         5b9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VQxqTVTvnKCPFdyBQjMkdm7NzasgJgC6YzkMYe1Piqo=;
        fh=wM4yZON0x8MN2uWcqZlvj9pgi1+5crKDWXeq4a2Bh3E=;
        b=MXct6TFEblvtcmWiaOudzolrrpLKYE4kzitm7AmIUIsci0nzQdTmehV5rj5YRA1JhC
         zxTEugLEN4wiPxOq23ZUsba4q8ruhw0tyUokvlh89rv/vkIGAftU45VTlNXOpW7gIs0k
         eCrb59/XkrYsPhVZnAqh0jgZaITJ8zhDMyQmmR0qQb+5lqkv4myE/Lvy0XCeA3sYAA7x
         563v1YW7kh5x/gZiFcDJgMUrA84EcF44RBZWbK05JJVsls5xEP09YdlTGStVTyr5zuE+
         /VcyzMbp2039I5+0ypERnAdA35wu5SyzeN7lC4OFsSP7JF6SywLnriQbzGlnzNTiWUF8
         7AIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786469160; x=1787073960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VQxqTVTvnKCPFdyBQjMkdm7NzasgJgC6YzkMYe1Piqo=;
        b=Kot+6o1dt2nGcxJyj3IpV4lNSznlskmzaufrwgkeNpu74hj7Js2g5L/S8ki5YtOjJP
         6+M/1J85vLAxhgWdWjZ4F0GijB4XQVPwfBxJRFipFGsdmsAWL1i85Q0fAkEzpjYAIXxF
         I4JXxYsx67URKC6DZT04IDOYmgeLF2yzhi/V2+p0yV7Xd5MMI3kHEycnsunvNyTpoVL6
         g7bFwp43revgGb/OXmGpyM4MoxBlgVcnFWlznWfOT4okhoS7C1MYNuyTikuuLDu14ZLP
         0zrxvP65jSW5zHZ2j/ol4I396k2PrApcOFezJIyHYj38nJcAjk96EWMhdO65BGgETUvY
         bd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786469160; x=1787073960;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQxqTVTvnKCPFdyBQjMkdm7NzasgJgC6YzkMYe1Piqo=;
        b=NGidwySFLKGXNV1Ygtbd+1TTfapK/kfin30OEdZO2olqyFdU9oInv3PaDBenaM5p3L
         a0b7i0R8qLN9gCL65Nkysy2FRCHaQL3UvdZDaSuxduER2kAywbHqzO1kZMjC6yEjo3ap
         zinA5GX2g7U1kKxkhHA42edHiOCQObv4yhI68RLufOrlf1vzy3xWDObo0Lz6zcVSIl1y
         lmvn5U2FFQXmZwXhDVYZaLueUiUMKb+7Y1nnNSq6AEaBpYnjpA4VuZ6hq2ljsY8vN1Tk
         QokDXY+3SsIS8SBq+Cb21d4DcsKRUyAo+AiV9QPJSMt2zVgH7lZZzf9Uei3v1oiPy3hK
         sHbQ==
X-Forwarded-Encrypted: i=1; AHgh+RreLNX+kFWxL+RH8Olc8Um9/tAHBqHjW7am6rUczSnaEQ/+18iR2KkhacvPArwYlrZKQwnoWoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVlmnGay0Kc/YmgFlouqHlyIzpk3XOXTVacPYJCmSjxVWQRfvh
	V7jrpIbG/Ut0Ux3MSVzDZuwaNwCY96iqhHHv6T0i60KXtTqFocnfi8FXnQ9gM2SOnW/OVW+gKrY
	XVgKwFEo5GvS7JgjDsX98zJgGwdcDJ6IizS2wTpWf
X-Gm-Gg: AR+sD10pOliVulhp5nECSULyivpNz2qptIdgLpWs8Pz2WY3H91uMe3Ht+4ipyI+ySh/
	dCGDK4J7+gM1YeuFJ9IPjqy6kyTd/jJkwqLGFWaUNa4Ua0a81oV8KgQlDjMOEe4CrhrSVGURv1U
	t3rig54RRgaUTSlxDfMGpzXIL8N4+qMZjVTruWlQ2EGNRF10b7qEvRU+ySRQZJ9QZ195izlf4o3
	bIP8u+XPlWGRULeWWe1TZgIsUVsHEVIM2R2mwJaqU3BBtQM3gefEI+4DxqPG+eWZZrL+dLJ23xL
	LDSoL/V5vz0DqtmZmA4NKnCz6xj6A+rnqwbPaDGQ2gz0W6CzFI7XZXzb7kzFp+ntcH6wrlh2VvK
	NvQLL0VPIFQ==
X-Received: by 2002:a17:902:ce0c:b0:2d3:153d:acae with SMTP id
 d9443c01a7336-2d33a3fa139mr647685ad.0.1786469159791; Tue, 11 Aug 2026
 10:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810175446.3945358-2-dtatulea@nvidia.com>
In-Reply-To: <20260810175446.3945358-2-dtatulea@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Aug 2026 10:25:43 -0700
X-Gm-Features: AUfX_mzzTPG3fXKSIJoOjl_90bMZJP1JVoiyE14MyuZ1YtTMTYvQDg5G333NaXc
Message-ID: <CAHS8izNLCCcxQwH3oYL1ch+UDf0Ok_LF0KuyJtA_S+daFye1mQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: devmem: add netdev_has_dmabuf_binding() helper
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	tariqt@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 1:59=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Currently there is no way to check if there is a dmabuf bound on a TX
> queue. RX side has netif_rxq_has_unreadable_mp() which gives a hint of
> it.
>
> To help with that, this patch add a helper to check whether a devmem
> dmabuf binding is active on a given netdev, optionally filtered by the
> DMA device the dmabuf was mapped against.
>
> This API is necessary for the upcoming support of data direct in mlx5e
> to allow blocking accidental swapping of DMA devices while devmem is acti=
ve.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  include/net/netmem.h | 19 +++++++++++++++++++
>  net/core/devmem.c    | 20 ++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index bccacd21b6c3..0e332e04ea16 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -363,16 +363,35 @@ static inline unsigned long netmem_get_dma_addr(net=
mem_ref netmem)
>         return netmem_to_nmdesc(netmem)->dma_addr;
>  }
>
> +struct net_device;
> +
>  #if defined(CONFIG_NET_DEVMEM)
>  static inline bool net_is_devmem_iov(const struct net_iov *niov)
>  {
>         return niov->type =3D=3D NET_IOV_DMABUF;
>  }
> +
> +/**
> + * netdev_has_dmabuf_binding - is there a dmabuf binding for a
> + * given @dev and @dma_dev
> + *
> + * @dev: netdev to check bindings
> + * @dma_dev: dma device to check, when NULL it will not be checked
> + *
> + * Return: true if a binding is found under @dev and possibily @dma_dev
> + */
> +bool netdev_has_dmabuf_binding(struct net_device *dev, struct device *dm=
a_dev);
>  #else
>  static inline bool net_is_devmem_iov(const struct net_iov *niov)
>  {
>         return false;
>  }
> +
> +static inline bool netdev_has_dmabuf_binding(struct net_device *dev,
> +                                            struct device *dma_dev)
> +{
> +       return false;
> +}
>  #endif
>
>  void __get_netmem(netmem_ref netmem);
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 957d6b96216b..f13a0e343684 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -364,6 +364,26 @@ struct net_devmem_dmabuf_binding *net_devmem_lookup_=
dmabuf(u32 id)
>         return binding;
>  }
>
> +bool netdev_has_dmabuf_binding(struct net_device *dev, struct device *dm=
a_dev)
> +{
> +       struct net_devmem_dmabuf_binding *binding;
> +       unsigned long id;
> +       bool found =3D false;
> +
> +       rcu_read_lock();

Why do you need rcu locking? I thought xarrays handle concurrency
inside their helpers.


--=20
Thanks,
Mina
