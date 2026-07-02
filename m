Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C4434DCD6;
	Thu,  2 Jul 2026 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980870; cv=none; b=oh3SgDWD56Udi6XFPKnTcxeMzMMQC5uSCs1B52Da3hWv1XzQgB0EUuiRWONi/nUyoeT4tjr7J0zWLBN4wc7PDSj98aoSbxt6lR8ZEwuT6mFfz0FjwALisdZ6lXUi9xh12NALm0H1rZ/qxKHrDlcuNAU5akXDjUsqyjm10opPY50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980870; c=relaxed/simple;
	bh=+VWsVZmbh6VuQAbEeJ8YTelqhXj03on95jXTEwbtnYA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=myvmJxv586zk4IG1Vr1RB19YuCOs6x/oyiV5ihIroPC0JdnueBDJBX1Tsma1da1agO/vkxP0IqAm2jGQqaZHwV1IwEu/wg/wvguqna5ZIsBWh3pnqHud2ui5XRV6JXot79TO15zz7UZXG2UQIGSrVlzBYYroPvOE4gfyivq313k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: e11a089475ef11f1b2470fb4f881575f-20260702
X-CID-CACHE: Type:Local,Time:202607021627+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:2df641c6-292d-45cf-9644-de51683a4a20,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:1d90e5ee-6085-4bd7-b32c-8f3a894d1f02,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e11a089475ef11f1b2470fb4f881575f-20260702
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1220226109; Thu, 02 Jul 2026 16:27:35 +0800
X-UUID: ddd763a275ef11f1b328fd8a884f4420-20260702
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:b2a0e46e-e1e5-4259-8371-f8e83357b9e0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:031aa614-ea64-44d4-98db-4e1fb89955a3,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ddd763a275ef11f1b328fd8a884f4420-20260702
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 117347440; Thu, 02 Jul 2026 16:27:30 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 2 Jul 2026 16:27:26 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::7d1b:448d:4d95:51b0]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::7d1b:448d:4d95:51b0%11]) with mapi id
 15.02.2562.029; Thu, 2 Jul 2026 16:27:26 +0800
From: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov
	<ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, Shi-Wei Yeh
	<shi-wei.yeh@mediatek.com>, Minano Tseng <Minano.tseng@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [External Mail] Re: [PATCH v3 2/7] net: wwan: t9xx: Add control
 plane transaction layer
Thread-Topic: [External Mail] Re: [PATCH v3 2/7] net: wwan: t9xx: Add control
 plane transaction layer
Thread-Index: AQHdA/KoG0AzoVDQmky5mWyAxH40ubZVI4cU///wpwCABNxa7A==
Date: Thu, 2 Jul 2026 08:27:26 +0000
Message-ID: <4ec081f8df234cc584702abc67213965@compal.com>
References: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
 <20260624-t9xx_driver_v1-v3-2-73ff03f60c48@compal.com>
 <2a90ae6b-2b6d-4340-b557-915252cc3488@lunn.ch>
 <49939d4d682f4c1fb359973ea2cdbd00@compal.com>,<92b1e341-31a1-4f60-80d5-ccf8f742a38a@lunn.ch>
In-Reply-To: <92b1e341-31a1-4f60-80d5-ccf8f742a38a@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30042.005
x-tm-as-result: No-10--5.111600-8.000000
x-tmase-matchedrid: gIzQ6PxOy4Muv++HU7VXryRFbfQbCufdN0X64jGy2db7+pncqRJfy2XQ
	7TcqkNINvK3gdx4WruG6C02CoqNlCtDVjrCAjJafEUw76ALZYKnyQ6dAmPdzEpASM5lkTKECkJf
	KQELyHYjhPhXQAUtd7cnIJXNwrshOgwp9EiT9SDbPEeDcxvUDjCh3g1nRJyiyojKyNVmXOrudJP
	a/3VyousENhGSOVOW5y5giTPlFHEONYN8w7dbL+QJmkj1SAkweoli4ZoiOHT8g4pZYxslhbbNke
	EYGbJYuHRsWxVXWBJXNhPz9cgqi3YYt/R+Zd8q9feQQQBikYjzCCiz194l71g==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--5.111600-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30042.005
x-tm-snts-smtp: 35A964323CE21EEFA67078F12AC4479D3B511B04E44653D239E22F5B0E2FD6072000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgQW5kcmV3LA0KDQo+ID4gbXRrX2Rldl9hbGxvYy9tdGtfZGV2X2ZyZWUgYXJlIHBhaXJlZCB3
cmFwcGVycyBzbyB0aGUgY2FsbGVyDQo+ID4gZG9lc24ndCBuZWVkIHRvIGtub3cgdGhlIHVuZGVy
bHlpbmcgYWxsb2NhdGlvbiBtZWNoYW5pc20uDQo+ID4gVGhlIGRldm1fa2ZyZWUgaXMgc3RpbGwg
Y2FsbGVkIGluc2lkZSBtdGtfZGV2X2ZyZWUuDQo+DQo+IFR3byBkaWZmZXJlbnQgaXNzdWVzIGhl
cmU6DQo+DQo+IDEpIElmIHlvdSBkb24ndCB3YW50IHRvIHVzZSBkZXZtXywgZG9uJ3QgdXNlIGRl
dm1fIGZyb20gdGhlDQo+IGJlZ2lubmluZy4gQSBwYXRjaCBzaG91bGQgbm90IGNoYW5nZSBob3cg
YSBwcmV2aW91cyBwYXRjaCB3b3Jrcywgc2luY2UNCj4geW91IGFyZSB3YXN0aW5nIHJldmlld2Vy
IHRpbWUgcmV2aWV3aW5nIGNvZGUgd2hpY2ggeW91IGxhdGVyIGNoYW5nZS4NCj4NCj4gMikgRG8g
eW91IHVuZGVyc3RhbmQgd2hhdCBkZXZtXyBhY3R1YWxseSBkb2VzPyBTaW5jZSB5b3UgdXNlDQo+
IGRldm1fZnJlZSgpIGkgZG9uJ3QgdGhpbmsgeW91IGFjdHVhbGx5IHVuZGVyc3RhbmQgd2hhdCBk
ZXZtXyBpcyBhbGwNCj4gYWJvdXQuDQoNClRoYW5rIHlvdSBmb3IgdGhlIGV4cGxhbmF0aW9uLiBZ
b3UgYXJlIHJpZ2h0Lg0KDQp3ZSB3aWxsIHJlbW92ZSB0aGUgbXRrX2Rldl9hbGxvYy9tdGtfZGV2
X2ZyZWUgd3JhcHBlcnMgYW5kIHVzZQ0KZGV2bV9remFsbG9jIGRpcmVjdGx5IGZyb20gdGhlIGJl
Z2lubmluZy4NCg0KV2Ugd2lsbCBhbHNvIHJlbW92ZSBhbGwgdW5uZWNlc3NhcnkgZGV2bV9rZnJl
ZSgpIGNhbGxzIGZyb20gcHJvYmUNCmVycm9yIHBhdGhzIGFuZCByZW1vdmUgcGF0aHMsIGtlZXBp
bmcgdGhlbSBvbmx5IHdoZXJlIHJlc291cmNlcw0KYXJlIGZyZWVkIGFuZCByZS1hbGxvY2F0ZWQg
YXQgcnVudGltZSAoZS5nLiwgQ0xETUEgcXVldWUgbGlmZWN5Y2xlDQpkdXJpbmcgbW9kZW0gcmVz
ZXQgY3ljbGVzKS4NCg0KVGhhbmtzLg0KDQpKYWNrIFd1
