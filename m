Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823A47206A
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297080; cv=none; b=lj7DwrmsZJEXLvuYPOhZXSaAj59RxNd3fVOMxsOPQEO4pwjiTRKauiIIiN6IJITA/SX32o85uU6MUfDWUgTqrL3xFr3aDSG1RF2o+Z2r062BBShgcn6taW8DGkDr1bHVZZxJ1JU1k1UhASETlEaA/WdkCI11FVgcKizTx9869Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297080; c=relaxed/simple;
	bh=znNImesnmYDDwFcPdyogF6MQjNBhrpi8w3O4Qtedo1U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FI6C94P5t43/LoTcz7RgJp6dPpcblZXPG+zmI2RMCKkxXq5fg4gRxS0JmbALR1pHMvspeLsqQgVtJWOVqw8fvbuxFfymztwCILHzQFF/voqYRh+JsvERyM0/KTA+i3khv65v2xnHwCZ8ayyYXalr/4/kUHfzcjwzST2xOJ1R4+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIW5sRPw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIW5sRPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77F11F0089C;
	Tue,  6 Oct 2026 14:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791297078;
	bh=dkiQ3GQbCTH9JcgRB5Ts7ihE7Z4cC2d47PvcOkgmVTM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LIW5sRPwb8y1A1y1Sbckl/+rZGNmcX8LyKSr4aQtu8wHWrZub13mBgGp5fxOvuxLI
	 xDDWg27XHesf6IQ3BgucVYD4mZM1Z2qSUBKMS1S0c2VQzHKqI81ygTGbGuocZ6/NvM
	 Eyd+lQezyyFSCsmnSx2yindfQyQiDJ8dfFIakpfu+E4d358eQHvVWPBTbIuWPEqpqv
	 XpEIeqAuDiJa9436GAVHkThd4SICJhVVKUZBMrc07B2jg8GVZlwSWQBK24VAUIKpSj
	 BBMsqqsTvc4olmQ/wThfMGbxBozwutBDARKij+dUe29uQt6E7lAwYFJ+b3IefTjbgE
	 i7BN3172AdrPQ==
Subject: Re: [PATCH net-next v8 4/8] hsr: Drop received PTP packets
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 edumazet@google.com, fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com,
 pabeni@redhat.com, praneeth@ti.com, pratheesh@ti.com,
 richardcochran@gmail.com, horms@kernel.org, vigneshr@ti.com,
 willemdebruijn.kernel@gmail.com
Date: Tue, 06 Oct 2026 14:31:17 +0000
Message-ID: <179129707723.434549.4053379151333278960@kernel.org>
In-Reply-To: <20261002-hsr_ptp-v8-4-60dabc07e554@linutronix.de>
References: <20261002-hsr_ptp-v8-4-60dabc07e554@linutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says "Drop all received PTP packets", but
  hsr_handle_frame() (net/hsr/hsr_slave.c) only matches Layer-2 PTP.

--

hsr: Drop received PTP packets

This patch changes hsr_handle_frame() so that PTP frames received on the
HSR/PRP slave ports are dropped instead of forwarded. It matches either an
outer ethertype of ETH_P_1588 or an HSR-encapsulated protocol of
ETH_P_1588. It also merges the kfree_skb() error paths into a single
finish_free_consume label.

> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index 5274ba6dd36e6..a5b47f016abd7 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c

[ ... ]

> @@ -64,15 +64,28 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)

[ ... ]

>  	skb_reset_mac_len(skb);
>  
> +	/* PTP packets are not supposed to be forwarded via HSR as-is. The
> +	 * latency introduced by forwarding renders the time information
> +	 * useless. Userland needs to capture the packet on the original
> +	 * interface instead of hsr.
> +	 */
> +	if ((!hsr->prot_version && protocol == htons(ETH_P_PRP)) ||
> +	    protocol == htons(ETH_P_HSR)) {
> +		hsr_ethhdr = (struct hsr_ethhdr *)skb_mac_header(skb);
> +		if (hsr_ethhdr->hsr_tag.encap_proto == htons(ETH_P_1588))
> +			goto finish_free_consume;
> +	} else {
> +		if (protocol == htons(ETH_P_1588))
> +			goto finish_free_consume;
> +	}
> +

[Severity: Medium]
The commit message says:

    Drop all received PTP packets.

Do these checks catch PTP carried over UDP? Both branches only match
ETH_P_1588, which is the Layer 2 mapping.

PTP over UDP/IPv4 or IPv6 (ports 319/320) has ETH_P_IP or ETH_P_IPV6 in
two places. For untagged, PRP, interlink or HW-tag-removed frames it is in
h_proto. For HSR-tagged frames it is in hsr_tag.encap_proto. Either way,
the frame takes neither drop branch.

These frames then go into hsr_forward_skb(). There they are de-duplicated,
delivered to the hsr master and forwarded around the ring. That causes the
same unaccounted forwarding latency and loss of per-port timestamps that
the commit message describes. linuxptp uses network_transport UDPv4 by
default, so this is a common configuration.

UDP PTP behaves the same as it did before this patch, and the IEC 62439-3
PTP profile for HSR/PRP uses the L2 mapping. Still, the commit message
names only VLAN-tagged packets as out of scope. The new comment also
states the policy for PTP in general.

Should the commit message and the comment say that only L2 (ETH_P_1588)
PTP is dropped? Or should the UDP case be handled as well?

>  	/* Only the frames received over the interlink port will assign a
>  	 * sequence number and require synchronisation vs other sender.
>  	 */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-hsr_ptp-v8-0-60dabc07e554%40linutronix.de
