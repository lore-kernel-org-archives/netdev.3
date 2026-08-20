Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4054647A89D
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244340; cv=none; b=FuEuRiyCsrEbWDVnRJ7ol/3BE7s/o/T9YzmSdoOBmWwnptUv9hXkJ+Ju8iLSyKOJ3LP0S3Rwx31qMv+FV6YPP+8rMdrOATUcDols22d+bDDSuaVI+StYjPOTfHg+IAr0x9Rzpa6xvOa/OntgQyDxTY01nDic1lMVZMabu80ejYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244340; c=relaxed/simple;
	bh=tMTeQnPU4AHC6P8juFuQipmONxaeDx/+5W8F0d5GdHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ie/Y6NYV8XgFcbHPWtz4XJd0MOTBxVTpGzd4eJ/eo8JA66CPbxfslPIlElPJPgPQXRNC5oT644aEHeEc3YzldKYzVXihGrmidfetkB4vuE4IG9SAId0en4WMJd9b66RjhJkT7+a3+BEVnsEeEtQWCkg+lzaHjjFgs3BPBG5h21o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YDkvd6jD; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YDkvd6jD"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-39266382df6so1868493a91.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787244338; x=1787849138;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DFMRQQoRiG9HhTWXFbW2ThkhjhbmIH6Y0qXnbefRKoM=;
        b=g76v4aImvjCOCbC/jpScYlTG47CYaHhjMBKHbVOk4VA3PFmsJAcCERPv4P18eNlcXi
         cEOJ09p7hB9JhJKvwukwAkSfcEB/5J5CdufcRcJQsaE2KDsJzjp9MIw3xCfjZ2x+9vdo
         04ZyQbh83cvSDWhD2/2sQQaeR6lQjls3GuMOEzUzuNkBG8TbrIblkHHNXo9ziWmnrdcl
         I8aNPCkXtZJcWsFB6Rwb8UQaib5CoMvJR/pkO1BM1GtkpuKrXy9/QUpFjNznBowJaDTU
         qV1tPxNYHXzq+pGIbhWeQukbDdhfEJgRm4TCicH1csmi0fPlQyYJ6JMyBE9Q6z5lOVgd
         jgWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoqzMaTv8wG7W5kN1AtMUzsQqXi+e4mYKwLKKGBSpPmWvV4VZBIlzNA+mW3WlDsEYrH7lHHQtc=@vger.kernel.org
X-Gm-Message-State: AFuF++kSMEvTtCkpQE+oVvw9MyRvX1vUXQzUsZMBVHGijvS6AeBM8BJK
	ySO5/HBdBWma/xk6dCIl1zThBTZm0FFrcjG76PUuT3KgeuQJ4SMDHuzwKYhZUnlnuLgqjyi4aQf
	LT1K8XshG/aGqxovGRi7YrLRk1Q0Ay6IEamHJ67ZoW02Ff7zqzMoILlytK9NixKokw5M36oa6x8
	zPQJuFIQOZBJ3aNQvEF5X9u42nAoGEsLzWvjrrkqs21DsCQjXAVxQQRxT7a+A88vcV/Aq2UfrTh
	lDZP0CwAZTqBUQo
X-Gm-Gg: AR+sD12TgajtOIst3z6o4CqYOxvfOab+UVTA07zu9IY9ar8BbYhpRdw6k1jTX9ZXEXE
	bWVpZuhbm2Yi9ooLkdMQ++4IFw8UyrS8ipZP30OvKE5SD/KALRDDtWqMoyz7oHL6Xl73aqZlau3
	/xpahlvuoZeWjt83QjiMSOKbda9SYao0NSIlKSaW+YsLN0WUuO+L/5gvb023kOx/+anMYML94HS
	ZRUE2ZAtjL7XdV7Kbo2RlHaUg1ZC8spn+AaC7vOifc+tzCbKsSTQTShiIDH7GD7XYTfOQbtClQb
	QXTi+zqKmu8jxIYFP9I1GsTsUCWjQ+foPG60e7popXE2pFpc/oYe0kYlhrcBTUjeec2JPC7L8vt
	DEKnEFG+coB4RrbpUBExc7ljKfNsCS+p8v7nidue4hLi4kF6FVjsskjN6JqAuLiDY7jJQC2ImRR
	UKiU0PMP//8vX2PeMsa1G/wuAl0udaN8wWo33uFI6G
X-Received: by 2002:a17:90b:3145:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-395810af13bmr22715275a91.16.1787244338251;
        Thu, 20 Aug 2026 09:45:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3957f65a9c1sm2583125a91.3.2026.08.20.09.45.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2026 09:45:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cec4226c70so891345ad.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787244336; x=1787849136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DFMRQQoRiG9HhTWXFbW2ThkhjhbmIH6Y0qXnbefRKoM=;
        b=YDkvd6jDdfSB27Sw2G1BxtmG2W9ldQ2B98mXWKkha0ExBbvm/j9s5BU2IbtZaqcSsK
         ax1lLUVKnjsi68h2wWUABLqjFSEsQcMhoj5hLfLXL8ZsQd8T0vL9H8J029mPi4fmFcC5
         D5VefLTkosnU5XAC+eg2mdbeO7/OH7kwR2HWg=
X-Forwarded-Encrypted: i=1; AHgh+RqjR8qd31rS5KoOrE+BML/Z1Oo2+jP4OveRRspwGFEU0AL4M86AiQhNRHnckDLJhxA5e6Uv578=@vger.kernel.org
X-Received: by 2002:a17:902:ebcd:b0:2d0:401c:2ebb with SMTP id d9443c01a7336-2d5fd73444amr281636285ad.4.1787244336484;
        Thu, 20 Aug 2026 09:45:36 -0700 (PDT)
X-Received: by 2002:a17:902:ebcd:b0:2d0:401c:2ebb with SMTP id d9443c01a7336-2d5fd73444amr281634745ad.4.1787244335995;
        Thu, 20 Aug 2026 09:45:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d555b5csm9613845ad.6.2026.08.20.09.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 09:45:35 -0700 (PDT)
Message-ID: <cc18ef57-4f5b-4459-b110-b29bf2c8b8eb@broadcom.com>
Date: Thu, 20 Aug 2026 09:45:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] net: broadcom: Improve IRQ error handling
To: Paolo Abeni <pabeni@redhat.com>, phucduc.bui@gmail.com,
 Justin Chen <justin.chen@broadcom.com>, Doug Berger <opendmb@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260820111456.97947-1-phucduc.bui@gmail.com>
 <a618bdba-c370-4f16-ac09-0f7ceb742d42@redhat.com>
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
In-Reply-To: <a618bdba-c370-4f16-ac09-0f7ceb742d42@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/20/26 06:30, Paolo Abeni wrote:
> On 8/20/26 1:14 PM, phucduc.bui@gmail.com wrote:
>> From: bui duc phuc <phucduc.bui@gmail.com>
>>
>> Hi all,
>>
>> This series improves IRQ error handling in several Broadcom Ethernet
>> drivers by propagating IRQ lookup and request errors instead of
>> silently ignoring them.
>>
>> The changes were found by manual code inspection and compile-tested
>> only.
> ## Form letter - net-next-closed
> 
> We have already submitted our pull request with net-next material for v7.3,
> and therefore net-next is closed for new drivers, features, code refactoring
> and optimizations. We are currently accepting bug fixes only.
> 
> Please repost when net-next reopens after Aug 31st.
> 
> RFC patches sent for review only are obviously welcome at any time.
> 
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> 

Not seeing much value in these patches, to be honest.
-- 
Florian
