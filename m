Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0A3C2D;
	Wed, 26 Aug 2026 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702942; cv=none; b=AaRjMnw3y5hpZzjykjx8fx0Z2v0/rBW+4Fnnj2dfF4oB/8Jnuuiuda4KNqNF2zE7hcvkd3+7bx66ahzwfDC07kqNl6IXxhQxhctX6ERKMN7XU5Ebpla0X4wabe8nFm2Wdbrt7uZ6CWzE2r0vtwu1WvVjk+hn1nLRSEvX63lUYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702942; c=relaxed/simple;
	bh=rT59UfzklRu5awBynaeRRNy/GIhkT4PjdDpRX4ieppA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVSdBsEE2Qo29ewBig3+BfaMOe+CFbKipdWNt8bUZki9eNa3SPuPTscNkaYZg3L7Yx34GYrsox5vnTZ110Az+c+J9vj/b+Z00btPHrtf5opuuM2D+m0bedplNTOl21EYJcdLScJyx0vqtZdPjP/uzjBQcvx57ckUsZ1m5fHtbA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=cX3ZfBp2; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="cX3ZfBp2"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BEF331C615F;
	Wed, 26 Aug 2026 02:08:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1787702936; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2vuOWpSASKJg2znhHds0mJtsBVVDEX1H0ZtqkDQG8JU=;
	b=cX3ZfBp2hPSrSU883c4qo0fTugVPROEryrT0w3yxNfhIGESOdgRV+P300IoAD4x2vGMWbe
	t7c5Puz5Og40pOwgBlj6ZS/NVE5Du+j30UZKSVXMVeCiC4C7OdgAfp7sb9UajmCHLb2c2H
	9Ay4hoB77HXWMVj+VqorKIHeyyjCSBGFZuR41GDkA+0rtprRwv5tQ+7qWmz9t0v1sw9wBr
	7ErlIq1P+6vwv9tE0cihhTTjHoGqs0ndmP7z2LNPZGs0gpCf5S18s/cSgt1/Xz6mXbJqLf
	WZdxRN82J45GoRvSyDYlWinBXm5BzNxMOftqK1HH14Onlk/Yia80paWiLGX45Q==
Message-ID: <4fa1ab31-cdcb-4488-b038-c5869966b6ec@cjdns.fr>
Date: Wed, 26 Aug 2026 02:08:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] net: phy: mediatek: add driver for EcoNet Fast
 Ethernet SoC PHYs
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, daniel@makrotopia.org,
 naseefkm@gmail.com, joey@tinyisr.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260825180421.1804729-1-cjd@cjdns.fr>
 <177dc347-4cf9-48ca-97fe-b0f3cd46d8e3@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <177dc347-4cf9-48ca-97fe-b0f3cd46d8e3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 25/08/2026 21:40, Andrew Lunn wrote:
>> Also provide support for the older EN7512 Fast Ethernet SoC PHYs found
>> in EN751221 chips with do not have the MCM switch. That is chips which
>> do not have a "G" in the name. As these PHYs bear the ID 03a2.9412
>> which collides with MTK_GPHY_ID_MT7530 gigabit PHY, do not match them
>> and instead rely on the user to override the PHY ID in the device tree
>> if they wish to use this driver.
> Is there a way to tell them apart using other registers?


The reference code differentiates this PHY from the other because this 
one does not advertise gigabit capability. I sent it like this because 
the idea of a matcher made me nervous and this felt more conservative, 
but I'm open to guidance about what is the most appropriate solution.


>
>> +static int en751221_fephy_r50(struct phy_device *phydev)
>> +{
>> +	struct econet_socphy_shared *shared = phy_package_get_priv(phydev);
>> +	struct compensation ctab = get_ctab(phydev);
>> +	int zcal_sz = ARRAY_SIZE(zcal_to_r50ohm);
>> +	u8 rg_zcal_ctrl = ECONET_R50_ZCAL_DEFAULT;
> Please swap these two lines.
Whoops, thanks.
>
>> +	for (;;) {
> It is unusual to do loops like this. Can it be turned into a do while
> loop? And without looking deep into it, it is not clear if this is
> endless if the hardware stops responding.


You raise a good point in that it's hard to reason out the default exit 
scenario, and I will figure out how to improve that. I'm not sure I can 
actually get rid of the infinite loop without making the code worse, 
because the default exit condition needs to assign ret and goto the 
error out label.

In any case I'll find something that's easier to reason out at a glance.


>
>> +static int en751221_fephy_tx_offset(struct phy_device *phydev)
>> +{
>> +	struct econet_socphy_shared *shared = phy_package_get_priv(phydev);
>> +	struct compensation ctab = get_ctab(phydev);
>> +	int initial_comp_out;
>> +	int polarity = 0;
>> +	int offset = ECONET_TXOS_DEFAULT;
>> +	u16 offset_bin;
>> +	int comp_out;
>> +	int ret = 0;
> Another reverse christmas tree issue. Please check all your functions.
Whoops, sorry for not catching this before sending.
>
>> +static int en751221_fephy_config_init(struct phy_device *phydev)
>> +{
>> +	struct econet_socphy_shared *shared = phy_package_get_priv(phydev);
>> +	u16 l0r26_temp;
>> +	int ret;
>> +	int i;
>> +
>> +	if (!shared->phydev_p0) {
>> +		phydev_err(phydev, "Port zero must be configured\n");
>> +		return -EOPNOTSUPP;
>> +	}
> What is the issue here? Why must port 0 be first?
It doesn't need to be configured first but it must be probed because 
these PHYs are not independent, they exist as a group and some 
configuration must be done on the first phy in the group. I will re-send 
with clarification in a comment.
>
>> +
>> +	for (i = 0; i < 5; i++) {
>> +		ret = en751221_fephy_r50(phydev);
>> +		if (!ret)
>> +			break;
>> +	}
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < 5; i++) {
>> +		ret = en751221_fephy_tx_offset(phydev);
>> +		if (!ret)
>> +			break;
>> +	}
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < 5; i++) {
>> +		ret = en751221_fephy_tx_amp(phydev);
>> +		if (!ret)
>> +			break;
>> +	}
> Why 5 ?


Following the reference implementation "keep trying until it's very 
clear that it's not going to work". But this should be a define and it 
slipped my mind to do so.


Thank you for your review!


Caleb

>
>
>      Andrew
>
> ---
> pw-bot: cr
>
