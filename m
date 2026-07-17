Received: from tpecef22.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44604346E44;
	Fri, 17 Jul 2026 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285491; cv=none; b=RbUcsUGUJcC4RPusU2xmuQrKTWiFfAmADW1A+XmL/kiBLwhY3Nb2xbpJk7eLz7OISr/urNwQtZuLhmWDZxusfZSGlwUCDjVLQWzLQyna6Hp6RcE7Qw0fmkgvOvd7ki8889kgDrDX3JI82NCb/8GAB0vbX6iENT2/QHK3rqDFDMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285491; c=relaxed/simple;
	bh=uU5bHw6QdL+gqAzHXNuS6lDwtifMyZRUAEbKOKEfFCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bPUKo1IOCDw4J6daPxvstVhY5lSrl46J6MkwJnZFYZ4nAoiRdRWU2+ghCrZ8dnQxfhQamG04Mi6LeiREPeGqLG6/aZtTT0XWcyRyw+dVrmuU8fEU6jM0kxle8zskH4TzjZTpuL92vEjcsxGpWm667tJ5pOH34oprR6erjL7YMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: 7442b64681cd11f1a87c2323a98e90a4-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:5efaa556-7392-42a5-af63-ac72da932180,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:3e34613f-46cf-453a-bd84-ad9fc7cb0e8c,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7442b64681cd11f1a87c2323a98e90a4-20260717
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef22.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 730774869; Fri, 17 Jul 2026 18:51:24 +0800
X-UUID: 70399bdc81cd11f1a9f9c99e036204b4-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:c5d01180-36c7-402a-a1d5-1d3a56b88a94,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:0134613f-46cf-453a-bd84-ad9fc7cb0e8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 70399bdc81cd11f1a9f9c99e036204b4-20260717
Received: from sdbmbx13.tpe.compalcomm.com [(10.113.2.137)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 1832406038; Fri, 17 Jul 2026 18:51:17 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX13.tpe.compalcomm.com (10.113.2.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 17 Jul 2026 18:51:16 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86%11]) with mapi id
 15.02.2562.043; Fri, 17 Jul 2026 18:51:16 +0800
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
Subject: RE: [External Mail] Re: [PATCH v4 1/7] net: wwan: t9xx: Add PCIe core
Thread-Topic: [External Mail] Re: [PATCH v4 1/7] net: wwan: t9xx: Add PCIe
 core
Thread-Index: AQHdFQZFiPEX/zmaIUK+niZ3qrcX0rZxPs9agABKi5Y=
Date: Fri, 17 Jul 2026 10:51:16 +0000
Message-ID: <cfff2fb84dc645d484fe1e60f620cba1@compal.com>
References: <20260709-t9xx_driver_v1-v4-1-a8c009d509c5@compal.com>,<20260716093324.230974-1-horms@kernel.org>,<93775de437ca4e25bb59b58a3d083dd0@compal.com>
In-Reply-To: <93775de437ca4e25bb59b58a3d083dd0@compal.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30074.006
x-tm-as-result: No-10--32.868500-8.000000
x-tmase-matchedrid: g1iLnnvgj1Muv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZnw0
	UcwaiWo2Fz8NwhmlWx4y7EpJodRIQMz74oElhNRBJfg23t68rFkZ9gzqlDBbLx2wDr7yFIghft2
	1pHZe72NBzOy8r156du8SnEHMQUBzoERNn+xy3FlFg2HO5lmNEODG2avXAfuSZeeyuXQ0wFsLxS
	p/W8v+ZqZC1AUZ/p0YQuAEsf+cTKENiwAwig29knEayD3+TWEcjdkfepRWNj6QEjOZZEyhAvAG4
	01+G+Byuo/gd8czTBCHXkRdBMJ00NMAWA9zBiGN+DE5zr5ahdxcEdBuvobtsHgIpajNPS8ZlUGw
	+UAYZYL0t3wCfeCs89b4MLpnHLxlk/n2htFGWJEKZkLGOW3RZpFEzshsEChHihqn73ZjfGhAJ5F
	gCyzy2iV1whql5+e+GWzxXV20iChzyiI4SZ13uiNpyjdKcD8BdXI+BffqLuQqAWUqxFNxWszGj/
	9t0VYSVBRmJ799oNOMSEHOmpApIiJfg4RijSM8BI7jI1gEwtXWRI6+saz/4V2TMSYoqccgw2moE
	h8ZH/5cAf2s/XIiJ6GFdDiYKYUfIK31UONauatxgLQYav+vFxnz+kO152KHANrl9L1tferEHD2i
	bhLPiGaB4VbTxx2vy422Wgpcw9F6o88ieDyhPTt2PQRPfn+RZb3M9XEdU7dYf8LrTKM9HISQlso
	VbaKro769/SpqAaFDgg0QCJCAhciKZuEdWAD//S/FwffMjBp4n1vSdHLUzhIIN3MAx5f9TvOSXK
	E9MP1gjJAzgl+daSVNJxt7aXvgmwjor1Nh6wuaFLMxELUb2Q==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--32.868500-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30074.006
x-tm-snts-smtp: C15F31829C1DFE4CA2BFFA25A984B42BBC34BCEC38B2BCCA6D66F842A4F057B92000:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU2ltb24sDQoNCkFmdGVyIGZ1cnRoZXIgaW50ZXJuYWwgcmV2aWV3LCB3ZSBhZ3JlZSB0aGlz
IG5lZWRzIHRvIGJlIGZpeGVkLg0KDQpPbiBKYWNrIFd1IHdyb3RlOg0KDQo+PiBbU2V2ZXJpdHk6
IE1lZGl1bV0NCj4+IFdpbGwgdGhpcyBicmVhayBjaGFubmVsIGluZGV4IGNhbGN1bGF0aW9uIG9u
IGJpZy1lbmRpYW4gc3lzdGVtcz8NCj4gVGhpcyBkcml2ZXIgdGFyZ2V0cyBNZWRpYVRlayBUOXh4
IFBDSWUgV1dBTiBtb2RlbXMgb24geDg2L0FSTTY0LUxFDQo+IHBsYXRmb3JtcyBvbmx5LiBPbiBs
aXR0bGUtZW5kaWFuLCBjcHVfdG9fbGUzMigpIGlzIGEgbm8tb3AgYW5kDQo+IExFMzJfVE9fVTMy
KCkgaXMgYSBzaW1wbGUgY2FzdCDigJQgbm8gYnl0ZS1zd2FwIG9jY3Vycy4gVGhlIEtjb25maWcN
Cj4gZW5mb3JjZXMgZGVwZW5kcyBvbiBQQ0kgJiYgQUNQSSwgZWZmZWN0aXZlbHkgcmVzdHJpY3Rp
bmcgdG8gTEUNCj4gcGxhdGZvcm1zIHdoZXJlIHRoaXMgaGFyZHdhcmUgZXhpc3RzLg0KDQpJbiB2
NSB3ZSB3aWxsOg0KLSBSZW1vdmUgTEUzMl9UT19VMzIoY3B1X3RvX2xlMzIoLi4uKSkgYW5kIHJl
dHVybiBod19iaXRzDQogIGRpcmVjdGx5IGluIGJvdGggbXRrX3BjaV9leHRfZDJoX2V2dF9od19i
aXRzKCkgYW5kDQogIG10a19wY2lfZXh0X2gyZF9ldnRfaHdfYml0cygpDQotIFJlbW92ZSB0aGUg
Y3VzdG9tIExFMzJfVE9fVTMyIG1hY3JvDQoNClRoYW5rcy4NCg0KDQrlr4Tku7bogIU6IFd1LiBK
YWNrQkIgKEdTTSkNCuWvhOS7tuaXpeacnzogMjAyNuW5tDfmnIgxN+aXpSDkuIvljYggMDI6MjUN
CuaUtuS7tuiAhTogU2ltb24gSG9ybWFuDQrlia/mnKw6IGxvaWMucG91bGFpbkBvc3MucXVhbGNv
bW0uY29tOyByeWF6YW5vdi5zLmFAZ21haWwuY29tOyBqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0
OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdv
b2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IHdlbi16aGkuaHVh
bmdAbWVkaWF0ZWsuY29tOyBzaGktd2VpLnllaEBtZWRpYXRlay5jb207IE1pbmFuby50c2VuZ0Bt
ZWRpYXRlay5jb207ICBtYXR0aGlhcy5iZ2dAZ21haWwuY29tOyBhbmdlbG9naW9hY2NoaW5vLmRl
bHJlZ25vQGNvbGxhYm9yYS5jb207IGNvcmJldEBsd24ubmV0OyBza2hhbkBsaW51eGZvdW5kYXRp
b24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LW1lZGlhdGVr
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmcNCuS4u+aXqDog
UkU6IFtFeHRlcm5hbCBNYWlsXSBSZTogW1BBVENIIHY0IDEvN10gbmV0OiB3d2FuOiB0OXh4OiBB
ZGQgUENJZSBjb3JlDQrCoCAgIA0KSGkgU2ltb24sDQoNCj4gPiArc3RhdGljIGlycXJldHVybl90
IG10a19wY2lfaXJxX21zaXgoaW50IGlycSwgdm9pZCAqZGF0YSkNCj4gPiArew0KPiA+ICvCoMKg
IGlmICh1bmxpa2VseSghaXJxX3N0YXRlKSB8fA0KPiA+ICvCoMKgwqDCoMKgwqAgdW5saWtlbHko
ISgoaXJxX3N0YXRlICYgR0VOTUFTSyhwcml2LT5pcnFfY250IC0gMSwgMCkpICYNCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXJxX2Rlc2MtPm1zaXhfYml0cykpKQ0KPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gSVJRX05PTkU7DQo+DQo+IFtTZXZlcml0eTog
SGlnaF0NCj4gRG9lcyB0aGlzIGxvZ2ljIHNpbGVudGx5IGRyb3AgaGFyZHdhcmUgaW50ZXJydXB0
cyB3aGVuIGZld2VyIHRoYW4gMzINCj4gdmVjdG9ycyBhcmUgYWxsb2NhdGVkPw0KDQpObyBpbnRl
cnJ1cHRzIGFyZSBkcm9wcGVkLiBUaGlzIGlzIHRoZSBNU0ktWCBtZXJnZWQgbW9kZSBkZXNpZ24u
DQpXaGVuIGZld2VyIHZlY3RvcnMgYXJlIGFsbG9jYXRlZCwgbXRrX3BjaV9zZXRfbXNpeF9tZXJn
ZWQoKSBjb25maWd1cmVzDQp0aGUgaGFyZHdhcmUgdG8gbWVyZ2UgYWxsIGludGVycnVwdCBzb3Vy
Y2VzIGludG8gdGhlIGF2YWlsYWJsZSB2ZWN0b3JzLg0KDQpGb3IgZXhhbXBsZSwgd2l0aCBpcnFf
Y250PTEsIHRoZSBoYXJkd2FyZSBtYXBzIEFMTCBzb3VyY2VzIChpbmNsdWRpbmcNCk1IQ0NJRiBh
dCBoYXJkd2FyZSBiaXQgMjgpIHRvIHZlY3RvciAwLiBUaGUgTVNJLVggc3RhdHVzIHJlZ2lzdGVy
DQpzaG93cyBCSVQoMCksIG5vdCBCSVQoMjgpLiBTbyBpcnFfZGVzY1swXS5tc2l4X2JpdHMgPSBC
SVQoMCksIGFuZA0KR0VOTUFTSygwLDApICYgQklUKDApICYgQklUKDApID0gMSDigJQgdGhlIGNo
ZWNrIHBhc3NlcyBjb3JyZWN0bHkuDQoNClRoZSBHRU5NQVNLIGZpbHRlcnMgdG8gYWxsb2NhdGVk
IHZlY3RvciBiaXRzIG9ubHksIHRoZW4gY2hlY2tzIGlmIHRoZQ0KY3VycmVudCBoYW5kbGVyJ3Mg
dmVjdG9yIGlzIHNldC4gVGhpcyB3b3JrcyBmb3IgYm90aCBmdWxsIGFsbG9jYXRpb24NCigzMiB2
ZWN0b3JzLCAxOjEgbWFwcGluZykgYW5kIG1lcmdlZCBtb2RlIChmZXdlciB2ZWN0b3JzLCBOOjEg
bWFwcGluZykuDQoNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gcGNpX3JlcXVlc3Rf
aXJxKHBkZXYsIGksIG10a19wY2lfaXJxX21zaXgsIE5VTEwsDQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmlycV9k
ZXNjW2ldLCBpcnFfZGVzY1tpXS5uYW1lKTsNCj4NCj4gW1NldmVyaXR5OiBNZWRpdW1dDQo+IENv
dWxkIHRoaXMgdHJpZ2dlciBhIC1XZm9ybWF0LXNlY3VyaXR5IGNvbXBpbGVyIHdhcm5pbmc/DQoN
CldlIHdpbGwgY2hhbmdlIHRvIHBjaV9yZXF1ZXN0X2lycSguLi4sICIlcyIsDQppcnFfZGVzY1tp
XS5uYW1lKSB0byBhdm9pZCBmb3JtYXQgc3RyaW5nIGlzc3Vlcy4NCg0KPiA+ICvCoMKgIGh3X2Jp
dHMgPSBtdGtfcGNpX2V4dF9oMmRfZXZ0X2h3X2JpdHMoY2gpOw0KPiA+ICvCoMKgIG10a19wY2lf
d3JpdGUzMihtZGV2LCByY19iYXNlICsgTUhDQ0lGX1JDMkVQX1NXX1RDSE5VTSwNCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZmcyhod19iaXRzKSAtIDEpOw0KPg0K
PiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gV2lsbCB0aGlzIGJyZWFrIGNoYW5uZWwgaW5kZXggY2Fs
Y3VsYXRpb24gb24gYmlnLWVuZGlhbiBzeXN0ZW1zPw0KDQpUaGlzIGRyaXZlciB0YXJnZXRzIE1l
ZGlhVGVrIFQ5eHggUENJZSBXV0FOIG1vZGVtcyBvbiB4ODYvQVJNNjQtTEUNCnBsYXRmb3JtcyBv
bmx5LiBPbiBsaXR0bGUtZW5kaWFuLCBjcHVfdG9fbGUzMigpIGlzIGEgbm8tb3AgYW5kDQpMRTMy
X1RPX1UzMigpIGlzIGEgc2ltcGxlIGNhc3Qg4oCUIG5vIGJ5dGUtc3dhcCBvY2N1cnMuIFRoZSBL
Y29uZmlnDQplbmZvcmNlcyBkZXBlbmRzIG9uIFBDSSAmJiBBQ1BJLCBlZmZlY3RpdmVseSByZXN0
cmljdGluZyB0byBMRQ0KcGxhdGZvcm1zIHdoZXJlIHRoaXMgaGFyZHdhcmUgZXhpc3RzLg0KDQo+
IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBXaGF0IGhhcHBlbnMgaWYgdGhlIGRyaXZlciBhdHRlbXB0
cyB0byBzZW5kIGFuIHVubWFwcGVkIGNoYW5uZWw/DQoNCkFsbCBjYWxsZXJzIG9mIG10a19wY2lf
c2VuZF9leHRfZXZ0KCkgcGFzcyBrbm93bi12YWxpZCBjaGFubmVsIHZhbHVlcw0KdGhhdCBhcmUg
bWFwcGVkIGluIFNFVF9IV19CSVRTLiBUaGUgaXNfcG93ZXJfb2ZfMihjaCkgY2hlY2sgYXQgdGhl
DQp0b3Agb2YgdGhlIGZ1bmN0aW9uIHJlamVjdHMgaW52YWxpZCBpbnB1dC4gVGhlIEZTTSBzaW5n
bGUtdGhyZWFkDQpkZXNpZ24gZW5zdXJlcyBhbGwgZXh0X2V2dCBzZW5kcyBnbyB0aHJvdWdoIGEg
Y29udHJvbGxlZCBwYXRoLCBzbw0KYW4gdW5tYXBwZWQgY2hhbm5lbCBjYW5ub3QgcmVhY2ggZmZz
KCkuDQoNCj4gPiArwqDCoCBwcml2LT5leHRfcmVnX2Jhc2UgPSBwcml2LT5iYXIyM19hZGRyIC0g
QVRSX1BDSUVfUkVHX1RSU0xfQUREUjsNCj4NCj4gW1NldmVyaXR5OiBNZWRpdW1dDQo+IElzIGl0
IHNhZmUgdG8gc3RvcmUgYW4gb3V0LW9mLWJvdW5kcyBwb2ludGVyPw0KDQpUaGlzIGlzIGEgc3Rh
bmRhcmQgcGF0dGVybiBpbiBQQ0llIE1NSU8gZHJpdmVycyB1c2luZyBBZGRyZXNzDQpUcmFuc2xh
dGlvbiBSZWdpc3RlcnMgKEFUUikuIFRoZSBtb2RlbSdzIGludGVybmFsIHJlZ2lzdGVyIHNwYWNl
DQpzdGFydHMgYXQgYWRkcmVzcyAweDAgaW4gaXRzIG93biB2aWV3LCBidXQgdGhlIGhvc3QgYWNj
ZXNzZXMgaXQNCnRocm91Z2ggQkFSMi8zIG1hcHBlZCBhdCBvZmZzZXQgQVRSX1BDSUVfUkVHX1RS
U0xfQUREUiAoMHgxMDAwMDAwMCkuDQoNClByZS1jb21wdXRpbmcgZXh0X3JlZ19iYXNlID0gYmFy
MjNfYWRkciAtIDB4MTAwMDAwMDAgYWxsb3dzIHVzaW5nDQptb2RlbSByZWdpc3RlciBhZGRyZXNz
ZXMgZGlyZWN0bHk6IGlvcmVhZDMyKGV4dF9yZWdfYmFzZSArIHJlZ19hZGRyKS4NCmV4dF9yZWdf
YmFzZSBpcyB0eXBlZCBhcyB2b2lkIF9faW9tZW0gKiwgYW4gb3BhcXVlIGNvb2tpZSBmb3IgTU1J
Tw0KYWNjZXNzIOKAlCBuZXZlciBkZXJlZmVyZW5jZWQgYXMgYSByZWd1bGFyIHBvaW50ZXIuIFRo
ZSBpb3JlYWQzMi8NCmlvd3JpdGUzMiBmdW5jdGlvbnMgcGVyZm9ybSBwbGF0Zm9ybS1zcGVjaWZp
YyBNTUlPIGFjY2VzcyBvbiBpdC4NClVCU0FOIGRvZXMgbm90IGZsYWcgX19pb21lbSBhcml0aG1l
dGljLiBUaGlzIHNhbWUgcGF0dGVybiBpcyB1c2VkDQpieSBvdGhlciBrZXJuZWwgUENJZSBkcml2
ZXJzIChlLmcuLCBtdGtfdDd4eCkuDQoNCj4gPiArc3RhdGljIHZvaWQgbXRrX3BjaV9yZW1vdmUo
c3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+ID4gK3sNCj4gPiArwqDCoCBpZiAobXRrX3BjaV9wbGRy
KG1kZXYpKSB7IC4uLiB9DQo+ID4gK8KgwqAgcGNpX2NsZWFyX21hc3RlcihwZGV2KTsNCj4gPiAr
wqDCoCBtdGtfcGNpX2ZyZWVfaXJxKG1kZXYpOw0KPiA+ICvCoMKgIG10a19taGNjaWZfZXhpdCht
ZGV2KTsNCj4NCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBEb2VzIHRoaXMgc2VxdWVuY2UgcmVzdWx0
IGluIHRoZSBkZXZpY2UgYmVpbmcgcG93ZXJlZCBvZmYgYmVmb3JlDQo+IHRoZSBPUyBpbnRlcnJ1
cHQgaGFuZGxlcnMgYW5kIHdvcmtxdWV1ZXMgYXJlIHN5bmNocm9uaXplZD8NCg0KVGhlIGRldmlj
ZSBpcyBub3QgbGVmdCBwb3dlcmVkIG9mZi4gbXRrX3BjaV9wbGRyKCkgY2FsbHMgQUNQSQ0KUFhQ
Ll9PRkYgdGhlbiBQWFAuX09OIOKAlCB0aGUgX09OIGNhbGwgcmVzdG9yZXMgcG93ZXIgYW5kIGJy
aW5ncw0KdGhlIFBDSWUgbGluayBiYWNrIHVwLiBBZnRlciBfT04gcmV0dXJucywgdGhlIGRldmlj
ZSBpcyBwb3dlcmVkDQpvbiBhbmQgQkFScyBhcmUgYWNjZXNzaWJsZS4NCg0KVGhlIFBMRFIgc2Vx
dWVuY2UgaXM6ICgxKSBfT0ZGOiBwb3dlci1jeWNsZSBtb2RlbSBmaXJtd2FyZSwNCigyKSBtc2xl
ZXAgZm9yIHBvd2VyIGRyYWluLCAoMykgX09OOiByZXN0b3JlIHBvd2VyIGFuZCBsaW5rLg0KQWZ0
ZXIgc3RlcCAzLCB0aGUgZGV2aWNlIGlzIGxpdmUgd2l0aCBhIGZyZXNoIGZpcm13YXJlIHN0YXRl
Lg0KDQpBZGRpdGlvbmFsbHksIGJlZm9yZSBQTERSLCBtdGtfcGNpX21hc2tfaXJxKCkgZGlzYWJs
ZXMgdGhlIE1IQ0NJRg0KaW50ZXJydXB0IGF0IGhhcmR3YXJlIGxldmVsLCBwcmV2ZW50aW5nIG5l
dyBpbnRlcnJ1cHRzLiBCZXR3ZWVuDQpwY2lfY2xlYXJfbWFzdGVyIGFuZCBtdGtfcGNpX2ZyZWVf
aXJxLCBtdGtfcGNpX2Rldl9leGl0KCkgdGVhcnMNCmRvd24gRlNNIGFuZCB0cmFuc19jdHJsLCBl
bnN1cmluZyBubyB3b3JrcXVldWVzIHJlbWFpbiBzY2hlZHVsZWQuDQoNCj4gPiArwqDCoCAvKiBS
ZXF1ZXN0IGEgc2xvdCByZXNldC4gKi8NCj4gPiArwqDCoCByZXR1cm4gUENJX0VSU19SRVNVTFRf
Q0FOX1JFQ09WRVI7DQo+DQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBXaWxsIHJldHVybmluZyBQ
Q0lfRVJTX1JFU1VMVF9DQU5fUkVDT1ZFUiBhY3R1YWxseSBhYm9ydCB0aGUgc2xvdA0KPiByZXNl
dD8NCg0KV2Ugd2lsbCBjaGFuZ2UgdG8gUENJX0VSU19SRVNVTFRfRElTQ09OTkVDVCBhbmQgdXBk
YXRlDQp0aGUgY29tbWVudCwgc2luY2UgdGhlIGRyaXZlciBkb2VzIG5vdCBjdXJyZW50bHkgc3Vw
cG9ydCBBRVINCnJlY292ZXJ5Lg0KDQpUaGFua3MuDQoNCkphY2sgV3UNCsKgwqDCoCAgICAg
