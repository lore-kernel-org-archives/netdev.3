Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDF846D2B8
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561863; cv=none; b=It1LECbXdEtjLudpxb+RBGELBzdaEZLktEGbPSVV6djqraIubDddqdb7yJmWYQR4eKOl1hJyyQkx79trKea8W116lG8jW5+JgQ4F2f4/f2WE9MrxjlRDpLYLiCdFYpIkSz5fvVGT+zxCF/JuaIzoi1d5ZaNajp3HtJ//TcLcgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561863; c=relaxed/simple;
	bh=Q6FtNDFFjNWaEF9EAMWjEDiH7/9CRptsgplPUDRoCz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxMwUwA3d9Dn54IeB0rwaYMFyw6/GKm5Qcra7F08HgJLbRDccBHeKq5O7ip0/97A8oigLlngOo60OJ5WEpu6yamwEcs72g2ZbzQZMG3WqmWEkWJhsJs9mNWpPKUEeYvOqjpRms3pA2Eo5NixhZX6CWrhOs3cDtU6NIEzaHl2JWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TgEKNZy3; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TgEKNZy3"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so3138490a91.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791561862; x=1792166662;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QPvsAsFKROVd2IVDjuabUUWH8AsyeJTOH9zIP0FhFmQ=;
        b=Q9+MSTFuQS1YRRQ8+54+d16hFcYiQn1dywWvqQzS+HTwn2ryzN4Gy/S5T0mr6CNIMx
         e9S8y8ljHG3c0g3ycRJzet55xG3wiLGPPEeh7S/fDLxSi/LnAvGJ8W3j8CGwV6wtHmYP
         2R0Dt5uEGQA0mjhz3m6stiJWnbcUsnWVl0X+0H84OhvNrA6hBEelepTRmN4cSa4bB9US
         98bd4OAj9iLYBtHbAvm233GBChSOnvCjf9tYM20QMm5525B3N5eF8fPgNgPTvPQvwreI
         V7g5oGhMqABEPK0LvDfqD5CSt8u2mp0zOUbybHkiPFPiUQMvWJP/PSryX7NRN0th4JJt
         F08Q==
X-Forwarded-Encrypted: i=1; AKwUvBwhr+4UpTS753FiV7ERnkM3JqNUv8qf8paace1mxcrrk/vK+GYb3Cwve0b62ipmwpCs/WafyPM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfE2MJFZ/cDchmXg7Ie69D5sM4jc4oSKXVR8B0syAHpTi4bgJ4
	ntsPs1AurQoXxM1d+Znif1Ot9nuzgpzxZNzDF7jweW83SjA2TwDody+V7XRgqXfUdSDJ2zR2gvs
	uSuMeU3pkdC41Q5a3WjxjPGzBCLnz92NMrp0g/XC1OHQePx4bxwr2ju11m+CDJ5qPHTkdqrTFCy
	edApPt8xq5hShDm2z48MrvpT1rzPYZmjcgyCb8mi1NuVuhocBkYa21s8v+FAZZhFlrlgi0cOyai
	cBCTY56MMJHmy/n
X-Gm-Gg: AYBFou2AhsAQ7IFy+m5pg+BV4JDQfn/P25G2gEHUGyQVVHh0wmMpBwITQf2F68KLg6X
	3PlVo1dridiE2ncGJ6/6IuQgdaw6BsMvdYujNsTwNtAygo5h0UKln35doArEzOxT+TQGJ5aU190
	Dka+5RjQq5O17ktSZOaybziZl7vQBii1isAjOvvCLOCsI1yTa+CcbGFpCTosMgY79btOuwwdqnc
	XX2TDQyo4R7IQBkt+Bpqpvhg4pN3MkBBt18HDnHbKAa0mhWNpJCW2gsJ/DwwFiR7HInuz4yr0iD
	/D7Y5AFUrbwFr5DdIofFApJaFsgp3TCQxO4VFQzfP3QkjdfmIoUZrjksmUNmchFxguPW+znotV1
	SiB2DAQ1ksxHoFxLZ3HBKOAvhy8KpWlOHkbWoewyqMafl37YC/vLSSTO6oL9M5KklcIeNwK91Av
	mGHPyVA+a6SEOtLJ5FnKXcojg7MEYbylGkYEqfeJr1VSc=
X-Received: by 2002:a17:90b:384c:b0:3ab:f38:2b43 with SMTP id 98e67ed59e1d1-3ab3ac86fbamr2149985a91.34.1791561861457;
        Fri, 09 Oct 2026 09:04:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab36d74b2fsm1334095a91.4.2026.10.09.09.04.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2026 09:04:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso4511218a12.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791561860; x=1792166660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QPvsAsFKROVd2IVDjuabUUWH8AsyeJTOH9zIP0FhFmQ=;
        b=TgEKNZy3DPhCiQ8UCJyTzCPtlwdvITlK6CDZsWcUtmtu+20RmL837M+/Qzy5DQTTU+
         NXWhs9C9+7olvE+hTBpWxyGaaRQUZ/uQpXyCyjo8QaQEcv4sGwAhHfqs0tuAcVUHLnRz
         ECe1pJoYVa3UtmB/qv9zU0bVcFC9H4pSZrAbg=
X-Forwarded-Encrypted: i=1; AKwUvBzEytMQ+8yu5ACFkn1v5GTh56b5PScFz74vPqK+ZXYLNUkIZlXScLfzyl2noCKKSEpxo4k+bbg=@vger.kernel.org
X-Received: by 2002:a17:903:2283:b0:2e8:3d48:4d80 with SMTP id d9443c01a7336-2e842ab6dd1mr20887215ad.45.1791561859724;
        Fri, 09 Oct 2026 09:04:19 -0700 (PDT)
X-Received: by 2002:a17:903:2283:b0:2e8:3d48:4d80 with SMTP id d9443c01a7336-2e842ab6dd1mr20886935ad.45.1791561859255;
        Fri, 09 Oct 2026 09:04:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e6aasm12197475ad.18.2026.10.09.09.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 09:04:17 -0700 (PDT)
Message-ID: <3b1a2994-5251-4800-8c61-b63d7a435b21@broadcom.com>
Date: Fri, 9 Oct 2026 09:04:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] net: mdio: bcm-unimac: implement timestamped
 MDIO writes
To: James Clark <jjc@jclark.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Nicolai Buchwitz <nb@tipi-net.de>, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>,
 Conor Dooley <conor.dooley@microchip.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>,
 Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-6-jjc@jclark.com>
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
In-Reply-To: <20261009143506.2507607-6-jjc@jclark.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/9/26 07:35, James Clark wrote:
> Implement write_sts to provide system timestamp bounds for completion
> of an MDIO write. This enables tighter system timestamp bounds in PHY
> implementations of gettimex64.
> 
> Take system timestamps around the command start, then add the time
> from the command start until the MDC edge that clocks the last data
> bit, calculated from the reference clock rate and the configured MDC
> divider.
> 
> On BCM2711 that edge comes 64 MDC periods after the command start, on
> average. This was measured on a Raspberry Pi CM4 with its BCM54210PE
> PHY. The PHY's PHC was read with PTP_SYS_OFFSET_EXTENDED while the MDC
> divider was switched between 9 and 39 through /dev/mem. Any error in
> the number of periods would make the PHC offset jump at each switch.
> After compensating for drift, the jump with 64 periods was under 10 ns.
> The MDC divider appears to run freely: the PHC offsets spread evenly
> over one MDC period at each divider. So use 63.5 and 64.5 periods as
> the lower and upper bounds of the delay.
> 
> Use a 200 MHz reference rate for BCM2711 GENET, whose clock is not
> described in DT.
> 
> Signed-off-by: James Clark <jjc@jclark.com>
> Assisted-by: LLM
> ---
> When there is no clock, unimac_mdio_clk_set() assumes a 250 MHz
> reference rate, and no in-tree DT gives GENET or UniMAC a clock. For
> BCM2711 I have no documentation of the reference rate or of the clock
> that supplies it, but MDIO busy times measured at several MDC dividers
> fit a rate of 200 MHz. This patch checks the parent's compatible string,
> which is unsatisfactory. I would prefer to get the rate from DT, and
> would welcome suggestions for the right DT description.

You can, and should define a chip-specific compatible string for the 
MDIO contorller node. We have one for 2711 already for GENET 
(brcm,bcm2711-genet-v5), so you could define brcm,bcm2711-genet-mdio-v5

The clock frequency is fixed, so you could also provide a fixed clock to 
ensure that the clock frequency is derived correctly. I will check the 
actual clocking because 200MHz sounds odd to me, since the RGMII 
interface does require 125MHz and therefore a 250MHz source makes that easy.
-- 
Florian
