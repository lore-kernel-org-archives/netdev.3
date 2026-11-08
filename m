Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794110653;
	b=Ly/A8JMdr57EegbGxwAzmvze1eOvA4obWxospfbDIp8QfP9ni/r3jBAKhFtP488dx/o0
	 oUCoRNxctduWPXH0cOGoHsXzchc4mQcBdBYxnpFUcDrqgiK9hDFVY+guaVvMtkCIVnPus
	 nf8gwlDWbcoLb3O68TxuBEiQq4fDUfDWM1NacRMwxmlxf5NBmKjSMEv6Gh0TidecfZw1x
	 PSXX7BDUVQzxPgDW9ddNHj5F4IqWRuTLArNx5znU1RlSKCVlA1Mo3XSc7AUvQKQlqJr2n
	 JPzS/bFZrTAX6pV0a/pzRYivPY+7Dsxoimkxg2ReEyyfGzZUK2HupJtJTu6SIedm2Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794110653;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=prREWKPfGDPz15x5zbL0iC2/9/oz4jLFrbCB+Kev8Zs=;
	b=uvlAUz20a9xGaiQ4PhG2Z94C7364kIP6/K2YM04aJgGwbXv76fv2QVgKDm602rLdqTMy
	 iwBey/7Y2kBBG58ATJzogSeVxSCbZcrRAcR9a+udNpPC8CsLbaeJhTC3q1R1myc9RkaHa
	 h5nMIXQ4N2fJdkoQkr1jH1hoWld+xGFkkJpbfV+YjkBzgiJNfj0UKeQQtuaR7crUmOEJj
	 4LCRWVq7lWXRLFuUSDtIBzokaimOMQLmZS8Bg9V8wZcHSEmLfbDgATChaRdeZAUHQpikW
	 a+daID2Ol+DPRAlIplPza/GnV821Obio6n/HGm/CRwTn7WNovUKKL7LcxTthNJpA1Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvSloEw0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C050606A31A;
	Sun,  8 Nov 2026 04:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvSloEw0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9AE1F0089F;
	Sun,  8 Nov 2026 04:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794110652;
	bh=prREWKPfGDPz15x5zbL0iC2/9/oz4jLFrbCB+Kev8Zs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TvSloEw0xs5Bpef/SfEPItAymhxFqwEKBlRSjp9pmn6nY03YljbR68dU28KgdIam8
	 C7X5y+adzoeCOtf2apgUTyhOVTdUIcnkvKtc4UP2Qz5nVcrTWWTnmEHREklJPfZxm9
	 pyBwhdD44/AjfbicottYZHJ7NftrdvyI7898y4Lo5j0HsyoYYEJivNc+9c/7Lcfxas
	 tuob7jVoliaulmk1RRDbRgEPamVdlMtVUG8brlAocN0c28b2tCI0stOoL3fe+Zrqvq
	 UKYa9yYjxAjSDR6acegf05lA9rcwZLZw2H/aRLVDF30X8v6Da+iuFSy2boQydVZwc+
	 zXrBClYGIiGug==
Subject:
 Re: [PATCH net v2] net: openvswitch: make transport checksums writable
From: netdev-bot+sashiko@kernel.org
To: kylebot@openai.com
Cc: dev@openvswitch.org, netdev@vger.kernel.org, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 04:04:11 +0000
Message-ID: <179411065171.994134.7555620955521911858@kernel.org>
In-Reply-To: <20261107040238.27606-1-kylebot@openai.com>
References: <20261107040238.27606-1-kylebot@openai.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch handles every skb_ensure_writable() failure in
  update_ip_l4_checksum() and update_ipv6_checksum()…

--

net: openvswitch: make transport checksums writable

This patch changes the IPv4 and IPv6 address rewrite helpers in Open
vSwitch. Each L4 checksum update now calls skb_ensure_writable() first,
instead of checking skb->len. A failure stays nonfatal, and packet
pointers are reloaded afterwards because the skb head may have moved.

Link: https://lore.kernel.org/r/20261030042304.74291-1-kylebot@openai.com

> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 12e339cbf7912..fe472e950cb1a 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -319,20 +319,22 @@ static int pop_nsh(struct sk_buff *skb, struct sw_flow_key *key)
>  	return 0;
>  }
>  
> -static void update_ip_l4_checksum(struct sk_buff *skb, struct iphdr *nh,
> -				  __be32 addr, __be32 new_addr)
> +static void update_ip_l4_checksum(struct sk_buff *skb, __be32 addr,
> +				  __be32 new_addr)
>  {
> -	int transport_len = skb->len - skb_transport_offset(skb);
> +	struct iphdr *nh = ip_hdr(skb);
>  
>  	if (nh->frag_off & htons(IP_OFFSET))
>  		return;
>  
>  	if (nh->protocol == IPPROTO_TCP) {
> -		if (likely(transport_len >= sizeof(struct tcphdr)))
> +		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
> +					       sizeof(struct tcphdr))))
>  			inet_proto_csum_replace4(&tcp_hdr(skb)->check, skb,
>  						 addr, new_addr, true);

[Severity: Medium]
Is it intended that every skb_ensure_writable() failure here is handled
the same way as a truncated transport header?

skb_ensure_writable() can fail even when the full TCP header is in the
packet. pskb_may_pull()->__pskb_pull_tail() returns NULL in three cases:
pskb_expand_head(GFP_ATOMIC) fails, a frag_list skb_clone() fails, or the
frags are unreadable:

net/core/skbuff.c:__pskb_pull_tail() {
    ...
	if (!skb_frags_readable(skb))
		return NULL;

	if (eat > 0 || skb_cloned(skb)) {
		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
				     GFP_ATOMIC))
			return NULL;
	}
    ...
}

pskb_expand_head(GFP_ATOMIC) can also fail later for a cloned skb.

In those cases the L4 checksum update is skipped. set_ip_addr() still
updates the IP header checksum and writes the new address:

	update_ip_l4_checksum(skb, old_addr, new_addr);
	addr = (__be32 *)(skb_network_header(skb) + addr_offset);
	csum_replace4(&ip_hdr(skb)->check, old_addr, new_addr);
	...
	*addr = new_addr;

set_ipv6_addr() does the same with memcpy(addr, new_addr, ...). Then
set_ipv4() or set_ipv6() returns 0.

Would the packet then be forwarded with a rewritten pseudo-header and a
stale TCP/UDP/ICMPv6 checksum?

With CHECKSUM_NONE or CHECKSUM_COMPLETE the checksum on the wire would be
wrong. With CHECKSUM_PARTIAL (including GSO), the stale seed in th->check
or uh->check would give a wrong final checksum for every segment.

The commit message says the reproducer relies on "natural allocation
pressure". That is the same condition that would make this new
skb_ensure_writable() call fail.

Other writers in the same file treat this failure as fatal. For example,
set_tcp():

	err = skb_ensure_writable(skb, skb_transport_offset(skb) +
				  sizeof(struct tcphdr));
	if (unlikely(err))
		return err;

set_udp() and set_sctp() do the same, so do_execute_actions() drops the
skb with OVS_DROP_ACTION_ERROR.

Could the update be skipped only when skb->len - skb_transport_offset(skb)
is smaller than the header size, with the skb_ensure_writable() error
returned in all other cases? That would need set_ip_addr() and
set_ipv6_addr() to return int.

The same pattern applies to the UDP branch here, and to the TCP, UDP and
ICMPv6 branches in update_ipv6_checksum().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107040238.27606-1-kylebot%40openai.com
