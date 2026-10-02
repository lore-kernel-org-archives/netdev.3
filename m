Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA24D34D916
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967112; cv=none; b=LbyVcBHbCjhMoPHTYPVPr8UkBf/W124bmKRRQr9O5cQb0O0oDUEERE4J3UIRRCL/pAAt6ibROmdPJdkK8fI31luGT8FNKHGxV4mYd2u+JXex+TPyyUzzpngryuSX19YGmBNo0qpPQoWX3jQgNLWwkgcFjQZMs4RVv8XnZQoZuPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967112; c=relaxed/simple;
	bh=QDX7lQ1hmHgJ9y3o5Z/Hm00xEaK1qYts6FM/BQ1Nm/Q=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=b0NUNlBb3F7HemmEuaU2ZYFgLyG7fc7XYnlAFqcrELvpWf4tb2xH2VFoZQfzzKJ2j1JzlF2tq51CSYDAnz+8ZvQUoAibpcYCch8NZ7XAZDIwFqly7Z50CNwXyHhPyZ4dgQle+joSbNytF3n2l29ocoRlKOJs4Hx8R/dMQWPhwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDKDP0zP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jj7ZH8NY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDKDP0zP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jj7ZH8NY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790967109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwzsAXBdR1BkVlkk6NnC6X5ecf++oyv9cFOEdcbokxc=;
	b=bDKDP0zPwtdjL53ZY8i6molV1ZjpTRdxU8fTgvecw34Fa0baQ6LlPXh+w3EC+H65ttIIgy
	3lmDoEWhY4vZ/RjeCSFZUj4Oz9ccbuKda1ISHiG4cN0irOLHeRtkVeijqnoqe9juqr/9hb
	FKqW8kNLaAShHqi74RZaSbmAxRN8kTU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-HeTHA6pzMp2Xs9QyR7Re9A-1; Fri, 02 Oct 2026 14:51:47 -0400
X-MC-Unique: HeTHA6pzMp2Xs9QyR7Re9A-1
X-Mimecast-MFC-AGG-ID: HeTHA6pzMp2Xs9QyR7Re9A_1790967107
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e82060977so371960685a.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790967107; x=1791571907; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jwzsAXBdR1BkVlkk6NnC6X5ecf++oyv9cFOEdcbokxc=;
        b=jj7ZH8NYVEdrxdyXvrrUVICgkUNovrKhQx+jcTeFBx5OkC9wtNxlui6CAFLwIhpTXH
         Q4WMOn2oN8HgJpJOQ31tQLG+DuZW0PeBib1ixm18GMht/xVFQH4+IFh+ZrmEgFWTqbt9
         yd0RVLz5XVElEu+zZTC+52DGvV6pHZhGuZazaZ9zyrgMjcYkt/yE6lWJyf8gsiLpfya0
         J7JBbMOEpCXcweTfK49rA5pMYf/EqecurRHOphKhFxafpGxewjKX2YhTKBOeIAGyGDqy
         OguFx7j0Fqtjscv1zFRp2HurZb1GLlp3zayaiFVAaRSftMJt/zOY84pIUNKhJGsMwpbB
         4JJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790967107; x=1791571907;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jwzsAXBdR1BkVlkk6NnC6X5ecf++oyv9cFOEdcbokxc=;
        b=PxqQs5gh6C545xiAB5eN+DzlQQ7HNY3AUu9wj+xjhBAyWHyike0A9ow5RDp6qOMzW+
         8XmwidBI+j5Rss4GHCygQkMUPlJtxNKkwaL6p23uiNo3+RcQbXjbCSI+D+pSCzysEUYR
         veOx5DYiKELzkE5dZpwtnfNlHFn0VKK0bjU0gOyS9aFoJiGLeDiHJyLHFsIPnp3cfJg/
         KWmBc9lTnfZJE6aNdQXkOtXnpPPUknfD+rTckkkb+nQ7w8P/YASHjPAYVU+JCUyBIqYB
         ZayJtsINSpMgyJ8phFCJPvBZAiyFBypv2IZt2528VpZN7ikfiGIs5NpQGgTEM/MA62iJ
         4WKA==
X-Forwarded-Encrypted: i=1; AKwUvBywPjVmK84DGEwrgNyfuQ4oHdpQLGYad3ccJWI7F5bOnfueu8A3xN8DXvN3p1nvofd3RHoeE+A=@vger.kernel.org
X-Gm-Message-State: AFuF++mwqS33i/tyvBmGF3IhudXzvCLp9HsRh1SsBCE5LtqNfkrr5usy
	MHxPnmDblZsvnPvpBef8zCXShAZ4uvEcZYGF1ohtAGRVsG/MTuyvFnxW9VPnqUqU6ChLvfLs2Gx
	T8gXgQ3zTdCL8WDvr2dHiem0XuOLjnTgf19N66qv/ZccZqrxnMrfFihBR0g==
X-Gm-Gg: AYBFou0YuUOzzwglQL4tQVYMd5xpsFdkN5JJmtsclE30t59fATjLP1gfaHcS8JUfeg5
	B/YI5Y+TWRTNe+BGrO4G7u737CxWXQk0R0jFUSnyuappVVgxvpDbYyrVKPq/ZIO4fm1s/pDl0Hd
	jxTQrVbtxaijrjCuRF418PVMcuJpYEYDVcIWxlvSrnzdWYr3SBlPpzomkw8y4PTHcQOrDRpbjDR
	tWvGKs4ob7Z0tpUTUu/pz/wnmNCDBBjSVnMaJlwFdu5yh1KOrB7B5UfGjWsV9sD8zB0/xjFEtsO
	x5d8lyc2DfYFDmknwk8M7pHvBRx8LcywD0mugQamdHLpabvrXvS4zBR1HAYQe55+Rk3sEtB1REa
	o3muo8R7rXCPw6w==
X-Received: by 2002:a05:620a:172b:b0:93a:32e7:bbe with SMTP id af79cd13be357-93cf177ead7mr639037785a.21.1790967107015;
        Fri, 02 Oct 2026 11:51:47 -0700 (PDT)
X-Received: by 2002:a05:620a:172b:b0:93a:32e7:bbe with SMTP id af79cd13be357-93cf177ead7mr639030785a.21.1790967106284;
        Fri, 02 Oct 2026 11:51:46 -0700 (PDT)
Received: from bmasney-x1.rmtuswv.csb ([2600:382:7723:4eba:66b1:961f:1a2d:af55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca03a1bbsm290352485a.1.2026.10.02.11.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 11:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 04/23] clk: starfive: jh71x0: Add generic CRG probe
 helper
From: Brian Masney <bmasney@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Brian Masney <bmasney@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>, 
 Kees Cook <kees@kernel.org>, 
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-hardening@vger.kernel.org, netdev@vger.kernel.org, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20260930124317.5648-5-changhuang.liang@starfivetech.com>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
 <20260930124317.5648-5-changhuang.liang@starfivetech.com>
Date: Fri, 02 Oct 2026 14:51:13 -0400
Message-Id: <179096707363.821688.2728247121300145722.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4235; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=QDX7lQ1hmHgJ9y3o5Z/Hm00xEaK1qYts6FM/BQ1Nm/Q=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL2/zV1zvtv7+SlXtHBUHFGbF2avMt2pk/9ujcLTCxi3
 ln8f/y5o5SFQYyLQVZMkWVJrlFBROoq23t3NFlg5rAygQxh4OIUgIlkT2L477RhtiqP0LV1IWGM
 ZU1dt/UfT9fN8wuQLvAMmf5nqsZPDYb/SZGX7zI8PTwx9kJQFcftAndb56ryh2camk4sv/s3O1S
 VGQA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Hi Changhuang,

> The StarFive JHB100 SoC has several clock and reset generators (CRGs)
> which share the same probe flow: map the registers, register all the
> clocks described by a table, add the clock provider and register the
> auxiliary reset device.
> 
> Add jh71x0_crg_probe() together with struct jh71x0_crg_domain_info so
> that each CRG driver only needs to provide its clock table, external
> clock names and reset auxiliary device name. The reset auxiliary device
> is registered with jh71x0_reset_controller_register().
> 
> The clock index space of these CRGs is sparse, so also make
> jh71x0_clk_get() reject indexes that were never registered when the
> domain info is available.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>
> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-jh71x0.c
> index 2cc71f49ddee..bb7706ede1a6 100644
> --- a/drivers/clk/starfive/clk-starfive-jh71x0.c
> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.c
> @@ -10,6 +10,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
> +#include <linux/pm_runtime.h>

Add #include <linux/property.h> for device_get_match_data()

>  #include <linux/slab.h>
>  #include <soc/starfive/reset-starfive-jh71x0.h>
>  
> @@ -334,10 +335,14 @@ struct clk_hw *jh71x0_clk_get(struct of_phandle_args *clkspec, void *data)
>  	struct jh71x0_clk_priv *priv = data;
>  	unsigned int idx = clkspec->args[0];
>  
> -	if (idx < priv->num_reg)
> -		return &priv->reg[idx].hw;
> +	if (idx >= priv->num_reg)
> +		return ERR_PTR(-EINVAL);
>  
> -	return ERR_PTR(-EINVAL);
> +	/* Index space is sparse: reject holes that were never registered. */
> +	if (priv->info && !priv->info->clk_data[idx].name)
> +		return ERR_PTR(-ENOENT);
> +
> +	return &priv->reg[idx].hw;
>  }
>  EXPORT_SYMBOL_GPL(jh71x0_clk_get);
>  
> @@ -391,3 +396,87 @@ int jh71x0_reset_controller_register(struct jh71x0_clk_priv *priv,
>  					jh71x0_reset_unregister_adev, adev);
>  }
>  EXPORT_SYMBOL_GPL(jh71x0_reset_controller_register);
> +
> +int jh71x0_crg_probe(struct platform_device *pdev)
> +{
> +	const struct jh71x0_crg_domain_info *info;
> +	struct jh71x0_clk_priv *priv;
> +	unsigned int idx;
> +	int ret;
> +
> +	info = device_get_match_data(&pdev->dev);
> +	if (!info)
> +		return -ENODEV;
> +
> +	priv = devm_kzalloc(&pdev->dev, struct_size(priv, reg, info->num_clk),
> +			    GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&priv->rmw_lock);
> +	priv->info = info;
> +	priv->num_reg = info->num_clk;
> +	priv->dev = &pdev->dev;
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	if (info->power_domain) {
> +		ret = devm_pm_runtime_enable(priv->dev);
> +		if (ret)
> +			return dev_err_probe(priv->dev, ret,
> +					     "failed to enable runtime PM\n");
> +	}
> +
> +	for (idx = 0; idx < info->num_clk; idx++) {
> +		u32 max = info->clk_data[idx].max;
> +		struct clk_parent_data parents[4] = {};
> +		struct clk_init_data init = {
> +			.name = info->clk_data[idx].name,
> +			.ops = starfive_jh71x0_clk_ops(max),
> +			.parent_data = parents,
> +			.num_parents =
> +				((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
> +			.flags = info->clk_data[idx].flags,
> +		};
> +		struct jh71x0_clk *clk = &priv->reg[idx];
> +		unsigned int i;
> +
> +		if (!init.name)
> +			continue;
> +
> +		if (init.num_parents > ARRAY_SIZE(parents))
> +			return dev_err_probe(priv->dev, -EINVAL,
> +					     "clock %s: too many parents (%u > %zu)\n",
> +					     init.name, init.num_parents, ARRAY_SIZE(parents));
> +
> +		for (i = 0; i < init.num_parents; i++) {
> +			unsigned int pidx = info->clk_data[idx].parents[i];
> +
> +			if (pidx < info->num_clk) {
> +				parents[i].hw = &priv->reg[pidx].hw;
> +			} else {
> +				if (pidx - info->num_clk >= info->num_ext_clk)
> +					return -EINVAL;

What do you think about adding a dev_err_probe() here as well to make it
easier to troubleshoot any failures here?

Brian

-- 
Brian Masney <bmasney@redhat.com>

