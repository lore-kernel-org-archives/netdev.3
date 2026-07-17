Received: from tpecef22.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEA73AD527;
	Fri, 17 Jul 2026 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270443; cv=none; b=ZHGQSpkQksdshf1a8IOZfhFuWRBTYDFLzsaUPUnwU4E9Vtm4lEaPZNrPO/DO6cZwPmZFDGZWf5jrBs1zfyTXCsWXvW759Zc4lgvLtFNCFldx4qCwzbaazxUp1gPcAXU8Eor3ejk+i2YscWqCrgr9kg6Gv2Iq7kjmQHdI6XGLYDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270443; c=relaxed/simple;
	bh=CzKmrvJYUGJ60GselFiC6/bm2gG/zrip/QU4pYlAp4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dvOFbb50A0R0Aa5I38Eowjrbiw8bLdbe61co1Z63N+m4eGMTF44iYtpMQ0UmP5eXUK+sfJ2MeoUACqVpP+1vLK9kpL/mn+Ig4IOHB0V59xmveiiBNLU5MLoArK8YULX/DFEP1P4dwZqWzij6vBqvDfN7waz9fXFYgrq2yXINB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: 458121c881a811f1a87c2323a98e90a4-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:4fe8bbd0-d786-4ef2-9024-9b1ec41668e6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:a5a6f350-9df4-4a32-98eb-0af8dcdad6c0,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 458121c881a811f1a87c2323a98e90a4-20260717
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef22.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1352445431; Fri, 17 Jul 2026 14:25:14 +0800
X-UUID: 4230e6b681a811f1a9f9c99e036204b4-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:36218b4b-4442-4c35-8e15-fdf0fa7560b4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:9d9a3a19-ab14-4403-9336-76696324c5a8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4230e6b681a811f1a9f9c99e036204b4-20260717
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 1815341332; Fri, 17 Jul 2026 14:25:09 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 17 Jul 2026 14:25:07 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86%11]) with mapi id
 15.02.2562.043; Fri, 17 Jul 2026 14:25:07 +0800
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
Thread-Index: AQHdFQZFiPEX/zmaIUK+niZ3qrcX0rZxPs9a
Date: Fri, 17 Jul 2026 06:25:06 +0000
Message-ID: <93775de437ca4e25bb59b58a3d083dd0@compal.com>
References: <20260709-t9xx_driver_v1-v4-1-a8c009d509c5@compal.com>,<20260716093324.230974-1-horms@kernel.org>
In-Reply-To: <20260716093324.230974-1-horms@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30074.005
x-tm-as-result: No-10--28.679700-8.000000
x-tmase-matchedrid: Bh1zlSZn7l8uv++HU7VXryRFbfQbCufdN0X64jGy2db7+pncqRJfy9MY
	tP5knBtutJEu+IhA8mRmQONkOFyfHFx3/mJTqaE1nRTJpY7VAKf+17n0Z/LNyOEKbxqb5I/nOM7
	To1x/H5Ki+3nL0nVRFIph4NsoPkdz6N5QvwB4KNS69rtClqkCjRqqRtM3sdE1Qk/eNLWwVkyb2E
	Kv2k1Jn3VLs8z/3pOJGDSYPm6vaqhl0XJKanQvEuT5AnjO7TXtGfYM6pQwWy8dsA6+8hSIIX7dt
	aR2Xu9jQczsvK9eenYHK3kw487bJnPKIjhJnXe6I2nKN0pwPwF1cj4F9+ou5CoBZSrEU3FazMaP
	/23RVhJUFGYnv32g04xIQc6akCkiIl+DhGKNIzwEjuMjWATC1dZEjr6xrP/hXZMxJiipxyDDaag
	SHxkf/lwB/az9ciInoYV0OJgphR8grfVQ41q5q3GAtBhq/68XxjpMWKqKTkOiMrI1WZc6u1BAVH
	JqFz64xourOZJGIT9OLirYKHn1uV4pH/ApSHI3HRrlF9VEpy4k6b5NIC/1tzJl3k9vFQK8W7MiR
	16X1tB/h68ua/b2wWGAskEt2wTcr3/i3/hFGkkBmIwrrOlq1ZvJRI12TKrObdHbuiVBr1kTl3/m
	hBEIUtdpauYRYIyC1c04BDYxKLaa4ymjlcrDbznxJqun3snzF+p38MndnJrusRtB/Z90Tgb9wcB
	d7K6H
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--28.679700-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30074.005
x-tm-snts-smtp: 2A477DFF0F81767C643DFDA434A1F238A161C9B40CAE47148B2C52439066C3572000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU2ltb24sDQoNCj4gPiArc3RhdGljIGlycXJldHVybl90IG10a19wY2lfaXJxX21zaXgoaW50
IGlycSwgdm9pZCAqZGF0YSkNCj4gPiArew0KPiA+ICsJaWYgKHVubGlrZWx5KCFpcnFfc3RhdGUp
IHx8DQo+ID4gKwkgICAgdW5saWtlbHkoISgoaXJxX3N0YXRlICYgR0VOTUFTSyhwcml2LT5pcnFf
Y250IC0gMSwgMCkpICYNCj4gPiArCQkgICAgICBpcnFfZGVzYy0+bXNpeF9iaXRzKSkpDQo+ID4g
KwkJcmV0dXJuIElSUV9OT05FOw0KPg0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IERvZXMgdGhpcyBs
b2dpYyBzaWxlbnRseSBkcm9wIGhhcmR3YXJlIGludGVycnVwdHMgd2hlbiBmZXdlciB0aGFuIDMy
DQo+IHZlY3RvcnMgYXJlIGFsbG9jYXRlZD8NCg0KTm8gaW50ZXJydXB0cyBhcmUgZHJvcHBlZC4g
VGhpcyBpcyB0aGUgTVNJLVggbWVyZ2VkIG1vZGUgZGVzaWduLg0KV2hlbiBmZXdlciB2ZWN0b3Jz
IGFyZSBhbGxvY2F0ZWQsIG10a19wY2lfc2V0X21zaXhfbWVyZ2VkKCkgY29uZmlndXJlcw0KdGhl
IGhhcmR3YXJlIHRvIG1lcmdlIGFsbCBpbnRlcnJ1cHQgc291cmNlcyBpbnRvIHRoZSBhdmFpbGFi
bGUgdmVjdG9ycy4NCg0KRm9yIGV4YW1wbGUsIHdpdGggaXJxX2NudD0xLCB0aGUgaGFyZHdhcmUg
bWFwcyBBTEwgc291cmNlcyAoaW5jbHVkaW5nDQpNSENDSUYgYXQgaGFyZHdhcmUgYml0IDI4KSB0
byB2ZWN0b3IgMC4gVGhlIE1TSS1YIHN0YXR1cyByZWdpc3Rlcg0Kc2hvd3MgQklUKDApLCBub3Qg
QklUKDI4KS4gU28gaXJxX2Rlc2NbMF0ubXNpeF9iaXRzID0gQklUKDApLCBhbmQNCkdFTk1BU0so
MCwwKSAmIEJJVCgwKSAmIEJJVCgwKSA9IDEgoVggdGhlIGNoZWNrIHBhc3NlcyBjb3JyZWN0bHku
DQoNClRoZSBHRU5NQVNLIGZpbHRlcnMgdG8gYWxsb2NhdGVkIHZlY3RvciBiaXRzIG9ubHksIHRo
ZW4gY2hlY2tzIGlmIHRoZQ0KY3VycmVudCBoYW5kbGVyJ3MgdmVjdG9yIGlzIHNldC4gVGhpcyB3
b3JrcyBmb3IgYm90aCBmdWxsIGFsbG9jYXRpb24NCigzMiB2ZWN0b3JzLCAxOjEgbWFwcGluZykg
YW5kIG1lcmdlZCBtb2RlIChmZXdlciB2ZWN0b3JzLCBOOjEgbWFwcGluZykuDQoNCj4gPiArCQly
ZXQgPSBwY2lfcmVxdWVzdF9pcnEocGRldiwgaSwgbXRrX3BjaV9pcnFfbXNpeCwgTlVMTCwNCj4g
PiArCQkJCSAgICAgICZpcnFfZGVzY1tpXSwgaXJxX2Rlc2NbaV0ubmFtZSk7DQo+DQo+IFtTZXZl
cml0eTogTWVkaXVtXQ0KPiBDb3VsZCB0aGlzIHRyaWdnZXIgYSAtV2Zvcm1hdC1zZWN1cml0eSBj
b21waWxlciB3YXJuaW5nPw0KDQpXZSB3aWxsIGNoYW5nZSB0byBwY2lfcmVxdWVzdF9pcnEoLi4u
LCAiJXMiLA0KaXJxX2Rlc2NbaV0ubmFtZSkgdG8gYXZvaWQgZm9ybWF0IHN0cmluZyBpc3N1ZXMu
DQoNCj4gPiArCWh3X2JpdHMgPSBtdGtfcGNpX2V4dF9oMmRfZXZ0X2h3X2JpdHMoY2gpOw0KPiA+
ICsJbXRrX3BjaV93cml0ZTMyKG1kZXYsIHJjX2Jhc2UgKyBNSENDSUZfUkMyRVBfU1dfVENITlVN
LA0KPiA+ICsJCQlmZnMoaHdfYml0cykgLSAxKTsNCj4NCj4gW1NldmVyaXR5OiBNZWRpdW1dDQo+
IFdpbGwgdGhpcyBicmVhayBjaGFubmVsIGluZGV4IGNhbGN1bGF0aW9uIG9uIGJpZy1lbmRpYW4g
c3lzdGVtcz8NCg0KVGhpcyBkcml2ZXIgdGFyZ2V0cyBNZWRpYVRlayBUOXh4IFBDSWUgV1dBTiBt
b2RlbXMgb24geDg2L0FSTTY0LUxFDQpwbGF0Zm9ybXMgb25seS4gT24gbGl0dGxlLWVuZGlhbiwg
Y3B1X3RvX2xlMzIoKSBpcyBhIG5vLW9wIGFuZA0KTEUzMl9UT19VMzIoKSBpcyBhIHNpbXBsZSBj
YXN0IKFYIG5vIGJ5dGUtc3dhcCBvY2N1cnMuIFRoZSBLY29uZmlnDQplbmZvcmNlcyBkZXBlbmRz
IG9uIFBDSSAmJiBBQ1BJLCBlZmZlY3RpdmVseSByZXN0cmljdGluZyB0byBMRQ0KcGxhdGZvcm1z
IHdoZXJlIHRoaXMgaGFyZHdhcmUgZXhpc3RzLg0KDQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBX
aGF0IGhhcHBlbnMgaWYgdGhlIGRyaXZlciBhdHRlbXB0cyB0byBzZW5kIGFuIHVubWFwcGVkIGNo
YW5uZWw/DQoNCkFsbCBjYWxsZXJzIG9mIG10a19wY2lfc2VuZF9leHRfZXZ0KCkgcGFzcyBrbm93
bi12YWxpZCBjaGFubmVsIHZhbHVlcw0KdGhhdCBhcmUgbWFwcGVkIGluIFNFVF9IV19CSVRTLiBU
aGUgaXNfcG93ZXJfb2ZfMihjaCkgY2hlY2sgYXQgdGhlDQp0b3Agb2YgdGhlIGZ1bmN0aW9uIHJl
amVjdHMgaW52YWxpZCBpbnB1dC4gVGhlIEZTTSBzaW5nbGUtdGhyZWFkDQpkZXNpZ24gZW5zdXJl
cyBhbGwgZXh0X2V2dCBzZW5kcyBnbyB0aHJvdWdoIGEgY29udHJvbGxlZCBwYXRoLCBzbw0KYW4g
dW5tYXBwZWQgY2hhbm5lbCBjYW5ub3QgcmVhY2ggZmZzKCkuDQoNCj4gPiArCXByaXYtPmV4dF9y
ZWdfYmFzZSA9IHByaXYtPmJhcjIzX2FkZHIgLSBBVFJfUENJRV9SRUdfVFJTTF9BRERSOw0KPg0K
PiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gSXMgaXQgc2FmZSB0byBzdG9yZSBhbiBvdXQtb2YtYm91
bmRzIHBvaW50ZXI/DQoNClRoaXMgaXMgYSBzdGFuZGFyZCBwYXR0ZXJuIGluIFBDSWUgTU1JTyBk
cml2ZXJzIHVzaW5nIEFkZHJlc3MNClRyYW5zbGF0aW9uIFJlZ2lzdGVycyAoQVRSKS4gVGhlIG1v
ZGVtJ3MgaW50ZXJuYWwgcmVnaXN0ZXIgc3BhY2UNCnN0YXJ0cyBhdCBhZGRyZXNzIDB4MCBpbiBp
dHMgb3duIHZpZXcsIGJ1dCB0aGUgaG9zdCBhY2Nlc3NlcyBpdA0KdGhyb3VnaCBCQVIyLzMgbWFw
cGVkIGF0IG9mZnNldCBBVFJfUENJRV9SRUdfVFJTTF9BRERSICgweDEwMDAwMDAwKS4NCg0KUHJl
LWNvbXB1dGluZyBleHRfcmVnX2Jhc2UgPSBiYXIyM19hZGRyIC0gMHgxMDAwMDAwMCBhbGxvd3Mg
dXNpbmcNCm1vZGVtIHJlZ2lzdGVyIGFkZHJlc3NlcyBkaXJlY3RseTogaW9yZWFkMzIoZXh0X3Jl
Z19iYXNlICsgcmVnX2FkZHIpLg0KZXh0X3JlZ19iYXNlIGlzIHR5cGVkIGFzIHZvaWQgX19pb21l
bSAqLCBhbiBvcGFxdWUgY29va2llIGZvciBNTUlPDQphY2Nlc3MgoVggbmV2ZXIgZGVyZWZlcmVu
Y2VkIGFzIGEgcmVndWxhciBwb2ludGVyLiBUaGUgaW9yZWFkMzIvDQppb3dyaXRlMzIgZnVuY3Rp
b25zIHBlcmZvcm0gcGxhdGZvcm0tc3BlY2lmaWMgTU1JTyBhY2Nlc3Mgb24gaXQuDQpVQlNBTiBk
b2VzIG5vdCBmbGFnIF9faW9tZW0gYXJpdGhtZXRpYy4gVGhpcyBzYW1lIHBhdHRlcm4gaXMgdXNl
ZA0KYnkgb3RoZXIga2VybmVsIFBDSWUgZHJpdmVycyAoZS5nLiwgbXRrX3Q3eHgpLg0KDQo+ID4g
K3N0YXRpYyB2b2lkIG10a19wY2lfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiA+ICt7
DQo+ID4gKwlpZiAobXRrX3BjaV9wbGRyKG1kZXYpKSB7IC4uLiB9DQo+ID4gKwlwY2lfY2xlYXJf
bWFzdGVyKHBkZXYpOw0KPiA+ICsJbXRrX3BjaV9mcmVlX2lycShtZGV2KTsNCj4gPiArCW10a19t
aGNjaWZfZXhpdChtZGV2KTsNCj4NCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBEb2VzIHRoaXMgc2Vx
dWVuY2UgcmVzdWx0IGluIHRoZSBkZXZpY2UgYmVpbmcgcG93ZXJlZCBvZmYgYmVmb3JlDQo+IHRo
ZSBPUyBpbnRlcnJ1cHQgaGFuZGxlcnMgYW5kIHdvcmtxdWV1ZXMgYXJlIHN5bmNocm9uaXplZD8N
Cg0KVGhlIGRldmljZSBpcyBub3QgbGVmdCBwb3dlcmVkIG9mZi4gbXRrX3BjaV9wbGRyKCkgY2Fs
bHMgQUNQSQ0KUFhQLl9PRkYgdGhlbiBQWFAuX09OIKFYIHRoZSBfT04gY2FsbCByZXN0b3JlcyBw
b3dlciBhbmQgYnJpbmdzDQp0aGUgUENJZSBsaW5rIGJhY2sgdXAuIEFmdGVyIF9PTiByZXR1cm5z
LCB0aGUgZGV2aWNlIGlzIHBvd2VyZWQNCm9uIGFuZCBCQVJzIGFyZSBhY2Nlc3NpYmxlLg0KDQpU
aGUgUExEUiBzZXF1ZW5jZSBpczogKDEpIF9PRkY6IHBvd2VyLWN5Y2xlIG1vZGVtIGZpcm13YXJl
LA0KKDIpIG1zbGVlcCBmb3IgcG93ZXIgZHJhaW4sICgzKSBfT046IHJlc3RvcmUgcG93ZXIgYW5k
IGxpbmsuDQpBZnRlciBzdGVwIDMsIHRoZSBkZXZpY2UgaXMgbGl2ZSB3aXRoIGEgZnJlc2ggZmly
bXdhcmUgc3RhdGUuDQoNCkFkZGl0aW9uYWxseSwgYmVmb3JlIFBMRFIsIG10a19wY2lfbWFza19p
cnEoKSBkaXNhYmxlcyB0aGUgTUhDQ0lGDQppbnRlcnJ1cHQgYXQgaGFyZHdhcmUgbGV2ZWwsIHBy
ZXZlbnRpbmcgbmV3IGludGVycnVwdHMuIEJldHdlZW4NCnBjaV9jbGVhcl9tYXN0ZXIgYW5kIG10
a19wY2lfZnJlZV9pcnEsIG10a19wY2lfZGV2X2V4aXQoKSB0ZWFycw0KZG93biBGU00gYW5kIHRy
YW5zX2N0cmwsIGVuc3VyaW5nIG5vIHdvcmtxdWV1ZXMgcmVtYWluIHNjaGVkdWxlZC4NCg0KPiA+
ICsJLyogUmVxdWVzdCBhIHNsb3QgcmVzZXQuICovDQo+ID4gKwlyZXR1cm4gUENJX0VSU19SRVNV
TFRfQ0FOX1JFQ09WRVI7DQo+DQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBXaWxsIHJldHVybmlu
ZyBQQ0lfRVJTX1JFU1VMVF9DQU5fUkVDT1ZFUiBhY3R1YWxseSBhYm9ydCB0aGUgc2xvdA0KPiBy
ZXNldD8NCg0KV2Ugd2lsbCBjaGFuZ2UgdG8gUENJX0VSU19SRVNVTFRfRElTQ09OTkVDVCBhbmQg
dXBkYXRlDQp0aGUgY29tbWVudCwgc2luY2UgdGhlIGRyaXZlciBkb2VzIG5vdCBjdXJyZW50bHkg
c3VwcG9ydCBBRVINCnJlY292ZXJ5Lg0KDQpUaGFua3MuDQoNCkphY2sgV3UNCiAgICA=
