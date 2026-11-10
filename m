Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299466;
	b=1El+LJBvHVzDR/YUAKPvxMUeFPnqL7ojFiYzhlYRW0mpkhLxgkFxHpDWngQ+yZEqoRJZ
	 jS649Z9V9+Bj1lOv3uFW3wi9vUmkddAVtt/YTXfGnPHdFDUlWlf3YNomN+b5Vl8aM31AZ
	 2OcQwxba7XF3fswvn+1f1J3U38mGwtqQitsGdIZ/CECUPryoenKvdQwm29R4KrOAmS+72
	 m7RTOn81zOJZoikN6ZuYdKh4t56W3REJOn6ja8l3W63zr6Edj7ggyTsJ1f95aTSc2JyH9
	 Tu0FzDdReNpiHwQklLfAS9UWFmCZhMK5i74zr54Dry+oXYkXuVhqvqOmDnW0SYDL8Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299466;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PI2PKfoJt0rvenbJLW+04PG2yF6v5rLbE6RaSFwnr3Y=;
	b=crPVH/s3OdJfolL/DJ257RvaCAmuetXyv1GZpv6o6wcZf/XOwtOjxAUZLBL2lrpD/bkH
	 JRFCrDaXhy+RZFpEfQ6KYdBIPVMIh+jSmbm64zZYmyCSCfrRxhGmpFVrWeJ6Xatz4BJdQ
	 BNLV0fAbnCObMMXciYD1tZw2PEipDa3QMg1/gK4e3QEkLQuN5fpcAdMgcdKrWHMsOjira
	 fm9UE57m7Pkpq38dDPcmPs7I2iLGsgHqVAwglZfcKxe9L9ErgyakypYR4jMz/iuU7L4Hj
	 9+Y4EYxLn/ok2bnJUyn5EC+Nuu/JrhTvXxnAHN4alFDnEH8JmEyhyNTFlp+FPpCY+OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KssVo+Za;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RlLSCZl1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252B60A3839
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9252B60A3839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KssVo+Za;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RlLSCZl1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794299464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PI2PKfoJt0rvenbJLW+04PG2yF6v5rLbE6RaSFwnr3Y=;
	b=KssVo+ZaJ7rLj0MPnEMu3Fbeaq2N1FMfjXGHBOvvG0TKDI/D9eWAg6Xsn4rOqMk5m96MJ4
	abyHI0N1t9nSae4nALFn1oRLWJgCTI0Gn5H0WpxtLk/LZeQJtp3a4cRXHQfSE28ZstiCos
	8147xRtqW01MUTxiMHtTSMZERTCCBUQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-BSnwTMGKMpujBB4HE1iZHQ-1; Tue, 10 Nov 2026 03:31:02 -0500
X-MC-Unique: BSnwTMGKMpujBB4HE1iZHQ-1
X-Mimecast-MFC-AGG-ID: BSnwTMGKMpujBB4HE1iZHQ_1794299461
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a2063be141so16491185e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 00:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794299461; x=1794904261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PI2PKfoJt0rvenbJLW+04PG2yF6v5rLbE6RaSFwnr3Y=;
        b=RlLSCZl1f2ieYE0nuRo3ks6hpd/xhYiHJ8P5g0Ypa4rV99Nwm29STv/yE8VqrjVQQW
         gLvPr0sYZ492EZnEKGfzu5V6dCA0GI48Z5QoHF/H0w3sXQKq80qq93ySsVEs26JkUcuV
         rMV2fjCENBk8qtUKl6stIXvFt8T3FrH1n5Vv83wwYT79Scs8Vgof98GhCpbuv4PROwu+
         YrlLHXzAFs23ih5xiuRwjbkJq/t4ujKhvqUrkvr8+2K93OCiCACkraSDz6J5PV+Lwrsy
         t1DFw/829L9egt5kuG9BhyJKyiqtDjzywOlR7/xx/A0Xbd48JaFVfLSbSD6JvxbYZjJv
         a8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794299461; x=1794904261;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PI2PKfoJt0rvenbJLW+04PG2yF6v5rLbE6RaSFwnr3Y=;
        b=a7t2HnUr8qNvDYzwEu12s04scceFxC7QdlHPefAflZYOSxUCSEvx3v4WO8OaPNzY5A
         FnbGyxN5JI7McxTAl2I4BtzH2nOoxMN2KY880vQfnM4R0+sYDh1hLSaj8TgCOWBQuqpE
         cHet60roLW8ZJc6ITl2umRtNWLuLEoxR6dJzkzN51sKCCO2UcRjTCB+oLYkcGiJtfIVj
         8SNnM4aBeofBlIUI5WpE1JHlByKSUoZ3ZegOdQ58wNZpqrCWYFpzX3kDxAntWparRL54
         woiQB9rnBX8Rqc3quj4wUZ2wfEwE6QtHTOUJnCez8Qngnnnm03YHjkQfpKOPLGb3NuR0
         9BtA==
X-Forwarded-Encrypted: i=1; AL+hErEy5d0EZZxtHBKlt1J14FWl2kiQz3v3yKJwr8zC/vlltxjv9TrIhWiQ2X/Bx+Bd3KF+BMIU3+Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ivub/j01s4mIBQJGRHkONBroPQp7vwcXEE/z9XBp64uO1D9ko
	ZVovSceyoDPKUwkA6ewQBrendTvTvJOhAXc/9CLt1BO+px857SZUn6m5srlllVG3Y625e55a9Pz
	qsIRsro+IYSVjiTkdKfdv4a9qzvAU0fKoaLCXPrANW+PSg4tkVB3vXxMQ1A==
X-Gm-Gg: AYBFou1xNQfGIwgIKmHZtrqDSuc4x/igkbZYb73w1Ar0ylYPJifZi/gGe98rW9gEnXD
	lgxZHVjWyFkQffQkPQvbWYaB9MNxchQGdFtQOazDzNvRBCA+jzHaXN9ugq7q6G9/mDD01lGNX5M
	4/xTX040+7qdWBwewwNfENO8+cyVR4g8Z82Kh+bMU5ETOQEh+2KSXQHB3uMidtQ57n6u4hsc5L2
	0omEr1stYB3P5nJOKX8TZitqkC11XMbeSQZw+FVWYcbZClErKZHVpVFY+vJ5QusFn+KoOCRneke
	3UzpJ2jpxhJb9O+BIek2khDAI/NZvOy632YC2PuFmoZWEbnqRsqLoxce/yHw77l3byaWZS8bNy4
	pkfaLBZzENjjT9ry6N38E4DH3IDJ2v+B8wjNlGYH+0ytRp12z14JQplWX/ceINdl1+GJKHae4Cm
	by7IczH3bf0n9hyvJBUQvJL9yijZ+aDwLeVj9TxBHTooAA
X-Received: by 2002:a05:600c:4f4b:b0:4b1:32c8:27db with SMTP id 5b1f17b1804b1-4ba0234bd12mr37428045e9.22.1794299461235;
        Tue, 10 Nov 2026 00:31:01 -0800 (PST)
X-Received: by 2002:a05:600c:4f4b:b0:4b1:32c8:27db with SMTP id 5b1f17b1804b1-4ba0234bd12mr37427425e9.22.1794299460813;
        Tue, 10 Nov 2026 00:31:00 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0204e22csm44017445e9.12.2026.11.10.00.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 00:31:00 -0800 (PST)
Message-ID: <817d2bd1-64fa-4a6f-bec6-5a4dd4d3a76f@redhat.com>
Date: Tue, 10 Nov 2026 09:30:58 +0100
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
Subject: Re: [PATCH net v2] net: stmmac: Clear DMA errors for multi-channel
 interrupts
To: Magnus Leatti <magnusleatti@kernelriot.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Nicolai Buchwitz <nb@tipi-net.de>, thomas.petazzoni@bootlin.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20261103125430.962715-1-maxime.chevallier@bootlin.com>
 <179379704484.488856.2140619507341432623@kernel.org>
 <20261107100140.8279-1-magnusleatti@kernelriot.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261107100140.8279-1-magnusleatti@kernelriot.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/26 11:01, Magnus Leatti wrote:
>> Should the Fixes: tag point at 1b9707e6f1a9 instead, or also include it?
>> As written, stable may backport this to 5.13+ trees that cannot hit these
>> storms.
> 
> A data point for the RBU case from the YT6801, same 64-byte UDP RX
> flood, all on the same 7.0.13 kernel:
> 
>    stmmac from 7.0.13 (has 6ccf12ae111e, not 1b9707e6f1a9):
>      no storm; the MAC interrupt never fires (4 streams for 10 s,
>      and 8 streams plus TX for 30 s)
>    stmmac from 7.2.11, built for 7.0.13:
>      storm, the machine hangs
>    the same, with only 1b9707e6f1a9 reverted:
>      no storm
> 
> So on this hardware the RBU storm needs 1b9707e6f1a9. I did not test
> the RPS case.
> 
>> Since RBU and RPS were enabled only for statistics, was masking them in
>> multi-MSI mode considered as an alternative?

AFAICS 'statistics' here means accounting of some corner cases errors. I
guess this could be a preferable route.

/P

