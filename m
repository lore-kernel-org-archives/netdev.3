Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618038;
	b=KKMArWT47a1IYB6F58gl0trWHFil0W480sTe0tbUaKgfHCAi1XrDqvbxbl+u6Bf/x7af
	 3/WSazBKG3c+H2OAOzAO7kQ1FohmbGHpU8GBUIxqmMOGAWJPHA3/cuGGlcFD4l1MTbXxM
	 xm1G++gVFPAT8d0N1iclJ8RwH6Y6qonypZYCyZWo8KdCo41iYVS75mt9aZrGHh6DQHTfE
	 zeeAj2Ywlf0ShC/HFCRQEaiclWyXV1d9CH8BDubj4R5mGgA/XbhZ9kd8i6wDtdE86Xsou
	 ZUB0r78dcVexUwfyaRWbR10OQdFclv+NOjBA0+Se7a4j+viK425cLLP1zZlZ4gjncEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618038;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Content-Language:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=h+I3LtM6P+LAFl9v+KYyeWWoy/hE4cVBV0T3IJSyatk=;
	b=qyTmrBH4BhPGuT+cUkIp1afiZa6Z6VQWScSWih6mmHtANTMRa7IhQ3LfZW1yGuiR+wed
	 UQkbgXXjvSgrRmZjPgJBafcZtoEQtcSLZH3PvDl+9+mzduKKn7FMPyP3URtGNej74DCPo
	 9j+W2JlqSDnmd84MnqxG+yf0PH1NstjIK2fTBalsfELQ1ZHaODy0D922Q1nEgXTH7IMtO
	 2CjiV1lcIck6LuiRNw6wOJjbmfi2P3Ad7aDC1zZdegHz8QvIFjMSnpf+94IrtetZ1MBYc
	 CFob08pWubsyQ/ScjvYEEa/B2fcAv71a+FsDRaXVMUusR2RiSMAjkW14Uq0BHO41SQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="gJ/3zJ1N";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FL15cLR2;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5003606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5003606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gJ/3zJ1N;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FL15cLR2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793618036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h+I3LtM6P+LAFl9v+KYyeWWoy/hE4cVBV0T3IJSyatk=;
	b=gJ/3zJ1NP00v5oi3cUj4Wpvdw8AonhBA0Ua0EXrl5DRNxsKMWDSL2k3j/COiNidPPJvfRc
	uDLEEQwNhcXVoKWBfP077L+UZPi2u0tnbdv2G4uHGsIwFk4KAKfuzT18Nbw065wAjUiPKq
	VUUEVyaIwVOgokVgsQh+YNfAaFwG/ik=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-fTSYiCjQM2uvWuA3J-0oJg-1; Mon, 02 Nov 2026 06:13:55 -0500
X-MC-Unique: fTSYiCjQM2uvWuA3J-0oJg-1
X-Mimecast-MFC-AGG-ID: fTSYiCjQM2uvWuA3J-0oJg_1793618034
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4afef353dd2so12612555e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 03:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793618034; x=1794222834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h+I3LtM6P+LAFl9v+KYyeWWoy/hE4cVBV0T3IJSyatk=;
        b=FL15cLR23DV05eTI5wAWJLW6uVBYbE+tJh8sdZT1ijvCOZruKIpAiPOYJM/gtykCkG
         SR302sfZwrGfLP7Mfc5MQjjxh9n65st5dWV8kl7TMNKT7puzXu6MRunkS4+7vhxMYdDy
         iGNbApRPHoWSou4MXemQ3AlpIFBuy6GUK8+1fCHEBshw5WQm1pAHm1skHdsK4C4tAwF5
         0ZgL6xA8Li8FlB16p/2amQ4lL6GAncSDF86wY6I/Wrw0gLzLn/RbXxZx9n5H0jt6OrsR
         D5r7rhEviSlULFZuDiUYBzQeGF5gJpUFgx22vgDYifza1VBgtpHA61D7lfGoxzNZelKx
         oruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618034; x=1794222834;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h+I3LtM6P+LAFl9v+KYyeWWoy/hE4cVBV0T3IJSyatk=;
        b=GXOrom/DlasqWHbbJr4VW0x3eh78uHC/t5RN0dz+8i/y+i/gZyEflzA3R0jnQ5SYV8
         RTZTSE1sdJMSc+dA+24gZSQEWPI8yZnt61yFVaeau4Oi10NoTeuRenq3wXPr7k9hRiYg
         2rLnJrhvRUOxlrhIRVMsK5HwH/sYcqAM6UTA6Sf5UMWL6hZs385PTOvDcBgQBqakokVV
         Z2lt5jnX82OtoK6Z9kbyocd4G1kF0xbfOWKTD3U++7y8e6Os/Cjmu9E61Er8E/OnJjQG
         /OkUtaM6GW0EiuUU4o6INKscv33l2KtcoKM0rQaLEdrOuJXosZtNF7VpBmdclyEnscvR
         4sMA==
X-Gm-Message-State: AFq9FYICz56eSjHM8XRcU2DQBjjgW+CQe+Z47YtKB0SOnTmRUdTo3j59
	hDQQT5WYvRz0yqvSMcWcQVa5gCory3vNukVZ6lEvOz10t74snZXF7yURrjzl7jwAi/88rkvw6D5
	06EwwB3H1aVWo6+dVCWrckkr7WJa9WzcUZ2m5Dc3oJTIsWKnRevA9onhzF3u3XSl7QyHXT3V/N6
	ub5OY+vsek85ZgYfACTWvlGQmiMNzYsq8SjMQNH/Y=
X-Gm-Gg: AYBFou0eenGBQIxyFR+mWKKJCNLje18H/QfsfZPae+rawePxqwxAx/1iB0a4yjwoJ5y
	Y82/0+TnMx4Tmt3UYQ0T+DcKY84Ndc8G7wrSmzTjUDX9qg4xtxGb40msc0JKcBpKbjvH+Q8bNa1
	YhQ2fT9OqYY72YfnhXitv9wdZxyh18y81RNdn52sMj2HXoH44J4d79HKsQg7/Xn0CW0GpaCLLVN
	VVRnDNv6xl+k6RcWWRSxarlroKkf6ZFrpS4XHGI+ICqE1cscvjUKJiYhmuQ0iT3BXlSDq7Mh8rn
	nWZxuSsIWuIFodARaxdF3KCkJf29Hq6lSN9yn7cxwpgubZpr84vTuNVRyIguKwfdEAtaQIXnAr6
	jaTvvVaVA7QGA5n5pyCGDfngxWCz2Qi1KC2Ku2eEI8MR0bJ/Wp0F9Mh6kB+oXKxo2GEwQHjfLIh
	xghFmrev6GJ+MJNwDiDcQXvkIZSUqjKjUPd1fnoBhWJhA=
X-Received: by 2002:a05:600c:524d:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4ac18993ca7mr228795705e9.32.1793618034403;
        Mon, 02 Nov 2026 03:13:54 -0800 (PST)
X-Received: by 2002:a05:600c:524d:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4ac18993ca7mr228795085e9.32.1793618033815;
        Mon, 02 Nov 2026 03:13:53 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d295csm337728825e9.7.2026.11.02.03.13.53
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 03:13:53 -0800 (PST)
Message-ID: <66b35989-9195-4e96-99bb-df383a52aa5d@redhat.com>
Date: Mon, 2 Nov 2026 12:13:52 +0100
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
Content-Language: en-US
To: network dev <netdev@vger.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Subject: [ANN] net-next is OPEN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

net-next is now open, and accepting patches for v7.5.

/P

