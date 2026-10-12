Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75426348C7C;
	Mon, 12 Oct 2026 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791801621; cv=none; b=FhzSMHJUD8gvUyKhp3l2oJMSyl2EbWxiRpAYL9hlsCAlXaXOkSFxziobqaA5Z6e45uIz8nVvip0CZpZFm233uXooYWeqItKdjlwo1xu/Pf862eTe6dMTIYZuTx8ovbPuSRWCB0KU+TLXgyUqLJs4uzfJb5jsORTpW9yKyfoYRc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791801621; c=relaxed/simple;
	bh=ziE8lAg3olNuSPnNtCsX4WIsjvjUwg80ecfSocDyoD8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=itRz1wMsGIkqPA6fv/UfOsi2kaC7ocYXEspqy57FcIjtJhR6If/wXds59bZjgbDKcxm5SDRHJdm//CbrIiz2q31JTRXEXdvVfZQaomJMNqEHg6BKFdwvP1xZ1CPMf9P+MbcV5mT/2831xoI6M8WBSabXol0F6aKW8W6lahNH14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/Nktul3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/Nktul3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1801F0089D;
	Mon, 12 Oct 2026 10:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791801620;
	bh=DiBrVZcOQoLTxCiDd+wbtrX+JX6LPS58GRReWsBaeBQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H/Nktul3XbOANsYijkOC5ePkVrHQOC0uRPlV60y7LN0u+Xh+3+eBecM+T7ooGJ1b6
	 a8NhBRTlEUhmr3bk1SFhnmlK72FjGruPjpBdm3mSVRVapw9cPhyENRdU+2vBPKaB/m
	 y8x/bImRbpfZXotM1UE+UKvNjfXsTvfelgfG+LR7FM2DE68un39OSqYZrRnNYs9M9u
	 uB+JCdEq7svUO4LqtsZXumg5CX2fY+ov1zTG5Ic8num1yD5GxRVYdeAJM7W8K8z+0S
	 VNdu+cFfFOlPTXtoYx6mIY2FflWS64tNiezBXrrmjtfctabCAtrT5Zhy5ORREc6Bkb
	 PmyaUdwAzDQow==
Subject:
 Re: [PATCH] udp: let rx-udp-gro-forwarding aggregate under encapsulation
From: netdev-bot+sashiko@kernel.org
To: eva.kurchatova@virtuozzo.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, alobakin@pm.me,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 12 Oct 2026 10:40:19 +0000
Message-ID: <179180161935.434549.5518274080541032248@kernel.org>
In-Reply-To: <20261008163817.2983484-1-eva.kurchatova@virtuozzo.com>
References: <20261008163817.2983484-1-eva.kurchatova@virtuozzo.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says "a tunnel socket keeps its own receive
  path" and that the new behaviour is "what every host without a tunnel…
- [Medium] The patch treats as a kernel regression a behaviour the in-
  tree selftests already document and work around.
- [Low] tools/testing/selftests/net/udpgro_fwd.sh still explains its DNAT
  setup with the socket-lookup restriction this patch removes.

--

udp: let rx-udp-gro-forwarding aggregate under encapsulation

This patch removes the !sk requirement from the NETIF_F_GRO_UDP_FWD check
in udp_gro_receive(). With it, plain UDP L4 aggregation happens whenever
the device has rx-udp-gro-forwarding enabled, even if the GRO lookup
found a receiving socket. The motivation is a veth.sh kselftest that
fails on hosts where udp_encap_needed_key is enabled.

> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index cf07c3c6611a2..d4e0e6bb9959f 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -804,7 +804,7 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  		if (skb->dev->features & NETIF_F_GRO_FRAGLIST)
>  			NAPI_GRO_CB(skb)->is_flist = sk ? !udp_test_bit(GRO_ENABLED, sk) : 1;
>  
> -		if ((!sk && (skb->dev->features & NETIF_F_GRO_UDP_FWD)) ||
> +		if ((skb->dev->features & NETIF_F_GRO_UDP_FWD) ||
>  		    (sk && udp_test_bit(GRO_ENABLED, sk)) || NAPI_GRO_CB(skb)->is_flist)
>  			return call_gro_receive(udp_gro_receive_segment, head, skb);

[Severity: Medium]
Is the commit message accurate for UDP tunnel sockets that set encap_rcv
but not gro_receive? It says:

  "That is what every host without a tunnel has done all along: a local
  socket without UDP_GRO gets the packets resegmented on delivery, and a
  tunnel socket keeps its own receive path."

Wireguard, L2TP, GTP, AMT, bareudp, rxrpc, SCTP-over-UDP, TIPC, ovpn,
pfcp, rxe, and ESP-in-UDP without UDP_GRO all go through
setup_udp_tunnel_sock()->udp_tunnel_encap_enable(). That turns on
udp_encap_needed_key. On any host with one of these sockets, the GRO
lookup always runs and finds the socket.

For such a socket, udp_gro_receive() takes the
"!sk || !udp_sk(sk)->gro_receive" branch. Before this patch, the !sk term
kept plain L4 aggregation away from the socket when GRO_ENABLED and
fraglist were not set. After this patch, its traffic is aggregated as
SKB_GSO_UDP_L4 whenever the ingress device has rx-udp-gro-forwarding on.

These packets only get resegmented because of the last-resort check in
udp_unexpected_gso(), which udp_queue_rcv_skb() calls:

include/linux/udp.h:udp_unexpected_gso() {
    ...
	/* GSO packets lacking the SKB_GSO_UDP_TUNNEL/_CSUM bits might still
	 * land in a tunnel as the socket check in udp_gro_receive cannot be
	 * foolproof.
	 */
	if (udp_encap_needed() &&
	    READ_ONCE(udp_sk(sk)->encap_rcv) &&
	    !(skb_shinfo(skb)->gso_type &
	      (SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM)))
    ...
}

This doesn't appear to cause corruption. However, every wireguard, L2TP,
GTP, etc. packet that arrives on an rx-udp-gro-forwarding device is now
aggregated and then resegmented. Hosts without a tunnel never did this,
because these sockets are exactly what enable the key.

The fraglist path already relied on udp_unexpected_gso() for found
tunnel sockets. Plain L4 aggregation through the FWD feature is new here.

The comment at the top of this block in udp_gro_receive() still says:

	/* We can do L4 aggregation only if the packet can't land in a tunnel
	 * otherwise we could corrupt the inner stream. Detecting such packets
	 * cannot be foolproof and the aggregation might still happen in some
	 * cases. Such packets should be caught in udp_unexpected_gso later.
	 */

The code now aggregates on purpose when the found socket is a tunnel
socket. Should this comment and the commit message be updated to match?

[Severity: Medium]
Does this change the meaning of rx-udp-gro-forwarding? Commit 36707061d6ba
allowed plain UDP GRO "if we are on forwarding path", and the !sk test was
how that path was detected. The feature bit is still documented that way:

include/linux/netdev_features.h:
	NETIF_F_GRO_UDP_FWD_BIT,	/* Allow UDP GRO for forwarding */

After this patch, the feature means "always aggregate plain UDP on this
device". That includes traffic that ends at a local socket without
UDP_GRO, which udp_queue_rcv_skb() then resegments.

The skip that this patch removes was already known, and the tree works
around it. tools/testing/selftests/net/udpgro_fwd.sh says:

	# UDP GRO fwd skips aggregation when find an udp socket with the GRO option
	# if there is an UDP tunnel in the running system, such lookup happen
	# take place.
	# use NAT to circumvent GRO FWD check

The failing veth.sh check sends through chk_gro() to a local receiver
that runs without -G:

	ip netns exec $BASE$DST ./udpgso_bench_rx -C 1000 -R 10 &

That is local delivery, not forwarding. Its result depends on whether
udp_encap_needed_key happens to be set on the host.

Would it be better to make veth.sh robust instead, for example with the
DNAT approach udpgro_fwd.sh already uses? The Fixes: tag will carry this
change in feature semantics into stable.

If the kernel change is intended, could the commit message describe the
semantic change, and could the feature bit comment be updated?

The commit message also says:

  "the receiving socket is looked up only once a tunnel socket exists"

Isn't the trigger wider than that? udp_lib_setsockopt() also calls
udp_tunnel_encap_enable() when UDP_GRO is set on any socket:

net/ipv4/udp.c:udp_lib_setsockopt() {
    ...
	case UDP_GRO:
		sockopt_lock_sock(sk);
		/* when enabling GRO, accept the related GSO packet type */
		if (valbool)
			udp_tunnel_encap_enable(sk);
    ...
}

[Severity: Low]
The udpgro_fwd.sh comments quoted above explain the DNAT setup with the
!sk restriction that this patch removes. The same explanation appears
again before create_vxlan_pair:

	# use NAT to circumvent GRO FWD check

Should these comments be updated?

The DNAT setup also forces sk == NULL during the GRO lookup. As a result,
the "GRO fwd" and "GRO fwd over UDP tunnel" tests behave the same with
and without this patch.

Does any test reliably cover the changed path, where a socket is found
while the encap key is enabled and rx-udp-gro-forwarding is on? veth.sh
only reaches it when udp_encap_needed_key happens to be enabled on the
host. Nothing seems to cover FWD aggregation followed by resegmentation
for tunnel sockets that set only encap_rcv.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008163817.2983484-1-eva.kurchatova%40virtuozzo.com
