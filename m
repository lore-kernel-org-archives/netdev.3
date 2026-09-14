Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7820448B96
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789414244; cv=none; b=Yetwbx9Y56bkUX176ld8uXDJ7JkeFCYsDraOx5URE7czNibamcM1u0bYbk2LmNHBdq64zTL8+tLcqkEZjkKC7YeXMNcgNXR1+XjDuKWupSsC3DkpkEWrvJP9OwBPYg6rFWaXLQZzgaha+zL+24aVm260ZgaOSVnP3zC3hJm3epQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789414244; c=relaxed/simple;
	bh=cYLy3DJpZIkpJecSb6NuNNbpB32nOfHC19s//UbQywY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVlpMq4VL57dKEDROxk/MNLaMuSfwFqtMVfspwRIVzUnAnOAu4XTgpnJPUQe4HKURrM3IZTKKYayrc4KAuFWefPMhU/bWteg0Ch/+xwK/OOYibWouXGdfvRTREcRqzYMHhO1pdjtqnmP9yg+jwztJutwkkB0TFQjnQEIAHcnHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TvhJdgUp; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TvhJdgUp"
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-87ffa98d4a9so34038947b3.3
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 12:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789414233; x=1790019033;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Bmagr1/j8DSlMpnHTXTSoBqwKOHDTaP5cUCVYcrL4o8=;
        b=HRCQ7mk2plX8+yrkDNom2yuirfgh1DeiCTibwqp2eFga2C+vQDUfmJLGH2ijTf2p/s
         PQvL0UMqdVDUjXz1XcYZoCN0OSLAqKHsz639OnWo0BZb3ybrTO/na1AKusx1y8txAfjT
         qXgtM8i3XJRDF+qWpwIqjh49vOgh69AuQdaOYTJIH3vdgH1brCSpic21BlZAF5nYAKgV
         0tdS4XU90aDoMZWltUfvpK+GUkW2+JqRZ5pSnW+JKDDaFrbWNjySCdjQ8pyOClrSm2yr
         BaZC9n4QoohXZzCNWMaR8taRFLmh2/I8B+AyqcJLk7RoN4UxuhYR5hNrKTEmB7E1DxGg
         L3lQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHErPYAGwp305fVIlCuXa7wXumTGNv0hFi/qK5glPF7xMB5ajtQV9Nd06rnl1QXQ1bUjbjYFA=@vger.kernel.org
X-Gm-Message-State: AFuF++mwL+tCMaIAylhuefXngQjuy094BUCgYfN8QpYjAniAomabWT0w
	26OlQl/f8ViiKmJYRjG1xQazJIWQhtulKk/o/gNMZWewNsyUDRhyWEg15sWUxNO+CGlJsO24I63
	SQ8TQ5y1ZSejKTbpdsUal0P7vZqLDtu7M+3Hg6sjpjw8ga5laMEUGMrnud4YEeszGNNLLgAysco
	92WRPHVDXKZ1nQZSgIzsOdrLZW8LASbpnuAuhu6mEhcChVr3b6v9pEUuBpBQ8AEMa5eZlr0nN3a
	2tv+YupGrp5njZH
X-Gm-Gg: AYBFou0ZmiISkRWWFQL8c42oOcOeIFdYrgWhdx4ThY1kO/fpClIGmm906k3hqgEpb48
	pkoSe2zjsmCsiZ1l/3HMeI/SSjyaQhiCF3QuZSoW7U1BAnKdSZWX6nwMbQBoOuDGSnGIQc90enn
	Yf5vj8aQvmUBy9Cl/0ZFTQw6st+xwkstnjUF51gY60PlXcQkqTtcsOetQ8Td+T1wVYXampRw5E2
	hWPivw0Pxl7y77OzQj/ikO0Jck5afgvUtn3ZeNNvl2EmFLPrbDfMY8opJ2HSq9tpVvGo9JzFIB3
	krUYTVJz9o27GXnu5uj+HFcldgdsA+MlkJWwUs6kcwIt/BvClX9nH30Inno51o0zdNmm18rqcNj
	UmV2kjfLxZT8v8/ztF4EVPnJ0fAOQ8kHxlLRvCfxBBPlfxZnKmT52aUSu0o8pSNggGlz5uItIs9
	ICnfD+ETecEAJBZVrcqFCqTimsYZsMxc/EvOhus57e
X-Received: by 2002:a05:690c:e198:10b0:873:5bb2:6c0e with SMTP id 00721157ae682-88d229f083fmr10121897b3.56.1789414233117;
        Mon, 14 Sep 2026 12:30:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-88c5671402asm822047b3.14.2026.09.14.12.30.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2026 12:30:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-912348a0ffbso1965736d6.3
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789414231; x=1790019031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bmagr1/j8DSlMpnHTXTSoBqwKOHDTaP5cUCVYcrL4o8=;
        b=TvhJdgUp64yAlDYSFQEgfkceYUvj2ZnRt2tpcL6A+Ht14TgWfk1ug5FZ3u1viwevIh
         XWvZ1qIut35CSYLtmWUVGOdQJ9kIuB8g4erlluzDXnKMxeYjcvnB7tp6NP+CH+Bcubv/
         hgvyxnoIDLVl1nkpZlQeQQq6sCHu49yR4nPgU=
X-Forwarded-Encrypted: i=1; AKwUvBxQI/yBjTV6Ajkcrd7uLuukPoS3jeT3tAuF2zQIE2QneAcHoE6mcK0x9BxiEKmfyk/6NT2VrjI=@vger.kernel.org
X-Received: by 2002:a05:6214:4883:b0:910:3fe4:e405 with SMTP id 6a1803df08f44-9122e4ccb6cmr67098766d6.1.1789414231482;
        Mon, 14 Sep 2026 12:30:31 -0700 (PDT)
X-Received: by 2002:a05:6214:4883:b0:910:3fe4:e405 with SMTP id 6a1803df08f44-9122e4ccb6cmr67097416d6.1.1789414230798;
        Mon, 14 Sep 2026 12:30:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4b3dcesm102481586d6.31.2026.09.14.12.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 12:30:30 -0700 (PDT)
Message-ID: <2c901027-93d4-4db2-8cac-8b61aaa6e28d@broadcom.com>
Date: Mon, 14 Sep 2026 12:30:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmgenet: restore the hardware filters on open
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: opendmb@gmail.com, justin.chen@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org
References: <20260913190052.939955-1-nb@tipi-net.de>
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
In-Reply-To: <20260913190052.939955-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/13/26 12:00, Nicolai Buchwitz wrote:
> bcmgenet_hfb_init() runs INIT_LIST_HEAD() on priv->rxnfc_list, which drops
> every rule off the list, and bcmgenet_open() calls it on each ifup. Every
> rule the user configured is silently lost:
> 
>    # ethtool -N eth0 flow-type ether dst $MAC action 0
>    Added rule with ID 0
>    # ethtool -n eth0 | grep -c Filter:
>    1
>    # ip link set eth0 down && ip link set eth0 up
>    # ethtool -n eth0 | grep -c Filter:
>    0
> 
> Initialise the lists once at probe and restore the rules on open, as
> bcmgenet_resume() already does.
> 
> Fixes: 3e370952287c ("net: bcmgenet: add support for ethtool rxnfc flows")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

With the sashiko feedback addressed:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
