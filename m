Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C43D3D1D
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515467; cv=none; b=mqSvJ45QT1BH6OhXSHYy0vFJlmA8azix2B0VKiIKYGnqS0HEy/XCqFfGQHpIGP6s0E7Kk/ub88WLbRnai7maaAzZT7D8Xi8vIIBrg7NbPYP7LVKMkLfohxKP6dXKhP4Mr+Sc56eZR9xtG8VEPZ2TCWhTqkUQsW/YFB5Qkfw+mT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515467; c=relaxed/simple;
	bh=WXwD4TZhJ/f01Burl30QhDjrsPHfjqoidUEi5xgkq7A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TH4Gm7GtKoryfAXrcXC3Py4zR+xbxbAU0sTc+gDPYa1QuDegymcJLmEh8ZvZvMTCFWYAtcKYi3pwDEo94fieNs1r7LJ8PlHcHvdi9KkTYDZ20VqHUAFT2k+0PbVy0niV+kBuqYA3XSQAcGR62eQzOnnYdruPDRRKhW2rkGFMopw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R69+8Q41; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R69+8Q41"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451621F00893;
	Sun, 27 Sep 2026 13:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790515466;
	bh=AM45RPEVKGNpJvuQAiYx9P+AFUmNym+TF08MF1k8f0M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R69+8Q41mrrBwyqxyYqKgs2+/yxtfWrjyMQ/wdrkeLdse+AYd5W5NPoWdf0GIG8VG
	 oiIR8zX0lHc2VObIwzdiV9Jo72VsRFrOjJ5LuhtIWC5WBQ272G/cT/dN42XpmSh/y1
	 CtuNaArA2iBcHnzKBz6icYujzVU+e2tISjEtWtE5clNBHJ0RbWUTg6jAoZwHkNLmm/
	 lAAEfLpCMB1Oz5rx22pPmgA/DaazLR/+cr/ZJmmK9NG2zCV6tXwWIWjeubahs3jdOA
	 ZZXZwUKxpuoetDQoeWsIDSGDBhHN984gdrxXEEL6KCxDzTXII9PK4g/FhsqHECR3Nk
	 f4zgP6C0LjDsQ==
Subject: Re: [PATCH net-next v6 4/8] hsr: Drop received PTP packets
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 edumazet@google.com, fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com,
 pabeni@redhat.com, praneeth@ti.com, pratheesh@ti.com,
 richardcochran@gmail.com, horms@kernel.org, vigneshr@ti.com,
 willemdebruijn.kernel@gmail.com
Date: Sun, 27 Sep 2026 13:24:24 +0000
Message-ID: <179051546486.2160803.3865035064393511257@kernel.org>
In-Reply-To: <20260923-hsr_ptp-v6-4-6ea07b3fb8a8@linutronix.de>
References: <20260923-hsr_ptp-v6-4-6ea07b3fb8a8@linutronix.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In hsr_handle_frame() (net/hsr/hsr_slave.c) the new PTP drop
  only runs in the `else` branch for non-interlink ports.
- [Medium] The new PTP check in hsr_handle_frame() only compares the
  immediate Ethernet h_proto (untagged/PRP branch) or…
- [Low] The commit message says 'Drop all received PTP packets', but
  hsr_handle_frame() only matches Layer-2 PTP.
- [Low] In hsr_handle_frame(), the intentional PTP policy drops go
  through the shared finish_free_consume label.
- [Low] In hsr_handle_frame() the two new branches are labelled '/* HSR
  */' and '/* PRP */'.

--

hsr: Drop received PTP packets

This patch changes hsr_handle_frame() so that PTP frames received on
HSR/PRP slave ports are dropped. Before, they were forwarded and delivered
to the hsr master. Tagged HSR frames are checked by their encapsulated
protocol. All other frames are checked by their ethertype against
ETH_P_1588. The error paths now share a single finish_free_consume label.

> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index 5274ba6dd36e6..7c99f7e072763 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c

[ ... ]

> @@ -81,10 +78,32 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
>  		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
>  		spin_unlock_bh(&hsr->seqnr_lock);
>  	} else {
> +		struct hsr_ethhdr *hsr_ethhdr;
> +
> +		/* PTP packets are not supposed to be forwarded via HSR as-is.
> +		 * The latency introduced by forwarding renders the time
> +		 * information useless. Userland needs to capture the packet on
> +		 * the original interface instead of hsr.
> +		 */

[Severity: High]
The new check is only in the else branch. Should PTP frames received on
the interlink (RedBox) port be dropped too?

When port->type == HSR_PT_INTERLINK, the frame is still forwarded without
any protocol check:

	if (port->type == HSR_PT_INTERLINK) {
		spin_lock_bh(&hsr->seqnr_lock);
		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
		spin_unlock_bh(&hsr->seqnr_lock);

An L2 PTP multicast frame (ethertype 0x88F7) from a SAN then takes this
path:

hsr_handle_frame()
  hsr_forward_skb()
    hsr_forward_do()
      hsr_deliver_master()     -> delivered to hsr0/prp0
      create_tagged_frame()    -> sent out slave A and slave B

hsr_drop_frame() and prp_drop_frame() only check supervision frames and
unicast destinations found in the node/proxy tables. They don't filter
multicast PTP.

The frame gets a sequence number, is tagged, and is forwarded into the
ring with the uncompensated software latency. The commit message says this
should stop ("Drop all received PTP packets", "Forwarding a PTP packet by
the HSR stack is undesired").

The TX side works differently. hsr_dev_xmit() only lets ETH_P_1588 out on
SLAVE_A/SLAVE_B via the inline header. Suppose a PTP stack on the RedBox
also relays interlink PTP into the ring via the inline header. Would
downstream nodes then get two copies of each message, the kernel's
uncorrected one and the stack's corrected one?

hsr_slave.c doesn't seem to change again later in the series. Would
moving the ETH_P_1588 check above the interlink/else split cover both
paths?

> +		if ((!hsr->prot_version && protocol == htons(ETH_P_PRP)) ||
> +		    protocol == htons(ETH_P_HSR)) {
> +			/* HSR */

[Severity: Low]
This isn't a bug, but are the /* HSR */ and /* PRP */ labels accurate?

The condition tests whether an HSR tag is present, not whether the device
is set up for HSR or PRP. So:

- The "HSR" branch also handles PRP-mode frames that carry ETH_P_HSR.
- The "PRP" branch also handles untagged frames in general. This includes
  HSR-mode frames on ports with NETIF_F_HW_HSR_TAG_RM, where the tag has
  already been stripped.

The logic is correct in all of these cases. Would "tagged" and "untagged"
be more accurate labels?

> +			hsr_ethhdr = (struct hsr_ethhdr *)skb_mac_header(skb);
> +			if (hsr_ethhdr->hsr_tag.encap_proto == htons(ETH_P_1588))
> +				goto finish_free_consume;
> +		} else {
> +			/* PRP */
> +			if (protocol == htons(ETH_P_1588))
> +				goto finish_free_consume;

[Severity: Medium]
Can L2 PTP with stacked VLAN tags get past this check?

__netif_receive_skb_core() strips only one VLAN tag before the rx_handler
runs:

	if (eth_type_vlan(skb->protocol)) {
		skb = skb_vlan_untag(skb);

Take a frame with stacked tags, such as an 802.1ad outer tag and an
802.1Q inner tag. It reaches hsr_handle_frame() with
h_proto == ETH_P_8021Q.

prp_ops has no .invalid_dan_ingress_frame hook. On a PRP slave the frame
therefore reaches the untagged branch here, where 0x8100 is compared with
0x88F7 and doesn't match.

The frame then goes to hsr_forward_skb()->fill_frame_info(). That
function does unwrap the VLAN header to find the real protocol:

	if (proto == htons(ETH_P_8021Q))
		frame->is_vlan = true;

It applies no PTP rejection, though. The frame is delivered to the
master, and on a RedBox to the interlink as well.

The same applies to HSR frames whose tag has encap_proto 0x8100 (a VLAN
header after the HSR tag). They also get past the encap_proto comparison.

Should this filter look through a VLAN header the same way
fill_frame_info() does?

[Severity: Low]
The commit message says:

    Drop all received PTP packets.

Both comparisons here match only Layer-2 PTP (ETH_P_1588). PTP over
UDP/IPv4 or UDP/IPv6 (ports 319/320) has ethertype ETH_P_IP or
ETH_P_IPV6, or that value as encap_proto in the HSR tag. That traffic is
still de-duplicated, delivered to hsr0, and forwarded around the ring in
software.

Limiting this to L2 is probably intended. The IEC 62439-3 and
IEC 61850-9-3 profiles use L2 PTP, and the inline TX header in the rest of
the series only handles ETH_P_1588. Could the commit message and the
comment say "Layer-2 PTP (ETH_P_1588)" instead of "all received PTP
packets"?

>  		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
>  	}
>  
> -finish_consume:
> +	return RX_HANDLER_CONSUMED;
> +
> +finish_free_consume:
> +	kfree_skb(skb);
>  	return RX_HANDLER_CONSUMED;

[Severity: Low]
Would a dedicated drop reason help here?

The deliberate PTP drops now share this label with two error paths: the
self-sent frame case and the failed pskb_may_pull() case. kfree_skb()
reports SKB_DROP_REASON_NOT_SPECIFIED and no counter is incremented.

On a network with a lot of PTP traffic, every Sync, Follow_Up, Delay_Req
and Pdelay frame shows up in drop_monitor and the kfree_skb tracepoint as
an unexplained drop. The error drops also can't be told apart from the
policy drops.

Could the PTP path use kfree_skb_reason() with its own reason?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-hsr_ptp-v6-0-6ea07b3fb8a8%40linutronix.de
