Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43049516161
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753149; cv=none; b=FOuwsXO0cCKMke750HD+W7GSOuC+xV2U2YYYMpj45jiy4ChuUDK+k0wVcVPS8YVM+AVHILfFD/53K0QWGFO4zo+Fuf86K7VzjKW3qkp5Nl87zHZEx7Y3U2x6oxTHPuc9BEquGu2us4X4jICnQMmdPW9y9Idq+1IIUx+WfEKM5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753149; c=relaxed/simple;
	bh=b68SMbhqEPsGIKJhflr4X1Z6aga2qlXGVURaZgut1Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWvcJx+n52j3Una+1LfUWJbHYDIVydjjPioFXD7dIE0paUEkp8CnStPNSI7vk7ge9jKVozLUHJt9VG6Q4idfghCMutLo/hSB0V9jKCeaf8q0XRv3Jg0mg5aPab1aGg+DEVAyhHyOezI3Rhj2uifkUeij1yiLSNtK/iA0FjbULAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Lh9gX65v; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lh9gX65v"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2d942c7cc2fso2985015ad.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 10:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789753147; x=1790357947;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sncqGjwoZ2ISwzGsUBmcxEN97dqN/iEU1rIWLc2X1fQ=;
        b=E9QlZqf1o6zCPcaeq587S8jmqkTvg03u2H6vYPzbZmEEnbIKKpFgN4Ymjgp4ODFhk/
         pAlkWiUKHrF9019Zhqy352lym0hDcTtQqmZ5uKtUi9A86PHan03F6Nkbr8RlTthXm24D
         VqeekmVJtUzC5Ikksu8lfZBO6P2xyvx8NuISIJWeI97i8cvn791kmipxtoYpdfSnv44F
         s2muzIob4SYLjMIEptpLKH5cAO/8/bvZ9oHevF3QGeoGpYsrO0/omCx4Pnt+dPwKAGI8
         QwRWDK5Uop27Qu2eVGbnWpgtbcRPhffsVnUef27CBp8Rtxlo3wDQFRozBDGxcxhXienI
         SnVA==
X-Gm-Message-State: AFuF++nJDmMdtwpa6U0bCSrtV76IMNjwtP9UJ90k4da3hdPTTTf5iTpJ
	OT79/mDa+vooUI9qD268ZmFCRs3PstTBT5w0a5olgH52SiOORro9OLAPcy735/DkX+KqDQjuLiv
	5ymlZ6H4JQaLy29nVQQv93/W6BkBztMlDFD4eUvm6Kbd5USxnqlMxo+HE3Vercr0FTOI8C6bTKZ
	+AKkp7SuOICk4hkx0PnSRMRMnSwWF+FLGd76L9zlU7Lex5eoQCfPY9IKMGBtO6uhcDBBw6AqyHy
	i9ZEZZ0GSM5Un4e
X-Gm-Gg: AYBFou3CrFfRzV58msMRIWVxVwDOW//SPOZn3gIR+Q+NcK7+ooIJFpJxmnuazMBRi2e
	u6DAyt+rIkt7lPEaky52UZ/9YztX+YN0H28EeLmOzIwLQ8z5OSDoGwA1oSooDcsMokSi1nhJvRm
	T12y2HBBdco6OY2DG1NSyxM8KQ2Tk+iF4D+L/qtrAj+cz+ef60IowNkMcZtbq1cHpT4XIQWYMxw
	QCAPtU9kbRzLCumfUWYkEKFK64I9Lf4B58uqZDqaOzrxLLYW6qKDYoZHu/sb4K+pxPjNt8OGtnQ
	BnjV5S4kLuU12EZvYPjsfIA/KpKs8JlnSAu1FtRK/k59jmuFmo77LXWydiq5+9MM01w9y0c8QRg
	AyWW0oIS11vbFSOC853ncQI/672TEmnyPputuzBIQT5qd2X6Tl9NyeNHfmeCr7rVEK5HoimTMqb
	TqOTlEjSfYHYq0tBBxunMxYPtMaCzjLbAzU8ZwQkpaMdo=
X-Received: by 2002:a17:90b:5305:b0:39e:4c81:6c64 with SMTP id 98e67ed59e1d1-39e54dbeb52mr6546535a91.31.1789753146511;
        Fri, 18 Sep 2026 10:39:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39e6573e104sm119841a91.2.2026.09.18.10.39.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2026 10:39:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-530f5e827c6so21666001cf.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789753145; x=1790357945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sncqGjwoZ2ISwzGsUBmcxEN97dqN/iEU1rIWLc2X1fQ=;
        b=Lh9gX65v2zTZJb3HEeTyPjzCBcBOhuiz3FJVHcI8y3i6w70vdhMaCb36UJ4GaIS+YU
         X2ISn0xntpQ58ia9onwMl7a8FcEKB6XCLOEw48sxdq/NFSHYtfg+sFGOOgQR8lmdFm5I
         Qbqrm0WN+2v8b3c2/GcNcu1i0ot48PASqwElY=
X-Received: by 2002:a05:622a:30a:b0:532:84d3:ac7 with SMTP id d75a77b69052e-5329e47ff64mr57465731cf.41.1789753145287;
        Fri, 18 Sep 2026 10:39:05 -0700 (PDT)
X-Received: by 2002:a05:622a:30a:b0:532:84d3:ac7 with SMTP id d75a77b69052e-5329e47ff64mr57465261cf.41.1789753144786;
        Fri, 18 Sep 2026 10:39:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ae76d5a7sm1954151cf.27.2026.09.18.10.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 10:39:04 -0700 (PDT)
Message-ID: <06a2be46-7ea1-4ffd-a6d7-95ae4d94ca84@broadcom.com>
Date: Fri, 18 Sep 2026 10:39:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/8] net: bcmgenet: clean up RX NAPI on
 bcmgenet_init_rx_queues failure
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Cursor <cursoragent@cursor.com>,
 Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>,
 Simon Horman <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20260918000732.276506-1-florian.fainelli@broadcom.com>
 <20260918000732.276506-5-florian.fainelli@broadcom.com>
 <d8b67a2402ec38f7cb374c5b223afb81@tipi-net.de>
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
In-Reply-To: <d8b67a2402ec38f7cb374c5b223afb81@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/18/26 03:43, Nicolai Buchwitz wrote:
> Hi Florian
> 
> On 18.9.2026 02:07, Florian Fainelli wrote:
>> bcmgenet_init_rx_ring() registers a NAPI instance for each RX ring via
>> netif_napi_add(). If bcmgenet_init_rx_queues() fails while initializing
>> subsequent rings, bcmgenet_init_dma() frees the RX buffers and page pools
>> but fails to clean up already registered NAPI instances with
>> bcmgenet_fini_rx_napi(). This leaves stale NAPI structs on the net_device
>> napi_list.
>>
>> Call bcmgenet_fini_rx_napi() in the error handling path of
>> bcmgenet_init_dma() when bcmgenet_init_rx_queues() fails.
>>
>> Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
>> Assisted-by: LLM
>> Co-authored-by: Cursor <cursoragent@cursor.com>
>> Change-Id: I45982e0e198a44f3f56b1300f462870462b81108
>> ---
>>  drivers/net/ethernet/broadcom/genet/bcmgenet.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/ 
>> net/ethernet/broadcom/genet/bcmgenet.c
>> index bfb74dca55d6..ef155a170fa6 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> @@ -3167,6 +3167,7 @@ static int bcmgenet_init_dma(struct 
>> bcmgenet_priv *priv, bool flush_rx)
>>      ret = bcmgenet_init_rx_queues(priv->dev);
>>      if (ret) {
>>          netdev_err(priv->dev, "failed to initialize Rx queues\n");
>> +        bcmgenet_fini_rx_napi(priv);
> 
> 
> napi->dev is still NULL here, bcmgenet_init_rx_ring() only fails before
> netif_napi_add().  netif_napi_del() does netdev_lock(napi->dev), so this
> oopses on -ENOMEM at first open.
> 
> rx_queues is 0 in all hw_params anyway, so there is nothing to clean up.
> Drop this one?

Yes, that's a good point, thanks!
-- 
Florian
