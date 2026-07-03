Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08531A6807
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 02:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783045465; cv=none; b=nhNuCBi6O4ddSqYwjMx+kWz7KYppw+ED6kduixJKVnSyP/Q9M3jyMU65WJyTNNddto15p2IRZN8oFcts0lbHcYCUD2UFQYeJMAEfzRrIhJDR+vMz9jfozQKqN2jTgSB3kcSqK7zp06Scx3puSMRHQx8RZLtzN6eFCnF2NGFciMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783045465; c=relaxed/simple;
	bh=ldjRhuoUmm96yhd/jzbgrACvM+ER+HM+o73q4Xiahzg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ul07ATo9K8bLN7I4vnBjT4qCkn+js67xkYJlNmaO8mDN8zJeNFIZvuduqX5T1MRtJtTKWFEVjMMBCIW98BMhAz7vkNHvPePRuS1YedcNPuekMredFDGYdmBDGS1aIX4FhnT1dDam2cHIYANxhaam0OT/qRyaJcltswRwHrngyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=gdKnmIlw; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="gdKnmIlw"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B54DB2C05BD;
	Fri,  3 Jul 2026 14:24:20 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1783045460;
	bh=ldjRhuoUmm96yhd/jzbgrACvM+ER+HM+o73q4Xiahzg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gdKnmIlwWZQYJ08pUg4dtT4lXXeBM4NpFQ6xiRYjRXFeUvniXrMm4GSupAY4GXmPW
	 JBmPo+iI6f0y6tG3t6wVWWTRg5cHn8qLEJ+8sntARAzkWL5Ag4Y7z9SA5+xkXJFk1g
	 aZPjjFbkLc/uCF7M2XvFb2YAnLLnSWppTXkJ8V9RXRB4qFDKssFQm5cyP7P4F2IF6V
	 RPHUp5sKmsNUJUZA03HEni43cj3+CwkIvuITWWIXHPytmDMcUCDo6gz8X8xX4gQfTV
	 7lKXIURN2qg1FJlTZbXtlH7uzVKp++wCnJATYyIPGcDjdhSNmV/lPYtKLp/bMp+PgH
	 m/nVDLLpkwrAw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a471d540001>; Fri, 03 Jul 2026 14:24:20 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 3 Jul 2026 14:24:20 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Fri, 3 Jul 2026 14:24:20 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>, Markus Stockhausen
	<markus.stockhausen@gmx.de>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/8] net: mdio: realtek-rtl9300: Configure
 hardware polling during probing
Thread-Topic: [PATCH net-next v2 4/8] net: mdio: realtek-rtl9300: Configure
 hardware polling during probing
Thread-Index: AQHdB9tQksraRZWC3EWnRbR6FKjf47ZU8muAgAVazwA=
Date: Fri, 3 Jul 2026 02:24:20 +0000
Message-ID: <eac9d8d1-0ebe-403f-9823-c676058cd9bb@alliedtelesis.co.nz>
References: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
 <20260629152336.2239826-5-markus.stockhausen@gmx.de>
 <6f0a60b2-5083-46c5-aae4-3197d66007da@lunn.ch>
In-Reply-To: <6f0a60b2-5083-46c5-aae4-3197d66007da@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9B1A5ABFEF3034F873806BA723D5B57@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=TI3mSEla c=1 sm=1 tr=0 ts=6a471d54 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=5hFCTVTI1vfZqTqBIt8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAzMC8wNi8yMDI2IDA0OjM4LCBBbmRyZXcgTHVubiB3cm90ZToNCj4+ICtzdGF0aWMgaW50
IG90dG9fZW1kaW9fbm90aWZ5X3BoeV9hdHRhY2goc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikN
Cj4+ICt7DQo+PiArCXN0cnVjdCBvdHRvX2VtZGlvX3ByaXYgKnByaXYgPSBvdHRvX2VtZGlvX2J1
c190b19wcml2KHBoeWRldi0+bWRpby5idXMpOw0KPj4gKwlpbnQgcG9ydCA9IG90dG9fZW1kaW9f
cGh5X3RvX3BvcnQocGh5ZGV2LT5tZGlvLmJ1cywgcGh5ZGV2LT5tZGlvLmFkZHIpOw0KPj4gKwlp
bnQgcmV0Ow0KPj4gKw0KPj4gKwlpZiAocG9ydCA8IDApDQo+PiArCQlyZXR1cm4gcG9ydDsNCj4g
SGVyZSBzZWVtcyBsaWtlIGEgZ29vZCBwbGFjZSB0byBjaGVjayB0aGUgUEhZIGlzIGEgcmVhbHRl
ayBQSFksIGFuZA0KPiByZXR1cm4gLUVOT0RFViBpZiBub3QuIFRoYXQgc2hvdWxkIGNhdXNlIHBo
eV9hdHRhY2hfZGlyZWN0KCkgdG8gZmFpbCwNCj4gbWFraW5nIGl0IGltcG9zc2libGUgdG8gY29u
ZmlndXJlIHRoZSBwb3J0IHVwLg0KSSBkbyBrbm93IG9mIGF0IGxlYXN0IG9uZSBib2FyZCAoWnl4
ZWwgWEdTMTIxMCkgdGhhdCB1c2VzIGEgUlRMOTN4eCBhbmQgDQphIEFRUiBQSFku
