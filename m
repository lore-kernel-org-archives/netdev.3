Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C376B3AEF2E
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811602; cv=none; b=TRCKPrjwXcKJUnqC9UBeG6rFC/ktGIa6RzOz1nc/7TCMhSI4AJFk9ia0tKJOUtofnx3bzy9BrtnGRkdsbtHOSGFEDadVOVc1gIUF+bnzZ5GI/jpU7MG7dmTN3hVsE1wGmm0b+FShHQAB6yg5Wu7t1HPJR1Yxzy7pgeG0MJOjenw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811602; c=relaxed/simple;
	bh=M4VWiUCQeOwlizLYFF/rRZ67WmcYGiofBmzukjFBRco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1DuQq99ZG+tvZ0KQcacZ7JQXfrXIa1z6yIIoKgSF5R7/bQHp8Kivhv2nrTyQogHYSazj2zUPZHWM8e+V5rqUxOd08L5QB/XX5xeNbLVYU3ssjPftlfLiUIOEgjs1unxjK5uIUHlJ5xkpTTAtM+OHwQBUv/AfPuKQRsEf2/woBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D529gbfy; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D529gbfy"
Message-ID: <c547f257-c6a5-4974-aea1-ba4fd477e4b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779811598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wU0mi45WaGLnNqLrcCRRP8WBi0KV0SIC8OHjq2Jk1M=;
	b=D529gbfyzFFMI0UetAl5fw0JbGEzncy/MFMhll5WSBX1bvoXc553/LvgFFaKIsup8yYRZT
	R/tbfxpguqwmNEuExOoNWyg68lIA84oMYyFuWzoxNisdEzdzYYbv7ACMr/dYRVCuTQ3C/v
	GxJFsZzFROQbXvJ3VQp3z/3MLy40CKE=
Date: Tue, 26 May 2026 17:06:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 05/10] ethtool: tsconfig: fix missing
 ethnl_ops_complete()
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 haiyangz@microsoft.com, andrew@lunn.ch
References: <20260526153533.2779187-1-kuba@kernel.org>
 <20260526153533.2779187-6-kuba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260526153533.2779187-6-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/05/2026 16:35, Jakub Kicinski wrote:
> tsconfig_prepare_data() calls ethnl_ops_begin(), we need to call
> ethnl_ops_complete() before returning the error.
> 
> Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> CC: vadim.fedorenko@linux.dev
> CC: kory.maincent@bootlin.com
> ---
>   net/ethtool/tsconfig.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
> index e9db4ee2299d..fc4f93cfa459 100644
> --- a/net/ethtool/tsconfig.c
> +++ b/net/ethtool/tsconfig.c
> @@ -69,8 +69,10 @@ static int tsconfig_prepare_data(const struct ethnl_req_info *req_base,
>   		if (ret)
>   			goto out;
>   
> -		if (ts_info.phc_index == -1)
> -			return -ENODEV;
> +		if (ts_info.phc_index == -1) {
> +			ret = -ENODEV;
> +			goto out;
> +		}
>   
>   		data->hwprov_desc.index = ts_info.phc_index;
>   		data->hwprov_desc.qualifier = ts_info.phc_qualifier;

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
