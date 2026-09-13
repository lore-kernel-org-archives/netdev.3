Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FED3BB115;
	Sun, 13 Sep 2026 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789330786; cv=none; b=A0N6beg6aWgo15JHVsOADVL/zdgZvd5SBfJSazN44uRp/oBm1fZkCvLXhZKAjcqHHsOZ6gBidmPm7yefWN/EK4V2L+UOHPLVDI0MOsc1ysHo31PLyXXfOTVml5oHtOQcMLpslF2KT39S/823sNEPaBZ/u67aNZyd6gm8dIgQuzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789330786; c=relaxed/simple;
	bh=MoUOPZz0PhemKa/PLV/7eBD6VJYFQ8zpuQFOhyMwdM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Odxf3WTru/qvslEaVAT2UA64VfJe6+5rcsG8QNng1oCA2h5I0sUiuBv48mLlP8VhyV4rJelEQ00uWHBotP+najnakPJx7YIo2nw5DUka5vYWYgxFHCsf75LY6gvxe51fRFYA4QJVDVDfCQRp0dmT6Rxnn9p33QcPPtcbmXht7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbEEY/ZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbEEY/ZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DCB1F000FF;
	Sun, 13 Sep 2026 20:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789330783;
	bh=JJd6I2+ld2ON+yhSmepyu1oAfhZ7/xRJVTKCC+Hy8YM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GbEEY/ZOQxkVes/sx79G3iJDTYwAnKocdMBppYFX0Y3AxduU/2REBRk6ytxVxiv1Q
	 MctFuXOfdY8C8WdJ2cNHKYyKfCuSvl7Qjvcd9H8M7ktiLb4B7HOTOWmqswt1K3Kwhe
	 212ars609/WaS1Sk0v8AF388f6sGdag45QMWBE7eussC/zeBPw3WB+WXJyq2UjPT0v
	 H2aL0Fg4mV20QnfI6OcrYi2+OXBV0ayE/HF0t/oZVOrELwut6CZgPXFqfdL3kGTugp
	 jnxTRNfBh+90bSUh0Pensqy8uBy3teBIx8Q9xRmNzhpC8p2n69O/aDNDH4h5QVe7fV
	 +IYddKkGd1l4A==
Message-ID: <7c095018-267f-4097-9d38-fe116041f47c@kernel.org>
Date: Sun, 13 Sep 2026 14:19:42 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] seg6: set IPSKB_L3SLAVE from IP6SKB_L3SLAVE on IPIP
 decapsulation
Content-Language: en-US
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Lebrun <david.lebrun@uclouvain.be>,
 Stefano Salsano <stefano.salsano@uniroma2.it>
References: <20260913194421.31-1-andrea.mayer@uniroma2.it>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260913194421.31-1-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/26 2:44 PM, Andrea Mayer wrote:
> When an SRv6 packet arrives on an interface enslaved to a VRF,
> vrf_ip6_rcv() sets IP6SKB_L3SLAVE in IP6CB, but decap_and_validate()
> has never set IPSKB_L3SLAVE in IPCB. The bit stayed clear in the
> common case, and with CONFIG_IPV6_MIP6 the leftover frag_max_size of
> a reassembled outer packet could even set it, with no VRF involved.
> Commit 44930446dde4 ("ipv6: seg6: clear IPv4 control block on IPIP
> decapsulation") then made the unreliable bit reliably clear.
> 
> The effect of the missing flag is visible with End.DX4 when a
> delivery to a local address of the node reaches the socket lookup.
> For example, a UDP socket bound to the enslaved ingress interface
> does not receive any of the decapsulated packets, while an unbound
> socket outside the VRF does.
> This contradicts Documentation/networking/vrf.rst: by default the
> scope of an unbound UDP or TCP socket is limited to the default VRF.
> 
> Set IPSKB_L3SLAVE for IPv4 in decap_and_validate(), which already does
> the same for IPv6. The socket lookup then matches the decapsulated
> packet like any other packet received on that enslaved interface. Such
> a packet matches an unbound UDP or TCP socket only when
> udp_l3mdev_accept or tcp_l3mdev_accept is set.
> 
> Fixes: 891ef8dd2a8d ("ipv6: sr: implement additional seg6local actions")
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  net/ipv6/seg6_local.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


