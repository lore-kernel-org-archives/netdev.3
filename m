Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329707;
	b=jMNJ2Vk1svpqZvsB7n1akCnBibmrHdQpvH3u1wGMWDmYk0gcT4E8iRZ0sr+dyDk0cUxF
	 sdbrer/e+UtHkYsQb9420wWIiiz/wVdZsv2+5/7oXTIX4x4aU9eXYdLnIe0hSVYFmJkdf
	 5HoknrQPAfpEA5cU6gBkY5CYUUgGr6N6mdqMaHQaQ84yKn8rb9IcxJ5O8pdKywEM7zqDk
	 G+jwlYj7bRvLNf5rqcaINVTqvXgfzB9z0G2ZV72pocsx2TsCD2bsuVmrNPFDIJrnC6Udh
	 k/+wUEbbHFBZz2/aTLZH/F9qAv57RdACUCMsWj3ykLTUIbOT3E2xSbZBux6Mi5fgDtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329707;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=md+g1Mn70lLLdOLh0WK7BFL83o0AsS7eFKgJ4bZ+xOc=;
	b=ISQX0M7vqUfNVg+uPcBTKJbqzVRvm/kJ9jhTO72VnRtfv/4b6dKbd9aoxcczNJCsLU9E
	 6YkNg0V/EeAhDuIn5pPj9ZRynOe76/FUgSnel/8OC3YaQ6n+S3M4JclqFUAVhgu6mKfsp
	 9n7oUd1RS62b7cbB+PmtbzJ6pc0y1iXOv+o6F8SVNjFEq9XlqoGWg7GN1qupv+whSh/Gd
	 hVfsps9VjvK62fNFx6zQAFBzEV9u9q6HTAeC8A1p/gDFcBx3JfCVirP2wpDyUicemJpql
	 sJyWCOuG1A0NPmNPe0fD5eBMzOyRotOH49nuAS/zeVlj+eL6sGrXKqxeIanugfdFg6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ru3DSI1J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D098360A263E;
	Tue, 10 Nov 2026 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ru3DSI1J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48A61F008A2;
	Tue, 10 Nov 2026 16:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329706;
	bh=md+g1Mn70lLLdOLh0WK7BFL83o0AsS7eFKgJ4bZ+xOc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ru3DSI1JtOvz1pz0p79Q21P9c/g0n6OobX9gSnI2to6yPqXyqv7OClz0s5fQ/RafU
	 Ar5W8KAQkdNyinf3mYJre4tTQkvbrHXpVQ5t+AmEdfcmOMSEFxKH1DIWwZg8x5NdF6
	 wC5JpNUEqCRrl5tl91d+CyoB/rwVuArrsutgzHGAPWdhKQ9OwSlhnh6UYN5fr1TvDQ
	 IoSpAp9Epowf9ReFqyFY9hZtRZStY/T2cqbcdDWr2LJKCGDlf56uZJ5S+wtEh7vEKC
	 h5aKWMYotcL65pKD29f9mGsW4Wo4wTzLlVym0byZox/2z1Tv2D4ei7gWuM3M8mcI6m
	 R05podtcK/jdg==
Subject:
 Re: [PATCH net-next 4/5] net: rnpgbe: Allow changing the primary MAC address
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, yaojun@mucse.com
Date: Tue, 10 Nov 2026 16:55:05 +0000
Message-ID: <179432970545.994134.2511152521699003993@kernel.org>
In-Reply-To: <425F4F0858D134DD+20261106112544.44210-1-dong100@mucse.com>
References: <425F4F0858D134DD+20261106112544.44210-1-dong100@mucse.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit 'net: rnpgbe: Allow changing the primary MAC address'
  adds two entries to rnpgbe_netdev_ops in…

--

net: rnpgbe: Allow changing the primary MAC address

This commit adds ndo_set_mac_address support to the rnpgbe driver, so the
primary MAC address can be changed while the interface is up or down. The
new address is validated with eth_prepare_mac_addr_change(), written to
RAR 0, and then committed to the netdev.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 31871b244882d..09d499dc10eeb 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> @@ -160,6 +160,8 @@ static const struct net_device_ops rnpgbe_netdev_ops = {
>  	.ndo_stop		 = rnpgbe_close,
>  	.ndo_start_xmit		 = rnpgbe_xmit_frame,
>  	.ndo_set_rx_mode_async = rnpgbe_set_rx_mode,
>  	.ndo_set_mac_address	 = rnpgbe_set_mac_address,
> +	.ndo_validate_addr	 = eth_validate_addr,

[Severity: Low]
This isn't a bug, but should the commit message also mention the
ndo_validate_addr hook added to rnpgbe_netdev_ops?

The commit message only covers ndo_set_mac_address:

  Add ndo_set_mac_address support to change the primary MAC address
  while the interface is up or down. Validate the new address with the
  standard Ethernet helpers, then update the primary receive address
  filter and the netdev address.

The "Validate the new address" sentence refers to the
eth_prepare_mac_addr_change() call in rnpgbe_set_mac_address().

eth_validate_addr is a separate change. __dev_open() calls it on every
ifup, so opening the device can now fail with -EADDRNOTAVAIL if
netdev->dev_addr is not a valid unicast address. Before this patch, open
did no such check.

As far as I can tell this check cannot fire today. In
rnpgbe_add_adapter(), probe either sets a firmware MAC that has already
passed is_valid_ether_addr() in rnpgbe_get_permanent_mac(), or it falls
back to eth_hw_addr_random(). After probe, rnpgbe_set_mac_address()
rejects invalid addresses.

Could the commit message mention the open-time validation, or could the
hook move to its own patch?

>  	.ndo_get_stats64	 = rnpgbe_get_stats64,
>  };

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/FB722C2F25FE9005%2B20261106112420.43050-1-dong100%40mucse.com
