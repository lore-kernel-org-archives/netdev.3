Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68C47125F
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297081; cv=none; b=N5bRCYe6LbCe/YhklEN+ATcBP/UrGVugujE71szOVcXh+53tfVg7dt7v21C51MGT7N8A2t8heSCWlbyTWeKSWqQdvOo2YSi1b6a3SDfddi5XfBDi75jIfkhTjFs5gnr4GVhykaS4DCBWLug6NHfnrdtlkixkADAvEc6HYQSB4ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297081; c=relaxed/simple;
	bh=BotHb1kd9irMy7LASTLuKdoD3r40yX8Z1KMc559EGRM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qsSfjVwLO1BTcvNT8ckQwkJjzi8Pls/lz6gL36Mrii97+aLU2jGqmZSQMbpmknzb0+u3uhCjcUdrgjpdtnxK2ujQh/rgw2Cm7yUbNNRl40rWIHc6YP40hWkVRpVU02p9qXaVALC+ELmyyi5y0wQMLfjX0NB2HGO8YyQ8Hgw8/MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bjx6N7y4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bjx6N7y4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558761F0089B;
	Tue,  6 Oct 2026 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791297080;
	bh=fph77RJ+JzKHa3Wc+dOv1L5qgAlmlEwGSlHs3kPIv74=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Bjx6N7y4s1idgY+ZOuHf2QRvdYa7UPpLEgkkJTzJatSmDUQF9opW4c9N2gSXRbP5x
	 w6cTJY0zDYTkRLtzfIlhxMOOwFrF/aLEalnhxlAWstSGrmrPtRAPC4wKq4pgwDJVdi
	 sRAji0y3nU7OGeSNyYOLJC2ohh5ngUiwymmXn8ccWVtJtC2lWPQHT5HH6qgql+LBgV
	 9xMIaGdOm/HIB2WlxD8oGoEkH7K9psbr9GBJ89oG5TUaJP0bVdEhKUvkkr5MBHv9xQ
	 ujWryxj2nz6sNs1yx1lPY8Efeb6LfGjBpYwdpMDQeIPiUjcfqYBMmRcT1cZaRJuG/d
	 c4hHdR8dE08tQ==
Subject: Re: [PATCH net-next v8 5/8] hsr: Use the port and header information
 in hsr_forward_skb()
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 edumazet@google.com, fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com,
 pabeni@redhat.com, praneeth@ti.com, pratheesh@ti.com,
 richardcochran@gmail.com, horms@kernel.org, vigneshr@ti.com,
 willemdebruijn.kernel@gmail.com
Date: Tue, 06 Oct 2026 14:31:18 +0000
Message-ID: <179129707887.434549.17889821067161034900@kernel.org>
In-Reply-To: <20261002-hsr_ptp-v8-5-60dabc07e554@linutronix.de>
References: <20261002-hsr_ptp-v8-5-60dabc07e554@linutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] hsr_forward_do()'s new per-port delivery (`frame->req_tx_port`
  filter, line 577) and pre-tagged bypass (line 582) ignore HSR hardware…
- [Low] The new foreign-header branch in hsr_forward_do() sends
  `skb_clone(frame->skb_std, GFP_ATOMIC)` without moving socket…

--

hsr: Use the port and header information in hsr_forward_skb()

This patch makes hsr_forward_skb() use the tx port and the "has HSR header"
information passed in by the upper layer. Frames can be limited to a single
slave port. Frames that already carry an HSR header are cloned and sent
unchanged, without sequence number assignment, source address substitution
or a node_db lookup.

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 4afe9e1d65b7e..562802ddff003 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c

[ ... ]

> @@ -572,6 +573,17 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  		if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
>  			continue;
>  
> +		/* PTP TX packets have an outgoing port specified */
> +		if (frame->req_tx_port != HSR_PT_NONE && frame->req_tx_port != port->type)
> +			continue;

[Severity: Medium]
Does "deliver it only on the requested port" still hold when the slaves
have HSR hardware offload enabled?

This check selects the port in software only. Nothing tells a slave with
NETIF_F_HW_HSR_DUP not to duplicate the frame. DSA switches (ksz9477,
xrs700x, and switches using dsa_port_simple_hsr_join()) add every HSR port
to the TX mask in the tagger:

net/dsa/tag.h:dsa_xmit_port_mask() {
    ...
	if (IS_ENABLED(CONFIG_HSR) &&
	    unlikely(dev->features & NETIF_F_HW_HSR_DUP)) {
		...
		dsa_hsr_foreach_port(other_dp, dp->ds, hsr_dev)
			mask |= BIT(other_dp->index);
    ...
}

icssg in HSR offload mode marks every skb as undirected and asks the
firmware to insert a tag:

drivers/net/ethernet/ti/icssg/icssg_common.c:icssg_ndo_start_xmit() {
    ...
	if (prueth->is_hsr_offload_mode &&
	    (ndev->features & NETIF_F_HW_HSR_DUP))
		dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;

	if (prueth->is_hsr_offload_mode &&
	    (ndev->features & NETIF_F_HW_HSR_TAG_INS))
		epib[1] |= PRUETH_UNDIRECTED_PKT_TAG_INS;
    ...
}

So a PTP frame sent with tx_port set to SLAVE_A goes through
hsr_dev_xmit()->hsr_forward_skb()->hsr_forward_do()->hsr_xmit(). On these
setups, wouldn't it still leave on SLAVE_B as well?

The has_foreign_header branch below has a related issue. It skips
create_tagged_frame(), which is where NETIF_F_HW_HSR_TAG_INS is normally
taken into account. It then passes an already tagged frame to hardware
(xrs700x, icssg) that may insert its own HSR tag. Can that produce a
double tagged frame?

The later commit "hsr: Move struct hsr_ethhdr to a global header" says
that "in the offloading case the network driver needs to inspect the HSR
header ... where it needs suppress offloading of the packet". No driver or
DSA tagger change in the series seems to do that.

Should hsr_forward_do() reject these frames on offloading slaves, or work
around the offload, until the drivers handle it?

> +		/* PTP TX packets may already have a HSR header which needs to
> +		 * be preserved
> +		 */
> +		if (frame->has_foreign_header && frame->skb_std) {
> +			skb = skb_clone(frame->skb_std, GFP_ATOMIC);
> +			goto inject_into_stack;
> +		}

[Severity: Low]
Does this clone lose the socket ownership of the original skb?

__skb_clone() sets n->sk and n->destructor to NULL on the clone. After
that, hsr_forward_skb() frees the socket-owned original:

	kfree_skb(frame.skb_std);

That runs sock_wfree() while the clone may still be queued on the slave.
The socket's wmem accounting then stops covering the in-flight packet.
Also, skb_tstamp_tx() sees a NULL sk, so the PTP TX timestamp never reaches
the sender.

A later commit in the series, "hsr: Assign a socket for cloned skbs",
seems to fix this. It adds the following to this branch, and does the same
for the req_tx_port case in hsr_create_tagged_frame():

	if (skb && frame->skb_std->sk)
		skb_set_owner_w(skb, frame->skb_std->sk);

The old path through hsr_create_tagged_frame() also cloned without
restoring the socket, so this patch doesn't make things worse.

Could that fix be folded into this patch?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-hsr_ptp-v8-0-60dabc07e554%40linutronix.de
