Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827554;
	b=AEVQP4IYTcNm+RHIWxDjWkobGJrDt4q7Lf7CUKIvnuL9z9t1tAjidmfreTLMGm7fGKCs
	 7OHXEerGm9S+ZVo/zDv4jjTqdZY8POsswgfpzvShMUwWeFdCEWJYBKzOgFYRN4lVIrEPp
	 KZSh6T0z9ohJW+9/OVmGtup3ZOp/iWWub14WSWEbOQbI8u0MzHmZhJzCBZ7vhZR7X5Vt1
	 0rNk0FaBx1VD1+4jhUPdSL9d8CyqesUMaiXrMXhxXuIQds1VYZG8iURoGFSJm19a3ZgAj
	 +UFpvncVw+R2pguCMKC/JatT6IMIV1kJ8YGMBhEiBFfKQQvX4lA4tRMl+om8GNWBCfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827554;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ehUjsofQYEve6ndzO97sRzCTIUWyobwDpskP54c542Q=;
	b=b8omBWrGln2j31KGWrkfjq9myTmcLmUDiR4RfIUpfINDrAuGsZN2GPIWDiSGnT4VULTM
	 U52jYYNlWcGAKbdZo3SF1S3xxe9mNVUtZw+dveciicBJjdEsJNwvAiouKVQiOuXRenhFV
	 wNwIOyrPiTdj/VMfdK2SPom6JOAyTYZWLY55XMfUPhI/mhFYtzEUAJNjhRb8IpovU84Js
	 5f7Qxs0CMetYRPm72pIif71l9WLwFu87Fx9xe8aSfenGwngzMaP2USbx2wrhElnN/nUjJ
	 0rBn8DQsmkn9zOHmwfaZ8M+N/+PDycuLY7WWRDg6ybA9AVzarq+a8j6+5JkyXKCljqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E4Cuw+Ej;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=X2vml9es;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C07606C5B8
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36C07606C5B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E4Cuw+Ej;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=X2vml9es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793827552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ehUjsofQYEve6ndzO97sRzCTIUWyobwDpskP54c542Q=;
	b=E4Cuw+EjjHtBBgzh/y1qW7fNKMTBW5npRubLltaU7WG54/0CFclD89uQouEyN7CsBrTUon
	fU/SKrbTYbxQdSt6EBMo4bWkA90wPx8PsfWJnNl4kwYMUkJskWGkztimbe/hQOY/rFQDUR
	NPsmaR6Ks61WBOxjBO6h3VaU32gAEQQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-75FL-SELOLaFTuPDX2FJnA-1; Wed, 04 Nov 2026 16:25:51 -0500
X-MC-Unique: 75FL-SELOLaFTuPDX2FJnA-1
X-Mimecast-MFC-AGG-ID: 75FL-SELOLaFTuPDX2FJnA_1793827550
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e0461e040so1073402f8f.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 13:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793827550; x=1794432350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ehUjsofQYEve6ndzO97sRzCTIUWyobwDpskP54c542Q=;
        b=X2vml9esjC3ryJ8DwKfNMDQLVcSUFaZZtftcnS5ShWrp1M5xyxTQd27t2fdNrKmRPN
         Yv49mTDynfJKH/BjtOFC5OtHION31m9nRGb7K8ZFzMcYhutIKxF1/gAO0pVQVu+DeL5U
         WUOM2Sgc4TQlq4/A5/e0ohmmqrmnQtWnuuKZ6aAQnKrZ00U0M8BAujJnOQLZdRffM2rM
         EE/4ZAvU7MmozKylTWGQIJEkI/WbMEy22jtVEtOC7b5sF6fD86hYseanv4e/eBFQMnad
         75x3FEoRUU3cJtoVsV/7IMyZ7J6LgmCw0SqPf06FR8ykT+ZFVpMElK4gk0NZH7HNaUIZ
         pfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793827550; x=1794432350;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ehUjsofQYEve6ndzO97sRzCTIUWyobwDpskP54c542Q=;
        b=nlmssQ94csKpFAOl8xInp15tRfJwCz8UvJHDYoLJ0IMYF+z+dchBfSZ9AGcldChOf/
         omWce+Pf7ZO519+MOtOVRVz6h/HrrR9bKaquh8K7LTMNBKtmq7NSfazMHoFyTYoxh+xb
         i/AZtJB9D0obJZkX8ou24JaaasGRlRMhKGAcR5e933xPJ/3TXc/ujw29POZdikELVo3V
         Yi4tD/3PrcVjZ4az9SxooV3Z+PDH1VUWZVAEF26/boieYgcJC94XsgZwFcCg0Y6OKJKt
         mL6T7FFtm43BnWV2oyW3oE4xLa9rNBBYkIVJFpsP6BPhRq7fgy3J/2qw5+BkM8povOqy
         Q6ug==
X-Forwarded-Encrypted: i=1; AKwUvBxQKcl2Nf7jHSWdQ2DOo3OzDGr8qRIzmeFZSjOBexZQRjsj5R93moViKWnfbP9WQ7ETDmY3ulU=@vger.kernel.org
X-Gm-Message-State: APuU4Z84dorpmJRUBNAiYHCQc81+2i9uRGEbOVa6umQ/ULZCb0+keDWY
	HLDt3CqvYEMu8gA/+8E0lGqYjsu0YZeIJm3CarDNyoprOWJ8gE+Lxwc5dtU4H9jU9uoZjYt5YHE
	/nSi3oBJQybT7PLKe4swKffbCSUWuQVkAOe1vMrBx0GhOS4Izf/oRE/kSaA==
X-Gm-Gg: AYBFou2emJrryFbXvjYbl3hUJg4lCU7T6hH1KqUjfvnFekL/gvMDjtRETSrtkDo4Hfc
	qjDw7/MMNG5dAJZogWayehC7o0sdP0sMHMCoQoSb1Hh3G/+AY/ofeXsRS+Bi3figfihmb28gzK4
	D8NgqSFNXrLAQdwDk9fyY9KSxGIjuvb4wsHCBa3t625o4YZEhGEVr5sFoPxwOfn5xWBzJrHmKTF
	jh5w/ZXxq4CbTNxGkxs7hiPGJVdkD87YklFFBRKKOjPwjWmod/t1Fb9LjiJJLi67tP9kClMR1e2
	FEVDgT0mwYVHIfus94zh5lNIDlTYF/4Pf8bD51/a2dGkVdfMSoSt3QW0setuvDOyPbtK4U6Tpzv
	Em67P59VL0plMTu0eqjakJGiD98+IcKZ/OnVcLy8Rma7MhiLsr9crRwpGCu3baC8oi29+jurDOt
	aopEB+yauAMTQDAPiXnYWfPSw2aQcR076Qr4ZRRyC4jH0=
X-Received: by 2002:a05:6000:184d:b0:48d:fbf2:555f with SMTP id ffacd0b85a97d-48e6e518487mr40091114f8f.55.1793827549850;
        Wed, 04 Nov 2026 13:25:49 -0800 (PST)
X-Received: by 2002:a05:6000:184d:b0:48d:fbf2:555f with SMTP id ffacd0b85a97d-48e6e518487mr40091084f8f.55.1793827549444;
        Wed, 04 Nov 2026 13:25:49 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed552afcsm5900596f8f.41.2026.11.04.13.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 13:25:48 -0800 (PST)
Message-ID: <457a96dd-99dd-47f9-ae0f-cdb82e2951f9@redhat.com>
Date: Wed, 4 Nov 2026 22:25:45 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] tipc: raise the minimum bearer MTU to fit tunnel
 and crypto overhead
To: Joas Antonio dos Santos <joasantonio108@gmail.com>,
 Jon Maloy <jmaloy@redhat.com>, Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <179340438471.4412.6707287163192409104@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179340438471.4412.6707287163192409104@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/26 00:53, Joas Antonio dos Santos wrote:
> A peer can lower the link MTU to TIPC_MIN_BEARER_MTU (100 bytes, plus
> the UDP encapsulation header) with the max_pkt field of a RESET or
> ACTIVATE message; tipc_link_proto_rcv() only checks the lower bound
> returned by tipc_bearer_min_mtu().  The same bound is applied to the
> device MTU when a bearer is enabled.
> 
> That bound predates two later reductions of the link MSS:
> 
>    tipc_link_mss() = mtu - INT_H_SIZE                    (tunnel header)
>                           - EMSG_OVERHEAD               (CONFIG_TIPC_CRYPTO)
> 
> With CONFIG_TIPC_CRYPTO=y, which is the default, an MTU of 100 gives an
> MSS of 28.  Once the link comes up, tipc_named_node_up() calls
> named_distribute(), which computes
> 
>    msg_dsz = ((tipc_node_get_mtu() - INT_H_SIZE) / ITEM_SIZE) * ITEM_SIZE;
> 
> For an MSS of 28 the subtraction is negative and the result truncates to
> 0xfffffff0; for an MSS between 40 and 59 it is 0.  named_prepare_buf()
> then allocates a buffer with no room for any item (the u32 size wraps),
> and msg_rem never reaches zero, so every cluster-scope publication on
> the node is written with publ_to_item() past the end of that one skb,
> over skb_shared_info and into adjacent memory.
> 
> Without crypto the MSS is at least 60, which still does not hold the
> first fragment built by tipc_msg_build(): INT_H_SIZE fragment header
> plus a message header of up to MAX_H_SIZE.  With pktmax below that, the
> header copies run past the pktmax bytes allocated for the fragment.
> 
> Raise TIPC_MIN_BEARER_MTU to MAX_H_SIZE + 2 * INT_H_SIZE so the MSS can
> always hold INT_H_SIZE + MAX_H_SIZE, which also leaves room for name
> table items, and add tipc_bearer_mtu_floor(), which adds EMSG_OVERHEAD
> on top for CONFIG_TIPC_CRYPTO=y.  Use it for the device MTU check
> (tipc_mtu_bad()), the UDP MTU check, the netlink MTU setting and
> tipc_bearer_min_mtu(), which also bounds the max_pkt negotiation.
> 
> Found by manual code review and reproduced with KASAN using two network
> namespaces joined by a veth pair (see below).
> 
> Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
> Fixes: 2320bcdae628 ("tipc: fix changeover issues due to large packet")
> Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
For some reasons the PW bot did not notice...

Applied, thanks!

/P

