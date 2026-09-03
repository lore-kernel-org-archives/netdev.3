Received: from mail.sprinte.eu (mail.sprinte.eu [141.95.128.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1403E172D
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.128.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788419048; cv=none; b=Q/9NGWyCJlubUIexxDTdPnsYOR34CNhx5QV4fXLg/PAmwCDJSxKhcU7vFZcxeKwAnz7P7YEK5L8HkUr9FZ0xhWtaXALrsrUUAZZLhzu74crVWTeootB2bBk/ahwTqPEPw1MYi3hOzapHtOy4S018+V4AsrFR+dvMJ6IKupus8ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788419048; c=relaxed/simple;
	bh=xqjAoXt2lTsRy+bQ1sY7doKpnxd44IvGBF84TBA2JJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HGTa8jUgD4Po23+hQsyc6hDkpzWhQRGvym5q7N0JSRBvJhKh3MlHm/521dxqY/Tn+CfdjOCioP/ekwyN6ircKkU0niKAZ2w9jFRWiK07KONNlGOZ/Adgmj9iLTw5Qqk4wwJuQ+D+yLFFNDcxpcryse0Wiz+7bDM5V9IMXs4TEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sprinte.eu; spf=pass smtp.mailfrom=sprinte.eu; dkim=pass (2048-bit key) header.d=sprinte.eu header.i=@sprinte.eu header.b=VLDQvSfw; arc=none smtp.client-ip=141.95.128.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sprinte.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sprinte.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sprinte.eu header.i=@sprinte.eu header.b="VLDQvSfw"
Received: from S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) by
 S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 09:04:00 +0200
Received: from S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0]) by
 S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0%6]) with mapi id
 15.02.2562.046; Thu, 3 Sep 2026 09:04:00 +0200
From: Julien Blanc <julien.blanc@sprinte.eu>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>
Subject: Re: [PATCH] Add config phase for dp83td510e phy
Thread-Topic: [PATCH] Add config phase for dp83td510e phy
Thread-Index: AQHdOvMgJh/Gn4788kyuSNBmULO8iba7VtAAgAD2i4A=
Date: Thu, 3 Sep 2026 07:04:00 +0000
Message-ID: <9571fa4681aed864a305b29a5ebbb05a02966167.camel@sprinte.eu>
References: <0d5badda1670a578b18fae293d8cdd7e57d4d01a.camel@sprinte.eu>
	 <9ddbcd2d-297f-4159-9290-fd87b7fccbfb@lunn.ch>
In-Reply-To: <9ddbcd2d-297f-4159-9290-fd87b7fccbfb@lunn.ch>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <F710F7A0DF2F34449BEE250272C10BEB@EX793143.lan>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; d=sprinte.eu; s=ovhex803668-selector1;
 c=relaxed/relaxed; t=1788419040; h=from:to:subject:date;
 bh=xqjAoXt2lTsRy+bQ1sY7doKpnxd44IvGBF84TBA2JJI=;
 b=VLDQvSfwRdYlM5N4fOUy9aQXXkePUaX5u9arVLJtTGlfBRezmhMS6SVuREDAMmhLcC+XyzxOu/4WHhdnJlui763ruMy9m3dWi+QWAjzGlz2JiBQoU4HKYazlwEVmyr05KXCg79gxyXMCibliTHdcmBra95AN/sodr1M3ZkG5ygzsoKxIFF3EavRpDVmmEY00Id2Tl3LN6s8UDtOI9yMZPC4W7Rlb1ylqM14sLOdOMzsPHyWr5ZAv1syPceqtEPllOzhemV/k0xkRqOihP01GwpaLVBR/LGIQLsEyiRUB5kW9dz+EA81FDS4RC9VHHQydjC2H+NN4oHQzzqmgz2ORUA==

TGUgbWVyY3JlZGkgMDIgc2VwdGVtYnJlIDIwMjYgw6AgMTg6MjEgKzAyMDAsIEFuZHJldyBMdW5u
IGEgw6ljcml0wqA6DQo+IE9uIFdlZCwgU2VwIDAyLCAyMDI2IGF0IDAzOjUyOjU4UE0gKzAwMDAs
IEp1bGllbiBCbGFuYyB3cm90ZToNCj4gPiBBZGQgYSBjb25maWcgcGhhc2UgZm9yIHRoZSBUZXhh
cyBJbnN0cnVtZW50cyBEUDgzVEQ1MTBFIGV0aGVuZXQgUEhZDQo+ID4gDQo+ID4gVGhlIGNvbmZp
ZyBwaGFzZSBjdXJyZW50bHkgc2V0cyB0aGUgZm9sbG93aW5nIHByb3BlcnRpZXMgZnJvbSB0aGUN
Cj4gPiBkZXZpY2UgdHJlZToNCj4gPiDCoCAqIFJNSUkgLyBSR01JSSBtb2RlIChub3RlIDogUk1J
SSBtYXN0ZXIgLyBzbGF2ZSBjYW4gb25seSBiZSBzZXQNCj4gPiDCoMKgwqAgYnkgc3RyYXBzIGFu
ZCBjYW5ub3QgYmUgY2hhbmdlZCBhdCBydW50aW1lIG9uIHRoaXMgcGh5KQ0KPiA+IMKgICogUkdN
SUkgZGVsYXlzLiBUaGVzZSBkZWxheXMgY2FuIGJlIGVuYWJsZWQgb24gdGhlIHBoeSBzaWRlLCBv
bmx5DQo+ID4gwqDCoMKgIGFzIGEgYm9vbGVhbi4gRGVsYXlzIGFyZSBlbmFibGVkIGlmIHBoeS1t
b2RlIGlzIHJnbWlpLWlkLCBvcg0KPiA+IMKgwqDCoCByZ21paS1bcnh8dHhdaWQgd2hpY2ggZW5h
YmxlcyBvbmx5IHRoZSBjb3JyZXNwb25kaW5nIGRlbGF5Lg0KPiANCj4gPiArc3RhdGljIGludCBk
cDgzdGQ1MTBfY29uZmlnX2luaXQoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCj4gPiArew0K
PiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJnBoeWRldi0+bWRpby5kZXY7DQo+ID4gKwlpbnQg
cmdtaWlfZGVsYXkgPSAwOw0KPiA+ICsJczMyIHJ4X2ludF9kZWxheTsNCj4gPiArCXMzMiB0eF9p
bnRfZGVsYXk7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCWlmIChwaHlfaW50ZXJmYWNl
X2lzX3JnbWlpKHBoeWRldikpIHsNCj4gPiArCQlyeF9pbnRfZGVsYXkgPSBwaHlfZ2V0X2ludGVy
bmFsX2RlbGF5KHBoeWRldiwgZGV2LCBOVUxMLCAwLA0KPiA+ICsJCQkJCQnCoMKgwqDCoMKgIHRy
dWUpOw0KPiA+ICsNCj4gDQo+IElmIGRlbGF5cyBhcmUgc2ltcGxlIG9uL29mZiwgeW91IGRvbid0
IG5lZWQgdGhpcy4gRG8gc29tZXRoaW5nIG1vcmUNCj4gbGlrZSBteGw4NjExMF9jb25maWdfcmdt
aWlfZGVsYXkoKSB3aGljaCBqdXN0IGxvb2sgYXQNCj4gcGh5ZGV2LT5pbnRlcmZhY2UuDQoNClRo
YW5rcyBmb3IgeW91ciBmZWVkYmFjay4NCg0KSSdsbCB0cnVzdCB5b3Ugb24gdGhpcyBhbmQgc2Vu
ZCBhIHYyLCBidXQgdGhpcyAocGh5X2dldF9pbnRlcm5hbF9kZWxheSkNCmlzwqBhY3R1YWxseSBo
b3cgaXQgaXMgZG9uZSBpbiB0aGUgZHA4MzgyMiBkcml2ZXIgd2hpY2ggaSB0b29rIGFzIHRoZSBi
YXNlDQpmb3LCoHRoZXNlIGNoYW5nZXMuIFNob3VsZCB0aGlzIGJlIGNoYW5nZWQgdGhlcmUgYXMg
d2VsbD8NCg0KUmVnYXJkcywNCg0KSnVsaWVuDQo=
