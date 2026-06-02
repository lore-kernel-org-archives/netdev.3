Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B82F3DA7C3
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403011; cv=none; b=JasNJnZj9JhwiT3zHNAleU5SuzlIrvpsW4ZsbcdELGP0zp2eUBA924E4M2ztOE/jVOmVtO6JZFGc7p7BBdS9NeSXhq1fgEBdno50iRqhwzFcz8JyuIFWcdfsRpACvKhhwkO/ju6AuPfBVWWxRReP0YcqGYLIj+jUDZGHtUhhCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403011; c=relaxed/simple;
	bh=Tww/NsYYipQmKbfKB+KBD/CQ8mSh2rAUi3urIDUefWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKTXRIfAlCbCCl09Q85M30dkleG580f/2/scu2lZ5PEhPLARzzrTwQAfKq53ixhQ52HIr0nZ3CEGa4JY6z8af0sElIzdByoSmPU8phqD1gbTg91SdF1jpckZGqK3tN0Z9aUnaRT/IV93SS5ZIo8D3B0BP424S30UxXtE8pB7jbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dad6FS5l; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dad6FS5l"
Message-ID: <319850b8-1374-44db-93a6-1203853de498@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780403006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ultwj2JKNumJYk+h9t8ZZ9dhH3lq4SDUcmsjPUw+W/I=;
	b=dad6FS5lDuUnimB7j5Q2t7unzBuaA+p8o/uRdWB+86Wyo502UMbvFYT7lcLKX+H+5sHLz2
	I+iSqPCeJOKfSlBkFQZUCo5IxHJ5N/LFqfgLO18tHcDrWJbJH/VTMUXGTaaftSu2P8bnsC
	6DL/v8B3+x7KIfwZuMes3yT781Olyzw=
Date: Tue, 2 Jun 2026 20:23:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] rtnetlink: use dev_isalive() in rtnl_getlink()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260602091319.1753654-1-edumazet@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260602091319.1753654-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/2/26 5:13 PM, Eric Dumazet wrote:
> rtnl_getlink() uses an RCU lookup to get the netdevice pointer.
>
> When/If rtnl_lock() is used, we should check if the netdevice is not
> being dismantled before potentially perform illegal actions.
>
> Move dev_isalive() out of net/core/net-sysfs.c and make it available
> in include/linux/netdevice.h
>
> Return -ENODEV if rtnl_getlink() finds a device which is currently
> being dismantled and RTNL is requested.
>
> Fixes: e896e5c0734b ("rtnetlink: do not acquire RTNL in rtnl_getlink() with RTEXT_FILTER_NAME_ONLY")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   include/linux/netdevice.h | 6 ++++++
>   net/core/net-sysfs.c      | 6 ------
>   net/core/rtnetlink.c      | 5 +++++
>   3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 74507c006490f180d2fac6594f6dcf2c86d53919..bfc847bc47fd957b58174dc4d2b82e2e8b461405 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5660,6 +5660,12 @@ static inline const char *netdev_name(const struct net_device *dev)
>   	return dev->name;
>   }
>   
> +/* Caller holds RTNL, netdev->lock or RCU */
> +static inline bool dev_isalive(const struct net_device *dev)
> +{
> +	return READ_ONCE(dev->reg_state) <= NETREG_REGISTERED;
> +}
> +
>   static inline const char *netdev_reg_state(const struct net_device *dev)
>   {
>   	u8 reg_state = READ_ONCE(dev->reg_state);
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 3318b5666e438fe5bab2bcfed2bb260c7b4d5a63..0e71c9ed41e81d85af33a4339f556a0c5d760243 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -37,12 +37,6 @@ static const char fmt_uint[] = "%u\n";
>   static const char fmt_ulong[] = "%lu\n";
>   static const char fmt_u64[] = "%llu\n";
>   
> -/* Caller holds RTNL, netdev->lock or RCU */
> -static inline int dev_isalive(const struct net_device *dev)
> -{
> -	return READ_ONCE(dev->reg_state) <= NETREG_REGISTERED;
> -}
> -
>   /* There is a possible ABBA deadlock between rtnl_lock and kernfs_node->active,
>    * when unregistering a net device and accessing associated sysfs files. The
>    * potential deadlock is as follow:
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 652dd008955a90691403de9a54d8693d64ea7799..9e90d02b73c2909409e12adfcec3940b49dcbaa1 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4265,6 +4265,10 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   retry:
>   	if (need_rtnl) {
>   		rtnl_lock();
> +		if (!dev_isalive(dev)) {
> +			err = -ENODEV;
> +			goto unlock;


This does fix the macvlan UAF, thanks.

But 'nskb' is used uninitialized, so the kfree_skb(nskb) below frees an 
uninitialized pointer.

+unlock:
     if (need_rtnl)
             rtnl_unlock();

     if (err < 0) {
             kfree_skb(nskb);   /* nskb is uninitialized when reached 
via goto unlock */
             ...
     }


> +		}
>   		/* Synchronize the carrier state so we don't report a state
>   		 * that we're not actually going to honour immediately; if
>   		 * the driver just did a carrier off->on transition, we can
> @@ -4282,6 +4286,7 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   				       nlh->nlmsg_seq, 0, 0, ext_filter_mask,
>   				       0, NULL, 0, netnsid, GFP_KERNEL);
>   
> +unlock:
>   	if (need_rtnl)
>   		rtnl_unlock();
>   



