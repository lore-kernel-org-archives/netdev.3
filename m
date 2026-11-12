Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494996;
	b=D2baMFq/ZsBWp6fIE/FfH8zbHYVhCNNYtw/tETu564hAZMW6NhPSAhJTahDc+h6Lipf3
	 SdoDFWcRRLJUlATarwjh/zgPLO8Z7OaG61uwcYn0yJRkBEnPTZ3JopgAy0vCpIBPWzMhn
	 XdXKEKJvJNLVQfnEYzZXsbduKWRuKSq+g4C4qM8HnJYvPpeBSLQ9u5oZ5tDIpnGBjYWvG
	 eYmK5ngI6lD3rZJLClVeTS6vlX+IqWV+t6JVbRrktuneapeFT36tAlGmOvP4xmrs/zxkb
	 Ecl7xVpnQS+Tl0WN/WGsY77LrFHPcqgM0ZsMdZMVkv5cyb7PTeQGHPv0A+rNfLdXyHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494996;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=vfNdgyP+NRKLkAfEjNEeqH/mZDeg/vBSn9uePnv4O7Q=;
	b=osCYcel80UizfEB768PFIvMndkUBxgs1ye1pNf5rskd9l3mEAPLrCwHTFFKEjWsqvX97
	 OKzPYAk4soyM6CiZ94EVtF8N6Aeq3cbHahvTbWToLF537u+PKzXRBRhGJUBbEU4JozzlD
	 j7wf776PMzfW3XT7q3GOzU9NZbH9tM0NE5tcEUwzM9rRoq2GcNaFSILc1B7uSZdGuewHf
	 hxSV2J9LY5f8rbCxttVmBoFGZOszXNUoRQRAhcH2U7tWaCSM0DeVDzV1X0z/lbwJ832RX
	 qOAeatXWIv5h0cJCfKFmpl0r8ka7Y3bbW7WMJW+YignjdQAtLSVWZy6JCZzvRDXpgKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DFRUeeaZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=d36m5nSx;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4D606A336
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1B4D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DFRUeeaZ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=d36m5nSx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794494994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfNdgyP+NRKLkAfEjNEeqH/mZDeg/vBSn9uePnv4O7Q=;
	b=DFRUeeaZ7PukFq0E2zU6kQkUyhWnE7OCKXlOMhuO7y9on1VxO7Lm6Qx4yRkDeBXOz/DyM9
	VMeC0F/8++wR2SgbJDGdjf+9TSTHN+/Li7QoUmAU+YdhzKylg5W++5mKvoBCfSuRB52toH
	J/tT4jqZwBYN1wxH7MDGWb8VLyAc5Kk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-A6GNV9KiMwWZICVbFzyYOQ-1; Thu, 12 Nov 2026 09:49:53 -0500
X-MC-Unique: A6GNV9KiMwWZICVbFzyYOQ-1
X-Mimecast-MFC-AGG-ID: A6GNV9KiMwWZICVbFzyYOQ_1794494989
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-490ab0a20ebso3282999f8f.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794494989; x=1795099789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vfNdgyP+NRKLkAfEjNEeqH/mZDeg/vBSn9uePnv4O7Q=;
        b=d36m5nSxoDWdvyYtLqnat3194iJTv5RdLjF8A0cLiDThlGMtUpCYJPUhOr+doqiE47
         SCZNGYTmAilxtj0XcaFk97qT1Zkp0AODjD0FiQd4xlqtdHRJNs5RVOMwhjwOXTk6B2Ot
         x+Mtm4olGs7EyjoH1yE4d7X0dxfs++EXzuH3u8+OU+5P9KQBC1fgxbjlf8/k3jFTdm+s
         cRzGbvNcN10o8dgvCCXKWQ5L7ZdDGFMlmlKCN9XCvf1RjXteKe0+cypskqqHJs/cu4oq
         c/xWT7BVJu1q5tISQ/1tlVUUZcVhx8hQ0HoqfgcgILFrkq+32bZdLEFoM5muSmA3RvaI
         cxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794494989; x=1795099789;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vfNdgyP+NRKLkAfEjNEeqH/mZDeg/vBSn9uePnv4O7Q=;
        b=TfVbztaA2ZXzLlCDzXezro+bgDZgvh03Yz0WJoGLJExmPfU/t470ylOTDYk7Ez06hu
         JaCHSaNvzlLcQH3hZ4JIKjxjmunoiO9yNBw9E3MnYYw+PEP/eBvsxcwa2qPztsS5ZDNC
         QuMF60/s1mLHzxvraJpsD09KEbgV9TEM06JiD8+VId1Ws48+skLyhu/JNsKJvzwR0mf9
         KD0HD3mOPD75Xf6rHt7HWgCPEQ+5bvqXConaXHHcxFuFQAPb0e5vASNR3DWhgP5T1vS6
         gt0xx/zyzAn2zPYBDHBGvQbAr5qoGyUcjULIFLxWDHvScfvBZBIa9qb/AG60EcFUfUJg
         wtgw==
X-Gm-Message-State: APuU4Z9t3chUuG+sRmkwruelDicS0V2+7GJWqcfbVQXS1BWBffqd9daR
	+/AcAB06x9hzb8AcZdjxuozmcmH7+pbtVWhd9IGp5iTNMUOrUlD+i0UskCvIU9MhWKj7qF8zzio
	nyvN3pUS/wM4Xu8XXLO6xKKvVibdt2Y2dWoFWaDNdqNIEhPxNymI0XDKuDw==
X-Gm-Gg: AYBFou017mpssv8oqfABWxROfb59Di30JPBdz1+fnMFyJpIoBLihzA5oXgT+18hYXr6
	p8admuvRvlihIZVfcfvAumLf8ihi//aNG6PMzH/nRZAKaKn+ksLtTdCtzsqm19VX7YWr/C8OyNC
	e+q4scvGtslYJmCWdeOQ2X/058oL8bUlKVWptdhJr4OF5LqUcYLyrZnLZZnEHEpwxgwaUlGpmgY
	QVm3sqgKboEnfyIxySjkIJXc3Z6swtnJcpDinwCFAZSkf6Oq30G2EVdlMb6bWv6+ePsreAXPtvr
	Fj7Jz9ewri5HvAOQcAUKJE3vs7SXEtWZrG6uj/p9REBVBA1kI68wLTeVxl/8l+k/2VPhmJBjs22
	xPWZPQlEG7CBieWkEruujFqfunK9C9n/Xhh7UE3oHs+wSsPG14N+p5nFVQoQCpWRbYLdepL4diI
	62DSt4GjsjnGWZ2TYSU+6+PuGHv0CzqmG5EBy82ZuVcaBG
X-Received: by 2002:a05:600c:4ecb:b0:4b9:ff69:19ac with SMTP id 5b1f17b1804b1-4ba093811d3mr106230365e9.11.1794494989332;
        Thu, 12 Nov 2026 06:49:49 -0800 (PST)
X-Received: by 2002:a05:600c:4ecb:b0:4b9:ff69:19ac with SMTP id 5b1f17b1804b1-4ba093811d3mr106229855e9.11.1794494988926;
        Thu, 12 Nov 2026 06:49:48 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2969e7sm66879205e9.10.2026.11.12.06.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:49:48 -0800 (PST)
Message-ID: <c4910aa4-a477-4b0b-b875-52703fc8bcc2@redhat.com>
Date: Thu, 12 Nov 2026 15:49:47 +0100
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
Subject: Re: [PATCH net-next 5/5] net/mlx4: flush pending doorbell when
 dropping a TX skb
To: Daniel Machon <daniel.machon@microchip.com>, Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20261110231304.1859217-1-joe@dama.to>
 <20261110231304.1859217-6-joe@dama.to>
 <20261112134346.zvctvknj4mc5s2pm@DEN-DL-M70577>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261112134346.zvctvknj4mc5s2pm@DEN-DL-M70577>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 14:43, Daniel Machon wrote:
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
>> index 123071a47bed..3166837711be 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
>> @@ -1135,6 +1135,9 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
>>   
>>   tx_drop_count:
>>   	ring->tx_dropped++;
>> +	/* an earlier skb in this batch may have deferred the doorbell */
>> +	if (ring->doorbell_pending)
> 
> I think checking !netdev_xmit_more() here would let you ditch the new ring
> state, but it seems bnxt does it the same way, so fine by me.
I don't think checking `!netdev_xmit_more()` would work, as
`__netdev_tx_sent_queue()` adds more logic to it.

Still I think that the cacheline alignment comment by sashiko
on patch 4 is relevant:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110231304.1859217-1-joe@dama.to

I think a better binary layout for `struct mlx4_en_tx_ring` is needed.

Thanks,

Paolo

