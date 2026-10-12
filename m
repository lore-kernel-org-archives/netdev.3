Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411ED4BD376;
	Mon, 12 Oct 2026 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825594; cv=none; b=EQ9vbDVcijWA2KyPmzuRVv8tYOnkbIIhtJ2WUpXFOEjl5+lktW5x9ZKo/lmNJmXs6kaoYVYTyKVt+4cp/A2sGiRTJKrXLUF7Ml8XpwyVa8VTGSI9TMR0BLQhkvYWkg7Cnh9JyMELJ2ucCki7i/hrDvkm1lWZXiLXBhG3EDt4FU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825594; c=relaxed/simple;
	bh=gavtnPFpyusz4wSwAGMMnk0Ajnd2ottY8GiJne6uPL0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IMaJNl66OAraEM4cZqifnZnRY6EHJ0699C5/vRcC1txYCJ8HqezBpt2BXXP6SOjECR5632B2wtp9ETPbmDFITkYG5DqbG0H+PuatuV+sNR41Z4cynBy0o4pixmGKD5dbhvC4q1gTrcMPrknTnIZpURVknb1AX+SDp9nuZuPyklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSgy7fq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSgy7fq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7F81F0089C;
	Mon, 12 Oct 2026 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791825593;
	bh=u0GoKvSM+AvUeQLfBn6vY1JU0K/zsDsPiEjubaTWqKk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PSgy7fq8ZOLzXGZ+/kE6MpET33N2vM7KJhElzMWMmxFrFCY15AOchI1bU9RWRsBLX
	 JuiX/gHq2jRUicgUIzcPMBfJ4gHeWlUemBZRtq62C5YuHe7rSdEGH0fy+gbIn0zEFv
	 kR6slvuMJqgaRtlV3a0br/++o2PJGULRWLDcqtEjNlodMr/qRVZPWA3bs0pDq+wPop
	 hsw0UgHnKm3OXBTm36xlaoaB/KDcuqbzQncvzIXp9rQ8k4sfBeuH6YGhaUKFoxA9vT
	 uHsQzQaV9DufJ6+VXewqRP74OjbCHpzGxmPO98kBzxHMzY+PXgFDm0KiCmeio7oniI
	 qxDOxBDS2sNkg==
Subject: Re: [PATCH net v2 1/3] net: make room for the tunnel header in
 skb_segment_list()
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, steffen.klassert@secunet.com, willemb@google.com,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 17:19:52 +0000
Message-ID: <179182559205.434549.15722340017210216290@kernel.org>
In-Reply-To: <20261011162957.1328474-2-julius@bairaktaris.de>
References: <20261011162957.1328474-2-julius@bairaktaris.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes the bug only as an IPIP case that
  ends in skb_under_panic().

--

net: make room for the tunnel header in skb_segment_list()

This patch adds a skb_cow_head() call for each frag_list member in
skb_segment_list(). The call happens before the member is pushed back to
the outer MAC header and the tunnel headers are copied in front of it.
The stated goal is to avoid skb_under_panic() when a fraglist GRO packet
is forwarded into an IPIP tunnel and segmented in software.

> skb_segment_list() pushes each frag_list member back to the outer MAC
> header and copies the tunnel headers in front of it, but never checks
> that the member has the headroom. A fraglist GRO packet forwarded into
> an IPIP tunnel and segmented in software hits skb_under_panic() when
> the members were received with less headroom than the tunnel headers
> need.

[Severity: Medium]

Does this description cover the whole impact? The same missing headroom
check seems to also allow a silent out-of-bounds write before
nskb->head on the UDP tunnel GSO path (VXLAN, GENEVE and similar). On
that path there is no skb_under_panic() at all.

On that path, __skb_udp_tunnel_segment() resets the mac header to the
inner header before segmenting:

net/ipv4/udp_offload.c:__skb_udp_tunnel_segment() {
    ...
	__skb_pull(skb, tnl_hlen);
	skb_reset_mac_header(skb);
    ...
}

After that, skb_tnl_header_len() returns the full outer header length
inside skb_segment_list(). That is 50 bytes for VXLAN over IPv4 and 70
over IPv6. Meanwhile, offset is only the inner MAC length.

Before this patch, skb_push(nskb, -skb_network_offset(nskb) + offset)
only moved each member back to its own received inner MAC header, so it
never triggered skb_under_panic(). The copy that follows is a plain
memcpy with no bounds check:

net/core/skbuff.c:skb_segment_list() {
    ...
		skb_copy_from_linear_data_offset(skb, -tnl_hlen,
						 nskb->data - tnl_hlen,
						 offset + tnl_hlen);
    ...
}

If a member has less headroom than tnl_hlen, this copy writes before
nskb->head. For example, a napi_alloc_skb() member with NET_SKB_PAD (64)
headroom, forwarded into VXLAN over IPv6 (70 bytes), would get 6 bytes
written before head.

vxlan_setup() advertises NETIF_F_GSO_SOFTWARE, which includes
NETIF_F_GSO_FRAGLIST. So fraglist GRO packets can reach this path
without being segmented first.

The new skb_cow_head(nskb, offset + tnl_hlen - skb_network_offset(nskb))
reserves the push length plus tnl_hlen. The code change therefore seems
to fix this case too.

Could the commit message describe the UDP tunnel case and the heap
corruption, so that stable and security triage don't treat this as a
crash-only issue?

It might also be worth saying that skb_cow_head() now unclones members
whose header is cloned before the tunnel headers are written into them.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011162957.1328474-1-julius%40bairaktaris.de
