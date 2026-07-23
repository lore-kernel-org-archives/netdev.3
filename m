Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A53B3F5BE5
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841783; cv=none; b=UZadIOCR9zFc6WdaEyNhjp0qvwiVA46BsqPWuEp7lf5wZz2nbPqgqUgzuXFySNU0a08USOZbr+adImqylA/WKVegJLpmhuLQ8jb2OITT6RxCSoS7cn9bTfkpq6Fv+ONG8XAuIGGLn/XT+aUUQ/azouPZlQDxn0NqKpEZGHkv2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841783; c=relaxed/simple;
	bh=haxoTexRbNT3Ih6fcspZyW2FGvcgo6DcA9WcvwhndhE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XWLVk0JIqldyZW0L3dD6z6hWRl4cHN7uKn0Mj7cV4T/DKMPL9dwhzc1A+12FmY4GURw+Dopn0dw/b7URT7g2y3CQyfYt51xhqpc4vjKw+EBBp+DP9RU4yfnlE70E36XEhX+UDR2etDxLLeP3Wdn8Y+c+2MTimaRdz4sCtDOQKTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2pzC/YL; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2pzC/YL"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6679d88abdcso1055641d50.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784841781; x=1785446581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xGlxBC5SjfZiRwDCCi1VHk7rw5dfR+3uY48owyOZVBg=;
        b=P2pzC/YL6ykygsCnfBbL7la9UEVPq4fO10utvJE8kQFz3TPIlQj5VcA1ZH9wxO64TB
         AeC3czdDjOBIFXiKSxyfYD+LEzG9s4gKOWyrLk62e1DwGGazyLy0ZDA8CfSRVn/yRgi6
         yWsroDvlJedAJRecceOOfMczVTWucqEHnyfmMkRrsSX83B4Z4/6L8VvO575up4Mb7xIh
         SPZsAVozjcv7ibAY381drmFpXTfp4EOwS0t4wH1Vlvt/qhjt9VOlk2X9nSVnoUolIVD4
         ti7AaUXvKfauCrjmvywXL8lRFBvG1V5Rxzm1lT8sdN7Ic3QBEs7u1vrwNR+zjK+Xe0Dm
         H0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784841781; x=1785446581;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xGlxBC5SjfZiRwDCCi1VHk7rw5dfR+3uY48owyOZVBg=;
        b=X8+GIRIL3qCSpRaRgb2F/T0GZ9bi8dT+Tfr6Eg5N3PcE87ZC0QDcDnsg2FBGh21xbR
         /VV2ec1+YFyMqhFZuQu0x9xyZMW+1lMCvoqepJoh0u1aMdK3uQqdO0wX0GefOpwb+fGm
         RlFV7S74p14xhmuopmxI9YL+dqKqTsRGHaTZa4euiKI0+nouD+48KVKGBNA1S4xaHOJp
         2hSZ3h/KIe0jstO2BbhrYbkBOLsDpqgpa5guHAtoWCdWA4xHHIVYKd5lauk+PWJ1KyEB
         2WL56bfMdxs7KtG68+heqyA3FxRpxOG4hUq+27VEZH0aOW1uDBIbYm5lCDMPq/9OpPYt
         OKCg==
X-Forwarded-Encrypted: i=1; AHgh+Rq4mQ3ruZHzQy4NDf6CCwWgNDBpRoxA7con69LAtkTC6Dl1ZlroqsesQ3wb/cwZGwieNB6LO8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+YAihZf4KhiBCsqrvB2heOkmIv3vNtYfSAuf24hKpCZJi2Xnp
	Wb5Vcokiy2H9jRwFXSWEdMIDQN+RPHvh145ui+CGRYjCWaWzj1dBtQ6N
X-Gm-Gg: AR+sD13Xs3KADF5WUQuzYPBuEduQiFXlwcyp/l9y6Q38nwcX1YRghwLU2oYKZw14tyB
	GyTIQ0LrhE+QS8yQNP8HEHkTmGtTFlplz3u+mcmPe+uDfMI/AHVngtuJDUf1hahauXELZwJJTq/
	Dxk5ROvlUIZVNoccMCrXgv0UzoWaCO0NogixunBzZYaEOplxQlkRXnYz1K2HpN/88j4ybhTYdVL
	hv4wV5uVoL6A30PQ3K3GvmxWqHGnki2wppFX86GpT6ctuTKWB6GGIpBiG1PyVeDrsb+TC5KSKSy
	LR1bAG3JKRj8r6xmMvXfnnjbtXRXvf1mvyfzg4ciM4+0SW5w7rOTdrySbFzulghSujchvfjFwvO
	+VG1Tp4hIW8YQUu8ULnGoGtyVpj0QPDNchOxxJCwwJC86YJQoq7XiTIcjn3DH4e+U7L1kCQzrJO
	zZJK0M74SzFRBjgwtzdo5psPxNZqp53Dvt1LzpIPsCELE2KLK+u02TGSs=
X-Received: by 2002:a05:690e:4384:b0:667:bf78:e8b1 with SMTP id 956f58d0204a3-668a4ba75c9mr919504d50.10.1784841780919;
        Thu, 23 Jul 2026 14:23:00 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6689766347csm3215255d50.10.2026.07.23.14.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:23:00 -0700 (PDT)
Date: Thu, 23 Jul 2026 17:22:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Doruk Tan Ozturk <doruk@0sec.ai>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Doruk Tan Ozturk <doruk@0sec.ai>
Message-ID: <willemdebruijn.kernel.36bee22ca53dd@gmail.com>
In-Reply-To: <willemdebruijn.kernel.4957260f765a@gmail.com>
References: <20260723020337.19040-1-doruk@0sec.ai>
 <willemdebruijn.kernel.4957260f765a@gmail.com>
Subject: Re: [PATCH net] net/packet: reset the MAC header on the packet-socket
 transmit path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Doruk Tan Ozturk wrote:
> > packet_parse_headers() resets the MAC header only for a SOCK_RAW frame
> > whose socket did not bind a protocol:
> > 
> > 	if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
> > 	    sock->type == SOCK_RAW) {
> > 		skb_reset_mac_header(skb);
> > 		skb->protocol = dev_parse_header_protocol(skb);
> > 	}
> > 
> > Every other outgoing packet-socket frame therefore reaches
> > ndo_start_xmit() with the MAC header unset: a SOCK_RAW socket bound to a
> 
> The normal __dev_queue_xmit calls skb_reset_mac_header.
> 
> This therefore only applies to the dev_direct_xmit path.
> 
> > specific protocol (for example socket(AF_PACKET, SOCK_RAW,
> > htons(ETH_P_IP))), any SOCK_DGRAM frame (its header is built by
> > dev_hard_header(), which does not set mac_header), and the legacy
> > SOCK_PACKET path. A driver that reads eth_hdr(skb) on transmit then
> > dereferences skb->head + (u16)~0, an out-of-bounds access about 64 KiB
> > past the head.
> 
> This is not currently an expected invariant, but I see from a comment
> below the --- that this approach is proposed instead of fixing up the
> buggy drivers.
> 
> > 
> > This is the same class fixed for one consumer in commit f5089008f90c
> > ("macsec: do not read an unset MAC header in macsec_encrypt()"); other
> > TX .xmit paths that read eth_hdr(skb)->h_dest (several DSA taggers,
> > ibmveth, sja1105, the atlantic PTP path) have the same problem.
> > 
> > packet_parse_headers() runs only on the transmit path
> > (packet_sendmsg_spkt(), tpacket_fill_skb(), packet_snd()), and there
> > skb->data is the start of the L2 header for every packet-socket type.
> 
> There are some subtle points with variable length L2 protocols that
> need to be reviewed.

Come to think of it, if __dev_queue_xmit can unconditionally reset the
mac header, then so can other tx paths.

> > Reset the MAC header unconditionally so it is anchored for all of them,
> > fixing the class at the source rather than hardening each consumer.
> > 
> > The protocol probe is unchanged. A CONFIG_DEBUG_NET build stops warning
> > about an unset mac header in skb_mac_header() on these paths, and the
> > out-of-bounds eth_hdr() read no longer occurs.
> > 
> > Found by 0sec (https://0sec.ai) using automated source analysis;
> > verified against source and matched to the macsec KASAN report in
> > f5089008f90c. Compile-tested.
> > 
> > Fixes: 75c65772c3d1 ("net/packet: Ask driver for protocol if not provided by user")
> > Cc: stable@vger.kernel.org
> > Assisted-by: 0sec:multi-model
> > Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> > ---
> > This supersedes the per-consumer series "[PATCH net 0/3] net: dont read
> > an unset MAC header on the raw/qdisc-bypass TX path"
> > (https://lore.kernel.org/netdev/20260713194010.54642-1-doruk@0sec.ai/),
> > per Jakubs suggestion to fix the problem at the source rather than
> > hardening each driver.  Vladimir Oltean had reviewed 2/3 of that series;
> > this is a different (source) fix, so I have not carried the tags.
> >  net/packet/af_packet.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index e75d2932475a..adfb9c19a3ca 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -1924,11 +1924,21 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
> >  {
> >  	int depth;
> >  
> > +	/*
> > +	 * packet_parse_headers() runs only on the transmit path
> > +	 * (packet_sendmsg_spkt(), tpacket_fill_skb(), packet_snd()), where
> > +	 * skb->data is the start of the L2 header for every packet-socket
> > +	 * type: SOCK_RAW and SOCK_PACKET carry a user-supplied header and
> > +	 * SOCK_DGRAM has one built by dev_hard_header(). Anchor the MAC
> > +	 * header for all of them so a frame does not reach ndo_start_xmit()
> > +	 * with the MAC header unset, where a driver reading eth_hdr(skb) on
> > +	 * TX would dereference an out-of-bounds offset (skb->head + (u16)~0).
> > +	 */
> 
> This is too verbose. Better captured in the commit message.
> 
> > +	skb_reset_mac_header(skb);
> > +
> >  	if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
> > -	    sock->type == SOCK_RAW) {
> > -		skb_reset_mac_header(skb);
> > +	    sock->type == SOCK_RAW)
> >  		skb->protocol = dev_parse_header_protocol(skb);
> > -	}
> >  
> >  	/* Move network header to the right position for VLAN tagged packets */
> >  	if (likely(skb->dev->type == ARPHRD_ETHER) &&
> > -- 
> > 2.43.0
> > 
> 
> 


