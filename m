Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4929F59D625
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907750; cv=none; b=Ikvv2yIY9MMUfj+wW5f/avPu0Qh4jj7N9mKPFvZvXl+eRP8v/B+K3FfePIPSnXCSHICL3tmpFj0PoHova0jxYHgWw6m5rpvl811vSPwxg5iMcpMC7T0FR/+k2TRWyvO2AFdKgZzq955CFEgQCLRrGacOpTx1qMbIvwuodzB/fIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907750; c=relaxed/simple;
	bh=7AMJfBhCWUs0PJPMngZINcs681MAZ7tdcrpycdoNJ2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=My9yznvaRTkq8qHjAwDz1EKHPAjRjZsjN8MGT+xs1KWDlfmaSOcqYHRSZwjUZb+XiM5Ak66jSm9lB5rzw1AZ9ZBARC0imcesMihsqKvOShOnx/9gEjWdzfn1xf8B2u5QmLTPc4t9q0MeA80rrvYXYBfRqSIZ8Bx0v34J1CCm960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvYtSHus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvYtSHus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B196E1F00ADB;
	Tue,  8 Sep 2026 22:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907742;
	bh=+L+nPtt7tbUsJ52z6dbQ6ZjHQXA5H/cCKKJXfBSrQDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gvYtSHusnT7u8fHFzoi3+ddZPs42hSBlsHrWkHOpJ/ql27ahKWh7MstMBiIbuALcU
	 n2vRWNwhznhDWUol1rKV9Lbv36dGSqpNP9udNH7HmCswPqXchTeunuKhBkCf/6CPn+
	 9e2QZF+I0JkqgWi/dJMLvCMEuGK7U1oSBWD3grqqbjdpOXBgqJxCzvgeFRGMn2dS8m
	 AL/DZnvonOyczYaS2DMX99PUPGX0VgjdQ8UsW06jCC9FUYkDZ0NdBPZKz+m7HqPVyL
	 flCdHaDpNXTxxXcy92DkEdD/4G+oVlll7LyCzXv1aCEYpyZOdPFCidZTujD5IWduK0
	 NsBYkzkkbS2Wg==
From: Jakub Kicinski <kuba@kernel.org>
To: steffen.klassert@secunet.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	netdev@vger.kernel.org
Subject: Re: [PATCH 10/12] xfrm: hold net_device reference under RCU in bundle creation
Date: Tue,  8 Sep 2026 15:49:01 -0700
Message-ID: <20260908224901.1591334-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907093020.2228346-11-steffen.klassert@secunet.com>
References: <20260907093020.2228346-11-steffen.klassert@secunet.com>
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
xfrm: hold net_device reference under RCU in bundle creation

This converts the dst->dev reads in xfrm_bundle_create() and
xfrm_create_dummy_bundle() to dst_dev_rcu() and keeps the RCU read-side
critical section open until xfrm_fill_dst() has taken the device
references, closing a use-after-free when a concurrent RTM_DELLINK runs
dst_dev_put().

Link: https://lore.kernel.org/all/20260820200245.44312-1-blbllhy@gmail.com/

> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 932a313b9460a..513c9f2283347 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -2770,9 +2770,12 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
>  	xdst0->path = dst;
>  
>  	err = -ENODEV;
> -	dev = dst->dev;
> -	if (!dev)
> +	rcu_read_lock();
> +	dev = dst_dev_rcu(dst);
> +	if (!dev) {
> +		rcu_read_unlock();
>  		goto free_dst;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but should the same treatment be
applied to the other dst->dev reads in this file?  The caller in the reported
stack trace, xfrm_lookup_with_ifid(), still reads dst_orig->dev twice and
dereferences it on the nopol path with no rcu_read_lock() held:

net/xfrm/xfrm_policy.c:xfrm_lookup_with_ifid() {
	...
nopol:
	if ((!dst_orig->dev || !(dst_orig->dev->flags & IFF_LOOPBACK)) &&
	    READ_ONCE(net->xfrm.policy_default[dir]) == XFRM_USERPOLICY_BLOCK) {
		err = -EPERM;
		goto error;
	}
	...
}

dst_orig here is a plain route dst that the caller only holds a dst
reference on, and a dst reference does not pin dst->dev.  The writer side
publishes the replacement and drops the device reference together:

net/core/dst.c:dst_dev_put() {
	...
	rcu_assign_pointer(dst->dev_rcu, blackhole_netdev);
	netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
			   GFP_ATOMIC);
	...
}

The old device is then freed after the synchronize_net() in
unregister_netdevice_many(), which only waits for readers inside an RCU
read-side critical section.  If this thread is preempted between the NULL
test on dst_orig->dev and the dev->flags load, can it read a freed
net_device the same way xfrm6_fill_dst() did?  The entry path is the one in
the commit message, udpv6_sendmsg() -> ip6_dst_lookup_flow() ->
xfrm_lookup_route() -> xfrm_lookup_with_ifid(), reaching nopol when
DST_NOXFRM is set or policy_count is zero.

Would dst_dev_rcu() under an rcu_read_lock() be appropriate here as well?

There is a second unannotated read of the same __rcu published pointer in
__xfrm_decode_session():

net/xfrm/xfrm_policy.c:__xfrm_decode_session() {
	...
		if (skb_dst(skb) && skb_dst(skb)->dev)
			oif = skb_dst(skb)->dev->ifindex;
	...
}

This bypasses the skb_dst_dev_rcu()/dst_dev_rcu() accessor contract and its
RCU coverage depends entirely on the caller.  Is that read guaranteed to run
inside an RCU read-side critical section on every path into
__xfrm_decode_session()?

For what it is worth, the dst->dev read in xfrm_bundle_ok() looks fine: the
dst there is an xfrm_dst whose ->dev holds its own tracked reference taken
by xfrm4_fill_dst()/xfrm6_fill_dst() via netdev_hold(), so it cannot be
freed while that xfrm dst is alive.
