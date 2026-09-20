Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341B47ECD8;
	Sun, 20 Sep 2026 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941363; cv=none; b=h8LFR8ywG0DnTKEcT8ev+WZJSbN05HNhDMXLOvxhNNzy+7nOLxl+x903xuFXXzAsPMEnlYoWY7P489qUGuDozB8vuev92Ioa7HiLynPkpamKnEa2yYfLxwKz4WwBFEidcyRgqv9hCSfnntTBdXHHb/yrHzZ/i8y5nYSiV88DODo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941363; c=relaxed/simple;
	bh=BEQiT5fc6AJC7c/aZf2Ivcxy9ugmzRwSIdGmXiPh7Ac=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HHzhuGXAn+pCshYJMm3R3MtawMWQ+z97vtogum3jV4awsOiQFwgzVmDk5qE6nHHxvXwDpRG1Tb8tzaUmTwGsdcgxwBTD5XliQwiAQGHvVBVQMQwgut5cWqBkZjaVDSbFo246r5EysRqOlqx2RP3xW/IJhjLBycHWP78w7xnr6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpJjBcA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpJjBcA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7A61F00898;
	Sun, 20 Sep 2026 21:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789941356;
	bh=billbsGtYXP6I0y210sXcMoSAiDZMPR70xpZzm1bUpI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FpJjBcA6qvytJoD4bpM7GD0Ua+qsv0bfdtTZFtvo9ka5FkQxUWAKrzjiqju3wGvzw
	 udq5tTw+kbeG/L+eg54eOyFJoZA+LEqLFogsO5OYpcyDVVmpYSbfa0SBAL1iEGK9cb
	 rCYCNPCtcKNZjCB69l67HkzvnFxXw5DTXQ7gPWdXlK9vGbg1zfXQXwfb+e90cmiPwB
	 0s/2kHBHi07j+3NgiwS805Xi88TgLhobdM7wPg50iYrhRqsbxtoMEFZW+BD5dC/J30
	 J/i6Aocmca4U2fD+lzqspimjl4RoufsQIcN7mzkz9WCUC4tLfCKD17MYy+2LXq4PBs
	 dRa3ro/uKl1SA==
Subject: Re: [PATCH] net/packet: zero-pad spkt_device and preserve sa.origlen
 across MSG_PEEK
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 21:55:55 +0000
Message-ID: <178994135589.2160803.3896990579971629208@kernel.org>
In-Reply-To: <20260919215237.3470987-1-benquike@gmail.com>
References: <20260919215237.3470987-1-benquike@gmail.com>
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

- [Medium] Hunk #1 (strscpy() -> strscpy_pad() in packet_rcv_spkt(),
  net/packet/af_packet.c:1921) is a genuine kernel-memory information…
- [Low] The commit bundles two independent defects with different bug
  classes, different code paths and different regression lineages: (a)…
- [Low] The commit message mis-states the user-visible symptom of fix #2.

--

net/packet: zero-pad spkt_device and preserve sa.origlen across MSG_PEEK

This changes packet_rcv_spkt() to use strscpy_pad() when filling
spkt->spkt_device, and moves the sll_family/sll_protocol assignments in
packet_recvmsg() from PACKET_SKB_CB(skb) into the destination
msg->msg_name buffer so that the aliased sa.origlen is not clobbered.

No Link: tags were present in the commit header.

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 50cae32ae269..15def2d16806 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1918,7 +1918,7 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
>  	 */
>  
>  	spkt->spkt_family = dev->type;
> -	strscpy(spkt->spkt_device, dev->name, sizeof(spkt->spkt_device));
> +	strscpy_pad(spkt->spkt_device, dev->name, sizeof(spkt->spkt_device));
>  	spkt->spkt_protocol = skb->protocol;

[Severity: Medium]
Is this hunk actually closing a leak of uninitialized kernel memory to
userspace rather than just padding a buffer?

spkt here is PACKET_SKB_CB(skb)->sa.pkt, i.e. it is built in place at
offset 0 of skb->cb[48], which is never zeroed and carries residue from
earlier layers (for example qdisc_skb_cb on the transmit capture path via
dev_queue_xmit_nit()).  strscpy() terminates but does not pad, so for a
short name like "eth0" the remaining 9 bytes of the 14-byte spkt_device
keep whatever was in skb->cb.

packet_recvmsg() then copies the whole struct out with no memset of the
destination on the SOCK_PACKET branch:

	if (sock->type == SOCK_PACKET) {
		__sockaddr_check_size(sizeof(struct sockaddr_pkt));
		msg->msg_namelen = sizeof(struct sockaddr_pkt);
		copy_len = msg->msg_namelen;
	}
	...
	memcpy(msg->msg_name, &PACKET_SKB_CB(skb)->sa, copy_len);

so those bytes end up in the source address returned by
recvmsg()/recvfrom().

The sibling accessor packet_getname_spkt() already does:

	memset(uaddr->sa_data, 0, sizeof(uaddr->sa_data));
	strscpy(uaddr->sa_data, dev->name, sizeof(uaddr->sa_data));

which suggests the padding is a deliberate defence in this file rather
than hygiene.  The commit message only says "so trailing bytes after
dev->name's NUL terminator in the 14-byte buffer are zeroed" - could it
name the user-visible disclosure and carry its own Fixes: tag so stable
triage does not treat the hunk as cleanup?

[Severity: Low]
Should this hunk be a separate patch?  The single tag in the header:

	Fixes: 2472d7613bd3 ("net: packet: use sockaddr_ll fields as storage for skb original length in recvmsg path")

only describes the packet_recvmsg() change.  Reading 2472d7613bd3, it
introduced the origlen/sockaddr_ll union and the recvmsg writes, and it
did not touch packet_rcv_spkt() or this strscpy() call at all.

The two changes affect different socket types (SOCK_PACKET here,
SOCK_RAW/SOCK_DGRAM in packet_recvmsg()) and have different lineages, so
as submitted neither can be backported or reverted on its own.  Would
splitting this into two patches, each with its own Fixes: tag, work
better?

> @@ -3510,15 +3510,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  	if (err)
>  		goto out_free;
>  
> -	if (sock->type != SOCK_PACKET) {
> -		struct sockaddr_ll *sll = &PACKET_SKB_CB(skb)->sa.ll;
> -
> -		/* Original length was stored in sockaddr_ll fields */
> +	if (sock->type != SOCK_PACKET)
>  		origlen = PACKET_SKB_CB(skb)->sa.origlen;
> -		sll->sll_family = AF_PACKET;
> -		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
> -			vlan_get_protocol_dgram(skb) : skb->protocol;
> -	}

[Severity: Low]
Is the symptom described in the commit message the one this hunk fixes?
The message says the clobbered value affects:

	subsequent recvmsg(MSG_PEEK | MSG_TRUNC) calls
	on the same skb

which reads as though the length reported for MSG_TRUNC is wrong.  The
return value of packet_recvmsg() does not use origlen:

	err = vnet_hdr_len + ((flags&MSG_TRUNC) ? skb->len : copied);

The only consumer in net/packet/ is inside the PACKET_SOCK_AUXDATA block:

	if (packet_sock_flag(pkt_sk(sk), PACKET_SOCK_AUXDATA)) {
		...
		aux.tp_len = origlen;

So the observable appears to be a garbage tp_len in the PACKET_AUXDATA
cmsg on a second recvmsg() of a peeked skb (the old code had written
AF_PACKET | protocol << 16 over the aliased bytes), and only when
setsockopt(PACKET_AUXDATA) is enabled.  Could the message mention that
precondition, so that someone reproducing with MSG_PEEK|MSG_TRUNC alone
does not conclude the bug is not real?

>  	sock_recv_cmsgs(msg, sk, skb);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919215237.3470987-1-benquike%40gmail.com
