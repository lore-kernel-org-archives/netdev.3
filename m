Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F448FF7B
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011940; cv=none; b=OgaWdPzIwvrIfWgnynOqYIZsmAxpmdQAc3xU8/wPleW7xUvZib2rdcHE7jovGn/hrE6nwKaQQVejFWcMNuAFpSr9DBIUsqh6LY1F7x3A3ctZT7XAyVE1MWWbLkrAuaStdtqZvjg0ZdFP+0Hirh18YR9H6C2TrovfrU3OdJsqrg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011940; c=relaxed/simple;
	bh=gaAFaXvKdZ1VCIuj4sHrL5mssP3PdDg4VL9jG3dT5O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEf7eCyEXvfJimyNbUUuET04W/rkDFRbW8BGT35ObIi0NcN9J1WKr65p8Q9pdt8aZeoKzLUpBDBhoTgM6XI9ef2nau44jDHk5ER+YaSHji2h+ucyRdHu1T/L1Fh3STf7Gv3U40+aY4HzfK8XvtcgTP6KE5SnX/YZh8AubvqxA1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJXeKkwK; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJXeKkwK"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0c89e34so2060849a34.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790011937; x=1790616737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lW48M+WR60klYaUA2KW7joDWLXdNgVT9S/f0yr7pYFQ=;
        b=OJXeKkwKqDUHOHjVPZYyHj9sy6cp7d47Z1UYxj5o4yWrzlvEr6V1qXF+b6cb9Oz7Si
         Llnl6urt8XuED+cEuFzg3cxb0qy656UkeG+p+9i6Vwz0CZz+YIgw1f6Eoi2VWUnd80Ay
         fYxI/gygXW76/KkpRCrkhC+NFChETqHeZGKrCqGjUKaAPg1Zljg+fk3mUQoMZU47LYAV
         l/Q4vlHWT7HLt6RNHc2lL8AS/hiOm/TyqIV3idCqXCP3lZv726teP/dJckpTrtdrIVAh
         OV0Fat7wXWyzOQ4mYzZ9kmdnwlVVE9iwS6kQLrZu8lfTvFZZ7tdg5bcHlfh1avwR3HD2
         woWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790011938; x=1790616738;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lW48M+WR60klYaUA2KW7joDWLXdNgVT9S/f0yr7pYFQ=;
        b=Nc4NZS5dZRkJAZ/lY8f4Q/hYfaL0KRy8UX7LzYbc4EVtP/8wcaUBqoZnsd9F+WN339
         T6inSu77M7tv2vNXuGKFgeqfPZ5r8BT+QAbYFKcvpBJUNNGV9rdnirptxC4jYbFHtoXo
         lOeFxcPj9h6piMJ7p00p4slOL8mWCB/PFzcHPzaacvL/dP/nPj/4AoOUhjzscX/89M69
         635kwq7ThA/WweUZYSe/GtqdQtF7lHfQs/i5AENUl0qvI9D20CI4TBbGTxYlo2unIhLU
         Jdy0+I2qdlQxyIaXOdsl+0SdSC9epvYTyW32yddAGOooZuInvQlzGsuHTc4a8awOdGnY
         ntXg==
X-Forwarded-Encrypted: i=1; AKwUvBxHdAalNKeOc7URcO5YcH7GwZBaWYA9vjJcipyG6feAymHzY9i2T+qATW4BwDbifAdAAsraSAg=@vger.kernel.org
X-Gm-Message-State: AFuF++lDYYAh+VTAS17ts7/dz3Z48VtXEcjtYpXE3w9xgVMRZ5P8u/oW
	i6QnE91llhtlksjpJi/M82zN7SHYpIUbcWv2vwjY66Y485A91zXcJe28
X-Gm-Gg: AYBFou21xbsEUeEEVGX3ihJ8PmUi2vgoitVWHfWXyKvVan3IsQ8pzIlX1lya1jPOu3K
	tjFiIlUBLDEAAMoe02pCgkqR1VIhhRGt3TNRF8s0L5vxuPIcSfmnAFW2plaGu+0ONzdCzXeXwNv
	/5fw1+NETb6xJ9vSR3XOQV6fNCfVTsvonUj1xSN//+pSUdXh+QA32H6tgFl1WsqHYoSnFlS6Q9M
	mvUIbAxaX2UnDXaZ7JmmCikb6KRHBXE+6UCbOf/DUAbRLLdJ4YlN3kgabmhp+Cfb6VQT4MR/vVe
	3KF0O7Y8TB/86D1JbKFjxT2T7FlggaNLgJXsfzRX8xiR21Kn/jrhPXwLaDfF8ctUN1XegnmNNa/
	9tKifuB0dEnMMyxL4gLX2dRi3K5FUY13ISgWhTRVlBemv9G8u8jip6Kyq6QPjK/bkj366L/dthH
	wRzwJxF8xDPEgSphTTd4mQ+xPU4bUD4FuKm3PcVyN48+XUR6BBDbbtnz20ZjNz0phqnhu7gQgCU
	1peiTaO3s5nRyi4H578jDvdWP3QQME=
X-Received: by 2002:a05:6830:a149:10b0:814:9c81:3ad8 with SMTP id 46e09a7af769-8149c813b4amr96786a34.19.1790011937552;
        Mon, 21 Sep 2026 10:32:17 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-814770d6190sm714240a34.24.2026.09.21.10.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 10:32:17 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:32:14 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next] vsock: remove dev_hold() and dev_put() in
 __vsock_deliver_tap_skb()
Message-ID: <arFqHglxl8e7XB6I@devvm29614.prn0.facebook.com>
References: <20260921094218.483234-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921094218.483234-1-edumazet@google.com>

On Mon, Sep 21, 2026 at 09:42:18AM +0000, Eric Dumazet wrote:
> __vsock_deliver_tap_skb() is called from vsock_deliver_tap()
> under rcu_read_lock().
> 
> dev_queue_xmit() does not require the caller to hold a device reference
> count, and the device lifetime is already protected by RCU.
> 
> Remove the redundant dev_hold(dev) and dev_put(dev) calls.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/af_vsock_tap.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock_tap.c b/net/vmw_vsock/af_vsock_tap.c
> index 30ee7e4fe25115cef71b43f335862a09b8c51382..7c5cdceabb2a5f7079faab243ee9de7d6bb8857c 100644
> --- a/net/vmw_vsock/af_vsock_tap.c
> +++ b/net/vmw_vsock/af_vsock_tap.c
> @@ -64,14 +64,10 @@ static int __vsock_deliver_tap_skb(struct sk_buff *skb,
>  	struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
>  
>  	if (nskb) {
> -		dev_hold(dev);
> -
>  		nskb->dev = dev;
>  		ret = dev_queue_xmit(nskb);
>  		if (unlikely(ret > 0))
>  			ret = net_xmit_errno(ret);
> -
> -		dev_put(dev);
>  	}
>  
>  	return ret;
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
