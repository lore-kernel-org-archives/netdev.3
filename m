Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB626AE5
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790208718; cv=none; b=mq6igKBVFEmjMwB32Quk6/L5gr1eEElUEujoxCr4nTogLYJUQotp6znLYp/gwUySdyRDJZg4oWHiPD5c6Ahi1efgOErySkUkQrJzBmFjUv+0/NeCvbiZ0X2/7469Q8+xvllelOSF4QUcWmFK9IF6OL93Q2SnY3MrNajyw7DRdGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790208718; c=relaxed/simple;
	bh=rNAF9vb55p8LzCTznmJGJ+ZH0fBKNKJj99sxBni/RBs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TXQFACQaU9N40QjhAZaOPe9BNEG6mahITLslr3gW1lDNs1MtM71uQwRN4tnQnM5N1jd3FCtjUlWUlxtUGpyNDc8/YGI4FbHsJvmZ43YxhD+Lv+bacYKcEk3Bzz0pWc7usQPEgeeAODBISFrODzOQNK2FVNZHn3jyCP9/LisgDi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cm16FvEC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm16FvEC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF561F00893;
	Thu, 24 Sep 2026 00:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790208716;
	bh=VdAESG/YQbxrAPJ7C6Pcl3ryZ1XSQRRKTo4Kw0yeBRI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cm16FvECpKtmquNeoz8POLMHWYw477qQXe6EzoVBmYT82ZYEKzxzh8QkemqrUhbfN
	 znMaDmqVNhJlCuBs0B6/4tf27Dnd5VLwL5pELqFYoq+519DtV/sIcgv6u+Gvy7/8gF
	 glUtLTGMOGhnLwkU4VHh5B8ipSV/ptOtZY7wTiSgjW9WUBFVfX2zexQTkloRnsvzyQ
	 ZTKWMYtyzEmdYcN1kKTBFKc4CThXK1bzha2PUyqsaZsHcAiYsVXJFuRyCwiyQ6zAr+
	 LE4Et/hqXT0wJt+kEDB0/459seXJbZgfQLwUJJwDC7m5lrMFQEUrbio+iUNK57xH9u
	 xu2pdNyNmbzDg==
Subject: Re: [PATCH v6 net-next 2/8] vxlan: vnifilter: use
 list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Thu, 24 Sep 2026 00:11:55 +0000
Message-ID: <179020871585.2160803.17477682416813463151@kernel.org>
In-Reply-To: <20260922181102.3989489-3-edumazet@google.com>
References: <20260922181102.3989489-3-edumazet@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Claim: the paginated RTM_GETTUNNEL dump keeps purely positional
  cursors (cb->args[0] = ordinal in the per-netns netdev list,…

--

vxlan: vnifilter: use list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()

This switches the vg->vni_list walk in vxlan_vnifilter_dump_dev() to
list_for_each_entry_rcu(), and adds a device ifindex cookie in
cb->args[2] so that a stale VNI offset in cb->args[1] is not carried
over to the next device during a paginated RTM_GETTUNNEL dump.

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index 336e8128be480..0a04e8875f7dc 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -333,22 +333,34 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
>  				    struct sk_buff *skb,
>  				    struct netlink_callback *cb)
>  {
> -	struct vxlan_vni_node *tmp, *v, *vbegin = NULL, *vend = NULL;
> +	struct vxlan_vni_node *v, *vbegin = NULL, *vend = NULL;
>  	struct vxlan_dev *vxlan = netdev_priv(dev);
>  	struct tunnel_msg *new_tmsg, *tmsg;
> -	int idx = 0, s_idx = cb->args[1];
>  	struct vxlan_vni_group *vg;
>  	struct nlmsghdr *nlh;
> +	int idx = 0, s_idx;
>  	bool dump_stats;
>  	int err = 0;
>  
> -	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
> +	if (cb->args[2] != dev->ifindex) {
> +		cb->args[1] = 0;
> +		cb->args[2] = dev->ifindex;
> +	}
> +	s_idx = cb->args[1];

[Severity: Low]
The cursors here stay purely positional: cb->args[0] is an ordinal into the
per-netns netdev list and cb->args[1] is an ordinal into vg->vni_list, and
RTNL is dropped between dump skbs.

Should user space be told when the dump was interrupted in this window, for
example a VNI removed from an already partially dumped device, where the
ifindex cookie still matches and the remaining VNIs shift down by one?

The netlink guidelines describe this as a generation counter recorded in
netlink_callback.seq so nl_dump_check_consistent() can set
NLM_F_DUMP_INTR.  The following patch in this series, "vxlan: vnifilter:
signal interrupted RTM_GETTUNNEL dumps", does exactly that (per-netns
vnifilter_seq bumped from __vxlan_vni_add_list()/__vxlan_vni_del_list()/
vxlan_vni_update_group() and from vxlan_netdevice_event(), with
cb->seq = vxlan_vnifilter_base_seq(net) set in vxlan_vnifilter_dump()), so
at the end of the series the signal is in place.  Would it be worth
mentioning that dependency in this changelog, since on its own this patch
leaves nl_dump_check_consistent() inert?

For the device side, an already partially dumped device can only move to a
lower ordinal, since list_netdevice() appends with list_add_tail_rcu(), so
the new clearing of cb->args[1]/cb->args[2] on the early returns does not
appear to introduce duplicated entries.

>  
> [ ... ]
>  
> @@ -394,6 +406,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
>  	}
>  
>  	cb->args[1] = err ? idx : 0;
> +	cb->args[2] = err ? dev->ifindex : 0;
>  
>  	nlmsg_end(skb, nlh);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922181102.3989489-1-edumazet%40google.com
