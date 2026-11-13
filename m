Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=59.120.207.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794551794;
	b=bunJO4Ectjtnf4hYrRjsvO23GoSMVLqBnKnNTZwmcFfzeuxa4UwccGAOZ7MmVlPxYuRG
	 LWaCObidq5NHc53f8PEEN8CBVLwLn29kOWNUttmmRHnE7YxtICoBw+TXCnvXiIC4r9YND
	 +MUiC3BTzdIi6DAKVDtMP4+jyzV0KKxbA4GROdvHfVGR5t9hRTQRAwWqKrQ+b0MUJpTYp
	 Xteet2mlbxMQnw/7t2+2Vpr5dxSwH6aQO/4ZOfOINnz41y18DhC4e/PhkXV3q59B+76Wy
	 PaLat01FfBvuytRrH5J7NXiIBQhiGgGbRoE2DyNBgqAs5V3cOqM0Hd3ytthnHtuKHww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551794;
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
	bh=DqWyeaP8EYpeALQ2OAvwyob2YuXcbB7VY/ZLud4SzOo=;
	b=2QW6bRNT6JmJ+TOmxZgs8az96DEZ/URM/r0WyYwcJMeWd8iyweD3oY1CNzfzTSyN7Wxq
	 4jLMmH52cYD0pcKm3BQkdo9lhR1sfsUJHBoZQ5BFCnebo92LpcnMuJZjIAljg6k3z/X85
	 7yn4oFRwwbzHUmZcDqBU1FuUpL/7UJiIEBn/jMpTZYD0djSIGxpaCVlXnLJBHScYRdkCt
	 gT5oMLPr8p7nyq2tUqWpuLK2cj+izW1bb1lKd6oClHMzPBGVdUi+bi7A+GYwQ3YNFkrC3
	 Lbvt++7F+Eyw2PNU/AgfF79DcpuVfw2zeZyVcLuGqg+yPXLJ5Od9yAuN9H7FW1tOctg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=compal.com;
	spf=pass smtp.mailfrom=compal.com;
	arc=none smtp.remote-ip=59.120.207.196
Received: from tpecef22.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E99606A31C;
	Fri, 13 Nov 2026 06:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07E99606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: 89771450df2c11f1a87c2323a98e90a4-20261113
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:21da27a5-7df4-40d3-900f-8b1eb71986f0,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:291e20b,CLOUDID:dfb1cb30-f289-4656-bb36-27baf4489f11,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 89771450df2c11f1a87c2323a98e90a4-20261113
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef22.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 743426839; Fri, 13 Nov 2026 14:36:20 +0800
X-UUID: 86973166df2c11f1b328fd8a884f4420-20261113
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:ffb07e99-06dc-4e81-acb0-22bc103174bd,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e276073,CLOUDID:44be3c66-4b51-4c95-bb1b-80ac6aad9c96,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50|99,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 86973166df2c11f1b328fd8a884f4420-20261113
Received: from sdbmbx12.tpe.compalcomm.com [(10.113.2.136)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES256-SHA 256/256)
	with ESMTP id 1291043534; Fri, 13 Nov 2026 14:36:15 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX12.tpe.compalcomm.com (10.113.2.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.43;
 Fri, 13 Nov 2026 14:36:13 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::23a8:5ed2:f09e:3abf]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::23a8:5ed2:f09e:3abf%11]) with mapi id
 15.02.2562.056; Fri, 13 Nov 2026 14:36:13 +0800
From: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
To: Brian Norris <briannorris@chromium.org>
CC: Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov
	<ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, Shi-Wei Yeh
	<shi-wei.yeh@mediatek.com>, Minano Tseng <Minano.tseng@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"Yu. Robert (GSM)" <robert_yu@compal.com>, "Chang. Jeff (GSM)"
	<Jeff_Chang@compal.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v11 1/6] net: wwan: t9xx: Add PCIe core
Thread-Topic: [PATCH v11 1/6] net: wwan: t9xx: Add PCIe core
Thread-Index: AQHdczlHMtKa50SmVUyj30cyupHiGA==
Date: Fri, 13 Nov 2026 06:36:13 +0000
Message-ID: <3e19cff16c1145ee8801c18a24c1c0f3@compal.com>
References: <20261105-t9xx_driver_v1-v11-0-2084aa512864@compal.com>
 <20261105-t9xx_driver_v1-v11-1-2084aa512864@compal.com>,<avY4pfjYOoJGh4en@google.com>
In-Reply-To: <avY4pfjYOoJGh4en@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30316.005
x-tm-as-result: No-10--18.703400-8.000000
x-tmase-matchedrid: FYPNOy2BwYguv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZuZd
	NI5cmL7EEwMD50omDCfiCKEWLpl9v7xENwJ2UvCElSaCdwgsOnCz3QJZlI1HSD7Qn1lMCQHYPHS
	aeqPT/nCHGYQxcw15AVIlQmKjkvU3fJYE9GoWRJE70BtMXRaQwtmfMOhnRXSp0hs/U79L1DC06I
	QNqLPXs/cLV+huLfyp6uBnihYl2pD2ny02seo5ybmRMjwGlGpyHNBTlD5KWT5dkzEmKKnHILXsc
	uuSQStqNkbUrk5jLZjIAmxL3KWaW/cHAb32Y13Y+mtDRLyNCFqgn19QHAlOzLG53EQ9QCTJbi8j
	cO5+cHXWaHdXYb1A75U4iC63III7Jvv8iTwFnicftZuMZfm2SRLkfOHvRgPi2ccOOwmG9xj0UU/
	ZFaEzIFKWDaBz8nokE4gpp2pfn9fOjVhM3xW2rB1wPM2CYnhNapw0ecwa7dOIZUCmJEsCudOuk/
	Oin8EWN/wwc82rdwTKvNGNmG0SU6+eCSMeOiOkA/lH/MvdoiYmkrgX3CciJtFJvI9LYcV3ImxnQ
	vgkai0DmyMy7NxgFnkymWss+DP3yZFhb/oEKmxI3cVVldOMbVf4f5tREmf37BOBAMr0OK5z6WCJ
	pEPfZg==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--18.703400-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30316.005
x-tm-snts-smtp: 3E27ECEF98D6235BF32FFEEEF0C3A230F1101CD8938FCBE05BDFED4838E436452000:8
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

SGkgQnJpYW4sDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KT24gRnJpLCBOb3YgMTMsIDIw
MjYgYXQgNjowNyBBTSBCcmlhbiBOb3JyaXMgPGJyaWFubm9ycmlzQGNocm9taXVtLm9yZz4gd3Jv
dGU6DQo+IE9uIFRodSwgTm92IDA1LCAyMDI2IGF0IDAzOjU2OjI3UE0gKzA4MDAsIEphY2sgV3Ug
d3JvdGU6DQpbLi4uXQ0KPiA+ICsgICAgIHJldCA9IHBjaV9zYXZlX3N0YXRlKHBkZXYpOw0KPiA+
ICsgICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAgICAgICAgIGRldl9lcnIobWRldi0+ZGV2LCAi
RmFpbGVkIHRvIHNhdmUgUENJIHN0YXRlOiAlZFxuIiwgcmV0KTsNCj4gPiArICAgICAgICAgICAg
IGdvdG8gZnJlZV9pcnE7DQo+ID4gKyAgICAgfQ0KPg0KPiBJJ20gYSBiaXQgc2tlcHRpY2FsIG9m
IGRyaXZlcnMgdGhhdCBzdGFzaCBhbiBleHRyYSBjb3B5IG9mIFBDSSBzdGF0ZS4NCj4gVGhlcmUg
YXJlIHRpbWVzIHdoZXJlIGl0J3MgbGVnaXRpbWF0ZSwgYnV0IG9mdGVuIGl0IG1lYW5zIHlvdSds
bA0KPiBpbnRyb2R1Y2UgYnVncyBvZiB5b3VyIG93bi4NCg0KQWdyZWVkLCB2MTIgd2lsbCBkcm9w
IHRoZSBjb3B5LiByZW1vdmUoKSB3aWxsIGNhbGwgcGNpX3NhdmVfc3RhdGUoKSByaWdodA0KYmVm
b3JlIHRoZSBtb2RlbSByZXNldCBhbmQgcGNpX3Jlc3RvcmVfc3RhdGUoKSByaWdodCBhZnRlciBp
dCwgdGhlIHdheQ0KdDd4eF9yZXNldF9kZXZpY2UoKSBkb2VzLCBhbmQgcHJvYmUoKSB3aWxsIG5v
IGxvbmdlciBzYXZlIGFueXRoaW5nLg0KDQpUaGUgcmVzdG9yZSBpdHNlbGYgaXMgc3RpbGwgbmVl
ZGVkOiB0aGUgcmVzZXQgcmV0dXJucyB0aGUgZW5kcG9pbnQgdG8NCml0cyBwb3dlci1vbiBkZWZh
dWx0cywgd2l0aCB0aGUgQkFScyBhbmQgdGhlIGNvbW1hbmQgcmVnaXN0ZXIgY2xlYXJlZCwNCnNv
IGNvbmZpZyBzcGFjZSBoYXMgdG8gYmUgd3JpdHRlbiBiYWNrIGZvciB0aGUgbmV4dCBkcml2ZXIg
dGhhdCBiaW5kcw0KdG8gdGhlIGRldmljZS4NCg0KWy4uLl0NCj4gPiArICAgICAvKiBXaXRob3V0
IHRoaXMgYSBydW50aW1lLVBNIHN1c3BlbmQgYWZ0ZXIgdW5iaW5kIHdvdWxkIHNuYXBzaG90IHRo
ZQ0KPiA+ICsgICAgICAqIHJlc2V0IHN0YXRlIG92ZXIgb3VyIGNvcHksIGFuZCB3aG9ldmVyIGJp
bmRzIG5leHQgZmluZHMgQkFScyB0aGUNCj4gPiArICAgICAgKiBkZXZpY2UgZG9lcyBub3QgZGVj
b2RlLg0KPiA+ICsgICAgICAqLw0KPg0KPiBJJ20gY29uZnVzZWQgYWJvdXQgdGhpcyBleHBsYW5h
dGlvbi4gWW91IGRvbid0IGV2ZXIgY2FsbA0KPiBwbV9ydW50aW1lX3B1dCgpIG9yIHNpbWlsYXIs
IHNvIHRoaXMgZGV2aWNlIGNhbiBuZXZlciBhY3R1YWxseQ0KPiBydW50aW1lLXN1c3BlbmQuIEFy
ZSB5b3UgdGFsa2luZyBhYm91dCBzb21lIGNvZGUgdGhhdCdzIG5vdCBpbmNsdWRlZCBpbg0KPiB0
aGlzIHBhdGNoIHNlcmllcz8NCj4NCj4gaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcG93ZXIvcGNp
Lmh0bWwjZGV2aWNlLXJ1bnRpbWUtcG93ZXItbWFuYWdlbWVudA0KDQpZb3UncmUgcmlnaHQsIHRo
ZSBjb21tZW50IGlzIHdyb25nLiBUaGUgZHJpdmVyIGRvZXMgbm90IHVzZSBydW50aW1lIFBNLA0K
YW5kIHRoZSBzYXZlIGFuZCByZXN0b3JlIGFyZSBuZWVkZWQgb25seSBiZWNhdXNlIG9mIHRoZSBy
ZXNldCBhYm92ZS4NClRoZSBjb21tZW50IHdpbGwgYmUgcmVtb3ZlZCBpbiB2MTIuDQoNCj4gQW55
d2F5LCBpZiB5b3UgKmRpZCogaGF2ZSBhIHByb2JsZW0gaGVyZSAuLi4gSSBleHBlY3QgdGhlIGFu
c3dlciBpcyB0bw0KPiBwcm9wZXJseSBnZXQoKSBhIHJlZmVyZW5jZSBvbiB0aGUgd2F5IG91dCwg
c28gdGhhdCBydW50aW1lX3N1c3BlbmQgaXMgbm8NCj4gbG9uZ2VyIHBvc3NpYmxlIGFmdGVyIGEg
cmVzZXQsIHVudGlsIHRoZSBuZXh0IHByb2JlKCkuDQoNCldpdGggYm90aCB0aGUgc2F2ZSBhbmQg
dGhlIHJlc3RvcmUgaW5zaWRlIHJlbW92ZSgpLCB0aGUgcmVmZXJlbmNlIHRoZQ0KUENJIGNvcmUg
YWxyZWFkeSBob2xkcyBhY3Jvc3MgLT5yZW1vdmUoKSBrZWVwcyB0aGUgZGV2aWNlIGFjdGl2ZSBi
ZXR3ZWVuDQp0aGVtLCBhbmQgY29uZmlnIHNwYWNlIGlzIGJhY2sgaW4gcGxhY2UgYmVmb3JlIHJl
bW92ZSgpIHJldHVybnMuIFNvIHYxMg0Kd2lsbCBub3QgbmVlZCBhIHJlZmVyZW5jZSBvZiBpdHMg
b3duLg0KDQo+IFlvdSBhbHNvIGhhdmUgYSBzbGlnaHRseSBkaWZmZXJlbnQgZGVzY3JpcHRpb24g
ZnJvbSB0aGUgY292ZXIgbGV0dGVyOg0KPg0KPiAiIiINCj4gICAtIG10a19wY2lfcmVtb3ZlKCkg
Y2FsbHMgcGNpX3Jlc3RvcmVfc3RhdGUoKSBhbmQgcGNpX2NsZWFyX21hc3RlcigpDQo+ICAgICBh
ZnRlciBwY2lfbG9hZF9hbmRfZnJlZV9zYXZlZF9zdGF0ZSgpOiB0aGUgcmVzZXQgbGVhdmVzIHRo
ZSBkZXZpY2UNCj4gICAgIGF0IHBvd2VyLW9uIGRlZmF1bHRzIGFuZCB0aGUgc3RhdGUgd2FzIHNh
dmVkIGFmdGVyIHBjaV9zZXRfbWFzdGVyKCkNCj4gIiIiDQoNCllvdSdyZSByaWdodCwgdGhlIGNv
ZGUgbm8gbG9uZ2VyIG1hdGNoZXMgdGhhdCBkZXNjcmlwdGlvbi4gSW4gdjEyIHRoZQ0Kc2F2ZSB3
aWxsIGhhcHBlbiBhZnRlciBwY2lfY2xlYXJfbWFzdGVyKCkgYW5kIHBjaV9kaXNhYmxlX2Rldmlj
ZSgpLCByaWdodA0KYmVmb3JlIHRoZSByZXNldCwgc28gdGhlIHJlc3RvcmVkIGNvbW1hbmQgcmVn
aXN0ZXIgaGFzIGJ1cyBtYXN0ZXJpbmcNCm9mZiwgYW5kIHRoZSB2MTIgY2hhbmdlbG9nIHdpbGwg
ZGVzY3JpYmUgaXQgdGhhdCB3YXkuDQoNCj4gSW4gYW55IGNhc2UsIHNvbWV0aGluZyBzZWVtcyBm
aXNoeSBoZXJlLg0KDQpBZ3JlZWQuIEluIHYxMiBpdCB3aWxsIGJlIGEgc2luZ2xlIHNhdmUgYW5k
IHJlc3RvcmUgYXJvdW5kIHRoZSByZXNldC4NCg0KVGhhbmtzLA0KSmFjaw==
