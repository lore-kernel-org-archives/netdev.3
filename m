Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2A6340281
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789423097; cv=pass; b=joFD2Zv/0dDPdOf0ggUbA0Puy+10EIoxGx2UhaXgee1aqRjO4fOkWTV/5z9gnOIDeMfDuEkA9qThra/iiFwlXmtxg22BVm9Sc9Gdk94Zm7FL6q1syxHLtfLHPV0BeiH/p+LF5luZQfTYpEwp+MNRpY3Q0NXSjWc1PIyqId2Dv50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789423097; c=relaxed/simple;
	bh=2oucmxVLZzpsHl2bsclPjBym6RGzyC0ruoTEA/sa9F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzrfmOzr3OREFrsKU3A1Emg7EdHYXc4OXxGI1QDW2UwR7YK9q0l8q6zhBbiWEcs72uJQHFkhjekmFXNTwM+alk7nTJaQtZ9P8UGDmg59mKy7rh9MovzFsK7RLSrJ4SV4inflAQ9pFCMPsr7hkHblGiiMEX0vbkR1v7kAMSDjuss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZORgcYuL; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZORgcYuL"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a613a6bcd8so624a12.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:58:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789423093; cv=none;
        d=google.com; s=arc-20260327;
        b=OH2DAo7ylYF6tzrkF6cmUQ4XhkR10I7HpyPcpJxK8Rl21/ouLlxlj9K2SS1Kwnqels
         66mtm1cDewEmfxZtHQsls9l3Na7ZHAr8GTSV0rbLcNof6JBS2ikklZA4KQsDiutPBc0i
         LZURd1eofi8I1fVbjS8lCZzoSwhQAS0dwNmq1/Eb67mVGzMEUAbWttyp3elIA4co7bT6
         MqUKXWJOwPq2/rkhAvH6K99YZkTZtd/Quj9lf8gT3W9OZlfFpg6GxuCjbTloP95FJ8cX
         BjKqHFYO2trUCDTZRJeXWsCWngUybziU9qPRlwNqo+eSuDl/NHjM8AGTqAz9KU7QmaXI
         oFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GBcZvsPwFZfbhRFR+qKliCsigQ1sOEsYBMsUSsjWMHo=;
        fh=jvNLtrBCCzuJ8z3sPmd5VEUHlzTO9IU6T5DMEjOkDXI=;
        b=ZWz3BOU53ty2w4dnBjVDC4lLYaSfJcYTUZPbzIP+giA0hw7IOeqBHOLxBDatwYuEit
         NnzuIM66v1I4rOLla+CwU3WVqRlvFxks+d9aCcXMlcqQuvJdPMeSfDmmvO0l9fEo/wtc
         7YAI6Ysxjxwt9wqbWs6+ec7v32aNI4HILhMCx1MXuiSTqeb4wpt3JJQpip8G2YnmTtKq
         joxetdyaLm2xnjoW49ysu2S/DlnUMRor+GcCzEBZb40Vs3ouo+aEMrc7CoJdt/yvM0bR
         2w4SIktRuXC3h7nXdypZSGHfCGde/U+jfjq3D3sx5a4YRFCuKTXjZjGFs/G3f58xfEq6
         CFAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789423093; x=1790027893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GBcZvsPwFZfbhRFR+qKliCsigQ1sOEsYBMsUSsjWMHo=;
        b=ZORgcYuLNvNKXCEhnZfOKd6D7GpPOg5whryg4OtY/+RutO2b+NQGqoq+atw+x9mRi1
         ZaViyaw1WRZpjPBNUturDGpRZ9RJKDySZwN/kKx2RgKj6JtqbKSpAKEzyhRG52RZJUqy
         6zIC7oKd0HUlXkX5gzbpiosGpXZ2pjivGmoHfENg13FVIgJHd/Z5i4epnf/xQ4zXSi+r
         5V+OUW5Rp1q2lh9+6Lp8WI2lwE6TP1FuygGY3RCbd+ePZwjdiV/1RuBzsnybTOhJOmmV
         y/yTxyEGi0ZF2adtrie/UuKHCfQkbwA5B+YSRm8lUx9tEUKm2HdcfyIM6k5syHCzefpR
         9GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789423093; x=1790027893;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GBcZvsPwFZfbhRFR+qKliCsigQ1sOEsYBMsUSsjWMHo=;
        b=uWBFzIOgvno2ruKqP7AFE/kH3GcH5OknN6z28/MXOVrMIGj0tHnVdySVY7Vl3aoTgT
         UqrtSmjtI1q/hO2gGWVCAPj8akRBtqF58MWONAdcoSsDMrSh2BnZPG5MY1DaVhGw5+Db
         qZOBDW+5Mw3w3+XfOv4mGXwu/OWi5d7EQhEhzSZsV+VV8YgJr/W14VdtJGziLQuzFv3v
         cM1ij8vn/XOD5yjYrR9gHgOyvFMmToxKgJX944JiDl+VtwXbB4H1CnUBDH1If0yBsKDk
         p1TXrCo5anD3wTIXdjpG2X9UKSzrxP1Lh8OHaBRj32YcgEO/NH1wPfOE6oeoDvt4ygoq
         fGMw==
X-Gm-Message-State: AFuF++m28RIhb4dYGEPzYBId9qPJgJvxKvyS9c8P+FzCiL8jnLwCbEgs
	hDcXxMLC0wPDrzHEcxqHTNaXx/O+M4TJ6aiFjQKRkJKCtOhonuyQqo9MSX50VQUgRj6ks1fjYwq
	Fb0pvUQKnRnCxYwQnOT0NKuBsywv0hNWXmW0eyle1
X-Gm-Gg: AYBFou2+EJiHlHhA5urz7/gwAhZIx6MzJlWnZE8EDdbvrT3sXgaWBdB2OjaNhzfTVFV
	7kUP/EMcmNR+YwIBoKdDojPRzbOXsVRciitvFHL9vziDqRq/ZERcLXo5ncD8UgWPz3srFqanSBH
	B9sGw/eQuDhaYVkO8G9KtlqB4VXLJfAjK0+RQWuvTY4+unv7pyeM2Mc+506fwwEOerSqfllQM6s
	GTMAdWZOFOjT1HO8NSuUJYBDN1R6Yeq1VsUIigoc8XrCOzE7vK+JvhweMkiyKVsE2RODN4JTTIM
	GUL/jLhDzAei4hV3eD0Kn8DwD3KyOB+EhB/SMVVXbEaGjZMhFZrZQ8vopZQdPWZwoBTpMXARV7J
	ZdoAZQgzAjzY=
X-Received: by 2002:aa7:c38f:0:b0:6a7:453c:a166 with SMTP id
 4fb4d7f45d1cf-6aa0749c8f5mr8562a12.1.1789423092200; Mon, 14 Sep 2026 14:58:12
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911154555.739041-1-sdf@fomichev.me> <20260911154555.739041-4-sdf@fomichev.me>
In-Reply-To: <20260911154555.739041-4-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 14 Sep 2026 14:58:00 -0700
X-Gm-Features: AcwNN1U59Zp0E6Rk1J11A4UKHaujiQuHE68JQWx3v-cvFCDxZxawq-kyicBT7r0
Message-ID: <CAHS8izOSaXtZy98UB2ye4-+59JujNb+SyBp+EO=YjnDvYLr85A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: devmem: batch net_iov allocations
 into the page_pool cache
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	bobbyeshleman@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 8:46=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> Rename net_devmem_alloc_dmabuf() into net_devmem_alloc_dmabuf_bulk() and
> make it refill page pool with up to PP_ALLOC_CACHE_REFILL NIOVs,
> similar to io_pp_zc_alloc_netmems(). That should amortize recently
> introduced freelist_lock.
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  net/core/devmem.c | 59 +++++++++++++++++++++++++++++------------------
>  net/core/devmem.h |  8 -------
>  2 files changed, 37 insertions(+), 30 deletions(-)
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 7949f8425bcd..a0dcc896dd12 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -58,25 +58,25 @@ void __net_devmem_dmabuf_binding_free(struct work_str=
uct *wq)
>         kfree(binding);
>  }
>
> -struct net_iov *
> -net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
> +static unsigned int
> +net_devmem_alloc_dmabuf_bulk(struct net_devmem_dmabuf_binding *binding,
> +                            netmem_ref *netmems, unsigned int count)
>  {
> -       struct net_iov *niov;
> +       unsigned int i;
> +
>         spin_lock_bh(&binding->freelist_lock);
> -       if (unlikely(!binding->free_count)) {
> -               spin_unlock_bh(&binding->freelist_lock);
> -               return NULL;
> +
> +       count =3D min_t(size_t, count, binding->free_count);
> +       for (i =3D 0; i < count; i++) {
> +               struct net_iov *niov =3D binding->freelist[--binding->fre=
e_count];
> +
> +               binding->freelist[binding->free_count] =3D NULL;

Nulling is probably unnecessary?

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina
