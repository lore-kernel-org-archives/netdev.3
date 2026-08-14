Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341C426656D
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729337; cv=none; b=akZjF/McFtyPze1HoXhYmXEcSI/JfUnNPI0xN+G2DngsJy7coaXrBAMXFhjc6Rk82FGfMQ38q4lUotJsFAZy5WD8Z/G8Y8h1wrGihs8OVmJRpm0KQXrDcktHSmcqJmGzhedKW+IoiEIhJq7zWY1YYrrN7ZRZwZhS8mfauK2hYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729337; c=relaxed/simple;
	bh=0recGyKPcuINt4dZlGyamNkN3KwKLO8qGHWdMDcBpXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbdAJcvyKt9e/DKQpgPfDpYbrg5ERKz3wDAaBrVbaJBAwu3+oYKy84x7Yap1mBCsLE982/qg+AUBLfl/E+nY/bA4XtXxFZYzcS/L9FO2jvgLb/Qxi71JIBig3zNtWVw/nk3WIY+Swl6Hos+LGFzxuGxhSMIxk60rlADicoi4dJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNuypRkF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNuypRkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB521F000E9;
	Fri, 14 Aug 2026 17:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786729335;
	bh=Fwcg1mBolrG61kZ40k2lT9ahffvqO65BxOMps4O2+iE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NNuypRkF2IVcjd2MkcjN33D7CY30xS5x/OOt3Wr99oibGI59V6e+OwEsrz24VedPC
	 5hHLTUDnO9dwL1kBwWAm9pwft2kP6AQQGMXkgpjZRf65w1Yz1vbzP7lRIRVWMNQOCD
	 tDVCmFrSg+ZkX0U63q6a3xf97ZRE5SiYouTggJr2ziAlr/IL9tk+HqWb8zriJFQvWR
	 M0fU7VN1vUuVbIcPF7QmNQu8ggRZgXWucLMRjXB1NjAfekdQpPgqe+3laSKkxSZPFY
	 hw1IrVwN9HbLmC6c6zm+Pxm80cduSuccgM1VKyys0hXRtMOM2QGnEgbrMVYNkhJJjo
	 u2AcwzON84i0g==
Date: Fri, 14 Aug 2026 18:42:12 +0100
From: Simon Horman <horms@kernel.org>
To: Zhixing Chen <running910@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] pptp: validate payload length before parsing
 PPP fields
Message-ID: <20260814174212.GS265046@horms.kernel.org>
References: <20260813082247.31499-1-running910@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813082247.31499-1-running910@gmail.com>

On Thu, Aug 13, 2026 at 04:22:47PM +0800, Zhixing Chen wrote:
> pptp_rcv_core() pulls the PPTP GRE header together with the payload length
> advertised by the header, then looks into the PPP payload for two special
> cases: allowing old-sequence LCP Echo packets and stripping the PPP
> address/control fields.
> 
> Both checks read fixed PPP fields from the payload. Make sure the
> advertised payload length covers those fields before reading them, so
> malformed short payloads are rejected before their PPP contents are
> evaluated.
> 
> This keeps the receive path within the declared PPTP payload boundary.
> 
> Signed-off-by: Zhixing Chen <running910@gmail.com>
> ---
> 
> While testing PPTP stability and reviewing the PPTP driver code, I noticed
> that the receive path can reach the old-sequence LCP Echo check and the
> address/control field handling with an advertised payload length shorter
> than the PPP fields being inspected.
> 
> I exercised this path with malformed short PPTP GRE packets and confirmed
> that such packets can reach both checks. The test packets did not trigger a
> KASAN report in my setup, but my understanding is that the parser should
> not inspect bytes outside the declared PPTP payload when deciding how to
> handle PPP fields.
> 
> This is intended as a small robustness improvement for malformed PPTP GRE
> packets.
> 
> ---
>  drivers/net/ppp/pptp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
> index a797a0606f6b..708d8fb3a900 100644
> --- a/drivers/net/ppp/pptp.c
> +++ b/drivers/net/ppp/pptp.c
> @@ -317,16 +317,18 @@ static int pptp_rcv_core(struct sock *sk, struct sk_buff *skb)
>  	payload = skb->data + headersize;
>  	/* check for expected sequence number */
>  	if (seq < opt->seq_recv + 1 || WRAPPED(opt->seq_recv, seq)) {
> -		if ((payload[0] == PPP_ALLSTATIONS) && (payload[1] == PPP_UI) &&
> -				(PPP_PROTOCOL(payload) == PPP_LCP) &&
> -				((payload[4] == PPP_LCP_ECHOREQ) || (payload[4] == PPP_LCP_ECHOREP)))
> +		if (payload_len >= PPP_HDRLEN + 1 &&
> +		    payload[0] == PPP_ALLSTATIONS && payload[1] == PPP_UI &&
> +		    PPP_PROTOCOL(payload) == PPP_LCP &&
> +		    (payload[4] == PPP_LCP_ECHOREQ || payload[4] == PPP_LCP_ECHOREP))
>  			goto allow_packet;
>  	} else {
>  		opt->seq_recv = seq;
>  allow_packet:
>  		skb_pull(skb, headersize);
>  
> -		if (payload[0] == PPP_ALLSTATIONS && payload[1] == PPP_UI) {
> +		if (payload_len >= 2 &&
> +		    payload[0] == PPP_ALLSTATIONS && payload[1] == PPP_UI) {
>  			/* chop off address/control */
>  			if (skb->len < 3)
>  				goto drop;

Hi,

There is an AI-generated review of your patch available at
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260813082247.31499-1-running910%40gmail.com

  It suggests adding a Fixes tag, and implicitly targeting net.
  I feel that is not correct as you are positioning this as a robustness
  improvement.

  However, the following portion of the review does stand out to me
  and I'd value your feedback on it:

  Both new guards bound the reads by the peer-advertised payload_len rather
  than by the bytes actually present (skb->len - headersize), which is what
  pskb_may_pull() guaranteed and what the pre-existing check just below
  already uses.  Is it intentional that one skb_pull(skb, 2) is now gated by
  two different length authorities?

  Since the skb is never trimmed to headersize + payload_len, payload_len is
  only a lower bound, so a peer that under-reports it still passes
  pskb_may_pull() and is still delivered.  For an in-sequence frame whose
  real PPP payload starts with 0xff 0x03 but whose header says
  payload_len < 2, the address/control octets are no longer stripped, and
  the frame continues down:

  drivers/net/ppp/ppp_generic.c:__ppp_decompress_proto() {
	if (ppp_skb_is_compressed_proto(skb))
		*(u8 *)skb_push(skb, 1) = 0x00;
  }

  0xff has the low bit set, so a 0x00 is pushed and ppp_input() then sees:

	proto = PPP_PROTO(skb);
	if (!ppp || proto >= 0xc000 || proto == PPP_CCPFRAG) {

  with proto == 0x00ff instead of the real protocol, so the frame never
  reaches its intended handler.  Similarly, out-of-sequence LCP Echo
  keepalives from such a peer are now dropped by the PPP_HDRLEN + 1 guard
  instead of allowed, which can tear a tunnel down.  Would using
  skb->len - headersize for both comparisons avoid this?
