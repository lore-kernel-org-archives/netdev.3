Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=59.120.207.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387439;
	b=WQ0SdcaBI4B4YXfi217G9ys43pUoobKHSQTL5jfp196nq8b7Ztf9wxZvGaWDutum2pmg
	 gXav5vXzpJAfVfyFKii6XjyhMw++btqhPrZ/HpjrMJofmBKZtvAzO/MdPvKxDS8psyL+E
	 mh4+fh02xNGQF8goS2Dw2nwR8le8/G8TYewSzomsR26iGY0jWu3qAfJwuCPQ7zYERgddR
	 S5EO+iUpHqz/si65XJYzWdaj5lwlg8atBfImnNhH37munCEo8mjw+3Ox6sWbnYNLdeqik
	 kKRbDQPir2xqcETQFFGQQAFqT9zW9BWQq/IK+P3oam5Qwya2i+LhpeCGGlFFg9VqR6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387439;
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
	bh=COY/HM40OieZxRHVdD14B8UaYjf52O17n+kjfN0vNoE=;
	b=4UfgOpeFSRQBMD3Ts1lpsY8EYYUThDyt0WGOQsKk12F+3no0VPgBtcsC1819+fYPjCj1
	 fRaImHRfgPglHdMta5KYC0A6RDdl/CF8u/Ns+yCUBznD+qrLRazmRiDgaOIBce0TDJzan
	 sNdIMjnHlPikhuoiXsBcjckSKbczhulxApowcotMDHOpLhHNRvMlHUXD96kuy6sQYnuMn
	 q8lr4z6qrr54sHBIOqEGWl7OigAVu8kKZfqpEFRQmi2rBW4xbEjyUgin2athvpIhUcfaM
	 xtO28Ao3ZmEaBPvrU88UVWcjqW4K8nO3p3ByOJ7Vn82AQrVuX+2L590Zt/98U/mrHLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=compal.com;
	spf=pass smtp.mailfrom=compal.com;
	arc=none smtp.remote-ip=59.120.207.196
Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A58D60A260A;
	Wed, 11 Nov 2026 08:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A58D60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: e23b1666ddad11f1b2470fb4f881575f-20261111
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:0e5c8bb1-e6bf-417d-a799-632c63c484fe,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:ef6a2466-4b51-4c95-bb1b-80ac6aad9c96,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e23b1666ddad11f1b2470fb4f881575f-20261111
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1891472827; Wed, 11 Nov 2026 16:57:11 +0800
X-UUID: def3c9b2ddad11f1b328fd8a884f4420-20261111
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:4ca9d4a0-73e1-4482-9966-7b7af6bcf43d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:ad6a2466-4b51-4c95-bb1b-80ac6aad9c96,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: def3c9b2ddad11f1b328fd8a884f4420-20261111
Received: from sdbmbx12.tpe.compalcomm.com [(10.113.2.136)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES256-SHA 256/256)
	with ESMTP id 376261585; Wed, 11 Nov 2026 16:57:06 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX12.tpe.compalcomm.com (10.113.2.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.43;
 Wed, 11 Nov 2026 16:57:02 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::23a8:5ed2:f09e:3abf]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::23a8:5ed2:f09e:3abf%11]) with mapi id
 15.02.2562.056; Wed, 11 Nov 2026 16:57:02 +0800
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
Subject: Re: [PATCH v11 4/6] net: wwan: t9xx: Add control port
Thread-Topic: [PATCH v11 4/6] net: wwan: t9xx: Add control port
Thread-Index: AQHdcbqeNFYPQCFsFEW0oGa9Q/XSkg==
Date: Wed, 11 Nov 2026 08:57:02 +0000
Message-ID: <c75f59d3acd04e80bcc5177ab0cb91e7@compal.com>
References: <20261105-t9xx_driver_v1-v11-4-2084aa512864@compal.com>,<179430863558.994134.1789647998017952188@kernel.org>
In-Reply-To: <179430863558.994134.1789647998017952188@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30312.005
x-tm-as-result: No-10--5.366300-8.000000
x-tmase-matchedrid: 48uEfNr0eYIuv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZuZd
	NI5cmL7EsdzeBfTA9wJtVWnZex/TYhPSDOhTpONbeJchdZcr1K2vfe6AKVPc3l2TMSYoqccgYSz
	1N0dxMDg2VzWm5OeUKzMt3MPGDZic+pQnDG+EsDimuS2h5T5tPs9pbisPwZaMWH/C60yjPRyQQq
	4HXprssj8DAtStwHlEB/hR1o1e6cCKz5NOgQFQV9GUDl6eQSsLUNBFadxXG5Bg8+fyjPxQDS0sh
	G3XYxXCE/UAzoBaCKWp9sJqXS958E1zJ4jtRj8ZnRTJpY7VAKfvzXgPRwNu0NdJXjU/xdoWqyY0
	m0xOzeNrKywmuEvN5yV7GQ7pbsfUk/uFoz3O0h5xDUVAEzJI2HZOvzSQRphQGBfwCnNYme1SjTu
	Rkxwm6v+nhznVeuz8/9Tv9xsxPI/VFY7mQxBUooZq+H6aG2LcdXI+BffqLuTiB58AjhFyECL8O5
	cbM8+6F8m1hqicLmnAxfciwpwPVfC8LZaGtaaJoXieF+7O0ppq7+m/dbgn6yKJRfKX/Y+pd33bU
	9VU4TIDmyMy7NxgFhIIN3MAx5f9TvOSXKE9MP1gjJAzgl+daXIpRBPj43vPO50T9A74HCtjc99K
	Y0Ed8r+76x+oFiflZC/QTLk81fDw7u3sKm9rbOjNL2E20mc2rT2swmCwSJJToWVAPnqV6DhCwOv
	i432w4o1IGixHBF7+EUodeU2QBk+XJYAidKu/3uEfKV2g8rcJ7ceEs2TdsNM1B0UCKafepX+yyq
	xcPsfU6uln4S19ow==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--5.366300-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30312.005
x-tm-snts-smtp: 71273EF3E0C688E67EEE602D5A8EBF0600065F45D139F3CA96E82E2BF730D6512000:8
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

VGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IFNob3VsZCB0aGlzIGFsc28gY2hlY2sgdGhhdCB0
aGUgY2hhbm5lbCBiZWxvbmdzIHRvIHRoZSBxdWV1ZSB0aGUgZnJhbWUNCj4gYXJyaXZlZCBvbj8N
Cj4NCj4gVGhlIGRlc3RpbmF0aW9uIHBvcnQgaXMgdGFrZW4gZnJvbSB0aGUgY2hhbm5lbCBmaWVs
ZCBvZiB0aGUgQ0NDSSBoZWFkZXIsDQo+IGFuZCB0aGUgZGV2aWNlIHdyaXRlcyB0aGF0IGZpZWxk
LiBUaGUgb25seSBjaGVjayBpcyB0aGF0IGl0cyBwZWVyIElEDQo+IG1hdGNoZXMgdGhlIHBlZXIg
b2YgdGhlIHBvcnQgdGhhdCBhcm1lZCB0aGlzIFJYIHF1ZXVlLg0KPg0KPiBMYXRlciBpbiB0aGUg
c2VyaWVzIHRoZSBNRCBwZWVyIGhhcyB0aHJlZSBwb3J0cywgZWFjaCBvbiBpdHMgb3duIHF1ZXVl
Og0KPiBNRENUUkwgb24gQ0xETUExIFJYUTAsIE1CSU0gb24gQ0xETUExIFJYUTIgYW5kIEFUIG9u
IENMRE1BMSBSWFE1LiBJZiBhDQo+IGZyYW1lIGFycml2ZXMgb24gdGhlIE1CSU0gb3IgQVQgcXVl
dWUgY2FycnlpbmcgY2hhbm5lbCBDQ0NJX0NPTlRST0xfUlgsDQo+IGl0IGdvZXMgdG8gdGhlIE1E
Q1RSTCBpbnRlcm5hbCBwb3J0J3MgLT5yZWN2KCkuDQo+DQo+IEVhY2ggcXVldWUgaGFzIGl0cyBv
d24gQ0xETUEgUlggd29yayBpdGVtIG9uIGEgV1FfVU5CT1VORCB3b3JrcXVldWUuIFR3bw0KPiBx
dWV1ZXMnIHdvcmtlcnMgY2FuIHRoZXJlZm9yZSBydW4gbXRrX3BvcnRfY2hlY2tfcnhfc2VxKCks
IHdyaXRlDQo+IHBvcnQtPnJ4X3NlcSBhbmQgY2FsbCAtPnJlY3YoKSBmb3IgdGhlIHNhbWUgcG9y
dCBhdCB0aGUgc2FtZSB0aW1lLiBUaGF0DQo+IGJyZWFrcyB0aGUgcnVsZSBpbiBzdHJ1Y3QgbXRr
X3BvcnQgdGhhdCByeF9zZXEgaXMgd3JpdHRlbiAib25seSBmcm9tIHRoZQ0KPiByeF9kb25lIGNh
bGxiYWNrIG9mIHRoZSBvbmUgcXVldWUgc2VydmluZyB0aGlzIGNoYW5uZWwiLiBUaGF0IHJ1bGUg
aXMNCj4gdGhlIHJlYXNvbiByeF9zZXEgaGFzIG5vIGxvY2suDQo+DQo+IENvdWxkIHRoZSBmcmFt
ZSBiZSBkcm9wcGVkIHVubGVzcyBNVEtfQ0hfSUQoY2hhbm5lbCkgbWF0Y2hlcyB0aGUgYXJtaW5n
DQo+IHBvcnQncyBjaGFubmVsLCBvciB1bmxlc3MgdGhlIGNoYW5uZWwncyBxdWV1ZSBtYXRjaGVz
IHRoZSByZWNlaXZpbmcNCj4gcXVldWU/IHQ3eHggZG9lcyB0aGlzIGJ5IG1hdGNoaW5nIHJ4cV9p
bmRleC4NCg0KTm8gY2hhbmdlLiAgdDd4eCByb3V0ZXMgQ0NDSSBmcmFtZXMgdGhlIHNhbWUgd2F5
Og0KdDd4eF9wb3J0X3Byb3h5X2ZpbmRfcG9ydCgpIG1hdGNoZXMgb25seSB0aGUgcGF0aCAoaGlm
X2lkKSBhbmQgdGhlDQpjaGFubmVsLCBhbmQgaXRzIHJ4cV9pbmRleCBjaGVjayBjb3ZlcnMgb25s
eSB0aGUgZGVkaWNhdGVkIGhlYWRlci1sZXNzDQpxdWV1ZS4gIEEgY2hlY2sgYWdhaW5zdCB0aGUg
cG9ydCB0aGF0IGFybWVkIHRoZSBxdWV1ZSB3b3VsZCBhbHNvIGRyb3ANCmZyYW1lcyBvbiBxdWV1
ZXMgc2hhcmVkIGJ5IHNldmVyYWwgY2hhbm5lbHMsIHdoaWNoIGxhdGVyIHVzZXJzIG9mIHRoaXMN
CmRyaXZlciBoYXZlLiAgQSBmcmFtZSBvbiB0aGUgd3JvbmcgcXVldWUgb2YgdGhlIHNhbWUgQ0xE
TUEgaXMgYSBmaXJtd2FyZQ0KYnVnLiAgRXZlbiB0aGVuLCBib3RoIC0+cmVjdigpIHBhdGhzIHRv
bGVyYXRlIGNvbmN1cnJlbnQgY2FsbHMsIGFuZA0Kcnhfc2VxIG9ubHkgZmVlZHMgdGhlIHJhdGUt
bGltaXRlZCB3YXJuaW5nLg0KDQo+IElzIHRoZSBjaGFubmVsIGFsd2F5cyBjbG9zZWQgd2hlbiB0
aGVzZSBjb3VudGVycyBhcmUgcmVzZXQ/IFRoZSBjb21tZW50DQo+IGluIHN0cnVjdCBtdGtfcG9y
dCBpbiBtdGtfcG9ydC5oIGRlcGVuZHMgb24gaXQ6DQo+DQo+IAkvKiB0eF9zZXEgaXMgc3RhbXBl
ZCBhbmQgYWR2YW5jZWQgb25seSBhdCBoYXJkd2FyZSBoYW5kLW9mZiwgYnkgdGhlIG9uZQ0KPiAJ
ICogdGhyZWFkIHNlcnZpbmcgdGhpcyBwb3J0J3MgVFggcXVldWU7IHJ4X3NlcSBvbmx5IGZyb20g
dGhlIHJ4X2RvbmUNCj4gCSAqIGNhbGxiYWNrIG9mIHRoZSBvbmUgcXVldWUgc2VydmluZyB0aGlz
IGNoYW5uZWwuICBCb3RoIGFyZSByZXNldA0KPiAJICogd2hpbGUgdGhlIGNoYW5uZWwgaXMgZGlz
YWJsZWQsIHNvIG5laXRoZXIgbmVlZHMgYSBsb2NrLg0KPiAJICovDQo+DQo+IFRoZXNlIGFyZSBw
bGFpbiBzdG9yZXMsIG1hZGUgYmVmb3JlIHRoZSBFTkFCTEUgaXMgc3VibWl0dGVkLiBOb3RoaW5n
DQo+IGNoZWNrcyB0aGF0IHRoZSBDTERNQSBxdWV1ZSBpcyBjbG9zZWQuIEkgY2FuIHNlZSB0d28g
d2F5cyB0aGUgcXVldWUgY2FuDQo+IHN0aWxsIGJlIGxpdmUgYXQgdGhpcyBwb2ludC4NCj4NCj4g
VGhlIGZpcnN0IGlzIGEgcmV0cnkgYWZ0ZXIgYSB0aW1lb3V0LiBPbiAtRVRJTUVET1VULA0KPiBt
dGtfcG9ydF9pbnRlcm5hbF9lbmFibGUoKSBkb2VzIHRoaXM6DQo+DQo+IAlyZXQgPSBtdGtfcG9y
dF9jaF9lbmFibGUocG9ydCk7DQo+IAlpZiAocmV0ICYmIHJldCAhPSAtRUJVU1kpIHsNCj4gCQku
Li4NCj4gCQltdGtfcG9ydF9jaF9kaXNhYmxlKHBvcnQpOw0KPiAJCWNsZWFyX2JpdChQT1JUX1Nf
RU5BQkxFLCAmcG9ydC0+c3RhdHVzKTsNCj4gCQlyZXR1cm47DQo+IAl9DQo+DQo+IFRoZSBFTkFC
TEUgdHJiIGlzIHN0aWxsIHF1ZXVlZCwgd2l0aCB0aGUgRElTQUJMRSBiZWhpbmQgaXQuIFdpdGgg
IkFkZA0KPiBGU00gdGhyZWFkIiBsYXRlciBpbiB0aGUgc2VyaWVzLCB0aGUgaGFuZHNoYWtlIHRo
ZW4gZmFpbHMgaW4NCj4gbXRrX2ZzbV9jdHJsX2NoX3N0YXJ0KCktPm10a19wb3J0X2ludGVybmFs
X29wZW4oKSB3aXRoIC1FTk9ERVYuIFRoZQ0KPiBkZXZpY2Ugc2VuZHMgSFMxIGFnYWluLCBhbmQg
bXRrX3BvcnRfbW5ncl9mc21fc3RhdGVfaGFuZGxlcl9sYXRlKCkgY2FsbHMNCj4gLT5lbmFibGUo
KSBhIHNlY29uZCB0aW1lLg0KPg0KPiBTdXBwb3NlIHRoZSB0cmIgdGhyZWFkIGhhcyBhbHJlYWR5
IHJ1biB0aGUgZmlyc3QgRU5BQkxFLiBUaGUgUlggcXVldWUgaXMNCj4gdGhlbiBhcm1lZCB3aXRo
IHJ4cS0+YXJnID0gcG9ydCwgYW5kIHRoZSBESVNBQkxFIGhhcyBub3QgY2xvc2VkIGl0IHlldC4N
Cj4gbXRrX3BvcnRfcnhfZGlzcGF0Y2goKSBjYW4gdGhlbiB3cml0ZSBwb3J0LT5yeF9zZXEgd2hp
bGUgdGhpcyBmdW5jdGlvbg0KPiByZXNldHMgaXQuDQo+DQo+IFRoZSBzZWNvbmQgaXMgLUVCVVNZ
LCB3aGljaCBtdGtfcG9ydF9jaF9lbmFibGUoKSB0cmVhdHMgYXMgc3VjY2Vzcy4NCj4gU3VwcG9z
ZSB0aGUgcXVldWUgd2FzIGxlZnQgb3BlbiwgZm9yIGV4YW1wbGUgYmVjYXVzZSBhbiBlYXJsaWVy
IERJU0FCTEUNCj4gc3VibWl0IGZhaWxlZCB3aXRoIC1FTk9NRU0uIEJvdGggY291bnRlcnMgYXJl
IHRoZW4gcmVzZXQgd2hpbGUgdGhlIHF1ZXVlDQo+IGlzIGxpdmUuIFRoZSB0cmIgdGhyZWFkIG1h
eSBzdGlsbCBiZSBydW5uaW5nIG10a19wb3J0X3R4X3NlcV9zdGFtcCgpIGFuZA0KPiBtdGtfcG9y
dF90eF9zZXFfYWR2YW5jZSgpIG9uIHF1ZXVlZCBUWCBwYWNrZXRzLg0KPg0KPiByeF9zZXEgb25s
eSBmZWVkcyB0aGUgcmF0ZS1saW1pdGVkIHdhcm5pbmcgaW4gbXRrX3BvcnRfY2hlY2tfcnhfc2Vx
KCksDQo+IHNvIHRoZSB2aXNpYmxlIGVmZmVjdCBpcyBhIHNwdXJpb3VzIG9yIG1pc3NlZCBvdXQt
b2Ytb3JkZXIgd2FybmluZy4NCj4gS0NTQU4gd291bGQgc3RpbGwgcmVwb3J0IHRoZSByYWNlLg0K
Pg0KPiBDb3VsZCB0aGUgZ3VhcmFudGVlIGluIHRoZSBjb21tZW50IGJlIGVuZm9yY2VkLCBvciBj
b3VsZCB0aGUgY29tbWVudCBiZQ0KPiByZXdvcmRlZCB0byBtYXRjaCB3aGF0IHRoZSBjb2RlIGFj
dHVhbGx5IGVuc3VyZXM/DQoNCk5vIGNoYW5nZS4gIFRoZSByZXNldCBvbmx5IHJ1bnMgd2hlbiBQ
T1JUX1NfRU5BQkxFIHdhcyBjbGVhciwgYW5kIHRoZXJlDQphcmUgdHdvIHdheXMgdG8gZ2V0IHRo
ZXJlLiAgT25lIGlzIGFmdGVyIE9GRiwgd2hlcmUgbXRrX3BjaWVfaGlmX2V4aXQoKQ0KaGFzIGNs
b3NlZCBldmVyeSBxdWV1ZSBhbmQgdGhlIG5leHQgaGlmIGluaXQgc3RhcnRzIHRoZSBxdWV1ZXMg
ZnJvbQ0Kc2NyYXRjaCwgc28gdGhlIC1FQlVTWSBjYXNlIGNhbm5vdCBjYXJyeSBhbiBvcGVuIHF1
ZXVlIGFjcm9zcyBpdC4gIFRoZQ0Kb3RoZXIgaXMgYW4gZW5hYmxlIHRoYXQgZmFpbGVkIGJlZm9y
ZSB0aGUgcG9ydCBjb3VsZCBiZSBvcGVuZWQ6IHRoZW4gbm8NClRYIFRSQiBvZiB0aGlzIHBvcnQg
ZXhpc3RzLCBhbmQgdGhlIG1vZGVtIHNlbmRzIG5vdGhpbmcgb24gdGhlIGNvbnRyb2wNCmNoYW5u
ZWwsIGJlY2F1c2UgaXQgb25seSBhbnN3ZXJzIHRoZSBIUzEgdGhhdCB3YXMgbmV2ZXIgc2VudC4g
IEENCnJlcGVhdGVkIEhTMSBkdXJpbmcgYSBsaXZlIGhhbmRzaGFrZSBmaW5kcyBQT1JUX1NfRU5B
QkxFIHNldCBhbmQgZG9lcw0Kbm90IHJlYWNoIHRoZSByZXNldC4gIFRoZSBjb21tZW50IGlzIGFj
Y3VyYXRlIGFzIHdyaXR0ZW4uDQoNCi0tDQpKYWNrDQoNCg==
