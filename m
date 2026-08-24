Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B938423D
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596522; cv=none; b=lnhYWXKYXK4xZ1QoFzqDgk33oGUMZZ5HVOFQTke5LqJV6iMZItAu4hlbBYfcc1HPFzIDOcrF3VNPh5z3eGfSYJlR3jcZohar9U32gnCTnazAaxGb6iLpDioGMF5VfQL7o87npMAVbzXD9m600j2jGnBdNZq0ceOSqa3dELHlfxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596522; c=relaxed/simple;
	bh=3ynfQF4aQtnucG5RquOeTsngqAozR+vhICajcKffHFk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=leqNwNjKBdAAaVADIMWvF3/1l9/1l52iwkytmTZB7hc0X8dKm4kn3KXMkJuq5D1aT9yx1U3nv+rfVbDD8IWhhEFBpb4rX8FlaPo2B6kI38ik83qWrUMcA1V/Qq4qmpjqCYDG52K3028LNcpvYkM8glNBe40EjXGJpzeNRr+DShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0NhxLd0; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0NhxLd0"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81ee6b2da98so53817957b3.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787596520; x=1788201320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lqUQB8N0xh+BKo1TncLlDjDEPkZi6hbKp2YpZy00LAM=;
        b=D0NhxLd0AhV5U2VmvzYd+Bw4RPoNdE/a+7PljM7zRxIOXrpkvhmRhCclLtJsZyhATH
         0d0GVjI1asuBFtlZoqfZMSU0V8wW/XUAZoFYz9ovx3JaM32WTLM8qapBf9w5XaJjNkgh
         w3Vt53j8cdOPXfajuuoDUwisk9jwyh/fsngkNe7RZDiwti08VH42XgnbhwvS1SF9jZ6j
         WrlY096usyWVC146XJ1aefAhn6ufzngczl06vGGYIy5hgjs/ZQUVFPJz8rw+3N2O2jqq
         kG4QrSMQMF6/hnrx39m/m7DC8ta7Y8e/V2VzdzYKU/45qC2l84HulO4r0RxpTwofoKQ/
         RFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596520; x=1788201320;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lqUQB8N0xh+BKo1TncLlDjDEPkZi6hbKp2YpZy00LAM=;
        b=GEx0Leu6f2DHHvq6/LosS23TEYjOeLzghXcoPM7XzUXo0coZThODipvLKRwqQS56k6
         HguVMH2lHGKWxALdp5OD4si4VH/JGaDlI3lUwzZpEwZkkIddI+M/uAJYS7DcctrlAdo4
         8u/kwyOK8FD+O2pYsyQBw0zhwN21D66zZwrF3BNFtIbVDZfATDopkZCzymqFQgH8xk6u
         6YSfbUcrZCYRgvHwYlgn0mtgNKcDLzR9adpSty5Z94rHvnAtCx49Rz8B5AVuVtRf40EC
         5EBW1wxoO7Dn4xJfsgdf/KeQUivmlJNIWxwFcOUaacmDo+hioyE2woREft1dhmO9lCaO
         P32g==
X-Forwarded-Encrypted: i=1; AHgh+Rq8h1bcNMN2WFlTmENqCTVuCeG5cwLTmOgI4jd5GzIOxPcARvbJDoIkjGyOMGjJb+255phaSuw=@vger.kernel.org
X-Gm-Message-State: AFuF++lR+QtkWlr10pC+AEK2M8hHFfPQLXD5olws/tVo2pA3D1o4zoCr
	zogjm6b8xsNpvs/EiMK9QUAqFCUFQ/LDbwR5Pp4icwK0T32ye5BKEieU
X-Gm-Gg: AR+sD11e/vnPSF7iJqpOqSHC7wGxCcVJPglu8d4wVqczvC5FtgIwJaMK3DhMkoZxZ/n
	gzyYeworsS0vZfbN+rKlON6PiHA8gcPCQnCUulz+bQkK34kFLws54ydNy4b9qtZyq6Auvdft9AU
	LBb8zPBg89iRL7uU5kfFdxJtJECJLft44eu6nG7pdEir09blcBQwtS2zdaCGtxJWFI8JQE7rYpE
	3j/0/NTx+hy4VgsmazWKszSvbhKsKHlt2SGznykr4kzLOjLNqsxbMlVz6R3lyXGA8h3u46EppWl
	bOACls7m3Onm3qhFQwzhuATf69NhCQwkxUV0Ti8J002VUSMmpsi+pJYKcEvoA/LwkJwmNEaiV7m
	lvMaQ7cvv9K6CY6WeW7X2syIKwhd0dRpVU9DojHdCEF8XAV+E7kcwsD+dOh6jOukgNMQrxr6+MV
	FLHh3wIdAHN78WcerbMs2TaDNwV7Ewd4fqd7yk7gncYUQhxzMosT1m8Y/HDS/opbOTtHP9uTPYO
	CgR2FXcFw70IZ89MqAheONLLlaba1DZBS4PeD21Ow==
X-Received: by 2002:a05:690c:c357:b0:845:ddf4:a3a7 with SMTP id 00721157ae682-8547466a101mr4981847b3.16.1787596519652;
        Mon, 24 Aug 2026 11:35:19 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca527e9basm38426117b3.5.2026.08.24.11.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:35:19 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:35:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: JR Lanteigne <root@dnim.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 richardcochran@gmail.com
Message-ID: <willemdebruijn.kernel.2f8e577afc766@gmail.com>
In-Reply-To: <178759055328.4181951.10346301845266420247@dnim.dev>
References: <178746246095.3786864.2262454553798466512@dnim.dev>
 <178756707212.4073008.8425791726071449399@dnim.dev>
 <willemdebruijn.kernel.1e07ba16c4cf4@gmail.com>
 <178759055328.4181951.10346301845266420247@dnim.dev>
Subject: Re: [PATCH net] net: fall back to skb_iif for the timestamping
 pktinfo if_index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

JR Lanteigne wrote:
> Willem de Bruijn wrote:
> > It may be possible to detect whether an skb_iif points to a physical
> > or aggregate device (e.g., through lower_dev)? If so, then the value
> > can still be used in most cases.
> 
> That only guesses less often (tunnels register no lower adjacency).

The lower_dev was only an example. There may be other ways to weed
out non applicable devices. Like dev->type (ARPHRD_..).

Though it may be hard to prove that all cases have been identified
and skb_iif can be trusted to come from a physical NIC.

Or inverse, iff dev->netdev_ops->ndo_hwtstamp_get is non-NULL.
Also not foolproof. vlan_hwtstamp_get is one counterexample.

I don't necessarily have an exact answer. But optionally an avenue to
explore.


> I agree with Miroslav: 0 when the physical interface is unknown.
> 
> The userspace check fixes chrony only; every other consumer of
> SCM_TIMESTAMPING_PKTINFO has to rediscover that if_index can be 0
> and grow its own IP_PKTINFO fallback. The kernel is the one place a
> fix reaches all of them.
> 
> The gap on cpsw: one napi serves both ports, the driver delivers
> with netif_receive_skb() so the id is never set, and it would name
> port 1 for every frame if it were. The driver knows the source port
> per packet (CPDMA_RX_SOURCE_PORT) and needs a way to hand it to
> put_ts_pktinfo(), e.g. via skb_shared_hwtstamps.


