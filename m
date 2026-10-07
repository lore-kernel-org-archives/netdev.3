Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F8E5B206;
	Wed,  7 Oct 2026 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791358987; cv=none; b=GTbc60LcDe2s0wBygmpZCsfq4j+kZg+g+Zhb8sI5sgezR1w4valiadjh3eScWNIOg1z8LOv13eoQ6i5vgM07tXLRE8/Zi1pwnQVDp1SMhzoFQeubf/0OfAvRoDOjQtnhLOj6s79iWA77KXeFP1GWhKWbcHs4DT8EGz8hD0oEm/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791358987; c=relaxed/simple;
	bh=wqxFuqPylaUS1LXc+FHFuUQaNSePIvD5zwAoA2qmKOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aWJ7GT+KI0zdUjC6CAW2ZSSrYDXcAhiR5R3jiIwYaD3h3G62bbLkYtHcunbMmKlGT0PW5P42/JdIO19CsIe2rDUmC+Pbe05JwskdxfwMQjh7yDVJZhIfo3URMMoeGZwKbJ+lkXDTZQV0c4tmNUiLg1i7p1gd9BHgM6ba1oYkeSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: b76af376c22211f1b2470fb4f881575f-20261007
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:a9e13632-4abf-465c-8623-73c6d3a175e0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:18104dfd-c023-4c3d-8087-71be3f81564e,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b76af376c22211f1b2470fb4f881575f-20261007
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 430474169; Wed, 07 Oct 2026 15:42:58 +0800
X-UUID: b57019d4c22211f1a9f9c99e036204b4-20261007
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:d4ed7548-1c97-47f8-a774-33b185806792,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:db267256-66df-4ed9-ba9a-e32623d07625,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b57019d4c22211f1a9f9c99e036204b4-20261007
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 1315189451; Wed, 07 Oct 2026 15:42:55 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Wed, 7 Oct 2026 15:42:53 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::d3a3:2665:d306:e36a]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::d3a3:2665:d306:e36a%11]) with mapi id
 15.02.2562.043; Wed, 7 Oct 2026 15:42:53 +0800
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
Subject: Re: [PATCH v9 2/6] net: wwan: t9xx: Add control plane transaction
 layer
Thread-Topic: [PATCH v9 2/6] net: wwan: t9xx: Add control plane transaction
 layer
Thread-Index: AQHdVi92CCkXrAbMD0Sm9T9DLl0WdA==
Date: Wed, 7 Oct 2026 07:42:53 +0000
Message-ID: <a742cc87225c4faeb288032b19ee7fe0@compal.com>
References: <20260930-t9xx_driver_v1-v9-2-3248b9256956@compal.com>,<179110515297.434549.13978731531634280399@kernel.org>
In-Reply-To: <179110515297.434549.13978731531634280399@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30242.005
x-tm-as-result: No-10--11.516100-8.000000
x-tmase-matchedrid: TS/yG7dSaeIuv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZuZd
	NI5cmL7EsYqOZUHi5O+REYy4Kg5qG1PMBVDvxMolGG92L3YEEC5lA1b7yNeDy2Q68uvIXW1erf8
	wz4ESzw8mU9XoXRWM6whejRXOq4Wu2SDCYhxkuA8nDrpxCH9HlxvlZxq14kYA8mB4uBzst3zyvS
	e8Im+It52CWWcsc9G2eqHcSQLZw+WTSX0ss3g67VZB3ebKuqDZNIT72OEr+MihLyngtWA7kEN3O
	J0Jv5josaRxslIYMb1VWWiPV6/GV6EW6WHtEhY9CqJ0RbJ3bb1qsngdQNC7B3vXWVrbHZDJWiYJ
	b0MO1BmEizXChXdpjKRl3NoCwksl+f1v71xAsKSmuS2h5T5tPhE+ekmiD9TP8gZH2u1Mu0BT1iZ
	2rzURygkcl33Ur3ZsZ0QO3a9gW7eZBafbv3rGvoWEan0Y08OtN/wwc82rdwQSCDdzAMeX/T9TGs
	4C8xEFcYO7LzLWqS4ibGdC+CRqLVYHXldrySG2zv7Ee4WB+8PZzcYLrduMvDAzk4iHqLcpoJ5CW
	l63ULR02BvmJZL/xA==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--11.516100-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30242.005
x-tm-snts-smtp: 9FA824996A4421DD2595263C526FC5A78337750C22B7152F709394DC17E592A52000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

VGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpPbiBTdW4sIDQgT2N0IDIwMjYgMTc6MTI6MDAgKzA4
MDAgbmV0ZGV2LWJvdCtzYXNoaWtvQGtlcm5lbC5vcmcgd3JvdGU6DQo+IFRoaXMgaXNuJ3QgYSBi
dWcsIGJ1dCBhdCB0aGlzIHBvaW50IGluIHRoZSBzZXJpZXMgbm90aGluZyBjYWxscw0KPiBtdGtf
Y3RybF9pbml0KCkgb3IgbXRrX2N0cmxfZXhpdCgpLiBUaGF0IG1lYW5zOg0KWy4uLl0NCj4gVGhl
IHN1YmplY3Qgc2F5cyAiQWRkIGNvbnRyb2wgcGxhbmUgdHJhbnNhY3Rpb24gbGF5ZXIiLCBidXQg
dGhpcyBwYXRjaA0KPiBvbmx5IGFkZHMgc3RydWN0dXJlcyBhbmQgaGVscGVycyB0aGF0IG5vdGhp
bmcgY2FuIHJlYWNoIHlldC4NClsuLi5dDQo+IENvdWxkIHRoZXNlIGhlbHBlcnMgYW5kIHRoZSBp
bmNsdWRlIG1vdmUgaW50byB0aGUgcGF0Y2ggdGhhdCBhZGRzIHRoZWlyDQo+IGNhbGxlcnM/IE90
aGVyd2lzZSwgY291bGQgdGhlIHN1YmplY3Qgc2F5IHRoYXQgdGhpcyBwYXRjaCBvbmx5IGFkZHMg
dGhlDQo+IHNjYWZmb2xkaW5nPw0KDQpXaWxsIGZpeCBpbiB2MTAsIHRoZSBzZWNvbmQgd2F5OiB0
aGUgc3ViamVjdCBiZWNvbWVzICJuZXQ6IHd3YW46IHQ5eHg6DQpBZGQgY29udHJvbCBwbGFuZSB0
cmFuc2FjdGlvbiBsYXllciBmcmFtZXdvcmsiLCBhbmQgdGhlIGNvbW1pdCBtZXNzYWdlDQpnYWlu
cyBhIGxpbmUgbmFtaW5nIHRoZSBwYXRjaCB3aGVyZSB0aGUgY2FsbGVycyBhcnJpdmUuDQoNClRo
YXQgbGlmdHMgaW50byB0aGUgc3ViamVjdCB3aGF0IHRoZSBtZXNzYWdlIGJvZHkgYWxyZWFkeSBz
YXlzIHRocmVlDQp0aW1lcyAtICJJbnRyb2R1Y2UgdGhlIGNvbnRyb2wgcGxhbmUgYW5kIHRyYW5z
YWN0aW9uIGxheWVyIGZyYW1ld29yayIsDQoiaW5pdGlhbGl6YXRpb24gZW50cnkgcG9pbnRzIHRo
YXQgc3Vic2VxdWVudCBwYXRjaGVzIGJ1aWxkIHVwb24iLCAiVGhlDQphY3R1YWwgRE1BIGVuZ2lu
ZSBhbmQgVFgvUlggc2VydmljZSBpbXBsZW1lbnRhdGlvbnMgYXJlIGFkZGVkIGluDQpzdWJzZXF1
ZW50IHBhdGNoZXMiLiAgSXQgaXMgbm90IGEgbmV3IGNsYWltLCBvbmx5IG9uZSB0aGF0IHdhcyBp
bnZpc2libGUNCnVubGVzcyB5b3UgcmVhZCBwYXN0IHRoZSBzdWJqZWN0IGxpbmUuDQoNCj4gVGhp
cyBpc24ndCBhIGJ1ZywgYnV0IG10a19jdHJsX2luaXQoKSBhbGxvY2F0ZXMgY3RybF9ibGsgd2l0
aA0KPiBkZXZtX2t6YWxsb2MoKSwgYW5kIG10a19jdHJsX2V4aXQoKSBvbmx5IGNsZWFycyBtZGV2
LT5jdHJsX2Jsay4gU3VwcG9zZQ0KPiBpbml0IGFuZCBleGl0IHJhbiBtb3JlIHRoYW4gb25jZSB3
aGlsZSB0aGUgZGV2aWNlIHN0YXllZCBib3VuZC4gRWFjaA0KPiBtdGtfY3RybF9pbml0KCkgY2Fs
bCB3b3VsZCBhZGQgYW5vdGhlciBkZXZyZXMgYWxsb2NhdGlvbiBhbmQgb3ZlcndyaXRlDQo+IG1k
ZXYtPmN0cmxfYmxrIHdpdGhvdXQgZnJlZWluZyB0aGUgb2xkIGJsb2NrLg0KWy4uLl0NCj4gV291
bGQgaXQgaGVscCB0byBhZGQgYSBjb21tZW50IHNheWluZyBtdGtfY3RybF9pbml0KCkgbWF5IG9u
bHkgcnVuIG9uY2UNCj4gcGVyIGJpbmQ/IFRoYXQgd291bGQga2VlcCBhIGZ1dHVyZSByZXNldCBw
YXRoIGZyb20gY2FsbGluZyBpdCBhZ2Fpbi4NCg0KV2lsbCBmaXggaW4gdjEwIHdpdGggdGhlIGNv
bW1lbnQgeW91IHN1Z2dlc3QsIG9uIG10a19jdHJsX2luaXQoKToNCg0KICAgIC8qIE1heSBvbmx5
IHJ1biBvbmNlIHBlciBiaW5kLiAgVGhlIGN0cmxfYmxrIGFsbG9jYXRpb24gaXMgZGV2cmVzDQog
ICAgICogbWFuYWdlZCBhbmQgaXMgcmVsZWFzZWQgYXQgdW5iaW5kLCBub3QgYnkgbXRrX2N0cmxf
ZXhpdCgpLg0KICAgICAqLw0KDQo+IFRoaXMgaXNuJ3QgYSBidWcsIGJ1dCBub3RoaW5nIGFzc2ln
bnMgY3RybF9ibGstPnRyYW5zIGluIHRoaXMgcGF0Y2guDQpbLi4uXQ0KPiBtdGtfY3RybF9wbGFu
ZS5oIGlzIGEgZ2VuZXJpYyBoZWFkZXIsIGJ1dCBpdCBuYW1lcyB0aGUgcGNpZS1vbmx5IHN0cnVj
dA0KPiBtdGtfY3RybF90cmFucy4gSXQgZG9lcyBub3QgaW5jbHVkZSBvciBmb3J3YXJkLWRlY2xh
cmUgdGhlIGhlYWRlciB0aGF0DQo+IGRlZmluZXMgaXQuDQpbLi4uXQ0KPiBDb3VsZCB0aGUgY3Ry
bF9od19wcml2IG1lbWJlciBiZSBhZGRlZCBoZXJlIGRpcmVjdGx5PyBUaGF0IHdvdWxkIGF2b2lk
DQo+IGFkZGluZyBhIHRyYW5zIG1lbWJlciB0aGF0IGlzIHJlbW92ZWQgb25lIHBhdGNoIGxhdGVy
Lg0KDQpXaWxsIGZpeCBpbiB2MTAsIGV4YWN0bHkgdGhhdDogc3RydWN0IG10a19jdHJsX2JsayBp
cyBpbnRyb2R1Y2VkIHdpdGgNCnZvaWQgKmN0cmxfaHdfcHJpdiBpbnN0ZWFkIG9mIHN0cnVjdCBt
dGtfY3RybF90cmFucyAqdHJhbnMuICBUaGUgbWVtYmVyDQppcyB0aGVuIG5vdCByZW5hbWVkIG9u
ZSBwYXRjaCBsYXRlciwgYW5kIHRoZSBnZW5lcmljIGhlYWRlciBzdG9wcyBuYW1pbmcNCmEgUENJ
ZS1vbmx5IHR5cGUsIHdoaWNoIGl0IHNob3VsZCBub3QgaGF2ZSBkb25lLg0KDQoNClRoYW5rcywN
CkphY2s=
