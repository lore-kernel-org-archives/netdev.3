Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7167C3F4104
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026159; cv=none; b=PA6397ucLuXRHBoxS/cTqA3fBarh9081OtKsoDRLDUie9JvLkV0uaVVNF/G3A4GJTmdiZCn34wV0vTtpXrSavUqB1eaBi5TOyy7yRG++dZ+zT7CZs3bBfts8x48tS781Z5LwrZtIdgi/PHHC5mS4bP/hSdgCr5uZVtvQVNf7L9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026159; c=relaxed/simple;
	bh=bzGQoiQkW8uI7NqC5arCnd2gaY9UmdXsas2LavsFtlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/lVhDOoTnyFSINHqaSsT8ZXyq20Ry+NERl4H/njPYtAkgAgzDzNqGB0Hl6fGxgG3RbSG0HmTbErIIj7kZH7lb/Y+I4yeX1OVGaHaVw+L3uWj39EqnIlVc5eAsfxpBjfUfbqHkr5ItxluWsP21yEgtfzS/6iQnSwIQB3lxhwEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duQ8gVKY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duQ8gVKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B9B1F00A3A;
	Thu,  6 Aug 2026 14:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786026158;
	bh=Ra1heKPyNQ3Fw6Q1EdV/5ge1UftVI9s8wvMITfn7+UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=duQ8gVKYziyr/7QcK29EVeQdteeKBUSthakynxitfYnbn0/dlxs0w0uBjaGCfeWHK
	 N4p/3DCdclffJEYTJapoWJTNTih9oNnpILwQTI7QRu9xh0B78Vv7B5govzUEZh369V
	 cX+LjnCMcAtljUrXWA8aEv9XWscOG87at5usmGS/MLK6CMrbm42eFqwxhICKprfJCn
	 ZHQ/ebs3+YRstAlfEmk624+/5Hx8jzHL/NFGUQjPOr+2ABMzXe9ztD9TJ+9N9sKTxo
	 9RyZQjr6HhfbvKFMLYJgfnI2utpBp8GrZ1XzwgHo8DICr70HTRJ2CeoE1xC92pqj9e
	 KWEklbfVNOidg==
From: Jakub Kicinski <kuba@kernel.org>
To: manizada@pm.me
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net v2] net: tun: bound receive headroom
Date: Thu,  6 Aug 2026 07:22:36 -0700
Message-ID: <20260806142236.2353282-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805084504.953162-1-manizada@pm.me>
References: <20260805084504.953162-1-manizada@pm.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "This is what the bots think :)"
---
net: tun: bound receive headroom

This patch clamps the headroom that tun_set_headroom() stores in tun->align
so that SKB_MAX_HEAD(align) in tun_get_user() cannot underflow, and it adds
pskb_may_pull() calls before reading the raw-TUN first byte and the TAP
Ethernet header.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index fed9dfdfcc3bc..efd2e7d75c9ac 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1107,11 +1107,16 @@ static netdev_features_t tun_net_fix_features(struct net_device *dev,
>  static void tun_set_headroom(struct net_device *dev, int new_hr)
>  {
>  	struct tun_struct *tun = netdev_priv(dev);
> +	size_t max_headroom;
>  
> -	if (new_hr < NET_SKB_PAD)
> -		new_hr = NET_SKB_PAD;
> +	max_headroom = min_t(size_t, SKB_MAX_HEAD(0), U16_MAX - 1);
>  
> -	tun->align = new_hr;
> +	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
> +		max_headroom -= ETH_HLEN + NET_IP_ALIGN;
> +	else
> +		max_headroom -= 1;
> +
> +	tun->align = clamp_t(int, new_hr, NET_SKB_PAD, max_headroom);
>  }

[Severity: Low]
Is the upper bound intentionally this tight?  At the clamp maximum,
tun_get_user() computes:

	good_linear = SKB_MAX_HEAD(align);

which evaluates to 1 for raw TUN and ETH_HLEN for TAP.  The non-zerocopy
path then does:

	copylen = len;
	linear = min(hdr_len, good_linear);

so the resulting skb has skb_headlen() of 1 (or 14) bytes.

Does that make every write() carrying a virtio_net_hdr with
VIRTIO_NET_HDR_F_NEEDS_CSUM or a GSO type fail?  The chain
tun_vnet_hdr_tnl_to_skb() -> virtio_net_hdr_to_skb() ends in
skb_partial_csum_set(), which requires the csum offsets to live inside the
linear area:

net/core/skbuff.c:skb_partial_csum_set() {
	...
	if (unlikely(csum_start >= U16_MAX || csum_end > skb_headlen(skb))) {
		net_warn_ratelimited("bad partial csum: ...");
		return false;
	}
	...
}

With a 1-byte or 14-byte headlen that check always fails, so tun_get_user()
takes the err = -EINVAL path, bumps rx_frame_errors and drops the frame for
all checksum-offloaded and GSO traffic while the headroom request is in
effect.

Note that for IFF_TUN, tun_can_build_skb() returns false, so the raw-TUN
path always goes through tun_alloc_skb() and always sees good_linear == 1 at
the bound.  tun_alloc_skb() only overrides linear when prepad + len <
PAGE_SIZE, which is not the case for non-trivial packets at this prepad.

Would reserving a usable linear area instead (for example GOODCOPY_LEN, or
the maximum hdr_len the device can accept) give the same memory-safety
guarantee without turning offloaded traffic into drops?  For a Cc: stable
patch, could the commit message also mention this consequence?  Right now it
only says:

  "Leave one linear byte for raw TUN and a complete Ethernet header for TAP,
   including NET_IP_ALIGN."

> @@ -1822,7 +1827,13 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  	switch (tun->flags & TUN_TYPE_MASK) {
>  	case IFF_TUN:
>  		if (tun->flags & IFF_NO_PI) {
> -			u8 ip_version = skb->len ? (skb->data[0] >> 4) : 0;
> +			u8 ip_version;
> +
> +			if (skb->len && !pskb_may_pull(skb, 1)) {
> +				err = -ENOMEM;
> +				goto drop;
> +			}

[Severity: Low]
Should this path set drop_reason too?  It jumps to drop without touching
drop_reason, so the free_skb label in tun_get_user() reports the initial
SKB_DROP_REASON_NOT_SPECIFIED:

drivers/net/tun.c:tun_get_user() {
	...
free_skb:
	if (!IS_ERR_OR_NULL(skb))
		kfree_skb_reason(skb, drop_reason);
	...
}

Since the call is guarded by skb->len, pskb_may_pull(skb, 1) can only fail
via the GFP_ATOMIC allocation inside __pskb_pull_tail()/pskb_expand_head(),
so SKB_DROP_REASON_NOMEM looks like the accurate value here.

The IFF_TAP arm changed by the same hunk does set an explicit reason for its
pull failure, so the two adjacent sites in the same switch end up reporting
different things to the kfree_skb_reason() tracepoint.

> +			ip_version = skb->len ? (skb->data[0] >> 4) : 0;
>  
>  			switch (ip_version) {
>  			case 4:

[ ... ]

> @@ -1842,7 +1853,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		skb->dev = tun->dev;
>  		break;
>  	case IFF_TAP:
> -		if (frags && !pskb_may_pull(skb, ETH_HLEN)) {
> +		if (!pskb_may_pull(skb, ETH_HLEN)) {
>  			err = -ENOMEM;
>  			drop_reason = SKB_DROP_REASON_HDR_TRUNC;
>  			goto drop;
-- 
pw-bot: cr
