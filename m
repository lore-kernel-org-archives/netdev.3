Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385519;
	b=v3/mswTdXTjzLVnYZuvv6xpIbJUa6h1T7gP0/OVZYatgjGdrsCMRvtA0aTtBwUGbsaAN
	 psOuuHr2fiiyi5/4hqElH7RdY2Ve/Xv/XiMqeWcSR3oj9XkcV0owzJpPoELyLTxfBM7IU
	 nxNK6YZ/89+58OlsQstHt96gwO7gZDoKEQKQqOWflF/VhqMbzj//yzRnVBr1N4co0xrkU
	 uupx5rIsML6NpfkkVjNJLPmNW3ecSyJgdbdVmptKkUVdZhSIbgIqXEvmctAnNi1mupDzV
	 aVh//JNf5qGg2Vi7LGASsEN+pYEDjslwSlt7eigzM/fFJuJ2vNuUThLmE2rttdKaQuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385519;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=enl1EseFXkx+U72ZVPGkzqGa2JIB15t8eF9UI8R7/0Y=;
	b=BjfaHnMzIqbVDP/KI2R/uGv+83GZTGwamuM8MjiDB1RCnCw3wRb97yvkNZXM4lUFJ2s+
	 m1nkBBDB6qvVpZhLKn9k1JmoBSoHV6Og6f43vjygscGGtUHHjxfc8kaLECZr0Nfbpdzdj
	 wLBXi/ihKgc6IVoNMjw+cIniRp/tw+KiHKglHOjqpmDGB0gI5UQ34xUwXCByMScxy6HJC
	 E9izS93m4WHd/9eS2rZ8YgMpXiuN/PDHZvsZI0akP6+htfGN0L1ke73jKibRMMLt8eIW8
	 0ZumGBm2/GN4qvG/ea8sK4UsWSwTJSq1zK9YH9JXRkx33EW7mZsVF3G/lVdLR7si3RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="O3w1kDJ/";
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49C9606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 18:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E49C9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=O3w1kDJ/
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so651671a91.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793385518; x=1793990318;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=enl1EseFXkx+U72ZVPGkzqGa2JIB15t8eF9UI8R7/0Y=;
        b=QkeRcspSUDe2gTmWH4677v2O4dm5W9Dh82Ex4qFURIQ3VZFdrMs1SFlw597oyZapq6
         HtojySqu159XcTcGgjMii0xDNqI0CYkSzbYlb1fT1iFOWi1ndFefAixSuI5LhvfR59wG
         6UEXqcX7khsKqy0VtTxOozq6m5ygX7sSxWbZH7r+BrR6nGJmzJte7/Kchh4RzsTLbacf
         JTkL5mm8wAWpt9rFfIs6iysJAQl0QyegrjmG7KzdzwAQcviUWxB4Ad5no6Sc2ubqaiIy
         8QEJ3A6mM1NtWzXmMNcHYjsmn7tjDezB8bm0YEs079DfK7z5ZunIsD5EL7sX9jjNphDU
         6Weg==
X-Gm-Message-State: AFq9FYJnT0B/mi2A/vtUBrG5oJWFMxWDmmNcC0HmX6JbN4bp+GTbFsro
	5Vgjr4bTJOLhZCzdLc69oXbzixVNod1w9XSqepARqN3K9qjNwtKx6he5zf95X7GNqAloJvVWZOc
	xQzgIIQwkWJoA3U5VL/bKk/ZX4cNADZR7yDn+gPAQzK/RkN72l0lVNl3SniIpHQqtqODgODiy0y
	keYvL7sKAJQuMRrYeIPuWw/lLPmQ9w1D8/8EjQw4ACKtWwONwIfE/ai8T3N40DrbjkAn1S4Bths
	UXO9urOUMYhwAxhBac=
X-Gm-Gg: AYBFou1OG6km2NslDJhrEqq6ujEpS+E8XFi7q4mNaednYMCEEWrdhySXWentupqYn1c
	gVgpjazvSVXssS50HUwdXEwgQEU7PjqwhINqUnRsOTB4bQClmwrke7Fx+LMLD6DUtFFsXnaOk8w
	1YmKzXWcsIaAxdcg8y0GXmU+ZXtF87Vy/RD6eCAzQVqw7FTqnzBWO8qOqJ9H0qMkWN7kO0ib5i2
	sjJZSGbBzEnYy6cemVGoaQAv6tPXh1iArcuogeBl8QeeFLLtVRMoeke3wkD21pC6JfYUHIYcyoO
	1yFD6sL8XZ3ukxOXFDKb76JnW4YwH0NtJxbxfnHyYtjTyNi5XWwEzEVSCiVCcFT8Bktp/hIpmnI
	FMoPlTdBL9/aV00HdIdI1Im3/xPY4cD8bm5jTOlR49d49IUffW98xae4VpyErF8LNtaXxBOC5jY
	p2GzeJASOWMe6Tg1akpWO0OID11YtZZk4QzaP9w1KP
X-Received: by 2002:a17:90b:1a82:b0:3ac:9e76:aa98 with SMTP id 98e67ed59e1d1-3ae89853900mr2621968a91.64.1793385517628;
        Fri, 30 Oct 2026 11:38:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cdb0962096asm62556a12.3.2026.10.30.11.38.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 11:38:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f1e62510cso224615785a.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793385516; x=1793990316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=enl1EseFXkx+U72ZVPGkzqGa2JIB15t8eF9UI8R7/0Y=;
        b=O3w1kDJ/d1pBpglxpfX2T+WkgeqA0ruNqnILjUgBq551+kdLBtByLgT9WdBrvl6A4f
         uQafciPYYqH6qElxkbVuGJTukKvawi+2jhqDOxINa+4Yk2DEaBw0G2kc38Ym9kyk1n4T
         QWxRybdzl9zuMsbzieSrvAHrPI49ioE5fX8PA=
X-Received: by 2002:a05:620a:2b47:b0:93e:c06a:7313 with SMTP id af79cd13be357-9442171a09dmr534077885a.13.1793385516092;
        Fri, 30 Oct 2026 11:38:36 -0700 (PDT)
X-Received: by 2002:a05:620a:2b47:b0:93e:c06a:7313 with SMTP id af79cd13be357-9442171a09dmr534075285a.13.1793385515719;
        Fri, 30 Oct 2026 11:38:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944252e581fsm205824185a.3.2026.10.30.11.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 11:38:34 -0700 (PDT)
Message-ID: <23f8cad1-d1a6-477f-bb3b-f3471ec50d21@broadcom.com>
Date: Fri, 30 Oct 2026 11:38:31 -0700
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
Subject: Re: [PATCH net v2 2/5] net: dsa: b53: fix the SRAB grant timeout
 check
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 open list <linux-kernel@vger.kernel.org>
References: <20261028212310.3847553-1-florian.fainelli@broadcom.com>
 <20261028212310.3847553-3-florian.fainelli@broadcom.com>
 <20261030113422.xg2sinp5hdiyfh4p@DEN-DL-M70577>
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
In-Reply-To: <20261030113422.xg2sinp5hdiyfh4p@DEN-DL-M70577>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/30/26 04:34, Daniel Machon wrote:
>> b53_srab_request_grant() polls for a grant up to 20 times, but checks for
>> an iteration count of five to detect a timeout. This rejects a grant
>> received on the sixth poll and reports success when all 20 polls finish
>> without a grant. The latter allows a register access to proceed without
>> ownership of the switch resources.
>>
>> Check for exhaustion of all 20 iterations instead.
>>
>> Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
>> Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   drivers/net/dsa/b53/b53_srab.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
>> index 83a03fca142a..f4689078ccd5 100644
>> --- a/drivers/net/dsa/b53/b53_srab.c
>> +++ b/drivers/net/dsa/b53/b53_srab.c
>> @@ -105,7 +105,7 @@ static int b53_srab_request_grant(struct b53_device *dev)
>>   			break;
>>   		usleep_range(10, 100);
>>   	}
>> -	if (WARN_ON(i == 5))
>> +	if (WARN_ON(i == 20))
> 
> I wondered why the initial check was i == 5. Seems like b53_srab_op(), just
> below this one, has more or less the same loop, but with 5 iterations. Probably a
> copy paste error.

Yes, that seems like it. I will be addressing the late Sashiko feedback 
received on v1 / patch #4 and re-submit a v3.

pw-bot: cr
-- 
Florian
