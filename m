Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C7C3F86F0
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406400; cv=none; b=ZE/O2fqoeAHCpTcwNg5agiq9Rn6fvCzFzzUPyNocghAysTNMl6xoEPxGVFNJA2OG+2zLW52bY55SUIf/vdsE6b8i7mRrFjvsTJt5IOiU889eIyFbjreGRpHn80/2OkjHkWoDcQ9txmDRtnlrs3lryz6IPY+wSwNjlmzjTClqWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406400; c=relaxed/simple;
	bh=pSyrneVZE3Fw7bk9QupiWCgMXjVhDU7ey8F3ipqp+Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4+8k2M1ksh6TBPVQpJW05w2emrr482yEFP6/ChEQLqaC7jENMr93ZoNuzCSKN2/E26DMR0VfUNkPG4xMvsITFkZIjf9tZjLTriZbkUIl6bvxv2v1oUCEUXFbtID8F3FQBfvBTJvfRz83AA7Row00/I/JVnU+UQ28k5jMYuprcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pv5QkDiD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXN41C4t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pv5QkDiD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXN41C4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785406396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hyi5P33Hd7zC18fjV/u2o5p57tCCsdMzMx4mr4O5m5k=;
	b=Pv5QkDiDA57wm3bBTtZXEiGKGQ5cv42RH5kuOnXJMlmLwsoRjyVrJ55GYPn+9oLucrAc2H
	AvAIzojshM9V/BxQfceuzOSRRModyUwnJnU8di1hp4lM7Yxx4tUHEfhw0y5Hytv0sAEn/Z
	X66grqCxy1m1E0OBGChBZgWEaVfeNBQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-_nvoljNCO5yJZalBuYZczg-1; Thu, 30 Jul 2026 06:13:15 -0400
X-MC-Unique: _nvoljNCO5yJZalBuYZczg-1
X-Mimecast-MFC-AGG-ID: _nvoljNCO5yJZalBuYZczg_1785406394
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495569acf8dso13168495e9.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785406394; x=1786011194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hyi5P33Hd7zC18fjV/u2o5p57tCCsdMzMx4mr4O5m5k=;
        b=ZXN41C4tbAzNCFZTZjJ+srlfAu3gyxnSd6/iw8UwDkIm/xmACT79qAS6jyHZO3cYkJ
         jHkn6l90Z7idR/+gDSHCCOf4NTijDleMe3hr5BCXwboKHrhxhAIH0DMsCoSxyc7P4VJA
         PqAw0IM/H0u6hYksA16AVl1P77QwltkfluEuQ2Op2nMhlkFnqAJGLNYn4kPZJX7HbKYW
         /fGV6xXTalucQOJK4KC0u3u3x9kRlArj0aYtzAKKOUfz0lblBzcTcWeWJTF/DvBZJnms
         togiULbw/nm0KChW7HVM/jkgtSAI1t6KKajOCPBk8U76JKc+49xRXVNxfZPQoqMc/gwa
         j8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785406394; x=1786011194;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hyi5P33Hd7zC18fjV/u2o5p57tCCsdMzMx4mr4O5m5k=;
        b=arypCT8woOoJiZka8vPN8rbC5/TZhW3rq7uk2ZdNqRuUiGZCO4hd0sXZzOwaa870IO
         Z1xLnTLxVcZsVxk7bIsC3EIbksz4rq2ei2cxq2HtXWRjuIqNzlrMJrSzvTyWewBq47R+
         LrQ+54E6NRtr6QiaSbo5jM71un+qYwwrvvDBTFDbzwP9j8X7ZI3e88QQVKvdvwN+yxWY
         Ud1Xz7ikscj8FJ7TgMjsl+0jveSKTzN2YDjPxJ7/4CbsoMy3GohdFBwjGpQUynK+za+9
         N4PtH+vAApGUk2Vki8RsK+kDs2QcVuwWlfHNuku5+20V1ZWl8W6DF355YjSuJS6O5BSx
         z8iw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+92GYHeu62l4wZ8HTk2iIu+zmyLHGm9WeFmnwyN3GEDXO9g+Qw9FHZyEZluguEJvrUtboGBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZD93jjkW3iuWFOWoGyyJAZZwcJAQRqymcpoHhXfhweamqux1Q
	3MVmLHHJ4gnuukQp3FKHvfb4ncR3T7vKme8SN3eUpKH3tnmMz9v2kxH6v3V4p/2caemJsmTnOts
	CjLxN6Snwp5fSMTIoeM0UJwFZABKOkcRltwfx1v/9eCr+uW30cEDRnxtuWQ==
X-Gm-Gg: AR+sD11V4/1Ngedn8adeekKO2+ya9smdUiW5A+6QLjz2DkcXIURlM0YMU9pmhczyQo2
	SvgyCrg0N08JbpnbrYhqEMge0SDKZu6B93f/1xn83doDqNQhSN4Jdp/eM+5v8Cpaf2OUTIha5sl
	8Tnmyt8L1iB5vCHl60bSKf8gWsAewDs0bOGRL5jagv04XDYCCk3RTaOkHLjFTD6wDQnLgToSCZX
	9ZRLt9u2+6O7VYWmNFMYob3sUSCKVUAfBIYUoYZzvUG9rcLYCdk5nzyLIyDEIs00hxMkfj/hOLs
	1jL9up2TpOiYdQibRfEooqAlW5ZiiEFSNbb8mZT0Qn3/FONFE2T1htwD1n67Xgpjhza3A1dusXv
	M76R53n6Js+iyh1jcOhs1FdZ8InVGDjOwsZD1ZpsU0AOVIcuC8YxFKTGhHqqiC1TCdTS/Dlb2Xl
	9aAw==
X-Received: by 2002:a05:600c:1f85:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49800e7028fmr23043715e9.7.1785406394156;
        Thu, 30 Jul 2026 03:13:14 -0700 (PDT)
X-Received: by 2002:a05:600c:1f85:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49800e7028fmr23043255e9.7.1785406393590;
        Thu, 30 Jul 2026 03:13:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011feca8sm50128245e9.8.2026.07.30.03.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 03:13:13 -0700 (PDT)
Message-ID: <fe135316-72d1-4347-aaac-aa2164bcdd4d@redhat.com>
Date: Thu, 30 Jul 2026 12:13:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: atlantic: free stranded TX buffers
 on ring deinit
To: Yangyu Chen <cyy@cyyself.name>, Sukhdeep Singh <sukhdeeps@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Lino Sanfilippo <LinoSanfilippo@gmx.de>,
 Igor Russkikh <irusskikh@marvell.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <tencent_1F173E0FC1606D2AC704DC9C98AF10984607@qq.com>
 <tencent_E5DA048E95B86B31EB21258D8E7CE1825308@qq.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <tencent_E5DA048E95B86B31EB21258D8E7CE1825308@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 11:01 AM, Yangyu Chen wrote:
> aq_vec_deinit() drains the TX rings with a single aq_ring_tx_clean()
> call, which frees at most AQ_CFG_TX_CLEAN_BUDGET (256) descriptors and
> stops at hw_head, which no longer moves once aq_vec_stop() has stopped
> the hardware and NAPI. Completed descriptors beyond the budget and
> everything still posted in [hw_head, sw_tail) keep their skb or
> xdp_frame when the interface goes down: aq_vec_ring_free() then frees
> the buffer ring and the references are lost for good.
> 
> Today this is a silent memory leak on every interface down under
> TX/XDP_TX load. With the following conversion of the RX path to
> page_pool it becomes much more visible: XDP_TX frames carry fragment
> references on the RX ring's page_pool, so a single stranded frame
> keeps the pool's inflight count above zero forever. page_pool_destroy()
> then never completes, the pool is leaked together with its pages, and
> "page_pool_release_retry() stalled pool shutdown" is warned every 60
> seconds from that point on, on every ifdown, XDP detach or ring resize
> under XDP_TX load.
> 
> Bring back aq_ring_tx_deinit() as it was before the removal and use it
> for teardown again, with one extension: TX rings can hold xdp_frames
> nowadays, so release those too. They are returned with
> xdp_return_frame() since this runs in process context.
> 
> Fixes: eb36bedf28be ("net: aquantia: remove function aq_ring_tx_deinit")
> Cc: stable@vger.kernel.org # v4.11+
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
You missed a relevant point from Mina's feedback: this is 'net'
material. We don't want fixes tag in net-next addressing bug in previous
releases.

You need to send this to 'net', wait for the commit to reach net-next
and resend patches 2 and 3 after that.

/P

