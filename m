Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B91A3A0E97
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787505; cv=none; b=cJELosFbrssoR9Slemm8ZJXEUUvOXmviNCpNbtNfHZkF8EfeFJHG0A9/G8XFG6hd21UtSwHuW/hEDZLVOanEKFIwxtHTd5SKBl9Sx/4LiQa80DZj7q19XOIyNvt8Zc5o2nA2CMSVwKBPeA68v3YMHIqxdEmDa8aMVWzVDL18vXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787505; c=relaxed/simple;
	bh=Bv7cPCbdRWjrq2py12tZKz5xOwe2z4tGo6vIitHtGMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0d1DfhQlQZTcpbEJeDFyO/em/muDIS2UmjnJ3vSSSZdiZdLHYw42qtiBzsLcZL+/DxDzI/UK5WIn3jjNtPfbiVB2Yi5q1yl0fzf8jsGcePJgs9dZRvl+moKEAoFPz5Smy1/yd/j3vT7cgkbJs2Y7fjFHjsirWQg0KCgETKstXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so4020825e9.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 13:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785787501; x=1786392301;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c6FTQauhG06GafhJOCFr4+vdqLJ7MzYl3H4W5YbOxb8=;
        b=KBaT+3q2bMQGgZUi8FhOjZmC3KW617A1HrCcWaWz6++ebVdmPdZlJcvX/dbIVX7h1L
         4Pw7SE6qtUEyMnsCshoQvsBiDCS/V3/5fo/bStNTr+xnEAgCS4UBFA5kGE2fQFPB1U68
         la0Rbc+FMUBjE6HBttU+odGW8tXkq7vosGRsCMMcvlIYc/o6yYBNe4KVRzKbBygqjpVz
         +1ypOMQJn9wLPGfHUS+AEhD2T7cdCNCgU2/E4yCS3M7wkrau8Ee0WSJR4T52zVDgvPhW
         ZEJljp8JizzCKKjhnhMfQknUVSrpy4Lb4niOdkaZoifhS8+78o8EFrX92Q42fOx2h4ta
         ea7A==
X-Forwarded-Encrypted: i=1; AHgh+Rp8+v4+rq5pSWTmpDrfkz1NVq1lMgfrCsvfONTvhY1Y47SaRrIE3n09kTJqXl6tTdFAsu5jbW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXLhVTAJhsfZnbNrZeL+jTwQHWkn9SOdgT+XQ9Ym78nN8amxVe
	WjAVbJ8jry66d3Gibqtt72OY0y0yc3wXaIsBFGjM4buFcLPiyNsh9H6Y
X-Gm-Gg: AR+sD13G/8Xs4aWmTEiFvapS9FFO6b1WHCh06/vnX2F1D0U8XsZtSQ3rxi3jHKSKlh3
	+zKg5QTEy+pMOUlAU7yyXVjZLCE/XzgnQHwk7orfOSFVAflWwqL/dKZichWecAkSjy1scIhNELI
	swBn4BbrRgaltG7yLlH5pgjVjTg5wTYILMjtd9Kml3YgcMb+HPl2sWsJFHIK9X3HBSasgFl1rIV
	Q49TqEy74lWTDgmprAYyGtEPlnlYUjyYbLFpattMJdJmVZfZ8kmFweWTCXSygBbJAboT4YrgmY/
	4SbtnTDl6NzU5lY66byMyHCtiXLz443tHom72XjZxxypTcYqdsxgOzATogwtgGkrv+965J8EvTT
	4lfIgc9DOI6kwduCRpGGI3uQlV7/ldjiS8vuNF6uAE2Q9BtV9DPAmiU4niW4fEJtwQX4MkHVmmH
	cPY5RkNhbEdgXbG1V/N9VwNvsAe3EwQZ8l2DE5H6GVBlJXw47m1oov0KiyFmuaHYVANx6GRQoNV
	RYVS+/jDUrn1liYWIDuP5NQCA==
X-Received: by 2002:a05:600c:6989:b0:495:4811:7998 with SMTP id 5b1f17b1804b1-4980c664d83mr307248445e9.17.1785787501019;
        Mon, 03 Aug 2026 13:05:01 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807bad893sm217157955e9.3.2026.08.03.13.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 13:05:00 -0700 (PDT)
Message-ID: <0d488dcb-7d11-41a9-884a-5f67c6aebea9@ovn.org>
Date: Mon, 3 Aug 2026 22:04:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/1] openvswitch: Fix CT limit teardown
 use-after-free
To: Ren Wei <enjou1224z@gmail.com>, netdev@vger.kernel.org,
 dev@openvswitch.org
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, yihung.wei@gmail.com, vega@nebusec.ai,
 tonanli66@gmail.com, xuyuqiabc@gmail.com
References: <cover.1784866791.git.xuyuqiabc@gmail.com>
 <8cf84ef117b917c4ca3a264af4df4cc1e293435a.1784866791.git.xuyuqiabc@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <8cf84ef117b917c4ca3a264af4df4cc1e293435a.1784866791.git.xuyuqiabc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 7:30 PM, Ren Wei wrote:
> From: Yuqi Xu <xuyuqiabc@gmail.com>
> 
> Packet processing uses CT limit state under RCU, while netns teardown
> frees that state under ovs_mutex. The CT limit pointer was neither removed
> from readers nor protected by a grace period, allowing packet processing to
> dereference the freed state.
> 
> Replace the pointer before freeing the CT limit state, and wait for RCU
> readers before freeing its contents. Keep ovs_mutex only around CT limit
> updates, while GET uses the RCU read-side lock for the lifetime of the
> lookup.
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
> Changes in v3:
> 
> - Use RCU dereference and a NULL check for CT limit GET requests.
> - Limit ovs_mutex to CT limit updates; do not hold it while preparing replies.
> - Use ovsl_dereference() for update paths and clarify the RCU grace-period comment.
> - v2 Link: https://lore.kernel.org/all/cover.1784711445.git.xuyuqiabc@gmail.com
> 
> Changes in v2:
> 
> - Sort local declarations modified by this patch in reverse Christmas-tree order.
> - v1 Link: https://lore.kernel.org/all/aa8a1d8dcbac8a13dbdf077a642a66f4c5d81e4b.1784355642.git.xuyuqiabc@gmail.com/
> 
>  net/openvswitch/conntrack.c | 109 +++++++++++++++++++++---------------
>  net/openvswitch/datapath.h  |   2 +-
>  2 files changed, 65 insertions(+), 46 deletions(-)
> 
> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> index 95697d4e16e6..aa71a254fe24 100644
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
> +	/* Wait for RCU readers to stop using the CT limits. */
> +	synchronize_rcu();
> +
>  	nf_conncount_destroy(net, info->data);
>  	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; ++i) {
>  		struct hlist_head *head = &info->limits[i];
> @@ -1665,22 +1676,28 @@ static bool check_zone_id(int zone_id, u16 *pzone)
>  	return false;
>  }
>  
> -static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
> -				       struct ovs_ct_limit_info *info)
> +static int ovs_ct_limit_set_zone_limit(struct ovs_net *ovs_net,
> +				       struct nlattr *nla_zone_limit)
>  {
> +	struct ovs_ct_limit_info *info;

Reverse xmass tree, please.

>  	struct ovs_zone_limit *zone_limit;
>  	int rem;
>  	u16 zone;
>  
> +	ovs_lock();
> +	info = ovsl_dereference(ovs_net->ct_limit_info);
> +	if (!info) {
> +		ovs_unlock();
> +		return -ENOENT;
> +	}
> +

This is not really what I asked for.  I asked to keep the lock/unlock
per entry as they are today and just add dereference + check under that
lock.  Something like this:

@@ -1679,7 +1691,9 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
                if (unlikely(zone_limit->zone_id ==
                                OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
                        ovs_lock();
-                       info->default_limit = zone_limit->limit;
+                       info = ovsl_dereference(ovs_net->ct_limit_info);
+                       if (likely(info))
+                               info->default_limit = zone_limit->limit;
                        ovs_unlock();
                } else if (unlikely(!check_zone_id(
                                zone_limit->zone_id, &zone))) {
@@ -1695,8 +1709,13 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
                        ct_limit->limit = zone_limit->limit;
 
                        ovs_lock();
-                       ct_limit_set(info, ct_limit);
+                       info = ovsl_dereference(ovs_net->ct_limit_info);
+                       if (likley(info))
+                               ct_limit_set(info, ct_limit);
                        ovs_unlock();
+
+                       if (unlikley(!info))
+                               kfree(ct_limit);
                }
                rem -= NLA_ALIGN(sizeof(*zone_limit));
                zone_limit = (struct ovs_zone_limit *)((u8 *)zone_limit +
---

This may memory allocations are kept outside of the lock and we're also not
holding the lock for a long time in case of a long list of entries.

Note that this version of my suggestion doesn't return on error.  This
should be fine, since the only way info is NULL is if the namespace is
being destroyed anyway.  And we're not returning errors from this code
when the id is out of range, so not returning an error here is not that
different.  But, please, note that in the commit message.

Also, returning ENOENT for the SET command is kind of weird, as it is
supposed to create the entries when they do not exist.

>  	rem = NLA_ALIGN(nla_len(nla_zone_limit));
>  	zone_limit = (struct ovs_zone_limit *)nla_data(nla_zone_limit);
>  
>  	while (rem >= sizeof(*zone_limit)) {
>  		if (unlikely(zone_limit->zone_id ==
>  				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
> -			ovs_lock();
>  			info->default_limit = zone_limit->limit;
> -			ovs_unlock();
>  		} else if (unlikely(!check_zone_id(
>  				zone_limit->zone_id, &zone))) {
>  			OVS_NLERR(true, "zone id is out of range");
> @@ -1688,15 +1705,15 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
>  			struct ovs_ct_limit *ct_limit;
>  
>  			ct_limit = kmalloc_obj(*ct_limit, GFP_KERNEL_ACCOUNT);
> -			if (!ct_limit)
> +			if (!ct_limit) {
> +				ovs_unlock();
>  				return -ENOMEM;
> +			}
>  
>  			ct_limit->zone = zone;
>  			ct_limit->limit = zone_limit->limit;
>  
> -			ovs_lock();
>  			ct_limit_set(info, ct_limit);
> -			ovs_unlock();
>  		}
>  		rem -= NLA_ALIGN(sizeof(*zone_limit));
>  		zone_limit = (struct ovs_zone_limit *)((u8 *)zone_limit +
> @@ -1706,32 +1723,37 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
>  	if (rem)
>  		OVS_NLERR(true, "set zone limit has %d unknown bytes", rem);
>  
> +	ovs_unlock();
>  	return 0;
>  }
>  
> -static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
> -				       struct ovs_ct_limit_info *info)
> +static int ovs_ct_limit_del_zone_limit(struct ovs_net *ovs_net,
> +				       struct nlattr *nla_zone_limit)
>  {
> +	struct ovs_ct_limit_info *info;

Reverse xmass tree.

>  	struct ovs_zone_limit *zone_limit;
>  	int rem;
>  	u16 zone;
>  
> +	ovs_lock();
> +	info = ovsl_dereference(ovs_net->ct_limit_info);
> +	if (!info) {
> +		ovs_unlock();
> +		return -ENOENT;
> +	}
> +

Same thing here.  We should just deref and check under the existing
locks inside the while loop:

@@ -1723,14 +1742,18 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
                if (unlikely(zone_limit->zone_id ==
                                OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
                        ovs_lock();
-                       info->default_limit = OVS_CT_LIMIT_DEFAULT;
+                       info = ovsl_dereference(ovs_net->ct_limit_info);
+                       if (likely(info))
+                               info->default_limit = OVS_CT_LIMIT_DEFAULT;
                        ovs_unlock();
                } else if (unlikely(!check_zone_id(
                                zone_limit->zone_id, &zone))) {
                        OVS_NLERR(true, "zone id is out of range");
                } else {
                        ovs_lock();
-                       ct_limit_del(info, zone);
+                       info = ovsl_dereference(ovs_net->ct_limit_info);
+                       if (likely(info))
+                               ct_limit_del(info, zone);
                        ovs_unlock();
                }
                rem -= NLA_ALIGN(sizeof(*zone_limit));
---

The code doesn't return any errors when the zone was not found,
so we shouldn't return ENOENT when the info is not found either.

>  	rem = NLA_ALIGN(nla_len(nla_zone_limit));
>  	zone_limit = (struct ovs_zone_limit *)nla_data(nla_zone_limit);
>  
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
> @@ -1741,6 +1763,7 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
>  	if (rem)
>  		OVS_NLERR(true, "del zone limit has %d unknown bytes", rem);
>  
> +	ovs_unlock();
>  	return 0;
>  }
>  
> @@ -1796,12 +1819,10 @@ static int ovs_ct_limit_get_zone_limit(struct net *net,

Should add a comment above the function that it is called under
RCU read lock.

>  							&zone))) {
>  			OVS_NLERR(true, "zone id is out of range");
>  		} else {
> -			rcu_read_lock();
>  			limit = ct_limit_get(info, zone);
>  
>  			err = __ovs_ct_limit_get_zone_limit(
>  				net, info->data, zone, limit, reply);
> -			rcu_read_unlock();
>  			if (err)
>  				return err;
>  		}
> @@ -1828,19 +1849,16 @@ static int ovs_ct_limit_get_all_zone_limit(struct net *net,

Same here.

>  	if (err)
>  		return err;
>  
> -	rcu_read_lock();
>  	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; ++i) {
>  		head = &info->limits[i];
>  		hlist_for_each_entry_rcu(ct_limit, head, hlist_node) {
>  			err = __ovs_ct_limit_get_zone_limit(net, info->data,
>  				ct_limit->zone, ct_limit->limit, reply);
>  			if (err)
> -				goto exit_err;
> +				return err;
>  		}
>  	}
>  
> -exit_err:
> -	rcu_read_unlock();
>  	return err;
>  }
>  
> @@ -1850,7 +1868,6 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
>  	struct sk_buff *reply;
>  	struct ovs_header *ovs_reply_header;
>  	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
> -	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
>  	int err;
>  
>  	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_SET,
> @@ -1863,8 +1880,8 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
>  		goto exit_err;
>  	}
>  
> -	err = ovs_ct_limit_set_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
> -					  ct_limit_info);
> +	err = ovs_ct_limit_set_zone_limit(ovs_net,
> +					  a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]);
>  	if (err)
>  		goto exit_err;
>  
> @@ -1884,7 +1901,6 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
>  	struct sk_buff *reply;
>  	struct ovs_header *ovs_reply_header;
>  	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
> -	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
>  	int err;
>  
>  	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_DEL,
> @@ -1897,8 +1913,8 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
>  		goto exit_err;
>  	}
>  
> -	err = ovs_ct_limit_del_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
> -					  ct_limit_info);
> +	err = ovs_ct_limit_del_zone_limit(ovs_net,
> +					  a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]);
>  	if (err)
>  		goto exit_err;
>  
> @@ -1918,7 +1934,7 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
>  	struct ovs_header *ovs_reply_header;
>  	struct net *net = sock_net(skb->sk);
>  	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
> -	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
> +	struct ovs_ct_limit_info *ct_limit_info;
>  	int err;
>  
>  	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_GET,
> @@ -1932,18 +1948,21 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
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
>  
>  	nla_nest_end(reply, nla_reply);
>  	genlmsg_end(reply, ovs_reply_header);
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

