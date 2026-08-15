Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97E62C3768
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786755943; cv=none; b=mTAU2UFP1ghrMdLKFzEDeCDnVtF1WHJW5MzPpw54O9wumIs6sRuEKgrGMRW/RJenhZQmT1AIx7zYF7WYMf4e2zpmnd8PEMLBGeMdse2qzUzywcHNNOyEXPaY8UlJAkfWUth3WkwZOCjTR6U9hj+6g8m2MRYW/e0zW7V1N24bghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786755943; c=relaxed/simple;
	bh=RaNUnABHFAZxh2tCweFZbu/vd0qHX6aPMsu31EcizMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKOEPDMnnf8936hdPnNfxWa4GO+nLFYcShov1+bsVoB46+GABy06t/x3/y3nsjwjb2Sj4ZhWD4WBXPq3abDb5D88JgYeSuADXD3II/y5jY4h3jjOMrP1YlhVtCx5b4/uXssQSAS+1pKt+ejp2AFCDEhTawyfx6CeAxi47xuCS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-4730b8edae6so461567f8f.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 18:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786755940; x=1787360740;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/qWu3OPyPzae/szxt8i2u7TrHzlI1Tw94MmPg8jResw=;
        b=RB2ewAaPVap5KyHDPMmDpRGedwAdhUsXRGDp+DunO+zL+Kep21AhWaBXR5Bzmt+YX5
         0YHwmVET1Qnc3Q6aVUhQb+ADcTrjliQq1EejuNyLjmcgc6/e4f4o/Y1BnY4xRroy8vu8
         apk2SCosagLvCSzTaU6p8QRusG+2njnzZ/2nGwUHsYquPNaPwWyxf4B2pIwUuMHf3g8l
         otOdTwlOOm6L1BYlsHG4TR/ElVrErFquIeKKi4vCmiRjCLRGqvR20PMzT8liJRLTmDB9
         3hil/AVIj1uCbhv7XByr0mWp3YW67+efZmm2CnUtaxZxKNmAI0/cKhQ6L+L/Rl++aBhs
         5VEQ==
X-Gm-Message-State: AOJu0YwDmX4oj5HRnbxLHWnGiXKY7IlTGrFU7zUgOHNZqMA3Prn5xr6B
	497t/F9pIHccX/iZT4+2AMuwe+qLcSE1BLS9c8YGrRe6G1GMSqKq8D52
X-Gm-Gg: AR+sD13TfRdzIMEistxpLvaeYB6jdhrOPJW9aprYnSmjr99fPqO5sXcwF/onUCZVhH6
	SJd0h6yPp574wK+zTz25kgAIPWw/EX0s12fQocIEKaIQKumVc/ghsC3ERhFAFq1+az27INS4Gia
	jDPd92ZohD4hh123epdqfKRf4kwe0HqB1rKMANgXQSjKQcl/S6uAOX9jUlnF06sywVUWBOLbkgS
	9JGxniSBYyT5IL9maPHnDGirLAT0rys9RO8YEfHwB3df0HDLxA5EPKjvLty/fXsMQQN5Cm4Xv4x
	w8gxQx7EoymzGO1XTzANa0Rj1FcHlw2EKibFNbSbexHy4nzJuJFxotjz9b9epgYHMwN2PsG6ji9
	RocuIo3Szw7dj5sVq92VMdvlRTPo6Q4qT8GHwdS6oFD/o760NRXKlOSZq074ypFu/NkA3kaV5M9
	US2Z2E11ShHrbVEBU17H4wqy96Pl2TjmBYEAb6AS1EbIrody2daLuwuFpLYBnP3sPdO9YTzNPdw
	TXR6Q+dKFhwUXqr
X-Received: by 2002:a7b:c4d0:0:b0:498:1595:be7b with SMTP id 5b1f17b1804b1-4998792f242mr102892195e9.4.1786755939885;
        Fri, 14 Aug 2026 18:05:39 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b203cfsm83100405e9.3.2026.08.14.18.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 18:05:39 -0700 (PDT)
Message-ID: <fbc62629-9c81-4a01-8bb6-7a19635b4b1d@ovn.org>
Date: Sat, 15 Aug 2026 03:05:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: openvswitch: fix nf_connlabels leak in
 ovs_ct_init
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, Yi-Hung Wei <yihung.wei@gmail.com>,
 Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eelco Chaudron <echaudro@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
References: <20260814134040.1386967-1-ruoyuw560@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260814134040.1386967-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/26 3:40 PM, Ruoyu Wang wrote:
> ovs_ct_init() acquires a connlabels reference before initializing the
> conntrack limit state. If ovs_ct_limit_init() fails, its error is returned
> directly. The pernet core does not invoke the exit callback for the
> operation whose initialization failed, so ovs_ct_exit() cannot drop the
> reference.
> 
> This leaves labels_used elevated when Open vSwitch pernet registration
> fails for an existing network namespace. Subsequent conntrack entries in
> that namespace may allocate label extensions even though Open vSwitch
> failed to register.
> 
> Drop the connlabels reference before returning a conntrack limit
> initialization error. ovs_ct_limit_init() already releases its partial
> state, and the original error remains unchanged.
> 
> This issue was found by a static analysis checker and confirmed by
> manual source review.
> 
> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")

Should add Cc: for the stable here.

> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  net/openvswitch/conntrack.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> index 95697d4e16e64..fbaa677144143 100644
> --- a/net/openvswitch/conntrack.c
> +++ b/net/openvswitch/conntrack.c
> @@ -2001,6 +2001,9 @@ int ovs_ct_init(struct net *net)
>  {
>  	unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
>  	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
> +#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> +	int err;
> +#endif

No need to guard it with a macro.  It should be cleaner to initialize
as zero and return err in both cases in the end.

>  
>  	if (nf_connlabels_get(net, n_bits - 1)) {
>  		ovs_net->xt_label = false;
> @@ -2010,7 +2013,10 @@ int ovs_ct_init(struct net *net)
>  	}
>  
>  #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> -	return ovs_ct_limit_init(net, ovs_net);
> +	err = ovs_ct_limit_init(net, ovs_net);
> +	if (err && ovs_net->xt_label)
> +		nf_connlabels_put(net);
> +	return err;
>  #else
>  	return 0;
>  #endif

