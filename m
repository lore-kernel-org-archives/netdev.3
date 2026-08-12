Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A93231F9A0
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557779; cv=none; b=GnfjDYMuFBLtY6J3nrZFTzHRHrkNxVfs+dn+vFDsoY4dZn10ByE7Tm2JAtppUtDA70O81H6KvToAeYkDtSTH+sHv/l2GyzzEzI9FGsXSgfLO79jz/J3fPRbcaFa7ORxTbttAk00KAj6yoHBxSfgLw7B57yELAFxwTJM/5d8aeDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557779; c=relaxed/simple;
	bh=m5CeT8WhAzSjCBjp1LJg5899gJdAwkBeQxj42ojzn9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuXerWWvvks57N2S67f5C2Eb9NNSyRMdppyx1LVHBEkYGbIk4ZZ8cwgWJvq/QCv+Xm+izjVQergPCwCPIueBMEL3ay+VsCpalKdXaBgwxZk+04Sbmu42DDAxmCOXPN2NwrN4jvSJ9+dVWwfblLaZ5gaJldzTF7X3ZdpesXLzQwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Kx5xSU3o; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Kx5xSU3o"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3811f512167so1589747a91.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 11:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786557778; x=1787162578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCF6tNyL3eGwCWXz/OETIKl/yai950rhoZA+gNdH5hY=;
        b=Kx5xSU3oo3tCPEd9gPq8xABH/tNAglrdNEqpWB/3RExrgZ5oAB8Zoey90R3FoU2gTU
         ULCxD6FaodxVLAEkX6EsxZVKGNT7cNH7vFWQsLvivooy8Ts3j3lVp+vExXV3iNrfV3Wh
         5F9UDOdZr18BWp8sM/Dm1aTOfmiXa/C8xRKXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786557778; x=1787162578;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yCF6tNyL3eGwCWXz/OETIKl/yai950rhoZA+gNdH5hY=;
        b=GxtYM9MR6nRGiHTAoLwKixbO0IIIj+WOTt5H5+PuhbmcVHQIgthfvUP4naE9dCN8hc
         gvgUtbg8Mo9TO4ZHAX+/guuhPZYvTe42VPHV/CMaQYaaAGNyGpFYsfFX3y0uRY2HLFH6
         nxmmar1EvaHtLfgbzo266dfPB2CxpuurtFmyKBByh2eSgy1Umy5oiTQD4HUcRsTsvZGJ
         rtg2ancNwZSUEAbVzo8c3Kd+LAs7/Omfy44wazSefESvEA0YAXV4PnnpKc4RlVqEut3Z
         JaqJSorBKcLzNjupbbUvmmucZXBkQ3SJi1FDrNXCbziB8pPpVv1UovWJequG420XH+AD
         8zPg==
X-Forwarded-Encrypted: i=1; AHgh+RpTkyIIK1GCkmBPeVE3mbP7ueSAkD8xHTekTv1yKMypvjzivZz0EJizRtwaKOqMawshOD6bVPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn8GDBR39ArbjjRdvqWR2wK9yrffYrTOy3+CtquOZKCzriFHmf
	8m4b4ohWGIj/mUlK/Tdow0FeEZGOFPraULEwowE0aX/H9Qj7cVLPEY0m1Whn8u2iTg==
X-Gm-Gg: AR+sD10tNzF6B/y/3O3V95LmAEd/ndrVFitfdTHnmrL4JpeahE5htZUK5VQU10hXub3
	CItWFlthFiDkLD0Mx0aeBCmXpwnmkclde+qO4xKFdPwnn5iqWU2a3nT3SaLr4Qo5df46ro4Eo4A
	2Di+rdsyyl+229Y0sSkcde3ptmaWDHLjKKtzzoGld8eXl2UnAJt3TmwsN4iLjanqFo8y+8TJR/b
	3Le7xXB2a144+0/scnb9Jrbjk8BgqOXTTzr6CmGCinCZJl5/zicx6Sbyj3COnfWW7kptIlsAjbl
	dW3WKiEzrYzXv1Y7t09B3+JMPkbnMknJr8IMv9w0KRcMj0AfydsUOjmDwz8PjV2sGrxGaB5E8jF
	npGkP1tTdRJ9cgSaEzIG2jcv2jjs3gmSTsvVgC8F+ZNJOgvmQRKWfE6MWaYsFQcUDwvOQotb5ag
	B7PWqOYCrZh0FCCewaksKcAoMqMIUtgJMFS3vyjJg651h3LfXT1mWT9waoTcGDe14n3BepqQ==
X-Received: by 2002:a17:90b:2248:b0:37f:c97a:939f with SMTP id 98e67ed59e1d1-3931e05f926mr30047a91.7.1786557777645;
        Wed, 12 Aug 2026 11:02:57 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67::2000? ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931d80306asm49164a91.0.2026.08.12.11.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 11:02:57 -0700 (PDT)
Message-ID: <56e61c75-1041-4107-bef3-5029c8fdfd74@mojatatu.com>
Date: Wed, 12 Aug 2026 15:02:52 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/sched: cbs: perform rate conversions in signed
 64-bit arithmetic
To: Jack Wang <163wangjack@gmail.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Elena Salomatkina <esalomatkina@ispras.ru>
References: <20260812100044.38040-1-163wangjack@gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260812100044.38040-1-163wangjack@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

On 12/08/2026 07:00, Jack Wang wrote:
> cbs_set_port_rate() and cbs_change() multiply link rates and slope values
> by BYTES_PER_KBIT, an unsigned long constant.  On 32-bit architectures,
> the multiplications therefore take place in 32-bit unsigned arithmetic
> before the results are assigned to s64 fields.
> 
> For port rates above approximately 34.36 Gbit/s this wraps port_rate.
> The same conversion turns a negative sendslope into a large positive
> value, reversing the CBS credit adjustment.  This affects software CBS;
> port_rate is also refreshed on NETDEV_UP and NETDEV_CHANGE notifications.
> 
> Cast the first operand of each multiplication to s64 so all intermediate
> operations use signed 64-bit arithmetic and preserve the value's sign on
> every architecture
> 
> Also reject a non-positive idleslope. A negative idleslope can arm the
> watchdog in the past and busy-loop.
> 
> Fixes: 585d763af09c ("net/sched: Introduce Credit Based Shaper (CBS) qdisc")
> Fixes: 397006ba5d918 ("net/sched: cbs: Fix integer overflow in cbs_set_port_rate()")
> 
> Signed-off-by: Jack Wang <163wangjack@gmail.com>
> ---
> v2:
>    - Reject a non-positive idleslope to prevent scheduling the watchdog in
>      the past.
> [...]
>   net/sched/sch_cbs.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
> index 1c93469c56e3..e960c8e01ef4 100644
> --- a/net/sched/sch_cbs.c
> +++ b/net/sched/sch_cbs.c
> [...]
> @@ -392,6 +392,10 @@ static int cbs_change(struct Qdisc *sch, struct nlattr *opt,
>   	}
>   
>   	qopt = nla_data(tb[TCA_CBS_PARMS]);
> +	if (qopt->idleslope <= 0) {
> +		NL_SET_ERR_MSG(extack, "Idleslope must be greater than zero");
> +		return -EINVAL;
> +	}

Unfortunately this is breaking tdc because it's forbidding an idleslope 
of 0:

# Test 1820: Create CBS with default setting
# exit: 2
# exit: 0
# Error: Idleslope must be greater than zero.

Please don't forget to run tdc before sending tc-related patches.

cheers,
Victor
