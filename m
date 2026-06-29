Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A6240D58C
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741544; cv=none; b=CkKwftm11mKT3KXW2Rx+d9zCg2G42Wke6mE+7cMXY/jj7fesdkvM+GFryb3mSxxYAvz6n6Db2CoAJagNMJgBUOG347WbrERyMYnIF7B3Hj1EhWMRZevtbigmo3IpNuOJSAjZwNmgKuOutsudXJEWpge98b3AfOD+KmYj+FMP2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741544; c=relaxed/simple;
	bh=KtL4BpmupJxevVTN0BsIXstXZlrPZhBbUhbYrf9LGFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgAOL1I9jAAwzVIBQh4DwgUZlcyZQi0iSxXlPS8nAdeLuNWYgaKVaMzEzFzaEHAPZ78ScIy9l9ESvVDzwV8RBCHxjwR8Lf4OHc9PPMgkmHOnWBKbjFuhrKzwP9aEHUhEMWEt9eegvzHl8+GlEWxV1QzR59Sk1EGKKv+KwbhIT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=jsQOVvPk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="jsQOVvPk"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-46f92237fc1so216649f8f.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1782741541; x=1783346341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H2hMYouoBeVpY2zemXppJ2FB9RiNJKITJKx7SI0axBE=;
        b=jsQOVvPk8CQ7Qbsgtmque+ZS+Vjp5owb47kMzliFaKgVkHt1A74+Rq3ZwQvGnB3mnp
         Ymc5Hu9dxSE5FRs4fwJdsEOiRghF3f1eMwN3LmO5l08nDi8W0nXtetBk2GDqcVVsznDv
         XaTuZhRj2yW4+NhqzvcGQC7oPlloaFFNxlcbOzDHQvppOiHaYM/eydvrOoe2PJRLaMlV
         nKY2eCpsp3U0iPtcB/xopQJyVJvDFhr6SOWxAhQjLpCurng6zBq17Trba2uXQAJkOMF2
         McDm8p1i2eKY97bu+dR7kfXdIoXEvo3DuuCSzSvNPnfSkkA6Bc2iqeYSVUul8X9IUEeK
         4rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782741541; x=1783346341;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H2hMYouoBeVpY2zemXppJ2FB9RiNJKITJKx7SI0axBE=;
        b=rjexEetejDhCVpcgwOFlNF82x8DEnfv0HeRyM77PUWkvQKfkMZdIaGw1v5xw7Et2f7
         e8nIPBC9e/F9z8J27MyT92BbFtGrNmBegYh807qq9JAiNYpiL/1nm/auwy8btfudgexJ
         YTn0Iqvbwtt4LjVzW4LzYNokxGoyUxEU6tIcvaczWMhnihnheGmSBrvMroMdieyXHfKN
         UwgMHK9M5Gye4BJTUmd5K+vvT3Bf2GNb3FB/uJRSUqFUhhV2dnfflOosThqqK8tj1Jnx
         PRVRhKyEcgT/aqgMwnjBJTtdBqHuh9HN1ZukPrZUasof+g7kA6Eumnztof4hzpFudgre
         TPDg==
X-Forwarded-Encrypted: i=1; AHgh+RrE/ALIkfU6IFsb5iypDPjY0hi7Siv6R+NMvMST6dDye8j6PbXsE7pDbMId8wSZAHym/k8Tw0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLhydgILlAtnPbScgiIz/9k37PIbptO77Lee1WqyarbCJmrLEc
	sXrwGbdBeOjj277VUhpRSDfJi1WVi/BpSbcEqedb96fj6MT+TzQ8bO92CkrL5+PRq6w=
X-Gm-Gg: AfdE7clgsXGH1Vsf/mO1PfG3K9ezD2UQtrzWA6J+JYG3VgrBVnGu/VQEsDkNceFBSEa
	IBQ790029uwyWjqWlAlLP3SeBcchCT/GXB9JxgDDeWbZ303XSSG/efqckauBEKFgBSdyj3P71j7
	quTxHcu9vpJillF4PkgymfbfwMva2mJfS51vkwtjfDMI9giTiYP7Pyn0iQFVv1o+jXznRHe+FCn
	gPbEhFGwVwo4i7FDLbI7qlLwXjHm/zKyNMleSA5hCsLV26WuIQiFdaQBjxyOvl0LxrfjIw70fZi
	/S6CwX3VEQzR30h1Ec0gCgh3L5GCLMvP8HFOZe8V26FbkfGJZhgsLC7YC/CdwvnQKQprZTA8v28
	PX/wlaZgkxVVeBDUjvC2930wuD07oT1ar7IyHliE/Ap+TaYfBzKdvN++ojXgQgtUEOVlEeB/qi3
	YkKnu2SO/WX3HOn6MacYdJziYAiJyGqjKh+dpgkjCGDlvUPu254peK6Xa737x9MDIdFQ==
X-Received: by 2002:a05:6000:4210:b0:46a:6474:8392 with SMTP id ffacd0b85a97d-46dc235912emr15722207f8f.7.1782741541235;
        Mon, 29 Jun 2026 06:59:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-472c7bec9c2sm15231360f8f.12.2026.06.29.06.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 06:59:00 -0700 (PDT)
Message-ID: <dd26c96a-8c9b-4dc3-8eb8-a1c6a8842aab@6wind.com>
Date: Mon, 29 Jun 2026 15:59:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2] ipv6: honor per-interface proxy_ndp in
 forward and NA paths
To: Chenguang Zhao <chenguang.zhao@linux.dev>, dsahern@kernel.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, netdev@vger.kernel.org,
 Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260623085600.396401-1-zhaochenguang@kylinos.cn>
 <20260629061831.1211922-1-chenguang.zhao@linux.dev>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260629061831.1211922-1-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 29/06/2026 à 08:18, Chenguang Zhao a écrit :
> ndisc_recv_ns() has always checked both devconf_all and idev->cnf for
> proxy_ndp, but ip6_forward() and ndisc_recv_na() only looked at the
> global setting. The original commit left XXX comments in these paths
> likely because idev was not available there at the time; ip6_forward()
> now obtains idev from IP6CB(skb)->iif.
> 
> Honor per-interface proxy_ndp in both places to match the NS path and
> allow setups that only enable proxy_ndp on specific interfaces.
> 
> In ip6_forward(), idev is looked up via the ingress interface (iif) while
> pneigh_lookup() uses skb->dev. For ND packets this is correct because
> vrf_ip6_rcv() does not modify skb->dev for neighbour discovery frames,
> so both refer to the ingress interface.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> v2:
>  Per Ido's review, the following changes were made in v2:
>  - Target net-next instead of net
>  - Drop Fixes tag
>  - Expand commit message: XXX comment history, idev vs skb->dev for ND packets
>  - Fix subject prefix
> 
> v1:
>  - https://lore.kernel.org/all/20260623085600.396401-1-zhaochenguang@kylinos.cn/
> 
>  net/ipv6/ip6_output.c | 4 ++--
>  net/ipv6/ndisc.c      | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 368e4fa3b43c..c4ca4a813479 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -579,8 +579,8 @@ int ip6_forward(struct sk_buff *skb)
>  		return -ETIMEDOUT;
>  	}
>  
> -	/* XXX: idev->cnf.proxy_ndp? */
> -	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
> +	if ((READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
> +	     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
As stated by Ido, this changes a 20 years old user-visible behavior. It suddenly
may enable proxy NDP on a system.
I was thinking that this kind of change was prohibited.

Regards,
Nicolas
