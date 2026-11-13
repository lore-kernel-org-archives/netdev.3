Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794561274;
	b=2yGerX8JMv9OH/8Pzi4SGwA4ozEUpGe74CFOuJ/FuwU1LkohriF5nha/0DCYOoXIHhBI
	 JsUFj/EAjEFstrQo4oI+p+NbtvDpCY99ATZqhWJqF5Nb7Kf8GPZc3DIdDOEteDN8op7aL
	 xW3zZHhD196vmVMon2vA56/IVebiB8f97Png8GG/iigAKUZZUDDcMr0iCGPa6ZWbOeRGf
	 pkOyc0oxcunq3AU5J8HGjDsLnCenC/mdzjj8BhfRxwPzQgwOEDMYfDaA8iK3hDqXpBziU
	 a8N3h8eArvoej72+QgRurn7yhr/RBKAH9vED3cSR1rWt+yBG8dlap+N8khRvtm6tt2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561274;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=f4kUZSaV6k4f/ciWJDBlfYnkQ6AnWCzawYjM0oJvPPU=;
	b=zemQpwFnpDEP93C56dEIR8Zu2FueJjTogehqnSeeD5SxDQLleu46ASKcDbbISho739nz
	 R4iuqKHdIYjySB3OaOmMpPpdfgF/yKLN4+qEhhXmYzFPw2ry7DGvOucpFfDYh/CPbfhMh
	 oSMfuM756nUFbubUJb7ewe5ev8UBR/HSAUIQGUEcp2Ep7bH36toAihFZi6sB3KyHK7rxP
	 5atIwiC6PSIeSRJrNJDfpVxsPWAgXGLjNieXTVaW9RxX5lz7JDxx4oc53HqfuikI8GNZt
	 35N1aHzIBzIRWYlfj8T3RsbAhtpXOlVnzhFsXCH0l04JBMWULSMWM/YiYse6bwWAVuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBT7i6F3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7406C606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBT7i6F3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261381F000C9
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794561274;
	bh=f4kUZSaV6k4f/ciWJDBlfYnkQ6AnWCzawYjM0oJvPPU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FBT7i6F352hdplN1mZWuc8z0JxRHf8UHqwmhXOvrbWK0PnMdXpAPGJJXFaDV/9G1Z
	 1xR6MuaLx16roGmFGwd7iW3Z7/hgLpDBlWm1sizTac0s7lXyEh28953QfO7VbDx2N+
	 rOpWCjMfybf9ZRpMn2ShYNfYpyh7HKK46U3QR+e2RXUmKg+1+u5+4KTpWO/GSMQ6lh
	 uZe0sxxN0wbuF0lWil08gxoE5iNJEYC+YQibuOL34/Rz/mE7eGh1BSpvcgeQEvjUFC
	 0Yu4KdgcZR96W93w2NzfnryMY+rsL0/yvgnDjSchwP/IpSku+R6HMqcakgqmTb1PDL
	 OpDTelPoYhs5A==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6e560e00a86so911951eaf.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 01:14:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGOgGHeUwVffNR15bjP6260t++YgemH+qHXn2R0qJq8ZTHxQscJNtImV11RGeCwr2KLBnE4VUs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3EGxbBbH8xmQ+U2UqrzewbGFPq7QIphA1KbvCZqsGAZrC7BIe
	CBlBdLKEcMJ2zxes67vbw05boroQcP8+vo4582YlA3tESkFZFFPcuf13TXp7+CWXeEqoGYI9RCG
	TqNVh4MlaZ7y1hPaysIIGDHlj5sNoMJY=
X-Received: by 2002:a05:6820:607:b0:6d7:fe06:5fe with SMTP id
 006d021491bc7-71ab5019f6amr1116158eaf.33.1794561273242; Fri, 13 Nov 2026
 01:14:33 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <avTTQNyvwPP6LtGx@v4bel>
In-Reply-To: <avTTQNyvwPP6LtGx@v4bel>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 13 Nov 2026 10:14:22 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiq3a4Hpxg8LYQjP3XURKwngxOyDtQFYn48fy0y8OoASvg@mail.gmail.com>
X-Gm-Features: AclHuK8mJXk_GCuElu2a_XdY8Pf40BOC7eso7tsK_cjnYm3NznxrvZPPyOZL5c8
Message-ID: <CAL4Wiiq3a4Hpxg8LYQjP3XURKwngxOyDtQFYn48fy0y8OoASvg@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: gro: avoid truncating transport header offsets
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Richard Gobert <richardbgobert@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 11 nov. 2026 =C3=A0 21:42, Hyunwoo Kim <imv4bel@gmail.com> a =C3=A9=
crit :
>
> skb->transport_header is a 16-bit offset from skb->head, and U16_MAX is
> reserved as the unset transport header value. A long IPv6 extension
> header chain can make the final offset exceed the field's range.
> skb_set_transport_header() then truncates it.
>
> In the UDP reproducer, UDP_GRO is enabled on the receiving socket and
> the first packet is held on the GRO list. The truncated offset makes
> udp_hdr(p) point to the source MAC address. The first four bytes of the
> source MAC address match the UDP source and destination ports, allowing
> the second packet in the same flow to pass the port comparison.
>
> gro_receive_network_flush() then derives the first packet's IPv6 header
> address from the truncated transport header offset. ipv6_gro_flush()
> consequently reads from an address 65,536 bytes before the first packet's
> actual IPv6 header. Both UDP and TCP GRO call
> gro_receive_network_flush().
>
> KASAN reports:
>
>   BUG: KASAN: use-after-free in udp_gro_receive+0x1f37/0x2680
>   Read of size 4 at addr ffff8881065f005e by task swapper/1/0
>   ...
>   Call Trace:
>    <IRQ>
>    ...
>    udp_gro_receive+0x1f37/0x2680
>    udp6_gro_receive+0x23e/0x11d0
>    ipv6_gro_receive+0x1200/0x2750
>    ...
>    dev_gro_receive+0x1a7c/0x2600
>    gro_receive_skb+0x271/0x970
>    virtnet_receive_done+0x3b5/0x12c0
>    receive_buf+0x33a/0x4b40
>    ...
>    virtnet_poll+0xc69/0x1980
>    ...
>    __napi_poll+0xa0/0x530
>    net_rx_action+0x8ff/0x1280
>    ...
>    </IRQ>
>
> The out-of-bounds address was in a free page, so KASAN reported a
> use-after-free. This classification reflects the state of that page,
> not the lifetime of the skb. The invalid read was caused by truncation
> of the 16-bit transport header offset.
>
> Use skb_set_transport_header_careful() to validate the final offset
> before assigning it. If the offset cannot be represented, the skb is
> not held as a new GRO head and is instead delivered through the normal
> receive path.
>
> Fixes: 4b0ebbca3e16 ("net: gro: move L3 flush checks to tcp_gro_receive a=
nd udp_gro_receive_segment")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/ipv6/ip6_offload.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
> index 700f1861d8eb7d..de4bab42359ba9 100644
> --- a/net/ipv6/ip6_offload.c
> +++ b/net/ipv6/ip6_offload.c
> @@ -241,7 +241,8 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_rece=
ive(struct list_head *head,
>                 skb_gro_pull(skb, sizeof(*iph));
>         }
>
> -       skb_set_transport_header(skb, skb_gro_offset(skb));
> +       if (!skb_set_transport_header_careful(skb, skb_gro_offset(skb)))
> +               goto out;
>
>         NAPI_GRO_CB(skb)->proto =3D proto;
>
> --
> 2.43.0


Thanks for the report.

This part looks correct to me, but I think the fix is incomplete.

1) The root cause is that GRO accepts an unbounded extension header
chain. The non-GRO receive path does not, since

 3744b0964d52 ("ipv6: Implement limits on extension header parsing")

ip6_protocol_deliver_rcu() gives up after IP6_MAX_EXT_HDRS_CNT (12)
extension headers, which bounds a chain to ~24KB. That commit did not
touch ipv6_gro_pull_exthdrs().

There is no point trying to aggregate a packet the stack is going to
drop anyway. I am going to send a patch [1] applying the same limit in
ipv6_gro_pull_exthdrs(), with your Reported-by.


This should be enough for your reproducer, could you test it once
posted ?

2) The limit does not replace the _careful() check : with nested
encapsulations, each level can add its own chain, so checking at the
points where the offsets are stored still makes sense.

But then inet_gro_receive() has the same pattern:

        skb_gro_pull(skb, sizeof(*iph));
        skb_set_transport_header(skb, skb_gro_offset(skb));

and can be reached with a large offset as well :

 a) IPv6 + exthdr chain + IPPROTO_IPIP
      ipv6_gro_receive() -> ip4ip6_gro_receive() -> inet_gro_receive()

 b) IPv6 + exthdr chain + UDP tunnel (or GRE) + inner IPv4.
    The outer transport header offset still fits in 16 bits, so your
    new check passes, but the inner one might not.

I have not tried to reproduce these, this is from code inspection only.

Inner IPv6 (ip6ip6, or IPv6 in a tunnel) goes through ipv6_gro_receive()
again, so that one is covered by your patch.

Please send a V2 on top of my patch, handling inet_gro_receive()
as well.

3) Unrelated to your patch, but while looking at this : the non-GRO
path has the same kind of unchecked 16-bit arithmetic after a tunnel
decap, since skb->head is not reset and offsets accumulate :

 ip6_rcv_core():  skb->transport_header =3D skb->network_header + sizeof(*h=
dr);
 ip_rcv_core():   skb->transport_header =3D skb->network_header + iph->ihl*=
4;

For IPv6 a wrap seems to end up in a failed pskb_pull() in
ip6_protocol_deliver_rcu(), but for IPv4 skb_network_header_len()
would be negative in ip_local_deliver_finish(), and __skb_pull() is
not going to like it.

With the 12 extension headers limit this needs several levels of
nested IPv6 tunnels, each with a maximal chain, so I do not think
this is a practical concern for current kernels. Still, these two
spots could use a checked helper. This can be a separate patch
targeting net-next, I can take care of it if you prefer.

Also, as the bot pointed out, please state in the changelog how the
issue was found. "Assisted-by: LLM" does not really tell us if this
was a fuzzer, a code audit, or something else.

Thanks.

pw-bot: cr

[1]
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 700f1861d8eb..01642900c0fa 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -26,6 +26,7 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff
*skb, int off, int proto)
 {
        const struct net_offload *ops =3D NULL;
        struct ipv6_opt_hdr *opth;
+       int exthdr_cnt =3D 0;

        for (;;) {
                int len;
@@ -38,6 +39,13 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff
*skb, int off, int proto)
                if (!(ops->flags & INET6_PROTO_GSO_EXTHDR))
                        break;

+               /* Same limit as ip6_protocol_deliver_rcu().
+                * @proto is left pointing to an extension header,
+                * so that the caller does not aggregate this packet.
+                */
+               if (unlikely(exthdr_cnt++ >=3D IP6_MAX_EXT_HDRS_CNT))
+                       break;
+
                opth =3D skb_gro_header(skb, off + sizeof(*opth), off);
                if (unlikely(!opth))
                        break;
