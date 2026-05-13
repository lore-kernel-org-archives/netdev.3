Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8621D30676A
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663889; cv=none; b=A2SGHcD65t2i7wyvAzk2rWCjU5A+SqSwLVpb221/mcuA/ogsDTv81/jRppmIWOcjhGa+Xi7IpVkmFkdygEsL+Wjg57iWo3uc/e3g+ky5v/uUzGQMLLO5fwREMwpnAPrWMEucx/Ta9UlbgxClDTg2cgOQ/Ly1pZ4mLzE9juI9fvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663889; c=relaxed/simple;
	bh=raMftH6D9YARKJvdfPGfZLGMahxfFWS658sdsOIS1AY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nSnTBz4OlsO6oq0FMML9MS91Xp3ORYWwQnERIqpiai1gbvrEY9mXX+TXjFPXiQ3PG5MyjbULRzVIyI9ojpn3sXHVBA3PNKwrnmWTjO8Yr45exfy6EBZ5+bZ2iPoczOXiy9yS+6M8XyIS5Fzz5+RmgXXZQ5+6CQBFTXbcczjtyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=D0yZT3v2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=THx3x4p7; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="D0yZT3v2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="THx3x4p7"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 16A647A0185;
	Wed, 13 May 2026 05:18:05 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-10.internal (MEProxy); Wed, 13 May 2026 05:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778663884;
	 x=1778750284; bh=CZzyZnP316grrL9Fo/vVZ+OYfn6mmxN+qddwd2EOk3I=; b=
	D0yZT3v2dLb6295rRc1924QmXhbB2Tjl6ntxBqugrr7HzJbVu8pw01VhRzOCmVlC
	wBmg8Ogk7aLc8eLKOw7VMjjRY/S16XbtgE+JTvZxQmAMulfRHKdTXYH5/JcmiS1J
	DK2ojBY7+ThiP3G4F4Tx4j2233MUQoFD/AEHocp0Uc/GqgN7RWLoRmbdws4dGXrc
	oXM4jlml3FZUhWoTF1eRy/hFKhD6/vHy5LVFoAIHw8cGvSMrL7gKKrxGGlhdDgPp
	LLiJACFopLFykXJUclv8UshFatz9j4lXAqoDSMqMa3zva2P2Kn3sRyKM94Z+TV7J
	SajTCY3CO9gfJDkgAlvcgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778663884; x=
	1778750284; bh=CZzyZnP316grrL9Fo/vVZ+OYfn6mmxN+qddwd2EOk3I=; b=T
	Hx3x4p7HXUnL+FmIPPnRxKfXe9DY9t7vzTCE2BAElVlLn60easKbnBtztIyq4HnH
	eFpGpQY6q6MmCCC/vmFH1FDCwq2RbESgWaQgaT22Na6ZhMUOuNXWcApu+dpi3zoA
	FMDMoYc1tNIRvNJApNu7OCqP6clCJTfH4oXl4SnKLZomin1Xz6JHv6Puyp7ifJEr
	Emc2ztjtFgUB55G3hQe+IOglzX5SbXFqVpOPQokPOff7dOnQEVi0mVuzfBLyfItn
	v2AucYBZh1e3hgiFYRfS0abQpfUhKpxyjQicyl92Bq4SzUoZn/RlIbVmryHvDR/r
	atcPgMvNfFCp4S5ItemcQ==
X-ME-Sender: <xms:zEEEaqNkdIhaMnNM5mvQ_aGgEIMLz7tKM7dDIzXQx7yZ2yWWSqXuLQ>
    <xme:zEEEajwfzKe-x9aCLspe6oeE0HA2rITl53d5ZZKpssXf3V9sRPLADSLBfOdjw8-7X
    dtlFbKk04gYD_XlaszQgYPr76uCNly2Gk1tF11Yrh-oEpZYNfVcXE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehlihgt
    vgcuofhikhhithihrghnshhkrgdfuceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrg
    hilhdrihhmqeenucggtffrrghtthgvrhhnpefhgfevgeeljeegleeiffduheegieehtdff
    tdetvdffieelkedthfejleejgfeftdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgt
    vgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhnsggprhgtphhtthhopeduuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdr
    nhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepfihilhhlvghmsgesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmshes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmrghtthhhvgifrdhstghhfigrrhhtiieslhhinhhugidruggvvhdprhgt
    phhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepug
    htrghtuhhlvggrsehnvhhiughirgdrtghomhdprhgtphhtthhopehgrghlsehnvhhiughi
    rgdrtghomh
X-ME-Proxy: <xmx:zEEEat7IZ8TEGj7bauXbLjcxX9OvfbCQD6mU0INud6Q8VRJG8DYmJg>
    <xmx:zEEEapKAyPHdW-Nv1pObXDrCFb9NlX0pxMK_SbceJoRz6_LG4-T5lA>
    <xmx:zEEEatwtyC_HsC5lyUuzFRj4eIVx9hbey9RhWSME2w9vjxd1jCOohw>
    <xmx:zEEEapIBJDeiofR2R5f1hz8md-NbpJPWjgtnjCVMvrZ29EzYdXskZg>
    <xmx:zEEEavNRoFumzAC8ekjwRJwzCxjLIvRSyepnTa6qj-8Y_YJATDgZOzHg>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5D2DAC4006E; Wed, 13 May 2026 05:18:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 May 2026 11:17:43 +0200
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Gal Pressman" <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: "Simon Horman" <horms@kernel.org>, "Dragos Tatulea" <dtatulea@nvidia.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "Matthew Schwartz" <matthew.schwartz@linux.dev>
Message-Id: <f75c1cf5-b5ad-47db-952f-faad9f0a33ed@app.fastmail.com>
In-Reply-To: <20260513074349.2152146-1-gal@nvidia.com>
References: <20260513074349.2152146-1-gal@nvidia.com>
Subject: Re: [PATCH net] udp: Fix UDP length on last GSO_PARTIAL segment
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, May 13, 2026, at 09:43, Gal Pressman wrote:
> Following the cited commit, __udp_gso_segment() writes single MSS length
> in the UDP header.
> The cited patch doesn't account for the fact that the last segment could
> be a GSO skb by itself. This could happen when the size of the packet is
> a multiple of MSS, hence the first segment is also the last one (there
> is no need for a remainder skb).
>
> When the post-loop segment is a GSO skb, assign the single MSS length in
> the UDP header.
>
> Fixes: b10b446ce7ad ("udp: gso: Use single MSS length in UDP header for 
> GSO_PARTIAL")
> Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Closes: 
> https://lore.kernel.org/all/6c3fb15e-711d-4b8d-b152-e03d9b05293f@linux.dev/
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  net/ipv4/udp_offload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index a0813d425b71..71df45f9488a 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -604,7 +604,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  		       seg->data_len);
>  	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
> 
> -	uh->len = newlen;
> +	uh->len = skb_is_gso(seg) ? msslen : newlen;
>  	uh->check = check;

This is going to have the same checksum bug as your first commit, which
I'm fixing in [1]. You should use the right value of either msslen or
newlen when modifying check a couple of lines above.

That said, maybe you can base your patch on top of my checksum fix? For
the last packet, it will then be:

if (!skb_is_gso(seg))
        newlen = /* the new value */;
/* keep newlen as is otherwise: my newlen is your msslen */
check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
uh->len = newlen;
uh->check = check;

[1]: https://lore.kernel.org/netdev/20260512165648.386518-3-alice.kernel@fastmail.im/

> 
>  	if (seg->ip_summed == CHECKSUM_PARTIAL)
> -- 
> 2.52.0
