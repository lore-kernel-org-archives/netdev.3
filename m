Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99113CFF44
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726494; cv=none; b=GwnZPESXZm0FrbJ6D/VP8QPPricGsTSRdB6/RLAgWFYznmXDHcTEc+48tqYaO237ZKLD47YKu8ArBCXCUxssEvR+EBUIz5gnKlfzTM1k1PFVrxHKj//E0GyeI/wCIsOjvfGtKjomUQEbV4ogJJ5BHFowUI3OrfJL/1deOhqafao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726494; c=relaxed/simple;
	bh=/vjN23W+dHdII+udsD60VC7YSLOh9wlw9WDJhexKqkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gcrv3274UOV3+kq3ottHq1+msActGUuljPZjsB/i5TbGy4Qv+xeI5tVtX2b1Yme1x9oeFTYHbwZUx8NNEdifZVatUKAjU5I4G1n6B+ZsOmcsb46K97Y9UcQ6H8+KSE8I/C9U87CU7yKkAJx/e00KQCYaV6TZ5XjTRoIbmNCJwi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=DQZO7z4W; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="DQZO7z4W"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-451fd21113cso1562516fac.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1786726490; x=1787331290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZLoEagl5oJlo/XqIhtXMMFJ7ceg3fIAgNhpZ08BUP8=;
        b=DQZO7z4WCwQp8ZDJtPxTbiQiXJqfBk8N/1ZmqkTHNdg2sdR4h4j0OdQTUXFjvWKLeN
         J/MsHqxqrBehsU6DQS640DZEemQp8sSYwX080dSuWROfOl4JquN9n8L2eBc85WxReVJ5
         yHCSyG5Whaky7wBcD3+ztsq0OoykdBK01537s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786726490; x=1787331290;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZZLoEagl5oJlo/XqIhtXMMFJ7ceg3fIAgNhpZ08BUP8=;
        b=b353Rrp3nE7dSPoqfrfv/YVs9tRpEcbm3zPhFw94nk/VSHqXdwnLQ1PCXSpY6s3Qss
         j0nit/+AiO+Cpq0MPwtEWxwwjitlPhWfv+YT7aUztYdY38zzO9BLAhIXR6cKLsETN14V
         IzaBDwOoK6HPZM3rh5abqGTfrPB2ikvcXGJI/AfjCjncW7IueH/1nEuhAZmil5X6Bc/a
         l0dzUzGTMUwJbUCOLw9k4117JUUZxJvQ7UGbydLe5wjkWkBR387NP6HB6Z+WyoS714Yu
         /KKj2iCbjMKXuV6x008LytnFfE173Qk6aBc5ULuEyB9tx4tklbhCjbUP4eE++EtRMrw9
         RcqA==
X-Gm-Message-State: AOJu0YxWcBkJdbFWFSSRdZo47gDyt+TeieYOhGTpU6RvE8VWFGEMfoeg
	6S7TIMmoyNkfsmYGjj9efxUIT3rd5cGLkZBRcWAU6Z/3BseIQVnxFHLMeJDt6MjtZQ==
X-Gm-Gg: AR+sD10nAK/NgBr89Li7ADJe3QMMYsmF1uQaRvakBW5H0Pg9jXUOPxCCFEUC6D9FzkJ
	nbPwAEEc61v+wm75bQ2uOUvf5+cP8YHI/ytBXNNQ0p0neV8UIuzeuNkzU3fTyq54bQGMF2Ycck9
	+V0LmBxeDxA+ZdBwbL9tlIfloXB41L0oKebuiVTn2UNUXtInM8mvEGnDLk6WekKlU/j2oV1NJvY
	jqxvqdL43kYzIyjLipwhPQl/hfOuIS8Hp2EIc9P+Y6gIzD2dmYMRCL+W57KobsZOgG6ljmrnV/1
	baeU7cvlftuSoem5U0KlGUik/jdhkWrxcaN7rmyrZ8nzluCcI7e/bshXt/LBuWLnibzveo1SfBa
	wfjo+2bTx+f21q/OII/xfXWYnfWfXhKa/6gTkfRq7Q7aCAF0copeKBWrZaHLFV5/u5LJfP3CZVt
	h88ZCItvWanP203XeB/1U0RIGf7tex4wM9cdcNXLBh/ka/OxXhkKwqOAY=
X-Received: by 2002:a05:6870:a096:b0:457:f4e1:a1e3 with SMTP id 586e51a60fabf-45e64baa472mr10124514fac.7.1786726490406;
        Fri, 14 Aug 2026 09:54:50 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-45e8f976bfesm2827606fac.8.2026.08.14.09.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 09:54:49 -0700 (PDT)
Message-ID: <4cc8fa8f-e827-43ea-8195-3e481bd6ee48@ieee.org>
Date: Fri, 14 Aug 2026 11:54:47 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ipa: balance runtime PM reference on remove
 error
To: Ruoyu Wang <ruoyuw560@gmail.com>, Alex Elder <elder@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260814134047.1387177-1-ruoyuw560@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260814134047.1387177-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/26 8:40 AM, Ruoyu Wang wrote:
> ipa_remove() takes a runtime PM reference before accessing IPA hardware
> during teardown. If a concurrent modem start or stop keeps
> ipa_modem_stop() busy across both attempts, the callback intentionally
> returns without releasing the remaining resources because proceeding
> with teardown could crash. That return also skips the matching
> pm_runtime_put_noidle(), leaving the callback's usage-count reference
> held.

I concur that there should be a pm_runtime_put_noidle()
call before returning, to match the pm_runtime_get_sync()
earlier.

The exact code you're modifying here was added by commit
a92dbb9cdf046 ("net: ipa: Convert to platform remove
callback returning void"), but this particular error
was present before that.

The comment above this dev_err() call is rather confusing
and repetitive.  Could you try to clarify what it means,
or write your own simple explanation to replace it?

Otherwise, this looks like a good change to me.
Thank you very much.

Reviewed-by: Alex Elder <elder@riscstar.com>


> 
> Drop only this runtime PM reference before returning.
> pm_runtime_put_noidle() does not request an idle transition, so the
> hardware and resources retained on this exceptional path remain
> untouched while the usage count stays balanced.
> 
> This issue was found by a static analysis checker and confirmed by
> manual source review.
> 
> Fixes: 923a6b698447 ("net: ipa: get clock in ipa_probe()")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>   drivers/net/ipa/ipa_main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 788dd99af2a4d..aab38fea91c61 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
> @@ -975,6 +975,7 @@ static void ipa_remove(struct platform_device *pdev)
>   			 */
>   			dev_err(dev, "Failed to stop modem (%pe), leaking resources\n",
>   				ERR_PTR(ret));
> +			pm_runtime_put_noidle(dev);
>   			return;
>   		}
>   

