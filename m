Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2FD3B2D39
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789600680; cv=none; b=UOE00i1GGvN92f1UGH7MGdlBa3ve0eczwzvnvNAv+LWLtJX1zktI55z66f0OhkAgEk2EMdqbqQOlE7GyERjF9HZ+pod15ttCI2YS81Z8LXxJUyC8hkBDnqkFOcNAsimm5HpWy+VqgE6aXXC+o42LXricED2j8i5RMs5KbtxB85g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789600680; c=relaxed/simple;
	bh=fij3eEOLxurYpPo1Gj1MtbRPxFtSDKvt+BZeN/vOW6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOn5taXFeQSwsokJqkJBfdiBQUqKbB0w1gohfq3W1wIF990gHPyXRWaNQVPX+AfddpsaZ30pOSjqIiv/oVj1Th//6bZL7y+XLdIU+8ha6s1yO89Gs4nVEf9ENJLJJouErDlIcEpsKeZ6OY1tg9KzzPJ1J6WvPgs+rM2KqPvRNGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cZEUumzZ; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cZEUumzZ"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-853e2610bb4so128056b3a.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789600679; x=1790205479;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0sDEArYGlpoxYwz5GEnDLe44Yw0mS5y0ZSiL1JMItsY=;
        b=v8Q71IB6wcB+IQkdfTo08F/e2JaAU7P8KpUVBn3LTS+mdmAEwtB/er9CvR5MdXTq0J
         KOmdhp/KZqjOmaVCVQ43FSMX+uPzeXKL0etIr+6zc3Kjlg7eMOGlzBeXkklsq6ipnETG
         kSI6glzgzmMnWlYgecuzZ2gUdoc9DmQj1/OxxBPMob/c9l8lzEvZj5EevJ/GqwsSS73R
         fuh0UdvjK0g9wUl3hccmH7qWEgBfOOQRmK39jlVyn+gGBxoMPVd7h0pTLMoJ7yGkXDaB
         nFx06WoQej7p3mOsPU9CvfYhMd/hxf57W+jupGKaGLjN5CQnTdQc8Nu3kQva2ALp4+we
         /chQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMiq2ItukKKM5dsRP1bz6OHVP633HSdHXMgBd7J+YLycJ4KGtcPc/NZBfpOvx806lt8BjRGYQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kowZI651MxtmyTRm8dN95ezGM1yogQy3M6ZxTvom6P+qKzUVqI
	Ri66+qM6i6myYAh5nGAeMoDytgVoJA9lNHdBJZnsPV9fxKSrLBuAzbsQoSY7yS8CCc6PV6V4sG8
	t2xwrqrtlOs/Qf51HYbjEskiJY2X2Y8ZtacBFGEAXP3g1HEn3yNFpLzjHNydgzODKG4buSvP3I2
	hdlum4vEw5ctI7sjqIrq4/tTSxb8dFIkkKTJJz8vCMQkINg+5cVH0if35TkNw6p2zgXqNlEIKWM
	jDJqvCL8lQ2sd/n
X-Gm-Gg: AYBFou1GzxA4tqgQ8hnmHJFtkp2l48TH0xWb1MvjzeSska7m9klL14XFLNRO/ChgeNa
	NLw82aqH6sQZHZwQkV7s0OQLA0LsfZuD+GqyNTo6bSxwxlN7maCA800pekNCMR9QnDB4Q6M7Rtd
	YwruAAS/F4KQ3wJEcyPSnGOFTZWb4jLXFMJ62eLW8U/Ir0l7WrclsxWkjkBn+/pyyAht6MWMTlF
	Mv6YDSJFCzeahOg2G+aRZfBK4Tb92NyVYDPpi61FpOBdAsf5l6+jMvt9OkmzVl4QG5qtaZfaMzN
	UjnoCUClVeKJa+AGCTcZKnpwMqNjWQGIty4GZtGwCYAxLyb57xlGybfKryKyM2Qw6nqqRPTQ/vZ
	xVTFcvFtdxsGWWqwKZehrvGX7MtAgmKaK7ssKnG1OVIfPRqLJySMDKuMlCu+EbeQr3c1/VOaO1A
	lnHJrsg/oQhFVm7B3ro4bgZyjpWRhMGqOpCvtT8fdC
X-Received: by 2002:a05:6a00:992:b0:869:6440:74ba with SMTP id d2e1a72fcca58-873433b06e1mr1845252b3a.18.1789600678490;
        Wed, 16 Sep 2026 16:17:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-98.dlp.protect.broadcom.com. [144.49.247.98])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8720104c4dcsm1256541b3a.6.2026.09.16.16.17.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 16:17:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dd7d0751efso1940725ad.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789600676; x=1790205476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0sDEArYGlpoxYwz5GEnDLe44Yw0mS5y0ZSiL1JMItsY=;
        b=cZEUumzZSXonK+ex+nqtcJuFGrCendCNw32f0a5+HTdEA7UgliPRMHvXR/90aP5TDW
         xXnPRSjR0thWBJKBOgk4FMJLNhc6q+hsR8B3iKEHF3IIF0PTGfQ9Prv2ou+y4LNNdRim
         qEAspDOblApibD5CWPUxGQkAIAssmGcO4d15w=
X-Forwarded-Encrypted: i=1; AKwUvBz0m10lrxra4c53fS15W/27qxJLtsqyQPzLorP2qMEjni8sGxovh9HAkJ+GKxHIGyeTImF0gww=@vger.kernel.org
X-Received: by 2002:a17:902:e543:b0:2dd:86a3:232d with SMTP id d9443c01a7336-2dd9c7c2b1cmr18256095ad.8.1789600676554;
        Wed, 16 Sep 2026 16:17:56 -0700 (PDT)
X-Received: by 2002:a17:902:e543:b0:2dd:86a3:232d with SMTP id d9443c01a7336-2dd9c7c2b1cmr18255765ad.8.1789600676083;
        Wed, 16 Sep 2026 16:17:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b2753csm20543472eec.31.2026.09.16.16.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 16:17:55 -0700 (PDT)
Message-ID: <f2c11f68-c787-4897-b5a0-3d05b15f6bb8@broadcom.com>
Date: Wed, 16 Sep 2026 16:17:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: broadcom: enable jumbo frames on
 BCM54xx
To: Nicolai Buchwitz <nb@tipi-net.de>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260914094703.1093504-1-nb@tipi-net.de>
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
In-Reply-To: <20260914094703.1093504-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/14/26 02:47, Nicolai Buchwitz wrote:
> Jumbo packets need two bits that default to off, extended packet length in
> the auxiliary control register and PCS transmit FIFO elasticity in the
> extended control register. The latter raises the transmit limit from 4.5
> KB to 9 KB at the cost of 16 ns of 1000BASE-T transmit latency, and the
> two together take copper mode to 10 KB.
> 
> Without them such frames are lost on a 100M link while the same frames
> pass at 1G. On a Raspberry Pi CM5, which uses a BCM54210PE, 9142 byte
> frames at 100M are lost 20 out of 20 with the MAC counting every one
> as transmitted. The same frames over the same path at 1G arrive intact.
> 
> Set both, which bcm_phy_enable_jumbo() already does for bcm7xxx. The
> frames then arrive and the payloads check out byte for byte.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
