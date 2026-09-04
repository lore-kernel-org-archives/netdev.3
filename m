Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3ED44D686
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517717; cv=none; b=Z572oDmIMkjbphyiWXbAc0drUbx/Z11XLJy3DRPeL6XuRSH4vCPUx56n5BlObyrLrrwsexEP0EuiFqyXpaCFO69QCufE4K+ndSDCPswSFMQEmwQu1pTgsn0NTzyOKztBufJiy8yrAOFIDB0Aw+WtGb6P2wuV4lihEERlYQo/tqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517717; c=relaxed/simple;
	bh=PRwmu9PBMUFn3hPcPN3bo01Rw2hTAL3CaM9BLWgw+3k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GlZEUMYDRbD6n4tryX1f+iDAU0swvpDeo2i/tJhqVw1T14zks3GxuHnP1YRL8yTj+9n3VVpTlgo3UBZtjUreGjQLPkKYcmA6ZW3OZzuFuYB/eDKRYLRTEoq/VOaQPi1QX3sJP7pWgtlHutmtRrnQZjMlCvhvmsfnzPwLY75K5Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz2AV9Qo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz2AV9Qo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6CE1F00A3D;
	Fri,  4 Sep 2026 10:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517715;
	bh=XY44sVjA6ONg9+n2JtIe9eR7BsDClJDKoNjnFIp2AhU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Pz2AV9Qo7dJoehYqvPzaCII/qzGIVCDE8hM/vj2TlVtEJEOgyCipGSgLX6pbcCa4L
	 PkA32/tnaYD0teWUVysGYwFU9ma38qXk3WsbrJlHwTzFDFetwcl4DkhdhidJTpSaxA
	 +SvuPwir+9JFU4oFptyH9h4bEOrfczKzcKu8oeDMrQJxGj/4kAgtCkuk4ugIxZyTll
	 72JIBN7NCzKMqG57aA0meJp+hcl4ATPOucdl845aaM+UhivLLQMs55qxUVUyC+dz2k
	 HHpkUqQnUmuX4rmcAsIBFa0espIzrjkEpYoXOUm32h0NeP9Z2obUk/wbrNN0hsxenH
	 gbr8wwvcn0mUg==
Subject: Re: [PATCH net-next v2] pptp: validate available payload before
 parsing PPP fields
From: netdev-bot+sashiko@kernel.org
To: running910@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 Chuyf26@linux.alibaba.com, netdev@vger.kernel.org
Date: Fri, 04 Sep 2026 10:28:34 +0000
Message-ID: <178851771440.4131868.15230379075689542594@kernel.org>
In-Reply-To: <20260902042827.87534-1-running910@gmail.com>
References: <20260902042827.87534-1-running910@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

- [Medium] Missing impact statement and missing `Fixes:` tag / target-
  tree annotation for what is a remotely triggerable read past the…

Pre-existing issues:
- [Low] Reported concern (assessed as NOT a defect): the new
  `payload_avail = skb->len - headersize` in pptp_rcv_core() bounds the…

--

pptp: validate available payload before parsing PPP fields

This bounds the two PPP field reads in pptp_rcv_core() by the number of
payload bytes actually present in the skb, and pulls those bytes into the
linear area before dereferencing them. The address/control stripping check
now reads skb->data after the header pull instead of the stale payload
pointer.

v1: https://lore.kernel.org/netdev/20260813082247.31499-1-running910@gmail.com/T/

> diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
> index a797a0606f6b4..4fb94a455c574 100644
> --- a/drivers/net/ppp/pptp.c
> +++ b/drivers/net/ppp/pptp.c

[ ... ]

> @@ -314,23 +315,34 @@ static int pptp_rcv_core(struct sock *sk, struct sk_buff *skb)
>  	if (!pskb_may_pull(skb, headersize + payload_len))
>  		goto drop;
>  
> -	payload = skb->data + headersize;
> +	payload_avail = skb->len - headersize;

[Severity: Medium]
Could the changelog say what actually goes wrong without this change, and
carry a Fixes: tag?

Before this patch pptp_rcv_core() only validated headersize + payload_len
bytes, where payload_len comes straight off the wire:

	payload_len = ntohs(header->payload_len);
	...
	if (!pskb_may_pull(skb, headersize + payload_len))
		goto drop;

	payload = skb->data + headersize;

and then dereferenced payload[0], payload[1], PPP_PROTOCOL(payload)
(bytes 2 and 3) and payload[4]. With a GRE-SEQ packet whose payload_len is
0..4, aren't those reads outside the validated range, i.e. skb tailroom or,
for a non-linear skb, bytes that are not payload?

The path is remote for a connected socket:

pptp_rcv() -> sk_receive_skb() -> pptp_rcv_core()

and pptp_rcv() only guarantees the 12-byte GRE header is linear.

Those bytes also steered control flow: if they happened to read as
FF 03 C0 21 09/0A, the out-of-sequence rejection

	if (seq < opt->seq_recv + 1 || WRAPPED(opt->seq_recv, seq))

was skipped via goto allow_packet, and they also decided whether two bytes
were chopped off the frame handed to ppp_input().

git blame points both reads at the original driver commit:

00959ade36ac drivers/net/pptp.c (Dmitry Kozlov 2010-08-21 317) payload = skb->data + headersize;
00959ade36ac drivers/net/pptp.c (Dmitry Kozlov 2010-08-21 320) if ((payload[0] == PPP_ALLSTATIONS) && (payload[1] == PPP_UI) &&

so would this be appropriate?

	Fixes: 00959ade36ac ("PPTP: PPP over IPv4 (Point-to-Point Tunneling Protocol)")

A target tree in the subject prefix (net or net-next) would help too, since
without a Fixes: tag and an impact description this is unlikely to be picked
up for stable.

[Severity: Low]
This isn't a bug introduced by this patch, but a note on payload_avail
versus payload_len for anyone reading it later.

payload_avail is derived from skb->len rather than from the GRE-advertised
payload_len that pptp_xmit() writes:

	hdr->payload_len = htons(len);

so the LCP Echo check can look at bytes beyond the advertised payload. That
asymmetry is pre-existing and unchanged here: the receive path never trims
the skb to headersize + payload_len, and after

		skb_pull(skb, headersize);

the whole remainder is passed to ppp_input(), both before and after this
patch. Since pskb_may_pull(skb, headersize + payload_len) already
guarantees payload_avail >= payload_len, the new guards never widen the
reads past the skb, and a peer could simply advertise payload_len = 5 to
reach the same LCP Echo exemption. So this looks like a wording preference
only, matching what the changelog already states.

>  	/* check for expected sequence number */
>  	if (seq < opt->seq_recv + 1 || WRAPPED(opt->seq_recv, seq)) {
> -		if ((payload[0] == PPP_ALLSTATIONS) && (payload[1] == PPP_UI) &&
> -				(PPP_PROTOCOL(payload) == PPP_LCP) &&
> -				((payload[4] == PPP_LCP_ECHOREQ) || (payload[4] == PPP_LCP_ECHOREP)))
> -			goto allow_packet;
> +		if (payload_avail >= PPP_HDRLEN + 1) {
> +			if (!pskb_may_pull(skb, headersize + PPP_HDRLEN + 1))
> +				goto drop;
> +
> +			payload = skb->data + headersize;
> +			if (payload[0] == PPP_ALLSTATIONS && payload[1] == PPP_UI &&
> +			    PPP_PROTOCOL(payload) == PPP_LCP &&
> +			    (payload[4] == PPP_LCP_ECHOREQ || payload[4] == PPP_LCP_ECHOREP))
> +				goto allow_packet;
> +		}
>  	} else {
>  		opt->seq_recv = seq;
>  allow_packet:
>  		skb_pull(skb, headersize);
>  
> -		if (payload[0] == PPP_ALLSTATIONS && payload[1] == PPP_UI) {
> -			/* chop off address/control */
> -			if (skb->len < 3)
> +		if (payload_avail >= 2) {
> +			if (!pskb_may_pull(skb, 2))
>  				goto drop;
> -			skb_pull(skb, 2);
> +
> +			if (skb->data[0] == PPP_ALLSTATIONS && skb->data[1] == PPP_UI) {
> +				/* chop off address/control */
> +				if (skb->len < 3)
> +					goto drop;
> +				skb_pull(skb, 2);
> +			}
>  		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902042827.87534-1-running910%40gmail.com
