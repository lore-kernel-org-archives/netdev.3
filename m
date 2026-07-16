Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9329E424671
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213324; cv=none; b=bD6w9mpCs9W4gEP7h3brr3fmyoSmHkjorefu+hQlF++MDDIx6Ng3LBX3BcessAfvOSdYln7YUzAiLkvnCs3ldit5t3zMdRmYt1TndWoppv6LAGYF8dnyCSDdI2SbHYD+qgRmzMV+z1PWpX7CZzVXpX2UkPCWXAau9OqUvC6PbuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213324; c=relaxed/simple;
	bh=+XRvv4MQceldV2fwBOvUUPmboGF+ffAPO7oPzG0p4Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adyyJWIKdj4jW3aDVX2pXZEGmQPPk6bSAx575vb30w3ROg0ChGQNJl+2oN32KpWmtRMLFXiFWuQviRADPVwcHfBINxCgEk3wPT197izkrLConH8vqjWoeisAa/lseuuPrTdXNRN0TJKU9Af3LXvWGC8oWgu3qcEVAiyAQdY/MPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBPBr/0Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBPBr/0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3701F000E9;
	Thu, 16 Jul 2026 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213323;
	bh=zQ4TnNCbrQSEpvT7HgWJyZhrbmf2/9fI9VcdMrCRoZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gBPBr/0YzOp6KqfWEL8WAHCvjAvXZqGgHPSNMir6xRdfD+chun1vCYYy0A9fvwdh/
	 4jd2snpQEewh79hrjoJ02092/cilVTNVWoON7yRQvxvzO7ihtX4F7rzAmYNat4yvf4
	 Ql58V/CQXReg2UoxAnewHV0xrFLdg2n2n6xTQHwgdWq0Hd/+HpCtoc//2IDiOx+h/j
	 FMmfavUhqyd09BtRmy9Fol1RoQQPUAp/gW8jJNfwAJxWDhYtbP9jWIV8NxdCevBiaP
	 uR/0meZXM7+bMBoesITAyhb4HLcD6x4dLpzT8mH64py0FkVIApkB/W90fjjurpy51O
	 vXWCiS5KxnTjQ==
From: Simon Horman <horms@kernel.org>
To: alice.kernel@fastmail.im
Cc: Simon Horman <horms@kernel.org>,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lucien.xin@gmail.com,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	dsahern@kernel.org,
	razor@blackwall.org,
	shuah@kernel.org,
	stfomichev@gmail.com,
	andrew+netdev@lunn.ch,
	fw@strlen.de,
	netdev@vger.kernel.org,
	alice@isovalent.com
Subject: Re: [PATCH net-next v9 8/9] geneve: Enable BIG TCP packets
Date: Thu, 16 Jul 2026 15:48:31 +0100
Message-ID: <20260716144830.337991-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710134242.216538-9-alice.kernel@fastmail.im>
References: <20260710134242.216538-9-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [8]: [PATCH net-next v9 8/9] geneve: Enable BIG TCP packets ---
commit d560b2b7c8bd97bea9e23790fdfc21cfe031b961
Author: Alice Mikityanska <alice@isovalent.com>

geneve: Enable BIG TCP packets

In Cilium we do support BIG TCP, but so far the latter has only been
enabled for direct routing use-cases. A lot of users rely on Cilium
with vxlan/geneve tunneling though. The underlying kernel infra for
tunneling has not been supporting BIG TCP up to this point.

> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 011bf9d833caf..a1639ad53077e 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -1745,6 +1745,8 @@ static void geneve_setup(struct net_device *dev)
>  	dev->max_mtu = IP_MAX_MTU - GENEVE_BASE_HLEN - dev->hard_header_len;
>  
>  	netif_keep_dst(dev);
> +	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
> +

[Severity: High]
This is a pre-existing issue, but by enabling BIG TCP on Geneve, will it
expose a bug where valid BIG TCP packets are incorrectly dropped?

In geneve_post_decap_hint(), there is a legacy size check that rejects
packets aggregated by GRO to sizes >= 65536 bytes:

drivers/net/geneve.c:geneve_post_decap_hint() {
	...
	total_len = skb->len - gro_hint->nested_nh_offset;
	if (total_len >= GRO_LEGACY_MAX_SIZE)
		return -E2BIG;
	...
}

When BIG TCP is enabled and the Geneve tunnel is configured with gro_hint,
large flows are aggregated by GRO into packets exceeding 64KB. This will hit
the legacy check and return -E2BIG, causing packet loss for large flows.

>  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
>  	dev->lltx = true;
