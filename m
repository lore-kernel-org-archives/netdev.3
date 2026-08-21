Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666A43D5643
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303256; cv=none; b=Po56wov94TU1ILAhYiI7g2s2/EXCcL7dfxdEBLXo1Im+0muWdajv13M9zaRpMgse1PVewm8Riw8vzuoDDlvtFoOJ+Uvia0GUnAVmUKX/w2IwnWDXRF2tf2ky6VlGYNKEZEN6mjD70Noq5sWy7a0cNsLh3x7/v3sHw3WnQ6NDZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303256; c=relaxed/simple;
	bh=klROXT761z9hnQ/lx8RdyrhzAFJ0TXuwT+b74SuZ9rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiAUsQpcXX6prh4J1I1h34u0KtuL0TECO5QsBlqbohsP7DWoriqzMTtSwUaY5Rtm875p1YDdEhnCaMIareKUZDVd6Nzj22P50f8xZrivdTTPmAdZTMRhIvxT8wI00ePY67/0M88QmUhu9jG51BSKzIuM7JM/gilxj6S0LplMd0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+l+txHs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+l+txHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3241A1F00A3D;
	Fri, 21 Aug 2026 09:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787303237;
	bh=gvw7TUZTzqyvJK/GTnAHBl9nD+SCDjuoU9N3OW+oEgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L+l+txHs7hewSLhy+FZckP0iMd7taNVF5A+CTLhPoYMhrJo28XJZopAqJiTR41tJP
	 z68xieGI/W/JhZxFgt3RWraApyUHXli0FnjPR7BFhHeEXKrJrEgfo0d5hDRskR6bYm
	 pGPuplRs1EVkpFO2J750rar3a/5iHAeLtl0VtTXVot/CcNfDOhQTcvpR/WVRqTx2AU
	 Z75y46tVKfzr58BgCL3i29qk7pV+F/ejx/RJB9jyiZCLU8/oCVxW9rAyGuJ1EDV69Y
	 iZVEBp/S6pNejU5bc6LXBxwK3x+dPQWKYimDuyetlWTxqjLtj4V3GoMxbnFM9ApKbu
	 mNZo/N9PZI7cw==
Date: Fri, 21 Aug 2026 10:07:13 +0100
From: Simon Horman <horms@kernel.org>
To: Chuyf26 <Chuyf26@linux.alibaba.com>
Cc: Dmitry Kozlov <xeb@mail.ru>, netdev@vger.kernel.org,
	Zhixing Chen <running910@gmail.com>
Subject: Re: [PATCH] pptp: reject payloads shorter than the PPP protocol field
Message-ID: <20260821090713.GE265046@horms.kernel.org>
References: <20260818162143.gn-j15t2twSq3EK4tluniorb9JMdD9cS6_NWtWioiRc@z>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818162143.gn-j15t2twSq3EK4tluniorb9JMdD9cS6_NWtWioiRc@z>

On Tue, Aug 18, 2026 at 04:21:43PM +0000, Chuyf26 wrote:
> pptp_rcv_core() dereferences the first payload bytes after pulling the
> GRE header: payload[0] and payload[1] when stripping the address/control
> field, and up to payload[4] when checking for an LCP echo request in
> the out-of-order case. Only headersize + payload_len bytes of the skb
> are pulled, so a PPTP packet with a payload_len smaller than these
> accesses makes the driver read past the end of the packet data.
> 
> The path is: a GRE packet for an established PPTP channel arrives
> through the IP protocol 47 handler pptp_rcv(), which validates the GRE
> flags, looks the channel up by call id and source address and queues
> the skb to the pppox socket, where pptp_rcv_core() runs for sockets in
> PPPOX_CONNECTED state. payload_len is taken from the GRE header without
> any lower bound, so an attacker who can inject packets carrying the
> channel's call id and peer address can make pskb_may_pull() pull as
> little as the GRE header itself; payload then points at the end of the
> pulled data and the dereferences above read up to five bytes past the
> packet. The sequence number is likewise attacker controlled, so both
> the out-of-order LCP echo check and the in-order address/control
> stripping are reachable.
> 
> The read lands inside the skb data allocation (tailroom of the same
> slab object), so KASAN does not report it and the access does not
> fault, but the bytes read are undefined and steer the accept/drop
> decision: garbage may let a short malformed frame through to
> ppp_input(), and the LCP echo check is meaningless for payloads
> shorter than a PPP protocol field.
> 
> A PPTP payload is a PPP frame and therefore always carries at least
> the two-byte PPP protocol field, and the LCP echo check needs five
> bytes to be meaningful. Drop packets shorter than two bytes and only
> perform the LCP echo check when at least five bytes are present.
> Valid packets are unaffected.
> 
> Fixes: 00959ade36ac ("PPTP: PPP over IPv4 (Point-to-Point Tunneling Protocol)")
> Reported-by: Abaci <abaci@linux.alibaba.com>
> Assisted-by: abaci:qwen3.8-max
> Signed-off-by: Chuyf26 <Chuyf26@linux.alibaba.com>
> ---
>  drivers/net/ppp/pptp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
> index 3a10303eb756..ce1cd72baadf 100644
> --- a/drivers/net/ppp/pptp.c
> +++ b/drivers/net/ppp/pptp.c
> @@ -317,10 +317,18 @@ static int pptp_rcv_core(struct sock *sk, struct sk_buff *skb)
>  	if (!pskb_may_pull(skb, headersize + payload_len))
>  		goto drop;
>  
> +	/* The payload is a PPP frame, so it always carries at least the
> +	 * two-byte PPP protocol field. The payload bytes are dereferenced
> +	 * below, reject packets too short to hold them.
> +	 */
> +	if (payload_len < 2)
> +		goto drop;
> +
>  	payload = skb->data + headersize;
>  	/* check for expected sequence number */
>  	if (seq < opt->seq_recv + 1 || WRAPPED(opt->seq_recv, seq)) {
> -		if ((payload[0] == PPP_ALLSTATIONS) && (payload[1] == PPP_UI) &&
> +		if (payload_len >= 5 &&
> +				(payload[0] == PPP_ALLSTATIONS) && (payload[1] == PPP_UI) &&
>  				(PPP_PROTOCOL(payload) == PPP_LCP) &&
>  				((payload[4] == PPP_LCP_ECHOREQ) || (payload[4] == PPP_LCP_ECHOREP)))
>  			goto allow_packet;

Hi,

Thanks for your patch.
Some feedback from my side.

* The CC list for patch is incomplete.
  An accurate CC list can be generated with assistance from:
  get_maintainers.pl this.patch

* Please target Networking patches at either net, for fixes (this case),
  or net-next, for other patches.

  Subject: [PATCH net] ...

* This patch seems similar to:

  - [PATCH net-next] pptp: validate payload length before parsing PPP fields
    https://lore.kernel.org/netdev/20260813082247.31499-1-running910@gmail.com/

  And the same concern I raised in relation to that patch seems present here.
  I'll copy that concern here for your consideration (although in this
  case there is only one new guard).

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

