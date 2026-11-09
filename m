Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268646;
	b=J/oYkfdtKPrL1cin2wXoEu79MNS2wQxp0LxJtTmkVbyNKK0LlCAZUZpyZTUYsRxNTr/H
	 qlV28lo1tvzdsV6EOzdCYrjjPqIzjYyD+jAY/rXAHWkhOU9R/MXMSS8DBVEWMSfytwxjf
	 y+uPu0y44aq1JNOzjhKhxDM05hAFcBvqJmfITBsDtvRlWuYKtOL0r15hXLYb904YbZ3j9
	 3H1M3K/tzhHbKRCVDraWLJl62mRdj6DM+jEp5srkXvsMQxSGfxH4vwD+aFVUMtH66BEq9
	 fohy59DWPUxdgbJ+ZswIMM218p0xKp/rzMIhowKjpi66Fl1u2JFQutg1SS1Gj1GfTag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268646;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=c2l02lH4CkPIKl8yer1fYXore0VFomr5mbN4wJ3bvKc=;
	b=mUtqmI+OHWcs/WiwXEO88le7DG9HlrfrxsboHxoJC0Nts7Ebqi5rHaTv3Qatr9sREPDr
	 cW2IxbZQB0Z/J9Kzy7jaKbnEBnn0/TXdy9qucGwlua0Gl3oywxqloeLq3wbOIc6q8by2d
	 QIKtUPU/lJVOO0lQKYL9R3QlbDEYqorSbo0rUdxZscYltP7ltBaKcVX4C3KJE7fBKOn9+
	 7IsGH0kV7M9NwKpsS6v4udyGToDF5CTwe0Ttr1pRiamC4GfiZQQKesgVzQvw5q3ujcx0B
	 zzbJoU8VdJ3fZ8aAtVEPu3laE901147OyGEnwf8IcRG26HppJQS4dFnFQOQRM1PRrrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="K/ookRI7";
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7096F6071832
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7096F6071832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=K/ookRI7
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so978035a91.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268645; x=1794873445;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=c2l02lH4CkPIKl8yer1fYXore0VFomr5mbN4wJ3bvKc=;
        b=UQLNxaOa9/UTWcuUjW6sHNcGyhc7LljzHKPJTe+bDfvJEHOslea3mkfVrHKRVZScy+
         mdxTXbuPqmWZ7Rd6st4t+Va2MEiSwx+wAYmKdkT3NL4eMTEYdMh9qrcHTZOGJyIxDgxn
         Pqtc1X+NG9zGquqdMC+TKkkBUWeePEPqsB81TzZJDns8HOmtfeR3wfFPjYlT7d7EgnIs
         +RXwit2Vm0Ke16MusfN/+NFYFKdZqfEUL0mTKTrh0Q9F8vhkjTWVkskx3BvXd6AWOKkS
         dy3bbk9ZoVds89GUc3iylSpGskBpk5x4dmBaYv408lzLfErqLEolC4Q72/iirlvcBJog
         7OrA==
X-Gm-Message-State: APuU4Z9n7xEypnp4gsXcEBW0iWQcTFnT6veMwBTGChUJBDA1Klqh7+JC
	P+mEz5wLryVjJXhoc/yMcw5yF2SZ7bM7tESC2sB11f4NhH6fb1MPZk8V68Iuyw3vgqk/3X/JUdC
	O+BXqSYcCpIIZq541K8vfzJoEJeCo1ZUUXZj6SNJGXvEkZAIPT6WWGX5iQhM1tgloYIyPaaiCQP
	WYPa80ZDxak1zEwiNSpKmXfPO1XLOJ0DwbcLOGZM8MEDEyWKH96ctWtjlwANUNz/6ECx1dXpguE
	/5lVfgpPZDk28CY
X-Gm-Gg: AYBFou0ATqzdVQRp7wSjJBVRVU76uMQ57KFd8Do+ugqulSo0ymnNHT0R5xftSHaYfqQ
	NzXjpv/dt4W5V96Pam6UWpwnSm+M/rdLyFvFBEh1g8AVptBFtvnsryjLIvl5ABC5Y0CIN/gLmD3
	ydkKfzGS6ORNVUTEkjaCMaQ4BGQPNKWr+F8lI1/cMAkI6zXEhvxDX05wBEey7exyZfte7OWVL8C
	ypbS1GldRZHdaLhU9K6fworC28bpKzP8qp38EaTbk8Vd0BE46ZHdj0YesgAtF3tjOhmiwd0lr/H
	uBImRirZk7hc7NdVpbmmZLqccNyJBSqDPNEdV2VP0fYhmdyeW+BvxZ9xA2ljE/XkZ4l0sldqkZI
	M9nlyU7NSK1S8mgGgMUPeAObeV6plRzomStZP1ArTFkmYQOjz95sLb7fQVeDSMEI/myx/HbajXu
	SqyRJKTGM4fOkGt6p8mFZZuMf7fKw9aKn+jFa6O0oh
X-Received: by 2002:a17:90b:448f:b0:3b0:af68:77a with SMTP id 98e67ed59e1d1-3b166aeefb9mr1143479a91.6.1794268644564;
        Mon, 09 Nov 2026 15:57:24 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b16700d812sm674599a91.4.2026.11.09.15.57.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 15:57:24 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f1e62510cso299878885a.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794268643; x=1794873443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2l02lH4CkPIKl8yer1fYXore0VFomr5mbN4wJ3bvKc=;
        b=K/ookRI7S4LJQIWYZUBH4covA9zZEZL+Vyxe7CkJEHbCcfnMqrigxh8b5MLRjMCK5r
         N2ZWIto40byAJr0vsNXHwevSBtiahcqeSXmlTrT2pwdUjS2SeI4729iqL5DqsL/PkIs6
         lXyoTlDVIGcvRMp65u0MCoxQAvJ9Y+fvYOKk0=
X-Received: by 2002:a05:620a:8089:b0:947:90cc:f151 with SMTP id af79cd13be357-9479f1c07ffmr155202585a.7.1794268643073;
        Mon, 09 Nov 2026 15:57:23 -0800 (PST)
X-Received: by 2002:a05:620a:8089:b0:947:90cc:f151 with SMTP id af79cd13be357-9479f1c07ffmr155200585a.7.1794268642539;
        Mon, 09 Nov 2026 15:57:22 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e734698sm94360885a.13.2026.11.09.15.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 15:57:20 -0800 (PST)
Message-ID: <c7ed60fe-eddd-43b5-9576-f574b5dd80da@broadcom.com>
Date: Mon, 9 Nov 2026 15:57:18 -0800
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
> 
> 	if (--(*mirror_count))
> 		return;
> 
>>   	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
>>   }
>>   EXPORT_SYMBOL(b53_mirror_del);
> 

Agreed that the conflict check needs to handle stale hardware state in 
the same patch. I’ll fold the mirror initialization and register-access 
hardening into this change, along with the shared-source reference 
counting, so the fix is complete in isolation.

pw-bot: cr
-- 
Florian
