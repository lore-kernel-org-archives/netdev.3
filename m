Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192523F58E9;
	Thu, 17 Sep 2026 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678506; cv=none; b=h1BQMSe//wzBZe3+n+n12LxHJYMI2B6ON9NYfRV5knvuOzL8UqW6gN3nt1x9/06fMuV7MeDTdbrMc9gZ99CBfO1mS0Ilya+alW2vtqzU9dU5xiRdcQYYpNrWBFsrkFtHWJv5FmUvg5KQMlLjXMm1u7D8x3IoWkDCK1ATn/mglEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678506; c=relaxed/simple;
	bh=enyDOQeYSkPasbMj0OxVLJZTXTL7rrrFME0koTlQWQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n33v+t6Bnn7wg/qBMTktqKABaohlEVzOmtmfNbgGwZ9JiCPiffJ+k+b+mxSxkvFELcCl1poTyYUHOS6XEL7JMKKrA9La9Prk7eCypKimMKRPM62JP1DUFHcj8p2j+SkhirKq3xux/UKuEvUw9A6NpJ7PQMAfDRtQQqLFHv+15os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=L8OXyVb1; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="L8OXyVb1"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88CBD4CDF79;
	Thu, 17 Sep 2026 22:54:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789678500; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/zXG8zjcLwtXi03aCja2HV2NYr13r4XXU/kOwJzkeS8=;
	b=L8OXyVb1k1J3R5VFFs5O4XCf57OuErk3xA8ezm9OQWBzgBam/ttJMdq3v70gen92xF1e4+
	catSQc3qCk2476V48vyIs4GkCscql7LiFPunWI6APEBCrybHzRnpDR13VO3ZaYX0vV3qIu
	MpPC1P8dg4WI2xALxE5qVipzOr3DumNu+WC1HXZ6BhAE0FrZEPYgP4Nmo0L6f93sstr5Oo
	BdEEMyL8hJJW7IjG5ZU9hIcJGzG4spttIXF9nvRdzkOMlaZOuINco8bx/Fm8eKm4EezyaV
	eE/hF99EUx2pTBAiK8bzJBwBkooUkHpGsVwZTb9ZqhSwyUUicyYRkfLVYOJwDg==
Message-ID: <89252048-b0d9-4fe3-97c0-92bcd083c751@cjdns.fr>
Date: Thu, 17 Sep 2026 22:54:48 +0200
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
 <95202df5-fdbb-4325-b77b-5f45ac8b1732@cjdns.fr>
 <aqw9ptzAZBmdHy1S@makrotopia.org>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <aqw9ptzAZBmdHy1S@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On 17/09/2026 21:21, Daniel Golle wrote:
> On Thu, Sep 17, 2026 at 05:11:50PM +0200, Caleb James DeLisle wrote:
>> On 17/09/2026 16:48, Daniel Golle wrote:
>>> On Tue, Sep 15, 2026 at 02:01:29PM +0200, Caleb James DeLisle wrote:
>>>> On 15/09/2026 13:47, Daniel Golle wrote:
>>>>> On Tue, Sep 15, 2026 at 11:34:27AM +0000, Caleb James DeLisle wrote:
>>>>>> @@ -135,6 +199,23 @@ static struct phy_driver mtk_gephy_driver[] = {
>>>>>>     		 */
>>>>>>     		.config_intr	= genphy_no_config_intr,
>>>>>>     		.handle_interrupt = genphy_handle_interrupt_no_ack,
>>>>>> +		.match_phy_device = mt7530_phy_match,
>>>>>> +		.suspend	= genphy_suspend,
>>>>>> +		.resume		= genphy_resume,
>>>>>> +		.read_page	= mtk_phy_read_page,
>>>>>> +		.write_page	= mtk_phy_write_page,
>>>>>> +	},
>>>>>> +	{
>>>>>> +		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),
>>>>> I'd suggest to actually use phy_id and phy_id_mask assigned by the
>>>>> PHY_ID_MATCH_EXACT macro by calling genphy_match_phy_device() in your
>>>>> match functions above instead of open-coding the ID match.
>>>>> Or drop PHY_ID_MATCH_EXACT from *both* drivers.
>>>> I suppose the latter is easier because then I don't have to re-think
>>>> mt7530_is_gphy() which would be lying if it wasn't actually checking ID is
>>>> MTK_GPHY_ID_MT7530.
>>>>
>>> I would have preferred to call genphy_match_phy_device() in your match
>>> functions instead of open-coding phy_id_compare() which is best
>>> reached via genphy_match_phy_device() in this situation -- that would
>>> express the code intent in the most obvious way imho.
>>
>> I did it this way because the name mt7530_is_gphy() implies "Is this an
>> MT7530 gigabit PHY?" which if it doesn't match on MTK_GPHY_ID_MT7530 then
>> that's not what it does so there's a little bit more thought involved.
>>
>>
>> If I'd have known this was really your preference I'd have done that, but I
>> already just sent v6 so I guess I can send v7 tomorrow.
> It's also fine for me like it is now, just a light preference, not
> worth a resend just for that.
>
> However, I'd also still like to see the OF parent walk replaced by
> register evidence, which requires that you dump the registers more
> than once to understand if any difference are things like counters or
> temperature, or actually identify the PHY variant.
>
> It can of course be that the actual silicon is really the exact same
> MT7530 MCM as eg. on MT7623, just driven by a different clock
> frequency and the observable register differences are things like
> clock devidors -- if we manage to understand that and just apply the
> resulting tuning accordingly, even better.


I just tried removing the remaining phy_write commands and it still 
seems to work. It seems that the thing that really made this driver not 
work on EcoNet was the EEE which Vladislav Karmanov removed in 
ccbe7540e4aad earlier this month. So at this point I guess I could send 
a patch which does nothing except check MII_ESTATUS & ESTATUS_1000_TFULL 
so it doesn't get confused with the FE driver.


I'm not sure if this is a good plan to deviate from what the vendor code 
was, but the values are not wildly different. If you think it's smart, I 
can send this and we'll see how it goes.


Thanks,

Caleb



