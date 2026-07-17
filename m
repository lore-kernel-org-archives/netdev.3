Received: from tpecef22.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E7383987;
	Fri, 17 Jul 2026 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784272831; cv=none; b=HlSUsisaKWlnGWkFc7a9QYjYZP7WIetGfMGJHznnBvqVxEZcMdQdxEi2n7WBOt70cDe0HcW4AfatsJmz8yaRombxKTJjsksG8DgUQbUBdkee1/om0s3I+hPI5UIVza+9DjIIF/S4ZmYcvzeWDdeSjSLrWKFxNCfAUBeeFO/NXWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784272831; c=relaxed/simple;
	bh=wI8lcX62BpT7VbksQ6l5+1yyxnb+SEZ1kLm2D3+8VbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UqEBzZzpd3j4weUTbrRMyVBe4PTX7YlMfJBEJuhh8zHODtIpnbTlBPMj3rFgNT+CUpyZpEJPnz/2AxbQdNL0ppHGQgkmWpC/KfsmHK/9SR7HJnEDNzR7mrgJrxUdhDrteO29F8X1SEEBhetlHtuRmQUr9xNiNk1GyFSGayW44Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: f8e17a2281af11f1a87c2323a98e90a4-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:44a0bb14-87d2-4146-8484-2515eef37c45,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:b40a965f-762a-4584-baab-4eebe609beea,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f8e17a2281af11f1a87c2323a98e90a4-20260717
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef22.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 431561282; Fri, 17 Jul 2026 15:20:21 +0800
X-UUID: f6ad3d0481af11f1a9f9c99e036204b4-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:4fea7553-d408-4cf8-96c0-873f99184046,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:af1a3b19-ab14-4403-9336-76696324c5a8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f6ad3d0481af11f1a9f9c99e036204b4-20260717
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 156141793; Fri, 17 Jul 2026 15:20:18 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 17 Jul 2026 15:20:17 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86%11]) with mapi id
 15.02.2562.043; Fri, 17 Jul 2026 15:20:17 +0800
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
Thread-Index: AQHdFQZRaZyRXyQV2Ei8jJ3fS8HrDbZxSABg
Date: Fri, 17 Jul 2026 07:20:16 +0000
Message-ID: <3a3b077758604433a0ddca3f3467a561@compal.com>
References: <20260709-t9xx_driver_v1-v4-4-a8c009d509c5@compal.com>,<20260716093414.231093-1-horms@kernel.org>
In-Reply-To: <20260716093414.231093-1-horms@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30074.005
x-tm-as-result: No-10--38.941900-8.000000
x-tmase-matchedrid: DEMuouwOUGIuv++HU7VXryRFbfQbCufdN0X64jGy2db7+pncqRJfy8YW
	k63M9txqU1vQdi89d9PutOqlmhRwLzTILUm/BmQIAbPIuj8krRCWkS5PNs73rQsPNAkPeS3QpBu
	7zSJhKcweWXbVSL019Ok/TbKu8KGKXu9h1RkUkL7s+7E98/tcIL81t3rGD+B+uzAg7efo/wX8aR
	XfwZTicK3qtUpZak6/J7sqSxynTWPEh7wAcG/2nFa0Ly3XpwrjE2Khi7WBTlnQHUviTbV1B+Crr
	sRoGjtI43Vy+7RF+VH6JGDM00uIR7/kF2ThSQcsHE2izCIy+zvyQ6dAmPdzEovXantxmoFY+u0Y
	8q746Onn/cYm17m4yNZetBX5Zvor/orIiVBSyHjGg/mtIFB3/NkWepC4TY0TZAvO4QbJLKPX8Un
	RAXx/6h3CjFgOLi1FoI9BFKocDXX00TOCF3AysH6eJTKwzTtE3IIiGg8YtIn7Q5aarjAe5LVbUW
	9ty8GGEcE3hXd3RBgWz8Cx25P7CjdNzyxZMiIPVkHd5sq6oNkIqNyN3IdSxRhZBaGLzNtp4aL7S
	hm/dl66Vp72lxqeCD8vgfp7qBkdGhGqsWcyt315JTDogbV4hDVl44MbImRCM3/AY2Y0EhMYLwyz
	My0J7mDnQYAMbw884TDb2CJpsuyQJYCajQ+zqZ+OD/MfMwaJOteHVGUMZ+A7dRmDCUrvTmApiTx
	lwAE5OioJOIKSEjjLmCJM+UUcQ41g3zDt1sv5D4I+2Qtnp0WiWLhmiI4dPyDilljGyWFts2R4Rg
	Zsli4D/dHyT/Xh7Q==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--38.941900-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30074.005
x-tm-snts-smtp: 79D79BC7CD2B9D7E14C6C501F4372C80DECC82CDA7812C44209097A63FE73E6F2000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU2ltb24sDQoNCj4gPiArc3RhdGljIHZvaWQgbXRrX3BvcnRfZnJlZV9vcl9iYWNrdXAoLi4u
KQ0KPg0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IERvZXMgdGhpcyBkaXJlY3RseSBieXBhc3MgdGhl
IGtyZWYgQVBJPw0KDQpXaWxsIGZpeCBpbiB2NS4gVGhlIGtyZWYgY291bnQgaXMgMSBhdCB0aGlz
IHBvaW50ICh0aGUgaW5pdGlhbA0KYWxsb2NhdGlvbiByZWZlcmVuY2Ugb25seSksIHNvIHRoZSBi
ZWhhdmlvciBpcyBjb3JyZWN0IKFYIGJ1dA0Ka3JlZl9wdXQgaXMgdGhlIHByb3BlciBBUEkuIFdp
bGwgY2hhbmdlIHRvDQprcmVmX3B1dCgmcG9ydC0+a3JlZiwgbXRrX3BvcnRfcmVsZWFzZSkuIFNh
bWUgZml4IGFwcGxpZWQgdG8NCm10a19wb3J0X3N0YWxlX2xpc3RfZ3JwX2NsZWFudXAgYmVsb3cu
DQoNCj4gPiArc3RhdGljIHN0cnVjdCBtdGtfcG9ydCAqbXRrX3BvcnRfc2VhcmNoX2J5X2lkKC4u
LikNCj4NCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBJcyBpdCBzYWZlIHRvIHBlcmZvcm0gcmFkaXgg
dHJlZSBsb29rdXBzIHdpdGhvdXQgYW4gUkNVIHJlYWQtc2lkZQ0KPiBjcml0aWNhbCBzZWN0aW9u
Pw0KDQptdGtfcG9ydF9zZWFyY2hfYnlfaWQgaXMgY2FsbGVkIGZyb20gdGhlIENMRE1BIHdvcmtx
dWV1ZSBjb250ZXh0DQoocnhfZGlzcGF0Y2gpIGFuZCBkdXJpbmcgcHJvYmUvRlNNIHN0YXJ0dXAu
IFBvcnQgY3JlYXRpb24gYW5kDQpkZXN0cnVjdGlvbiBhcmUgZHJpdmVuIGJ5IEZTTSBzdGF0ZSB0
cmFuc2l0aW9ucyBvbiB0aGUgRlNNDQprdGhyZWFkLiBQb3J0cyBhcmUgY3JlYXRlZCBiZWZvcmUg
dGhlIENMRE1BIFJYIHF1ZXVlIGlzIG9wZW5lZCwNCmFuZCB0aGUgUlggcXVldWUgaXMgc3RvcHBl
ZCBiZWZvcmUgcG9ydHMgYXJlIGRlc3Ryb3llZC4gTm8NCmNvbmN1cnJlbnQgbW9kaWZpY2F0aW9u
IG9jY3VycyBkdXJpbmcgcmFkaXggdHJlZSBsb29rdXBzLg0KDQpUaGUgdHJlZSB3YXMgaW5pdGlh
bGl6ZWQgd2l0aCBJTklUX1JBRElYX1RSRUUgKG5vdCBSQ1UtdGFnZ2VkKSwNCmFuZCBhbGwgbW9k
aWZpY2F0aW9ucyBhcmUgc2VyaWFsaXplZCBieSBGU00gc3RhdGUgb3JkZXJpbmcuDQoNCj4gPiAr
c3RhdGljIHN0cnVjdCBtdGtfcG9ydCAqbXRrX3BvcnRfc2VhcmNoX2J5X25hbWUoLi4uKQ0KPg0K
PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IERvZXMgdGhpcyByYWRpeCB0cmVlIGl0ZXJhdGlvbiByZXF1
aXJlIHJjdV9yZWFkX2xvY2soKSBwcm90ZWN0aW9uPw0KDQptdGtfcG9ydF9zZWFyY2hfYnlfbmFt
ZSBpcyBvbmx5IGNhbGxlZCBmcm9tDQptdGtfcG9ydF9pbnRlcm5hbF9vcGVuLCB3aGljaCBpcyBl
eGNsdXNpdmVseSBpbnZva2VkIGJ5IHRoZSBGU00NCmt0aHJlYWQgZHVyaW5nIG10a19mc21fY3Ry
bF9jaF9zdGFydC4gUG9ydCBjcmVhdGlvbiBhbmQNCmRlc3RydWN0aW9uIGFyZSBhbHNvIGRyaXZl
biBieSBGU00gc3RhdGUgdHJhbnNpdGlvbnMgb24gdGhlIHNhbWUNCmt0aHJlYWQuIFNpbmNlIHRo
ZSBGU00gc2VyaWFsaXplcyB0aGVzZSBvcGVyYXRpb25zLCBubyBjb25jdXJyZW50DQpwb3J0IHJl
bW92YWwgY2FuIG9jY3VyIHdoaWxlIGl0ZXJhdGluZy4NCg0KPiA+ICtzdGF0aWMgdm9pZCBtdGtf
cG9ydF9zdGFsZV9saXN0X2dycF9jbGVhbnVwKC4uLikNCj4NCj4gW1NldmVyaXR5OiBIaWdoXQ0K
PiBUaGlzIGFwcGVhcnMgdG8gYmUgYW5vdGhlciBpbnN0YW5jZSBvZiBieXBhc3NpbmcgdGhlIGty
ZWYgQVBJIGJ5DQo+IGNhbGxpbmcgbXRrX3BvcnRfcmVsZWFzZSgpIGRpcmVjdGx5IGluc3RlYWQg
b2Yga3JlZl9wdXQoKS4NCg0KV2Ugd2lsbCBmaXggaW4gdjU6DQpVc2Uga3JlZl9wdXQoJnBvcnQt
PmtyZWYsIG10a19wb3J0X3JlbGVhc2UpIGluc3RlYWQgb2YNCmNhbGxpbmcgbXRrX3BvcnRfcmVs
ZWFzZSgpIGRpcmVjdGx5LiBUaGUgY2xlYXJfYml0IGJlZm9yZQ0KaXQgZW5zdXJlcyBubyBkb3Vi
bGUgbGlzdF9kZWwsIGFuZCBrcmVmIGNvdW50IGlzIDEgc28gdGhlDQpiZWhhdmlvciBpcyB1bmNo
YW5nZWQgoVggYnV0IGtyZWZfcHV0IGlzIHRoZSBwcm9wZXIgQVBJLg0KDQo+IFtTZXZlcml0eTog
TWVkaXVtXQ0KPiBEb2VzIHRoaXMgbGVhayB0aGUgc19saXN0LT5kZXZfaWQ/IFRoZSBsaXN0IGVu
dHJpZXMgYXJlIGZyZWVkIGhlcmUgZHVyaW5nDQo+IG1vZHVsZSB1bmxvYWQsIGJ1dCB0aGVyZSBk
b2Vzbid0IGFwcGVhciB0byBiZSBhIGNvcnJlc3BvbmRpbmcgY2FsbCB0bw0KPiBpZGFfZnJlZSgp
IHRvIHJldHVybiB0aGUgZGV2X2lkIHRvIHRoZSBhbGxvY2F0b3IuDQoNCldlIHdpbGwgZml4IGlu
IHY1LEFkZCBpZGFfZnJlZSBiZWZvcmUga2ZyZWUoc19saXN0KSB0byBwcm9wZXJseSByZWxlYXNl
IHRoZQ0KICAgZGV2X2lkOg0KICAgICBpZiAoc19saXN0LT5kZXZfaWQgPj0gMCkNCiAgICAgICAg
IGlkYV9mcmVlKCZjY2NpX2Rldl9pZHMsIHNfbGlzdC0+ZGV2X2lkKTsNCiAgICAga2ZyZWUoc19s
aXN0KTsNCg0KPiA+ICtzdGF0aWMgaW50IG10a19wb3J0X3RyYl9pbml0KC4uLikNCj4NCj4gW1Nl
dmVyaXR5OiBIaWdoXQ0KPiBEb2VzIHRoaXMgYXNzaWdubWVudCBuZWVkIHRvIHRha2UgYSByZWZl
cmVuY2UgdG8gdGhlIHBvcnQgd2l0aA0KPiBrcmVmX2dldCgpPw0KDQpUaGUgVFJCIGxpZmVjeWNs
ZSBpcyBwcm90ZWN0ZWQgYnkga3JlZiBvbiB0aGUgVFJCIGl0c2VsZg0KKGtyZWZfZ2V0IGJlZm9y
ZSBzdWJtaXQsIGtyZWZfcHV0IGluIGJvdGggdGhlIGNhbGxlciBhbmQgdGhlDQpjb21wbGV0aW9u
IGNhbGxiYWNrKS4gVGhlIHBvcnQgaXMgbm90IGZyZWVkIHdoaWxlIFRSQnMgcmVmZXJlbmNlDQpp
dCChWCBwb3J0IGRlc3RydWN0aW9uIGdvZXMgdGhyb3VnaCBrcmVmX3B1dCgmcG9ydC0+a3JlZiwN
Cm10a19wb3J0X3JlbGVhc2UpLCBhbmQgVFJCX0NNRF9ESVNBQkxFIHRyaWdnZXJzDQptdGtfY3Ry
bF9jaF9mbHVzaCwgd2hpY2ggZm9yY2VzIGFsbCBwZW5kaW5nIFRSQnMgdG8gY29tcGxldGUNCmJl
Zm9yZSB0aGUgcG9ydCB0ZWFyZG93biBwcm9jZWVkcy4NCg0KPiA+ICtzdGF0aWMgaW50IG10a19w
b3J0X3NlbmRfZGF0YSguLi4pDQo+DQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBDYW4gY29uY3Vy
cmVudCB3cml0ZXJzIGNvcnJ1cHQgdGhlIHR4X3NlcSB2YXJpYWJsZT8NCg0KdHhfc2VxIGlzIGEg
cGVyLXBvcnQgOC1iaXQgc2VxdWVuY2UgbnVtYmVyIHdpdGggYSBzaW5nbGUgd3JpdGVyDQpwZXIg
cG9ydDogZXh0ZXJuYWwgcG9ydHMgYXJlIHNlcmlhbGl6ZWQgYnkgdGhlIFdXQU4gY29yZQ0Kb3Bz
X2xvY2sgbXV0ZXggYXJvdW5kIHR4L3R4X2Jsb2NraW5nIGNhbGxiYWNrcywgYW5kIGludGVybmFs
DQpwb3J0cyBhcmUgd3JpdHRlbiBleGNsdXNpdmVseSBieSB0aGUgRlNNIGt0aHJlYWQuIENvbmN1
cnJlbnQNCnRyYW5zbWlzc2lvbnMgb24gdGhlIHNhbWUgcG9ydCBkbyBub3Qgb2NjdXIuDQoNCj4g
PiArc3RhdGljIGludCBtdGtfcG9ydF9yeF9kaXNwYXRjaF9mcmFnX3NrYiguLi4pDQo+DQo+IFtT
ZXZlcml0eTogSGlnaF0NCj4gQ2FuIHRoaXMgbGVhZCB0byB1c2UtYWZ0ZXItZnJlZSBhbmQgZG91
YmxlLWZyZWUgb24gdGhlIHNrYj8NCg0KTm8uIFRoZSByZWN2IGNhbGxiYWNrIChtdGtfcG9ydF9p
bnRlcm5hbF9yZWN2KSBkb2VzIG5vdCBmcmVlDQp0aGUgc2tiIG9uIGVycm9yIKFYIGl0IHJldHVy
bnMgLUVOWElPIGFuZCBsZWF2ZXMgc2tiIG93bmVyc2hpcA0Kd2l0aCB0aGUgY2FsbGVyLiBXaGVu
IHJlY3YgcmV0dXJucyBhbiBlcnJvciwgaXQgaXMgc2FmZSB0bw0KYWNjZXNzIHRoZSBza2IgdG8g
cmVzdG9yZSBmcmFnX2xpc3QuIFRoZSBjYWxsZXINCihtdGtfcG9ydF9yeF9kaXNwYXRjaCkgdGhl
biBmcmVlcyB0aGUgc2tiIG9uY2UgaW4gdGhlDQpkcm9wX2RhdGEgcGF0aC4NCg0KPiA+ICtzdGF0
aWMgaW50IG10a19wb3J0X3J4X2Rpc3BhdGNoKC4uLikNCj4NCj4gW1NldmVyaXR5OiBIaWdoXQ0K
PiBUaGlzIGlzIHdoZXJlIHRoZSBzZWNvbmQgZnJlZSBvZiB0aGUgc2tiIG9jY3VycyB3aGVuIHBy
b3BhZ2F0aW5nDQo+IHRoZSBlcnJvciBmcm9tIHRoZSByZWN2IGNhbGxiYWNrLg0KDQpBcyBhYm92
ZSwgdGhlIHJlY3YgY2FsbGJhY2sgZG9lcyBub3QgZnJlZSB0aGUgc2tiIG9uIGVycm9yLg0KVGhl
IGRyb3BfZGF0YSBwYXRoIGluIG10a19wb3J0X3J4X2Rpc3BhdGNoIGlzIHRoZSBvbmx5IHBsYWNl
DQp0aGUgc2tiIGlzIGZyZWVkIKFYIG5vIGRvdWJsZSBmcmVlIG9jY3Vycy4NCg0KPiA+ICtzdGF0
aWMgdm9pZCBtdGtfcG9ydF9hZGRfaGVhZGVyKC4uLikNCj4NCj4gW1NldmVyaXR5OiBNZWRpdW1d
DQo+IFRoaXMgaXMgdGhlIG90aGVyIHNpZGUgb2YgdGhlIHR4X3NlcSBkYXRhIHJhY2UuDQoNClNh
bWUgYXMgYWJvdmUgoVggdHhfc2VxIGlzIHNlcmlhbGl6ZWQgYnkgdGhlIFdXQU4gY29yZSBvcHNf
bG9jaw0KZm9yIGV4dGVybmFsIHBvcnRzIGFuZCB0aGUgc2luZ2xlLXRocmVhZGVkIEZTTSBrdGhy
ZWFkIGZvcg0KaW50ZXJuYWwgcG9ydHMuDQoNCj4gPiArc3RhdGljIGludCBtdGtfcG9ydF9zdGF0
dXNfdXBkYXRlKC4uLikNCj4NCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBJcyB0aGVyZSBhIG1pc3Np
bmcgYm91bmRzIGNoZWNrIG9uIG1zZy0+cG9ydF9jbnQgaGVyZT8NCg0KVGhlIG1lc3NhZ2UgaXMg
dmFsaWRhdGVkIGJ5IGhlYWRfcGF0dGVybiwgdGFpbF9wYXR0ZXJuLCBhbmQNCnZlcnNpb24gY2hl
Y2tzIGJlZm9yZSB0aGUgbG9vcC4gVGhlIHBvcnQgZW51bWVyYXRpb24gcHJvdG9jb2wNCmJldHdl
ZW4gaG9zdCBhbmQgbW9kZW0gZ3VhcmFudGVlcyB0aGUgYnVmZmVyIGNvbnRhaW5zIGV4YWN0bHkN
CnBvcnRfY250IGVudHJpZXMuIFRoZSBtb2RlbSBmaXJtd2FyZSBpcyBhIHRydXN0ZWQgc291cmNl
IKFYDQp0aGlzIGlzIGEgY29udHJvbCBwbGFuZSBpbnRlcmZhY2UsIG5vdCBhbiB1bnRydXN0ZWQg
bmV0d29yaw0KcHJvdG9jb2wuDQoNCj4gPiArc3RhdGljIGludCBtdGtfcG9ydF9jaF9lbmFibGUo
Li4uKQ0KPg0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IENvdWxkIHRoaXMgY3JlYXRlIGFuIGluZmlu
aXRlIGxvb3AgaW4ga2VybmVsIHNwYWNlPw0KDQpUaGlzIGlzIGludGVudGlvbmFsLiBDaGFubmVs
IGVuYWJsZS9kaXNhYmxlIGFyZSBjb250cm9sIHBsYW5lDQpvcGVyYXRpb25zIHRoYXQgbXVzdCBj
b21wbGV0ZSBvciB0aW1lb3V0IKFYIGFib3J0aW5nIG1pZC1vcGVyYXRpb24NCmR1ZSB0byBhIHNp
Z25hbCB3b3VsZCBsZWF2ZSB0aGUgY2hhbm5lbCBpbiBhbiBpbmNvbnNpc3RlbnQgc3RhdGUuDQpU
aGUgbG9vcCBkb2VzIG5vdCBidXN5LXNwaW46IGVhY2ggaXRlcmF0aW9uIHNsZWVwcyBpbg0Kd2Fp
dF9ldmVudF9pbnRlcnJ1cHRpYmxlX3RpbWVvdXQgdW50aWwgdGhlIGNvbmRpdGlvbiBpcyBtZXQg
b3INCnRoZSB0aW1lb3V0IChNVEtfREZMVF9UUkJfVElNRU9VVCkgZXhwaXJlcy4gVGhlIHRpbWVv
dXQNCmd1YXJhbnRlZXMgYm91bmRlZCBleGVjdXRpb24uDQoNCj4gPiArc3RhdGljIGludCBtdGtf
cG9ydF9jaF9kaXNhYmxlKC4uLikNCj4NCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBUaGlzIGFwcGVh
cnMgdG8gaGF2ZSB0aGUgc2FtZSBpbmZpbml0ZSBsb29wIHJpc2suDQoNClNhbWUgcmVhc29uaW5n
IGFzIG10a19wb3J0X2NoX2VuYWJsZS4gVGhlIHRpbWVvdXQgZ3VhcmFudGVlcw0KYm91bmRlZCBl
eGVjdXRpb24gcGVyIGl0ZXJhdGlvbi4NCg0KPiA+ICtzdGF0aWMgaW50IG10a19wb3J0X2ludGVy
bmFsX3JlY3YoLi4uKQ0KPg0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IFRoaXMgaXMgd2hlcmUgdGhl
IHNrYiBpcyBmcmVlZCBvbiB0aGUgZXJyb3IgcGF0aCBiZWZvcmUgcmV0dXJuaW5nDQo+IC1FTlhJ
Ty4NCg0KbXRrX3BvcnRfaW50ZXJuYWxfcmVjdiBkb2VzIG5vdCBmcmVlIHRoZSBza2Igb24gdGhl
IGVycm9yIHBhdGguDQpUaGUgZHJvcF9kYXRhIGxhYmVsIHNpbXBseSByZXR1cm5zIC1FTlhJTyB3
aXRob3V0IGNhbGxpbmcNCmRldl9rZnJlZV9za2JfYW55KCkuIFRoZSBza2Igb3duZXJzaGlwIHJl
bWFpbnMgd2l0aCB0aGUgY2FsbGVyLg0KDQo+ID4gK3N0YXRpYyBpbnQgbXRrX3BvcnRfY29tbW9u
X29wZW4oLi4uKQ0KPg0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IElzIHRoaXMgdGVzdF9iaXQoKSBh
bmQgc2V0X2JpdCgpIHNlcXVlbmNlIGludGVuZGVkIHRvIHByb3ZpZGUNCj4gbXV0dWFsIGV4Y2x1
c2lvbj8NCg0KQWxsIGNhbGxlcnMgb2YgbXRrX3BvcnRfY29tbW9uX29wZW4gYWNxdWlyZSBwb3J0
X21uZ3JfZ3JwX210eA0KdmlhIG10a19wb3J0X2dldF9sb2NrZWQgYmVmb3JlIGNhbGxpbmcgdGhp
cyBmdW5jdGlvbiwgd2hpY2gNCnNlcmlhbGl6ZXMgY29uY3VycmVudCBvcGVuIGF0dGVtcHRzIG9u
IHRoZSBzYW1lIHBvcnQuIFRoZQ0KdGVzdF9iaXQvc2V0X2JpdCBzZXF1ZW5jZSBpcyBwcm90ZWN0
ZWQgYnkgdGhlIG11dGV4Lg0KDQpUaGFua3MuDQoNCkphY2sgV3U=
