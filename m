Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1F3BC667
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396667; cv=none; b=SGcBVB3b6YlMAp+DsVJwMlYUMLHc1TAZawdTGyx9R1Z9fdyFHs6COg0kBbbfchrRSA7Auj3C34pLH3BoHr5hFdJ33pWh9Y90IzlmPw9lx5juUw6T+qB77ougqMv3HLX/5/rlFnqBzSrf6vRd0/pa0d3dMAaCiH/SQOK3gYk1U9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396667; c=relaxed/simple;
	bh=TcC89QdhdtitgIgGaLddzszwIFIh0mGzl+Nx6JuAAIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEDCoKNiEoFY6I+py1XnkUDkYLuWDBCuzl64NB1Tg7tWUyWzKkUSuj8s2A/VQ4HiOJUR3a/IldDQ+Y5E3qWc77D0Xwepb3zuVcpHXMR95IAhyO9byPd0JSDeT0cfxCJxgwz/Dqb2Kr16klG5qInpHIvfsyOU5ANbve9lZ3wd46g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yi6IBqzO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qzzPdD0s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yi6IBqzO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qzzPdD0s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785396664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Iax8WC+6ctgl/TpjfswFa+BIlwe3/7Xtr8Bw7WqK9Fg=;
	b=Yi6IBqzO2i/ABG9VAyIXMlWU+S74qriHeY0R2MttAPiWF7sTwAz/VbnbumbXaWQEYwFY1w
	kufVBnq0riGR6GQQzEcPZnIx8/JQiDhVYURj8UJTw43Jw2i6z8S3gTdlxg+ikLLTLAZA5k
	igp+ONE/O+EgUwKkU53/KaGEVkM/UYM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-Beizj7NyNg2tIkjSOBEnig-1; Thu, 30 Jul 2026 03:31:01 -0400
X-MC-Unique: Beizj7NyNg2tIkjSOBEnig-1
X-Mimecast-MFC-AGG-ID: Beizj7NyNg2tIkjSOBEnig_1785396660
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-492488f8583so15662945e9.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785396660; x=1786001460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iax8WC+6ctgl/TpjfswFa+BIlwe3/7Xtr8Bw7WqK9Fg=;
        b=qzzPdD0sawIAcZnfCmez8bUS90H1qHICDMBcqNBkeo95pSTlHKgz4yrGnkUda9ZLxb
         Somot/EJj1FldmzfF8gqeqZsUo9ubO0kxy5hsODSJIf8BtReTRfQkt+L33qipuXc5dcB
         HYnfCJwTaM/RqA45bvKBCGZUcRTkMHKaRTi7SZ3pop7QHHbjkB8tS4jTIeJ9/C12B13L
         7dtCs1cRkxeMXoS+Q1FKVTJMKt5eJP6W5U1PmSavHb2qN2d0JxbZtGDwkfwLR5TR2x5I
         IelIyBkAjNQTrEhtU11+PQIaG6J+LYN3gKQHoQl9TEpLFAqV1rfbjgfmjzLCY/z01lot
         2TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785396660; x=1786001460;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iax8WC+6ctgl/TpjfswFa+BIlwe3/7Xtr8Bw7WqK9Fg=;
        b=lGlIL0T4eRxhBE0eZz2z1wEdO4M4GIYHR/lgSEadt8T02Q/6fKdkD/xE4TqIH0qf1r
         ra0L0pAF3QOVtdggA7Sn+nAty3eLjAn4eJgvRzrjp6sQtlKRijws0bem16k43bhzqk2V
         9b+h3W8zpHPiUHfTRCZBCuNummE2y7SbFZaJbutZEHbG37uPFzmyhlOGX57cZV/JnJsk
         60fZwy8+bN/9+P0TIFbgYWXNAM5NRLNMrbbONXbcfdC45tbpJ+3utwm0A24qH0tASs61
         XKEjwBU4LT6siSutajHPgMvlGoDbhjG7QCXBCkvaAMqKi13xxHPjBz30kflXtMqO7Lvp
         zePA==
X-Forwarded-Encrypted: i=1; AHgh+Rqm1Rxtof28HeDq/2rFaZtC6raPPSkvyhg5ZqkMxJ3i5rcwrOqhK+IJSFtKZNrOImXmIRvL3lU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99H/XKXMuNRj+j6WCWJvuOVtiocUJJMWwwe4lq1Mr2CemUye4
	UM2aojKCBK4qErTjXtnuUFrtuS4qAQwNzMnz4w8c/nwKafPGKE495uaJ2GYzmMcXdwqGjCdmfkI
	UhtoOBD0RA/kMPtx1lqjM6eg7Zwi1uSQmonKJ6WAVJOGD+WPQwjMb8iO8GomG9ISHpFG/
X-Gm-Gg: AR+sD10qk3nzBWpc/4pKd+nE5pOIIzsApRIrEqT7sHjhAZe/bRGDiDIV32X/fPIQH6F
	hHhePx0Dnh5PZjFuJhOcbMUALQIiNoL8BpSkubWi5cHsk9qv9zWJdZ5DmLcZOEXxcT8QZBnoJDr
	WAQKdG228ZCHf4JqJMAlV0fFfC5o1d+jUC8sTw23ZYj12p2Q+vWcngwjU0xpaIhqpA3kkyTgDhp
	q4IxeADBGABe3DZavGWVVCJ3eWWl4H3KuBHIrF7wVwwZ/nfqlDF6Zrzm+vdufmViAO1xYSm+Kwa
	HRb5xVl9nbwcc0RqovkkXeOwN5DqT/KI5IAY5BoOPRGvy/47CpmbHDrn3xSJfoq8BSoNHeDTyKy
	HxR8mbujRQpdlrBXHOr7kYpd79Y+n7aUoMQ/4YIU=
X-Received: by 2002:a05:600c:a3a2:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-49800e89181mr11669865e9.4.1785396660204;
        Thu, 30 Jul 2026 00:31:00 -0700 (PDT)
X-Received: by 2002:a05:600c:a3a2:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-49800e89181mr11669435e9.4.1785396659746;
        Thu, 30 Jul 2026 00:30:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c? ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d6e68sm3712374f8f.7.2026.07.30.00.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 00:30:58 -0700 (PDT)
Message-ID: <d81babcf-a4aa-423b-90d7-9b4037872c5e@redhat.com>
Date: Thu, 30 Jul 2026 09:30:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] usbnet: cap max_mtu for drivers without bind
 callback
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>,
 netdev@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
 linux-usb@vger.kernel.org, jarod@redhat.com, stable@vger.kernel.org
References: <20260727072304.154608-1-lvivier@redhat.com>
 <20260729175218.15b5d081@kernel.org>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20260729175218.15b5d081@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/26 02:52, Jakub Kicinski wrote:
> On Mon, 27 Jul 2026 09:23:04 +0200 Laurent Vivier wrote:
>> -		if ((dev->driver_info->flags & FLAG_NOMAXMTU) == 0 &&
>> -		    net->max_mtu > (dev->hard_mtu - net->hard_header_len))
>> +		if (dev->driver_info->flags & FLAG_NOMAXMTU)
>> +			net->max_mtu = ETH_MAX_MTU;
>> +		else
>>   			net->max_mtu = dev->hard_mtu - net->hard_header_len;
> 
> Sashikos point out that this will causes issues for existing drivers in
> both directions. Some drivers explicitly set max_mtu. So we need to move
> the
> 
> 	net->max_mtu = ETH_MAX_MTU;
> 
> line before the call to ->bind ?

So you mean like my v1?

Thanks,
Laurent

