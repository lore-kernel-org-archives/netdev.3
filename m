Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400AD34EF07
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231767; cv=none; b=NDlhVKK3HSliA7FHL09F7PxCB7mitQFr69X47jDNZvJhiUAqGMAkpn58p/F+hSE+B3ieBlsm690TJWsg8sPXhEE6kIfFROHUkqR54jtP9srOuqVE4mvDtaINvVDsGAM5RSQpaiP/BfW7FKCM0cz8BSijLMaV2WNYN+tAoxqUeSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231767; c=relaxed/simple;
	bh=vVftfbO983dMH30ztaHLyqyoAc68CNw36k+b+VcTM3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrE1bza7mcHpGutLtDQfFj/9skmzNSHo4TMmsG+XsGjIC2QPHLchb61/nmn/3WMFqfy+K2mnY0LUdMFVutx8DLpR+wdY7k9VoO8nxQTpUEXdCboRrOZSc6hPb/Bn/wGQiHXotE9neLf6O9VMqf459Tvly2W+ydY0qipMN/LnN44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Od+FmiQD; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Od+FmiQD"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3a0a55fa355so81449a91.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231765; x=1791836565;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZlFJdwc7oi9xmKEkV3kt0BJUfy7wkh5TqERqZflzvAc=;
        b=WO9ZaPTH87WolKNpEnHyrYRPNYEO6usW2tLrpObmY7AuHKABpg3ign5QMDhwH5Zomy
         MgQwqNih797Y74QSJ9ldQYfk9Et+phmk87Io1oY9ZrNpoPQntvEynx9BQoCIA26GSf3h
         2EcZ2N33w6f57dLeuuyPr/JG/ybK2kKQs1rie6q2qaMFZ/l85z7cET2UGYKRAW/xPvX6
         53oYO8y11LMehZqV9iw1yIRPf5FmsMk/Kr7dQQd2zINnuq71hc7SW6MI2T9IbA/viiFP
         iLAk0hmHdZ5HXfNp/f42YXXITvNLZrfMM5C6Ibnn8JVa+ksMBZHXvM5iAQL+Q9JoMegp
         AGZg==
X-Gm-Message-State: AFq9FYI5caH0v0c00ED76oYVmdN02AfcB9Rzpm29PWyZoGHtG72D7Oyi
	C27shU2QUs4svf1uHUTBxjg5eKHCmycuQo8qeKFOvgxax1wmUiQQ23FWEhIRnua/T8yZJn861GU
	govuHZgQh66wiUBaFWmUa4E0Y6OLGe3gYqjNY7unDY6ltnMrZCFhPTiivgJjQTtmqgRGwrUg4hk
	Uj3wN/Iq7zVl9oDR2jwmPGf/F0LF7YCucP4xHzEg9B/wVW7g/wwoWxQPTbkLGQuMQRzf6sOncHg
	PlJl5QBTWdxg+f8
X-Gm-Gg: AYBFou20mD+A6oefzm3R/zmgkjEJKhjf9XVZqaajLTBl23N5EU5zCfL7dNoeYZ9Mnof
	RjktLZCOqJStLRc0U8CLdAIHl67hOlRzA/kz+iK7KPiPJYWwNISh2sNo1uLQM2vQxTiOyPER0tE
	qSWmuKTCXCcDzjQWoLpnMvUNPB2Nok/X7Pzrm6grSbG2jyn4XNLPlZYmIgy7FRL8OypciN1/zC5
	zmxePMNRgnZLFzuU3HedSHXxN9qy4KZRp9ECoJcDGzInLLXQ0ZPL+6nxlAzj78fKQ/YPddZOmf6
	XCzog7a7v1yBh9/SCjLBcC9XwfSa+XRu+/lxiyxu/a+PfeLiaXQtiyjw/e4IzpMlCWcqumOdHMC
	ITTWowTfZjiLQ7D4CnV0ns4gaxpm+oj2iafygN4cQNAGU/iSRJw37qyrD7iwIf8ajsf6d5K3q5H
	pnPzupe9pHk3IywONOXGktz70CYHl+3e0eGGNkJ5nEQ/4=
X-Received: by 2002:a17:90b:5805:b0:3a2:b04e:8086 with SMTP id 98e67ed59e1d1-3a6ceca1622mr5310864a91.44.1791231765059;
        Mon, 05 Oct 2026 13:22:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a853e5e392sm298431a91.4.2026.10.05.13.22.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 13:22:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6f80c76e6so23885025ad.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791231763; x=1791836563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZlFJdwc7oi9xmKEkV3kt0BJUfy7wkh5TqERqZflzvAc=;
        b=Od+FmiQDPKaGZ1BH79ZBGT2F3kncRwMpLwxbKnyJSrpnJN8bn1jXkwyLwMUPPSq4Su
         G4iLz8we8fqMrGm8GoMjeVYOHnRHk7Vxz8VekAfz+tc1FkKjSs5rwR/WLZVCDo6a4YQH
         4u+lQOBYrm903OwyuMpDYPENjlWOokPR3LC2M=
X-Received: by 2002:a17:902:ea08:b0:2e5:73eb:a086 with SMTP id d9443c01a7336-2e573ebbac3mr52399835ad.54.1791231763316;
        Mon, 05 Oct 2026 13:22:43 -0700 (PDT)
X-Received: by 2002:a17:902:ea08:b0:2e5:73eb:a086 with SMTP id d9443c01a7336-2e573ebbac3mr52399635ad.54.1791231762830;
        Mon, 05 Oct 2026 13:22:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5cae50fsm12565585ad.25.2026.10.05.13.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 13:22:41 -0700 (PDT)
Message-ID: <3c355cc7-5b21-4356-90f3-14e8cd48037e@broadcom.com>
Date: Mon, 5 Oct 2026 13:22:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/7] net: bcmgenet: let the caller decide whether
 to start the PHY
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
References: <20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de>
 <20261002-nb-genet-mtu-nn-v2-v1-1-96dc6d54cbee@tipi-net.de>
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
In-Reply-To: <20261002-nb-genet-mtu-nn-v2-v1-1-96dc6d54cbee@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/2/26 08:03, Nicolai Buchwitz wrote:
> bcmgenet_netif_stop() already takes stop_phy, bcmgenet_netif_start() does
> not. The MTU change in a later patch leaves the PHY running while the
> datapath goes down and comes back, and phy_start() expects a stopped PHY.
> 
> Add the same parameter to the start side.
> 
> No functional change.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
