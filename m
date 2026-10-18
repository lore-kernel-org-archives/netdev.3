Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0442B3AFD1D
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338708; cv=none; b=Dg9x7l7T2rz6QjAf7r3rm/IFPinPlGLV89ypjok6GPxUcQE9eiUx/ZCTT7gmEk4NhRzM7wQawMAvXtwltBfrb3/3KmJuGaM8NUC3MMDSlMWqCvefu1dJuSUaApDMtFsmJOxd0DE7EASWTvtL5rJVNl0Rykwqwq69Gr2frUxIy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338708; c=relaxed/simple;
	bh=x7xyrecPHgznzsY41gZAa2pCFpLn54CvquHMb3Jynwg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kujnxj8AoDXgf+qm+ZweF+8GAGhuK8o7vAvn+Wo4ISfP0VQahxIl7ETkDjkBxPj/XmeDrgAlyCG1nd8IgUmGzIL71s5vyi1hzmWoCtGnXNcESKRox+5CxjaB9C13QlZKiELiX6e3VBrLTnQH9e8xBh5xIUKKDbWg0jF7Wt4MykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctuFhzwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctuFhzwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89ADA1F000C8;
	Sun, 18 Oct 2026 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792338704;
	bh=uU9jjvxOlWreYS+cEB7FIls6zHtCzog3WjEwcb7R8i0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ctuFhzweguTxdzpWDU0zD9ZEnklpjmpPBw0GNkkDJGPk++OcdY5LEEYytvrVAVtRl
	 /S9OBrNS/yk4BCBUFmqEZQ3X1TGkklJ2B0frcvQFO+lTgTm7THJ6ohGyaFQLO5GNhF
	 jh2qEiMP0S9dbIb7qQk6MzjYDaWS9wTK70/IsRa6VTwzx10mGpZShn9ISZSrlKNm7C
	 4Yv6pIuo+r5ypu9hoNV2bJ4CcmBIJk1G+3/FtZVqP+t6/eAFP1tgB4kkWEdJXe+TEb
	 0O2xf4eRkEGsTcH6hX8309TRrXnNUgXTlDFl83+H5KOOq6r/CYFUsAjQqQqWaMlzyo
	 WHIx/eWBw5JhQ==
Subject: Re: [PATCH net-next v9 5/8] hsr: Use the port and header information
 in hsr_forward_skb()
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com, pabeni@redhat.com,
 praneeth@ti.com, pratheesh@ti.com, richardcochran@gmail.com, horms@kernel.org,
 vigneshr@ti.com, willemdebruijn.kernel@gmail.com, daniel.machon@microchip.com,
 edumazet@kernel.org
Date: Sun, 18 Oct 2026 15:51:43 +0000
Message-ID: <179233870314.3135.16408273084496136138@kernel.org>
In-Reply-To: <20261014-hsr_ptp-v9-5-2d20a2a0f816@linutronix.de>
References: <20261014-hsr_ptp-v9-5-2d20a2a0f816@linutronix.de>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The per-port TX request (frame->req_tx_port) added by this
  patch does not take effect on slave devices with NETIF_F_HW_HSR_DUP.
- [Low] On PRP devices the has_foreign_header flag is only half honoured.
- [Low] Baseline decision: discard.

--

hsr: Use the port and header information in hsr_forward_skb()

This commit makes hsr_forward_skb() use the tx port and header
information passed down from the upper layer. A frame with a requested
port is sent only on that port.

A frame that already carries an HSR header is sent as a clone of the
original skb. It is not given a sequence number, its h_source is not
replaced and no source node lookup is done.

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 14d793f00344f..a76bd02fe25f1 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c

[ ... ]

> @@ -570,6 +571,17 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  		if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
>  			continue;
>  
> +		/* PTP TX packets have an outgoing port specified */
> +		if (frame->req_tx_port != HSR_PT_NONE && frame->req_tx_port != port->type)
> +			continue;

[Severity: Medium]
Does the per-port request still work when the slave devices have
NETIF_F_HW_HSR_DUP set?

hsr_forward_do() passes the frame only to the requested slave netdev.
Nothing tells the lower driver not to duplicate it.

For DSA, dsa_xmit_port_mask() in net/dsa/tag.h adds every HSR ring port
to the egress mask:

    unlikely(dev->features & NETIF_F_HW_HSR_DUP)) {
    ...
        dsa_hsr_foreach_port(other_dp, dp->ds, hsr_dev)
            mask |= BIT(other_dp->index);

This covers ksz9477, xrs700x and the switches that use
dsa_port_simple_hsr_join().

For TI ICSSG, icssg_ndo_start_xmit() replaces the directed port:

    if (prueth->is_hsr_offload_mode &&
        (ndev->features & NETIF_F_HW_HSR_DUP))
        dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;

So a PTP frame requested for SLAVE_A, such as a per-link peer delay
message, would also go out on SLAVE_B. That doesn't match "If the port
set, deliver it only on the requested port" in the commit message.

The later commit "hsr: Move struct hsr_ethhdr to a global header" says
offloading drivers need to inspect PTP packets and suppress offloading.
No driver is changed in the series, though.

Should the directed case be handled here, or in the drivers, before this
is enabled?

> +		/* PTP TX packets may already have a HSR header which needs to
> +		 * be preserved
> +		 */
> +		if (frame->has_foreign_header && frame->skb_std) {
> +			skb = skb_clone(frame->skb_std, GFP_ATOMIC);
> +			goto inject_into_stack;
> +		}

[Severity: Low]
Should the clone take over the socket ownership here?

__skb_clone() leaves sk as NULL on the clone. The slave driver takes the
TX hardware timestamp on the clone, so the timestamp can't be delivered
to the sending PTP socket. The original skb, which owns the socket, is
freed in hsr_forward_skb() without being sent.

The next commit in the series, "hsr: Assign a socket for cloned skbs",
fixes this by adding skb_set_owner_w() to this branch. So this only
affects this intermediate commit. TX timestamps through hsr were not
delivered before the series either.

> +
>  		/* Don't send frame over port where it has been sent before.

[ ... ]

> @@ -661,6 +674,13 @@ int hsr_fill_frame_info(__be16 proto, struct sk_buff *skb,
>  	struct hsr_port *port = frame->port_rcv;
>  	struct hsr_priv *hsr = port->hsr;
>  
> +	if (frame->has_foreign_header) {
> +		frame->skb_std = skb;
> +
> +		WARN_ON_ONCE(port->type != HSR_PT_MASTER);
> +		WARN_ON_ONCE(skb->mac_len < sizeof(struct hsr_ethhdr));
> +		return 0;
> +	}

[Severity: Low]
This early return is only added to hsr_fill_frame_info(), the hsr_ops
callback. What happens on a PRP device, where proto_ops->fill_frame_info
is prp_fill_frame_info()?

hsr_dev_xmit() accepts hsr_hdr for any prot_version. fill_frame_info()
then sets has_foreign_header and skips hsr_get_node(), and
prp_fill_frame_info() runs its normal logic.

If the frame has no valid RCT, handle_std_frame() still uses up a
sequence number:

    frame->sequence_nr = hsr->sequence_nr;
    WRITE_ONCE(hsr->sequence_nr, hsr->sequence_nr + 1);

The commit message says no sequence number is assigned when a header is
already present.

If the frame has a valid RCT, skb_prp is set and skb_std stays NULL. The
"has_foreign_header && frame->skb_std" bypass in hsr_forward_do() is then
skipped. The frame goes through prp_create_tagged_frame(), which calls
prp_set_lan_id() and rewrites the trailer the user supplied.

At the end of the series, that skb_prp clone also gets no socket owner,
so its TX timestamp is lost.

hsr_dev_xmit() also always adds HSR_HLEN when hsr_hdr is set:

    if (has_header)
        hdr_len = ETH_HLEN + HSR_HLEN;

PRP uses a trailer, not a front tag. On PRP this places network_header
and mac_len 6 bytes too far into the frame.

The later commit "hsr: Assign a socket for cloned skbs" says "This does
not consider PRP part of the stack". Would it be better to reject the
inline header on PRP devices, or to handle has_foreign_header in
prp_fill_frame_info() as well?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014-hsr_ptp-v9-0-2d20a2a0f816%40linutronix.de
