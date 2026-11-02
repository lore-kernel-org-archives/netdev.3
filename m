Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661886;
	b=mCobIXJN2H0B/s3RI6upG4fiF90jhqlSO1HU8A7qujamkusatmNaVw9DnX/NQcFKJqcS
	 D5h1TwLia8tc4QLeqdHE01bJI5QyB6kBjDleLBIjr+jVMK4+b/abliCeWBiNXSY3uJ1Je
	 oaf5jLVxEBAMMy2HI3aSNtAonbLJ9VTHjkAcxq/7gQBlf9vmk2jpRoOg10xrQ3FWLOQWn
	 prOmi5gWJHN+rkr3n+xlj7mxq/WBH+xVXPeIawUE8hB7SRqMOtg3FYmCpnOYNnx8ZNkFp
	 xLb1l3QNzW7pueo9m/i057QpzZnAwuEMgpN1wGQ1cjPKIYcZfLBo2r+TpBE8wNs5bNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661886;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=YF2ZaT39aKwFG2Zu0dT49qqvZ6PYD/WHLec3K73Pqdo=;
	b=mu+b/bUweMJxx4wZsFd1WGgXeYzzc6hDwd59yNh8wsz4/+coeWhMNXdmhLoxIhq/dyAk
	 fF2WuY0MFoEunQ2LgjKI0nPNT29I44pZIYPyCeE9R68ciVeKTuIUXexMPNvwzVC3jMDxx
	 mnY7X0ETJeo4nnn2+JEp92R5QiAR43z8ujWVj4+4/kihPgUdRlOs15qWLDoEgoKBdhOgy
	 a4o6S0AP1RbVyvk25yU3sjxWEbi/4cPGSiLFF/NYXsC+RAHcrQQWzMnltkdKlD1OS6D0A
	 jS+giUYA2RgevONnltKBUcYbf2367IoaK/XGTW2YUNqU/txxghhF/WMt2zKfQAZsnIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GwIhOace;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C1606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 23:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 946C1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GwIhOace
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so2998390a91.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 15:24:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661885; x=1794266685;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YF2ZaT39aKwFG2Zu0dT49qqvZ6PYD/WHLec3K73Pqdo=;
        b=2veAxF5TzhCDG+xihZttBIyNzeGzLc0Hnt6nHLaDqKHX0tooDO+dglbCnuaZL9RGq6
         x+MLpSU/OluU6etbCI7BjwJK+xTU4Esib5C1OoiX9Hni83UG1NzCu3f6vlvGlDINt2N5
         UegMsJOVudGXbqZ2yvLGmJxOGj1bPg8FUuJADZnS9lm+jUy46TQacqTXFJs4Lh+aSk6n
         79bFg9aMZrscav6OmXGrhiZFRwFw90ftzLMg71Po+qXHD3N/oTrqfZWHPcAO0mDBcMcA
         aWqdOZA9qD0zkUr8ptk8zQ8ns3ZidaViDyfq/s70AVqWQ2h/zQYRT4jW6sdXZAZbUKuA
         uMsQ==
X-Gm-Message-State: APuU4Z+XJKcUynDGwririRrt78LBbn+Y3RIozKSVI6gStA1vGfxlC8HM
	8hdp4OWWqsz0v6oqkOFOYyjyUJhucLWii8oWt6+gfHIZnW5J/oMAEdw30PmgNRQfm16V02oCeok
	rFNJ8BHlXek2SBHLpgKKql19rR1ibcWvtVnHJMTLNmCQGTn7o7yjwdx+jBbYhlCwIZqDx/bWa6y
	4zbWgu9nJAWtmzdHp9f/5CtXMGIdrKuaLoOBbORbzPhR3PQ3QAk3yJni4LhnTYt+yLGTonKAQNT
	kp5M84onhQUroujSkY=
X-Gm-Gg: AYBFou2/ndCnHqd8DVsc8QH7zQi/X/sIKxm5TrMVsoRpNBKtQHdCB+W9u6FHVWB98qq
	CCLoyQWHQxBcqfqvMyKtEA++tOgU9npIH7Q/QY1Btb3jW8d7mRvPUVMPX+PGMT5J1ovodVd9cwU
	zicQnylNUOKkKA9LTogkSa0r0awgPqjj+Vz0RcqnHsmmUjE/K1kQSk0D3n9HVRI+uG/Br1OeYOa
	5EBNX1QSV9wcK1ci2Hx49SOm6FJGUTxAGBKErukg7PrCZa3b0DLv6Ew/ZN8VUDNuuGv6q19uXhd
	pebyTTi4M/T+Idt4ge77hsb4+ijEF+sG3LZr0ELeZlcHK9MVW6AGjrZnBswdTR0j1AKy4wrC9Ro
	mtiNoQ40KkLnvjI77QZuiewd0RG4XrCgFGRLOMhS9OuQZ1TihfxfNxXpvOIYA9qjbCw8GzIFMXS
	R5iRKdKYX/r/yDlR5rbVmIZNeqsQ+pwpZieR/JO8Sb
X-Received: by 2002:a17:90b:4cd1:b0:3ab:2d46:1dd6 with SMTP id 98e67ed59e1d1-3ae895a56a3mr9494970a91.4.1793661884949;
        Mon, 02 Nov 2026 15:24:44 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b07c4d80c9sm621110a91.0.2026.11.02.15.24.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2026 15:24:44 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5363b06bcb2so77314521cf.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 15:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793661883; x=1794266683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YF2ZaT39aKwFG2Zu0dT49qqvZ6PYD/WHLec3K73Pqdo=;
        b=GwIhOaceOiG9i7ReKL171SyfLqTa5fsym1B3CFt/Yeer74gazRz8VkaG9FPmFNyeEv
         aKFfxY04/wPARSOeSnMKTjwVvZfUdpKddFfclUK4JR8+T6BziNlzXsr6BCJsinrQeYRK
         Xq5LRNMbELCq6zw/d1hEecU23XNqopSVjZOyY=
X-Received: by 2002:a05:622a:1214:b0:537:8412:e659 with SMTP id d75a77b69052e-542b7047750mr193376551cf.34.1793661883169;
        Mon, 02 Nov 2026 15:24:43 -0800 (PST)
X-Received: by 2002:a05:622a:1214:b0:537:8412:e659 with SMTP id d75a77b69052e-542b7047750mr193376191cf.34.1793661882693;
        Mon, 02 Nov 2026 15:24:42 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498cb5b520sm10336701cf.26.2026.11.02.15.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 15:24:41 -0800 (PST)
Message-ID: <492b4539-8906-472a-a35f-04db88974123@broadcom.com>
Date: Mon, 2 Nov 2026 15:24:37 -0800
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
Subject: Re: [PATCH net v4 1/2] net: ethernet: bgmac: preserve forced 2.5 Gbps
 link speed
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, jon.mason@broadcom.com,
 arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20261029211540.4123250-2-florian.fainelli@broadcom.com>
 <179365621626.3131.8036596501259312595@kernel.org>
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
In-Reply-To: <179365621626.3131.8036596501259312595@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/2/26 13:50, netdev-bot+sashiko@kernel.org wrote:
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
> - [Medium] After this patch the speed seen by userspace and phylib no
>    longer matches the MAC.
> - [Low] The patch depends on a switch-side change that is not named.
> 
> --
> 
> net: ethernet: bgmac: preserve forced 2.5 Gbps link speed
> 
> When BGMAC_FEAT_FORCE_SPEED_2500 is set, this commit makes
> bgmac_adjust_link() keep the MAC at SPEED_2500 instead of following the
> fixed PHY's 1 Gbps speed. It also restricts the platform forced-speed
> flag to Northstar Plus via of_machine_is_compatible("brcm,nsp").
> 
>> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
>> index 669eb7ce7d40b..9ef7307edd41e 100644
>> --- a/drivers/net/ethernet/broadcom/bgmac.c
>> +++ b/drivers/net/ethernet/broadcom/bgmac.c
>> @@ -1430,11 +1430,15 @@ void bgmac_adjust_link(struct net_device *net_dev)
>>   {
>>   	struct bgmac *bgmac = netdev_priv(net_dev);
>>   	struct phy_device *phy_dev = net_dev->phydev;
>> +	int speed = phy_dev->speed;
>>   	bool update = false;
>>   
>> +	if (bgmac->feature_flags & BGMAC_FEAT_FORCE_SPEED_2500)
>> +		speed = SPEED_2500;
> 
> [Severity: Low]
> Does this patch depend on the b53 change that puts the IMP port in its
> 2 Gbps mode? The commit message says:
> 
>    Together with configuring the switch IMP port for its 2 Gbps
>    mode, this eliminates the output queue discards ...
> 
> but it does not name the commit that makes that change.
> 
> With only this patch applied, the AMAC stays at SPEED_2500. Meanwhile
> b53_force_port_config() still programs the IMP port from the DT
> fixed-link (speed = <1000> in bcm-ns.dtsi) and clears the 2G bit:
> 
> drivers/net/dsa/b53/b53_common.c:b53_force_port_config() {
>      ...
> 	if (is5301x(dev) || is58xx(dev))
> 		reg &= ~PORT_OVERRIDE_SPEED_2000M;
>      ...
> }
> 
> The next patch in this series, "net: dsa: b53: restore the NSP IMP port
> 2 Gbps mode", fixes this. It sets speed = 2000 for BCM5301x/BCM58XX CPU
> ports in b53_phylink_mac_link_up(), so both ends match once the whole
> series is applied.
> 
> The two patches have different Fixes: tags, though (f6a95a24957a and
> b6a8a5477fe9). If a stable backport or a bisect picks up only this
> patch, would the MAC run at 2500 while the switch IMP port runs at
> 1000? Could the b53 commit be named here as a dependency so both are
> backported together?
> 
>>   	if (phy_dev->link) {
>> -		if (phy_dev->speed != bgmac->mac_speed) {
>> -			bgmac->mac_speed = phy_dev->speed;
>> +		if (speed != bgmac->mac_speed) {
>> +			bgmac->mac_speed = speed;
>>   			update = true;
>>   		}
> 
> [Severity: Medium]
> Can phy_print_status() still be reached on these interfaces?
> 

No it does not reach on those interfaces.

> bgmac_open()->bgmac_chip_reset()->bgmac_miiconfig() sets the cached
> speed and duplex before phy_start():
> 
> drivers/net/ethernet/broadcom/bgmac.c:bgmac_miiconfig() {
> 	if (bgmac->feature_flags & BGMAC_FEAT_FORCE_SPEED_2500) {
> 		...
> 		bgmac->mac_speed = SPEED_2500;
> 		bgmac->mac_duplex = DUPLEX_FULL;
> 		bgmac_mac_speed(bgmac);
>      ...
> }
> 
> When the fixed PHY reports link up, bgmac_adjust_link() now computes
> speed == SPEED_2500, which equals mac_speed, and the duplex also equals
> mac_duplex. So update stays false and the link-up message is never
> printed. Before this patch, the change from 2500 to 1000 always set
> update.
> 
> Also, bgmac_ethtool_ops uses phy_ethtool_get_link_ksettings, which
> reports phydev->speed. That is still SPEED_1000, either from the fixed
> PHY in bgmac_phy_connect_direct() or from the DT fixed-link:
> 
> 	struct fixed_phy_status fphy_status = {
> 		.link = 1,
> 		.speed = SPEED_1000,
> 		.duplex = DUPLEX_FULL,
> 	};
> 
> The UniMAC, however, is now programmed for 2500.
> 
> Will ethtool and netlink report 1000 Mb/s for a link that is actually
> running at 2.5 Gbps?

Yes, that will happen, teaching phylink, phylib and ethtool about 
Broadcom's proprietary 2Gbits/sec is beyond the scope of this patch.
-- 
Florian
