Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200084;
	b=ydf3gVE8VYPP5mXUCwkFQ3bC9ypBO0x/a4ECwuXlgyoE6GnG/mX99LkbwVPl8dwhB2zo
	 x1seJ3WcU+UCbzlboEuVrwWTdcHeisLLu0TYLLMQFQwg8XeNY/NFN0uDyMXz0gVxiGG9B
	 kUe1OGMeUA1FFk6UzrURiPuf7KUkpGwCEV0K6VXLdZY/XZQyZRbIeX1I+svh0nbkCLZT8
	 V2klcnopbxxrujIZWpSlKCduK2Bp3RnEdEPRqjIOra9cgNBzOe/x7vh0hWLXf76eNo8l2
	 NM6bR0GM3FzjwWPOEIX4Q212vquMmfGStZGgP4I4b9eJRCVvzYllPDhITwHla0znMZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200084;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:Date:
	 From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=44l5EMiVsY/tDoRrmll9AZ7FjK4IkjzJb1T2mR7SHCA=;
	b=Mw1pcBxp7Yh1KTplU0y8AQZZHiNQQvyYDze2MnR3y7XKIkpypAVFR+boGMy39Od9nF0I
	 rjDmMkPET+K/NL36Ws4HOcU3O7dkVHDxxiu3sOt277zV/yijFMkYj4jdB4n+QVlE7HGon
	 ctsWk2brLedh2HNUxD/U98bxkxp9n6QQR/mySFiMy0CFHPu8uXWHG2yQaFdWBSINf2Nky
	 AsNnFXVCloBXT06X1TCU09d1RZCDNLY5uPdrnA1vaW+R1gpsMtWVo7ebQBlXyqwF8+y3Z
	 /eKsZvU8adrctZog7o+igt5vNQyWVH75+hoXuH5BbRsTQd2Z0gIjFpG/lipfLZPOOEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=9EDRZRtN;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b="O/MbzMa0";
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C84606A31E;
	Wed, 28 Oct 2026 15:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37C84606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=9EDRZRtN;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=O/MbzMa0
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69SF7AJl016772;
	Wed, 28 Oct 2026 16:07:16 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 8C3A8122954;
	Wed, 28 Oct 2026 16:07:04 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1793200025; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44l5EMiVsY/tDoRrmll9AZ7FjK4IkjzJb1T2mR7SHCA=;
	b=9EDRZRtNWbjr9yybTkw0MUZLg3twCV3daEIHWNRj+XkqvA0vLw5JWQXyVAaPuzTRooKF8P
	JXKbfQ30TkaLGNBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1793200025; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44l5EMiVsY/tDoRrmll9AZ7FjK4IkjzJb1T2mR7SHCA=;
	b=O/MbzMa0a1lNebygFgsWSkocmAmxjCD8C32WY8Oqp4+exAW8yHATcbbNk4ed5PFfMngerA
	5G3NWUBK+uxOUDa1fGU3mvQMvSGDsJSqSjl+//SJxa/QNir605AuLKh/5QTmmvkW1BNPC4
	PVzOQzMf/gHWHtTDQp9UrqV8kQdo+j7tpwG5vdqesoOe9RRJ87wEd2yml2wsIKAHzOG63i
	NfTx87uKMeY5ANZ+q3Sz+Pv44uNebNO9ge/C57B3NHkdEc5L/UMulEbF9ZRJG9ROUlHjEK
	rXvdORXAdYdtOF+ZJ4so7F40cEa21+VAw8OIbpkg+xuhvr5olrhawcWYm3/vmQ==
Date: Wed, 28 Oct 2026 16:07:04 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Lebrun <david.lebrun@uclouvain.be>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu
 <herbert@gondor.apana.org.au>,
        David Ahern <dsahern@kernel.org>,
        Hazley
 Samsudin <hazleycryilis@gmail.com>,
        Stefano Salsano
 <stefano.salsano@uniroma2.it>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] seg6: fix transport header for inner IPv4 with IP
 options
Message-Id: <20261028160704.5dd02501bad62a6dfd46139f@uniroma2.it>
In-Reply-To: <944e6740-d91d-4251-be31-aab730a49d43@redhat.com>
References: <20261020023336.34-1-andrea.mayer@uniroma2.it>
	<atgWEBZ5J9LQyULx@fedora>
	<944e6740-d91d-4251-be31-aab730a49d43@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Wed, 21 Oct 2026 12:40:30 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 10/21/26 03:32, Hangbin Liu wrote:
> > On Tue, Oct 20, 2026 at 04:33:36AM +0200, Andrea Mayer wrote:
> >> The End.DT4, End.DT46 (its IPv4 path only) and End.DX4 behaviors set the
> >> transport header of the decapsulated IPv4 packet at a fixed 20 bytes, the
> >> size of an IPv4 header without options. They do not validate the header
> >> length either. With options, the transport header points at the first
> >> option byte. The effects include:
> >> - ping -R sends an echo request with a 60-byte IPv4 header to a local
> >>    address through an End.DT4 or an End.DX4 SID. Since icmp_rcv()
> >>    computes the ICMP checksum from the first option byte, the request
> >>    fails the check and is counted in IcmpInCsumErrors.
> >> - A UDP datagram can reach a port that an iptables rule drops. The rule
> >>    checks the UDP header after the full IPv4 header, while the socket
> >>    lookup reads it at the fixed 20-byte offset.
> >> - With an inbound AH state, ah_input() reads the AH header at the fixed
> >>    20-byte offset, but copies the IPv4 header over it with the length in
> >>    the IHL field. A packet shorter than that length can make ah_input()
> >>    write past the end of the data, into skb_shared_info when the skb has
> >>    no tailroom.
> >>
> >> Validate the inner IPv4 header length with the new helper
> >> seg6_validate_iphdr_len() and set the transport header at that length. A
> >> packet that is not IPv4, whose header length field is below 5, or whose
> >> header is truncated, is dropped with a drop reason. The fix is limited to
> >> the header length, which the transport header relies on. Other checks done
> >> on IPv4 input, such as the header checksum, the total length and the IP
> >> options, are not addressed here.
> >>
> >> Found by code inspection while reviewing commit 44930446dde4 ("ipv6: seg6:
> >> clear IPv4 control block on IPIP decapsulation"), as a pre-existing issue
> >> that Sashiko also reported on v2 of that patch. Without this patch, a
> >> bpftrace probe on ah_input() shows the reporter's reproducer packet
> >> written into skb_shared_info. With it, that packet is dropped before
> >> ah_input(), ping -R no longer fails the ICMP checksum, the UDP datagram
> >> reaches its real port, and the SRv6 selftests still pass. These effects
> >> reproduce on an unmodified kernel, without error injection.
> >>
> >> Fixes: 891ef8dd2a8d ("ipv6: sr: implement additional seg6local actions")
> >> Fixes: 664d6f86868b ("seg6: add support for the SRv6 End.DT4 behavior")
> >> Reported-by: Hazley Samsudin <hazleycryilis@gmail.com>
> >> Closes: https://lore.kernel.org/netdev/20260809221915.2ffc1ecd0f445fcb70270e31@uniroma2.it/
> >> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> >> ---
> >>   net/ipv6/seg6_local.c | 56 ++++++++++++++++++++++++++++++++++++-------
> >>   1 file changed, 48 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> >> index 53f7b2452575..c249f7751d41 100644
> >> --- a/net/ipv6/seg6_local.c
> >> +++ b/net/ipv6/seg6_local.c
> >> @@ -1056,6 +1056,40 @@ static int input_action_end_dx6(struct sk_buff *skb,
> >>   	return -EINVAL;
> >>   }
> >>   
> >> +/* Validate the length of the IPv4 header at skb->data (which must point to
> >> + * the network header) and report that length, options included.
> >> + * Only the version, the header length and the presence of the whole header
> >> + * are checked.
> >> + * The length is written only when SKB_NOT_DROPPED_YET is returned.
> >> + *
> >> + * skb pointers may change: after this call, the caller must evaluate again
> >> + * any pointer into the packet data.
> >> + */
> >> +static enum skb_drop_reason
> >> +seg6_validate_iphdr_len(struct sk_buff *skb, int *hdrlen)
> >> +{
> >> +	enum skb_drop_reason reason;
> >> +	const struct iphdr *iph;
> >> +	int len;
> >> +
> >> +	reason = pskb_may_pull_reason(skb, sizeof(struct iphdr));
> >> +	if (reason)
> >> +		return reason;
> >> +
> >> +	iph = ip_hdr(skb);
> >> +	if (iph->version != 4 || iph->ihl < 5)
> >> +		return SKB_DROP_REASON_IP_INHDR;
> >> +
> >> +	len = ip_hdrlen(skb);
> >> +
> >> +	reason = pskb_may_pull_reason(skb, len);
> >> +	if (reason)
> >> +		return reason;
> >> +
> >> +	*hdrlen = len;
> >> +	return SKB_NOT_DROPPED_YET;
> >> +}
> >> +
> >>   static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
> >>   				       struct sk_buff *skb)
> >>   {
> >> @@ -1085,14 +1119,18 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
> >>   static int input_action_end_dx4(struct sk_buff *skb,
> >>   				struct seg6_local_lwt *slwt)
> >>   {
> >> +	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
> >> +	int hdrlen;
> >> +
> >>   	if (!decap_and_validate(skb, IPPROTO_IPIP))
> >>   		goto drop;
> >>   
> >> -	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> >> +	reason = seg6_validate_iphdr_len(skb, &hdrlen);
> >> +	if (reason)
> >>   		goto drop;
> >>   
> >>   	skb->protocol = htons(ETH_P_IP);
> >> -	skb_set_transport_header(skb, sizeof(struct iphdr));
> >> +	skb_set_transport_header(skb, hdrlen);
> >>   	nf_reset_ct(skb);
> >>   
> >>   	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
> >> @@ -1102,7 +1140,7 @@ static int input_action_end_dx4(struct sk_buff *skb,
> >>   
> >>   	return input_action_end_dx4_finish(dev_net(skb->dev), NULL, skb);
> >>   drop:
> >> -	kfree_skb(skb);
> >> +	kfree_skb_reason(skb, reason);
> >>   	return -EINVAL;
> >>   }
> >>   
> >> @@ -1234,6 +1272,7 @@ static struct net_device *end_dt_get_vrf_rcu(struct sk_buff *skb,
> >>   static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
> >>   				       struct seg6_local_lwt *slwt, u16 family)
> >>   {
> >> +	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
> > 
> > Nit: We can use SKB_DR(reason) without the long definition.
> > 
> >>   	struct seg6_end_dt_info *info = &slwt->dt_info;
> >>   	struct net_device *vrf;
> >>   	__be16 protocol;
> >> @@ -1246,7 +1285,9 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
> >>   	switch (family) {
> >>   	case AF_INET:
> >>   		protocol = htons(ETH_P_IP);
> >> -		hdrlen = sizeof(struct iphdr);
> >> +		reason = seg6_validate_iphdr_len(skb, &hdrlen);
> >> +		if (unlikely(reason))
> >> +			goto drop;
> >>   		break;
> >>   	case AF_INET6:
> >>   		protocol = htons(ETH_P_IPV6);
> >> @@ -1260,6 +1301,7 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
> >>   
> >>   	if (unlikely(info->family != AF_UNSPEC && info->family != family)) {
> >>   		pr_warn_once("seg6local: SRv6 End.DT* family mismatch");
> >> +		reason = SKB_DROP_REASON_NOT_SPECIFIED;
> >>   		goto drop;
> >>   	}
> > 
> > And maybe move this checking upper before switch(), then we don't need
> > to reset reason.
> I think both suggestions make sense, please send a v2.

Sure, I will send a v2 with both changes. Thanks Paolo, and thanks
David and Hangbin for the reviews.

The Sashiko review [1] also asks about the inner IPv4 options on the
decap paths. That point is pre-existing, is not addressed by this
patch, and can be handled separately.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020023336.34-1-andrea.mayer@uniroma2.it

Ciao,
Andrea
