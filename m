Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D79B3B42F4
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841095; cv=none; b=ITnORIMEshOM5pOBSAVKNjg8zX+aeKlQn1yVSC0yD9s2C8uGGouMEVbUzN0Ae1AtETNDHtdB+IVYIMlOZNYMagZzgTfBz1Z/JaAo1yLbUTDxce/+ob3it/Pl9hTTBJ+iXaaB2j44UsVdxz7XhHLQV8KX7vqbZpzsA4JF68YtsWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841095; c=relaxed/simple;
	bh=qQaH3L8BpbCXELnWiv04IgP9typ9bfpn74Gyn/ZyzO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMA1GHxTgtzlIlda5ZR0G6FBop98GjOUADHYFCOIYk2VjZTJPDr0qIy/457LgZqmp6kZUJFhyJaslSRmRGPc+nbXth/lxQbbrWEACeCiagbgLlhhqO3+jmZmjHLYtgrFSdgk4aw+g5zc/e6QbR/WJSft6nZVTfLuLEhhG4NUOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MVhqzwmE; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MVhqzwmE"
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cd3310348d2so1887665a12.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791841093; x=1792445893;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3vlSbo4Pdnjbh8waT5OPK3ABW3rN2NX05GJe3pGPoqU=;
        b=aBmiKmrvcBWBIVANdY+NmErhKKbKf3pRNK3hkPURA5AQgx37bOYQiVxcMcm2asv2Sk
         3dTA1svTaE4kC33rMAfFuidCbWx4baj8MXcbbXMonZbRQSEcqQ1YI3kwUG/XHaC48KTX
         bCR8+w+/4SwE4PNIFdWp2qRPjAIc0Ge1ESzAjvl2OrgCllcUtKMgVs8zDUNmu2tMUk2Y
         CjFs9XCDeuEMgp9NoFg2fkxWSARlWm1hiLzypSSfMsDnv3x/22cLh+0sDwDda7f6c0Ss
         62k//2QrqfvsVxtlWBBtriSuWvFdamgI4sLI/hiz6vJ3rNRd2xIzsEgk0vIJpuzCaEKP
         El2g==
X-Gm-Message-State: AFq9FYKp0dLXXomNWTZg9MdiGQtiJpgChz3eoFxsSlN+mufYFHICLTx7
	pRaYtZ2zbJ7BiTx5HD6REGCDly3geE8gXAE6fQOnfGU4cosrHBopbL+tBs7FtpnaCL3upnSb359
	dF6rmy6UEgw7OAczbC59eA+0lhDvDOY4fzxWF284W4xMkeM7CzDaqhXW1ke3RSamedvbj1t7WwB
	018lJQ68S8/eJEYgzQ/QqyyE88FkEpyC+Z049Qz1em7tYXmNzj6hf9KBYC0MEaWySRJJh8xeHIJ
	rtDOEUSkde5Mf18
X-Gm-Gg: AYBFou0t3NX9myEsEeDhk6eKKqOXlThw/NCGNO8M37RRZRh+CmQjWOADkumElIwH9Rd
	+t80rGJzw6YGo5zNR3BPS0kEpq3LmbiwaUqAvn2yknuExUuyYea81hIqwQTO5owtYLl0c+6Q93K
	MQwuaEhOP4FTHL6gezpu0TECQhiEJHfUa2CVdP9Q6MDLdev/r9tlRlexplPun4xVhO4M8ChxwI3
	I2KIkpQFI9fN0Yu9mgxnayQDQNm2gTgNJH0rzp++uFwTL8qIMI8YTXFDGZ6eXOtU4QGET0TiiuZ
	vJr7ASbhmdJtsf8fjswrxYNALkgXdew6RCiWcNyx8iAhPs3ZEE02EA49mlfkXYoeKQ0xbi0+XqJ
	l7lLfGCsIB7lxce5nTkOQwTLhtjMdey8hVkNJ8fKdaP/uBLDBoeyVwdBCiR3aQayclfWgu1cUYt
	Eny7wQlLY5SbQ4aCJMriPYPhMFbJo2DGkhKbK0NiKge88=
X-Received: by 2002:a17:90b:3b84:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3ab3a369ebamr6170444a91.3.1791841093419;
        Mon, 12 Oct 2026 14:38:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab370e7fe4sm6144874a91.1.2026.10.12.14.38.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 14:38:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-155a75f91e1so6126171c88.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791841092; x=1792445892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3vlSbo4Pdnjbh8waT5OPK3ABW3rN2NX05GJe3pGPoqU=;
        b=MVhqzwmEgoCGWY2566QIREsegkF76pVaIFnuT9RByNtkDbnajlNacRIqUV/nX8kN3B
         eDX0Zv9xZeW23R/NhewLstaIIRzfx47kvEvLcLheIEAR5yy9YtGOYjTCrLXpC2PxUEQg
         tGdD0o1REUzCqVYgDQg7OaTjOPYSfWnQohh0Y=
X-Received: by 2002:a05:7022:e804:b0:13c:f65c:d5b5 with SMTP id a92af1059eb24-16a0b37d130mr15430920c88.3.1791841091439;
        Mon, 12 Oct 2026 14:38:11 -0700 (PDT)
X-Received: by 2002:a05:7022:e804:b0:13c:f65c:d5b5 with SMTP id a92af1059eb24-16a0b37d130mr15430890c88.3.1791841090564;
        Mon, 12 Oct 2026 14:38:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1699718c547sm31698113c88.3.2026.10.12.14.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 14:38:09 -0700 (PDT)
Message-ID: <6ad6d66a-57a2-4f9e-8245-0ab060f07606@broadcom.com>
Date: Mon, 12 Oct 2026 14:38:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 7/8] net: bcmgenet: allow the MTU to be
 changed
To: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Justin Chen <justin.chen@broadcom.com>,
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>
References: <20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc@tipi-net.de>
 <20261012-nb-genet-mtu-nn-v2-v4-7-2e2e3bfaf8cc@tipi-net.de>
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
In-Reply-To: <20261012-nb-genet-mtu-nn-v2-v4-7-2e2e3bfaf8cc@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/12/26 02:00, Nicolai Buchwitz wrote:
> The driver never sets dev->max_mtu, so the MTU is stuck at ETH_DATA_LEN.
> 
> One descriptor reaches as far as the packet ready threshold, so derive the
> maximum from it. The threshold registers are 8 bit in units of 16 bytes and
> want a multiple of the 256 byte burst size. A descriptor is one page and
> also holds skb_shared_info behind the frame. On 4K pages the page is the
> tighter limit and leaves 3564 bytes. That includes room for a VLAN tag so a
> VLAN interface can run at the parent MTU. The MAC accepts a little more
> than one descriptor holds, so a double tagged frame at that maximum is
> dropped as fragmented until a later patch reassembles those.
> 
> Resize the buffers and rewrite the registers in place. The PHY keeps
> running and the link stays up. Two MTUs at or below ETH_DATA_LEN derive the
> same values, so a change between them skips the restart.
> 
> A failed allocation retries at the previous size. If that fails too, take
> the interface down. Running on rings that were never allocated is worse.
> 
> Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Link: https://github.com/raspberrypi/linux/issues/5561
> Tested-by: Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
