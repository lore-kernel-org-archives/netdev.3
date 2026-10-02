Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C433BB678
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967124; cv=none; b=XFSLuWJn5ysZchD3tDnWLsEBbjCgABYC02wmPj+ZpJi102kKZK25+yJHq4q4EIgdHl/KDN4LbWGYoG/pKsif4dzANJ/X8zMXBSS0QgSY24pS89JmmJet/rjhVtT3Nunf5A2QywcH1cnk+ouKX4Du685Y+uxleT2WHJgcSmv2m1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967124; c=relaxed/simple;
	bh=DHchWNZ1wELl9N/w6lEvEhX4ovGIqMkBB+Mj5IaftOY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=a3mVq8N4O30aiLDwM5x+IohTTRCZf8semVDIxEAoYgf5y3CJpueSnE9JGUSt9dbcC0GbRw22g85ZgeEBYaBnIfd5161MFWp52tSWZbnJff5maGr+9Oi3yVPo3i0HNANMhsO6PzDV7/1YTqRKCmisg/qcyXZ2ZKUPytHUw5HjlG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpwvNA6y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjDTpSw/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpwvNA6y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjDTpSw/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790967121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZbusdJQDLU9CqEcp+iezpSfVMrYKCe1NKRzE9U8ZfQ=;
	b=KpwvNA6yyHps7fBy23Jiy6/hPp/Nzm3EqGCQYLs6FY/iUkxwaRokU50jEp5EmLK7kVu6TO
	3MgGuRovlVpDX7/V+QMNsfYQn6JHFJZFDKF8qIboU2x6yyrkY1Wm01rmN7V2qZcckiM0Qs
	2HVwjkWml7cSg0/IjClbNvSwioib3SY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-1SNWpICyOSCR7yc39RjCeA-1; Fri, 02 Oct 2026 14:52:00 -0400
X-MC-Unique: 1SNWpICyOSCR7yc39RjCeA-1
X-Mimecast-MFC-AGG-ID: 1SNWpICyOSCR7yc39RjCeA_1790967120
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e46c120dfso71226485a.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790967120; x=1791571920; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8ZbusdJQDLU9CqEcp+iezpSfVMrYKCe1NKRzE9U8ZfQ=;
        b=UjDTpSw/X7ws2i650ZZTBkLxi+6XcdlopPZI3rAIW1C/mPXcKr49O2KAZJwrG/wYnt
         L7KlvO8ERtLs30th+GARDp/dF3x/4fNTfPo32hymHWd6m5oFHLuCJV1QrUxs/JHiAPMH
         7xT71lAT5IHSeenbPTG/TVbacbHzxtch1wFIsUcGuAPsU9qLML7UlHBtrdGEXGVnUawi
         j/R6ynK7JZXJMEizbfqWgayPW4ngnhRJA4zzvvEE8Gv/tNi5uOVT++kU7jZFatskavm3
         bUL7Rx4ZANrIS779EB91feCvYwhFu6jmkgxKL/W5ptBUJ57AL8WXI2bAvdzDZtjYo/WZ
         Rkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790967120; x=1791571920;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ZbusdJQDLU9CqEcp+iezpSfVMrYKCe1NKRzE9U8ZfQ=;
        b=qp3TgALFBJhDngD7p6kq2mBgX0j/77QBi/gYYo8BNSkVDvj2hGQZ8xqLOUO/7aKK9m
         NkdT6XdRbPWYDCeMePyuaOZrGa3alOc7UNYi48ktfho/Oa+33vQEY3pJd1k2T9euX8ZN
         Ucp2vQCglIjbTvxk1uOEIqBfsvI2ZqnydrK/XK+Xg8i5LUaHjEngdfTY5CkUd8O8KZfM
         j4N4V5vq3Z0/wBas/fpsrPLkIm+UPkKmgHY1Po2tIgtr+B61t34Umum8pMG25OJM0Sir
         HIgj3I83slMjiBEpo62en+ZlsG5E4sd6IgiB/Y3TdqUFffZurgcIZCUIAYCUDt9+vOHJ
         aKyA==
X-Forwarded-Encrypted: i=1; AKwUvBzlKPpyW2w43iaYpG0lnaOhr9o9PHgqcaK99b4MflYhMA2HUTL9N/KS/ALd1N110SPh0vpdr1U=@vger.kernel.org
X-Gm-Message-State: AFuF++nhbqRq4xw837yC/FjZO1ZPYqEZdVQtTH+ZpYHIY1lqxbNwxvyw
	hLaKH50nfJPkoclk9mfCmTiT1cm/eOG4x8dZeHmBxh2r2fIkXS8SSv4PsRZmq+PQxM0pxcYTIIP
	DTSW+QQAZhhYwfVySLehinmPFZfwAudPcolC8z4d9zuwdtdCBVwaxU35efA==
X-Gm-Gg: AYBFou2lMPm1wkAcHER6H+MVJV5Vsg9DvGwl69bsFmQOb6oivUA5rD5hOothjKz2K3m
	ttC6mkNNWPilCko0YFiHJZENSYn3swQJj5/AdsYtvhgOg1aCrNwWgo5K/dcowWV7eADJG/BAW/A
	pW2fRIVyZZwScxDK8YR2RJ76NEpd6w3QlCEhSHhzPxXn8AJ5OouE8AUy1X7LM2JsaQf/QrE7onS
	NzRH5+QieS1RpKrozF1UMvRLAxqr/RHl9KCSgFFyUwsRl5gy4K/kmxEcw8ELZCOtGn4UhtIBfn2
	deYUf84eYVa2hilqaPvu5rsSTcLtWwmbSoyWK4EUkhTn+VuvFjXowkLvMBEPq2Gpv4EhHq0n8Pq
	DEu09HINS1PeTbg==
X-Received: by 2002:a05:620a:1707:b0:93c:ab7d:af7 with SMTP id af79cd13be357-93e510eda88mr48340985a.54.1790967119655;
        Fri, 02 Oct 2026 11:51:59 -0700 (PDT)
X-Received: by 2002:a05:620a:1707:b0:93c:ab7d:af7 with SMTP id af79cd13be357-93e510eda88mr48333485a.54.1790967118935;
        Fri, 02 Oct 2026 11:51:58 -0700 (PDT)
Received: from bmasney-x1.rmtuswv.csb ([2600:382:7723:4eba:66b1:961f:1a2d:af55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca03a1bbsm290352485a.1.2026.10.02.11.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 11:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 12/23] clk: starfive: Introduce idiv ops for
 inverted divider clocks
From: Brian Masney <bmasney@redhat.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Brian Masney <bmasney@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>, 
 Kees Cook <kees@kernel.org>, 
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org, 
 netdev@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20260930124317.5648-13-changhuang.liang@starfivetech.com>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
 <20260930124317.5648-13-changhuang.liang@starfivetech.com>
Date: Fri, 02 Oct 2026 14:51:13 -0400
Message-Id: <179096707366.821688.7143884804671628088.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1581; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=DHchWNZ1wELl9N/w6lEvEhX4ovGIqMkBB+Mj5IaftOY=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL2/7W9zLXuyMqzenaif56235iYH37vy6njq2S21Ouo+
 +7y2HUxvaOUhUGMi0FWTJFlSa5RQUTqKtt7dzRZYOawMoEMYeDiFICJdK5hZOiut5vCynTqZcHe
 S+F3wxhvO356uFlMyslMe9Iri3Oa/ikM/2MWlG1+tWHSu7i1E1iyY9Z/9z/fdPbqy3Oxs2tXT/8
 VOYsRAA==
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Hi Changhuang,

> Some StarFive clocks only advertise the divider and invert capabilities
> (via JH71X0_CLK_INVERT, without ENABLE). Add the JH71X0_IDIV() macro
> to declare such clocks, and jh71x0_clk_idiv_ops, which combines the
> divider rate operations with get_phase/set_phase.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>
> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-jh71x0.c
> index bb7706ede1a6..1f98f1f8f0a5 100644
> --- a/drivers/clk/starfive/clk-starfive-jh71x0.c
> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.c
> @@ -302,6 +302,15 @@ static const struct clk_ops jh71x0_clk_inv_ops = {
>  	.debug_init = jh71x0_clk_debug_init,
>  };
>  
> +static const struct clk_ops jh71x0_clk_idiv_ops = {
> +	.get_phase = jh71x0_clk_get_phase,
> +	.set_phase = jh71x0_clk_set_phase,
> +	.recalc_rate = jh71x0_clk_recalc_rate,
> +	.determine_rate = jh71x0_clk_determine_rate,
> +	.set_rate = jh71x0_clk_set_rate,
> +	.debug_init = jh71x0_clk_debug_init,
> +};
> +
>  const struct clk_ops *starfive_jh71x0_clk_ops(u32 max)
>  {
>  	if (max & JH71X0_CLK_DIV_MASK) {
> @@ -312,6 +321,9 @@ const struct clk_ops *starfive_jh71x0_clk_ops(u32 max)
>  		}
>  		if (max & JH71X0_CLK_ENABLE)
>  			return &jh71x0_clk_gdiv_ops;
> +		else if (max & JH71X0_CLK_INVERT)
> +			return &jh71x0_clk_idiv_ops;
> +
>  		if (max == JH71X0_CLK_FRAC_MAX)
>  			return &jh71x0_clk_fdiv_ops;

else if so that it's with the block above.

Brian

-- 
Brian Masney <bmasney@redhat.com>

