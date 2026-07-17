Received: from tpecef22.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760AD3F1AD3;
	Fri, 17 Jul 2026 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285910; cv=none; b=gqgUkRw7SaaWHApC/FpXMGapDuOf7EgOgjmRY4BaigwO5BJBThRnF8iQA8gRRZn6uXo0uUkohl5cbprOw1GcUM7IocqfAfafBUJddO9YvBCks3i4wYiLXnMEDTmAaA4kFEyiu0ysN4ecNLa0sEfwSglWajNRlCIzkNB635mjVS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285910; c=relaxed/simple;
	bh=lWNNBSIoyWBOFSNOhQeKfEHHIbciltHRFCNlpYq3ZL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cdHD4y607JjrxnrFD5pe2Go2wYcajnJL+t9IE7rWuSbJzkWxgYnIjvJyNt8dHbt8ii6SXqnMwngMUZcqLlRgW5oplvKjMmyPragtEDzRynR6tleP4U7QdbMV28iURiaiDmAh4dLnelbHsFmGcGhBYfM9wZC766FHYYrcOwfhbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: 634c902c81ce11f1a87c2323a98e90a4-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:d5fdd15a-3451-4c1c-b770-ec6f9eee737c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:cff2975f-762a-4584-baab-4eebe609beea,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 634c902c81ce11f1a87c2323a98e90a4-20260717
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef22.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 712035120; Fri, 17 Jul 2026 18:58:05 +0800
X-UUID: 60eeb05881ce11f1a9f9c99e036204b4-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:6ec2cd01-364f-4a82-a583-bffed7df6d45,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:1242613f-46cf-453a-bd84-ad9fc7cb0e8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 60eeb05881ce11f1a9f9c99e036204b4-20260717
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 251997475; Fri, 17 Jul 2026 18:58:01 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 17 Jul 2026 18:57:59 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86%11]) with mapi id
 15.02.2562.043; Fri, 17 Jul 2026 18:57:59 +0800
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
Thread-Index: AQHdFQZPlE9Zcx29j0SOvF2f5GB/ubZxQQT+gABKArw=
Date: Fri, 17 Jul 2026 10:57:59 +0000
Message-ID: <b1bc657dfd584ebfbe126ed7b1c25aa2@compal.com>
References: <20260709-t9xx_driver_v1-v4-3-a8c009d509c5@compal.com>,<20260716093406.231071-1-horms@kernel.org>,<cacde4a05d6a48afbac6425425fe180c@compal.com>
In-Reply-To: <cacde4a05d6a48afbac6425425fe180c@compal.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30074.006
x-tm-as-result: No-10--8.503600-8.000000
x-tmase-matchedrid: SIzKuw2hzSsuv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZpNz
	D6YMRvgW4TxIMIx6VwqygWex5mZjoExpKNdX3ZAHGG92L3YEEC7+i5C4lXMwGpkRPHajPHqahHb
	hMYBfXh6xz2XsYPh81PcsiAWLTUtcNAvg4f4NA3aKXsEnE1HIgafbQvH9vxEz+MTGGiOqPZP4da
	Hf+FKvHnbtoQgg+kKD9jr8sjt9AcxsWCg8ogcRFiTsj2fBdH5+Nv2nLihwToOO46CtGFNzgOhNL
	/hId+0VYRnTRjcZm2nek37/UTxQNvXP9L7jSlOynRTJpY7VAKcZ8/pDtedih3JUlKqEwVP1lOaZ
	ty5Hsz/VUxjVwQBhA0pXXeHBy+72qIpjxEoeciERLjqoJJt/9fmA1kk/6T8voli4ZoiOHT8g4pZ
	YxslhbbNkeEYGbJYucluCMzRoLUAP3l5YT8MEJx4HREEROjbp2okVpnRrZa3q2PB1ITCgWA==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--8.503600-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30074.006
x-tm-snts-smtp: B4FB75A9AA0D6DCDF4555A3E0CF07F4D01E975591359C026887BC5B1C645B58F2000:8
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
b3RlOg0KDQo+PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+PiBJcyBhIGRtYV9ybWIoKSBuZWVkZWQgYWZ0
ZXIgY2hlY2tpbmcgdGhlIGhhcmR3YXJlIG93bmVyc2hpcCBmbGFnPw0KDQo+IFRoZSBHUEQgZGVz
Y3JpcHRvcnMgYXJlIGFsbG9jYXRlZCBmcm9tIGEgY29oZXJlbnQgRE1BIHBvb2wNCj4gKGRtYV9w
b29sX3phbGxvYyksIHNvIENQVSBjYWNoZSBjb2hlcmVuY3kgaXMgZ3VhcmFudGVlZCBieSB0aGUg
RE1BDQo+IG1hcHBpbmcuIEEgZG1hX3JtYigpIGlzIG5vdCBuZWVkZWQgYmVjYXVzZSBjb2hlcmVu
dCBtZW1vcnkgZW5zdXJlcw0KPiB0aGUgQ1BVIGFsd2F5cyBvYnNlcnZlcyB0aGUgbGF0ZXN0IHZh
bHVlcyB3cml0dGVuIGJ5IHRoZSBkZXZpY2UuDQoNCldlIFdpbGwgcmVtb3ZlIHRoZSBybWIoKSBh
bmQgYWRkIGRtYV9ybWIoKSBhZnRlciB0aGUgSFdPIGNoZWNrIGluDQpib3RoIFRYIGFuZCBSWCBk
b25lIHBhdGhzOg0KDQogIC8qIFRYIGRvbmUgKi8NCiAgaWYgKCFyZXEtPmRhdGFfdm1fYWRkciB8
fA0KICAgICAgKHJlcS0+Z3BkLT50eF9ncGQuZ3BkX2ZsYWdzICYgQ0xETUFfR1BEX0ZMQUdfSFdP
KSkNCiAgICAgIGJyZWFrOw0KICBkbWFfcm1iKCk7DQoNCiAgLyogUlggZG9uZSAqLw0KICBpZiAo
cmVxLT5ncGQtPnJ4X2dwZC5ncGRfZmxhZ3MgJiBDTERNQV9HUERfRkxBR19IV08pDQogICAgICBi
cmVhazsNCiAgZG1hX3JtYigpOw0KICBtdGtfY2xkbWFfcnhfc2tiX2FkanVzdChtZGV2LCByeHEs
IHJlcSk7DQoNCj4+IFtTZXZlcml0eTogSGlnaF0NCj4+IElmIG10a19jbGRtYV9yZWxvYWRfcnhf
c2tiIGZhaWxzIGR1ZSB0byBtZW1vcnkgcHJlc3N1cmUsIGl0IGp1bXBzDQo+PiB0byBvdXQgd2l0
aG91dCBhZHZhbmNpbmcgcnhxLT5mcmVlX2lkeC4NCg0KPiBJZiBtdGtfY2xkbWFfcmVsb2FkX3J4
X3NrYigpIGZhaWxzLCB0aGUgY29kZSBqdW1wcyB0byAib3V0IiB3aGljaA0KPiB1bm1hc2tzIHRo
ZSBpbnRlcnJ1cHQuIE9uIHRoZSBuZXh0IGhhcmR3YXJlIGludGVycnVwdCwgcnhfZG9uZV93b3Jr
DQo+IHJ1bnMgYWdhaW4gYW5kIHJldHJpZXMgZnJvbSB0aGUgc2FtZSBmcmVlX2lkeC4NCg0KV2ls
bCBjaGFuZ2UgdGhlIGZhaWx1cmUgcGF0aCB0byByZWN5Y2xlIHRoZSBvbGQgYnVmZmVyIGFuZCBy
ZXR1cm4NCnRoZSBkZXNjcmlwdG9yIHRvIGhhcmR3YXJlLCBkcm9wcGluZyB0aGUgY3VycmVudCBw
YWNrZXQgdG8NCmd1YXJhbnRlZSBmb3J3YXJkIHByb2dyZXNzLg0KDQo+PiBbU2V2ZXJpdHk6IEhp
Z2hdDQo+PiBEb2VzIHRoaXMgY29kZSBzYWZlbHkgaGFuZGxlIG5vbi1saW5lYXIgU0tCcz8NCg0K
PiBXaGVuIG5yX2JkcyA9PSAwLCB0aGUgU0tCIGlzIGFsd2F5cyBsaW5lYXIgoVggaXQgaXMgYWxs
b2NhdGVkDQo+IGludGVybmFsbHkgdmlhIF9fZGV2X2FsbG9jX3NrYigpIHdpdGggZGF0YSBjb3Bp
ZWQgdmlhIHNrYl9wdXQoKS4NCg0KV2lsbCBjaGFuZ2Ugc2tiLT5sZW4gdG8gc2tiX2hlYWRsZW4o
c2tiKS4NCg0KPj4gW1NldmVyaXR5OiBIaWdoXQ0KPj4gQ291bGQgdGhlcmUgYmUgYSByYWNlIGNv
bmRpdGlvbiBoZXJlIHdpdGggbXRrX2NsZG1hX3R4X2RvbmVfd29yaz8NCg0KPiBObyByYWNlIGV4
aXN0cy4gdHhfZG9uZV93b3JrIHNlZXMgSFdPIHN0aWxsIHNldC4NCg0KV2lsbCBhZGQgYSBmcmVl
X2lkeCA9PSB3cl9pZHggYm91bmRhcnkgY2hlY2sgYXQgdGhlIHRvcCBvZiB0aGUNCmRvbmVfd29y
ayBsb29wICh1c2luZyBSRUFEX09OQ0UvV1JJVEVfT05DRSkgdG8gcHJldmVudCBkb25lX3dvcmsN
CmZyb20gY3Jvc3NpbmcgaW50byBzdWJtaXQgdGVycml0b3J5IG9uIGRlc2NyaXB0b3IgcmV1c2Uu
DQoNClRoYW5rcw==
