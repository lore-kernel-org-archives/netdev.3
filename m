Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794009766;
	b=QNpnv15BtQ5C1EsaLyJ3PiL83NJtZ1b7KkWRQt5gjdarsr96uWrBrVVAerqNT7gMZUd7
	 qOcU2Vxm2L2mOAImjB5bFDC5//z0bXnCGhyWAaqjzCJXb0jy3vbHiB5KEAGcZfDEHVdwo
	 XsrJ5uDJanMkovncv4i8Zc9llbAkqDBBkYvRX+HgDfB+CoGABTLv2QkvIn5mToz8hVUZ7
	 4cy7NkoG+1LfZGDpIlQ/d6Xjum2wcjj0+nkZPLr/0VTO5wTFvT/1/P9adfij7xYjpq2OJ
	 gn9RFlPnNg/A3IQbN4zabAs0eME413uCrXZEnG0sLkDpSLSKftgkZ0gbMPhyiTHyZCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794009766;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=2bbBoX07yT8rTJCrVM6gY2O9OIdKlfJo8J6sej1aUio=;
	b=lvKSkQkh5x70ZtR4GoaqWGmhZbrUEpEHlPfnDtiXdNDircym5CIxPFMZPMzMjrXu9haZ
	 YDzzk4sYe5bPEWKs0GKd75FpSdpWhzCAmS+4tUNqyhhaGRBVUHeCqitOCQ8vr1rLfTwY2
	 pyoBKO35nSs3AIENIeQ9t63slKr/Dgt3RGip1izXjMQABrXuEMxC2HaQ+5wIoXKMHx0D8
	 oXOrESDmoPhG5r9vnLG2edJ9NdLh42UCttBspM9LXOQiqJlebRWIGMdK+PZRCcx4LxIq0
	 /0XlKvhKBqsOFw7sAvuPMg0XtjqPqS6H/paaTzL+i/nHuVRQtmE505MmcuxL3pVZmHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hPD79lUw;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF8606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 00:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08CF8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hPD79lUw
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so739569a91.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 16:02:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794009765; x=1794614565;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2bbBoX07yT8rTJCrVM6gY2O9OIdKlfJo8J6sej1aUio=;
        b=2npYdPB+p1SenJZxYq/vm/YyaLQ3CXpx0oF/1SuL0if2bpR84kgg0FbT6/QxL0BhNa
         ldeMPMGQ2iAeiIJ79JN/BjTAsiz4eOS6L3KYy+j+Khzu7himBNqeOFkPArXwlQSld675
         Ew2Y0m6XU06kOWUI/W2M3VGW1585DsGPmSpt3kUeGZjX7ALdWdxdgXvrAnnz9TfoWjcn
         E8GAwFTjoirBpYiSjL0DGoPxvOWVos+WeTjs71BfeNr9Kehk2KYOAIAbbaMMN+P5HpuR
         vYgSwrV65C/ED0SDkBpIrEP/osKJH1IV2/l3MmO5SXMvOuoZjiQnVoFgji+zF5xE+rqt
         gpyw==
X-Forwarded-Encrypted: i=1; AL+hErHpnI44ST7Qy3wO/vVqNy8sWpZncqH6szvWYlTagKoydx0O4BeH12wpLAcfzKIwXSMj8gX9Klo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BgcyHleSnJKwZOouvRCJI0btmXEFRZt0SV/yFfcXCm0vlk+U4
	fqzEnJcn9YYG1le+YqfMLDoiWvbp2brkttTJWZkjX24GBo6IeMN6uPHzb36/7l3/EOZ0okJX3J6
	+pAMR9dqK9VPvqPKCyGuKxGINj5JMd4ROu1xHgmKSTTxfU1d79gJxd+m3FNgI0AUkn3ev3vEL7Q
	BGTEiM+OsEjenDivC2ec/x2cflWXhcm0PGjm97Ca+8fgnv0+kMrMGvl+95g4c3CbIK+t5Y6gzVz
	sbBXltJKT3nTFNS
X-Gm-Gg: AYBFou3VTr8PtcGK3vR8Fr25NzfQjyWlRuD+xKGPziw79ppIRXpbTMFHxEmLnGtoBnG
	gb5/rKOkA4QhedIuNrAP9pbcUfWiqppa45URmPoX0U/dUvPtj/lP6FQMuHXfGPD8UJs5pPBzTld
	7UF+3VD0lfid8yIXUj36+ASbH8kdgotY1f9unhVSFtF+a4SjrZAiOxZyhhx+YYB0uPaJ6dfk0Mh
	sapYRanw4ShznCdyxzBuB3tFYpMsYB9scy7ojpUWhbaFRZlUQ0qCEEDOV8+6jPTPaoFKT/jzlyF
	qWEyD8eL8AQXt4sDUgWqZLJbIgf76/SnOR3J9dR7BIeceA2/IHzAqDoBdcjOgjmT7CUbOm47Fgk
	mI4G+61jFVdchJUtfwUHp9aRu7kEhsHXx3Z2sK/wxrhFTtkpaxCBfzGEJXXc3H4NjONLxQ6Ah/9
	jKUIYe5mLsCTbezuo6ZxLLMQ87MBMitnt168lEA5S0
X-Received: by 2002:a17:90b:1fc7:b0:3ab:b39f:41cd with SMTP id 98e67ed59e1d1-3b0db6ed2f0mr4273116a91.60.1794009765240;
        Fri, 06 Nov 2026 16:02:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b103458b19sm273478a91.4.2026.11.06.16.02.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2026 16:02:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so4048037c88.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 16:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794009763; x=1794614563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2bbBoX07yT8rTJCrVM6gY2O9OIdKlfJo8J6sej1aUio=;
        b=hPD79lUw4v6ULgu1GePpYDYS3SwpS4ESWWX/lNyD8XyfQXgYpr2pzjD6bcLv0XH1x3
         wjqigfn+uBNdODYsSqa6Nt023XTpGbOqmGYVhFeeCk0j7hxQ6fAIxgduBKGDC47MnZWc
         uzAyZz/1M6GCHTR5CAo83k8e4N2z382FdYGkw=
X-Forwarded-Encrypted: i=1; AKwUvBxvR1VXuKqMZ4ekFRNneXDpsEnvd7TjNKNJF9j1rR3EhLQHygN78IMKmcluuZYnWXz2LC8rf1c=@vger.kernel.org
X-Received: by 2002:a05:701b:2512:b0:150:c9c5:1ca1 with SMTP id a92af1059eb24-1b25d318407mr5084589c88.18.1794009763175;
        Fri, 06 Nov 2026 16:02:43 -0800 (PST)
X-Received: by 2002:a05:701b:2512:b0:150:c9c5:1ca1 with SMTP id a92af1059eb24-1b25d318407mr5084543c88.18.1794009762313;
        Fri, 06 Nov 2026 16:02:42 -0800 (PST)
Received: from [192.168.10.3] (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4880dasm8119785c88.8.2026.11.06.16.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 16:02:41 -0800 (PST)
Message-ID: <0897e70e-3a7b-4f1b-81cc-98b4bde1dff4@broadcom.com>
Date: Fri, 6 Nov 2026 16:02:40 -0800
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
Subject: Re: [PATCH net-next] net: bgmac: stop advertising TX checksum offload
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
References: <20261102215806.13723-1-rosenp@gmail.com>
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
In-Reply-To: <20261102215806.13723-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/2/2026 1:58 PM, Rosen Penev wrote:
> The driver advertises NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM, but
> bgmac_dma_tx_add() calls skb_checksum_help() on every CHECKSUM_PARTIAL
> skb, so the checksum is always computed in software anyway. The return
> value is ignored too, so if skb_checksum_help() fails the frame is sent
> with a bad checksum.
> 
> Remove the feature flags and the fallback. The stack then computes the
> checksum before handing the skb to the driver.
> 
> Tested on an ASUS RT-N16.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

There is no transmit checksum offload through the DMA descriptors, it 
can only be done through FA/FA+ which is not supported yet (working on 
that).
-- 
Florian

