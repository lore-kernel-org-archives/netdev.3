Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B48B581229
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887352; cv=none; b=e+oXy4mBBZpJnaDnXAlYAJkoPirc9egzeI1T8yNDmy7v7Sfh3Hq8hlcPz4+nuxgaDI0CB0F9iNKhAgEfdscf0te1f56jqgtKMR6E5AJtLMEt6P9o+KJpSpW5P1TCw0Y02GBEy8pW6zlUOkSiSR7qbJkLSwLGC7UsRGLhWvVTb+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887352; c=relaxed/simple;
	bh=8GU77QZfMpmw1JWT2b/xZyBG15dXdHuBmo0aDHxJ140=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ty3+X3lKcJBk4zv+W6CZFtQYO1hkiIMdaKw56YptC1qIOz2GUCqwEJvseYHr6zg3z/rrn4DkwYCE4pXUK1buagpAVQdmMmPifb8nl7UpJEQJIkCuouy5q6p5bUSeB/uPraXYnR+TAI/deLQ6UVbcHeUxBdpgOQQXOSO4QV/38XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bn46imBk; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bn46imBk"
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-8534d507f59so5135202b3a.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887350; x=1789492150;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UeXFQt2/DYXHVDgRgZbgowxJ9TftyrbrtY8N/UsY7Q0=;
        b=WGWeRp7EXDppEqOY/2KFih8JwE/PWpn2buZH0QZX+R9jxP5912IUEdCnfz09kns83v
         qhUgQXUKbZTix3I1HpNWNkKn+54nTVWpXfibvcPJe5zkKCCejPKvjTMMNnw74H7lWRlm
         gwCrCpfZe7JevbujjrspTUCCENH+XUKutYPfZ7Qcvogk+4H7MgkOv5gm3RPfG0VbFOA6
         Esil08EnjNYXwjOmr75B+nwixzUf/dN02UUKoO7+49MFdIDnN5NZPtwN3hvSLMQ1RulF
         miHZa/P146nvqOCLtV6FURu9vq1FKTEQz+5RQLxKLnAPaQblE/bsfkqmdCI/1YFXoeMA
         wD1A==
X-Gm-Message-State: AFuF++nphIygxw+vVuBpANveydZ4AYqTnOJR4ZLIn1BiEnYqi0AidLqD
	CxHWapTS6gk7rUgNL57flEEbGvUNubJlwqLhOsyp4euZfRshvJ0L+4cUhkheQabmbakYf27ZgAV
	K7Gut3KfJIV0UirD2XBP5LjX1npnjApQ2RmnVQhAahK7mxmnZ3iwogKqIWusKpHe2NbXD7ksb4B
	erCUnf77mxr+pDFXf6vWBGRM6Z9C4FRuU0h5/A/GwTbSI4TrFZIB+aRkDUKTnEenRwlMRIjj2VT
	y38hFe2WVcgNN0R
X-Gm-Gg: AYBFou1oxU5qv8WjVNchG+gYPj9EWw51bqvN11xYyj/7I4PWAYtgPohU2EAlwTbjGVx
	eYSzVrHGNwBxdaV6SwO1BzibDt9sVFhA5kOn0j/NdsYKBkurDR1Z9D84HKvw2FMPotVFaNSALHq
	BWFYWKNEGvxtWBEENNchvnhy7EPZilmPpQco76aK5gdA3LtnjSOcAuPLvLs8/q3Di3PJsRzQ+fY
	+/ZcQKj0oElbfzNPHJPrRyRWLhZYNOMQbyQn4va7Dtk89oeV+TxzSsL6pmWGSzcxkmL3b5PVLlH
	4Jv/N1sBcRA/CEQbXJzJdQxXfJPxW/mhocp2/rkuKaclGnAwqaDyO90ePSUMGYYEqE4wD6KkyUG
	/c7t11UrFnGlcmk8fdzdhNIfVgthe3I6n2nkj37jeQw6UNHAo4BuTbNN8efNEDLfUCD/fPB7T7V
	vkJxwGwSazWQXnb9+y8Lu3vQdb7rb0WBn4BWkwPtaK
X-Received: by 2002:a05:6a00:2d11:b0:85f:3dd6:f426 with SMTP id d2e1a72fcca58-8616a0691a0mr39478767b3a.17.1788887349262;
        Tue, 08 Sep 2026 10:09:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8614e59f912sm4154624b3a.2.2026.09.08.10.09.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 10:09:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d9336581a2so76765755ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788887347; x=1789492147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UeXFQt2/DYXHVDgRgZbgowxJ9TftyrbrtY8N/UsY7Q0=;
        b=bn46imBkuLLYqvRHSPDjrjYrjBNkOITCTppn4T2JKqlJlJ09i/HgIobsgrLuIoZrW8
         Tg4e5sxO32seaiJT7KpdU7rc57MTgxM4RlAkSuTQ6EhinLnz5IjbGRAE12sEQ+KDMIe2
         g9X1ShYpXNRUqvv5Kij5M15pl/6MTzRDURs5Y=
X-Received: by 2002:a17:902:d4d2:b0:2d8:d4ce:7e3c with SMTP id d9443c01a7336-2db12630dd6mr354079075ad.17.1788887347003;
        Tue, 08 Sep 2026 10:09:07 -0700 (PDT)
X-Received: by 2002:a17:902:d4d2:b0:2d8:d4ce:7e3c with SMTP id d9443c01a7336-2db12630dd6mr354078525ad.17.1788887346477;
        Tue, 08 Sep 2026 10:09:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1cdb4acesm58360645ad.4.2026.09.08.10.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 10:09:05 -0700 (PDT)
Message-ID: <70bcc9af-5003-4131-94d9-2c7f23506124@broadcom.com>
Date: Tue, 8 Sep 2026 10:09:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: tag_brcm: legacy FCS: request needed
 tailroom
To: Weiming Shi <bestswngs@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 Xiang Mei <xmei5@asu.edu>, co+28eef7d8af9428e6@bugs.sh,
 stable@vger.kernel.org
References: <20260908165047.2786340-1-bestswngs@gmail.com>
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
In-Reply-To: <20260908165047.2786340-1-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/8/26 09:50, Weiming Shi wrote:
> The legacy FCS tagger calculates the CRC over skb->len bytes starting at
> skb->data. When a nonlinear skb reaches the tagger, this reads past the
> linear head into unrelated slab memory.
> 
> The tagger appends an Ethernet FCS but does not declare that tailroom. As a
> result, DSA leaves NETIF_F_SG and NETIF_F_FRAGLIST enabled on the user
> port, and nonlinear skbs can reach the CRC calculation.
> 
> Declare the required tailroom. DSA will then clear those features and the
> networking core will linearize skbs before the tagger runs.
> 
> A KASAN-enabled dsa_loop test using this tagger reports:
> 
>    BUG: KASAN: slab-out-of-bounds in crc32_le
>    Read of size 1 at addr ffff8880397086c0 by task exp/135
> 
>    Call Trace:
>     crc32_le (lib/crc/crc32-main.c:38)
>     brcm_leg_fcs_tag_xmit (net/dsa/tag_brcm.c:343)
>     dsa_user_xmit (net/dsa/user.c:942)
>     dev_hard_start_xmit (net/core/dev.c:3937)
>     __dev_queue_xmit (net/core/dev.c:4926)
>     packet_sendmsg (net/packet/af_packet.c:3110)
>     __sys_sendto (net/socket.c:2281)
> 
>    The buggy address belongs to the object at ffff888039708400
>     which belongs to the cache skbuff_small_head of size 704
>    The buggy address is located 0 bytes to the right of
>     allocated 704-byte region [ffff888039708400, ffff8880397086c0)
> 
> Fixes: ef07df397a62 ("net: dsa: tag_brcm: add support for legacy FCS tags")
> Cc: stable@vger.kernel.org
> Reported-by: co+28eef7d8af9428e6@bugs.sh
> Closes: https://lore.kernel.org/all/jH6u350kaBRuqklDjd3k3BW4nWzp0tYRjq3p%40bugs.sh/
> Assisted-by: Claude:gpt-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

