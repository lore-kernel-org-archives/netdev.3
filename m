Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0F3BED78;
	Fri, 17 Jul 2026 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273209; cv=none; b=jJ64mQSF/4vctRQmNzQmzwW4E/JJraeWmQZXlmKXHQWys/FDoxlfp60NIB6b46greK4ntV4bvOCHnSXs65xZybg88SjoYPyT6oeplw1NL+8Kt6DPQqTvR5QpTTXoKTxj/xaauInYx/OSAm21OOIRK6NN+MHlKHPG9A61GJ9gmAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273209; c=relaxed/simple;
	bh=vpf7Ez7EdE1Vq+sym35CgM4C5nXj0FZvUFGxud5ge6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QzdsfJx1f5pj+Z7B8bVWGlsPXJl3qcNiBtp/2RwI+WX+Dxfony+XKpoqcTpdF3Atd5IB5aMu7M/ze5JG+VEkAtflCLqDbhTHY9xFJYWYE0qjx40kXOyhjMreBufqIYbWGpyJ5IUBVZplLB8oPtW/1vv84rC0orQaPhTzHi3JdCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: dad16fa081b011f1b2470fb4f881575f-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:5797b8da-42b0-4f0f-9ebd-a3bd877608a0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:6b675f3f-46cf-453a-bd84-ad9fc7cb0e8c,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dad16fa081b011f1b2470fb4f881575f-20260717
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1568818958; Fri, 17 Jul 2026 15:26:41 +0800
X-UUID: d8b4070081b011f1a9f9c99e036204b4-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:68120410-0751-41c4-ae7e-f9a985aa4f58,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:94ca12d7-d84b-4e52-b801-314e13fb1691,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d8b4070081b011f1a9f9c99e036204b4-20260717
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 847746305; Fri, 17 Jul 2026 15:26:37 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 17 Jul 2026 15:26:35 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86%11]) with mapi id
 15.02.2562.043; Fri, 17 Jul 2026 15:26:35 +0800
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
Subject: RE: [External Mail] Re: [PATCH v4 6/7] net: wwan: t9xx: Add AT & MBIM
 WWAN ports
Thread-Topic: [External Mail] Re: [PATCH v4 6/7] net: wwan: t9xx: Add AT &
 MBIM WWAN ports
Thread-Index: AQHdFQZbJYK1bUK1WEaDXhVMUHB9n7ZxULXN
Date: Fri, 17 Jul 2026 07:26:35 +0000
Message-ID: <7348d8ecabef42f892503ae6910c0e75@compal.com>
References: <20260709-t9xx_driver_v1-v4-6-a8c009d509c5@compal.com>,<20260716093429.231132-1-horms@kernel.org>
In-Reply-To: <20260716093429.231132-1-horms@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30074.005
x-tm-as-result: No-10--10.227100-8.000000
x-tmase-matchedrid: k7uoLACGqMouv++HU7VXryRFbfQbCufdN0X64jGy2dZAvBJVRgtcsjny
	lHiK0ou/0wNjG7j2lpdbGNsZDOUGQtDVjrCAjJafJfg23t68rFm+UXZnp3CKAKMhPVMnoUqMFZF
	fhayav43p+gp7hDwK8qIWjMM1LlCVlP8tEM0fMQ95JTDogbV4hPJDp0CY93MSHyNEnetUnYKO9o
	XZJdq+a1LCyrCU73d8bZ0ZmXZM5yZ4KjjH0UCbNQ53Bh+4sUi8wBLtKYu8bEtpbszOEp41ydil2
	pkoOjM8c7UkjmkQhyoNh194vDCrLCRoQhMu0UDBJPlTeUnhPwo58Sarp97J8xfqd/DJ3Zya7rEb
	Qf2fdE7jTz65t1IJFMi17oTzQKhWJZ8EOwoK47yY3+hmZP9IU931j9zwRXOC
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--10.227100-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30074.005
x-tm-snts-smtp: 03905B1A35D55303C1E0973AC004C0DEE4B03304099A1CAEE825BBD116093C1A2000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU2ltb24sDQoNCk9uIC4uLiBzYXNoaWtvIHdyb3RlOg0KPiA+ICtzdGF0aWMgaW50IG10a19w
b3J0X3d3YW5fd3JpdGUoLi4uKQ0KPiA+ICsJaWYgKHJldCA8IDApDQo+ID4gKwkJcmV0dXJuIHJl
dDsNCj4gPiArDQo+ID4gKwljb25zdW1lX3NrYihza2IpOw0KPiA+ICsJcmV0dXJuIDA7DQo+DQo+
IFtTZXZlcml0eTogSGlnaF0NCj4gSWYgbXRrX3BvcnRfY29tbW9uX3dyaXRlKCkgc3VjY2Vzc2Z1
bGx5IHNlbmRzIHRoZSBmaXJzdCBmZXcgZnJhZ21lbnRzDQo+IGJ1dCBmYWlscyBvbiBzdWJzZXF1
ZW50IG9uZXMgLi4uIGRvZXMgdGhpcyBjb2RlIHNpbGVudGx5IGRyb3AgdGhlDQo+IHJlbWFpbmlu
ZyBkYXRhPw0KDQpUaGlzIGlzIGEgZGVzaWduIGxpbWl0YXRpb24gb2YgdGhlIFdXQU4gcG9ydCBB
UEk6DQp3d2FuX3BvcnRfb3BfdHggcmV0dXJucyAwIGZvciBzdWNjZXNzIG9yIG5lZ2F0aXZlIGZv
ciBlcnJvciChWA0KdGhlcmUgaXMgbm8gbWVjaGFuaXNtIHRvIHJlcG9ydCBwYXJ0aWFsIHdyaXRl
cyBiYWNrIHRvIHRoZSBXV0FODQpjb3JlLiBUaGUgYWxyZWFkeS1zdWJtaXR0ZWQgZnJhZ21lbnRz
IGNhbm5vdCBiZSByZWNhbGxlZCBmcm9tDQp0aGUgRE1BIGVuZ2luZS4gRm9yIHRoZSBBVC9NQklN
IGNvbnRyb2wgcG9ydHMsIG1lc3NhZ2VzIGFyZQ0Kc21hbGwgKHR5cGljYWxseSB1bmRlciAxS0Is
IHdpdGhpbiBhIHNpbmdsZSBNVFUpLiBUaGUNCm11bHRpLWZyYWdtZW50IHBhdGggaXMgcmFyZWx5
IGV4ZXJjaXNlZCBmb3IgY29udHJvbCBwbGFuZQ0KdHJhZmZpYy4NCg0KPiA+ICtzdGF0aWMgaW50
IG10a19wb3J0X3d3YW5fd3JpdGVfYmxvY2tpbmcoLi4uKQ0KPiA+ICsJaWYgKHJldCA8IDApDQo+
ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwljb25zdW1lX3NrYihza2IpOw0KPiA+ICsJ
cmV0dXJuIDA7DQo+DQo+IFtTZXZlcml0eTogSGlnaF0NCj4gQ2FuIHRoZSBzYW1lIHNpbGVudCBk
cm9wIG9mIHBhcnRpYWxseSB3cml0dGVuIFNLQnMgaGFwcGVuIGhlcmU/DQoNClNhbWUgcmVhc29u
aW5nIGFzIGFib3ZlLiBUaGUgV1dBTiBwb3J0IEFQSSBkb2VzIG5vdCBzdXBwb3J0DQpwYXJ0aWFs
IHdyaXRlIHJlcG9ydGluZywgYW5kIGNvbnRyb2wgcGxhbmUgbWVzc2FnZXMgYXJlDQp0eXBpY2Fs
bHkgd2l0aGluIGEgc2luZ2xlIE1UVS4NCg0KPiA+ICtzdGF0aWMgaW50IG10a19wb3J0X3d3YW5f
ZW5hYmxlKC4uLikNCj4gPiArCXBvcnQtPndfcHJpdi53X3BvcnQgPSB3d2FuX2NyZWF0ZV9wb3J0
KC4uLik7DQo+ID4gKwlpZiAoSVNfRVJSKHBvcnQtPndfcHJpdi53X3BvcnQpKSB7DQo+DQo+IFtT
ZXZlcml0eTogSGlnaF0NCj4gQ2FuIGEgcmFjZSBjb25kaXRpb24gb2NjdXIgaGVyZSBpZiB3d2Fu
X2NyZWF0ZV9wb3J0KCkgZmFpbHM/DQoNCm10a19wb3J0X3d3YW5fZW5hYmxlKCkgaXMgY2FsbGVk
IGZyb20gdGhlIEZTTSB0aHJlYWQgZHVyaW5nDQp0aGUgaGFuZHNoYWtlIHNlcXVlbmNlLCBiZWZv
cmUgdGhlIHBvcnQgc3RhcnRzIHJlY2VpdmluZyBkYXRhLg0KVGhlIENMRE1BIFJYIHF1ZXVlIGZv
ciB0aGlzIHBvcnQgaGFzIG5vdCBiZWVuIG9wZW5lZCBhdCB0aGlzDQpwb2ludCChWCBSWCBkYXRh
IG9ubHkgYXJyaXZlcyBhZnRlciB0aGUgbW9kZW0gY29tcGxldGVzIGl0cw0KaGFuZHNoYWtlLiBU
aGUgUlggcGF0aCBjYW5ub3Qgb2JzZXJ2ZSB0aGUgZXJyb3IgcG9pbnRlci4NCg0KRHVyaW5nIHRl
YXJkb3duLCBtdGtfcG9ydF93d2FuX2Rpc2FibGUoKSBob2xkcyB3X2xvY2sgd2hlbg0KY2xlYXJp
bmcgd19wb3J0LCBhbmQgbXRrX3BvcnRfd3dhbl9yZWN2KCkgY2hlY2tzIHdfcG9ydCB1bmRlcg0K
dGhlIHNhbWUgbG9jaywgc28gdGhlIFJYIHBhdGggaXMgcHJvcGVybHkgc3luY2hyb25pemVkLg0K
DQpUaGFua3MuDQoNCkphY2sgV3U=
