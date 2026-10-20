Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484001;
	b=oD28BEP4BeXNHKrCr/lmHGygEptPoA3EdtO4cFZAkWgqtSUsGUzyvIwaD84YFJ/D/Eht
	 W3lpxwfnU75LRrxfWYyZL+5BCr1IkrY/+rOs20Pd/QwQ1CRq9ZhuGaq6I3DODtdR57CVw
	 TPPGjkZ+kXvZh7B7xPi2SA+QJVf9pd/Do+LXBD7MYincCB1V5czLjQ7tSQou7ecr21FZh
	 jSOQNxVWjv/vc8CsSMFh2ltNW3zhaCZMxOr9OoRMBvQjt9tab1Wq1mxEY0JREnu004JDg
	 76YNdpNolJhH1bsYzz1IVy5yD85IC7ZGub/+4vm0xDeE75awZIXznn38rvsKPh+D+Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=sifT94IuJdm+evFSGgUtUBWt/nlaaaYHDsDEfF5nTj0=;
	b=ZDymnIClWl8eGLnsSrDBVTvusPyRLP15TPZs9AileZbNpSq/RSEXWfAp2gf5l9GF7J/i
	 nIIiVG8YFaxChDSqHGiNJpq1jUUAnPuNl8osGClF1t2UnodNx1uxpN+Mwtv8B5/kh5RwD
	 0AqeozGE51e0nlV3jyundAZ1uO3nPu4GWlN3rThjIAJmremxyN3VF5Pg05enk4lS09CjM
	 7Wx/JjB8p+WwTvK+oTUJULUPDOxYjeHMoX82bjluzybo60RUWAyPbH+6QvmOZv8k2O82j
	 wWkaeUoY4PgAnrGGCUm4FcX/HMw5u6ulngAon7foz2G7CqpZH8qbqj5W9dks8ZpSrYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="hep+mB5/";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E84606A331
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66E84606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hep+mB5/
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso33826525e9.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 01:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792483999; x=1793088799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sifT94IuJdm+evFSGgUtUBWt/nlaaaYHDsDEfF5nTj0=;
        b=hep+mB5/rzIkpFTWECjY//gRKF5/dPu43U4EeiM7sptRr+nzRHVuGra7s+DAmavJvO
         43XfOCWTBTAMVRmX1gunxl0uMCN2VFq0EMqyimdkr1AQacZhgKLWoNsHBx4o9ex/Bih1
         hw7PbRz0e76GmeIFMyk70RWN4+tGEgHvEzdbxbnPisPwbDho/Hja22ces/QWrrDlPvaK
         pkWTvquTI3EFsYebuaGPBXtka9PtOIMqjJlMuSGwwezSgfrbnp3Y9J9H1sVbj/biwJw/
         y3ZcRM25GpoLwmAkPgH/E0Qh9u8n10GY0hWvQGrXzY5ND7XABJh8+ARDnlL7Gkn4vs71
         /ONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792483999; x=1793088799;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sifT94IuJdm+evFSGgUtUBWt/nlaaaYHDsDEfF5nTj0=;
        b=p/ZRKBe/APuE8PNG8OSRrE4QcAyz9AlyP2niHs2e6zqCukubqNF/LGEVPpDfppzD0q
         JHC87TVhgErxoBaHjHh7VNzBwoi1M5vhaxGwDMs6+gcy9jmg3qTz/M+xmYAZLMoNa/f0
         7oSFjm6kAlgfnkPiqGUm7xeqoOKV+NAKvKqkdlQJnBZlO3vFtFtJx+fDSO01Yp0+dybR
         UTXESh21IR6XJO6ZI0y/1L383awRH1KfuFec7TnGzhCH9JTEwQozdwYxn4bVk8ikOoI8
         1VRVpxA5Sw1w8XTCYmxnTG5Y98rItHkpbHG/M8O3kB88fVusIpsXxkiQJKBQnAkNS2JJ
         RxpA==
X-Forwarded-Encrypted: i=1; AKwUvBxN9HaglSHS4JF+77xCpEYbFtIJugPNtyj7yjkJhjbBvol9ol2najamhtTwOdMrNRczw+Dzr9k=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6etu4ySGEWMwaHbJbyt0a5/3X0+3MC4Feu1vna/zImJOzF1V0
	TY0FmS7Wj3ctvsNMOiEkdE6DE/XNcqyg5xgyyY8jP/QCtMgozMqgZa7i
X-Gm-Gg: AYBFou35nrUybauCEgbGTYU3SEySUW2nJ3HDMHvPtsQkAowSukGLJUhhmAiGFrLlvuV
	eBvVJgmE+dd19s+TO8NbtpDWHjubVKuHPGBp57gIzb+TgazfDfMEaIlYSeng1z5Wy2lyZ0UoZ7Z
	99p9z2PgLGeqaykVuBtWmX9PCFekb1ns9pfdYkcaiURHLRoQCZm4L1CeQMZeGanchzHU4iF8AsV
	dBWyAehJcDUX2N3XXU1tU8bo0iSmC/vy9GFQ3JMNhDiyBuwPR2A1bBY7MFAlk9F2558b5SBfldI
	LjGXIJ4eF4QnEba7S4WifqQQIn+/WMyR9W+xD7cHtARos9X3cQk9juFJPZrlwPyc8o3y+oHHZY+
	OtIfOfAcCQKSz5USsp3203/01Ygo5d/p+d4ayeVVKKJjbOpck12PDH6F/aJG5ysssDzQahXNMAG
	NxVG23kSUMxV3eJlETCaE1Ngw7r0Yl4gJdL6mPnuXu+AfzIpuK1i3CyslYSB0lYhgd9yT8LkEyP
	BKy1WpTS0Ifp2pB+2ItdVv57kOlernEjtTX8SiJ8VXW8xDxDQyVIniYOxxuQ5iBhWsMHUa+
X-Received: by 2002:a05:600c:1f83:b0:4a0:27eb:49b with SMTP id 5b1f17b1804b1-4a1d761b900mr213796785e9.30.1792483998516;
        Tue, 20 Oct 2026 01:13:18 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f117:a001:5c30:2c3c:9609:3456? ([2001:9e8:f117:a001:5c30:2c3c:9609:3456])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cc809csm55072355e9.8.2026.10.20.01.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 01:13:18 -0700 (PDT)
Message-ID: <2f64d2b7-f23d-4c99-ae1d-7404079dcde5@gmail.com>
Date: Tue, 20 Oct 2026 10:13:17 +0200
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
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: pse-pd: realtek,pse: add
 gen1 I2C transport
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Sander Vanheule <sander@svanheule.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261018161248.376205-1-sander@svanheule.net>
 <20261018161248.376205-2-sander@svanheule.net>
 <20261020-noisy-amorphous-jackal-1df08a@quoll>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20261020-noisy-amorphous-jackal-1df08a@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 20.10.26 09:27, Krzysztof Kozlowski wrote:
> On Sun, Oct 18, 2026 at 06:12:47PM +0200, Sander Vanheule wrote:
>> Like the gen2 protocol, the gen1 protocol can also be used over both a
>> raw I2C transport and an SMBUs transport. Add a compatible for the
>> former and the compatible for the Ubiquiti Unifi Switch Lite 16 PoE
>> device that uses it.
>>
>> Signed-off-by: Sander Vanheule <sander@svanheule.net>
>> ---
>>  .../bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml          | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
>> index 3bb32349c28c..526f8525bb4d 100644
>> --- a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
>> +++ b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
>> @@ -54,6 +54,12 @@ properties:
>>                - zyxel,gs1920-24hp-v2-pse
>>            - const: realtek,pse-mcu-gen1-smbus
>>  
>> +      # I2C, raw framing
>> +      - items:
>> +          - enum:
>> +              - ubnt,usw-lite-16-poe-pse
>> +          - const: realtek,pse-mcu-gen1-i2c
>> +
>>        # UART
>>        - items:
>>            - enum:
>> @@ -100,6 +106,7 @@ allOf:
>>            contains:
>>              enum:
>>                - realtek,pse-mcu-gen1-smbus
>> +              - realtek,pse-mcu-gen1-i2c
> That's the same device as smbus, no? Same device, same compatible.

Physically it's the same device/MCU but the baked-in firmware and configuration
differs. Same for the UART vs. SMBus.

> You can have property deciding about protocol, if this cannot be deduced
> from the clients.

This was the approach in the early versions of the driver when I sent it
to the list. Rob favored the current way [1] and I think Conor was ok
with it later on.

[1] https://lore.kernel.org/netdev/20260615212959.GA1679454-robh@kernel.org/

> Best regards,
> Krzysztof

Best,
Jonas
