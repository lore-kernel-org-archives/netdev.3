Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BF03A3E73
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122809; cv=none; b=VMthWy1qtHEwj/cLP05kiNsW4YuxkURgz8woO0QFEn/Zf0QET0n6l2q3nSl6MV/g4x1Uw/yox3ZKk362cicWUkh2N/g5lWWxt/+gKUoXY1oO26aDYvSg/D/cGVos9t26qFZervRECidVGSJ15bHX5rc0ioTdGPP1i/3vltUGKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122809; c=relaxed/simple;
	bh=Eta09yHf0y9K2CX42Ddir6PtPan1JHP91SRbMGkdqe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCyYSfvXgz/4LlU8vcgrEsd9v3oiNBU2hYblskwGuldQtdzAQAsp2gypRyGpwYrYd0clC+83TCDYA5U5ho+zwnwtZnP2KTwd81e0vNPY+dXnn7nZKFlXEDTqm3M0vCo2aeLvksmLDbE9XPOcqpKpgfHZ7+UNHbBne97TIT5ufZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a1706a2b24so1681005e9.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 07:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791122805; x=1791727605;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VUXvy50bECQ2jjyhstzsZVcApJzJFF/Z6zq/JzULuvY=;
        b=RVB64c7gzLt65Fh2uu7HBaWjuQ/l2s1gNgGA6syDE1BMF4y4nlKATaBopVqqEBue1s
         m+l5Xtn8mbfy9ZKduGHfrwmboC/TM5ZvYOMX/uT7+rlBbmD0rkKsrvxjMj1uv3oUim9t
         ikiIFJRW/GVwKRx7dXw8eTg/a6yEdAtDvkL4/X8NA8LJuL/bTSui3jUDP5p0E0ACdrkP
         sdn8zr+zdUU7Pyzz4373dLnEWYqlvSF2ZONcFwpWj0epgRrUOGZa6Ko+GZrzkAIEQYNO
         J7bls2oQH86bWFejvj/MAOYabZwJ+rmlp6tuXicdjS8dJvRd1mNEW+xi7fcSbAme1HUf
         JpEw==
X-Forwarded-Encrypted: i=1; AKwUvBw7DjhNQjG/nJ2OsC1P+Wew0jx3R2aXaRzyO4e3F0ji7FUiWhqsMi9MLvfJ6K1xXtm4hK5Uy7s=@vger.kernel.org
X-Gm-Message-State: AFuF++n39XX7Mjoi2e8f8Qb7b1joBpxCCt8/TrWtzbozlcVKrSS2jLrI
	B4BB/vu1qXQBxQmyD4YelvUmNbjZInnLfMr040PLUuHKZsg92BhhTzUN
X-Gm-Gg: AYBFou2SbYhVm88Afs1wmgy33gBLjGtbWDNQ3hVwNIdWNMrd2CM67rWx02dQF+Wtlay
	05YVzTzgzoRzn21LyV4RBvzhm2EVUn8N4/r5BwZmEsLcUhsCSuTpdCu/KLvo3tBaZA/xxsxTnyv
	FSDWZaRjYnbjakLU4gtwa1SyH8A/bcy59DOeFNnmubYuG1sc3YWQKLIUvRoeCVXB6XcSe0sxMJ9
	OLOf06s9H08TFzE/eYop9s9GMC7byNnaW+G83olAtrKtSNVvnyY7yg8JNCDTWQBjZ2D0p1dCHXZ
	lepzRo4gra+KoJzDqKmK/Fk6UlFrzDnV5XQ2lllc2UaOFlVm7n39Wk/7gV5aOID1W6cYpRoVVrN
	w6AoF4M5ngvDL45OcKH2Hw3rLCyKX0aPG2rcBGOPRDx8yes23f493y6MTjtfP7gwFeArjPnOqWo
	SvJf98i8AsUTrDFGWDPT5Hq/GfwP6c4wfQ1esq1SflDGzaJgEmkuMFh69B1dHahbfAeDP3ZOD1M
	bzJliBE6qMw37eqL3vbAK7jgYjT
X-Received: by 2002:a05:600c:6212:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a0275432f7mr127957445e9.9.1791122804538;
        Sun, 04 Oct 2026 07:06:44 -0700 (PDT)
Received: from [192.168.1.135] ([84.68.183.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17125adfesm30902405e9.15.2026.10.04.07.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 07:06:44 -0700 (PDT)
Message-ID: <4460ec4a-1a28-4481-a33e-3fe72f68bf58@linux.com>
Date: Sun, 4 Oct 2026 15:06:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: net: meson-dwmac: add T7 support
To: Conor Dooley <conor@kernel.org>, xianwei.zhao@amlogic.com
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260924-t7-node-new-v2-0-319d3c19b4b2@amlogic.com>
 <20260924-t7-node-new-v2-2-319d3c19b4b2@amlogic.com>
 <20260924-stinger-stoplight-7c327c3225fa@spud>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <20260924-stinger-stoplight-7c327c3225fa@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/09/2026 18:21, Conor Dooley wrote:
> On Thu, Sep 24, 2026 at 05:51:09AM +0000, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Add the T7 compatible to the Meson DWMAC binding.
>>
>> The T7 DWMAC controller requires the following compatible combination:
>>
>> amlogic,t7-dwmac
>> amlogic,meson-axg-dwmac
>> snps,dwmac-4.00
>>
>> Add a conditional schema check to enforce this compatible combination
>> when amlogic,t7-dwmac is used.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   .../devicetree/bindings/net/amlogic,meson-dwmac.yaml    | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>> index 5c91716d1f21..b529ca5577a9 100644
>> --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>> @@ -23,11 +23,24 @@ select:
>>             - amlogic,meson-gxbb-dwmac
>>             - amlogic,meson-axg-dwmac
>>             - amlogic,meson-g12a-dwmac
>> +          - amlogic,t7-dwmac
>>     required:
>>       - compatible
>>   
>>   allOf:
>>     - $ref: snps,dwmac.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: amlogic,t7-dwmac
>> +    then:
>> +      properties:
>> +        compatible:
>> +          items:
>> +            - const: amlogic,t7-dwmac
>> +            - const: amlogic,meson-axg-dwmac
>> +            - const: snps,dwmac-4.00
> 
> This is not how fallback compatibles are described.
> 
> Instead of doing this, which affects all other compatibles in the file
> by allowing dwmac-4.00 for all devices, please do this the normal way.
> dwmac isn't special, it's just this binding that's weird!
> Can whats currently in the binding (before this patch) be largely
> replaced by just doing:
>    compatible:
>      oneOf:
>        - items:
>            - enum:
>                - amlogic,meson8b-dwmac
>                - amlogic,meson-gxbb-dwmac
>                - amlogic,meson-axg-dwmac
>                - amlogic,meson-g12a-dwmac
>            - const: snps,dwmac-3.70a
>            - const: snps,dwmac
>        - items:
>            - enum:
>                - amlogic,meson6-dwmac
>                - amlogic,meson8m2-dwmac
>            - const: snps,dwmac
> 
> You'll have to check this yourself against the amlogic devicetrees and
> see if this is correct, but with this you should be able to add your new
> device without doing anything special.

I have the same patch in my T7 work and checked it against the amlogic 
device trees: meson6 and meson8m2 use the two entry form, the rest add 
snps,dwmac-3.70a. dt_binding_check and dtbs_check are clean. The example 
needs fixing.

Xianwei, from my VIM4: the MAC reports Synopsys ID 0x51, DWMAC_CORE_5_10
in common.h, so the core is 5.10a, not 4.00. And the controller reaches
DRAM through a pipeline stage. Nothing claims its gate, sys_ampipe_eth,
so clk_disable_unused switches it off. My node lists it as a fourth
clock. Does the AN400 differ?

I will send my series today so the code is on the list. Not a race: I
will drop or rebase whatever overlaps once you tell me.

Thanks,
Lucas

> 
> pw-bot: changes-requested
> 
> Thanks,
> Conor.
> 
>>     - if:
>>         properties:
>>           compatible:
>> @@ -38,6 +51,7 @@ allOf:
>>                 - amlogic,meson-gxbb-dwmac
>>                 - amlogic,meson-axg-dwmac
>>                 - amlogic,meson-g12a-dwmac
>> +              - amlogic,t7-dwmac
>>   
>>       then:
>>         properties:
>> @@ -93,6 +107,7 @@ allOf:
>>                 - amlogic,meson8m2-dwmac
>>                 - amlogic,meson-gxbb-dwmac
>>                 - amlogic,meson-axg-dwmac
>> +              - amlogic,t7-dwmac
>>       then:
>>         properties:
>>           rx-internal-delay-ps:
>> @@ -139,8 +154,10 @@ properties:
>>             - amlogic,meson-gxbb-dwmac
>>             - amlogic,meson-axg-dwmac
>>             - amlogic,meson-g12a-dwmac
>> +          - amlogic,t7-dwmac
>>       contains:
>>         enum:
>> +        - snps,dwmac-4.00
>>           - snps,dwmac-3.70a
>>           - snps,dwmac
>>   
>>
>> -- 
>> 2.52.0
>>
>>
