Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103641;
	b=L5ErpR7Vq971Gze2ky8UtzGyPqS1gByiMh2xQG8IR7DjrLIlp/mehyzAuS0b4MdlALDX
	 tSw1JRWfpqSs4BZzGZ3TyjsOGIaMn9uo5JjO5T7mlCDd/5wcOlJO3m6qo6B+5Q8kTCSza
	 Fiu6NtZavaCfWsOu13pULDgmJl8S4ITJ2hufBA5lbKHGMLOntx734oYBB810rRBQTyRmR
	 KmguKGBlspGuO14svE3cIxuvyt7aI5jhrq95IUxNKcs+96ZUlolC+kQocN7MGXDoYVoHi
	 xrTWUK/2LNOywuPEJAYatcCTXAc2xwIKiBa2zRu1/I3a0eUZnTX1l7hGZFe7t+NCZQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103641;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DJKH5fyBpHe0bd+2YhQRujgA8rtCXUKuCcn6zDzbY90=;
	b=jAz/8zrS1VxbqMmdBUTiUC7iyOt81WvjJVNalXcJAp9xlHtlO50TGa5xMMqFMQf6vvJo
	 JjtkM38UPiOtcgiE1/WNijF1J8XmNPZNm75fZXNicFbcC2inqT95NkExUcWFlk/B4E9af
	 qspHFWBU5f0AIyWOx0w6g7StM+irkcwCLkrXFkGk3/9MR+MFrAM6UUH5qU2tqvlh+GWA+
	 W2BebByj6tJc7Y/WUm4w75LjLZjGc/gvtAI1bxfTg/NOm+ih6q333ykhueVfhAV14rpFI
	 k+MXUqpZjEe0vIeTNUoL+Q5l+aEhK674PFf9mPUl/aduuby642UeSHvMb/uuMOj9/PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I86ulnk9;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YY2oxAm4;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1253A606A31E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1253A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I86ulnk9;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YY2oxAm4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793103635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJKH5fyBpHe0bd+2YhQRujgA8rtCXUKuCcn6zDzbY90=;
	b=I86ulnk9qeR6D8CUuvGSDuLeW5aOut4K/eyWeeUpsw3WJPBG4ZSjw9y3VwednkmwYnGFEV
	ASSz9w3rPhDp3jPBbvBnBNDWydH/CnLELLY1NGT+1QLr8BXFcDfldYPViQQEuZ5+zsFKFA
	z7l7uWrYeOLwuzQ44UzHyBnzao1IM4o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-xruIu8XNMYOKwnp0nWGQRw-1; Tue, 27 Oct 2026 08:20:27 -0400
X-MC-Unique: xruIu8XNMYOKwnp0nWGQRw-1
X-Mimecast-MFC-AGG-ID: xruIu8XNMYOKwnp0nWGQRw_1793103626
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c465c4c8da0so466494366b.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793103626; x=1793708426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DJKH5fyBpHe0bd+2YhQRujgA8rtCXUKuCcn6zDzbY90=;
        b=YY2oxAm4qa0oT9nf2WVh9sPFuG7/RC0BwLWjVt4r0eJgGHimrtltaG8qP3r09wBgG8
         3L7RLree4h3pdtKHnaiAtAj84fWLXtTsEB7S0F77Rnlss9eOTnN+Ku76CaRlRN5p8EOP
         p+MsRFxp/JB9dV9kgC2MukwxQoiEefpWQaZg+jGScYGlCCVvj+2gWRwf4J96gygK+dX0
         sdmNY88YpzmRrcuGt/qnq0idfwRea+3siZOUqnKCxXoR7vpeRTV85rxPu5sjAW9O9cSi
         UP0cu27eC43Wnxu6s6BB71ZFGWa2304y2RSfGRi0bTd5rmT77vTY7vx2bOx2dLi8ONUK
         YF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103626; x=1793708426;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJKH5fyBpHe0bd+2YhQRujgA8rtCXUKuCcn6zDzbY90=;
        b=rKDQ/NuZgaGSIGgkhGf9bEB2tmOffpZa0zoeEZwxibLJk2CDZQrX46zSyBgmyShEKM
         /I8VdPPGazpTY38NYEOS3xg5lu6a19+a6JdZdpBYA9cy0Xi9krAKsCVcm73D7btDi0lc
         jJBNuYud6KF6ocn8lDEzVgWqR/gBiI26g9gkjge8AoeELwgW0RW+OHzT3w350afq5W2m
         H6jboAQu8V7afHDhvuL9ZCtE11gZT6AXXxnXLyAxo9m2Cra8TBTMQY2bU78/6q3egMAq
         LsDLr4AyBSblrlWXWMSn5II7P9wIgWE1Yz6LNFn3YHhMMgcagdd+roG1QGRMTlmrIXuM
         H6DA==
X-Forwarded-Encrypted: i=1; AKwUvBxSboPIKiORZfHJxmuUUV6vidHibRlAV00C9ODOKpAwHMi2+wzTmVftw1uZlfwAWJUvaEerN+4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4OlaiZZ2y+GD87XHNso5/PvU0ryPHP/BxPUuDrw60/XS3dx0E
	ljuIbJJqt0xHrCzJRaOjGV1jin2zx/ejnyg4P3DtMVZLVSa7DpFt/1c9vDhD1+7+/dzQO3hozed
	w1cDoE5rUtgBeRqOCa9WgjugCKgIhOYMeKRTauKY482rjeGihWeFa+VYiuQ==
X-Gm-Gg: AYBFou1z6K5Zuy9+Vygy8Eu3D71VS9olN53oI6mFHuw4Xn3hPoM1e37fy8Xz8GbMcL/
	15IKiZRICxoMdJ5iKgrDGQvvYERoZnWOiuwHfh4xgrwztAMWagzS4CI4BKkKJBmsjgXc1S90cDu
	o8y5J5xffiA2RwjSwRT2yk8y+yRajALpqVOGRPuzKWcq/k6tuKJyV1ZAal84qTD0j+kyMrP2xfF
	oFEysBP5dltVUWctA4j0S+3PQGLY2o7gpsERYSFEHz+nQmag2CVF+A3KbHmIdIwQ6jynAm7UMjA
	QdlQkX3fBU39y1oMK80+LUu/Ica09bqCbkfrDRSUQjiRecdCY18AAfEnhBS1socYBkXJnkvCQ6R
	Tr2HMr9qg8/TRFTmhd/g2lOVcqDEOXY5zUTsHcdfgaRrIVWY7UqhbvUuqpobGD0KonkTmoEl31g
	==
X-Received: by 2002:a17:907:9409:b0:c2d:bf61:24d1 with SMTP id a640c23a62f3a-c46bda57206mr969337166b.1.1793103626278;
        Tue, 27 Oct 2026 05:20:26 -0700 (PDT)
X-Received: by 2002:a17:907:9409:b0:c2d:bf61:24d1 with SMTP id a640c23a62f3a-c46bda57206mr969333866b.1.1793103625653;
        Tue, 27 Oct 2026 05:20:25 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm22251473f8f.14.2026.10.27.05.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 05:20:25 -0700 (PDT)
Message-ID: <129584ad-9434-4403-aa0a-48abf9966dc1@redhat.com>
Date: Tue, 27 Oct 2026 13:20:23 +0100
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
Subject: Re: [PATCH net-next v5 0/5] vsock/virtio: reduce RX per-packet socket
 overhead
To: Jia Jia <physicalmtea@gmail.com>, netdev@vger.kernel.org
Cc: stefanha@redhat.com, sgarzare@redhat.com, bobbyeshleman@meta.com,
 mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com,
 xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, horms@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261023075140.9613-1-physicalmtea@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261023075140.9613-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/26 09:51, Jia Jia wrote:
> This series reduces per-packet socket overhead in the virtio-vsock RX
> worker.
> 
> Patch 1: separate socket lookup from locked packet processing.
> 
> Patch 2: factor out the RX skb metadata-budget check.
> 
> Patch 3: keep one socket lock across a bounded run of established
> STREAM/RW packets for the same native socket, and reuse the locked socket
> for later same-flow packets.
> 
> Patch 4: coalesce default write-space notifications while that
> lock is held.
> 
> Patch 5: defer the default readable callback until after the batch
> unlocks.
> 
> Performance:
> 
> Tested on a single-stream vsock connection (one Guest receiver thread on
> CPU0, virtio-vsock IRQ on Guest CPU1, fresh QEMU Guest per state, with 16
> balanced AB/BA pairs per payload for each baseline/patchset comparison).
> The host uses vhost-vsock.
> 
> For throughput, vsock_perf runs on the host as the
> sender, with a custom single-threaded Guest receiver pinned to Guest CPU0
> using blocking recv(). The fixed-64K table uses a 64K buffer; the matched
> table uses the sender's request size. The virtio-vsock IRQ/RX worker is
> pinned to Guest CPU1. To normalize run times across payloads into a
> bounded, deterministic window and avoid long runs being skewed by host
> background noise or virtualization scheduling jitter, transfer sizes scale
> proportionally with the request size (64B/64M, 256B/256M, etc.), capped at
> 2G for 4K–64K. The custom receiver keeps the recv() size and count
> explicit; vsock_perf's receiver uses poll()+read().
> 
> Latency uses a custom user-space vsock ping-pong tool.
> 
> The measurements below were collected for the RX batching series.
> 
> This benchmark does not run vsock_perf on both ends. Instead, it uses
> vsock_perf as the sender on the host (vhost-vsock) side and a custom
> blocking recv() program without poll() on the Guest side, with the receiver
> thread pinned to Guest CPU0 (and the virtio-vsock RX worker pinned to Guest
> CPU1). Plain blocking recv() combined with strict core pinning gives
> audit-level determinism for tracing a single-threaded TID.
> 
> With all patches applied:
> 
> End-to-end RX throughput (64K Guest recv() size, SO_RCVLOWAT=1; Gbit/s):
> 
>    payload  baseline RX  PATCH RX  throughput change (95% CI)
>             (Gbit/s)      (Gbit/s)
>    64B        0.1290       0.2489    +92.91% [+89.31%, +96.58%]
>    256B       0.5780       0.9727    +68.29% [+66.14%, +70.48%]
>    512B       1.1688       1.8316    +56.70% [+53.85%, +59.61%]
>    1K         2.3059       3.3377    +44.75% [+43.39%, +46.12%]
>    4K         3.8787       5.7310    +47.76% [+45.20%, +50.36%]
>    8K         4.5983       5.4575    +18.68% [+16.42%, +20.99%]
>    16K        5.0806       5.5615     +9.47% [ +8.05%, +10.90%]
>    64K        5.4842       5.6423     +2.88% [ +1.13%,  +4.67%]
> 
> Fixed-syscall stress test (receiver recv() size = sender write size;
> Gbit/s):
> 
>    payload baseline PATCH    throughput change (95% CI)    recv()
>            RX       RX                                     (base/patch)
>            (Gbit/s) (Gbit/s)
>    64B      0.1384   0.2532   +82.99% [+74.19%, +92.24%]       1048577/1048577
>    256B     0.4042   0.8983  +122.25% [+113.06%, +131.85%]    1048577/1048577
>    512B     0.8056   1.6035   +99.05% [+89.34%, +109.26%]      1048577/1048577
>    1K       1.6030   2.7158   +69.42% [+63.22%, +75.85%]       1048577/1048577
>    4K       3.0194   4.9586   +64.22% [+58.43%, +70.23%]       536799/525225
>    8K       3.8316   5.1255   +33.77% [+31.00%, +36.59%]       274864/263013
>    16K      4.5702   5.3808   +17.74% [+14.87%, +20.67%]       144958/131332
>    64K      5.4736   5.7118    +4.35% [ +2.79%,  +5.94%]        49039/32938
> 
> Request-response latency (Ping-Pong RTT, 10,000 requests):
> 
>    payload  baseline mean RTT (us)  PATCH mean RTT (us)  change (95% CI)
>    64B      224.148                  224.151              +0.00%
>                                                          [-2.26%, +2.32%]
>    256B     222.037                  224.499              +1.11%
>                                                          [-1.66%, +3.95%]
>    4K       225.982                  227.026              +0.46%
>                                                          [-1.15%, +2.10%]
> 
> Guest CPU1 aggregate cycles per received byte (fixed 64K receiver, with perf):
> 
>    Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
>    64B        65.282    57.843  -11.40% [-13.77%, -8.95%]
>    256B       14.710    13.813   -6.10% [ -7.89%, -4.28%]
>    512B        7.709     7.188   -6.75% [ -8.79%, -4.66%]
>    1K          4.075     3.862   -5.23% [ -6.80%, -3.63%]
>    4K          2.034     1.887   -7.21% [ -8.67%, -5.72%]
>    8K          1.664     1.568   -5.78% [ -7.83%, -3.69%]
>    16K         1.450     1.385   -4.48% [ -6.08%, -2.86%]
>    64K         1.338     1.317   -1.51% [ -3.21%, +0.22%]
> 
> P1-P3 contribution:
> 
>    payload  baseline RX  PATCH RX  throughput change (95% CI)
>             (Gbit/s)      (Gbit/s)
>    64B        0.1285       0.2462    +91.59% [+79.74%, +104.22%]
>    256B       0.5909       0.9666    +63.59% [+61.03%, +66.19%]
>    512B       1.1817       1.8350    +55.29% [+46.76%, +64.32%]
>    1K         2.3252       3.3600    +44.50% [+38.93%, +50.30%]
>    4K         3.8436       5.5661    +44.82% [+40.30%, +49.47%]
>    8K         4.6609       5.4115    +16.10% [ +8.91%, +23.77%]
>    16K        5.1196       5.6399    +10.16% [ +4.07%, +16.61%]
>    64K        5.6095       5.7062     +1.72% [-3.19%, +6.89%]
> 
> Fixed-syscall stress test (receiver recv() size = sender write size;
> no perf; Gbit/s):
> 
>    payload baseline PATCH    throughput change (95% CI)    recv()
>            RX       RX                                     (base/patch)
>            (Gbit/s) (Gbit/s)
>    64B      0.1446   0.2540   +75.71% [+63.67%, +88.62%]       1048577/1048577
>    256B     0.4211   0.9061  +115.18% [+72.13%, +169.00%]     1048577/1048577
>    512B     0.7980   1.6112  +101.90% [+95.30%, +108.72%]     1048577/1048577
>    1K       1.4965   2.6986   +80.33% [+68.93%, +92.49%]       1048577/1048577
>    4K       2.9384   4.8590   +65.36% [+60.17%, +70.72%]       539544/524982
>    8K       3.8170   5.1887   +35.94% [+27.66%, +44.75%]       274857/262991
>    16K      4.6856   5.5996   +19.51% [+15.36%, +23.81%]       147518/131351
>    64K      5.5182   5.8800    +6.56% [-0.83%, +14.49%]        48492/32910
> 
> Guest CPU1 aggregate cycles per received byte (fixed 64K receiver, with perf):
> 
>    Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
>    64B        66.728    61.220  -8.25% [-18.99%, +3.91%]
>    256B       14.363    14.515  +1.06% [ -4.22%, +6.64%]
>    512B        7.792     7.578  -2.74% [ -6.55%, +1.23%]
>    1K          3.988     4.032  +1.09% [ -1.64%, +3.88%]
>    4K          2.063     1.973  -4.38% [ -8.23%, -0.37%]
>    8K          1.702     1.667  -2.06% [ -7.99%, +4.25%]
>    16K         1.473     1.475  +0.17% [ -5.06%, +5.68%]
>    64K         1.385     1.358  -1.96% [-10.61%, +7.53%]
> 
> P4-P5 contribution (combined):
> 
> End-to-end RX throughput (64K Guest recv() size, SO_RCVLOWAT=1; Gbit/s):
> 
>    payload  P1-P3 RX  P1-P5 RX  throughput change (95% CI)
>             (Gbit/s)      (Gbit/s)
>    64B        0.2449       0.2463    +0.55% [-3.86%, +5.17%]
>    256B       0.9649       0.9931    +2.93% [+0.83%, +5.07%]
>    512B       1.8205       1.8260    +0.30% [-4.27%, +5.10%]
>    1K         3.3431       3.3420    -0.03% [-2.15%, +2.12%]
>    4K         5.6541       5.8428    +3.34% [+1.10%, +5.63%]
>    8K         5.4280       5.3364    -1.69% [-15.55%, +14.46%]
>    16K        5.5935       5.6701    +1.37% [-1.41%, +4.23%]
>    64K        5.6917       5.8351    +2.52% [-0.20%, +5.31%]
> 
> Fixed-syscall stress test (receiver recv() size = sender write size;
> Gbit/s):
> 
>    payload P1-P3 P1-P5    throughput change (95% CI)    recv()
>            RX       RX                                     (P1-P3/P1-P5)
>            (Gbit/s) (Gbit/s)
>    64B      0.2553   0.2575   +0.87% [-3.68%, +5.63%]          1048577/1048577
>    256B     0.9069   0.9183   +1.26% [-3.96%, +6.76%]          1048577/1048577
>    512B     1.6048   1.6459   +2.56% [+0.98%, +4.18%]          1048577/1048577
>    1K       2.6939   2.7357   +1.55% [-1.35%, +4.54%]          1048577/1048577
>    4K       4.9168   4.9678   +1.04% [-1.84%, +4.00%]          524965/525283
>    8K       5.1476   5.2005   +1.03% [-4.02%, +6.34%]          262926/263156
>    16K      5.5964   5.6609   +1.15% [-2.86%, +5.33%]          131311/131475
>    64K      5.9439   5.9073   -0.62% [-3.00%, +1.83%]          32875/32937
> 
> Guest CPU1 aggregate cycles per received byte (fixed 64K receiver, with perf):
> 
>    payload     P1-P3     P1-P5  change (95% CI)
>    64B        60.281    58.258  -3.36% [-8.74%, +2.35%]
>    256B       14.242    13.648  -4.17% [-9.81%, +1.82%]
>    512B        7.547     7.211  -4.45% [-9.73%, +1.13%]
>    1K          3.987     3.853  -3.35% [-8.52%, +2.12%]
>    4K          1.983     1.880  -5.17% [-7.97%, -2.27%]
>    8K          1.665     1.620  -2.75% [-9.03%, +3.96%]
>    16K         1.409     1.346  -4.52% [-10.94%, +2.37%]
>    64K         1.322     1.281  -3.11% [-6.49%, +0.38%]

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

