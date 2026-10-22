Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685978;
	b=Mm8f46b/wAz9SvvpRgH53UGK+qFabi/An5N+Al5xhc3ydx7ifhS1K1SINHlmICCK2ZIr
	 lqbSZMuvODDI3/Tn7smRJQ/wmdwptDtGQFTENa7ZeJyk6RToPpi2ITW/aw9Ok0YrYnWvr
	 kSbcifbgids3PzArgKoW8UmLaBNCnPQCVD7RpEGjF/e4eHTyh7+Z6HtAv5kjeX6n4gvzM
	 3d/DrxLnuKoW8BhYq8zSvyvS8xnvMMAlafUW5YCAm7Gssc8iuVkpXM/LwgLeT5qFKEVTA
	 FffuLcLeX47d1wpL9LBlT/QsqkkA9VA0WilwlzporaCwBP4UVYrgOQE/xda4shSD0Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685978;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=rQv+vHmR/Q2SHrYd52K5xLtIzo1Bo85ScgYlpurBBjk=;
	b=Z/FHy23q6OVw5FhRcc7/QT1kPaNe1bSYTQ4to9HvD8aFgVPrafMG16i9DP39BSTHmY6w
	 CPOOrOj9qgANjc/ClJJXTu/uXDqOVjuP/+WbOM68LmKLGyvV51SZoHOHk5Ph3naPkS48k
	 tMbHvZ7FFlD32Ostg29qlK4kRmdNyT4tjujY7wc7mWg59AyP5kCsU0s7W3w0ffaJu6wSS
	 VC+9m5hN4D2QYNtfkpTF42iaKLPqhb37SCtuVrgpXiN+39mksioYZ0fhi5hO6+xK/SvbF
	 cq7aj1DbK741ZHgRovg+nvQYT8rDYhI6WcK0AbHBJtQMcir5CEDKuz6P3XDsiQHyLhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZOE9VyiR;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=V7foR4qw;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788C606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 16:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5788C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZOE9VyiR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=V7foR4qw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792685977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQv+vHmR/Q2SHrYd52K5xLtIzo1Bo85ScgYlpurBBjk=;
	b=ZOE9VyiRY7HwsOc/p2WX3FlWJhYiIjw9+3OFaXnLq5ANr6NtP8AImcLv5wbt5EwV8xC2MM
	94JDwFsbE4pttgDz85C5Z4o/R1/9yohhE7t7XfS0ZOiWvOomx0SG3z/jpfKDPSneq+NFGJ
	RFqLrykVO+kQ9HvxzavITfgIW3C7Wb0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-wP3C1Er3OFi2BuSyQKG-gA-1; Thu, 22 Oct 2026 12:19:29 -0400
X-MC-Unique: wP3C1Er3OFi2BuSyQKG-gA-1
X-Mimecast-MFC-AGG-ID: wP3C1Er3OFi2BuSyQKG-gA_1792685969
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e1ad3cb66so1108990f8f.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792685968; x=1793290768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rQv+vHmR/Q2SHrYd52K5xLtIzo1Bo85ScgYlpurBBjk=;
        b=V7foR4qwJ4gonzd/PRCgoJi+R3+0U77gkLaHqWdFqQecxa5JhezvB2mzvRQv0a3h0R
         Lkv3/mMEEC56vWOovz0OGSuFM7HL95DPrdgGVnMybr/7BxOuEvrBHWy3XgJ6t2l32f1i
         f5foBPMzCDbij41YuNZX1m2XMPxTMoJOdnlDIuvbqgDPoXiiUcNTERQDA3zN82uCvB23
         3IEGntEUAOCVjTXKuUjVq2x9G2ABpFLW/s/jIC71mVeoNCaohmZNqFI163OV1IQo7uhq
         +n3TPzaXwgVoXf+cTtcdeSYYtD6QlrjXsN4H1JnzG4QLFkpJ3yt6dwOhuWSUkr2XdC7T
         hWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685968; x=1793290768;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rQv+vHmR/Q2SHrYd52K5xLtIzo1Bo85ScgYlpurBBjk=;
        b=ehP1tFCZD4m0R1Xt0hsYMu2WXU0DPQF9ajDOECViUu2v2w8XmWhPvNMS5QSvcLtH6e
         BcNJhtkEYsPP/xogM8Mm+T7LF6/+cI62x512DYSoCkzthWLi+f8brHKbsKfVWViCJH77
         D+inN+F+UOEOwL1LS5Iwo6hyW1BBu9mHnsPYE4d55RUHKTw0KcOUDXSF4IGOg3eB/qYI
         0EdweSLexIAXgZ0dnrWIp1XmIHVgvQwNBcM6zjtuWVvj0LNxWL+ImP/igK7dd5ePBqYO
         WPWinQZcc1VykhaBzVbuy1dU7ddgE7lTCyyBM4a4dtgV/MqcmkNpZX33KVQVJNzD+0P6
         H0EA==
X-Forwarded-Encrypted: i=1; AKwUvBz04BZbs7rSm8HmmsNGN7RF52xT7HvZ+Q7HEfqFqFBPKqhZVwQUwFNixf4Wll7ZgKUW1J+kALM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwCNgDk/+xh/hPfB0TfpCYj882wVWlt8RH1wdXb1bz78Rg9raf
	OzfuSCZ7WtRWWLixfNEpVxqMIRcdX0swQHbQpJ9Km0Z9+7mJqKes04QcpjUStcVkcN51efrarwV
	fHKHu7IqAiRGSZz4B4TtBVBVf6M9v106eTso1yGFPjGpzcuPGPbP7tak9MR/MMZOIaQ==
X-Gm-Gg: AYBFou2sR3huyFEtSNHMA27YRhyxGx00TDi1nwMKDmedWtFdPz1KcIXKP9kOltsMZBT
	gp2Q2OkxATq5yXQebWs/5G8RRIUtrd8D0ijQgD9KDF+wgBi8PbirZ+2TH8fIeMT8xhTcn63mzgx
	aP7Sq7vfv/GkbHnEmi9NjPWsxKsZ1SQT8XW8y4IYVMN+5QVxqxgAWwF6HX+0gTK4+Jvumvu8y30
	UPKxH2SlNQaL3YeVZEhz9PYfioM7uJBQ9QgxutNfHbrNpK8fuffBLRUrOOROeeC83IUrFwPDJMD
	4DOL7fGV+Qg1vWNRlax0TEI/vuHH696uVv/DfgPBsBVJbWk90Y7ZBZu8RX95ChGlG185O5fkxEC
	PXvKA1NkwaORwufQsKNYRS/4bY1/xpfI99hmMEfLdviXFUXCrKNOfwdSnd2EH7G7YhCXa5TxKTg
	==
X-Received: by 2002:a05:6000:4555:b0:48d:f470:6b3e with SMTP id ffacd0b85a97d-48e264a3264mr8170278f8f.13.1792685968571;
        Thu, 22 Oct 2026 09:19:28 -0700 (PDT)
X-Received: by 2002:a05:6000:4555:b0:48d:f470:6b3e with SMTP id ffacd0b85a97d-48e264a3264mr8170243f8f.13.1792685968106;
        Thu, 22 Oct 2026 09:19:28 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f093asm13752672f8f.4.2026.10.22.09.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 09:19:27 -0700 (PDT)
Message-ID: <e084641c-d7aa-439f-b994-85011d7c11f8@redhat.com>
Date: Thu, 22 Oct 2026 18:19:26 +0200
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
Subject: Re: [PATCH net-next] Bluetooth: btusb: disable by default Qualcomm
 multi-subsystem
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
References: <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
 <CABBYNZL_EV5LHaXO4rUGu1jg7domF_h1xfmg1m9odHBfgFPA4Q@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABBYNZL_EV5LHaXO4rUGu1jg7domF_h1xfmg1m9odHBfgFPA4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/22/26 17:44, Luiz Augusto von Dentz wrote:
> Hi Paolo,
> 
> On Thu, Oct 22, 2026 at 11:38 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> New knobs should default to 'n'. The mentioned one depends on
>> BT_HCIBTUSB, but the latter is enabled on most systems.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> this is a last minute fixlet to avoid breaking expectation for the
>> upcoming net-next PR. I'll merge it in a matter of minutes unless
>> someone scream very loudly very soon!
>> ---
>>   drivers/bluetooth/Kconfig | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>> index db0189ca3cbe..0dca5e43edc5 100644
>> --- a/drivers/bluetooth/Kconfig
>> +++ b/drivers/bluetooth/Kconfig
>> @@ -96,13 +96,12 @@ config BT_HCIBTUSB_QCOM
>>          select FW_LOADER
>>          select GPIOLIB
>>          select WANT_DEV_COREDUMP
>> -       default y
>> +       default n
>>          help
>>            Enables various required support, such as configuration, firmware
>>            download, and error recovery, for Qualcomm Bluetooth controllers.
>>
>>            Say Y here to compile support for Qualcomm protocol.
>> -         If unsure, say Y.
>>
>>   config BT_HCIBTSDIO
>>          tristate "HCI SDIO driver"
>> --
>> 2.56.0
> 
> Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Thank you _a lot_ for the very prompt reply. Really appreciated and
really useful!

+1 on my beer-o-matic :)

/P

