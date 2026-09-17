Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA524E432D
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647068; cv=none; b=RZFSGWDBrSovsHtMC8WQ/nlfvzWvBLLR3fhX83cwPR1IZN/kHHyvFygBfGHZaY+M2RuleyX1drTvMr8ZnsP/eleUcdPXlNdvnbj1JwBKEe7Y2k6fvPgXcPt/WFuhDsHPSNQadaJuLxU2omTXZtta6eiGdghZf6InEbc/ASu/GVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647068; c=relaxed/simple;
	bh=2IuuBesuhtQABZX5aTgcPIV5cqFrtbm6oW8Rke4nfe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRMdF6+GVXYfmHwjD5HuKUgxui920dm1ZYqMNWmxmaI2rb4LzRHRK6tuzFeIyYPX5ihYGH3UqQ+bLEFsmmWk1XXYomft6ZOOVrBXwwE6GwO1XV5dV/lq/nKH7PrJZ1GIhCV2mxwVBmf4MODxLGDL3pX0ohpyZpx2G1Tt5XlcTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=KGZi5e8S; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="KGZi5e8S"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-7fcb425fc2bso483110a34.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 05:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1789647049; x=1790251849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HHax/jJrt/1XwwtW9NMv6p1y2gNa0xD70FHoF7NK73g=;
        b=KGZi5e8Srbkk19d0xhNeSKueOlytHXJn2Mnb1IgZJcFBE63RE7LSz5Zq1kSQjuS1qg
         h5n3EU2zFAEv+PLOPQnr4ff9LN33FG6GUXiLB5TpEz3QATMvIF9l8MFFE93aD2DHHfGj
         x3G1ckFmdbMIUdluJFQvViAKg8mohr5QEmxOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647049; x=1790251849;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HHax/jJrt/1XwwtW9NMv6p1y2gNa0xD70FHoF7NK73g=;
        b=lhNnP1Cw6VhQcgsAXXe3LucT/gZ5Ufx2rPCIlIOipIIvkAlaFS9AjAjWrlW6rjS0wI
         Aq3FkCwqH2IRceEyVP9W7MqyMDOWHdWiaiN6sZex8sg2ShOsqNMW+iEZE6CBmR/n6rzc
         lTnKz3IUyABNeW9ZDHS0syIjK7QWEhn2K/GPh9D5gOjzmfP7pBLbWtIuNLeCCeGi+57A
         2gSYQC57nqleRoC0S8Zz8m0kpdaHawcUGZWWs4qdo0e0O4RW7mlPJSnxnO3cniLOWyuM
         mP29iYboWO+JxGTN3xgqQ1dPCcyJtdrtCIJ6WIlT8eUzQzLiZx44/JXpgqVb3l2F2U9m
         w+Vw==
X-Forwarded-Encrypted: i=1; AKwUvBzeVFHheviRsxZPttweljPWhZjyzHl+lzwRTbhztV8avAg5mok3Bj5U34HMvqCeT9ABrpz28PQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lzu9uicfFO735QomSAhAD6e8aVfMeShevGW5rB37LijwMEPeiH
	cMOOdBf+SWxl5p46g9/cJPcSpmv9tCJM3wz+X8bsNQVyFfkF/CaKHoGFzgGqsx2MX/sUS6+5iWP
	hVhHEGQ==
X-Gm-Gg: AYBFou2BvOSNxAZWrU+WMBA4M+1UeteRaZCbHAJWJjV4k1JjfhqBG1Mp3RQlypIcRu8
	u/admjoWRI4bUWY84ER2DJwJzhZsZ0Kcci3+BjK8CwMBvyr52mHaf641jzolnEs92ClDuqI8STB
	RdzH0WLpDOEmuRcC9N5UG6JaQlLvX7bgy0XHazQTSdAGuTHwWKLMzlFIHdqYDq0IifLDVGP3qSN
	BA3t278udXjSaD270fZaGsd7pfvCT4TfSF83hJpa2GsF2ExtldGZe+ja1NQZv4oEOkiaOWh/jJC
	HLyZHekkRnuAUXjly9DXIcjAGv9JvPGoabc4P8Q6p2NUbXYhxq+5k8TjrhdWTW8B8cInI1GgVOd
	6fXWEfaVP28ZVuYqa//xr823uC+YoJ/BMUmRc0BcDYMBh+PxWgC8/WVdYy9++75zBkvFuBPS+wV
	HLL422rtwgmtnswlSY6wpCTFwQ5+RXZIwdVgeCq+iyDw7k7CEUcAw4cTT8oBy+S7dVAg==
X-Received: by 2002:a05:6830:640c:b0:7fa:5c49:5258 with SMTP id 46e09a7af769-80b2eb61acdmr7602954a34.31.1789647049145;
        Thu, 17 Sep 2026 05:10:49 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-80c466a2e6fsm2510405a34.14.2026.09.17.05.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 05:10:48 -0700 (PDT)
Message-ID: <7509f005-709d-46d5-8554-b9d2fd0cd218@ieee.org>
Date: Thu, 17 Sep 2026 07:10:47 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipa: Fix runtime PM reference leak in ipa_remove()
To: Wentao Liang <vulab@iscas.ac.cn>, andrew+netdev@lunn.ch
Cc: davem@davemloft.net, edumazet@google.com, elder@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, stable@vger.kernel.org
References: <20260917115115.2149796-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260917115115.2149796-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 6:51 AM, Wentao Liang wrote:
> ipa_remove() takes a runtime PM reference with pm_runtime_get_sync() and
> is supposed to release it at the out_power_put label. If the modem fails
> to stop, the function returns early and never drops that reference, so
> the device usage counter stays elevated forever. Release the reference
> before returning.
> 
> Fixes: cdf2e9419dd9 ("soc: qcom: ipa: main code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/net/ipa/ipa_main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 788dd99af2a4..aab38fea91c6 100644
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

This issue has already been fixed.  See:
   6b9eaa61ff2df net: ipa: balance runtime PM reference on remove error

How did you find this problem?  that commit indicates a static
analysis checker was used.  If you benefited from any tools like
that you should probably explain that.

Thanks.

					-Alex

