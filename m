Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213315;
	b=roXOZf5Y6TOdmkncuYUMCiM80PbpDh59y4qJrD4XMK6IdjzPFiLMWYH2ig8lKKvFLJ4U
	 r1K2T4Uh2o1nJkpHU5/fS9BX7OGz07/ztztwT2yuWZr9xOtKbow3+HvlBElH/VZAN//qL
	 v/TIEjpeHYcr+X/+m8MBUPQVLe9zKNsq/2uR2wLdS591iVPYf2wZLsjJaLk+IWTYePfWc
	 RuKLFHQbtMVpdJqOZ74WjZ7puS4N6IkEhSWMpiyE6AhWm5TPse6RvpyaXJyKGV5XQ1loM
	 y831H9c0NqUAu7ZCjS/ty0n6aR+QlajDydPuGn9H62ZWC1QjHP0Rw6cE9q/HJeYoLvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FoM3jrwU9mnONLYaNhWTsxjkZz6IQHFf2kOZKAb2OVw=;
	b=pttCi9tUKbq1yMqrYXrImMkY02qYHomkDccYlX28aeBlD9JX+drdVQRzD6jecndzU7pF
	 G6uVEjAR/D0Ab5aKMtfS+qIkWdhKPjKzvnAYlmvBpUgtSrCbKMPOl7o06/f0qvRbRd1jH
	 JXmH3AFzBuZtAV4RLzXHqsM0l1ogK+rU4IteViOFvaHzIGT6H8xNlTuQNxeNt2Buu713G
	 gNNmv6YFSr29hBJyk2LsGhaXvVDevQG753UVUHi6vvRUXvi/dm61T5Mc0VVCZiazZfBoT
	 t3BNOKOoAU0BFL9vZF8GXpJp4qy/5Q0JymsTU5t0EzyNDKy3bJYECrmfnGrzs2qIRqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HrG6VXhJ;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30EF606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 18:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F30EF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HrG6VXhJ
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b10d24345dso12999147b3.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793213314; x=1793818114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FoM3jrwU9mnONLYaNhWTsxjkZz6IQHFf2kOZKAb2OVw=;
        b=HrG6VXhJZUpYGzsQlGM7mXpO7NaSEsyM5NgP2QNvXh/XDogGvTnyfAuehx353+xEBh
         IVg4hKvcedg3x50xIyIFetXyyqFOZNUjb4RJkJeTg+o+oY4W0UCbJYdG/vsl6w0xa7WH
         7bYgThfyccr7ydpX8XLkugAF3tj2x8ZLlw5EWSMrAt7UyNEpj9Avnve3KQbMbvEMUocC
         6WOwqa4k5KM9BkQFKycLJB+3ywP/x2YoXanyFnKl3Hr6zSG+GLuTGr1MYj+HgKGr6oaj
         6L37rkJc9y44GssbLEJHjgdqI0aXKwSlytASZGQAV5vDjK2raS3573lKyafTFFR2KdN7
         OPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793213314; x=1793818114;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FoM3jrwU9mnONLYaNhWTsxjkZz6IQHFf2kOZKAb2OVw=;
        b=votflKqFid9zMJurppOsbrF2WR/3w8ymkQoHMOBMQ8I8ShYHR/fi//VJU+ZcNqAOKO
         Pcg8WyPuy+2PzDfX4ScRhqxu+bv6eK7kIx/TgwrxsTLcqeKmUYvKGD7wwKNLhO5gPPur
         QbOeUQI1M73MBNw7FX3iL2PK/SBc2UpTElG0oMgKroSQXJWGlVO60NUaG/s9eEyebsA0
         +zvrpkbMCD+gtTIy3kG7+fJjTXzJbfF/mhTdniSyqM5/kwbh2kW/egw6i6PIgEZHfdGQ
         076hSSVno/6yRgBDslgkDp5ycEaEb2D++pE2cxu+dh3wXFHYqxQupyhGPnVQkbMneTrO
         jaHQ==
X-Forwarded-Encrypted: i=1; AKwUvBznZjovvv4D0ppp7GsjeahfS7EeSdGvV878Uju3vjtk+37AAml5PB5e3hpvV7WcdkMn9GIQ+Vk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLattQ9hWlyy24TPVufLyYfExc9rn1qGApWRVuhlamTFJzIXgMv
	wIodVm+HE93v9k8RY4PWN7H8bahc7zAf/MPpGHoWexaKt4Q9CcffYajT
X-Gm-Gg: AYBFou2quW+IjXZKjtUcJ5CeoEbSSlC0oR4V6kSfYxE8Xlk8q+TpptNrgK7PeGAQX19
	6EWBRH0SKcz75SDg4EYEFY9V6U+xD7nv5qp1J5+yhltN0CYwjmoqaRWXrdCrrswzpMCxVmmZPeu
	fVBNGSYypxoMDfD3iw69vvfcHazW2UKiUA6P2rccIn3uh3xYcynbR5GOWs+bvwp0X1jkotJn94/
	sfvzhUwKfufSvD0fht9Z9G4QLRMzmMv+1FPOpI57PUlxDFdaKIDEZ9CNrdX27UFGiUqP3ZU4o7u
	eSOfU0OSYCiLWx5jMVMhkDO0nf12+A83Ifhnygn6ml5PTKAbVvkMGIaZOJOWDHWxHi2uQfpHtQ3
	j8+1g1NFQSfNuiElsaOnsgoOBFwATdaGDRriG38TRxVRPTzdqQOMBpwU6Imd7Vnp0QqS3MgzQfi
	Z3ZnvHr7ms9KKhs75X6aKNVjnsPDofa9wApg+V8UPYg6yWpy6HN5Jxlo7tfNuwa0Wbeog37ZNkk
	/NXSxos/9K3YX9Abbc4On1ZDPvw93CDrJJvTUEW/O3oDm3F55tGEyif9pTJN2Cg3HVaA2hXXWOh
	yMTPSlt9yVfAmguo6a8thEBZg90O+yvA9/9jUu2riVcPjOxaFOpNbl0iNVxhgCo6kcHA9PN/GK4
	iLCYwSLnw1fPWhC3x6T3mJm96u2A6NPZZ9DEGShfViyJlGx6ARS8Y2u96fQNx5EfK5rwx
X-Received: by 2002:a05:690c:38b:b0:8ab:37e5:6678 with SMTP id 00721157ae682-8b1b5d394a6mr23556237b3.44.1793213314099;
        Wed, 28 Oct 2026 11:48:34 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e5c7d50sm33374577b3.30.2026.10.28.11.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:48:33 -0700 (PDT)
Date: Wed, 28 Oct 2026 14:48:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 dev@openvswitch.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Ren Wei <weir@nebusec.ai>, 
 Vega <vega@nebusec.ai>
Message-ID: <willemdebruijn.kernel.1010e42464cde@gmail.com>
In-Reply-To: <20261028122703.2093730-3-edumazet@kernel.org>
References: <20261028122703.2093730-1-edumazet@kernel.org>
 <20261028122703.2093730-3-edumazet@kernel.org>
Subject: Re: [PATCH net v2 2/5] loopback: use eth_type_trans_careful()
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
> tc egress actions can leave an skb with fewer than ETH_HLEN bytes in
> its linear part. loopback_xmit() then crashes in eth_type_trans():
> 
>   tc qdisc add dev lo clsact
>   tc filter add dev lo egress matchall action vlan pop_eth
>   # AF_PACKET SOCK_RAW: eth / eth / 8192 bytes of payload
> 
>   kernel BUG at include/linux/skbuff.h:2839!
>   RIP: 0010:eth_type_trans (include/linux/etherdevice.h:635 net/ethernet/eth.c:163)
>   Call Trace:
>    loopback_xmit (drivers/net/loopback.c:87)
>    dev_hard_start_xmit (include/linux/netdevice.h:5455 include/linux/netdevice.h:5464 net/core/dev.c:4057 net/core/dev.c:4073)
>    __dev_queue_xmit (net/core/dev.c:5066)
>    packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)
> 
> The same happens with "action ife decode" on lo egress.
> 
> Use eth_type_trans_careful(), and drop the packet if the Ethernet
> header can not be pulled.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/netdev/20261005052249.1914367-2-weir@nebusec.ai/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
