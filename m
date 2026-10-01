Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2815218A2
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877136; cv=none; b=aheNXx+q3gxo2eIKzjOMnN7bgnLu+mSf+fByx6/isKSwB8cTbhA0Z6ENTleoyCoAPcihcWK1l02YdezejIXTr3I/2/uy0OuhoCviPfciXiZ0HYr7o5v5m1JN2+lkZ0CzvQHqoUozQigZLmPRWR/jm3plZsWLHKd2+wxyGmSAckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877136; c=relaxed/simple;
	bh=JQTknwQvuM+WM78q7BXdSg01osnfdScnK2G806+hXXg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+CAe2jOaeiI5dUotwuRWsE91flRmNaTLHiAFREJFNSEtvJcUdS6oriJdDWtf7MnjOfUoBzRYJ/cZodYv5zs3NOEjI0utDZv9joSV5LJh+gkhy2F+tV0+HVUfkal35MDgPWZTteV2kf1sLaMEkE+AiC9mgZdDS2DY1wHV8gZT2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9PZs7Lj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9PZs7Lj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C3F1F00898;
	Thu,  1 Oct 2026 17:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790877124;
	bh=C5ZPslgdoLGskXkING6gAlYe7zipo/ZbMELISXKdMDA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J9PZs7Lj16XUVrwoX4fHQ+314rUmVqjHIfwig8ebOag35gJW0hcEyMaBzm3SBaqQC
	 mPS3px8QlTdf/XmJOikCE4iLwK8GOTkskx8P3znbS+GN2J+9TOUxGYOKX7L1JsgDBv
	 h3hcDiopI3gadQ4W7QdHAH9XHr1wghzUY9InRj35ZVkuSJ9jYEEJlgbkzKPC5SgfJ3
	 quIDM7VOfGe14/MPx7JAvQEnaX48O5RxWINi+BAt/EDGDX47iOQ89GN9obr3/plb9h
	 bik5HaOOjfKrpQD6b8dHZqPgts5WTSRm6lu3PhQNl4auocLAbjyZbfoiPPceCHS9MM
	 ELZPIQzFU+m/Q==
Subject: Re: [PATCH v2 net 2/2] selftests: net: tun: add test for VLAN-tagged
 GSO without NEEDS_CSUM
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, mst@redhat.com, netdev@vger.kernel.org
Date: Thu, 01 Oct 2026 17:52:03 +0000
Message-ID: <179087712352.434549.11484759163883432713@kernel.org>
In-Reply-To: <20260928144254.3361044-3-edumazet@kernel.org>
References: <20260928144254.3361044-3-edumazet@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The 'Truncated TCP header without NEEDS_CSUM' sub-case in
  TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum)…

--

selftests: net: tun: add test for VLAN-tagged GSO without NEEDS_CSUM

This adds a selftest in tun.c that writes a VLAN-tagged TCPv4 GSO packet
without VIRTIO_NET_HDR_F_NEEDS_CSUM to a TAP device with IFF_VNET_HDR. It
checks that the packet is accepted with flags = 0 and with
flags = VIRTIO_NET_HDR_F_DATA_VALID. It also checks that a mismatched GSO
type and a truncated header are rejected with -EINVAL.

> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index abe488bac50b..c6afafb7b957 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c

[ ... ]

> +TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum)
> +{

[ ... ]

> +	/* Truncated TCP header without NEEDS_CSUM */
> +	vh.gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
> +	vh.hdr_len = ETH_HLEN + 4 + sizeof(struct iphdr);
> +	memcpy(pkt, &vh, sizeof(vh));
> +	ret = write(self->fd, pkt, sizeof(vh) + vh.hdr_len);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);

[Severity: Low]
Would this sub-case still pass on a kernel without commit 67fbe1f8a962
("net: always dissect GSO packets in __virtio_net_hdr_to_skb()")?

The frame written here is ETH_HLEN + 4 + sizeof(struct iphdr) = 38 bytes
after the vnet header.

Before that fix, tun_get_user() reached the unvalidated gso_type fallback
with skb->network_header still at 0. That fallback did
pskb_may_pull(skb, nh_min_len + thlen), which is 40 bytes, so a 38-byte
frame already failed with -EINVAL.

After the fix, __virtio_net_hdr_to_skb() dissects the frame. thoff is
14 + 4 + 20 = 38:

include/linux/virtio_net.h:__virtio_net_hdr_to_skb() {
    ...
		p_off = keys.control.thoff + thlen;
		if (!pskb_may_pull(skb, p_off) ||
    ...
			return -EINVAL;
    ...
}

With p_off = 58 this also fails with -EINVAL. Both kernels therefore give
the same result, and the ASSERTs never exercise the thoff-based pull.

Only frame lengths from 40 to 57 bytes separate the two kernels for this
VLAN packet. Take hdr_len = ETH_HLEN + 4 + sizeof(struct iphdr) + 10 = 48.
The old kernel pulls 40 bytes and succeeds. Since skb->len - nh_off (8)
is not greater than gso_size, no GSO is set and write() returns the full
length. The fixed kernel needs 58 bytes and returns -EINVAL.

Could the truncated length be picked from that range, so this sub-case
catches a regression of the thoff-based pull? The TCPV6-on-IPv4 sub-case
above already separates the two kernels through
virtio_net_hdr_match_proto().

> +}
> +
>  FIXTURE(tun_vnet_udptnl)
>  {
>  	char ifname[IFNAMSIZ];

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928144254.3361044-1-edumazet%40kernel.org
