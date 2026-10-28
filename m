Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145820;
	b=IKIfp2x/S9t5GERimGBghQNFkhK91HqyByIs6GQXLtI9wE9xMbgkN8o0iClRFsJSHiE/
	 pUzxMyEs0Q9vjjeyaH+Bsgf6q8B5sLhgozGvfzRS5DyX0zkT9JcmUT8wzq3Hh09/w+ywj
	 GLPORc7bVr9KlRLhQPsgYOXUAqlPtyRcZHBn1EWB0GGCBkrb/O5pN15GXsiBci6aXfKF1
	 c5EE0KH5WTYyTEK0NtNY2gdlGFYk6Zjk2vkL/pLFwyoWXX0I9rAjMU8mmp1KQkw1LASvM
	 r75OYKt318idKuH1+FHSo58fwxEKh74JX4n+2Oc8SZ/z8Zho5Z9+qgHjminxsRlfeRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145820;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=Rp7LGkUVrmXCkphyWnFX63KRi+EDmDlHYBY1YDA4Aj0=;
	b=PhZkckGsLbMqPMADEYeqQT63qq4DF1Pcre2NW0HBJYEDF0CE5cSZnrfV2Aj7l2MAl8b5
	 y75pjYBK5ky20eXa07s7tpm3IuwCkC09yGYyJ902deDUx8oZRYhKZptC6nz9NjKwiIXOV
	 QUIPyidkG5UVsQezob8T8ToyeeRpdkw22iozyCgZpQPcapW/f6q08CIJHkQiXQknW3NDM
	 BaqO0exJO2w5tS/4M771Rr2UpGsxK0UQvpdHwOkotWnA2ETzVn07/sMJ8gf18L3TYTuQo
	 lPGnVOCYcWjIRB48UTPb8xYP/5Ctw/t5+5IJ0Yz3DkBwRvqXbOZ9pODGnIn47uNHkhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="MuFrW/mx";
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5A606A320
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 00:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7C5A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MuFrW/mx
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so315197a12.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 17:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793145819; x=1793750619;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Rp7LGkUVrmXCkphyWnFX63KRi+EDmDlHYBY1YDA4Aj0=;
        b=0fYnEpevPFQueuaTiVHEKGRZbtXPtYkT8cYcTEhw+HCDkn1YwHH91CvPpdDAUmqbz+
         jLczzidFRUS2ccckh+sqKeCt8Ex6v1291prhrBHu8wBWtgJPUvewk0kEfnx3e5stFDKc
         uLBOeXjsaom2S7wTr8B+bmMKubqqFT90MguwMXGxWBDW58lGnflNH45jG4S2jJ0spsOQ
         fOw7L0lc3V4lLs9489fdu/L+H9d2ufkyLFgV5s1Q+OBpyIjgjH2TThE7j/RNdOIinh2B
         4+MUuzfc5hHg0N3Tq7MMV/PhmBSVwWGGaHtpjIHmtywDanKMexZq9kKJ93o38vkX6T2A
         MxIQ==
X-Gm-Message-State: AFq9FYLC7YMulReIAOrNnG4C8+ZktPPNOoit2jhVKcXJan6VAdphDEqe
	z//yXAhegYGtd19+blzdF8BZ3rgvu2Q7WnrD++GmqJlFFjray6sZOKfEeZmfVr2kyzEd9suejPc
	blthErX78m3M+NOZBOgU5QXBkdogubzEWibOgoJfR3PC2OonSYHtkJctpbP+YgMaCd8REvnOSlm
	aX+UL3VURrb8cqXtANek71/RqqGGuexxHk9QJ9NEkoTpYAw9qte7NRH7YrbtVStFV0MIT8yj3jR
	2YSG3hGdBHCyHWa
X-Gm-Gg: AYBFou2uURVt6lBX3vyYSobxUhWWLTsdqxYBHck4ssHHhC4tWonYA2cYfRIKA8vNNMU
	Sw6gnvU0BqWoDWKlWU4YAAwA+Gicz6OcqkiP3+CurTOPHpMTB4MR8HJcp3VzwY672gVsdV9CRxL
	jUPHqIU0rLIwVlASVaZ9zEPg/CaUM93Om9QBuCprTS6rd91xYILxqjfUPF4vsvG+VLY9sJ4AuTM
	YqIkMH74gSyxr40GrFe/hQGNQIP8170kDPFjSk4gvCKPRXR6iJUbz0btYI2VMCuCProrCkj/uze
	+KS3A8C2nnmKxPgpP+Fg56inxJQEvXeeyeER5H+asOSE7hi7sgT9pdMXYS9iGGgav7pSYqXcYu1
	0uwcIzht/nMa0JhWduejVsmVSHOmYL+Km9o1Sg1n7nvKXFkUtt/iza+FVfX/dhV7D5/rqiHH9Zf
	+U6X7G1K8nnfI7CmFARIr/64bKIbORESgvcd4Yvujv
X-Received: by 2002:a17:90b:1b0f:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-3ae580a8351mr500206a91.18.1793145819031;
        Tue, 27 Oct 2026 17:03:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae5a5ca7dfsm246337a91.5.2026.10.27.17.03.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 17:03:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-14373747468so374754c88.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 17:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793145816; x=1793750616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rp7LGkUVrmXCkphyWnFX63KRi+EDmDlHYBY1YDA4Aj0=;
        b=MuFrW/mx4OhoKwTeMHEKaDLpPUYiy5REIZcktnxS8NVsVsBnnbbe9o09+IdKadyyDz
         FEieNvAaohMLKVHYbSeq4wahwRO2bK3nSK5+829ujX15OwhdSzLbJfDWLOdINzPtwLBo
         2Vd5RfSWUyqWd1SehGYgg9yHvlcbzz5tsfvBk=
X-Received: by 2002:a05:701b:42c6:20b0:143:54c6:6a5 with SMTP id a92af1059eb24-1a6d00d2a21mr1002797c88.37.1793145815865;
        Tue, 27 Oct 2026 17:03:35 -0700 (PDT)
X-Received: by 2002:a05:701b:42c6:20b0:143:54c6:6a5 with SMTP id a92af1059eb24-1a6d00d2a21mr1002748c88.37.1793145815151;
        Tue, 27 Oct 2026 17:03:35 -0700 (PDT)
Received: from [192.168.2.21] (wsip-184-189-202-35.oc.oc.cox.net. [184.189.202.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75fdc1031sm229439c88.19.2026.10.27.17.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 17:03:34 -0700 (PDT)
Message-ID: <2c6f6e8f-2e82-44f7-a789-599e6b0ba189@broadcom.com>
Date: Tue, 27 Oct 2026 17:03:32 -0700
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
Subject: Re: [PATCH] net: dsa: b53: Enable IGMP and MLD control packet CPU
 copies
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, vivien.didelot@gmail.com,
 linux-kernel@vger.kernel.org
References: <20261026172453.3152951-1-florian.fainelli@broadcom.com>
 <179314132517.3134.14168811742216365656@kernel.org>
Content-Language: en-US
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
In-Reply-To: <179314132517.3134.14168811742216365656@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/27/2026 3:48 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The new IGMP/MLD CPU-copy setup in b53_enable_mcast_snooping()
>    (drivers/net/dsa/b53/b53_common.c) is static and has one caller,…
> 
> --
> 
> net: dsa: b53: Enable IGMP and MLD control packet CPU copies
> 
> This commit enables the IGMP and MLD high-level protocol classifiers in
> B53_HL_PRTC_CTRL, so control packets get copied to the CPU even when a
> multicast ARL entry matches. This lets the bridge keep learning listeners
> after the first MDB entry has been offloaded. BCM5395 uses a 16-bit layout,
> BCM531xx/5301x/58xx use a 32-bit layout, and older chips are left alone.
> 
>> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
>> index 0880310c9ce3f..54844cfadf019 100644
>> --- a/drivers/net/dsa/b53/b53_common.c
>> +++ b/drivers/net/dsa/b53/b53_common.c
>> @@ -836,6 +836,52 @@ void b53_brcm_hdr_setup(struct dsa_switch *ds, int port)
>>   }
>>   EXPORT_SYMBOL(b53_brcm_hdr_setup);
>>   
>> +static int b53_enable_mcast_snooping(struct b53_device *dev)
>> +{
> 
> [ ... ]
> 
>> +	/* Older switches use different IGMP controls, not HL_PRTC_CTRL. */
>> +	if (!is531x5(dev) && !is5301x(dev) && !is58xx(dev))
>> +		return 0;
> 
> [ ... ]
> 
>> @@ -1334,6 +1380,10 @@ static int b53_setup(struct dsa_switch *ds)
>>   			b53_disable_port(ds, port);
>>   	}
>>   
>> +	ret = b53_enable_mcast_snooping(dev);
>> +	if (ret)
>> +		return ret;
>> +
>>   	return b53_setup_devlink_resources(ds);
>>   }
> 
> [Severity: High]
> Does this fix reach the Starfighter 2 switches (BCM7445, BCM7278, BCM4908)?
> 
> b53_enable_mcast_snooping() is static, and its only caller is b53_setup().
> bcm_sf2_sw_probe() sets the chip id and then swaps in its own ops:
> 
> drivers/net/dsa/bcm_sf2.c:bcm_sf2_sw_probe() {
>      ...
> 	pdata->chip_id = priv->type;
>      ...
> 	ds->ops = &bcm_sf2_ops;
>      ...
> }
> 
> bcm_sf2_ops sets .setup to bcm_sf2_sw_setup(), so b53_setup() never runs
> on these chips. bcm_sf2_sw_setup() does not program B53_HL_PRTC_CTRL:
> 
> drivers/net/dsa/bcm_sf2.c:bcm_sf2_sw_setup() {
>      ...
> 	b53_configure_vlan(ds);
> 	bcm_sf2_enable_acb(ds);
> 
> 	return b53_setup_devlink_resources(ds);
> }
> 
> bcm_sf2_ops still has this entry:
> 
> 	.port_mdb_add		= b53_mdb_add,
> 
> So multicast ARL entries still get installed on SF2. After the first
> listener's entry exists, the original problem looks unchanged there: later
> IGMPv2/MLDv1 reports sent to the group MAC follow the ARL entry and never
> reach the bridge.
> 
> The resume path, bcm_sf2_sw_resume() calling ds->ops->setup(), has the same
> gap.
> 
> The is58xx() part of the gate above matches BCM7445_DEVICE_ID and
> BCM7278_DEVICE_ID, but devices with those IDs never reach this function. Is
> that check dead code? The commit message also says this covers the "newer
> integrated RoboSwitch families".
> 
> Should the helper be exported and also called from bcm_sf2_sw_setup()?

Yes, all good points, will address in v2.

pw-bot: cr
-- 
Florian

