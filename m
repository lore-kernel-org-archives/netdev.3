Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E362E736A
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346129; cv=none; b=VX/hkHJfJs7bk5wslwDGcDZWRiLq8CE37z5ehuooyN3LaTVTRb+gKYL4Ul7SrZc58pVLvHpzkVF/xrex3yvUiXcz1OaJtXF3bBNAkXWoVrln8aQaxFB8uBH2g33c6OxMtqkmPAQ69pxOkhR4JtR+QZK4hzztLO11/uzZlm0lWdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346129; c=relaxed/simple;
	bh=rSvalNLhQaQ3apwOEUMfr2154HFkB49g22/1CuJLpak=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ecKzWMWzb9pbOGP4mgpqJJDtIDNgr6KR0vU5YeK/xExCy9+yp12P/W49jlqXR14E9arTO7f5K54YYGBy3oUI0HMos1Ycy0p6K30PHSluZUKcBunEjkI6HRMdi0l86PB/5/hK3UdarCY9/pVEKUnerRoKV4n9xGw+2PNFTBAqrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMHPjA4y; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMHPjA4y"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-80bb578d58bso24842507b3.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783346127; x=1783950927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SrImBI3WtIa1ASISM1T4xqaLApnPkT2AAEsmhw2GWts=;
        b=XMHPjA4y/+cI7Xy3oBEa2Z01SRr08HbmO556O0d9rH0/QkA/3sGB7cv9okrgMNe8Zy
         CtJDmCfMWM/FI5PnqxKL4qov5MEgcie2qZOG3f95E3YsFqoc2zAnzF9YllpDP2uDSRTu
         /rEimvJay47ijcqPFjAy9CGMHhfQGn+WEDm/f9hEIlBXApfW7dBPAGR/e+P09+GrEfao
         rQ3GINaMM0DEWCYlSGHUuVS0zF//DLd7zk3IFDNdlxMXp52iDulAxltEmOUHrns5Wth2
         rdQfGvrVh13A1hrkJQSIZUc7TnsfgTyGaG7duj3hq0iLdjpDGhC2E6Dtf2rNXhnjM6Yt
         O5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783346127; x=1783950927;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SrImBI3WtIa1ASISM1T4xqaLApnPkT2AAEsmhw2GWts=;
        b=HUE48XBPjvX0VBoZnbreh924JfhFX2owbCPGIcz9FY4tR78CSd8tMhn47b0Rxdbc3g
         +qVJwNXbSAf7X7wMuDJjBwiyMtWp45alHlNr1BitIsO3tIDsuB62eCUw82dS3LIN8xAW
         RKQvoD8Q/CRr1gb13IPhOxfYqvAgAkWVWX25bTbMb8z3VafLHGT+d9rTYRk7UNZnG8HA
         ijCzle3t6ims8/yTg6YNkd4kLEtUUduwJZzZm6ZWSvln1xr3mJPBypOtvlBYA7VB0m02
         j4byMOQ6OUJkVvCZLZEQrl1VR7C6Z1W/1klNeY3sHe9WdLvmtp9X6CQ4rEE2jDqJr+xz
         STqg==
X-Forwarded-Encrypted: i=1; AHgh+RqIVEWGPGl7asb8kvPLATrJpGKqF0j327vp1TFzyyx/Yr5r19Xmn5tfPcc6mI80txlW+ZEuFXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2+VVF85hBS9ifI5KnBunXqlMd4kcFemVlaL5Nnfmip70+F0Nz
	yTLxQwKN0hZ+mUnVn3wdN851ebj307S8LXXDlW3meTuMsFVxkSHuE5kK
X-Gm-Gg: AfdE7cnoeEM5CmGT+KaH9bmbY5z0SbySBiZb40tHtUl5/6SDVO0bnAnzRY8dbGCWET0
	uW4I+v9x+4Wek6aLVvXQNobx5C+dWn7ljJx+fHOor9jhqenFzxe6etlQeme6AxQIhGZvpg3ATza
	pXPgRtiql6rbioUWXiIlnvf49yxG/WRqEhwGwSes5pCF3SlK5JMk7g6Hhh0/9LxdQvFVtoAPs2l
	YcTkMEjlLRrElSnCGO0oRsNC5KdyP1BM647w7bShny3NQlvvgDBa0vSDAAYyAEdOoF5Yk9gsLMa
	snP13R5Crvd6JP0DKP5H+ZC1Nr8M6++piloQqvWMrFYO23I9yL9Qu9nwvC4RD2RWvILLu57yUOv
	qbWBI1LPAhV7RoolF9av93+KZFVKTmpaZnfkNXwwYk7+MI0LmLVe7HZLh2R7Ril0/KTkkcYRecO
	CLKNMbGwjhEV6chvswPLn3P9mgkurtG9tDh0N5BHwWSHBw/ZTDD/JBxe13DlBCsGl2jQ==
X-Received: by 2002:a05:690c:e08:b0:80d:66b2:82c with SMTP id 00721157ae682-81be184d41fmr2713047b3.16.1783346127448;
        Mon, 06 Jul 2026 06:55:27 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81448dd0217sm57733137b3.22.2026.07.06.06.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:55:27 -0700 (PDT)
Date: Mon, 06 Jul 2026 09:55:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yun Lu <luyun_611@163.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 kerneljasonxing@gmail.com, 
 kuniyu@google.com
Cc: mhal@rbox.co, 
 bjorn@kernel.org, 
 jiayuan.chen@linux.dev, 
 netdev@vger.kernel.org, 
 minhnguyen.080505@gmail.com
Message-ID: <willemdebruijn.kernel.250ccf6e7c9be@gmail.com>
In-Reply-To: <20260706100229.13812-1-luyun_611@163.com>
References: <20260706100229.13812-1-luyun_611@163.com>
Subject: Re: [PATCH net-next] net: skbuff: use net_zcopy_get() instead of
 refcount_inc()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> The net_zcopy_get() increments the uarg->refcnt, which is called both
> in pskb_carve_inside_header() and pskb_carve_inside_nonlinear().
> Also use net_zcopy_get() in pskb_expand_head for code consistency.
> 
> No functional change intended.
> 
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> ---
>  net/core/skbuff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 18dabb4e9cfa..bcf3b2c65fb9 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2326,7 +2326,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
>  		if (skb_orphan_frags(skb, gfp_mask))
>  			goto nofrags;
>  		if (skb_zcopy(skb))
> -			refcount_inc(&skb_uarg(skb)->refcnt);
> +			net_zcopy_get(skb_zcopy(skb));

This adds some unnecessary instructions in skb_zcopy.

It's not terrible and I see the consistency argument. But would make
more sense to update the recently added pskb_carve_.. variants instead.
