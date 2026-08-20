Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499647A879
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241648; cv=none; b=DDYL0Y9ANI1MTOHJByIAHobsX8JQu8FkMSVSKn0Nu/mWytSMHsrngBy12wBUREyAxWsk5W4d387U3M6W3PMOhxXIsKh1MOq9jgkFPzhBhSO+coqetGPEB67N+3PKjByckxNRbjgzQKwzT31qzvTchIBxnb60NPpsBMAoQpqnL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241648; c=relaxed/simple;
	bh=e98Ns8RgG/tO3hM5DQu0vN9cSQETsDuOjG+T/IL8T8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRJs8QeLMIX8PjonNVNo6P1u18d4VEag9VKYsxgfoUIrIGuSgqgc39/qepfrICJYCswKJy261WKLDGrNBCHWFDe5BkK7aga7Vuwly7LFY428qcJrdTBu6Hq1zvYyDobF2q/uQ0KowVqcL42q7+VMVe5pj32LoHfXaLWxTtMj0Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-6a3eef59914so52794a12.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787241645; x=1787846445;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iUyYQjAnVD8EWDvTGAzja/w49BNS2xoeSYKZ1O6OnsU=;
        b=l/K8PKkbGtZEw6qLi13qgF5BNhffb+x5OVxI/+oYQ+kVcPQltHNC07TvBM/F5v6Q51
         iBqiDenKnRCUhxbmQCSKd6YVlx0H9aTkeMrKL8FqU4S1kP0eheDgBO0koQ2faKIJObu+
         htG1bX2i47IAzbu5HKmGU7PnmVR8Pweylj5jrzb6UOFWnxtGruAJFbrIyQhz//VjdwKy
         zwIBwCwJt8omr99P6f4Fk8+7zE+P05FHIHELSrRB+UWWGKnsVsrh1HNeKaehhs4f2Xbg
         wwOXkraQp8ExBAhLzRm//fxoKYdY5BNKjBllqsW2ZnyNnqsxPU+Sp601zdhdB/XQ0PeJ
         jNIQ==
X-Forwarded-Encrypted: i=1; AHgh+RpKGa4zEnO87sDMhhNYcQkaj5FGcbmHpt7aWTy3sLgS5aHJ890rjIAerD42s0IICzComSnD+5Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lV4lLx533+xuJIDUh4vFbUvXlxA6Br2N6q29Ps4XWogbbbmRAP
	6FaNtoOWAY+uzN0FZhp52Fot9NzHAaAr/pqbJSjJsM95azo90x/QXmYg
X-Gm-Gg: AR+sD10rUORTgSRnvTBYE5F1iDDkvJj8tkhE4f7RmeW7+GvYUkqSl6mP9JoB3sQvMhs
	l9luLbtjZ/8q1JvoZcH9B9SXTZ3w1y/4sY3FB4EbBHqIDSwcHjZE24fp8uIJJ73dWSVZx3li6u2
	jbbVq5kr8k/U/OJq+C8vQOXh5SjUIdxNAEz6Uv4RtLI18d3vgd+mh/jtKCuxjF1Y219a8uYRbHk
	Vl1AMMJ2O07gBEsGxsyziiq73mHCakTZTIjvHD2yt5jVbvHQtf8tdYGK2vHJo1dwahWJ1hSUvvT
	yoUwAbiV4CwQuEOQStoUHgxNZZDAV3XhtUuyPdLMOV8sSAiKlFJbm9eukEZPkYibiqEKONbTRKw
	aNgekcCZ4QuncWzS2BcagHLMKrpdnypAe/J0h1L+O0PPbqb/IRcAa3nnb3oexkqzOCtEKxl5ix6
	fpFPaP7OGx7H6DZ7dDETiJymrijsVI9JUe+vjmZX9XFj9vBdsgQWayTFMNtnMSOZK0Na1RQPpUi
	9qGtuufqj8JNzIE
X-Received: by 2002:a05:6402:44c4:b0:6a3:ff14:ebc9 with SMTP id 4fb4d7f45d1cf-6a4033429a8mr9099352a12.11.1787241644709;
        Thu, 20 Aug 2026 09:00:44 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3fec280e9sm2469945a12.0.2026.08.20.09.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 09:00:43 -0700 (PDT)
Message-ID: <aeae9794-f94d-4eca-99f1-c3c6dc3ef9cc@ovn.org>
Date: Thu, 20 Aug 2026 18:00:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v8 1/1] openvswitch: Fix CT limit teardown
 use-after-free
To: Yuqi Xu <xuyuqiabc@gmail.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Yi-Hung Wei <yihung.wei@gmail.com>,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Vega <vega@nebusec.ai>, Nan Li <tonanli66@gmail.com>,
 Ren Wei <enjou1224z@gmail.com>
References: <cover.1787129643.git.xuyuqiabc@gmail.com>
 <d9687780533d0b257e01ab792c8206a69beb281e.1787129643.git.xuyuqiabc@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <d9687780533d0b257e01ab792c8206a69beb281e.1787129643.git.xuyuqiabc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/26 11:24 AM, Yuqi Xu wrote:
> Packet processing uses CT limit state under RCU, while netns teardown
> frees that state under ovs_mutex. The CT limit pointer was neither removed
> from readers nor protected by a grace period, allowing packet processing to
> dereference the freed state.
> 
> An unprivileged user can trigger this bug from a user and network
> namespace, causing a slab-use-after-free in ovs_ct_execute() when the
> netns is torn down.
> 
> Publish the CT limit pointer through RCU, remove it before teardown, and
> wait for readers before freeing its contents. Keep ovs_mutex around
> individual CT limit updates, and use the RCU read-side lock while GET
> traverses the RCU-protected limit lists.
> 
> Netns teardown detaches the RCU-protected CT limit state in the pernet
> .pre_exit callback while holding ovs_mutex.  The pernet core guarantees an
> RCU grace period between the .pre_exit and .exit callbacks, so the .exit
> callback completes the teardown without adding any extra synchronization.
> 
> The netlink command handlers do not need NULL checks because the userspace
> netlink socket holds an active reference to its network namespace while a
> request is processed. The per-netns exit path therefore cannot run
> concurrently with SET, DEL, or GET for that socket's namespace.
> 
> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/all/cover.1784711445.git.xuyuqiabc@gmail.com
> Assisted-by: Codex:GPT-5.4
> Co-developed-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
> ---
> 
> Changes in v8:
> 
> - Rebase onto net/main, which now contains the adjacent nf_connlabels
>   leak fix.
> - Move the CT limit detach to the pernet .pre_exit callback and complete
>   the teardown in .exit, relying on the RCU grace period that the pernet
>   core guarantees between the two. Drop the extra synchronize_rcu() and
>   use plain kfree() in the teardown path.
> - v7 Link: https://lore.kernel.org/all/cover.1786936669.git.xuyuqiabc@gmail.com/

[...]

> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index ded46d993a4e..362e322fb41f 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -2757,17 +2757,24 @@ static void __net_exit list_vports_from_net(struct net *net, struct net *dnet,
>  	}
>  }
>  
> +static void __net_exit ovs_pre_exit_net(struct net *dnet)
> +{
> +	ovs_lock();
> +	ovs_ct_exit_start(dnet);
> +	ovs_unlock();
> +}
> +
>  static void __net_exit ovs_exit_net(struct net *dnet)
>  {
> -	struct datapath *dp, *dp_next;
>  	struct ovs_net *ovs_net = net_generic(dnet, ovs_net_id);
>  	struct vport *vport, *vport_next;
> +	struct datapath *dp, *dp_next;

Shouldn't move these around now that there are no other changes.

>  	struct net *net;
>  	LIST_HEAD(head);
>  
>  	ovs_lock();
>  
> -	ovs_ct_exit(dnet);
> +	ovs_ct_exit_finish(dnet, ovs_net->ct_exit_data);

This will not compile without CONFIG_NETFILTER_CONNCOUNT.
There is also asymmetry here.  The value is not set in this
module, there is no point to pass it from here.  The finish()
function can access it through the dnet pointer.

>  
>  	list_for_each_entry_safe(dp, dp_next, &ovs_net->dps, list_node)
>  		__dp_destroy(dp);
> @@ -2791,6 +2798,7 @@ static void __net_exit ovs_exit_net(struct net *dnet)
>  
>  static struct pernet_operations ovs_net_ops = {
>  	.init = ovs_init_net,
> +	.pre_exit = ovs_pre_exit_net,
>  	.exit = ovs_exit_net,
>  	.id   = &ovs_net_id,
>  	.size = sizeof(struct ovs_net),
> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
> index 696640e88fa7..446553c51c30 100644
> --- a/net/openvswitch/datapath.h
> +++ b/net/openvswitch/datapath.h
> @@ -164,7 +164,10 @@ struct dp_upcall_info {
>   * Protected by genl_mutex.
>   * @dp_notify_work: A work notifier to handle port unregistering.
>   * @masks_rebalance: A work to periodically optimize flow table caches.
> - * @ct_limit_info: A hash table of conntrack zone connection limits.
> + * @ct_limit_info: Hash table of conntrack zone connection limits. Protected
> + * by RCU; updates and teardown are serialized by ovs_mutex. May be NULL during
> + * netns teardown.
> + * @ct_exit_data: CT limit state detached at .pre_exit, freed at .exit.
>   * @xt_label: Whether connlables are configured for the network or not.
>   */
>  struct ovs_net {
> @@ -172,7 +175,8 @@ struct ovs_net {
>  	struct work_struct dp_notify_work;
>  	struct delayed_work masks_rebalance;
>  #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> -	struct ovs_ct_limit_info *ct_limit_info;
> +	struct ovs_ct_limit_info __rcu *ct_limit_info;
> +	struct ovs_ct_limit_info *ct_exit_data;

Maybe rename into ct_limit_exit_data, since it is only for the limits
and guarded by the CONFIG_NETFILTER_CONNCOUNT.

>  #endif
>  	bool xt_label;
>  };
> 

