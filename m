Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794083305;
	b=Z2KQ3ktmEHS0Ks3rHezuAPWgeFUeghVR6DQBG1WUSKJw8KcIXUgS/U46mrjrtTTSkbfj
	 L8yxsToNnMGKl8oR5+dYeFEHGeKw+0if1kk/uARZYPoPXDuRpYl5MCJSLwoKt43ONi6fB
	 LrWju4pRxVTvvcFN2wvP9VWTl2Z38E59LtWA0nh4cxh9Nc1yXEtmkSr/nojpzC8keGKxc
	 a1oewpz1v4Fzn0H7HiOpLEv8psaFZ6RukzP914YEY0zeUfno4tkrgGpIsH0R4wgatDsyv
	 kLa2xQMqM82mbYhl1H6jFS1s5rx5buaVXk7bdubyycGm9sG5FGrI4rxdEw/c1ebnZ+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794083305;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jF9WkFqqoz8XKjv/vCeqUx68L6lox4H4hMAIP0GVae4=;
	b=gb31t7QNufr7l8Qe9t/8JZ8W5uKyvyJftd6Gf0fsQv7S402wCNqEx3WOyJrobj1D7fsC
	 F9jCdGvNwZju4wHD7H4jDKZhrHRxRMsUDXY0sHqg6z/IOCAbDOhoLgwTYhnDVrmD1Gr/E
	 gdeXmnpeaBBSwhcbdT9r80Smp8LyvOQKHiGRk5AmepxCJgTQnI1Hs3eKaMvsGnly/qUWK
	 vz1sj0q+f6cJefAb1xlbDDeg7vIFqUkC9UcFEN4LVEREjvIWNKtJ5FBDl2iAJLMF65u6+
	 dz0Z7zV6G/E+SpOjjouEd4v9PPVAWM3plYBOatmSA2aDl8hirVsM5NZQtR7ol9nNMmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZl6zzjU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED39606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZl6zzjU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981091F0089F;
	Sat,  7 Nov 2026 20:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794083305;
	bh=jF9WkFqqoz8XKjv/vCeqUx68L6lox4H4hMAIP0GVae4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hZl6zzjULvj02M6bpUnpJJj9Hvl9/LIQ9QB6BEnQwlWeeuhekjmz0PpAdC275Vg1T
	 XvcizhgNH0qMih4GjqvrKuUX48MY3821O/Lty7oJMdIrYyT1YaJvoSrg7Bl5tTk+Gd
	 ap035d4S+ka65m/KKg7Tr3uZ1S07Tog5u/33kYuKo6wafSH77sDTMQTPdr0X/r5iQy
	 TCMXqCfMlfug1z4vbLDO9rtgnT0RJ7se2dlnvuSHKAWkxTjud28OUXmJHaHhDZf4ev
	 WMax/T28Zcf7IBWVQsAR/vN83xiQET1eZu4v5iyEojF4u/0M8NXB+zvYENxJCE22Hy
	 B8ZIycrggGHKg==
Subject: Re: [PATCH net] net: gro: compare skb->protocol in gro_list_prepare()
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org,
 kylebot@openai.com
Date: Sat, 07 Nov 2026 20:28:24 +0000
Message-ID: <179408330415.994134.10254341408188333393@kernel.org>
In-Reply-To: <20261106195136.2496777-1-edumazet@kernel.org>
References: <20261106195136.2496777-1-edumazet@kernel.org>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The Signed-off-by trailer does not match the commit author.

--

net: gro: compare skb->protocol in gro_list_prepare()

This commit adds a skb->protocol comparison to gro_list_prepare(). Held
packets with a different outer protocol are then no longer treated as
part of the same flow. It targets devices with hard_header_len == 0, such
as L3 GRE tunnels, where none of the compared link-layer bytes carry the
protocol.

> Fixes: 60769a5dcd87 ("ipv4: gre: add GRO capability")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Eric Dumaze <edumazet@kernel.org>

[Severity: Low]
This isn't a bug, but the name in the Signed-off-by is missing its final
"t", so it doesn't match the Author line (Eric Dumazet). checkpatch.pl
reports this as a From:/Signed-off-by: mismatch.

> diff --git a/net/core/gro.c b/net/core/gro.c
> index 1b033855a20db..08e4731ddb7e6 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -374,6 +374,7 @@ static void gro_list_prepare(const struct list_head *head,
>  		}
>  
>  		diffs = (unsigned long)p->dev ^ (unsigned long)skb->dev;
> +		diffs |= p->protocol != skb->protocol;

[Severity: High]
Is this enough to close the bug class? The commit message says:

  Nested GRO handlers (VLAN, GRE, IPv4, IPv6) already compare their own
  next-protocol field. Only the outermost protocol was not checked.

In gue_gro_receive() in net/ipv4/fou_core.c, a GUE version 1 packet
(direct IPv4/IPv6 encapsulation, with no GUE header) jumps past the loop
that compares held packets:

net/ipv4/fou_core.c:gue_gro_receive() {
    ...
	case 1:
		switch (((struct iphdr *)guehdr)->version) {
		case 4:
			proto = IPPROTO_IPIP;
			break;
		case 6:
			proto = IPPROTO_IPV6;
			break;
		default:
			goto out;
		}
		goto next_proto;
    ...
	list_for_each_entry(p, head, list) {
		...
		if (guehdr->word != guehdr2->word) {
			NAPI_GRO_CB(p)->same_flow = 0;
			continue;
		}
    ...
}

When a v1 packet arrives on the same outer 5-tuple, a held GUE v0 packet
or a held v1 packet of the other IP family keeps same_flow set.

The incoming packet then goes through ipip_gro_receive()->
inet_gro_receive() (or ipv6_gro_receive()). That code reads the held
packet at the same offset:

net/ipv4/af_inet.c:inet_gro_receive() {
    ...
		iph2 = (struct iphdr *)(p->data + off);
		/* The above works because, with the exception of the top
		 * (inner most) layer, we only aggregate pkts with the same
		 * hdr length so all the hdrs we'll need to verify will start
		 * at the same offset.
		 */
    ...
}

For a held v0 packet, the bytes compared as protocol, saddr and daddr are
really the GUE header plus inner IP header bytes. In the cross-family
case they are IPv6 saddr bytes. The sender controls all of them.

After that, tcp4_gro_receive()->tcp_gro_lookup()->tcp_gro_receive() can
treat a held UDP header as a TCP header. On a merge it does:

	tcp_flag_word(th2) |= flags & (TCP_FLAG_FIN | TCP_FLAG_PSH);

This writes 12 bytes past the start of the 8 byte UDP header. The commit
message describes the same layout confusion and write for ipgre.

Both packets have outer skb->protocol == ETH_P_IP on the same device, so
the new check in gro_list_prepare() doesn't catch this case.

The reverse direction (incoming v0, held v1) is caught by the
guehdr->word comparison, because the version bits differ.

A remote sender can reach this once a GUE port is configured with "ip
fou add ... gue".

Does gue_gro_receive() also need a held packet comparison on the v1 path?
For example, it could clear same_flow for held packets whose first GUE/IP
byte differs.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106195136.2496777-1-edumazet%40kernel.org
