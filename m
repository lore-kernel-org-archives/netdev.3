Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819144;
	b=UXMz0OfGH1rSinm1ft5x2rk/w9Qp2NAujNiulfGcu1Ob2axQn3uh+GVcUueZKivvUHla
	 iqSNxibl7Fajye2iHghgYsgJJTleIGv2/J5xNyRVyKCWy7j+MDIsAHiGsQrJsYez+Vk9b
	 8A/KGdVvFVn3b4SezATAYVdPKbs8jfMleWNN3X4gTdoOhpTzge6XZbjLjqUPiuQG3rH7V
	 7shn5IP0mZX3Tg8FbOvo///2O1zSJbAM8YSt0TL6iF0uWjeAXA0UWFmBwVGsmJ4r5dHZW
	 muEtua4umBpif+QWEMbOp15CuZ0wgUva3Fsra75VnGl96yr0AL3SO5MPXsPyrEa0jPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=O75HJWwF/RnbUopgDHMkFvMSL8L7W5xVT0WXc+61KCU=;
	b=uApIJY2vfjfUYO4ZCsdJZI/aES+A5vCodCukmzGoV+vzSMnj5J2GJrks7f39EEOt7Hnw
	 qtP72ZCAqUEn4Cor3Lhn3DrCwLY9J8j+NaAYCCd/1nuOiWFRRX1q7UYxTrkv27+5fRRi9
	 S2W1WcOFY4cGEK8fK8X5pRCaqECSVZ/E2FYNktHGsowDVHEelMgjIJNrzcyFwYbAhxxwm
	 JOzvkZzuj49PwU+K9NDO9t2NeD3OGan9DVrQknMxsUrq5Ge4OLxmIDTZrQjyxoZ2DD6VX
	 NJ31CVJhZmhRX8v2SX0oEDRkMYJLXKFqs6Dq9reOvByJnc90L4I2M2UiEBWgMxn363w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MEtdHqB8;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE8606D810
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 19:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CACE8606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MEtdHqB8
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1adbf62dd31so1500858c88.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 11:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793819143; x=1794423943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O75HJWwF/RnbUopgDHMkFvMSL8L7W5xVT0WXc+61KCU=;
        b=MEtdHqB86xZ2D7eNBZrPkkUQcehhYt1vPlaBX3c7MZ1SXry3ZhhPHQVsjY8kr6Xajv
         hV2sEdfatE7yUMrohim3sPyPbi4k4n888A23qCb3SBVkB4DWEMLQmKjehPzaoEML5Dy8
         VrlFoqQkAVO5hzhEEOP/H9ZtPWPtsuJtgmPImqMQiFtueU9094P6YWLhaJ+93wFsvi0s
         0vKHBToJtstoVO94e5vCV0eF1/9iJ/hgLbmJYEQlNCADZrNikyfUaa0CBP3sDFB3yMx6
         2Z1vqdwM6yAnaw/vAwoZhJ0JZm0Au+ONlenPwfXhJ18jiA2+9ki5xfrYFJVBtfbc68Hy
         glSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819143; x=1794423943;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O75HJWwF/RnbUopgDHMkFvMSL8L7W5xVT0WXc+61KCU=;
        b=bKjO3tmOAyJP7oqabF12Fp8rd32NVhaIsHlP6opTKyAg/j8XrlImYB2qtM4JqcXlBw
         MskGtFFvy0OT4exfvkw+elOKSsRQ7rEL6cjCH98b8Ms+JYkLH4uSE/tXoTdAht/KV2qO
         rBs/ZOrDHGGg1lUuKkFaMozCpQPHWHGDAHkvXfKl255gWLaQY4gRKj62BjhW92/jHvSn
         BLiiJknS4POe6v1QaP1Yklm/jO/fwtkDSUWgNf4FTDBT1jmyFomZ8dt27rZk2mjxjR9V
         bwwwK+w++x26TEFBpruFPJOV6IGn3cpHsFH9OJWhfmriA9SsvTPLNtD/gOtGjwmnyWUs
         xtxw==
X-Forwarded-Encrypted: i=1; AKwUvBydVmRVf/tP9EVi2vdCXQtw7Xm7EOzERbpZvFgklFzcMuINm0PuP242rDmll05700WEqiu2WRQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gZWPLd8qLbfdicsxX8zSnprNUfVP/MxxwBce3M/uxYSqU2b7P
	MekvcfoRwmtqiNVOpcRntMcn+x7vDs1a+C/UZyHnIQWPqcUyKPw4N+sl
X-Gm-Gg: AYBFou29mIaQCLZu6Lqwlg8aSQ2YoMaCcvKGXfzzes3LJXbRLZkB+8y5OzvvS0PSHqc
	0PPricbPVbesQAaVxmVFl+ur0+05gCvVzB20CjWLjG37BQNJi6JZcQxVa2WQLE7E+sBoa/k5O72
	C6BiUzVT+pVtPYJjcN+hac9ne14Rmk1f3Mzkp379C+rzHErYoIgvKKoKI24m7NsfUcVxLKHX302
	pKvV7BNNB7KZQiDsCVQYhHDCHlmh5bTdPYQWa4v4VyD84RT6b8kdDF4mEvmE3m10IHl5V1vXzIl
	IGko9f1qkeO0unNIDXDpYqC1NIfyU+XQeEJtgOP7S6V4XJFBPV2onFh2WyqLujCwZZ7yY+LTc28
	5tN11GtKGvjAkH7F2fjMyeJaCQ4YKkL+giK3w18zdsGw+254xkTkds4yfC4Yk3/1vm70MRut3Hm
	OtKQAAMMFQsIuDoA2G6HtEcUJKbm5/mIB+XCjpGwReolVHnX2ExxMfielThuNV1fv4MAtdYhweH
	hZjVR74cF2raPCaPSbuxmXYEMqkMQ55HKB/qxKC3XQTUOinmL50pNjJg84qMECvdF/9+mc7yGst
	PQfcOrFj/5s3piBc+sfsbFAx8b+yixyU0c+/gPjY5lDGPHXoFFuyFU8Rn9V4f8ynB9gAgReBAOM
	usQRx
X-Received: by 2002:a05:7022:1608:b0:185:4ad4:3d15 with SMTP id a92af1059eb24-1ac56302329mr19046948c88.1.1793819142508;
        Wed, 04 Nov 2026 11:05:42 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::5:74b3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2d69asm8999881c88.11.2026.11.04.11.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 11:05:41 -0800 (PST)
Message-ID: <aa4f18b3-0628-4f29-8e12-894e53adacea@gmail.com>
Date: Wed, 4 Nov 2026 11:05:40 -0800
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
Subject: Re: [PATCH net v2] selftests: drv-net: pause: Avoid cleanup failures
 for unsupported link settings
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org
References: <20261103190622.3981970-1-mohsin.bashr@gmail.com>
 <4f90c4b1-98d3-4e98-bcfc-d9f2d17b4391@bootlin.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <4f90c4b1-98d3-4e98-bcfc-d9f2d17b4391@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/4/26 2:57 AM, Maxime Chevallier wrote:
> Hi,
> 
> On 11/3/26 20:06, Mohsin Bashir wrote:
>> From: Mohsin Bashir <hmohsin@meta.com>
>>
>> pause_setup() saves the initial link settings and queues a deferred
>> restore. For devices that report forced link settings but do not support
>> changing link settings, this can queue a restore even when setup never
>> changes the link. On fbnic, the deferred restore returns EOPNOTSUPP and
>> turns pause tests that use pause_setup() into cleanup failures.
>>
>> Fix this by queuing the forced-link restore only after setup successfully
>> enables link autonegotiation. Keep pause_test_support coverage for devices
>> that cannot change link settings by falling back to forced MAC pause on the
>> current link. Run the extra link autoneg on/off checks only when those link
>> setting requests are accepted.
>>
>> Results on fbnic:
>>
>>    Before: # Totals: pass:0 fail:4 xfail:0 xpass:0 skip:24 error:0
>>    After:  # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:24 error:0
>>
>> Fixes: cbd8a536cd6d ("selftests: drv-net: Introduce a selftest for ethtool flow control")
>> Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
> 
> That looks better, this patch ran on the netdev CI and no regressions on
> stmmac,
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Maxime
> 

Hi Maxime,

Thanks for the feedback on V1 and review of V2.
