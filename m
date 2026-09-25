Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6A175A8D
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324256; cv=none; b=pkfgC75Lm9hQ97p9P0ZMU0cgVkyedfPo+xsGL57t6r26OyUi9+Y8gL1e2jl6AiK/TZ5NfTZvZVmNFYOVwghB4DWgMlYCqI7oxHRp13eOe5P1CDcI9sDI67BBeqkRNF8Ko4lW2wksZjSdyR+VpWkakqbdgj6e7Ml2Y7JXWqpJRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324256; c=relaxed/simple;
	bh=LiGbslpSw1BZSzsUAYmJNaUcdG2k9KF+ZclF5FdcFmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRCYNOljqrc2jK6zxIGu3IXz1YUfwy0Ldph8bKJ3ve2ZusMtFaLHyA5taXsp3JHIgpDTVZfZCKHzWp89uWTO/NyA0ltsIPJySEqWeDsT7Bv0kqKjQ00Jb8Di2tpV0OU4JAJHQwe2yOpAhia8JOCr91J3f2V9zecWCjsfyjyyqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=fVDKOnKF; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="fVDKOnKF"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887d9f05d0so34220f8f.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 01:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1790324253; x=1790929053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vMw0vdUUGSQAbQKLUcnYcE+r3kZ8/NMxHIwt7/zuSwM=;
        b=fVDKOnKFU7NheLf9ZUBlirTUJMrEkvpQgi1c6Ru4+F7MoMlDkIoljXV64OxANVLxc+
         B7LZhjkDoegoUUGGRGSkLboPC+TePSaakw9fyRl7jyWy/NHPSl+3dE6MOftSWZz4acrJ
         R/9BqgmcXw8s1wmxMRLQjE6ePzP/6OAP1WCBzUpOzX8Yaws/+4n6LNCnMNfyqmBgSzHC
         GPo0Gr/c+f9E8RIuixxhX3reVOGZX6iJGaNL4zqJeG7aEJLHbJiLA0ydMO7TkNsJQlWF
         +h2C+ZFS0v08xWWynP02pft1gZ43l8DL2QegkLfETJNuMXyQFEloqUmA1317rEXKUbWZ
         j8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790324253; x=1790929053;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vMw0vdUUGSQAbQKLUcnYcE+r3kZ8/NMxHIwt7/zuSwM=;
        b=GX+uOR/XMXa7vmZqyYASkH+CBZEquoYe2jYyRxwDejc9uYKzxQZf2CiGFSsjpV/4pa
         nwr47RrfGsUm+6WI8cZNMMnsbengEcQnQ46f98jwF6NrE0xgOOjg5xpHnSoJeeY6JONk
         HRW5pso12+yJ71/9UJNinGVsEh0xbOXxL95b+332xrU7buHPLr/R433zvVXgVzlXjYjJ
         9kRIvxTEUDBujMMB3XNKN60JI+NOUa+qoAcn1rurrHyfK68HrIeD5nk9H1Ee/+Eq8/dH
         NBdb0EMrFbVygrNXxCy535zMmVMtK2Lc1G5Wxsz+U5s+In2b3ddRWOr886zholeCwzLj
         aKaQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAcoWMYSvRWJUVnqAmohuXYbgBAjXj8XobgKlDLK1++icLJN9r4NsUDV9Y3Nv69gs3NlqJ560=@vger.kernel.org
X-Gm-Message-State: AFuF++mL7jTGASbnd0oXDW28VoHKyVqq9eaiwUszzmWdG9M4hDRRkYCu
	8ip3KlBFBNVOdxXm42l8e4zyd8hIKScxnTTygawUd+KNNaKLFHjonKSbUAnwbbIgQZI=
X-Gm-Gg: AYBFou2yrfGIjpiSLtWPTv6elZLkt/Zcdj8LkbNyOmy/DmYcQfQq8UegGwbCTW95FvH
	7u8SLuPM3APu1DX39pr0Itm8kXEnCvBitdNip/xLiGfjgWiiu7B3f/RoWi9LSnQt+yiMdZZXaz8
	FGVf2LPSErymeKL/WlRt6CJ4UK1AbNXhU5vqVBsLIhlKR8OKAwr2ObVVYs+j1mJb4qKC7CdC3aj
	mw49G4bDPErPVY0EKmyExgP3anc6wWOpnYnN/hu9Hfq9s8TTXBAvK7YLinlQC0tmHC0lphVs+t4
	mfGmgT0FivDepArp2n2YPjeTekIKGaZbW5e/XyaoNlnGBomn8S3JkkQdZf0R4OZG29hqHwk19mi
	vVteaFh7YANFVnOTvvbfbuixRJyqcxKGTUgsEH/d0nlZkrwm+TLN5JBMeoQ6M2PM/AuU5ie5aOb
	PB0EQznHqShE5GtDyJcPkbQi+TAbAWolQmA9oYDtIjh8RZeZvYvkAPaHHzSl2UNOmLrlfeSY6DA
	lDv++rWw1z96m9cpMMPanN01JoIH7XmuAs4iva/GRkSK5IF3p0=
X-Received: by 2002:a05:600c:6088:b0:49e:7186:f36e with SMTP id 5b1f17b1804b1-49feddba128mr35504205e9.1.1790324253108;
        Fri, 25 Sep 2026 01:17:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff044406dsm48037575e9.1.2026.09.25.01.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 01:17:32 -0700 (PDT)
Message-ID: <6541b309-4e1f-462b-a867-57b67bba1b94@6wind.com>
Date: Fri, 25 Sep 2026 10:17:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v7 2/5] net: add a generation counter for dev->mc
 changes
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20260924011554.3494-1-sigefriedhyy@gmail.com>
 <20260924011554.3494-3-sigefriedhyy@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260924011554.3494-3-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 24/09/2026 à 03:15, Yuyang Huang a écrit :
> A multi-part RTM_GETMULTICAST dump of dev->mc resumes by position, so
> entries added or removed between two dump rounds can be skipped or
> repeated. The IPv4 and IPv6 dumps report that with NLM_F_DUMP_INTR by
> stamping cb->seq from a per netns generation counter combined with
> dev_base_seq, see inet_base_seq().
> 
> Add the equivalent for the device multicast lists: a per netns counter
> bumped whenever an entry is added to or removed from any dev->mc. The
> list helpers do not know which device a list belongs to, so give
> netdev_hw_addr_list an owner set for dev->mc only and bump the counter
> of dev_net(owner) where entries are created and freed. That covers the
> dev_mc_* helpers, both lists of a sync, the hardware sync helpers
> drivers call from their rx mode callbacks or their own workers and the
> reconciliation after an asynchronous rx mode update, while snapshot
> and other lists have no owner and are not tracked. It is atomic since
> the writers only hold the address lock of their own device.
> 
> Used by the following patch for the AF_PACKET multicast dump.
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
> ---
>  include/linux/netdevice.h   |  3 +++
>  include/net/net_namespace.h |  1 +
>  net/core/dev_addr_lists.c   | 21 +++++++++++++++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 5d16737167ee..be3804cdbb2d 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -256,6 +256,9 @@ struct netdev_hw_addr_list {
>  
>  	/* Auxiliary tree for faster lookup on addition and deletion */
>  	struct rb_root		tree;
> +
> +	/* Set for dev->mc, the owning device of a tracked list */
> +	struct net_device	*owner;
There are several lists owned by a device (dev->dev_addrs, dev->uc, dev->mc,
dev->rx_mode_addr_cache), the name 'owner' does not reflect that it is set only
when the list is dev->mc.
I wonder if the name should be changed or if __hw_addr_init() should be updated
to always set owner when the list is owned by a device.

>  };
>  
>  #define netdev_hw_addr_list_count(l) ((l)->count)
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index 46b4c67e2966..d8c681ab5c74 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -71,6 +71,7 @@ struct net {
>  	spinlock_t		rules_mod_lock;
>  
>  	unsigned int		dev_base_seq;	/* protected by rtnl_mutex */
> +	atomic_t		dev_mc_genid;	/* bumped on dev->mc changes */
>  	u32			ifindex;
>  
>  	spinlock_t		nsid_lock;
> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> index 08528ca0a8b3..18acd874fdbd 100644
> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
> @@ -16,6 +16,19 @@
>  
>  #include "dev.h"
>  
> +/**
> + * __hw_addr_changed - account a change of a tracked address list
> + * @list: the address list an entry was added to or removed from
> + *
> + * Bumps the netns generation counter RTM_GETMULTICAST dumps use to detect
> + * changes of dev->mc between dump rounds. Untracked lists have no owner.
> + */
> +static void __hw_addr_changed(struct netdev_hw_addr_list *list)
> +{
> +	if (list->owner)
> +		atomic_inc(&dev_net(list->owner)->dev_mc_genid);
> +}
> +
>  /*
>   * General list handling functions
>   */
> @@ -126,6 +139,7 @@ static int __hw_addr_add_ex(struct netdev_hw_addr_list *list,
>  
>  	list_add_tail_rcu(&ha->list, &list->list);
>  	list->count++;
> +	__hw_addr_changed(list);
list->count and dev_mc_genid evolves together. Perhaps some helpers would be
less error-prone for future patches?

__hw_addr_count_inc()
__hw_addr_count_dec()
__hw_addr_count_reset()

?

>  
>  	return 0;
>  }
> @@ -162,6 +176,7 @@ static int __hw_addr_del_entry(struct netdev_hw_addr_list *list,
>  	list_del_rcu(&ha->list);
>  	kfree_rcu(ha, rcu_head);
>  	list->count--;
> +	__hw_addr_changed(list);
>  	return 0;
>  }
>  
> @@ -487,6 +502,8 @@ void __hw_addr_flush(struct netdev_hw_addr_list *list)
>  {
>  	struct netdev_hw_addr *ha, *tmp;
>  
> +	if (list->count)
> +		__hw_addr_changed(list);
>  	list->tree = RB_ROOT;
>  	list_for_each_entry_safe(ha, tmp, &list->list, list) {
>  		list_del_rcu(&ha->list);
> @@ -501,6 +518,7 @@ void __hw_addr_init(struct netdev_hw_addr_list *list)
>  	INIT_LIST_HEAD(&list->list);
>  	list->count = 0;
>  	list->tree = RB_ROOT;
> +	list->owner = NULL;
>  }
>  EXPORT_SYMBOL(__hw_addr_init);
>  
> @@ -612,6 +630,7 @@ void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
>  				__hw_addr_insert(real_list, ref_ha,
>  						 addr_len);
>  				real_list->count++;
> +				__hw_addr_changed(real_list);
>  			}
>  			continue;
>  		}
> @@ -623,6 +642,7 @@ void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
>  			list_del_rcu(&real_ha->list);
>  			kfree_rcu(real_ha, rcu_head);
>  			real_list->count--;
> +			__hw_addr_changed(real_list);
>  		}
>  	}
>  
> @@ -1177,6 +1197,7 @@ EXPORT_SYMBOL(dev_mc_flush);
>  void dev_mc_init(struct net_device *dev)
>  {
>  	__hw_addr_init(&dev->mc);
> +	dev->mc.owner = dev;
>  }
>  EXPORT_SYMBOL(dev_mc_init);
>  

