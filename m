Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902553E4506
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753957; cv=none; b=fbv3KbquEjq0J1bSrCI9wdr8Zul0IC0tXGnEjli3l9hYFQ5hMEjJL431HLt3b5YwnQVFjptTrIAGSPvV6lkLIMUugEfZYae5TraNRpT3j4sQ7bVQ/w7JsvIE0d58l4EGUvEk9JqJHLvbfU5IrDPZarn2IIjmi6YXFt5EqAmPcX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753957; c=relaxed/simple;
	bh=B18OJqEhj5l/fTqX8Y1BJ5zZk8xrCQK60MeRKZRCEsk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h2MRA3CTFS4x7zhzjmnZqX3P0ZbZj3yD01BJfM8L4Xy2S5XWPr169ABpn/T1lgP95KNb3yhAQK+SUUVdondVo9byNYUlTmG+HePAbN71KFXGPG2OHdHkm29A7OedPD8whEjeZbaydQbakCIBtFIfWloQT+ShXcKqGVqNyKv7pkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-473ba029526so1329372f8f.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753954; x=1785358754;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0cnHVoGost+eh6NVbPOGieSk6PQRs6v9Ur9BOE+zy1g=;
        b=UJ43U+yAPnLSN1hLWeckbpkvTMk9S5VmJMf1uEQGORBW0sXr/2Pc1w8pFytEsRmh/k
         1rcQ/8xCUppb40Hws11XQwXevs1m3NzJgcxfZGq60OfjC8AD+s6k2bNg7rlJH+b/tFqO
         rQIYVpYNayMSFT3oickAMWiE4/kYdVma9PRm9O28fnESJeD9Kb7m6CbD6h2TdxvH7e22
         bMu7crpqYSY0pM4dOqjFjS5DKkTvM23zBZPCGvFezip6LfYQYahdVVjH0MYodhN9kWJc
         vFLWc9PJD3Uf2UFf8Ep4Hdq/UAhsLw59IcWEaSY7+TK/AK9ZV8d2Pi8mb4No/7q4CiZ7
         fAjA==
X-Forwarded-Encrypted: i=1; AHgh+Rr+A3uQtLHOMIsJdYfByAf722f7jbFoUVVHBYbPVOSIqYnIWQhpwTtTFMJ7igW7QLpTcCHvvOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUy6m8v9q/OGfMX1En6xRKJNNdM1yPXP6EZg1d1Te9cCNIea2h
	+3j9nUuCaEqzBF8g8mC8pmVe/y9xDLZxI8oD/eIwfpkOg+vaWg9JyMPy
X-Gm-Gg: AR+sD13254tW7xC1QGrP93hL/MEuVkds2Mu7J9QWDA5nN1g/lRcEca368agHLhuwBV3
	7/k1QXMhmEAsXkKxigcsINuOJcOGCKLXfHv4Ec84Jr4lChLbAjoKpVVPpRALxodInGDBIGDNWek
	jsr9K4/s0IknpVKBAYHbLJKxc9D6KVskvkw/Kpy3ciI6yp98p56aqyRynNxgqh22IhRjLNEclGN
	2+W2mTApAVTYABnwnleOLZbbTcs81MdF+zooxJ8StKHDOZz2zWvMlSUa0XfiYJ1+yyEgA+QL876
	S6zPi+hcHXR20uIXB5egV1X8fD06919PmYqG4m0jBtibKlOfPoQWNT04jrfJoCktz3hggVY16ia
	ckBSOlPksJE47DUGVFsWQqljFXqx+yw4PhdkIdiyb83LO64PgFx0smSaVV0xJEBEaA0ZxlsAUhm
	eW57IuhYDcfu03PPdz6m6/kDouQEV44e85WYovdus=
X-Received: by 2002:a05:600c:1c1c:b0:493:b698:9247 with SMTP id 5b1f17b1804b1-49574405a5amr293845e9.14.1784753953491;
        Wed, 22 Jul 2026 13:59:13 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c66cebsm8770996f8f.30.2026.07.22.13.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 13:59:13 -0700 (PDT)
Message-ID: <2c2cef53-3bba-4dd4-b66c-cef45852d470@ovn.org>
Date: Wed, 22 Jul 2026 22:59:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, aconole@redhat.com, echaudro@redhat.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, yihung.wei@gmail.com, pshelar@ovn.org, vega@nebusec.ai,
 tonanli66@gmail.com, xuyuqiabc@gmail.com
Subject: Re: [PATCH net v2 1/1] openvswitch: Fix CT limit teardown
 use-after-free
To: Ren Wei <enjou1224z@gmail.com>, netdev@vger.kernel.org,
 dev@openvswitch.org
References: <cover.1784711445.git.xuyuqiabc@gmail.com>
 <20260722164120.2064541-1-enjou1224z@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260722164120.2064541-1-enjou1224z@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 6:40 PM, Ren Wei wrote:
> From: Yuqi Xu <xuyuqiabc@gmail.com>
> 
> Packet processing uses CT limit state under RCU, while netns teardown
> frees that state under ovs_mutex. The CT limit pointer was neither removed
> from readers nor protected by a grace period, allowing packet processing to
> dereference the freed state.
> 
> Replace the pointer before freeing the CT limit state. Wait for in-flight
> RCU readers before freeing its contents. Serialize CT limit netlink
> operations with teardown for the full lifetime of their state accesses.
> 
> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:GPT-5.4
> Co-developed-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---
> changes in v2:
>   - Sort local declarations modified by this patch in reverse
>     Christmas-tree order.
>   - v1 Link: https://lore.kernel.org/all/aa8a1d8dcbac8a13dbdf077a642a66f4c5d81e4b.1784355642.git.xuyuqiabc@gmail.com/
> 
>  net/openvswitch/conntrack.c | 79 +++++++++++++++++++++++--------------
>  net/openvswitch/datapath.h  |  2 +-
>  2 files changed, 51 insertions(+), 30 deletions(-)
> 
> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> index 95697d4e16e6..5c9a607d27a7 100644
> --- a/net/openvswitch/conntrack.c
> +++ b/net/openvswitch/conntrack.c
> @@ -933,10 +933,14 @@ static int ovs_ct_check_limit(struct net *net,
>  			      const struct ovs_conntrack_info *info)
>  {
>  	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
> -	const struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
> +	const struct ovs_ct_limit_info *ct_limit_info;
>  	u32 per_zone_limit, connections;
>  	u32 conncount_key;
>  
> +	ct_limit_info = rcu_dereference(ovs_net->ct_limit_info);
> +	if (!ct_limit_info)
> +		return 0;
> +
>  	conncount_key = info->zone.id;
>  
>  	per_zone_limit = ct_limit_get(ct_limit_info, info->zone.id);
> @@ -1585,40 +1589,47 @@ static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info)
>  #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>  static int ovs_ct_limit_init(struct net *net, struct ovs_net *ovs_net)
>  {
> +	struct ovs_ct_limit_info *info;
>  	int i, err;
>  
> -	ovs_net->ct_limit_info = kmalloc_obj(*ovs_net->ct_limit_info);
> -	if (!ovs_net->ct_limit_info)
> +	info = kmalloc_obj(*info);
> +	if (!info)
>  		return -ENOMEM;
>  
> -	ovs_net->ct_limit_info->default_limit = OVS_CT_LIMIT_DEFAULT;
> -	ovs_net->ct_limit_info->limits =
> +	info->default_limit = OVS_CT_LIMIT_DEFAULT;
> +	info->limits =
>  		kmalloc_objs(struct hlist_head, CT_LIMIT_HASH_BUCKETS);
> -	if (!ovs_net->ct_limit_info->limits) {
> -		kfree(ovs_net->ct_limit_info);
> +	if (!info->limits) {
> +		kfree(info);
>  		return -ENOMEM;
>  	}
>  
>  	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; i++)
> -		INIT_HLIST_HEAD(&ovs_net->ct_limit_info->limits[i]);
> +		INIT_HLIST_HEAD(&info->limits[i]);
>  
> -	ovs_net->ct_limit_info->data = nf_conncount_init(net, sizeof(u32));
> +	info->data = nf_conncount_init(net, sizeof(u32));
>  
> -	if (IS_ERR(ovs_net->ct_limit_info->data)) {
> -		err = PTR_ERR(ovs_net->ct_limit_info->data);
> -		kfree(ovs_net->ct_limit_info->limits);
> -		kfree(ovs_net->ct_limit_info);
> +	if (IS_ERR(info->data)) {
> +		err = PTR_ERR(info->data);
> +		kfree(info->limits);
> +		kfree(info);
>  		pr_err("openvswitch: failed to init nf_conncount %d\n", err);
>  		return err;
>  	}
> +	rcu_assign_pointer(ovs_net->ct_limit_info, info);
>  	return 0;
>  }
>  
>  static void ovs_ct_limit_exit(struct net *net, struct ovs_net *ovs_net)
>  {
> -	const struct ovs_ct_limit_info *info = ovs_net->ct_limit_info;
> +	const struct ovs_ct_limit_info *info;
>  	int i;
>  
> +	info = rcu_replace_pointer(ovs_net->ct_limit_info, NULL,
> +				   lockdep_ovsl_is_held());
> +	/* ovs_ct_check_limit() accesses the info under the datapath RCU lock. */

'datapath RCU lock' is a strange wording.  'RCU read lock' may be better.
But also, the comment is not particularly useful.  It could say 'wait for
other CPUs to stop using ct limits', or something like that instead.

> +	synchronize_rcu();
> +
>  	nf_conncount_destroy(net, info->data);
>  	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; ++i) {
>  		struct hlist_head *head = &info->limits[i];
> @@ -1678,9 +1689,7 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
>  	while (rem >= sizeof(*zone_limit)) {
>  		if (unlikely(zone_limit->zone_id ==
>  				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
> -			ovs_lock();
>  			info->default_limit = zone_limit->limit;
> -			ovs_unlock();

Enlarging the critical section for the ovs_mutex() doesn't sound nice.
There are multiple memory allocations and other things in the path
that could take a decent amount of time holding the lock.  Might be
better to pass ovs_net into set and del funtions instead and do the
rcu dereferencing right here after taking the lock.  It will be done
in 4 places in the code, but you're doing it in 3 places right now,
so code-wise it's not that different.  E.g.:

---
                        ovs_lock();
+                       info = ovsl_dereference(ovs_net->ct_limit_info);
+                       if (!info) {
+                               ovs_unlock();
+                               return -ENOENT;
+                       }
                        info->default_limit = zone_limit->limit;
                        ovs_unlock();
---

If we do so, then ovs_net should likely be the first argument of the
function.

>  		} else if (unlikely(!check_zone_id(
>  				zone_limit->zone_id, &zone))) {
>  			OVS_NLERR(true, "zone id is out of range");
> @@ -1694,9 +1703,7 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
>  			ct_limit->zone = zone;
>  			ct_limit->limit = zone_limit->limit;
>  
> -			ovs_lock();
>  			ct_limit_set(info, ct_limit);
> -			ovs_unlock();
>  		}
>  		rem -= NLA_ALIGN(sizeof(*zone_limit));
>  		zone_limit = (struct ovs_zone_limit *)((u8 *)zone_limit +
> @@ -1722,16 +1729,12 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
>  	while (rem >= sizeof(*zone_limit)) {
>  		if (unlikely(zone_limit->zone_id ==
>  				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
> -			ovs_lock();
>  			info->default_limit = OVS_CT_LIMIT_DEFAULT;
> -			ovs_unlock();
>  		} else if (unlikely(!check_zone_id(
>  				zone_limit->zone_id, &zone))) {
>  			OVS_NLERR(true, "zone id is out of range");
>  		} else {
> -			ovs_lock();
>  			ct_limit_del(info, zone);
> -			ovs_unlock();
>  		}
>  		rem -= NLA_ALIGN(sizeof(*zone_limit));
>  		zone_limit = (struct ovs_zone_limit *)((u8 *)zone_limit +
> @@ -1850,7 +1853,7 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
>  	struct sk_buff *reply;
>  	struct ovs_header *ovs_reply_header;
>  	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
> -	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
> +	struct ovs_ct_limit_info *ct_limit_info;
>  	int err;
>  
>  	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_SET,
> @@ -1863,16 +1866,22 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
>  		goto exit_err;
>  	}
>  
> +	ovs_lock();
> +	ct_limit_info = rcu_dereference_protected(ovs_net->ct_limit_info,
> +						  lockdep_ovsl_is_held());

Should use ovsl_dereference() instead of open-coding it.  And also, we
should probably check that the result is not NULL, for consistency.

>  	err = ovs_ct_limit_set_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
>  					  ct_limit_info);
>  	if (err)
> -		goto exit_err;
> +		goto exit_unlock;
>  
>  	static_branch_enable(&ovs_ct_limit_enabled);
>  
>  	genlmsg_end(reply, ovs_reply_header);
> +	ovs_unlock();

There is no point holding ovs_mutex for the entire reply message preparation
and also the static branch setting.  See above.

>  	return genlmsg_reply(reply, info);
>  
> +exit_unlock:
> +	ovs_unlock();
>  exit_err:
>  	nlmsg_free(reply);
>  	return err;
> @@ -1884,7 +1893,7 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
>  	struct sk_buff *reply;
>  	struct ovs_header *ovs_reply_header;
>  	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
> -	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
> +	struct ovs_ct_limit_info *ct_limit_info;
>  	int err;
>  
>  	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_DEL,
> @@ -1897,14 +1906,20 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
>  		goto exit_err;
>  	}
>  
> +	ovs_lock();
> +	ct_limit_info = rcu_dereference_protected(ovs_net->ct_limit_info,
> +						  lockdep_ovsl_is_held());
>  	err = ovs_ct_limit_del_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
>  					  ct_limit_info);
>  	if (err)
> -		goto exit_err;
> +		goto exit_unlock;
>  
>  	genlmsg_end(reply, ovs_reply_header);
> +	ovs_unlock();

Same here.

>  	return genlmsg_reply(reply, info);
>  
> +exit_unlock:
> +	ovs_unlock();
>  exit_err:
>  	nlmsg_free(reply);
>  	return err;
> @@ -1918,7 +1933,7 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
>  	struct ovs_header *ovs_reply_header;
>  	struct net *net = sock_net(skb->sk);
>  	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
> -	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
> +	struct ovs_ct_limit_info *ct_limit_info;
>  	int err;
>  
>  	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_GET,
> @@ -1932,23 +1947,29 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
>  		goto exit_err;
>  	}
>  
> +	ovs_lock();

Why are we locking the get() path?  Is simple rcu_dereference not enough?

> +	ct_limit_info = rcu_dereference_protected(ovs_net->ct_limit_info,
> +						  lockdep_ovsl_is_held());
>  	if (a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]) {
>  		err = ovs_ct_limit_get_zone_limit(
>  			net, a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT], ct_limit_info,
>  			reply);
>  		if (err)
> -			goto exit_err;
> +			goto exit_unlock;
>  	} else {
>  		err = ovs_ct_limit_get_all_zone_limit(net, ct_limit_info,
>  						      reply);
>  		if (err)
> -			goto exit_err;
> +			goto exit_unlock;
>  	}
>  
>  	nla_nest_end(reply, nla_reply);
>  	genlmsg_end(reply, ovs_reply_header);
> +	ovs_unlock();
>  	return genlmsg_reply(reply, info);
>  
> +exit_unlock:
> +	ovs_unlock();
>  exit_err:
>  	nlmsg_free(reply);
>  	return err;
> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
> index 696640e88fa7..93e11e468d17 100644
> --- a/net/openvswitch/datapath.h
> +++ b/net/openvswitch/datapath.h
> @@ -172,7 +172,7 @@ struct ovs_net {
>  	struct work_struct dp_notify_work;
>  	struct delayed_work masks_rebalance;
>  #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> -	struct ovs_ct_limit_info *ct_limit_info;
> +	struct ovs_ct_limit_info __rcu *ct_limit_info;
>  #endif
>  	bool xt_label;
>  };

