Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C31409265
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428599; cv=none; b=hNixzkRbzl+3AxhsUSfg8k3iQiB3chooyLeAuOKC62pOuDZk55ip53CcEklrwARtz+fS8pYrA/9uayr7m7mzjdT/Ue5VaQ00LlgSlSi8EBraUYwuXpTy3g9MXFUJU0t1yXtjbx+9gXB8Cb222AertbuKslPRHRJcnKWSFSGYvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428599; c=relaxed/simple;
	bh=QlpCUlv+E6wRy2NB52jPmYtg/gL7xxiavKZ+fWvKSsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZOi0ynhKZ5BFO7Z83OKiH8v8xPTfGG0OfSQEqBuB2scee3edvNR4oP6NMvnJz7n79cXBrfAsXJ6xNNpq6Mzawly4Z0T7cYXS4h4VFFPuk9JBkkGsQujDtIta1cxY29JwQuIN5w/QcXYjjyYYXCYMRjXqeQ2uqE/DGERpe15XX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bf8e1edc3aso1525314e0c.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 02:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788428596; x=1789033396;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/8aSggrTq+PN9vIOxwXLgYslllD/sPjeAKVtCCSsPVQ=;
        b=Se45nG7bSDVI2K5nMhZoMd3KcS+gob3f5qK0Nr8M3Sll+nAfEcHCWaqTKBgwQpnaWi
         DM/XO7qS3wfCz9ZFNxTGb+wNkHFeEEfgXUrHVawz5vx0UoKFkxJKkAtBqTJt26Ap4zUl
         Z3erfYF8qle1qft3DFxKFTxKNiX/QsoxkZ0nW0xw1BdfuCHEpIbeexPMbGbws8hkzmuo
         SJiH47QehBvGNGD0cMWlrHF6BfokuW59Ufy3hz5USfnVXthJ6135Rk5UZqoIxihso69L
         +UpjTdG7MO2MPiP5jQ83PZnBy11xGnkvLkBWC0A15pHZkKaIZV3dyAb99hbXtf3dskvO
         t2lw==
X-Forwarded-Encrypted: i=1; AKwUvByvrZBYSFn7PIiEwOWLgEcn4/t/Un+Vf/tQgOR67L/cnMlgC6BMpQDorVOMh+C2Onh/TJe36eI=@vger.kernel.org
X-Gm-Message-State: AFuF++mmsa87rnY43J+YvNXHjU86KEKkWvrOXBSHaEV5eF90IfpnO+u5
	LlVlleZqLDPgbsGrpE8hQrzULnCY1/ho7QzCz2TWWIG0m90JXdadAufY8gdXoHd46M8=
X-Gm-Gg: AYBFou34ltZdiVv19cJoTTQvxY9TbWlr9gjSbetPY/4hfbBqgdyjxPFTlNq+25xosRr
	R7ytgBiattuchjZ1FoRAkQ/f9+URETjIENs4kNWioWXVuBMa4gWFnCXdZZWXAevUjKi7HVr/Kdi
	Mn4LEGzJD/BRv2z1I5dOxSOYaP5kdaenZANRln3nOdG79CNGDI0pKOJsxjGbf89XOdEFjtHhGAg
	w3dtBm9+ZuTw7PwrKNz+YT6B8UmnPlqZiXtb2ZfxZXTShAUbadVG5qxcvzyVCezFwCW+/zsJ9se
	8KyNLZM7qNNioVJoj9GhEZ5NjTQGZgI2JbP6tDyBafSWAz/e/+L56gv7jH5eAuMzAZG/0ycYbPs
	llYYiLipeBz/XB4jBDDwDjm/89qkLPD7Qi5oxVCJeEyC9mYAP/1zExPjuOWJhzu2lif8auS+t20
	0e16astxSCFTv0/mVAjvSivZLCjCjdA1htMmwiHayefh5KZHdiDgsiPdC9xv72AkEwFmUXBnhZR
	NGHk+ejWR87qncg1md1kW8r/GPQnych3L10
X-Received: by 2002:a05:6122:f92:b0:5bd:8c84:59aa with SMTP id 71dfb90a1353d-5c7d287da45mr5357372e0c.8.1788428596587;
        Thu, 03 Sep 2026 02:43:16 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9806714fd39sm4154409241.0.2026.09.03.02.43.16
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 02:43:16 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-966e7380109so1339116241.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 02:43:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwDwX/DW9WWmFQzysDZIEI4yKrIIskDKaYuq5vlcJz5CHV++IJ7xDIHPe1ua0gxoEWs8uJk9cw=@vger.kernel.org
X-Received: by 2002:a05:6102:2997:b0:784:a169:194a with SMTP id
 ada2fe7eead31-78a1f437b62mr4757188137.10.1788428595977; Thu, 03 Sep 2026
 02:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903084339.870562-1-zhouruizhe@resnics.com> <20260903084339.870562-14-zhouruizhe@resnics.com>
In-Reply-To: <20260903084339.870562-14-zhouruizhe@resnics.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 Sep 2026 11:43:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV871ZLtrCzXFmhUeThkc8eFAhcFo2=Cos9iJru3bxvqQ@mail.gmail.com>
X-Gm-Features: AcwNN1VNMZwSAyY54Zj_XBQDARj9cOjn3MGAVS5vnzomKXlBjnTLo99feqtQTjY
Message-ID: <CAMuHMdV871ZLtrCzXFmhUeThkc8eFAhcFo2=Cos9iJru3bxvqQ@mail.gmail.com>
Subject: Re: [PATCH net-next 13/14] net: renesas: rswitch: Remove obsolete
 32-bit DMA mask fallback
To: Ruizhe Zhou <zhouruizhe@resnics.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ruizhe,

Thanks for your patch!

On Thu, 3 Sept 2026 at 11:27, Ruizhe Zhou <zhouruizhe@resnics.com> wrote:
> The DMA API guarantees support for masks of 32 bits or wider and

Really?

> explicitly identifies retrying a 32-bit mask after a wider request as
> incorrect:
> https://docs.kernel.org/core-api/dma-api-howto.html#dma-addressing-capabilities

AFAIUI, that is only true iff the wider request is DMA_BIT_MASK(64).

> Remove the obsolete fallback while retaining the error check so that a
> genuine DMA setup failure still aborts initialization.

Have you tested this on actual hardware, with/without IOMMU support?

> Signed-off-by: Ruizhe Zhou <zhouruizhe@resnics.com>
> ---
>  drivers/net/ethernet/renesas/rswitch_main.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
> index 755232994fcc..64b821ca02f8 100644
> --- a/drivers/net/ethernet/renesas/rswitch_main.c
> +++ b/drivers/net/ethernet/renesas/rswitch_main.c
> @@ -2162,11 +2162,8 @@ static int renesas_eth_sw_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
> -       if (ret < 0) {
> -               ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> -               if (ret < 0)
> -                       return ret;
> -       }
> +       if (ret)
> +               return ret;
>
>         priv->gwca.index = AGENT_INDEX_GWCA;
>         priv->gwca.num_queues = min(RSWITCH_NUM_PORTS * NUM_QUEUES_PER_NDEV,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
