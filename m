Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CDA3E3DB1
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515466; cv=none; b=nBvD9qI7A+9xpYsbC4TXJ7I4uMBIIvp8lf0fzOKNkoFppz3bGcL1SCZA5eeHbIFnTRPMPXxqJGnAPiKZa81cTt76oWqYvjoVxd/TNLDRyqwot2ZT4lo1SMBqIyPcsfxL6RsiDT1ztdjJXp+/oKyNynUkQRmNoYLSxSDznAqbQZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515466; c=relaxed/simple;
	bh=LDWOC+Yb6cnV2ST9o9WdxQaORBeQiLtfXYyR9Ird1d4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dos6BkJuSRRtbqsHkt7seFvlQPbVGRQKp4SLf1zluHel1MTnkrBbAGq+Fw1w6UP9IM2rR18pI2MPylGA4+ByYwvumXSmogy3o9ui8f7j9Ru4mqXdLm9UnathSe/r6ypIUMsm4qRiRT83d5oMp3h5zt5MYL3+668QSj9ERGKMKbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fh3SNfb7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fh3SNfb7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E4A1F000FF;
	Sun, 27 Sep 2026 13:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790515464;
	bh=JPagg1iG6AFB7aNoUtdgH/MY/gM1SX9L2+RaiLje2QU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fh3SNfb7JZ6eUHuKxhF6Uho7RQP0PjfKDMF9B0f+kP/UgJrYAnYTYQOTT/1T4JbF5
	 KCbjB1QyxQCl0gbLwgpElFKcabqkyel1suoIWuwZZKzybqG86rjft7Qw3yc8yE8bl+
	 SG7TJiFKVSCZC+2kkkME4GOz1N2Tq6z1MgkNqE8rRnohRAqxMnEpUQjVokzmJf6cmf
	 45LTzOPAmyJRgy9vv2E7P2uol5T6BD9iRVYiO0I5uPG1y0CM4rrXZuUxFh5fg0wC5B
	 IkdDbAFH/nq2RUD8tg5IK1IFIcNL7yuIqxxTwiuQ7mcQiv80qVLEo5okfyMC2L2IG2
	 LkNa+tTMW1nGw==
Subject:
 Re: [PATCH net-next v6 3/8] hsr: Add a magic header for sending PTP packets
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 edumazet@google.com, fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com,
 pabeni@redhat.com, praneeth@ti.com, pratheesh@ti.com,
 richardcochran@gmail.com, horms@kernel.org, vigneshr@ti.com,
 willemdebruijn.kernel@gmail.com
Date: Sun, 27 Sep 2026 13:24:23 +0000
Message-ID: <179051546321.2160803.5230686056782443625@kernel.org>
In-Reply-To: <20260923-hsr_ptp-v6-3-6ea07b3fb8a8@linutronix.de>
References: <20260923-hsr_ptp-v6-3-6ea07b3fb8a8@linutronix.de>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] net/hsr: UAPI breakage for standard ETH_P_1588 packets
- [Medium] The patch adds a new userspace ABI: an in-band 14-byte header
  (struct hsr_inline_header, magic HSR_INLINE_HDR 0xaf485352) that PTP…
- [Low] At this commit hsr_forward_skb() (net/hsr/hsr_forward.c:779-789)
  accepts the new tx_port and has_hsr_header parameters but ignores them.

--

hsr: Add a magic header for sending PTP packets

This commit adds struct hsr_inline_header, which must be prepended to
ETH_P_1588 frames sent through the hsr device. The header is identified
by a magic value and carries the requested transmit port and whether an
HSR header is already present. hsr_dev_xmit() checks and strips the
header, then passes both values to hsr_forward_skb(), which gains two new
parameters.

> diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
> index f4cf2dd36d193..1db1bd0fa181d 100644
> --- a/include/linux/if_hsr.h
> +++ b/include/linux/if_hsr.h

[ ... ]

> @@ -22,6 +23,16 @@ enum hsr_port_type {
>  	HSR_PT_PORTS,	/* This must be the last item in the enum */
>  };
>  
> +#define HSR_INLINE_HDR	0xaf485352
> +struct hsr_inline_header {
> +	uint8_t tx_port;
> +	uint8_t hsr_hdr;
> +	uint8_t __pad0[4];
> +	__be32 magic;
> +	uint8_t __pad1[2];
> +	__be16 eth_type;
> +} __packed;

[Severity: Medium]
Userspace has to build this header for every PTP frame written to an hsr
device, so isn't this a new userspace ABI? It is defined in
include/linux/if_hsr.h, which is not exported. The only exported HSR UAPI
header is include/uapi/linux/hsr_netlink.h, and the patch does not
document the format anywhere.

The tx_port values are the internal enum hsr_port_type values
(HSR_PT_SLAVE_A = 1, HSR_PT_SLAVE_B = 2). That enum lives in the same
non-UAPI header and has a "must be the last item" ordering rule. If the
enum is ever reordered, would a given userspace value then select a
different port without any warning?

The selftest in the series (tools/testing/selftests/net/hsr/hsr_ptp_test.c)
already has to redefine struct hsr_inline_header and HSR_INLINE_HDR. It
also hard-codes the port numbers:

    #define PORT_1 1
    #define PORT_2 2

Also, hsr_dev_xmit() only checks magic and tx_port:

    has_header = hsr_opt->hsr_hdr;
    tx_port = hsr_opt->tx_port;
    if (tx_port != HSR_PT_SLAVE_A && tx_port != HSR_PT_SLAVE_B)
        goto drop;

__pad0[], __pad1[] and eth_type are never checked, and any non-zero
hsr_hdr is treated as true. Kernels with this patch will accept any value
in those fields. Doesn't that mean these fields can never be given a
meaning later?

Could the definition and the port values move to a uapi header, with the
format documented and non-zero padding rejected?

[ ... ]

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index d5e6597917c26..bb111a18d24e9 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -776,7 +776,8 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>  }
>  
>  /* Must be called holding rcu read lock (because of the port parameter) */
> -void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
> +void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
> +		     enum hsr_port_type tx_port, bool has_hsr_header)
>  {
>  	struct hsr_frame_info frame;
>  

[Severity: Low]
At this commit, hsr_forward_skb() accepts tx_port and has_hsr_header but
never uses them. The body is unchanged:

net/hsr/hsr_forward.c:hsr_forward_skb() {
    ...
	if (fill_frame_info(&frame, skb, port) < 0)
		goto out_drop;

	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
	hsr_forward_do(&frame);
    ...
}

hsr_dev_xmit() now parses and strips the inline header and passes both
values in. With only this commit applied, would a PTP frame that asks for
one slave port still be sent on both ports?

And would a frame with hsr_hdr = 1, which already carries an HSR header,
still go through node registration, duplicate tracking and source
substitution?

This is fixed later in the series by "hsr: Use the port and header
information in hsr_forward_skb()". That commit passes tx_port and
has_hsr_header to fill_frame_info(), skips ports that don't match in
hsr_forward_do(), and takes the foreign-header shortcut. The commit
message here also says the parameters "will be used later", so this only
affects bisection.

Could the parsing and the functional change go into the same commit, so
the new header isn't a no-op in between?

[ ... ]

> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -223,24 +223,66 @@ static netdev_features_t hsr_fix_features(struct net_device *dev,
>  
>  static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
> +	enum hsr_port_type tx_port = HSR_PT_NONE;
>  	struct hsr_priv *hsr = netdev_priv(dev);
>  	struct hsr_port *master;
> +	bool has_header = false;
>  
>  	rcu_read_lock();
>  	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> -	if (master) {
> -		skb->dev = master->dev;
> -		skb_reset_mac_header(skb);
> -		skb_reset_mac_len(skb);
> -		spin_lock_bh(&hsr->seqnr_lock);
> -		hsr_forward_skb(skb, master);
> -		spin_unlock_bh(&hsr->seqnr_lock);
> -	} else {
> -		dev_core_stats_tx_dropped_inc(dev);
> -		dev_kfree_skb_any(skb);
> +	if (!master)
> +		goto drop;
> +
> +	skb->dev = master->dev;
> +	if (skb->protocol == htons(ETH_P_1588)) {
> +		struct hsr_inline_header *hsr_opt;
> +		struct ethhdr *eth_hdr;
> +		unsigned int hdr_len;
> +
> +		BUILD_BUG_ON(sizeof(struct hsr_inline_header) != sizeof(struct ethhdr));
> +
> +		/* need to access the magic header */
> +		if (!pskb_may_pull(skb, sizeof(struct hsr_inline_header)))
> +			goto drop;
> +
> +		hsr_opt = (struct hsr_inline_header *)skb_mac_header(skb);
> +		if (hsr_opt->magic != htonl(HSR_INLINE_HDR))
> +			goto drop;
> +
> +		has_header = hsr_opt->hsr_hdr;
> +		tx_port = hsr_opt->tx_port;
> +		if (tx_port != HSR_PT_SLAVE_A && tx_port != HSR_PT_SLAVE_B)
> +			goto drop;
> +
> +		if (has_header)
> +			hdr_len = ETH_HLEN + HSR_HLEN;
> +		else
> +			hdr_len = ETH_HLEN;
> +
> +		/* Ensure the real header after the stripped one can be
> +		 * accessed
> +		 */
> +		if (!pskb_may_pull(skb, sizeof(struct hsr_inline_header) +
> +				   hdr_len))
> +			goto drop;
> +
> +		eth_hdr = skb_pull(skb, sizeof(struct hsr_inline_header));
> +		skb_set_network_header(skb, hdr_len);
> +		skb->protocol = eth_hdr->h_proto;
>  	}
> +
> +	skb_reset_mac_header(skb);
> +	skb_reset_mac_len(skb);
> +	spin_lock_bh(&hsr->seqnr_lock);
> +	hsr_forward_skb(skb, master, tx_port, has_header);
> +	spin_unlock_bh(&hsr->seqnr_lock);
>  	rcu_read_unlock();
>  
> +	return NETDEV_TX_OK;
> +drop:
> +	rcu_read_unlock();
> +	dev_core_stats_tx_dropped_inc(dev);
> +	dev_kfree_skb_any(skb);
>  	return NETDEV_TX_OK;
>  }
>  

[Severity: Critical]
Before this patch, an ETH_P_1588 frame sent on the hsr device took the
same path as any other frame. hsr_dev_xmit() handed it to
hsr_forward_skb(), and it went out on both slave ports with the HSR tag
or PRP trailer added.

After this patch, any skb with skb->protocol == htons(ETH_P_1588) that
does not start with struct hsr_inline_header is dropped here. Isn't
that a user-visible regression? An existing application that writes
plain PTP frames to an AF_PACKET socket bound to the hsr interface had
those frames duplicated onto both LANs. Now every one of them is
thrown away, even if it never cared about getting a TX timestamp back.

The drop is also silent. The only trace is the tx_dropped counter
bumped by dev_core_stats_tx_dropped_inc(), and sendmsg() still returns
success. A user upgrading the kernel would have a hard time working
out why PTP stopped working over the hsr device.

The new layout places magic over h_source[0..3]. The 0xaf in the first
byte has the group bit set, so a valid ethernet source address can
never match HSR_INLINE_HDR. Given that, could a frame without the magic
fall through to the old forwarding path instead of hitting goto drop?
The inline header would then be opt-in rather than mandatory.

If dropping plain PTP frames is intentional, could the commit message
say so and explain why the old behaviour is not worth keeping? The
other option is to select the new mode explicitly, for example per
socket or per hsr device through netlink, rather than keying it only
on the ethertype. Which of these did you have in mind?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-hsr_ptp-v6-0-6ea07b3fb8a8%40linutronix.de
