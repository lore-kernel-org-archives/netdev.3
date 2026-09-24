Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDDA4D0A12;
	Thu, 24 Sep 2026 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271373; cv=none; b=lbg7xAm2mrmKIASqYUmsBJLrIqCpXsdd5GSrnzZdJggV+ouQ0o06TIlPebEONIIx+8RqdQz5jGotf6ZIeaG5r9Io2sVKsk2eOuRDckVeLOSI44KR3Wuav+zVnrrxO9tSvtyIzdB9cKa1qWgvi55d+ezBcSr4Q03B60lruT8EvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271373; c=relaxed/simple;
	bh=G9a3/ldRt7NsqVgwHUF/D7U6FJCqGqgC5L1oJA42CiY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bglmol+08cyxgcCwip2c+a+RPzSp9sR9qQ2UViVhIBFTSQ1C+I31xb2ueiBgVdfhgvqPxDwMRKC+rU4qKDPYZ7++wqpdo+8p1T8awwP+WDHQYUW7tgjXYaPNv+VUS2BpfAGpnrNNzx7UbkrNQUbSfY/F6HtOPuyuPI45+kNdcFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqbnOpKT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqbnOpKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B981F000FF;
	Thu, 24 Sep 2026 17:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271372;
	bh=LbYLt5qDLRw8rsQouH9GU6xm5xjYUB1tiDw/VfJwMdE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HqbnOpKTFOpij9C3y1hCdGigvS+/q+91i0/4yWMxrIJix4LgnnzU7Z5d3YoCrkw7/
	 lXj0IcWiUAscNiFn3UzWECXSu/gXTWzdrWX9kPsXmMLBpgX5ly7W/GnJ0ABmA6E1R3
	 l5PB0GjNYj+syFKqKWdE/ZS17clV/FiPLduNX/6/LrbqVHoNdrHDoBuHadVAXf5vld
	 jG0prgKOf7mkCe20sEY8Av/7Eun7TZ3Zr24cLB/+31aGKapB4LHmOH2z+mn3EVlw/q
	 1vKr4vn8WFvZyJY2XPUM8RfUoN+I9fDE5/zx3+CMY4L1HxgQTlHCEQxOGkSVk3+Gms
	 /+fucPHyddv3A==
Subject: Re: [PATCH net 5/6] net: bcmasp: account for offload header in TX
 short packet padding
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Thu, 24 Sep 2026 17:36:10 +0000
Message-ID: <179027137077.2160803.14243651452303687960@kernel.org>
In-Reply-To: <20260922221630.3864427-6-florian.fainelli@broadcom.com>
References: <20260922221630.3864427-6-florian.fainelli@broadcom.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix only works for linear skbs.

--

net: bcmasp: account for offload header in TX short packet padding

This patch makes the TX padding threshold in bcmasp_xmit() include
sizeof(struct bcmasp_pkt_offload) when hardware checksum offload is in
use. bcmasp_csum_offload() pushes that 20-byte header onto the skb, and
the hardware strips it before transmission. Without the adjustment,
short frames could go out below ETH_ZLEN + ETH_FCS_LEN.

> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> index 7a63a592f158d..3370cbf1b395a 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c

[ ... ]

> @@ -267,8 +267,12 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
>  	for (i = 0; i <= nr_frags; i++) {
>  		if (!i) {
>  			size = skb_headlen(skb);
> -			if (!nr_frags && size < (ETH_ZLEN + ETH_FCS_LEN)) {
> -				if (skb_put_padto(skb, ETH_ZLEN + ETH_FCS_LEN))
> +			min_size = ETH_ZLEN + ETH_FCS_LEN;
> +			if (csum_hw)
> +				min_size += sizeof(struct bcmasp_pkt_offload);
> +
> +			if (!nr_frags && size < min_size) {
> +				if (skb_put_padto(skb, min_size))
>  					return NETDEV_TX_OK;
>  				size = skb->len;
>  			}

[Severity: High]
Does this still let short checksum-offloaded frames go out undersized
when the skb is non-linear?

The new min_size is only applied when nr_frags is zero, and it is
compared against skb_headlen() rather than skb->len.

bcmasp_interface_create() advertises scatter-gather together with L4
checksum offload:

	ndev->features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_SG |
			  NETIF_F_RXCSUM;

tcp_sendmsg_locked() copies payload into page frags through
skb_copy_to_page_nocache(). This means small TCP segments arrive here
as CHECKSUM_PARTIAL skbs with headers in the linear area and
nr_frags >= 1.

As an example, take an IPv4 TCP segment without timestamps carrying 1
to 5 bytes of payload. That is 14 + 20 + 20 + N = 55 to 59 bytes.
bcmasp_csum_offload() pushes the 20-byte header and sets csum_hw, so
skb->len becomes 75 to 79. That is below the new min_size of 84.

Because nr_frags == 1, skb_put_padto() is never called. The hardware
strips the offload header and a 55 to 59 byte frame goes out on the
wire. This looks like the same failure the commit message describes:

  "causing short frames to skip padding and be sent on the wire smaller
  than the minimum Ethernet frame size (ETH_ZLEN + ETH_FCS_LEN)"

For TCP, retransmits of that segment would have the same non-linear
shape, so they could be dropped by the receiver every time.

Would it be better to make the padding decision on skb->len before the
descriptor loop? One way is skb_put_padto() or eth_skb_pad(), which
linearize through __skb_pad(), followed by re-reading nr_frags.

The pad can't safely happen inside the loop. nr_frags is cached before
bcmasp_csum_offload():

	nr_frags = skb_shinfo(skb)->nr_frags;

If the skb were linearized in the middle of the loop, the loop would go
on indexing frags that no longer exist.

As far as I can tell, no later patch in the series changes this code in
bcmasp_intf.c.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922221630.3864427-1-florian.fainelli%40broadcom.com
