Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915250;
	b=D21wjouql1vldNUfwXlkYIP23hLiyZqlTYnECLOeQ9P8vznOZbimVpg0s/8WiV1TdEhk
	 Z5lvaU6PDFj7A4Smv/AYB5C0acXtmyO22h8cvfHw5NicnxTINNM73me9OTZOL1oiK4mpX
	 3TWZhNYZg4UZuzcCYf62B4Nqs6Qu1qvAP2bVsJK2+BtEl/DueMTCn4v8yJrEqVHV/Mw5n
	 cXh9CaV6JQtGjrPDCfZV6UBwx571Hm0HMxVcWt02QpJEuG+CSoKj0WYBBkJsMWqIFYKP2
	 gx+4WHRookHVpdxaJu/ovZ2l3chQ5WNRmqAkAh3BPmwrbVGSQQ1yKp4CJUW3jKDAhbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915250;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=tF2GiLip2eghBn6G11QIbGdBYa2x2FuFEYyBYxkrvXc=;
	b=MxVWQ4ZCnEqz6ju/gfcCB90CrjsbkyiJh0HAnH+zRYmjKooi076knrDWVfqVplG0PlvN
	 N0/1+xzkUY3VhBLbNCHmz83+j9z5j0O//vGGzW1pU61P5xIOVtw75iBL1c4Nn7Lfl6o7/
	 59cwMU+W62RG+89BX2RurfXxMBkhbtIlKWXKDF9U0DGmXyD12eZF0fSQW9AnK6ZK02GVY
	 hT/bVPj8R3k2H9v6sDrM0ZZRavf1iNXYXjHTNomujr4URvtoMWuwbhdc5vxKmIFFsb/rn
	 /emDLfasphPkav/9731mJFEeP3SByOhZYM3fARhsKBzemdTX6KMbf/eVSHyuwtZz4dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=none smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=Su106odv;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8334606A328;
	Thu,  5 Nov 2026 21:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8334606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=Su106odv
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7508337ADE;
	Thu,  5 Nov 2026 22:47:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793915245; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=tF2GiLip2eghBn6G11QIbGdBYa2x2FuFEYyBYxkrvXc=;
	b=Su106odvYiSUdlTy4gAn6reXaT7CU3p8XbrNLGRsW0G1/51JVSQTtsC8y6+C0vTLEFp29q
	ZuCAYRIt/vXquLBTqbVQ2plZcOYu/GZNugKlPmQFY6Tcj6kD5Uw6iNDK1Vw11Qj2MsU073
	eASRdfK2XuDz3N1J3vmddrc8+HvPoYoZ8sH2sWAQDBh9tREDyQ+v6NmFuzW/Hz0fZ0w6MQ
	iGmKqkuMT24HraaUlhQx06Vb2GLkqk2GIqvQP8a04KrfRMk4SmDyQhotpbYR8TTHB13RpJ
	TPU1I8CFu6tU19rcp+Nd2wiuItzAnKupzERHjr3ShL52t5HXj/ufX24LMNku1w==
Message-ID: <8cc1d8d6-c563-4eb7-a738-5ba51ae60ac0@cjdns.fr>
Date: Thu, 5 Nov 2026 22:47:10 +0100
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
 <39cb446e-b667-4766-bd79-2635eb36166c@cjdns.fr>
 <7c15c254-d157-4f5b-bfae-06a5301af222@kernel.org>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <7c15c254-d157-4f5b-bfae-06a5301af222@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 04/11/2026 08:20, Krzysztof Kozlowski wrote:
> On 03/11/2026 14:15, Caleb James DeLisle wrote:
>>>> +        const: econet,en751221-gswitch
>>> That's almost the same compatible, which makes me wonder if you describe
>>> the same device twice. Same device, same compatible.
>>
>> Well, these are both MT7530 based, but one of them is on-die with the
>> SoC and the other one is an MCM so for the driver they are very
>> different - they're even loaded by different kmods. I think since one is
>> MMIO and the other is MDIO, using the same compatible won't cause a
>> driver problem - but I don't know if it's best practice to smooth over
>> such a difference or not. Your advice here would be most appreciated.
>>
> The drivers do not matter - we have one compatible for I2C/SPI/Serial
> devices as well. The only question is about the hardware, what are these
> devices and what are you here exactly describing. Compatible is en751221
> but you call it MT7530, so even more confusion.


Let me address these in reverse order: The compatibles are 
econet,en751221-switch and econet,en751221-gswitch but the switch is an 
MT7530. This is a convention used for this switch: When it is integrated 
in an SoC and has customization for that SoC, it is identified using the 
name of the SoC suffixed by "-switch" (except in the case of 
mediatek,mt7621 where it takes the exact name of the SoC, but this looks 
like it was a mistake).


Regarding the en751221-switch vs. en751221-gswitch dichotomy, the 
meaningful difference to the DT is that the gswitch is a 
multi-chip-module so the CPU port is phy-mode "trgmii", and on the 
on-die switch it's "internal" since there's no PHY between it and the 
CPU. Moreover the gswitch requires the mediatek,mcm; attribute while the 
on-die switch forbids it. I can of course relax the restrictions so they 
can use the same compatible, but I don't know which way is most 
appropriate so I would like to follow your advice.


Thanks,

Caleb


>
> Best regards,
> Krzysztof
