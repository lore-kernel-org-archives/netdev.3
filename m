Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307137;
	b=KqMUFeVdWii5oyNDXjzMcPfJelp7vxJQzADRg+YAFTN0zHQYBzMXbpsqBMCcyu3smAtQ
	 q0VDaNw5yMz1/Gwq9CjP0c8HBjZwRyBU949f7vAkwMFtpcXbQhZo4NDW8LF9tFDsk4Dwt
	 jC2D+yO3Mml34XDnWYsAEPlVKmpCZJ7eA2df3037wqv0qerrLWaT6CmbzWPgTFwCVH9NC
	 Ln7os8hLOB/srLtR2occEA0HwqIimLI5l3kdqkbAjpTpkFH+hYvfyH3o9xOvmlbGrpyR9
	 rZ6nxsOrHtXmc85wP0XFPdNfeDfs4d34k7+dyeovO98joMlV1ZJxWUIB+AqWkbG1wmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307137;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=Ih8ipGpv0Zfp8OZAhIyZManL9BimEuOvsRc4m4YJ7Io=;
	b=yfhnLPZtmR4xd6ZjGPHAOctCc+vkLxyyYV7oqA3UYTdxx4lTT4c3xdwq4uNmjZF3phFY
	 TS3dfkyD9smWsrlJfBR/jqkcpA8DZYBbdahZ15d16M2aSbW+iejmeZGoKBVs9mFeReMCy
	 Pn6rco/aVQfNTc0cv1lgfPl3k00FtMxP1xT0Nevw2NSawGN+F+KfaxcXgVUIAQPJhGUpa
	 /KkbbnFQcQT+hnyB+K/+zdHcuLI93nvYN3acVtvC8HNBlKaQc21824R+nYJRrBgeuUlhv
	 jFas/fIo8+HsLjj+7TlEX7exxJnV7zG08LGeB9RczJEIIyyy5u8kUj/EdMHIYDZny6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=afptfJsB;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416ED606A339
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 20:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 416ED606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=afptfJsB
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so9096a91.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793307136; x=1793911936;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ih8ipGpv0Zfp8OZAhIyZManL9BimEuOvsRc4m4YJ7Io=;
        b=pvb5iMmjeTNEfKLXOUH8OmbfXbiftJn/TTxPmyOMMP44TfdpdKydym+K+xWfbDZFtF
         a1nNuUCnXKuBgiCAJTVOuNyRTmv8Fp9/1uYPR37e4uK++iQaHPQ/UE+/wtGsMGFcdSYH
         F1maGt+GVlaRA1ZoEY2hMzbLj/mZtQgijlDrqf7P1m1PEhtCWHnMuukSECirSxp6j/X/
         uVCaw8XG3PCpnM1lk/CL4KAeIgZDKeXEVJ3bGxHvSijEZzG9c4wABYDGCJcslyyfskH4
         Z0+ck9zTExJBiTsvdGbqubjEH8OTTxIRtaZyCwkJ8F1kWJ2y16G1R6/TlTUwRlksM4nt
         bSVg==
X-Gm-Message-State: AFq9FYIjLLF19PojMccFvuL/GjR1BXFukCgyiJ9tWSMuSvk9IgITjUnt
	5bcW6b19Iydy7XptW0sp57HmcXQ9+Qcj47ethOHVmbyT1ZoNULYVY9aVdmA1R0H3C2QrwRa414j
	28iB5js77hzptPVjv/DtKKbIdWohjptuRSy/kQfBsrcXNKLNZCBM/nTQSTx32MQQBPAN1PjXMsA
	U5tN9QEHJFafkiDKKSnXiP8IyJnmJfZh1kJAwN+eNn9trDBcUb3J62RLl3ITNhTnibdkgV8dbJ8
	9M1Ngpxosx88+RQfBA=
X-Gm-Gg: AYBFou3ks+1ZwTyRC0APsam38VJGajSmrs39gQ+75t/IxWnnlM3JuRRZsNNoaNg66ZM
	KWaOtTDdF+DivsWMphTRtCpeiBv/Si1DB6l/n1TTPW0HXXpDiT1VuDgu+aWZAzOduRCrUw/zLct
	AHaS++3yxaAqSHoiGgoQf4grMZSxQROru1hiaYvsODZw464IKHTbbIwWrbuXp0/aZ58O3yDjca5
	n/nkDF/aytO74K8OaTLxIqTQKzcYB4Sck9nIa850TGxUlMeN6upF6LXQh5ohzcA3zvIfbeAfrVl
	DBrCIxvKSepDrGW3ZoiFQm0dSN/buC7ddFiaZfgJWXQ4x7MS/04x+3fpjoHJ8J3YE0Kxcj3wJOG
	WopPSKFT5c6YflHjLFJXIZJnlJBp/ri1yGmv53qqa6Pv76x8E+3o402er8Sar8fS2FTaRV9NbCY
	sPXj+uA+vUs1s0u0B5g/X6NBTdRW/fEqmwuVeikVPs
X-Received: by 2002:a17:90b:5623:b0:3ab:5758:3766 with SMTP id 98e67ed59e1d1-3ae897c3937mr133961a91.51.1793307136315;
        Thu, 29 Oct 2026 13:52:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae845f21dasm578991a91.8.2026.10.29.13.52.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 13:52:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53664911d46so66927001cf.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793307135; x=1793911935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ih8ipGpv0Zfp8OZAhIyZManL9BimEuOvsRc4m4YJ7Io=;
        b=afptfJsBa/ZPDBRwsPekJCZxEiwI1szjaTsOkQYJJaj/+8n6M19Ox79K0wWZ7CjwjA
         /33+5kxNZpEQpIe8H1KjZNNo+W2UN6NVQYOl+DuNowik/fD8CgnICwBEX0LtDmkPXR17
         7qThfEmbzY4m5oYqJwA1GdOQie+/nX/xCD/qs=
X-Received: by 2002:a05:622a:248b:b0:535:2447:3d02 with SMTP id d75a77b69052e-542b6d60babmr4009061cf.33.1793307134982;
        Thu, 29 Oct 2026 13:52:14 -0700 (PDT)
X-Received: by 2002:a05:622a:248b:b0:535:2447:3d02 with SMTP id d75a77b69052e-542b6d60babmr4008731cf.33.1793307134282;
        Thu, 29 Oct 2026 13:52:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-542a55c8d43sm3505551cf.25.2026.10.29.13.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 13:52:13 -0700 (PDT)
Message-ID: <2f2c4dbd-39fe-4116-a575-e4744cb73645@broadcom.com>
Date: Thu, 29 Oct 2026 13:52:11 -0700
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
Subject: Re: [PATCH net v3 2/2] net: dsa: b53: restore the NSP IMP port 2 Gbps
 mode
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, jon.mason@broadcom.com,
 arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20261026203742.3198673-3-florian.fainelli@broadcom.com>
 <179330639281.3134.16708275740775166450@kernel.org>
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
In-Reply-To: <179330639281.3134.16708275740775166450@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/29/26 13:39, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The new code in b53_phylink_mac_link_up() sets speed = 2000
>    for any port where dsa_is_cpu_port() is true on BCM5301x.
> - [Medium] The fix covers fewer chips than the regression it reverses.
> - [Low] b53_regs.h documents PORT_OVERRIDE_SPEED_2000M (line 103) and
>    GMII_PO_SPEED_2000M (line 149) as "BCM5301X only, requires setting…
> 
> --
> 
> net: dsa: b53: restore the NSP IMP port 2 Gbps mode
> 
> This commit forces 2 Gbps mode and flow control on fixed-link CPU ports of
> BCM5301x and Northstar Plus (BCM58XX) switches in b53_phylink_mac_link_up().
> It restores the PORT_OVERRIDE_SPEED_2000M bit, which b53_force_port_config()
> clears when the 1 Gbps fixed-link speed is applied. Clearing that bit
> caused queue discards and TCP retransmissions.
> 
>> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
>> index 0880310c9ce3f..743fc04da0a48 100644
>> --- a/drivers/net/dsa/b53/b53_common.c
>> +++ b/drivers/net/dsa/b53/b53_common.c
>> @@ -1663,9 +1663,15 @@ static void b53_phylink_mac_link_up(struct phylink_config *config,
>>   	}
>>   
>>   	if (mode == MLO_AN_FIXED) {
>> -		/* Force flow control on BCM5301x's CPU port */
>> -		if (is5301x(dev) && dsa_is_cpu_port(ds, port))
>> -			tx_pause = rx_pause = true;
>> +		/* Force flow control and 2Gbits/sec on BCM5301x and NSP CPU
>> +		 * ports
>> +		 */
>> +		if ((is5301x(dev) || dev->chip_id == BCM58XX_DEVICE_ID) &&
>> +		    dsa_is_cpu_port(ds, port)) {
> 
> [Severity: Medium]
> Does this actually force 2 Gbps on BCM5301x CPU ports that are not the IMP
> port?
> 
> The condition matches any port where dsa_is_cpu_port() is true. However,
> b53_force_port_config() only handles 2 Gbps correctly when
> port == dev->imp_port, which is 8 on 5301x/58xx. Other ports go through
> the GMII override register:
> 
> b53_force_port_config() {
>      ...
> 	} else {
> 		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
> 		val = GMII_PO_EN;
> 	}
>      ...
> 	if (is5301x(dev) || is58xx(dev))
> 		reg &= ~PORT_OVERRIDE_SPEED_2000M;
> 
> 	switch (speed) {
> 	case 2000:
> 		reg |= PORT_OVERRIDE_SPEED_2000M;
> 		fallthrough;
>      ...
> }
> 
> PORT_OVERRIDE_SPEED_2000M is BIT(6) in the IMP register layout. The GMII
> per-port register has these two bits the other way round:
> 
> #define   GMII_PO_EN			BIT(6) /* Use the register contents */
> #define   GMII_PO_SPEED_2000M		BIT(7) /* BCM5301X only, requires setting 1000M */
> 
> On a non-IMP CPU port, case 2000 just sets GMII_PO_EN again and falls
> through to 1000M. GMII_PO_SPEED_2000M never gets programmed.
> 
> This looks reachable in-tree on bcm53015-meraki-mr26.dts and
> bcm53016-meraki-mr32.dts. On both boards port@5 is the CPU port, with
> ethernet = <&gmac0> from bcm-ns.dtsi and a 1000/full fixed-link, and gmac0
> runs with BGMAC_FEAT_FORCE_SPEED_2500. Most other boards that use port@5
> as a CPU port have no fixed-link, so mac_link_up is never called for
> them.
> 
> The Fixes commit b6a8a5477fe9 cleared BIT(6), not BIT(7), on the GMII
> register, so it never wiped a GMII_PO_SPEED_2000M set by the bootloader
> on port 5. Whether these boards still have a mismatch depends on what the
> bootloader set. Either way, this statement in the commit message is only
> true for the IMP port:
> 
>      Force the 2 Gbps mode and flow control for BCM5301x and NSP CPU ports.
> 
> Should the speed override be limited to port == dev->imp_port, with the
> commit message reworded? Or should b53_force_port_config() use
> GMII_PO_SPEED_2000M for non-IMP ports?
> 
> [Severity: Medium]
> Should BCM583XX_DEVICE_ID be covered here too?
> 
> The clear in b53_force_port_config(), added by b6a8a5477fe9, runs for
> every is58xx() chip:
> 
> 	if (is5301x(dev) || is58xx(dev))
> 		reg &= ~PORT_OVERRIDE_SPEED_2000M;
> 
> is58xx() includes BCM58XX, BCM583XX, BCM7445, BCM7278 and BCM53134. The
> restore added here only covers is5301x() and BCM58XX_DEVICE_ID.
> 
> BCM583XX (Cygnus/BCM11360/Omega, through the brcm,bcm11360-srab,
> brcm,cygnus-srab and brcm,omega-srab compatibles in b53_srab.c) seems to
> have the same topology as NSP:
> 
> - In bcm-cygnus.dtsi, port@8 is the CPU port, with ethernet = <&eth0>
>    and a 1000/full fixed-link.
> - eth0 is a brcm,amac with no phy-handle, so bgmac_probe() in
>    bgmac-platform.c sets BGMAC_FEAT_FORCE_SPEED_2500.
> - bcm911360_entphn.dts enables both &eth0 and &switch.
> 
> If the Cygnus IMP uses the same 2 Gbps mode as NSP, the IMP 2000M bit
> would still be cleared on every fixed-link link-up while the AMAC stays in
> its high-speed mode. Wouldn't that leave the mismatch the commit message
> describes in place on that SoC?
> 
> Could the clear and the restore use the same chip predicate?
> 
>> +			tx_pause = true;
>> +			rx_pause = true;
>> +			speed = 2000;
> 
> [Severity: Low]
> This isn't a bug, but b53_regs.h still says the bit is 5301x only:
> 
> #define   PORT_OVERRIDE_SPEED_2000M	BIT(6) /* BCM5301X only, requires setting 1000M */
> 
> GMII_PO_SPEED_2000M carries the same comment. This change now sets
> PORT_OVERRIDE_SPEED_2000M on BCM58XX IMP ports, and b53_force_port_config()
> already clears it on all is58xx() chips. Should that comment be updated?

The use of 2Gbits/sec on non-IMP port is supported and it requires the 
use of a different offset and bit, which is being fixed by this patch:

http://lore.kernel.org/r/20261028212310.3847553-6-florian.fainelli@broadcom.com

In addition, there will be a treewide change that switches all of the 
configurations to use port 8 which is the only "true" IMP port where 
everything works, there were several discussions on the matter but it 
has not happened yet.
-- 
Florian
