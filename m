Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AE2463B88
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142119; cv=none; b=I4PB0kG7u0kRUALsTDF6jBWAmp4kDcAXqrptV46PbDIOeWbfqEhm2zvnF2v3reLG2XBub2KjEUeEjwu5Nzcl46Xll3dtZ1f2vpRMOlBuvbhZvmqM7TlyUPvXXzVhFsYGjO/NSoACvtuw91qG8Hu15XiUwwQ5THBKp4NKiwRrmN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142119; c=relaxed/simple;
	bh=BYhk5C+Zm2lXO/HMuAksvz8NTWmbeCB6INeu8mwY/s4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx7YdoDvTeO2khJs4o62VHSxTuDJYep7mceXk/eDWT1YKpuHgNwSgtu3xda1f0x3r4dwaVM2unjmY3bAABhcZsxjABYgQVIYoL76ND/u4LWIKhah+YI1H+F790NE098HBVFlGgFcscjVf+jgrEy+e7AKw4Jj+kEiY0n4QNtbwa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vguBHYt5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vguBHYt5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792142118; x=1823678118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BYhk5C+Zm2lXO/HMuAksvz8NTWmbeCB6INeu8mwY/s4=;
  b=vguBHYt5d3cvJgQJZ5mUP0p84OyZXYuU9UfuU+jMvr+KlrY5d+nVVtHM
   EU+cab7K9+i5rrxnzgZ/9pzK8d/JgqYzGFPWWza7BYSnF3QI2yAqTT9IO
   Jv1FZLVNa71pS+khnu4c+ymYBjX56bGivE87hlD7j3KyoPmM9WQ9f1ljp
   Tc2phGx86kU13iGO/uab7iZfzqB0znICpVeyPI9fGcHp0ROmHTw0t/tfy
   hW7ZrHk29gvxz8YtvCM/tf80Lc79gaHQroYgPbz8SCj4COuF0nGfdM01u
   nPlfw8uyDLOhjuY+Kj7y+n4Y5mmkjbfrWv28IJrWwGFTDooWa+QH45RCn
   Q==;
X-CSE-ConnectionGUID: UmWDmK0gSDCSf3JPpN/+Mw==
X-CSE-MsgGUID: wX9DVRaCTduudE94hZWUBg==
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="296554681"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2026 02:15:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 16 Oct 2026 02:15:16 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 16 Oct 2026 02:15:12 -0700
Date: Fri, 16 Oct 2026 11:15:12 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <netdev@vger.kernel.org>, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Chintan Vankar <c-vankar@ti.com>, Danish
 Anwar <danishanwar@ti.com>, Daolin Qiu <d-qiu@ti.com>, "David S. Miller"
	<davem@davemloft.net>, Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Neelima Muralidharan <neelima@ti.com>, Paolo Abeni
	<pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>, Pratheesh Gangadhar
 TK <pratheesh@ti.com>, Richard Cochran <richardcochran@gmail.com>, Simon
 Horman <horms@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net-next v9 3/8] hsr: Add a magic header for sending PTP
 packets
Message-ID: <20261016091512.tqrunkdgiorm4jo3@DEN-DL-M70577.microsemi.net>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
 <20261014-hsr_ptp-v9-3-2d20a2a0f816@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014-hsr_ptp-v9-3-2d20a2a0f816@linutronix.de>

> Sending PTP packets (ETH_P_1588) via the HSR stack is pointless in its
> current shape because the requested PTP timestamp is not routed to the
> sender. It also needs to be distinguished on which port the message
> should be sent and whether or not a HSR header should be attached.
> 
> To pass this information, a custom header (struct hsr_inline_header) is
> introduced. This header is expected and mandatory if the ether type is
> ETH_P_1588. To avoid any wrong usage, there is a magic field to ensure
> it really is the header.
> 
> The inline header is just prepended containing the port and header
> parameter. After the header, a regular packet follows. It is ensured that
> the inline header and the following ethernet or HSR header is linear
> and can be accessed. Given that this information is important for how
> PTP is used, PTP packets missing this information will be dropped.
> 
> The two retrieved parameters are passed to hsr_forward_skb() and will be
> used later.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  MAINTAINERS                  |  1 +
>  include/linux/if_hsr.h       |  1 +
>  include/uapi/linux/hsr_ptp.h | 20 ++++++++++++++
>  net/hsr/hsr_device.c         | 66 ++++++++++++++++++++++++++++++++++++--------
>  net/hsr/hsr_forward.c        |  3 +-
>  net/hsr/hsr_forward.h        |  3 +-
>  net/hsr/hsr_slave.c          |  4 +--
>  7 files changed, 82 insertions(+), 16 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f53047aa8d3c1..5f8bed05ed6b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12023,6 +12023,7 @@ F:	drivers/net/usb/hso.c
>  HSR NETWORK PROTOCOL
>  L:	netdev@vger.kernel.org
>  S:	Orphan
> +F:	include/uapi/linux/hsr_ptp.h
>  F:	net/hsr/
>  F:	tools/testing/selftests/net/hsr/
>  
> diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
> index f4cf2dd36d193..7b6b60ef592db 100644
> --- a/include/linux/if_hsr.h
> +++ b/include/linux/if_hsr.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_IF_HSR_H_
>  
>  #include <linux/types.h>
> +#include <uapi/linux/hsr_ptp.h>
>  
>  struct net_device;
>  
> diff --git a/include/uapi/linux/hsr_ptp.h b/include/uapi/linux/hsr_ptp.h
> new file mode 100644
> index 0000000000000..a0b104a3df569
> --- /dev/null
> +++ b/include/uapi/linux/hsr_ptp.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +#ifndef __UAPI_HSR_PTP_H
> +#define __UAPI_HSR_PTP_H
> +
> +#include <linux/types.h>
> +
> +#define HSR_INLINE_HDR  0xaf485352
> +#define HSR_INLINE_HDR_PORT_A	1
> +#define HSR_INLINE_HDR_PORT_B	2
> +
> +struct hsr_inline_header {
> +	__u8 tx_port;
> +	__u8 hsr_hdr;
> +	__u8 __pad0[4];
> +	__be32 magic;
> +	__u8 __pad1[2];
> +	__be16 eth_type;
> +} __attribute__ ((packed));
> +
> +#endif
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 6d96bc4a12446..c5ea7ef0209db 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -223,24 +223,66 @@ static netdev_features_t hsr_fix_features(struct net_device *dev,
>  
>  static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
> +	enum hsr_port_type tx_port = HSR_PT_NONE;
>  	struct hsr_priv *hsr = netdev_priv(dev);
>  	struct hsr_port *master;
> +	bool has_header = false;
>  
>  	rcu_read_lock();
>  	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> -	if (master) {
> -		skb->dev = master->dev;
> -		skb_reset_mac_header(skb);
> -		skb_reset_mac_len(skb);
> -		spin_lock_bh(&hsr->seqnr_lock);
> -		hsr_forward_skb(skb, master);
> -		spin_unlock_bh(&hsr->seqnr_lock);
> -	} else {
> -		dev_core_stats_tx_dropped_inc(dev);
> -		dev_kfree_skb_any(skb);
> +	if (!master)
> +		goto drop;
> +
> +	skb->dev = master->dev;
> +	if (skb->protocol == htons(ETH_P_1588)) {

Seems like this is also accepted for PRP - should it?

> +		struct hsr_inline_header *hsr_opt;
> +		struct ethhdr *eth_hdr;
> +		unsigned int hdr_len;
> +
> +		BUILD_BUG_ON(sizeof(struct hsr_inline_header) != sizeof(struct ethhdr));
> +
> +		/* need to access the magic header */
> +		if (!pskb_may_pull(skb, sizeof(struct hsr_inline_header)))
> +			goto drop;
> +
> +		hsr_opt = (struct hsr_inline_header *)skb_mac_header(skb);
> +		if (hsr_opt->magic != htonl(HSR_INLINE_HDR))
> +			goto drop;
> +
> +		has_header = hsr_opt->hsr_hdr;
> +		tx_port = hsr_opt->tx_port;
> +		if (tx_port != HSR_PT_SLAVE_A && tx_port != HSR_PT_SLAVE_B)
> +			goto drop;
> +
> +		if (has_header)
> +			hdr_len = ETH_HLEN + HSR_HLEN;
> +		else
> +			hdr_len = ETH_HLEN;

Nit: Maybe hdr_len = ETH_HLEN during declaration, hdr_len += HSR_HLEN reads a
bit simpler.

> +
> +		/* Ensure the real header after the stripped one can be
> +		 * accessed
> +		 */
> +		if (!pskb_may_pull(skb, sizeof(struct hsr_inline_header) +
> +				   hdr_len))
> +			goto drop;
> +
> +		eth_hdr = skb_pull(skb, sizeof(struct hsr_inline_header));
> +		skb_set_network_header(skb, hdr_len);
> +		skb->protocol = eth_hdr->h_proto;
>  	}
> +
> +	skb_reset_mac_header(skb);
> +	skb_reset_mac_len(skb);
> +	spin_lock_bh(&hsr->seqnr_lock);
> +	hsr_forward_skb(skb, master, tx_port, has_header);
> +	spin_unlock_bh(&hsr->seqnr_lock);
>  	rcu_read_unlock();
>  
> +	return NETDEV_TX_OK;
> +drop:
> +	rcu_read_unlock();
> +	dev_core_stats_tx_dropped_inc(dev);
> +	dev_kfree_skb_any(skb);
>  	return NETDEV_TX_OK;
>  }
>  
> @@ -362,7 +404,7 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
>  		return;
>  	}
>  
> -	hsr_forward_skb(skb, port);
> +	hsr_forward_skb(skb, port, HSR_PT_NONE, false);
>  	spin_unlock_bh(&hsr->seqnr_lock);
>  	return;
>  }
> @@ -430,7 +472,7 @@ static void send_prp_supervision_frame(struct hsr_port *master,
>  		return;
>  	}
>  
> -	hsr_forward_skb(skb, master);
> +	hsr_forward_skb(skb, master, HSR_PT_NONE, false);
>  	spin_unlock_bh(&hsr->seqnr_lock);
>  }
>  
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 5862c05f52110..2b8ae9723bd7f 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -771,7 +771,8 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>  }
>  
>  /* Must be called holding rcu read lock (because of the port parameter) */
> -void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
> +void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
> +		     enum hsr_port_type tx_port, bool has_hsr_header)
>  {
>  	struct hsr_frame_info frame;
>  
> diff --git a/net/hsr/hsr_forward.h b/net/hsr/hsr_forward.h
> index 206636750b300..e64b0358907a9 100644
> --- a/net/hsr/hsr_forward.h
> +++ b/net/hsr/hsr_forward.h
> @@ -13,7 +13,8 @@
>  #include <linux/netdevice.h>
>  #include "hsr_main.h"
>  
> -void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port);
> +void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
> +		     enum hsr_port_type tx_port, bool has_hsr_header);
>  struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
>  					struct hsr_port *port);
>  struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index a546f70f9cc8b..5274ba6dd36e6 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -78,10 +78,10 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
>  	 */
>  	if (port->type == HSR_PT_INTERLINK) {
>  		spin_lock_bh(&hsr->seqnr_lock);
> -		hsr_forward_skb(skb, port);
> +		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
>  		spin_unlock_bh(&hsr->seqnr_lock);
>  	} else {
> -		hsr_forward_skb(skb, port);
> +		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
>  	}
>  
>  finish_consume:
> 
> -- 
> 2.55.0
>

/Daniel
