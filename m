Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124436;
	b=AIdbl5D3c3EG4nj563dOWKcQthpj+GcEY9kNmwixuMvZ78x+lU0X9Bz30ZWDUeRMmWlX
	 nxQI+4cpFajX1LBU9uoi22/SpcKIGSsdKHsQecWfIwGPbe+qbKkvOZ/uOjyyawOJQvJe5
	 I+50GTtL2gGr5SGUjMPrehk5xLY1W09OazD86DO5qkSZ+aGUsNnXSL8xrKLL5skmh1qfk
	 qt/c7HCvRjziYtV1MSbXI1A+mfcGoswW1T5y+bXCj92LmfOhrF4NQUM6hS2LF6wepFDfm
	 Goz4tZL11pNw6DqYZh7VEml9i+5D/K94+QYr5qNdL0jAfCRBxLsZHsVCtO9ENQwdzyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124436;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=txKnAOMpecG2Pi48xVkZvqz90pTRH6AnJzRnr4eHRQ4=;
	b=O/4305oy9kc4SeGpW1fR3Ay9s+Y+Y4i7daMUl6s4FReI18UqyEcAhefDLBc/5e9uQ8xp
	 SgWvzpHKvfQci8BP0uxJtHZBwc/MC9HgCEzf5n34iW4OhYTZpcT+npwSkasJZNVf47lxH
	 pa8p4NBPNkZ3L/+n6cZIbO66kz2jyAqa1S9arhgxCzao1z4AmV8g/Oo/ZyZNGv4muhj9y
	 L2/5k1hnOFLp77GzL2XVJIIlanneo1aRUx1Z6ygpfQ+0j81w77Yv7mA5mbADWRqw7VCmF
	 tBvEd5felqX3EYzL+5K6I7CBJtVgmd343+EjB7AFTsOQ1OTtpOqoIFNRzx9J4fU85AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=iOJ93Hof;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A6E606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 18:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22A6E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=iOJ93Hof
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso123017a12.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124435; x=1793729235;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=txKnAOMpecG2Pi48xVkZvqz90pTRH6AnJzRnr4eHRQ4=;
        b=hcSmESLEo3BYtWhhG6HUJjOtojF2VE8HeX7AZHHh388ldq0lpzZwQn/zAeVSHOw4lL
         xFSDuUMxXnc6dzfrXSTLmMtY0HBGIDUgZvIJIAfya1RBVN/jZz7u32y6jrREaAR5XfOh
         VOh4AdsZ8cJ6lq2ER5E9i5q8Q/Ponys3QWfzP47CEGr5hj2zRZ3uHE5xt7cHsnBQJmkS
         16sRcaT3tGzDnpk9rxHuTv0lQ7Uzr+meffxSttgSn91hi9d6QFldPAwzACOlpY5j/3bt
         QNwLZfgWSl2Um2tYMTYNejMhRlAaalG8XBduoHg3RujZpcfypWSZDo101KTUMgeGoL+c
         T6DA==
X-Gm-Message-State: AFq9FYKMkRcL+tc8L9yxToEwu7qPeD85UoFBnV7t04g1lQ3ZESH1bh1T
	++l8zt/3totbnZc7kXqmkovXbObsZ7X/dHoAxT3vu5vlPcAjr2EshHAQyGdRyPDTTemN+ttorMf
	5rHuko7EhnE8ki7VIPXLNI3zxetmOXtWTmmxcmpzkCaa9ayH+jPirj78M1zlEFQDgWHUStXZoz2
	7Mj/V5gBDf0AuOxo41/W8LqYgB/7antDOgoaSzfrxlDmBFV8xoq7hfndeM+Aw5X5oXb5inAJLZ5
	KJzMExoWrvGiUeN
X-Gm-Gg: AYBFou1jsa2eJPfB5IJfPMVeWll6Jh+p2EBCfolFNjSWBuWZPYFoSC8Inm0lkUWe3WE
	rDGJlyZ1Uo5YcU0Y5tlfH699qZSWQbNmfO24wBPx25x0NIGSvCgKiBghLximybCEmF4oeYocSyG
	IH0DCQuJUpQHQo9/K3IDOWW7K2yWYekQJWpM0ZEh1jRR3R7htn2FWvXQgE1GLyUbJAuqWL5nIsd
	aDvhsHFsUpBkfFdgD+M3hrPbTPUxpRkZX4qDLg2p8olgfPh960YTJ2JlcFw8HdqqB65syNknhMB
	/FYUf3t6hAOC0MErea+hzi0kPitoMEvwsY3gULqsoHAyzNx6VB1eSCXSlT6UjyajydgY26EFyKO
	McTyvEkzE4tjLp64Y74yq+qgErWPSXuuol+89gG2rMWIZ6o+LFXJ0O6hDBtv/Q6LSX/dsISRziR
	NuDa08JcRgPuR5ECxrqDfpk9X2Eejv+Ydyxo9XQcbq
X-Received: by 2002:a17:90b:4fc2:b0:3a7:ef4:164b with SMTP id 98e67ed59e1d1-3adea1a76d0mr7387809a91.2.1793124435357;
        Tue, 27 Oct 2026 11:07:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae4063da67sm2666550a91.8.2026.10.27.11.07.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:07:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33713e5e6daso137216eec.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793124434; x=1793729234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=txKnAOMpecG2Pi48xVkZvqz90pTRH6AnJzRnr4eHRQ4=;
        b=iOJ93HofJ3h84wYduRlqNUQEz14JOf0yH7Xl5ctahzeO8aeXf39jGGgK09VpMkGNEc
         XzTlytBRM3AD/5Vatpa6a6N1UOk0OrNvmaydofQAL9xmW7DiXhecYjAb60+GNIUJywZX
         D4VoAUkUEgyNy4F3iVmW0dS0gH0FukCrUEfvo=
X-Received: by 2002:a05:693c:880d:10b0:36a:1cbc:108e with SMTP id 5a478bee46e88-36a203df9e4mr239314eec.31.1793124433474;
        Tue, 27 Oct 2026 11:07:13 -0700 (PDT)
X-Received: by 2002:a05:693c:880d:10b0:36a:1cbc:108e with SMTP id 5a478bee46e88-36a203df9e4mr239261eec.31.1793124432695;
        Tue, 27 Oct 2026 11:07:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ee71f5sm44876022eec.28.2026.10.27.11.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:07:10 -0700 (PDT)
Message-ID: <000c8ac5-3d34-4c11-8b58-4ef9cd9726ab@broadcom.com>
Date: Tue, 27 Oct 2026 11:07:08 -0700
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
Subject: Re: [PATCH net 5/6 RESEND] net: dsa: b53: report link state through
 the PCS
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org
References: <20261022225656.1387306-6-florian.fainelli@broadcom.com>
 <179305844139.3134.6974876926759672110@kernel.org>
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
In-Reply-To: <179305844139.3134.6974876926759672110@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/26/26 16:47, netdev-bot+sashiko@kernel.org wrote:
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
> - [Medium] b53_srab_port_thread()
>    (drivers/net/dsa/b53/b53_srab.c:371-380) now calls…
> - [Low] In b53_serdes_link_change()
>    (drivers/net/dsa/b53/b53_serdes.c:317-330), if the…
> 
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but
>    b53_srab_request_grant() (drivers/net/dsa/b53/b53_srab.c:91-112) has a…
> 
> --
> 
> net: dsa: b53: report link state through the PCS
> 
> This commit changes b53_serdes_get_state() to decode the Clause 22 BMSR
> and LPA registers with phylink_mii_c22_pcs_decode_state(). The SRAB
> port interrupt now notifies phylink through phylink_pcs_change(), using
> the SerDes digital status LINK_STATUS bit instead of the MAC link status.
> The patch also removes b53_port_event() and turns on PCS polling.
> 
>> diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
>> index fc20e211e67e1..c7f3e131f2def 100644
>> --- a/drivers/net/dsa/b53/b53_serdes.c
>> +++ b/drivers/net/dsa/b53/b53_serdes.c
>> @@ -291,50 +291,44 @@ static void b53_serdes_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
>>   static void b53_serdes_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
>>   				 struct phylink_link_state *state)
>>   {
> 
> [ ... ]
> 
>>   	bmsr = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_BMSR),
>>   			       SERDES_MII_BLK);
>> -	if (bmsr < 0) {
>> -		state->link = false;
>> -		b53_serdes_error(dev, lane, bmsr);
>> -		return;
>> -	}
>> +	if (bmsr < 0)
>> +		goto error;
> 
> [Severity: Medium]
> This is a pre-existing issue and was not introduced by this patch.
> The SRAB accessors behind b53_serdes_read() have a mismatched timeout
> check in b53_srab_request_grant() in drivers/net/dsa/b53/b53_srab.c:
> 
> 	for (i = 0; i < 20; i++) {
> 		ctrls = readl(regs + B53_SRAB_CTRLS);
> 		if (ctrls & B53_SRAB_CTRLS_RCAGNT)
> 			break;
> 		usleep_range(10, 100);
> 	}
> 	if (WARN_ON(i == 5))
> 		return -EIO;
> 
> If the grant never arrives, the loop exits with i == 20 and the function
> returns 0. The register access then goes ahead without the RCA grant.
> 
> If the grant arrives on the sixth poll (i == 5), the function warns and
> returns -EIO for an access that should have succeeded.
> b53_serdes_get_state() then reports that error as link down.
> 
> Should this check be i == 20?
> 
> [ ... ]
> 
>> +void b53_serdes_link_change(struct b53_device *dev, int port)
>> +{
>> +	u8 lane = b53_serdes_map_lane(dev, port);
>> +	int dig;
>>   
> 
> [ ... ]
> 
>> +	if (lane >= B53_N_PCS || !dev->pcs[lane].dev)
>> +		return;
>> +
>> +	/* Use the live PCS status, not latched BMSR or MAC override status. */
>> +	dig = b53_serdes_read(dev, lane, B53_SERDES_DIGITAL_STATUS,
>> +			      SERDES_DIGITAL_BLK);
>> +	b53_serdes_error(dev, lane, dig);
>> +	phylink_pcs_change(&dev->pcs[lane].pcs, dig >= 0 && (dig & LINK_STATUS));
> 
> [Severity: Medium]
> Can this force a fixed-link SerDes port down?
> 
> b53_srab_port_thread() calls b53_serdes_link_change() for every port
> whose mux mode is SGMII. Nothing on this path checks the phylink AN
> mode. b53_serdes_phylink_mac_select_pcs() returns the PCS for SGMII and
> 1000BASE-X in every mode, so pcs->phylink is also set for fixed-link
> ports.
> 
> When the SerDes has no sync, for example because the peer is not up
> yet, this is the call chain:
> 
> b53_srab_port_thread()
>    b53_serdes_link_change()
>      phylink_pcs_change(pcs, false)
>        phylink_link_changed()
>          pl->link_failed = true;
> 
> phylink_resolve() checks link_failed before the fixed-link branch:
> 
> 	} else if (pl->link_failed) {
> 		link_state = pl->link_config;
> 		link_state.link = false;
> 		retrigger = true;
> 	} else if (pl->act_link_an_mode == MLO_AN_FIXED) {
> 
> As a result, b53_phylink_mac_link_down() calls
> b53_force_link(dev, port, false). The retriggered resolve then takes
> the MLO_AN_FIXED path, and b53_phylink_mac_link_up() calls
> b53_force_link(dev, port, true).
> 
> Before this patch, b53_port_event() read B53_LINK_STAT. That register
> follows the forced override, so a fixed link always reported up=true
> and this interrupt never took it down.
> 
> The commit message says MAC link status "can be overridden by
> mac_link_up/down()". Does the link_state_pN interrupt also fire when
> those override bits change? If so, each forced toggle would raise
> another interrupt that reports SerDes down again. The forced MAC link
> and the carrier would then keep flapping until the SerDes gets sync. I
> can't confirm that hardware behaviour from the code.
> 
> Would it make sense to call phylink_pcs_change() only when the PCS
> provides the link state (in-band), or to keep the previous MAC-status
> notification for the other modes? The commit message also doesn't
> mention this change in fixed-link behaviour.
> 
> [Severity: Low]
> What happens here when the B53_SERDES_DIGITAL_STATUS read fails?
> 
> b53_serdes_read() can return a negative errno, for example -EIO from
> b53_srab_request_grant() or a b53_srab_op() timeout. In that case the
> expression evaluates to false and phylink_pcs_change(pcs, false) is
> called. phylink_link_changed() then sets pl->link_failed. As a result,
> phylink_resolve() forces a link down/up cycle while the real link state
> is unknown.
> 
> The phylink_pcs_change() kernel-doc says:
> 
>    If in doubt about the link state at interrupt time, then pass true if
>    pcs_get_state() returns the latched link-down state, otherwise pass
>    false.
> 
> b53_serdes_get_state() now reads MII_BMSR, which latches link-down.
> Should the error case pass true, so that a transient access failure in
> the IRQ thread doesn't cause a link flap?

Agreed on both findings. The next revision restricts PCS notifications 
to in-band links. On an IRQ status-read failure, it requests resolution 
without forcing link down, since pcs_get_state() reads the latched BMSR.

The pre-existing SRAB grant timeout check is also corrected in a 
separate patch.

pw-bot: cr
-- 
Florian
