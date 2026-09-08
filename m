Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF42D37419B;
	Tue,  8 Sep 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855874; cv=none; b=YCpHX/o8wCYREul8Kqek9b+GkapqXFaGG3+8KVxCJV639YizOGOZpMvkG5iqyEgqHg+DEEUVBISJJcDxcA5Y5ktL8iXnE8xmiOEAsCRyVJLArykR0ZQzl+DNT3o3arDXYmL52XJ+Cn+97q/WbP02cdLNceE57vJ0Ug1Dn3GaL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855874; c=relaxed/simple;
	bh=k9GUad2pSIdAfMY4XYBjydP2Vj5lMkji1fN+l1eawQs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LFrXMrpdmISc+VuYAbwUUazv8FkAI8p0uWEOMdE5XHAEmxVob2XERwqNKX+K3jm3WIbonPhrSmRKHq0oYOINbhb6zdkrXJdeeC23Krr+dy6U+oOfh9uZjou87lMO7TO3boytc6WNY4BEOmFjRiQ5Y257EW2q9reFC7Qz2bYCnBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgMO9GLK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgMO9GLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F871F00A3A;
	Tue,  8 Sep 2026 08:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788855872;
	bh=j6w+E661wQoXMaD2TSKr4GPyPUlZlAyHm4Kq85zBY9I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WgMO9GLK1WiMokBMfeI62TNqopvCnzYHFH2xq6mUaz8YOrhlAJ6okIX5JnlBcYoLB
	 LM84eP90Tsu2MD3GyVHRFpWM0b9Mf3o0fnl3MBkeffj/pS/iGz37Q9TXRwMEdR4ckk
	 UBrsEjD8TS5qNxEPFCnggfDkxo6Zyo7JhXvfQkZX7zfKwmjKkX3KGNuvUomvp6FcxC
	 wzNzya82YcUwrZsBUE0SPi2RnpSSJEHe69H8DAB5tSPq3t5Cin2BQ0xIi1FO5kjpwH
	 dWUIiDji8Ehw2Bw5j834FzST9kQuAQOLmDocabk8Os+KtNG2s7cYZUHr0CKECUSBoT
	 T1Z9ho1jfTW+A==
Subject: Re: [PATCH net-next v2] seg6: reallocate the skb head on L2
 encapsulation only when needed
From: netdev-bot+sashiko@kernel.org
To: yuya.kusakabe@gmail.com
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 08 Sep 2026 08:24:31 +0000
Message-ID: <178885587111.219967.14896644410984520593@kernel.org>
In-Reply-To: <20260903-seg6-l2cow-v2-1-f37b3b35416f@gmail.com>
References: <20260903-seg6-l2cow-v2-1-f37b3b35416f@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 1

- [High] The computed pre-encapsulation headroom in seg6_do_srh()
  (net/ipv6/seg6_iptunnel.c:452-454, L2ENCAP/L2ENCAP_RED case) accounts…
- [Low] The commit uses the AI-assistance trailer `Assisted-by:
  Claude:claude-opus-5`, which does not match the only format documented…

--

seg6: reallocate the skb head on L2 encapsulation only when needed

The L2ENCAP and L2ENCAP_RED modes of the seg6 lwtunnel previously called
pskb_expand_head() unconditionally for skb->mac_len.  This patch replaces
that with a skb_cow_head() for the whole encapsulation (mac_len, outer
IPv6 header, SRH and dst_dev_overhead()) so the head is reallocated at
most once and only when the existing headroom is too small.

Link to v1:
https://lore.kernel.org/r/20260902-seg6-l2cow-v1-1-e823ce216454@gmail.com

> Assisted-by: Claude:claude-opus-5

[Severity: Low]
This isn't a bug, but does this trailer match the form documented in
Documentation/process/coding-assistants.rst?  That file describes only:

  Assisted-by: LLM [TOOL1] [TOOL2]

where the optional trailing entries are specialized analysis tools
(coccinelle, sparse, smatch, clang-tidy), with the example
"Assisted-by: LLM coccinelle sparse", rather than a vendor or model name.

> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 61c6a27bf202..ecd8146089ee 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c

[ ... ]

> @@ -446,8 +447,13 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
>  		if (!skb_mac_header_was_set(skb))
>  			return -EINVAL;
>  
> -		if (pskb_expand_head(skb, skb->mac_len, 0, GFP_ATOMIC) < 0)
> -			return -ENOMEM;
> +		headroom = skb->mac_len + sizeof(struct ipv6hdr) +
> +			   ipv6_optlen(tinfo->srh) +
> +			   dst_dev_overhead(cache_dst, skb);
> +
> +		err = skb_cow_head(skb, headroom);
> +		if (unlikely(err))
> +			return err;
>  
>  		skb_mac_header_rebuild(skb);
>  		skb_push(skb, skb->mac_len);

[Severity: High]
Does this account for skb->mac_len often enough?  The L2 path rebuilds the
inner MAC header twice, and mac_len is counted only once here.

First rebuild, in seg6_do_srh():

	skb_mac_header_rebuild(skb);
	skb_push(skb, skb->mac_len);

Second rebuild, in __seg6_do_srh_encap() (and identically in
seg6_do_srh_encap_red()), after the outer header has been pushed:

	skb_push(skb, tot_len);
	skb_reset_network_header(skb);
	skb_mac_header_rebuild(skb);

The commit message says that "__seg6_do_srh_encap() then finds the room it
needs and its own skb_cow_head() becomes a no-op".  With that cow turned
into a no-op, is anything left to supply headroom for the second rebuild?

After the push of tot_len = sizeof(struct ipv6hdr) + ipv6_optlen(srh), the
headroom guaranteed by the new request is only dst_dev_overhead().  If
skb->mac_len is larger than that, skb_mac_header_rebuild() calls
skb_set_mac_header(skb, -skb->mac_len) with a negative resulting offset,
which is stored unchecked into the __u16 field:

include/linux/skbuff.h:
static inline void skb_set_mac_header(struct sk_buff *skb, const int offset)
{
	skb_reset_mac_header(skb);
	skb->mac_header += offset;
}

Can that wrap to roughly 65534 and make the following

	memmove(skb_mac_header(skb), old_mac, skb->mac_len);

write skb->mac_len bytes about 64 KB past skb->head?

Can skb->mac_len exceed dst_dev_overhead()?  dst_dev_overhead() returns
LL_RESERVED_SPACE(dst->dev), which is 16 for a plain Ethernet egress
device, while on ingress vlan_do_receive() re-inserts the tag when
VLAN_FLAG_REORDER_HDR is off:

net/8021q/vlan_core.c:vlan_do_receive() {
	...
		skb_pull(skb, offset + VLAN_HLEN);
		skb_reset_mac_len(skb);
	...
}

giving skb->mac_len = 18, or 22 for stacked VLAN devices, and
__netif_receive_skb_core() does not reset mac_len again on the forwarding
path.

Note also that skb_cow_head()/__skb_cow() only guarantee headroom greater
than or equal to the request, so the skb need not be reallocated for the
underflow to happen.  With mac_len = 18, overhead = 16 and a one-segment
SRH (ipv6_optlen = 24, tot_len = 64) the request is 98, and an skb whose
resulting headroom is 98 or 99 gives mac_header = 16 - 18 = -2.

Would

	skb->mac_len + sizeof(struct ipv6hdr) + ipv6_optlen(tinfo->srh) +
	max(skb->mac_len, dst_dev_overhead(cache_dst, skb))

be the amount to ask for, since the rebuilt inner MAC copy and the egress
device's own link header both live below the outer IPv6 header?

For seg6_do_srh_encap_red() the same sequence applies; it is partly
shielded because the caller here asks for the full ipv6_optlen() while
only red_hdrlen is pushed, but the first_segment == 0 && sr_has_hmac()
sub-case sets red_hdrlen = hdrlen and is exposed the same way as plain
L2ENCAP.

A similarly shaped window existed before this change, since the
skb_cow_head() inside __seg6_do_srh_encap() never accounted for mac_len
either.  Given that this patch takes over sizing the whole encapsulation
up front, would it make sense to fix the amount here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-seg6-l2cow-v2-1-f37b3b35416f%40gmail.com
