Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFDA49C4DC
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792102387; cv=none; b=fQrzJdjskUyZd+a9hER8h/eEuUbohAIU+woiaJQhSqV5R2VHJ+qhAu6Wqh50i5wW4va73etG4aHLQ3soKVyBNq1mArKZrO/peY1h7EZfOtWBR1yMm9vLbspI3wRVEXxm/mgwvZNZghqktwSlFl7snZH5bNVdlDKYoOTlT0GVArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792102387; c=relaxed/simple;
	bh=40gmtCymycQFHbFXfgKDqLipoiytU518gUFzifom2sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rrx3PMzQtmKvDFyaUnInPiJ8jFuK4PaaQ6A/x1VGvUxUbkVrYrUufshNronIc4eK4k9Ex78IUmseHEa8RTrFNYu3o2NULWwVgyEnku/sLEQYUY9wXpVsHoXvUNsvQoEexCtNQoAh7nOP3KykPN07P/ZHW8Y5VV+BBFLDBfZZzgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cpYzY6Nq; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cpYzY6Nq"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so1840786a91.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792102386; x=1792707186;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KAMNNIjaffC8G5IgYh2OMegewZGeZrERfs6YCxgtum8=;
        b=YFpOn6sbsMNXcRdy9JIDzojoZfwA+yD3etmbdOJKnxAdRXOp+2BRfGZAi8T5iikx38
         0wPBZYpzZPKmM4tbvC2U59OrznY/JBjD2Hg2hwEa44AbLdPOVuIPqLyN4KrbCc7bxWEU
         S1R/81KdNMno3POuKvOqyZQ01uJLi38zfWTp1XpVZ7jetAtHLgU/Dpb11ce+h7oKfOqn
         kXiBKsFWK5VSsbXkth/DtiYUBrxjAYb8AY0klByNMBpL05soHU6uzwrAYs9stGUczQaJ
         Uvyk09CPv00FvFb1G/y763yQilejcbim7VTatIvQFcja8pA7M4w0SyK4HoL8wH5dL3M7
         cZFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCCXmIXY6hBwUFQlMtlepJgR82faTjJGMlWhFuCP9Qhe8dEf4xVwKtIxdHs/KZl7lKEX5aGpU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnGtFMMPX5jMrRnRKxbCHTOfKUNZX2dEIizlSmhjtr6MBufOwx
	gWdRu0OlfnrlJ8eiykvXfckkIHYW6EsmfUdYT9vl8ULNqg1nF68Yrj7dnr+8oy8vRmxl5avDvRU
	+g9CWX+F+mNLnXPRn7nFnp8xPyagdAr5EsjDJW6ekeQHLu+Padv7RTvmPS0uQvdQFQrYik2d5If
	rKtR6DuL29i3eMrA/UgDU07N8JgrrLM+c0PAvcwC8+g4XkvvZ6TgR7g4xrrA1B2dbWXT96ck4+/
	6BIYfsPK8FtrmQC
X-Gm-Gg: AYBFou3aHNN23Fknxpct5hxoJHpVXzq/hAuyMZdimFSoDNxijxGpCkdtHMkPShoCbTh
	2TgKEQfEmtqp7UMQN+q4yfml9sNWba/cNFmw+kKOMD7uac3ZZr8n5CLoYOHbQd/2UONIVL198oV
	c9mmvopZNKZxnDk22eibGma7Wdu1lZIa8C7c7hJI4Psz24EFe7Ou/tbfAvpvcTRxk0d06Rz2wct
	F4erlY39uC6RufNZqAkov8ihrUeGFNCiw9oz6Q56o8OTd4GdFfxEmS4gGVKG6ODBA50itQ+1pLB
	1Myd67TRJPx35KdkT0FaDU1a1xdoIPlD7a/ceGB6nvzJKDKw1GylX1zOclEgELGmn0GxQhdxpja
	LFNIuktX0Pdl9dRBT1myyadkjspX0OxnQ7DOO6HIVrso1WW3vG9+ERSE2/sfklzuQpEzj76Ez73
	PNteUVjzY0Gk+0kIzXeJ/Z3SdnR7yrXBW99g4Tpw1YkU0=
X-Received: by 2002:a17:90b:4b05:b0:3aa:ff19:42b8 with SMTP id 98e67ed59e1d1-3ab3a9aaab6mr19817105a91.27.1792102385736;
        Thu, 15 Oct 2026 15:13:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3acbd620a05sm601765a91.2.2026.10.15.15.13.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 15:13:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ac575a9198so2977528a91.3
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792102383; x=1792707183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KAMNNIjaffC8G5IgYh2OMegewZGeZrERfs6YCxgtum8=;
        b=cpYzY6NqjdtF4W2IViWyd0UP8nzrsDcgBlFd99Cff8LrLc2OIP8ABzyk3gUZpwIXYm
         257T1/Bdp9m422zegBDgQ+d1tl0DPmrlQnnlxNVEhVoOAFbruxEpikNyPcx8RzOSWalV
         ifrhR/oIWa2Ad34kMCzegt8u0suz6gKaW5hcg=
X-Forwarded-Encrypted: i=1; AKwUvBw3Ja2sM8D5SLWVt864NZ2tsx1YmqPoKtts3TFDdaPpL+b3sa/NlfhayQjCpGXaF4x63ThI5C0=@vger.kernel.org
X-Received: by 2002:a17:90b:5345:b0:3ac:9df3:6b07 with SMTP id 98e67ed59e1d1-3ac9df36ea5mr3322557a91.24.1792102382659;
        Thu, 15 Oct 2026 15:13:02 -0700 (PDT)
X-Received: by 2002:a17:90b:5345:b0:3ac:9df3:6b07 with SMTP id 98e67ed59e1d1-3ac9df36ea5mr3322538a91.24.1792102382175;
        Thu, 15 Oct 2026 15:13:02 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94748c6csm6168418a91.10.2026.10.15.15.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 15:13:01 -0700 (PDT)
Message-ID: <2279ba71-009f-429b-a27e-dc72ab11cfbc@broadcom.com>
Date: Thu, 15 Oct 2026 15:12:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] net: mdio: bcm-unimac: implement timestamped
 MDIO writes
To: Nicolai Buchwitz <nb@tipi-net.de>, Andrew Lunn <andrew@lunn.ch>
Cc: James Clark <jjc@jclark.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, Doug Berger <opendmb@gmail.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Russell King <linux@armlinux.org.uk>,
 Conor Dooley <conor.dooley@microchip.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>,
 Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-6-jjc@jclark.com>
 <3b1a2994-5251-4800-8c61-b63d7a435b21@broadcom.com>
 <60accbd89cfaf0d4be1da5ec2fafd975@tipi-net.de>
 <CANz3_EYfcBopo=HgRioXkhoT6P+4WWpfFT7UeWkXd5eM_RNpSA@mail.gmail.com>
 <41c32f5a6f38ec9df8a79ce896912fb9@tipi-net.de>
 <68eeee64-7f62-459c-b53d-61ec04b4d8e3@lunn.ch>
 <6b5ff0aee5db9bba10828d2f949c9d67@tipi-net.de>
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
In-Reply-To: <6b5ff0aee5db9bba10828d2f949c9d67@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/12/26 06:21, Nicolai Buchwitz wrote:
> Hi Andrew
> 
> On 12.10.2026 13:51, Andrew Lunn wrote:
> 
>> [...]
> 
>>> I've put together 3 patches, which do the clock plumbing:
>>> https://github.com/nbuchwitz/linux/commits/devel/bcm2711-gisb-clk/
>>
>> It would be nice to extend this and set the divider based on this to
>> give 2.5Mhz, as required by 802.3, as the default. Allow boards to
>> override this using the clock-frequency property.

Regarding the choice of the GISB clock to feed it into the MDIO clock 
input, that's something for Raspberry Pi to comment on because I vividly 
remember we did something different for 7211 and used a 250MHz clock in 
the interest of being identical to the other STB chips. Your changes do 
look correct however.

> 
> Sure, as a net-next follow-up once James's clock lookup is in, plus a
> binding tweak since it currently promises hardware defaults?
> 
> Only BCM2711 would notice for now, 10 MHz down to 2.5. Both Pi PHYs do
> 12.5 MHz and the slower bus mainly hurts the PTP path, so I'd set
> clock-frequency = <10000000> in bcm2711-rpi.dtsi to keep what the
> boards do today. Florian, ok?

Works for me if it gets us what James want as well, thanks Nicolai!
-- 
Florian
