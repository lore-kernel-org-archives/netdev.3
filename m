Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186367;
	b=frYRwo2yQOzjfJPFRPWEfHQOdanXOGODGphb7OzMEqGi3DV5BULOwAAVxHqtvb88Smv4
	 PDslsGCVOxQQ/aJke9o9HUtpod1xlJ8Q36K3KaOLLWIiw/w9RmmuymUiy/n78hVrYjjSu
	 djje0qEBatFQgGl0MHmSvHjI45/9xl6Rl3NzDZ2FYOWWHIriPVDZ/fvDJ1+CQ4ahtmxgB
	 IBwRactkxiwSoxXRiyUKw+iXxY5/A4l9xK6gFwEEgmTIpdFrGmQuxjG8GYkPYzYcn+Elt
	 Ez5j+1eGo30dYm9KwbHkSnUgf+X6ScnJjZS8h+UyUlTMNeuyItZfulZP3oIkylyfsNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186367;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=yKdfPzMRS/kwPXscycDGzlcjovJBQwAGTa4z13VzbQI=;
	b=gb18WHlUyTcaEASgInkQYeid7hs3g1PZ4sBiHa5woG37JvM7UIHbCT/z3eleVH92/OWQ
	 gIDi6bRB2h9meY4qHvJ5N/LYFqwfkRTVFR11xNl3agB1PEJ/1uDbqiPHRjMaJ4bBICa2m
	 NLB59PB2l5aElSSiwElF09EBG2CVCua/1odjc2GMrwXYY5qEwxqJ1PxxclhFFoxaWxE/6
	 ZLuWl/Gkyp938LrRi6eFX+zJF+UKYxfr2CrAczlCVqYNpH0Cte16qq8ffTjOn94aHj3n4
	 1feNyrvzJrwlFjRPZK0fLeYg+M+rRE2t3Rr3vgawVrHx7WnKDjTidenqeC3nEk7w1wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=none smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=m59PuZSH;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B16073210;
	Wed, 28 Oct 2026 11:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B8B16073210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=m59PuZSH
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17AC6159721;
	Wed, 28 Oct 2026 12:19:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793186363; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=yKdfPzMRS/kwPXscycDGzlcjovJBQwAGTa4z13VzbQI=;
	b=m59PuZSH0wQWRO9g5AKyqgoruvEOgJ05UH1RBowvozLh4c0D7H8AJ26PyakRtlinOM4ufv
	BTYUDPZuRQL2RTJvtudK5LoGl/TCl+D+p7e1SElHrXce5jiI/Ap3RBqGKeLpcyfGv6yM+Z
	4NOK5BYdKEedmrwXMu0mAqNrwh816Z1vAQcsx0AiClAsXSR2HZvwo19wH2W55PMhrMoHm3
	t7esB+H7DBXHwd1LbsRPKBQgsumglcmvEXC+N/j2xIC/XOZuLqCSvTfLP8xsds7ksQwIB+
	GfgzQ4/LhBGLAc6F2Y0MOb9RTuW3q2rQn9dmNu6phmmMY/4L5i3yCc1ml8MQGw==
Message-ID: <9f955484-1ca4-44a4-84a9-cc1d062efcf0@cjdns.fr>
Date: Wed, 28 Oct 2026 12:19:16 +0100
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
Subject: Re: [PATCH v3 6/7] dt-bindings: net: dsa: mediatek,mt7530: add
 econet,en751221
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
 <20261028011317.1557238-7-cjd@cjdns.fr>
 <f9249c6d-ef72-4723-a3b5-8d5375e53744@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <f9249c6d-ef72-4723-a3b5-8d5375e53744@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 28/10/2026 03:26, Andrew Lunn wrote:
> On Wed, Oct 28, 2026 at 01:13:16AM +0000, Caleb James DeLisle wrote:
>> The EcoNet EN751221 MIPS SoC integrates an MT7530 switch memory-mapped
>> in the SoC register space. It is similar to the econet,en7528-switch
>> except that ports 0..3 are 10/100 only, port 4 has a gigabit PHY, and
>> port 5 has no PHY, but is in some implementations connected to a
>> downstream MT7530 multi-chip module via a TRGMII link.
>>
>> The downstream MT7530 is similar to the MT7621 multi-chip module and
>> has all gigabit ports.
>>
>> Add the econet,en751221-switch compatible with the same constraints as
>> the other built-in switches and also add the econet,en751221-gswitch
>> multi-chip-module switch whose port 6 is configured as a DSA link port.
> Is there a use case of the econet,en751221-switch not in pass through
> mode? This is where you could have a different dsa_switch_ops
> structure, which probably makes the changes less invasive.
>
> Even if there is a use case for not pass through, you can still look
> for the property in probe, and decide which of two different
> dsa_switch_ops to pass to dsa_register_switch.


I think this was pretty much answered in my reply to your patch 3 
review. Without insider knowledge, my understanding is EN751221 is a 
common die, and it's packaged in a variety of different EN751x (DSL) and 
EN752x (Fiber) chip modules. The die has a switch with 3x 10/100 ports 
and 1x gigabit port. Chips with a 'G' in the name (EN7513G, EN7526G that 
I know) have the MCM switch and use the on-die switch as a passthrough. 
So yes, in short there are real (and quite popular) devices with both 
MCM and non-MCM implementations.


Thanks,

Caleb


>
> 	   Andrew
