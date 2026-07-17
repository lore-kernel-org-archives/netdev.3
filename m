Received: from tpecef22.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FED29B8E1;
	Fri, 17 Jul 2026 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270292; cv=none; b=cdZz8YeuYukvGQjbpdJ0uuJpW5yPuvjYzhaw97ahNCPGE4035YA51RaVTVzsx/QWIr/DHBtRteq5GImSE/IWLdXD6uFfHzOogR6bclCYBgFgrw5UrPHlpInFY9gbWZgmrDmElQHg21GEnzwc+fhrEZtCoD31I/Nf2D4ynTKeAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270292; c=relaxed/simple;
	bh=kl7gcC8mC75qrnyRkcbYclciYZkpFjaFqaAlZVmo2Wo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dnGrHkiY4ShhjXbgjdmzCdFJjbnAeZ3A4BySRvJSJU2mRzQZf8V4mrqZG7QPaubJ3dMslRMmnL77tNRm7ncneXUoKTfvwTxapeNLOqWWb0cUvzjgMuJgz6OAy5LngrtGDpDMX9N1Ce9EFhUQdJAtCLy0rXUzu3+u/MtAAP1G4lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: 106d4f0a81aa11f1a87c2323a98e90a4-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:5427e692-918e-4c2c-b5a3-ae69e5f6c4f7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:49b83a19-ab14-4403-9336-76696324c5a8,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 106d4f0a81aa11f1a87c2323a98e90a4-20260717
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef22.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 529373144; Fri, 17 Jul 2026 14:38:04 +0800
X-UUID: 0ccdd3b081aa11f1b328fd8a884f4420-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:cf847c4d-0e1b-40cf-9bc4-17834c4b03bb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:15b83a19-ab14-4403-9336-76696324c5a8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0ccdd3b081aa11f1b328fd8a884f4420-20260717
Received: from sdbmbx12.tpe.compalcomm.com [(10.113.2.136)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES256-SHA 256/256)
	with ESMTP id 1930171672; Fri, 17 Jul 2026 14:37:58 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX12.tpe.compalcomm.com (10.113.2.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.43;
 Fri, 17 Jul 2026 14:37:56 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86%11]) with mapi id
 15.02.2562.043; Fri, 17 Jul 2026 14:37:56 +0800
From: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
To: Simon Horman <horms@kernel.org>
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
	<angelogioacchino.delregno@collabora.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [External Mail] Re: [PATCH v4 3/7] net: wwan: t9xx: Add control
 DMA interface
Thread-Topic: [External Mail] Re: [PATCH v4 3/7] net: wwan: t9xx: Add control
 DMA interface
Thread-Index: AQHdFQZPlE9Zcx29j0SOvF2f5GB/ubZxQQT+
Date: Fri, 17 Jul 2026 06:37:56 +0000
Message-ID: <cacde4a05d6a48afbac6425425fe180c@compal.com>
References: <20260709-t9xx_driver_v1-v4-3-a8c009d509c5@compal.com>,<20260716093406.231071-1-horms@kernel.org>
In-Reply-To: <20260716093406.231071-1-horms@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30074.005
x-tm-as-result: No-10--19.498000-8.000000
x-tmase-matchedrid: RjGFKQPDGZ4uv++HU7VXryRFbfQbCufdN0X64jGy2db7+pncqRJfy2XQ
	7TcqkNINf6QJ0tN82r5hsM9nk6RmuCCt9VDjWrmrGG92L3YEEC7+i5C4lXMwGpkRPHajPHqahHb
	hMYBfXh6xz2XsYPh81BEEzqyuEl9gNuOgXP1afqWfYQ5y1W3erOfShpTpYz77clSUqoTBU/Wev5
	1bGmTwSE+bqgpsw/yOgaDFHNp6hieMwUH1wUDkvwX7nj/JfnUbROuHdMXD18WvoPXbGVmT3YOnv
	I7B7t22echm2OmVVwNmylKOva/Q7364btTa6HpceSUw6IG1eISLr3CqRkgz6d1/jxGgLCckhP4Y
	uTInOwQe67A3WrjNy24By4DoaH+mOQ+xYkUwraWdFMmljtUAp28ORWp/jqsKM3/AY2Y0EhMJofc
	xKT8fC3v++hw0sQBEweh0kiv5S9Zp64cBNwqR/N2crNR8miTUdk6/NJBGmFAxlAyRTqolgsB5AU
	+akcqoz9cchQv6t4KLg2ZvOkj4FQolFwG/4NIOqeJZzLE73IUKzfE0xibHNDqwP2FR2FcNW/kQW
	KMp0XNZ6WTmi5uH0lNTC+geWxvL/OEBM+tKlYexBsMJRiOaof2OXvUImtUpkj4YNhB8WcIsWWWp
	k0LupSC05h2UdKv1pteGFrAg7gNcRrJHfP2qnur9vWEotVRyXBY1tWcFPfdt9C8Vn7Sn4a+eCSM
	eOiOkA/lH/MvdoiYmkrgX3CciJmLK5A5md0r9rg4L214qcZ9P8StIwFbkBA==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--19.498000-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30074.005
x-tm-snts-smtp: A676DAC02A9765872735F616CA5ECD64374A98AF1C8CF5B880FAEA3B916E8C502000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU2ltb24sDQoNCj4gPiArc3RhdGljIHZvaWQgbXRrX2NsZG1hX3R4X2RvbmVfd29yayguLi4p
DQo+ID4gKwlpZiAoIXJlcS0+ZGF0YV92bV9hZGRyIHx8IChyZXEtPmdwZC0+dHhfZ3BkLmdwZF9m
bGFncyAmIENMRE1BX0dQRF9GTEFHX0hXTykpDQo+DQo+IFtTZXZlcml0eTogSGlnaF0NCj4gSXMg
YSBkbWFfcm1iKCkgbmVlZGVkIGFmdGVyIGNoZWNraW5nIHRoZSBoYXJkd2FyZSBvd25lcnNoaXAg
ZmxhZz8NCg0KVGhlIEdQRCBkZXNjcmlwdG9ycyBhcmUgYWxsb2NhdGVkIGZyb20gYSBjb2hlcmVu
dCBETUEgcG9vbA0KKGRtYV9wb29sX3phbGxvYyksIHNvIENQVSBjYWNoZSBjb2hlcmVuY3kgaXMg
Z3VhcmFudGVlZCBieSB0aGUgRE1BDQptYXBwaW5nLiBBIGRtYV9ybWIoKSBpcyBub3QgbmVlZGVk
IGJlY2F1c2UgY29oZXJlbnQgbWVtb3J5IGVuc3VyZXMNCnRoZSBDUFUgYWx3YXlzIG9ic2VydmVz
IHRoZSBsYXRlc3QgdmFsdWVzIHdyaXR0ZW4gYnkgdGhlIGRldmljZS4NCg0KQWRkaXRpb25hbGx5
LCB0aGVyZSBpcyBhbiBybWIoKSBiZWZvcmUgdGhpcyBjaGVjayB0aGF0IGVuc3VyZXMgdGhlDQpI
V08gZmxhZyBpcyByZWFkIGJlZm9yZSBhbnkgc3Vic2VxdWVudCBmaWVsZCBhY2Nlc3Nlcy4NCg0K
PiA+ICtzdGF0aWMgdm9pZCBtdGtfY2xkbWFfcnhfZG9uZV93b3JrKC4uLikNCj4gPiArCWlmIChy
ZXEtPmdwZC0+cnhfZ3BkLmdwZF9mbGFncyAmIENMRE1BX0dQRF9GTEFHX0hXTykNCj4gPiArCQli
cmVhazsNCj4gPiArCW10a19jbGRtYV9yeF9za2JfYWRqdXN0KG1kZXYsIHJ4cSwgcmVxKTsNCj4N
Cj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBTaW1pbGFybHksIHdvdWxkIHdlIG5lZWQgYSBkbWFfcm1i
KCkgaGVyZSBiZWZvcmUgYXR0ZW1wdGluZyB0byByZWFkIHRoZQ0KPiByZWNlaXZlIGxlbmd0aCBv
dXQgb2YgdGhlIGRlc2NyaXB0b3IgaW4gbXRrX2NsZG1hX3J4X3NrYl9hZGp1c3Q/DQoNClNhbWUg
cmVhc29uaW5nIGFzIGFib3ZlLiBHUEQgZGVzY3JpcHRvcnMgdXNlIGNvaGVyZW50IERNQSBtZW1v
cnkNCihkbWFfcG9vbF96YWxsb2MpLCBzbyBubyBhZGRpdGlvbmFsIG1lbW9yeSBiYXJyaWVyIGlz
IG5lZWRlZC4NCg0KPiA+ICsJcmV0ID0gbXRrX2NsZG1hX3JlbG9hZF9yeF9za2IobWRldiwgcnhx
LCByZXEpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlnb3RvIG91dDsNCj4NCj4gW1NldmVyaXR5
OiBIaWdoXQ0KPiBJZiBtdGtfY2xkbWFfcmVsb2FkX3J4X3NrYiBmYWlscyBkdWUgdG8gbWVtb3J5
IHByZXNzdXJlLCBpdCBqdW1wcyB0byBvdXQNCj4gd2l0aG91dCBhZHZhbmNpbmcgcnhxLT5mcmVl
X2lkeC4gV2lsbCB0aGlzIGNhdXNlIHRoZSB3b3JrZXIgdG8gcGVybWFuZW50bHkNCj4gc3RhbGwg
dGhlIHF1ZXVlPw0KDQpJZiBtdGtfY2xkbWFfcmVsb2FkX3J4X3NrYigpIGZhaWxzLCB0aGUgY29k
ZSBqdW1wcyB0byAib3V0IiB3aGljaA0KdW5tYXNrcyB0aGUgaW50ZXJydXB0LiBPbiB0aGUgbmV4
dCBoYXJkd2FyZSBpbnRlcnJ1cHQsIHJ4X2RvbmVfd29yaw0KcnVucyBhZ2FpbiBhbmQgcmV0cmll
cyBmcm9tIHRoZSBzYW1lIGZyZWVfaWR4LiBUaGlzIGNyZWF0ZXMgYSByZXRyeQ0KbG9vcCB0aGF0
IGRlcGVuZHMgb24gbWVtb3J5IGJlY29taW5nIGF2YWlsYWJsZS4gVW5kZXIgc3VzdGFpbmVkDQpt
ZW1vcnkgcHJlc3N1cmUgdGhlIFJYIHF1ZXVlIHN0YWxscyBidXQgcmVjb3ZlcnMgb25jZSBtZW1v
cnkgaXMNCmZyZWVkLiBUaGlzIGlzIGFjY2VwdGFibGUgZm9yIGEgY29udHJvbCBwbGFuZSBpbnRl
cmZhY2Ugd2l0aCBzbWFsbCwNCmluZnJlcXVlbnQgbWVzc2FnZXMuDQoNCj4gPiArc3RhdGljIHZv
aWQgbXRrX2NsZG1hX3R4cV9mcmVlKC4uLikNCj4gPiArCWtmcmVlKHJlcS0+YmRfZHNjX3Bvb2wp
Ow0KPiA+ICsJa2ZyZWUodHhxLT5yZXFfcG9vbCk7DQo+ID4gKwlrZnJlZSh0eHEpOw0KPg0KPiBb
U2V2ZXJpdHk6IENyaXRpY2FsXQ0KPiBEb2VzIHRoaXMgaW5jb3JyZWN0bHkgZnJlZSBtZW1vcnkg
bWFuYWdlZCBieSBkZXZyZXM/DQoNCldlIHdpbGwgY29udmVydCBhbGwgZm91ciBmcm9tIGRldm1f
a2NhbGxvYyB0byBrY2FsbG9jIGluIHY1LiBUaGVzZQ0KYXJlIHJ1bnRpbWUtbWFuYWdlZCByZXNv
dXJjZXMgKGFsbG9jYXRlZCBvbiBxdWV1ZSBvcGVuLCBmcmVlZCBvbg0KcXVldWUgY2xvc2UvdGVh
cmRvd24pLCBzbyB0aGV5IHNob3VsZCB1c2Uga2NhbGxvYy9rZnJlZSByYXRoZXINCnRoYW4gZGV2
cmVzLg0KDQo+ID4gK3N0YXRpYyBpbnQgbXRrX2NsZG1hX3JlbG9hZF9yeF9za2IoLi4uKQ0KPiA+
ICsJZGV2X2tmcmVlX3NrYl9hbnkoYmRfZHNjLT5za2IpOw0KPg0KPiBbU2V2ZXJpdHk6IEhpZ2hd
DQo+IENhbiB0aGlzIGxlYWQgdG8gYSBkb3VibGUgZnJlZT8NCg0KV2Ugd2lsbCBhZGQgYmRfZHNj
LT5za2IgPSBOVUxMIGFmdGVyIGRldl9rZnJlZV9za2JfYW55KCkNCmluIHRoZSBlcnJvciBwYXRo
IHRvIHByZXZlbnQgZG91YmxlIGZyZWUgZHVyaW5nIGRyaXZlciB0ZWFyZG93bi4NCg0KPiA+ICtz
dGF0aWMgaW50IG10a19jbGRtYV90eGJ1Zl9zZXQoLi4uKQ0KPiA+ICsJcmVxLT5kYXRhX2RtYV9h
ZGRyID0gZG1hX21hcF9zaW5nbGUobWRldi0+ZGV2LCBza2ItPmRhdGEsDQo+ID4gKwkJCQkJc2ti
LT5sZW4sIERNQV9UT19ERVZJQ0UpOw0KPg0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IERvZXMgdGhp
cyBjb2RlIHNhZmVseSBoYW5kbGUgbm9uLWxpbmVhciBTS0JzPw0KDQpXaGVuIG5yX2JkcyA9PSAw
LCB0aGUgU0tCIGlzIGFsd2F5cyBsaW5lYXIgoVggaXQgaXMgYWxsb2NhdGVkDQppbnRlcm5hbGx5
IHZpYSBfX2Rldl9hbGxvY19za2IoKSB3aXRoIGRhdGEgY29waWVkIHZpYSBza2JfcHV0KCkuDQpU
aGlzIGlzIGEgY29udHJvbCBwbGFuZSBpbnRlcmZhY2Ugd2hlcmUgU0tCcyBhcmUgY29uc3RydWN0
ZWQNCmludGVybmFsbHkgKEFUIGNvbW1hbmRzLCBNQklNIGNvbnRyb2wgbWVzc2FnZXMpLCBub3Qg
cmVjZWl2ZWQNCmZyb20gdGhlIG5ldHdvcmsgc3RhY2suIFBhZ2VkIGZyYWdtZW50cyBhcmUgbmV2
ZXIgdXNlZC4NCg0KV2hlbiBucl9iZHMgPiAwLCBmcmFnbWVudGF0aW9uIHVzZXMgc2tiX3NoaW5m
byhza2IpLT5mcmFnX2xpc3QNCihsaW5rZWQgU0tCcyksIG5vdCBwYWdlZCBmcmFnbWVudHMgKHNr
Yl9zaGluZm8oc2tiKS0+ZnJhZ3MpLg0KDQo+ID4gK3N0YXRpYyBpbnQgbXRrX2NsZG1hX3N1Ym1p
dF90eCguLi4pDQo+ID4gKwlyZXEtPmRhdGFfdm1fYWRkciA9IHNrYi0+ZGF0YTsNCj4gPiArCXdt
YigpOw0KPiA+ICsJcmVxLT5ncGQtPnR4X2dwZC5ncGRfZmxhZ3MgfD0gQ0xETUFfR1BEX0ZMQUdf
SFdPOw0KPg0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IENvdWxkIHRoZXJlIGJlIGEgcmFjZSBjb25k
aXRpb24gaGVyZSB3aXRoIG10a19jbGRtYV90eF9kb25lX3dvcms/DQoNCk5vIHJhY2UgZXhpc3Rz
LiB0eF9kb25lX3dvcmsgY2hlY2tzOg0KICBpZiAoIXJlcS0+ZGF0YV92bV9hZGRyIHx8IChncGRf
ZmxhZ3MgJiBDTERNQV9HUERfRkxBR19IV08pKQ0KICAgICAgYnJlYWs7DQoNCkl0IG9ubHkgcHJv
Y2VlZHMgd2hlbiBkYXRhX3ZtX2FkZHIgaXMgbm9uLU5VTEwgQU5EIEhXTyBpcyBjbGVhcmVkLg0K
SW4gc3VibWl0X3R4LCBkYXRhX3ZtX2FkZHIgaXMgc2V0IGJlZm9yZSBIV08gdmlhIHdtYigpLiBB
ZnRlcg0KZGF0YV92bV9hZGRyIGlzIHNldCBidXQgYmVmb3JlIEhXTywgdHhfZG9uZV93b3JrIHNl
ZXMgSFdPIHN0aWxsDQpzZXQgKGhhcmR3YXJlIGhhc24ndCBjb21wbGV0ZWQgRE1BKSBhbmQgYnJl
YWtzLiBUaGUgcm1iKCkgaW4NCnR4X2RvbmVfd29yayBlbnN1cmVzIEhXTyBpcyByZWFkIGZpcnN0
LiB0eF9kb25lX3dvcmsgb25seQ0KcHJvY2Vzc2VzIHRoaXMgcmVxIGFmdGVyIGhhcmR3YXJlIGNs
ZWFycyBIV08gdXBvbiBETUEgY29tcGxldGlvbi4NCg0KPiA+ICtzdGF0aWMgdm9pZCBtdGtfcGNp
X3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gPiArCXBjaV9jbGVhcl9tYXN0ZXIocGRl
dik7DQo+ID4gKwltdGtfcGNpX2Rldl9leGl0KG1kZXYpOw0KPg0KPiBbU2V2ZXJpdHk6IEhpZ2hd
DQo+IElzIGl0IGludGVuZGVkIHRvIGNhbGwgcGNpX2NsZWFyX21hc3RlciBiZWZvcmUgbXRrX3Bj
aV9kZXZfZXhpdD8NCg0KQmVmb3JlIHRoaXMgcG9pbnQsIG10a19wY2lfcGxkcigpIGhhcyBhbHJl
YWR5IHBvd2VyLWN5Y2xlZCB0aGUNCm1vZGVtIGZpcm13YXJlIHZpYSBBQ1BJIFBYUC5fT0ZGL19P
Ti4gQWZ0ZXIgUExEUiwgdGhlIG1vZGVtIGlzDQppbiBhIGZyZXNoIGJvb3Qgc3RhdGUgd2l0aCBu
byBhY3RpdmUgRE1BLiBUaGUgQ0xETUEgcXVldWVzIGFyZQ0KaWRsZSChWCB0aGVyZSBhcmUgbm8g
cGVuZGluZyBoYXJkd2FyZSBETUEgdHJhbnNhY3Rpb25zLg0KDQpwY2lfY2xlYXJfbWFzdGVyKCkg
ZGlzYWJsZXMgYnVzIG1hc3RlcmluZyBhcyBhIHNhZmV0eSBtZWFzdXJlDQpiZWZvcmUgdGVhcmRv
d24uIFNpbmNlIHRoZSBoYXJkd2FyZSBpcyBhbHJlYWR5IHJlc2V0IGFuZCBpZGxlLA0KdGhpcyBp
cyB0aGUgaW50ZW5kZWQgb3JkZXJpbmcuDQoNCj4gPiArCWVyciA9IG10a19jbGRtYV9zdWJtaXRf
dHgodHJhbnMtPmRldiwgc2tiKTsNCj4gPiArCWlmIChlcnIpIHsNCj4gPiArCQlpZiAoZXJyID09
IC1FQUdBSU4pDQo+ID4gKwkJCXJldHVybjsNCj4NCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBJZiBt
dGtfY2xkbWFfc3VibWl0X3R4IHJldHVybnMgLUVBR0FJTiAuLi4gY291bGQgdGhpcyBjYXVzZSB0
aGUNCj4gbXRrX2N0cmxfdHJiX3RocmVhZCBsb29wIHRvIHNwaW4gY29udGludW91c2x5IHdpdGhv
dXQgc2xlZXBpbmc/DQoNClRoZSAtRUFHQUlOIHBhdGggcmV0dXJucyBmcm9tIG10a19jdHJsX3Ry
Yl9oYW5kbGVyKCkgdG8NCm10a19jdHJsX3RyYl90aHJlYWQoKSwgd2hpY2ggY2FsbHMgd2FpdF9l
dmVudF9pbnRlcnJ1cHRpYmxlKCkuDQpBZnRlciAtRUFHQUlOLCB0aGUgc2tiIHJlbWFpbnMgb24g
dGhlIGxpc3QgKG5vbi1lbXB0eSksIGJ1dCB0aGUNCkNMRE1BIHJpbmcgaXMgZnVsbC4gVGhlIHJp
bmcgZHJhaW5zIGFzIGhhcmR3YXJlIGNvbXBsZXRlcyBETUEsDQp0cmlnZ2VyaW5nIHR4X2RvbmVf
d29yayB3aGljaCBjYWxscyB3YWtlX3VwIG9uIHRoZSB0cmJfd2FpdHEuDQpUaGUga3RocmVhZCBz
bGVlcHMgdW50aWwgaGFyZHdhcmUgY29tcGxldGlvbiB3YWtlcyBpdCChWCBubw0KYnVzeS1zcGlu
IG9jY3Vycy4NCg0KPiA+ICsJd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlKHNydi0+dHJiX3dhaXRx
LA0KPiA+ICsJCQkJIW10a19jdHJsX2Noc19pc19idXN5X29yX2VtcHR5KHNydikgfHwNCj4NCj4g
W1NldmVyaXR5OiBIaWdoXQ0KPiBDYW4gdGhpcyBjYXVzZSBhbiBpbmZpbml0ZSBsb29wIGlmIGEg
c2lnbmFsIGlzIGRlbGl2ZXJlZCB0byB0aGUgdGhyZWFkPw0KDQpLZXJuZWwgdGhyZWFkcyBpbiB0
aGlzIGRyaXZlciBhcmUgbm90IHRhcmdldGVkIGJ5IHVzZXIgc2lnbmFscy4NClRoZSBrdGhyZWFk
X3N0b3AgYW5kIGt0aHJlYWRfc2hvdWxkX3BhcmsgbWVjaGFuaXNtcyBhcmUgdGhlDQpwcmltYXJ5
IGxpZmVjeWNsZSBtYW5hZ2VtZW50LCBhbmQgYm90aCBhcmUgY2hlY2tlZCBpbiB0aGUgd2FpdA0K
Y29uZGl0aW9uLiBUaGlzIHBhdHRlcm4gaXMgY29uc2lzdGVudCB3aXRoIG90aGVyIFdXQU4gZHJp
dmVycw0KKGUuZy4sIHQ3eHgpIGFuZCB3aWRlbHkgdXNlZCBhY3Jvc3MgZHJpdmVycy9uZXQvIHdo
ZXJlDQp3YWl0X2V2ZW50X2ludGVycnVwdGlibGUgaXMgdGhlIHN0YW5kYXJkIGNob2ljZSBmb3Ig
a3RocmVhZA0Kd2FpdCBsb29wcy4NCg0KPiA+ICsJcmFkaXhfdHJlZV9mb3JfZWFjaF9zbG90KHNs
b3QsICZ0cmFucy0+cXVldWVfdGJsLCAmaXRlciwgMCkgew0KPiA+ICsJCXF1ZXVlID0gcmFkaXhf
dHJlZV9kZXJlZl9zbG90KHNsb3QpOw0KPiA+ICsJCXJhZGl4X3RyZWVfZGVsZXRlKCZ0cmFucy0+
cXVldWVfdGJsLCBpdGVyLmluZGV4KTsNCj4NCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBJcyBpdCBz
YWZlIHRvIGl0ZXJhdGUgb3ZlciB0aGUgcmFkaXggdHJlZSBhbmQgY2FsbCByYWRpeF90cmVlX2Rl
bGV0ZQ0KPiB3aXRob3V0IGhvbGRpbmcgcmN1X3JlYWRfbG9jaz8NCg0KVGhpcyBmdW5jdGlvbiBp
cyBvbmx5IGNhbGxlZCBkdXJpbmcgdGVhcmRvd24gYWZ0ZXIgYWxsIHVzZXJzIGhhdmUNCmJlZW4g
c3RvcHBlZCAoRlNNIHNodXRkb3duLCBrdGhyZWFkcyBzdG9wcGVkLCBxdWV1ZXMgZHJhaW5lZCku
DQpUaGVyZSBpcyBubyBjb25jdXJyZW50IGFjY2VzcyB0byB0aGUgcmFkaXggdHJlZSBhdCB0aGlz
IHBvaW50Lg0KDQpUaGUgdHJlZSB3YXMgaW5pdGlhbGl6ZWQgd2l0aCBJTklUX1JBRElYX1RSRUUg
KG5vdCBSQ1UtdGFnZ2VkKSwNCmFuZCB3ZSBhcmUgdGhlIHNvbGUgYWNjZXNzb3IgZHVyaW5nIHRl
YXJkb3duLiBUaGUgY3Vyc29yLWJhc2VkDQppdGVyYXRpb24gaXMgc2FmZSBmb3Igc2luZ2xlLXRo
cmVhZGVkIGRlbGV0aW9uLg0KDQpUaGFua3MuDQoNCkphY2sgV3U=
