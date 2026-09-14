Received: from mta0.migadu.com (out-130.mta0.migadu.com [91.218.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5582522A7F6
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367677; cv=none; b=kkER3YpJLHS3xOHmhCmZkJjRBh0J1bPEjVTzYYJShgpMA7ZG6GBzwGdrOI4sq8xojTa9+/ZYJC7C5TgqPbPGp2JvOq+58XStC/5ljlHS2jg97I77PVj/sEU8OHAhkJhtLxmG6YvU638T8thh3hb55VgBViyQoMHlbNmGDofiWtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367677; c=relaxed/simple;
	bh=aNc2vIq5VHhrkQZVzL865jZWWie+LzfHllkVeQTfLPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e25FCY9Zx1ajUzrYtthumjVeXcLXjm4l8ADH7qDDy/Igjtr4ofiL3rQRRcxq853res2ZUKLqofqKd4lq0Hx6ojzicQOn1YB+1PnoEd42p0oiER0k9YjVtIHuu+Q5+flRoInl1ljNLRY0A/CmJlmaMuoPesf1V69SahrPeQ62EeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PQ0Ul0zs; arc=none smtp.client-ip=91.218.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PQ0Ul0zs"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aNc2vIq5VHhrkQZVzL865jZWWie+LzfHllkVeQTfLPE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789367673; v=1; x=1789972473;
 b=PQ0Ul0zs9XSfqDRkqnWXHN2OYGU+y/b0ehxe4qp6b37707AcLxk/TfXtdLLXeVIAFFPGNB7t
 ec280SEkJO/cfs63euukUTy8/JFd9YxnWld79c0mS78tEmAUndoYr9wM74Jk+HkzoyyFK1sb/+w
 TaLIMbzYN67mCHxNrykOAtVo=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id c8828078a668acb4;
	Mon, 14 Sep 2026 06:34:33 +0000
X-Mizu-Trace-ID: c8828078a668acb4
X-Migadu-Flow: FLOW_OUT
Date: Mon, 14 Sep 2026 14:34:21 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lebrun <david.lebrun@uclouvain.be>,
	Stefano Salsano <stefano.salsano@uniroma2.it>
Subject: Re: [PATCH net] seg6: set IPSKB_L3SLAVE from IP6SKB_L3SLAVE on IPIP
 decapsulation
Message-ID: <aqeVbZJX1htjy6_x@fedora>
References: <20260913194421.31-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913194421.31-1-andrea.mayer@uniroma2.it>

On Sun, Sep 13, 2026 at 09:44:21PM +0200, Andrea Mayer wrote:
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
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 7b5212220185..d1070aec7b72 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -257,10 +257,13 @@ static bool decap_and_validate(struct sk_buff *skb, int proto)
>  		return false;
>  
>  	if (proto == IPPROTO_IPIP) {
> +		bool l3slave = ipv6_l3mdev_skb(IP6CB(skb)->flags);
>  		int iif = IP6CB(skb)->iif;
>  
>  		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
>  		IPCB(skb)->iif = iif;
> +		if (l3slave)
> +			IPCB(skb)->flags |= IPSKB_L3SLAVE;
>  	} else if (proto == IPPROTO_IPV6) {
>  		bool l3slave = ipv6_l3mdev_skb(IP6CB(skb)->flags);
>  		int iif = IP6CB(skb)->iif;
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
