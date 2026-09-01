Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320BA32FA2B
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222293; cv=none; b=TV4vztW6B1xhlxeSQq9ypMs71umGSgANDJrAHDYBKsRGbLteBauKmd/Hxu59lNMX4EP+spcYgUmku2puG2KNs5RFNS5R4EcXTufxZUZ9vAakfgE6GnxrY8XFG9jwXAmNU3PZh3nwtSslA0tTew0dxxz0E+mrfhv6yFVFqR8Br+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222293; c=relaxed/simple;
	bh=530T4/rw3ieoscDtHqSy3ulDMef5Xa8Z4ignHnHROx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAzhmdmIfqeNdrIRq2avMV2Bb2MuIjlLeci+qauVoa0r0uLV2pf++Ju6YxBFA7CIsJlhk++POQRaI1M7HxB2XrIxSYr+KFYFaY9HSLgI+60r7nEeYHiwUZBh/iaOiddWeHjrgK7VJVftMtb21fA5IDNj8cxrjglx4Yh/7hWtUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XHMQVAQG; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XHMQVAQG"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-381b831d535so655260a91.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 17:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788222290; x=1788827090;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CZgq3ZO2/IRbFeKpzhpHQ+vUPHDN8CZFNbGpniI+he4=;
        b=IKsWR+UBdMltNU7K6z+qxG4y2ApAoOtGVWnFMbg6qJnQ0MoocI53pu13gnvg/ZOu4g
         PmEwO6GmgBeJ9YBeV4GnPnJ1rMV7AdJo9IopMtsyVPowOfzkN5a7hcRDcdWUKE2mYMCJ
         Z7Xg0btfBBIuBQyRdPPGZpvxHgB5QcSWEYlwbD018RNH6VjOd1L5BRocFR72n24MObH8
         Zz+FAgLx7CL5/BR02jO4Q1dCsKq5baTQsrW83TI++B4LkSzz5Z33Xc2GxtBxqyMwiq/p
         l8TGajmNbXzisSa+0bmeCbaCYh/QTTqYicubqmTgazRnhZ99ZkeWInsVFPq68kcYowzG
         1S8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwJfvSkcxKuxya6Rr8SjgKassxiMu5OryTYXlG1pLNNC/z6Z8WOVPNNCi8RsbDp9IUTRRwHwIk=@vger.kernel.org
X-Gm-Message-State: AFuF++lMR/BV8wDMEQ2D45WEpchyxdy3Lg+QkD9lNIy1aGVInTiJXdAs
	pU6VY0xB7ZIF9H1p0u9UDKfM/oXmv35IRGTIMHUub3I4Qha650Q3em1EWKmeF3/7cDGz0T8A647
	n1P+DYoEnMfoZW60qGPYigVtzic44MqDmny76+5SnHZwipJ9NYm0QtXoJG6Mw2sSfODajHRhVl6
	i8LI6ZcJ2sa+C2R1pPPPigRvptSkOayNQk3qNnaUMJsxhJWXc3k3KRFE7nMBZmCxWa2gILrtLnD
	6GXMOMxnhMddRbL
X-Gm-Gg: AYBFou2PnRuleXg1/Qo9U2fI3cIjExVRBXbFfWI2iwSuavnDW/VML3VHBUontXmrn/x
	9bWOzNu2z4Go3xx/1Mbtl55DO+rIxIc2ApeqzFRHj/c6TPcqffW3Qj8zE9JP1681jORYISRh2RI
	FjyEqBpbhFJrYfreX5zaX/hwTaS57+CRNPWAHFFR/u5Qqn+K8sazsQY6vzB6q/SQoLJEPVYSu9V
	8Y/pvAk8i0vp0tA94d4ChjbjH8ioQfnfwTioxcJQB6CVVouDwds4KPGFd3MLx0RStrVZDotiiE6
	AA374P2x0HdmkuTe1xE1N04M1baONxH89naEeoilDAoVFrspSZUFCcX6RHBEs1qtuEfBY9QJiHK
	SutYRhMVU1D8p5AYJ1z6ocT9Vz5Ps5KMNX0Up3gU7JhkiCg8xWJwYxFVYnOAWVrKAVainBxryAj
	c+/NJ5H0Hr7uf06WKHWWjJ9Y8bia0yVra8Ud1Ak+4l
X-Received: by 2002:a17:90b:6c7:b0:396:6344:3b63 with SMTP id 98e67ed59e1d1-396d0e25905mr45857551a91.2.1788222290416;
        Mon, 31 Aug 2026 17:24:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3990d4d690csm344388a91.10.2026.08.31.17.24.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2026 17:24:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d9057fab9eso3945165ad.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 17:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788222289; x=1788827089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZgq3ZO2/IRbFeKpzhpHQ+vUPHDN8CZFNbGpniI+he4=;
        b=XHMQVAQG0LepNiEr1VhgctMzvbYv89+FrPu5bNOaldTd7WxIIDiFp3+Nfv4siQz+L9
         s1tCkcXqWa1/zPputtEzur6IeJIHmjg8vVvTjSoytJlV0QyPZo68FAdGHvSnm2AlZzQU
         riziSalKe1dEumeqYLAwadxGviQabeOgzYM7w=
X-Forwarded-Encrypted: i=1; AKwUvByY7qJm4nsQVpzR8ExMwFXTpykxK8edDK3b5DEiDfoWmmfE2zU1HBSgcFCf0j8b+UAokUkjXyg=@vger.kernel.org
X-Received: by 2002:a17:902:f54e:b0:2ca:61bc:317c with SMTP id d9443c01a7336-2d74def63d7mr467478005ad.13.1788222288675;
        Mon, 31 Aug 2026 17:24:48 -0700 (PDT)
X-Received: by 2002:a17:902:f54e:b0:2ca:61bc:317c with SMTP id d9443c01a7336-2d74def63d7mr467477355ad.13.1788222288254;
        Mon, 31 Aug 2026 17:24:48 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b0451sm39927452eec.16.2026.08.31.17.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 17:24:47 -0700 (PDT)
Message-ID: <739079cd-dc83-4b53-a3a9-a7e610379d19@broadcom.com>
Date: Mon, 31 Aug 2026 17:24:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/2] net: dsa: b53: fix 8021q uppers on standalone
 ports
To: Semih Baskan <strst.gs@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260831085217.391-1-strst.gs@gmail.com>
 <CAOiHx=md28_BmsDOsNDp0XbUpfih=P+-+aDYb6tiWPJTCu1drg@mail.gmail.com>
 <CAAsRjRktqEx+-CLDO_q6rLUBe1dtRQPH1NkX4xy7ichx79yGPQ@mail.gmail.com>
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
In-Reply-To: <CAAsRjRktqEx+-CLDO_q6rLUBe1dtRQPH1NkX4xy7ichx79yGPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 8/31/2026 3:17 AM, Semih Baskan wrote:
> Hi Jonas,
> 
> On Mon, Aug 31, 2026 at 12:34 PM Jonas Gorski <jonas.gorski@gmail.com> wrote:
>> I really think we should just fix up the in-tree device trees and then
>> complain loudly about the broken configuration on probe in case there
>> are out of tree device trees with the broken configuration.
> 
> I agree, fixing this up in the device tree is the more robust way.
> In the meantime OpenWrt can carry these patches as a band aid for
> the affected boards.

But you control exact how the DTS gets distributed in OpenWrt, why not 
just fix all of the DTSes there and have the users confirm that using 
port 8 as the IMP works?

Don't get me wrong, I am very appreciative that you spent a decent 
amount of time trying to come up with some sort of solution.

Thanks
-- 
Florian

