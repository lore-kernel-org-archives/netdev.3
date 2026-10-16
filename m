Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D7B47125C
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143291; cv=none; b=Sf3qMjn1otwq2BerWo0xjkp6s9Qayu81Jce2d+9rWhv2axvXtmEmYat5rGMklHFtQ90a/yjPCEsdpZErBYsmhY0ylUoJi4vgfz6dMiIGBqXhuoR/5RaT6citnPqyG/0r9sRPgmjqQ6g0ClPJIOHAeW/nJreypZHMv0tuS3QO1po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143291; c=relaxed/simple;
	bh=9xnoIElRwOXfuzQOFDfFwgQhjgUrtJGz5OTcCdAQ7JQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTFK/CdA0lhGpqYpiJNH3J8YCyGPTNxaAPwD6bFIitZshohz+uAUMT0G9BiAqW0pd9RLn3Wx0SV+PNvHqbxRgmdMGU+nge+XA3GV8ILbMJ+XlYsbvUGHti3beFIQwpjUpvvraF2/E6f2xnCbEuaXud32lhREzHPcXhs/Xxs1mlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uHmvltxV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uHmvltxV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792143290; x=1823679290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9xnoIElRwOXfuzQOFDfFwgQhjgUrtJGz5OTcCdAQ7JQ=;
  b=uHmvltxVsMzphXiN+OmdKBGY96osLaGYd2DzqS3QI3HvK3R4BwpdN3xL
   ZwR6a1WBElDF1mUkAHcBmP21uF4vFYwVQ5RQ5gBtOTTyUumTEuv3KHVIk
   AlXHbWS6VzHXM7QnqSWsdQlhLPyLtU1XB+phmNhNMy6/yLu3ck5aa7kFJ
   TzUIAHmHNboyAVPWF2RBTl9EfpZD0/VGmrZT+hpbsH4S2GZ4IgPglnFas
   DYMFVHfEYKlRW8SQ2YFCf2aPvn1zPblVM9KK2wEOxjlh0t0fukuQmfccf
   RXatcDYpriT/3qfL0X/21T8/pj0pFhDLNQUPKJdxqluGqablv5iZTEuEW
   Q==;
X-CSE-ConnectionGUID: Jx15wQQXSm2QSo2pN1hmKg==
X-CSE-MsgGUID: 8oHtBNCiSaKMdJlp0MRBqw==
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="64189009"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2026 02:34:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 16 Oct 2026 02:34:48 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 16 Oct 2026 02:34:45 -0700
Date: Fri, 16 Oct 2026 11:34:44 +0200
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
Subject: Re: [PATCH net-next v9 6/8] hsr: Assign a socket for cloned skbs
Message-ID: <20261016093444.dkdhdmuvo4fg2mjt@DEN-DL-M70577.microsemi.net>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
 <20261014-hsr_ptp-v9-6-2d20a2a0f816@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014-hsr_ptp-v9-6-2d20a2a0f816@linutronix.de>

> The cloned skb does not have a socket information recorded of
> the original skb. The original skb is never submitted. This means the
> requested timestamp information gets lost.
> 
> This does not consider PRP part of the stack. The specification says
> that PTP-PRP packets do not have the RCT therefore these packages can be
> sent directly from userland skipping the stack.
> 
> Assign the socket of the original skb to the clone so the timestamp is
> forwarded to the user.

The commit description seems right, but is maybe a little vague. Could go a
little more into detail about the effect: skb_clone() clears skb->sk, and
skb_tstamp_tx() drops the timestamp when there is no socket, so without this
ptp4l never gets its TX timestamp.

nits:

s/a socket information/the socket/
s/these packages/these packets/

> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/hsr/hsr_forward.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 534798da48d53..e3a7affd947a1 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -12,6 +12,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/etherdevice.h>
>  #include <linux/if_vlan.h>
> +#include <net/sock.h>
>  #include "hsr_main.h"
>  #include "hsr_framereg.h"
>  
> @@ -347,6 +348,9 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
>  	if (!skb)
>  		return NULL;
>  
> +	if (frame->req_tx_port != HSR_PT_NONE && frame->skb_std->sk)
> +		skb_set_owner_w(skb, frame->skb_std->sk);
> +
>  	if (port->dev->features & NETIF_F_HW_HSR_TAG_INS)
>  		return skb;
>  
> @@ -579,6 +583,8 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  		 */
>  		if (frame->has_foreign_header && frame->skb_std) {
>  			skb = skb_clone(frame->skb_std, GFP_ATOMIC);
> +			if (skb && frame->skb_std->sk)
> +				skb_set_owner_w(skb, frame->skb_std->sk);
>  			goto inject_into_stack;
>  		}
>  
> 
> -- 
> 2.55.0
>

/Daniel
