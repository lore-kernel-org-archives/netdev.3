Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564ED34B66F;
	Fri, 17 Jul 2026 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286161; cv=none; b=KVqNaDOp1/1PgqIxI8MZouLENjAT0vubSS54rVJv6eyh9vWYPc6Y0d39Ow6RuR+niLDWUg8QqeCExBw8UtVFWho/OmHQEJ8TyprU3guFpN5pkRTB7kBz13eLjD/04wD7xSBjEnmVVX3BEtZpJUEIso0dWLb6pvsasJHbr/KZpB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286161; c=relaxed/simple;
	bh=mBBc8/lv7ph7coB1xS4ADIWd930ymdFgmRJa/Bi/MZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bqb+1wVgwLizSEE8CaAyGn0riTSTUHorJH7Xl4+jWxl7Kpvh/ai6kP9tXDnR76EyMuHrUTcf/e7VvZFnYFsYDWElIl6bzDqTjxTCrCaLLatOceq1jhqfdsYeOmLFq2Q+7mQ0wv9A7Fs+b8wLhHAC4wblDcy4plJG7x5uh7DbRP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: fd0362ea81ce11f1b2470fb4f881575f-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:61a23bba-cce7-4795-9dd9-7675b90e8d43,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:750c3d19-ab14-4403-9336-76696324c5a8,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fd0362ea81ce11f1b2470fb4f881575f-20260717
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1954777916; Fri, 17 Jul 2026 19:02:23 +0800
X-UUID: f9923c8a81ce11f1b328fd8a884f4420-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:7215ff62-c96b-4b85-98c8-feeadfe71d4c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:26daf88c-879e-4a06-a1b9-fbfe288700dc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f9923c8a81ce11f1b328fd8a884f4420-20260717
Received: from sdbmbx12.tpe.compalcomm.com [(10.113.2.136)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES256-SHA 256/256)
	with ESMTP id 953992257; Fri, 17 Jul 2026 19:02:17 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX12.tpe.compalcomm.com (10.113.2.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.43;
 Fri, 17 Jul 2026 19:02:16 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86%11]) with mapi id
 15.02.2562.043; Fri, 17 Jul 2026 19:02:16 +0800
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
Subject: RE: [External Mail] Re: [PATCH v4 5/7] net: wwan: t9xx: Add FSM
 thread
Thread-Topic: [External Mail] Re: [PATCH v4 5/7] net: wwan: t9xx: Add FSM
 thread
Thread-Index: AQHdFQZYY6Au0ymBcU6QRccOSxUFeLZxT48kgAA9QiQ=
Date: Fri, 17 Jul 2026 11:02:16 +0000
Message-ID: <b9b53e70a87648acb527a70f389ef823@compal.com>
References: <20260709-t9xx_driver_v1-v4-5-a8c009d509c5@compal.com>,<20260716093422.231112-1-horms@kernel.org>,<cbd2ef0bba8e46efb19f692a2e114149@compal.com>
In-Reply-To: <cbd2ef0bba8e46efb19f692a2e114149@compal.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30074.006
x-tm-as-result: No-10--20.244000-8.000000
x-tmase-matchedrid: QYUnrClngWYuv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZpNz
	D6YMRvgW4TxIMIx6VwqygWex5mZjoExpKNdX3ZAHGG92L3YEEC7+i5C4lXMwGvAGAj5s+iPSYts
	GA1MBOo6tyHv92W7bO/ranYAb1hBlhIOMOnfndO/XIza/NEqjlZbTt2Vz36FFojKyNVmXOruKzg
	hR2FMRuezIXYsPq2gCadWHkyQPE4zW2NgQcJOQ2p4p07KVSE/ZRXCUrhCu5WMcO9g0wIXVO78bu
	2KvjRzVoJaYJ5BrgQI9DuOzNhKgnvFDN+Mc76F7iu6u4shZ+fGFCkPhi2xezb2L79/20sYbNlHN
	CjMfVpFDElVyrzDzfhsu3/K0JNREbcSnmXCS46CRj0jujuSQmqODSWu0oxbKa1P8Ik1zBcXCWXL
	d4w2EwNvIAMT/07OiB73xunbyKrpX9HM7P8GE6Q==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--20.244000-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30074.006
x-tm-snts-smtp: 01F419E205422152DBCFDDCFF3421F264753989CA777A35C1E9D23CBE5D181DD2000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU2ltb24sDQoNCkFmdGVyIGZ1cnRoZXIgaW50ZXJuYWwgcmV2aWV3LCB3ZSBhcmUgY29ycmVj
dGluZyBzZXZlcmFsDQpyZXNwb25zZXMgZnJvbSBvdXIgcHJldmlvdXMgcmVwbHkuIFRoZSBmb2xs
b3dpbmcgaXRlbXMgd2lsbA0KYmUgZml4ZWQgaW4gdjUuDQoNCk9uIEphY2sgV3Ugd3JvdGU6DQoN
Cj4+IFtTZXZlcml0eTogSGlnaF0NCj4+IEluZmluaXRlIGJ1c3kgbG9vcCBvbiBzaWduYWwgcGVu
ZGluZy4NCg0KPiBUaGlzIGlzIGludGVudGlvbmFsLiBDaGFubmVsIGRpc2FibGUgbXVzdCBjb21w
bGV0ZSBvciB0aW1lb3V0Lg0KPiBUaGUgbG9vcCBkb2VzIG5vdCBidXN5LXNwaW46IGVhY2ggaXRl
cmF0aW9uIHNsZWVwcyBpbg0KPiB3YWl0X2V2ZW50X2ludGVycnVwdGlibGVfdGltZW91dCB1bnRp
bCB0aGUgY29uZGl0aW9uIGlzIG1ldCBvcg0KPiB0aGUgdGltZW91dCBleHBpcmVzLg0KDQpXaWxs
IGNoYW5nZSB3YWl0X2V2ZW50X2ludGVycnVwdGlibGVfdGltZW91dCB0bw0Kd2FpdF9ldmVudF90
aW1lb3V0IGFuZCByZW1vdmUgdGhlIC1FUkVTVEFSVFNZUyAvIGdvdG8NCnN0YXJ0X3dhaXQgYmxv
Y2suDQoNCj4+IFtTZXZlcml0eTogSGlnaF0NCj4+IFJhY2UgaW4gbXRrX2ZzbV9ldnRfc3VibWl0
IKFYIGZzbV9oYW5kbGVyIE5VTEwgYWZ0ZXIgc3BpbmxvY2sNCj4+IHJlbGVhc2UuDQoNCj4gVGhl
IEdBVEVDTE9TRUQgY2hlY2sgdW5kZXIgZXZ0cV9sb2NrIGVuc3VyZXMgZnNtX2hhbmRsZXIgaXMN
Cj4gdmFsaWQuIEFmdGVyIHRoZSBjaGVjayBwYXNzZXMsIHRoZSBldmVudCBpcyBzdWJtaXR0ZWQg
YW5kIHRoZQ0KPiBrdGhyZWFkIGlzIHdva2VuLg0KDQpXaWxsIG1vdmUgd2FrZV91cF9wcm9jZXNz
IGluc2lkZSBldnRxX2xvY2sgaW4gZXZ0X3N1Ym1pdCwgYW5kDQpoYXZlIG10a19mc21fZXhpdCBj
bGVhciBmc21faGFuZGxlciB1bmRlciBldnRxX2xvY2s6DQoNCiAgZXZ0X3N1Ym1pdDoNCiAgICB3
YWtlX3VwX3Byb2Nlc3MoZnNtLT5mc21faGFuZGxlcik7DQogICAgc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmZnNtLT5ldnRxX2xvY2ssIGZsYWdzKTsNCg0KICBtdGtfZnNtX2V4aXQ6DQogICAgc3Bp
bl9sb2NrX2lycXNhdmUoJmZzbS0+ZXZ0cV9sb2NrLCBmbGFncyk7DQogICAgaGFuZGxlciA9IGZz
bS0+ZnNtX2hhbmRsZXI7DQogICAgZnNtLT5mc21faGFuZGxlciA9IE5VTEw7DQogICAgc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmZnNtLT5ldnRxX2xvY2ssIGZsYWdzKTsNCiAgICBpZiAoaGFuZGxl
cikNCiAgICAgICAga3RocmVhZF9zdG9wKGhhbmRsZXIpOw0KDQo+PiBbU2V2ZXJpdHk6IEhpZ2hd
DQo+PiBydGZ0X2VudHJ5LT5kYXRhIHBhc3NlZCB0byBhY3Rpb24gY2FsbGJhY2sgYmVmb3JlIGRh
dGFfbGVuDQo+PiB2YWxpZGF0aW9uLg0KDQo+IFRoZSBhY3Rpb24gZnVuY3Rpb25zIG9ubHkgcmVh
ZCBmaXhlZC1zaXplIGZpZWxkcy4gVGhlIG1vZGVtDQo+IGZpcm13YXJlIGlzIGEgdHJ1c3RlZCBz
b3VyY2UuDQoNCldpbGwgbW92ZSBkYXRhX2xlbiB2YWxpZGF0aW9uIGJlZm9yZSB0aGUgY2FsbGJh
Y2sgY2FsbCBpbg0KbXRrX2ZzbV9wYXJzZV9oczJfbXNnLCBhbmQgcGFzcyBkYXRhX2xlbiB0byB0
aGUgY2FsbGJhY2suDQoNCj4+IFtTZXZlcml0eTogSGlnaF0NCj4+IFVuaW5pdGlhbGl6ZWQga2Vy
bmVsIGhlYXAgbWVtb3J5IGluIG10a19mc21fc2VuZF9oczNfbXNnLg0KDQo+IFRoZSByZXNlcnZl
ZFsyXSBmaWVsZCBpcyBzZW50IHRvIHRoZSBsb2NhbCBtb2RlbSBvdmVyIFBDSWUgRE1BLA0KPiBu
b3QgZXhwb3NlZCB0byBleHRlcm5hbCBuZXR3b3Jrcy4NCg0KV2lsbCBhZGQgbWVtc2V0KHNrYi0+
ZGF0YSwgMCwgUlRGVF9EQVRBX1NJWkUpIGFmdGVyDQpfX2Rldl9hbGxvY19za2IgaW4gbXRrX2Zz
bV9zZW5kX2hzM19tc2cuDQoNCj4+IFtTZXZlcml0eTogSGlnaF0NCj4+IFNpbGVudCBrY2FsbG9j
IGZhaWx1cmUgaW4gbXRrX3BvcnRfZGlzYWJsZS4NCg0KPiBBbGxvY2F0aW9uIGZhaWx1cmUgaXMg
ZXh0cmVtZWx5IHVubGlrZWx5LiBIYXJkd2FyZSBoYXMgYWxyZWFkeQ0KPiBiZWVuIHBvd2VyLWN5
Y2xlZCB2aWEgUExEUi4NCg0KV2lsbCByZXBsYWNlIHJhZGl4X3RyZWVfZ2FuZ19sb29rdXAgd2l0
aCByYWRpeF90cmVlX2Zvcl9lYWNoX3Nsb3QsDQplbGltaW5hdGluZyB0aGUgdGVtcG9yYXJ5IGFy
cmF5LiBTYW1lIHBhdHRlcm4gYXMNCm10a19wb3J0X3NlYXJjaF9ieV9uYW1lLg0KDQpUaGFua3Mu
DQoNCkphY2sgV3U=
