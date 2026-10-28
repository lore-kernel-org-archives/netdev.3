Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195578;
	b=k9EFhSertI3Qe/eW4GpZqu8iYn2BXWlQ/557CJg8Y2gjP/kadbv+WhMSOdmv/LYOkMvs
	 dIl907ay6X9PuaUGLP1Uk+twOobln18R+ifoXFxwxwutSSWnHwxqPtd7q/jA2THm1emSv
	 I9WTXQYsJKlM9vjinZ09Q1Oo6+3jzNi3S88WnLEiYBYaWGMuAuAZZd+jKI0Zu2OlVCsQh
	 Zpr1gea1eEAMo0eHm6pKM1XRSgq7zQSHW0kW29I9cW6diMQJHug0eSQaIPnoAipXwZ2Jg
	 6LCPKf0XtAI834Zecs1DtCbKv2hmvZRYmdi4C7wquP2EHpv9RROvU1wpq+dR1wVPFOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195578;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=sXikcPN/2u2jcqxK0ic3WXRLLLyeXrwW2xb+LwiQxXY=;
	b=kPskJJ2cUXBE6Mn+/Km0Zxbxr9rsxs7kiW1QRwFIGQw3k+PNRq4ELRDfJ1buPWdvEsbS
	 i9tHakRKLB7cbPUiyaTaq/Qall1XkxrTCDXcZTSiCUNT3vAHB4kC0SJX2mekvIrz63EGL
	 +ngxcobcMipVUve16XoMs7F15RnHcteIJm8DPGUWKoTvU8acCihiLw+8CH+r1wFrG6NUA
	 F9EsUWJj3F3JFrhIWzWXMhI9rXhxlOzATZf4Te4Sfpka2KeLesAtCB6GBExN5lvlAhgp6
	 OtcoDRQk+2ELr95RIsHM5KBFzYDkfMfIaIALp0O7WoE5+CQ/3o/sdsUSh44uaDhoKeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=SAvQBHOm;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3167606A33A;
	Wed, 28 Oct 2026 13:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3167606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=SAvQBHOm
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D80E215FD22;
	Wed, 28 Oct 2026 14:52:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793195573; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=sXikcPN/2u2jcqxK0ic3WXRLLLyeXrwW2xb+LwiQxXY=;
	b=SAvQBHOmhiuyKvlXtM1AIKAj6CRqI92p5TarTfEUggze30z+GnbG565ZljxAgt9yHEC2dM
	uD5iBoqtnOoZOkDKm2IGdLODqoyp/e0jfOhfmpnSaikTs7D6Lenc1O1BbWgh87s/ma/Nyv
	vXgTMgY1W84l8PsDxj4I+9z1ztQDiCRxWVVACm3kSa6NgsrRAOPZ/Vhus041nsaRWalF1C
	DoCc3UPTBDy+cs4xKDWnbbmOkb4G/zZCOhvIYOmx+6EyMWoAV+2XadysA9Wdy/uPflREyO
	0119GI7xKpC5Bf/FgQbIOizvjAHIjyaiWdtPRb7F8nPbA73yEHVZi50bJKd6Xg==
Message-ID: <c6154519-98f4-46a7-ac30-076ebf588bab@cjdns.fr>
Date: Wed, 28 Oct 2026 14:52:44 +0100
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
Subject: Re: [PATCH v3 2/7] dt-bindings: net: dsa: mediatek,mt7530: add
 passthrough mode
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
 <20261028011317.1557238-3-cjd@cjdns.fr>
 <a031f089-0b96-4fc0-b878-6af13414524f@lunn.ch>
 <521b930f-0bf9-4373-bfbf-3e2570661ec9@cjdns.fr>
 <a566aad7-754c-4960-b018-4471a0068344@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <a566aad7-754c-4960-b018-4471a0068344@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 28/10/2026 13:28, Andrew Lunn wrote:
> On Wed, Oct 28, 2026 at 12:27:18PM +0100, Caleb James DeLisle wrote:
>> On 28/10/2026 03:04, Andrew Lunn wrote:
>>> On Wed, Oct 28, 2026 at 01:13:12AM +0000, Caleb James DeLisle wrote:
>>>> MT7530 switches can be configured to blindly pass packets between their
>>>> CPU/upstream port and a downstream DSA port, in particular, without
>>>> altering the MediaTek DSA Tag on the packets. This mode is used in some
>>>> integrations where an SoC integrated switch exists, but a more capable
>>>> MCM switch is added to effectively replace it.
>>>>
>>>> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
>>>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>>>> ---
>>>>    .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml       | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>>>> index 90b3582b7619..e29fb8693498 100644
>>>> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>>>> @@ -73,6 +73,13 @@ description: |
>>>>          Check out example 7.
>>>> +  The MT7530 and MT7531 switches are capable of being operated in "passthrough"
>>>> +  mode. In this mode, traffic is unconditionally passed between the CPU port
>>>> +  and the DSA port which links to a second switch. To use passthrough mode, the
>>>> +  upstream switch is configured with a DSA link to the downstream switch. In
>>>> +  passthrough mode the upstream switch is restricted, with no other ports or
>>>> +  switch configuration allowed.
>>>> +
>>>>    properties:
>>>>      compatible:
>>>>        oneOf:
>>> Looking at just what is here, all i see is a comment. There is no new
>>> property? Yet the subject is "add passthrough mode"?
>>
>> Indeed, I used "add" to mean "add documentation of". Per my reply on patch
>> 3, I think we really prefer to avoid special properties and let this
>> constitute (very) limited support for a switch hierarchy.
>>
>> If there's another verb you think makes a better commit line, I'd be happy
>> to adjust.
> [Goes and looks at mediatek,mt7530.yaml]
>
> So pass through is not an existing property. You are also not adding a
> new property 'passthrough'.
>
> What you appear to be saying is that the MT7530 and MT7531 are hard
> coded by the driver into pass through mode? So it is in effect a
> property of the compatible? So maybe put this comment next to the
> compatible? And make the subject/commit message talk about the
> compatible being hard coded for pass through?


Perhaps I should rephrase as follows:


"""

The MT7530 and MT7531 switches do not support switch hierarchies except in
the case that a switch is configured with only one CPU port and one DSA port
that links to a downstream switch. In this configuration, the upstream switch
acts as a blind pass-through to the downstream switch.
"""


> Looking forward, what happens when somebody wants to use the switch as
> a switch? Or you figure out how to do proper D in DSA? It becomes
> messy because you need to add a property indicating the compatible
> should actually be a switch?


Full hierarchy (using DSA tag) is impossible because of what seems to be 
a hardware bug where switches don't distinguish themselves in the tag. 
However it is possible (albeit ugly) to enable ports on both switches 
providing the same numbered port isn't enabled on both switches.


If somebody ever implements that, even if they remove this passthrough 
support, users of the current passthrough capability will not notice a 
difference because that will do the same as this.


>
> So maybe you really do need a property?
>
> But DT describes hardware, and pass through is configuration. So maybe
> it should not be in DT at all, Maybe the driver needs to look at the
> DT tree, figure out a port is used as a DSA port, and put the switch
> into pass through all on its own? Once D in DSA is supported, the
> addition ports become available, but no other changes are needed in
> the DT blob?


Previously there was no documentation regarding hierarchies, and any 
hierarchy would fail at runtime. I think a brief note that this one case 
of hierarchy is allowed is nice for the users, though it does bend the 
definition of "describing the hardware" so it could also be excluded. I 
may be persuaded either way.


Thanks,

Caleb


>
> Sorry, going around in circles, but hopefully it helps you think about
> the big picture.
>
> 	   Andrew
