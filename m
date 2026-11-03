Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711756;
	b=5CnVlRnl5TnurR1/gavNtjaNMdF9poR6CRlUu+mSt2SK9V9sU14KiqLr9MFxN72rRrho
	 vA/caheo/736KQfNbBh31zX+bys/w1HyfU4SUURySSfh3BwPHT6zKyamthaEvLEAU69Fo
	 f+XeYBQ1DVgnmEbsbL1N3IhFtktaA/soYJfh5Gn80JgAkgnF9oOGcqVhl1fCvD2EyCyOW
	 OgAImNo++wpTP2FwJs31yloUbacjjN1aDDjda8Kosbtz32ihLrhnYSpda1Ekd2VMUkp7b
	 YIBcFnNfVrhyYsCEG5aAwsh7tnhzs0pIYcOzgXs32fqpEqEWf4Xc7xYsxHtPSEKlatg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711756;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=7ulnvN9VsCbKJ/5rQ+fv57lUtGef7Rza8nTzYqc8E6E=;
	b=bI7NjmXumcrqP/HXzgXqkpCk893I7Sf3aUHR0xcwpvSccgbW7sv8IVYTjBSr81vdii/N
	 0Uzzz0npL1ChH/cZYSyikZEG17wNnkBNRcWIizpFV9l/vGho3WizG9Lp2HIIUEK78bv87
	 kxjSqsrE9Yxp4O6aJogRSi5gPHjbkn18hI3h8DVjsk3sdOYmyNXVcaPxp04NM75wg2PqW
	 LlQ/z1nGGNhrH/bFQUkQe8SReKvASN7w60y88U1PIuPhbd0Ure7TDfMYBbxIPf+H6YAJP
	 nTUPF0Jyq/ZJlN9dyGi1CfWLa+bYzhxID8MAn2muUxxGc5A9q4qPMjaHTRAd931OOfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=none smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b="J/JdBhFu";
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B000C606A326;
	Tue,  3 Nov 2026 13:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B000C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=J/JdBhFu
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4BB4273BB9;
	Tue,  3 Nov 2026 14:15:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793711745; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7ulnvN9VsCbKJ/5rQ+fv57lUtGef7Rza8nTzYqc8E6E=;
	b=J/JdBhFuB1Lc17BCzKASBTrGoMuC5xDlVYh6Z005FWsIQ+l00oHjV8LmTml6Kl6fMP66+r
	9Ix+RVrpBG5C66PfhmX3my5GYaaiwTymlM905oI51K2DG/IM1Giu+kqxzgGmAyvLRTZaTd
	YhGNyGdgwdqVU+NquzGUQ5z1PddP5LFTCzJCtKlnda9DAvS2RXzaJI6z4dGzMC0HwNIKLB
	6erpbH0qh32nlxnCirtPNjxVTk9h6wLybxcxZTWN18SszPGE0wzB/fgI+e80oqgeuV3lK9
	D7szzMK5mhi79mzbP61lfXdWDkH5IuxSzDXR4mSZeGubb6ptkSueuvWsfj8C5Q==
Message-ID: <39cb446e-b667-4766-bd79-2635eb36166c@cjdns.fr>
Date: Tue, 3 Nov 2026 14:15:32 +0100
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
Subject: Re: [PATCH v4 6/7] dt-bindings: net: dsa: mediatek,mt7530: add EcoNet
 EN751221 switches
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, linux@armlinux.org.uk,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
References: <20261029184202.1859843-1-cjd@cjdns.fr>
 <20261029184202.1859843-7-cjd@cjdns.fr>
 <20261103-soft-lyrical-squid-c5a108@quoll>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <20261103-soft-lyrical-squid-c5a108@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello,

Thanks for the review.

On 03/11/2026 12:08, Krzysztof Kozlowski wrote:
> On Thu, Oct 29, 2026 at 06:42:01PM +0000, Caleb James DeLisle wrote:
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
>>
>> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
>> ---
>>   .../bindings/net/dsa/mediatek,mt7530.yaml     | 43 ++++++++++++++++++-
>>   1 file changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>> index f98b9113ad12..011c94ef9554 100644
>> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>> @@ -29,6 +29,12 @@ description: |
>>     and the switch registers are directly mapped into SoC's memory map rather than
>>     using MDIO. The DSA driver currently doesn't support MT7620 variants.
>>   
>> +  EcoNet EN751221 SoCs have a memory mapped MT7530 with 3x 10/100 PHYs and 1x
>> +  gigabit PHY. Some EN751221 chips such as EN7513G and EN7526G have a multi-chip
>> +  module implementation of the MT7530 as well as the on-die switch. In these
>> +  packages, the multi-chip module is connected to port 5 of the on-die switch
>> +  via a TRGMII link and allows for 5 gigabit ports.
>> +
>>     There is only the standalone version of MT7531.
>>   
>>     Port 5 on MT7530 supports various configurations:
>> @@ -109,6 +115,14 @@ properties:
>>             Built-in switch of the EcoNet EN7528 SoC
>>           const: econet,en7528-switch
>>   
>> +      - description:
>> +          Built-in switch of EcoNet EN751221 SoC
> You can drop, pointless description, repeats the compatible.


Perhaps reword "On-die switch of EcoNet EN751221 SoC" to avoid confusion 
with MCM switch?


>
>> +        const: econet,en751221-switch
>> +
>> +      - description:
>> +          Multi-chip module gigabit MT7530 in EN751221 SoC
> Keep it in one line with description. No need to inflate it even more.


OK


>
>> +        const: econet,en751221-gswitch
> That's almost the same compatible, which makes me wonder if you describe
> the same device twice. Same device, same compatible.


Well, these are both MT7530 based, but one of them is on-die with the 
SoC and the other one is an MCM so for the driver they are very 
different - they're even loaded by different kmods. I think since one is 
MMIO and the other is MDIO, using the same compatible won't cause a 
driver problem - but I don't know if it's best practice to smooth over 
such a difference or not. Your advice here would be most appreciated.


Thanks,

Caleb


>
> Best regards,
> Krzysztof
