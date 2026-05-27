Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B573D5226
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900066; cv=none; b=VjoSKOHMgmEKCkgISr7oHRwePgqK0OJ9PBhGXAx6rtQAnCXo2u/MTs5Iy1z6lmXZsnp0lq7ZIvuUrbkgrSM0H9KmUoHhcEilZZAikxnCSpUDMbdRjkDOGny6Hd9/1Ukr36UAKX9+TCcNCNgfndvBf65PVVQoG/1TuPFOi8xihGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900066; c=relaxed/simple;
	bh=Et0w97QQdsu5AJfpj66DmE3/2tkes/HqFFYm5RDdSeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHq+D20QgkvG45WahEMqxB39QenqGuqNVzRj7PyCULFUe1z6G1WQrLl/ahNLsDHfDWARw67Ohcw1iND/Gyp2ZiILi7SGYK1hlCi1oSrb+eztOKRU0LIAMHzHUhSVLYuwarfXxVIiXZPdYpQWkXnWAwnWEZivEOugxCtSZerXGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZCMSrlFX; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZCMSrlFX"
Message-ID: <6ced4406-0795-417f-b0d2-87efb88d87c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779900060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEMk/ar/UJETx2iI7pP/O3wI78MI6GU/aJUrSUqo3Gc=;
	b=ZCMSrlFXTzqHYuBhYSa5rplcKxdU3o9CHg/+80vCJSxhIQE/VVfABfPsfVKo6ES435Y7Rf
	CoVj3Yc5CyQ5py77oLPty7oSH8FOQOwwmUG0EFCG0BejTvatZ3Ub1/XqZ8219YcdRuOwAY
	M7mFgJnx4HU/POpx3l882pRbSbEfZV8=
Date: Wed, 27 May 2026 17:40:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: ethtool: don't take rtnl_lock for global
 string dump
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 maxime.chevallier@bootlin.com
References: <20260527162522.3344231-1-kuba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260527162522.3344231-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 27/05/2026 17:25, Jakub Kicinski wrote:
> ETHTOOL_MSG_STRSET_GET is the only op which sets allow_nodev_do.
> When no device is provided it dumps static tables, there's no
> need to hold rtnl_lock for this.
> 
> Not taking rtnl_lock is a minor win in itself so I think this
> patch stands on its own merits. Later on it will be useful
> to do locking only in paths which have access to a netdev,
> so that we can decide which locks to take per-netdev.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> CC: maxime.chevallier@bootlin.com
> ---
>   net/ethtool/netlink.h |  4 +++-
>   net/ethtool/netlink.c | 10 ++++++----
>   2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
> index aaf6f2468768..b31de00fe683 100644
> --- a/net/ethtool/netlink.h
> +++ b/net/ethtool/netlink.h
> @@ -333,7 +333,9 @@ int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
>    * @hdr_attr:         attribute type for request header
>    * @req_info_size:    size of request info
>    * @reply_data_size:  size of reply data
> - * @allow_nodev_do:   allow non-dump request with no device identification
> + * @allow_nodev_do:
> + *	Allow non-dump request with no device identification.
> + *	Note that locks (rtnl_lock etc.) are only taken if device is set.
>    * @set_ntf_cmd:      notification to generate on changes (SET)
>    * @parse_request:
>    *	Parse request except common header (struct ethnl_req_info). Common
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 5046023a30b1..a42bdd5ded51 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -526,13 +526,15 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
>   		goto err_free;
>   	ethnl_init_reply_data(reply_data, ops, req_info->dev);
>   
> -	rtnl_lock();
> -	if (req_info->dev)
> +	if (req_info->dev) {
> +		rtnl_lock();
>   		netdev_lock_ops(req_info->dev);
> +	}
>   	ret = ops->prepare_data(req_info, reply_data, info);
> -	if (req_info->dev)
> +	if (req_info->dev) {
>   		netdev_unlock_ops(req_info->dev);
> -	rtnl_unlock();
> +		rtnl_unlock();
> +	}
>   	if (ret < 0)
>   		goto err_dev;
>   	ret = ops->reply_size(req_info, reply_data);

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
