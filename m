Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0733A4E3EFB;
	Mon, 19 Oct 2026 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414744; cv=none; b=SYMquuqXd9MMEFlk9nJdKk4woY0x2It8LoHlaoq4RdKDfqbnd+SyhT/G7DKYstY0EJKjzA/Mom9KYCaxAcnNXEMPGzTCc+PNyTdtgo2txG2IJJRPyA6X2fPwUchXF19mF8Y7XbzpSPQflJB7SujBH4mzrejRdf1PNeezfLVCuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414744; c=relaxed/simple;
	bh=1NiuXvMK1x1kT9RDVHcfDBR+3Bi791ZbVdM+nUoxkYk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A8YF5DGsKSOY3dmdhUOPzCDsADrHm9Ra5uWdRAA8BR6EufVE0yCPdPy7XUPJu6ajxl+jLkLiSAdjq1k91yv9h8HIRI/ZFYu7BQ6M+pihtvaKtwyOJNGof5xqKwif1C6Bt05qUs9+mtyS7TDc85i2sP2vZY35b8ofi+vFJ9E1G5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=VHneX6jr; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=sreV4qm6; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="VHneX6jr";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="sreV4qm6"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69JCiEce031291;
	Mon, 19 Oct 2026 14:44:20 +0200
Received: from lubuntu-18.04 (host-79-32-222-240.retail.telecomitalia.it [79.32.222.240])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 451C2122951;
	Mon, 19 Oct 2026 14:44:10 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1792413850; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcO8tMb5SE5HTlX/hYlR3RK/n3xdFi018XnPAAEWrbQ=;
	b=VHneX6jrHlHqM5uqYbYiMSVqMSpz/wIK7zz9qdkh7/J/vXuGchYGssnseA3+SL7mhMMj0A
	lNoyqh2M+11+rzDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1792413850; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcO8tMb5SE5HTlX/hYlR3RK/n3xdFi018XnPAAEWrbQ=;
	b=sreV4qm6bfn6pubyB5tvVMTiYutM6Pi8iWwFRfvYxd3sO80q+GxgoXFi/rANW/QHW9F052
	HIZEKytDcwfRuhYaZa50gxSmv45+Gmen3vxvdRsKsuESQhPerD1Q7yjyi/Ox7L4bIH0Qfw
	sU/0iSA/e92H31Hh5GMcnCRVqkZjjdDwNz5FhyEq8FmNg+itrUSuoe3EiN4noQ6ShzYewz
	Sfzr6O1o89/LLG4QC325GooEvW4chil+bQ0NPQ8w1U9nQi0l1oXkOil5ihfLmHXUGRufzr
	zDBeesZ0dHD+J+7rI07F36LKmGk6gzrfcLOVhzfUV7VHmHxxLHXKNgvfWo/Xjg==
Date: Mon, 19 Oct 2026 14:44:09 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Boyan Liu <yymhvert@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+98d7de09cd94fec5@bugs.sh, stefano.salsano@uniroma2.it,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v2] seg6: Fix unset mac header in SRv6 End.DT VRF
 decapsulation
Message-Id: <20261019144409.aeedfcbaf76b341945d6e370@uniroma2.it>
In-Reply-To: <20261017120144.3059-1-yymhvert@gmail.com>
References: <20261017120144.3059-1-yymhvert@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Sat, 17 Oct 2026 20:01:44 +0800
Boyan Liu <yymhvert@gmail.com> wrote:

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
> Restore a valid mac header, pointing at the network header, once
> the VRF rx handler returns. The sniffer rebuild happens inside the
> handler while the header is still unset, so tap behavior is
> unchanged; when no rebuild happened, the packet now carries the
> same mac header state as any packet received on an L3 device.

Thanks Boyan. On the SRv6 side the approach looks reasonable to me.
With my own reproducer I see a KASAN slab-out-of-bounds in
inet_gso_segment() without the fix. With the fix I could not reproduce it
anymore, and the datagrams are delivered. A sniffer on the VRF sees the
same L2 header with and without the fix.

> [snip]
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 7b5212220185..5232c9e2b7d7 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -1113,6 +1113,14 @@ static struct sk_buff *end_dt_vrf_rcv(struct sk_buff *skb, u16 family,
>  		/* the skb buffer was consumed by the handler */
>  		return NULL;
>  
> +	/* the VRF device had its chance to rebuild the mac header for
> +	 * sniffers; restore a valid one pointing at the network header,
> +	 * like any L3 device without an L2 header, before the packet
> +	 * continues up the stack.
> +	 */
> +	if (!skb_mac_header_was_set(skb))
> +		skb_reset_mac_header(skb);
> +
>  	/* when a packet is received by a VRF or by one of its slaves, the
>  	 * master device reference is set into the skb.
>  	 */

The patch sets the mac header but not skb->mac_len, which stays at the
value the ingress left (e.g. 14). IMO the patch should also reset
skb->mac_len with skb_reset_mac_len(), which gives 0 with the mac header at
the network header. Sashiko raised the same point.

Sashiko also asks about L2ENCAP. With the fix, the decapsulated packets now
pass the skb_mac_header_was_set() check in seg6_do_srh() when the VRF has
no sniffer. In my tests L2ENCAP then builds a malformed frame.
skb_mac_header_was_set() only means the mac header is set, not that a real
L2 header is present, and the L2 ends up rebuilt from the IP header bytes.
Resetting mac_len does not make the frame valid either, since the IP header
itself then sits where the L2 header should be. skb_mac_header_was_set()
already lets End.DX4 packets into L2ENCAP without the fix, and the
resulting frame is malformed as well. I will look at the L2ENCAP check
separately.

Ciao,
Andrea
