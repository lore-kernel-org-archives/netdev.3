Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709846;
	b=yUGtKr/e5cx2gazOpXsWFHn/AqL8IJqvcTSXMxmR6EduNcFmrGkQg2Oxw5XSWNa0JxSR
	 kGwDGAOo62PcNXzxyxqMaFTRbX2YJuJzJAggIONcXVHLIGvLZdcWmtq6rJmskzhZ+7GAs
	 f0LUWNEsR9fNnLEMYRQKWeeU8PhYTqZNRMqHSnCpcBG/kkzUAsuQ4gxGOJCcX6wEgh6OB
	 MOUNlbONUTmRkQMDVswXpW2wKvUCBHGWQFgDhCvOP/JNHMWrkV2+qPk5h6KiHIrXWactt
	 RKuUSlLIQXmqHTae5MAc09dJ4kOuVN3wce/VdTgVjQBNLjtFEgwHSo7G2tsSnSBWuZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709846;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lpn/R1aA8HbvXNstFgjD6czhaiXvrQxTqDM1qfiPs2A=;
	b=MdTYpIxsonTcQ5UCsKSZDyZP7o41D0uzsOGKn9iQEUGyq7F72Qxcjiok8Ruq2oa5gByf
	 YVuJ/aDUArvSQEbbCn7I5HF/e5xQBkeNuJFMwJL6nM66yafADLyXpH4EQyNKBM38j2qsj
	 XMCA31SG2X+WCUf63Y1IWTqRtp0Kdm8YcpWZXUdd93DpZl6/JDAN4rJo5eh+7sJdsQffe
	 Cufm+oDi7zYtlZoZd/Aw6fDZkZEOUjJFmUJsmSxD6OzK4UTJyhE4kBnM9HOmkGkpEsk6j
	 xCvEqXuMoNTTwmjxiOk3lFfimMNM7GyFF0PZxD9OwEwPpbTHuTJkYdrfPM43D1+bQog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vs1HNlQv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6893606D827;
	Tue,  3 Nov 2026 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vs1HNlQv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833C01F00A1F;
	Tue,  3 Nov 2026 12:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709845;
	bh=lpn/R1aA8HbvXNstFgjD6czhaiXvrQxTqDM1qfiPs2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vs1HNlQv6Lvx4JAage7a7MTsuDjgmPpu/IRARR9pWT086+jouhGDlqWB+rUFjtCBf
	 0QxnO1rn6Z5DLQvQv7wUJ+xc6xpJ2JguJMGSvixdayN5NFT6vNtZ5CgMkPr1+k/ti3
	 nXpswpwt5WBYPGkUOuQXS/Dkmp3/DsVP3/plpA1A96BuKCkHecy100rAIJyJyhzAgD
	 IJLQ4UjqdZowQpzf+1xAztAbAB+Hl+H+PFsaWx2XhYRkzWIHc+CGEMYabs3HQ2AOSG
	 ZHKWC2XhaRAb9ol1FLy2GX8oPXXNt8GaEGiE5ExkO+FdU8PLMCFlMxU7T+fitDEb7W
	 tWTvcXKPKVvIw==
Date: Tue, 3 Nov 2026 12:44:00 +0000
From: Simon Horman <horms@kernel.org>
To: Julius Bairaktaris <julius@bairaktaris.de>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, steffen.klassert@secunet.com, willemb@google.com,
	jiayuan.chen@linux.dev, mfleming@cloudflare.com,
	almasrymina@google.com, bigeasy@linutronix.de,
	richardbgobert@gmail.com, ecree.xilinx@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/4] net: gso: count the inner UDP header of
 encapsulated UDP GSO packets
Message-ID: <20261103124400.GK865646@horms.kernel.org>
References: <cover.1792838740.git.julius@bairaktaris.de>
 <7b6a12fbe0853f7faf2987610e25957d2017bd54.1792838740.git.julius@bairaktaris.de>
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
In-Reply-To: <7b6a12fbe0853f7faf2987610e25957d2017bd54.1792838740.git.julius@bairaktaris.de>

On Sun, Nov 01, 2026 at 05:42:30PM +0100, Julius Bairaktaris wrote:
> skb_gso_transport_seglen() adds the inner TCP header length for an
> encapsulated GSO packet, but not the inner UDP header for
> SKB_GSO_UDP_L4, whose gso_size covers the payload only. Every segment
> of a UDP GSO packet in a UDP tunnel, built by UDP GRO behind a tunnel
> socket or sent with UDP_SEGMENT over VXLAN, is counted 8 bytes short.
> ip_forward() and ip_finish_output_gso() then let DF segments that
> exceed the MTU by up to 8 bytes leave unfragmented.
> 
> Add the inner UDP header as the unencapsulated branch does.
> 
> Fixes: ee80d1ebe5ba ("udp: add udp gso")
> Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>

Reviewed-by: Simon Horman <horms@kernel.org>

