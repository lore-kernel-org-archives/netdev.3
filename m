Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4DC5A0AB1
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907750; cv=none; b=LXBk/TuGMlShG3vkaqjT7gOQPen06VtJWPmDhbiFZdNLJv54YJeJd6o22WoGG6tsvyfklC4YQzDu7qgNX4vqR2TaaTTSdFAiKu6msFxpf5hvK5wGLEespJx2RvHVlAf9/dySu9E4KKwpYMeheK5yb5ZlV7iQddqt/t2cOkUKLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907750; c=relaxed/simple;
	bh=qYsNO/+TmUmp3+Ik0iy0jtg18VD9qGv/wetLorl+rCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEBEmLiJUXFqraPE9zv3kDA2hIbvJbRQlEz/aRYtgJQKLQN9Ft3vrZbJ6oeiNcgWtXDg/Bq2IF1+n0Kz/pwthNjcvZe1GVDtGM1kAy99VvZtNqgu74qN6SxOWhBHXg5MfNhSyX4VxcYfjnL4k2Jy3T69wILB2lU5sd8NxiW53I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4pxmOyl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4pxmOyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BF21F00ADE;
	Tue,  8 Sep 2026 22:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907743;
	bh=F86Gqnnwz2ciidQz9vIXkzObIJ/8A5v3n6RJnUUYkyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V4pxmOylSFiSNAdrjofkmbEihOaAQBqOOODQ1nhxjw8zWsdsrgSCjilan0xwLQnnM
	 oTI4yAw8w9ZFPN5fplOOluUrm1IrhxlvE7dyMsDYpcL+6NPP7xdNvyWhQ1Wf90U3l4
	 eI16rE1e9oEkPlL5uUpmnknerTTVW/Z8mlIlZFaNKZlZhH+9teI2vMT4Odx4pYGw6p
	 BxVGQDC9kae8OgsLFzXlFlR5MJgVGTZmvDbVz6dGTTSn/hzFt0UjM81z0UG+5pDyxf
	 QbSP3/aLjsiaSQrCzs7lDKNVEYyz7meukHCXSU/Emme+YWX8xwjZ0HuW0SGzC4r3FI
	 0dh63PYeO5ETg==
From: Jakub Kicinski <kuba@kernel.org>
To: steffen.klassert@secunet.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	netdev@vger.kernel.org
Subject: Re: [PATCH 12/12] net: xfrm: reject unrepresentable espintcp transport headers
Date: Tue,  8 Sep 2026 15:49:02 -0700
Message-ID: <20260908224902.1591378-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907093020.2228346-13-steffen.klassert@secunet.com>
References: <20260907093020.2228346-13-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: xfrm: reject unrepresentable espintcp transport headers

handle_esp() in net/xfrm/espintcp.c switches from the plain transport
header reset to skb_reset_transport_header_careful(), and drops the skb
with LINUX_MIB_XFRMINERROR when the offset does not fit in
skb->transport_header.

> diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
> index 674aedc5af5a2..3e72b9f067b9b 100644
> --- a/net/xfrm/espintcp.c
> +++ b/net/xfrm/espintcp.c
> @@ -30,7 +30,11 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
>  {
>  	struct tcp_skb_cb *tcp_cb = (struct tcp_skb_cb *)skb->cb;
>  
> -	skb_reset_transport_header(skb);
> +	if (!skb_reset_transport_header_careful(skb)) {
> +		XFRM_INC_STATS(sock_net(sk), LINUX_MIB_XFRMINERROR);
> +		kfree_skb(skb);
> +		return;
> +	}

[Severity: High]
Is this gate placed early enough to cover the pulls that the ESP input
path performs on the same skb afterwards?

skb_reset_transport_header_careful() in include/linux/skbuff.h only
rejects offsets that are already unrepresentable:

	long offset = skb->data - skb->head;

	if (unlikely(offset != (typeof(skb->transport_header))offset))
		return false;

	if (unlikely(offset == (typeof(skb->transport_header))~0U))
		return false;

so any offset up to 65534 is accepted here with no margin left.

handle_esp() then calls xfrm4_rcv_encap()/xfrm6_rcv_encap(), and the
chain xfrm_input() -> esp_input() -> esp_input_done2() pulls the ESP
header and IV off the very same skb and resets the transport header with
the unhardened helpers, in net/ipv4/esp4.c:

	skb_pull_rcsum(skb, hlen);
	if (x->props.mode == XFRM_MODE_TUNNEL ||
	    x->props.mode == XFRM_MODE_IPTFS)
		skb_reset_transport_header(skb);
	else
		skb_set_transport_header(skb, -ihl);

with hlen = sizeof(struct ip_esp_hdr) + crypto_aead_ivsize(aead).
esp6_input_done2() in net/ipv6/esp6.c has the same shape for the
AF_INET6 branch of handle_esp().

For an skb whose head offset lands in the window [65536 - hlen, 65534],
the new check passes but the offset after skb_pull_rcsum() no longer
fits, so doesn't the truncation the changelog wants to eliminate simply
move downstream, now on a partially decrypted packet instead of a clean
drop?

Can such near-limit offsets be reached in practice?  espintcp_rcv() does:

	/* remove header, leave non-ESP marker/SPI */
	if (!pskb_pull(skb, rxm->offset + 2)) {

which makes skb->data - skb->head equal to the initial payload offset
plus rxm->offset + 2, and rxm->offset is bounded only by the size of one
coalesced TCP receive-queue skb.  If offsets at or above 65535 are
reachable (which is the premise of this patch), offsets a few bytes below
65536 look equally reachable, and the peer selects them at byte
granularity through the 16-bit espintcp length prefix.

For ESP transport mode there also seems to be a second-order effect.  With
k = (offset + hlen) - 65536 and k >= ihl, esp_input_done2() leaves
transport_header at (k - ihl), i.e. wrapped, and
xfrm4_transport_input()/xfrm6_transport_input() in net/xfrm/xfrm_input.c
consume it directly:

	int ihl = skb->data - skb_transport_header(skb);

	if (skb->transport_header != skb->network_header) {
		memmove(skb_transport_header(skb),
			skb_network_header(skb), ihl);
		...
	skb_reset_transport_header(skb);

Can ihl here become roughly 64 KiB and turn that memmove() into a copy
that runs past the packet data into the trailing skb_shared_info?  With
AES-CBC (ivsize 16, hlen 24) k can be 20..23, which is >= a 20-byte ihl.

Would it make sense either to give the espintcp check a margin covering
the largest downstream ESP header plus IV pull (or avoid the large linear
pull in espintcp_rcv() altogether), or to convert the esp4/esp6 and
xfrm_input transport-mode reset sites to the careful helpers as well?

Conversely, if offsets in that window cannot occur, what makes the check
added here reachable at all?
