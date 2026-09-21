Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403DB4A3F34;
	Mon, 21 Sep 2026 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003656; cv=none; b=LpMuwNuLoIux9JSmmb3g82CL96EDu99OZ2lG0Q+b/DOJBVEdXHuIma9Z7n3sw3ybNXQsRJh6dYo6+pz8irGtNmBAGxQ7iqWVFpuWjiJ0LryZwJD9Sa5VPbzEWTUFEAE6Muulhxi86ZzEWLpOirefV5LuZLhtoNexwMeWgec+DeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003656; c=relaxed/simple;
	bh=V8uEpj3nim/mWnF+DAzb/sgomJixghaCpEwApMJMGKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5jD4fII93fm4OcnPy2+sCoy4ugZmwc/dLp0fsY9zN7G6ZpcDfF1ita0N8eBfCXGs514QEyWYoiBOAq2ryNbgf+unzd7L1wIjJbxcUF2b0jMrbGf4qddlEz/gv+0KLJeNYJxY1pO22pYFwhGzwLWsWaK7O3OMXCgXg3ZhUJoBz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUBFYUgw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUBFYUgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516B71F00893;
	Mon, 21 Sep 2026 15:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003654;
	bh=Rpgx4CLN3b9dZK0aGYB6vRewYDqVU6M4yiv44MWiT8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eUBFYUgwjmVYJtQjoJ3sAU+3Xx35J9pncdvBniJGHyIP+rbu1NhjF2xLtGk9tyeZ6
	 /w3che3koWRMDgbTg/xxw5Md1t8mXPleH5ivV9yPTZvVHmNs+oKdScYGW5tlF+TDGS
	 gcMQQ50GcgeFXMEP9m3Kk2mGL06AWPTRZcmh+7P9LrHj+wM0snhCT7wBoo6PQOwjM/
	 fNNqpuSJ+WtGOBxbFhQROX093Vyrmitvyf57T+Jk+8QRQXox056a50adq6Du/PdwK9
	 aQuQ9zYoX/4wKHGqBdD/kZQfR+8cMV0rzE+0AdDUbK3zY7/FeOZV+F/Tsnrb0k3jH8
	 Wg4bLh74YKS5A==
Date: Mon, 21 Sep 2026 17:14:10 +0200
From: krzk@kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: alex.aring@gmail.com, horms@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, davem@davemloft.net, 
	linux-kernel@vger.kernel.org, dsahern@kernel.org, edumazet@google.com, idosch@nvidia.com
Subject: Re: [PATCH] ipv6: exthdrs: copy old IPv6 header before
 skb_mac_header_rebuild() in ipv6_rpl_srh_rcv()
Message-ID: <arFJv0KqUdo_tp_y@quoll>
References: <20260919210618.3028986-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919210618.3028986-1-benquike@gmail.com>


On Sat, 19 Sep 2026 21:06:18 +0000, Hui Peng wrote:
> In ipv6_rpl_srh_rcv(), after pulling the compressed RPL SRH and calling
> skb_push(skb, chdr_len) to expand the buffer for the decompressed SRH,
> the function calls skb_mac_header_rebuild(skb) BEFORE copying the saved
> IPv6 header from oldhdr to ipv6_hdr(skb).
> 
> When chdr_len - pull_len < skb->mac_len (for example, an 8-byte
> expansion with a 14-byte Ethernet MAC header), the newly rebuilt MAC
> header at [skb->data - skb->mac_len, skb->data) overlaps with the old
> IPv6 header at [oldhdr, oldhdr + 40). Calling
> skb_mac_header_rebuild(skb) first overwrites the beginning of oldhdr
> (version, traffic class, flow label, payload_len, nexthdr, hop_limit,
> and the start of saddr) with the Ethernet header bytes, and the
> subsequent memmove(ipv6_hdr(skb), oldhdr, sizeof(struct ipv6hdr)) copies
> those corrupted bytes into the new IPv6 header. Moreover, oldhdr's
> nexthdr is only updated to NEXTHDR_ROUTING before the pull, which also
> gets clobbered by the overlapping MAC rebuild.
> 
> Fix this by copying the 40-byte IPv6 header from oldhdr to skb->data
> immediately after skb_push(skb, chdr_len) and before calling
> skb_reset_network_header(skb) and skb_mac_header_rebuild(skb), and
> explicitly setting ipv6_hdr(skb)->nexthdr = NEXTHDR_ROUTING.
> 
> Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> 
> ---
>  net/ipv6/exthdrs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



