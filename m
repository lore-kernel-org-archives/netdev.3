Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092442;
	b=4BiutOnVMhPTRkUB5N+pSbhKDaTPFWPeX/ObQCddhACvFAyqV1q7boSAigN8E4n3AwXj
	 2iU6MIQBm6ODYG6meVlzcOYzFpqpQkHYO908hil2MHGcZnk5uFjZnT0wcbQGJQv3rNRjM
	 7jXS5763pZkIM6vXiwfpBycFqWOgQU3oN7I/C1h5iJyaCYURufs24m/FGEBc7/wKBO59k
	 BH+6NoYAGtnNjXF/9UjY1k0ufKWSSHZauP5zv8vEEukkMr4YKADZMAFDul5l52foWQWM1
	 E4V4A4E8Jd3LIDilovqqhKjJrs9CxE2NPFbj5MO4mTCsiLEGT9t0LoRlgWmTPo+ApSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092442;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hJEIcr4Cbco2yvPZ/s/3T8+YR17zM0P3saY8Ui62mR4=;
	b=df5rU6jEnHFHq2PUPs8Rax3oa59QJc00AZqJf5qDRpr3O/AJNQApznHbhO7aSu2Dq55a
	 zg5Fc/LcO1zF83ywaUFSLR0KMGh4bBDD5fG5CVtW+mAohgRUfYLHANy3jdT0wPryL3iEJ
	 XMH2ywinQIXZQ0qBEPNbYYwNKZh0H4ESotIEslDqkyx+5/iGUyPxy2yiChpvTQLhQ6tpR
	 texe6mbjyuly/b/cLTOZxh/6iYMuvRHjwh89gObjgvTdvSpIXbIvLvZp9MN2O3l/XlKSr
	 qKnlJi64SY6FfwIO/OlBOrXLGsD6li1JaugzqSPWOkN8Kr7CT42gmTcX5MwD6v67QuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EK4jpZTb;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Pxu50o6s;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2F6606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D2F6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EK4jpZTb;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Pxu50o6s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793092440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJEIcr4Cbco2yvPZ/s/3T8+YR17zM0P3saY8Ui62mR4=;
	b=EK4jpZTb902wdaebiTvK+UlmwE7qZiaXgD6cq6O7yJrA8qBxmjLQQ8CAyxo02Yyn2pN01m
	SBFufig7c+xje/CYQ5gnXyQr2YsSypxrBF1PGT9THJw/RmuL1aNt5WTYGQyBCEc+GmAyqJ
	EOKbGIraDc2JMA+W4zr8ZZsHeNmc/Ts=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-p5_GYuUnMQO4huIeFNJOqQ-1; Tue, 27 Oct 2026 05:13:59 -0400
X-MC-Unique: p5_GYuUnMQO4huIeFNJOqQ-1
X-Mimecast-MFC-AGG-ID: p5_GYuUnMQO4huIeFNJOqQ_1793092438
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48df02b91f9so496709f8f.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793092438; x=1793697238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hJEIcr4Cbco2yvPZ/s/3T8+YR17zM0P3saY8Ui62mR4=;
        b=Pxu50o6sqI/AzD7BWfZvHPX77sFbK3EVKrvrhTLSZzfIgTLJ1hBJ+BU18pdBvFk8+k
         lAju021gHY105wHmNGkuoWj69OP8Qt2GDaQb+3tbQbRJlM3WAS10JqzDeFzoiA7uBsTq
         Z3iyCuLfkXDWjXA805K7Ih2gwKTMT/NzOYdNp05QlaaaDDGjrBeu5yWpvHjkkRfvscaY
         3GD9YK0qJEVKM64fM9HTHkrlmDn8C1yCtdNdecHRZS9CXPubDV5+dwtEx4fTNNocG0Y2
         lfK59sp67XibVc2cQP1YGA7I3ndh5zrufIlB5HQe+5RcAdGA8L5md4el5AMb9C3JfQ9w
         im3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793092438; x=1793697238;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJEIcr4Cbco2yvPZ/s/3T8+YR17zM0P3saY8Ui62mR4=;
        b=gdZtvnII7eCl5IhhPZFv8MyDzD/czIOSQuHuB2dx7BQrt94nvOWJvZK25UB26FkJwc
         vt9YRFqFt9fWXX4Xmj+S7JW+m7+0kUcRbjud/Px7auQzZxtvPIlZLnoClmQnHtWD53fC
         m6avK/EJ7SaCOHgpr8y6SrwsXq9LDzlrKVI0F61uM3aFmXNCNHFW5RlAFWvGlrLt+GQH
         0giyFvuk138y/RE0PmljIhp3HZMpjLe3Y/fAodHSf/o3TKra7YqsSlyg3cZnkDNX+Bc6
         rSPbprtfsaQbQA7+8S/kQatW9gxqK03Xe9INQv5TZiYf6y7wc/EQlYCRwCy9IyeMwTDI
         unYw==
X-Forwarded-Encrypted: i=1; AKwUvBz8RsijpEpZBuZccPQ7iREUBBp+o54IrLaN806dzVcbQNjr3W9BYnAng3DAWJZI82QlJze4sZo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwnz++v1gOpr8R6198OSY9ruo+PXHkJHjjtqJi5ow3a5dyH/wJ
	1ciYGYDYAOGWjXatDiZ8xz6EFJYzWJxS5xZ//tbmerMnF66QRitZg+k71aL9DWJ8+dvfM0+auzk
	5N09Vu3Fy/Q6+UUGixWiifTrCyH4Z4Xs74PPlmx5hOKEgSb4yKWumuzOKKw==
X-Gm-Gg: AYBFou2ApD/q7V7RFTLOCmEE1kLDUkH7k94Rjw4f6V+JrlVQTEwuGQfO124JXU6moCT
	Apd3sw8TzDviH65vptttW30DFgUAXiqgvyvebSRul33UizQLmlG2Pmj/VGO9z7Esk/oHINYuw6P
	qcR0VB5JS9Zsu/QI6NkHLUyM//Pza+lBB2UwLpa+nLSZwgs1CPmaZ7GExAH132TfEUKmW06bgM6
	hP+cTAGJhGY/euXiSC+zqyJ/gL/MIRb1Nx9z1xlazZCIQkjcRkrqUtvRFmY6RAnUfFvshiaamDT
	q9QSliIVSR7rFOcWzXfRLNDInIV7s+ow7xAuBJBfIZ1hmoCTXn09+zfmGQwGjnfmver/gG6scMW
	uIqf8pdmY14Hn1Xu2BoBKmcDBcNKxAZHNwEvQMzDDTSApex3dpqmPncoDFYNuWTonULuROXJApQ
	==
X-Received: by 2002:a5d:5081:0:b0:48e:d3f:c41f with SMTP id ffacd0b85a97d-48e55a550b8mr3720282f8f.26.1793092437957;
        Tue, 27 Oct 2026 02:13:57 -0700 (PDT)
X-Received: by 2002:a5d:5081:0:b0:48e:d3f:c41f with SMTP id ffacd0b85a97d-48e55a550b8mr3720240f8f.26.1793092437482;
        Tue, 27 Oct 2026 02:13:57 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb99esm20919540f8f.23.2026.10.27.02.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 02:13:55 -0700 (PDT)
Message-ID: <1104cef2-569a-4aa5-aa43-5c42b715a7d0@redhat.com>
Date: Tue, 27 Oct 2026 10:13:53 +0100
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
Subject: Re: [PATCH net v4 3/3] netconsole: recheck device registration after
 waiting for carrier
To: gustavold@gmail.com
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, stephen@networkplumber.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev-bot+sashiko@kernel.org
References: <20261021-netcons-fixes-v4-3-3857120c6340@gmail.com>
 <179293924034.3134.1271340447995228966@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179293924034.3134.1271340447995228966@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/26 15:40, netdev-bot+sashiko@kernel.org wrote:
> - [Medium] The stall the commit message names is still reachable during
>    the carrier wait.
This looks legit.

/P

