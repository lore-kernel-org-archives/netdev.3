Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552F39D6E9
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472334; cv=none; b=UOdyq9JnLtrvGxb8dzLFG4Iw64r1a+43fTt1wPG0bKV084ki0VwdNAytD2jM4fY+yeNV50sfk0C+ZHqAxKO0IFVDJnxvimcOpsXybfBL4JJRwEf8JOTJ5Q9u3gWHgeU8rTdeiNYj/AM9JxMGd/0Nx4XbXg5aB6MxYcu1g95/z7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472334; c=relaxed/simple;
	bh=vFqskwQFA6Ct7+KYBX7ArKE5Hs2Wq54dcwzGVUZ70to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQ0jef72W5aBstOw3Cvq1unYpzGGf4Yt0nokciUBMOYR/WGVCExhtnMROeOKMvzh2FWru+C+JZpfpvtG0LWnIslXefZdI9nhUwFXT/SfgO4srzekdwcEncV/ZQoWPn7wEstyT1pCwe3N/DylBqhKpLtWjaCPfn35435RfxIfABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mxEIRRnK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mxEIRRnK"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so92897035e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780472331; x=1781077131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=neDSgt1MPe5zWskeM7FOmL0bhkA8C24EluOX3+GZicw=;
        b=mxEIRRnKctksFjZf3G1j+SdHFF+ByfX8Yn+/E9EhL0iWGvPWjJrmzr/QIJbKXRKaNi
         9OpdHfMKK+u23kJ785KN/V8NB7vnsJCW4iYMNol4IIbagtvof4VjPQdTNCqmqwqKZKBp
         GX9R+KukXUY9M+gFPRi2nbVKrLy+B8q7aXFWw658nE6/SuvymwYd04EMRTB3IvLamXDr
         WsSzysRDKNLyzea1dWJiNmTIQFfFK9vmsyDgaysftaNai8BkSJ0QbC42JvBjzqBszPcF
         /eL66biPIkY0jyMEhMlcY0hU3Fb2JhZRD9+VWN4s8E83Hy25RsX/ffyjWbpuQW/hYrIK
         gQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780472331; x=1781077131;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neDSgt1MPe5zWskeM7FOmL0bhkA8C24EluOX3+GZicw=;
        b=eusAfMFOVwRqjnzYqNWbRX3R7VE7/zPeP4w87Hf2KF/DBGcUkPrLNeaA57TczHhopg
         CRFOYR05Rc0gzscqZkrvFa/oRYn9cEykzQw0bgHdxhTXDWMYsKVVgHq60aHaaz7h5cK9
         xSXzvwm5d2ZqAA1/FOYw+Ovg+3WfjULjpO8q5UHfe5vD404UF66XFsVRTPZcslrYqERK
         bJytsjbIzh7iIUAzb/WtX/VWoQUpXlobi+qHRCTHnmFsHdqh2DTaT9Uhv9NhkgmJh9FI
         4Awrkwriqtn2ztgxuuMZpD9IpCPbMQVBHbVXuBVge6I/poKXhMiceRVhvI15vtgD8ulG
         3IBw==
X-Gm-Message-State: AOJu0YzOlutqZemsm9/YjOPMQ5HtM1RgLv8B3kF6Mj+xnYeaUcbFHOdc
	c5aKO0xMLkLrhcO/j2kCAd7BihxE0bjTeFMpiZSJLqKKJLapOjcB3OXR+cr1kIcTwRA=
X-Gm-Gg: Acq92OFR/SJTizjJL2bOu0VFJbNGNc0TxMfMdIqi0cWAxly6hqTVedqSdR8My5ii+F5
	3ynb3WwNwtGTtRhfX+NFalwjt61K/Z8ZjsVBeuMQyWnM+nJ0aeM3U50U8AMozIbXBGT9NevIMM5
	sJeTXXAgp/MUoL6vYlwB7oQrH+ronjvtUkw3QPifUi42awIQw/VrL/fDJWhHgLIjA4TTYtIPsFn
	97OUphQyQTX1DOoEuikwo1+r/2ZKVsnTlGkYGKALPZ6In/e8I6XAZrnMt6Jtk3nj9r3xRKWcWb6
	vEaVIF77zJzVwozjXG4aqFoJvbnuGSSBZmcVIX9fm2rw5Y40NP0FWEFBszaLu63tcMzQCGY2Ayf
	2VB5dsysGWZr9CQkOGxHz/B5knYqaYETunhmplyWeJLY7FgvY5T325YiqFaL+Id9kV3mrS9dVaq
	Uz4yIRzB/d/umA0fOfJpVAWjad9qe/QLQ8KKngq583k6WlqMZnlmXsa6nJO+3kW1SHLIGXZYRCv
	+8=
X-Received: by 2002:a05:600c:6389:b0:490:b9c3:6c48 with SMTP id 5b1f17b1804b1-490b9c36dbemr12598615e9.29.1780472331066;
        Wed, 03 Jun 2026 00:38:51 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b725fb1bsm31394425e9.8.2026.06.03.00.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:38:50 -0700 (PDT)
Message-ID: <30f0378e-af59-44a3-8904-3dfa39235f33@blackwall.org>
Date: Wed, 3 Jun 2026 10:38:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/6] net: bridge: convert mdb_entry
 host_joined to a flags field
Content-Language: en-US, bg
To: Luke Howard <lukeh@padl.com>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
 Max Hunter <max@huntershome.org>, Kieran Tyrrell <kieran@sienda.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-2-72be14522e7c@padl.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260602-mv88e6xxx-8021qat-mqprio-v2-2-72be14522e7c@padl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/2026 03:43, Luke Howard wrote:
> Replace the bool host_joined in struct net_bridge_mdb_entry with a u8
> flags field and a BRIDGE_MDBE_F_HOST_JOINED bit.
> 
> Signed-off-by: Luke Howard <lukeh@padl.com>
> ---
>   net/bridge/br_input.c     |  2 +-
>   net/bridge/br_mdb.c       | 14 ++++++++------
>   net/bridge/br_multicast.c | 26 ++++++++++++++------------
>   net/bridge/br_private.h   |  4 +++-
>   net/bridge/br_switchdev.c |  2 +-
>   5 files changed, 27 insertions(+), 21 deletions(-)
> 

it's best these new flags to be unsigned long and use test/set_bit for
manipulating them, otherwise kcsan won't be happy

> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 470615675bdc0..5787066b1f4cb 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -188,7 +188,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>   		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
>   		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
>   		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
> -			if ((mdst && mdst->host_joined) ||
> +			if ((mdst && (mdst->flags & BRIDGE_MDBE_F_HOST_JOINED)) ||
>   			    br_multicast_is_router(brmctx, skb) ||
>   			    br->dev->flags & IFF_ALLMULTI) {
>   				local_rcv = true;
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 3ddfbd536edb4..b95ca72ec6347 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -344,7 +344,7 @@ static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
>   			break;
>   		}
>   
> -		if (!s_pidx && mp->host_joined) {
> +		if (!s_pidx && (mp->flags & BRIDGE_MDBE_F_HOST_JOINED)) {
>   			err = __mdb_fill_info(skb, mp, NULL);
>   			if (err) {
>   				nla_nest_cancel(skb, nest2);
> @@ -1053,7 +1053,8 @@ static int br_mdb_add_group(const struct br_mdb_config *cfg,
>   
>   	/* host join */
>   	if (!port) {
> -		if (mp->host_joined && !(cfg->nlflags & NLM_F_REPLACE)) {
> +		if ((mp->flags & BRIDGE_MDBE_F_HOST_JOINED) &&
> +		    !(cfg->nlflags & NLM_F_REPLACE)) {
>   			NL_SET_ERR_MSG_MOD(extack, "Group is already joined by host");
>   			return -EEXIST;
>   		}
> @@ -1381,7 +1382,8 @@ static int __br_mdb_del(const struct br_mdb_config *cfg)
>   		goto unlock;
>   
>   	/* host leave */
> -	if (entry->ifindex == mp->br->dev->ifindex && mp->host_joined) {
> +	if (entry->ifindex == mp->br->dev->ifindex &&
> +	    (mp->flags & BRIDGE_MDBE_F_HOST_JOINED)) {
>   		br_multicast_host_leave(mp, false);
>   		err = 0;
>   		br_mdb_notify(br->dev, mp, NULL, RTM_DELMDB);
> @@ -1619,7 +1621,7 @@ br_mdb_get_reply_alloc(const struct net_bridge_mdb_entry *mp)
>   		     /* MDBA_MDB_ENTRY */
>   		     nla_total_size(0);
>   
> -	if (mp->host_joined)
> +	if (mp->flags & BRIDGE_MDBE_F_HOST_JOINED)
>   		nlmsg_size += rtnl_mdb_nlmsg_pg_size(NULL);
>   
>   	for (pg = mlock_dereference(mp->ports, mp->br); pg;
> @@ -1658,7 +1660,7 @@ static int br_mdb_get_reply_fill(struct sk_buff *skb,
>   		goto cancel;
>   	}
>   
> -	if (mp->host_joined) {
> +	if (mp->flags & BRIDGE_MDBE_F_HOST_JOINED) {
>   		err = __mdb_fill_info(skb, mp, NULL);
>   		if (err)
>   			goto cancel;
> @@ -1702,7 +1704,7 @@ int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
>   	spin_lock_bh(&br->multicast_lock);
>   
>   	mp = br_mdb_ip_get(br, &group);
> -	if (!mp || (!mp->ports && !mp->host_joined)) {
> +	if (!mp || (!mp->ports && !(mp->flags & BRIDGE_MDBE_F_HOST_JOINED))) {
>   		NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
>   		err = -ENOENT;
>   		goto unlock;
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 5d6fdfb43c046..4107bf7bd271f 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -391,13 +391,13 @@ static void br_multicast_sg_host_state(struct net_bridge_mdb_entry *star_mp,
>   
>   	if (WARN_ON(!br_multicast_is_star_g(&star_mp->addr)))
>   		return;
> -	if (!star_mp->host_joined)
> +	if (!(star_mp->flags & BRIDGE_MDBE_F_HOST_JOINED))
>   		return;
>   
>   	sg_mp = br_mdb_ip_get(star_mp->br, &sg->key.addr);
>   	if (!sg_mp)
>   		return;
> -	sg_mp->host_joined = true;
> +	sg_mp->flags |= BRIDGE_MDBE_F_HOST_JOINED;
>   }
>   
>   /* set the host_joined state of all of *,G's S,G entries */
> @@ -425,7 +425,8 @@ static void br_multicast_star_g_host_state(struct net_bridge_mdb_entry *star_mp)
>   			sg_mp = br_mdb_ip_get(br, &sg_ip);
>   			if (!sg_mp)
>   				continue;
> -			sg_mp->host_joined = star_mp->host_joined;
> +			sg_mp->flags &= ~BRIDGE_MDBE_F_HOST_JOINED;
> +			sg_mp->flags |= star_mp->flags & BRIDGE_MDBE_F_HOST_JOINED;
>   		}
>   	}
>   }
> @@ -453,7 +454,7 @@ static void br_multicast_sg_del_exclude_ports(struct net_bridge_mdb_entry *sgmp)
>   	 * we treat it as EXCLUDE {}, so for an S,G it's considered a
>   	 * STAR_EXCLUDE entry and we can safely leave it
>   	 */
> -	sgmp->host_joined = false;
> +	sgmp->flags &= ~BRIDGE_MDBE_F_HOST_JOINED;
>   
>   	for (pp = &sgmp->ports;
>   	     (p = mlock_dereference(*pp, sgmp->br)) != NULL;) {
> @@ -824,7 +825,8 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
>   	hlist_add_head(&pg->mcast_gc.gc_node, &br->mcast_gc_list);
>   	queue_work(system_long_wq, &br->mcast_gc_work);
>   
> -	if (!mp->ports && !mp->host_joined && netif_running(br->dev))
> +	if (!mp->ports && !(mp->flags & BRIDGE_MDBE_F_HOST_JOINED) &&
> +	    netif_running(br->dev))
>   		mod_timer(&mp->timer, jiffies);
>   }
>   
> @@ -1470,8 +1472,8 @@ void br_multicast_del_port_group(struct net_bridge_port_group *p)
>   void br_multicast_host_join(const struct net_bridge_mcast *brmctx,
>   			    struct net_bridge_mdb_entry *mp, bool notify)
>   {
> -	if (!mp->host_joined) {
> -		mp->host_joined = true;
> +	if (!(mp->flags & BRIDGE_MDBE_F_HOST_JOINED)) {
> +		mp->flags |= BRIDGE_MDBE_F_HOST_JOINED;
>   		if (br_multicast_is_star_g(&mp->addr))
>   			br_multicast_star_g_host_state(mp);
>   		if (notify)
> @@ -1486,10 +1488,10 @@ void br_multicast_host_join(const struct net_bridge_mcast *brmctx,
>   
>   void br_multicast_host_leave(struct net_bridge_mdb_entry *mp, bool notify)
>   {
> -	if (!mp->host_joined)
> +	if (!(mp->flags & BRIDGE_MDBE_F_HOST_JOINED))
>   		return;
>   
> -	mp->host_joined = false;
> +	mp->flags &= ~BRIDGE_MDBE_F_HOST_JOINED;
>   	if (br_multicast_is_star_g(&mp->addr))
>   		br_multicast_star_g_host_state(mp);
>   	if (notify)
> @@ -3537,7 +3539,7 @@ static void br_ip4_multicast_query(struct net_bridge_mcast *brmctx,
>   
>   	max_delay *= brmctx->multicast_last_member_count;
>   
> -	if (mp->host_joined &&
> +	if ((mp->flags & BRIDGE_MDBE_F_HOST_JOINED) &&
>   	    (timer_pending(&mp->timer) ?
>   	     time_after(mp->timer.expires, now + max_delay) :
>   	     timer_delete_sync_try(&mp->timer) >= 0))
> @@ -3626,7 +3628,7 @@ static int br_ip6_multicast_query(struct net_bridge_mcast *brmctx,
>   		goto out;
>   
>   	max_delay *= brmctx->multicast_last_member_count;
> -	if (mp->host_joined &&
> +	if ((mp->flags & BRIDGE_MDBE_F_HOST_JOINED) &&
>   	    (timer_pending(&mp->timer) ?
>   	     time_after(mp->timer.expires, now + max_delay) :
>   	     timer_delete_sync_try(&mp->timer) >= 0))
> @@ -3722,7 +3724,7 @@ br_multicast_leave_group(struct net_bridge_mcast *brmctx,
>   		     brmctx->multicast_last_member_interval;
>   
>   	if (!pmctx) {
> -		if (mp->host_joined &&
> +		if ((mp->flags & BRIDGE_MDBE_F_HOST_JOINED) &&
>   		    (timer_pending(&mp->timer) ?
>   		     time_after(mp->timer.expires, time) :
>   		     timer_delete_sync_try(&mp->timer) >= 0)) {
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 6a2dabd6f4bfb..1e0eefaf50dd1 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -373,12 +373,14 @@ struct net_bridge_port_group {
>   	struct rcu_head			rcu;
>   };
>   
> +#define BRIDGE_MDBE_F_HOST_JOINED	BIT(0)
> +
>   struct net_bridge_mdb_entry {
>   	struct rhash_head		rhnode;
>   	struct net_bridge		*br;
>   	struct net_bridge_port_group __rcu *ports;
>   	struct br_ip			addr;
> -	bool				host_joined;
> +	u8				flags;
>   
>   	struct timer_list		timer;
>   	struct hlist_node		mdb_node;
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index c46d8e49ce990..39535f1a6b8ce 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -741,7 +741,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
>   		struct net_bridge_port_group __rcu * const *pp;
>   		const struct net_bridge_port_group *p;
>   
> -		if (mp->host_joined) {
> +		if (mp->flags & BRIDGE_MDBE_F_HOST_JOINED) {
>   			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
>   							 SWITCHDEV_OBJ_ID_HOST_MDB,
>   							 mp, NULL, br_dev);
> 

