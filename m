Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE6C39A4D6
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841543; cv=none; b=cgnrfecGYh58aOUVM4/2K/OMjqwUMyASs1RCwbz09lV13sjmVhpnZSJJdEEgtoDDUK7tDBHq8etJMVRxjvYmSU/8BR+t2+GXWzqPjHQVD7zAjx0eTPRkBpgLFGNIQTIIfGdWThCXyPMMbvoBipRbGN68eUCmfRfhYT22oMH15A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841543; c=relaxed/simple;
	bh=EUV4jR3Xmrm+zvbQKNKQvNj7dgrJGr3KYjlMK8xOQSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X50IWnEm44Nfgdy1YxHiy2I1YXW51UGqnfE1Cp0mv8mV00qzt/jfLL+6lkanyxzAMhb0Yton/3lpnG0a2K8FudOyIcF7u371duMj28I3VQhUrjmtaxNOjezOytWHa36nk13Y4r9+iG4jbedZ6YlDyJIuQrPudUouFPf4xZus52k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xy/efOQg; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xy/efOQg"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ab2bf5e75bso1153862a91.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791841542; x=1792446342;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cTnyIzo3AeEH1eCQ1+EfSK06BlNNlyFOOZ6a77pSqG8=;
        b=RZ1ImpZzrxz9J2sKjDvlGdf/Z8AvVbTtI8uwxRmzmdky8ZPBFNzzIGfomITpjAt3zt
         B4c1bwfiTgZgH/gEm+LSUGaE5MHnAYvG+DvanTi7phSWDK4d6IY+3nBVRpg9RTz7glOt
         cKjcgH6PJAWwH+MIK/OCJwg19QyojHRhb5e3xjFU2Ryh4XAXbfNG1QZV1rC/pkjiRRjF
         DjEHF+BrQCgk8fc8yn/ra+HMcaIUfaQ1ElSJAw8LfiALnayuZ89PTDZRjA/iOrSIELYJ
         /zr6T74bn5M/I1WBVDYA1pKR/N1893hJo3lD0lhnLDpAU1/EZ0lsr0cVA+5YmQzJfrUe
         I+8A==
X-Gm-Message-State: AFq9FYLHxgZ384P36Ax4cKgGSG3rkPFDal/9LODk3maz14iDqLRKrXQR
	Jy4O9ez0tG15++Xom1U+DVt3/ZY8Z+t8asS2yDUubAnG5Ikr6TxXO2K04U1/Zkrw+ghgqHVHHwA
	TeGqJ2e4C96yvQuJTwtpxrfM3bs38qsxB8Xjxkh5/XMCPToRrtqFyOjlJ1pEvEO5bkDWzrvoGD+
	+mNudAoitSIdygvrFRQONLdsw6XtTNWMZBdkTL2t6YzDY9D3rDwpRgNPT2xdMQvT+nOpb1afjqz
	qTHBNQz97fTitR4
X-Gm-Gg: AYBFou2jvzow8YftrlB+bgKk8t0ERIhGR+14e98X9w3dxf39BgWGnL3hc5U9qzQUQTD
	lqSKCMxmtp+H9lT7xsXclLPUcWQegq+Mxx07a05mKU3BYuZZaYfAQ2dspnpE1fCxqee45q4Z+f8
	+puw2auOt0/kM/ezrxYB0bGMp3b1TODyKttQkfCzI2aWwt1pdfdy7Vu+ZK6OL2+hddJevzdgTi2
	toReVmU6HFcB2fAcjTVQssflpON9xbzDeuoDiPaZOmbuivQGz2LpH5J3dkapOTH6kj9wKbzMFDv
	WAze/Q1Eebjemo/X1DmMLnEA42O4RMUEw565ohGcGma0O3cpw77bWUqBctJAqqamF2qinK9mEdh
	doS3+a9e8qhHLeZCbpxekYiUrkjOtJ2MVQW9p5ahA6f93DHRClimDpHjpSIBS5OH6VT1vhm7eNR
	oNYVMAOL6MdmCtMat4KAkTpnY2cdqSs89TN0utFowCIIY=
X-Received: by 2002:a17:90b:2b4e:b0:3aa:9a32:5054 with SMTP id 98e67ed59e1d1-3ab3ace05e2mr8266899a91.62.1791841541970;
        Mon, 12 Oct 2026 14:45:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab36d74b2fsm6119800a91.4.2026.10.12.14.45.41
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 14:45:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3510d0baf63so6558670eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791841540; x=1792446340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cTnyIzo3AeEH1eCQ1+EfSK06BlNNlyFOOZ6a77pSqG8=;
        b=Xy/efOQg6zSpJhgpgs//X8PVz1fyhubQqm+pDUisvRN3VanR7bXOl/czGSyar00wVK
         Rm2QQv/Z43PwJZux6lErFRqYgbK6MGunXfxz7MjiyO1d9/BD+OsjXdasfJFMDTy2w/Ds
         PZYmWTYGRayUufg+cFofIbGhEhtRBDq4fXHXs=
X-Received: by 2002:a05:7300:ec8e:b0:351:1bdb:e3b7 with SMTP id 5a478bee46e88-3537e0792c4mr14600875eec.15.1791841540087;
        Mon, 12 Oct 2026 14:45:40 -0700 (PDT)
X-Received: by 2002:a05:7300:ec8e:b0:351:1bdb:e3b7 with SMTP id 5a478bee46e88-3537e0792c4mr14600828eec.15.1791841539253;
        Mon, 12 Oct 2026 14:45:39 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e02asm39290375eec.27.2026.10.12.14.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 14:45:38 -0700 (PDT)
Message-ID: <8f019666-30cd-4c64-a40f-43982b297d2b@broadcom.com>
Date: Mon, 12 Oct 2026 14:45:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/8] net: bcmgenet: derive the receive buffer
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
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>
References: <20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc@tipi-net.de>
 <20261012-nb-genet-mtu-nn-v2-v4-5-2e2e3bfaf8cc@tipi-net.de>
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
In-Reply-To: <20261012-nb-genet-mtu-nn-v2-v4-5-2e2e3bfaf8cc@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/12/26 02:00, Nicolai Buchwitz wrote:
> The receive buffer length is a fixed 2048 bytes. The packet ready
> thresholds keep whatever value the reset left. Neither follows the MTU.
> 
> Compute the receive threshold from the MTU and program it into RBUF. The
> buffer length follows from it, with the status block on top. The MTU is
> still fixed at ETH_DATA_LEN, so the threshold comes out at the reset
> default and the buffer only grows by the status block the hardware already
> wrote. Derive UMAC_MAX_FRAME_LEN and the flow period from the MTU too, with
> a floor at ETH_DATA_LEN so a lower MTU does not stop the MAC accepting a
> standard frame.
> 
> Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
