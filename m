Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741794;
	b=rU5O2HVFyF9qCCw4+niqqnhI1ut2TFUCaPcAq9HeODTfkNpcR5EeltOf1u5zffCUkyeI
	 MqGocdaA/8hOIoG1YfuQhDG4SxkL0iIk2YfdsX/gTZ4ovJfgSZ5CdJY2KwbaOvKf2GLbg
	 6gGaG3877K62G50e4EZSP4ha12zOliTutHUW5ZIr50twE/bL08oCIakV7qcFUlW92nU/G
	 D4PEJo6H/A4pYV4fdTJpx5u+4wrugUa56dEq5DH5dN7i6+1Iq3o20uIPPCOUtVZQoui8Y
	 otpbsU9RJMpF09nAW0ZD8cdEwdyO671BFsLci58TGJL49mMrtvMlpfwA3jMkmsbE8UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741794;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4cXd1VFBgIfOAD+61rGAZDsr+QKv24JXaxEhYtMOIKc=;
	b=AYWoimSBUNbanoBihxi1yt1weDINcP1Abm3aLYaUvZyv9Ow1yytpgnQhiWKYXKEO/2CP
	 gh6sq/37mxCLxlpVDkbA1srXUJpEW6iH0AjZ4/QHyDbLrRze/AFLZVj4EyOMdB7ifGT05
	 rIiMZdpi4+xLSnzruZXP1iD+B+HnRgmfUKsnHFufx9WnYkO95Ew3Rzzh9o4kqTF7K3W6H
	 3XJheUrjrIoQkGDBvH45BoLIcForBNjBf8DnLFgif+arEMJNsrC/Q2ogKtijthUa0KA2m
	 EcJefgNZ6SNOUEwS6kF9g5I9AN/y7OG3nYYpcbOCUnwQp3BHaSVxpq4sS37e8Y8n4Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=blhASesy;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AGuMrkCv;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A20606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 21:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10A20606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=blhASesy;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AGuMrkCv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793741793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cXd1VFBgIfOAD+61rGAZDsr+QKv24JXaxEhYtMOIKc=;
	b=blhASesy+XYbb9cPdzLCO04w7KBLRj9BqzF6f/C/mCGfWiLVOsSTbaKmpT9+eCU8s7+GK3
	2DXot23cj08OMz636rcclxG/A8WVo2f8vbmI11Amd5lm1bLzV+YM7ZrPZHw7AsHzb+wURo
	RtSQ5keuKE6ruDOJMimpj1UQ93Svok0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-Xm5erbd9Ns6jfqLyNMFcxA-1; Tue, 03 Nov 2026 16:36:31 -0500
X-MC-Unique: Xm5erbd9Ns6jfqLyNMFcxA-1
X-Mimecast-MFC-AGG-ID: Xm5erbd9Ns6jfqLyNMFcxA_1793741791
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49953abe51fso165395e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 13:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793741791; x=1794346591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4cXd1VFBgIfOAD+61rGAZDsr+QKv24JXaxEhYtMOIKc=;
        b=AGuMrkCveJCCzbR3cE/rqmYY9+HNuHapKjxoOvKDixv6sDWY0JSuAiYGAUFxUZPGSc
         tlEsjU90aZlzjBjTU3PC2lBTDkJ6bbAYxzxwwTQ8vPwF/gU6OWNnHMhMbiXUn5ac6uvJ
         MLvsUq+oSCJN28BOJpodQ9hmvKU71IuypHt6NNd3CyJNfrkypA2vT+fT9EvSeVt1jv2o
         vN6JWqPnc6SyRye5GFRAKA7Jdm6ePMTx6EbXPDsYxs2tvkeFY0S9DCVUkMtzYGuCVLQd
         Zuef3Yx2OttE4UxqMTNt6GoUAubqLA7S8JkWEhpP6ne62hUE0OTGp4Uu2HvQa6/pg0t+
         rWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793741791; x=1794346591;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4cXd1VFBgIfOAD+61rGAZDsr+QKv24JXaxEhYtMOIKc=;
        b=x/f1I1/P7xh0kA2HjOITrGh6v1anGjQBuRCJIC6RI71JskCXZDE4/HH2RQ4i4TJmoS
         FW+I7p0MVkdaUVaSoH5sszWz4OOF1Hl9Vl6MscEl3CpbgX1cP1xwNu8Vc6QNVdAb2A52
         ch/SJJokf6uHjKjhNyahtvye6n8GjrE6GszmvY/6Y/UsjOnOo0A1qErs8Slo6/zpgIiT
         LcNzUANCDuPOomGscNng030YsAr11XjxbFT8+J/nu6tjpsWkeNhdX9wXUo/h4HxiaOkb
         WCsorVLOJkhAYGBuGU2lRFZ7b2sRaE2Uwl8UbA/UwYFKwjubTpggeavBBwsm9suughkx
         X4EQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4vCGKVHansNV7fAVRRdO+x9ceOnsm0NZiYsz6f96l0RlYNRB6lOMAbH1jw7XZsfM0BvbLp2s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uPFPbUqmmDdznNAMt8ru7uuNTqRcWF7hknNTTQAWYem7VnYLu
	u1IOe5cwmO0yplO1O3NhAQ+NN4TYIIHVEPk/OcOFEVMdlamH6NbpseyNFMnCFfn0ZQ6LX9ncfP4
	iwUabkB+OBNRS9bLN5zWmY+OLL4pZs086STFHX6sh7OwdpRyzm1uMDEQMNg==
X-Gm-Gg: AYBFou0Eu1Zc/W+TDDo4cDnLEvadXmF4IVKnXAubcd2AKSsd+8t7JA/S25Bm7TurCcD
	A6qsxy/igolUKVJ+eBLth0NIk7zFVQX/uES4sfNa/j4NClUz54tKy+cQbRGR8Z6JfJiENehHdAC
	rrGnF95yEZTafK7v+lYcia7onzfrsbK1DPfKpqWqs5fm97NdUkVlYe8fBxp3JOVYmcTyXXth9ko
	V9dTumH5qLogDjyOcq9nOuh5hSMmpVh1eBHd6DveqbbC3dw4wO1ZtCMFYluBKnrz9ubFJRc1hfr
	cYgKmZ/ry1FnO9tX6vf0+vFF+yqniXRv4xQyogBRjVD4aqJyGSVdoxKzT24KLR2j7zUeJ41NsI6
	AAB9Z3/8qz34gN8xRrIA1BITMywX625WmyVklnVAvLnBYZOmzKYEan8kroAwKHXBVOpUMVFNMnW
	fkNjQmCg+URNSbzB/t6iUHIwztdahI2K3BteGhupX4ROE=
X-Received: by 2002:a05:600c:e41a:b0:4b2:406b:f3bd with SMTP id 5b1f17b1804b1-4b2406bf3d2mr93216295e9.23.1793741790512;
        Tue, 03 Nov 2026 13:36:30 -0800 (PST)
X-Received: by 2002:a05:600c:e41a:b0:4b2:406b:f3bd with SMTP id 5b1f17b1804b1-4b2406bf3d2mr93215975e9.23.1793741789994;
        Tue, 03 Nov 2026 13:36:29 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecac1caesm153067f8f.17.2026.11.03.13.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 13:36:29 -0800 (PST)
Message-ID: <7accf8fa-105a-4059-a1c8-7f416d06703a@redhat.com>
Date: Tue, 3 Nov 2026 22:36:28 +0100
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
Subject: Re: [PATCH net] ipmr, ip6mr: queue netlink route queries out of band
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Katherine Leaver <kleaver@janestreet.com>
References: <20261030092303.2749386-1-edumazet@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261030092303.2749386-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 10:23, Eric Dumazet wrote:
> ipmr_get_route() and ip6mr_get_route() queue synthetic skbs on the
> unresolved MFC entry to answer RTM_GETROUTE requests once the route
> is resolved. These skbs carry a fake IP header with version 0, and
> ipmr_cache_resolve(), ipmr_destroy_unres(), ip6mr_cache_resolve()
> and ip6mr_destroy_unres() rely on this in-band tag to tell them
> apart from regular packets queued by the input and output paths.
> 
> The IP version is only validated once, in ip_rcv_core() and
> ip6_rcv_core(). A netfilter hook running later, for instance an
> nftables payload statement in a PREROUTING chain owned by an
> unprivileged user namespace, can rewrite the first header byte to
> zero. The SRv6 End.DX6 action also passes the decapsulated packet
> to ip6_mr_input() without checking that the inner header version
> is 6. If no MFC entry exists, the packet is queued and later handled
> as a netlink request: its payload is treated as an nlmsghdr and
> written to, mr_fill_mroute() may call skb_put() on a nonlinear skb
> (hitting SKB_LINEAR_ASSERT()), and the skb is unicast to a netlink
> portid taken from stale IPCB/IP6CB bytes in skb->cb[].
> 
> ipmr_cache_report() also relies on the same tag since
> commit 94a6736bb5ab ("ipmr: only copy pktinfo to cache reports").
> 
> Stop trusting packet contents: queue route queries on a dedicated
> nl_queries list in the unresolved MFC entry, and pass an explicit
> nl_query flag from the callers.
> 
> The per-entry limit of four queued skbs now applies to both lists
> combined, as before. The synthetic header keeps version 0, since it
> is copied into the NOCACHE report delivered to the mroute socket.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 7bc570c8b4f7 ("[IPV6] MROUTE: Support multicast forwarding.")
> Reported-by: Katherine Leaver <kleaver@janestreet.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>   include/linux/mroute_base.h |   2 +
>   net/ipv4/ipmr.c             | 104 +++++++++++++++++++-----------------
>   net/ipv6/ip6mr.c            |  76 +++++++++++++-------------
>   3 files changed, 94 insertions(+), 88 deletions(-)
> 
> diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
> index 4d55827e970537aff6938503a39ee3306c8fde6d..2d506966357b2591af4eadef88b27e236a2fe9cf 100644
> --- a/include/linux/mroute_base.h
> +++ b/include/linux/mroute_base.h
> @@ -119,6 +119,7 @@ enum {
>    * @mfc_flags: entry flags
>    * @expires: unresolved entry expire time
>    * @unresolved: unresolved cached skbs
> + * @nl_queries: queued RTM_GETROUTE requests waiting for resolution

FTR: the above causes kdoc warning, but fixing it would be so ugly:

   * @mfc_un.unres.nl_queries: ...

I really think we are better of this way.

/P

