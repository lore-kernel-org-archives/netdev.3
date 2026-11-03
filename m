Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707487;
	b=Oz2skrEUtJQH0uN+hq1StWa/0hGPZzt5FCNsgZ3AEQs5we6TRcZojd2jM5hVkrrfx38H
	 liEtIOu+yovJWPsCzT+edCEQaoKcz99F2ZpsAvg1yug+8Z6mYhgwJ7/sO1Lv0NL+PjIFb
	 mIwbfO50sACQJlp+N2HU4Y1AM/7tVqI1GZjoveoMgv7MXCkPMLgSehLoZaU5GKfCcr57a
	 T/7HjSoc8/C2LR0nB2/PYpJKYusIDRux365sd+A9Fk+xi7PoRe59lP5/8r4b9hVPXpwoG
	 R7SAX5GFlilvQdFbXEr20z1iMUoehLM2PVUYJ4CjSYMwAWEsFFeI4SVgPuWN2XYRtGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707487;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZqbSq0DrPxgLJkLEtNhIYD4V8Brh3IAUvvQYZu839C4=;
	b=SJgVYeCkKzBpL/cnJQCt2iO8aj3jcfJN2+5pzrfLJkFDlmibuSmjzkWQREZhntEmb07V
	 jtDmKZtR2HLwwl9qjby0ZhLTsX00jeySBqw2JJBomkU1jJ8BWeym7xBLI2owrfph8fhAr
	 eWhmbGViLAEelO4k7T4cIM4ORItGcgVn2olI1W7+2+I4DZiDshhVX4q8u7x9LFBHSnDKr
	 TykTjO3XsGn+i8ljV9c5wG4r6XqnSsWjH6KeJ6DxUlSpeiGSJGhtbVzMKayne5DDo1NzN
	 op+whNd1AMa+KYP5zamM2xSZH0XnfngzZIsR9Kx2jMdEqtMWyzjW+fb35gZD7C/OFjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=df3IbQ+b;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Bcv5UaEo;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C345606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C345606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=df3IbQ+b;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Bcv5UaEo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793707486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqbSq0DrPxgLJkLEtNhIYD4V8Brh3IAUvvQYZu839C4=;
	b=df3IbQ+bstTq1C1W3ySHTwuiWY9HoBGKlcGqw0F8RS8mI6qf+W7iZMAXRFQIXAmcAYk1bq
	1djD0UB3A8HlRp9p5ax7mANqQbTxBpP2+vhTFQRNi6YTWZNGWdcr1UZXWcdfXDmLoaMQ+l
	I1/UFX4roRq7UkhVq/79c64JnJwDoj4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-9jE2FJSsPJ-jYIGapF3gwg-1; Tue, 03 Nov 2026 07:04:45 -0500
X-MC-Unique: 9jE2FJSsPJ-jYIGapF3gwg-1
X-Mimecast-MFC-AGG-ID: 9jE2FJSsPJ-jYIGapF3gwg_1793707484
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a77c1cbd15so41081015e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793707484; x=1794312284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqbSq0DrPxgLJkLEtNhIYD4V8Brh3IAUvvQYZu839C4=;
        b=Bcv5UaEoGLBHQ59uWT6nvW6UZt2kp4IhlKocyy/pIFO4Sprz6UqgQHQtbGn2rdBnV8
         EychCn+5m6MgAiD4NDZ85BFSyXKb0vWz6b38FS5kt9bwb/uM2zKoBLGNnQYUarFFmY7/
         wFPtvyxt6faL8mkoQOLAbVE2/Gjb0naqrh5GNdObrwYQGjzb/S4F1pGgwn4EHgd+Ou3w
         2nmigrHXm410w1WTKO6xFoWQEb+s5FRq0v8Y0yWa2Pr7T/2mkUSdY5Z715bsfhBUlMbZ
         zcERtr7Dr/9AjdYjZVBSaf6bnDgS6Jj2SpP9ykFS0XjfG/9zQRPoUfiM27d2IgTUhua/
         RDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793707484; x=1794312284;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZqbSq0DrPxgLJkLEtNhIYD4V8Brh3IAUvvQYZu839C4=;
        b=tNzSg4P8N32PnGYux1goVDgO3E77JnY/AsVzNJKdBUlYf9MCv9rCKAkZuEndvUAtqd
         VIfi27bWo3P5hVkNhg98bL8m0EbU5mujCCWEU28eF7ZpRrTG20HJQxrE3I6E/EKSNsb3
         32ERtMCUIDCQI5u9PGjO2QGTH8kanGD71KK3P/U+tA+v+akIb2hvGM97kf+l8EyC1/iY
         KaW7Ym5c7lfcQPOs+KLLSbpWZSiGkRPRIdn9vVGut54PNlQZkLHPdPnkosp4W8nn1np6
         SYHC7YxxAyXccZSCEFaheJZtdGfBKnA/gLsFNcIXInO8GFWa5MqqR0+YRgd2VyAgyEhV
         NKrg==
X-Forwarded-Encrypted: i=1; AKwUvByltzgWL0mFAuzR9tLdgfhThMk2vMT7dtDxgyWS3UmvXj2qmGKUKZO/ckVjzj7FajXUnvKMkk0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FtEgGg/KC00cknbWIbjyXPLMsUu3h4Ek6OFNAbpKpSZm2VpQ+
	fehB8BuOYPc9L+Kq2dlHLFlnuERUfGQfCCUb8KfNyvZvC724n8eoSVwXuYQRo1HOTuouQ7OJIXS
	9y8j7uxhsVIN/0pwAzEXhnkxmsqRaea9kEDgXX9CRD52DKdgsoYKpKSWtTw/IOS6GqQ==
X-Gm-Gg: AYBFou0kWQ4B+lJkwbUV0uTbNmVxAWE5NBN8JQH3A/2k0M375eES+817In1t8+9idj9
	DyxV9ej8q534qMq/3Io6NfH8wEXr2Fop4BgvqGmhhlFhVzRTbXkCWU9SvCzuPhZCCxQ4fEvCdZ6
	o9zohWlJ7H0nnfx6Pu3em6WbuLj1BtQhhZqGbZ1Ar4DMZ4qCyVCFjjkR0o+JXa0b/S+lZjvdnwN
	WeVsKedDTEZ+CFvvYc5zoSDvUhZtJVX8d0o2A+S5RjRWzLVatDTt84Nwb/xaaDF6LtQsCZxj1fZ
	mJP+TCUex4oOCBF6A18gVwCLZmwuPOAs78NyukQ5fl8ySsTpk7rOL5gy3Fxj7hOKjN31pbvsH4/
	jOqvvJkWWVqRf32D5wFi6wn0eonn7jDEFdH9KDVDGIf2gA8zLoJ7qpcby1s8U04O3U01XRMDHNp
	5X0oXI8E9lEOQh8h7F1/RtkGCM69pYXpVtn/+G0fcvLgE=
X-Received: by 2002:a05:600c:1990:b0:4a7:462c:6b9e with SMTP id 5b1f17b1804b1-4ac1923581cmr280827085e9.32.1793707483821;
        Tue, 03 Nov 2026 04:04:43 -0800 (PST)
X-Received: by 2002:a05:600c:1990:b0:4a7:462c:6b9e with SMTP id 5b1f17b1804b1-4ac1923581cmr280826555e9.32.1793707483404;
        Tue, 03 Nov 2026 04:04:43 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab3ea6a9sm80111865e9.15.2026.11.03.04.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 04:04:41 -0800 (PST)
Message-ID: <b452b25b-37fd-48ab-a88c-feec6b82e9ec@redhat.com>
Date: Tue, 3 Nov 2026 13:04:39 +0100
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
Subject: Re: [PATCH net 00/15] Netfilter/IPVS fixes for net
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@kernel.org, horms@kernel.org, fw@strlen.de, ja@ssi.bg
References: <20261102005654.532438-1-pablo@netfilter.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261102005654.532438-1-pablo@netfilter.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 01:56, Pablo Neira Ayuso wrote:
> Hi,
> 
> The following batch contains Netfilter/IPVS fixes for net:
> 
> 1) Add recursion count to nf_reject infrastructure to prevent stack
>     overflow, from Fernando F. Mancera.
> 
> 2) Address a infinite loop in RCU list traversal with the TWOS IPVS
>     scheduler, from Darong Lu and Julian Anastasov.
> 
> 3) Use kfree_rcu() to release IPVS parent application to fix UaF,
>     from Chengfeng Ye.
> 
> 4) Fix UaF in IPVS netns removal path due to releasing per-net protocol
>     data too early, from Chengfeng Ye.
> 
> 5) Fix unbounded growth of stale, unmatchable IPVS connection entries,
>     from Julian Anastasov.
> 
> 6) Restrict maximum master conntrack chain depth in ctnetlink,
>     from Florian Westphal.
> 
> 7) Preserve recursion count on nfqueue reinjection, from Zihan Xi.
> 
> 8) Restore GRE timeout in the flowtable, otherwise, WARN_ON_ONCE()
>     is reachable, from Michail Andreas Michalopoulos.
> 
> 9) Check non-null gc transaction in nft_rbtree before queuing it for
>     processing, from Xingyuan Mo.
> 
> 10) Replace WARN_ON_ONCE() by DEBUG_NET_WARN_ON_ONCE() in
>      nf_conntrack_bridge which is reachable if the protocol of the tag
>      of a frame differs from the vlan_protocol of the bridge.
>      From Laveesh Bansal.
> 
> 11) Check x_tables target name is non-null before accessing it when
>      building a new table, from Fernando F. Mancera.
> 
> 12) Fix out-of-bound memory read in nf_conntrack_sip, from
>      Joas Antonio Dos Santos.
> 
> 13) Fix a memleak in nf_tables hardware offload when double deleting
>      the same rule, in the same batch.
> 
> 14) Use a mutex in xt_recent netns exit path instead of spinlock,
>      since proc unregistration might sleep. From Cen Zhang.
> 
> 15) Zero the nf_nat_range2 struct before filling it up, to avoid
>      using stale uninitialized stack data to configure NAT with
>      an esoteric NAT flags combination. From Florian Westphal.
> 
> Please, pull these changes from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-26-11-02
I'm sorry, but something went very wrong on the nipa side: the tools did
not pick this PR. Do you mind repost it verbatim?

Thank you!

Paolo

