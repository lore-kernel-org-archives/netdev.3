Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012513603EE
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640300; cv=none; b=FCItUcb7bWmND0d0T7yF01S/YDjJevDm09kWaZOxU6rynXQJrvcCgiluDpjEzi7Q3X2kUAiSvatZLcopSMogiE9JZh18CROb4GgmDvpiVn3Wveurc7fd7sqFn348lUtp8qmbYfguPlWdUWzi4tTpNn63BKFpYiLgolaNGCX/adc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640300; c=relaxed/simple;
	bh=tybRTNRIFn2D/DUGT1ckFP6dZPpEHLzw/gcut2K0MZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1xH1aeuvhrxD5Q9LPdbWNi8K3zF0kbwmF6Hwg+BXzp0PbNVfM60Vg8fI3ydu+dMLbRoiDYJ+KF0TyOrsfFTS/lGFhIyjpsrWETd26qnvtZ06x3jiXLb5sSRUii3N/HKj1eLVuRKegIVnoKzfDkEnxYIL3Y7soE3TXjJeqDEBGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUtqqwCU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ol4gfriE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUtqqwCU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ol4gfriE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784640297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KAwZvJdqyRIXw57Va30j5O0qt4+P1ojJQfs+XKxSXqY=;
	b=AUtqqwCU3TRuUkcqvuehRA1ocW3Rs3UdzXEb1x7NfZcvaUKb3QTcA7vXq8cBDlHEJcf6Dg
	H4+76I027vyvzT7+Di06YENxJh6zx5XOzB1V2UD823S9BMoju7VKu85STpshMbtbt1hYSI
	mtNDZyn8H7ypjhyPx7g0AD81MtgQodE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-keV0yNH1P1uXoJwQMSjMZQ-1; Tue, 21 Jul 2026 09:24:56 -0400
X-MC-Unique: keV0yNH1P1uXoJwQMSjMZQ-1
X-Mimecast-MFC-AGG-ID: keV0yNH1P1uXoJwQMSjMZQ_1784640295
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493a7fa8481so28491085e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784640295; x=1785245095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KAwZvJdqyRIXw57Va30j5O0qt4+P1ojJQfs+XKxSXqY=;
        b=ol4gfriE0mbH2vd098Q7Eu73oOefNJtXZQx3GgPq3yPDBFvpxpfzlQFGq7QcmMeudb
         jW67rnx4KT34PKXEf5i8y1RoCDymtmRqWQ6D9zn1AhyBlqrtpC0jlohlkxlxjR/aePu0
         uNdirXNLMFvoIDz/DnOZWkP8wI7cOSP82fIoXvfMzxorSTbmNn21s9wzMXWZJwMGFxkV
         EHZACLT1grgmIaZGGEODGAFT7i2CpvMSB0/O+ApnKEU0lTjCO4wQcKhAGFj+vOSo0rQJ
         +AZ6LSLEgQbbe5hQweZsQPl+LdAqb5CC7Ut2Sxn6UZu0UzS/KWyQx8JhmfcMnCDvJ8Tg
         6YTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784640295; x=1785245095;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KAwZvJdqyRIXw57Va30j5O0qt4+P1ojJQfs+XKxSXqY=;
        b=SCFSNmBNY3rI7oGmw7HsM+tw82smUCxg5gS36K9c3H7lgujeuHKy4oTRVBYn4D7viy
         LgX+RO3nta4pFF6DY7yPWvdKtNPo5exYJBW87C4z1QTyT8lLplZ3SwABwXRlkdNSgiDQ
         qQYIpaePofZV9j/YlwJcht81FroU9IVO7Y8iOtcj+vf9t4iX4UaqMdOPpPSvOl0cDNoC
         PYqeg3jvWvC+gYF3ERm1ILFS+uZhzkoxzDs3vt+wEWqymfzvoLrj4r43PP2N2P9xaMwA
         jtoSLwTIilScviM8f4rFagBeDjwwpkAGWlb1w335T3CaYdXOWn05ILmdFbt8FOWo9xBp
         f0uA==
X-Forwarded-Encrypted: i=1; AHgh+RpuocSE3lcJMAgYQo1AC+l1ou5NNvAF3no+w3mqkGh6HABPX20R/h//B9rrtKj3s/E+20LMQP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj1QIac2INXZBztTyLv3HkFTASDesYd0mp6FS6vJ18dncEYFnB
	GGtPTJmurndwG2g5FltIQxKz85VcLeTi8tAord2onhUDIGRNk3z3rVTDnUyq4hJrsjoS/j0T2sE
	UdjqPm4LEptm4pLPKEHNCNCAK2QJcT346q1uYoEvCi67ixj4jut03wHjToQ==
X-Gm-Gg: AfdE7clKnk315csvwCHP2ny3fzDG7lc8iEtRmkG5CVGHAWH2QOMGRbxNHefCl3jPRYM
	Zw8GUN7OFX/CcQKMmXTAmnRkIr55NJ+RMiObqlmKxmNUjBCBK7V/QT/TSN4AYSZ7hX5ig8ykqvq
	crVHNY3KlpEKyyB3mfp3ArXx/J7R/3ypgodep+07iZJlnFJYA2ajDN1/W6H9Wc6i6ptf1iVvY1S
	FbYQciCcRSrrUPHxBp++CzOdnQLy9wXbJAboEUA/OMgB+K6EbZoIG4DVUEiuTtSuUCSOwGxaUCW
	clN+SrDgKu/oe9evw2+AwmbVNQ7xMj1uZa5AcK4yxqZVXjY7GIkFusQRTeBCFW3qEaM5NpFeN+P
	LoJaBiynqNx1aOGPvxLojRXlZufVai3osf8u/9OFrNYOmm+xYt1cm3SvD3QdE7AoRpL3EuCU81a
	rd6w==
X-Received: by 2002:a05:600c:1d18:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-4954a320080mr197900705e9.3.1784640294933;
        Tue, 21 Jul 2026 06:24:54 -0700 (PDT)
X-Received: by 2002:a05:600c:1d18:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-4954a320080mr197900245e9.3.1784640294400;
        Tue, 21 Jul 2026 06:24:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49565482c5asm103791375e9.10.2026.07.21.06.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 06:24:53 -0700 (PDT)
Message-ID: <6c01c713-14a8-43c2-aaaf-2fcf622f7e4f@redhat.com>
Date: Tue, 21 Jul 2026 15:24:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/tcp: Prevent inlining tcp_syn_ack_timeout()
To: Emil Tsalapatis <emil@etsalapatis.com>, netdev@vger.kernel.org,
 edumazet@google.com
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 kuba@kernel.org
References: <20260708180837.9507-1-emil@etsalapatis.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260708180837.9507-1-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/26 8:08 PM, Emil Tsalapatis wrote:
> The tcp_syn_ack_timeout() function gets inlined by Clang,
> preventing tracing. Since the call is not in the fast
> path, prevent it from being inlined.
> 
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  net/ipv4/tcp_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index bf171b5e1eb3..f7215d53bbda 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -748,7 +748,7 @@ static void tcp_write_timer(struct timer_list *t)
>  	sock_put(sk);
>  }
>  
> -void tcp_syn_ack_timeout(const struct request_sock *req)
> +noinline_for_tracing void tcp_syn_ack_timeout(const struct request_sock *req)
>  {
>  	struct net *net = read_pnet(&inet_rsk(req)->ireq_net);
>  

What's the point of tracing such function? It just increment a mib. If
you want to discriminate between TFO and non TFO syn ack timeout,
possibly adding another MIB counter and incrementing it in
tcp_fastopen_synack_timer() would be better???

/P

