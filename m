Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383AF41B351
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461572; cv=none; b=ocPxQKII1lUeguBp3tLM2mJY4pphs3rBXQ85CFu6gZxWGban8AF7kmq12de/efobFvDrsHn9OK+pSM0HhJrC/D4F690IaE+V/3GndK20BqJG5lS5W2I8QGnZJZsTCwoKlwTk8yrbRCGAFEqz0KsLcspV6qoOreu6CoaKspbF2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461572; c=relaxed/simple;
	bh=y0vkzzRueGXWEIrelCtCqAiTgsBYxvK/uKnbBTxzxZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VoMUK6L/l9OUeARUomQ4XVr0UpsYlaBfapKUWI2GxFyHxufQxtKroB1OnkGqOT/UAOYVqz6VbSkqKfVXXypGhIGkC9lMpj43fJrjdGj7Z/xNZRDjq8ATbYBEGPKfWEOmMPOcyw/7cUCfEfM746w9aoQSpabfIPf+NloWJuFzn/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=j1F9n1nC; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="j1F9n1nC"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 04A5C2C03DE;
	Wed,  8 Jul 2026 09:59:21 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1783461561;
	bh=y0vkzzRueGXWEIrelCtCqAiTgsBYxvK/uKnbBTxzxZM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=j1F9n1nCgDwaMVuXG5UO7RugzbWV9lwofrIYFwegkewTrbO1QfY/7Zqc32H7yXfz/
	 j4xBmfgkEMsCpv6ptIyxoBR1Pn0081RSO/H5kQun8IFqNb9MO31/qK1Hl9/fXa6Zfy
	 ZHPvdjCZcFBjiCM8pNufRarn0n5P5F6yA2DRpqT33n0B8sSU29UgHTCZlBLZBNk53z
	 5m7c8e++r2sBMRcxuHyQ2N+g9/mslIAJoMkoc0mXcLvWR6fvLHOgHLKh2ecVmFiXTt
	 mPA2WV5f5r6zasY2rWrZ4sMgC1pstXCLo9O+/JQp2wr3EG/cY7kWH4a4EkAWSqs0N0
	 VbKnfyk3x/JBg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a4d76b80001>; Wed, 08 Jul 2026 09:59:20 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Wed, 8 Jul 2026 09:59:20 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Wed, 8 Jul 2026 09:59:20 +1200
From: Ben Brown <Ben.Brown@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Chris Packham
	<Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH] net: phy: marvell: Add soft reset for 88E1510
Thread-Topic: [PATCH] net: phy: marvell: Add soft reset for 88E1510
Thread-Index: AQHdCnU25IxsSStIXU2TivaqAyBQrLZaEDQAgAAThwCAANQDgIAG4eYA
Date: Tue, 7 Jul 2026 21:59:20 +0000
Message-ID: <c77dd281-9ae2-4634-a670-bd6c70afb3df@alliedtelesis.co.nz>
References: <20260702225034.1062457-1-ben.brown@alliedtelesis.co.nz>
 <3536a59f-405c-452a-a7d6-359c0ea1b151@lunn.ch>
 <c0d760ff-fe66-48df-bd9f-3226dfdc97fc@alliedtelesis.co.nz>
 <3c493e6f-b5d8-42ed-a752-fdce6452926d@lunn.ch>
In-Reply-To: <3c493e6f-b5d8-42ed-a752-fdce6452926d@lunn.ch>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <317A99CAECBC154F89A577C179B628FE@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=TI3mSEla c=1 sm=1 tr=0 ts=6a4d76b8 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=GE29vkJnOosA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=LKViL4yy71K4K3j8qdYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQoNCk9uIDcvNC8yNiAwMDo1MywgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IE9uIEZyaSwgSnVsIDAz
LCAyMDI2IGF0IDEyOjE0OjI2QU0gKzAwMDAsIEJlbiBCcm93biB3cm90ZToNCj4+DQo+Pg0KPj4g
T24gNy8zLzI2IDExOjA0LCBBbmRyZXcgTHVubiB3cm90ZToNCj4+PiBPbiBGcmksIEp1bCAwMywg
MjAyNiBhdCAxMDo1MDozNEFNICsxMjAwLCBCZW4gQnJvd24gd3JvdGU6DQo+Pj4+IFdoZW4gYnJp
bmdpbmcgZG93biB0aGVuIHVwIHRoZSBsaW5rIG9uIGEgODhlMTUxMiBwaHkgYSBsaW5rIGlzIG5v
dA0KPj4+PiBnZXR0aW5nIGVzdGFibGlzaGVkLiBUaGlzIGlzIGJlY2F1c2UgdGhlIHBoeSBpcyBj
b21pbmcgb3V0IG9mIHJlc2V0IHRoZW4NCj4+Pj4gaW1tZWRpYXRlbHkgZ2V0dGluZyBjb25maWd1
cmVkLiBEdXJpbmcgY29uZmlndXJhdGlvbiB0aGUgcGFnZSBpcw0KPj4+PiB1bnN1Y2Nlc3NmdWxs
eSB1cGRhdGVkIGNhdXNpbmcgd3JpdGVzIHRvIHRoZSB3cm9uZyByZWdpc3RlcnMuDQo+Pj4+DQo+
Pj4+IEFkZCB0aGUgc29mdCByZXNldCBmdW5jdGlvbiB0aGF0IGRvZXMgYSByZXNldCB0aGVuIHBv
bGxpbmcgcmVhZCB3YWl0aW5nDQo+Pj4+IGZvciB0aGUgcGh5IHRvIGNvbWUgYmFjayBvbmxpbmUs
IGF0IHdoaWNoIHN0YWdlIHRoZSBwYWdlIHJlZ2lzdGVyIGNhbiBiZQ0KPj4+PiB1cGRhdGVkIHN1
Y2Nlc3NmdWxseS4NCj4+Pj4NCj4+Pj4gVGhpcyB3YXMgdGVzdGVkIG9uIGEgODhFMTUxMiBwaHks
IHVzaW5nIGlwIGxpbmsgdG8gYnJpbmcgdXAvZG93biB0aGUNCj4+Pj4gbGluay4NCj4+Pg0KPj4+
IFdoYXQgbWFrZXMgdGhlIDg4RTE1MTIgc3BlY2lhbCB0aGF0IGl0IG5lZWRzIHRoaXMsIGJ1dCBu
byBvdGhlcg0KPj4+IE1hcnZlbGwgUEhZIGRvZXM/DQo+Pj4NCj4+PiAJQW5kcmV3DQo+Pg0KPj4g
VGhpcyBtYXkgYmUgbmVlZGVkIG9uIHRoZSBvdGhlciBtYXJ2ZWxsIHBoeXMsIGJ1dCBJIG9ubHkg
aGF2ZSBhY2Nlc3MgdG8NCj4+IGEgODhFMTUxMiBwaHkgc28gSSBhbSBvbmx5IHVwZGF0aW5nIHdo
YXQgSSBoYXZlIHNlZW4gdGhpcyBvbi4NCj4gDQo+IFRoZSBNYXJ2ZWxsIGRyaXZlciBpcyB1c2Vk
IGEgbG90LCBzbyBpIHdvdWxkIG9mIGV4cGVjdGVkIHNvbWVib2R5IGVsc2UNCj4gdG8gb2Ygbm90
aWNlZC4NCj4gDQo+IExldHMgdGFrZSBhIHN0ZXAgYmFjay4NCj4gDQo+IFdoYXQgc29ydCBvZiBy
ZXNldCBhcmUgd2UgdGFsa2luZyBhYm91dD8gU29mdHdhcmUgb3IgaGFyZHdhcmU/DQo+IA0KPiAJ
QW5kcmV3DQoNCkl0IGlzIGRvaW5nIGEgaGFyZHdhcmUgcmVzZXQgdXNpbmcgYSBHUElPIGxpbmUu
DQoNCldoZW4gbGlua2VkIGRvd24gdGhlIHBoeSBnZXRzIHB1dCBpbnRvIHJlc2V0IHVzaW5nIGEg
aGFyZHdhcmUgR1BJTyBsaW5lLA0KZHVyaW5nIGxpbmsgdXAgdGhlIHBoeSBpbml0aWFsaXplcyB0
aGUgaGFyZHdhcmUgdXNpbmcgcGh5X2luaXRfaHcoKSwNCndoaWNoIGRlLWFzc2VydHMgdGhhdCBy
ZXNldCBHUElPLiBUaGVuIHRyaXZpYWwgc2V0dXAgaXMgZG9uZSBiZWZvcmUNCnRoZSBkcml2ZXIg
c3BlY2lmaWMgY29uZmlnX2luaXQoKS4NCg0KV2hlbiB3ZSBhcmUgZG9pbmcgdGhlIG1hcnZlbGwg
bTg4ZTE1MTBfY29uZmlnX2luaXQoKSB0aGUgZmlyc3QgcGFnZQ0Kd3JpdGUgaXMgbm90IGFwcGx5
aW5nIHNvIGl0IGVuZHMgdXAgd3JpdGluZyBjb25maWd1cmF0aW9uIHRvIHRoZSB3cm9uZyANCnJl
Z2lzdGVycy4gV2hlbiB0ZXN0aW5nIGZpeGVzIGFkZGluZyBhIDE1dXMgc2xlZXAgYmVmb3JlIGNo
YW5naW5nIHRoZSANCnBhZ2UgYWxzbyBtZWFudCB0aGUgcGFnZSB3YXMgdXBkYXRlZCBjb3JyZWN0
bHku
