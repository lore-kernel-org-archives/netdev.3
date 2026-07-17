Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D593EFFB5;
	Fri, 17 Jul 2026 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286056; cv=none; b=AtGi2Uc5APCdHFCDJFrQjsWIebL25vRkVEZMtPAO3a1mRW8jlz9gPjMpzdwHhzdN38I7ps99pGFF/5AhuKfTrypht2q1p4IDLx24iUDiMCegev9pDkksVzzEzdQnpTJdt7oArrAcyxkuhRijJj5H8X6P80KMVDi228silV11R/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286056; c=relaxed/simple;
	bh=8RmbrxbGqGU2GDfQYejUZ3I25Q1A45ujtjtU7ERjgzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AB4BX5nO1zycAsUvAVg47S9tNMPxH/ZX0C84YeFn9epI1c8+q2ULlZgAszBBX6fl4JOTyiwLWKsOz5vLX309PiRFReH0M2YypW+Q3UP1E4QFvcyZm0QNhFioMS15RcA7/G+bRocilmQaXxGhPqGd53Aw9nw55WG7yQLd4P3XtEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: ac8a6ad481ce11f1b2470fb4f881575f-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:76176333-cffe-4cda-b0cb-61e428cafc55,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:25f7975f-762a-4584-baab-4eebe609beea,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ac8a6ad481ce11f1b2470fb4f881575f-20260717
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1094600300; Fri, 17 Jul 2026 19:00:08 +0800
X-UUID: a98fe78281ce11f1b328fd8a884f4420-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:2bd3c9ee-7f01-4716-9e78-dd9258a3323b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:d0f6975f-762a-4584-baab-4eebe609beea,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a98fe78281ce11f1b328fd8a884f4420-20260717
Received: from sdbmbx12.tpe.compalcomm.com [(10.113.2.136)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES256-SHA 256/256)
	with ESMTP id 371862174; Fri, 17 Jul 2026 19:00:03 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX12.tpe.compalcomm.com (10.113.2.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.43;
 Fri, 17 Jul 2026 19:00:01 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86%11]) with mapi id
 15.02.2562.043; Fri, 17 Jul 2026 19:00:01 +0800
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
Subject: RE: [External Mail] Re: [PATCH v4 4/7] net: wwan: t9xx: Add control
 port
Thread-Topic: [External Mail] Re: [PATCH v4 4/7] net: wwan: t9xx: Add control
 port
Thread-Index: AQHdFQZRaZyRXyQV2Ei8jJ3fS8HrDbZxSABggABEQi0=
Date: Fri, 17 Jul 2026 11:00:01 +0000
Message-ID: <def80621b7b542008580609735872604@compal.com>
References: <20260709-t9xx_driver_v1-v4-4-a8c009d509c5@compal.com>,<20260716093414.231093-1-horms@kernel.org>,<3a3b077758604433a0ddca3f3467a561@compal.com>
In-Reply-To: <3a3b077758604433a0ddca3f3467a561@compal.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30074.006
x-tm-as-result: No-10--21.348200-8.000000
x-tmase-matchedrid: +gTBWF+Z0RMuv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZpNz
	D6YMRvgW4TxIMIx6VwqygWex5mZjoExpKNdX3ZAHGG92L3YEEC7+i5C4lXMwGl+wo4bU8mXUSOk
	QLkoPeXNt9gtd7AIX7UcQboVrj5RRQ/oBc6KOvLkftZuMZfm2SRAHEUDztk84PtCfWUwJAdi3UA
	+94gBIbWa96NA93JmEciryVhu4m80Asgl6PZgqJDZ4NKr/TszHbfDppa3pvd6QWn82LFk2uRNpw
	FGo8YcXeNazwatiYB8gjQSNV+ZFJ4tH8IewwDDb9K6xgLnDQNiW07dlc9+hRSSt1u56pOfAOg7j
	BSGj9CIgXawxmmfGtTHjiWB1Lc+2ZBKFYVim6qlgFLgE7TxyQ5Wa6EbToghtmbcAVHD2StYRusB
	Q5CSPEND6xLvX4M4IEA4s0Z67fd2/2tJ3foSBQsD3fX6Y132wmzuCQZagpjfpAuB7xNymfQ==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--21.348200-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30074.006
x-tm-snts-smtp: C42462ECFE02659FD77BFAE001E7F45A52DADA376696B2C7F36703BC9A08705D2000:8
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
b3dpbmcgaXRlbXMgd2lsbA0KYmUgZml4ZWQgaW4gdjUuDQoNCk9uIFtkYXRlXSBKYWNrIFd1IHdy
b3RlOg0KDQo+PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+PiBDYW4gdGhpcyBsZWFkIHRvIHVzZS1hZnRl
ci1mcmVlIGFuZCBkb3VibGUtZnJlZSBvbiB0aGUgc2tiPw0KDQo+IE5vLiBUaGUgcmVjdiBjYWxs
YmFjayAobXRrX3BvcnRfaW50ZXJuYWxfcmVjdikgZG9lcyBub3QgZnJlZQ0KPiB0aGUgc2tiIG9u
IGVycm9yIKFYIGl0IHJldHVybnMgLUVOWElPIGFuZCBsZWF2ZXMgc2tiIG93bmVyc2hpcA0KPiB3
aXRoIHRoZSBjYWxsZXIuDQoNCj4+IFtTZXZlcml0eTogSGlnaF0NCj4+IFRoaXMgaXMgd2hlcmUg
dGhlIHNlY29uZCBmcmVlIG9mIHRoZSBza2Igb2NjdXJzIHdoZW4gcHJvcGFnYXRpbmcNCj4+IHRo
ZSBlcnJvciBmcm9tIHRoZSByZWN2IGNhbGxiYWNrLg0KDQo+IEFzIGFib3ZlLCB0aGUgcmVjdiBj
YWxsYmFjayBkb2VzIG5vdCBmcmVlIHRoZSBza2Igb24gZXJyb3IuDQoNCj4+IFtTZXZlcml0eTog
SGlnaF0NCj4+IFRoaXMgaXMgd2hlcmUgdGhlIHNrYiBpcyBmcmVlZCBvbiB0aGUgZXJyb3IgcGF0
aCBiZWZvcmUgcmV0dXJuaW5nDQo+PiAtRU5YSU8uDQoNCj4gbXRrX3BvcnRfaW50ZXJuYWxfcmVj
digpIGRvZXMgbm90IGNhbGwgZGV2X2tmcmVlX3NrYl9hbnkoKSBvbiB0aGUNCj4gZXJyb3IgcGF0
aC4NCg0KT3VyIHByZXZpb3VzIHJlc3BvbnNlIHdhcyBpbmNvcnJlY3QuIEluIFBhdGNoIDQncyBj
b2RlLA0KbXRrX3BvcnRfaW50ZXJuYWxfcmVjdidzIGRyb3BfZGF0YSBkb2VzIGhhdmUNCmRldl9r
ZnJlZV9za2JfYW55KHNrYikgoVggdGhlIGRvdWJsZS1mcmVlIGFuZCBVQUYgYXJlIHJlYWwuDQoN
CldpbGwgcmVtb3ZlIGRldl9rZnJlZV9za2JfYW55KHNrYikgZnJvbQ0KbXRrX3BvcnRfaW50ZXJu
YWxfcmVjdidzIGRyb3BfZGF0YSBwYXRoIGluIHY1LiBUaGUgY2FsbGVyDQoobXRrX3BvcnRfcnhf
ZGlzcGF0Y2gpIGlzIHRoZSBzb2xlIG93bmVyIGFuZCBmcmVlcyB0aGUgc2tiDQpvbiBlcnJvci4N
Cg0KPj4gW1NldmVyaXR5OiBIaWdoXQ0KPj4gQ291bGQgdGhpcyBjcmVhdGUgYW4gaW5maW5pdGUg
bG9vcCBpbiBrZXJuZWwgc3BhY2U/DQoNCj4gVGhpcyBpcyBpbnRlbnRpb25hbC4gQ2hhbm5lbCBl
bmFibGUvZGlzYWJsZSBhcmUgY29udHJvbCBwbGFuZQ0KPiBvcGVyYXRpb25zIHRoYXQgbXVzdCBj
b21wbGV0ZSBvciB0aW1lb3V0LiBUaGUgbG9vcCBkb2VzIG5vdA0KPiBidXN5LXNwaW46IGVhY2gg
aXRlcmF0aW9uIHNsZWVwcyBpbg0KPiB3YWl0X2V2ZW50X2ludGVycnVwdGlibGVfdGltZW91dCB1
bnRpbCB0aGUgY29uZGl0aW9uIGlzIG1ldCBvcg0KPiB0aGUgdGltZW91dCBleHBpcmVzLg0KDQo+
PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+PiBUaGlzIGFwcGVhcnMgdG8gaGF2ZSB0aGUgc2FtZSBpbmZp
bml0ZSBsb29wIHJpc2suDQoNCj4gU2FtZSByZWFzb25pbmcgYXMgbXRrX3BvcnRfY2hfZW5hYmxl
Lg0KDQpXaWxsIGNoYW5nZSB3YWl0X2V2ZW50X2ludGVycnVwdGlibGVfdGltZW91dCB0bw0Kd2Fp
dF9ldmVudF90aW1lb3V0IGluIGJvdGggbXRrX3BvcnRfY2hfZW5hYmxlIGFuZA0KbXRrX3BvcnRf
Y2hfZGlzYWJsZSwgYW5kIHJlbW92ZSB0aGUgLUVSRVNUQVJUU1lTIC8gZ290bw0Kc3RhcnRfd2Fp
dCBibG9jay4NCg0KPj4gW1NldmVyaXR5OiBIaWdoXQ0KPj4gTWlzc2luZyBib3VuZHMgY2hlY2sg
b24gbXNnLT5wb3J0X2NudCBpbg0KPj4gbXRrX3BvcnRfc3RhdHVzX3VwZGF0ZS4NCg0KPiBUaGUg
bWVzc2FnZSBpcyBhbHJlYWR5IHZhbGlkYXRlZCBieSBoZWFkX3BhdHRlcm4sIHRhaWxfcGF0dGVy
biwNCj4gYW5kIHZlcnNpb24gY2hlY2tzIGJlZm9yZSB0aGUgbG9vcC4gVGhlIG1vZGVtIGZpcm13
YXJlIGlzIGENCj4gdHJ1c3RlZCBzb3VyY2UuDQoNCldpbGwgbW92ZSBkYXRhX2xlbiB2YWxpZGF0
aW9uIGJlZm9yZSB0aGUgY2FsbGJhY2sgY2FsbCBpbg0KbXRrX2ZzbV9wYXJzZV9oczJfbXNnLCBw
YXNzIGRhdGFfbGVuIHRvIHRoZSBjYWxsYmFjaywgYW5kIGFkZA0KYSBib3VuZHMgY2hlY2sgaW4g
bXRrX3BvcnRfc3RhdHVzX3VwZGF0ZToNCg0KICBpZiAoZGF0YV9sZW4gPCBzaXplb2YoKm1zZykg
Kw0KICAgICAgbGUxNl90b19jcHUobXNnLT5wb3J0X2NudCkgKiBzaXplb2YoKnBvcnRfaW5mbykp
DQogICAgICByZXR1cm4gLUVQUk9UTzsNCg0KVGhhbmtzLg0KDQpKYWNrIFd1
