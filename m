Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646369;
	b=FzmK6RB/tV65xs695lQBZyhaFG9i9qJ2yyv4z9BxP2PRKh8NVK3dp7v7399EmVTseWC0
	 SiCU7+Wt6Rk5gDzXZVV5bMVHYcMLV5EXMhzLreoBxWNLvr49w2bWTXbw4b90NcXRIbMDR
	 7ZGsyi0Tjneqk0iRBxYBuJplJ328fkGgurBPw2B/a+xu2/gZNKsfmG0nxDMdzZ67LMlAk
	 bb1KTH3b/lE6/chfBiUr9UEztY86hAk+7l67WnCMWj4+Izkl0BZZVkHJE5EjnQhWsYyTB
	 JKgOIm9+lf4P9j2btHu0Y4+1Yk1wH2UwPYJKtR/Kt/bnaczdCOcAu8NmbzxyIlAbedQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646369;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ClJ0+mcbYLWCO6jCQUFPvJuHbyK+fvSWo7IOSpnbA+o=;
	b=NBlwnkf2RGN5vF1w9JIVARJb4WMbLYYknrsHLRG4w4Z3w2yET5jHA4WzxkcyVEAledv7
	 28EM+Zj4lJU4F/7l8DeHPU23gjVsDOfz3blIH1I5H4lbv+T/yGIV0INtHG2h27PuhalyU
	 InghcVkwIV9IpkT8zdKaqQO8lqShO2Thi6iqiaQdzRxCXBJWe2aQ6QZA+Tu92oIFmGcnS
	 waYFcPRckImmJ8WQAzD2yGEcRyopyrzrmnq6Z1bi/fY/+vtxCtXW0Lls0X4NXBcWFrrUg
	 AY8ysdKZxIy/ki/+52bI65ZRpUAPNUL9aL8yJ/hwXfWsffCH1BbbQOMHcux4hA4mVlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VgYMGP8E;
	arc=none smtp.remote-ip=95.215.58.94
Received: from mta1.migadu.com (out-94.mta1.migadu.com [95.215.58.94])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09704606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09704606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VgYMGP8E
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RHVFBTbh8FahNaw5EWUek8qDsF+0xAqaAJBJ+B7LQbA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792646366; v=1; x=1793251166;
 b=VgYMGP8Eru0vGOlKUhCo/dh0h5L7Q56p9YixEMyBhb90zgBQ4YddKpjUGjoGo7sazo9OvfM7
 pvPOo9azFeQHu/KU+TSJcEO1bhlkt8fqtDon8rdneC3/mQJfIqB9GcLigT9kyDzPZ0Hugf5AjOB
 Z38rQrpI6aJM0LiHU7XtlRkQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 5914cadf4b4e6497;
	Thu, 22 Oct 2026 05:19:25 +0000
X-Mizu-Trace-ID: 5914cadf4b4e6497
X-Migadu-Flow: FLOW_OUT
Date: Thu, 22 Oct 2026 13:19:09 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Boyan Liu <yymhvert@gmail.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	co+98d7de09cd94fec5@bugs.sh
Subject: Re: [PATCH net v3] seg6: Fix unset mac header in SRv6 End.DT VRF
 decapsulation
Message-ID: <atmczawXBSexpfPw@fedora>
References: <20261021024738.17266-1-yymhvert@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021024738.17266-1-yymhvert@gmail.com>

On Wed, Oct 21, 2026 at 10:47:38AM +0800, Boyan Liu wrote:
> SRv6 End.DT4/End.DT6 VRF decapsulation unsets the mac header in
> end_dt_vrf_rcv() so that the VRF device can rebuild it for packet
> sniffers. The VRF rx handler only performs the rebuild when a
> sniffer is actually attached to the VRF device (ptype_all
> non-empty); otherwise the packet continues up the stack with
> mac_header == 0xffff.
> 
> Every other receive path delivers packets with a valid mac header:
> NIC drivers set it in eth_type_trans(), and tunnels without an L2
> header (ipip, sit, gre, tun) reset it to the network header after
> decapsulation. skb_mac_header() even warns on the unset state with
> DEBUG_NET_WARN_ON_ONCE().
> 
> If the decapsulated packet is an unexpected UDP GSO packet,
> udp_queue_rcv_skb() re-segments it after restoring skb->data to the
> mac header with __skb_push(skb, -skb_mac_offset(skb)). With the mac
> header unset, skb_mac_offset() returns a large positive value,
> which the unsigned __skb_push() argument turns into a huge length:
> skb->data moves far outside the buffer and skb->len is corrupted,
> so segmentation reads out of bounds:
> 
>     BUG: KASAN: slab-out-of-bounds in inet_gso_segment (net/ipv4/af_inet.c:1383)
>     Read of size 1 at addr ffff88800da7ffff by task exploit/149
>     Call Trace:
>      inet_gso_segment (net/ipv4/af_inet.c:1383)
>      skb_mac_gso_segment (net/core/gso.c:53)
>      __skb_gso_segment (net/core/gso.c:124)
>      udp_queue_rcv_skb (net/ipv4/udp.c:2476 net/ipv4/udp.c:2466)
>      udp_unicast_rcv_skb (net/ipv4/udp.c:2620)
>      ip_local_deliver (net/ipv4/ip_input.c:262)
>      seg6_local_input_core (net/ipv6/seg6_local.c:1640)
>      lwtunnel_input (net/core/lwtunnel.c:465)
>      ipv6_rcv (net/ipv6/ip6_input.c:351)
> 
> Restore a valid mac header once the VRF rx handler returns: point
> it at the network header, and reset mac_len, which still holds the
> ingress frame's L2 header length. The sniffer rebuild happens
> inside the handler while the header is still unset, so tap behavior
> is unchanged; when no rebuild happened, the packet now carries the
> same mac header state as any packet received on an L3 device.
> 
> Fixes: 664d6f86868b ("seg6: add support for the SRv6 End.DT4 behavior")
> Cc: stable@vger.kernel.org
> Reported-by: co+98d7de09cd94fec5@bugs.sh
> Signed-off-by: Boyan Liu <yymhvert@gmail.com>
> ---
> v3:
> - Also reset skb->mac_len with skb_reset_mac_len(), as suggested by
>   Andrea Mayer: it still held the ingress frame's L2 header length.
> v2: https://lore.kernel.org/netdev/20261017120144.3059-1-yymhvert@gmail.com/
> - Move the fix from the UDP GSO path to seg6local.
> - Restore the mac header after the VRF rx handler returns, preserving
>   the VRF sniffer behavior.
> - Verify the original reproducer, datagram delivery, and VRF sniffer
>   output under QEMU.
> v1: https://lore.kernel.org/netdev/20261010073015.7665-1-yymhvert@gmail.com/
> 
>  net/ipv6/seg6_local.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 7b5212220185..4ef9d32907e5 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -1113,6 +1113,16 @@ static struct sk_buff *end_dt_vrf_rcv(struct sk_buff *skb, u16 family,
>  		/* the skb buffer was consumed by the handler */
>  		return NULL;
>  
> +	/* the VRF device had its chance to rebuild the mac header for
> +	 * sniffers; restore a valid one pointing at the network header,
> +	 * like any L3 device without an L2 header, before the packet
> +	 * continues up the stack.
> +	 */
> +	if (!skb_mac_header_was_set(skb)) {
> +		skb_reset_mac_header(skb);
> +		skb_reset_mac_len(skb);
> +	}
> +
>  	/* when a packet is received by a VRF or by one of its slaves, the
>  	 * master device reference is set into the skb.
>  	 */
> -- 
> 2.43.0
> 

Thanks for the fix.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
