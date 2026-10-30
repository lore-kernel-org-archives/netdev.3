Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385548;
	b=polx9M7ee/N0d4pft0BgOeqdju0ExxD1VovT8vO96KdpVfocH5Za6sdy5uJdfGyTSd08
	 Wfvd09oZSXdI9AboroP2ZrHSTjTCIR5FlVznuyyP3VB92Vvn/hOnJd8/naWKMQZMUk4mj
	 N5wc6kT1E7ZTxJ4W8pxuAy+4vBV0Tx28VUyLQwPy7BbFeB+XNd/DDN5QTRogl91f6aCET
	 3NaHMFlRFthVlC0689ShEVVoRSGZhKjWUJ1nUWG7bMFs41aec+aa/AWbqSKskvmXFoPtE
	 wcHU73imc2ENuXFW8Be18iMXOTElu+5xzNk8W6BdZAFmcC1FSb8RcwJduzaeZpxqZnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=cM+BvkDxP8fM78hQZg5AYrn5YUAQx7WN9vYLoZ70OUo=;
	b=1ZPFcoJPq22ZjJRVm/MxNRqNLMkJe1d3FZKWhJywTN055F2+J/XbvKlh6uQjMIyB7ZmC
	 vNxbSNWSeWztgjP34GbhImNWibMm23bQl9f5YIu4sPz3ZWJ7GIwuhAyMRxCABgfF6Gyzt
	 9lO11K3UpDzfTv1koYRaTI4N9hWi+iDKR7RxxFQjGfgwca5V/IUvVXT64cRipqSm5A5ZH
	 OjgglEeiZWx6KcRvc8QjZWZ9eVyH7jdTOnObzQnZ4WVvDpEo+bJ1ruPNXOiXY8TQjET5A
	 n0HSqWFDWv/0EoCkNfmBLaRLEMtANpAkr581QVhKVnFXynrMhHJ15gS2SgkhDk0n27g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t0jDxw+g;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794BF606A31F
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 18:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 794BF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t0jDxw+g
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a3c08d6928so1338461c88.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793385547; x=1793990347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cM+BvkDxP8fM78hQZg5AYrn5YUAQx7WN9vYLoZ70OUo=;
        b=t0jDxw+gwG9FlkDiEEVKvJaGAMnA0fNNcq4vgNLzqnEQ0wgefhM8hHDjvJHbU4urig
         ZK/LbzZbDDXFxa5we+5dvRUq34ibd/Er8cHs3w5LD2Cc6ZnLoMubT9It4w7KF20N5xY4
         itU//CqLRqBco9eTk66evHlYiF0s7qxOhR8cm1Js5PMWBoAT6KS6LYbAl1EKBW2is0IB
         1hvxsNSEXCXS+Cf5IZsGZWIoongcTVYTGGsIJ+KrgT8eDM+Ylb29+k0yvtbpGPAGwrAl
         SDQVoEbP+vAn4gtgCUB0JeUzIR99YqVXZTy+YbU0AQ8TI2VqBAgGqI1Cof9PYQGgOwLA
         D4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793385547; x=1793990347;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cM+BvkDxP8fM78hQZg5AYrn5YUAQx7WN9vYLoZ70OUo=;
        b=pUcUoPQfAiiOEPp2bKOPIQzNiE03exFK1jXmYcGbLI1H2HJ8G71L+x7Cbbk0EKBQve
         fEqv16T84tUNFXPWLf2t+hrHtmKq4Dkha2RV+C+xjyrFYGIBcwCxMoGfRyk/hT4OXNrL
         YunzLfMWG5UobnbLa5psNN7pPblJbERdqiU6yDUaHq4Gi+W5sCxaCH62SC69roLLKFmT
         kZrcjDaCtgwLv5w/MRGC6++Q3a5uAqJtB9ryQD/YvWmbu3SYyUZ/XYRaDmqVt8BVyS1F
         wH1UtHnFMdPhlyVNSq1a+EVrK3iK4SncrjEA/Ka0fSBIpm0NYdea05GBKOw3B0Cf63IJ
         XVuQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZACAGTbXvrHyNDN5xjsA5LstkTFxJssNJrWcc2yu+pgJIMXPgcDPapDmHynj8i7HB/dZeYus=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzXQpefBO/PDIr8veWDo0BWsxwUuwESoPf/1Y7tLTb9zum2FQI
	qK3i2AhpyvaqKrLe7KP/0NRve/dBJJ/+w9hYM5q4AF2DTiCOUbO8vw04
X-Gm-Gg: AYBFou3TxwGBwm8jv8pJDhvEYGvUrdPpfiwHxJinLL09hXDcqyzBRatgP61nV6Hx4fD
	UM8RJP7oRmKZqbP5Wn7uBq//TX00IK5U5SoNEPXTFy1L5r2qCPv4I5mD1oEClgJ/r2M4dKictFV
	+qR7uTTN3hlgrxdbA3sXKmiWLEiVg39krTotaZ+vH64POg15dCwkQe/adQVIJElf5bm4QLatTqm
	4OCiNOKdM4Nv56+FKgG4tmDNhvn281UWMR/gOUNcSosQwTRG0NlkS1/PYcLjiSQX3zz7L+yacFk
	eQIo2Ntz8ZiP6UaIL1E7gAqP1LkZUSCFqnveTirArLBf5aghwGXfzOZ84YLmYurRtsQs8lBa9Sg
	7e0izGcLFXWLbyfugEQ80qzNu70iDBZbcD5qNzPldLtZ05a6B1oIKIPS6TTw2uT4kcqm1f8VYoK
	tHy/JOP1IsukzCsP3ws77egCcbwZkbzPTPjiT0Rn3vVjXCfBHA6t4iNZWy2zXYVvrcFYXCU6wYS
	1rfLjy1BT02WnZQyf/W4rEbkTs6ecbHSS2l6NbdcVl5qvbw+SBeKOaHF1XqwTrVKPlmWB2ewCa2
	ksU8fIiWmQ5XCABY22EiFE4FeirnU7GP2gYBr6JK/n/B9F6nxKYgF5dEMRbFYRQHMr+shG2ofdl
	1
X-Received: by 2002:a05:701b:4213:10b0:1a4:fac9:aeee with SMTP id a92af1059eb24-1ac56d95c0amr4153882c88.4.1793385547176;
        Fri, 30 Oct 2026 11:39:07 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::4:2e7d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac194b5437sm9886300c88.13.2026.10.30.11.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 11:39:06 -0700 (PDT)
Message-ID: <7cd99851-5bc0-4db8-a44c-a664c3f824b1@gmail.com>
Date: Fri, 30 Oct 2026 11:39:05 -0700
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
Subject: Re: [PATCH net] selftests: drv-net: pause: Skip support tests without
 link autonegotiation
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org
References: <20261030173516.1002250-1-mohsin.bashr@gmail.com>
 <701c6f7e-e715-4647-bddf-48a1485afbe2@bootlin.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <701c6f7e-e715-4647-bddf-48a1485afbe2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/30/26 10:54 AM, Maxime Chevallier wrote:
> Hi,
> 
> On 10/30/26 18:35, Mohsin Bashir wrote:
>> From: Mohsin Bashir <hmohsin@meta.com>
>>
>> Devices without link autonegotiation support may reject both link-setting
>> requests in pause_test_support(). On fbnic, all four variants then fail
>> in cleanup when the deferred restore of unchanged link settings returns
>> EOPNOTSUPP. Removing the restore alone would report PASS without running
>> any pause checks.
>>
>> Fix this by calling require_link_autoneg() before pause_setup() to skip
>> the test when either interface lacks link autonegotiation support. This
>> also skips devices that support only forced link configuration.
>>
>> The issue was observed in the fbnic CI/CD pipeline. It was reproduced and
>> the fix was tested on a local fbnic device.
>>
>> Fixes: cbd8a536cd6d ("selftests: drv-net: Introduce a selftest for ethtool flow control")
>> Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>>   tools/testing/selftests/drivers/net/hw/pause.py | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
>> index ca4a55e59c30..1537f88e0e77 100755
>> --- a/tools/testing/selftests/drivers/net/hw/pause.py
>> +++ b/tools/testing/selftests/drivers/net/hw/pause.py
>> @@ -466,6 +466,7 @@ def pause_test_support(cfg, pauseparams):
>>       supported fields.
>>       """
>>   
>> +    require_link_autoneg(cfg)
> 
> This helper checks if the remote supports aneg too, so it's too restrictive.
> 
> The goal of this test is to check the local device's behaviour, without too
> much dependencies on the remote, so that we can at least have it test some of
> the local driver behaviour even when it's connected to a dumb remote or a switch.
> 

Right, it may be too restrictive however cleanup handling is still 
required on both interfaces even when the DUT accepts the configuration 
and runs its checks, the remote can reject the deferred restore and fail 
the test. Ideally, this test should not depend on remote config in the 
first place.

> Maybe the sane thing to do is to allows the defer() calls in pause_setup() to
> fail silently with "fail=False" ?
> 

IMO using fail=False would also suppress genuine restoration errors when 
settings actually changed and can leaving the interface in an unexpected 
configuration. No?


> Or maybe a bit more clever, have a quick check to see if the device accepts
> an ethtool -s XXX command ? looks like fbnic will refuse all of'em as it
> doesn't have a .set_link_ksettings.
> 

Yes, checking whether the DUT accepts ethtool -s is one options. We 
could reuse the existing autonegotiated and forced-link attempts, and 
report SKIP if neither allows pause checks to run. Alternatively, we can 
add a remote arg to require_link_autoneg(), default to True, and pass 
False for this test so it checks only the DUT’s autonegotiation support.
