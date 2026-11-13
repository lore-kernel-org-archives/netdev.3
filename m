Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574720;
	b=crFKNSrU+wBOJKb7M1kTM/oEMHfbqC1n5TydcFXvq6Ta7NCo6CpqUwGv7LLFk6Z7DANl
	 nv+I4+okk/d0vIWN8UJaM5osuDCBTSvgiOuuW7uk2E6Wg4z0i8ec8Lv/CwiH/WVUGvFiV
	 iFQO3OvJjegQTpZ+QiH3pHfmUwwGXEzIuVRWjKKwCUpiqbpgehGPNVOX9rHc2GKILJGKV
	 +qoFWmq6BaQdKI17q6XCoGsMLJAVLbYZrr9kX/LBFme2E6JKTazy3dunr+ISVXXMzjs1J
	 wDOFBdJ8wfNaKm80LBcqtHcgVjH6okUhib6lS+j9zp/2tl7qoioVEotLhZfgWab/Dpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HbPJR8S7V/lAdH8GEImzC/9dsJwbaq/ITvmKn5PwyDo=;
	b=SJX5Yipajnm12bmICR0f26JuGuqAFYS5RLOMZUiGmYOJ3uh3T0e2/PeIHUEP4CuTeo+p
	 7z54B1kBuiGNDJNDD1DLWvL/MAWJ+EvYuep6jvtMdbq4t+b/1VH9dJInMwk+WCk/bZXnX
	 Z58FgPWkSLgTM+EE7o8Ac+MqY/RMeEaczlkJGLKOPUL1RDi+UU1TEhS6E+WCABde1xbOu
	 8XLE4ukTUX33bi/2RMFQ37+flnJt7avgq9lESIj186wBnsm1JcFHIxYwvt4hm+57ZOj2g
	 g3oR4Crx3qVm90N57LFFFQBQAQumhUH6mquWUSlQEteek31EWJvnNNBVZwFlJqZBn5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rcx54Hjr;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB223606A32E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB223606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rcx54Hjr
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ed3d8877e6so12820015ad.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794574719; x=1795179519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HbPJR8S7V/lAdH8GEImzC/9dsJwbaq/ITvmKn5PwyDo=;
        b=Rcx54Hjr2g/nu/NUW5elGTukc1iLZ+5oltNqc2lOWpk6GuB3Y8pB5AC3QFUIsqmFt3
         yiefb9JeD4rAM3/InTQ8OmV7s6aVyEMSnht5LtgpC6hUef677ASWreLi6Xw0tiX7MjBV
         RTlsRydF2lphapMMNssZY5wi2gP9u3H7y03GUewD/1iw9SnjZG0WEZbnYO6OQ6dopwOl
         jRvsZ1+H1VN8tDLbxe/VN4Cb/4uqQs47AfCqySFa4O79V7k2ehIZk9kV2U9QshpUn9rf
         TNU39j/DYfJgY7ikXiIx4L1pqsBHib57dIWLyt9DTpy0pPIjdTIcUcYQrnYTiflfDnbE
         svBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574719; x=1795179519;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HbPJR8S7V/lAdH8GEImzC/9dsJwbaq/ITvmKn5PwyDo=;
        b=Gide2IC6biTMbIlqq7ODbQRwo8K9nbxu1uT/0v3fF/FA2KMwAxXHuymUKsRGZ0doqZ
         Hg/CW/MJYp9vll3h0d5Ur+nLf8i6TimXmwpjpiFyrwv5btPYa6n7vKbaBXR96HsebUWW
         U85/NP13rZrT39O/+Va0pw3pRsi9FFNcCLkvZ8JWoxAXZuZqV6sYQ3Hb/3/OTmf2mLA1
         +46nCRTlZs/k0lSKuL4Xv8XrLIIiXSklgNRB6J6aIP2RrJbu5sR6G49CSEj2BLKUqAa+
         h67/1MANhgcrkHcIeQKym2hwC69LhhwTKas2vxJ+kpyMi7KUYbr5HNm76EUExyijiVYH
         F69Q==
X-Forwarded-Encrypted: i=1; AL+hErF9TT06t6SKmnxOe4YlPE2p56ldw/t5c/Q/bhYfIy2puDKD0vRsQkarqNFiK/oyEHORTJ+/nBM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KKEtDhJoCDBB/nlPyNzx7l5L37MoFn/yWFiIpUmTzeah98aOC
	ZPqITz8l6X6zl85lFFV3vyGsDndndSTmZQu8v7lN9O/DdzOhVa0R23CB
X-Gm-Gg: AYBFou2u7zeVR6oXMCFRLuHyz0jOv4zCPcBuPHNW1aJ6Jk4C2qVJcdPeaqqBnIjE/YW
	L7KtocVWGL4UeZuhTG6qY4FvrAKJoGtNsIzJmVFN9dD92mnKbSNDYnVUgbCm6N6H2GI8JYwruXL
	kZJ4qRhdIFUJ74p8GYOPSZhhLGZnSPdWsWBm+6/s+hp9IAAWBDDPzmisSQKleMZs0l4pot5jzdM
	euEWXmWy90YrdnoCA1T6xSxcLgABOgZTW52o8dgxW9VypADUQhPBDkxZgF9UaovRg2tb+glHN+9
	5pSxinnzkURVwiyyiuaPYPOJImDWqAiColL8SM9iHnjQwda34xseGGJK5SZHxwwezNEx8ZijxKu
	pNGNIq+s7w3r3kC+vhJDC5EBEK2UDyCCxJVUd14y5bDNCG+sbCgx+TpCwy3+kLDAiPG2b/Wz7tq
	+8rfZeLz4KHuGhKnKfo17YybpXXP5cuFM2tuF9n0ZAJO7nP4GpDqu+cJkRapcj8UNBrdoFpdmeM
	wLgzLAUktO9JNO8XoXjNnYXQNyc6fAV0okQc2WFYG+mtyHojCnskrCtSvkBwGlDOWermYXEpgDi
	PdKaoZ65cEbmJsADD77Zqf6EyPkQr/oPwQV4+BXBYxidm5n60Q==
X-Received: by 2002:a17:902:db08:b0:2ed:3be3:c648 with SMTP id d9443c01a7336-2ee0dd9f13emr26553385ad.22.1794574719245;
        Fri, 13 Nov 2026 04:58:39 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7e4e47sm9461925ad.38.2026.11.13.04.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:58:38 -0800 (PST)
Date: Fri, 13 Nov 2026 21:58:32 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Justin Iurman <justin.iurman@gmail.com>,
	Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stefano Brivio <sbrivio@redhat.com>, netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org, dev@openvswitch.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net 1/5] ipv6: gro: limit the number of extension headers
Message-ID: <avcJeFcatcigXekZ@v4bel>
References: <20261113124625.4010206-1-edumazet@kernel.org>
 <20261113124625.4010206-2-edumazet@kernel.org>
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
In-Reply-To: <20261113124625.4010206-2-edumazet@kernel.org>

On Fri, Nov 13, 2026 at 01:46:21PM +0100, Eric Dumazet wrote:
> Hyunwoo Kim reported that a long chain of IPv6 extension headers
> can push the transport header offset of a GRO packet beyond what
> the 16-bit skb->transport_header can store. The truncated offset
> is later used by gro_receive_network_flush() to locate the network
> header of a packet held in the GRO list, leading to an out-of-bounds
> read.
> 
> Since commit 3744b0964d52 ("ipv6: Implement limits on extension header
> parsing"), ip6_protocol_deliver_rcu() drops packets carrying more than
> IP6_MAX_EXT_HDRS_CNT extension headers, but ipv6_gro_pull_exthdrs()
> was left unbounded.
> 
> There is no point trying to aggregate packets that the stack is going
> to drop anyway if they are locally delivered. Apply the same limit in
> ipv6_gro_pull_exthdrs().
> 
> When the limit is hit, @proto still designates an extension header.
> Extension header offloads have no gro_receive() callback, so
> ipv6_gro_receive() takes its existing "goto out" path with flush set,
> and the packet is given to the normal receive path. Local delivery
> drops it with SKB_DROP_REASON_IPV6_TOO_MANY_EXTHDRS, while forwarded
> packets are simply not aggregated.
> 
> An extension header being at most 2048 bytes, this bounds a chain
> to 24576 bytes.
> 
> Note that offsets can still accumulate over nested encapsulations,
> so the places storing them should be hardened separately.
> 
> Fixes: 4b0ebbca3e16 ("net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment")
> Cc: stable@vger.kernel.org
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Link: https://lore.kernel.org/netdev/avTTQNyvwPP6LtGx@v4bel/

Tested-by: Hyunwoo Kim <imv4bel@gmail.com>

> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/ip6_offload.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
> index 700f1861d8eb..01642900c0fa 100644
> --- a/net/ipv6/ip6_offload.c
> +++ b/net/ipv6/ip6_offload.c
> @@ -26,6 +26,7 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
>  {
>  	const struct net_offload *ops = NULL;
>  	struct ipv6_opt_hdr *opth;
> +	int exthdr_cnt = 0;
>  
>  	for (;;) {
>  		int len;
> @@ -38,6 +39,13 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
>  		if (!(ops->flags & INET6_PROTO_GSO_EXTHDR))
>  			break;
>  
> +		/* Same limit as ip6_protocol_deliver_rcu().
> +		 * @proto is left pointing to an extension header,
> +		 * so that the caller does not aggregate this packet.
> +		 */
> +		if (unlikely(exthdr_cnt++ >= IP6_MAX_EXT_HDRS_CNT))
> +			break;
> +
>  		opth = skb_gro_header(skb, off + sizeof(*opth), off);
>  		if (unlikely(!opth))
>  			break;
> -- 
> 2.53.0
> 
