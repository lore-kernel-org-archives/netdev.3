Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.238.123.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794070694;
	b=aW5zUAdmkfb8Btbx+wO7znB2lHMp3jp4M964Ao/VBqkgbYkIXSo+W8v3Y8ZFipxA22XY
	 UhlA1FJGUPlRgWtfsfJaLmkn7AqvhYTU9L5kEKFY5yMLa+gHZro9UjJDOIwkd/wdszWQM
	 zy9XQfYebNDGVoM/IbS8o1Vycz5zLDPf+pjt3We0qdOPXHq4EQJ5gSaKmV+2XMUABlnKY
	 oBtN5C2jgqWNnP/EyVZKjOwFEPfG4VuyZrzSC56aKd//j5AuGcO/ZFUKaOS7J0bxBNT4X
	 HTFY87CxJjRYJF+FYjAIX5Aq78F7pv0Jc0TV1s9sb5TI/INKBcHrx7AqL8JkQR7IQhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070694;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=KKTs5+AnKZPaqJkUBfTaMQT3/ZytLFNYoxVwpYr6eHY=;
	b=DnMfP9C/EPsQ7fzUORMc0cum2UwTOZA8rQZ13RA9SpO6hhjLkQ2R/B/nJdL60t2dYld0
	 /0pRFSN65dWBRXM6U27l/IR83FBI6JuqM8shsbr436+43xA7NhXFjfwYiTUENvRUMa0Rh
	 PvS4Z/aMDlRxaO0z91H92P5feOTMdOILnCYapNkgqVfrddoshS14jInPjAoDin5son+Wc
	 4NsiTPB5QMYVDcRoIdbR+dZ2BmY7SxVpYquQErWhcDekyUgxqyT6h+Q9fk3SoVtURVfli
	 KYA4GaaRcfGfUHELRkjlb255V0Bg+FWGm+fbRdoRmlZxT3RP9e/3hWqr/RrorvYLxzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marleb.org;
	spf=pass smtp.mailfrom=marleb.org;
	dkim=pass header.d=marleb.org header.i=@marleb.org header.a=rsa-sha256 header.s=dkim header.b="gWC6VK/4";
	arc=none smtp.remote-ip=80.238.123.102
Received: from mail.marleb.org (mail.marleb.org [80.238.123.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA3606A335;
	Sat,  7 Nov 2026 16:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2CA3606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marleb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marleb.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marleb.org header.i=@marleb.org header.a=rsa-sha256 header.s=dkim header.b=gWC6VK/4
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D2471732;
	Sat, 07 Nov 2026 17:58:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marleb.org; s=dkim;
	t=1794070685; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KKTs5+AnKZPaqJkUBfTaMQT3/ZytLFNYoxVwpYr6eHY=;
	b=gWC6VK/4BCtlJvkAks9C6fn25sZTBpztRVApdHMzZpIVnWHEi2xUir/EVse1Rq630PRzQZ
	mTNgdJyKEYvJOK/guUBqHlfWXsWfP8/GW7BVaVRrBvHA7H360X2hDAuzzvCyX7m6GmS3Iv
	tswSFTFRwTiBJZF75zI9qJOPzVdORqyVWNsY4wC0KaQiL93oslDCoUlN6FRZ388Kwjqt6f
	jF7KNsknWghiXMIiPhxnLM7ASfVkUpSeHYB9uP2l43N+V+SF/mpPMnNXUrLFSQaBk7V375
	t6VH+Z11frgLUVOhwhC0VIuQFf7OCIjHlcFPvr/d+ZlZKUcn35+xCnqkZ7Mm9g==
Message-ID: <2c7c16a8-b8ba-4df6-96b3-39e8222f8d8a@marleb.org>
Date: Sat, 7 Nov 2026 17:58:01 +0100
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
Subject: Re: [PATCH net-next] net: phy: realtek: register hwmon thermal zones
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261103-realtek-hwmon-tz-v1-1-e672723c58cb@marleb.org>
 <20261106212528.948836-1-kuba@kernel.org>
Content-Language: en-US
From: Hleb Shauchenka <me@marleb.org>
In-Reply-To: <20261106212528.948836-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On Fri, Nov 06, 2026, Jakub Kicinski wrote:
 > So on mainline, no RTL8261 PHY seems to register a hwmon device. The
 > three thermal zones seen in testing would then come from out-of-tree
 > OpenWrt PHY support.

Correct. On that board OpenWrt's out-of-tree RTL8261N support calls
rtl822x_hwmon_init(). In mainline the flag reaches the RTL8221B-VB-CG,
RTL8221B-VM-CG and RTL8251B when they have a DT node. The internal
NBASE-T PHYs normally have none, so the hwmon core skips them. I will
reword the commit message in v2.

 > Would a DTS that adds #thermal-sensor-cells = <0> to an ethernet-phy@N
 > node under a realtek,rtl9301-mdio bus fail dtbs_check?

Yes. dt-schema drops the additionalProperties: true of ethernet-phy.yaml,
so nothing evaluates the property. v2 will add #thermal-sensor-cells to
ethernet-phy.yaml, which also covers the Aquantia and Marvell PHYs.

 > If the errno were returned, the thermal core would keep its previous
 > state.

Agreed. v2 will return the phy_read_mmd() error from both reads, as a
separate patch with a Fixes tag for 33700ca45b7d.

On 06/11/2026 22:25, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: phy: realtek: register hwmon thermal zones
>
> This commit adds HWMON_C_REGISTER_TZ to the channel info of the Realtek
> PHY hwmon device. With it, the hwmon core registers the PHY temperature
> sensor with the thermal framework, so device-tree thermal zones that
> reference the PHY can bind.
>
>> Set the flag, as the Aquantia PHY driver does. This lets the RTL8261N
>> sensors on the Zyxel XGS1250-12 B1 drive the chassis fan through
>> thermal cooling maps.
>>
>> Tested on a Zyxel XGS1250-12 B1 with OpenWrt's Linux 6.18.55: the
>> three PHY thermal zones register, and an emulated 85 C reading on one
>> of them (CONFIG_THERMAL_EMULATION) switches the fan on through the
>> existing 80 C trip and off again once cleared.
> [Severity: Medium]
> Does this description hold for the mainline driver?
>
> rtl822x_hwmon_init() has only one caller, rtl822x_probe() in
> drivers/net/phy/realtek/realtek_main.c:
>
>      if (IS_ENABLED(CONFIG_REALTEK_PHY_HWMON) &&
>          phydev->phy_id != RTL_GENERIC_PHYID)
>              return rtl822x_hwmon_init(phydev);
>
> Only four entries use that probe: RTL8221B-VB-CG, RTL8221B-VM-CG,
> RTL8251B and Realtek Internal NBASE-T PHY.
>
> The RTL8261C/CE/D_VM entries use rtl8261x_probe(). That probe only
> allocates priv and picks a firmware name. It never calls
> rtl822x_hwmon_init(). The driver table also has no RTL8261N ID.
>
> An external C45 PHY cannot fall back to the internal NBASE-T entry
> either, because rtl_internal_nbaset_match_phy_device() has:
>
>      if (phydev->is_c45)
>          return false;
>      ...
>      return rtlgen_supports_2_5gbps(phydev) && !rtlgen_supports_mmd(phydev);
>
> So on mainline, no RTL8261 PHY seems to register a hwmon device. The
> three thermal zones seen in testing would then come from out-of-tree
> OpenWrt PHY support.
>
> Could the commit message name the PHYs that actually gain thermal zone
> registration (RTL8221B, RTL8251B and the internal NBASE-T PHYs)? Or
> could it say that RTL8261 hwmon support is a missing prerequisite?
>
>> diff --git a/drivers/net/phy/realtek/realtek_hwmon.c b/drivers/net/phy/realtek/realtek_hwmon.c
>> index ac96e2d1ebe82..e6235df288c32 100644
>> --- a/drivers/net/phy/realtek/realtek_hwmon.c
>> +++ b/drivers/net/phy/realtek/realtek_hwmon.c
>> @@ -51,6 +51,7 @@ static const struct hwmon_ops rtl822x_hwmon_ops = {
>>   };
>>   
>>   static const struct hwmon_channel_info * const rtl822x_hwmon_info[] = {
>> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> [Severity: Low]
> Does this need a DT binding update to go with it?
>
> With HWMON_C_REGISTER_TZ set, hwmon_thermal_add_sensor() calls
> devm_thermal_of_zone_register() on the PHY's of_node. Thermal-of finds
> zones through thermal-sensors phandles, so the PHY node needs a
> #thermal-sensor-cells property.
>
> None of the relevant schemas seem to allow that property:
>
>    realtek,rtl9301-mdio.yaml is the RTL930x MDIO binding used by the
>    board in the commit message. Its ethernet-phy@ children are
>    $ref: ethernet-phy.yaml# with unevaluatedProperties: false.
>
>    realtek,rtl8224-package.yaml restricts its PHY children the same way.
>
>    realtek,rtl82xx.yaml, which covers the
>    ethernet-phy-id001c.c849/c84a/c862 compatibles, ends with
>    unevaluatedProperties: false.
>
>    ethernet-phy.yaml does not evaluate any thermal property.
>
> Would a DTS that adds #thermal-sensor-cells = <0> to an ethernet-phy@N
> node under a realtek,rtl9301-mdio bus fail dtbs_check?
>
> The Aquantia and Marvell PHYs have the same gap, but this patch makes
> Realtek PHYs new users of it.
>
> [Severity: Medium]
> With this flag, rtl822x_hwmon_read() becomes the get_temp backend of a
> thermal zone that drives cooling devices. Should it check phy_read_mmd()
> for errors now?
>
> drivers/net/phy/realtek/realtek_hwmon.c:rtl822x_hwmon_read() {
>      ...
> 	case hwmon_temp_input:
> 		raw = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSRR) & 0x3ff;
> 		*val = rtl822x_hwmon_get_temp(raw);
> 		break;
>      ...
> 	return 0;
> }
>
> The mask turns a negative errno into a plausible temperature, and the
> function returns success. For example, -EIO becomes 0x3fb, which reads
> as -2500 millidegrees. -ETIMEDOUT reads as -55000.
>
> hwmon_thermal_get_temp() treats only ret < 0 as a failure:
>
> 	ret = hwdev->chip->ops->read(tdata->dev, hwmon_temp, hwmon_temp_input,
> 				     tdata->index, &t);
> 	if (ret < 0)
> 		return ret;
>
> 	*temp = t;
>
> If one MDIO read fails while the PHY is hot, the thermal core gets a
> sub-zero reading. Could the governor then switch the fan off for at
> least one polling interval? If the errno were returned, the thermal
> core would keep its previous state.
>
> The hwmon_temp_max path, which reads TSSR and shifts by 6, has the same
> unchecked pattern, although thermal does not use it.
>
> The masking itself goes back to commit 33700ca45b7d2e ("net: phy:
> realtek: add hwmon support for temp sensor on RTL822x"). This patch is
> what connects it to a cooling control loop.
>
>>   	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX),
>>   	NULL
>>   };
