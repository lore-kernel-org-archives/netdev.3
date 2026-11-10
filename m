Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269017;
	b=29Qv26bPTnFeerey0R5ryxx0Lm34ELC6uAALTOaAb+wctifbI9GDKpzk27AFrQsTFWU5
	 gOwnsXXHXwp0gAy1EnQq4WnAvWawOCpWpEciSbOwZO3XCWToCAroVZQBYGKOQQi6Oy5v4
	 4H30c+7ohprtPGBW/EErUnVBcVPFbjRlZAFb1KcMfYPnQltMgTCrOwaBGEgfk1ITqdhBw
	 AuoXG4zZW0fSj2gqd1shg5hrdt9jgOobgxBZdJwJVZFO3W4QJZKU0SpsALBP7l/ioi5UP
	 GehuyFVIrbHqIizzLKfi9TmAS4T/jw65ooeRt60lMlso36FuewYJrhZxRHHv1CJJY7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269017;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=tJd3VnZ0yei7ubLx3kXd/82473H1gHXrkj2v6vgi4M4=;
	b=z68CotBzD1ASJHBsAIA5hppSf8ozyG7L67vH3AXU/DzA4LwLP/AwTOBv59PrJrPustEw
	 hsusnhTx4rYIvd4Q/ALPckI/Dtht4+BQKEJE6wLFRelyfI5PTUi3WmMosAEpP3BEttFTA
	 gLo7v2vZcFda5eo56xXsUDkJULPICmoB7i3377HMG0XC1wT8gV4o1+q4bjr8gl3W0LTXP
	 jvOKTWdv0cPOvciTdEDL/1+3y93Z9jsWLMGuObFjCVfZuR23BYYSpCbxjBb0wzecGR0NP
	 GqDV/xwT3QEu7URDA+3VH7cRGgSjZsskau9WEUqCmGV4Wbd77tz6lrwzNjeeqjnNgtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=L7Xe0Dcs;
	arc=none smtp.remote-ip=209.85.222.225
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0A3606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 00:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE0A3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=L7Xe0Dcs
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93f3c89594cso109412985a.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 16:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794269016; x=1794873816;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tJd3VnZ0yei7ubLx3kXd/82473H1gHXrkj2v6vgi4M4=;
        b=a7Kf9jXIWRINdrbHn7puYI6mKOJ0FFyP+o/Ar2tMEm5GQt88EwPc7YE5dQYQxHuUuI
         rp8T6+vUvRMNvskZlSUDGrd3bWroE+JJNVdvYEy5USXIERbgZOBP/690fSboUzENcqkM
         tWZfXb7TcX2XeDIUCo3WaLTNxyWO2Y1hp6wKdPCR2+3oBSgBJkegzaTYUtByVA89jvws
         EXYMDoEinSbxHTHPx1mQMVgJHRpcYYVQEhI+xfXJFub3uWPoTXPM5COoMR0OnMS8nm2m
         Yoe9xmM5FrdTb2lXkTAbKDUNg/Pqfnsio1VBLfIxKYZIMRhcEpYA8/R7KQ5Sn3osEwuK
         WUkQ==
X-Gm-Message-State: APuU4Z8AHW9re8YnGfKCONr61TsPGsakUNqq0wJ7xgl3hcaak9uakQh1
	wN7Fy+tCd9LMwOAWqGP1NAsp/IVJvrDjsS9fTTL6B5PLxU3OGz5AUA6tdDLJ0aGGyH3jo2K/K1u
	V8SVfN8ikjRzofRztkVsKth9SGexnQyP3qTcKyYm88snvNT+DsXxiLN0N3S7M/t08DJzrMO7TB3
	NTQDRyk6n+YfXLcHuvmOMBJqDggh+GCdWVIjVjY0bIibrZLqLeuecp47Wl03+GzEmNfjLMrna06
	xb1cDMzZpTlm8EZ
X-Gm-Gg: AYBFou1k4sjSZc2K4Ci4fjh9PqHRtrIFM+cLVa1x8TlF2XQIAgahKuFr0Us8g0dwu6a
	/DsOctGLO3pa0wUmFBxZ92BaVXBHBKVPjJzAgditZYvq+5LrMo4306wAMDTSHUIKVJYQwfsDQvT
	nROJ9rp8W2RA/72Ue/nbMNThzA+6EL18MwlTN6qEje6XGslgfugIDcPb/fWS5DGJtuq+8ZuntOT
	xZpCOM+4cv9ZAhyB2rHuPiCgVoQ/ALanNfiLvKIVNQ9E52OCS9Vp+0b+EYAKN7HSOt3YGIKDjYT
	+rGlwHlIbO+raZS2m9FQRG/cYbe/SMWEwRsFfAKYYuHv2+pG2UZsMXDiaxyHaKvnbuh2tM69QDO
	0e1C7fcqQMcZTV5zUy/hFkVEVsD9Y+yAtBbic1yqwYSYjDSRf7SiH4EvE0LkDMk+BLsYYi8wyKf
	j0OC8LJhl+t3Qv2tJvhlz3wIoE8Fv3vSmwwUPP86ri
X-Received: by 2002:a05:620a:2b94:b0:944:192:85f1 with SMTP id af79cd13be357-9479f37b795mr178940385a.48.1794269015685;
        Mon, 09 Nov 2026 16:03:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9479ee6d10asm11672985a.3.2026.11.09.16.03.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 16:03:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f5844e383so286140185a.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 16:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794269015; x=1794873815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJd3VnZ0yei7ubLx3kXd/82473H1gHXrkj2v6vgi4M4=;
        b=L7Xe0Dcsg3acKarBmuK9AmWdtOgiFTmwl1Naa061UgoHg8hjKzJ5cb5F7Y/X1rrD/Z
         F5l4ZvRhP0YlyiRuzyLFHMe7cw1Af00wvfd/04PpnmQmW1OP3HW/7Qz8iewWKL5lo98e
         7zk5q1jAvFwMW3Moci085Vj/Upaoa9QQ18DYc=
X-Received: by 2002:a05:620a:28c8:b0:945:fb2e:ef72 with SMTP id af79cd13be357-9479f3105e2mr183579285a.29.1794269014910;
        Mon, 09 Nov 2026 16:03:34 -0800 (PST)
X-Received: by 2002:a05:620a:28c8:b0:945:fb2e:ef72 with SMTP id af79cd13be357-9479f3105e2mr183574985a.29.1794269014474;
        Mon, 09 Nov 2026 16:03:34 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7aa5fdsm93758885a.24.2026.11.09.16.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 16:03:33 -0800 (PST)
Message-ID: <75190f6e-35c2-42ba-b894-d7810a913adb@broadcom.com>
Date: Mon, 9 Nov 2026 16:03:29 -0800
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
Subject: Re: [PATCH net v3 6/8] net: dsa: b53: reference count shared mirror
 source bits
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, vivien.didelot@gmail.com,
 linux-kernel@vger.kernel.org
References: <20261030211617.288562-7-florian.fainelli@broadcom.com>
 <179348376420.3131.8153125267393893230@kernel.org>
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
In-Reply-To: <179348376420.3131.8153125267393893230@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/31/26 14:56, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] This patch adds a per-port software counter of mirror source
>    references (struct b53_port::mirror_count[2]).
> - [Low] At this commit, the first-reference path in b53_mirror_add()
>    (b53_common.c:2573-2582) ignores the return values of b53_read16(loc),…
> 
> --
> 
> net: dsa: b53: reference count shared mirror source bits
> 
> This commit adds a per-port, per-direction reference count for the b53
> mirror source bits. The hardware bit is programmed on the first
> reference and cleared only when the last reference is removed. A
> delete with no matching reference is ignored.
> 
>> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
>> index 75033b28100ec..b16167c9510b8 100644
>> --- a/drivers/net/dsa/b53/b53_common.c
>> +++ b/drivers/net/dsa/b53/b53_common.c
> 
> [ ... ]
> 
>> @@ -2559,6 +2560,11 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
>>   		return -EOPNOTSUPP;
>>   	}
>>   
>> +	if (*mirror_count) {
>> +		(*mirror_count)++;
>> +		return 0;
>> +	}
>> +
> 
> [Severity: Medium]
> Can mirror_count get out of sync with the hardware after a suspend/resume
> on bcm_sf2?
> 
> On resume, the switch is reset and setup runs again:
> 
> drivers/net/dsa/bcm_sf2.c:bcm_sf2_sw_resume() {
>      ...
> 	ret = bcm_sf2_sw_rst(priv);
>      ...
> 	ret = bcm_sf2_cfp_resume(ds);
>      ...
> 	ds->ops->setup(ds);
>      ...
> }
> 
> bcm_sf2_sw_rst() does a watchdog chip reset, or a reset_control
> assert/deassert on BCM7278. That puts B53_MIR_CAP_CTL, B53_IG_MIR_CTL
> and B53_EG_MIR_CTL back to their defaults. Later in the series,
> bcm_sf2_sw_setup() also calls b53_mirror_init(), which writes 0 to all
> three registers.
> 
> The only place dev->ports[] gets cleared is in b53_reset_switch():
> 
> 	memset(priv->ports, 0, sizeof(*priv->ports) * priv->num_ports);
> 
> and only b53_setup() reaches that, not bcm_sf2_sw_setup(). Unlike CFP
> with bcm_sf2_cfp_resume(), nothing replays the mirror configuration.
> DSA also keeps the tc matchall filters installed across resume.
> 
> So after resume, a port can have mirror_count[dir] >= 1 while its source
> bit and MIRROR_EN are both clear. If a new matchall mirror filter is
> added on that port and direction, the destination check passes because
> the registers read back as 0. It then reaches the early return above
> and reports success without programming any register.
> 
> Wouldn't the filter show as offloaded while nothing is mirrored, until
> every filter on that port and direction is removed?
> 
> Before this patch, every add did the full read-modify-write, so adding a
> filter after resume reprogrammed the hardware. The later patches
> "net: dsa: b53: harden mirror register programming" and "net: dsa: b53:
> fix mirror port encoding on BCM5325 and BCM5365" keep this early return.
> 
>>   	if (ingress)
>>   		loc = B53_IG_MIR_CTL;
>>   	else
>> @@ -2573,6 +2579,8 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
>>   	cap_ctl |= MIRROR_EN;
>>   	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, cap_ctl);
>>   
>> +	(*mirror_count)++;
>> +
> 
> [Severity: Low]
> At this commit, b53_mirror_add() ignores the return values of
> b53_read16(loc), b53_write16(loc) and b53_write16(B53_MIR_CAP_CTL), and
> then increments mirror_count anyway.
> 
> If one of those bus accesses fails, the count says the source is
> programmed when it isn't. Every later add on that port and direction
> then takes the if (*mirror_count) shortcut. Will that keep the source
> unprogrammed?
> 
> In b53_mirror_del(), the count is also decremented before the unchecked
> clear.
> 
> The later patch "net: dsa: b53: harden mirror register programming" in
> this series fixes this. It checks every read and write and only
> increments mirror_count after programming succeeds. On the delete side
> it logs failures, since .port_mirror_del returns void. A failed clear
> there leaves a stale bit with a count of 0. That can be recovered,
> because the next add goes from 0 to 1 and reprograms the bit.
> 
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL(b53_mirror_add);
> 
> [ ... ]
> 

Agreed. The reference counts survive SF2 resume while hardware mirror 
state is cleared. I’ll restore the destination and active source masks 
during setup, preserving the counts for filters DSA retains, and 
propagate setup failures from resume.

I’ll also fold in the register-access hardening so counts advance only 
after successful programming.

pw-bot: cr
-- 
Florian
