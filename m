Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691430;
	b=HYD9687W7Ag9/EnBjiRMJd9Wyp0op4G9VEH6bEKUC5pYFEe2Lq4ioAKS85NTXg1e4l8G
	 C7R5jHJAEx/hEx0eUTL8st8Er20eLgnpKK9SzwR9FWyQUx+QR0RewlmaUgEVO6XsvAyVS
	 pKPc6FeMr/cdm513EKVXB1FwIn5eN3rJF97NHztRZ+ikhy0eeyb0qVO6yozD5YMxXWdJR
	 fuZyhgtX9athlVz9ONrRYMecQproHyVAHfiiwjFA66a9i2IsAj44OF6pDmUgLLbbOtcmM
	 XjOf95oUCnUHUcqPYNQ/J2hG0ZeOJC6hnkVQ7aeAL6/5q4t0ZUreMvJ3uOiee7VgJfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691430;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Wd3oLS+dcFTXkdvGEDZ+0YYIQNbTTyKN39PEruh5N40=;
	b=Ly23+b6t1LwRvbbHxmsHyGET5zIuKWTZP0Bedm46K3z86CbITlhTuiasOWxUZAXGBMMP
	 AcwDdFyy1Wagzl/p/Ng1pR0LW66lMyOQodZNFT5zkvIW3g0dskv+nf3m+uvMnMB5Ec3Va
	 bP4RSgsLLYIr0kRE1MTpdPxozLaWJVpmW6A3wpI+h3KJWKCqbiaEytcUBTJVV83Mfm4Ia
	 nv4QJsyBqME11Qf107Rm8yrtqYrZn9TeWm/S4BWwQGfSTDzgSbcZv62yLht/PldOF33vq
	 m6mEeOWZTavxFd8PE38pHRy0HZv4jUyj9AX3/uUSUrYxHTS30GfZDi9E8Ca6p45Xq2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AD4606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30AD4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so34206f8f.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691428; x=1793296228;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wd3oLS+dcFTXkdvGEDZ+0YYIQNbTTyKN39PEruh5N40=;
        b=PMxJ2VVuS+I336204T5ETkLQOvCvMeBcsMKksQGNCHeFEU6JK8DCZJrnYuzXgA1b2L
         B/5VcYa2ZFd4UACiBcU0Uz4BzZzpoJ7dOOUwqH4Zh9Bt+3swTL+TtwNY+U8axfvbrSK7
         nYIL+UyKwtoalSlDQi2t1Qv9JIZH7TBOx5HpiWTGxdM8cJTbY7tYOwQuwHT3u4QCFD7s
         +cCa35JmVttPtUPsgm3VpCVUi82chaRDMXrHRxNX5R9bztlGI3jZy5aPHnCBdM2+6p7Y
         SE0+kmOP6uWFvuS4Iz7uF7K4v7YE0pZSn1uxgWYYybstogx0brynMSuHW0PUd10tlTCS
         GZ1A==
X-Gm-Message-State: AFq9FYKf6Au78dSmgPk91J1CwutFJO7EHvSJhurgSAvJTokSBtO5vWDk
	O+0C8vqFY8aJPk9/0sBYOJ6Vrxgl0wICvs77FOVMvaRhGRORZJOquLnY
X-Gm-Gg: AYBFou2oj34/Qqel8br4MmzOGhKaRoJZFswE4ogC5laNlOuLaS6fcKtWdxKWqu2/u0/
	4J0a4w3Uiq9PLFITdZEhVjkgYg80+qBkgr4g1ODgiC3d3ce86/1GQCr7TFZvw/ovDCle1WxXPZD
	vEWWlUAfO0oyY3B7gx6krAsfeMV7FxDT4UdpuHBuefAm/a8504HZLSgQANHG/e/b6y+7h3A33p7
	5pqDEZjwREBJWNCVGlne9t8aUa5IKg+oNxNyYUjj5I4/BuFcLdxZWXcECXJAyXEaQNo0LLaFfmk
	RialOFEwSDBXRQ2VQGXOuqo2J1zFebNjZFDjykTK9ss3VF8X565CnBBZWGQg+MgIpLuDiCOlkYD
	nZmdjy5rtUeMrAza9ou7/V6VePnh6m4R1cL40PnaoN7jRQKy/O0TA2OXhFioLviUojoGiSl7rxj
	SiHgBoQIMWI8oY9D3ceBIkcaa3nd5VLfUuOB9zE2OYfdQaBP0acVhb/+nadlhLWuM+hyWzmqNj6
	IoAsbEmlv0PQXFDQg3iTLsrlVaB0a/0eNoyUNx6PuAaAPnZ3Fkiqj1pe8pglLg4OY2u3iPqKcnn
	ES33VBDSLA==
X-Received: by 2002:a05:6000:1866:b0:48e:412:37f4 with SMTP id ffacd0b85a97d-48e2641de1amr14015136f8f.1.1792691428424;
        Thu, 22 Oct 2026 10:50:28 -0700 (PDT)
Received: from [192.168.1.135] ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835247sm13834966f8f.41.2026.10.22.10.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 10:50:27 -0700 (PDT)
Message-ID: <c9d2b1dd-c733-454a-9281-80787f5c432e@linux.com>
Date: Thu, 22 Oct 2026 18:50:26 +0100
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
Subject: Re: [PATCH v3 8/8] dt-bindings: net: ethernet-controller: tabulate
 who adds the RGMII delays
To: Jerome Brunet <jbrunet@baylibre.com>, xianwei.zhao@amlogic.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261010105900.247342-1-tanure@linux.com>
 <20261010105900.247342-9-tanure@linux.com>
 <1jqzhu9in5.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <1jqzhu9in5.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/10/2026 08:14, Jerome Brunet wrote:
> On sam. 10 oct. 2026 at 11:59, Lucas Tanure <tanure@linux.com> wrote:
> 
>> The informative section explains in prose how phy-mode, the delay
>> properties in the MAC node and the mode handed to the PHY fit together,
>> and says itself that developers often get this wrong. A reader has to
>> work through several paragraphs before answering the one question they
>> usually have: for this phy-mode and these properties, which part adds
>> which delay.
>>
>> Add a table that answers it at a glance, with one row for every
>> combination the properties allow.
>>
>> Assisted-by: LLM
>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>> ---
>>   .../bindings/net/ethernet-controller.yaml      | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
>> index 1bafd687dcb1..bba27a9feb61 100644
>> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
>> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
>> @@ -339,6 +339,24 @@ additionalProperties: true
>>   # has added. Failure to remove the delay will result in a
>>   # non-functioning link.
>>   #
>> +# Put together, with the two properties in the MAC node, this is who
>> +# adds each delay:
>> +#
>> +#   phy-mode    tx-internal-delay-ps  rx-internal-delay-ps  TX delay    RX delay
>> +#   rgmii       -                     -                     PCB trace   PCB trace
>> +#   rgmii-id    -                     -                     PHY         PHY
>> +#   rgmii-id    present               -                     MAC         PHY
>> +#   rgmii-id    -                     present               PHY         MAC
>> +#   rgmii-id    present               present               MAC         MAC
>> +#   rgmii-txid  -                     -                     PHY         PCB trace
>> +#   rgmii-txid  present               -                     MAC         PCB trace
>> +#   rgmii-rxid  -                     -                     PCB trace   PHY
>> +#   rgmii-rxid  -                     present               PCB trace   MAC
>> +#
> 
> That would match how the HW is working on the A733 Allwinner too but I'm
> not entirely sure this is what Andrew had in mind from our previous
> discussion [1]. Adding him to the thread
> 
> [1]: https://lore.kernel.org/linux-sunxi/491f043e-6dc6-4936-a490-31a3362c5b6e@lunn.ch/
> 
>> +# A property for a clock the PCB already delays is not in this table.
>> +# It is either the fine tuning described next, or a mistake the MAC
>> +# should report as a fatal error.
>> +#
>>   # Sometimes there is a need to fine tune the delays. Often the MAC or
>>   # PHY can perform this fine tuning. In the MAC node, the Device Tree
>>   # properties 'rx-internal-delay-ps' and 'tx-internal-delay-ps' should
> 
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> 

Thanks, But I will drop this as it is wrong.
Lucas

>> -- 
>> 2.56.0
>>
> 

