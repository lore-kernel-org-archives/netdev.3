Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4E23AA50A;
	Fri, 17 Jul 2026 06:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784269691; cv=none; b=Yk3DLxtnx4cesRcr5tJ6PH5BPpVFWmIi2bGRJ8khky2DpNj4UUIj6KKJKNOA2GK8OFGVOv37MhFSfP49/QJ+FSZKwx3M/S/pxQcSYoFaOurvREw7SIU9VRDF+Q0Nnt66DVKSaNRRkFbdGEQce64PUVyhXbkgrY0SM3PPn+psW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784269691; c=relaxed/simple;
	bh=+WZmixc0LYgqk7x8Zg0zKSBG4nAF2PH9ypi4BLTI3D8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bC0JeOr6O0Jk3akOCcj+nl3EOmjE5jcZkEJBAZV68ZEimRXa20zrn2QVdUqJdmqFj56d/kVyvNBj8d6td+uiHsBOASEo8sN1qbNO5CNLMdkzXewj+LS496QOJfDIHacZgPUWp96wcSa0G/1BOHplZ+KE2eB3JsqqnSgYIQ5X+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: aa2baa9e81a811f1b2470fb4f881575f-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:29b6c768-909f-448c-83ef-a389682b2ca7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:0990955f-762a-4584-baab-4eebe609beea,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aa2baa9e81a811f1b2470fb4f881575f-20260717
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1157579681; Fri, 17 Jul 2026 14:28:03 +0800
X-UUID: a7956cd481a811f1b328fd8a884f4420-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:53ec91b0-798f-415f-b7e9-9289716d75da,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:68df5e3f-46cf-453a-bd84-ad9fc7cb0e8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a7956cd481a811f1b328fd8a884f4420-20260717
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 238460647; Fri, 17 Jul 2026 14:27:59 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 17 Jul 2026 14:27:58 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86%11]) with mapi id
 15.02.2562.043; Fri, 17 Jul 2026 14:27:57 +0800
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
Subject: RE: [External Mail] Re: [PATCH v4 2/7] net: wwan: t9xx: Add control
 plane transaction layer
Thread-Topic: [External Mail] Re: [PATCH v4 2/7] net: wwan: t9xx: Add control
 plane transaction layer
Thread-Index: AQHdFQZLXFhkpHGHwk+0HowAeOhgTrZxQAIh
Date: Fri, 17 Jul 2026 06:27:57 +0000
Message-ID: <47002e869f5b4f0985316669d2769c19@compal.com>
References: <20260709-t9xx_driver_v1-v4-2-a8c009d509c5@compal.com>,<20260716093355.231047-1-horms@kernel.org>
In-Reply-To: <20260716093355.231047-1-horms@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30074.005
x-tm-as-result: No-10--16.406200-8.000000
x-tmase-matchedrid: gIzQ6PxOy4Muv++HU7VXryRFbfQbCufdN0X64jGy2db7+pncqRJfy2XQ
	7TcqkNINMlye2WA77Ai9CAA19yO7SzTILUm/BmQIWZxYhPYYrMks49QZH9p6LCLW2ccC0rwjNqy
	UdyLI2AvnBl01IH4/9Qz88i1JVNBxy0T1fdU23LIBs8i6PyStEHKa5XrXQyxS/4EbuHnSgjTfUT
	/CYNWKD3fuxt/hlr6ly5giTPlFHEONYN8w7dbL+QJmkj1SAkweoli4ZoiOHT8g4pZYxslhbbNke
	EYGbJYuA/3R8k/14e0=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--16.406200-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30074.005
x-tm-snts-smtp: 04A923A4871FEB9BF888966411B513889BC16DBC60899E76CE3CB1EA28536E092000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU2ltb24sDQoNCj4gPiAraW50IG10a19jdHJsX2luaXQoc3RydWN0IG10a19tZF9kZXYgKm1k
ZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBtdGtfY3RybF9ibGsgKmN0cmxfYmxrOw0KPiA+ICsJ
Y3RybF9ibGsgPSBkZXZtX2t6YWxsb2MobWRldi0+ZGV2LCBzaXplb2YoKmN0cmxfYmxrKSwgR0ZQ
X0tFUk5FTCk7DQo+DQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBEb2VzIHRoaXMgcGF0Y2ggYWN0
dWFsbHkgaW1wbGVtZW50IHRoZSBUWCBhbmQgUlggc2VydmljZXMgZGVzY3JpYmVkDQo+IGluIHRo
ZSBjb21taXQgbWVzc2FnZT8NCg0KV2Ugd2lsbCByZXdyaXRlIHRoZSBjb21taXQgbWVzc2FnZSB0
byBhY2N1cmF0ZWx5IGRlc2NyaWJlDQp3aGF0IHRoaXMgcGF0Y2ggZG9lcyChWCBpdCBpbnRyb2R1
Y2VzIHRoZSBjb250cm9sIHBsYW5lIGZyYW1ld29yaw0KYW5kIGRhdGEgc3RydWN0dXJlcywgbm90
IHRoZSBUWC9SWCBzZXJ2aWNlIGltcGxlbWVudGF0aW9ucy4NCg0KPiA+ICsJcmV0dXJuIExFMzJf
VE9fVTMyKGNwdV90b19sZTMyKGh3X2JpdHMpKTsNCj4gPiArfQ0KPg0KPiBbU2V2ZXJpdHk6IEhp
Z2hdDQo+IERvZXMgdGhpcyBjb2RlIGFwcGx5IGEgZG91YmxlIGJ5dGUtc3dhcCBvbiBiaWctZW5k
aWFuIGFyY2hpdGVjdHVyZXM/DQoNClQ5WFggY3VycmVudGx5IG9ubHkgdGFyZ2V0cyB4ODYgKGxp
dHRsZS1lbmRpYW4pIHBsYXRmb3JtcyB3aGVyZQ0KY3B1X3RvX2xlMzIoKSBpcyBhIG5vLW9wLiBU
aGUgS2NvbmZpZyBlbmZvcmNlcyAiZGVwZW5kcyBvbiBQQ0kgJiYNCkFDUEkiIHdoaWNoIHJlc3Ry
aWN0cyB0aGlzIHRvIHg4NiBwbGF0Zm9ybXMuIE9uIGxpdHRsZS1lbmRpYW4sIG5vDQpieXRlLXN3
YXAgb2NjdXJzIGF0IGFueSBwb2ludCwgc28gZmZzKCkgb3BlcmF0ZXMgb24gdGhlIGNvcnJlY3QN
CnZhbHVlLg0KDQpUaGFua3MuDQoNCkphY2sgV3UNCiAgICA=
