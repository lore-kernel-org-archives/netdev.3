Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661940;
	b=evRqqSG4U/D3u9kT9+O6WBdSLOU0croDQcbX+TlQ2DD1AlXOkvvVvS7xauNktq7bagyd
	 zji7UdhRT9/eFsMyVcniwYEs2Jb93wyZXu+o+1pGIMKHmP7JPah7Z+rzR5iN+BO6YjCHQ
	 L8nxUqm/nVRBw9tVvpcMM+YSrEgfVUOmwpqz93XWcLemcEcJzvaOk0LI/XZ4lUL7CD8fd
	 xRBiO0fUahqdV/0eOEMb7YL8Y2mY/KS/xshZqUObJBjD/IqONG0rMxqOJ8aUztNkyZqc9
	 1/05g/2o+JAubShOHjzysZhRRI2hP8YP3A7A75mF2bb57qcKHCcJOzTM2nxRcWSjnQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661940;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=PIvHcKU8RxSTHCJiY3rrjMN++MkUl2ZsU9B218J4VrM=;
	b=QJJK9cYV2GutONynQbEztAs0PD05Pthepjv+p+U2IUhmuQaSVG2BZLSNueNvoWKb7uxu
	 yPSy5MhSbpyWiIgE3CoRJuJNaTIO6H/BQiuSRHVVoxg06ph6rq78BTWFR2LOZDDkqH/zI
	 +4t8l65zOXm7NmS2z6sNTX53tPST6i6LHqNFhDblh8zo17SjxXtR99KzGyEL/Q/HunW9f
	 3x53wO6pQKbYjrsaI1abv/BPxlQPfRfCF21+XS3yJ116wXwZPedzRjAS5D4w/1Iv2tnLL
	 07aWUAIKgluzBazi9t8gl1jnwfm047c1oGxa8cwnG5C7sMPwlPC5g9s8F4UCuYx2hbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IPCOhjnC;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B74606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 23:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81B74606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IPCOhjnC
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ab98332238so1922547a91.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 15:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661939; x=1794266739;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PIvHcKU8RxSTHCJiY3rrjMN++MkUl2ZsU9B218J4VrM=;
        b=vXWARM6NJeeCO/ek3mP452i/qRYtkmo9cQD9BCPNHwuvzT4zrzHd5JJAOGuodST2Sm
         otOUG5Gq/ivundOgMBZA2dgpoaXLCMFZkxGfTqPiTR4Ffn88YRs8MoOCafDklchNQfQ4
         4+kXlDWoKyatBtdCINukW0ELiUGXuEar4XC1UeW9u7RrsmWazRDiTFiqQ8BYMpZNx21Z
         Rqxw5NlGGinSfnunkA3DsdpJlM6J3ok3PJm13XMlhMsYP8vPpQb7jcmmTtWMilxmJZ7X
         J/dFENUKbgTqcQk/L30bBIvD2jW0mDVQFWuwnJ1DOFXBmsW46672oM3ksK6Ta4u/zgk3
         PZcA==
X-Gm-Message-State: APuU4Z+MaedQhLwAJCkLtHA1Jui9cGBzwEK04cYPiZsvpYIcG/1No7oO
	QqJoqRPVmzVcBhSW5vCoDvVGEYUqMcgebEl9mc8vca8T5KNHnvcTCz1V24fSyATbiLVGrVb4giJ
	WACoPAFHl95ZgD9DBrGptuKBt15Ig82F4sNbl1DvxAk/U4iJIMHwUHF1GPIX3xspS3IGkc+LM9U
	Z1qcpJBVFkftsGbzHHS1AnwLiSTAp3c3mkh8hptDx9QxvCaXXb2Zr1TA1a2Nd7UpFV/XyjIvhaV
	eTANXBj2ueEx+M5Yqc=
X-Gm-Gg: AYBFou36qQZybWk7Nao1Hc0GKmgQoZZljAEwtEdboeV0cE3E3xS1nbNaDFECQtvwCaV
	PhZ1C8mMDcdV3zwFATC/22ING+MijzdNc5lE65M4wlmFQfJS0fl0LFfn900XPLZAzFaXXbVLNYM
	VYIjuCR0aGscbr8SV3vuLMi5y0BWirDp1VqRGQ2px85se8kPFezmWK4JAQDYnQ2c2KnhTyNH6Yn
	vGSwnuUOSHKjiyzUlgJhsBfFfunoO/iA9X1BRBwzvxc7oy8XNOTdmIhaILf95oWlRKs0wfzdnuq
	esPLiOehYoat7PmU9btNG5XUqyxINufMT3awrH3IdBv018uRyNnUSwUHqquir8ozbu7XI9gfFpO
	cOvOi9o8Otl8A7KCnFtBOT+nIyMUjwUzvv4Lpp8wUS52SVSKr0H50AJMREfZeZfu4/hi81bxXqN
	zNN4J2LLSf5/xiADt1+T0z9cWw1QyafdnmIH3PbIoy
X-Received: by 2002:a17:90b:3f8b:b0:3ac:c03a:38ad with SMTP id 98e67ed59e1d1-3ae89535e7bmr9861360a91.5.1793661938731;
        Mon, 02 Nov 2026 15:25:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae87fdda54sm2814031a91.3.2026.11.02.15.25.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2026 15:25:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e49a1d3b1so845728285a.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 15:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793661937; x=1794266737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PIvHcKU8RxSTHCJiY3rrjMN++MkUl2ZsU9B218J4VrM=;
        b=IPCOhjnCr9kGzGzCuVsDpAoh8gUEgCqBOZluIA5ZjlLw8xdnTQtUjTC0ehxqBmP8Gl
         YgiHUy9JaXzgcOS0VR4i2psJxgDon5gzWZr5EiKAUthKuF/Y4veEetJv1qWaJk2ZSh+0
         0MBlxelIlcsqxqOYEwKM2r7YPErXxGMMNQYps=
X-Received: by 2002:a05:620a:3707:b0:93f:5445:c661 with SMTP id af79cd13be357-944217b3b9emr1920510585a.57.1793661936943;
        Mon, 02 Nov 2026 15:25:36 -0800 (PST)
X-Received: by 2002:a05:620a:3707:b0:93f:5445:c661 with SMTP id af79cd13be357-944217b3b9emr1920506185a.57.1793661936353;
        Mon, 02 Nov 2026 15:25:36 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca807d8fasm102470636d6.41.2026.11.02.15.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 15:25:35 -0800 (PST)
Message-ID: <8f49edbd-9916-4fcf-ac9d-5ccc7ac97f4b@broadcom.com>
Date: Mon, 2 Nov 2026 15:25:32 -0800
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
Subject: Re: [PATCH net v4 2/2] net: dsa: b53: restore the NSP IMP port 2 Gbps
 mode
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, jon.mason@broadcom.com,
 arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20261029211540.4123250-3-florian.fainelli@broadcom.com>
 <179365621756.3131.9531361745901719210@kernel.org>
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
In-Reply-To: <179365621756.3131.9531361745901719210@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/2/26 13:50, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The new code in b53_phylink_mac_link_up()
>    (drivers/net/dsa/b53/b53_common.c) sets speed = 2000 on every…
> 
> --
> 
> net: dsa: b53: restore the NSP IMP port 2 Gbps mode
> 
> On BCM5301x and NSP, fixed-link CPU ports now get forced flow control and a
> 2 Gbps speed in b53_phylink_mac_link_up(). The goal is to restore the
> proprietary 2 Gbps mode on the IMP port. That mode was lost because the
> fixed-link description reports 1 Gbps.
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
>> +			tx_pause = true;
>> +			rx_pause = true;
>> +			speed = 2000;
>> +		}
> 
> [Severity: Medium]
> Does this set up 2 Gbps correctly when the CPU port is not the IMP port?
> 
> The check is dsa_is_cpu_port() rather than port == dev->imp_port, so a
> fixed-link CPU port on port 5 or 7 also gets speed = 2000. Those ports go
> through the GMII override register in b53_force_port_config():
> 
> drivers/net/dsa/b53/b53_common.c:b53_force_port_config() {
>      ...
> 	} else {
> 		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
> 		val = GMII_PO_EN;
> 	}
>      ...
> 	reg &= ~(0x3 << GMII_PO_SPEED_S);
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
> The two registers use different bit layouts in b53_regs.h:
> 
> #define   PORT_OVERRIDE_SPEED_2000M	BIT(6)
> #define   PORT_OVERRIDE_EN		BIT(7)
> ...
> #define   GMII_PO_EN			BIT(6)
> #define   GMII_PO_SPEED_2000M		BIT(7)
> 
> So on the GMII register, the 2000 case sets and clears BIT(6), which is
> GMII_PO_EN. GMII_PO_SPEED_2000M (BIT(7)) is never written. The port ends up
> at 1 Gbps, and its 2 Gbps bit keeps whatever value it already had.
> 
> Some upstream 5301x device trees use port 5 as a fixed-link CPU port, for
> example bcm53015-meraki-mr26.dts and bcm53016-meraki-mr32.dts. bgmac-bcma
> sets BGMAC_FEAT_FORCE_SPEED_2500 for these GMACs, so the speed mismatch the
> commit message describes would remain on those links.
> 
> The new comment and the commit message both say 2 Gbps is forced on
> "BCM5301x and NSP CPU ports". Should this either be limited to
> port == dev->imp_port, with the comment updated to match, or should
> b53_force_port_config() use GMII_PO_SPEED_2000M for the GMII override
> register?

Not necessarily, while it is preferable to use the IMP port, 
functionally it still makes sense to be able to prime the non-IMP CPU 
ports to 2Gbits/sec should we desire so.

There is a separate patch set to address the 2Gbits/sec override.
-- 
Florian
