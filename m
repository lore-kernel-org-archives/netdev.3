Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792799954;
	b=PoZ/5bwq04gWs/7F/u0XGGiV2O8tjTdicVQCSuMHa8d6c7ZyXZ6rHNaoFq6qn8nUKs5B
	 Qc05WZC75Um3yH9Qw4jimbAoQRrvdUVNWf4Y3w1ahvvoq2u7PWEXCgQzD3xUL3lUPO/co
	 AkNT4Kp0ueEby6ULBJggzdzaKN2jxXo3iOt0Isft852oQ3SI8gr8TChQAVBs+PNXO7ium
	 RfQ/bObNO9ZJsZDJ55KJ6t1Zy27IPSTxq5SwkXoZ840nkhspCVrWdHr8UZE5o8XlQjNX/
	 TOW28CVTw9xr0+zJ0i54rXBNgcR4MsSOUN8ybXwGrQW5/uLeUWZBTeL+4MME8e5mIAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792799954;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:Date:
	 From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=5CsImtCByLi3iDUbTqFyDL/DCVY5SvkC3RRk1o8Kcfs=;
	b=ZqtT2W61KFfSGvCYxnoWuaP/hc0RpcIBrSmUaF69QFABJwY3wTemgURHxQAZqGpHckOW
	 UeHxdBSPxfvyiqC9RIfX4IPiGVZb58PopLht52+AviEG0vkEeSpGy0uxVR9hN6KoxFlPE
	 XN67LeykyGjwU4mGJTSxi58HHpB4v7oLH8I7bGy/A/P76MbDySSW2uolc66bxE4IsEB9d
	 6C5XRcm46V/Y5ER5sQumfnW4WooZ3ISLHz2E8QUvQk1IkptrpLRo8RBAZyesA81uvzDoW
	 7To2PXCx2n657gkWXB7I3O1M66VgiUyez9DAh5ZWdHwIKLW3b/cDUL08C0H5VCTkXog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=orh9x4BO;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b="uH/n7kbS";
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939FB606A336;
	Fri, 23 Oct 2026 23:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 939FB606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=orh9x4BO;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=uH/n7kbS
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69NNwGv1014702;
	Sat, 24 Oct 2026 01:58:21 +0200
Received: from lubuntu-18.04 (host-79-32-222-240.retail.telecomitalia.it [79.32.222.240])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id DE9EF1227F6;
	Sat, 24 Oct 2026 01:58:11 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1792799892; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CsImtCByLi3iDUbTqFyDL/DCVY5SvkC3RRk1o8Kcfs=;
	b=orh9x4BOWnIziDMunFyXsI/W27dEvXrXZxhAopMPMLV8qFU8rUyYFF5Jt/w++r9Rssl+tN
	Ofrcnh+jHNKDw/Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1792799892; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CsImtCByLi3iDUbTqFyDL/DCVY5SvkC3RRk1o8Kcfs=;
	b=uH/n7kbSra4BPDOwBD5lqMHXjT8cWw3aW7qwJ5DoZwkrLWWm3Qk8mdBcObqsC5NrFhxvsq
	au1Y+x+XvnrykzNAvoYL3wKL0WEQKX+yKpH7pScWGQLATJiaEmI4C2dRSVjg58z5PTcKhC
	W48dhdkGiqTj02w1BiH39Al3E6N4jvWAJCqdv6ag4+9pEvo6SDWYOouzO0SWE2Ag9WZ3hE
	41szSVAffms79eCYvwL57KmyXvWtCnZPToehXs3yO8R8gAC3jg//rRQMNIE+ehLbXnZ3ao
	3afbwqeMP5C/r2VJH9QCpsNy5qiA7upSFk6LjRz3hTuSfO7RHQUDNNzUJFp4jw==
Date: Sat, 24 Oct 2026 01:58:11 +0200
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
        co+98d7de09cd94fec5@bugs.sh, hangbin.liu@linux.dev,
        stefano.salsano@uniroma2.it, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v3] seg6: Fix unset mac header in SRv6 End.DT VRF
 decapsulation
Message-Id: <20261024015811.a995b7cab417cac2f41689de@uniroma2.it>
In-Reply-To: <20261021024738.17266-1-yymhvert@gmail.com>
References: <20261021024738.17266-1-yymhvert@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Wed, 21 Oct 2026 10:47:38 +0800
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

Thanks Boyan. I'm looking at this patch, also because of the NFQUEUE
case the Sashiko review raised on v3. I will follow up.

Ciao,
Andrea
