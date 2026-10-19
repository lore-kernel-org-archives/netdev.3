Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B24EA38C
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417576; cv=none; b=Qv6nuqkosbRpkHEmv04r4YHEo0MOr+/KjFZgRqlbGziQqa0mauBgX1Cc8eONpblL/6PCQerqBDFhhTtY517a6vH8NLYz1XRbM8avHY4Cxz33msXwB6g0LzEIh7o7Vx77RJ0B30I4tqX9DQCubo4QvVgM6sqEZpj4oQJcWPQZ8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417576; c=relaxed/simple;
	bh=HNlOMRgr05iS9zkT34hfoQsiQYjyRLYbLhNxi+r3Phs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkQgFDE8ektk+BmyxyOAntvqtNAVdDVBJ2Drhql4AEsEWqEmBTDAGs7m2vajxL6kqoB5vZyTkWJ3IoVn3Jt5iIcg0Ly4G5hS0rrOM19UpJ6oHCknQFlj0z3F3GHUdiUtdCvbmMyaU0t23nyyWYTU+77lI8jtSdNgrvTToRDHPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 70763447B0;
	Mon, 19 Oct 2026 15:36:08 +0200 (CEST)
Date: Mon, 19 Oct 2026 15:36:06 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Andre Brait <andrebrait@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-net] e1000e: segment TSO packets whose headers cross
 a 4 KB boundary
Message-ID: <atYbzARmBOVuRTdW@luna.proxmox.com>
References: <20261018203215.77371-1-andrebrait@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261018203215.77371-1-andrebrait@gmail.com>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1792416967724

Hi Andre,

On 18.10.2026 22:32, Andre Brait wrote:
> [snip]
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 834a5b888..6f95ed19a 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -11,6 +11,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/delay.h>
>  #include <linux/netdevice.h>
> +#include <linux/sizes.h>
>  #include <linux/interrupt.h>
>  #include <linux/tcp.h>
>  #include <linux/ipv6.h>
> @@ -7359,6 +7360,34 @@ static int e1000_set_features(struct net_device *netdev,
>  	return 1;
>  }
>  
> +/**
> + * e1000_features_check - validate offloads for a packet about to be sent
> + * @skb: packet to check
> + * @netdev: network interface device structure
> + * @features: offload features usable for this packet
> + *
> + * The transmit DMA can stop for good when a TSO packet's protocol headers
> + * cross a 4 KB boundary in the buffer holding them: the descriptor is never
> + * written back, the driver reports "Detected Hardware Unit Hang", and only a
> + * reset brings the queue back. Seen on I219-LM/-V (PCH) with forwarded
> + * guest traffic, which arrives as linear GSO skbs that can start anywhere in a
> + * page. Let the stack segment those few packets in software instead.
> + *
> + * Returns: the features to use for @skb.
> + */
> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
> +					      struct net_device *netdev,
> +					      netdev_features_t features)
> +{
> +	if (skb_is_gso(skb) &&
> +	    (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) &&
> +	    (offset_in_page(skb->data) & (SZ_4K - 1)) +
> +	    skb_tcp_all_headers(skb) > SZ_4K)

Hmm, doesn't validate_xmit_skb call validate_xmit_vlan after the
ndo_features_check, which means that the vlan header can be pushed into the
packet? Meaning the packet can grow after this check.

> +		features &= ~NETIF_F_GSO_MASK;
> +
> +	return features;
> +}
> +
>  static const struct net_device_ops e1000e_netdev_ops = {
>  	.ndo_open		= e1000e_open,
>  	.ndo_stop		= e1000e_close,
> @@ -7378,7 +7407,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
>  #endif
>  	.ndo_set_features	= e1000_set_features,
>  	.ndo_fix_features	= e1000_fix_features,
> -	.ndo_features_check	= passthru_features_check,
> +	.ndo_features_check	= e1000_features_check,
>  	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
>  	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
>  };
> -- 
> 2.56.0

Gabriel

