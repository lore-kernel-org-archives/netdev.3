Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52C37C927
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788475186; cv=none; b=qW1Xb4XGXMyG8aRGuqQwafoDWnXCh12tLvRMlKtBCm02oqzvKNpBiyLbkuy5FASWHbMdKnTwTiH5YgeHKkdr4WOT++SmmH6n35ZleBptFFCeT482EtmxSYWR0pR/B9OAdzUjUUWhJYiIALn7Vqu3NX9w06iK0BAWHzw62ek3PH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788475186; c=relaxed/simple;
	bh=RFYRiyl60OoPN94nAl/soupy5dZK1XSdgswd+55mhg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9uol7JsWIpV/I+/o6ZUlmIaCBOdbGygM1RoNw67pBdZuhS2DEyaFiPLegaDugmxx20Mozsg7wVXqj2xI9IJzr7wTX2axYSIgJGmxCNRpHfQUJSHMeWgmnTtnEBMAemtTGgmFV8d2e8YBfvPI6ml00riO4BpF/xXaetj19gSqsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PGuMcoeK; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PGuMcoeK"
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-7564b7a9490so1244203137.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 15:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788475183; x=1789079983;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ykzYuBAmaz7rW62KAbS5zr6hcHRjqOUQ1zRCJ2bekNw=;
        b=BMT1Y7lyNEaEA5K8T19Ql6c4rTpK2jooaC9d7wJJ6RQdjnJapz19UZ4AqUChYmsLEo
         FuOOyUHuRlK++MmwzyMGtD/v7FBg0mniUANJYdPY8L3pZeG4ch47DYughMK3ACGi4ZT1
         L73OY3+sPiWIqXVMt0qaHsIObFTbN+EWN4+Bp1CYGdhmWU5MWxgPi3tfqVHNdEId1oZw
         g6vqtaGiOPmSZd/DupFhgnbXVKfYB6XkLKEgp/As4G82t/YmKPlfILT8oE9UC9VZiYOS
         +rKbt5I3dAV1XdMzMumWHkYU5/zsHHKLS4YDUqWNPCzNObYSfSSl3C5Px35XxjK2EEUM
         NAGA==
X-Forwarded-Encrypted: i=1; AKwUvBx4zvht8ndiNJyliD6TaOaCzUGsEN7Jb/5E1cf4yhuEm4bZ5GxkNlEJEdS7EspDuCY19DjU62U=@vger.kernel.org
X-Gm-Message-State: AFuF++l0R3HdibCvcRU9N1Pri4SR87HbcFOxaYmYhhtpI0buUAB9uTte
	PRakG/wYNFu7ws72ad4FMirswpLQ/U0J133+UdJOdjm/pJ3BsoBZNgF1iYyUASRFifh+YJXgFGX
	Pcc7urXDu/nZJd08TWpuF/y0xVNy4brm8BWhykyVw/bDYg1vJCzCe0JdmrWdDs/EvjaKOuJTcx+
	eyPSR8xeq8Oy+maOzTe/5dSXe4d17FtO36fXOk6a7goXyEwJcAa6DvqSABeVLzO5K3gLvLwsDAp
	72FmLlEHYh3dUO5
X-Gm-Gg: AYBFou1C64e3g0FySX6ltVBX2cb+L6QBen1M8oj3Qe6pn043A80nUpHf49R2DyV91b5
	l8l+sxuaPzYZJckFY/6k6ep1KI50AGLjMfzgNaR3FN6bUbcEqDbkuSAJH+1kVUhq4uzGnghXnYb
	sf/bI9j6AN6Fnt3V+46TtffFJt7nS1E6GZxP+G2DPqGYuTmylaW+qquLtlwgZIOXviYbgypXOhQ
	hzyOLIpV5npwFoP4DUhmoMwTHqWLIN6D3tkwjpH2YYufIH8J5q2i1ym6dbpZ4GCNSoSSxoTeQff
	Nx6Q1nlXktOR0PzNCb19UbQkaiG/z8nJyzJJyWA7PDUsMy8DJm7pV+ECWd40CuD8I1HuFrAzEfk
	P0/wPBIqNEEIt1hce3MFKFLZqVcMTt4CJGn7I/2iPTZnbIWStvIQ+EsB9+SbkuE5WS3T4ZmIT3c
	UfjUv74FYbWg3V73VxXebez89oUBFiUm0nZyqMogPj
X-Received: by 2002:a05:6102:610c:20b0:786:22cc:cdda with SMTP id ada2fe7eead31-78a2ed80666mr1915903137.1.1788475182797;
        Thu, 03 Sep 2026 15:39:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c7ec138a06sm380279e0c.2.2026.09.03.15.39.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2026 15:39:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db050d469fso14291685ad.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 15:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788475181; x=1789079981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ykzYuBAmaz7rW62KAbS5zr6hcHRjqOUQ1zRCJ2bekNw=;
        b=PGuMcoeKhIaCn8LM/HUWuMgsZSfOeN8SDQJPzXnjfOMWjj0RZ8eYvIJCAcDbi0hXoW
         kLDfWspI5Fe1mw9hsQykpp0HpHuDnXATFoGb2DdQLxrd4dyXd8WQPBJOtDrVegG6gWs3
         lTMMsKOqUUlfsuXJZbnjjWZ92LX3lghDoTNQQ=
X-Forwarded-Encrypted: i=1; AKwUvBx+0zruDF5qm02LZ3ScpEexAMH3BIrte08soKaV/TlgasL9td0E8OWEqyjEZpX43mMhEmD8pR4=@vger.kernel.org
X-Received: by 2002:a17:90b:2709:b0:396:7c01:553f with SMTP id 98e67ed59e1d1-39b086533admr11332510a91.21.1788475181585;
        Thu, 03 Sep 2026 15:39:41 -0700 (PDT)
X-Received: by 2002:a17:90b:2709:b0:396:7c01:553f with SMTP id 98e67ed59e1d1-39b086533admr11332468a91.21.1788475181093;
        Thu, 03 Sep 2026 15:39:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm1913696eec.1.2026.09.03.15.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 15:39:40 -0700 (PDT)
Message-ID: <a177c745-722e-4d68-bd39-fa8916525708@broadcom.com>
Date: Thu, 3 Sep 2026 15:39:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: bcmasp: clear txcb->last before writing each
 descriptor
To: Danesh Petigara <danesh.petigara@broadcom.com>, justin.chen@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260831184235.4133351-1-danesh.petigara@broadcom.com>
 <20260831184235.4133351-2-danesh.petigara@broadcom.com>
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
In-Reply-To: <20260831184235.4133351-2-danesh.petigara@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/31/26 11:42, Danesh Petigara wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> bcmasp_xmit() only wrote txcb->last = true for the final fragment
> of an SKB; non-final fragments left the field untouched.  If a
> descriptor slot was reused while it still held a stale true from
> a previous SKB (possible when tx_spb_ring_full() underreported
> fullness), bcmasp_tx_reclaim() would see last == true mid-SKB and
> call dev_consume_skb_any() prematurely, freeing the sk_buff while
> its remaining fragments were still in flight.
> 
> Unconditionally clear txcb->last before the conditional set so every
> descriptor slot starts from a known false state regardless of what a
> prior transmission left behind.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> Assisted-by: Claude:claude-sonnet-4-6 vscode
> Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
