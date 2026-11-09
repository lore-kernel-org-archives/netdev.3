Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268440;
	b=ZwlgK/6EwfOKvbZmtXGKZd0xjUDJo/Y3q/+3fH1VWZN2H4OfR7ZtazDV3GcuLqcPeWRs
	 13y6AI2CnfPrf/j7F2xlNzVX7pmCTBwuGmLj6f9xHj/S0YUaoWS59JiNk8yY4jS2I4e2w
	 oA9/vxe2fxbSe3kB7WwsrLReCpzKNbxYCyLMoBtlR1mC/xCqwmKr/hlkcNMdmEjj8zfLE
	 8MuzUEEbAsPe0J+DPNFjkyYXJaWPW7QR4myZBB8P6x06FdfMVJtFqJQYcF3Hx1NjpMAzw
	 W2kL/Lz1LkNFkfBexvBt9QxcDN5aG3bsrPO2hdDvjyiwt0y1kwcAzQeQiFwvF3yBi9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268440;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=wDZM26kavt9D8JjAc62c7nTD7qb5atqKeFWtZFgPNxk=;
	b=eFBpJ0tvrXm5humtoNuMJeuSWTDjN4T+m7E3qA/MRHb39agkE2wMhgXeEAjEeTTJ+SVy
	 hD4Y7KQz5ZE4MQRr52gRQ4FSCx05pPFMNqjcwPeio6RijZ9zP6jdl0T2o8RfgZTx2aYKz
	 S0qf1SeOLuWtHtDDhqPh7PpmjiKIYntml+JhY9aDD2FJ+r5Pa7RAEPiM4gjiF2J0K3c1s
	 hnp2nTw1xfJMriRehomoDCcF7lx7+kKvV1OZ+CDvPgQhFVw1/Mh4laepEg8YQ7OlYnK83
	 f/Bk13yNJvygjr3+cP678RvgTW9Sp9J5daKMZJyuWKMDUiYagz9v8OYkeNMg5ZLZhUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=E8DMb2GB;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C09606A333
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06C09606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=E8DMb2GB
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cdb9f760337so721514a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268439; x=1794873239;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wDZM26kavt9D8JjAc62c7nTD7qb5atqKeFWtZFgPNxk=;
        b=I7lHyoRl7bS7K4SnyCvB9GZBZFqNSKLu8ZAO3t6FYf9ujBcyggTRTW5W/cuvS2+VG5
         JSVCByoq7MPHzlN9ZpMo9ZfDEwe3UllEAQAUpcL5rW+o6PgHwhzBNorg8DLiAQSIJoV9
         ZiDnWnnYK5oueRBE7P8OQREhlVC4fsEufaJuKeigaytHK1Ff2wKTpJDPppmSwSUbhQ37
         K6F4YYvbRAtOyI7DHZkWXGoays+bZ3DCCAdbfVxgQKF8fDWuHKMzQGx/pK90h23w1vD5
         HA3kJ8bRXSWTVfPm88JfCDOKumfFmAYTm8IcqMVY++ipO2KU8Nd8OF5IHa8qG98MEXun
         DfYg==
X-Gm-Message-State: APuU4Z+AS01SBctDbtMj/WSOs8XslVAhb5L+iPHdYkTZ9AdOZ5lf3jRi
	IAkaWe8z40TEGjT1nSLeyRgasQcERI5lqMTT/SkdsqXpXXSwoYh/sRc+EJa6oPrTwJedoCaRQQK
	WOBufmChTt5PvgoHiTzC2PYDu4Vxub1IXEmOMUPj3SHoLc8U0g3U5LGRwl1COFqJDX0IqgGwXeV
	oFfoaAFy/jz82vdvq/YBylrkSXTbz55gDCK3FTg7opXqjmw8DSTlCxOkX0LLs77ivFu5qE1R8c/
	eeYTlYJSG2HgxNK
X-Gm-Gg: AYBFou1FmJHly+3USc9sO7bihkQ73asPzmdZVsC+yv4ZPnSm9+ezVfIpY3rS80KvNXY
	f3EdnGZ+ldofHeGIDOtX9p57YKOZ5DT8v/TaWasexcF4iHjE+30CMKKUKYgjGWAlgK71SohfeFi
	Hk85TyVo25lSOqrxztlshv5eXrD+c5S8DEK/6GZuD2/QQw8MXJh/OUr9OetnJLO/A5LZpdbzd4t
	eribAaHbnQLKDUibptAxyzX/2JzZNtdcPuzKaSPK/v1r12i9D8sNqrfYg4s/vshg41yXTZPhTNb
	0ShTNRg4yMYlrQ/gSKUHtX+nGEomzwJoEz9l5CZt5fArk/a8rl0Pw1lvPMasgkVAmQTTeQy9Q4Z
	m+gDfahUOTFDcIwwbAgwamvowJFmqib/kwABW3rsscfSAkdlSRSvbOYvoiyldFrtlvyO7r8stSq
	g6n5wTfmtfEk/10+Gox6UWumlSUuYC3UUk8YIs+tBO
X-Received: by 2002:a17:90a:da8c:b0:3a8:337d:228a with SMTP id 98e67ed59e1d1-3b1678cee19mr674022a91.6.1794268439276;
        Mon, 09 Nov 2026 15:53:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1678cedcesm625331a91.4.2026.11.09.15.53.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 15:53:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91eb3a63064so30868516d6.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794268438; x=1794873238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wDZM26kavt9D8JjAc62c7nTD7qb5atqKeFWtZFgPNxk=;
        b=E8DMb2GBs6zLjvUPZJuj98zPmuCVdn6kCR6DxUZ+hdNhUfQn59Ns2b0C6wlkmFBW51
         nbRs280Grs/3gycRzkjCkbaP4M6Vn+jzx+BEWUWMr9hf87QGg6aHM0nvwN7Mp98EwVQq
         UMqWsonYizxgigJhgF80l+OEH5OOtD5ThYUFI=
X-Received: by 2002:a05:6214:411e:b0:91e:972b:ad99 with SMTP id 6a1803df08f44-91ef027a678mr16002316d6.25.1794268437545;
        Mon, 09 Nov 2026 15:53:57 -0800 (PST)
X-Received: by 2002:a05:6214:411e:b0:91e:972b:ad99 with SMTP id 6a1803df08f44-91ef027a678mr16002066d6.25.1794268437024;
        Mon, 09 Nov 2026 15:53:57 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef010b059sm8239736d6.0.2026.11.09.15.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 15:53:56 -0800 (PST)
Message-ID: <f637bc1e-c7d2-4a12-8271-d8a128ba0e34@broadcom.com>
Date: Mon, 9 Nov 2026 15:53:53 -0800
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
Subject: Re: [PATCH net v3 4/8] net: dsa: b53: reject conflicting mirror
 destinations
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, vivien.didelot@gmail.com,
 linux-kernel@vger.kernel.org
References: <20261030211617.288562-5-florian.fainelli@broadcom.com>
 <179348376172.3131.11440720201294156466@kernel.org>
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
In-Reply-To: <179348376172.3131.11440720201294156466@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/31/26 14:56, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] At this commit, the new conflict check in b53_mirror_add()
>    (drivers/net/dsa/b53/b53_common.c:2553-2557) decides whether rules…
> - [Low] The commit message says the patch propagates a failed capture-
>    control read, but only the B53_MIR_CAP_CTL read in b53_mirror_add()…
> 
> Pre-existing issues:
> - [Medium] Each per-port, per-direction mirror source bit is shared by
>    every tc matchall mirror rule on that port and direction, but it is…
> 
> --
> 
> net: dsa: b53: reject conflicting mirror destinations
> 
> With this patch, b53_mirror_add() reads B53_MIR_CAP_CTL first. While
> MIRROR_EN is set, it rejects a new mirror rule whose destination differs
> from the one already programmed. b53_mirror_del() now clears the whole
> CAP_PORT_MASK field along with MIRROR_EN when the last source is removed.
> 
>> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
>> index c38e8c5838bd8..378f47e7250cd 100644
>> --- a/drivers/net/dsa/b53/b53_common.c
>> +++ b/drivers/net/dsa/b53/b53_common.c
>> @@ -2543,7 +2543,19 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
>>   		   struct netlink_ext_ack *extack)
>>   {
>>   	struct b53_device *dev = ds->priv;
>> -	u16 reg, loc;
>> +	u16 reg, loc, cap_ctl;
>> +	int ret;
>> +
>> +	ret = b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &cap_ctl);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if ((cap_ctl & MIRROR_EN) &&
>> +	    (cap_ctl & CAP_PORT_MASK) != mirror->to_local_port) {
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "Only one mirroring destination is supported");
>> +		return -EOPNOTSUPP;
>> +	}
> 
> [Severity: Medium]
> Can leftover hardware state make this check reject a valid first rule?
> 
> The check only looks at MIRROR_EN and CAP_PORT_MASK as read back from
> B53_MIR_CAP_CTL. It doesn't look at B53_IG_MIR_CTL or B53_EG_MIR_CTL.
> 
> At this commit, nothing in the setup path writes any of these three
> registers. The only writers are b53_mirror_add() and b53_mirror_del().
> Also, b53_switch_reset() doesn't soft-reset every chip.
> 
> Suppose a bootloader, a previous kernel (kexec or warm reboot) or an
> earlier driver bind left MIRROR_EN set with capture port X. The first tc
> mirror rule to any port other than X would then fail with -EOPNOTSUPP and
> "Only one mirroring destination is supported", even though no software
> rule exists. Before this patch, the add path just overwrote the stale
> destination.
> 
> The reverse case also seems possible. Stale source bits with MIRROR_EN
> clear pass this check, so those ports end up mirrored. The same stale bits
> also stop b53_mirror_del() from ever clearing MIRROR_EN.
> 
> The later patch "net: dsa: b53: harden mirror register programming" in
> this series seems to fix this. It adds b53_mirror_init(), which zeroes all
> three registers from b53_setup() and bcm_sf2_sw_setup(). It also bases the
> occupancy test on the source masks:
> 
> 	if (((reg | other_reg) & MIRROR_MASK) &&
> 	    (cap_ctl & cap_mask) != cap_port) {
> 
> Could that be folded into this patch, so this commit doesn't regress on
> its own?
> 
>>   
>>   	if (ingress)
>>   		loc = B53_IG_MIR_CTL;
>> @@ -2554,11 +2566,10 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
>>   	reg |= BIT(port);
>>   	b53_write16(dev, B53_MGMT_PAGE, loc, reg);
>>   
>> -	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
>> -	reg &= ~CAP_PORT_MASK;
>> -	reg |= mirror->to_local_port;
>> -	reg |= MIRROR_EN;
>> -	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
>> +	cap_ctl &= ~CAP_PORT_MASK;
>> +	cap_ctl |= mirror->to_local_port;
>> +	cap_ctl |= MIRROR_EN;
>> +	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, cap_ctl);
>>   
>>   	return 0;
>>   }
> 
> [Severity: Low]
> The commit message says the patch will "propagate a failed
> capture-control read rather than making the decision from uninitialized
> data". Are the other register accesses here still unchecked?
> 
> Just above this hunk, the source mask read is not checked:
> 
> 	b53_read16(dev, B53_MGMT_PAGE, loc, &reg);
> 	reg |= BIT(port);
> 	b53_write16(dev, B53_MGMT_PAGE, loc, reg);
> 
> reg is an uninitialized stack variable. On failure, b53_mdio_read16() and
> b53_spi_read16() return without writing *val. A failed read therefore
> writes garbage back into B53_IG_MIR_CTL or B53_EG_MIR_CTL.
> 
> Both writes are unchecked too, and the function returns 0 either way. DSA
> then keeps a mall entry that the hardware never accepted.
> 
> The source bit is enabled before B53_MIR_CAP_CTL is written. If the
> capture-control write fails, MIRROR_EN can stay clear, and a later rule to
> a different destination would pass the new guard.
> 
> b53_mirror_del() has the same pattern. If its B53_MIR_CAP_CTL read fails,
> reg still holds the other-direction source mask, and that value is written
> into the capture control register:
> 
> 	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
> 	...
> 	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
> 
> The later patch "net: dsa: b53: harden mirror register programming" in
> this series seems to fix all of these. Every read and write is checked,
> B53_MIR_CAP_CTL is programmed before the source bit is enabled, and the
> delete path jumps to an error label instead of writing back garbage.
> 
>> @@ -2595,10 +2606,8 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
>>   
>>   	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
>>   	/* Both no longer have ports, let's disable mirroring */
>> -	if (loc_disable && other_loc_disable) {
>> -		reg &= ~MIRROR_EN;
>> -		reg &= ~mirror->to_local_port;
>> -	}
>> +	if (loc_disable && other_loc_disable)
>> +		reg &= ~(MIRROR_EN | CAP_PORT_MASK);
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but each per-port,
> per-direction source bit is shared by every matchall mirror rule on that
> port and direction, and it is not reference counted.
> 
> dsa_user_add_cls_matchall_mirred() in net/dsa/user.c allows several
> identical rules, and each one is tracked as its own mall entry. Earlier in
> b53_mirror_del(), deleting any one of them clears the shared bit:
> 
> 	reg &= ~BIT(port);
> 
> With this patch, if that was the last bit, MIRROR_EN and CAP_PORT_MASK are
> cleared as well. Does the remaining rule then stop mirroring in hardware
> while it is still installed? And would the new guard in b53_mirror_add()
> then accept a rule to a different destination?
> 
> The later patch "net: dsa: b53: reference count shared mirror source
> bits" in this series seems to fix this. It adds mirror_count[2] to struct
> b53_port, so the hardware is programmed only on the first reference and
> cleared only when the last one goes away:

Agreed. I’ll respin this patch such that deleting an absent entry 
returns success for both lookup-miss cases, while retaining the early 
return without writing hardware. This avoids retaining stale DSA 
host-address references and errors for entries that were never 
offloaded. I’ll update the commit message accordingly.

pw-bot: cr
-- 
Florian
