Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571007;
	b=SVZ6KMfWpXThrkd/RBq/S1Wg4BS/jyIjOGBrMC2sGvunRlGx++eL9v7rakeX5pTVZxm4
	 4BWdN+5zbacH2LbblfHVOq3tD7HSvSBPEc03zDTJ5bL5jJ0nQOVK4ncBQbdHOw6Ld5P6U
	 p2hxkudaxK9W9NARhShPELGzfmBDGHAUk0I6SxzagrNXQjczjUzaJIxTk+ZQ0Pu/SHaOr
	 caye+M75S7hsiyZDvcttAHFSOGoyxQ1MtYbi+7o985PFWWbey61c2ZSIVb+yoxZ4/Qlc1
	 GQTeiaqcjSUbqiWcCMcykFDUhoyaWeTHiqEi52Vn3ZV9YS0vwx5HS5+MedXbJipcxRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=4N/dZS8Z9He1Ojn4sK8fQVdQGSlr0eeBK13+larFmHQ=;
	b=hFvEBIxN1SZcA2OahDD9yWM2F+FaaDzH3tSs4eDwk2457xIRSzSuG0WZ0gQb2HT4QYSs
	 xKI1qpy/QU0BpeCK1Rsf2vtm0yqQT2zJ1/m3gjfVlR+gRC6SOW0+FzPltlTRNvBlT6RcE
	 GRWC9/8oX9ZXFAd8g+ktO2wJcRKw9av0f5O5tDiIOSpMr/0I2StXTsKf7vDxdXsnQamoX
	 bRuhdwo2z7dKpNAwUN8FhWx+4beDL+9Jva4ck51UahWLX/0oQJ3sC/gi7DQVU5onMub4b
	 3RAPwSYBETwNsFD8Ov0Mt01rSzm0nSc9V6oZ4LdIWcgdRx9MCzA2pS8xjgG5Zr81pKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qb56LMbp;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A6606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB4A6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qb56LMbp
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso1442631a91.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 03:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794571006; x=1795175806; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4N/dZS8Z9He1Ojn4sK8fQVdQGSlr0eeBK13+larFmHQ=;
        b=Qb56LMbpgc73Vh/+XT/XWQVIUmZr0IKXnZu+SQ0c+a0Q98C2O4vsljR0i7P485IsG8
         8mCMo9lsnDQg+8Xfr0938Eqdy0CqyTcWKNa/+ec5uoarU9hVGoX/iG9BciQIXzPI5Ksq
         oYPLdmNpcSu7ARkHZvQ3SzDi6sD3c2Am/gyVqFysdLKU9iZqbbUXy/vpeZH2neeTCQ1k
         w/b2cy2moV3mTAouZcm9zwvYKvbL6nLwmnu7RnsQ/ifMMexNGKjT+AGWYWIpVHk74Lc6
         tGD8MkuappezpJG6cbG02peHbYZDXR6VdXcyPiqYDwphUkVcpxuNiF8o/luUQE8+WIUu
         8iQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794571006; x=1795175806;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4N/dZS8Z9He1Ojn4sK8fQVdQGSlr0eeBK13+larFmHQ=;
        b=riNN40HIt++CKnjo61/iFrUyTm3NYgP/fD6hof1hIF4LwStZseok+xgn2ff+xjpxQr
         D/NOe5DdV0kAgjs7IcZH0suWEB0lFLVKTHoQYOB7zc57qnqymEzAVZvOfxWmw0uefOVS
         f4BYm92YTT/CAGxQJZeuL3kQu5rMCKfAdhcJgpOWODnpbshf8hfY/qaX07j4TlzKsF1g
         e0bYhQkQcH7Lfm2j8RCjz3p6RLvb/+fBxsr8bOoPHeqcCu2LRD7FPdy8+wmYaw8FmN13
         3DWxm4qEEZD3/Q78LD6zC7LPegJ0YssOeoVzQWpVW0HjEy/EpDNuxM2yNYKgVnZ2qwmJ
         Sx/w==
X-Forwarded-Encrypted: i=1; AL+hErE3WTbXAvPCss+X47Zwgggs2lZ2pH+voFbbuhcTj3H39Z7kL2q8WSEJvVgqEv7kfYfTiJ7Yguo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VkLe0nEuVR55znm2q6Zr013mr7o2DxtRd8UdGwqHNq13V6iQW
	97EvPRZKiO1X53+lRMX54eewaGoW+1K3Fe8vSjL1MGTH+DQUgJwbUO49
X-Gm-Gg: AYBFou1ye8FxsQ9E/EmZAxrPdmLEW/MbO9mkf3Ti9R8tbY3YEVEVfipvZC00O4ahzO9
	4dlVPKwQ5zF+6Abv5hChQgqruKNxUEYtLuh3KRJrU7Pu4b+dBO3e7nO+FtWPrS/l7eF1+kEVmWe
	3UCt0K2FWO9D0YXbOz4lz/6KuYa2X4m3QbS7hjExPXsHkY6g8xMI3QbrTQzPl1hr/+P8vcaqLci
	akItydV7qXvg75wP3pUowi1A2BfGY9o5f+G+0WipA3Q1xBrdrRyjiU4h/G2/v79TQsdwmWS9SOq
	1CFVIAnFcQddQTkw5LqkKPKPnTBDJGP/R2nuDg3Y+FQZHCYOUDSUyjtU0jytJXxQ787HheC2+7X
	a2hgzko40B9gb3+VdLTXcIuJmQPmc1BkDVnePiMBS1whWdF/863NwCne1VAm5Xru2qHXnpt2qCu
	UAxo7USolhG1KtYjH78jIACDvyoDy7jDWHec74Xhwcf9m/p8XfDfS/Hl/Ht6QY0QOCYs2VctHf4
	tOpjiSyRiOQ87XfYh0EQddhAWQb3xDZMJcXHypdf5oc7hBPTjQqFJmqj6vrP62tEN5SqlgNj+/h
	ChQKd9fNi+zQNRnFO8KCoAeRhs7WQVSdMUXj/QDeWcmDrQGD
X-Received: by 2002:a17:90b:5845:b0:3b0:968f:fdef with SMTP id 98e67ed59e1d1-3b1b0cfd862mr2250673a91.49.1794571006089;
        Fri, 13 Nov 2026 03:56:46 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c6dd2dsm9237357a91.2.2026.11.13.03.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:56:45 -0800 (PST)
Date: Fri, 13 Nov 2026 20:56:40 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net] ipv6: gro: avoid truncating transport header offsets
Message-ID: <avb6-Hh6ITrDumOi@v4bel>
References: <avTTQNyvwPP6LtGx@v4bel>
 <CAL4Wiiq3a4Hpxg8LYQjP3XURKwngxOyDtQFYn48fy0y8OoASvg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4Wiiq3a4Hpxg8LYQjP3XURKwngxOyDtQFYn48fy0y8OoASvg@mail.gmail.com>

On Fri, Nov 13, 2026 at 10:14:22AM +0100, Eric Dumazet wrote:
> Le mer. 11 nov. 2026 à 21:42, Hyunwoo Kim <imv4bel@gmail.com> a écrit :
> >
> > skb->transport_header is a 16-bit offset from skb->head, and U16_MAX is
> > reserved as the unset transport header value. A long IPv6 extension
> > header chain can make the final offset exceed the field's range.
> > skb_set_transport_header() then truncates it.
> >
> > In the UDP reproducer, UDP_GRO is enabled on the receiving socket and
> > the first packet is held on the GRO list. The truncated offset makes
> > udp_hdr(p) point to the source MAC address. The first four bytes of the
> > source MAC address match the UDP source and destination ports, allowing
> > the second packet in the same flow to pass the port comparison.
> >
> > gro_receive_network_flush() then derives the first packet's IPv6 header
> > address from the truncated transport header offset. ipv6_gro_flush()
> > consequently reads from an address 65,536 bytes before the first packet's
> > actual IPv6 header. Both UDP and TCP GRO call
> > gro_receive_network_flush().
> >
> > KASAN reports:
> >
> >   BUG: KASAN: use-after-free in udp_gro_receive+0x1f37/0x2680
> >   Read of size 4 at addr ffff8881065f005e by task swapper/1/0
> >   ...
> >   Call Trace:
> >    <IRQ>
> >    ...
> >    udp_gro_receive+0x1f37/0x2680
> >    udp6_gro_receive+0x23e/0x11d0
> >    ipv6_gro_receive+0x1200/0x2750
> >    ...
> >    dev_gro_receive+0x1a7c/0x2600
> >    gro_receive_skb+0x271/0x970
> >    virtnet_receive_done+0x3b5/0x12c0
> >    receive_buf+0x33a/0x4b40
> >    ...
> >    virtnet_poll+0xc69/0x1980
> >    ...
> >    __napi_poll+0xa0/0x530
> >    net_rx_action+0x8ff/0x1280
> >    ...
> >    </IRQ>
> >
> > The out-of-bounds address was in a free page, so KASAN reported a
> > use-after-free. This classification reflects the state of that page,
> > not the lifetime of the skb. The invalid read was caused by truncation
> > of the 16-bit transport header offset.
> >
> > Use skb_set_transport_header_careful() to validate the final offset
> > before assigning it. If the offset cannot be represented, the skb is
> > not held as a new GRO head and is instead delivered through the normal
> > receive path.
> >
> > Fixes: 4b0ebbca3e16 ("net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/ipv6/ip6_offload.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
> > index 700f1861d8eb7d..de4bab42359ba9 100644
> > --- a/net/ipv6/ip6_offload.c
> > +++ b/net/ipv6/ip6_offload.c
> > @@ -241,7 +241,8 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
> >                 skb_gro_pull(skb, sizeof(*iph));
> >         }
> >
> > -       skb_set_transport_header(skb, skb_gro_offset(skb));
> > +       if (!skb_set_transport_header_careful(skb, skb_gro_offset(skb)))
> > +               goto out;
> >
> >         NAPI_GRO_CB(skb)->proto = proto;
> >
> > --
> > 2.43.0
> 
> 
> Thanks for the report.
> 
> This part looks correct to me, but I think the fix is incomplete.
> 
> 1) The root cause is that GRO accepts an unbounded extension header
> chain. The non-GRO receive path does not, since
> 
>  3744b0964d52 ("ipv6: Implement limits on extension header parsing")
> 
> ip6_protocol_deliver_rcu() gives up after IP6_MAX_EXT_HDRS_CNT (12)
> extension headers, which bounds a chain to ~24KB. That commit did not
> touch ipv6_gro_pull_exthdrs().
> 
> There is no point trying to aggregate a packet the stack is going to
> drop anyway. I am going to send a patch [1] applying the same limit in
> ipv6_gro_pull_exthdrs(), with your Reported-by.
> 
> 
> This should be enough for your reproducer, could you test it once
> posted ?

I ran A/B tests with your [1] patch. It fixes the issue.

> 
> 2) The limit does not replace the _careful() check : with nested
> encapsulations, each level can add its own chain, so checking at the
> points where the offsets are stored still makes sense.
> 
> But then inet_gro_receive() has the same pattern:
> 
>         skb_gro_pull(skb, sizeof(*iph));
>         skb_set_transport_header(skb, skb_gro_offset(skb));
> 
> and can be reached with a large offset as well :
> 
>  a) IPv6 + exthdr chain + IPPROTO_IPIP
>       ipv6_gro_receive() -> ip4ip6_gro_receive() -> inet_gro_receive()
> 
>  b) IPv6 + exthdr chain + UDP tunnel (or GRE) + inner IPv4.
>     The outer transport header offset still fits in 16 bits, so your
>     new check passes, but the inner one might not.
> 
> I have not tried to reproduce these, this is from code inspection only.
> 
> Inner IPv6 (ip6ip6, or IPv6 in a tunnel) goes through ipv6_gro_receive()
> again, so that one is covered by your patch.
> 
> Please send a V2 on top of my patch, handling inet_gro_receive()
> as well.

Ok, I will send v2 shortly on top of your [1] patch.

> 
> 3) Unrelated to your patch, but while looking at this : the non-GRO
> path has the same kind of unchecked 16-bit arithmetic after a tunnel
> decap, since skb->head is not reset and offsets accumulate :
> 
>  ip6_rcv_core():  skb->transport_header = skb->network_header + sizeof(*hdr);
>  ip_rcv_core():   skb->transport_header = skb->network_header + iph->ihl*4;
> 
> For IPv6 a wrap seems to end up in a failed pskb_pull() in
> ip6_protocol_deliver_rcu(), but for IPv4 skb_network_header_len()
> would be negative in ip_local_deliver_finish(), and __skb_pull() is
> not going to like it.
> 
> With the 12 extension headers limit this needs several levels of
> nested IPv6 tunnels, each with a maximal chain, so I do not think
> this is a practical concern for current kernels. Still, these two
> spots could use a checked helper. This can be a separate patch
> targeting net-next, I can take care of it if you prefer.

I would appreciate it if you could handle this issue.

> 
> Also, as the bot pointed out, please state in the changelog how the
> issue was found. "Assisted-by: LLM" does not really tell us if this
> was a fuzzer, a code audit, or something else.

I found this issue through AI-assisted auditing. Some of my other patches 
under review came from AI-assisted auditing, and others from AI-assisted 
fuzzing tuned for race detection. 

I will note this in future commit messages.


Best regards,
Hyunwoo Kim

> 
> Thanks.
> 
> pw-bot: cr
> 
> [1]
> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
> index 700f1861d8eb..01642900c0fa 100644
> --- a/net/ipv6/ip6_offload.c
> +++ b/net/ipv6/ip6_offload.c
> @@ -26,6 +26,7 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff
> *skb, int off, int proto)
>  {
>         const struct net_offload *ops = NULL;
>         struct ipv6_opt_hdr *opth;
> +       int exthdr_cnt = 0;
> 
>         for (;;) {
>                 int len;
> @@ -38,6 +39,13 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff
> *skb, int off, int proto)
>                 if (!(ops->flags & INET6_PROTO_GSO_EXTHDR))
>                         break;
> 
> +               /* Same limit as ip6_protocol_deliver_rcu().
> +                * @proto is left pointing to an extension header,
> +                * so that the caller does not aggregate this packet.
> +                */
> +               if (unlikely(exthdr_cnt++ >= IP6_MAX_EXT_HDRS_CNT))
> +                       break;
> +
>                 opth = skb_gro_header(skb, off + sizeof(*opth), off);
>                 if (unlikely(!opth))
>                         break;
