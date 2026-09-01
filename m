Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEEC47A0C7
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256879; cv=none; b=kIzkWATFEOpTlYLIk4EYYhFNF5u91fEf+ObU5Z8c8/UhUnOb1IT5fkXIjv1Fz4qffB6G94pMUKmke7QV61F1ach0xNToVSWMj5qCMPL1OJ2PawDj9YmImiF72RdcYaMpQdxUoFamx7FTlul1HqRz4x6vKdCgiqZ4bvVx/SPC6eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256879; c=relaxed/simple;
	bh=6ZttEQI77VGHxntNdBuD7O0pV0mlbBNMFoR5csSubww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6B+ywT+5lUbgKVoVOY5fM7HL1zxVHQZn57wlXvnFXdxqRVipzQFsKZ4PbhGsBEwZJC7zcY797JKHsrzX0psVvpXZWF8rGkVgY3IvkfytX/0xZWAs2Qk5hhYlWiSgeFH73GJL9yTVNaicpv3kNzPrJJgHC0IISDJtD1SyeR9Sl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ri3EdJR5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1XcJuWa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ri3EdJR5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1XcJuWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788256876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuPAxLx/XtcAd+3dhLSFGMMJgYC24wb6aYaIL5HLVdU=;
	b=Ri3EdJR51NnCiVU8j870GiqwjcujWyauZpEpgt31qe6iXfntJO8P0TsaS8SnDtDs4tu2/B
	pUeGlBsTWSmburvkFeISYZRDz0LR/UvT2PiGwt6f5fviZKWa1OmhAMUWs+i4MBaPeXDXEu
	Kxn/4E4Mav59ajih7CA6x50sHgpT5Qs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-AWnCuTN2Ml6_MMMSVqF2Ow-1; Tue, 01 Sept 2026 06:01:14 -0400
X-MC-Unique: AWnCuTN2Ml6_MMMSVqF2Ow-1
X-Mimecast-MFC-AGG-ID: AWnCuTN2Ml6_MMMSVqF2Ow_1788256874
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cd55ee2f7so19542365e9.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 03:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788256874; x=1788861674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AuPAxLx/XtcAd+3dhLSFGMMJgYC24wb6aYaIL5HLVdU=;
        b=P1XcJuWaIEKqgeR98nPkRaF6Q+vacgkHAT5g43qXP0Lm7sa9IaXTfgBZSW8QDr1G9V
         Y4EGOiuY19oJkMA+KaZaRvrzctWi1AgDL3mahSvVqzdpGTdwJtwwnYC7EQnDcaMtzv3p
         QpC1OHjuTJku4Se+t5lPiPcysQa2S+WiB/2832MwbmkjMplVhZ+cv3K1qh0xV5jtH3yM
         vsl2kzg4sbDZLcIiHTTxGFGo7g+y9kuiaxzFVYZ1DJFl7pF1i/6ZeEfApWSJgdgiHmKp
         hfeJRG+xa3c2x/D0nfB7ohl87gpJ4zG2JOkE3OX4DmiY4Sshxm7XxMNwqDYIQvJpZ8Nc
         DfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788256874; x=1788861674;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AuPAxLx/XtcAd+3dhLSFGMMJgYC24wb6aYaIL5HLVdU=;
        b=WhhLN/LYahP+HJaw5UxJW5hCMHhaC4Hw2XIy/ECIk9IdCa4zAfLDxxED+uVQJFOdrk
         jXlHjz0oOWWfW7ZNfY7Pkb4i+yBPSlQ2kh1uZFxor+9zafmod+Z+49glsA2mquKijfAe
         Nh7uFq929w8HJWGQH1a28HR76QLn4VuP+MwtX3eTAL9J8aagnFx0gIZJ9SV1ThfHpcqF
         n+AWakzHuaSrkRkVFheFuCJHVzoGDC9ERq2eyQwl6p5bctA+7JkfHbF18gbaHZpiOuQC
         9EoTifmWZohFcNUGJpueo/9oeTy1bU5kao+rk9WhHBD5S86NLI06xPENoFAVW2SSyaki
         QABg==
X-Forwarded-Encrypted: i=1; AHgh+Rq73JI+/fhro+gqNEPcXDwRklHIMywTFQbo7+MhdiNjWdL6SwB7k04CA0XrX4ClGOgPDT+7Eu0=@vger.kernel.org
X-Gm-Message-State: AFuF++nLIHZ69A/P/coNBvRqzbMWKpXsB7z+SOGLlS7UYOCEQuArFuoY
	2WDlHkHuNrItDmKaPx0P5KVI9mY2f9UIFtuxRSxyZ105NZHA4PHrkvyCZCyBuSuPa6jm58t+DsZ
	r6QslSt4jCh/3MKiRjpyblfNhjODPigfURH31G5g1UXU127M6RiFjTGSKFA==
X-Gm-Gg: AR+sD11tFMO1eQaMXPKgBO7U1aYajY8uWinnIN31FuYESu5cA7raOxtZCcWUg7jpiCh
	Eav16kv1/ONfiQ+s02zhN/4VpSIA1r1AJ9/DsLHvkheMtIlmLl9IhBIG8Sm6xJxlylnBrrqZiI4
	MpEEn1I1jGkVbeoFnjFiM4VGSL0mlIHfLT6TWKmgMcFMffe+squajKY+7gyRoGq8MzpO2SEsx1Q
	cW9oxTdOSV7ZyxNj9isLbfxfZUzF5W7Z3jni2wKvEE2oDtOmRKvmnIqYDM/ZR2sgj3lo9KDC+hQ
	8c4QI25CCNYUf7Qaxh5krOjq2o+iRLJjlxuhzbF+V44UD3WTuZhLD1v7IjTTtVw66N3YiRhDhWj
	aaMavGjWZOSnXzr/xU+A9xbWpEKRF/w00eRFRhSSaOuRZNRi37ImNJKPLRGEntzU4J22egJV8kA
	==
X-Received: by 2002:a05:600c:4f8b:b0:49a:2c4b:403f with SMTP id 5b1f17b1804b1-49b91c46494mr434457245e9.13.1788256873608;
        Tue, 01 Sep 2026 03:01:13 -0700 (PDT)
X-Received: by 2002:a05:600c:4f8b:b0:49a:2c4b:403f with SMTP id 5b1f17b1804b1-49b91c46494mr434456125e9.13.1788256873159;
        Tue, 01 Sep 2026 03:01:13 -0700 (PDT)
Received: from [192.168.188.218] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce10153sm61989385e9.4.2026.09.01.03.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 03:01:10 -0700 (PDT)
Message-ID: <924455c8-9f62-491f-ae3c-ea2127f46769@redhat.com>
Date: Tue, 1 Sep 2026 12:01:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: psp: do not inherit the Rx association on clone
To: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>,
 linux-kernel@vger.kernel.org
References: <BC10EB92-ABB3-41B2-AB16-266BEEBE18C0@doyensec.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <BC10EB92-ABB3-41B2-AB16-266BEEBE18C0@doyensec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/26 6:56 PM, Norbert Szetei wrote:
> sk->psp_assoc sits past sk_dontcopy_end, so sock_copy() copies it into
> every socket accepted from a listener without taking a reference, while
> inet_sock_destruct() puts for every inet socket. psp_twsk_init() does
> refcount_inc() for the timewait socket, so a child closing through
> TIME_WAIT cancels its own put and leaves the association with one
> reference and N timewait sockets holding the same pointer. Closing the
> listener frees it, and the timewait timers then put freed memory.
> 
> Rejecting the association on a listening socket is not sufficient: a socket
> can acquire one while established and then be turned back into a listener,
> because tcp_disconnect() leaves sk->psp_assoc in place.

So rejecting the association on listener, and clearing on disconnect
would be enough, right?

I think that would be preferable: it's a pity to add safeguard code to
the datapath due to a syscall (disconnect) used mostly by fuzzers.

/P

