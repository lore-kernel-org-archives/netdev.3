Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960B3B5E08
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786401867; cv=none; b=DxGPfYBYu2HgosBAbtWpI1vnlhVP/MaCZHQXIacVj8gmcrR2ClRmNm6+Y4jCWXvz/tUE4y+1GZC32U212lhsWN5p5Pm+h3UbWBt3KshXTsTYcvbSskATRTtOyY12BVAuvCA9cV68t2bhg+fYmgDCcsdKhP1f6/3gwX5ucfSlwIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786401867; c=relaxed/simple;
	bh=wI+RFXDrQ2iUIM4C0Ni4gRSR5qQFGLoHrSa+oYCjb08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvUjkRfcp3ZLmlWFeo0EhVux0HvAfnyfy3mWagnR6gkv7VKvQZ/YZDNqG3IUiIlf9aTMfEw8JJ8CgacMF9OKVm/pKXxUV+2XHtkWnkSw5pg26mbZP3LHnb8g7B759L4ZoR9EUBltx4Mdhm4tGP6zOQoR4j2wwin/6YcWttzPkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4NehSx0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4NehSx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C4B1F000E9;
	Mon, 10 Aug 2026 22:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786401866;
	bh=KHRsWxbyOh66WiHkYOmvWeXOOQcMDqIP1hS825QoBws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n4NehSx0lxFQjbNy2DkOXTnqZOv28BHZtpqQbPAoEq7b4dd6AfUJSShDgn7Pnk1K8
	 pdjpMXDgrM/vFS3tcDS2galoFJBUCh6wxXz8VRxSlLqFJIN7yjRCz/fs/ZIXT0mH8o
	 TRIYvE1IO7PXJY8gV5az4dJGLQT8wCT7XlqxqbF2deBlHTQGYqxTc8hobcTsHsbZl7
	 zGiLkklJDFHe+xqVw0D7qUwxH1DhBzX6q0pdEC81BrXFoBi5FrOWDYUj+PqlqkAX/o
	 dtOdggB2JqTCqy8Vy2otkgwkaydFkfIDMDJoCpCw6bkaj/3tDEjHvxer4iyYjgEnVn
	 g/4HWiQBX0Qag==
From: Jakub Kicinski <kuba@kernel.org>
To: enjou1224z@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	yihung.wei@gmail.com,
	pshelar@ovn.org,
	vega@nebusec.ai,
	tonanli66@gmail.com,
	xuyuqiabc@gmail.com
Subject: Re: [PATCH net v4 1/1] openvswitch: Fix CT limit teardown use-after-free
Date: Mon, 10 Aug 2026 15:43:57 -0700
Message-ID: <20260810224356.927424-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <07a1967fb56f2b38465cc5b611343827d636f77b.1785908366.git.xuyuqiabc@gmail.com>
References: <07a1967fb56f2b38465cc5b611343827d636f77b.1785908366.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
openvswitch: Fix CT limit teardown use-after-free

This makes ovs_net->ct_limit_info an __rcu pointer, clears it with
rcu_replace_pointer() plus synchronize_rcu() during netns teardown, and
converts the readers to rcu_dereference() with NULL checks. The CT limit
GET path now runs under a single RCU read-side critical section, while SET
and DEL take ovs_mutex per entry.

> @@ -1679,7 +1691,9 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
>  		if (unlikely(zone_limit->zone_id ==
>  				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
>  			ovs_lock();
> -			info->default_limit = zone_limit->limit;
> +			info = ovsl_dereference(ovs_net->ct_limit_info);
> +			if (likely(info))
> +				info->default_limit = zone_limit->limit;
>  			ovs_unlock();
>  		} else if (unlikely(!check_zone_id(
>  				zone_limit->zone_id, &zone))) {
> @@ -1695,8 +1709,13 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
>  			ct_limit->limit = zone_limit->limit;
>  
>  			ovs_lock();
> -			ct_limit_set(info, ct_limit);
> +			info = ovsl_dereference(ovs_net->ct_limit_info);
> +			if (likely(info))
> +				ct_limit_set(info, ct_limit);
>  			ovs_unlock();
> +
> +			if (unlikely(!info))
> +				kfree(ct_limit);
>  		}

[Severity: Low]

Can info actually be NULL here?

All three handlers take the netns from sock_net(skb->sk), i.e. the namespace
of the socket that received the request, and the request is processed
synchronously inside the sender's sendmsg():

netlink_unicast_kernel()
    nlk->netlink_rcv(skb)

The sending userspace netlink socket holds a netns reference (sk_alloc()
with kern == 0 does get_net_track()), so the refcount cannot reach zero and
cleanup_net() -> ovs_exit_net() -> ovs_ct_exit() -> ovs_ct_limit_exit()
cannot run concurrently for that namespace.  Module unload is serialised too:
dp_cleanup() calls dp_unregister_genl() before
unregister_pernet_device(&ovs_net_ops).

Given that, the changelog text

    "When netns teardown has already removed the CT limit state, SET and DEL
     complete successfully without changing it. SET frees an allocation that
     could not be installed because teardown won the race."

describes a path that does not look reachable.  Could that paragraph be
dropped, or the reachability argument spelled out?

There is also a consistency question if these branches are kept: the same
NULL state is given three different meanings.  ovs_ct_limit_cmd_get() returns
a new -ENOENT, ovs_ct_limit_set_zone_limit() and ovs_ct_limit_del_zone_limit()
discard the request while ovs_ct_limit_cmd_set()/ovs_ct_limit_cmd_del() still
reply success, and ovs_ct_check_limit() treats it as "no limit enforcement"
by returning 0.  Should these be reconciled, or the unreachable guards
dropped so only the packet-path check remains?

> @@ -1723,14 +1743,18 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
>  		if (unlikely(zone_limit->zone_id ==
>  				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
>  			ovs_lock();
> -			info->default_limit = OVS_CT_LIMIT_DEFAULT;
> +			info = ovsl_dereference(ovs_net->ct_limit_info);
> +			if (likely(info))
> +				info->default_limit = OVS_CT_LIMIT_DEFAULT;
>  			ovs_unlock();
>  		} else if (unlikely(!check_zone_id(
>  				zone_limit->zone_id, &zone))) {
>  			OVS_NLERR(true, "zone id is out of range");
>  		} else {
>  			ovs_lock();
> -			ct_limit_del(info, zone);
> +			info = ovsl_dereference(ovs_net->ct_limit_info);
> +			if (likely(info))
> +				ct_limit_del(info, zone);
>  			ovs_unlock();
>  		}

[ ... ]

> @@ -1932,18 +1951,21 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
>  		goto exit_err;
>  	}
>  
> -	if (a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]) {
> +	rcu_read_lock();
> +	ct_limit_info = rcu_dereference(ovs_net->ct_limit_info);
> +	if (!ct_limit_info) {
> +		err = -ENOENT;
> +	} else if (a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]) {
>  		err = ovs_ct_limit_get_zone_limit(
>  			net, a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT], ct_limit_info,
>  			reply);
> -		if (err)
> -			goto exit_err;
>  	} else {
>  		err = ovs_ct_limit_get_all_zone_limit(net, ct_limit_info,
>  						      reply);
> -		if (err)
> -			goto exit_err;
>  	}
> +	rcu_read_unlock();
> +	if (err)
> +		goto exit_err;

> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
> index 696640e88fa7e..93e11e468d173 100644
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

[Severity: Low]

Should the kernel-doc for struct ovs_net be updated alongside the type
change?  The block above the struct still reads:

 * @ct_limit_info: A hash table of conntrack zone connection limits.

while the field is now RCU-protected, requires ovs_mutex plus
ovsl_dereference() for writers, and can be NULL after ovs_ct_limit_exit().
The sibling entry in the same block does document its lock:

 * @dps: List of datapaths to enable dumping them all out.
 * Protected by genl_mutex.

Could the ct_limit_info entry mention the RCU protection, the ovs_mutex
requirement for updates, and that it may be NULL?
