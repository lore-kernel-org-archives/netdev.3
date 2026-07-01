Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDF33FC5A7
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907923; cv=none; b=d029OmaF3hxFXiIK1vNyP3I2wHvNr7nJn0Fsj++fY6jnniBZjE5o1BF62kZUZH/P/CaE28Cv2VgmreLLbueg5eSibRqb0eISTS/qg4cmuuOyyl0AL5oIhqy35lIJ9mnoKr4rZLo4EQx5/Vydr6wawdDkQyE0UYmLfl6i+5jf5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907923; c=relaxed/simple;
	bh=ROlxj8Cc1VAGXf30YbaxSaZ37M2GQ1wwd10sk5YEUPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIqli6Zp2s7f5eNrUbzoEjipVlTZKvjPwfPY1pTk9Kos4DSCUNAss30WtdrlDnGP9O6yxCVSyfdA1TeUekd8gAh0SQm9eb+0VQey7aEfVPXetcwPw8FX6ELnwkk1sEPc6aMxvJYklJNbgGQnlwk15TJ2Pu0V4rjem+yLHRImvto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=DSJpN07v; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="DSJpN07v"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so4317445e9.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 05:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1782907920; x=1783512720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Ne/M8n0H/GY5faSBTuOE3v7ExKoklUKwfPoQLquDss=;
        b=DSJpN07vCljxXX9E/UAfroi91ZMm94P8YVqgv13iJxtUiNWFbaCl1z2RfR22vvppSo
         auxDnHg56pddhhVVSGoHEhYjiLeukLM+wwiQlRhqKxHee/LgMv9LocDWdlVjCannoZHL
         NbJeSrG9q/nkXAb5wgcMhmkSzJOikT9CxqW/ZRjds5i6P4fMdd2LIfZK7uFWpVlMcV1y
         I+Qn1ZAJDLDdC8qCBvuZD9RoHIoVudwa1n93LD/C4pA2RJovWqUDzM3D+9HEpFDHGIJd
         HWxQhjWSmMx3EsvqCivTygHSfJTulaOQ0jAKs/eeJDaZyQpD7pFtKBy8LvsflNNcsKeL
         hAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782907920; x=1783512720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ne/M8n0H/GY5faSBTuOE3v7ExKoklUKwfPoQLquDss=;
        b=MXeC8lWCNQAOMK0yDEPNP4coSBAXzizGuVEmCNsOwVfe8yYoaL/fjEyXc4SpqHwmGJ
         uG707QWVMfpPwJoYEf3wS/iAVSI9C1o4jpp4f4L9KBgP0g+ybiz4Rcyp3K8Ps3jMqzEj
         vX8wYL8jJ8j/Oy8uHks4UXW2gOS5E1PkKCsoogIKet1rI8CVZT1jL14ZZe7ftBca1voh
         4hyfc1IRHgTwGldQ98Hty6cyxRp4pwMHTHVnYVe3G49aRHqOtyi/KUAAjROz8qskwXDM
         38iUgXpqOMIbKctbXBy3SstckepVoZb5e6Fzp8M0W397bupEUZKuSH/CJKtX0DUsLFaD
         Lu0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8ewcZscMkPe7oBrl0rlZHrqNd7TpDsaTN9jya3c4t7ncP04xXaDgF0W3SLepfUcM2/qipEjLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW6G41o9yWZ7SXSiTmLnE9xGe0CWX8O/QSxSoD5QBLcZkpATqH
	JixtgNdZRbgM1paLRL9qV7NENxn6LFk7wmTzUzGQ4zJllJGt6sG09hGESujHDlSCJxs=
X-Gm-Gg: AfdE7cmEI7be8qoMwFRrjjmH6E1diSrtPeqmBaAAb8IEsQdtybpF0C2QImPQO0nEavn
	GTaP9OLX6YP7fX00bgmxwKcqNvlDZT91b1+OKT4iPZQL1Ljkbz6C1i+Avjm2ttEAj0PLxBzFi3j
	yvnEHu5VG95jicEjgiMCOt7EeJ8ru9nLS8jKuP1cLuJlvyyFvsfphQqHuDyIjozu10J89sIK3tK
	oLRTe0KuR+v1ngNe9PyqnacqD8uJv+dSSTLjemtmO8x3ywaAWsUv4m/V59bn2Gc6NV0+00pL6KI
	Jl13IGTDDAMyZvz1tzygM/OevBCmObLtY5MKR9Um59ggYoqL07FI5K6IX8qejntw2bGCrwQ23Ja
	Do8gb5j2NOb48l5D2qSe7yajClosXj7bewi1139LUH4Y1O8A7jGHZ+ADpfEde56Kvv1psDElSCu
	qFCkMFd1s0ZcMnYVcQHpfgmM9Y357ruEZ9rh3LRwd5mU8=
X-Received: by 2002:a05:600c:8b2a:b0:492:6113:d4fc with SMTP id 5b1f17b1804b1-493c2b56fccmr21817145e9.17.1782907920116;
        Wed, 01 Jul 2026 05:12:00 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4c89ccsm79485005e9.4.2026.07.01.05.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 05:11:59 -0700 (PDT)
Message-ID: <3f70661e-539a-4157-9e5f-1ee94a720519@blackwall.org>
Date: Wed, 1 Jul 2026 15:11:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] macvlan: no longer rely on RTNL in
 macvlan_fill_info()
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260701082214.2974946-1-edumazet@google.com>
 <20260701082214.2974946-3-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260701082214.2974946-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2026 11:22, Eric Dumazet wrote:
> Add READ_ONCE()/WRITE_ONCE() annotations on vlan->mode, vlan->flags,
> vlan->bc_queue_len_req and port->bc_cutoff.
> 
> Fill IFLA_MACVLAN_MACADDR_DATA nested attribute and compute
> on the fly the precise number of elements we put in it,
> to fill an accurate IFLA_MACVLAN_MACADDR_COUNT attribute
> as some user space applications could depend on its value
> and the attributes order.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   drivers/net/macvlan.c | 71 +++++++++++++++++++++++++++++--------------
>   1 file changed, 48 insertions(+), 23 deletions(-)
> 

The snippet that sets macaddr_count gave me pause. :)
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

[snip]
> +
> +	if (READ_ONCE(vlan->macaddr_count) > 0) {
>   		nest = nla_nest_start_noflag(skb, IFLA_MACVLAN_MACADDR_DATA);
>   		if (nest == NULL)
>   			goto nla_put_failure;
>   
>   		for (i = 0; i < MACVLAN_HASH_SIZE; i++) {
> -			if (macvlan_fill_info_macaddr(skb, vlan, i))
> +			cnt = macvlan_fill_info_macaddr(skb, vlan, i);
> +			if (cnt < 0)
>   				goto nla_put_failure;
> +			macaddr_count += cnt;
>   		}
> -		nla_nest_end(skb, nest);
> +		if (!macaddr_count)
> +			nla_nest_cancel(skb, nest);
> +		else if (nla_nest_end_safe(skb, nest) < 0)
> +			goto nla_put_failure;
>   	}
> -	if (nla_put_u32(skb, IFLA_MACVLAN_BC_QUEUE_LEN, vlan->bc_queue_len_req))
> +	*(u32 *)nla_data(attr) = macaddr_count;
> +
