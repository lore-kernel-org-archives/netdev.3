Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971312;
	b=p7vdnIr2/+MhLFiGt3moCjFwZfK+hIQp4/xnZYsCd9BG9T/EhWmj9xbAGFbfFp3eSUjS
	 568hPyQhcfXfJ1+6jqHmZi1RDivkr1ht43/BcL6QUlKytIG2bNbK4Xl4cvkuMaNCEMxul
	 CXREa2yIqF1LhgEM//9LIuBlF8Cymni9D8vfxnWfw5nlByfLYPKjeIRRTk1X08AApPdg5
	 ROOw5mTB2q7uPa/lrPKvrbybbIAqdkCDbJIwBQddArCRj+CRWFBkyTkP20q1zGD8T4m+/
	 zNgAPOy60DvEytKNVuIfoaxbBEOXDbehm1xCV1rCz+jkPFGuopYGWNicggJEtobaoEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971312;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:Date:
	 From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=HS2Eyl9PVeBpwNJkRpIh4i48ioiL/wO+WYjW6saovWQ=;
	b=ngKw3tE7HztwKqGTP4OaZGH0MfX7DWt14TaThF+SmZDrqRYAbAuQkEazGTSR+iqQchUx
	 oU7h0QadCYeqd3U3068D9fGMZwkftEFRrW3FTjVVTS+Ozp+YXUGP98ZQMRjZl3hP3xsbm
	 LmSqLyaX1htmscvL3T/afrIdarhnw7HMGPHS4qOC2XNTeoE1dpllKqtYDZjdtdRR2DrEO
	 WJ6MbeSVGN0ePxmspQyTPPZEgJDRJIpNbhfi9Szrw1MAa1tDdQf2de4+ak7WIZwA6Ueg1
	 EUch1dgWsvos2DiUw1bWfPKvX2NmdDsvlPrKw118O3s3DRB/+XBgqOLeFCLfVxtIK4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=W80BFNID;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=enJwGoEf;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940E1606A31B;
	Sun, 25 Oct 2026 23:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 940E1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=W80BFNID;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=enJwGoEf
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69PNYLhG025990;
	Mon, 26 Oct 2026 00:34:26 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id E160F120428;
	Mon, 26 Oct 2026 00:34:16 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1792971257; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HS2Eyl9PVeBpwNJkRpIh4i48ioiL/wO+WYjW6saovWQ=;
	b=W80BFNIDNu5PKDJoDWftpKbfMuzOiykKHygPtmdVmJb0E1+wXPQygFftQ/S3oki6LtuVeT
	AJ9+1pO6SY7MmbDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1792971257; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HS2Eyl9PVeBpwNJkRpIh4i48ioiL/wO+WYjW6saovWQ=;
	b=enJwGoEfDnLa78zsaGjyw4xgwORUA9sUOhyqjbWjWYDamYpPWRa4TbNd/b24BY7yD3XrmJ
	Jif/AU31R7VIq1mu76eAbd93gfQoeNptCz779AecO+X0FPBIyqL4kuZ2+gBTF96b632WlU
	MiIqLTegaiysjJOQ9oOhXRht1JpTtUJxeEUggCLU8qR9YNx8MpTgKtatBZMhh+aowjGGf9
	5COblEY2XN+z3G9fSksM2mBAox6Q4Hr3uGNuts8syGEwjbg6VHVm9wXca8vMdaKM9OBCCn
	1aodFdqJuvcEJ08eyzb7KhGkuyiCjlpxGPTp1OdrDlZsgHNIH69rnoPedIHU0w==
Date: Mon, 26 Oct 2026 00:34:15 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Boyan Liu <yymhvert@gmail.com>, David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,
        hangbin.liu@linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, co+98d7de09cd94fec5@bugs.sh,
        stefano.salsano@uniroma2.it, andrea@common-net.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v3] seg6: Fix unset mac header in SRv6 End.DT VRF
 decapsulation
Message-Id: <20261026003415.f7c46fa5a495144c29c03a07@uniroma2.it>
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
> [snip]

Thanks Boyan. I ran my tests on v3 with End.DT4, End.DT6 and End.DT46 in
VRF mode, and I could not reproduce the UDP GSO KASAN report anymore.
Setting the mac header at the network header with mac_len 0 looks fine.

The NFQUEUE case in the Sashiko review also exists without this patch,
because the PRE_ROUTING hook run by the VRF rx handler sees the mac header
unset when no sniffer is attached to the VRF. In my tests the case needs a
combination of the conditions listed in the review, among them the bridge
netfilter extension of the outer frame, which the decapsulated packet still
carries.

end_dt_vrf_rcv() unsets the mac header to let the VRF rebuild it for a
sniffer. Unlike ipip, End.DT has no tunnel device of its own. It is a
seg6local lwtunnel behavior, and orig_dev is skb->dev of the outer packet,
for example an Ethernet device. With a sniffer attached to the VRF,
vrf_add_mac_header_if_unset() rebuilds the header only when the mac header
is unset or orig_dev has no header_ops->create:

  packet          create    mac header    rebuilt  tcpdump on the VRF
  Ethernet        yes       set, len 14   no       Ethernet header
  ipip            no        set, len 0    yes      header with VRF MAC
  End.DT today    yes       unset         yes      header with VRF MAC
  ---------------------------------------------------------------------
  End.DT no unset yes       set, len 0    no       IP header as Ethernet

If end_dt_vrf_rcv() set the mac header before calling l3mdev_l3_rcv(), the
capture would change, as in the last row. It would stay as today if
vrf_add_mac_header_if_unset() also rebuilt the header when mac_len is 0,
that is when there is no L2 header to show, something like (just an
example):

 static int vrf_add_mac_header_if_unset(struct sk_buff *skb,
 				       struct net_device *vrf_dev,
 				       u16 proto, struct net_device *orig_dev)
 {
-	if (skb_mac_header_was_set(skb) && dev_has_header(orig_dev))
+	if (skb_mac_header_was_set(skb) && skb->mac_len &&
+	    dev_has_header(orig_dev))
 		return 0;

Other devices with header_ops->create and mac_len 0, such as ip6gre without
a remote address, would get the rebuilt header too, and tcpdump on the VRF
would decode them instead of starting at the IP header. With a sniffer
attached, this header would stay on the skb that continues up the stack, as
it does today for End.DT and ipip.

If the VRF could rebuild the header also when mac_len is 0, the reset added
by this patch could move before l3mdev_l3_rcv(), in place of the
skb_unset_mac_header(). This would remove the unset, the point Willem
raised on v1, without the capture change Boyan pointed out. The PRE_ROUTING
hook run by the VRF rx handler would then see the same mac header state as
a packet received on an ipip device, and this would avoid the crash I see
in the NFQUEUE case.


David, since this touches the VRF, do you think it could rebuild the header
also when mac_len is 0? I may be missing a case where it should not be
done.

If it can, I see two ways to go, and I am not sure which one is better.
This patch could go in now, since the reported crash is gone with it in my
tests, and the VRF change and the move of the reset could follow on top of
it. Or this patch could go in together with the VRF change, with the reset
already moved, so that the unset goes away in one step. In both cases I can
work on the VRF change. If the VRF should not change, I will look for
another way to cover the NFQUEUE case.

Opinions from everyone are welcome, on which way is better and on the
NFQUEUE case.

Thanks!

Ciao,
Andrea
