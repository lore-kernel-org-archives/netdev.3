Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268739;
	b=A7SdYTsOFB2jhr5V04VL5hQ/8pydTyyENQOM+8oI8nn/VGicf7DcjGpH6Doxa0IIi53W
	 eLzD5gju7OH0RiilwelnoCaJNN2NyAqHqlgMO74zr7kt6eqvlezQQTgkv78kfruiB3t12
	 Y3v36Uwehjf0GSZocS3x46MFjYKllxPJ1a3lwbyPyltXgw8umPwU4/+PW00OC1acfco2e
	 G3au0zFex0O86ciknvcNj8X5tACed7D/UvOOh0Nv9bR8rqqBNWTDNZH0bsTzqHBgrJZsN
	 8rX74K58eDdBHmFHSWhxUaLrQLt/awlWIFMv1/PJU6kh9+pCD5QOH2lXZaqhWcSxlzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268739;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=yepJivcfTEFxiv517cxbabDHxAIYQtJbN0Ka8KlzXSI=;
	b=B0Cu+tbzpz9+FhzhoLvwlIT6zBcFqRBMg/cLjcFsBkGJ9k02lEFbx5cXT103lulU6jE/
	 DoKYAPn7LxnElWTi+ThVDiRZnzMXTCgNULrtovYtvv5e+BpJsGWWN1ItSS6S5qNxkKCfa
	 ROuWUfP/b0oC2v8XXVkpuMAi1/GXZlXnG7PJ/cUA58yuynRHOVG4FtNoZGCd20/eV2EKW
	 Vgf1oSoVhOVlpzqSdsXIstwjQNv0BFgs/8ktLDZCw6e3zptg+hWGMGvRzCFEo30W7A8LV
	 3UZMBhexjUXDFbs9eU0TXaVYi2auGlFh1gFOkdS5EknGRkGJeqEaKjPr1aQw26H5vWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=CYk6IF8B;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBC3606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FBC3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=CYk6IF8B
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso765514a91.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:58:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268738; x=1794873538;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yepJivcfTEFxiv517cxbabDHxAIYQtJbN0Ka8KlzXSI=;
        b=0eFYT+Rnrb6WFyiJ1UKSXnEnEdIfNtplCPj8feJSkSprQhrmnAygopg7nU8ze7iv9K
         TabpvfqepJ/flNiNyJlI53vhgi8L0lOycTaMFPYy2gYIQtWYhpiGiX2MPNnF9RPdlhh/
         MIun8/a0oIxVyhimFPpd3usjCF8YeKrz4eeqHNuDcz7BkGnW/t1w0Rwi201H/HAZsqbq
         8M91A/wPs8RcGXhrQ+VRfSERXD6n1OOQGyY6cDXMKqq+3J9Um0YwJikyz/Qb82G5Q4JL
         U5w0aVvVPI09f4Y5wR7EsqXbA1NIlJ10irtELu6GsYqZoZxnOlG44DexMafM+afFmIEs
         asmQ==
X-Gm-Message-State: APuU4Z9LRnF8UTCAtyN1h2Tf1yzB85OG9FgCskuno2mGH/8jWbUQgm+k
	Bjh3VAnhOP+eaKYwZpN5RZCZnurJpi8WAlwyEbGdUKvkHoaY3Hf3ek2HBiiOBS40ntFmABWuBC3
	J5EBJtXCquxcSPFMP9kVNpI/jA8Ca1kFG68dzECIBQn0Kz7/7tGNzgYKCqEEyKSmBYDLDAd2F/d
	d8o5W9oRa0l/a0KZqBSdywBZTiPjNRyjxNxTIfPt9RKg+G07rceKjCsKEboejEQ0d9zvzMwWm4h
	2ql0J5eVnGF1+Ft
X-Gm-Gg: AYBFou2/ld0VIBzwBmFUzKXWRj+721vfS58X0V9bu6s0EmrN1lS2cWLbseDq9pHBRo5
	qDVV7r+YmgUgGuTubaUYLyTZalThsyVLtMB7YNyuuq3dLTSMfbZEJuZmZLJP+Oms2x/GMzaAAG0
	w6TAtRhB58OIIcpIcSHzX96h+AcyeyZTU8bpEPnpvRrWeRr7vSYxgSBbTkJN2e0PAY3LvBMfaa4
	03cISuMEBbPGKs6n3gnYgM+nLPs9zTFPo9778PwfPNGbEu3TE/6x9qhfH98AmSpZ3bcy/5VFOZg
	T+yIU8MbQp3GFtQHDDADkV0PgkczqfQPuUpAM4HQIZ1tl9PGz1j1lpkp3CMpeSOG258+71lcHFJ
	92yoyQPpZDndyKm8KcWSARDpchVo8CFbiP4JTJvZdHFl5ZhSQe7wp6t5qDi/k5kSeSdFT+fpoOw
	lJ/x/dRCBKdr/4RrpbeAnqv3uYr6sFbimGDokV5rAH
X-Received: by 2002:a17:90b:2f04:b0:3a4:e735:b39d with SMTP id 98e67ed59e1d1-3b166d01d5bmr1109296a91.64.1794268737615;
        Mon, 09 Nov 2026 15:58:57 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b16703663csm649298a91.5.2026.11.09.15.58.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 15:58:57 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5337f26ee19so41703681cf.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794268736; x=1794873536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yepJivcfTEFxiv517cxbabDHxAIYQtJbN0Ka8KlzXSI=;
        b=CYk6IF8Baq2u5VxH2yy3/nkNnkxt2Tar3ISsDBONRbuYtk8mwB1u/6DogXYXmmP5ny
         /bsSifuBRvkum4QKpXwK+HOcMPff21EW0mr8a4U4AcLh+gZiTjxT8IakZQlBv0RzbVvU
         PCBJYjB+9SUZfSao3C+FI4NkZjsTwW9fzOWDE=
X-Received: by 2002:a05:622a:301:b0:539:c527:259 with SMTP id d75a77b69052e-5552a174972mr14303541cf.76.1794268736386;
        Mon, 09 Nov 2026 15:58:56 -0800 (PST)
X-Received: by 2002:a05:622a:301:b0:539:c527:259 with SMTP id d75a77b69052e-5552a174972mr14303231cf.76.1794268735803;
        Mon, 09 Nov 2026 15:58:55 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-555093d9c3fsm9945091cf.3.2026.11.09.15.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 15:58:54 -0800 (PST)
Message-ID: <e7fe7c0f-870b-451e-8c4d-966e63251736@broadcom.com>
Date: Mon, 9 Nov 2026 15:58:51 -0800
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
Subject: Re: [PATCH net v3 5/8] net: dsa: b53: use the correct override
 register 2 Gbps bit
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, vivien.didelot@gmail.com,
 linux-kernel@vger.kernel.org
References: <20261030211617.288562-6-florian.fainelli@broadcom.com>
 <179348376296.3131.18140178740714009002@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <179348376296.3131.18140178740714009002@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/31/26 14:56, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] This patch makes b53_force_port_config()
>    (drivers/net/dsa/b53/b53_common.c) write BIT(7) of the per-port GMII…
> 
> --
> 
> net: dsa: b53: use the correct override register 2 Gbps bit
> 
> The IMP and per-port GMII override registers use swapped bit positions
> for override-enable and 2 Gbps speed. This patch adds a per-register
> speed2000 bit to b53_force_port_config(). The function then uses that bit
> both to clear the 2 Gbps selection on 5301x/58xx and to set it for speed
> 2000.
> 
>> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
>> index 378f47e7250cd..75033b28100ec 100644
>> --- a/drivers/net/dsa/b53/b53_common.c
>> +++ b/drivers/net/dsa/b53/b53_common.c
>> @@ -1370,17 +1370,19 @@ static void b53_force_port_config(struct b53_device *dev, int port,
>>   				  int speed, int duplex,
>>   				  bool tx_pause, bool rx_pause)
>>   {
>> -	u8 reg, val, off;
>> +	u8 reg, val, off, speed2000;
>>   
>>   	/* Override the port settings */
>>   	if (port == dev->imp_port) {
>>   		off = B53_PORT_OVERRIDE_CTRL;
>>   		val = PORT_OVERRIDE_EN;
>> +		speed2000 = PORT_OVERRIDE_SPEED_2000M;
>>   	} else if (is5325(dev)) {
>>   		return;
>>   	} else {
>>   		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
>>   		val = GMII_PO_EN;
>> +		speed2000 = GMII_PO_SPEED_2000M;
>>   	}
>>   
>>   	b53_read8(dev, B53_CTRL_PAGE, off, &reg);
>> @@ -1392,11 +1394,11 @@ static void b53_force_port_config(struct b53_device *dev, int port,
>>   
>>   	reg &= ~(0x3 << GMII_PO_SPEED_S);
>>   	if (is5301x(dev) || is58xx(dev))
>> -		reg &= ~PORT_OVERRIDE_SPEED_2000M;
>> +		reg &= ~speed2000;
>>   
>>   	switch (speed) {
>>   	case 2000:
>> -		reg |= PORT_OVERRIDE_SPEED_2000M;
>> +		reg |= speed2000;
> 
> [Severity: Low]
> Should the set in case 2000 use the same is5301x() / is58xx() check as
> the clear above it?
> 
> On GMII ports, speed2000 is now GMII_PO_SPEED_2000M, and b53_regs.h
> documents it as chip-specific:
> 
>      #define   GMII_PO_EN			BIT(6) /* Use the register contents */
>      #define   GMII_PO_SPEED_2000M		BIT(7) /* BCM5301X only, requires setting 1000M */
> 
> Before this patch, reg |= PORT_OVERRIDE_SPEED_2000M on a GMII port set
> BIT(6). That is GMII_PO_EN, and reg |= val had already set it. So on
> chips other than 5301x/58xx, speed 2000 behaved the same as 1000.
> 
> With this patch, speed 2000 on a GMII port of any chip that is not
> 5301x, 58xx or 5325 (for example BCM53125, BCM5395, BCM5389 or BCM63xx)
> writes BIT(7) of B53_GMII_PORT_OVERRIDE_CTRL(port). Since the clear is
> gated on is5301x(dev) || is58xx(dev), nothing ever clears that bit again
> on those chips.
> 
> Commit b6a8a5477fe9 gated the clear because this bit position "can have
> different meanings on other chips, e.g. for BCM5389 this controls
> scanning PHYs". The set path was never gated the same way.
> 
> The IMP-port side of this mismatch existed before this patch. This patch
> extends it to all GMII ports.
> 
> One way to reach it is a DT fixed-link with speed = <2000> on a GMII port:
> phylink_parse_fixedlink() only warns and keeps the speed, and phylink then
> calls b53_phylink_mac_link_up()->b53_force_port_config() in MLO_AN_FIXED
> mode. The 63xx RGMII path in b53_phylink_mac_link_up() reaches the same
> function.
> 
> Would it be better to gate reg |= speed2000 on is5301x(dev) ||
> is58xx(dev), or to reject speed 2000 on other chips?

Agreed. I’ll gate setting the 2 Gbps bit on is5301x() || is58xx(), 
matching the clear path and preserving chip-specific bits on other 
devices. This also addresses the pre-existing IMP-port mismatch.

pw-bot: cr
-- 
Florian
