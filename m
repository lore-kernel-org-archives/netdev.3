Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792935905;
	b=rQO9L8Z+pfD5b0H/VimjlEBodtQ6LSHv9pEkb0YyvvO30rr2fYOJB4A3BsaXfCqGL4pP
	 bCBqkngQ0S9FBceQgvbfMvbcSEDma/NJkFHnfvpAiWcwR3J/T0qyZIRw4+JgBiQ+Rwkf/
	 DXJCXU5VQ8B1OOodmzZBqwlB0j88ETQsSSd0iwbb+whdNXqCL2kzweRWxRYl0wnCtfDnp
	 jo/F6aF8MUdKSunKPNyaJwpyS4Jfb8hy5dzcVv2i4LmgDBhWywE81ylDDTJbU4CiQVc0G
	 m7yWo8RvOIESAW4Xtz1UNGr6TCaYctdXk40GHi9aF3m9LjfqFpnCAtngwPelAwl7aZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792935905;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WzGdwyTIB8OSTT9qV4w81uP2js36URfyJcS9pAsflJU=;
	b=amB+d9Vf5QdC2p1tHo36lFGW4NEamJEA5hY+vOMdc561/ay/zhcGjzGcj/FK2ZKqUpOF
	 7KZneOy2Rc9iIAX6nlVmrfYU3srx3VCsO2+yzm22UqizzT6JGOsI/qBi42pABOBI0twSQ
	 IUvaKQaqaeHvXw7Ri2zenZbxV+A3mpGMIyHAOZbosWbTHtiWo5/pwVbl5+4JtX1ORAx36
	 hMP7mbJudYXqh/Q4ARZ0LaP05Sd1WB5hXvxGq1C/yronMYradAfdyE7ghpDzvOJztXJsi
	 djobd8gDrySvwfbMyVLsIuk4pEX8aM39xUush1B/JJJOikNrkG7FqVqYJzJV6aquUIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRQRDKmu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC63606A31B;
	Sun, 25 Oct 2026 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRQRDKmu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691671F01825;
	Sun, 25 Oct 2026 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792935905;
	bh=WzGdwyTIB8OSTT9qV4w81uP2js36URfyJcS9pAsflJU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NRQRDKmus9MplXxmlbdnbUu4+03S/jLB5rA2TlVMLbu/jEVISfSfvDKdepE7UnvHx
	 oEkkz2UOHDpQovkPVfvBHqZL0oKFOoM3l/6aGeRn/Src73BUV6+mtedBrc5w9w59WC
	 EzniXUTrdO/pIBYG+W+2os+QpScfAULMnxmDj/JYy5VxNxN9yir9yU+yzapXHvqzef
	 Muwx761HQkMd2VtupRA3yb5J2KG+ObAL2oNveN6X1IZ8WTk9XKLRgfv+pYYewqr5K/
	 0TH7pb3VguPY19WSA30JiSYAsidXHH2L9CWx53xGB9711JIeo8l8qfk/mNYQIZnsBH
	 QhRPSP8jQR/VA==
Subject: Re: [PATCH net] skbuff: keep accesses through unset transport header
 in bounds
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, edumazet@google.com, noreply@anthropic.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org
Date: Sun, 25 Oct 2026 13:45:03 +0000
Message-ID: <179293590392.3134.1010737398551488334@kernel.org>
In-Reply-To:
 <0bdcbe2ab5ffc86ba7190fe25476bcebcb967310.1792844270.git.mst@redhat.com>
References:
 <0bdcbe2ab5ffc86ba7190fe25476bcebcb967310.1792844270.git.mst@redhat.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete because the length helpers that read the
  same fields were not changed.
- [High] The new guards in skb_transport_header() and
  skb_inner_transport_header() only fire when the field equals exactly…
- [Low] skb_inner_transport_header() checks inner_transport_header
  against ~0U.

--

skbuff: keep accesses through unset transport header in bounds

This commit changes skb_transport_header() and skb_inner_transport_header()
so that they warn under CONFIG_DEBUG_NET when the transport header offset
holds the ~0 unset value. In that case they fall back to the network header
position. The aim is to keep accesses through an unset transport header
inside the packet instead of at skb->head + 0xffff.

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 6787fcf6ac3e4..e0e2f925f7299 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3002,6 +3002,12 @@ static inline void skb_reset_mac_len(struct sk_buff *skb)
>  static inline unsigned char *skb_inner_transport_header(const struct sk_buff
>  							*skb)
>  {
> +	if (unlikely(skb->inner_transport_header ==
> +		     (typeof(skb->inner_transport_header))~0U)) {

[Severity: Low]
This isn't a bug, but is ~0U the right unset value to test for the inner
transport header? The rest of the inner header code uses 0 to mean unset:

include/linux/skbuff.h:skb_inner_network_header_was_set() {
	return skb->inner_network_header > 0;
}

net/core/skbuff.c:skb_carve_reset_headers() {
	...
	/* Inner offsets have no "unset" marker, zero them so that
	 * skb_inner_network_header_was_set() becomes false and no
	 * consumer mistakes them for a real (and long gone) header.
	 */
	skb->inner_mac_header = 0;
	skb->inner_network_header = 0;
	skb->inner_transport_header = 0;
	...
}

The ~0U case can still happen, because skb_reset_inner_headers() copies an
unset outer transport_header into inner_transport_header. An inner
transport header that was never set (0) is not caught by this check,
though. It still returns skb->head. That pointer is in bounds, and the
behaviour is the same as before the patch.

> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		return skb->head + skb->inner_network_header;
> +	}
> +
>  	return skb->head + skb->inner_transport_header;
>  }
>  
> @@ -3081,7 +3087,11 @@ static inline void skb_unset_transport_header(struct sk_buff *skb)
>  
>  static inline unsigned char *skb_transport_header(const struct sk_buff *skb)
>  {
> -	DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
> +	if (unlikely(!skb_transport_header_was_set(skb))) {

[Severity: High]
Does the unset value always survive until this check? The new test only
matches 0xffff exactly. skb_headers_offset_update() shifts both transport
offsets unconditionally, while it does guard mac_header:

net/core/skbuff.c:skb_headers_offset_update() {
	...
	skb->transport_header += off;
	skb->network_header   += off;
	if (skb_mac_header_was_set(skb))
		skb->mac_header += off;
	skb->inner_transport_header += off;
	...
}

pskb_expand_head() calls it with a positive nhead, so 0xffff wraps to
nhead - 1. skb_copy_expand() calls it with newheadroom - oldheadroom. That
value is negative when the new headroom is smaller, which gives 0xffff - k.

In both cases skb_transport_header_was_set() returns true, so no warning
fires. In the second case skb_transport_header() still returns a pointer
about 64K past skb->head.

One RX path that looks like it can reach this is vl600_rx_fixup() in
drivers/net/usb/lg-vl600.c:

	s->current_rx_buf = skb_copy_expand(skb, 0,
			le32_to_cpup(&frame->len), GFP_ATOMIC);

That buffer is later passed up with usbnet_skb_return(). Because was_set()
now returns true, __netif_receive_skb_core() also skips its reset:

	if (!skb_transport_header_was_set(skb))
		skb_reset_transport_header(skb);

Should skb_headers_offset_update() leave unset transport offsets alone, as
it already does for mac_header?

> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		return skb->head + skb->network_header;
> +	}

[Severity: High]
Should the length helpers that read the same fields use the same fallback?
skb_transport_offset() picks it up through skb_transport_header(), but
skb_network_header_len() and skb_inner_network_header_len() still use the
raw offsets:

include/linux/skbuff.h:
static inline u32 skb_network_header_len(const struct sk_buff *skb)
{
	DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
	return skb->transport_header - skb->network_header;
}

static inline u32 skb_inner_network_header_len(const struct sk_buff *skb)
{
	return skb->inner_transport_header - skb->inner_network_header;
}

With an unset header, both still return about 0xffff minus the network
offset. skb_inner_network_header_len() has no check at all. Callers that
use these values for pulls, copies or offset arithmetic would still get a
length of about 64K.

Code that reads skb->transport_header directly, such as
virtio_net_hdr_tnl_from_skb(), also bypasses the fallback.

Does this match the commit message's "accesses stay within the packet"?

There is also a new mismatch. Before this patch,
skb_transport_header() - skb_network_header() always equalled
skb_network_header_len(). With an unset header they now differ.
ipv6_mc_may_pull() mixes the two:

include/net/addrconf.h:ipv6_mc_may_pull() {
	if (skb_transport_offset(skb) + ipv6_transport_len(skb) < len)
		return false;

	return pskb_may_pull(skb, len);
}

include/linux/ipv6.h:ipv6_transport_len() {
	return ntohs(ipv6_hdr(skb)->payload_len) + sizeof(struct ipv6hdr) -
	       skb_network_header_len(skb);
}

Before the patch the raw offsets cancelled out. Now the first term is
clamped to the network offset, but ipv6_transport_len() still subtracts the
raw ~64K value.

Can the unsigned sum wrap here and skip the advertised length check,
leaving pskb_may_pull() as the only bound?

> +
>  	return skb->head + skb->transport_header;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0bdcbe2ab5ffc86ba7190fe25476bcebcb967310.1792844270.git.mst%40redhat.com
