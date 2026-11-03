Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709860;
	b=xBcHpvGmWuEx4FU2b+M7t0TlfSQVaFJzSY3a2OYCMLLj6neO0sFf+iatYdgApzwoOzMz
	 TKska/g0I/UksHtv0iEabg9GQM5w5zG8m8pDcbRcO/mn+sqCL5o1BTwUnXJEKXKTpEciR
	 MFiJWC2kFed+wSBCmR0A+bH8yvgVKN06TUPNWm6pcUIp7ZYGxOXonCvKU1B1/h16a4j50
	 2W7fH/ZbyDqreXn+dn6PZXX5G4vqilbNU+u+SlX8D6LLiQtCpUNEI2NNHquxPs+ztCsSD
	 LLYeV1xykxaxxCSlcLyrjKKjjOaOcWA9cut4RRGigM1jOVaOmu1Tzk4OAo8HkPJKmkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709860;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=atMkXfqr6wyCsQOzsxiGqMDY9n0JIabptthQIwanW2g=;
	b=WQH4VKqiAnaOLH3c1Jw/tQGW+aM+2qzpFYxH+hmj7GCCWSLjh3RB901EJXM0TN78ylvX
	 EFRgxEdajAHPohgUkQ0kJRARB/RejJtQhaTdiZWfUkR9oYfcqEZdbhUSzJUH33VhR9y9n
	 03a2JJEMDWJ3DsR3aXt2P1r70fG3NEjEefcPHzeou+CfTKim0lUGMRFErudCYaShnqB2i
	 eTVvly3rvJ5jQ44mFSSiMYkfuAe411FWIsN1Y4uTtbqjvCNXLuy8dxHaAKf52Yzx1q1KV
	 ObDfa4qHWuhO7lKDlEI/tx3uoiGeW/+RwI30wvOHqUjs4kCZJgG+AUAbRgdC/TKpSfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ro50EDUf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478D0606A324;
	Tue,  3 Nov 2026 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ro50EDUf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A961F000C1;
	Tue,  3 Nov 2026 12:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709859;
	bh=atMkXfqr6wyCsQOzsxiGqMDY9n0JIabptthQIwanW2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ro50EDUf2JTOPvvt1KsKyd5ZxD3Rd3dNDEvWdjTOB0lWyYtUk74h0ifOtV5ZkUi5r
	 j7GjzVO7aTRF7QqvyZNhHjgP3ar+XhjYPW7PoHoJWYzH2FwWernPHKZv7clJD0M4fr
	 l5UXp+dOcxEtd/T9KW0aoxkZgbrc8nHX8vzTMvImkOcQdVruJzGv1YxP+ALbp0PztD
	 0OkoKXJmhzYtXUtnVyf4GzTEn0K6f58E5lKA0eSEPNynANIclGvU9RBrOEKK1PduBF
	 lK60ryoX/xPDB0zA4mACM1ki2WKCSbPdq85Fnhq3Kx5KXh6iqDXRvLlz/ohSGDw+8B
	 YT0tCSz1aumEA==
Date: Tue, 3 Nov 2026 12:44:14 +0000
From: Simon Horman <horms@kernel.org>
To: Julius Bairaktaris <julius@bairaktaris.de>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, steffen.klassert@secunet.com, willemb@google.com,
	jiayuan.chen@linux.dev, mfleming@cloudflare.com,
	almasrymina@google.com, bigeasy@linutronix.de,
	richardbgobert@gmail.com, ecree.xilinx@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 3/4] ipmr: set up GSO state for tunnel vifs
Message-ID: <20261103124414.GL865646@horms.kernel.org>
References: <cover.1792838740.git.julius@bairaktaris.de>
 <529dd7ba1395f17c0b328ab2a597769809cbe720.1792838740.git.julius@bairaktaris.de>
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
In-Reply-To: <529dd7ba1395f17c0b328ab2a597769809cbe720.1792838740.git.julius@bairaktaris.de>

On Sun, Nov 01, 2026 at 05:42:31PM +0100, Julius Bairaktaris wrote:
> ip_encap() pushes the outer IPv4 header but does not set SKB_GSO_IPXIP4,
> skb->encapsulation or the inner headers. A GSO packet forwarded to a
> VIFF_TUNNEL vif is then rejected by ipip_gso_segment() and dropped in
> validate_xmit_skb(), after being counted as sent. A device with UDP
> segmentation offload is handed a GSO packet whose transport header
> points at the inner IP header.
> 
> Call iptunnel_handle_offloads() and skb_set_inner_ipproto() as
> ipip_tunnel_xmit() does, reserve one outer IP ID per segment as
> iptunnel_xmit() does, and set the outer length with iph_set_totlen(),
> since a GSO packet plus the outer header can exceed 64 KB. A GSO packet
> that GRE or UDP tunnel GRO marked as encapsulated already uses the inner
> headers for its own tunnel; drop it, as segmentation did before.
> 
> Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>

Reviewed-by: Simon Horman <horms@kernel.org>

