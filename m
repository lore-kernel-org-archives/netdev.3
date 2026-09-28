Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E416A46D2B4
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581993; cv=none; b=AhwFQAS/wyMecFaFuQuuV/kV04w6+rCj/N2IDBX9JTga6VDP/aHfwLUTIuTOgySWkrYi7NMRRyyHd/wUSM+/x4JuEaO2TUCIxzfaRbbRz7RrMlzZ791yxNhYvBuPLbLe4pu4qoRQ3PKk99XBCSWY5voYZlLKou3Inxs0nZkAh7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581993; c=relaxed/simple;
	bh=aA/zrPMspakEuvzH3RaiPDVitAjjOTzjf/L/Kpmyf0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MA5bZWbuHU36lmhgemkCu/xl4un2kqDWsP3RgGbVpJarItH/pwEUJOtGiAk38oWvBmUjDYKLAv+MSGNPTqGfgLHwnjyr3Lhr664M5iFgZnWgcQ/qHUSNL3iWH1ooUQ9i4pCjpU/9svbd4nTuKZeA3O3aIQD6VR6cW0DY6ClsWdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=jFJ+16CF; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="jFJ+16CF"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887dc451d7so247182f8f.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 00:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1790581989; x=1791186789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BF10bhz/UbdNdYSJY9TUFjfFC06TQP6+N+yfVQ0ryuw=;
        b=jFJ+16CFM+jjpt2BWFeCO0quo16TnjakV33xfGKLyK/hjPepDAD0KA0xNzxQi+Us72
         jQVCm+wnHpKDbXX5oGaU+FSTNaSMk6fmEvZqLQdtxoJWUTol0NvVJbSzlV5Hu/aL4LPT
         DiTdbnzeISIkNohNqdaYaHHc29U3qdP3oLmv+sz0Vdy3qhEjbMls5wjGibT9UH9bVGtL
         aDwFnm2fBF9/GdwWAJGp2z1j9Oi3lAcH0Cky89rXK2yKmsn/ziBVKd+w+GUWgxjHlWBr
         quwHEC79+TfhQRf3934ZIIpEC3CDg2bnKgPfH3VEkTMANujdjmaE0VQeK5MtUTFO75XB
         d+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581989; x=1791186789;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BF10bhz/UbdNdYSJY9TUFjfFC06TQP6+N+yfVQ0ryuw=;
        b=GDZMTSDU12tmZoQEWJaeh4wzEvUfMKzw7olneOLRpzVz2oa1etPAh1I6kUBeSIQKAi
         zouEKSf4SapwppZB6NF6xhSLviBBXdwx4XUZ3WgftInp7xRD5A8HfLgeDQAiI5AWnAAy
         H06D6DtdcO9RQ1VMFbPo0/K0Cu1fQh/sgIxcayRDqSABlziBXwv091K5xMK4rxHbD8Hr
         J0/lfZGs5O5QjknjX2WjNtLbM3W+f3tZcVEbKsUW54e87CurJWUD+lVQ9kpkzP6qq+wD
         87c0hjZlyH73cZWyq5wYhYOt+bxtB8GR+freJ/dEOnlfZ01XJhc/IN3te9Eg5G8hEhQL
         INmw==
X-Forwarded-Encrypted: i=1; AKwUvBz61aWAfdCLoOECCYpkVJKJZk7dWZe7tEPrANDHHgafUIrJw+qeld8PKF0UZqgXv00TBHGLX0g=@vger.kernel.org
X-Gm-Message-State: AFuF++lpVpusa5bxmo742V8mSmNlkmQxzcBwTC+gXj/NP5bHv9QSye1H
	wiu5Mut7MycbOxewAvFxnPKQ/bRRxrF6Q1gcT9cLOSKWS57CSXcdOseNxmVKcDqNM+o=
X-Gm-Gg: AYBFou2sAvqxXcdIB3v9kvZOsOlqzO/zWp605eqh4Zb0+f5Dv4KK6o32R9D+lrTZRTo
	Lq4jT7h/CGJcLd/gPWyUgd241Zu2xvKTDAMUMhIkx6qAU5CQuivRR95VB/vKhMoWgYm5OLs6aBx
	H84Vz/y+6CPvuTGayMgU6fj45z2K8bddcvBQogioe1mHzqwRgdkYVY4rTje3XfuNMnWh8lHfC3X
	HmkC/Stoh46xWaTcfGHmerEAwuxRrLuLJ315WkvxDzDo2F0tu9pLgNmywrXsY0AAVW+Y5VbBNKM
	tFq1MFNF8rnM4StjgftG75MCqUqYSYP3+A/McM6F9dcr5TPRx3W2FoZIIqhEZV6Lq50XZOTU8kj
	hZ+swYHC9MYvWOzibjDDADr5M1ABSSj+wO6twnxDW6BHskpBRwRWbN+uA5m2cyclXzxp5CEVRpU
	meOEVN/ho84FaPPXjRq12yOgDsoJMF/0cCXnRJzewZt+IywhiFl6GrAf2SJqfSzjRo66SI/dOkz
	kvHid6BBSkwg1njHcY6/JnUqR2O+6CiTdD01kWAUh60sSDYdhk=
X-Received: by 2002:a05:600c:a414:b0:49f:ff2c:e0cf with SMTP id 5b1f17b1804b1-49fff2ce1a7mr66131745e9.0.1790581988608;
        Mon, 28 Sep 2026 00:53:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001922102sm122800265e9.15.2026.09.28.00.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 00:53:08 -0700 (PDT)
Message-ID: <cd00e6e7-aa2d-4f98-8a79-083b64b3376a@6wind.com>
Date: Mon, 28 Sep 2026 09:53:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v8 2/5] net: add a generation counter for dev->mc
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
References: <20260927002427.4519-1-sigefriedhyy@gmail.com>
 <20260927002427.4519-3-sigefriedhyy@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260927002427.4519-3-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Le 27/09/2026 à 02:24, Yuyang Huang a écrit :
> A multi-part RTM_GETMULTICAST dump of dev->mc resumes by position, so
> entries added or removed between two dump rounds can be skipped or
> repeated. The IPv4 and IPv6 dumps report that with NLM_F_DUMP_INTR by
> stamping cb->seq from a per netns generation counter combined with
> dev_base_seq, see inet_base_seq().
> 
> Add the equivalent for the device multicast lists: a per netns counter
> bumped whenever an entry is added to or removed from any dev->mc. The
> list helpers do not know which device a list belongs to, so give
> netdev_hw_addr_list an owner, set for the lists of a device and NULL
> for snapshots and other standalone lists, and change list->count
> through helpers that bump the counter of dev_net(owner) when the list
> is dev->mc. That covers the dev_mc_* helpers, both lists of a sync,
> the hardware sync helpers drivers call from their rx mode callbacks or
> their own workers and the reconciliation after an asynchronous rx mode
> update. It is atomic since the writers only hold the address lock of
> their own device.
> 
> Used by the following patch for the AF_PACKET multicast dump.
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>


If another version is needed, you can rename counter to _counter to highlight
that the helpers should be used.
> ---
>  include/linux/netdevice.h   |  5 ++++
>  include/net/net_namespace.h |  1 +
>  net/core/dev_addr_lists.c   | 52 +++++++++++++++++++++++++++++++------
>  3 files changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index d037faff7c44..69d1cde0a38a 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -256,6 +256,11 @@ struct netdev_hw_addr_list {
>  
>  	/* Auxiliary tree for faster lookup on addition and deletion */
>  	struct rb_root		tree;
> +
> +	/* The device a list belongs to, NULL for snapshots and other
> +	 * standalone lists
> +	 */
> +	struct net_device	*owner;
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
> index 08528ca0a8b3..c941c3ec1007 100644
> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
> @@ -16,6 +16,37 @@
>  
>  #include "dev.h"
>  
> +/* Only dev->mc is tracked, RTM_GETMULTICAST dumps use the netns generation
> + * counter to detect changes between dump rounds.
> + */
> +static void __hw_addr_changed(struct netdev_hw_addr_list *list)
> +{
> +	struct net_device *dev = list->owner;
> +
> +	if (dev && list == &dev->mc)
> +		atomic_inc(&dev_net(dev)->dev_mc_genid);
> +}
> +
> +static void __hw_addr_count_inc(struct netdev_hw_addr_list *list)
static void __hw_addr_count_add(struct netdev_hw_addr_list *list, int value)
> +{
> +	list->count++;
list->count += value;> +	__hw_addr_changed(list);
> +}
#define __hw_addr_count_inc(l) __hw_addr_count_add(l, 1)

> +
> +static void __hw_addr_count_dec(struct netdev_hw_addr_list *list)
> +{
> +	list->count--;
> +	__hw_addr_changed(list);
> +}
> +
> +static void __hw_addr_count_reset(struct netdev_hw_addr_list *list)
> +{
> +	if (!list->count)
> +		return;
> +	list->count = 0;
> +	__hw_addr_changed(list);
> +}
> +
>  /*
>   * General list handling functions
>   */
> @@ -125,7 +156,7 @@ static int __hw_addr_add_ex(struct netdev_hw_addr_list *list,
>  	rb_insert_color(&ha->node, &list->tree);
>  
>  	list_add_tail_rcu(&ha->list, &list->list);
> -	list->count++;
> +	__hw_addr_count_inc(list);
>  
>  	return 0;
>  }
> @@ -161,7 +192,7 @@ static int __hw_addr_del_entry(struct netdev_hw_addr_list *list,
>  
>  	list_del_rcu(&ha->list);
>  	kfree_rcu(ha, rcu_head);
> -	list->count--;
> +	__hw_addr_count_dec(list);
>  	return 0;
>  }
>  
> @@ -492,7 +523,7 @@ void __hw_addr_flush(struct netdev_hw_addr_list *list)
>  		list_del_rcu(&ha->list);
>  		kfree_rcu(ha, rcu_head);
>  	}
> -	list->count = 0;
> +	__hw_addr_count_reset(list);
>  }
>  EXPORT_SYMBOL_IF_KUNIT(__hw_addr_flush);
>  
> @@ -501,6 +532,7 @@ void __hw_addr_init(struct netdev_hw_addr_list *list)
>  	INIT_LIST_HEAD(&list->list);
>  	list->count = 0;
>  	list->tree = RB_ROOT;
> +	list->owner = NULL;
>  }
>  EXPORT_SYMBOL(__hw_addr_init);

For correctness, __hw_addr_splice() should use helper:

@@ -509,8 +509,8 @@ static void __hw_addr_splice(struct netdev_hw_addr_list *dst,
 {
         src->tree = RB_ROOT;
         list_splice_init(&src->list, &dst->list);
-        dst->count += src->count;
-        src->count = 0;
+        __hw_addr_count_add(dst, src->count);
+        __hw_addr_count_reset(src);
 }

Renaming  struct netdev_hw_addr_list->count to _count would help to check all
users and highlight that modifying _count should be done with helpers.

>  
> @@ -536,7 +568,7 @@ int __hw_addr_list_snapshot(struct netdev_hw_addr_list *snap,
>  			entry = list_first_entry(&cache->list,
>  						 struct netdev_hw_addr, list);
>  			list_del(&entry->list);
> -			cache->count--;
> +			__hw_addr_count_dec(cache);
>  			memcpy(entry->addr, ha->addr, addr_len);
>  			entry->type = ha->type;
>  			entry->global_use = false;
> @@ -554,7 +586,7 @@ int __hw_addr_list_snapshot(struct netdev_hw_addr_list *snap,
>  
>  		list_add_tail(&entry->list, &snap->list);
>  		__hw_addr_insert(snap, entry, addr_len);
> -		snap->count++;
> +		__hw_addr_count_inc(snap);
>  	}
>  
>  	return 0;
> @@ -604,14 +636,14 @@ void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
>  			if (delta > 0) {
>  				rb_erase(&ref_ha->node, &ref->tree);
>  				list_del(&ref_ha->list);
> -				ref->count--;
> +				__hw_addr_count_dec(ref);
>  				ref_ha->sync_cnt = delta;
>  				ref_ha->refcount = delta;
>  				list_add_tail_rcu(&ref_ha->list,
>  						  &real_list->list);
>  				__hw_addr_insert(real_list, ref_ha,
>  						 addr_len);
> -				real_list->count++;
> +				__hw_addr_count_inc(real_list);
>  			}
>  			continue;
>  		}
> @@ -622,7 +654,7 @@ void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
>  			rb_erase(&real_ha->node, &real_list->tree);
>  			list_del_rcu(&real_ha->list);
>  			kfree_rcu(real_ha, rcu_head);
> -			real_list->count--;
> +			__hw_addr_count_dec(real_list);
>  		}
>  	}
>  
> @@ -685,6 +717,7 @@ int dev_addr_init(struct net_device *dev)
>  	/* rtnl_mutex must be held here */
>  
>  	__hw_addr_init(&dev->dev_addrs);
> +	dev->dev_addrs.owner = dev;
>  	memset(addr, 0, sizeof(addr));
>  	err = __hw_addr_add(&dev->dev_addrs, addr, sizeof(addr),
>  			    NETDEV_HW_ADDR_T_LAN);
> @@ -962,6 +995,7 @@ EXPORT_SYMBOL(dev_uc_flush);
>  void dev_uc_init(struct net_device *dev)
>  {
>  	__hw_addr_init(&dev->uc);
> +	dev->uc.owner = dev;
>  }
>  EXPORT_SYMBOL(dev_uc_init);
>  
> @@ -1177,6 +1211,7 @@ EXPORT_SYMBOL(dev_mc_flush);
>  void dev_mc_init(struct net_device *dev)
>  {
>  	__hw_addr_init(&dev->mc);
> +	dev->mc.owner = dev;
>  }
>  EXPORT_SYMBOL(dev_mc_init);
>  
> @@ -1348,6 +1383,7 @@ static void netif_rx_mode_retry(struct timer_list *t)
>  void netif_rx_mode_init(struct net_device *dev)
>  {
>  	__hw_addr_init(&dev->rx_mode_addr_cache);
> +	dev->rx_mode_addr_cache.owner = dev;
>  	timer_setup(&dev->rx_mode_retry_timer, netif_rx_mode_retry, 0);
>  }
>  

