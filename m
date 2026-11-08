Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794114231;
	b=dpHE4Punzze+/Fca1D6WDIGlJfwdw1pYaZJWbzoqorYhrSuzAClrpmq+8AsZPRNQlWQh
	 CgTrE+BK7HQfL/c8zZytjEq7CuLhQFfKJ9rZZRrj6x6XOgU9J1Uf6+iPx7eaAXJUfYmMD
	 uS9E1UNXR4uFGZ+dRNbBvCu6AJNPUIkdBPwipPxU2xYYL/WKcANq8L8SgjzY6waX7fKX7
	 lPs9DwyNQvbFx1KDNXWAAE47Mcnl3J7+Y2ux91TvFCP1V2xcJaqBwgR0+fKC8NH+t8m40
	 PBkG5fbcBGOau7PuQ/4NBFSKnyG3HJ057Btl/S6DxjXiYMwgml7/bGiQM70oxgaZhPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794114231;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=a+JbwsepHx9Uk2AzsEX7xxvXiLmEyOWKB/M2T5kLRG4=;
	b=Q8CTpdE9jgsGwG6CU9R2lmbm6uJp54YX8ZCgSNV0VHIk/D+VVxzi+SZkUsJ5RYSohcCv
	 q8EkphWs4lZgKKNrmo9s4gd+aQnCfHIQf3rFKUDLQDO01p9kwZS8O9zAOpmqSWtXZUMC4
	 NWKDi82pHRqF6cfdNKY0BOg5C67w+a6GC51MLOhlrsCxQGW4G7MGgHJ4iLF4wP96/XFIO
	 B458Kjt/SXN+ZP/LZvINCx6yKTaYQ/spnpXVqb+eFF3qHcydYM9YjBMclY76C4EAZ35dI
	 rktdq+IA0ioY1gf7PEc828/S+fLgWjVyI9ggUcfV4swRrHEE3+GsPQeMSi1iazTx0Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBIaTmaZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D182606A31A;
	Sun,  8 Nov 2026 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBIaTmaZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382881F0089F;
	Sun,  8 Nov 2026 05:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794114230;
	bh=a+JbwsepHx9Uk2AzsEX7xxvXiLmEyOWKB/M2T5kLRG4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hBIaTmaZeD8km6dArl4lJEQpIWcEB5RyPi6UioymbYW3QNlJ1rcRGCFnjZIcyK2s0
	 1bf9K5WBJkAR0VL2L8fF1/m9CkGyzbeC4eTgjZuHfyjkdkxhOPzx0CYjlzzA2TsAKU
	 5lPrtpPtY4Mam5MHzrOZO4t1N4rrdxAKWF9Q82dVe9klP9iOWD4KOxdE16hM4veUxL
	 23Xvm94gYdoUbiiS+5Qr4UIGzau8hzdlaXEvq78O0C1PaDTp+UE6Ax8s3TdAGUMDwK
	 rXseucLMNSoI1OACw/5lEXcHnwW0BcpS6RLGoWZNkDOHmN2owyOS31KzyX2UqQbBF6
	 /lylpETjHXieg==
Subject:
 Re: [PATCH net-next v2] erspan: drop packets with an unknown ERSPAN version
From: netdev-bot+sashiko@kernel.org
To: yanhaishuang@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, witu@nvidia.com, linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 05:03:49 +0000
Message-ID: <179411422969.994134.8902723149137301857@kernel.org>
In-Reply-To: <20261107130030.35220-1-yanhaishuang@cmss.chinamobile.com>
References: <20261107130030.35220-1-yanhaishuang@cmss.chinamobile.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new version check can be bypassed: an ETH_P_ERSPAN2 (type
  III) frame with a 4-byte GRE header never reaches it.

--

erspan: drop packets with an unknown ERSPAN version

This patch makes erspan_rcv() and ip6erspan_rcv() reject packets whose
ERSPAN version field is not 1 (type II) or 2 (type III). Before this,
such packets either had no ERSPAN header pulled or were given the type
III length.

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 5485586fa0e62..ea41be3c4229b 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -303,8 +303,10 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
>  	if (tunnel) {
>  		if (is_erspan_type1(gre_hdr_len))
>  			len = gre_hdr_len;
> -		else
> +		else if (ver == ERSPAN_VERSION || ver == ERSPAN_VERSION2)
>  			len = gre_hdr_len + erspan_hdr_len(ver);
> +		else
> +			return PACKET_REJECT;

[Severity: Medium]
Can an ETH_P_ERSPAN2 frame with a 4-byte GRE header get around this new
check?

is_erspan_type1() looks only at gre_hdr_len and never checks
tpi->proto:

net/ipv4/ip_gre.c:is_erspan_type1() {
	/* Both ERSPAN type I (version 0) and type II (version 1) use
	 * protocol 0x88BE, but the type I has only 4-byte GRE header,
	 * while type II has 8-byte.
	 */
	return gre_hdr_len == 4;
}

gre_parse_header() treats ETH_P_ERSPAN2 (0x22EB, defined in uAPI as
type III) as always carrying an ERSPAN base header, whatever hdr_len
is:

net/ipv4/gre_demux.c:gre_parse_header() {
    ...
	if ((greh->protocol == htons(ETH_P_ERSPAN) && hdr_len != 4) ||
	    greh->protocol == htons(ETH_P_ERSPAN2)) {
		...
		tpi->key = cpu_to_be32(get_session_id(ershdr));
	}
    ...
}

gre_rcv() then calls erspan_rcv(skb, &tpi, 4). Since
is_erspan_type1(4) is true, ver is forced to 0 and the lookup uses
NO_KEY with key 0. That can match a keyless erspan_ver 0 tunnel or the
collect_md fallback in ip_tunnel_lookup().

>From there len = gre_hdr_len and the new version check is skipped. An
ERSPAN header with any version (0 or 3..15) is passed up as the start
of the inner Ethernet frame, which is the outcome the commit message
says is fixed.

In collect_md mode, tun_id = key32_to_tunnel_id(tpi->key) is also built
from the session ID in those 4 bytes, and the same bytes are handed up
as the inner MAC header.

__iptunnel_pull_header() still pulls ETH_HLEN, so nothing is read out
of bounds.

Would it make sense to also require tpi->proto == htons(ETH_P_ERSPAN)
when classifying a packet as type I, so this path is covered too?

>  
>  		if (unlikely(!pskb_may_pull(skb, len)))
>  			return PACKET_REJECT;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107130030.35220-1-yanhaishuang%40cmss.chinamobile.com
