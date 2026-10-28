Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199862;
	b=JhMzo8uD0L5RFbHx/SwkMhGrjB/wZ22SfdmMtHrREsNLsg3ymch9k9R4ujCD7off2p97
	 54R/uUTVHphS86enCb/d5KI3wsUs3VjMtOT8RAxbHKEVSa8Y96+1bpF2fnz0FbzF5vfjZ
	 Xyn9nP+8uH2aoTspSSP6Q6mcGdNU4ESiIP54MRfutmeZ5VrT1UgVTkT12i4CmmDq3NAcy
	 Q7i5wSNXpXFLGXfxZ2BEwXwOw4UOqEbMyBlI/4KZD6wBW08WF0ojBfBJIvun9zmaUUPyz
	 rqIJdjXDunAaZGDbvUcirGv1o4PKA0d001mMBMFD8pGluW2hz4lkbhTXj7Mvnx7h84A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199862;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=2Pak5tnRuTRRR5lgI3SQ+wNVW+vIb8vrbTpuoRT98Po=;
	b=w6jtuHqfLfsg9fDUdl8VdiRdWCuoma0hqst9lSC9oRiT4Xl4fKx4UKamMKDJDCt/1XxL
	 m1/G0BUs1oNHaSk2r9HxcYm//tge2mcY4qfPQ+ECgRNf9/1tAdUI6nDZSfGpZmCwZDs6y
	 AYPzOCEanmTc3zCVpuYzh7fIvWJ1+dWO0q1Qs4u5P8bn0rmXUAdZQnAq9eLouX8YHxhkc
	 TnWJXvQbDEEqBl5+ThGIWwoC1EtVWgmNbWPbirkYIZkCQosanzU/AT0AUyZXGlbkJ5k8D
	 4Qj/cHVOugAyqwZAuQ78iGkEC/fxAMaU1P1tohESwngm/Wg+WqkidiXJQeVY5ZBls2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=sYN7Wb4W;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AFD60A261B;
	Wed, 28 Oct 2026 15:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39AFD60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=sYN7Wb4W
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 923E7161DCC;
	Wed, 28 Oct 2026 16:04:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793199857; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2Pak5tnRuTRRR5lgI3SQ+wNVW+vIb8vrbTpuoRT98Po=;
	b=sYN7Wb4W+yUTIRGpnInR+C9sIBvUi21SE2TULkltVcRLjMFYLQChN1xOKUe5DSzQ9aQP8p
	sqwWe+gBK2LjIM+o4yq4j44QgOpPnHtC6f49TkFrnJEdPTSF1ON/dUUrdgKy+nMSgmSB6L
	lLC48jrjJFDPSDjIUyU9it2XAwOMFVX2PXRDUIcC2TTJNqfljXiAzlicnGLPj0T5OdO8eS
	VOtmeUnKaajXekF9RTwjMyY9d7BOpOv4N73nSAY/1L/xfgwVQk8HkWBwzD9tPS/g181uRr
	QYBOMqLrqZ+0EWyMkCXKyMjtAI+AQ0cTRl/dZ8K3w5INT2SeLIwi5XbBQ5dT4A==
Message-ID: <8ebdebe0-a8a2-4e35-9ef6-41999547e2aa@cjdns.fr>
Date: Wed, 28 Oct 2026 16:04:06 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 5/7] net: dsa: mediatek: support MDIO switch downstream
 of MMIO switch
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, linux@armlinux.org.uk, arinc.unal@arinc9.com,
 Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 naseefkm@gmail.com, b.larsson@gmx.com
References: <20261028011317.1557238-1-cjd@cjdns.fr>
 <20261028011317.1557238-6-cjd@cjdns.fr>
 <f6fe9c7a-5617-475b-babe-da24cda815cc@lunn.ch>
 <acf55987-e96d-407f-a4a7-1c78178a0c7a@cjdns.fr>
 <bdde8389-008a-430a-8d0d-14edcb4050b4@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <bdde8389-008a-430a-8d0d-14edcb4050b4@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On 28/10/2026 13:50, Andrew Lunn wrote:
> On Wed, Oct 28, 2026 at 12:59:23PM +0100, Caleb James DeLisle wrote:
>> On 28/10/2026 03:20, Andrew Lunn wrote:
>>> On Wed, Oct 28, 2026 at 01:13:15AM +0000, Caleb James DeLisle wrote:
>>>> The MT7530 / MT7531 can connect via either MDIO or MMIO. In MMIO mode
>>>> the switch provides its own MDIO bus which connects to its integrated
>>>> PHYs, but also can be connected to other things, such as another
>>>> switch.
>>>>
>>>> If the MDIO bus contains another switch, then the upstream switch
>>>> will register but it will not setup the DSA tree because the
>>>> downstream switch is missing. Without the complete DSA tree,
>>>> mt753x_setup() will not be called on the switch and therefore
>>>> mt7530_setup_mdio() is never called so the downstream switch never
>>>> registers.
>>>>
>>>> Update mt7530_setup_mdio() so that it can be called multiple times,
>>>> export the symbol, and call it again after dsa_register_switch()
>>>> from mt7988_probe().
>>> I would suggest just moving it to probe. Don't also have it in setup.
>>> KISS.
>>
>> I don't think there's a way to do that which will work. And I guess I need
>> to add a few comments to explain why. Basically when dsa_register_switch()
>> is called, one of three things can happen:
>>
>> 1. return error (often without calling mt753x_setup), typically this is
>> EPROBE_DEFER because the ethernet driver is not there yet.
>>
>> 2. return 0 without calling mt753x_setup (because not all switches in the
>> tree are yet probed)
>>
>> 3. call mt753x_setup, complete setup, and return 0
>>
>>
>> In case 1, mt7530_setup_mdio must not be called, because it would be setting
>> up an MDIO on a driver that's about to get deleted.
> Which is fine, because when the probe fails, you unregister the MDIO
> bus. That should work. The second time around, you do have the netdev,
> and it should work.


When I tried doing this it did not work. The first issue is that 
mt7530_setup_mdio() uses a static int and increments it to make its ID. 
And normally this would create higher numbered busses but still work, 
however from what I remember there's something (not mt7530) that 
searches for mt7530-0 anyway and is unable to find it. I don't remember 
now what was doing it but I remember thinking I would need a global ID 
generator with reuse of released IDs.


Furthermore, I think I'd have to test all of the PHYs that are 
downstream of this switch because this is the first time we would 
actually be asking them actually register and unregister multiple times 
each startup, so if there are bugs, then they're kinda my bugs.


So if this is a requirement, then I think this patchset will need to go 
on the back burner and that support would probably be its own 
patch/patchset. So please let me know how you're feeling on this because 
I don't want to put too much time into the rest of this patchset if it 
is going to have to get shelved for a while anyway.


Thanks,

Caleb


>
> It is not great, you are doing extra work, but many DSA drivers are
> structured like this, the MDIO bus is registered in probe. The bus is
> scanned, PHY are found, and then the probe fails, and the PHYs are all
> thrown away etc.
>
> Hanging one switch off another switch like this using MDIO, kind of
> pushes you in this direction. Typical DSA setups don't do this, there
> is one MDIO bus which all switches hang off, sometimes with a
> multiplexor to make one MDIO bus act like many.
>
> Something to look at which might be interesting, Vladimir had some
> patches which allowed for partial switch topologies, where you could
> take a switch in a DSA setup off line. Maybe there is something in
> those patches which help, you can bring the switches up independently?
>
> 	    Andrew
