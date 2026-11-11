Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=59.120.207.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387514;
	b=1V9BIUZmrOUC4AEdLKbeufjwYfmT3CuljuUUfXjiFZ78XvGVvbQk62wwwfWteHW/mKay
	 rAfNtupgZmTKh7GIlGfYjXvfTY3SDF7N06Sp3oybwjsdckF122xz2p0O2W+lhxIoI7bpr
	 clDpLIUBPvUQ6vzqpibnOUit3z+RUfqCClMfcP7cmZmOwedo1FKMYAtnI3Eev0PYZtCVB
	 GQlDRKce7DgyGClpElaMFew4TV1L+q7jFVEnECdyejJGoB/7zZD8Ugp3ynvDL1+f0i424
	 NnHJnVM/c3dtD5kxgwzP7i++/zfn4aW2poxEGRz548LZsJHJtO9o/ybCZDgys6q4cxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387514;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:X-UUID:X-CID-P-RULE:
	 X-CID-O-INFO:X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:
	 X-UUID:Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:x-tm-as-product-ver:x-tm-as-result:
	 x-tmase-matchedrid:x-tm-as-user-approved-sender:
	 x-tm-as-user-blocked-sender:x-tmase-result:x-tmase-version:
	 x-tm-snts-smtp:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=Y+eH+GhdmUrfoDGpz56/iD2DrpHo93goPhQusAyArEE=;
	b=2D3ALAP633B2hTuVW8qTn+J2Mp/SFW4ZP+Bwv2neO/Sd/R66S+Ffz8isYx9mkHpou++F
	 VZxBUSQ79qDbOOHAhWWfYzufDrhyxH+N/dnXPsIzn0MY9+Q6zSVhbVgbzKEbohKcMH7LZ
	 F4I4rOE8gI3g0y1T2SrW3Ihs8CUKHTVuYCaGbFG/9usYr7EyX9yE6nrF9RtvIu6bEjWZi
	 P2my5RymwcOEBdywF37pqCO6VAZenQYT07+jVtvpqCkGXeldSHQe+VqWTL8IJTlmGtaOG
	 H56izG26iDGPBDSNwNTfj+91M/rWpXCdJFuK9I429TrrU+6cLQhTSLTKsLrybrQHu0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=compal.com;
	spf=pass smtp.mailfrom=compal.com;
	arc=none smtp.remote-ip=59.120.207.196
Received: from tpecef22.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B72E606A326;
	Wed, 11 Nov 2026 08:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B72E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: 0eed5a3eddae11f1a87c2323a98e90a4-20261111
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:600a96ec-e884-4b08-bde2-8cb0d4b74448,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:566e2466-4b51-4c95-bb1b-80ac6aad9c96,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0eed5a3eddae11f1a87c2323a98e90a4-20261111
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef22.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 533507991; Wed, 11 Nov 2026 16:58:26 +0800
X-UUID: 0c4ae1acddae11f1b328fd8a884f4420-20261111
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:d037e0bf-94b7-4720-9e83-02c1cf6d890f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:1990988d-b3e7-4795-ae33-b1b4d51e21d7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0c4ae1acddae11f1b328fd8a884f4420-20261111
Received: from sdbmbx12.tpe.compalcomm.com [(10.113.2.136)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES256-SHA 256/256)
	with ESMTP id 143282859; Wed, 11 Nov 2026 16:58:22 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX12.tpe.compalcomm.com (10.113.2.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.43;
 Wed, 11 Nov 2026 16:58:21 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::23a8:5ed2:f09e:3abf]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::23a8:5ed2:f09e:3abf%11]) with mapi id
 15.02.2562.056; Wed, 11 Nov 2026 16:58:21 +0800
From: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "loic.poulain@oss.qualcomm.com" <loic.poulain@oss.qualcomm.com>,
	"ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"wen-zhi.huang@mediatek.com" <wen-zhi.huang@mediatek.com>,
	"shi-wei.yeh@mediatek.com" <shi-wei.yeh@mediatek.com>,
	"Minano.tseng@mediatek.com" <Minano.tseng@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "horms@kernel.org"
	<horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "Yu. Robert (GSM)"
	<robert_yu@compal.com>, "Chang. Jeff (GSM)" <Jeff_Chang@compal.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v11 6/6] net: wwan: t9xx: Add AT & MBIM WWAN ports
Thread-Topic: [PATCH v11 6/6] net: wwan: t9xx: Add AT & MBIM WWAN ports
Thread-Index: AQHdcbrNXFYrSVnY/0qugubVifbtVQ==
Date: Wed, 11 Nov 2026 08:58:20 +0000
Message-ID: <f0a480783459458f97c70a01e25e7ec7@compal.com>
References: <20261105-t9xx_driver_v1-v11-6-2084aa512864@compal.com>,<179430863921.994134.2627836072572850693@kernel.org>
In-Reply-To: <179430863921.994134.2627836072572850693@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30312.005
x-tm-as-result: No-10--27.825700-8.000000
x-tmase-matchedrid: FYPNOy2BwYguv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZuZd
	NI5cmL7EsdzeBfTA9wItSJJXQOmfwXzFvO78wHZusX4aFYAMIYOvfe6AKVPc3lIhOZRrGf3IREf
	5oRlSyIY/mwKDp7nBQmzBMi9d1ALNvJry7MXwYemGavh+mhti3MAS7SmLvGxLWH/C60yjPRwyLd
	+z5mFX0lzx/INQzDCIFqHPWokMPGovQR5DgsZZTvGNYAx7C5BCi69wqkZIM+lNbINBwEGUTaOY1
	0X4PL2KL8q1xLpGuUumTeAM0d55y47c1MxzsflB5enkh7Jrzn4304eoJbTN0RqXY3hdPmbE39zs
	KQPf3cZ9He+f2l6P/9kYYjC93YHf8ad285k03lcIjw+vaMoImxyqoGG6T9ochyxRFqxgsXU7mVl
	acjgdS5dYXpTgtgKtzDNWTL5eLZoOBEhSg62auH6eJTKwzTtEGqiseS8e4Gf3UFNAPy1GeKz6Vg
	SfzWXFHy3JWQlCAA/Zljn20+NeJ94RhVwczLmRGqxL/yNoD8rVzTgENjEotprjKaOVysNvOfEmq
	6feyfMX6nfwyd2cmu6xG0H9n3ROBv3BwF3sroc=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--27.825700-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30312.005
x-tm-snts-smtp: 8F5E04D47D432F7D308C60F16EE0A49376CAAC70B8A0531EF20841DDCCA40F912000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

VGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IENhbiBhIHN0YWxlIHBvcnQtPmVuYWJsZSByZWFj
aCBSRUFEWSBoZXJlPyBtdGtfcG9ydF9zdGF0dXNfdXBkYXRlKCkgb25seQ0KPiB3cml0ZXMgcG9y
dC0+ZW5hYmxlIGZvciBjaGFubmVscyB0aGF0IGFwcGVhciBpbiB0aGUgY3VycmVudCBlbnVtZXJh
dGlvbjoNCj4NCj4gICAgIHBvcnQtPmVuYWJsZSA9IEZJRUxEX0dFVChNVEtfSU5GT19GTERfRU4s
IGxlMTZfdG9fY3B1KHBvcnRfaW5mby0+Y2hhbm5lbCkpOw0KPg0KPiBOb3RoaW5nIHJlc2V0cyB0
aGUgcG9ydHMgdGhhdCBhcmUgbm90IGxpc3RlZC4NCj4NCj4gSW4gbXRrX2ZzbV9zdGFydHVwX2Fj
dCgpLCBtdGtfZnNtX3BhcnNlX2hzMl9tc2coKSBhcHBsaWVzIHRoZSBNRCBwb3J0DQo+IGVudW1l
cmF0aW9uIGZpcnN0LiBJZiBhIGxhdGVyIFJURlQgZW50cnkgaXMgbWFsZm9ybWVkLCBvcg0KPiBt
dGtfZnNtX3NlbmRfaHMzX21zZygpIGZhaWxzLCB0aGUgY29kZSB0YWtlcyBoc19lcnIgYW5kIHJl
LWFybXMgdGhlDQo+IGNoYW5uZWwgc28gdGhlIG1vZGVtIGNhbiByZXRyeSB0aGUgaGFuZHNoYWtl
Og0KPg0KPiAgICAgcmV0ID0gbXRrX2ZzbV9wYXJzZV9oczJfbXNnKGZzbSwgaHNfaW5mbywgc2ti
KTsNCj4gICAgIGlmICghcmV0KQ0KPiAgICAgICAgIHJldCA9IG10a19mc21fc2VuZF9oczNfbXNn
KGhzX2luZm8sIHNrYik7DQo+ICAgICAuLi4NCj4gaHNfZXJyOg0KPiAgICAgaWYgKGhzX2luZm8p
DQo+ICAgICAgICAgbXRrX3BjaV91bm1hc2tfZXh0X2V2dChtZGV2LCBoc19pbmZvLT5taGNjaWZf
Y2gpOw0KPg0KPiBTdXBwb3NlIHRoZSByZXRyaWVkIGVudW1lcmF0aW9uIGxlYXZlcyBvdXQgYSBw
b3J0IHRoYXQgdGhlIGZpcnN0IG9uZQ0KPiBtYXJrZWQgZW5hYmxlZC4gVGhhdCBwb3J0IGtlZXBz
IHBvcnQtPmVuYWJsZSA9PSB0cnVlLiBPbiBSRUFEWSwNCj4gbXRrX3BvcnRfd3dhbl9lbmFibGUo
KSB3b3VsZCB0aGVuIGFybSBpdHMgQ0xETUExIHF1ZXVlIGFuZCBjYWxsDQo+IHd3YW5fY3JlYXRl
X3BvcnQoKSBmb3IgYSBjaGFubmVsIHRoZSBmaW5hbCBlbnVtZXJhdGlvbiBkaWQgbm90IGFkdmVy
dGlzZS4NCj4gVGhhdCBnb2VzIGFnYWluc3QgdGhlIGNvbW1lbnQgYWJvdmUuDQo+DQo+IFRoaXMg
ZGVwZW5kcyBvbiB0aGUgbW9kZW0gZmlybXdhcmUgc2VuZGluZyBhIGRpZmZlcmVudCBwb3J0IGxp
c3QgYWNyb3NzDQo+IGhhbmRzaGFrZSByZXRyaWVzLCBzbyBpdCBtYXkgbm90IGhhcHBlbiBpbiBw
cmFjdGljZS4gRlNNX1NUQVRFX09GRiBpcw0KPiB0ZXJtaW5hbCBpbiB0aGlzIGRyaXZlciwgc28g
dGhlIGhhbmRzaGFrZSByZXRyeSBzZWVtcyB0byBiZSB0aGUgb25seSB3YXkNCj4gdG8gZ2V0IGhl
cmUsIG5vdCBhIGxhdGVyIGJvb3QuDQo+DQo+IFdvdWxkIGNsZWFyaW5nIGFsbCBwb3J0LT5lbmFi
bGUgZmxhZ3MgYmVmb3JlIGFwcGx5aW5nIGEgbmV3IGVudW1lcmF0aW9uDQo+IGNsb3NlIHRoaXMg
Z2FwPw0KDQpObyBjaGFuZ2UgZm9yIHRoZSByZXRyeSBjYXNlLiAgVGhlIE1EIGFuZCBTQVAgZW51
bWVyYXRpb25zIGJvdGggZ28NCnRocm91Z2ggbXRrX3BvcnRfc3RhdHVzX3VwZGF0ZSgpIGFuZCBh
cnJpdmUgYXMgaW5kZXBlbmRlbnQgSFMycywgc28NCmNsZWFyaW5nIGV2ZXJ5IHBvcnQtPmVuYWJs
ZSBiZWZvcmUgYXBwbHlpbmcgb25lIHdvdWxkIHdpcGUgdGhlIGZsYWdzIHRoZQ0Kb3RoZXIgc2lk
ZSBoYWQgYWxyZWFkeSBzZXQsIGFuZCBSRUFEWSB3b3VsZCBlbmFibGUgbm8gTUQgcG9ydC4gIEEN
CnBlci10YWJsZSByZXNldCB3b3VsZCBuZWVkIHRoZSBoYW5kc2hha2UgaWQgcGFzc2VkIHRocm91
Z2ggdGhlIFJURlQNCmFjdGlvbiBzaWduYXR1cmUsIGZvciBhIG1vZGVtIHRoYXQgd291bGQgaGF2
ZSB0byBjaGFuZ2UgaXRzIG93biBwb3J0DQpsaXN0IGJldHdlZW4gdHdvIGhhbmRzaGFrZXMgb2Yg
dGhlIHNhbWUgYm9vdC4NCg0KV2lsbCBmaXggaW4gdjEyIHRoZSBzdG9yZSB5b3UgcG9pbnQgYXQ6
IG10a19wb3J0X2VuYWJsZV9ieV90eXBlKCkgbm8NCmxvbmdlciBjbGVhcnMgcG9ydC0+ZW5hYmxl
LCBhbmQgaXRzIGNvbW1lbnQgZ29lcyB3aXRoIGl0LiAgRlNNX1NUQVRFX09GRg0KaXMgdGVybWlu
YWwgYW5kIFJFQURZIGlzIHJlYWNoZWQgYXQgbW9zdCBvbmNlIHBlciBiaW5kLCBzbyBub3RoaW5n
IGNhbg0Kb2JzZXJ2ZSB0aGUgY2xlYXJlZCBmbGFnLg0KDQo+IElzIHRoZSBDQ0NJIGhlYWRlciBz
dWJ0cmFjdGVkIHR3aWNlIGhlcmU/IG10a19wb3J0X2NoX2VuYWJsZSgpIGFscmVhZHkNCj4gcmVt
b3ZlcyBpdCBmcm9tIHBvcnQtPnR4X210dToNCj4NCj4gICAgIHBvcnQtPnR4X210dSA9IHRyYl9v
cGVuX3ByaXYtPnR4X210dSAtIE1US19DQ0NJX0hfRUxFTjsNCj4NCj4gbXRrX3BvcnQuaCBkb2N1
bWVudHMgTVRLX0NDQ0lfSF9FTEVOIGFzOg0KPg0KPiAvKiBjY2NpIGhlYWRlciBsZW5ndGggKyBy
ZXNlcnZlZCBzcGFjZSB0aGF0IGlzIHVzZWQgaW4gZXhjZXB0aW9uIGZsb3cgKi8NCj4gI2RlZmlu
ZSBNVEtfQ0NDSV9IX0VMRU4JCSgxMjgpDQo+DQo+IFNvIHBvcnQtPnR4X210dSBhbHJlYWR5IGxv
b2tzIGxpa2UgdGhlIHBheWxvYWQgYnVkZ2V0LiBUaGlzIGNvZGUgYW5kDQo+IGNhcHMuZnJhZ19s
ZW4gaW4gbXRrX3BvcnRfd3dhbl9lbmFibGUoKSBib3RoIHN1YnRyYWN0DQo+IHNpemVvZihzdHJ1
Y3QgbXRrX2NjY2lfaGVhZGVyKSBhIHNlY29uZCB0aW1lLiBFYWNoIHBhY2tldCB0aGVuIGNhcnJp
ZXMNCj4gMTYgYnl0ZXMgbGVzcyBwYXlsb2FkOiB3aXRoIFFfTVRVXzNfNUssIGZyYWdfbGVuIGlz
IDM0NDAgaW5zdGVhZCBvZiAzNDU2Lg0KPg0KPiBUaGUgZXJyb3IgaXMgaW4gdGhlIHNhZmUgZGly
ZWN0aW9uLCBzbyBub3RoaW5nIG92ZXJmbG93cy4gU3RpbGwsIHRoaXMNCj4gbWF0aCwgdGhlICJw
YXlsb2FkIGJ1ZGdldCIgY29tbWVudCBpbiBtdGtfcG9ydF93d2FuX2VuYWJsZSgpLCBhbmQgdGhl
DQo+IE1US19DQ0NJX0hfRUxFTiBkZWZpbml0aW9uIGNhbid0IGFsbCBiZSByaWdodC4gV2hpY2gg
bWVhbmluZyBvZg0KPiBwb3J0LT50eF9tdHUgaXMgaW50ZW5kZWQ/DQoNCldpbGwgZml4IGluIHYx
MjogcG9ydC0+dHhfbXR1IGlzIHRoZSBwYXlsb2FkIGJ1ZGdldCwgYXMgTVRLX0NDQ0lfSF9FTEVO
DQpzYXlzLiAgVGhlIHdyaXRlIHBhdGggYW5kIGNhcHMuZnJhZ19sZW4gbm93IHVzZSBpdCBkaXJl
Y3RseSBhbmQgYWxsb2NhdGUNCnR4X210dSBwbHVzIHRoZSBoZWFkZXIsIHNvIGEgcGFja2V0IGNh
cnJpZXMgMzQ1NiBieXRlcyBvZiBwYXlsb2FkLiAgT25lDQpjb3JlIGZyYWdtZW50IHN0aWxsIG1h
cHMgdG8gZXhhY3RseSBvbmUgQ0NDSSBwYWNrZXQuDQoNCj4gVGhpcyBpc24ndCBhIGZ1bmN0aW9u
YWwgYnVnLCBidXQgZG9lcyB0aGlzIHBhdGNoIG1ha2UgdGhlIGNvbW1lbnQgb24gZW51bQ0KPiBt
dGtfcG9ydF9zdGF0dXMgaW4gbXRrX3BvcnQuaCBpbmFjY3VyYXRlPw0KPg0KPiAvKiBTdGF0ZSBi
aXRzLCBub3QgbG9ja3M6IGNhbGxlcnMgc2VyaWFsaXNlIC0+ZW5hYmxlKCksIC0+ZGlzYWJsZSgp
IGFuZA0KPiAgKiBvcGVuIG9mIGEgcG9ydC4gIFRoZSBhdG9taWMgYml0b3BzIG9ubHkgbWFrZSBh
IHJlcGVhdGVkIGNhbGwgYSBuby1vcC4NCj4gICovDQo+DQo+IEZvciB0aGUgV1dBTiBwb3J0cywg
b3BlbiBjb21lcyBmcm9tIHVzZXJzcGFjZSB0aHJvdWdoIHRoZSBXV0FOIGNvcmU6DQo+IG10a19w
b3J0X3d3YW5fb3BlbigpIHJ1bnMgdW5kZXIgdGhlIGNvcmUncyBvcHNfbG9jay4gLT5lbmFibGUo
KSBhbmQNCj4gLT5kaXNhYmxlKCkgY29tZSBmcm9tIHRoZSBGU00gdGhyb3VnaCBtdGtfcG9ydF9t
bmdyX2ZzbV9zdGF0ZV9oYW5kbGVyKCkuDQo+IE5vdGhpbmcgc2VyaWFsaXNlcyB0aGUgdHdvIHBh
dGhzLCBhbmQgdGhlIGNvbW1lbnQgYWJvdmUgc2V0X2JpdCgpDQo+IGhlcmUgZXhwZWN0cyBvcGVu
IHRvIHJ1biBhdCB0aGUgc2FtZSB0aW1lIGFzIGVuYWJsZS4NCj4NCj4gVGhlIG9wZW4gdnMuIGVu
YWJsZSBhbmQgb3BlbiB2cy4gZGlzYWJsZSBpbnRlcmxlYXZpbmdzIGxvb2sgc2FmZSBiZWNhdXNl
DQo+IG9mIHRoZSB3X2xvY2sgb3JkZXJpbmcsIGJ1dCB0aGUgaGVhZGVyIGNvbW1lbnQgbm8gbG9u
Z2VyIGRlc2NyaWJlcyBob3cNCj4gdGhpcyB3b3Jrcy4gQ291bGQgaXQgYmUgdXBkYXRlZCBzbyBs
YXRlciBjb2RlIGRvZXNuJ3QgY291bnQgb24gY2FsbGVyDQo+IHNlcmlhbGlzYXRpb24gdGhhdCBk
b2Vzbid0IGV4aXN0Pw0KDQpXaWxsIGZpeCBpbiB2MTI6IHRoZSBjb21tZW50IHdpbGwgc2F5IHRo
YXQgLT5lbmFibGUoKSBhbmQgLT5kaXNhYmxlKCkNCmFyZSBzZXJpYWxpc2VkIGJ5IHRoZWlyIGNh
bGxlcnMsIHdoaWxlIGEgV1dBTiBvcGVuIGNvbWVzIGZyb20gdXNlcnNwYWNlLA0KY2FuIG9ubHkg
cmVhY2ggYSBub2RlIGNyZWF0ZWQgYWZ0ZXIgLT5lbmFibGUoKSwgYW5kIGlzIG9yZGVyZWQgYWdh
aW5zdA0KLT5kaXNhYmxlKCkgYnkgd19wcml2LndfbG9jay4NCg0KLS0NCkphY2s=
