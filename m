Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DDA3AC00
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786000746; cv=none; b=Ed0HpvtMhVW9W/4EdkGH+snO2FN4L3Dhyl3TbiJMZEo65Qd5efMgbRQYSEJ2FqkjUfd9FSBPDiBbq9nFkJcFzF0EKnWP97BY2nlc7XyBv5pG4miLAntWgHahwjNBLSf8DRZuP7BzeMePZUEuALZQNWUaYZ8RvND6gdd8GJv9GOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786000746; c=relaxed/simple;
	bh=pAnZTpbJUx3vZ+GsiQOgJ/n1CQp1O4Pq+UpZM1UMbH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tT4f1BGtDRI4Oyd3xjlgmqBp4ozlrVnlf1WPcgAQlY78yiEn9rcQCvr+J+MPigV7NmXGNKArUgeX7OiFJwG2hfIpM2he9hQeF2d9oASzhCwM8mnurr6ipBhA3pzca+lLvVd0TXIPZFY+1dZWg5Io44Rzz2Ad2RPPOTeo0ZYc7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8PnNgG2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8PnNgG2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so11007145e9.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 00:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786000743; x=1786605543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J58Qoy4aHHn9awwFtSrKAEtr0Dz8WhHaRR0KQcTY5As=;
        b=L8PnNgG2b2VyMmFrYjdjNdDC3wEWoQY2eZDrcP7oFIj5QpQX6PivN0i2mmWOV1auGw
         hvwpezOBj5FIAWS6MqmczQZ40CFZOwV+pWPzV5fJn3AKnxlhy68S3RAJojtKbcrLiVaU
         uxxitkah+h2z1wBQE5/djgWjkpTTKP8rrHhyPjXNr64/lIL5OvD9SlahvDYxEAyqrIop
         kA5/Kq1BvDmN3B4mNv3UN85Aw4Ih3PENMlUUtHw2L8wguGfW30LuxHWTJKhGlfQW3212
         HspQHzLrxbg/ghotlVvRX5+OMTDstojE2Gv5s3xNIfF9M9krb9G8rUS/Df3aQaax7Bfk
         j63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786000743; x=1786605543;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J58Qoy4aHHn9awwFtSrKAEtr0Dz8WhHaRR0KQcTY5As=;
        b=Gw3HOI7ohyArqvgmvxe5v/UN9dWwqM3gGYIOyo98vPBa9lQ/p8EY7vL8G/xlXrWulR
         6sHW36alCtrkJDNPBQ06rPANi7Vi78Fe+ViNUC/74H9q6qUQwuTwrzbVaDh4v/CHQj3r
         Sbxk8u9GnXb7BrwyjTa9Klr4/3GYs8EmJDW4KTYQZgFkYoRNQ7iqVpYZouV52Y9kppYq
         QutcfIyWZD75nsFLfQd0OkZyIIhvjM7DlPAw1V933z8ydDFmxINobicJP0lMuFLskkRo
         ep8aE0px9S7Ocu08fBoxvBSUl8W0dj1xdXh1xSKMxrAJ+OlGzaqO4lFbq3eWKw4GPtLi
         cJlQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQApgulJe/Kw8PkMJpy7fpdBTBg+e+6Wv/3wRsnOqdMM7PYqcQBkXapUkkVuB33YaffgQK6bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhQQtAfp8qJ/4yR2I915nZnB81nqNSke/sEggEhJ1z3LxUcRks
	o+2CfrHvNSOvwHTYpRYJxeFTceeJO2TnlPBYQOFhnjsLA1z01gsQnypn
X-Gm-Gg: AR+sD138UfzuwpchrSyo3bcyIpnwAr4sZUZ0LMLvey65hZlZb1RxqEb5mJGBTMudPR0
	6/iuuMK0vQibEbuRbR9mNTrBXs4I2dmwBA0QTihtb1p4otkPHkkze/RFeOZOW9kJnWdzdGAcl/3
	iEyxvkv3pfeBnpgdr0pUoYxi9RNf3Hd3H4/em63RE5LQRwuHH5mw9I5d1Bk+FeWSFvEk8Pkp5mg
	ay2qa07kofz2XM+TJSn5IzvT4F9WUGSQSBKu+tKXpgEnHykcGEtWGyqDiiXMDf9ZxM3Z21V+Sr0
	n5/MJx3CJZP6YWENK4NQgW+e7mpmLcZwblSD38jTeHmazDjYnGaUeHFn6zOuP7oRlOoAnLqtMxy
	+GeGh7x+zRxRzBQ9wReTj2ZF3j6ZXafN012Tl04OmcpebWsftWBLYj//8sxMp/kKI3sj+ymwjPO
	/QQvWcp4bPU5528Xk1VeKoEhLD9rzYXgpueAdW33NViypo2gZE0McBeIiKIa47iuPB8yuktuv9G
	/tUjZ+fi9RQne/cM0WT/ZgyA7wXbOvOZeojeVnihtg6xN7X+Hv3+huaPGiN7WM=
X-Received: by 2002:a05:600c:1d23:b0:499:51b8:d649 with SMTP id 5b1f17b1804b1-49951b8d652mr95522045e9.3.1786000742355;
        Thu, 06 Aug 2026 00:19:02 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f131:1d01:8da1:260c:d732:9394? ([2001:9e8:f131:1d01:8da1:260c:d732:9394])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e98fdedsm109323795e9.4.2026.08.06.00.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 00:19:01 -0700 (PDT)
Message-ID: <d26486b9-e820-41a6-ae22-f7473cc9ecef@gmail.com>
Date: Thu, 6 Aug 2026 09:19:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 1/4] dt-bindings: net: pse-pd: add bindings
 for Realtek PSE MCU
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, bjorn@mork.no,
 sander@svanheule.net
References: <20260802100114.720594-2-jelonek.jonas@gmail.com>
 <20260806011107.1855326-1-kuba@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260806011107.1855326-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.08.26 03:11, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> dt-bindings: net: pse-pd: add bindings for Realtek PSE MCU
>
> This adds a new YAML binding for the MCU that fronts the PSE silicon on a
> range of managed Realtek-based switches, covering both protocol generations
> and the I2C/SMBus and UART attachments.  Two questions below about the file
> naming and about the serial slave node name.
>
>> diff --git a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
>> new file mode 100644
>> index 0000000000000..3bb32349c28c4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
>> @@ -0,0 +1,182 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/pse-pd/realtek,pse-mcu-gen1.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> [ ... ]
>
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      # UART
>> +      - items:
>> +          - enum:
>> +              - zyxel,gs1900-10hp-a1-pse
>> +          - const: realtek,pse-mcu-gen1
>> +
>> +      # I2C, SMBus framing
>> +      - items:
>> +          - enum:
>> +              - zyxel,gs1920-24hp-v2-pse
>> +          - const: realtek,pse-mcu-gen1-smbus
>> +
>> +      # UART
>> +      - items:
>> +          - enum:
>> +              - zyxel,gs1900-10hp-b1-pse
>> +              - zyxel,xmg1915-10ep-pse
>> +          - const: realtek,pse-mcu-gen2
>> +
>> +      # I2C, SMBus framing
>> +      - items:
>> +          - enum:
>> +              - zyxel,xs1930-12hp-pse
>> +          - const: realtek,pse-mcu-gen2-smbus
>> +
>> +      # I2C, raw framing
>> +      - items:
>> +          - enum:
>> +              - linksys,lgs328mpc-v2-pse
>> +          - const: realtek,pse-mcu-gen2-i2c
> [Severity: Low]
> This isn't a bug, but should the file be named after the family rather than
> after one compatible?
>
> The file (and $id) is realtek,pse-mcu-gen1.yaml, while the compatible list
> here documents five strings across two protocol generations:
>
>     realtek,pse-mcu-gen1
>     realtek,pse-mcu-gen1-smbus
>     realtek,pse-mcu-gen2
>     realtek,pse-mcu-gen2-smbus
>     realtek,pse-mcu-gen2-i2c
>
> There is no file bearing the name of any realtek,pse-mcu-gen2* compatible,
> so searching by that compatible name finds nothing, and the commit message
> does not mention that gen2 is described in a ...-gen1.yaml file.
>
> Would realtek,pse-mcu.yaml (with the $id updated to match) describe the
> actual scope better?
>
> To be clear, the $id path itself is consistent with the current file path
> (net/pse-pd/realtek,pse-mcu-gen1.yaml#), so $ref resolution and
> dt_binding_check are not affected here - this is only about the declared
> scope of the name.

Could someone please take a decision on this and tell the bot how it
should be? This is being raised again and again... Conor explicitly said
the filename should carry one of the compatibles.


>> +required:
>> +  - compatible
>> +
>> +allOf:
>> +  - $ref: pse-controller.yaml#
> [ ... ]
>
>> +    else:
>> +      allOf:
>> +        - $ref: /schemas/serial/serial-peripheral-props.yaml#
>> +
>> +      properties:
>> +        reg: false
> [Severity: Low]
> This else branch declares the bare gen compatibles to be UART (serial
> slave) attachments, and the node name is forced to ethernet-pse by
> pse-controller.yaml:
>
> Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
>   $nodename:
>     pattern: "^ethernet-pse(@.*|-([0-9]|[1-9][0-9]+))?$"
>
> But serial.yaml only enumerates these serial slave child node names:
>
> Documentation/devicetree/bindings/serial/serial.yaml
> patternProperties:
>   "^(bluetooth|bluetooth-gnss|embedded-controller|gnss|gps|mcu|onewire)$":
>     if:
>       type: object
>     then:
>       additionalProperties: true
>       $ref: serial-peripheral-props.yaml#
>       ...
>       required:
>         - compatible
>
> Does a board device tree with an ethernet-pse child of serial then get the
> shared slave-node subschema applied at all?  Since serial.yaml ends with
> additionalProperties: true, the unmatched child looks like it just falls
> through silently rather than being flagged.

It gets applied since it's referenced in my bindings. It just doesn't use the
"routing" present in serial.yaml.

> Should serial.yaml's pattern list gain ethernet-pse as part of this series,

I would avoid this since it adds no value in what is validated. From what
I've seen the pattern in serial.yaml isn't exhaustive so other bindings
like "qca,qca7000" also use a node name not being in that list.

> or is the intent to reuse the existing generic mcu name (which would
> conflict with pse-controller.yaml's $nodename pattern)?

No, reason already given in ( ).

> [ ... ]
>
>> +  # UART attachment
>> +  - |
>> +    serial {
>> +        ethernet-pse {
>> +            compatible = "zyxel,gs1900-10hp-a1-pse", "realtek,pse-mcu-gen1";
>> +            current-speed = <19200>;
> [ ... ]


Regards,
Jonas
