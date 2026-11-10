Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316340;
	b=SXK5clmLZmrUHh8U8c9CDPKgTTjRb3CSWHLpTjDWmcg6hj21FqfTcY34PbPnXbmpO3lN
	 RisTz/F0NBTzKZFHpZufaHQvlgdPemY62LMhQVT1NFdIKqWGzSTb1faDMTgbAq/4oQ6IG
	 L8YzHJT4bJ9NoDk7dh2p8oR9+Pgv3xTGC5Kn4B8fNQ9lO+deT4DYYNY4NZnPRPiZzOIj/
	 lr21d+KloygSviqDxhgaca6hd20IpQC3R05W9/qm5DeD9rnYknlteE1cTc6EPZpxuRHjh
	 8iKRbjWEHLKoYBR3ysbNDQu2jtWRD180XP1Hi0XnGO9ha24K5Ru8Yxd7Crc1QaL2V6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316340;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=4crdWvdScJFXStgZEW+ZdWBReFNhvZ69NlU138FE2M0=;
	b=NnJoVg7Y1v1i4P+HZYEUpeTa4XjfzLA9/cAEDjYmejzcgW6ei1Z84Y4XVp8Yrk6hpDRf
	 ckicV2gGvm1o/5aGU6heg1WynWv/6eLkRbT38a/J8EYp1mXdFmKB4a5pHH3sCD1iIjIlw
	 vLeL1WFkdeHdMF+IuO7DnCa14RVrgBbrQP0hiYRUNeJkmpjtQBvsJ2gB/ocob7WPHjDAX
	 oOwQkLzwK/L36v/Y/dTwWl/d9k8O/sqHI36pGoPyv6T/DAPSexDklj/uIcQuJDhwZH3j6
	 2dJwFrLGzt6lFxB+tIQPiQD1nXYy9M1SJMiY05xyTT3tQBefrxTbUjm11/RKDXlsQVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=LS4fQBkn;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEDF606A749
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AEDF606A749
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=LS4fQBkn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794316340; x=1825852340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KEwzUFORjZ1W+gdh/px8sOmDhXcgN3iSEeQ/e3UG5WI=;
  b=LS4fQBknMMKmWLXvooaKix0oG6uNIHycc2sK43/dMBTnScjvtoDjgJso
   wGFmxlod10U/WehzknxRYeIqex0WlW/lPigsL3cahiCT1f90ZQQzNGRum
   BXlOPm8ZfzYHc5udeoz1BGxrroeHt82UpZ2Hd2wWpxFHlrRedKGK8JhgS
   EjkQc7sp4QLHVC1LHscxRHL+2XIE15o1DYdsSAUUDUycq7mDhYCytgUpC
   BG3YgiNpvx1f7JBaeO0CP1jTly8Uve8iNaC0+7FGW8wxqMSfbV8b12Qb9
   Q+9jH9mCCcyJ71CqXX+abwNBbOQG+ex5BhysJlBpjqAOGGhgjn/5+h+4E
   Q==;
X-CSE-ConnectionGUID: y5gZRYsaTAqdC6cahCJ48A==
X-CSE-MsgGUID: qBsZ09ZmQHScz9o3kldaxw==
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="66533379"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:12:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 10 Nov 2026 06:12:17 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 10 Nov 2026 06:12:14 -0700
Date: Tue, 10 Nov 2026 14:12:14 +0100
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
Subject: Re: [PATCH net-next v10 3/8] hsr: Add a magic header for sending PTP
 packets
Message-ID: <20261110131214.5i4b3jt7iigbewsw@DEN-DL-M70577>
References: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
 <20261104-hsr_ptp-v10-3-2c4a38ad973c@linutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261104-hsr_ptp-v10-3-2c4a38ad973c@linutronix.de>

Hi Sebastian,

A few nits for you to consider, in case you need to respin anyway.

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
>  include/uapi/linux/hsr_ptp.h | 20 +++++++++++++
>  net/hsr/hsr_device.c         | 71 ++++++++++++++++++++++++++++++++++++--------
>  net/hsr/hsr_forward.c        |  3 +-
>  net/hsr/hsr_forward.h        |  3 +-
>  net/hsr/hsr_slave.c          |  4 +--
>  7 files changed, 87 insertions(+), 16 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93abbb315065d..bd8f678710153 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12306,6 +12306,7 @@ F:	drivers/net/usb/hso.c
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

Is this needed?

>  
>  struct net_device;
>  
> diff --git a/include/uapi/linux/hsr_ptp.h b/include/uapi/linux/hsr_ptp.h
> new file mode 100644
> index 0000000000000..95e905441ebdc
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
> +	__u8 req_tx_port;
> +	__u8 has_hsr_header;
> +	__be32 __pad0;
> +	__be32 magic;
> +	__be16 __pad1;
> +	__be16 eth_type;
> +} __attribute__ ((packed));
> +
> +#endif
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 59df647d2fd45..1cd871b1e8b37 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -223,24 +223,71 @@ static netdev_features_t hsr_fix_features(struct net_device *dev,
>  
>  static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
> +	enum hsr_port_type req_tx_port = HSR_PT_NONE;
>  	struct hsr_priv *hsr = netdev_priv(dev);
>  	struct hsr_port *master;
> +	bool has_hsr_header = false;

RXT.

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
> +		struct hsr_inline_header *hsr_opt;

Is 'hsr_opt' a leftover name from a previous version? I would have expected it
to be something like hsr_inline_hdr.

> +		struct ethhdr *eth_hdr;
> +		unsigned int hdr_len;
> +
> +		BUILD_BUG_ON(sizeof(struct hsr_inline_header) != sizeof(struct ethhdr));
> +
> +		/* need to access the magic header */
> +		if (!pskb_may_pull(skb, sizeof(struct hsr_inline_header)))
> +			goto drop;
> +
> +		if (!skb_mac_header_was_set(skb))
> +			skb_reset_mac_header(skb);
> +
> +		hsr_opt = (struct hsr_inline_header *)skb_mac_header(skb);
> +		if (hsr_opt->magic != htonl(HSR_INLINE_HDR))
> +			goto drop;
> +
> +		has_hsr_header = hsr_opt->has_hsr_header;
> +		req_tx_port = hsr_opt->req_tx_port;
> +		if (req_tx_port != HSR_PT_SLAVE_A && req_tx_port != HSR_PT_SLAVE_B)
> +			goto drop;
> +
> +		if (hsr_opt->__pad0 != 0 || hsr_opt->__pad1 != 0)
> +			goto drop;
> +
> +		hdr_len = ETH_HLEN;
> +		if (has_hsr_header)
> +			hdr_len += HSR_HLEN;
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

I think that is a big ptp-hsr specific block in a hot xmit function. Personally,
I would probably have put that into a helper hsr_ptp_parse_header() or
something. Not a big deal though.

> +
> +	skb_reset_mac_header(skb);
> +	skb_reset_mac_len(skb);
> +	spin_lock_bh(&hsr->seqnr_lock);
> +	hsr_forward_skb(skb, master, req_tx_port, has_hsr_header);
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
> @@ -362,7 +409,7 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
>  		return;
>  	}
>  
> -	hsr_forward_skb(skb, port);
> +	hsr_forward_skb(skb, port, HSR_PT_NONE, false);
>  	spin_unlock_bh(&hsr->seqnr_lock);
>  	return;
>  }
> @@ -430,7 +477,7 @@ static void send_prp_supervision_frame(struct hsr_port *master,
>  		return;
>  	}
>  
> -	hsr_forward_skb(skb, master);
> +	hsr_forward_skb(skb, master, HSR_PT_NONE, false);
>  	spin_unlock_bh(&hsr->seqnr_lock);
>  }
>  
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index b183358207506..f49d962337f8b 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -771,7 +771,8 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>  }
>  
>  /* Must be called holding rcu read lock (because of the port parameter) */
> -void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
> +void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
> +		     enum hsr_port_type req_tx_port, bool has_hsr_header)
>  {
>  	struct hsr_frame_info frame;
>  
> diff --git a/net/hsr/hsr_forward.h b/net/hsr/hsr_forward.h
> index 206636750b300..662dd369c7df2 100644
> --- a/net/hsr/hsr_forward.h
> +++ b/net/hsr/hsr_forward.h
> @@ -13,7 +13,8 @@
>  #include <linux/netdevice.h>
>  #include "hsr_main.h"
>  
> -void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port);
> +void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
> +		     enum hsr_port_type req_tx_port, bool has_hsr_header);
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
