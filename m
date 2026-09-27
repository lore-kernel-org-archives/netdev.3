Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908193D3D1D
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515470; cv=none; b=gzDWNFWPHVNsAojDAGBxPBZV9XebCE21zdqxyWQgj21UOArwOcxngbktNoJUqXZIVrxuu63wY2G5uD9PIMxAVmVcoUsvV3sjiaalkMgAz4YfcEiAIKU3v79l+QAAMJwc6ezI9duTbMCJbmH7SWFl+Sm6tdZ9DtgCHhpkVfSFjFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515470; c=relaxed/simple;
	bh=iCdkYJp4QWOS5etcTyzdaZjAz3ZpyGwYAds1YtwNKNw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rR0r7te3ELcKPQXaRkSIII3/VUqqCnaK1gQJXNQitFTKZl70cMcMiv58TOsZoQBEZHI5uqIy2J1winNhCSB6EAMH2Yg2AyxN/Dci28wIlL4QgbupemDUJhnhfNE6MB229WO+PCGwJ6pA8NW2c/++uoboWUSkiFpj9TACm2e0b1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtiP93Ox; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtiP93Ox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E1D1F00893;
	Sun, 27 Sep 2026 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790515469;
	bh=8bVMICCQsflVQ39MfeFhdw5q5W50jiu31I5mIiz5ijI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LtiP93Oxjcy+a/rhiiHmunpW30ishbvk+0/J3/keWMnTwnyEraINSlYce5+/Um5+y
	 JUNx6IMmv373BJIjgwsdBMHcUlT91Fyw8tif6AuiHDC6AhEItmmIfzTdUVz4EiQGJq
	 LI5ZRk73WauAlGGUyO6AfqBufKBDlbvx8Mp2O1kVRyEX/wdI7lV8aI6CS8Fy0nuVXO
	 LxA0VNaH3RT0u32sSb4Oe6He2PfDX5Cn7MPVObwn6j7EWx18RTGzVOjKsisqLNyjX1
	 PXIAw8YUM/5PIyebzDmzfSPaxFrs+Nvcuq1pCpI0PGPHd4qsTZwhizrJUV9ox58PoA
	 p5l17RJ7jOsLw==
Subject: Re: [PATCH net-next v6 6/8] hsr: Assign a socket for cloned skbs
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 edumazet@google.com, fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com,
 pabeni@redhat.com, praneeth@ti.com, pratheesh@ti.com,
 richardcochran@gmail.com, horms@kernel.org, vigneshr@ti.com,
 willemdebruijn.kernel@gmail.com
Date: Sun, 27 Sep 2026 13:24:27 +0000
Message-ID: <179051546785.2160803.13163251351614203954@kernel.org>
In-Reply-To: <20260923-hsr_ptp-v6-6-6ea07b3fb8a8@linutronix.de>
References: <20260923-hsr_ptp-v6-6-6ea07b3fb8a8@linutronix.de>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes PTP TX timestamps only for HSR.
- [Medium] The commit message describes a general fix and does not
  mention that the socket is reattached only for PTP-directed frames.

--

hsr: Assign a socket for cloned skbs

This patch gives the clone the socket of the original skb in two places:
hsr_create_tagged_frame() and the has_foreign_header path of
hsr_forward_do(). Only the clone is ever transmitted, so this lets
requested TX timestamps reach the user.

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index b68aada1a1393..318e1ca438c25 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c

[ ... ]

> @@ -348,6 +349,9 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
>  	if (!skb)
>  		return NULL;
>  
> +	if (frame->req_tx_port != HSR_PT_NONE && frame->skb_std->sk)
> +		skb_set_owner_w(skb, frame->skb_std->sk);
> +

[Severity: High]
Does this fix leave PRP devices out?

hsr_dev_xmit() accepts the ETH_P_1588 inline header and sets tx_port
without checking prot_version. A PRP device therefore reaches the same
req_tx_port path:

net/hsr/hsr_device.c:hsr_dev_xmit() {
    ...
	has_header = hsr_opt->hsr_hdr;
	tx_port = hsr_opt->tx_port;
	if (tx_port != HSR_PT_SLAVE_A && tx_port != HSR_PT_SLAVE_B)
		goto drop;
    ...
}

Here is the path when hsr_hdr is not set:

- prp_fill_frame_info() calls handle_std_frame(), so frame->skb_std is
  the original skb.
- hsr_forward_do() skips the has_foreign_header branch.
- prp_register_frame_out() and prp_drop_frame() both let the frame
  through.
- The outgoing skb is then built by prp_create_tagged_frame() through
  prp_ops. This patch does not change that function:

net/hsr/hsr_forward.c:prp_create_tagged_frame() {
    ...
	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
		return skb_clone(frame->skb_std, GFP_ATOMIC);
	}

	skb = skb_copy_expand(frame->skb_std, skb_headroom(frame->skb_std),
			      skb_tailroom(frame->skb_std) + HSR_HLEN,
			      GFP_ATOMIC);
	return prp_fill_rct(skb, frame, port);
}

The NETIF_F_HW_HSR_TAG_INS branch returns the same socket-less clone the
commit message describes. The skb from skb_copy_expand() also has
skb->sk == NULL.

The copy path loses more than the socket. skb_copy_header() only copies
gso_size, gso_segs and gso_type from skb_shinfo(), so tx_flags and tskey
(SKBTX_HW_TSTAMP etc.) are dropped too. Setting the socket alone would
not be enough there.

When the slave driver reports the TX timestamp, __skb_tstamp_tx() stops
at:

	if (!sk)
		return;

Nothing reaches the user, so a PTP stack such as ptp4l on a PRP device
would time out waiting for TX timestamps.

The later patches in this series ("hsr: Move struct hsr_ethhdr to a
global header" and the selftest) don't touch prp_create_tagged_frame(),
so the gap is still there at the end of the series.

Should PRP get the same socket assignment plus a way to keep the
timestamp flags on the copy path? Or should hsr_dev_xmit() reject the
inline PTP header on PRP devices?

[Severity: Medium]
Does the commit message match what this condition does? It says:

    The cloned skb does not have a socket information recorded of
    the original skb. The original skb is never submitted. This means the
    requested timestamp information gets lost.

    Assign the socket of the original skb to the clone so the timestamp is
    forwarded to the user.

That reads like a fix for all cloned skbs. The code, however, only sets
the socket when frame->req_tx_port != HSR_PT_NONE.

hsr_dev_xmit() sets tx_port only for ETH_P_1588 frames that carry the
inline header magic. All other traffic keeps the default:

	enum hsr_port_type tx_port = HSR_PT_NONE;

Clones of those frames still go out with no socket, because
__skb_clone() clears sk and destructor. For sockets using
SO_TIMESTAMPING on hsr0, __skb_tstamp_tx() still returns early on those
frames.

Limiting this to the PTP path looks deliberate. Charging every clone to
sk_wmem_alloc and changing skb->hash and ooo_okay would change behavior
for normal traffic.

Could the commit message say that the change only covers PTP frames sent
to a specific port, and why?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-hsr_ptp-v6-0-6ea07b3fb8a8%40linutronix.de
