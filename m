Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EEA381C4;
	Sat, 10 Oct 2026 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642734; cv=none; b=MIfS1EOX0mXc+zEctU3e93gJY6gLaxV+tYBqO6Vjav6urj8Q1X00zQrW19z81ffLLWd1ynYPOfwN4lB/fM2bFUdTRbJCMy34DUzgNsc+kh4wdXQnogcsSmfM93t/9j3NAlAPOOWU1dnutKv1xYk0F8vmj+iBiRWWaKqBkWgpuTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642734; c=relaxed/simple;
	bh=2LIPWbfOeDgSf5t6nd75y8gDzljUUM8YhDMfuPbA9qM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OtMyFTH/QT6SGZet9tPcH2oLLNGJj8+kxnjxkjBb2Q6CY16p4Gam/aSu5VhiA3EA7ElI8QwzB9oEx8OU7PQbC7YFPIkuAPQgRo0KiH4cYry6AKzNKdtqhbOH95K3gebYRERu3IhbmZqshbfvxLw6vhCnUcw4p0r8AosJmBDaK4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTST7iuv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTST7iuv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBE51F000FF;
	Sat, 10 Oct 2026 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791642732;
	bh=dJZLdbFhLC/ynJVpWk/rEOzcEFJLRmSBZudkVqLrcp0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KTST7iuvzfxpvR5a97XPjhGCw1IhaZDtfa+AjX4TqdyWUO/8ktIJ6XTIUOX3XgoGU
	 yXZBCO0F2c+sTEpp/hOHQC87sBulKnlE3LVk1I0tvd221bTemtMvYgiUebSCVKwdQi
	 kAeYeM5nkmGBAnMT4Jek2IQtsi+zkDs1PfPS3y4gAIo0MEWhA8m4nV07uOxWTzvmoj
	 5OuKLIXLhwXbUmidi/FFFdwkxL0sJDIxOmC9/XsaAnpGYNMJJ8t6eLcPZ2WTzkk8wE
	 ZRJ/hfIgvxGq+1sewqDhcSliTh9/25g+Y+8fKvM/Dp5A04yKlmWk/Xpy8UxgEOEYsh
	 PQRji3tPxCzAg==
Subject: Re: [PATCH net] esp: fix out-of-bounds transport-header read after
 exthdr walk
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 14:32:11 +0000
Message-ID: <179164273177.434549.11736942363139290526@kernel.org>
In-Reply-To: <20261009135233.4084239-1-bsdhenrymartin@gmail.com>
References: <20261009135233.4084239-1-bsdhenrymartin@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Both new bounds checks compare a negative, data-relative offset
  against skb->len using unsigned arithmetic, so the check is always…
- [Medium] Where the computed offset is non-negative, the new checks
  bound it only by skb->len (total length including page frags and…
- [Low] The new comments and the commit message do not describe the main
  receive paths accurately.

--

esp: fix out-of-bounds transport-header read after exthdr walk

This adds a bounds check to esp_input_done2() and to esp6_input_done2()
before the 2-byte source port is read from the encap transport header.
If the computed offset plus two bytes is past skb->len, the packet is
rejected with -EINVAL.

> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index e76db5817e78e..aaff5a2b659db 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -744,6 +744,18 @@ int esp_input_done2(struct sk_buff *skb, int err)
>  		struct udphdr *uh = (void *)(skb_network_header(skb) + ihl);
>  		__be16 source;
>  
> +		/*
> +		 * ihl is taken from the decrypted inner packet and is not
> +		 * re-validated after esp_remove_trailer() shrank the skb;
> +		 * make sure the 2-byte source port we read below is within
> +		 * the packet.
> +		 */

[Severity: Low]
Is this comment accurate for the UDP encap path?

In esp_input_done2(), ihl comes from:

	iph = ip_hdr(skb);
	ihl = iph->ihl * 4;

At this point that is the outer, unencrypted IPv4 header that
ip_rcv_core() validated. The inner network header is only reset later,
by the mode input callback.

The UDP header at network_header + ihl was already linearized by
__xfrm4_udp_encap_rcv():

	if (!pskb_may_pull(skb, sizeof(struct udphdr) + min(len, 8)))

That header sits before skb->data, so esp_remove_trailer() trimming the
tail can't move it out of range.

The esp6 comment has the same problem. On the UDP path,
ipv6_skip_exthdr() walks outer extension headers that IPv6 input has
already validated, stops at the UDP header, and returns a negative
offset relative to skb->data.

The scenario might really happen on espintcp paths where the network
header is stale. tcp_collapse() leaves network_header at 0 for a new
head, and alloc_skb_for_msg() copies first->network_header into a
0-byte head through __copy_skb_header(). That would fit the Fixes: tag,
but neither the comments nor the commit message describe it.

Could the comments and the commit message describe how the offsets
actually work, and which path produces the bad header?

> +		if (skb_network_offset(skb) + ihl + sizeof(__be16) >
> +		    skb->len) {
> +			err = -EINVAL;
> +			goto out;
> +		}

[Severity: High]
Can this check ever pass for a valid encapsulated packet?

When esp_input_done2() runs, skb->data points at the ESP header. The
outer IP header and the UDP or TCP encap header both sit before
skb->data. For UDP, __xfrm4_udp_encap_rcv() pulls the UDP header off:

net/ipv4/xfrm4_input.c:__xfrm4_udp_encap_rcv() {
    ...
	if (pull) {
		__skb_pull(skb, len);
		skb_reset_transport_header(skb);
    ...
}

For espintcp, espintcp_rcv() does:

	if (!pskb_pull(skb, rxm->offset + 2)) {

So with UDP encap, skb_network_offset(skb) is -(ihl + 8), and
skb_network_offset(skb) + ihl is -8. Adding sizeof(__be16) converts
that to size_t, so the left side becomes a huge unsigned value and the
comparison is always true.

Wouldn't that drop every UDP_ENCAP_ESPINUDP and TCP_ENCAP_ESPINTCP
packet with -EINVAL after a successful decrypt? That would break both
NAT-T and espintcp receive.

The new check in esp6_input_done2() looks like it has the same problem:

	if (offset + sizeof(__be16) > skb->len) {

offset starts at skb_network_offset(skb) + sizeof(*ip6h).
ipv6_skip_exthdr() stops at the UDP or TCP header, which gives -8 for
UDP. The existing code already depends on offset being negative there:

	hdr_len += offset;

Also, skb->len counts bytes from skb->data onward, but the port being
read is before skb->data. Even a signed comparison against skb->len
would not bound this read.

Would something like skb_header_pointer_careful(), or a signed check
against the headroom and headlen, be needed instead of extending this
check?

> +
>  		switch (x->encap->encap_type) {
>  		case TCP_ENCAP_ESPINTCP:
>  			source = th->source;
> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> index b1c9b36f76dc4..89e8cdf5a26b2 100644
> --- a/net/ipv6/esp6.c
> +++ b/net/ipv6/esp6.c
> @@ -782,6 +782,17 @@ int esp6_input_done2(struct sk_buff *skb, int err)
>  			goto out;
>  		}
>  
> +		/*
> +		 * ipv6_skip_exthdr() can advance past the packet end when the
> +		 * last extension header claims an oversized length; the
> +		 * transport header below would then be read out of bounds.
> +		 * Make sure there is room for the 2-byte source port we read.
> +		 */
> +		if (offset + sizeof(__be16) > skb->len) {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
>  		uh = (void *)(skb->data + offset);
>  		th = (void *)(skb->data + offset);
>  		hdr_len += offset;

[Severity: Medium]
When offset is non-negative, does this check bound the read that
follows?

skb->len includes page frags and the frag_list. The port, however, is
read straight from the linear buffer through skb->data + offset. Any
offset with skb_headlen(skb) <= offset + 2 <= skb->len passes the
check, and the read then lands past the linear data, possibly past the
end of the head allocation.

Non-negative offsets seem possible on the espintcp paths where the
network header is stale. alloc_skb_for_msg() does:

	n = alloc_skb(0, GFP_ATOMIC);
	...
	skb_shinfo(n)->frag_list = first;

	__copy_skb_header(n, first);

and tcp_collapse() leaves network_header at 0. In both cases
ipv6_hdr() points at bytes that are not a real IPv6 header.
ipv6_skip_exthdr() walks with skb_header_pointer(), which can read
frags, and each step can advance up to 2048 bytes. esp6_input() does
not linearize the skb, so the offset can end up well inside skb->len
but past skb_headlen().

The esp4 check has the same skb->len bound in front of the direct
th->source and uh->source reads at skb_network_header(skb) + ihl.

I haven't confirmed the whole path end to end. Would reading the port
with skb_header_pointer_careful() handle both the negative-offset case
and the frag case?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009135233.4084239-1-bsdhenrymartin%40gmail.com
