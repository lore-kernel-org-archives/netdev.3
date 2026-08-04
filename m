Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615935838E
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811401; cv=pass; b=VLXfUW7pIw7MZXiuvQuFy0DyWVGK9gRC9Sil6LhVXSR833Co9ZfKdyzjrB7GDTmqvNNklX0eQMc7siBWj2YufyLRfUMvqu/H3jEtW1/qwJ26n8g2JBkOrUoTCd/7pLZThK47RbKQnBWSe4ckMhzMvWdciEu4PNrtMTNFpTVg3bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811401; c=relaxed/simple;
	bh=YZKYb+GkPftg01Ou+o7yt15VY2iSSja29MKhp+0jynE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFE6HWv05J1hVyymlBWdtv6dooquUfJ3XiIOeW4ZBM+wq0i+C1lgnQDMNPiMYRrZUfbRaXYCOXMXRSS27vrDQLyiSpbzJPy4Pt4YzlgOMoSSNoNcEm4uvt2fns7d/RJxJClRUMMJmB5sf0FR4xyJevk1SF+PIAcT0xLjYI5rqKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jC8vkyGR; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jC8vkyGR"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81f3b227a4aso61747327b3.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 19:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785811399; cv=none;
        d=google.com; s=arc-20260327;
        b=j6X3EAZDPWIj7gVZ2yt+KJ/RYHtMc7vnVQ5K6zNbikU4v4AFBdkAOFhcHdVqhqwSIG
         jqWxRnSDluy1wFEozQ+Rwwt3FHiW4akqWJgkFVWnm+3q6RR9rgMZFgO1NAykAK07QTci
         mrd9DzsVRwW4B52+kGEkR28J1f0Zdr6odahsNzNLwO28T6qHvsr+A2tjQQIPuntgh2Hg
         NhLOIAKfg8apTod77DZWzwds0x9FfOKAecFTQjv3MHZu4+tFVQBRNxtPWRFzzVicgrow
         w+dalECOuUPQL5BUrmRwmcDG+Lu0yu4QHFdSM0bB1iledeRa/Up7cEUPDZ+YNrkj49Jl
         cxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RF3fTD6VniiBpbG6B64SSlFMt6UnvATMppDDhdm47VI=;
        fh=XnBQpgvwb8/kl3pZcKrgVDn89lCeGD9KSPU4dnSbHtg=;
        b=krLB/W6/LwGGFmVg6Mkm7l0GWETnf1+Y7dkpSduCfwC5uQAezep4eaRLYut0faPECF
         G1OCKLj5BY7g+oSMlLg17TaD4H1LexzMq2bqrjE72faRJTNG7KWyvL6L6/kHVVZFkGyK
         cJLwUUC6CM5h3kqy6+4MsUDvrMdX1OQD4emn1Mk4WYXShFrL1yJxIsL8XiLXoXn0q2z6
         v3kLK7i9C/IFYeQC3XtZA/yqcV7D4zM/fTRmp/TpQjwGKtbyEizppbNbazpqeIv7t6Df
         IA0BLojKQ2jkY+ClKG4UYkrybsIWkXjWWN5NdLx37GvbqZO/NYGTRAsNg7Ja7GFLeqoL
         5vAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785811399; x=1786416199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RF3fTD6VniiBpbG6B64SSlFMt6UnvATMppDDhdm47VI=;
        b=jC8vkyGRk/6dVnzI57mRjrGd4MqWLiArc7JTmqjqD6z0oiS0mwNucudqoCumJqjU6B
         yfCx7waIOJmSxiWu6GvOnURVX/TuBoZF/zv/89yb+OVs/IWg5BeyTcALp8iho/2z2Lwg
         k15bw1pWFm6RivINUFCPNnpZjG4nxfykdY+6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785811399; x=1786416199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RF3fTD6VniiBpbG6B64SSlFMt6UnvATMppDDhdm47VI=;
        b=ryD8P2kJPh6YgCMjG0MS2+kc3DdkL6qU7PFL9UcYz2yDPjkEA0f8iVpiVB53TBMoG1
         /KzFGHV0P4u4lplAYw9kOp34iCLUQHFfj+G2JDqAuqmG79KN0KXMr8U9JzdVWVAclf3L
         LUSF5G+nw8bYoPUNF6JN1G01ZvvR0OWwI3I5ICyCWd1nT+VYezQrQkqeFxV9KvjBL/TG
         HB+e1p8gnhs2hPofRZ+GPCSN0p1lCMjt9Sni5gIoUkRUBL/bi90bQn/q/CeMrthfImVj
         qaDsO88GpCy9BTReZ97s0Xqx4wvtzRMF75adlpUQktzjr6FuloP3Vn2Cf6ZGzE+QjxX0
         TaLw==
X-Forwarded-Encrypted: i=1; AHgh+RoGhyWQRzkfOP62vrNcxCfMICNF9du/rmzPyFGeVnFdKUcpnl11q5tfOygLt8atJlG9PIww8UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRd/vQXBnQD01qyuX6u5CeCiFWbKkmERp3YPBX+XtwBVvPMJ4S
	HlomSouYJDTyLRVgmHHXt9HErU/JwA3wO3orR/QH9uAHhKDFGyFi0TT2An/2avZzSN5A8h3IfCB
	G6vKeiCItdUj5zBo7PhlsswPOdRW+HpTwOLauEfMn
X-Gm-Gg: AR+sD135emcMoe2W3vbBkWAtfrqJFaRF2YtvyZLZBGauEwFGLMtyamg0MHv39ed7vA0
	nSfwl3IQBnicD2VL9Hbo+JtJmWgwjLK0+tHXZoa4FJUf7rN1E4l1+WE03xXLdx1i2k1RILEVo20
	oxoYHdahbMP6LU0yEnPk8IeVVxIQqyLq6rBnj3q8LHNP3eudoEhDyhaCIOqLb/uPd+wD/5q6r7c
	XYzJlOyrn6cCT9i75HXY5T2tkx4E3zC6yJe5OL2uxN4bN1KLDUP10ILnMdQ6htAv9KrZIqURYB8
	s5Ms21bpwHGeqml8M5K/tVbcvxbm69FITuCrpQ737sjJ2gw=
X-Received: by 2002:a05:690c:6984:b0:81e:a425:fe88 with SMTP id
 00721157ae682-81fd4bf523fmr168290117b3.33.1785811398719; Mon, 03 Aug 2026
 19:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803141659.559129-1-akkun11.open@gmail.com> <20260803141659.559129-12-akkun11.open@gmail.com>
In-Reply-To: <20260803141659.559129-12-akkun11.open@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 4 Aug 2026 10:43:08 +0800
X-Gm-Features: AUfX_mw0ODj1uLGkUiNOBLIVs6yIxP-U-M-JHW0wgLxFKYiXjICIFii0-d42exg
Message-ID: <CAGXv+5FHSNH5SLiCiXyHDieO2rUDypAQBi5-nbTFKFzb+3ZWRA@mail.gmail.com>
Subject: Re: [PATCH 11/32] clk: mediatek: Add auto-population of sub-devices
 support in simple probe
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Yassine Oudjana <y.oudjana@protonmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Laura Nao <laura.nao@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Takashi Sakamoto <o-takashi@sakamocchi.jp>, Haotian Zhang <vulab@iscas.ac.cn>, Kees Cook <kees@kernel.org>, 
	Miles Chen <miles.chen@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, 
	Sam Shih <sam.shih@mediatek.com>, 
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, 
	"open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)" <netdev@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:18=E2=80=AFPM Akari Tsuyukusa <akkun11.open@gmail=
.com> wrote:
>
> MediaTek audio clock drivers call devm_of_platform_populate() after
> mtk_clk_simple_probe(). Extend __mtk_clk_simple_probe() to run
> devm_of_platform_populate() when the new 'populate_children' flag is
> set, reducing boilerplate.
>
> Note that explicit of_platform_depopulate() calls in remove functions
> are unnecessary because devm_of_platform_populate() is managed by
> devres and cleans up automatically.
>
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 7 +++++++
>  drivers/clk/mediatek/clk-mtk.h | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mt=
k.c
> index c3369a04cdec..71d70b5a9990 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> @@ -609,6 +610,12 @@ static int __mtk_clk_simple_probe(struct platform_de=
vice *pdev,
>         if (mcd->need_runtime_pm)
>                 pm_runtime_put(&pdev->dev);
>
> +       if (mcd->populate_children) {
> +               r =3D devm_of_platform_populate(&pdev->dev);
> +               if (r)
> +                       goto unregister_clks;

You cannot use devm_* here, as they get unrolled _after_ the probe function
returns an error or after the remove function returns. A child could be
referencing a clock that got tore down in the error path below.

All devm_* functions need to happen before anything that requires manual
tear down. You can't mix the two together.


ChenYu

> +       }
> +
>         return r;
>
>  unregister_clks:
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mt=
k.h
> index b6504b3e77ed..11939e3e0b38 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -265,6 +265,7 @@ struct mtk_clk_desc {
>         unsigned int mfg_clk_idx;
>
>         bool need_runtime_pm;
> +       bool populate_children;
>  };
>
>  int mtk_clk_pdev_probe(struct platform_device *pdev);
> --
> 2.55.0
>
