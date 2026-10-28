Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206812;
	b=B66aDGZaFR1S9hZxC6HddWDIoJBcR+45wZsyqZRtQZNJcPCC1BIoeG9qQ2uQAhhjVyKb
	 2eA7XrLqvvZiUN2Ddfe1UEPDh93QXKZ1pWnb6Qq4LeWCa5obm2nrmQ4M8cZnZlwBI8mBg
	 CQbEz4RfTVO5Hj7y3+Y9yG/GCQfTB5+OKESw+aAFC1s2f2oViLubqtRC9zWMrU3EdpT/T
	 jaLGiTjISGh9O45YdoV7Qi53h+nMRAm1O4bM+kObm6cma1jksVkiZQT1tL/DLcpRv6VEX
	 4x0jM2M9fThuwYUtZQlog1kuJMG0WE521qN+t7eIwrp9vaGO1xyzD6NdHZYc9GnIjSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206812;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=OGZNQpKI2A8LcMcd/MmHbTTOSLlmhVgRy9eyEEKBTEM=;
	b=ixW/W0EuROydndTDqWAsez7an9Ky8zfb9HSD2tb7FeorbGU+FsJSPZF+sGevlX1T9Hzs
	 OP+GEtiJd2XGuZCm67giwem/pYXAhxJzQnVB1DBLc9B3UpaW/UbK7+uD2HGXwmMZSDpMu
	 A0mWT+tb55OmsGeX5hbLG10Y/ObiFf7gYjABlWTNRy48P7Je8HkLgt+sCfNNyjZbyOkhu
	 aYuRNPO3zZ9s+8PDGKQ5vP/zvU3+/L7/FFH5TpmAPA8E5JJklYHqV78QByworCt09oCV2
	 S4J7+jHekms35n9Yk04IH87kB+t9iA8WSYPSY3Np1pqFXfVb3G1Kwf6hEkGvv/HuvYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=TfcCUjAI;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A05606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 17:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68A05606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=TfcCUjAI
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso506930a12.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206812; x=1793811612;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OGZNQpKI2A8LcMcd/MmHbTTOSLlmhVgRy9eyEEKBTEM=;
        b=vQFPULxA1FU+YHFKz3mv3tbMtotg7ahAlXEPpgX7qUDUQ7JIgZ4LPsyEID9+uQfGqQ
         uCmuZaDWOeEqE/HDXQfGcAV3OQLaGkWwg/44oNaLnm3d7cKgheMaCzvnX5qyLLXzv7f+
         0bPH8nfrsEXKcyHJFIZsmZ/lnp1JRIjX3/7xbsW4iGr4xod6ok8F1Fi3lUCHveSmkPcs
         1C53bu0OUtWUuluXhRBaTH+sc90OFx5c4NS0+NcMkQf4Y1zM0VdtjvklabYOfV33TaEK
         WbCGWkl5vcDExfsiem6jheSaLnCMt/ibv2XwZuqldJzA0SJ8bquFkYmGM9TwNR/cThPT
         yAaQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYOnicAEicm8O6sfqv3VGSCKKAxCkvq0KBfEtCXYCdwLINsbTSzIP7XgK/jrDWPaosvfX8pQ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYILN5eM8vfcuESQsM7YBWh4x0MQXpKWGFPNnOabS6VBG5465Is6
	HIKiQleH6mAyI9C7KE2lQ1m5HAfIu/TCXOHiHW1CtdhZHLw1ATSzbwL18vC5rOpKOGC8bv26ELi
	HHFElZjcVu/zt91Yb2qrdlBJkTAHAelZZClreV8yXM9ablILwkwYnpAoN44rJz8tWUN3NfC+2WV
	M45Lb5j8mMstPyXJMwjOHuTlw+fH0R6kvmIxP6U0ZomJVH0eddsl4JEXJctT6fdjINTIRt3ynko
	e9drUO2GV+OZ+Db
X-Gm-Gg: AYBFou3b6EBdT4ayi99AOrcsbcAt2CqJsP0LadaVyW9oCOt3V/aKvpgTjyqK3UET1gG
	K5fvZxPBAtl5JsHJmfwpcC+gyHbE+HMsY8hL0G+zIDs4eSwa2A5vlvFOMFttSBgV7vHALwHnrJH
	sYX3beah0LnuC0gM7UiOYvH2pKRTgptn+H8iE9gSERThdW+NObXbgiN50XYPGOcSoqwERndUFnw
	v3i0Mg/LEktsxhBL8MD06jCqw60zFQ/j+R8m6L9RxPudbfiW/t8nhWLozB35+d5hfbHmUKkBg5m
	nB5zGC+roWrZeI/lWe5ZcvT8MJBhFACPBQK1nLKDjxduSp5mrc1jnZqswbsVXtKbLl0Z3V11jPh
	3bRgKYNxK/72R5jdlsrQIz73NmSLFp62oxI1Nt6p4gr1wv9G+0vli91gPyk9DeKykl6htrTta5d
	ebuCLsc4u6/1nZJVS9M0fzZpw8vQgZRiZLsPSw+Dxd
X-Received: by 2002:a17:90b:5252:b0:3a0:516d:9f87 with SMTP id 98e67ed59e1d1-3ae580a9d39mr2126992a91.13.1793206811518;
        Wed, 28 Oct 2026 10:00:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae55de790asm1071502a91.2.2026.10.28.10.00.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:00:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f13c143c8so218435885a.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793206810; x=1793811610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OGZNQpKI2A8LcMcd/MmHbTTOSLlmhVgRy9eyEEKBTEM=;
        b=TfcCUjAIR/5bnnVkepai46f5D2WVmdYsheavuu6HunEHL5giAty/DbADrIYKnG8H6L
         5Xojlavkxl5T9/h8Qe0C1m5FBNLbG4gxP81N64hJlfV5OXo4OIZlaSzsJOonACzJWRq5
         QwY0iFPzYudgJIlU5xkl5ec3qmfhCR0WcIHhg=
X-Forwarded-Encrypted: i=1; AKwUvBxcCGRyfJg19F/sfLng+JNRc468KLkWCuOxlMRXJEvcNpwg89fk5Mrdn8XffAdnQn/coWnFtnQ=@vger.kernel.org
X-Received: by 2002:a05:620a:319a:b0:93f:22af:cce7 with SMTP id af79cd13be357-9440896dc3emr425257285a.12.1793206809874;
        Wed, 28 Oct 2026 10:00:09 -0700 (PDT)
X-Received: by 2002:a05:620a:319a:b0:93f:22af:cce7 with SMTP id af79cd13be357-9440896dc3emr425249085a.12.1793206809376;
        Wed, 28 Oct 2026 10:00:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f066a5bcsm1307476485a.13.2026.10.28.10.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:00:08 -0700 (PDT)
Message-ID: <725c51ed-6e7f-44cf-b5e1-73fc39623fc3@broadcom.com>
Date: Wed, 28 Oct 2026 10:00:05 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bgmac: fix oversized RX frame check
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@openwrt.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20261028011035.49201-1-rosenp@gmail.com>
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
In-Reply-To: <20261028011035.49201-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/27/26 18:10, Rosen Penev wrote:
> While reviewing commit 77dac783f11
> ("net: bgmac: rate limit RX error messages") , Florian spotted that the RX
> length sanity check compares the length reported in the RX header against
> BGMAC_RX_ALLOC_SIZE. That is the size of the whole fragment, including the
> space reserved for struct skb_shared_info. The data area handed to the
> hardware is only BGMAC_RX_BUF_SIZE bytes, and the frame starts
> BGMAC_RX_FRAME_OFFSET bytes into it, so a valid frame is at most
> BGMAC_RX_MAX_FRAME_SIZE bytes long.
> 
> A corrupted length between those two limits passes the check, and the
> following skb_put() runs past the skb tailroom and calls
> skb_over_panic() instead of dropping the frame.
> 
> Compare against BGMAC_RX_MAX_FRAME_SIZE instead.
> 
> Only compile tested. Not tested on hardware.
> 
> Fixes: 6a6c708469c9 ("bgmac: add check for oversized packets")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
