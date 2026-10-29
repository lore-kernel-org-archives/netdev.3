Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290803;
	b=tKEK0PvU/LfjYNSIfOiJxBBousfKkQqU3mbCC0dw5nQMeHOYPwMlx7Qc07d51zmnT1Ov
	 Mr5nzwhsfBYKkXBNTPLAavRbQebaIbr/5fbPkflrrY5qXw6UvLIpUBlWPTNMZ4jqgcTVG
	 Nk4rvH3lYomtwnto2dbiraeK9XHfZs0WHIegLPjYV/7Pm2Dr9M3EScYqk3KhzTownbifZ
	 rFodkigfZnnJckk4jofTHo8C5Irbnk/1CzWOq/rouUpUmsAHkERRfaLo5blCieEVCVstV
	 6z7PNHwB5z7VH83HCwlY0r9JNyyQ5anqD+Ixj0IWHXs5QmHuwNxMfkLEyxsXxbVL+kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290803;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=WE4Rwi8lssJPH8tN9xYxcVpSPT33zDTKRCIuAcoEU80=;
	b=fKRIDXeEIlUdKkyGuBWSWsMMX72/NgMUorarjLCRNsLj4UTDw3eujfR+mrkKyuAVkg73
	 M2Q60uYiZsCuCpIZoPE5b+hFacJt7oov2fMXLvhgrYAZ7833ZVTKmqq5SJop/F/ZhkB3c
	 uYECBFrhoTUedLDSwG7Vgz4rlge2J8yI2SnsdJfMzllXkswOohpVyIMSm7BQCLI82AOqL
	 R4USTASJFa1BMlWvgD8mrMTJT+3O4pHEpf75fkb8DcFF8qfyu8xLzENvh8/udmf6WNWor
	 Z8zu+8SKe8HiaAMA1yevTq1Sk0GXH2/LAwpLT37gj3CmUJSkw45SIZl36VXWCz7rcFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=dgq+p6mc;
	arc=none smtp.remote-ip=209.85.210.225
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E2F606A31E
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2E2F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=dgq+p6mc
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-89f28c3ac7bso1035474b3a.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290802; x=1793895602;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WE4Rwi8lssJPH8tN9xYxcVpSPT33zDTKRCIuAcoEU80=;
        b=bff7dKrcQTE+pWciEB5L28NR7ZsB/Vz7lq7kTGUN06bAhmfU6O3qQByjlEqDG10UUZ
         7hbTReZ58M/iLPEhZmqlZ97sdfCNNSFIymXJ1dCHJoMJ3QV6rbP+OILVjEnO5qYTaYNw
         037oAJ3HD9YeQRo05MqLvdDg/OTitLui/x9pEXgY7Nrce0sr1KurIzfJStQA+6EyVFro
         6ld5/EZsI+HNf5qGKhSSpp8NgBzgbcvSECMOFN98RbyNEDLUfUFaRaiisRWih7J36skg
         eA1gcJDVcUg21TFO4rJbmClyh8GTsoSAPLgXZGpgHMfsauO9wZnv8lJ5FV5fCFWuebPK
         BlmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKoU+XQ/7XSYR2QYGqF7USbuujezQxHF3IstLydLSArXn9fMoXCPHwP4G4H7t+pSEfYFkLprc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBbPulkjg/qr8N+KzJoK1AN6Ekvg2ATPIFnPZCkDJyKtziy7Fy
	PyH5miaDYhh60ISOUjl6u/gWTK3vmYYxmVI0b4FmR8Bo9g1LRshy+k+XRouHbVyI6t9tF0pNykA
	e6ymXe4TfAn+0RljqrCsHd6XlchOyG+1gc9EYk60bWcilZ8I4iAZSYEDIV4sj4PM9iOnI/gzEc+
	9sN1eJb/k9x8LJnoNKm6/ugRnvsBvvcjZV1bSrQPE9QWMAmrwh1kq7Jenw01bZ7f2Xm99YQdJKa
	eMNpz+z7wCfEhRDN7k=
X-Gm-Gg: AYBFou2fKZRYsIqYB/mI+LcyVmWt6EQlpGFQDIuMaXRjPiPlXwW4ikq7b2CsQ0r8I1V
	e4JuXpHYIGrQ2ZGl7OXBL3GZIXgiVn3+G9cJTT/G2DkHrmrNGhAL+lHNoOFG7YeuZgQMnAeWWmC
	uTd0qr7dNG383L/QsZPN33WTKYexsDtau+CaeHrPXB/zGwDydyyK0CVmlvryKK/ZFWnUU4HVNtR
	54Aru6yi1kyX7dm43Y5HsAveis89VZKICecC/XA2KbeOaz5X759XE+Nzo8jliVPPsTpnxJ8QQNH
	ArZdIkcYyxMM/7HAJyYCkcAKMPZDIl3+UI4RsZgnhl1KRsGucskmFVHetqBG1R35OlovtnhZwuP
	/DZm1XQHPbR9wTVAmobIRaM2cckyGWXgnY0YKOMaBmQjaaVusAKyCcFmLOEkTg3lOZ33//3ri3B
	otwQMBC3jAmcr1jZMvJj1AC0LoZYkzuBdifs9JPygM
X-Received: by 2002:a05:6a00:3c93:b0:874:708d:b61f with SMTP id d2e1a72fcca58-8a6e78d000cmr5318271b3a.29.1793290801865;
        Thu, 29 Oct 2026 09:20:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8a98ed13f0asm2496b3a.4.2026.10.29.09.20.01
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 09:20:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-8486941f252so3278558a34.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793290800; x=1793895600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WE4Rwi8lssJPH8tN9xYxcVpSPT33zDTKRCIuAcoEU80=;
        b=dgq+p6mcv7qv4E6vOjOFcO6eFJNQ9JR7xgrtthG7guqYpWeZPIx7CCH4+jzC1clZET
         RlEW31oNiasUR9zVBdKnMNN4fcjpz/ey3iWYoMxgfgNfI65zR/79gNP5bSRlzy+25uG6
         ugC7OIQf1bO7WKl9sHPO+XHXds2UleOivfOZQ=
X-Forwarded-Encrypted: i=1; AKwUvBzQN2ZPAp3OKlIMZ+THKUwoJucemBmi6yIslLXAPZtDd2YeANfyqSTOoURJAuQxddB2dFk6fg0=@vger.kernel.org
X-Received: by 2002:a05:6830:3490:b0:822:ce5a:4ab with SMTP id 46e09a7af769-85ab9d504femr5537664a34.26.1793290800286;
        Thu, 29 Oct 2026 09:20:00 -0700 (PDT)
X-Received: by 2002:a05:6830:3490:b0:822:ce5a:4ab with SMTP id 46e09a7af769-85ab9d504femr5537628a34.26.1793290799806;
        Thu, 29 Oct 2026 09:19:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d340137bdsm262758a34.21.2026.10.29.09.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 09:19:58 -0700 (PDT)
Message-ID: <7e73f5e5-b09d-4fbd-ae72-417115f1d4f2@broadcom.com>
Date: Thu, 29 Oct 2026 09:19:53 -0700
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
Subject: Re: [PATCH net v2] net: bgmac: fix oversized RX frame check
To: Simon Horman <horms@kernel.org>, netdev-bot+sashiko@kernel.org
Cc: rosenp@gmail.com, netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, nbd@openwrt.org, linux-kernel@vger.kernel.org
References: <20261028011035.49201-1-rosenp@gmail.com>
 <179323634946.3134.7111348485490827533@kernel.org>
 <20261029152249.GI257209@horms.kernel.org>
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
In-Reply-To: <20261029152249.GI257209@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/29/26 08:22, 'Simon Horman' via BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> On Thu, Oct 29, 2026 at 01:12:29AM +0000, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 2 · Medium: 1 · Low: 0
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [High] The fix only tightens the upper bound of the RX length check in
>>    bgmac_dma_rx_read() (drivers/net/ethernet/broadcom/bgmac.c).
>> - [High] bgmac_dma_rx_read() loses track of the RX descriptor ring when a
>>    frame spans more than one descriptor, and a remote sender can then…
>> - [Medium] The commit message rests on the premise that 'a valid frame is
>>    at most BGMAC_RX_MAX_FRAME_SIZE bytes long' (1536 including FCS).
>>
>> --
>>
>> net: bgmac: fix oversized RX frame check
>>
>> This patch changes the RX length sanity check in bgmac_dma_rx_read(). The
>> length from the RX header is now compared against BGMAC_RX_MAX_FRAME_SIZE
>> instead of BGMAC_RX_ALLOC_SIZE. The intent is to drop frames with a
>> corrupted length instead of hitting skb_over_panic() in the following
>> skb_put().
>>
>>> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
>>> index b3a92ae95de30..6873c7bb7a141 100644
>>> --- a/drivers/net/ethernet/broadcom/bgmac.c
>>> +++ b/drivers/net/ethernet/broadcom/bgmac.c
>>> @@ -455,7 +455,7 @@ static int bgmac_dma_rx_read(struct bgmac *bgmac, struct bgmac_dma_ring *ring,
>>>   				break;
>>>   			}
>>>   
>>> -			if (len > BGMAC_RX_ALLOC_SIZE) {
>>> +			if (len > BGMAC_RX_MAX_FRAME_SIZE) {
>>
>> [Severity: High]
>>
>> Should this check also have a lower bound?
>>
>> len is a u16 read directly from the RX header. A value of 0..3 passes both
>> the 0xdead/0xbeef poison check and this upper-bound check. Further down in
>> bgmac_dma_rx_read():
>>
>> 	/* Omit CRC. */
>> 	len -= ETH_FCS_LEN;
>>
>> 	skb = build_skb(buf, BGMAC_RX_ALLOC_SIZE);
>> 	...
>> 	skb_put(skb, BGMAC_RX_FRAME_OFFSET +
>> 		BGMAC_RX_BUF_OFFSET + len);
>>
>> The subtraction wraps len to 65532..65535. skb_put() then asks for about
>> 64KiB, but build_skb() only provided
>> SKB_DATA_ALIGN(BGMAC_RX_BUF_SIZE + BGMAC_RX_BUF_OFFSET) bytes of linear
>> space. skb->tail ends up past skb->end, and skb_over_panic() calls BUG().
>>
>> Isn't this the same "corrupted length leads to skb_over_panic()" case that
>> the commit message describes?
>>
>> Lengths 4..17 also get through. They produce an skb shorter than an
>> Ethernet header, and eth_type_trans() then reads the header from bytes past
>> the end of the received data.
>>
>> Would it work to also reject len < ETH_HLEN + ETH_FCS_LEN (or at least
>> len < ETH_FCS_LEN) in the same rx_length_errors branch?
> 
> The problem above does seem legit to me.

Yes it is legitimate, the absolute minimal size should be ETH_FCS_LEN, 
but that's basically a zero-sized Ethernet frame after stripping the 
FCS, not very useful. I suppose ETH_HLEN + ETH_FCS_LEN would be more 
reasonable here.

> 
>>
>> [Severity: Medium]
>>
>> The commit message says:
>>
>>      so a valid frame is at most BGMAC_RX_MAX_FRAME_SIZE bytes long.
>>
>> Does this match the limits the driver sets elsewhere?
>>
>> bgmac_chip_init() programs the MAC with:
>>
>> 	bgmac_umac_write(bgmac, UMAC_MAX_FRAME_LEN, 32 + ETHER_MAX_LEN);
>>
>> That allows 1550 bytes. bgmac_change_mtu() writes 32 + mtu, which goes up
>> to 1564. bgmac_enet_probe() also sets:
>>
>> 	/* Omit FCS from max MTU size */
>> 	net_dev->max_mtu = BGMAC_RX_MAX_FRAME_SIZE - ETH_FCS_LEN;
>>
>> This leaves out ETH_HLEN and any VLAN/DSA tag, so a frame at MTU 1532 is at
>> least 1550 bytes long.
>>
>> With this patch, frames of 1537..1564 bytes that the MAC accepts are
>> dropped here. They are logged as "Found oversized packet ... DMA issue!" and
>> counted in rx_length_errors. Frames of 1537..1540 bytes, where only FCS bytes
>> went past the buffer, used to be delivered intact.
>>
>> bgmac_change_mtu() also never updates net_dev->mtu. The MTU the stack sees
>> and the hardware limit can therefore drift apart.
>>
>> Should UMAC_MAX_FRAME_LEN and max_mtu be derived from
>> BGMAC_RX_MAX_FRAME_SIZE, so the MAC never accepts a frame larger than one RX
>> buffer can hold?
>>
>> [Severity: High]
>>
>> Can a frame longer than one RX buffer put the ring out of sync here?
>>
>> bgmac_dma_rx_setup_desc() sets up each descriptor with:
>>
>> 	ctl1 |= BGMAC_RX_BUF_SIZE & BGMAC_DESC_CTL1_LEN;
>>
>> That leaves room for 1536 frame bytes after the RX header. The MAC is
>> programmed to accept up to 1550 bytes, or 1564 after bgmac_change_mtu().
>>
>> b43 uses the same Broadcom DMA engine, and its dma_rx() handles this case
>> explicitly:
>>
>> 	if (unlikely(len + ring->frameoffset > ring->rx_buffersize)) {
>> 		/* The data did not fit into one descriptor buffer
>> 		 * and is split over multiple buffers.
>>
>> b43 then recycles every slot the frame used, and brcmsmac chains
>> continuation buffers in a similar way. Only the first descriptor carries the
>> status header, and continuation data starts at offset 0 of the next buffer.
>> This split-descriptor behavior is inferred from those sibling drivers, not
>> from bgmac-specific documentation.
>>
>> On the oversized path, bgmac_dma_rx_read() frees only the first buffer and
>> advances ring->start by one. The next iteration reads the continuation
>> descriptor as a new frame. Its rx->len and rx->flags are then frame bytes
>> 1536..1539, which is payload the sender chooses.
>>
>> If those bytes decode to a len of 0..3, len -= ETH_FCS_LEN wraps and
>> skb_put() reaches skb_over_panic(). Other values produce frames built from
>> stale buffer contents.
>>
>> With the default UMAC_MAX_FRAME_LEN, can a single 1544..1550 byte frame
>> from a LAN peer reach this panic?
>>
>> For the fix to cover this, would it need to skip the continuation
>> descriptors (as b43 does), keep UMAC_MAX_FRAME_LEN within the buffer
>> capacity, and reject len < ETH_FCS_LEN?
> 
> But the one above seem speculative.
> 


-- 
Florian
