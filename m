Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124381;
	b=02wVQCRqNT4qTCVYX/hJ33j0EphoZVvTUWV8dZpOje1jkiYMqJj2fcufKixsMGKAb/A+
	 XzLP45zS++Q4eSn3cckLwo4dAIJY7EGI42Qyb3MVCNmzkmtJK99OMG40SyOomng1yh93w
	 /ouHGRcx77j4q1mvsbcoyNTorUqIoMb5k4mGOjaVD4hZ2RZfDvQv30G+rIuMdLhIQC1kz
	 riR6/299D4Pazlic2Nh9N2ItNPC06CcZbKSvkjNdiq1w+FTdgLwA6nWL28hpBDYW33fR9
	 IbOblFAWKQBwAjRTtJAHA/8tXWYknU5yfj8Ql9Nbey4OvUmAaG0dtHZmw4zAt0iwsyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124381;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=66cNEccWGpyjNnFJrodUk/m7tUZG3QXdwqn4vHPr+zQ=;
	b=NmjV7DjZdcYRh3mM4ByA3WGheUMT2ZKNQVqs/X1RtbCfK/YiwiOzuzCM+P+m6mXTYk0v
	 rctF3BoNIdn3NbzkNcubkHHK6l1wJ6QlEDKXe6iLhFBoJvedi4KP8BjQ3O1fLPlIAwVCn
	 J9R4mIcyRiku4YzfzJJcFfCwcngcKBRJTKCcA/IPXP8TkeydQtdKK6KqMa1G/uXSiNrYQ
	 uWhQbKMsiTmDTiW3cioiWCuESiBgu78KlIKWuerAWi8pBTkouGb1kNwqCVh53q+m+yXjW
	 HGXIgFh6mO+CVh1OowGiJD9azXv/ori/ULADUwZlVmSTxk9gs8NK5s+ibtQZN7oDFjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bXFhRoLq;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31CA606A31E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 18:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F31CA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bXFhRoLq
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so126515a91.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124380; x=1793729180;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=66cNEccWGpyjNnFJrodUk/m7tUZG3QXdwqn4vHPr+zQ=;
        b=Yp1vGEl3W6AcGjhOrhZiPwixlp2A0D6/5bYdXZ939PFzV+esDm0k7XzLtGo6d3TYre
         mhTvOq9y5PsTGaQ6kAkJ6H1Z+6wabMCv/yy9crKftQRRh1NkLqChz//rlbaCFe8T3pM3
         wq5R+Pha78CmZy3NUwyQPg99KZiUsiYLfUejEyW4uLrhQh1cKYczJ4h6JglsaatDF+Ia
         CFlr89LaQPwNzWYjyfjuxvuhFRYaa87k38zQf399fvznh8+7wHUyuaBZ/DAwImu3V2ym
         HhUm9FBB+8b1yZO0A65riFMjjvk6EiIlqVAbnaWMQTb3AU24iw/Grpq+LfffZ4GcuTq/
         3/ig==
X-Gm-Message-State: AFq9FYLjeETemujZ4L3o65fjAgx4n7aqRRPw8nXOUv1Q4aAWlwaffACO
	lhNXXrvSuCLw17z+FuPnSKWSjIkx4oqdoNVgDsJcXcYAylXvAoMaOFy2iC3jBzo3BFboL5I/mjN
	wmebgpzY+d1JKUmSb9jnBmXaSbPil8yyTziotgovdxity6tfG5orsy0GEtGlKdizB0I5USo7zjA
	29S1XjSBRKy0aL7nuvDEltyPtb/pqfcDAnmz7PHY+PVvoofvMrCXBCiuc1j6fTcRDSDg2YGwT/R
	FOrHRNEmtPAi1UdjYs=
X-Gm-Gg: AYBFou3NYEjD2c7oi4uYPUkLT72M1YHbPT6hLlG/FX9qTE9EDwaBntw5Mjz+CiBokOq
	LfZecBq0RjOMAfTacvVKQ41RJ8E/dve7qxgmHdotqIFJN8JyDX0IpXjoDxmu1HDnjYYU3rH/3Y6
	uxLJGKtc2YSq7b4GEu3X0yYsq2lXlDNyTnuEt7ytnjLF/rFUAQvP0u2+lpV8WPKB+4ZQp0cTv9U
	K/gJwyXIWhnmtk16aH9q0aIW6gLRhCTWm7wIXj73DpRTuiuuiPH0G+v916heOr0HADv9+3H7iFR
	Hy2sWSzDb7Ko2HiJON8ihD/35ukkhdnxTIjQELU1yM4lgslC28L1SAAfn4xFs6kq1mm3nENgkrK
	1yPVvUECQy5XbV7L3D6Qg7bOfd/fNiasVIAVWlSHlEXLljZRrlchCOaxZvSiCU30AjT/1EOTUhI
	IG7HZrA2lpt+ubTgiuiWbay/szBnNVPMJ5nzcK2bNs
X-Received: by 2002:a17:90b:2d82:b0:3ab:f38:2b3b with SMTP id 98e67ed59e1d1-3adea899420mr8764386a91.21.1793124380154;
        Tue, 27 Oct 2026 11:06:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae55a6e1b0sm66236a91.2.2026.10.27.11.06.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:06:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36998507c13so179304eec.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793124378; x=1793729178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=66cNEccWGpyjNnFJrodUk/m7tUZG3QXdwqn4vHPr+zQ=;
        b=bXFhRoLqxqgBCp4kEKyKwFDYimyqtCtN8WbfZwHD2exPBhv+s3790zGlccIITab6O0
         X4xIWIpCdkRkPy0WsQf42K3H+ys6sSDaJn1NAxciaI3dy/LLMb9tTzngOM9nrdrfpv7B
         Q/mAz14BU4UuHhab/jf7FuoXFAzaacmf3qL8E=
X-Received: by 2002:a05:693c:401a:b0:366:fbdb:2070 with SMTP id 5a478bee46e88-36a203ffc42mr298454eec.34.1793124378211;
        Tue, 27 Oct 2026 11:06:18 -0700 (PDT)
X-Received: by 2002:a05:693c:401a:b0:366:fbdb:2070 with SMTP id 5a478bee46e88-36a203ffc42mr298388eec.34.1793124377391;
        Tue, 27 Oct 2026 11:06:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d93663sm40527392eec.13.2026.10.27.11.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:06:16 -0700 (PDT)
Message-ID: <fdd3cb6d-681e-43a8-927e-0c33c0be63f0@broadcom.com>
Date: Tue, 27 Oct 2026 11:06:14 -0700
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
Subject: Re: [PATCH net 4/6 RESEND] net: dsa: b53: configure PCS negotiation
 and forced link parameters
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org
References: <20261022225656.1387306-5-florian.fainelli@broadcom.com>
 <179305844003.3134.7429976502843350858@kernel.org>
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
In-Reply-To: <179305844003.3134.7429976502843350858@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/26/26 16:47, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] b53_serdes_config() ignores permit_pause_to_mac.
> 
> --
> 
> net: dsa: b53: configure PCS negotiation and forced link parameters
> 
> This commit makes b53_serdes_config() program the advertisement, the BMCR
> autonegotiation enable, the protocol selection and SGMII MAC mode based on
> phylink's negotiation mode. It adds pcs_inband_caps(). It also adds a
> pcs_link_up() handler that forces speed and duplex when in-band negotiation
> is disabled.
> 
>> diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
>> index d521050d7c8f7..fc20e211e67e1 100644
>> --- a/drivers/net/dsa/b53/b53_serdes.c
>> +++ b/drivers/net/dsa/b53/b53_serdes.c
> 
> [ ... ]
> 
>>   static int b53_serdes_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>>   			     phy_interface_t interface,
>>   			     const unsigned long *advertising,
>>   			     bool permit_pause_to_mac)
>>   {
> 
> [ ... ]
> 
>> +	bmcr = neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED ? BMCR_ANENABLE : 0;
>> +	/* phylink requests Clause 37 restarts separately, but not SGMII. */
>> +	if (bmcr && changed && interface == PHY_INTERFACE_MODE_SGMII)
>> +		bmcr |= BMCR_ANRESTART;
>> +	ret = b53_serdes_modify(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
>> +				SERDES_MII_BLK,
>> +				BMCR_ANENABLE | BMCR_ISOLATE | BMCR_ANRESTART, bmcr);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* The MAC applies phylink's resolved pause policy in mac_link_up(). */
> 
> [Severity: Low]
> Is this comment accurate at this point in the series?
> 
> b53_serdes_config() ignores permit_pause_to_mac and relies on this comment
> to justify that. However, b53_phylink_mac_link_up() in b53_common.c has no
> MLO_AN_INBAND branch. Its MLO_AN_PHY branch only programs pause on 63xx
> RGMII ports:
> 
> drivers/net/dsa/b53/b53_common.c:b53_phylink_mac_link_up() {
>      ...
> 	if (mode == MLO_AN_PHY) {
> 		/* Re-negotiate EEE if it was enabled already */
> 		p->eee_enabled = b53_eee_init(ds, port, phydev);
> 
> 		if (is63xx(dev) && in_range(port, B53_63XX_RGMII0, 4)) {
> 			b53_force_port_config(dev, port, speed, duplex,
> 					      tx_pause, rx_pause);
> 			b53_force_link(dev, port, true);
> 		}
> 
> 		return;
> 	}
>      ...
> }
> 
> As a result, SGMII and 1000BASE-X SerDes ports in in-band or PHY mode never
> get phylink's resolved tx_pause/rx_pause applied to the MAC. This is not a
> change in behavior, since pause was not applied before this patch either.
> 
> A later patch in this series, "net: dsa: b53: apply resolved link settings
> to serial port MACs", adds b53_phylink_mac_needs_override(). That helper
> covers SGMII and 1000BASE-X in every mode and calls b53_force_port_config()
> with tx_pause and rx_pause, which makes the comment correct.
> 
> Could the comment be added in that later patch, or could this commit
> message note that the MAC side is handled later in the series?

Agreed, the comment was premature at this point in the series. It has 
been removed, and the commit message now explicitly notes that the later 
“apply resolved link settings to serial port MACs” patch handles MAC 
pause policy.
-- 
Florian
