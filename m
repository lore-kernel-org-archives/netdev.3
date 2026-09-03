Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FFB4D8DBD
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449049; cv=none; b=rA4iXJnarPAZrkaHUwErr7tPOCwfmxnQYO6FI3J0qRKp/BiqSXmDosSLjxJz2eW2IRnym7SpYi72p0crLf9qrDo5aTmwNhe3PW6J0w1yuvCb2hCMxtgJCA1TaDmfEsnMmZW0N0YkUMbwKjPuB7Fc+dy+/5vx3/p7GePkQbFsdgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449049; c=relaxed/simple;
	bh=omShexslEO0ormzdaLwfaqKk2Itx1pm+zftJ+FCoHV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRMaHitu2ZZRSCnmnmO1KpFSzVDuirBviHBs2TT7NVbUxqbSgxdqrSgD0Pf1E9ZFIBmsu6hBqEBR3A/E3gtTRch+0fcmwUbCkc7wqxGjpqM1GnVg7JDvPCmqNr93zD+B+0qYSJtK23W+xkF1cremvajfFHCmZXFZHpkaBewTS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MO+W1pwA; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MO+W1pwA"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2218360a91.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 08:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788449047; x=1789053847;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1lhliXRyJiQd1jmS684fOdzwqNj/3SOH6gyE1zgaeSI=;
        b=g5NpPW8QWKRyyAbM84agbMYvYcGobWr7CHMHSxMf5h6A+m7cxVeIT6+K28DKPXaBuO
         3Qb0b0ZKwOUysZjXiFZWzXVVyaXLO3FsXdS+h0quXWdE6NEX+meU/xw9o+XESkVMe7jO
         ChjAZUglOnXdVW+rBfM1TzXh3MX+HilNYa6J5icdzpS5wy8qKsnmMAwv2wuEXmK99C1M
         PSXXrC/+uqgvJnpHDk0oI3muHbUt3BqaHcSKR/HLZ58VsPtR/rgIrfuqlwesmjPQGum4
         GPaAUAB4Nevg8RXM9Hl7rV2uTqJFOVDNGy4vvxYLjYGVUNwm/tVDBMWStHWfb720Z1bm
         pyYg==
X-Gm-Message-State: AFuF++lmpvZ2E5p49uDSUnyAx8W5Vs6H1NyMzNgCNZ05nbRNO8XlKiC5
	DHWA/fMoqYT+C43HKbjtHrt70Np8mVaar8aEDcdTw9oxRdiCHRiQPXBab6TwB5xMPPfJqV5b4KP
	ex4vyrINNAhSndF7g9QB5nWXdKhwkd3S7wwPbdc1dC0ka1OP06J6EEvpVME2BAqj50s3FB45dAf
	RZHKJGiqBblcBJ0l1yfSA1AsAtNLk+TxeSGfUzba0B7Rsu/Ui2fQE4ConH6J46hpQhnMauqXc96
	BwDVwKyXucgUW4j
X-Gm-Gg: AYBFou0vBd+0a3gtCeEeq6W0WaowVb8xp8FPaQSz6P9P0nrF1KTP/bvty5phJw/ly7C
	0k/m9PcAwlKgcer5/TlltqUeZK3airsyx8CR7scIzGupT9rfvUQwRK+V7jKI6P6EHqJ9l10Apsh
	S+Owb+ZS2rx3kYQem5QgvaDpCeYXxN5LJnYMGquyOErLa2jsoweQ+UFRnGIKLamRiFKdjbEhlTb
	ioPGwMUGYbEe7e4kI2AbYOfK3ZKgv4g9Y9lAwJ7jdmmVKm1nOtHEfL8LQjcYogmA7iyLv39ZR4l
	XZBKIBH506fc4pybaR+M1eAoa5XqLsi2i2yn6tDt3E/iUsonxqQsisQcssNfEK7ijUBkgju3Jzv
	x5ZSVXRds5/1BpvwOkOuTFvHm/LxMlZbtN6HU+x3AKM9KvvZH5GkCffMO8NTCydooFBvQhVcEXW
	0IhIyrl45kE970EFKibY1mXT8Qh1CZPv5DZFiZW4xv
X-Received: by 2002:a17:90b:4d0b:b0:380:f389:447b with SMTP id 98e67ed59e1d1-39b22ce8b5cmr659890a91.11.1788449046686;
        Thu, 03 Sep 2026 08:24:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39b15caea34sm1146547a91.2.2026.09.03.08.24.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2026 08:24:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6f73d0f89so32564185ad.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788449045; x=1789053845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1lhliXRyJiQd1jmS684fOdzwqNj/3SOH6gyE1zgaeSI=;
        b=MO+W1pwAnpVi6JBel1geQD9eutfxSXjqfPSpmLdu/ZQ60nj1672+u/5/dQZ86N/m30
         ucMSbHUltDzOsSkmXs2QU2kTmSSONCKEQd3k5e8qZAE/6znkXblAA5lD6IC7N8VqubWg
         OFd/OPPR0+Yil8O0DievK2xnQ0unwOONfGSA8=
X-Received: by 2002:a17:903:26c8:b0:2d8:d4ce:9f33 with SMTP id d9443c01a7336-2db105a569cmr6865505ad.17.1788449044481;
        Thu, 03 Sep 2026 08:24:04 -0700 (PDT)
X-Received: by 2002:a17:903:26c8:b0:2d8:d4ce:9f33 with SMTP id d9443c01a7336-2db105a569cmr6864395ad.17.1788449043806;
        Thu, 03 Sep 2026 08:24:03 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33253672b6asm7234065eec.1.2026.09.03.08.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 08:24:01 -0700 (PDT)
Message-ID: <09bf93ba-7e8f-4488-a728-07bd133be6e7@broadcom.com>
Date: Thu, 3 Sep 2026 08:24:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] net: dsa: bcm_sf2: bound the CFP rule dump by the
 caller's buffer size
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jonas.gorski@gmail.com,
 andrew@lunn.ch, olteanv@gmail.com
References: <20260903032611.3000029-1-kuba@kernel.org>
 <20260903032611.3000029-2-kuba@kernel.org>
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
In-Reply-To: <20260903032611.3000029-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/2/2026 8:26 PM, Jakub Kicinski wrote:
> bcm_sf2_cfp_rule_get_all() walks the whole cfp.unique bitmap into
> rule_locs[] without consulting nfc->rule_cnt, which is how many entries
> the caller had room for.  ETHTOOL_GRXCLSRLALL requires no CAP_NET_ADMIN
> and the ioctl sizes the buffer from the rule_cnt userspace passes in, so
> once an admin has installed CFP rules any user can ask for fewer slots
> than there are rules and run off the end of the allocation.  A rule_cnt
> of 0 leaves the buffer pointer NULL and the walk dereferences it.
> 
> Fixes: 7318166cacad ("net: dsa: bcm_sf2: Add support for ethtool::rxnfc")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

We had the exact same internal patch we were about to submit, thanks!

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

