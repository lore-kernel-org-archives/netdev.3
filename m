Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EAC4D4884;
	Thu, 17 Sep 2026 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657971; cv=none; b=ZmYGdrbpxAbx/0bE0us+2Z69dJJ6WvLzzmWXQK05ghuVAo5CV2zuvq2dH9m9f8Vt5aHZacYR6GYN8+X0xTplmDLT6Xw8p7qR7ROj9ZYhv2Hbq+bfo3zJcNmVRA12DJ0vKAdIFisbs3+8WGeA7/zJABcf87M9QjnIWKMep3mUX9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657971; c=relaxed/simple;
	bh=MU1bN7FoveAYVzgvWXqpr3G4LDwEGMOhXhVWYa3VoGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERRSNRWovJyyr3jAjevF8HZ60oYwF9cIwsBRehGzOF94Gfmik1HwylfpJQiRU04vKZEnz8CBXOQ6+1oHZ9iLlln0eMkyIWBxc3dsfyLdoha9ZaucRQeU5ViAT0TKh1yKfvA/KX923wnb7VYnv9hLvIOry43ynlhd6q5bbxGn8Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=Av195hmA; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="Av195hmA"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 802EF4C301B;
	Thu, 17 Sep 2026 17:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789657928; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=DqWR7hYROWy/62+C7c2MOHPyBP86rK/9sHBnklMxuv4=;
	b=Av195hmAG2se1bBc2mVvC49xtmKl9Yp5Oas2Ym7ZMeqIeDJJuFVeOSOCrZHVqDsaPpd1Pq
	NmlAu0x+lthIV2wgWo5QoIh82AnoABImmODhDYqZURjLUaK9+EVnxzZmOIMBCujizfLdIB
	T9m8U+jHAq7FNAWnwq109d2A2LJw8ix6SLBZ1McjkUbZUurQLlmRVmgaNVPCUDpWVFIUJI
	Z9D6p6MuuchHb7bYL17q5HzeEIEwaf7y69GXZrnH+336B6l32ERRNoBhSRZ2ki1/Atm84x
	ub/ATHK8HrNGbtju02el2Y9T0e65+6qBlqv/Dd7QydfFkqlo/k5Jl6n9NDKjIA==
Message-ID: <95202df5-fdbb-4325-b77b-5f45ac8b1732@cjdns.fr>
Date: Thu, 17 Sep 2026 17:11:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
References: <20260915113427.113296-1-cjd@cjdns.fr>
 <aqkwYd5dTmHDCIW9@makrotopia.org>
 <2a7edfd0-b784-4b60-b9f9-769fe00286b7@cjdns.fr>
 <aqv92pZsobVEdipZ@makrotopia.org>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <aqv92pZsobVEdipZ@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 17/09/2026 16:48, Daniel Golle wrote:
> On Tue, Sep 15, 2026 at 02:01:29PM +0200, Caleb James DeLisle wrote:
>> On 15/09/2026 13:47, Daniel Golle wrote:
>>> On Tue, Sep 15, 2026 at 11:34:27AM +0000, Caleb James DeLisle wrote:
>>>> @@ -135,6 +199,23 @@ static struct phy_driver mtk_gephy_driver[] = {
>>>>    		 */
>>>>    		.config_intr	= genphy_no_config_intr,
>>>>    		.handle_interrupt = genphy_handle_interrupt_no_ack,
>>>> +		.match_phy_device = mt7530_phy_match,
>>>> +		.suspend	= genphy_suspend,
>>>> +		.resume		= genphy_resume,
>>>> +		.read_page	= mtk_phy_read_page,
>>>> +		.write_page	= mtk_phy_write_page,
>>>> +	},
>>>> +	{
>>>> +		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),
>>> I'd suggest to actually use phy_id and phy_id_mask assigned by the
>>> PHY_ID_MATCH_EXACT macro by calling genphy_match_phy_device() in your
>>> match functions above instead of open-coding the ID match.
>>> Or drop PHY_ID_MATCH_EXACT from *both* drivers.
>> I suppose the latter is easier because then I don't have to re-think
>> mt7530_is_gphy() which would be lying if it wasn't actually checking ID is
>> MTK_GPHY_ID_MT7530.
>>
> I would have preferred to call genphy_match_phy_device() in your match
> functions instead of open-coding phy_id_compare() which is best
> reached via genphy_match_phy_device() in this situation -- that would
> express the code intent in the most obvious way imho.


I did it this way because the name mt7530_is_gphy() implies "Is this an 
MT7530 gigabit PHY?" which if it doesn't match on MTK_GPHY_ID_MT7530 
then that's not what it does so there's a little bit more thought involved.


If I'd have known this was really your preference I'd have done that, 
but I already just sent v6 so I guess I can send v7 tomorrow.


Thanks,

Caleb


