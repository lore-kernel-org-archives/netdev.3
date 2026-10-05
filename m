Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB08142E41B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241920; cv=none; b=CBPmsZNUsihJHE7tiwZGV2qSPFgHcj4I+c+xjrq5AhO+jsl2QSvLwMC7apFKoARBkpziF111A43Q0JwNejDElpoNeva5eFqKylO3R1lDvvU2pSVlnYKnpSfC6ilE88PPfCAOFM3w6tpOOj08Y76HPyIuSglrhHehF58MV9oHreE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241920; c=relaxed/simple;
	bh=NClSQG2nR5RIo/DxjpVhsRM+ggSNw5Mni8L1nmeSRhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8Jon7EN0eFoSH5Bp4HJRW1OY4/wxJ+Oz4fT+Sr6pbV/sfta5/9f7m8hy3+rSOds3vRnvFz/O2U06TvlFCe0sEihLvM+UydH7JQgqMUrjZWUOWA3XdDMIGKbt8VWw/84PdgC4AOvvfbL11VzyLm+TEr/j92KvJRGQFx7cR6EcN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P6fFjsAD; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P6fFjsAD"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2db18e5cb56so3628395ad.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 16:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791241919; x=1791846719;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=94iLiTY8vyM8AFBst9Xq87yk06idrSO1lJMkk9ngQeo=;
        b=0udvjntMkcu4cB0rzFH9hJhtr3A19BS5vLeNUOmoxdmlpYJIAcA/6radHI4rGGOb0j
         J3qWoFDI/CPMpZ3M+Ys/DRpwa6FFEBqnd6RdiDp1vQG6VaNvJX/XaiGSFdqUoTx8eKKv
         5pVHQsDFgvLg/3oc5aL+NFgQmkYVwhRIy8eg28wvpG8Mj/KNfSMEAUY2LPsdIyy4okt9
         1cLnHr6yIPsTdKXx0Q+sbG3e1DgWlr+8q+Bk34mMpRa/s7ABSJRZ1wMs8rRxAohOKTS8
         FPItOpGVPumgkJSW9v4nn28QJM+yFRSATPzkzEsh7YGpjCI4dubODqLRBxIswGNXK4o1
         XSkg==
X-Gm-Message-State: AFq9FYKWuf03rNZ4iz+x9LnV+p1nHdXqXeJmCNuaIYONcIbYhLIExp/E
	yOpMEPt2AKO7GF+tvBt0TiCNlFU24cXtfRq+wOcHRMn2IP4eGExR9xofZ+WA8s31OazwzAJUedl
	3sBSll8Mcq4NMcbc2BKO18GobnYgsBpIEDZZ/usWq2a3BaPByPx8x4RMr1VzHATZNDG3Dk9A5xv
	09UKsNZxNvcW4hyuZWta97hN5/37I9kzO6+tZdKYhvI8z9X4VAz+8XdE8zjAiAxSHj6MLyWbh5F
	RfZmjOgNuB4Vgtv
X-Gm-Gg: AYBFou0teAKooXB8DzMnzgKqH3tWsYxNfj6dq1X2OxFu9yGOFdrhTewM6/y9UEk0x9X
	+zhOiOcv3wWxFYtVWq4tlDEUkhM8ItyZ6BtdypI/W7OidDN57iep4fDlNq2H/yuehunjvN7pvG1
	8AbD2wFyM+S8PMwIuWU1efnVbNS/GnIrh10V1gVHx63JBTh1r/EBXs553WBx5GeKNOmzIepfUSq
	He4riW30lQhAtjY6VJ5hh0i5fWUly45kpSj68GZQnZrnt624rWxS/f9Dn60Ve42G9xrfkj4j4/q
	Tv8kVkSK+f4UBZrWMS8GmXTo1vMXpRXtYOyt3JHIsH/6NR0IVFbSriXDzC7lKqbUVx8fn1EIaZY
	/reAkxTmWEXigL45dwZMVdzi/mSzo5CDjJvcCiCaTYj49uqEsiRMKLpJXGl+zYYj7vxK+KV6waA
	mtdHZgDtBmyiy2Nq7TbhITVoxoE8xOkNa5LFt2xR8r1W8=
X-Received: by 2002:a17:90a:dfd0:b0:3a4:bc68:310e with SMTP id 98e67ed59e1d1-3a6ce7f684amr8488194a91.39.1791241918807;
        Mon, 05 Oct 2026 16:11:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a853e5dc1csm465365a91.3.2026.10.05.16.11.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 16:11:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-313d1015161so6628864eec.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 16:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791241917; x=1791846717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=94iLiTY8vyM8AFBst9Xq87yk06idrSO1lJMkk9ngQeo=;
        b=P6fFjsADraItraC0EA4lDRjeeT2d2tB+I8X00TZ9LxIcdpEA3wtpjT2Ks4OlELfnKl
         UMgI+raZcYxngOYBM1f96zELTm/+QPXOJmlu9A/AGSaQmJoXN29tLZdwa6PCjqQTd7Km
         ypabUFuqViFZq21Uf7E6UcZSCR1aPEh95vdNU=
X-Received: by 2002:a05:7301:dd88:b0:34b:efa3:ea63 with SMTP id 5a478bee46e88-34f179f68e6mr15021939eec.28.1791241917008;
        Mon, 05 Oct 2026 16:11:57 -0700 (PDT)
X-Received: by 2002:a05:7301:dd88:b0:34b:efa3:ea63 with SMTP id 5a478bee46e88-34f179f68e6mr15021910eec.28.1791241916349;
        Mon, 05 Oct 2026 16:11:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146b16846sm2868121eec.28.2026.10.05.16.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 16:11:55 -0700 (PDT)
Message-ID: <ac05e2aa-df42-47ea-8142-f1e1fc9f5164@broadcom.com>
Date: Mon, 5 Oct 2026 16:11:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/7] net: bcmgenet: derive the receive buffer
 length from the MTU
To: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Justin Chen <justin.chen@broadcom.com>,
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>
References: <20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912@tipi-net.de>
 <20261006-nb-genet-mtu-nn-v2-v2-4-c4be21151912@tipi-net.de>
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
In-Reply-To: <20261006-nb-genet-mtu-nn-v2-v2-4-c4be21151912@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/5/26 15:24, Nicolai Buchwitz wrote:
> The receive buffer length is a fixed 2048 bytes. The packet ready
> thresholds keep whatever value the reset left. Neither follows the MTU.
> 
> Compute the receive threshold from the MTU and program it into RBUF. The
> buffer length follows from it, with the status block on top. The MTU is
> still fixed at ETH_DATA_LEN, so the threshold comes out at the reset
> default and the buffer only grows by the status block the hardware already
> wrote.
> 
> Program the transmit threshold at its maximum as well. It sets how much of
> a frame the MAC holds before it starts sending, and holding less buys
> nothing. A later patch lowers it for the few MTUs that need the room.
> 
> Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
