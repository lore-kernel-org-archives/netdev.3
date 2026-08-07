Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F1038F64D
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 04:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786077859; cv=none; b=JNGw5Dsas4YmcCl3hSC2Vi0ZpUpjRY3Fj1SsiXMp5+dq7cKysIFwcG77zpsu+A/dOPVSlewiFhVA6q+OdNDgHnVKtkxbrI41YalD6oF+oY1JrfSx1es++3GgmXKBWlphlIeLv72ydbXdASbtkYl2HIxHwVG5hb9hY/4z7fDGIzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786077859; c=relaxed/simple;
	bh=fNUAVSh87gyqiRUTF61Kq6TTInm4rWrlJXeXNfgPN60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoMy8cDS05Qw8iQlCIVbnEIQJgUQ4g+8ZQDBwKJSB42794N3UUVyVLgi3BSP2bN6fWysWG2nvSjZyVQGbDbO/FiIMA8k93/+2uHi2SMkzjl/dR62WUHCGG2+TBmPSyG2jarSYIqjpiKpH+DKbUP+EZMwb9koMRlx6VZNtRu769s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/eYcpES; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/eYcpES"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38101f85591so1488018a91.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 21:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786077857; x=1786682657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ABwdlKjS2wcFImpU+xFj4AEYt0rG3aoP9rVyKaasM0Q=;
        b=P/eYcpESyz9DQTRtYHn0U5LVgBUiwbynHLlcgA3jZc5MBfurT9FVwoh3u303Sf1bgK
         Pu0rn35jnJTjioTajlZMfw1DGy9qsVNWomKCkPcOJZ1vW0r4jtoh0NzgFfuWynm0i0yK
         vbsAI+7Y4Glz/lT+SMeQtXaCtgm9LG3uyWbr/se4HNsx0udij13s2iNva64CPvS98lYI
         /AYjVelJTIdzaC1YXCTva6HLN95cRQQmk8YOCxAAHJizX8IAZavvTvs6gSarqzB74gxz
         nLrXCazEH+RuYN4pDH18kEuqzJ8L+MIIeBiisWypJn9Rm1xsn/gPzEObZkyPPpWmezav
         T1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786077857; x=1786682657;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ABwdlKjS2wcFImpU+xFj4AEYt0rG3aoP9rVyKaasM0Q=;
        b=MZ/kTFjmVjnFN7Ks85EnMG5PCudw6SYqCSnbqymyLRgIwxm7Ki5aUHWcku/ObkCanN
         zHfKhj/rif8rFT/j9sapHE8p3hTgHLwc33rGRj+1q/AVQrgkCfHcHQ4ejY2UHq6sIOzB
         wcCoFU7TknUQMKQy5Y2lKnAwvV/SVUTpEdKa4PAXMPUTyA3FthkVvvTNzJVUDZ+uP0Us
         AZ4eEngTEpaYltsxf9eXN8L2W/6NFqMlsRVKRVn/R+Gfb240crnHPbKq5n6kDPjYz14G
         xgn/M94eqJoD7NTOR7Ox4vhf2EJSol49gqt/3GiP2fZLns7QX/ylYPRXHiEaIkzsOVpo
         4Z8w==
X-Forwarded-Encrypted: i=1; AHgh+RrTXnCxZtoBhObY/71dQIfnFraguGKrjtlJdok0Oh5jIy6v970k97sBxW0rQlsssqolfsD7IuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3x1eV66FbE3kmsDxGM0rksMD6n25UC5SdBCuVLH09/7hMCJoU
	/2BYbwLtCnyTfR9l/LrgYTEMcXmTI6zzHaNJityLLzFQTOt71NXzedO2
X-Gm-Gg: AR+sD12qQtQnMmBiHguoQllkQn231FRqe2hI58HIAgTKYyPOj0y0tCziZAINIiFDWk8
	YXoMFBYWNlHbmsnSXrsc9uUbBqwCBccC4Hvq6Z0V9ZAbgGXWtwzff7hQIRIN5SqbCtdk24vX8AO
	9ggsxR3yJ1velmFovVwfOTc1qX5/dPo/L77Oh1A7/02qDKm7w5FFAJCK3T/yqHv5C6/y4/x/PrR
	XkIGVHZA3B06AobwlRowTXcVLjAHoKncpHz6bIgkwHNMNaDtsjppy3zLDQ/c2GMFTgM8oewnqvn
	VyXB21wvVAa0yLArMZXgtILleW6xeVIIyS2J8o/dU9ahL/dYs+sdueAmpjcwO6zlnp9KONhWwqc
	PC0yHkWgLEAEGBhD1UIHqots4YWZHIX1pQ4P48n2fhneFnC9ATLj3EVMW7i2ZzG66xUtilEGPa7
	JvEthjZHxHAaAI7B/BYwBv4Xt6DVMhomNSg/fX0Pep2GnNI/BSZqGbxtv84vFdA7cL/nnlu/YUr
	IZjyPCd32BaptYqyG4TUYwXbfwvT2Py
X-Received: by 2002:a17:90b:2f10:b0:387:d5bd:6231 with SMTP id 98e67ed59e1d1-39089861124mr4334944a91.20.1786077857168;
        Thu, 06 Aug 2026 21:44:17 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b1573defsm423588a91.1.2026.08.06.21.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 21:44:16 -0700 (PDT)
Message-ID: <f18c47fd-b067-4573-a877-194e680c0979@gmail.com>
Date: Fri, 7 Aug 2026 12:44:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: cls_api: fix teardown of an adopted proto
 on insert-race loss
To: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 jiri@resnulli.us
Cc: horms@kernel.org, vladbu@nvidia.com, netdev@vger.kernel.org
References: <20260805134049.927864-1-victor@mojatatu.com>
From: Aohan Mei <ljp1205831794@gmail.com>
In-Reply-To: <20260805134049.927864-1-victor@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/5 21:40, Victor Nogueira 写道:
> In tc_new_tfilter() the create branch sets tp_created = 1 before calling
> tcf_chain_tp_insert_unique(). When the caller loses the race (another
> request inserted a proto at the same chain/prio first), insert_unique()
> destroys the caller's own tp_new and returns the winner's proto with an
> extra reference. tp_created was never cleared, so the loser's errout
> path treated the winner's live proto as its own and called
> tcf_chain_tp_delete_empty() on it, silently unlinking an active
> classifier that the winning request already advertised via
> RTM_NEWTFILTER.
> 
> Track the outcome of the insert step in a single tri-state variable so
> each errout path reacts correctly:
> 
> - TP_NOT_CREATED: no proto created; pursue the old path.
> - TP_CREATED: proto inserted successfully; same code path as before.
> - TP_NOT_OWNED: New - lost the insert race; tp is another request's proto
>    (chain ref already released by tp_new's destroy)
> 
> Both errout reactions are single expressions derived from the state.
> 
> This fix is motivated by the Sashiko's automated review of Patch
> (net/sched: cls_api: Always acquire rtnl_lock when destroying locked
> classifiers) [1][2]. The review identified the silent-unlink behaviour of
> an adopted proto's teardown when a request loses the
> tcf_chain_tp_insert_unique() race.
> 
> [1] https://sashiko.dev/#/patchset/20260801125632.360365-1-jhs%40mojatatu.com
> [2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260801125632.360365-1-jhs%40mojatatu.com
> 
> Fixes: 8b64678e0af8 ("net: sched: refactor tp insert/delete for concurrent execution")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260801125632.360365-1-jhs%40mojatatu.com
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260801125632.360365-1-jhs%40mojatatu.com
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>   net/sched/cls_api.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 4e6a2812a4f3..3271963c945d 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -2248,6 +2248,12 @@ static bool is_ingress_or_clsact(struct tcf_block *block, struct Qdisc *q)
>   	return tcf_block_shared(block) || (q && !!(q->flags & TCQ_F_INGRESS));
>   }
>   
> +enum tcf_tp_insert_state {
> +	TP_NOT_CREATED = 0, /* did not create and insert a new tp */
> +	TP_CREATED, /* created and inserted a new tp */
> +	TP_NOT_OWNED, /* created a proto but failed to insert */
> +};
> +
>   static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
>   			  struct netlink_ext_ack *extack)
>   {
> @@ -2268,12 +2274,12 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
>   	unsigned long cl;
>   	void *fh;
>   	int err;
> -	int tp_created;
> +	enum tcf_tp_insert_state tp_state;
>   	bool rtnl_held = false;
>   	u32 flags;
>   
>   replay:
> -	tp_created = 0;
> +	tp_state = TP_NOT_CREATED;
>   
>   	err = nlmsg_parse_deprecated(n, sizeof(*t), tca, TCA_MAX,
>   				     rtm_tca_policy, extack);
> @@ -2395,13 +2401,15 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
>   			goto errout_tp;
>   		}
>   
> -		tp_created = 1;
> +		tp_state = TP_CREATED;
>   		tp = tcf_chain_tp_insert_unique(chain, tp_new, protocol, prio,
>   						rtnl_held);
>   		if (IS_ERR(tp)) {
>   			err = PTR_ERR(tp);
>   			goto errout_tp;
>   		}
> +		if (tp != tp_new)
> +			tp_state = TP_NOT_OWNED;
>   	} else {
>   		mutex_unlock(&chain->filter_chain_lock);
>   	}
> @@ -2455,13 +2463,13 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
>   	}
>   
>   errout:
> -	if (err && tp_created)
> +	if (err && tp_state == TP_CREATED)
>   		tcf_chain_tp_delete_empty(chain, tp, rtnl_held, NULL);
>   errout_tp:
>   	if (chain) {
>   		if (tp && !IS_ERR(tp))
>   			tcf_proto_put(tp, rtnl_held, NULL);
> -		if (!tp_created)
> +		if (tp_state == TP_NOT_CREATED)
>   			tcf_chain_put(chain);
>   	}
>   	tcf_block_release(q, block, rtnl_held);

The fix seems good:

Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Tested-by: Aohan Mei <henrymei@tencent.com>
