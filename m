Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F5440655
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580254; cv=none; b=GTPh1TYjQMLxX9ej/z+YtlmUS6jZDuAyEHS2tPtEurRvSVDPoBkVZcpogkHzgZ/7KNcbn5syPuQqhNQZFhcaFiUzyDO1zJihUGsFu99pvElcPSq1PFM9RLJAFUM+SbuRFC8XZmHXP0aIyv6JEw3dsmOiFO3o7Swau9HitaP+6Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580254; c=relaxed/simple;
	bh=XqL2HCd0UPofeqYeB/BZt1wok8dT8aPuwMtTYW3NGVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qfIETbsomdQw8qqjJfWtNOFcfoC4TzvWvJDVWkvw8wg+i1zBQj7xOdDjCB6on35vNi5GfJ+jYSuJ+9qxlVMg1AY9Kh1JApfDf61Epwjp7AuUtRw+WmMrN8ZbuBQukpA8VNPiRf3xHyuPpp8IMSliQ3kLE6ZUqjvGJRTG3LBPS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcbDtB+Z; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcbDtB+Z"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2afd63c3e0so231681466b.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 00:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790580251; x=1791185051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xoV67SdNy1ziTa8aJ6OVJtQuFKSbE7nYyY+jBoK/+ew=;
        b=IcbDtB+ZP3p96Vy5AIzAjFJFaAL0u77TBp3yUmxK/UMxxYGfPfyittipcDov0bC8Qr
         5AmYM9d038iq0eRqCS9Y0HKbTS1Dy0Ht6CW09m81AiTP1cLoJpfrnUDRtk320HkEyD/Z
         gf12SDWG77uKwmpt4vDuQUbunFy+euLCy60hzdVGAZyMLtbieOqY36DEdPDLMEQYCyO3
         2duMfvrTlR7NV/O7R1cjaZ6RazvxHBhpRjCSWzVuEo5qeQVsq73WxT7yup+KoNNX4NyP
         nY/wbktvSx+rTFGq5W2ww9hxNJRswWhIVNT+YDXVfK4oxe0+G7Rm+OWio0hKuIEhx0T+
         +o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790580251; x=1791185051;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xoV67SdNy1ziTa8aJ6OVJtQuFKSbE7nYyY+jBoK/+ew=;
        b=HeL8JEkAud7xjVjQtYc56QH0ZreJL9fu40gMLffCSRsfqdoykirPdCi4cJJ9ErAsYr
         hubOxRxiMgyD5kr5Av/lReccDSfIQE4qPds0dvDSKw7d6iq94UD7Q8dx89Xp1h8GpPiL
         0RX8MW/XXPzOOe6U+d8+T472MpegxxGSvvfJErpnMc4a+/2s7u60Ti8q4ArawLhayxMr
         Qcel/CTD6j7UOQ+TehlCTkcmLDRHjbmyaJD/VlbH0EDGAfEbHuLGSpMuZv1bbqkVSRZv
         9/1dTllao8ZDh+h9U5idJyc8fbyGg163yx+xFwflp+e9Z94t3vUgQnuPT5zuyQ1uolm3
         /xVg==
X-Forwarded-Encrypted: i=1; AKwUvBwOe8CO6ypBkIesxJODvr8lAhzw7WNUVV9YEXOHQ5VS6YkMimesKNK2/Y1PH8oRDKyVFMFHkhQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ly5XWG7n8dHDQuelQ8NhV6nVcuZ4Qa7zYg6TV0XhZGh444+/bc
	iHy+AlVKjd+15tWwVOTJ+oiJqB+eE1nZWTv8+2YeUCStITv5ZDu9PpmPOVXTeg==
X-Gm-Gg: AYBFou1ySFGegQ6po1DBrRIkL7tJcY9J7GMpoRE+kTVpMqlhV+/LYQwhC6pOfsKBLK9
	fiR3KrgckF+JtkDhAEwkk3a4OoNQG985PwxXco9OsRGNjQrea6cxLt5fxe+gEr1Hg7lqSlOKwKw
	wIVlAR1YELRuQ9A76LWZVybXhdjmCPQiTjmnDE35uJMrsyhBgy4Ijvf3qbUyEF3UnE88zVMLs4/
	rLXixbyeMTdkdPkLsVD6X5N+QRYTVU3HidUeIwzigxjSJa+9Va4KzZPnguvVnRheB0ypn4TvF1V
	dcYxhtXL5GLCKSz+H9MvXkwtn1BtO+ldCDwl46HCA8Vrlb9pe4HvsRAOKyHHxB8soBrH3QoqEmY
	wMjzqzv7DvC3P5BpAwY3EgqctBcMCbkjNWWq57BmSrLbnxt3FS22qI+5hMMVrNVC+n3hZZdYZq3
	6dF985juLzux8db8yDH+lDUl6BPoTF7OFYcVYNufL6UtmNRGGUZr+/dOwIDuHrCGQh3TG07Er0B
	1hxvaOe46D6HgsV3nKvnYChREBwz4H2JZefvM46LVB1lot+4foz0fRFZbUYYq3Bws898JkaKA4c
	szbFU0xqqcoevNGtBU74dua0gAJjw+o++0NeV4E0QnTETJ4OkCXHM3BRPAwRELDtuZTgzvuzx+v
	2tJLyzQD0+8+KEBJuPDLdF3Fw
X-Received: by 2002:a05:6938:a085:20b0:c2a:fd39:f23b with SMTP id a640c23a62f3a-c2afd39f9c8mr338499466b.24.1790580251224;
        Mon, 28 Sep 2026 00:24:11 -0700 (PDT)
Received: from [192.168.0.2] (dslb-092-075-058-142.092.075.pools.vodafone-ip.de. [92.75.58.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2de104355fsm68983866b.19.2026.09.28.00.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 00:24:10 -0700 (PDT)
Message-ID: <36af3503-48c7-4518-946c-84e2d7ff49fd@gmail.com>
Date: Mon, 28 Sep 2026 09:24:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] atlantic: resume from S3 fails with -ENOMEM in
 aq_ring_alloc(), leaves unusable netdev
To: Stephan Hauser <kernel.org@s.arstneio.ch>, netdev@vger.kernel.org,
 sukhdeeps@marvell.com
References: <b382cde0-7a2f-4251-8b9c-6763c3fe4cad@s.arstneio.ch>
Content-Language: en-US
From: Jonas Gorski <jonas.gorski@gmail.com>
In-Reply-To: <b382cde0-7a2f-4251-8b9c-6763c3fe4cad@s.arstneio.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 26/09/2026 21:49, Stephan Hauser wrote:
> Hi,
> 
> The atlantic driver intermittently fails to resume an AQC107 from suspend-to-RAM.
> aq_nic_init() reallocates its per-ring software buffer arrays from the PM resume
> path, where the PM core has restricted allocations to GFP_NOIO. With the default
> ring sizes these are order-5 and order-6 requests (128 KiB and 256 KiB), which
> cannot reliably be satisfied in a context that can neither reclaim, compact, nor
> dip into reserves.
> 
> Resume then returns -ENOMEM and the device is left half-initialised: the netdev
> still exists and is still marked IFF_UP, but has no rings and no vectors. It
> passes no traffic, DHCP never completes, and bringing the link down hangs.
> 
> I have 3 occurrences in 60 suspend/resume cycles (5%) over 5.5 weeks of journal,
> across kernels 7.1.4 and 7.2.2. What makes this worth reporting rather than
> filing under "memory was tight": the three failures have three *different*
> proximate causes in the allocator, detailed below. The allocation is fragile in
> several independent ways at once, which is why no amount of tuning fixes it.
> 
> Two distinct problems:
> 
>   1. A >PAGE_ALLOC_COSTLY_ORDER kmalloc() on the resume path, for memory that
>      never needs to be physically contiguous.
>   2. atl_resume_common() does not unwind when aq_nic_init() fails, so an
>      allocation failure is converted into a wedged interface.
> 
> 
> Disclosure
> ----------
> 
> The analysis in this report, and the text of the report itself, were produced
> with the assistance of Claude (Anthropic). Please weigh it accordingly.
> 
> What is directly evidenced: the hardware is real and in front of me, and every
> log line, zone dump and free-page histogram quoted below is verbatim from my
> journal. The failure counts come from scanning all boots in that journal.
> 
> What is inference rather than measurement, and where I would welcome a second
> opinion:
> 
>   - The 64-byte element size is derived from the two reported allocation
>     orders, not read out of the source.
>   - The TX-before-RX ordering in aq_vec_ring_alloc(), and the claim that
>     aq_nic_init() aborts on first failure, are inferred from the backtrace and
>     from only ever seeing a single warning per event.
>   - The ZONE_DMA32 lowmem_reserve arithmetic in case 3 is hand-computed from
>     the zone dump.
>   - The aq_nic_stop() attribution for the link-down hang is a guess; I say so
>     again where it appears.
>   - The suggested fixes were not compiled or tested, and were written without
>     the source tree to hand. Treat them as a direction, not a patch.
> 
> I have read the whole thing and stand behind reporting it, but I have not
> personally verified the driver internals against the code.
> 
> 
> System
> ------
> 
>   Kernel:    7.1.4 and 7.2.2 (also running 7.2.7), x86_64, PREEMPT(lazy)
>   Hardware:  Micro-Star International Co., Ltd. MEG X570 UNIFY (MS-7C35),
>              BIOS A.80 01/22/2021
>   NIC:       Aquantia AQC107 NBase-T/IEEE 802.3an [Atlantic 10G] (rev 02)
>              PCI 0000:24:00.0, [1d6a:07b1], subsystem [1d6a:0001]
>   Driver:    atlantic, firmware-version 3.1.100
>   Rings:     rx 2048 / tx 4096 (driver defaults; maximum 8184), 8 vectors
>   Memory:    64 GB, no swap configured
This is also happening to me, at least since 6.18 (where I first noticed it)
with an AQC113 [1d6a:04c0 / sub 1043:889a]. Currently running 7.2(.4).

Looking at older boot logs I see the exact same allocation failures, then
(later) hangs.

For me the hang often happens at suspend. I don't use the card as an uplink
port, so most of the time it has no connection, and the issue only shows up
when trying to tear down the interface on suspend after the allocation
failed at the previous resume.

Best regards,
Jonas
