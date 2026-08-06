Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456E43DA31
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786012510; cv=none; b=oAYNxj9eSodbLum+kObf0Yich8Htr1MVc6otjCCu8pIEqKKL5DWsp1Z/7rHyodEVe4IVpiFrVaX/0km+3068aJCW9i8GftnrXpdOlvhyyNKbelFH8bRFs1YTg4sO+Mm/4eh/melGQPL+unA7yUxcYCAdDeKjfhYPU8uxqcUKprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786012510; c=relaxed/simple;
	bh=NIfmBcIS8AUrGupvQOZ7x2SRlwytFniaM+5zsSUMgVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rk8FIhMb5ZsjUC2FsRU8zi04S5VWPZ7ErhIcQN7j11fQH/C7E7EluHFtKgjwaaEIlyqoI45paFKCHnN4LZv1wXoOr0OGf/SMZreIbKmlDJd4sBsgHcnAi9rYta4M+tuNY43GFo98HR1otVOnwhel6hUbsR44V56rDa+3vhB1MDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQcn6qHT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQqNCssb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQcn6qHT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQqNCssb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786012507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJYQ27Sjsp6jth/HjB+z5OpRp2AnhJkmpaIw+MV/sWQ=;
	b=LQcn6qHTA1Pl+4mq+l6sLwVXjFqdjQydBHQa8fxCMy+yMtDObbrDQb62loFp7Y9JAsPW6E
	ygL0WZdLE/zSoDwnL1NZCmHvSsqMuP/YPyZvc38KBfIacYEOQjfawm/gp6FZEPfa4Q1KZW
	DdWEEIKiRe2O2ANK0pNerz5WVO7Stro=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-mxGtJHxCMKK696G9Xo0tsA-1; Thu, 06 Aug 2026 06:35:06 -0400
X-MC-Unique: mxGtJHxCMKK696G9Xo0tsA-1
X-Mimecast-MFC-AGG-ID: mxGtJHxCMKK696G9Xo0tsA_1786012505
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-496b408a5c0so11289655e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 03:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786012505; x=1786617305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DJYQ27Sjsp6jth/HjB+z5OpRp2AnhJkmpaIw+MV/sWQ=;
        b=iQqNCssbILnvVFNoN7TfO13u98GwooZneMdFzf5ekOunXSx+YBOLSw9rh9MjC0/7pF
         ClGGhsqCsmvumCWcVgP2szVbaSoiYH4HHka6vh54t6NcwIvnM2xywIOyGTEe/awjeTXN
         VqDHAqVpp3rnzur/2w+i95FQWaWyROKINjPQ2Fw3kzLt6+JsdtJ0TF1fYRYDO7fFsXzj
         KLlokKROs+QwZPGvE3BwCviYN6GywST+ws6bHacExBYUrhPUqIKc1I3hJE0fbBNSz4VU
         ACEmsirLF9o8un/vjdDImKjcc9K14GujOG/AeWNPH0Lkri9fRG7ubeNx4sZePZg2tq5u
         BWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786012505; x=1786617305;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJYQ27Sjsp6jth/HjB+z5OpRp2AnhJkmpaIw+MV/sWQ=;
        b=rYplQtLka4lDpQlNxnEjrx9REu2fav2KRpB9+d/lL6nt/soarm0Ju1IvkjzlYx7ceh
         CeqrWuDhuB7URiICceu1O+IwXXF1ixRUo2Nf+JT1D76joBVhmhR4Vo6l52WGsjuNvgsy
         Z05qrlXLYCP12gK374rbX1Hy0WgbzoNeWzCBMmvP5AZfln0L71nWFIzb75SszA4rUC9Y
         pARZxsKmDeTCd60dx2DiDK97BoBD7AuS/hFnk5Lnydd6XX/YQMN+DyKr0EmKS9LaJEAY
         RUlwIgSoM6TU9pM2uyIGwTLHIZsA5HXhku7oZavtyQtkycHhU7BlFZ+vPdteP0srByBD
         fwUw==
X-Forwarded-Encrypted: i=1; AHgh+RpAIJ6b8Gfcsqo7Uf1eLKFQ3zp5Zgbfw7Mv/+ozomnAK3PBFFZgwAESIcqzfNJyiSwr8BLZulo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYUyMO7C6m0obVn5KPJPI7/Ac223uQ86R4o06F3DcnaAUGy/ee
	+UpB6o2+6Sz/98Q3fUxzgbHvdoZxZyC4fYioklbJcpfe8iCGYdJBjteplTu8cs5skJJq+PzYjBy
	ZjybWXr8OyQlzFJJ3TZ2U6HQZGInRGbNXtAp5WrSVYuNRpT7oyPoPc8Q61A==
X-Gm-Gg: AR+sD118hd1+hDqKb8B915T3mWfnGAfPG9oqVmhLa5+4Gq7MAnjUmOj06jaAPMCd27S
	h8alyYIaI33X+CLoS0oNM/OZjwyl1QeI5IIcbwRCA8EXLSitAC/nap27LwXOjxZh5RUwQMU8SZP
	Gt3wregiM8pTDGoKH9YAs5MSOTZRyqJrA/G9mBgaC0BQ5pCjPuS4jIDmVTrmmH5Fxg/Q5FmodCU
	AbfRLZ/4g8dsLDVjjGtZYSO/fK6YG6le9TnatYy77S8J7Wyh8fvQX7lb8PieluSg8yM+Ed45ifS
	B5MM3NDNEJ/T75CbXkWkxnujsNMQwfhWA6fk5aO7y8QLoguUjBD2H4t3PxdX8gUzF23Ul2S+gu4
	xpU19AD0i78rut/Ds3S1GjIeNVrhfXtjh79pIQmA7zShVU2GZOVdPU3+ACz2Oy1ydc+U9ad3u8H
	E=
X-Received: by 2002:a05:600c:3583:b0:499:59e9:64 with SMTP id 5b1f17b1804b1-49959e900b4mr2389075e9.12.1786012504788;
        Thu, 06 Aug 2026 03:35:04 -0700 (PDT)
X-Received: by 2002:a05:600c:3583:b0:499:59e9:64 with SMTP id 5b1f17b1804b1-49959e900b4mr2388435e9.12.1786012504257;
        Thu, 06 Aug 2026 03:35:04 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542241c4sm49753095e9.11.2026.08.06.03.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 03:35:03 -0700 (PDT)
Message-ID: <4fc3b9f1-4bef-4b34-ae7a-e89037cce829@redhat.com>
Date: Thu, 6 Aug 2026 12:35:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/3] net: hsr: clone before updating path and LAN
 IDs in tagged frames
To: Xin Xie <xiexinet@gmail.com>, davem@davemloft.net, kuba@kernel.org
Cc: edumazet@google.com, horms@kernel.org, shuah@kernel.org, lukma@denx.de,
 m-karicheri2@ti.com, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, ali@iusegentoo.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260802202504.2962-1-xiexinet@gmail.com>
 <20260802202504.2962-3-xiexinet@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260802202504.2962-3-xiexinet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/26 10:25 PM, Xin Xie wrote:
> hsr_create_tagged_frame() and prp_create_tagged_frame() update the
> path/LAN ID in the received skb data buffer and then skb_clone() it
> for the egress port. When the same frame is forwarded to both slave
> ports, the second port ID update lands in the same shared buffer the
> first port clone still points at; if that clone is still queued
> (qdisc backlog, NETEM, BQL), it is transmitted with the second port
> ID - a silent on-wire corruption.
> 
> One always-available trigger is the master transmit path: a
> pre-tagged frame transmitted on the master (for example injected
> locally via AF_PACKET with a valid RCT) passes prp_fill_frame_info()
> with frame->skb_prp set, the master-origin gate lets it through to
> both slaves, and both slaves run prp_set_lan_id() + skb_clone() on
> the same buffer. Tagged frames arriving on an HSR RedBox interlink
> take the analogous path through hsr_create_tagged_frame(). Normal
> traffic tests do not expose the race: the window between the first
> dev_queue_xmit() and the second ID write is only a few instructions
> and opens only under egress backpressure. With a 200 ms netem delay
> on one slave, all 200 injected frames left that slave carrying the
> other slave LAN ID in testing.
> 
> Reorder both helpers: clone first, privatize the clone with
> skb_cow(), reacquire the header/trailer pointer, then update the ID.
> skb_cow() is used rather than skb_cow_head() because privacy is
> needed for the whole linear area, not only the header: the HSR tag
> sits in the head, but the PRP RCT sits at the linear tail.
> skb_get_PRP_rct() computes the trailer from skb_tail_pointer(), so
> the returned pointer is always inside the linear area that
> pskb_expand_head() copies; frames with a nonlinear tail are
> mis-parsed by the existing helper regardless and are out of scope
> here. (Both wrappers currently reach pskb_expand_head(); they differ
> in the cloned-data predicate, and correctness here needs full data
> privacy, not only header privacy.) This adds one linear-head copy
> per tagged egress; untagged master traffic keeps the existing
> __pskb_copy() path and pays nothing from this patch.
> 
> Fixes: 451d8123f897 ("net: prp: add packet handling support")
> Reviewed-by: Ali Ahmet Memis <ali@iusegentoo.com>
> Tested-by: Ali Ahmet Memis <ali@iusegentoo.com>
> Signed-off-by: Xin Xie <xiexinet@gmail.com>

Please try to condense a bit your commit message: too much text is alike
no text at all.

> @@ -377,15 +389,28 @@ struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
>  	struct sk_buff *skb;
>  
>  	if (frame->skb_prp) {
> -		struct prp_rct *trailer = skb_get_PRP_rct(frame->skb_prp);
> +		struct prp_rct *trailer;
>  
> +		/* Same sharing hazard as above: privatize the clone data
> +		 * before updating the LAN id.
> +		 */
> +		skb = skb_clone(frame->skb_prp, GFP_ATOMIC);
> +		if (!skb)
> +			return NULL;
> +		if (skb_cow(skb, 0)) {
> +			kfree_skb(skb);
> +			return NULL;
> +		}

This is the verbatim copy of the previous chunk; please create a shared
helper instead.

While at it, sashiko notes this leaves the else branch open to the same
issue:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260802202504.2962-1-xiexinet%40gmail.com

Note that the data race on the dev stats can be addressed later in
separate series, as there are already many occurrences in the hsr code.

Also be aware of net-next commit c82ff94592fb.

/P

