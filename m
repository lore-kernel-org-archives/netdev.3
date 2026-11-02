Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631870;
	b=Dcc3iFrmRl4DpLUGXvV95baP9tPmQbiS16CbQzTlLLS/Fgys8ulokE+6g7jkkvTsTDWq
	 8bLRXqSfgmy3UF/+V8HCZtS6uGAg7BXSMP2juJzBPfpDihU8hRxBUVzg8QbxvLFyi8l4u
	 d5cjAXAU+aLlM4V785P0Pu7hxOPG9LuZhNVBmkV81zYSMUuYMVcIJBRC7QroDmSIkKzTE
	 CsKEJ+ZHZl8tALY0kWQ/dsTTZ43UH7hTiXk8+bZd3bHwa1HwpOPBqdGNsbOJkfn7vPN6F
	 5gZw9g5CmOwFr+WChpMU+J4MkaFN/JqAgKS/Hm50CFm48ZIop0CjmH/vgPQqZjMV0rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631870;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4fA008cerU78BCHAofvMFL2hjDxFpzl/8zUGrxds54c=;
	b=CXppzRmJLU4/9H36/n30WFHm4T10+k6pSs+igPfbFPNlSvGy/U9W0Kiuj+pO8+g9Sl0A
	 duBKwbPWOhm7q/XKmuR5UYzdFdURwK932NWqXL8vyPsVHAobOHpKb0CyTPQTjDX68XXFY
	 tI6u9Uq0B//jOvnj/2K+bcLXRqULzdY2YmzxhTX3XoVBPESO6n2LAq/asa7MyNTcio0b+
	 6P+1wtpz7DUvwiaBRUgoSNanmSrOXj3a2xt/ZmTmUnOTkUv25Y4uPvhI64Ipx+SC1VH6+
	 Spae8Gx1/1oSN6WDAOJfk8WIoTBK3ZoNHZSQzAbOCBtJNyZCvreP+0YQp2T6PxvBgHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gdxKNWOQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KAXFWBPi;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5196460703BC
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5196460703BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gdxKNWOQ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KAXFWBPi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793631869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4fA008cerU78BCHAofvMFL2hjDxFpzl/8zUGrxds54c=;
	b=gdxKNWOQEk++S4/1bXtMi507dNZmHMapgdaILo1y7p4sXk39Udy2F++uT3a3D5kre1xrpD
	1bRjMfIfNzSKS7gVAoIyMd7UJgCGpIAaJADw8BI+uCD8Cib/NtQJ2907zNE+EQHZiVv3Az
	Ois4/7SyB4i8xy94WrBsQxuo2/mOE/Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-eapLGiAQNK6M8bNjNKULBQ-1; Mon, 02 Nov 2026 10:04:28 -0500
X-MC-Unique: eapLGiAQNK6M8bNjNKULBQ-1
X-Mimecast-MFC-AGG-ID: eapLGiAQNK6M8bNjNKULBQ_1793631867
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so32833865e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793631867; x=1794236667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4fA008cerU78BCHAofvMFL2hjDxFpzl/8zUGrxds54c=;
        b=KAXFWBPiPvK1zdlOSD7Y6+WhcMNsSPF8TEk90tpnyjlVD1yLrHRLF1ID5BeVYevEsN
         WS5uyoS3SyJcL1bA5Ojx5M+DHmPCBxIkPqQBf6wGSvelyHORsY/wRNoTeWvfrotXJy5P
         YnznCVQ7eoSIpBm3BCPwiRakjb+wAOlRQsou2orIRniLZzaa10zvQJpOGPP6IylEkhGD
         PNA6rG/Oi3zBwqp4ZD7ftqV5HU5+daEZtGZpszMjRsvgCj1u3kj27z64meTN3LcupcEL
         HVLR1NEKVoZdaWUy0EaNYKjK5TqlhfME1dGoS3VUmGyOM2OvfS0/MsEAVqUFz+Wx7Ly2
         NZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793631867; x=1794236667;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4fA008cerU78BCHAofvMFL2hjDxFpzl/8zUGrxds54c=;
        b=Sewji8jY6P8QhhYUMx2HZW4JXd0hRBVZi7BA4bHsHuQk+VT0bK9e4+4+p5172OneMu
         eUri0zfn4leICTQR5W0vxWWCRzWmmn2XRcBSEMYk6daCytZO8RcsJshUfJF4wCjncuQg
         waCOO3M/JVznjuuEBIaEO9SXrFGN9L/fboIh9tgPDjlkbl12Maq0Ur46J+3lufU2rx+j
         uD8VEQq9cHjSheXO55VOq18o9GQPKOqBT6cylT+/A+K8SdCAn7abUPcKOenMSWeOjACS
         JTmAUOeEYP6ROWKoQUttSVha8nWCcAsJe9VcyTr/FvesuUUvv5FHN3Xgms4ZU1TCQrYa
         IoBg==
X-Forwarded-Encrypted: i=1; AKwUvBxi2diotLQbOFBkFMavMhMXC2dHNPj5OqyPsXfld7IwJaTlgcIDDUTItRqo4zVLtpQU3PUH0h8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyo3PYyiF/insxc/MiQgrEk8TRZvFyYaDtmxvly9J0HJkTu8SO
	MWG6nS2A6gcfohCHlx73rzuCiRSMXwwdaovKHKgz/9HLkJAYDAeOi//ZurLqaQPkLDN4YCiPI+o
	bTF1FBNwfnLLXS8kWA03dg1iq7AaKz6JgBWmk4VYtxYJbwAreTpBWBe8w7A==
X-Gm-Gg: AYBFou04DTjItPo2yN36M1pPry2EEmvJ0eO0+KA2J68dYTwdW/ryay6o3TRDAgPU72c
	A4QUBHpYFVcbR5ibxWx3AYW2PEmFXKylPHmn7aXKk1sNZuD6jsMrg+Ta+Ee8+zry8SPzqkSN5LG
	r4SHBKUqVkQwPKg7RcGXzKbv0Mpq3jGv+CQmKqjonVUpjNCxdv737/O6TniThVVXy5vn0e8v2mb
	P3vvfVcMydSIdKMz9vhPaRosf0o3R2Xzy/Lvpdp2SUiHUKMFXmGrpxuXWlegF0NRwhfKyedwtXq
	M7hoDEWkXpzsMvCP/mzgaIcH8uoaG4UH1C3ZfIX8ru5hoMQklr801E6CQgM7Rw3ASmGG0KhFZj1
	B7rgRGRFWe/nit0Ve3UQz4aypJ9cFA162pvC6bEMSp9XbEc1CGnS6nDz7lAeyJhifOLGYD4n2iU
	RgjbO12HFkhtFUXaL+HsNwBC9eCy8dwvveetHvFeDLsnc=
X-Received: by 2002:a05:600c:4715:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-4ac17567cc8mr228613935e9.11.1793631865961;
        Mon, 02 Nov 2026 07:04:25 -0800 (PST)
X-Received: by 2002:a05:600c:4715:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-4ac17567cc8mr228613495e9.11.1793631865501;
        Mon, 02 Nov 2026 07:04:25 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b289f7sm279340495e9.5.2026.11.02.07.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 07:04:25 -0800 (PST)
Message-ID: <24feda7d-ae49-45af-9596-2cc5f149f28e@redhat.com>
Date: Mon, 2 Nov 2026 16:04:23 +0100
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
Subject: Re: [PATCH v2 net] inet: frags: limit the truesize of a reassembly
 queue
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, Kyle Zeng <kylebot@openai.com>,
 Florian Westphal <fw@strlen.de>
References: <20261030081225.2575462-1-edumazet@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261030081225.2575462-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 09:12, Eric Dumazet wrote:
> The truesize of fragments in a reassembly queue is only bounded by
> the per netns ipfrag_high_thresh sysctl, which has no upper limit.
> 
> inet_frag_reasm_finish() sums the truesize of all fragments in an int.
> If this sum reaches 2^32, it wraps, and the final sk_wmem_alloc
> adjustment of the socket owning the reassembled skb can cancel its own
> reference, leading to a use-after-free of this socket.
> 
> This can be triggered from an unprivileged user/network namespace,
> raising ipfrag_high_thresh and using padded TUN packets, which keep
> a large truesize after being trimmed by ip_rcv_core().

Clasiko infers a similar scenario is still reachable using multiple
concurrent frag queues:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030081225.2575462-1-edumazet@kernel.org

I'm unsure if that should be dealt with separately?!?

Thanks,

Paolo

