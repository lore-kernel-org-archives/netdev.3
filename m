Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32911224AF2
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143539; cv=none; b=rTvS/HCpugz9IUagB7xElqqyqUIb4e8GJ6rwBJKMxkZUaWY7EHdXWKU/urrlPxRdnuc5MzeN7fnxgrATS85N71b9Cow3vjwpQRJslKNO/HNXzit8c7QqpFNdNXDB2ncOYPRVbsDlxUijdjCiJD30YaGZwqR07qJLFJDMnjaBZ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143539; c=relaxed/simple;
	bh=vJyIlrxx5ELtTZLqd6rMsHJhGCOH6yiMjBpEC/ADV9E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LagEXzNRQ9XxpxS7KxsjUKKMuo4wgw4v2fO+cuSSn2DUL/92MEQa64tdRRnEMrk4gcirmYbkMgT2BRDCtFPy/VC5yUd2XDYLcSv5Fqv8C7JGWcfjVBeI5/N9yGu0+OOFYirscy16bJZRBVszzITNlf1rvlexvCtKVE7zQx+2zOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pX4pR6xM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pX4pR6xM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792143538; x=1823679538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vJyIlrxx5ELtTZLqd6rMsHJhGCOH6yiMjBpEC/ADV9E=;
  b=pX4pR6xMw54dxjl6Lf8HsBmUwvtrk++HMU8xSWSJSNjXkskedNz13PC4
   OLrLIrxQvoDnG0J8L/6aOjhcMofXLMnS2+aslFbx/VvQyapWvlvd12Joh
   VFfKzcPkaVB7GPrM12S4EmqHuiZPmrXkunCcsTS7tgbxNsvg0oNGlOy4D
   gfCTuHFDXS5gnK8Qjly4e1LxHeEUQaZ0lmzyVpIFujY19m8GD0OLgymNO
   ESlBazb2IbiFLk32RVtyyD85AgNMkpGNZDo2TOE0WzrkrLLDM2UbgGoWe
   a30SekJyahqP3C2IAcNVSZyzWRTSq9Jl/36ct9HYP57cVnBZY0HYuCAz2
   w==;
X-CSE-ConnectionGUID: hh1JkdjUTAWISyyMWepM1g==
X-CSE-MsgGUID: fxvzoeL8TZmzXPPusvp6tg==
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="65406703"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2026 02:38:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 16 Oct 2026 02:38:56 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 16 Oct 2026 02:38:53 -0700
Date: Fri, 16 Oct 2026 11:38:53 +0200
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
Subject: Re: [PATCH net-next v9 7/8] hsr: Move struct hsr_ethhdr to a global
 header
Message-ID: <20261016093853.jugkxkcvzxsm2kgx@DEN-DL-M70577.microsemi.net>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
 <20261014-hsr_ptp-v9-7-2d20a2a0f816@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014-hsr_ptp-v9-7-2d20a2a0f816@linutronix.de>

> In the offloading case the network driver needs to inspect the HSR
> header to find out if the encapsulated type is a PTP packet where it
> needs suppress offloading of the packet.
> 
> Move the header so it can be included the driver.

nits:

s/needs suppress/needs to suppress/
s/included the driver/included by the driver/

This is the header that drivers needs to poke into, to find out if they should
steer the frame and add a header or not, right? Would it make sense to add a few
helpers here?

> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/if_hsr.h | 6 ++++++
>  net/hsr/hsr_main.h     | 5 -----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
> index 7b6b60ef592db..f81323f10eecc 100644
> --- a/include/linux/if_hsr.h
> +++ b/include/linux/if_hsr.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_IF_HSR_H_
>  
>  #include <linux/types.h>
> +#include <linux/if_ether.h>
>  #include <uapi/linux/hsr_ptp.h>
>  
>  struct net_device;
> @@ -39,6 +40,11 @@ struct hsr_tag {
>  
>  #define HSR_HLEN	6
>  
> +struct hsr_ethhdr {
> +	struct ethhdr	ethhdr;
> +	struct hsr_tag	hsr_tag;
> +} __packed;
> +
>  #if IS_ENABLED(CONFIG_HSR)
>  extern bool is_hsr_master(struct net_device *dev);
>  extern int hsr_get_version(struct net_device *dev, enum hsr_version *ver);
> diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
> index 53e95bae0ee27..36eb82774000c 100644
> --- a/net/hsr/hsr_main.h
> +++ b/net/hsr/hsr_main.h
> @@ -72,11 +72,6 @@ static inline void set_hsr_tag_LSDU_size(struct hsr_tag *ht, u16 LSDU_size)
>  				       0xF000) | (LSDU_size & 0x0FFF));
>  }
>  
> -struct hsr_ethhdr {
> -	struct ethhdr	ethhdr;
> -	struct hsr_tag	hsr_tag;
> -} __packed;
> -
>  struct hsr_vlan_ethhdr {
>  	struct vlan_ethhdr vlanhdr;
>  	struct hsr_tag	hsr_tag;
> 
> -- 
> 2.55.0
> 

/Daniel
