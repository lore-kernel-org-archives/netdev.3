Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621942;
	b=zvp9Y99xX36GyEzNEH4o68R5ilQUHqxKSzlPLCv92RVOev6y/zqizSuB9fGraxPPEvMI
	 PO0IionOZBOcAgWyZKekZIxW8tT0EBPsxwex7eEU/0Fo2Azu4a4Gsri5S8Xp/iGn1dOp7
	 yO8k1aZA7r6ERhESVhg9oW7ht2n9N4Ym8u8LQyTws/7tf9O8p38M3YmL0BgSLi+A+gxzU
	 FozliUHcjuG2Ts4WHASzb57/aciZLnGGQMNHe+bjEIDEdni3yEOhzTPnqZ220NiEWbusO
	 Fvb2aDiEvvJzWkJ6ONwcwByd85yFdtgKWiFMT+/FRancakZJDPVnArj+dY4zxWBYPwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621942;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ezbpBo/Df5RXTILcrA43k0R/PKSOtGb0Z1SJrrOr0RY=;
	b=YnXKmpzxsaJ3IFyM0yIGQGW1hYD99IboVuS0WbFPzwFL04Ib9W7Hz0Ex2eCwcwAsmcfF
	 EbAOPHpluj7gIsXVq5vpPKRCxP82NK8WGyFOykuBsXK1wOGxW6lhTl/T7CvJSK8tMopuq
	 GsTzaKH+oodSczSrHQKeOiCiWr0PySUbtDmhn6krGmP5Mkh5vTXfaAa/fiFqNv7jxsdz7
	 EYfJ7hyqWOZHB5LKdmQ0u5CqhTlvPBcuaSb82zKeDIK5mGeXdOoQuYob/GYxIZqd4Dc4t
	 pyZz/VVEiEwblpcdMnFbvrsjeVM57aumXWr8xE9YI4zj8b6nC+P4vMzoP5FQO8IRpdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kj0UyuK8;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=muxRvgEI;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDD6606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCDD6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kj0UyuK8;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=muxRvgEI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793621940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezbpBo/Df5RXTILcrA43k0R/PKSOtGb0Z1SJrrOr0RY=;
	b=Kj0UyuK8l7Y2xhXJy2Sz5jOnn2uZnapvDf+tZeGDYIG77R+3DMEuc/f9oPAiuGfUMvMpTW
	5ZhXkDX/ga3CYyInyx2WmW1r9YHj6ODBRbVVdCdR0A6A1M+zpZFXMTpYBU5MMow1jIpCV6
	Ta5QvLEVJw99h9I7RXtnHpCYZwyQ3tI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-0kVnLV_RM_2qnxLtZIs80w-1; Mon, 02 Nov 2026 07:18:59 -0500
X-MC-Unique: 0kVnLV_RM_2qnxLtZIs80w-1
X-Mimecast-MFC-AGG-ID: 0kVnLV_RM_2qnxLtZIs80w_1793621938
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c41f85ee4a3so73082266b.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 04:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793621938; x=1794226738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezbpBo/Df5RXTILcrA43k0R/PKSOtGb0Z1SJrrOr0RY=;
        b=muxRvgEI1s8h2zXXULZwzI/3XpicjK0kmbxlDECs7rKlTB1yV417AeqCjWgbpgMPHo
         HaZDvQbbIp8Z9pm++PmPre6CDAOjXSvgLL2PTbyanJsw2PSpd2/Tez5W6NLvLMBHsBuv
         NTRIpvhZHtiAaGj4AfwZubouJ8NmlF/fcU2U9VP6C9ZNxoO9BUo3RuY7LBL877l0+sW3
         erVGbHIbFa0qo6s9N4vntGzH5HUU8un+SikGAnSUunIV+aR6G0QHZnLcCTY0DhwG9Y4+
         GIxr/OqeijdBgYRIPusUguFRwANmziqyeJYXNPhzIHn5dhsFd+/ihq7X22q95wzwc8kW
         g8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621938; x=1794226738;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ezbpBo/Df5RXTILcrA43k0R/PKSOtGb0Z1SJrrOr0RY=;
        b=VCDFweqzjXVXK3M7z1ko/HbeZwB3hkYTKb9Ajbn7gpDfotqFigsDiOpiszEd6h/U/H
         XzCTpPZFp+49OfAM3pAC133Bb6SWF+JKQvMMF2qIOAL5TxH/9XhKKr0Cgd4XBaTIF4In
         Hh6FJ8d4S9Gkl9Q3IVRy9JZ/BTSFnG+7hyjxMlSQS3p9kw1fpzum7KSGYVZEehgyPeVs
         gLCzFHP8v0BsGkoeWa02K/ndd8+636fU1DobxHz/P+ZY+mpsvPesHENYsOa5n5UkCKNc
         sslhDQPZ3eXf6OPDFJXSLOqW84Pj/i0fhPghDoC9sls239IGu1QLyLkB7FXXYWg1OqfC
         5kOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUo2A6aUd9ggLpXllcZYTrjXu6h8dZYp1LwzGI3+6aUpTpIL3phLxcN5KOc2+ur7TAys4xgFU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WVOgegZGD9v+DMe6wQ6prJk+K/y2GEOaZ807cKmbE8tQBoWqA
	TVpfoeM5jyfcOXVtuY2E/bcwCdU/12uM9nNytveHauLMlJCzl2uQr4cZa7ZWUqFBVYnXGdYPom3
	XU7E/C2IBiG0CsEaqDGheWAKprS9PoFYRHzPASHYsUMzoMgA+/JUOf7oPVHPXmoqx1A==
X-Gm-Gg: AYBFou2ucmSwdsZny18MllozIB8ITG0CDSlOlpzSkEqO1CSel/9MvBrYL/S9yRh0Z4w
	eIIfZ2dEDn+avhA8Gui1lPuA3TGm/IzOva4VMEFXMhWBXKwgNQvqcbM6X1wtGLqeXNRBInvQEn8
	OkEhVaG7ALVDJgoYWtfantih3b6PIWbUI/Xf9kTn8BBqTfXaJhQbfWRcZcpPlXzra7204IrLsqb
	F1hqc6MDjSTs/UC9hCznWSg4fs24A4+sy4ZGD/e33yj2fDl6azBIdSQjA2NuEF8+sBnRkJFFBt4
	5bHKx1PNs0bccLM3MVTw6AVtAzZJE2SNn7myotFesZ9xlwrPCqM+Uf0FNLgnhIcdMYpfolRLKOS
	DHZKQBqP/F8N+JVl3LuTr7CO1xhW+Nv6VAD/0dR2nLjIWyCJHSRxe3Xci4AVrBi2OAsV7JDlOsK
	hXUZQDS+1pCtSMXrv8lKrQF4h07MW2qVwo+FVNcnhb4U0=
X-Received: by 2002:aa7:d518:0:b0:6ac:7868:b690 with SMTP id 4fb4d7f45d1cf-6b4d438916amr5355713a12.8.1793621938404;
        Mon, 02 Nov 2026 04:18:58 -0800 (PST)
X-Received: by 2002:aa7:d518:0:b0:6ac:7868:b690 with SMTP id 4fb4d7f45d1cf-6b4d438916amr5355695a12.8.1793621937879;
        Mon, 02 Nov 2026 04:18:57 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec9fb9a3sm3166256a12.14.2026.11.02.04.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:18:57 -0800 (PST)
Message-ID: <836982e0-b733-44d4-ae2b-20276589f867@redhat.com>
Date: Mon, 2 Nov 2026 13:18:55 +0100
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
Subject: Re: [PATCH net v4 2/3] sfc: ptp: serialize host and MC
 synchronization transactions
To: netdev-bot+sashiko@kernel.org, alex.austin@amd.com
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, richardcochran@gmail.com,
 alucerop@amd.com, pieter.jansen-van-vuuren@amd.com, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20261026123023.3566549-3-alex.austin@amd.com>
 <179336481081.3134.5405870739856758840@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179336481081.3134.5405870739856758840@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/26 13:53, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The new kernel-doc for `@phc_lock` in struct efx_ptp_data
>    (drivers/net/ethernet/sfc/ptp.c:275-276) says the lock "Serializes PHC…
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but
>    `_efx_phc_adjtime()` in drivers/net/ethernet/sfc/ptp.c (line 2144)…
> - [Medium] Baseline decision: not a defect of this patch (pre-existing,
>    Medium, in a driver the patch does not touch).
> - [Low] Baseline decision: false positive, fixed later in the series.

Note you can usually ignore pre-existing issues. Exceptions are
e.g. when the solution for the pre-existing issue will require
a significant rework of the patch at hand or impact is drammatic.

BTW I agree comments WRT problems still existing on siena are
unrelated and should be addressed separately.

> sfc: ptp: serialize host and MC synchronization transactions
> 
> This adds a phc_lock mutex to struct efx_ptp_data. The mutex is held
> across the whole efx_ptp_synchronize() transaction and around the PHC
> adjfine/adjtime/settime operations, so the PPS worker and the hwtstamp
> enable path no longer clobber each other's handshake flag and timesets.
> It also bails out of efx_ptp_synchronize() when efx_mcdi_rpc_start()
> fails.
> 
>> diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
>> index 957ca08092e7f..e26269fae38d6 100644
>> --- a/drivers/net/ethernet/sfc/ptp.c
>> +++ b/drivers/net/ethernet/sfc/ptp.c
> 
> [ ... ]
> 
>> @@ -271,6 +272,8 @@ struct efx_ptp_rxfilter {
>>    * frequency adjustment into a fixed point fractional nanosecond format.
>>    * @current_adjfreq: Current ppb adjustment.
>>    * @phc_clock: Pointer to registered phc device (if primary function)
>> + * @phc_lock: Serializes PHC commands and synchronization, and protects
>> + *	      @current_adjfreq
> 
> [Severity: Low]
> Does this comment claim more coverage than the code gives? Two of the
> callbacks in the PHC ops table don't take phc_lock. efx_phc_gettime()
> (.gettime64) sends MC_CMD_PTP_OP_READ_NIC_TIME, and efx_phc_enable()
> (.enable) flips nic_ts_enabled. A standalone clock_gettime() on the PHC
> therefore runs without phc_lock.
> 
> Making the comment true by adding the lock to efx_phc_gettime() would
> self-deadlock, because efx_phc_settime() now calls it with phc_lock
> already held:
> 
> 	mutex_lock(&ptp_data->phc_lock);
> 	rc = efx_phc_gettime(ptp, &time_now);
> 
> Nothing breaks today, since the MCDI interface lock already serializes
> the RPCs. Could the comment instead list what phc_lock actually covers
> (synchronize, adjfine, adjtime and settime)?
You forgot to comment on this one. My reading is that this is just a
slightly misleading comment.

/P

