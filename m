Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681995;
	b=mDnbGII9JpILM06g4ILbyDClNo7c+xiJvXbRDnA7XUiB/XgBg+OvlMBy22etfQbougPh
	 qJ+M3g0CJEtqnG5mTU6dIuj+IbmDggAxcOKHDR97H009i/R5i7Qwtk0KVSqCdntiyaULn
	 jUZGJ8nkGMOp1ntpdbGxLStK+vLSFWNT9vUJ4mBgTwCmD7mRPSk8LicJXRsCe3PKlkbAy
	 luIRAQ7G6AIhY6g/iI/E+XMxV2NiG7DkvmQN2hLQfXMcHfq8B+ejf4VWtLcSXc5WH86HO
	 d4NXBh/BzPnGLAXinSHyd1RjyjcKY2z1k6rNrNYw9z9BraIX192paclUo5tPyxRtRkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681995;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LXajKIsKvudYKoT6Qka57GNOPhZZEEXC9uwxtsOqE7E=;
	b=w6+LXhwZM1AEsOlkncorSh18meqhhRlAMuNctQF9xoyXXQB4prWHWEM+AU2r6DZKgRy8
	 s9VNlGC7mWyjyHxIOOWNvSV4msZdasHaYJRzdcC4H4JhYnhjh2SPO3HOZbv6agSuKKmsP
	 9hQQ3/weNdjEPUo65uK2ToZ4y0rEdPgyuhZZaZlj8RvIcOOISVU5TOmJfGIgxSscJ16Ak
	 xDEawLFFmTQCzied8g2OudSG+SK3fsoneFZjm0UoUcgkEoZdeOj7biH8ylLZtm7CaF1G/
	 WdcbRtT1Z1WYnLGVSFVleVlmRf3gVUnfUwrAEjyEQdbeg+wDOavrWMr/RZRzYmxe9Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RA9DTIkU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288CE606A324;
	Tue,  3 Nov 2026 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RA9DTIkU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E9F1F000C1;
	Tue,  3 Nov 2026 04:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793681994;
	bh=LXajKIsKvudYKoT6Qka57GNOPhZZEEXC9uwxtsOqE7E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RA9DTIkUXnFt62mjBEtoaKaPDAq6B/QaT0sMgn1tWpcdt8rQHPyeK7H9AM71UmZGM
	 9tXGN8tP3npEwi+RlHGqvB7wuWQB4D1NKkm3ooOvEHDPMGuewCcdUuIQW+Ym+h3N4g
	 l9UDYLvfUivrnQE3drK+MgpBQo/pd/Bz1EBkc9Xvo+O1x4WAQ/cnaF4VzgGxOh89un
	 awMftiOKDTUvOq50Jlx9OOQLjm9zUg1I9hw0yT/vWen8JCsJlak923dIaFUV6KKwNP
	 IbvxWnxKpyP/WTN+ec3tUsivNjat9jvRxtAodlgaRGGPLhBYJo+JFLyFWitr/chQJV
	 L3vghLV6yeD/g==
Subject: Re: [PATCH] mpls: reject headroom that overflows skb header offsets
From: netdev-bot+sashiko@kernel.org
To: kylebot@openai.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 outbounddisclosures@openai.com
Date: Tue, 03 Nov 2026 04:59:53 +0000
Message-ID: <179368199381.488856.1269001903165496876@kernel.org>
In-Reply-To: <20261030042246.74144-1-kylebot@openai.com>
References: <20261030042246.74144-1-kylebot@openai.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new `skb_headroom(skb) > U16_MAX` check in mpls_xmit() and
  mpls_forward() only shows that the data offset (skb->data - skb->head)…
- [Medium] mpls: mpls_forward() resets network_header before U16_MAX
  headroom check

--

mpls: reject headroom that overflows skb header offsets

This adds a check after skb_cow()/skb_cow_head() in mpls_forward() and
mpls_xmit(). The check drops the packet if skb_headroom() exceeds U16_MAX.
The aim is to stop the u16 header offsets from truncating when the aligned
headroom expansion pushes skb->data more than U16_MAX bytes past skb->head.

> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index ad4ad6f2001ab..4bfdb7c81f046 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -453,6 +453,10 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
>  	if (skb_cow(skb, hh_len + new_header_size))
>  		goto tx_err;
>  
> +	/* The aligned expansion must still fit the u16 header offsets. */
> +	if (unlikely(skb_headroom(skb) > U16_MAX))
> +		goto tx_err;
> +
>  	skb->dev = out_dev;
>  	skb->protocol = htons(ETH_P_MPLS_UC);
>  
> diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
> index 1a1a0eb5b787f..4eccbd911fe1f 100644
> --- a/net/mpls/mpls_iptunnel.c
> +++ b/net/mpls/mpls_iptunnel.c
> @@ -109,6 +109,10 @@ static int mpls_xmit(struct sk_buff *skb)
>  	if (skb_cow_head(skb, hh_len + new_header_size))
>  		goto drop;
>  
> +	/* The aligned expansion must still fit the u16 header offsets. */
> +	if (unlikely(skb_headroom(skb) > U16_MAX))
> +		goto drop;

[Severity: Medium]
Is the new check early enough in mpls_forward()?

Before skb_cow() is reached, the label pop has already moved skb->data
forward and written the new offset into the u16 network_header:

net/mpls/af_mpls.c:mpls_forward() {
	...
	/* Pop the label */
	skb_pull(skb, sizeof(*hdr));
	skb_reset_network_header(skb);
	...
	if (mpls_pkt_too_big(skb, mtu - new_header_size))
		goto tx_err;
	...
}

Suppose an MPLS skb arrives with skb_headroom() in [65532, 65535]. That
is still within U16_MAX, so nothing rejects it on the way in. The
4-byte skb_pull() then takes the headroom to 65536..65539.
skb_reset_network_header() hits its DEBUG_NET_WARN_ON_ONCE() and
truncates network_header to 0..3.

One source of such an skb is a previous mpls_forward() hop. With
nh_labels == 0 and !dec.bos, new_header_size is 0, so the new check
accepts a headroom of up to 65535 and sends the packet on. After the
peer's eth_type_trans(), the next hop sees the MPLS header at that same
offset. AF_PACKET on a netkit device with a near-maximal
needed_headroom looks like another way to inject one.

The truncated offset is also used before the packet is dropped. For a
GSO skb larger than mtu - new_header_size, mpls_pkt_too_big() calls
skb_gso_validate_network_len(). That goes through
skb_gso_network_seglen(), which computes skb_transport_header() -
skb_network_header(), so the MTU decision is based on a bogus header
length.

skb_cow() can only grow the headroom, so the new check after it will
still drop the skb. By then, though, the warning has already fired. On
CONFIG_DEBUG_NET kernels with panic_on_warn, that is a crash reachable
from a user-owned network namespace.

Could the bound be enforced before the pop, for example by rejecting
an incoming skb whose headroom plus sizeof(*hdr) would exceed U16_MAX,
before skb_reset_network_header() runs? Or is there a better place to
catch this for skbs that reach mpls_forward() with headroom close to
the limit?

[Severity: High]

Does this check cover all of the u16 header offsets that the comment
refers to?

By the time it runs, skb_cow_head() has already gone through
__skb_cow()->pskb_expand_head()->skb_headers_offset_update(), and that
function does unchecked u16 additions:

net/core/skbuff.c:skb_headers_offset_update() {
	if (skb->ip_summed == CHECKSUM_PARTIAL)
		skb->csum_start += off;
	/* {transport,network,mac}_header and tail are relative to skb->head */
	skb->transport_header += off;
	skb->network_header   += off;
	...
	skb->inner_transport_header += off;
	skb->inner_network_header += off;
	skb->inner_mac_header += off;
}

skb_headroom() only bounds skb->data - skb->head. The transport_header
and csum_start offsets point past skb->data, so they can wrap while the
headroom is still at most U16_MAX.

For example, take a netkit device with needed_headroom in [65426, 65441].
That gives LL_RESERVED_SPACE() = 65456. A UDP packet built by
__ip_append_data() reserves 65456 bytes of headroom, so transport_header
is 65476. netkit advertises NETIF_F_HW_CSUM, so udp_send_skb() sets
CHECKSUM_PARTIAL with csum_start = 65476.

mpls_xmit() then asks for 65460 bytes, and __skb_cow() expands by
ALIGN(4, NET_SKB_PAD) = 64. The headroom becomes 65520 and passes the new
check. transport_header and csum_start become 65540, which wraps to 4.

netkit_setup() sets mpls_features to NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE,
so the skb reaches the peer unchanged. If it is later sent out a device
without checksum offload, validate_xmit_skb() ends up in
skb_checksum_help():

net/core/dev.c:skb_checksum_help() {
	...
	offset = skb_checksum_start_offset(skb);
	ret = -EINVAL;
	if (unlikely(offset >= skb_headlen(skb))) {
		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
		WARN_ONCE(true, "offset (%d) >= skb_headlen() (%u)\n",
	...
}

The negative offset is compared as a large unsigned value, so skb_dump()
and WARN_ONCE() fire. A device with checksum offload would instead get a
bogus checksum start offset.

mpls_forward() has the same headroom-only check after skb_cow(). The
same window appears to apply there to CHECKSUM_PARTIAL skbs received from
a netkit peer.

Could the check bound the largest header offset, or refuse the expansion
before it wraps, instead of testing skb_headroom() after the offsets have
already been updated?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030042246.74144-1-kylebot%40openai.com
