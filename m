Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E45C339719
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826880; cv=none; b=mmAuo0nTarlObLqwoz2qiHqTufCG5OGwM/rIfj44WPR4az7Kn6rroGOZyHCuwEKgyf5qNiMtql8FCV2OnRDvjcdZJ+hLhWQCLSkPoZX7e3pu0vaFpm879lz9QZAhWcHlmOVYaPcwopTb/d+RCykyuRylJgZrYia6GgRK2sOzO/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826880; c=relaxed/simple;
	bh=FzqhfrxfHIh5adE1a4s+pfQBXbFOe2PvokXajWgp4J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lF62tE8SE5x3QKZyLU4HXFJ56G5kF2J4393QX/AxXseeUE1iRWEcz+mlzcLbTDVhWBvrSYs7rdgdewO006+w17G69J/yc6OoDGd5KbMZAJ2UAYkEeUjLKgDNtsTFscrLRMuLWqWN92M6F8+ub6HywoIENRDZFGI3W+skXZEX+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCWhqn1H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCWhqn1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A760E1F000E9;
	Thu, 23 Jul 2026 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784826878;
	bh=0RqwDEg9CfzbaN2Ne1e178fq54ilr6SB3twv2NkWpKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HCWhqn1HOEUDENALXdRDwoDtwn6XHlwee3N+qv6vipdA4Lpw9ewev30U9+bNvxzoq
	 OnIxk6GKIrgIpmEfaeSK2GPMJUg6EVqdkVwrpDwMHrU4Z/ijKhnThg1gO5rUxFdcom
	 GIySVEcKq77MtxxVPFY69LYAg7GPSsZQ9EW8NnuiswOIJw2GU5bE+ZIPaOfYCC4fwg
	 Q/vvof4aWFcOj2eZ1aKXx7FELwfEwl7Ef7pMBa9815FwMBswFhIGsDIx0LioZtywMV
	 eEnA7QKcfFJQzxrvQaaNM7JFumdvo+FRSyKJn6VK+28+O1oS3yk3VHU7XPSnKY+0nT
	 FKsxTFQrzlPdw==
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
Subject: Re: [PATCH net] tun: prevent underflow in rx headroom calculation
Date: Thu, 23 Jul 2026 10:14:37 -0700
Message-ID: <20260723171437.784955-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721014117.2234892-1-manizada@pm.me>
References: <20260721014117.2234892-1-manizada@pm.me>
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
tun: prevent underflow in rx headroom calculation

This patch clamps good_linear to zero in tun_get_user() so that a large
tun->align value coming from ndo_set_rx_headroom() does not cause
SKB_MAX_HEAD(align) to underflow into a huge size_t when assigned to the
linear variable, and later cause the skb data pointer to end up outside
the allocated head.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index ffbe6f13fb1f..d3be0f2d5df8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1780,6 +1780,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  	}
>  
>  	good_linear = SKB_MAX_HEAD(align);
> +	good_linear = max(good_linear, 0);

[High]
Does this fully cover the IFF_TAP path when align is large enough that
SKB_MAX_HEAD(align) is <= 0?

With the clamp, good_linear becomes 0, and later in tun_get_user() the
non-zerocopy path does:

    copylen = len;
    linear = min(hdr_len, good_linear);
    ...
    if (!linear)
        linear = min_t(size_t, good_linear, copylen);
    skb = tun_alloc_skb(tfile, align, copylen, linear, noblock);

so linear ends up 0 and the resulting skb has skb_headlen(skb) == 0.

For IFF_TAP without IFF_NAPI_FRAGS the code then calls:

    skb->protocol = eth_type_trans(skb, tun->dev);

eth_type_trans() -> eth_skb_pull_mac() -> __skb_pull(skb, ETH_HLEN),
and __skb_pull() has:

    if (unlikely(skb->len < skb->data_len))
        BUG();

Since skb->len and skb->data_len both start at the packet length and
skb->len is decremented by ETH_HLEN in the pull, would this reach the
BUG() when a user writes to /dev/net/tun with tun->align pushed above
the SKB_MAX_HEAD threshold via the OVS/netkit/VXLAN stacking described
in the commit message?

The pre-existing behavior at align == 3776 appears to hit the same
BUG() and align > 3776 pre-patch corrupted memory before reaching it,
so this change is an improvement, but would forcing linear >= ETH_HLEN
in the IFF_TAP path (or calling pskb_may_pull() before eth_type_trans()
regardless of the frags flag) be needed to close the remaining panic?
-- 
pw-bot: cr
