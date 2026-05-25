Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936022D29C7
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741511; cv=none; b=Szg9WXwswgG2m/1N1O3laib6NdS15Ub5BmATt8JI/nNRjyGbKv/0i6XjqlrK6Zl9OLG/INjtCDaL57C7p81+aRuGpeOJmbxN8+ntskOn6Ev9kB+1p+0/L7l2AhpJiJRZfa7YnGdM9uGhgT/c01ugi5RXkdgnFMcqPZJOLFB44TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741511; c=relaxed/simple;
	bh=C+uBJrh7uNVXmQ5bc7v9TPOK5Xw0ozLsQ86WERLpkE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSrPa6MWGkSpga5suQiV1KBasL15g7qR1cbqCViB4LE6r65W9PO36mUcOW5g3juRtTcWKaQYF3SLBdlo12beq9BwTCDN04kK+KNxqg1KPpNgu+o/IXJh2oQh0IApH4doBqMLBlwfheav5h88K2lMcCD+fvrj95PoYhfChA2Jp8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luna7Tpu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luna7Tpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329021F000E9;
	Mon, 25 May 2026 20:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741510;
	bh=CDb+7noS5KJbm6YKc31a3LoHaeRtwVVfkPaES20nPgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=luna7TpudHmWdkTbhxLor41Vz7hLTRAFtx/bHaf9svIPR6l2FNjawrHVcflTHfXWX
	 TXzROQLyV86tXKxwR6vDINOK1NKSGi6aofpy8sh5myxCpzkyi1yzHUB8F7ssqrOOxA
	 djSTs1yOODBWfecuBEQuKKLn8iYRGRs64TmqByWAoAxkvFGOLpGavezH079hJi16me
	 ecq1w7PT6E6cnSDSF7u2wCKMGQ2TG8LndE9dgCS1rNMFpFzzaGWhyhvdW3wOJTVgzV
	 M1BM5XxoBFNLCNzXbBK/cfjiHaLmoj6FKmBQuvsR+IqyGOcDI3aM5T6LOlrkryb5/A
	 pK+eboHd5/9RQ==
Date: Mon, 25 May 2026 13:38:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [net-next] net: hwbm: fix buffer leak when construct callback
 is missing
Message-ID: <20260525133829.4fc8d504@kernel.org>
In-Reply-To: <20260521101618.1099537-1-zhaochenguang@kylinos.cn>
References: <20260521101618.1099537-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 18:16:18 +0800 Chenguang Zhao wrote:
> hwbm_pool_refill() could allocate a buffer and return success without
> calling construct(), leaking the buffer and letting hwbm_pool_add()
> incorrectly increment buf_num.
> 
> Free the buffer and return -EINVAL if construct is NULL.

This code would make no sense if ->construct is NULL right?
If you want to touch this code you should remove all the checks
if ->construct is NULL instead. All in-tree callers (obviously)
set it to a valid callback.

> diff --git a/net/core/hwbm.c b/net/core/hwbm.c
> index ac1a66df9adc..284b97c488dc 100644
> --- a/net/core/hwbm.c
> +++ b/net/core/hwbm.c
> @@ -33,11 +33,15 @@ int hwbm_pool_refill(struct hwbm_pool *bm_pool, gfp_t gfp)
>  	if (!buf)
>  		return -ENOMEM;
>  
> -	if (bm_pool->construct)
> -		if (bm_pool->construct(bm_pool, buf)) {
> -			hwbm_buf_free(bm_pool, buf);
> -			return -ENOMEM;
> -		}
> +	if (!bm_pool->construct) {
> +		hwbm_buf_free(bm_pool, buf);
> +		return -EINVAL;
> +	}
> +
> +	if (bm_pool->construct(bm_pool, buf)) {
> +		hwbm_buf_free(bm_pool, buf);
> +		return -ENOMEM;
> +	}
>  
>  	return 0;
>  }
-- 
pw-bot: cr
