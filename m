Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511026;
	b=fZH5D/NuKZygtAu1w5yJ1Nooe0jyAcXGa/vUMYQRhdWlmlONZkL9mltzJkJ+Tyo+PRhT
	 o80jw6cV8pOJkicV/eT1wncS2OGlJxDtcJeoTexB3tUVp16n4J7aMAh3xzIose0QxCzxn
	 5SGgCTiZZhMfK8CHm+QITjRWgEvWPmL5iVmslKkmiTntfvbRj5tJbDVZwzoX9GHjto/Vr
	 6+Z2P9V3VtaVxjRzklkneRjpON7hnCOuxTRHWEwqYbY/QZyKXZTMo4sZ7ofYV7Y3m2w6B
	 nKXn8TcZPGrKxRVhq1OX1bXXrgYJmZAMIJpsr5UGV9Pd9EpMgb4GBAgqxHVmkhVPd6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511026;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=y8SXWaXVp6eHYei7hOYj5YehcGSooBIEj+1T2E6N2dU=;
	b=DX06bI0fxt3uE9gUJpnKO3lQWvCa1raXWJW6rGw8rnjnkaq8INQSEIs8CGYWAYAjMjDk
	 C4fzUtIlu7ronFv14uNedFvk6SdwqdToZrE0hyezcVtc7g77+TmHe0SMbotU+jQj7J/MA
	 VS0LkSpe62VJGX9COz7dpdAMAiHmbN4cQP3VSL11PQz/QIzwukowwVpqON8RCFaSE8npW
	 rHcvTcxzoOB47tRf9NeBtDDXfr/QysLWCCe3qZ9VBQnhjjehvfBtSsYqXBkIyvTFOM74v
	 7ahqwuOnvuIGyCKorThs4LC3Sl9I/oE+LlPBNqWH/UqqyOdgadewISahwLGnL0mHZTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MkOpQip9;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859C606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A859C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MkOpQip9
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so2759237a91.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511025; x=1793115825;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y8SXWaXVp6eHYei7hOYj5YehcGSooBIEj+1T2E6N2dU=;
        b=kJJt7tbndwct8E56duD2jB8eqY7s8P00ejO8CybiulIRU/hrG2ZkmvOKcSbrelDaUc
         dwrZ3keJZgmV6/91kCFc2zlGi8URuGTEL/8olGRWt+2/Vp8pCBHjQNkqcVeoRFflpGy+
         frxiO/4T2dgDLQ+vgqBOGJWn8EttByiiIn2gIwYvrdSpnMkjZ4Anvz2gSJHCEntk20Ng
         rA1yj0HjorpfGL84QtfnLo0RnMPSNgGquve6eU//ll//4BthL4fE0TJDU0R1naK8qS2a
         zO/hON5Gvv9uYx44Rnoy3nWGYOOPzEnJiJ6NBIETewsFBnkb23HLN63UJYJNJKfOJtyT
         f4ZA==
X-Forwarded-Encrypted: i=1; AKwUvByRIs8m11WNikyvDKVMLyObmmzaqCOsqkOlY8euVlvgcf0bToglENTx067t8rfs7QH8BMfjoPY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLypQdh4oxxUis5tbYo3/ftYBepb5ELNYV7WvPHTjjp2RhJmqaQ
	uHXYsnwfUNQBaT5DDwgFrr6rw39zk1FUrRLiZH0dVaZr7BfaEsffJuYy0E0Q4u24L/oVOWfBR9W
	xJndSClId0q15LGUjgT/yU/zYK0t/wPYrGcaTBoADn2K0I2V8eBdBq3EtZtpOKX1e4zJPrYCDOr
	5BO3rGovgsO8B3TAPee1nHJOTQJj8nyQ6osLhIoPoV1Nd9MLrxwi0jA0gwhCIh8oURg+ZIGDhea
	wgBtiVsNph5Cd1K
X-Gm-Gg: AYBFou3YC6ka6Jo4+4T4yg4OTgRWwIwFfUcrD+2O7RKWWUDkVs/Mniu96clcZD0kTSZ
	AWVnrBtqes/zjXfl2woofxBjiUjJOKWr06CtqLnmoi20Aghb/629RscD/2qO4W7QyINLUYqmqv5
	I/w2ng4IuLBgnzwGXzdXLSBc1fmHAbIVeN5UQ8IM64jMJ4ccmIYM082TbwV4QQTnLUS6GmQB0PA
	8x2diW1cqE6gqG2GQlsgMn0dCTlRAmo0DOfogxmfG/QceL/2FaD3p3PtMVMoEmHbUOLexxbKK0w
	rG7pafmuztujF8W1gJ1W1Ohy0GQ1YxM8S+T8jTxF8ZNG+Io9Lvm1nu60o0PuJusy3q/MSht4hij
	J0tszi5wLFALBsudGyxYw/us4bC+vURSlQLzKkiGiaf0sW+mvta8ANHpTAqOMVGkXvLJlSsSTrg
	gkIPIA8UuR3GrUZN2j9+gjkuttBqcOVOhhCXZTgy8x6FQ=
X-Received: by 2002:a17:90b:3889:b0:3ac:95d7:2fa5 with SMTP id 98e67ed59e1d1-3acef1545d3mr9752505a91.44.1792511025004;
        Tue, 20 Oct 2026 08:43:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3acc9940511sm3987334a91.1.2026.10.20.08.43.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2026 08:43:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53635e21ddaso40436031cf.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792511023; x=1793115823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8SXWaXVp6eHYei7hOYj5YehcGSooBIEj+1T2E6N2dU=;
        b=MkOpQip9TRLogJxJsR6nTo1Bj8isvFnwVOu/OeCcjYemELko7EG+FQzTStDXU8sYeG
         oj8ck80CBTsFNFRPCqr6gdgbi88/D2VZPqNlcpAXgcoarJQnhOwak8CepUE/cuan7FgZ
         8509eIgJVYfkr3ae3xzDaNPLQWyzIaySNsgqQ=
X-Forwarded-Encrypted: i=1; AKwUvBwn4QrKLXBlrROkkYSnvge4iE8+1ystUbIWoU6H7hz13wDX2nranHXNcK6Rs2mjU6mFN3Rch0c=@vger.kernel.org
X-Received: by 2002:ac8:5ac8:0:b0:532:a5f4:df25 with SMTP id d75a77b69052e-536460c6fb8mr171853251cf.57.1792511023450;
        Tue, 20 Oct 2026 08:43:43 -0700 (PDT)
X-Received: by 2002:ac8:5ac8:0:b0:532:a5f4:df25 with SMTP id d75a77b69052e-536460c6fb8mr171852561cf.57.1792511022781;
        Tue, 20 Oct 2026 08:43:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536660162efsm62610011cf.27.2026.10.20.08.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 08:43:42 -0700 (PDT)
Message-ID: <a111e15d-9bfa-4b38-a52e-ffa1d305fd0a@broadcom.com>
Date: Tue, 20 Oct 2026 08:43:40 -0700
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
Subject: Re: [PATCH net v2 1/2] net: bcmgenet: recover from a failed resume
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev-bot+sashiko@kernel.org
Cc: opendmb@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, f.fainelli@gmail.com, justin.chen@broadcom.com
References: <20261019-nb-genet-fini-dma-net-v2-1-b85f6b92654a@tipi-net.de>
 <179250090686.3135.17597197349680697960@kernel.org>
 <a033b1e2dd424000dc5669f88bed0c89@tipi-net.de>
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
In-Reply-To: <a033b1e2dd424000dc5669f88bed0c89@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/20/26 07:16, Nicolai Buchwitz wrote:
[snip]
>> [Severity: Medium]
>>
>> With WoL not in use, can this early return leave an external PHY powered
>> for the whole sleep?
> 
> Yes, but IMHO also pre-existing: phy_init_hw() in the failed resume powers
> it up and it isn't started again. Before this patch suspend hung instead.
> Not leaving the half state behind is arguably a better way.
> 
>> [...]
> 
> I really need to find a WOL capable genet board, so I can test these 
> code paths too ....

It should be somehow possible to exercise that code path on a CM4 by 
having the system enter the "freeze" sleep state and have GENET 
configured for WoL. We can discuss offline how to get there if you are 
having issues with that.
-- 
Florian
