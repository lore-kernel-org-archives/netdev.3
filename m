Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAE2305057
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786297738; cv=none; b=lM9YOENhNQEMKudqRxpmHmmRWo06U3O6SDeNiWMWMqhwskcenTK0UYh1RNgdyriLSGag9jun6RnLF1WUptcEbQkPw68WcdIIlx0e2S3rRywFCtLG8FFq9HfC0SQjvs7LqBN6/XmgkE00ZIMV1/UGB51H3GTIG13EeYoOGsyT3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786297738; c=relaxed/simple;
	bh=h80ROkZ1L41leW4D/oQCviDZGdtRRFwIi2wBKy1ffS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNK/4EZ2Ua9uUgUyxslrmr3q0tuEW9jxZReLTJXto10pLvtltUYzUezJcPT5iFZXC6LhjzYUgF2Xx+lKrRhZVjhEzXvxgBmr6h9vqpaBUVgg+FmtwfehX/iaFs3/BfvDaR4GxvO2eYbZpfUOeoaZU9U9Q/t0m4fKLytHvpgb4EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bB4BHefX; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bB4BHefX"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3900e39d935so1095627a91.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 10:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786297736; x=1786902536;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7Cf/GU5DQwzJNWY6jfFN6+m9rxncZDrtcffGDCTuspw=;
        b=iGjYDlaWJ/0VWVTV9AcqMn6R5o8SzkFmQ+HEkiBf/SYignWT+I7fu86yqtLhNERmmI
         VbYileLXwDEl5BQ9Xd++heA9P2gC4382LQSFjw56GK6tiJGgo1a6GrwA+a78vjFV31E/
         rZGBUVV4aDaKAx02FBaVIGnYmF8U1YWycKcxK3FjSNcxFmJB5FNPYMGowW9Ru9U91tLo
         JdPL3Nhdnt1DgHygmPEZTzqfya5mLqcsV1QOgKZc2AQBd328fbrN7rQje4p5X1bWV+UJ
         RWp6O0TfxNVmA2JmJKbyIHUPaaxan0qF7UAzv03Nzb5oZRJ/1yERGBn7qJ5AcztaJN/a
         DqGA==
X-Forwarded-Encrypted: i=1; AHgh+RqPUNhMcxT031KCeFSq+eAneAGWooN36MoDUpiXFiWcNCo8jtvncHqM7Uinboy5BDwoIzdHsQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+Ohy72tVd0Wu2YKSStYg6aJurQPUXRekQGbLUm7T+y5L3XIb
	kAF7wAJ+llB80UgjeD3T5E9aARJzPxUkj9D0kefqfbdybKUpMWGKymgdxuS/dEbGwXu7lkhxNyw
	k9+qt/JrF5TplpO9v3TGJ4FZ5iZg0mBLRbfq0wvW9eZG6wT/zbJLBI6qqnbKcwFvWNKa04Ftcgg
	NbcD9R5TXs1wt2Pf5aw/ZQv6oww7teCrepP+re+nRPtq56O4EFDDjH/+dFIhUhwXZMCkpPxzm4P
	7mAdE+CNEECeXgI
X-Gm-Gg: AR+sD13iax7hoV1nvtrQ5NsCOx2iPF9IjbNJdnxGDCY0Rv/0y9se/CPNolxx4R3cX9d
	3NY1iolLD4X94CvNaKo7wAfUtsyRy7MzUQkZ+0k+qxaxBdpYdePJhBn68bQcG3wAhBMaQh3LpmN
	e6pWZihdkiQ54QvHAY9zihiqTlwsJE34pNVYMM93t6B4VgcBI/yhdPoeZKv277PZjGsEjdXDFUT
	YIymuS7s6/aFrF7m/zor/0v2WcMfhp5QNMI7L8NiB0W/cF65rQ+XUr7Wr42roulLaqXQeiSPiLS
	A1ejQ/Jfeq5GpKTgwdSj4MUJCjloNRpq5zKXgWTSaH6lD3n0C9jwfBsf5/zbhUctb4MiE2SLvrM
	X8ToL7h+mgPqJFw3oHgc2HCBy3RV9w4hc585At8I0ApmAlm8pZ+hb/HviFegMFduO09R5/XBg68
	ndEDf6OuIBKKZ6HI/A29xC5vln3YPx1qq2uyRzpg==
X-Received: by 2002:a17:90b:2dc1:b0:38f:de97:b06 with SMTP id 98e67ed59e1d1-3903c535d79mr41902549a91.5.1786297736429;
        Sun, 09 Aug 2026 10:48:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39085c4670fsm5490483a91.0.2026.08.09.10.48.55
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2026 10:48:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so1569880a12.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 10:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786297734; x=1786902534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Cf/GU5DQwzJNWY6jfFN6+m9rxncZDrtcffGDCTuspw=;
        b=bB4BHefX74jVtGNdymq33hoBSPEoIOFEgk10PFUlRGuniptk8VuvowpvyVgoSemVa7
         pNu8sWK2ZsOX0bWcU8Asg0Xoro0IhXGN7G9V/0r6dqMgVIYGYYvwNqEsPf2tCPGE5r7l
         t1Dl/e+sfGTapdDkwHtReKYPf0UuuIJEGAuCw=
X-Forwarded-Encrypted: i=1; AHgh+RpymO/H9gy2y8Xlrlik0RyhXKDtlAS+xnbuXtDpUxQ+ZWUQGl9/EbLqHKyR8XKyMHM04m4Donc=@vger.kernel.org
X-Received: by 2002:a05:6a20:728f:b0:3a2:d316:de53 with SMTP id adf61e73a8af0-3cb85c0732fmr41638832637.0.1786297734531;
        Sun, 09 Aug 2026 10:48:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:728f:b0:3a2:d316:de53 with SMTP id adf61e73a8af0-3cb85c0732fmr41638791637.0.1786297734003;
        Sun, 09 Aug 2026 10:48:54 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8a6809sm34437245eec.10.2026.08.09.10.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 10:48:53 -0700 (PDT)
Message-ID: <d5b85dc7-31ac-4888-98fc-2cd3197dbb7f@broadcom.com>
Date: Sun, 9 Aug 2026 10:48:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: b53: skip EAP mode setup on Northstar SoCs
 when using port 5 or 7
To: Andrew Lunn <andrew@lunn.ch>, Jonas Gorski <jonas.gorski@gmail.com>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
 netdev@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Semih Baskan <strst.gs@gmail.com>
References: <20260809093934.28098-1-zajec5@gmail.com>
 <CAOiHx==_HzdmNN5BY4DMh3Cr6JK5oQri3ZCNWN9v+xQPjzQZkg@mail.gmail.com>
 <1ec9fffb-77a5-42c9-874a-8a8e807e6e50@lunn.ch>
Content-Language: en-US
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
In-Reply-To: <1ec9fffb-77a5-42c9-874a-8a8e807e6e50@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 8/9/2026 8:00 AM, Andrew Lunn wrote:
> On Sun, Aug 09, 2026 at 12:39:58PM +0200, Jonas Gorski wrote:
>> On Sun, Aug 9, 2026 at 11:39 AM Rafał Miłecki <zajec5@gmail.com> wrote:
>>>
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> Northstar devices have 3 CPU ports. This design was meant for dual IMP
>>> setups when WAN traffic goes to port 5 (IMP1) and LAN traffic goes to
>>> port 8 (IMP0). While all 3 ports support Broadcom header some features
>>> are not available for ports 5 and 7. Trying to set EAP mode when using
>>> those ports breaks standalone ports.
> 
>>> +       /*
>>> +        * Northstar devices (SoCs with BCM53011 / BCM53012) have 3 Ethernet
>>> +        * controllers connected to 3 switch ports: 5 (IMP1), 7 and 8 (IMP0).
>>> +        * Each of those ports can be used as CPU one as all support Broadcom
>>> +        * header but ports 5 and 7 have some limitations.
>>> +        *
>>> +        * Setting EAP_MODE_SIMPLIFIED with port 5/7 used as CPU port breaks
>>> +        * standalone ports, see:
>>> +        * https://lore.kernel.org/netdev/ce4d9b7b-aaf6-4796-94fb-8c3d6a1dcd4d@gmail.com/
>>> +        */
>>> +       if (is5301x(dev) && !dsa_is_cpu_port(dev->ds, B53_CPU_PORT)) {
>>> +               dev_warn_once(dev->dev, "skipping EAP setup because of not using CPU port 8\n");
>>
>> We should print a bit fat warning at probe time, since this is
>> essentially a broken device tree configuration.
> 
> I was wondering how we got here, is it a device tree problem, but the
> commit message is a bit vague.
> 
> I agree, for a DT problem, it should be reported at probe. After that,
> the driver can do its best, but should be quiet.
> 
>> EAP isn't the only feature not working, anything that relies on trap
>> to CPU is broken. E.g STP also won't work, likely (if ever
>> implemented) bonding would not work (LACP frames won't be correctly
>> trapped), I assume LLDP would be broken, and any other protocols that
>> rely on reserved multicast addresses as well.
>>
>> So we should strongly encourage users to fix the device tree and use
>> port 8 as CPU port.
>>
>> Also can you try to move the CPU port on all devices you have access
>> to and send patches for that where it works successfully?
> 
> I agree. This should be changed into a patchset.

Also agree here, using ports 5 and 7 likely stemmed from limited 
understanding at the time, given all of these ports are internal and are 
all functional, there should really be no reason not to use port 8 
unconditionally as the IMP port, it's the most capable and it has no 
limitations.

> 
> 1. Move the warning into probe
> 2. Update the binding .yaml to indicate such a setup is invalid.
> 3. Fix all in tree .dts{i} files to make the new warning go away.

Sounds good to me.

> 
> If there are any boards which cannot be fixed because the correct CPU
> port is not wired up, we need to think further about what needs to
> happen.

I don't think that can happen.
-- 
Florian

