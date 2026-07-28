Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654762BE053
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 04:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785212225; cv=pass; b=NzgB4eMyuvdObeJgWBgvh8d93mtdWZkcQHfLH5f5XiIB3RmWViwg5qe/kz17r97dSaTsXV2hsXcRf+oM0tUL1+jhMK4SEypRvGfWDpQUXytJc04jBPMJq6s5A5qDk+Ats5YowpuV25hIJmHlGPTlZLFOZaTCbcRi/nM/GgBIAm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785212225; c=relaxed/simple;
	bh=wAZbP+y9skYRzd21PZ20bFTOlfTVjYcnyFYkqToUktA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmGjH7Rv7UN1IqT7pQllpXpk72u1pRfCkez9ay3vXwTCRzQYB9LieSTTmSmLMk4ypODngSUonx/1rsBjrD6xFeAHZLRpWYxcDE7EjfGjWoxUsOtbQmwPAw9R0joxWJ1YTBn50+yqr35S1r/OzIXuB/aV6l4s9j1MXaKvxsvsC6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8a12Y1r; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8a12Y1r"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c04bf4711so33434111cf.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 21:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785212216; cv=none;
        d=google.com; s=arc-20260327;
        b=Jrgq4lkK+P4uOAZ8l9oHckjJPE/cK4DH5hOo6dqODnd+rqNjBQH6ZJlGR4DNlVVK3p
         Ezfnta5gkxCrQBfMZ9Fhyedjy4NBZBEteRIZuJilPNrIjJ86oMdIYBaJhNyNPx5l4++t
         obcd0rdraQVFTPJlC/H6MRrrC2q9At1JD013b6rcQ2xC9NqWLkcXxgcqkOZge5yzMXnc
         iELEMqp79ejoaP5LKX4rqOrGsLD7MFrsqne7we4dcM4N6ArLWXGIVBlgZXyt/oK2svU1
         8Wfx2XzUZgHi0dpqMqlF3ekBZbZ2VXADv0Lh4efftnrmmTIMvJRN1uEe+9Peym3thesI
         S2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XekGCxojJEhXUWFTpUiFdg5xCcY4H+jCxAJHqYvFYqw=;
        fh=ceMpJpXAAy8VIX2MknDmZ5nfyEWVY1hKrr58Uq5Gglk=;
        b=CqTk9oI/4qlA4pKrcD1936fc7/GUJrAvDl9RtrMTVnjtYVSqQFn8EDzc75KmVngugt
         ustwdC0WLxXIDGPnrrvfEIzaw5heh4pdMI4vl4QQN4ljn9tquFplJL8pd/pUawP6E60E
         LrykOS1G0+B035eCnm8tK+Ryay1An7luqkX+5V4UkjbnWdau6kMCifO9Rvr/gwEwEl5C
         7/9lsLWf8F2IjRTSA2t4+5lWenLDazNAPe18vIFtXUPS9V1NSPIXq14Abx9GD2sJqd+N
         8OpM2kZHAovTqzxpocEhw2WyhiqyMXp8O7E/LXA5h++6O+B1s2eiDNvIxLc1SKqV0+c+
         lexg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785212216; x=1785817016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XekGCxojJEhXUWFTpUiFdg5xCcY4H+jCxAJHqYvFYqw=;
        b=c8a12Y1rQuX8aVQ00h7GeI0tpKk8/IWkbmNZPOkogS9IhD0/XBKRW8QgFoTAiG3ySS
         xXvSFOByPNAVdzljpEP8HMW8JExWsvE35QLIYGBL5Sxnrfb6+7TmfYYt1Zq/C3ucMMz1
         hwNcYblpGxoNClbPaw5HCT3rFPN8O8AJvS3mla0BY4ipqh135ZimKShNGjXgIE/RYXfv
         nArMRi1Pgeyx53cVgexU9esz/j7oNyAdsYW6zbqU2kExFEPhvz6kHu/GsW/6/Ef7zVYL
         DRPl2Kj/bkALPKc9pr1aiv/qZPLgZpxwUgi9p95B1V5GgMLZCn4ZKnRcScJ9xJUKgjB1
         I5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785212216; x=1785817016;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XekGCxojJEhXUWFTpUiFdg5xCcY4H+jCxAJHqYvFYqw=;
        b=KECHuwyjaP1JCH/DEUn9HMd4vPc1QwSgK+6/Y+7cmhSY1PtVplarNM+W86oTG9TS+Z
         0pZSj3Bsl/f/xSon9MP4A0nMjPCIRvEjzLYY0IV/zf9ar7Sup/v8NoSACY/mEJU1KMHt
         7q5wDyMQVbBJBRosUqNI/SMqwS4QkO28B5YJrBkwpl8NpkvwL1vZv/T2mFULphFVeN2D
         3w46SbeXceSl5OA9lfuPOciK7atYjLbfGI7wVrnaN9uAhlmzQMFeOsY9zFr7hqmatQT6
         udTSB/udBOcPWntIltne/d0r+5qM0CkzLQNcCXsKAofb2uRlfvf9uuC+4X0pzXVqtKYG
         xrqA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1YREvlpv8k1FG8ykTp8bhnkFGsM4styMgYZCEsAOiZcLjsZJAuFHm5zlgPLa5zICPlgnrjCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjcD7Xzk2hMg0Y45TrI0fx15SGwYa7asWcy8N5xJ/wj5ko7tEo
	4LCrfH5Df892vwzqgwNpccFGN9nHBrdmwbk9ucktOrvkmOV2eIJZ0T9kLmRBLa+e8nE7iHTwJ6D
	txPJiuNUKpfIU1Qm5APOdtABPClyCxhw=
X-Gm-Gg: AR+sD13lIJX9xLlGvnlMAA+6dZO7ca2Ee6iz0aDaTR7OnpjTHrYNIezC+6Kh9GCx0F+
	bhGqZCBNmDYIS+P9RhNThqldc+7i98Hf6I3LdQ+uyLlATix9crqoPjb7+ggDF3wJISXLMZuVylZ
	i2+h4P7+PdiDx8u15txP/7Sx7JlR5IQVcISc7B4r4Kv97RR5E5jvE35E4qjgWbWnXG4YRKuzuZH
	m0PXWktUCNzF2Pe28lSB9EokIQ2bQm9FkS5/r0AMqOW14VJHGyEs3H0FiaMNEBf9aa/aGmd4uqn
	X0E6VQMCbzhW0YobOA==
X-Received: by 2002:a05:622a:6097:b0:51c:7b12:5fdc with SMTP id
 d75a77b69052e-529d71a5fd5mr4771651cf.88.1785212216269; Mon, 27 Jul 2026
 21:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727205602.1188008-1-gahing@gahingwoo.com>
In-Reply-To: <20260727205602.1188008-1-gahing@gahingwoo.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 28 Jul 2026 08:16:44 +0400
X-Gm-Features: AUfX_myvNtJnega2iP3q9qJFtpLJlEuxkzgJa22nNvHcCMG6lVTQm6OH8bQ5w7Y
Message-ID: <CABjd4YwmznLERMx_DgfTeqXmOEZh=pcOjf+NYfkV069mETe-uQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: phy: motorcomm: enable the reference
 clock for YT8521 and YT8531
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com, heiko@sntech.de, 
	linux-rockchip@lists.infradead.org, attinagaoxu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jaxing,

On Tue, Jul 28, 2026 at 1:04=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> These PHYs need a 25 MHz reference. On boards without a local crystal
> it is fed from the SoC and described as a clock on the PHY node. Get and
> enable it in probe, via a small helper called from both yt8521_probe and
> yt8531_probe, so the PHY is clocked before its registers are accessed.
> The clock is optional, so crystal-clocked boards are unaffected.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>
> Changes in v2:
> - Factor the clock enable into ytphy_get_and_enable_refclk() and call it
>   from yt8521_probe as well, so the YT8521 is covered too, not only the
>   YT8531. v1 only touched yt8531_probe.
> - Carried Andrew's Reviewed-by; the enable itself is unchanged, only
>   moved into the helper.
>
> v1: https://lore.kernel.org/all/20260719034555.3623003-1-gahing@gahingwoo=
.com/
>
> A second crystal-less RK3576 board with a YT8521 needs the same handling
> (see the RK3576 GMAC 25M refout thread [1]), so v2 covers both PHYs. This
> supersedes the withdrawn dwmac-rk MAC-side series. The DTS that consumes
> the clock (rk3576-armsom-cm5) goes to the rockchip tree separately; the
> clock is optional so this patch stands alone. The YT8531 path is tested
> on an ArmSoM CM5-IO (links at 1000 Mbit/s).
>
> [1] https://lore.kernel.org/all/20260727021048.3375444-1-attinagaoxu@gmai=
l.com/
>
>  drivers/net/phy/motorcomm.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 708491bc1..32eb5ce93 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -6,6 +6,7 @@
>   * Author: Frank <Frank.Sae@motor-comm.com>
>   */
>
> +#include <linux/clk.h>
>  #include <linux/etherdevice.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -1043,6 +1044,29 @@ static int yt8531_set_ds(struct phy_device *phydev=
)
>         return 0;
>  }
>
> +/**
> + * ytphy_get_and_enable_refclk() - get and enable the PHY reference cloc=
k
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * A crystal-less YT8521/YT8531 takes its 25 MHz reference from the SoC.=
 When
> + * that reference is described as a clock, enable it for the life of the
> + * device. It is optional, so crystal-clocked boards are unaffected.
> + *
> + * returns 0 or negative errno code
> + */
> +static int ytphy_get_and_enable_refclk(struct phy_device *phydev)
> +{
> +       struct device *dev =3D &phydev->mdio.dev;
> +       struct clk *clk;
> +
> +       clk =3D devm_clk_get_optional_enabled(dev, NULL);
> +       if (IS_ERR(clk))
> +               return dev_err_probe(dev, PTR_ERR(clk),
> +                                    "failed to get and enable the refere=
nce clock\n");

A helper for a single-line function call looks like an overkill, and
requires scrolling to understand what is going on where an open-coded
version would be self-explanatory at the first glance.

Maybe fold it into the two caller functions instead?

Best regards,
Alexey
