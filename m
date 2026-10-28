Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186853;
	b=j1xQEbLXbmFHsjP683rwb59L/rtDe6wYBO0/nVrPxArjRC7niW1gDco1id9xZtv3nCmQ
	 FH3FR01f4J6XrRzqZOW/7s3S7JarKTkdtLe1L6yaYVr684A5n9G+ZpG7/3nGNN0xj4zKQ
	 TWe8XECeUherzP7kN15C5m3x9p+etWI3p2DhUwXhEFoMu8l3Xlcc1suyk2DNMwXMQGZgT
	 RFryvQKJMdfK0GZQv/DrwZoYHEBbD8OjSUKNg/rIGu15dqy/IH6LG17ILINtSUtTnveFq
	 nOo68xjQbuFjmLCiBOwiFWYFtT4f/D7sizCgT014tmp+sSpsUwsIgWUciRjFJAy7iug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186853;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=CevGQp+s1w1J24KtaW8+NnlonqWYYMxxCOLZ2QIESgY=;
	b=MmLuCSefeJ86U4toFi7PLf1F8KQmo0y6igbvsYafFIrznekM0RxKJsUbLdnbAogliq6N
	 xuvoo2Srffbi8DMUjhox/YhcbRK0O36LYZiEaoH71TFsSHq9S8CnjAlduysd32HfnPaKm
	 hrzz7jA9qR7f/IjSne/Nmc3+cBeutU0o5OjAoMTmP25rtYO3BXNdWUmgQ/2ZDRYXwPZcQ
	 E5xGvrrkal866xZVpcbzhkxvwQuWLM8mRnsRVgGYKAB4U5axBFAD2VF5A6AONLseeBWtP
	 m/Q4ZMPJ29IUVGViIZ7WMIptGEWYCTL1GOcVp3pIQ1w3dKXjHYfn4Ml7cGbbLBIv16w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b="Pl1km/oF";
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1A606A31A;
	Wed, 28 Oct 2026 11:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78C1A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=Pl1km/oF
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E16F415A508;
	Wed, 28 Oct 2026 12:27:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793186847; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=CevGQp+s1w1J24KtaW8+NnlonqWYYMxxCOLZ2QIESgY=;
	b=Pl1km/oFujov7U9vn/7PmrQGLNFYnU/cP8SNsfDLDBHYvir/Jn3mahgOhSPuJ59sYmoqvX
	CfOXb/EfnQu1Fn8NE1WUxyynR5JsDereRbofEGGwlD/NFgF7DKvyr0ox4QXGIZ+gjncfiY
	47cetQ+qi5KEc/xrFTURm/7nbjl7vLJ28+DQPyJV9dM3nEMk+rY/tVEPklt+RYqb8xcdQ+
	Lcvi+/GQIN751WRGVRpruLaIEuzSfKbnhhlWI9YAODcHgFIQEChTpqO39jzPze0WX0BEdF
	m2RotoTUCr+dBL60t14SfOfG+ZNBN3sN6kzA8w57hxRpzSwmlSgSesO540Hcnw==
Message-ID: <521b930f-0bf9-4373-bfbf-3e2570661ec9@cjdns.fr>
Date: Wed, 28 Oct 2026 12:27:18 +0100
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
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <a031f089-0b96-4fc0-b878-6af13414524f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 28/10/2026 03:04, Andrew Lunn wrote:
> On Wed, Oct 28, 2026 at 01:13:12AM +0000, Caleb James DeLisle wrote:
>> MT7530 switches can be configured to blindly pass packets between their
>> CPU/upstream port and a downstream DSA port, in particular, without
>> altering the MediaTek DSA Tag on the packets. This mode is used in some
>> integrations where an SoC integrated switch exists, but a more capable
>> MCM switch is added to effectively replace it.
>>
>> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>> ---
>>   .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml       | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>> index 90b3582b7619..e29fb8693498 100644
>> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>> @@ -73,6 +73,13 @@ description: |
>>   
>>         Check out example 7.
>>   
>> +  The MT7530 and MT7531 switches are capable of being operated in "passthrough"
>> +  mode. In this mode, traffic is unconditionally passed between the CPU port
>> +  and the DSA port which links to a second switch. To use passthrough mode, the
>> +  upstream switch is configured with a DSA link to the downstream switch. In
>> +  passthrough mode the upstream switch is restricted, with no other ports or
>> +  switch configuration allowed.
>> +
>>   properties:
>>     compatible:
>>       oneOf:
> Looking at just what is here, all i see is a comment. There is no new
> property? Yet the subject is "add passthrough mode"?


Indeed, I used "add" to mean "add documentation of". Per my reply on 
patch 3, I think we really prefer to avoid special properties and let 
this constitute (very) limited support for a switch hierarchy.

If there's another verb you think makes a better commit line, I'd be 
happy to adjust.


Thanks,

Caleb


>
> 	Andrew
