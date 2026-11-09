Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267399;
	b=OhDqlXPwQJsuri7Ef3hZeZjKN1tfic18ZUrOfuhHtAG8Ug1O7hu6VuJRAeNFOOVDsj3e
	 ZPvP+NqbK0SYvL6VHaLoG9/iqElpg24ND+w3B2rx1PNmRfCrrgckM9WKjrpy9NrLfW3Te
	 WuyhiMNlB/duvvVg36IC0NpiZbTJJLS2TSZ0whD5TVHRShQr8MgN1q76QI2hBUKKPnciq
	 +TZOpnbemzQF2qYlODi1tAqMMQI9irNuTyqo0aqqFt+mH+l6/1tvTXQj/E0SNf2Ljt0oQ
	 9jUSRMyHOf42pa0/p50aIpvvUQB9cJYuLUdQrlxYTBegxZEKzGvQoi7J6wGDc9UnLTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267399;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=R38lvJI/yIC3pF1WXOBB7vce5zcVMZ9tMA2+KmpBkac=;
	b=BMGxUusjjTpiff3BI54r7agNo8Xzrp69X/OAhuj8a6WZC7jUPS8CmrMSh+iHyVZjOqz8
	 K3ZYRFe90YxZaPNbjfhHwdx6Fx/UYNiaN2dgI3fdmbCInRjym9k6AM0Uv0fUCYXzAx/pf
	 DtWouEl5OfBhjvuR9QFNESaCYnp+bEuW2CSb2qLbwU2KEJCT2UW0pO3OJLyvBBFxiydZb
	 Q/Xs6BYZ5dqGadDF+UAMfVS38uSW2orEX/W4xFMScNBrygJLO1aTb6mpVwVrByWAMpxz8
	 vJe8o7XXpcrzce3T/A2baXn+w/nduoc7+ZFPlrKua758oDnA52RdYFAmB+Kvri1+fPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="Q/nkK1TT";
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39803606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39803606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Q/nkK1TT
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so637699a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267398; x=1794872198;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=R38lvJI/yIC3pF1WXOBB7vce5zcVMZ9tMA2+KmpBkac=;
        b=QSgD2XyDqF1srUGY7qbdfWj+3pVA85vCYEdcNYTgx78Sorut4/11bywcCSl6fpTO+S
         deT1bvbAVgg4HtHZtTQaak5bCHTwa8VZQKHcb88H/Bq4ptUSwk/7tbt8Nk+urGaLoPtO
         VczK3BUKtWbxqpNU9yWjKbbdYLT/TPZeSDV7JAavwjFSEqs/E/oFfqWMXWTVa3kpoWQ9
         ZjRAYeAFigisUfeIqLEsEaM+/78I8Fh5D/flathTgBzwvlT1e4mcK2bC/Au/X60acYi0
         W7EwA1JXvK5hy936yzH6JGMuQ1vOlgIe3v3/KXGBpC0erCxMVXwZazRgh+37GlJOj2n9
         jEiw==
X-Forwarded-Encrypted: i=1; AL+hErHo83sAl4WIZUmZ2ib7ioqVmzA78stYjgk/feNyGzcZvToAQaBt3vrPU6IpaePy68xcP3ZeUVA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GPED4xJQZ2wPUHGwMzYxxiiTN+zYE6glRqbyjIAjtJUmaHSbm
	vJZ2zo2pPIUMh5+J3tLwVTd2Lj8ZdwF8SUMLFLEQGhBZhkiuZSHh4prLiwmMewJzH9/BBoHkxoe
	nyIV4VS/43LLkqhF4ElQ9XKXfvjrQLVjMtn1WOqb36951rE2k5H4Q/k3gSv0ute/8Mal2HyCyhm
	eTzaKYefOvfi+z4PXPvjEsNNkLkrGlj73gv+vyEu03zgMp27ybj7AlDebqTLNNQf52MSYB4ptv4
	9FSPPBNcrCPffdT
X-Gm-Gg: AYBFou2GbuB5bQEauF2taihcsUMVhMGEle3NPVLld63wgG+I+5bwOUaEdLPHy2CBbBW
	X9TIdYC7PFyqFns2IWjVFGgIngEJmNxlTrW+y6Ew88vna5BfuW8ozjGtuyvvtkXBk3HXtF1/v92
	LZeTEeaDhFGBzlTPe6S6UA7Ck6hxm9GrSiwiTAUExJ99oJrzktusIKn3VsJ3EBAyF0rw/l8L2GI
	gyBxq2q7jwlOS2RYIskio+epKf20fLFVtpxJJ7VU5HUGTA4hNsQFRm4JdsNKqq5LwgMUh2WTQBY
	TF3F5QbEz+OzW13Kw/RC3j7qxxQS6eLtWhh7y8QNUp5gMS0lcoe82YGuFgBsOgEaemtRHiQwpW6
	sb0TTXMSJjZ/9h0mj1xCe7wfL0/3NOLFkTzq6RDEKWtRAQHwmBm/xCUEamafDMM72qyOHAgiNIS
	WVSEu7+KlWd1nL3UW3/7+l/OcQ6FOw105i6ekzVuIr
X-Received: by 2002:a17:90b:4a83:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3b166aef2dcmr1208766a91.1.1794267398434;
        Mon, 09 Nov 2026 15:36:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b16792604csm605930a91.5.2026.11.09.15.36.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 15:36:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36de26cb4b3so1771330eec.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794267396; x=1794872196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R38lvJI/yIC3pF1WXOBB7vce5zcVMZ9tMA2+KmpBkac=;
        b=Q/nkK1TTDQHHBxyXAwn1ZUcVQmKBziSKj0c6pK5N65XgGT9V+lsnUjvY5w6P35J9gb
         sGBvVMKtRHNBuqIj100E5cx+A8pKH8PesiTCIGAw/w/DgBhvCCGXXK4u3zCKBjt1cn0S
         C6bq0eqlypm5zx42+29Z/ppMdiOhmTMi+aFlU=
X-Forwarded-Encrypted: i=1; AL+hErFSZu/sJKp0icUgPQEXY686ljFxfsJEhMMRwxijOKKVd4fh1gf29iXMhly8Z3IF90NXOSXRcoA=@vger.kernel.org
X-Received: by 2002:a05:7300:e9cf:20b0:36a:1434:c691 with SMTP id 5a478bee46e88-3751f4625a7mr1173426eec.14.1794267395081;
        Mon, 09 Nov 2026 15:36:35 -0800 (PST)
X-Received: by 2002:a05:7300:e9cf:20b0:36a:1434:c691 with SMTP id 5a478bee46e88-3751f4625a7mr1173385eec.14.1794267394139;
        Mon, 09 Nov 2026 15:36:34 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe29fsm1787870eec.21.2026.11.09.15.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 15:36:33 -0800 (PST)
Message-ID: <db90cf8c-191f-4576-8b19-00b1b92c47e2@broadcom.com>
Date: Mon, 9 Nov 2026 15:36:31 -0800
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
Subject: Re: BCM4908 Ethernet and 2.5G WAN: upstreaming plan and two questions
To: "Kordian Chmielewski (mlody1212)" <kudzo51@gmail.com>,
 netdev@vger.kernel.org
Cc: Jonas Gorski <jonas.gorski@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <zajec5@gmail.com>, bcm-kernel-feedback-list@broadcom.com,
 Justin Chen <justin.chen@broadcom.com>,
 "William (Zhenghao) Zhang" <william.zhang@broadcom.com>
References: <20261109231739.2561930-1-kudzo51@gmail.com>
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
In-Reply-To: <20261109231739.2561930-1-kudzo51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

CC Justin, William,

On 11/9/26 15:17, Kordian Chmielewski (mlody1212) wrote:
> Hi all,
> 
> I am porting OpenWrt to the TP-Link Archer AX6000 v1 and AX11000 v1:
> a BCM4908 with two BCM43684 radios, a BCM54991E 2.5G PHY on the WAN
> socket and a BCM53134 switch for LAN 5-8. The port runs on 6.18 with
> OpenWrt main. The AX6000 v1 will be public around 16 November; the
> AX11000 v1 runs the same code and follows later. The first patch went
> to linux-wireless on 9 November (brcmfmac).
> 
> What works today: LAN 1-4 on the SF2 with the CPU port at 2.5G, the
> WAN at 100M, 1G and 2.5G, LAN 5-8, both radios with brcmfmac, USB,
> Bluetooth, the LEDs and the buttons.
> 
> I would like to send the Ethernet side upstream and would like to
> check the plan with you first.
> 
> As fixes for net, with Fixes: tags:
> 
> - bcm4908_enet: the TX ring could stall silently under load (an
>    off-by-one in the ring indices); a DMA mapping error left the ring
>    inconsistent; RX buffers and pending TX frames were not freed on
>    stop; RX frames longer than the buffer were passed up; the RX
>    buffer address has to be written before the OWN bit.

Yes definitively a bug fix.

> - bcm_sf2: with the default egress flow control thresholds of the
>    BCM4908 (32 pages) the switch drops frames under load; raised,
>    WAN to LAN runs at line rate. Is this net or net-next material?

Seems reasonable to be targeted as a fix as well.

> 
> For net-next, with the device trees through the BCMBCA tree:
> 
> - pinctrl-bcm4908: the "mdio" function on GPIO 48/49, the external
>    MDC/MDIO pins;
> - mdio-bcm-unimac: native Clause 45. The MDIO_CFG bit that enables
>    it I found by testing; I would be glad to have it confirmed;

We have an internal patch we should be submitting soon that supports 
Claude 45 in mdio-bcm-unimac

> - bcm_sf2: the crossbar routing of the SerDes (the CFE leaves the
>    Runner's port on the SerDes as well), 2500BASE-X and SPEED_2500 on
>    port 7, and the IMP port at 2.5G;

OK

> - the BCM54991E in bcm84881.c: it has no flash, so the host uploads
>    its firmware; autonegotiation and the link state are the BCM84881
>    driver's;
> - the device trees of both boards.
> 
> Two questions about the WAN, where I would rather ask than guess:
> 
> 1. The SoC SerDes (a control register at 0x800c03c4 and its own MDIO
>     address) feeds the BCM54991E its 50 MHz reference clock and has to
>     follow the copper speed: SGMII at 100M and 1G, 2500BASE-X at 2.5G.
>     Today the PHY driver drives it, which I know is wrong. Where should
>     it live: a phylink_pcs in bcm_sf2, or a driver of its own? The
>     crossbar can also give the SerDes to the SoC's packet engine (the
>     Runner), which this port drives out of tree, so something both
>     could use would help.

0x800c03c4 is SWITCH_REG_SINGLE_SERDES_CNTRL and there are a few other 
adjacent registers that logically belong to the switch driver from an 
address range perspective. It seems to me like phylink_pcs would be 
adequate here.

> 
> 2. The PHY does not answer MDIO until its enable GPIO is high and the
>     SerDes clock runs. The binding allows "ethernet-phy-id3590.5090",
>     "ethernet-phy-ieee802.3-c45" for a PHY that needs such a sequence
>     before its IDs can be read, but fwnode_mdiobus_register_phy() calls
>     get_phy_device() whenever -c45 is there, so it reads the IDs anyway
>     and finds nothing. With the ID alone the device is created as
>     Clause 22, and today the driver switches it to Clause 45 in probe.
>     Would a change that creates the Clause 45 device from the ID in
>     that case be acceptable, or should the GPIO and the clock come up
>     before the bus is scanned, for example as reset-gpios and clocks
>     of the MDIO bus?

IIRC we have other internal PHYs on other Broadcom SoCs which have 
similar constraints and that would fail reading their clause 45 
identification registers, as such, I would welcome a change that aligns 
the phy_device creation between c22 and c45 from Device Tree.

> 
> Whether the BCM54991E firmware can go to linux-firmware, and the
> Wi-Fi side, wait on answers from Broadcom, which I have asked
> separately. The Ethernet code does not depend on them: the PHY driver
> loads its firmware with request_firmware(), and the code taken from
> Broadcom's GPL files keeps their GPL-2.0 notices.
> 
> Thank you,
> Kordian Chmielewski (mlody1212)


-- 
Florian
