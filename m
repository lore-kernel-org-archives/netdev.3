Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB84CDDFB
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627952; cv=none; b=Tx15PSTR93x51S8qXeKgmCEsNkzXK4TfIQmoqcTtEHZy0WSqEw5oNfH3LGpxKaJiSyAyMYKjxa9YUAwraangK0mTs5oc6ET6K3ZFmIqfbL2wowi33IUMr0ggKqrZYys6LdD96q08Z9QZrJ3TkmS5HVbbZKKgmIpjSr1Mjg/x14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627952; c=relaxed/simple;
	bh=VCqmwSFMv0XjIaaz8yd8wYu93nx3bDTj1er1GjZijVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzAoh5HnFTVFiuBUBMzoW1K4UMD647unDrhgLvOzJ0p+Yw978Dfur3Ens416xUYao2/JwLLwezsuj5KMS58QQZPxuKfjCNcyCKkaGYGNJldcs/SfX46Tzv7OakfaphObZ5aE6CjaK8EKpr7LjxTzv7wECuYtsygAnJDMD2TxJZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LZrD3vye; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LZrD3vye"
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cc7a032647cso285896a12.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790627950; x=1791232750;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Mk5AKXfEZkuSTVbBfHwnafuVDyGa1LOHVbuZG5U6gT4=;
        b=WB17Vue3/yeqlG61o3LpOp4fFAGEn9KusIBXCA1VnlxcMKlU8c6qa2w2/yhdTVarVZ
         PehJzApkvYSB7remT8Y764UAO7U9SMbRDWU0pWbpDhhtO9YbXT3oUNPkalkJywG5VY3t
         fvulKvA3ZbCtOohmGrIVv/Ca0SCmvRZl3YYYG3YNbLX7bWJfbxN3RjPUawiI9lwH+Sxe
         f6qwM2N07HHtBk8Iln4/Bwl8rDc5odba//ml+Rk63FgybA8ep5KTwuYsOpwZ9Dva6v0u
         1qNQHzcpe4yj0bCN44UgYK/9HlirNdYAjMOLIsFQkHFqF53zVLelIrVK6TReS6e9Opj2
         4i+A==
X-Forwarded-Encrypted: i=1; AKwUvBway8U5rqh1j0bCPEwnZ1+EDSQpWCVewj2PtBV8nVZDp9nPj4mD8d6NSlwot1qI3h1IPq96Zbg=@vger.kernel.org
X-Gm-Message-State: AFuF++lYwC23zgEFEbSK2h2ExhEV/U7JiSRgoaXiP6H1OlB5GAPjippT
	cdrKpr1/bQ10hKfQVuKSWrTmrdvC+w1chglJmjgcGFQwWh2Tx5AxtNI3OJtr2u7ZxD5ksLEX93o
	whGJq6R7hI+Rbvy/pchkJo2N367yO60by5iDMPt6sOGS/avzwX8wMHNLrQ+EstPuCMsEGgCX7WZ
	O1VHBVT0+ZHKMmKunz2q4IAwg5nevRg2zHtwSnuPbG1gsblY6k7ScNn52KBE8cC/rfujNieiYiH
	oo45ZGjKEOyRGNh
X-Gm-Gg: AYBFou29R6LlFAf8c5ezleNyeNJNTGcZdJ/C1YyKaUeArOl9ojtusUVlxnoX1fhq3Zp
	EKc98kSyWrzQ43fbbVm9i610hNwMXZVFeTf9HDjxoU87de01yuASCT9iCXKk2ZomveMeWz7BfdT
	U8vp+lhQPq7LhgAAONAasXCDt0OoGqsjKAc02ktfGXdorkd4t9uvw4wjLaMplpmlA/ULkPr0uCe
	m2ilRuQzkioXELonYr3lSg30mS2V9M6sE5TAizLzWgZQ1hsn5KmR+HHfDLB82SGfhkPaYWlzjog
	GCAdUU3YpBTYDsPed41VZKQJR4Nii1mZDGCgv5T9+LNq+e8u9fE9J5bU0RXjFgR0Gti6/CS24Rr
	kWpFLFnY1z4tAxhCFwYl86bMLjuNqiImnVQ1yTDS3MvsT+hm/dDFRu0uNUdlHKi0BfHDfQd7tvp
	MjVUJs5GR2LCHVUEinNBYyVBNLVev/ouO3Tpv81xZUfV8=
X-Received: by 2002:a05:6a20:2451:b0:3de:61f6:4207 with SMTP id adf61e73a8af0-3de61f646ebmr3648938637.51.1790627950333;
        Mon, 28 Sep 2026 13:39:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc7877909dfsm6801973a12.7.2026.09.28.13.39.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 13:39:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e2c785aa62so294365ad.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790627949; x=1791232749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mk5AKXfEZkuSTVbBfHwnafuVDyGa1LOHVbuZG5U6gT4=;
        b=LZrD3vye2pbc4PFrVP3R+LbCUeOUOjst79a3yoAfyaerSy+B2YESC80GEtsKyVFFyi
         /7t8fgyz+3sIWfMpwkmM3QrNWC49Ofhey1RUSH6GV1WIZ0qiL0chbAU85PEKPsPZR8UG
         GamGWDH9JLfc4ICVowOUnjixqAFaFoees/eGE=
X-Forwarded-Encrypted: i=1; AKwUvBwG9sLENEJ4hYz78VjxI67mZYaFy7TKeHJrFkRin90kqZWSqloYpMwQaf0DN6GjWIZzjM0JDZM=@vger.kernel.org
X-Received: by 2002:a17:902:e751:b0:2dd:ad73:c936 with SMTP id d9443c01a7336-2df7da9e288mr112944505ad.23.1790627948616;
        Mon, 28 Sep 2026 13:39:08 -0700 (PDT)
X-Received: by 2002:a17:902:e751:b0:2dd:ad73:c936 with SMTP id d9443c01a7336-2df7da9e288mr112944325ad.23.1790627948048;
        Mon, 28 Sep 2026 13:39:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2c794166fsm72055ad.21.2026.09.28.13.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 13:39:07 -0700 (PDT)
Message-ID: <ec851b5d-197c-4a78-a746-3970206251a7@broadcom.com>
Date: Mon, 28 Sep 2026 13:39:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmasp: fix lost TX wakeup race with lockless
 queue API
To: justin.chen@broadcom.com, netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
References: <20260928201816.3935530-1-justin.chen@broadcom.com>
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
In-Reply-To: <20260928201816.3935530-1-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/28/26 13:18, justin.chen@broadcom.com wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> netif_stop_queue() in bcmasp_xmit() raced with netif_wake_queue() in
> bcmasp_tx_poll(): a reclaim landing between the ring-full check and
> the stop call left the queue stopped despite free descriptors,
> hanging TX until timeout.
> 
> Switch to netif_txq_maybe_stop()/netif_txq_completed_wake() (the
> lockless TX queue API, which also brings in BQL), replace
> tx_spb_ring_full() with a live bcmasp_tx_avail() count.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> Assisted-by: Claude:claude-sonnet-5

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
