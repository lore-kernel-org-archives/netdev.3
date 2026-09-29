Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A449153E2E6
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790712777; cv=none; b=mbCJ7RTmS8iVHNoGgwtq2dcLFd0ME3QR5vuNo9rie9lv7dg5vLziAWhqggBDO1RufrF9phvZafCfEm+01dGUveyh32cwHw7KVb4A2VNW8HM+aD3qr0pIrEvTqnLyNtZaoXgBLVdJQt8JZ7T33DQRFGFXK82PsrCOvqOqCXFJuV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790712777; c=relaxed/simple;
	bh=KCr62e+H2FVI7hnjekNyacyjNm0sQFiuwwAyqkYTQ9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFJfmfwZsBhrQwhhRnIgbv9VtnC1EN3t5Xnesi19/UhAN0LmTbK6LDq8GQ1zrGrswXVSLHvglRNJqzPk1QjBN5vP1ag+xOrqmLJ5P9WTszBD8tLzuEi7FwEL0ngh2Xl9Gs2T4kdG/KuoOw/9Sqth4aiO9k9GVzhNsNv13+yzGt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gOd0Vnza; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gOd0Vnza"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2df5b0a3540so27789085ad.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790712775; x=1791317575;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kEju3cAlnk83AErEDM2Q7Pq8+4qHPfRrHNF4mftw9ts=;
        b=gfq69EEPVSfCnyI7WXvqP7kjMsIhH14OLb2g3SFO+VELzwwu16+P9WCrUsK3BQM/hK
         v4bZF1GkX1fYK6Rdf/PR6HAegpQsNJe8y+Y6jI2yZCBbbYiENTbOOuDL0bDJ94GBQrb+
         2Fd+f6Tsll+mQOZOWCUcgdw9RfNRsfgc4wlSRsU5D3HuamaK4iHv1DZA/cU2I/aADuU3
         5WGlKqbqbQN5sENYwDNTpdtXxrhx13pFWFugFyCVCDXE3p4c80WesfLS8agDqgza1G3c
         in+hlJb7iNQx3pqsHPOjAyAcTXeqPa3YtIyjANxMwChuyiWBnMWib8wAcpjDlLTDw2Kr
         cChw==
X-Forwarded-Encrypted: i=1; AKwUvBwSdWj5y/I8WGOwsnSF1YvsQFQcbJ6c/AqrpLrIhoA/IRkmWEH315cq2LBxdxL5MAo+cqKnQfU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLD3Xg7gw+fmUq+EiBokhjQJG154USk3tCE7PAkflQyEjv0QTYs
	nx49XX4eplJqRAqM9SgDZATx9JZp2iUcvSZ8AqfKL/bI/61aaHm/ya+t8SFdAKul7LdLmKcevVx
	38mHnHsWcKhzqK94HEYPxyRF68GJnvm/XGeQg04qGo5mc48PGob0B3YSKwybbdfHmaf9pEnqBkd
	XMTSKNkQQK2MZvEv3t38RNPqnQAOgDOC6DayrejzXvC537vnvz+hgOG3rwk4kxrDQiz9+3UhtyY
	GUKNjlyk1SoVgJu
X-Gm-Gg: AYBFou1GtF1vcEyH6njTiykoAwwbw+4MjruHuMM8dgzIBhtOxuZh3p2oCsRVGnOzPYE
	byyICMb0gfq6JU03XauerLwSz5Ot2iHL9iIPxXIzA0lw4LURzvGYZWsjY4LpCgBXIc/qZDOIgDC
	Zbnfhuxw50iH0Jl8n1zeUACIQ2Ue2B5gSGvtlHtgR96wPahYCNg0f3epA6Wste+E4JYhKQ/FVZT
	OYmZ9nkxqGJFDLDhRYJujpuVT70QKC48IMxYylgumf534CzqBQcl3H1KO4yLiWzUhckD4UeuR4E
	QH7ze/2Tgx88G9Zas45ZRXURjShOxs4DaoyZbO5cWX6qiaQnYdAmFoo2k6O5QLtN5TLR545QRsq
	bIfW6sZxYkzzlMDN3mGINpFdkS6gVfIJ7wL2EBRracXrOIGp/hyXB/ijm64PHP2/B2K4ytFTGui
	aydZkuRite+MsggyamluVf+kb95MKq431MkUpM6ekNapU=
X-Received: by 2002:a17:90b:5112:b0:3a0:2662:815a with SMTP id 98e67ed59e1d1-3a4bfe6eed2mr375229a91.43.1790712774468;
        Tue, 29 Sep 2026 13:12:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-124.dlp.protect.broadcom.com. [144.49.247.124])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc7d2dc79a2sm281002a12.8.2026.09.29.13.12.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2026 13:12:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1522714eec.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790712772; x=1791317572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kEju3cAlnk83AErEDM2Q7Pq8+4qHPfRrHNF4mftw9ts=;
        b=gOd0VnzaSAeCw38vxOcjlhRLwihrCDXc12fnWM297CsHRXE5uZbMtrdHn2vxuZBDA9
         s9hgoqZlzgEbn7atf0zqCIndJOdU+UTj/ZkKCjUyefS8N6mQHO1z3Xj27//p1rHEzjSo
         aRcofmznQ/3OcNxWwP5xGNl5kB898L082mjbE=
X-Forwarded-Encrypted: i=1; AKwUvByeEUvMB48JcFgMy3FYoyOJefKIOcPqGmbKo64Tvf2470hfOBawxnypT/ltIXtjgJygOs6vjPk=@vger.kernel.org
X-Received: by 2002:a05:701b:2407:b0:14b:cf58:ce5e with SMTP id a92af1059eb24-14c99ae6493mr433484c88.0.1790712772530;
        Tue, 29 Sep 2026 13:12:52 -0700 (PDT)
X-Received: by 2002:a05:701b:2407:b0:14b:cf58:ce5e with SMTP id a92af1059eb24-14c99ae6493mr433448c88.0.1790712771849;
        Tue, 29 Sep 2026 13:12:51 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14c634f0635sm1251739c88.3.2026.09.29.13.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 13:12:51 -0700 (PDT)
Message-ID: <f3212307-4ab7-42e1-9b6e-04cf2248c393@broadcom.com>
Date: Tue, 29 Sep 2026 13:12:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmgenet: if UMAC was suspended in SW_RESET,
 restore it to SW_RESET
To: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org,
 davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, nb@tipi-net.de, opendmb@gmail.com
References: <20260929192216.1490017-1-justin.chen@broadcom.com>
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
In-Reply-To: <20260929192216.1490017-1-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/29/26 12:22, Justin Chen wrote:
> When the revised suspend/resume sequence was introduced this led to an edge
> case where the TX is left disabled in the following sequence.
> 
> 1. phy link is down, so UMAC is held in reset and then network interface
>     is WoL enabled
> 2. Enter suspend, bcmgenet_wol_power_down_cfg() enables UMAC_RX since MAC
>     is in SW_RESET
> 4. Enter resume, UMAC_RX is left enabled. Since we only enable UMAC_TX
>     and UMAC_RX in SW_RESET. The UMAC_TX is never enabled again on link up.
> 
> Fixes: 254f3239dd07 ("net: bcmgenet: revise suspend/resume")
> Fixes: 88f6c8bf1aae ("net: bcmgenet: keep MAC in reset until PHY is up")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Excellent catch, thanks!

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
