Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416E942DA2E
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173208; cv=none; b=Lt+bTw12xn4jU63nGoSvu9zeQ8A/QHh8qurI6qck3LLtbY16oQFvuM8KLIQHFnDjQ2KU9qiMDmRFbeus+dvFvKSfJ14oU2Zy5gmuXlc62JnIyT5IS0lOZnnOUDR9MN6Q0dUYTPVfO26PmMw2C8ixNkk+fmOB0Y5QJpFMO1GCA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173208; c=relaxed/simple;
	bh=DYJVjDY3Hh8r6nJ40O2QEGlKAbitjQ2tcYV4SgI2IgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzhYY8Gqck/pgbl+S/x0cCaXEneE4U0OYXsOmSGB+wYi60w5UEQOMyU573bz5rOJn+LOmonvkq/ud9T+mTQEenRrVRJWwvAxEaEp7UyRZx5croqo5kuVRmYhdfEpQ0eSSuS7x4UvfUk1RuXCcD5RPSo/Qr9+k0R3bQuf2KsciBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=asI5DVfs; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="asI5DVfs"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc73e322dbso28548145ad.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785173196; x=1785777996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nmWUnAlGsYxzTsFGMc342HIpAkEWy6v0F2egVQDfD7k=;
        b=asI5DVfsori3jEn0YiuADYZ2V37V/cXqv6jNrtr4dwcKzWsu+HOrgckEfeD5wz2k1G
         LzR+RL8IgQ9tNxXgEhGfoqxcb3Xk8bc5/2lJ1CBkQzDruxvW4iGjxz9zwGN0QZI66bth
         mHvvdehHJrLVVJ2a3saFjq0occUwxaJH5ubw/kHr53Ks1waQTwVu2qya+7zDoZDyYCus
         02Vsp24396j3c57wrT+B9OQP8ABigzUrlhpRig9eSvRCjHEtaff/WszMe22GcEP3nxr2
         DH1rt+K1ql5gpy3etwgBTAhKVAHRunn0KwJBcW8TFuqWssrOPJJxw+kDarN8Qd/siy2t
         C6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785173196; x=1785777996;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nmWUnAlGsYxzTsFGMc342HIpAkEWy6v0F2egVQDfD7k=;
        b=IJcOOlAIg4KwmJ5JfC+Qs7z5l9QPzgZzZsesyduUNl10AjonWwR3oavOMHQDOM44yE
         tObeq9a1q571sDm7w7AkvHJnEm5WEZMpCIVV9fO7SuA2mXvt/u/cGNZGKZo6K00QEmOB
         3EnrdPJw0etOp/TvSKPWk+M7jrb/92CX+r65CiWT0LcmGSAW89ukpzRwfwWuUwO9nOdv
         ZdUgeiy5CflOKaQmt5kH8KWwUHCssvXR2+A1x8CCNZ0exzkPgWsWE/uaU1UEoz55jiM/
         McXeAiygpksNKtFOMenJhdnVrBddnH4PvEhNVP4uY/umRG0WmQQ5nzCOMZWtcEux2/Kw
         p+aw==
X-Forwarded-Encrypted: i=1; AHgh+RoKebKawon4xW308GDGmReqm+/lcBzwOMJLRdF+zOarkJHvSuMGvQhm23M/1byr7nqxZcNJfac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuPWs0FOKpm8PCZvFbpKU84zPrxu974hprgPeenyzPn76aWU2N
	zW8Rv/zu8H7ie7ZktoudprCbqz92o2M2Mf1Nq20ROUh46BzjDL9tNmCkHVK5lL2dw28=
X-Gm-Gg: AR+sD128E+YHmPGoVkgYUQw0n5qOe+PF1pbT7HAb1zlXH4rzV0RgEutPrRnhIziCbqJ
	gzTej6WJQOX1Noy5GRD4sioBF2qr0rsrqPpAnf2QauRMue/fRpAfEawnW+BTgWbHFE4Biww2uDH
	vrbaWkjcRjpGwBNz6zFos3VsJenKezp5FUUWGJdR9sp18XdlvDH0+/M16z/aHVQ4RrG6H6m4IUL
	GmPEK2lVQi/kEBTU4hVhTWkojpHYiw/33g0xNjx910Skkn2EiI0VhzaVTw6OKtPowER1T+SWpwK
	jogjtgyTKPwLuCy5aAqKe9Qrg2vm9hHXblFLI0w1VhK8VeDL718opnv++Evj0Kee1TsdjC/CT8p
	3YuGdua85UTJ2PM/f2zX0tCEnNPxAVhhlsBj4QflViSZmD6NKQyS68a+fDlI=
X-Received: by 2002:a17:902:d4c6:b0:2ca:c68:c554 with SMTP id d9443c01a7336-2d00f45aab8mr1466035ad.38.1785173196275;
        Mon, 27 Jul 2026 10:26:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:53::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81cd27sm39388635ad.79.2026.07.27.10.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:26:35 -0700 (PDT)
Date: Mon, 27 Jul 2026 10:26:34 -0700
From: Joe Damato <joe@dama.to>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: microchip: vcap api: Fix possible memory leak
 in vcap_decode_rule()
Message-ID: <ameUygDr01/ZvnPD@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Abdun Nihaal <nihaal@cse.iitm.ac.in>, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260727125757.134611-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727125757.134611-1-nihaal@cse.iitm.ac.in>

On Mon, Jul 27, 2026 at 06:27:55PM +0530, Abdun Nihaal wrote:
> The memory allocated for struct vcap_rule_internal, keyfields and
> actionfields inside vcap_dup_rule() are not freed in some of the error
> paths in vcap_decode_rule(). Fix that by calling vcap_free_rule().
> 
> Fixes: 610c32b2ce66 ("net: microchip: vcap: Add vcap_get_rule")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.
> 
>  drivers/net/ethernet/microchip/vcap/vcap_api.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
> index ff86cde11a32..0cc0db7b641b 100644
> --- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
> +++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
> @@ -2427,18 +2427,21 @@ struct vcap_rule *vcap_decode_rule(struct vcap_rule_internal *elem)
>  
>  	err = vcap_read_rule(ri);
>  	if (err)
> -		return ERR_PTR(err);
> +		goto err;
>  
>  	err = vcap_decode_keyset(ri);
>  	if (err)
> -		return ERR_PTR(err);
> +		goto err;
>  
>  	err = vcap_decode_actionset(ri);
>  	if (err)
> -		return ERR_PTR(err);
> +		goto err;
>  
>  out:
>  	return &ri->data;
> +err:
> +	vcap_free_rule(&ri->data);
> +	return ERR_PTR(err);
>  }

Not sure what the style guidelines say, but the label err and the local
variable err having the same name is a bit confusing.

Maybe you could make the label "out_err" and update the gotos instead?

Either way, the code looks right other than the style nit, so if you resend
you can apply my tag:

Reviewed-by: Joe Damato <joe@dama.to>
