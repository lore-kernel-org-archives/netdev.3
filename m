Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4EE399CE4;
	Mon, 25 May 2026 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741679; cv=none; b=g172tyzvwH91mR8dhhY7esO1WqX+WXSlWWSgItBMte03xktiukOT9VxFRXJro/6Oiui8miRG3nmto4FX5bPWQP8vouUEh4rGRDNQ5GND9cOkWcFURT3GqxX8IAE7U5w3LZYenR8yv8w0IbRNeX8Y3N71WcmKqoKu3DrpqloXO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741679; c=relaxed/simple;
	bh=oMLMgK6JmTjkHWAmtA2JJLc+RJPM2xIIzlw2GaHgSPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pa90wX87/EC/1qY9e3u8kWJbU89n4QTNC7qoiBv49sn/vqyUHuLgPa0Q/mY49zlzJv+SmYmcYYXQYFlw1jKaXL1sapJihikFShcw+yvLiR1shoVZL/IzYxYN5qpSgySfgvTbyAvtKM4/LGuLBXOEc43ZjrtooI2B2+vGYcBI1q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZaV1Bs7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZaV1Bs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C071F000E9;
	Mon, 25 May 2026 20:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741677;
	bh=FQXWkOiULchnn+wXhs4w2nhqOSOrVReGbgp27hIZ2rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eZaV1Bs7zXfJqvoKBHAtSe2//1sTyYXQWjtcKR3QZPKSq5TBi5aWV/hm2b4gluPYs
	 0vT0tc4CwYghRAhcjboYRUj2VIQlKYvUdxVurliIxAS9RCGalwvdv6QdsxmDfZDpeO
	 jDSwtgyKbEWl/fzOigq9jXFuKKSe3OkNjNh+mPDYQYDjOaFNqh+NNE5KZp7QkMBCwa
	 Ec7JIylPJFdMdo6u8dTQvobjb0CzCWiLaimaF/V+oa+l1eDjH8sQdxePSqTALlbEl0
	 4nGGvOnIpQywWIJHMK6B41dIhk8IrQT8NrmU5SYUAMXuivxcTxZ/eRO5JZb1JCWe9x
	 HjjlEvEmMWzdg==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.dege@renesas.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	yoshihiro.shimoda.uh@renesas.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	niklas.soderlund@ragnatech.se,
	paul@pbarker.dev,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 10/14] net: renesas: rswitch: update port HW init
Date: Mon, 25 May 2026 13:41:16 -0700
Message-ID: <20260525204116.2471424-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522-rswitch_add_vlans-v5-10-53589d944a9f@renesas.com>
References: <20260522-rswitch_add_vlans-v5-10-53589d944a9f@renesas.com>
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
net: renesas: rswitch: update port HW init

Certain Ethernet and cpu port settings need to be updated for vlan
support.

> diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
> index a445d9a8505d8..13e59d2d08282 100644
> --- a/drivers/net/ethernet/renesas/rswitch_main.c
> +++ b/drivers/net/ethernet/renesas/rswitch_main.c

[ ... ]

> @@ -895,6 +899,7 @@ static bool rswitch_rx(struct net_device *ndev, int *quota)
>  	limit = boguscnt;
>  
>  	desc = &gq->rx_ring[gq->cur];
> +
>  	while ((desc->desc.die_dt & DT_MASK) != DT_FEMPTY) {
>  		dma_rmb();
>  		skb = rswitch_rx_handle_desc(ndev, gq, desc);

[Severity: High]
This is a pre-existing issue, but does this code leak receive buffer
fragments allocated via netdev_alloc_frag() when packet assembly fails?

In rswitch_rx_handle_desc(), if build_skb() fails for a start fragment,
or if a middle/end fragment arrives without a preceding start fragment,
the function returns NULL.

The caller rswitch_rx() then jumps to the out label:

	skb = rswitch_rx_handle_desc(ndev, gq, desc);
	if (!skb)
		goto out;
	...
out:
	gq->rx_bufs[gq->cur] = NULL;

This executes gq->rx_bufs[gq->cur] = NULL, discarding the pointer to the
memory previously allocated by netdev_alloc_frag(). Because the fragment
is neither attached to an SKB nor explicitly freed before the pointer is
zeroed, this appears to cause an unrecoverable memory leak.
