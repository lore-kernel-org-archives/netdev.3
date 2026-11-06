Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996515;
	b=t6tvgNSa4BGCEd8WjNv670g3mvJGWkaGJAEBEiTO3dqVmwnA85WC80Vvb9C35gUD999U
	 GcdVR3dF2m5NfMqgMMXhpb43i6HxJFBNE7UbmLDe7EIIFg6JOzL8VAsEvm0QQdtaF+NRc
	 1PAKrh1cvT86hHpL980/+PUfbC4giqG3U+f5xWKQ0iYEbSYrIcz6+6/UMReN+NNyOAMIq
	 WcPOGd9UbWR5dE73i2GwE41B5MSDp5+jFynejwexCbTTfb95PRjauNU3ivC2gNVBEw3jh
	 2AWwIFXxRAsAi/j1pEsHLJVdpWRsJelA/VScPvBpiIhE8RAFt2E9XIUw+AEMEZvKQSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Sb20IHjVSetpiv5t1Z1gtkWKENrx09lpxlhN+zGrFjA=;
	b=PUiiuzWlCZKPAQ5q84JcC8S90ckwSXIIz3qM4MsE+XY3e4G1g/1VSzfCq/ku0XIzGP56
	 J6IsGQJxnxuEPPfU/xSDn/XQNuAsDfWV42r1nKmlb5QIDvTzSwDQDQtM0TNGpl7U2Zt2s
	 KVCcgCFP3XmwfEmyq72bcmJsHqr861qLICSrRHmASEV4U/HNg50n7m5iwlNgJ/OPSjAzw
	 dNTkq3FcmPiljgZTBlh4n1zz1py4bHotHHlO0kK3yKIE7HWUVIBEMZXV9hsBzrHjNI/zr
	 cKqREUCCJi47/aul/PJLfOBurlwySHXW1lRDMn6j895nC3KP/66hm11JZnhuBOJkrPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EGTWOgWp;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B9B606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 20:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7B9B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EGTWOgWp
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eab93a9862so296784e0c.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 12:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793996514; x=1794601314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Sb20IHjVSetpiv5t1Z1gtkWKENrx09lpxlhN+zGrFjA=;
        b=EGTWOgWp+Awus7UG5tUxBPrRZ3YWTEyDfCa/R39AaAe/c1fkNTVslSfYkQBN5BJk7i
         5j9YIIQZdLUsPIUhsD2u4w7TFjZMNEK/QgIFT+lRAO5UoLyyaFOZQAMakREKiO4B5isa
         CwrlUHCnV+GTeA+rbU1MJynfodlxBSbzjSxEP6GWL1GbWVV9n64uJ3McODQxTgaTQr3N
         fiD3D3qNhTGZgIISNpRFOOwlV/rvF3+esnz0DJrCOYcAd4aH/vQ1QD6CbmMUKEFcLTUi
         cVzsajjuCgAFeO+weiShrNBVuVq3JPHRZepC5UthJmNhy8ksfpWwq/fvVBA60z99AeR3
         snVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996514; x=1794601314;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sb20IHjVSetpiv5t1Z1gtkWKENrx09lpxlhN+zGrFjA=;
        b=bcnLQcKRVaTgV3IHnPgkokpHNGVb+aPWBBIdfaG59dcMaOKkCeJcV/CDD0ZP4a6oQT
         nef2HS0ceCaYWg0RIWJ9i+1QUV8Lo1IaMLUP6b6t0EeRITuj+QXhXOONKyEQD6f2MzIU
         WLSOrpWRuGfgCsRDRibFGkK1Sf8w1cNyKueMZ8guSfOOeqXyGGj5C6DXYf+Q2PtT4ln8
         n5Wk3MBMJCd6kORdQKxPe275frri9IbyFZ1eEWOXrNc88G3IovR4gUq16yVZdKZC3qtF
         bm0ABkxZqaNXlbvNovajiAIDdCvmGJKHMM4EQ5Pd5qE6UqI3MQw9tIT2O6s3gfkWYqw7
         u+hA==
X-Forwarded-Encrypted: i=1; AL+hErEPb2H+9FYyQG51G9Y6xHaLZsuB46GY1hdnr23HVY9QdT+sOOsmj2y93kNuLQvbeGTNGRPIRxk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SRHuDqB/zOL66fB2u5j7foLWbcc23eHP9Qu8HTxybfxP876XY
	+BTVMetlNiIYqHczCjar+9FiTNV+QsbmGZ4Gz3306Zq8gnhpbZI9lsVLd3voDw==
X-Gm-Gg: AYBFou3jV+TSAn7H1C8dqQXQAgcUsGQjhLPQNowtN8anI+3nzxDo+Ip/9YP/3XtzLtF
	YSwnpP4uahdPBBHCPxAMj4WyAc8UB9hzTa0ZVo2U4tRwo1iLO7QDAnz3rISukuNgmnvqa2w3qBG
	mY8oyWhH/0XQvA+4ztOgyDVmokwdpry65LH/rxKi4RBn8Yz8DmUYFOy5VikZok9pnwE9yVl6n0J
	jQfu52uo3NpSX6pXX6g280uOAFwp1zuPesKI5he74ZAtmILJT5bjPhcsnFp3seQBIMu6ATM6pSM
	tIkZojAFaQkoTL/NDyd5HpHC3UR1tbngKUWQxuut5D3HvkPEV5gv2VMxi2ux4t178asz9PiAXnw
	Tkk7+RiGUE4u4RjZthRD933ZvwBzcK6GaYmrZZWDGsEm40NQDNOWsmiwe9eaBeZv6hIqMm6frgX
	nTirFjsfKXB9IOGYe+8roD5ckbzZrypS0fST2oa13FMs8fyLroSD9dPbfWVO/mcmm2YPzaEcMjI
	PUV+WKIs1MAddJNLh5vEFZdeC2QWgZQVw4Jx61/iTJG1V8rDWjTZEtiOF/vJ93KsvE21F0DWE3L
	XFmP6gl8anVLnu+63m0csFRteaG/ntz/HIlOfoalJycRQ+zLL+cEpP6pDM7OPzC0GA7Ty6c8Zsh
	ZPKFJpptheoxdziHww3GD7A8ca/Jmf/lh2MN9JdXCgSZwpmEfyU8pt3PT+k3PjqLma2dnQuQ=
X-Received: by 2002:a05:6122:3c4c:b0:5ea:9218:eac1 with SMTP id 71dfb90a1353d-5ecc4468d2amr1644458e0c.20.1793996513649;
        Fri, 06 Nov 2026 12:21:53 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc629388esm2222013e0c.2.2026.11.06.12.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:21:53 -0800 (PST)
Date: Fri, 06 Nov 2026 15:21:52 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 Eric Dumazet <edumazet@kernel.org>, 
 Kyle Zeng <kylebot@openai.com>
Message-ID: <willemdebruijn.kernel.2e09a035794e5@gmail.com>
In-Reply-To: <20261106195136.2496777-1-edumazet@kernel.org>
References: <20261106195136.2496777-1-edumazet@kernel.org>
Subject: Re: [PATCH net] net: gro: compare skb->protocol in gro_list_prepare()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> gro_list_prepare() checks whether a held packet may belong to the same
> flow as the incoming one by comparing the device, VLAN tag, metadata
> and the link-layer header, using dev->hard_header_len as its length.
> 
> On devices without a link-layer header (hard_header_len == 0), such as
> L3 GRE tunnels, no compared byte carries the outer protocol:
> skb->protocol comes from the tunnel header. Packets of different
> protocols can then stay eligible, and the GRO handler selected from the
> incoming skb->protocol parses the held packet with the wrong layout.
> 
> For example, take an IPv4/UDP packet held by UDP GRO and a
> VLAN/IPv4/TCP packet received on the same ipgre device.
> vlan_gro_receive() reads the first four bytes of the held IPv4 header
> as a VLAN header. With crafted values, the held packet survives up to
> tcp_gro_receive(), which uses its UDP header as a TCP header. With a
> short linear part, the FIN/PSH update of the held packet's TCP flags
> can then write into skb_shared_info.
> 
> Nested GRO handlers (VLAN, GRE, IPv4, IPv6) already compare their own
> next-protocol field. Only the outermost protocol was not checked.
> 
> Compare skb->protocol too. On Ethernet devices this is redundant with
> compare_ether_header(), but it is cheap.
> 
> Fixes: 60769a5dcd87 ("ipv4: gre: add GRO capability")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Eric Dumaze <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
