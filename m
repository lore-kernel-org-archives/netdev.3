Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B743547F2DB
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943489; cv=none; b=FIJ+XX4NKwMPIowivT3TCnLAqRtkezej5NvEUFkUA77OZ12g+MfMvZBrDvlK4vBPxgI9eu+zjDE5mJlRz780Uq7tkrcuj5Rvuho9I74ewC7Bpd1u0mKhVbj5ZhHbKGHqHpWWqKwk2uqokjoj4P2Z4B1sRGb4XPUu9ROwexhdajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943489; c=relaxed/simple;
	bh=ePm9i7Kk92Y+hDUY+8+o7WMulCg0zQFnIVps8v3mnJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9eQSWtwgrldeS9aJ5la3yOQ+YBXweNlClaTRWTxhLtRc3Q6wYWlNUpyRibWwV+RWWG9sxPMk8OvyoT/TbkbPX9HG/0X2k9vwQu/nDCXilBw0CaM1+9vEqvCbT3sFtcDlmG2VWrWWXaTH6d/3ruPBZzq7fEKdWikKAY6MZ+xRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=gTkp12CN; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="gTkp12CN"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-499db1a5b5eso1579175e9.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1788943482; x=1789548282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J8Aqe2ScHV++lSSph7hCxIE0TonE2FREGCTyr4JGGuw=;
        b=gTkp12CN+DDjYdsD+HU2XVf+PV48ZldoOWLYfYF0Y5Z9EiWv9lLMPa2UGWWLPS/WQg
         eCKwXgYDfXlCICqbew467uvXmfEch0DicWOeqv0htrgYe4Q5fJy2J3Nqp1FBYvO9OtQz
         N4l3Q+GdvxaAQNOTshMhJSHlDO0IidVELDGw/mqlTYPDFLpAKdAH0kqzd3M89/vACN8X
         MU4xEV7QTYTcugJkF4d27L5EXzocN84liWjezrin1f5O/eKUL0OFakjzKobfEj9yHl3k
         4MWqU0UUc6H34xtJEytMQMZoZKHqDTj+Czp6ZBoL249NjpT9WctWQu/j/N8XLeM6wO9Q
         yHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788943482; x=1789548282;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J8Aqe2ScHV++lSSph7hCxIE0TonE2FREGCTyr4JGGuw=;
        b=Hypg8zwzFK+9NuE3FOQvtIndchpZ/0bYE9S2FWVYvnNoSl4SQ068cUwvENrzGOrWlV
         xfp9KGNFZihtCqsP7LQPxpg4W1wqjtLP9nXEwUKAoRXC9m+0R1uhT/G+uHZusdRqQhfP
         Nl7P0nr8YmtGg6ZLqI2Hla4Xdemo/ZuXVMv12xWPHd1AkQjBpLdcjoku9P9daAD3PDL6
         oJCiGcOO7Fn4ge0rK0+VCBfDfiB17zn70C2hITsxQrDuIXqXnjgXn9nDjJGBnZbVK5UD
         +uyqRBCAx/+sfqCXxiZp3nDD2HPqqoO5PWCeXNmroyDcCY1c+DaJ90OLHNoj1g/S4JKD
         jYnw==
X-Forwarded-Encrypted: i=1; AKwUvByWCIpcdbk29P4a5M0Pblw9AztUsjwll8G/ed5xamiTueLHAoVvYp5SbmJAvTF2pgFpKlQkVfY=@vger.kernel.org
X-Gm-Message-State: AFuF++mvP3Nq7eDi7iN6dtyhWOobXPJqhuzf+10FWCdJ7EZnXP2OO7mu
	JIynwSBgWOdaTYMBiimCg8c/VT58CaKPq9DNGeg2yxvEUZL+qD7JB7576NzgNIlWIgU=
X-Gm-Gg: AYBFou13up57kwzb6qWHnKYsHis2nlCSFAoy4nzWVxSIxMW7vXIBSghW81PqPOlbRLH
	GeLdmSzMNxErUOzwtVkjfnRnTMqkFwz6q+fwE7mwf0bzBGmz81daWGn/d3RC7XY0ILCblsaGWjI
	3tEXI2oJB2h2COFk8GRFdQ/t8x/Zo4ptGAAEFR7dBYrD2QB/9sqvZh8hz34ReDlEPc1iQmEthZP
	trNNLeSDZHbPexCRd3FC6Z/o9rccPzJ8IfSvFAR9QgHgISizidrPFZzlzx2kp18wpKFZ1YuX6AB
	YlL/qxRrRxzn2LaeaDtE7L1FykYqktphe67eD6xDG77Sv+eJCKkRwZUtLQbcYs/pCo4EDVSrY7m
	XFjOK6gI2jpMT5/23gapFzyOZEU4Cv+oj1obrZu2g+FEc2WG98LKHYVuJFfh82HkrRC8uP1g0fj
	ouikx+CfZjgK6WjwKhj825XB4HtBQqPcsDGQDL1Z3mNPwYSBEX3zKnrEUPWUiYpO0mdj/sq8nbN
	JLjvAFWG0Fl9Tq4zo3ddy/Z7QS7oHNtlMHN888uuXgIdQza7KBo
X-Received: by 2002:a05:600c:c494:b0:49b:916a:e553 with SMTP id 5b1f17b1804b1-49d010c2a57mr242611125e9.0.1788943482177;
        Wed, 09 Sep 2026 01:44:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm634667375e9.13.2026.09.09.01.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 01:44:41 -0700 (PDT)
Message-ID: <175b6b01-2f8e-4b77-8504-6f26d9f8df98@6wind.com>
Date: Wed, 9 Sep 2026 10:44:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2 1/3] rtnetlink: add AF_PACKET multicast dumps
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260909013401.14408-1-sigefriedhyy@gmail.com>
 <20260909013401.14408-2-sigefriedhyy@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260909013401.14408-2-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 09/09/2026 à 03:33, Yuyang Huang a écrit :
> RTM_GETMULTICAST dumps IPv4 and IPv6 multicast group memberships, but
> the device multicast list (dev->mc) is only available through
> /proc/net/dev_mcast, so "ip maddr show" still has to parse procfs for
> its link-layer entries.
> 
> Handle RTM_GETMULTICAST dumps with ifa_family set to AF_PACKET and
> report every entry of dev->mc in the existing ifaddrmsg format:
> 
>   - IFA_MULTICAST carries the raw link-layer address
>   - IFA_MC_USERS carries the entry reference count
>   - IFA_F_PERMANENT marks entries added with SIOCADDMULTI
>     (netdev_hw_addr::global_use, "static" in "ip maddr")
The global flag is also set for addresses added via dev_mc_add_excl(), ie by
some drivers.

>   - ifa_scope is RT_SCOPE_LINK
> 
> This covers every column of /proc/net/dev_mcast. AF_PACKET is the
> family iproute2 already uses for link-layer addresses ("ip -0"), and
> AF_UNSPEC keeps its "all families" meaning from RTM_GETADDR.
> 
> The default FDB dump also walks dev->mc, but only for Ethernet devices
> without an ndo_fdb_dump of their own, so bridge, vxlan or macvlan
> devices never show their multicast filter there, and it has no users
> count or SIOCADDMULTI bit. Extending it would change "bridge fdb show"
> output and add NDA_* attributes, while this dump needs no new uAPI.
> 
> There are no legacy users of AF_PACKET requests, so they are always
> validated: prefixlen, flags and scope must be zero, no attributes are
> accepted, and a non-zero ifa_index restricts the dump to that device.
> The dump runs under RCU and netif_addr_lock_bh() and does not need
> RTNL.
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
> ---
>  net/core/rtnetlink.c | 129 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 81c5a6104dea..b2febdb6915e 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4566,6 +4566,133 @@ static int rtnl_dump_all(struct sk_buff *skb, struct netlink_callback *cb)
>  	return skb->len ? : ret;
>  }
>  
> +static int rtnl_fill_mcaddr(struct sk_buff *skb, const struct net_device *dev,
> +			    const struct netdev_hw_addr *ha, u32 portid,
> +			    u32 seq, unsigned int flags)
> +{
> +	struct ifaddrmsg *ifm;
> +	struct nlmsghdr *nlh;
> +
> +	nlh = nlmsg_put(skb, portid, seq, RTM_GETMULTICAST, sizeof(*ifm),
> +			flags);
> +	if (!nlh)
> +		return -EMSGSIZE;
> +
> +	ifm = nlmsg_data(nlh);
> +	ifm->ifa_family = AF_PACKET;
> +	ifm->ifa_prefixlen = 0;
> +	ifm->ifa_flags = ha->global_use ? IFA_F_PERMANENT : 0;
I wonder if adding a new attribute IFA_F_GLOBAL would not make the API more
understandable.

> +	ifm->ifa_scope = RT_SCOPE_LINK;
> +	ifm->ifa_index = dev->ifindex;
> +
> +	if (nla_put(skb, IFA_MULTICAST, dev->addr_len, ha->addr) ||
> +	    nla_put_u32(skb, IFA_MC_USERS, ha->refcount)) {
> +		nlmsg_cancel(skb, nlh);
> +		return -EMSGSIZE;
> +	}
> +
> +	nlmsg_end(skb, nlh);
> +	return 0;
> +}
> +
> +static int rtnl_dump_mcaddr_dev(struct net_device *dev, struct sk_buff *skb,
> +				struct netlink_callback *cb, int *s_addr_idx,
> +				unsigned int flags)
> +{
> +	struct netdev_hw_addr *ha;
> +	int addr_idx = 0;
> +	int err = 0;
> +
> +	netif_addr_lock_bh(dev);
> +	netdev_for_each_mc_addr(ha, dev) {
> +		if (addr_idx < *s_addr_idx) {
> +			addr_idx++;
> +			continue;
> +		}
> +		err = rtnl_fill_mcaddr(skb, dev, ha, NETLINK_CB(cb->skb).portid,
> +				       cb->nlh->nlmsg_seq, flags);
> +		if (err < 0)
> +			break;
> +		addr_idx++;
> +	}
> +	netif_addr_unlock_bh(dev);
> +
> +	*s_addr_idx = err < 0 ? addr_idx : 0;
> +
> +	return err;
> +}
> +
> +static int rtnl_valid_dump_mcaddr_req(const struct nlmsghdr *nlh,
> +				      struct netlink_ext_ack *extack,
> +				      int *pifindex)
> +{
> +	struct ifaddrmsg *ifm;
> +
> +	ifm = nlmsg_payload(nlh, sizeof(*ifm));
> +	if (!ifm) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Invalid header for multicast dump request");
> +		return -EINVAL;
> +	}
> +
> +	if (ifm->ifa_prefixlen || ifm->ifa_flags || ifm->ifa_scope) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Invalid values in multicast dump header");
> +		return -EINVAL;
> +	}
> +
> +	if (nlmsg_attrlen(nlh, sizeof(*ifm))) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Invalid data after multicast dump header");
> +		return -EINVAL;
> +	}
> +
> +	*pifindex = ifm->ifa_index;
> +
> +	return 0;
> +}
> +
> +static int rtnl_dump_mcaddr(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	struct net *net = sock_net(skb->sk);
For consistency with ipv4/ipv6, it would be nice to handle IFA_TARGET_NETNSID.

> +	unsigned int flags = NLM_F_MULTI;
> +	struct {
> +		unsigned long ifindex;
> +		int addr_idx;
> +	} *ctx = (void *)cb->ctx;
> +	struct net_device *dev;
> +	int ifindex;
> +	int err;
> +
> +	err = rtnl_valid_dump_mcaddr_req(cb->nlh, cb->extack, &ifindex);
> +	if (err < 0)
> +		return err;
> +
> +	rcu_read_lock();
> +
> +	if (ifindex) {
> +		cb->answer_flags |= NLM_F_DUMP_FILTERED;
> +		flags |= NLM_F_DUMP_FILTERED;
> +		dev = dev_get_by_index_rcu(net, ifindex);
> +		if (!dev) {
> +			err = -ENODEV;
> +			goto out;
> +		}
> +		err = rtnl_dump_mcaddr_dev(dev, skb, cb, &ctx->addr_idx, flags);
> +		goto out;
> +	}
> +
> +	for_each_netdev_dump(net, dev, ctx->ifindex) {
> +		err = rtnl_dump_mcaddr_dev(dev, skb, cb, &ctx->addr_idx,
> +					   flags);
> +		if (err < 0)
> +			break;
> +	}
> +out:
> +	rcu_read_unlock();
> +	return err;
> +}
> +
>  struct sk_buff *rtmsg_ifinfo_build_skb(int type, struct net_device *dev,
>  				       unsigned int change,
>  				       u32 event, gfp_t flags, int *new_nsid,
> @@ -7251,6 +7378,8 @@ static const struct rtnl_msg_handler rtnetlink_rtnl_msg_handlers[] __initconst =
>  	{.msgtype = RTM_SETSTATS, .doit = rtnl_stats_set},
>  	{.msgtype = RTM_NEWLINKPROP, .doit = rtnl_newlinkprop},
>  	{.msgtype = RTM_DELLINKPROP, .doit = rtnl_dellinkprop},
> +	{.protocol = PF_PACKET, .msgtype = RTM_GETMULTICAST,
> +	 .dumpit = rtnl_dump_mcaddr, .flags = RTNL_FLAG_DUMP_UNLOCKED},
>  	{.protocol = PF_BRIDGE, .msgtype = RTM_GETLINK,
>  	 .dumpit = rtnl_bridge_getlink},
>  	{.protocol = PF_BRIDGE, .msgtype = RTM_DELLINK,

