Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591775;
	b=FMlXInQ42KBA47U9WXS+BPejd+y5OVPhuJUn/+mklP/qb7B5SpOEpbssQcUeYQ8cTlTh
	 Mmwtc2aBQbrpj3mjiBjpPXpkeBeJEg/A2MUgdTD8W+5RXRCBxpEaN63I8wlK4sR3fFP/Y
	 rav286z+htrO8eQvYSuHckQFFH7PjtYHkx7/lWTDzT5+3LkOT9Flf+V+mZn3LRVSE6SsS
	 1cuM3vqpDuq0eKt47LNhx0mjgqn6DDQ9RR0HnDLKlA2IKkg6vfdRSYTuufUmS4BkmV2rE
	 bL2O9TQFePjZBsEj6ZRmDU/m9w6x0v6MqK3rXPte+R5OFNw6yKNw96nUnEJM/bCBy3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591775;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5CvprOY8GdDKnUT4fQztxlFl9qvx9dxL64cl7Huoi7o=;
	b=F+JLi38MyTXPfpOmHWT1A2w85E1yW/v5uOTJlOM4YzhC2iog9uJDO1LeBY5ueAX/qJR4
	 YGZywmrgEfzfuN9Mw0CCG1ZFkU6srBSJMj1ntDDWrMkDD/7pHg03YTht/X2sV1xi6MWmK
	 50rpKfPD83LZOmWoVwF/O3RRgbVPptqP5Sx46Ck6Fotgpf0eOWmdyreewfHKChNdvmGdA
	 STQHXD7HrQYDZOi3IDtWHJ8G2h/xL4U5fSpNoG+oxWOOWo8COA3Q89NNQE6Q0a2JTkhqM
	 1GqAdnASbU1mJVX5tXWwOqMzKfUT2jjxKBnvndPGznVXoxhKePmCAhF7Y3Q+MxOOs+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ElS3rNnB;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UtnLIxdQ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A077B606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 14:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A077B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ElS3rNnB;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UtnLIxdQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792591773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CvprOY8GdDKnUT4fQztxlFl9qvx9dxL64cl7Huoi7o=;
	b=ElS3rNnBZMoc/bjcdwIl2jUMQENHpfc8vRCcY45rAffUFxZjEFDRFQVTigjCIi0ymz/iTB
	iQhvZ//84bcfKrwIv6j9/4+wZ6WId1tzauGegU7B22MC49L4hLGjmBQ1qq0xcp69eXrtsy
	x9fMYcJd3ycRsf8Wy2ie+bTMiE2toZA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-W6xxGhCQOWyb0L7BhMKKhQ-1; Wed, 21 Oct 2026 14:09:32 +0000
X-MC-Unique: W6xxGhCQOWyb0L7BhMKKhQ-1
X-Mimecast-MFC-AGG-ID: W6xxGhCQOWyb0L7BhMKKhQ_1792591771
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1df6c2937so7889105e9.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792591771; x=1793196571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5CvprOY8GdDKnUT4fQztxlFl9qvx9dxL64cl7Huoi7o=;
        b=UtnLIxdQA2lTnSByHVImMXFviGILVn1KcFFs5kIC0Y5ti1ySrF4CephjMcpeA3fuX7
         hMVH0jsoanXPUlpkhnVbBNFjXcMNkEkWA3I732ix3cBTjrKMGY8ZC/M+SjBoxMiwWEHa
         dUjTq2sTjleNE7/uf4JhI4aOgK9EVUrA7f1GWVCjXqP0knzRNgK4dGvdvzfEMzJovzUB
         m/zChMe7l5vb73XzIPOT1wl2sVLChFmCy7itKHP7jrlo3tnH5Apr6gKbggqhKxsd/Rtm
         JdaxDxLi2sBi+D8CNP3cuswX/hfg55AOjSV2lqeFi+1lkc3Rs7IHzooPzHwsKxnbhflg
         te1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792591771; x=1793196571;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5CvprOY8GdDKnUT4fQztxlFl9qvx9dxL64cl7Huoi7o=;
        b=PISgRssx61+D+GrJ6Ta2FpjVkE2ef5Y7X5nw8+DuCPbbXZF8Osv5JDUkJo42NfGuet
         jDSiV0aqrDRT39Wqp/PGBMEHtrp9dqanUPY7KM8wng9i9K0ZzgwxlbrUC/AUYVX4VvUv
         tnncqED+TS6EvgRgqknD1Mo2a4bbfCyQWEPWAaZnY5IvgMyHBP6tsDRNsiZQ1HhrOIZY
         75h9cyQntBwDVaBbm8oELbHq91F+E8lBY4DXsi7a1ZLEXSjvhxOBpO6t5An1XPMGLL4j
         vEHuBr6XmYNI28SQ5fr70/24wWWi4xu9t4HMEyPsLNgs+gBwI6rY+pogCZ378orG/n6F
         34Sg==
X-Forwarded-Encrypted: i=1; AKwUvBxX4EuSPr4edmFv9qGDV00B6Rp8fdz5ApefHDMNg3yiHs9DfNZVgAPcJ2jFZG63C4BTVWQlZQo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxdph145uYYG9s/62gz4seJIQkWIhndZGp7FVJw6Ctu6JesDPC
	PzmdoTzu8KVIsvZ5eRLgMargX09orQNPkhP4/Kfo+73Cd7YEE6+r8rYBG/68Y770o3raUT93zJ9
	DaGXAekIexR54IKKOkCEW0jp2tYdsfYLu4lLZswMSMg+4nrEzTqcZUIufEA==
X-Gm-Gg: AYBFou2hJbGPWoYyjU9/bY73OHzuE3mhTz5FanQUmQaNoN+8R9/l9WkSXbhO87rkBhi
	bFQV9Y3KbM6DpvjYH/PJ8IsEfU7NYqBhBphGcQiv5d4KMa/OQDzbEP/3rcJ7PGYle5yN9uQWAG1
	+1Dy+aIuJzXn2JBWiXlAj15DwIruJwD/SlO1SdPjabHgZ+ba0Yxu2mraacUTBOd19sVmt3DzKIU
	6CeWTjU/mxGxaxtfWxsgbtM8HTPcN55BD9sM04Nb2h/72CvNiZY0LhbSKi8HbvLNm/u07ffCKln
	klMkBm8w5HOdGG0sf4HkBul8KtR2f1WcMI8YBZil+ANyPNFjQYxuqXFNo06tMPk3H0UgjdHCBAX
	M3VYKyrdDBu9W5qsbe3ty5zZjL2TfORGHM813AnAiqCBqRqrpPr0xR49aeDNxdnzdhoYUDBl8BA
	==
X-Received: by 2002:a7b:cd99:0:b0:4a1:877b:d4e0 with SMTP id 5b1f17b1804b1-4a1f53bf67emr80568115e9.12.1792591770974;
        Wed, 21 Oct 2026 07:09:30 -0700 (PDT)
X-Received: by 2002:a7b:cd99:0:b0:4a1:877b:d4e0 with SMTP id 5b1f17b1804b1-4a1f53bf67emr80567525e9.12.1792591770430;
        Wed, 21 Oct 2026 07:09:30 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828e3bsm5669285f8f.31.2026.10.21.07.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 07:09:29 -0700 (PDT)
Message-ID: <03a741b8-f330-4d2c-9254-153934ef0960@redhat.com>
Date: Wed, 21 Oct 2026 16:09:28 +0200
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
Subject: Re: [PATCH net-next v1 0/2] netmem: rename non-pp ref helpers to
 *_inc/dec_ref()
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Ralf Lici <ralf@mandelbit.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Pavel Begunkov
 <asml.silence@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 Willem de Bruijn <willemb@google.com>, Daniel Borkmann <daniel@iogearbox.net>
References: <20261021015558.4124825-1-almasrymina@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261021015558.4124825-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 03:55, Mina Almasry wrote:
> Rename the net_iov and netmem non-page_pool reference helpers from
> get/put_net_iov(), net_devmem_get/put_net_iov(), and get/put_netmem() to
> net_iov_inc/dec_ref(), net_devmem_net_iov_inc/dec_ref(), and
> netmem_inc/dec_ref() to follow the object_action() naming convention.
> 
> Use *_inc_ref() and *_dec_ref() rather than netmem_ref() because
> netmem_ref is already the typedef for the generic network memory handle.
## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

