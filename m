Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746301A9FB7;
	Wed, 23 Sep 2026 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188243; cv=none; b=ZFXa2mlU0s8la6LeF+OebzEib/znbqZ6If2yf7a+Nqcc0Wn1k55dbqAhdTnwW65jmFjYkjflqnJHM/GbUbwuMhrU+hGQIZjQ16BMlMD8431semfS5CcPXBLdpG7jehol/tMbXbbnDj6P80A6iAzpnMXcagflY9a0xbDgwzViOIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188243; c=relaxed/simple;
	bh=U7FwIwVCVcdGMgfGj5+JKllpzgJtLEmRpzH7cP3S/qY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LLtMcjzDWikNCKTkbbauqckgcn2ImBDsDB4iWKRmxeff4q/Uj7JtdQSYCZzcqggDlt+QtJPO1TrO74my49F9950TZ53fLIu0knHWuU5YMeo371akxuxDEchWReDZ+mlTKSznEg5ZqKDLmcIwmInOyvvzwPHXfCzTm1dO18f/X40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvZVxpZ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvZVxpZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251FE1F000FF;
	Wed, 23 Sep 2026 18:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188236;
	bh=3rRcavay/uZqKxxaOQ8jVX7R9A/LP6u2sfbUr8jvwqQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IvZVxpZ77OOYiqLrLdt/5qZAh9ajr0XNN7D+BsX5w6EvYtJfpfvnSJ+VkudNl2n6L
	 bwQSBZ8TLf7KxpupK1qhHr4i4y8+Cc1mFvx+JTATN8XuOxBCBs8H1uQCjar9urSnXg
	 l3hpzi3+D8Q9Svqo0n32HqOC1n0oHBRVZ3Ch2Dn4jF57fz+i8MjgJWdcOGLjiitw/4
	 uefA4rEv24/Y32flJDAZV3GDsVB4suiWUHgwQ9p6oQeHDs+lz/l+XU1wasS+2DdMza
	 wVEc0AtIM30dZb36u4olSNsFa4CcEiKrhDhpoYLi8/lHqZctMay13ux6ib8Y4DoQjE
	 dPIzQs8MEL0mA==
Subject: Re: [PATCH] ppp: pptp: fix out-of-bounds read on short payload_len in
 pptp_rcv_core()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 18:30:35 +0000
Message-ID: <179018823567.2160803.3874112471826535147@kernel.org>
In-Reply-To: <20260919212856.3241262-1-benquike@gmail.com>
References: <20260919212856.3241262-1-benquike@gmail.com>
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

- [Medium] New unconditional `if (payload_len < 2) goto drop;` in
  pptp_rcv_core() (drivers/net/ppp/pptp.c:313) narrows the set of PPP…

--

ppp: pptp: fix out-of-bounds read on short payload_len in pptp_rcv_core()

The patch adds a minimum length requirement on the GRE payload_len field in
pptp_rcv_core() and gates the LCP Echo detection on payload_len >= 5, so the
PPP header bytes inspected after pskb_may_pull() are known to be present.

> diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
> index a797a0606f6b..2f979294490d 100644
> --- a/drivers/net/ppp/pptp.c
> +++ b/drivers/net/ppp/pptp.c
> @@ -310,6 +310,8 @@ static int pptp_rcv_core(struct sock *sk, struct sk_buff *skb)
>  	payload_len = ntohs(header->payload_len);
>  	seq         = ntohl(header->seq);
>  
> +	if (payload_len < 2)
> +		goto drop;

[Severity: Medium]
Does this unconditional drop narrow the set of frames the PPTP channel will
deliver to ppp_input()?

A one-octet payload holding a Protocol-Field-Compressed protocol value is a
valid channel frame for the PPP core, which only requires a single byte:

drivers/net/ppp/ppp_generic.c:ppp_decompress_proto() {
	/* At least one byte should be present (if protocol is compressed) */
	if (!pskb_may_pull(skb, 1))
		return false;

	__ppp_decompress_proto(skb);

	/* Protocol field should occupy 2 bytes when not compressed */
	return pskb_may_pull(skb, 2);
}

The transmit side of this same driver produces that format in pptp_xmit():

	/* compress protocol field */
	if ((opt->ppp_flags & SC_COMP_PROT) && data[0] == 0 && !islcp)
		skb_pull(skb, 1);

	/* Put in the address/control bytes if necessary */
	if ((opt->ppp_flags & SC_COMP_AC) == 0 || islcp) {

So with payload_len == 1 a protocol-only frame used to reach ppp_input() and
is now dropped in pptp_rcv_core().

The only in-window access that needs two bytes is the address/control probe
further down:

		if (payload[0] == PPP_ALLSTATIONS && payload[1] == PPP_UI) {
			/* chop off address/control */
			if (skb->len < 3)
				goto drop;
			skb_pull(skb, 2);
		}

Would gating that test with payload_len >= 2, in the same style already used
for the payload_len >= 5 LCP test below, close the read without rejecting
one-byte frames?

>  	/* check for incomplete packet (length smaller than expected) */
>  	if (!pskb_may_pull(skb, headersize + payload_len))
>  		goto drop;
> @@ -317,9 +319,11 @@ static int pptp_rcv_core(struct sock *sk, struct sk_buff *skb)
>  	payload = skb->data + headersize;
>  	/* check for expected sequence number */
>  	if (seq < opt->seq_recv + 1 || WRAPPED(opt->seq_recv, seq)) {
> -		if ((payload[0] == PPP_ALLSTATIONS) && (payload[1] == PPP_UI) &&
> -				(PPP_PROTOCOL(payload) == PPP_LCP) &&
> -				((payload[4] == PPP_LCP_ECHOREQ) || (payload[4] == PPP_LCP_ECHOREP)))
> +		if (payload_len >= 5 &&
> +		    payload[0] == PPP_ALLSTATIONS && payload[1] == PPP_UI &&
> +		    PPP_PROTOCOL(payload) == PPP_LCP &&
> +		    (payload[4] == PPP_LCP_ECHOREQ ||
> +		     payload[4] == PPP_LCP_ECHOREP))
>  			goto allow_packet;

[Severity: Medium]
Related question on the same change: payload_len is a peer-supplied GRE
header field that the rest of pptp_rcv_core() treats as advisory.  It is only
fed to pskb_may_pull(), the skb is never trimmed to headersize + payload_len,
and the later checks use skb->len instead.

Using it as the gate here means a peer that under-reports payload_len has its
out-of-window LCP Echo keepalives dropped rather than recognised, where the
previous code looked at the bytes actually present in the skb.

Would checking skb->len - headersize (the bytes pskb_may_pull() actually
guaranteed) be a better gate than the header field?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919212856.3241262-1-benquike%40gmail.com
