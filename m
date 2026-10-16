Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5986545D5F6
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141790; cv=none; b=Oh6l3yyn81t03vXhCwZqm1PIy05vXrdOHbDfSrLyLM6S5b1xV6AvGR9Ul/yyClfNU+f+FN8DJVyLTGnGYFoYiuB0/HSC/0UJuIvPqEZJKjX9k1lIodohu0Z4OGfq11BoLA3gFlR0+OQ2u2Ywkx0JzoAjlTUPSxIQjz1OBTbVjFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141790; c=relaxed/simple;
	bh=4LaZ0214tKw5r60HpnJdgVE8Ofbq0hoJXCXixcM3GdU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnx0H48KHaifiW6NWmGeK0NS7dRylsqg+1vx+rdG1mQwsQfnFw36uugi9EOrWSe52bjDrUh8nSfW8DN8O6CmQ1hfSGIg0YBjicXhHJ9p1Tn6I0JwXahabowBNguGmmcP9Cl5y+ZpcefMvDSg70bJo7OiLDBWHri871viqWONAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lBT63E16; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lBT63E16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792141792; x=1823677792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4LaZ0214tKw5r60HpnJdgVE8Ofbq0hoJXCXixcM3GdU=;
  b=lBT63E16CQuFqOtlXU3KBc3czQ5MQv06Cd3wT7FKZYCqqc4D4K0/95tW
   VrFIp5DoqG2JW6PWVmPWugHhsTh8uCv6IbfqOq5KUbpi0OZT4NahHZCqG
   Q/Ty2pI1KNppkH7y8KtUdkGR9e4Eq6jbB5Zbp0C5yl4AKccDCMvHxAgdK
   Ahs3GrRiffMoKtHpVsXnIN3asaz6QLLhsc1uV0QFTRVPOd/EzaCQNtrVA
   yiKlHVF8zivSoFSAXIrAJgZT7KyO/gOn+CvZ1ShC/yHmO8bQTAp//yauL
   NTq2yCGBg4wG5BZbV7xq09C2rBhR6lt/NptMer4peTMtS8g6WV9tlMrXU
   g==;
X-CSE-ConnectionGUID: Rm+mEW+1Qxig7DnRZxaajg==
X-CSE-MsgGUID: hFG6W5TIRrG24l8UO/+5EA==
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="75538339"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 02:09:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Fri, 16 Oct 2026 02:09:44 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 16 Oct 2026 02:09:41 -0700
Date: Fri, 16 Oct 2026 11:09:40 +0200
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
Subject: Re: [PATCH net-next v9 2/8] hsr: Use skb_clone() while adding the
 HSR header
Message-ID: <20261016090940.a2ztkv6p3wtysk57@DEN-DL-M70577.microsemi.net>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
 <20261014-hsr_ptp-v9-2-2d20a2a0f816@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014-hsr_ptp-v9-2-2d20a2a0f816@linutronix.de>

> hsr_create_tagged_frame() creates a new skb where the HSR header can be
> prepended via __pskb_copy(). This does not copy the skb_shared_info part
> of the original skb so any timestamp request is lost.
> 
> An alternative is to use skb_clone() where the skb_shared_info part is
> shared and then skb_cow_head() to make the header part writeable. This
> avoids touching manually the tx_flags and tskey members.
> Using skb_clone() allows also return early (after the clone) in the
> offloaded case so this can be unified a bit. The clone also preserves
> metadata so skb_postpush_data_move() is used instead of memmove().
> 
> This is a prepartion for PTP handling where timestatmps are requested.

s/prepartion/preparation/
s/timestatmps/timestamps/

> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/hsr/hsr_forward.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 7734a521a96c2..5862c05f52110 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -331,7 +331,6 @@ static struct sk_buff *hsr_fill_tag(struct sk_buff *skb,
>  struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
>  					struct hsr_port *port)
>  {
> -	unsigned char *dst, *src;
>  	struct sk_buff *skb;
>  	int movelen;
>  
> @@ -342,33 +341,40 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
>  		/* set the lane id properly */
>  		hsr_set_path_id(frame, hsr_ethhdr, port);
>  		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
> -	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
> -		return skb_clone(frame->skb_std, GFP_ATOMIC);
>  	}
>  
> -	/* Create the new skb with enough headroom to fit the HSR tag */
> -	skb = __pskb_copy(frame->skb_std,
> -			  skb_headroom(frame->skb_std) + HSR_HLEN, GFP_ATOMIC);
> +	skb = skb_clone(frame->skb_std, GFP_ATOMIC);
>  	if (!skb)
>  		return NULL;
> -	skb_reset_mac_header(skb);
>  
> -	if (skb->ip_summed == CHECKSUM_PARTIAL)
> -		skb->csum_start += HSR_HLEN;
> +	if (port->dev->features & NETIF_F_HW_HSR_TAG_INS)
> +		return skb;
> +
> +	/* Ensure the cloned skb has enough headroom to fit the HSR tag */
> +	if (skb_cow_head(skb, HSR_HLEN))
> +		goto err;
>  
>  	movelen = ETH_HLEN;
>  	if (frame->is_vlan)
>  		movelen += VLAN_HLEN;
>  
> -	src = skb_mac_header(skb);
> -	dst = skb_push(skb, HSR_HLEN);
> -	memmove(dst, src, movelen);
> +	/* The entire header area needs to be linear */
> +	if (!pskb_may_pull(skb, movelen))
> +		goto err;
> +
> +	skb_push(skb, HSR_HLEN);
> +	skb_postpush_data_move(skb, HSR_HLEN, movelen);
> +	skb_set_network_header(skb, HSR_HLEN + movelen);
>  	skb_reset_mac_header(skb);
> +	skb_reset_mac_len(skb);

It took me some time to realize why skb_reset_mac_header() and the
csum_start adjustment were removed, and why skb_cow_head(),
skb_set_network_header() and skb_reset_mac_len() were added. Could the
commit message say why? Or maybe a comment.

>  
>  	/* skb_put_padto free skb on error and hsr_fill_tag returns NULL in
>  	 * that case
>  	 */
>  	return hsr_fill_tag(skb, frame, port, port->hsr->prot_version);
> +err:
> +	kfree_skb(skb);
> +	return NULL;
>  }
>  
>  struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
> 
> -- 
> 2.55.0
>

/Daniel
