Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688635;
	b=2PtZdFEP9YVN8UROc7ZB98XFaGM593AxBQc01Gpb4S/fKdD8bw3f5lvkCYbRrDUAhWS0
	 CNs4/UoHn5tSW+PISbZOvLpPgNzCWcVN2fwgJt/LClfLRoFUVV3AS9yWVbk/ginux7H0q
	 KstnDd7lT2bRNS/wnrvkTcD0Q2MTvod/CoSa5uiait026AUtthlxBiGRlGxSUOIMgQXCS
	 pBLLkTJytxAlxcMZuC2YYmUdRfTVT6CgZ/Ac7iHBhAeb/HFkTBZene1TM/OQJ2AEDSEYT
	 8hAf15+EeJ/GJgkYj8XMmWBC2bnzqKbVSlFBYUAFxkpdhXvFzO+4s2yH5hGkfdzf0dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688635;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=KhrZm0zHiTnRcguhPzPRKqxL4jUA63f4qsM2/mVl/S4=;
	b=cV3WAwtDr569jDxGnxxBRXrKRU7+IklN/JP5Vuv3OlzKKjkrVj/Skqlz3Zk1rwnZJ6aY
	 nuPrnndBZq6Rq+vGbBTxqg/tKYKwh7e28sFKENK5iygDRArQjIDlqj2ZttbMUx1pSKFQ+
	 PKGM9T5tHTIw+gHWwzC3YGxJPkZSrMD0aE5Ch49KKRQ/iF6LCt91oWuMSCf7mmT9CjzwF
	 lLw4KZPUnzEjKeB9iaNcxfNS/9nfDD4jJSMPOT2n4yIE5bKgatCr5Pot4B8iejuLkv2np
	 1hhNmXio2Yh0RT1hVmwP6wARop/uWfJh5D1kth8Pdm60WKj/M5O16N1FkWziYCE8IrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HrM8gcJy;
	arc=none smtp.remote-ip=74.125.224.100
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9D606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0D9D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HrM8gcJy
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-67a2bd0c297so92439d50.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792688634; x=1793293434;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KhrZm0zHiTnRcguhPzPRKqxL4jUA63f4qsM2/mVl/S4=;
        b=NjKGxhCYmYj5REIIuAUNtKIHf/EY17wfS7iRsZyi9p+vlhu+vxb1pw0LjJb68OcNws
         aKjXsOJYTYlFXpqXRU1NIebvXwvwqI46kVKY+tKc2p8Nb+Bpis6SwPd8/+PxNCYaTMZ/
         Q2moshL48Lcdrbwl0A1vo/+tSm4FcmSEMuDRwxI00XPuRTGB0F007wAgqcpgv4E1FRub
         8lnt9C2VbHcGss2vwwWOs5jlMoBWtKm48vNuL2woGlxocZgqcLSVH5wOUZ8+alWS7SZ8
         BCPnqQypONotEp87AnpKsDQxLxLTdPIbgiIT1JcNKnpt4fjbbs8IN4HltXS7irAUI6oI
         j+pg==
X-Gm-Message-State: AFq9FYJxVjEh8LmmqBNxTvKlyw815xLx4hBKuHhoskcYvvQ9NielmUmp
	PqS8vloHO6S3wNLW39jX1TtPXrDH9eHP6q6jOOyE7xBsSpEGzlUMxZG717wX/qiJfMi1JnAZ1IX
	MU0Ycx13V1G5Ac0jjklNzz7LvfATy4miFGUumoKSpLXIuTSkQD8h01qBlV69+vI/2cJtya2eEsh
	t3VCabuYVFl82Jdbqh/onlMPNQT+VtPNW07q/eJNbnYcqKXaeoTZStZMgpVleRKrCnnoxPnXB1r
	8/YpVNl07WRiyeD
X-Gm-Gg: AYBFou1xJUUL9mxXeaUS+Y65pcwNbntLFCzoPE7ANDV2Ses71AsbOkQcPaZycmoUYPc
	hrUvf7ga0yFVWlJR7uRhLn+HyPHGKgTAEd4YkDuy9nNnkFepJyL971mm2zhSYIppMAU1WIVbHdk
	2OmSeecrbmmA5uyjxMlNL1LgHuVPpgrk8mI+OVDV5LyBxY0DWEzu3MS0tx2jZJfT5KgHu86F/2J
	aUH3ch8gVNQL/IrJzjV+89qz2HgRtA6HBINaBfuURdhuKBHMf2O1foboABbFy3BqI5IZMBWkKOg
	JU+eFMMAutPiJL7VWUoK051MgFABD4xSBPwibaWFIaSXOvYiuI7aLxjiQVJfBnH0P/e5S5MMC3J
	/YctrIVANckkEo6upVBaXkYWK7ponPYBTRZD9vOWWh06W5MTeTDj+Kb3XeWfhWg5hmn9QY+gxDL
	IodhrRPbFtfILBSn9legT7LXEXP4KwblCb8pOdPXJj9DI=
X-Received: by 2002:a05:690e:251a:20b0:679:c12b:ec0c with SMTP id 956f58d0204a3-67a0e4bf57cmr2458112d50.53.1792688633665;
        Thu, 22 Oct 2026 10:03:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-91c3710c63bsm23546d6.46.2026.10.22.10.03.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 10:03:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b92acedd9so2366586d6.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792688633; x=1793293433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KhrZm0zHiTnRcguhPzPRKqxL4jUA63f4qsM2/mVl/S4=;
        b=HrM8gcJyT7vAHXqDlemgwwECPHHqP+7XJI81eltLuirjuMXOloxcnbkepr6O5eRMcI
         J9e4op2XZ/7lX0I5UsVs0OmNC5opt8zbSLLzP6CC9J/izDLKBdqjrDdCyqf4TwZgsx8A
         lXhwLcufI112y37+vME2+4hjNFmyBp3hTb8ag=
X-Received: by 2002:a05:6214:19e1:b0:91b:efa3:a608 with SMTP id 6a1803df08f44-91c12f0db8fmr97404396d6.44.1792688632794;
        Thu, 22 Oct 2026 10:03:52 -0700 (PDT)
X-Received: by 2002:a05:6214:19e1:b0:91b:efa3:a608 with SMTP id 6a1803df08f44-91c12f0db8fmr97403596d6.44.1792688632108;
        Thu, 22 Oct 2026 10:03:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c3705e80dsm1945456d6.23.2026.10.22.10.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 10:03:51 -0700 (PDT)
Message-ID: <2580c2fb-0ffe-4867-83c7-368643854dff@broadcom.com>
Date: Thu, 22 Oct 2026 10:03:48 -0700
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
Subject: Re: [PATCH net 1/2] net: ethernet: bgmac: preserve forced 2.5 Gbps
 link speed
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Russell King
 <linux@armlinux.org.uk>, Jon Mason <jon.mason@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>, open list <linux-kernel@vger.kernel.org>
References: <20261021191035.751684-1-florian.fainelli@broadcom.com>
 <20261021191035.751684-2-florian.fainelli@broadcom.com>
 <20261022082908.5bc9f6d6@kernel.org>
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
In-Reply-To: <20261022082908.5bc9f6d6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/22/26 08:29, Jakub Kicinski wrote:
> On Wed, 21 Oct 2026 12:10:34 -0700 Florian Fainelli wrote:
>> Subject: [PATCH net 1/2] net: ethernet: bgmac: preserve forced 2.5 Gbps link speed
> 
> Does not apply & not correctly threaded

I believe it's another case of some emails not making it to netdev, I 
will resubmit with patch #2 applying to net/main.
-- 
Florian
