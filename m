Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0240A30F938
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785058804; cv=none; b=YomwDQIPo2Zsrc9K7SRxSfC9HBIpa015sUKfD4lKw4tWy8U/Q0FJ9X0qUYXCRFJIQa9E35ld30iAr6TeQgvYXuC1S5s+e25TOqxHZvEcy/eLISNiWM9Wse06oeWEkiLKVP3sviLKOB0wez2gUtE9IO92WQETm8QpEJZV73clv9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785058804; c=relaxed/simple;
	bh=3OwFQ5mBOcOXXMKcgunF0FyB50swdeCOl1+H3ELbnJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3dEpo9RBqi3F3K6Ymhf3VgUmUeoh9RHcxrN9c5G8NeXgCZ5P8z0wQMFFYDCPJV+hjkEKvOQFWiDAPkouWMd3dvhylv6RGYTFmaxhbgqki9ath5K7ELEzPGv4Uf9+mbwWMW5X6FCl23gnRm+i3wtBPejqTT+EiWxlSOzu1i/xWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=kPlnC8/X; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="kPlnC8/X"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954afac04bso19852015e9.0
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1785058801; x=1785663601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W9EbBcFAYSv/DDp1rQAfTtxvwF2ptTiblYa9/W6HiBI=;
        b=kPlnC8/XWrL8jfrtzZQI5pXpaUKUq0jxvFG0PQ+utOAvOAyxoE+swM9SUHu2CSRzcm
         MUfnN13B9xlrrRChSJ5p+4MvTXNA7EtWW3kT1SfM0HD2jrSr+U1RkEgNEjg5dT1qIt6R
         nGBCaegflk2B3ALRw+pcQIXlGwrtHsE9nzoe4AbmYC//y4pjbGMn8Brl1ATEYW/weZHy
         pe9mPMMmt1yEG0FTxAALL3GQ4ttMUhR4QQtDJgp4bgDs/WVYWwFld4tXGhPj6Bm1ZZQ5
         qYJBagiJZV+GBBLM+l6bdpkN0KQ7aJSIX94FwiQmdKHlcr6M1pF3SdSbYmlgZrusZcB/
         oEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785058801; x=1785663601;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W9EbBcFAYSv/DDp1rQAfTtxvwF2ptTiblYa9/W6HiBI=;
        b=L+KFrvw5Nlf+Ux5GQaRnwFyPXKetz156/IoAuoGUlflJAU1qRj93Gyuw1YoAYbwZ46
         UtTfr1/ETWDEmgnqGwd5yPGTxvCv67l4I0iHHFEam+EeXzpZ/mMQ1KLlTmqZ/eqY2WbA
         h0En0NArSgJ6JBk+kcTglvvHnw2Rp20BjQ+D2vVgegXFhrGpYdK6kGOro4hn0D2g8U0r
         KQ5QgmxI+st7HT5n+QrJXp6vQ9KhbRR8RLADSpGrXPYUg6g2fH5u6peE4PVpKz33Mrfm
         R6oPtfZylmdH5vEqiBIpu+ORovwhR/vT9G98pEjYjiQoBk69tr+dLQIothINeVXIfNbp
         pfaw==
X-Forwarded-Encrypted: i=1; AHgh+Rqr+MTnPES3XwMm+1d10yjLiXQzYHDyRxX0O6WDysZc+vIqRckF4r3HTlWAjZhoQ2Coao7E6hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGKOJzj0JAjiBtXqgq2lochsx8+w+p2vcLE2ol+COk2cLkp1MO
	z5esekt6eTjDAGTQMs+TurbsYYjUjxPlChm0E75kMWgQZ57Ryq5YZBprCWXcSzfdI0A=
X-Gm-Gg: AR+sD13QiPKWmqcea7Fgr9MN/xgemt+Rn077op1fLEuXQ4I8vayFSgX/E7jnjkbWCYG
	sakA3tl51WQWDqJ7fJvY9K25juQ6hm3EWdC6NiQxfy7odOV8B2qMh+7HN4sCN8VuBIvsgSnMqTE
	cGhCF0gFoVCGv9GYxN/72ewVQN4Ugqn6ByYSrYwrxKuf8/ju2RRWYxGo8BrLavGGLXWXXToYS/n
	LhJhf0w2oKYXECoYcdOA6NiobjXSNH0jsJyrfEblUa+fu/ec1XOnfzxn0DsxcpmLSzfIpiaUuBh
	H2Tf7q40KYUAfPDqp7Zt18aKbPg0kfiFplO8Q1e6IR/RqQ77AZkKD4zhtpVLMLjTdItztqpo9Ug
	XIuab4QCWGfVhRGFRmaEJGzG+daffH1ujW7k00tg7eTZEh9zUmFNwPM8jFNwj4Of1tYDFFPu3Ug
	==
X-Received: by 2002:a05:600c:1d0d:b0:493:f0f5:f2d7 with SMTP id 5b1f17b1804b1-496b56b1b23mr60004835e9.7.1785058801109;
        Sun, 26 Jul 2026 02:40:01 -0700 (PDT)
Received: from localhost ([109.160.73.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bffc501sm137035665e9.4.2026.07.26.02.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 02:39:59 -0700 (PDT)
Date: Sun, 26 Jul 2026 12:39:58 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: David Corvaglia <david@corvaglia.dev>
Cc: Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: bridge: mrp: fix Option TLV length in
 MRP_Test frames
Message-ID: <amXV7nnXDWaaH68a@penguin>
References: <20260726062605.2746-1-david@corvaglia.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726062605.2746-1-david@corvaglia.dev>

On Sun, Jul 26, 2026 at 06:26:05AM +0000, David Corvaglia wrote:
> oui is a pointer, so sizeof(oui) is the pointer size. The MRA
> Option TLV thus advertises a wrong length (15 vs 10 on x86_64),
> causing misparsing of the frame on peers. Fix is to replace
> with sizeof(*oui).
> 
> Fixes: f7458934b079 ("net: bridge: mrp: Update the Test frames for MRA")
> Signed-off-by: David Corvaglia <david@corvaglia.dev>
> ---
> v2: target net and add Fixes header
> v1: https://lore.kernel.org/bridge/20260724051202.61946-1-david@corvaglia.dev/
> ---
>  net/bridge/br_mrp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index 3f7126a7d720..179d2470b724 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -215,7 +215,7 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
>  		struct br_mrp_oui_hdr *oui = NULL;
>  		u8 length;
>  
> -		length = sizeof(*sub_opt) + sizeof(*sub_tlv) + sizeof(oui) +
> +		length = sizeof(*sub_opt) + sizeof(*sub_tlv) + sizeof(*oui) +
>  			MRP_OPT_PADDING;
>  		br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_OPTION, length);
>  
> -- 
> 2.55.0
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
