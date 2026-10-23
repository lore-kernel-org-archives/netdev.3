Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792786135;
	b=qWaTBkh40kuDq5dX4GlylNZKzwPg5t0fWfqzLuez+KvP5w57esqoLITKVxzOhgpJleWJ
	 jpQptQ/yMeU2pPrwuJUEI/dc2TLMqsUKvZhyOgoszDIlW1fVKMIINh5riEDa4bSNMZ08d
	 znRKiLZ/GbGcTN6CL2ZVcf0sv9nNW/X3/wP0kX4TDAurbZrOOZgNWMvB8ZZFiucOINjvD
	 7RsOlmQVPU8009j4RjsV7+xp8YSfi14q8fJLhsMPQDEHr9he+Jcro+tMfG8KixWDhJcX9
	 l3UmbX7YYasy5kIFpBFqEdvWDvqRRd0zmCghbaiH4eb98Dd+fE+hquGvl0pPbuJ0g0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792786135;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=wTZgu3dpY8yCPiHCSe3dgdypZFuw0DXkkwwCRyTZNgY=;
	b=aV7hYwcE/hqLnqaITEtljyoA7CSXUtA6lLJgn/CWbVgTlmhyohrE0SuOLarYkIDPT32z
	 JpANVGSbHLjKi2ovG3+AUxwG63iWXTOTYaydoWsI0WmhvlUBPm6IeilFSaOmuRFrb5mww
	 k0Kf/5t98U9cMR9D1slpGf2nqcU3c3g6H2/eO6o4WM/wNwYEqzQ0wve978AIAsN8tAuVb
	 eGNkFQpCt5lQw9gY0SzmXd+PX6XeOmqUHlK5qV6Irutfmt7XPh7zbba7n+t1iruNxNuLV
	 3shuF0qaURz4D4ODsQIXIg6qT0Hgd+fIBnwvxwSDEeYXSFBFsD7mt2ttqZ+zI7S8oyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YAOvWiQO;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DBC606A31E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92DBC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YAOvWiQO
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so973712a91.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792786134; x=1793390934;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wTZgu3dpY8yCPiHCSe3dgdypZFuw0DXkkwwCRyTZNgY=;
        b=JF+qc893T7uLZxnzci8HU7hm/8Ku1pRsnlU2/XL2siVdPAVZ6urt5HsUbGjjCS8I/7
         TxaUY/+ON9Qvh77ktzsQC+6lAGQCRK8lZvE+Q4T+sncqUkvySKcNLM51L3EnSfQPTLfk
         fuIyAgapdDpZbijvlTienxuz8ZgfEdk+y+yhhb+Xrf2HEnEDfmR+Z5jRZYMdt7kyIZg1
         85AMTgi46tr0enDkUG6vIO+bLjt3cbsjRhUlhwD6gCqLY/UBiWn2Kfr+iCDbIHFztYQ5
         vwCRkYG3Uo6qTmeCxMaseoGsF8gDcrq/RToiiakOyqIaSuzJ4FBU14QWkPUNnyvtIm1k
         p0Vw==
X-Forwarded-Encrypted: i=1; AKwUvBxtRskLxduZzVuU9S3rU781i+5W+YYth9aT0bEENvPN38a6f6eJbSQpUlFge0wQONAM7TkngfU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBE+ENP7BT7i5zyq/7SBAASjcFQZ9u7f5NAi2CDxQEWkuVaOly
	TAJ5ODrhHv1jRrYvTg/sat7AZWor41JvVRtwQ95FrgwkNFVIksXs0mxc7gTxFjxNBuBpK53ZU5S
	Ewtna8hnBf54hfoUGYEQPdZ/aCbaZaykwfggsnvEw0zih41fl2xTC8Kl4bHoJ7uPb9FNuDPL/7Y
	T0goRPWcG/Pp5FI91fm5A7BCmF4WygKiLNn9qY2Iis8D9WtWRxSWVYL8VoRs8SI8UWrKaj+wd20
	fpLigPzImxV1cB1O+4=
X-Gm-Gg: AYBFou23LtAYqhsBUKJdhNj2WCrFnXGa/6Bc4EAzqAuPgn8astl2LksJKC3hqJz7qio
	gWsE+CAkGQJsH26IAIwimoX6TNZxb9GSCWIrOqAP268I5AcN9z0bz8OtyLqpXK/96cRLTneP3UO
	QIfeOYKOKo/10EF1gIQgJNLSx9JzrfinWFU3Ubp4xxclR9qfH4zXOTiYrpgU4SNvDNu5bfm6fNi
	HockLb2rQ1IEJ9Jw1slHVd+uQsah2FK+h65YPusGv5mdKSGqD1muDVtCw7Vlos++Y43Da2VyevL
	vcXHoxRPWMqhBy3ZT3NObuJOtHs1fN+C+9w/xkSyLnadH86pDyUW6KauTDSY6nF9EBTg1CeVfot
	Gk5wo5XpRsJFbZldSSx0UbRsjU4oW+p0ZtdJDyLtDU0N8F7XPszN/XNeIuaWIo5PhwxihaVNEyV
	ZLyhU/b2bKapGs0+JIlarll4L1QOmnA+5W7Tl8xVWY
X-Received: by 2002:a17:90b:164c:b0:3a4:ad5c:d48a with SMTP id 98e67ed59e1d1-3adeb121e8amr301550a91.67.1792786133976;
        Fri, 23 Oct 2026 13:08:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ea9b1bc842sm41385ad.38.2026.10.23.13.08.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2026 13:08:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2130874eec.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792786131; x=1793390931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wTZgu3dpY8yCPiHCSe3dgdypZFuw0DXkkwwCRyTZNgY=;
        b=YAOvWiQOx8OoeCvVmx87RYx8/77SQARgJwZOL31KlT+bQIRg9wM+uG3mKqbjMB3+8N
         ppFb1u1Ie8WWFp6DI4x6asTiZdpwsjYTECdcepmJYcipyX+pQh2wPvYUbpKB0yjOFmqQ
         hyozQBJgImnc8AunBOZVjAbPhXyhhW/TQc6Ps=
X-Forwarded-Encrypted: i=1; AKwUvBz+aYF6D//SJTELUlpvQkoLJeZ7S+OozI59n6ZimrZ1hVthVwl4e73LZI4VrDibgKfLYcirpWg=@vger.kernel.org
X-Received: by 2002:a05:7022:672a:b0:15a:4155:3d9a with SMTP id a92af1059eb24-1993f6d826dmr200566c88.47.1792786130935;
        Fri, 23 Oct 2026 13:08:50 -0700 (PDT)
X-Received: by 2002:a05:7022:672a:b0:15a:4155:3d9a with SMTP id a92af1059eb24-1993f6d826dmr200474c88.47.1792786130014;
        Fri, 23 Oct 2026 13:08:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2eefbsm775867c88.7.2026.10.23.13.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 13:08:49 -0700 (PDT)
Message-ID: <bbc66ce1-8d8d-4d35-9314-98fe14082690@broadcom.com>
Date: Fri, 23 Oct 2026 13:08:47 -0700
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
Subject: Re: [PATCH net] net: bgmac: fix oversized RX frame check
To: Jakub Kicinski <kuba@kernel.org>, Rosen Penev <rosenp@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Felix Fietkau <nbd@openwrt.org>, linux-kernel@vger.kernel.org
References: <20261023005313.3946390-1-rosenp@gmail.com>
 <179271707120.3327.4775409276963055481@kernel.org>
 <CAKxU2N-_Th-ksPst_1KR3W1nYWoZpWR2Sjfo=RWroot5A1RR8w@mail.gmail.com>
 <20261023123637.1aba3995@kernel.org>
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
In-Reply-To: <20261023123637.1aba3995@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/23/26 12:36, 'Jakub Kicinski' via BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> On Thu, 22 Oct 2026 18:00:53 -0700 Rosen Penev wrote:
>>>   - How the issue was discovered, e.g. hit in production, hit during
>>>     development, syzbot report, manual code inspection, LLM or static
>>>     analysis tool scan.
>> I added Suggested-by in the commit. LLM only used for the description.
> 
> Suggested by is for suggestion of how to write the code,
> if Florian reported it appropriate tag is Reported-by

This was a suggestion, so I think it is appropriately being used here.
-- 
Florian
