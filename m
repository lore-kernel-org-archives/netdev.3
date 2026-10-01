Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFE052FE35
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790881270; cv=none; b=io2OUYuz5j21eNddcU4H+DjR0kqBc8tW9+QqVTuPsm7vKTZBrtUJRrSjKPUYjZCPk7S0j5PlN/BHJU7/hpmhV6VXTyv5jX2o8vEnPQoXL7ex9gF1Q7nRxvIjY4lGjzBjrsdbg+9M1I8zzzWym6gSiakfXQoHeQaRh25V2I8nRHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790881270; c=relaxed/simple;
	bh=dVYFsDiGy+3gXhXE6Oi5XSFviQl/MmRq/efm2Mg/2k4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qs3uMfbaIyS7R10uPONeaRKnSd9BbyP+UxLE7TPnqSiV2ekbSixxIYCK8z4nVmKSOL2yBrhebcOf7JO1/JOdd1vpnaAr2RXPszrcIis9IvZxx9I6zfmPlLyrrtRmDIi2XsQJ6ikm0URg5sWB/ESstjLN0Trb2oOqlMGBUwwi9U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/h1BIUa; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/h1BIUa"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a87fe69060so60308757b3.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 12:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790881240; x=1791486040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C0CoS0O2CGYig/LC2vlHKGOR/9P+oir4qg+Xp46PI3w=;
        b=G/h1BIUabtQ68mzlSC7rCxsXDgrlXXMC+DvXNWZCsqYhz7lLDXeKX9dFnb/TWptPhG
         X16y47M5aqvlfOMXohEPfsK+TEHpWGKuHh1e2s0i3u7Ke62+JdbiNx9QJOOm8fWVUi8x
         Z85pyv1y0t2hrWBuaTMRnLvBYvEK7S0LI0/XzAc0pSsPxGnl6WYoGYWpQMv7bGDYRDAQ
         ffjufqJvzYoF+OJHbZd2nQc5tm9BlV2AGJSut1mueWUHmPASEkgR7gD/lgCFaRyZ7qO1
         ZlQSZAL2Y9i25JHjSsEzhG2QwNsajqCkO4kP5YKWpVbXjQjoQPePM1kg3nFGA0nKdDSB
         fVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790881240; x=1791486040;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C0CoS0O2CGYig/LC2vlHKGOR/9P+oir4qg+Xp46PI3w=;
        b=GaJssSsICHoXkG42HBkcnKe+bhxn4w2pMSfJO1YEzyIJWBafGerf110rNKrQNvv4Hv
         dRmHVpFTxhXn9LNTQb/MRAYUmuxmCQjhT+35DleO72yIP6ybMgaFsj2rF8kiVAoXfB0q
         9mFDQMvyMhP4clh6x8Q3MN7i0UYb/OEVRi8wywc9aXkR9lPpx82EiaMMZmoNaA5c4yq4
         eluxSGrEjS51gStrcjI5pnHUXhtZzljELGTzUp8vu3yY9DjLNt02ap6y/s7DKaNb0oft
         C3gHCgBKcRjUq+J3qSQjTY7wW3cOtsEuvfIOAmMBMGAJyEa467pUnDi7BhS71+SueJab
         axpQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8hui9Ks3hCHEXHxqE5qHishlg+EDpG4I9nCjcqjF7zIfbMkjRE+5mgqle7v4BJ8n9ARd0Yyc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKU0dGtZnKBctWVrQltpSPDCDzn6S33xV8draqNHJCT4AagNdfs
	TkmkewZTpuxkQ36lRGqlNHCd9XSxeCyB+DaxBgBn504VH4leKoRcOwrW
X-Gm-Gg: AYBFou3jM6E/PME0flwiFk3oU+L/Ozc39x9+5plEgr6ldq93e+TsqBi9J2VQX5wZChQ
	a6IFUhkTqCRBewy5RF2vfDNp3wwq9VYJc6dtL3/hVTBTtzJ+KR1fQquso0AMg/JsODdX+OCxnj2
	LeeburN3GcOImDz0VVnAsibgtXd6mQYWtYZ9wKp2FpGAkH0IYE80vHYB5jtO9WfLYpnEcshly5D
	p0Q7KkSVJJKKZwmB417im08yRpG/Gv1lDrG1fzV+qnMy8dp6j3QQCB5e3/luMSqwVTNeuZHhmIC
	4EhlOR2WCj9QXY04V3uFFYEaNjpXptanrk5wnRsQqSPxLlfvuCC7KYZz9mO9Df8oYyZVNSCpsup
	vDvqIh+0gsP87PKOYN3R3J3uxBczy4D95jPaWj9lZn2wQx5EtjxyLlQeFuM4p9gmODveyVClhpq
	Ed1P20RjWmddH/4WfBbI0pFQZDUWY+gWIn/blG1WLalojQYqDkW24d9UwQw5wd5A61BKanEyPD8
	zf6ew1+6zpnM+zqitH0i1SGyO8Qe4QcxjIHAO85k7vLaoo0CmLK6Q==
X-Received: by 2002:a05:690c:571b:b0:8ac:4b34:60af with SMTP id 00721157ae682-8ae39bde7damr1127967b3.40.1790881239791;
        Thu, 01 Oct 2026 12:00:39 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae321fa488sm1079097b3.16.2026.10.01.12.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 12:00:38 -0700 (PDT)
Date: Thu, 01 Oct 2026 15:00:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3b99b3605b4c1@gmail.com>
In-Reply-To: <20261001093925.3529772-1-littlesmilingcloud@gmail.com>
References: <20261001093925.3529772-1-littlesmilingcloud@gmail.com>
Subject: Re: [PATCH net-next] tun: use pskb_may_pull_reason() and remove
 SKB_DROP_REASON_HDR_TRUNC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Anton Danilov wrote:
> tun_get_user() is the only user of SKB_DROP_REASON_HDR_TRUNC. It sets
> it when pskb_may_pull() fails to pull the Ethernet header of a frame
> written to a TAP device.
> 
> pskb_may_pull_reason() reports why the pull failed: PKT_TOO_SMALL if
> the packet is shorter than requested, NOMEM if pulling the data into
> the linear area fails. Use it for the Ethernet header pull in
> tun_get_user() and remove the now unused SKB_DROP_REASON_HDR_TRUNC.
> 
> After a successful pull drop_reason is SKB_NOT_DROPPED_YET. The path
> that later finds the queue detached has no reason of its own and relied
> on the SKB_DROP_REASON_NOT_SPECIFIED initializer. Fall back to
> SKB_DROP_REASON_NOT_SPECIFIED at the free_skb label, as vxlan_rcv()
> does, so that this path, and any later one without a reason of its own,
> keeps reporting it.
> 
> The error returned to user space does not change.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/netdev/20260923145931.GA2859441@shredder/
> Assisted-by: LLM
> Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> 
> ---
>  drivers/net/tun.c             | 5 +++--
>  include/net/dropreason-core.h | 7 -------
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 5a302709a68a..758956f93979 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1932,9 +1932,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		skb->dev = tun->dev;
>  		break;
>  	case IFF_TAP:
> -		if (!pskb_may_pull(skb, ETH_HLEN)) {
> +		drop_reason = pskb_may_pull_reason(skb, ETH_HLEN);

Should we update the skb_may_pull in the above IFF_TUN similarly?

> +		if (drop_reason) {
>  			err = -ENOMEM;
> -			drop_reason = SKB_DROP_REASON_HDR_TRUNC;
>  			goto drop;
>  		}
>  		skb->protocol = eth_type_trans(skb, tun->dev);
> @@ -2062,6 +2062,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		dev_core_stats_rx_dropped_inc(tun->dev);
>  
>  free_skb:
> +	drop_reason = drop_reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
>  	if (!IS_ERR_OR_NULL(skb))
>  		kfree_skb_reason(skb, drop_reason);
>  
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index 12f909651591..47b44a29daab 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -82,7 +82,6 @@
>  	FN(DEV_READY)			\
>  	FN(FULL_RING)			\
>  	FN(NOMEM)			\
> -	FN(HDR_TRUNC)			\
>  	FN(TAP_FILTER)			\
>  	FN(TAP_TXFILTER)		\
>  	FN(ICMP_CSUM)			\
> @@ -427,12 +426,6 @@ enum skb_drop_reason {
>  	SKB_DROP_REASON_FULL_RING,
>  	/** @SKB_DROP_REASON_NOMEM: error due to OOM */
>  	SKB_DROP_REASON_NOMEM,
> -	/**
> -	 * @SKB_DROP_REASON_HDR_TRUNC: failed to trunc/extract the header from
> -	 * networking data, e.g., failed to pull the protocol header from
> -	 * frags via pskb_may_pull()
> -	 */
> -	SKB_DROP_REASON_HDR_TRUNC,
>  	/**
>  	 * @SKB_DROP_REASON_TAP_FILTER: dropped by (ebpf) filter directly attached
>  	 * to tun/tap, e.g., via TUNSETFILTEREBPF
> -- 
> 2.47.3
> 


