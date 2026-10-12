Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0484EE869
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841809; cv=none; b=SC5IRp+Kc1vEYeYZG3OF4D8vGBMelShZG9z5ox89aBrHDsQ+bv56PJCOB1zxWryWdtuIsq/n8JawrKJoNmb9Y0REjrXnIHX6UTlYjwyvicZAxA56GKwjga5gK/5HjekSj/8GrL/XO5p9+OArKPwuVW5XxUVprlQmorKVj986CLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841809; c=relaxed/simple;
	bh=nbPhqW+eWC6Cce9PnKbS6LgbwFkV8/9/Y4NY2DrQSY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BTVOZzw9xGkfUE5yyxdXzFU71n1Y/QyggUdDJWzIw21Nc7kIQTNptaoV/wQna8iG2P8Zd1Hi8juGWfhmzJ5mMa/1UEkqkUCArU1tDj0mEvPPtr13ykni4TF4aTEDH2fRk+ymqA0xQiqcr+hUmkgmXmGDcONqcPrgqMtDFzZIk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gLRgG5Jf; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gLRgG5Jf"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ab868eb9cfso930486a91.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791841804; x=1792446604;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=//4tECdi8BFJKV6WG98OoZqesXX7E4bq+4mUAnkqPdA=;
        b=T4OCD2tYESBEHyrq7lskRfxgeZIIu3hI9RBxPQ6CsHn5XmKeKZF1rJT5WttmwI35iS
         3UQNocv1S3bqC34qrvRi1zjfcL9hWZUhpWj0+roTJp+Q/wlOohLHPtg2EVpVmEyA4OJd
         GYlFMm6GzDhEw8Q5MzQCdD4W+/A1yS7apAjm+TBfgVnoa3jlIP22QvbaX7myuqe3iqUA
         bkEO5eNk/UkVzkRPDMMhbfj+PjH6I9W7Wg3JMZnpsf2vayV7W0HBZ89ySPmpteOA0SP0
         zxSABuKieMrtcFkh+pO+hyTO0R1UNanEBkizvYluboxgNDBTWknPXVBN28oM1Bg+gz3p
         UeyA==
X-Gm-Message-State: AFq9FYK5GTZm/ql/1+Kjn770rxboE19ClOhaAOWjZi7B/bYOzVw57SU4
	q9YXWgcSNvpSvdjgH5xMisFr6lW74MfAHCRKsKIZWuvGPxkd5MVwcFKTZpkyOXjIMg9LNWjfffk
	k9L0yiV+czAhvqdAURPOApMAgoO1IljJnttOixtbjOSLiyBtlUQvwTSWQk31oGYO/qgmdf1V0x9
	f/uwmL+lw9CG033qc7USNptW5s/4b1/9s4F16hCfAn+W13bahsyY6j6MUtPxrPPzMsksQUihiGq
	vLqv6njCTq/xiyD
X-Gm-Gg: AYBFou02WlPl0xytn3U4x5kcBBmY+9qg3OFdMozcgRK4enipEhtnYoRSCW/pMABNq+E
	CJmbKLsAq1I5MrYfM+M5aEQtQ+zotga/GP+qzX6694jNy1OpVluUlhinVx4ERdaEOd0ZxjGZg8D
	OO+jeBew8ciwjYVvMyRMmta5p0elX89UUdA+5qLT827uMTPph8iKgdGN4Z5RscWxjGRxsPc2CPI
	CPdhJ6mxbaZX+fnBIQyL8mF+xRLUF3xwCmtVgJ1EMmUMhYU8uJPKANWq59Uy/oOQ5KUfwK/BCbQ
	YlduPnGglK95x19nU0C2iS2ocsyF4dCfteR+LkuQ5ZIB2YylLlpyK273qCN/2QsMDq8YImKCVYm
	1MxIlmqmIvv/fhEg/Kwt2aC50m459O+J2yqVRO72cZWb7M69PYjqJAogjJqn0lqdXaKyDF3zgqq
	kavlTGk2DC1N41etCArR4Wh611Ys6329uGza50yWxMiEE=
X-Received: by 2002:a17:90b:3b90:b0:3ac:17c:6e7c with SMTP id 98e67ed59e1d1-3ac017c7089mr2924673a91.37.1791841803701;
        Mon, 12 Oct 2026 14:50:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab39617e13sm2490855a91.4.2026.10.12.14.50.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 14:50:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34ef0362d95so3421800eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791841802; x=1792446602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=//4tECdi8BFJKV6WG98OoZqesXX7E4bq+4mUAnkqPdA=;
        b=gLRgG5JfABefTspfRGXUszzuVV8b8u1Y5y6uNo5pMLNE2tifMlT9rEqcG2J33E07wL
         keM99okg8eTxGIiipU/nyUPL2mClZ0V2a49oW2VEdRX2DdZLbKh+t2ByU0jadevBNCdS
         APbqvMtOrx7d3QqG+V1bjf1n+7vWGMz1uSwk8=
X-Received: by 2002:a05:7022:1605:b0:151:94a6:6f5f with SMTP id a92af1059eb24-16a5fc917b4mr17679598c88.10.1791841801565;
        Mon, 12 Oct 2026 14:50:01 -0700 (PDT)
X-Received: by 2002:a05:7022:1605:b0:151:94a6:6f5f with SMTP id a92af1059eb24-16a5fc917b4mr17679544c88.10.1791841800836;
        Mon, 12 Oct 2026 14:50:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a620bdafsm42915443c88.23.2026.10.12.14.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 14:50:00 -0700 (PDT)
Message-ID: <9767d40a-7926-42a5-8acd-67183a68f8d1@broadcom.com>
Date: Mon, 12 Oct 2026 14:49:58 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 8/8] net: bcmgenet: reassemble jumbo frames
 from status block fragments
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
 <20261012-nb-genet-mtu-nn-v2-v4-8-2e2e3bfaf8cc@tipi-net.de>
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
In-Reply-To: <20261012-nb-genet-mtu-nn-v2-v4-8-2e2e3bfaf8cc@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/12/26 02:00, Nicolai Buchwitz wrote:
> The hardware does not truncate a frame longer than the packet ready
> threshold. It splits the frame across descriptors and writes a status block
> at the start of each one. The first fragment then arrives with SOP and no
> EOP and is dropped as fragmented. This caps the MTU.
> 
> Strip the status blocks and reassemble the fragments. Only the last block
> holds the checksum of the whole frame. Broadcom confirmed from the RTL that
> every GENET revision splits long frames this way, not just the v5 this was
> tested on.
> 
> On transmit the MAC only checksums a frame it holds in full, so anything
> longer than the threshold falls back to software. At jumbo sizes the larger
> frame saves more per packet overhead than the checksum costs.
> 
> UMAC_MAX_FRAME_LEN is 14 bit and counts the FCS. That puts the maximum MTU
> at 16347.
> 
> The TX descriptor length field is wider than DMA_BUFLENGTH_MASK suggests,
> that mask only extracts the length from the RX status word. A frame of
> 16361 bytes, the largest that MTU allows, came back byte exact 200 times
> over UMAC loopback.
> 
> Suggested-by: Justin Chen <justin.chen@broadcom.com>
> Tested-by: Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
