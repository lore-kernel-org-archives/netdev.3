Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709884;
	b=UCCaPxbkeLrRrFB6Ghnp8EixS4ypTZ7QA0Mqvfxq6r8LAeZOzll4LboGGM+12uIr3i1G
	 593em1kTrFuGj/45u7d9kWAT1/FHCm2A8bXbbjUHRwIcDkpZ91sr86TSrH0Jd/4a2ePTn
	 H02Qux4ocfp/XJr/82cLgqwIIZ5fowjJJYBwrW6Sh9nn+2rKl00efASkqyHH8A3tSe2rg
	 4hoPCcf5ehSniDy7j0RtGhM6mUK6hA2Ug7/QqErGzum36pfav6yws49JV4mSsYSdDsrGM
	 svlJlaYb1IAb89q4w6ai3/mtBdo+wj+bHHwCVpNaurcni9C8EIDup9nMjK5NrquL5NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709884;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Tmc7avZ1TScdVSl8+sWmq3B5heD1yOD8qxdj3oQCY1A=;
	b=JL1e1sCGeU5dZ9Mcm4NphZXYWYg/B/4Z+whRaLlrSA91cv40MCYwkGVkS7of1Gxez6vK
	 P9tMzU8qBQQQJi7yQv2ryT4B/TSCWx/Ji9ttIVZ/i1kS73hxWA90GvlKGtJWPEydJBksF
	 j89o40Mw9TI+QnH6CV+Age69Wux2pnBQ16UaXJcp6Njxuuw7uG8S2kzLag6W0GYJOYCds
	 czwHm8QPvD295KqaVed32HMO/5xJpdLdFcgJtCOyLfSdYb/TSVAHRJRJ9y2cBBjlc4qyn
	 M8SZu2CEz1YOE9XjgeuntYfTK/+1cnciNJXb+qv3M03KfVW54vkuHppnsI0nV93ct4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozayK0xu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E9606A324;
	Tue,  3 Nov 2026 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozayK0xu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A9C1F0093A;
	Tue,  3 Nov 2026 12:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709883;
	bh=Tmc7avZ1TScdVSl8+sWmq3B5heD1yOD8qxdj3oQCY1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ozayK0xu0E2zRXw3DA2tgIY4Dwsw4VmVukIXfFvJpwU+HXMyrdxtnITex7SoKVmqh
	 wSMVp//z7kLNbdxQ8CrLXiS4gyIv5FRCX60lY4L1paIHlQIEK4UcIZQC0nOYGhcpQC
	 KWl3eZeRdaGE210dw0oPU3//PqfME4xdZ0zBXevM2VjGgHIsp2aCa5L958+H/9NoQz
	 ix5tZjfEQ5FK6Q/JPExOZ/CG3ld8Y/s7G2PB3cRZCdlu5i/LUVkl7Zf+WRhfZMjBnJ
	 yXiMUrD4lq1jPcbkZptXgmImn3WKCwjXg5OE65nPMyQs0VD0ZYmXYPRe2xkgLDB0Fh
	 V3B/koq3LM14Q==
Date: Tue, 3 Nov 2026 12:44:38 +0000
From: Simon Horman <horms@kernel.org>
To: Julius Bairaktaris <julius@bairaktaris.de>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, steffen.klassert@secunet.com, willemb@google.com,
	jiayuan.chen@linux.dev, mfleming@cloudflare.com,
	almasrymina@google.com, bigeasy@linutronix.de,
	richardbgobert@gmail.com, ecree.xilinx@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 4/4] ipmr: do not drop GSO packets that fit the
 MTU after segmentation
Message-ID: <20261103124438.GM865646@horms.kernel.org>
References: <cover.1792838740.git.julius@bairaktaris.de>
 <3733295a358d34df6220ea924d2b710ca537cf6d.1792838740.git.julius@bairaktaris.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3733295a358d34df6220ea924d2b710ca537cf6d.1792838740.git.julius@bairaktaris.de>

On Sun, Nov 01, 2026 at 05:42:32PM +0100, Julius Bairaktaris wrote:
> ipmr_prepare_xmit() drops a packet with DF set when skb->len exceeds the
> route MTU, without checking whether it is a GSO packet. A UDP multicast
> stream received with fraglist GRO or UDP GRO forwarding enabled is
> aggregated into GSO packets, and every aggregate is dropped with
> FragFails, while ip_forward() lets the same packets pass by checking
> skb_gso_validate_network_len(). Do the same for multicast routing,
> leaving room for the outer header on tunnel vifs. ip6mr has no such
> check and leaves GSO packets to ip6_output().
> 
> On an IPQ8074 router with fraglist GRO on, a 10 Mbit/s stream of
> 1316-byte DF datagrams routed by igmpproxy loses 14.5 to 15.5% (n=3)
> and 0% with this change.
> 
> Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>

Reviewed-by: Simon Horman <horms@kernel.org>

