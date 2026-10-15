Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D32838DC53;
	Thu, 15 Oct 2026 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056462; cv=none; b=OMoVesvJyNg3yGvW5UcOqE85wAZzu7VnpnC6m30bTiIVtusI8zg8sNDw+2XGA+C7wgd2EmgelU6rAnXWLBM9gwn9YpFvP64Kh2A8ehFsvnOUBzPw6HLcqXBxvrH3D6KhYK7JoEf6Y4Ud8736QCGelImYuSTtQx1CrqQtFm8Pkeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056462; c=relaxed/simple;
	bh=lfNaC7G0CFtt6g5HK84/0GmEi2YR+Up4b6D59qzUdj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r+slQrSqTWft/rbz1LpgcCvtfj7l6mDoxJOwxKnxflph5VHwRjGsXqdYStGGkRczFfJQQYMaHcZOdepWGmxDVvkyWjpVp7UDtNd88yw2A9UUQ+OAV0n9w+EbiwN3nZ45YA2Ygt60N5efX4dwFPdolMtj83QIVMAy4a6mqVkr07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: 8946b258c87811f1b2470fb4f881575f-20261015
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:72dd7c39-1ca2-4e8f-835d-f9612eb780c9,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:291e20b,CLOUDID:83af6095-3103-4fdb-b79c-08de0e281a5d,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8946b258c87811f1b2470fb4f881575f-20261015
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1895491617; Thu, 15 Oct 2026 17:12:24 +0800
X-UUID: 85f07972c87811f1a9f9c99e036204b4-20261015
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:6c0fc86c-41a4-4d2d-8bb1-fd28e0d23b8d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e276073,CLOUDID:42af6095-3103-4fdb-b79c-08de0e281a5d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 85f07972c87811f1a9f9c99e036204b4-20261015
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 985879827; Thu, 15 Oct 2026 17:12:19 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 15 Oct 2026 17:12:17 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::d3a3:2665:d306:e36a]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::d3a3:2665:d306:e36a%11]) with mapi id
 15.02.2562.043; Thu, 15 Oct 2026 17:12:17 +0800
From: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
CC: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg
	<johannes@sipsolutions.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Wen-Zhi Huang
	<wen-zhi.huang@mediatek.com>, Shi-Wei Yeh <shi-wei.yeh@mediatek.com>, "Minano
 Tseng" <Minano.tseng@mediatek.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "Simon Horman" <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"Yu. Robert (GSM)" <robert_yu@compal.com>, "Chang. Jeff (GSM)"
	<Jeff_Chang@compal.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v10 1/6] net: wwan: t9xx: Add PCIe core
Thread-Topic: [PATCH v10 1/6] net: wwan: t9xx: Add PCIe core
Thread-Index: AQHdXIVGsyD+Aq2AK0OYcS5BD0f6eA==
Date: Thu, 15 Oct 2026 09:12:17 +0000
Message-ID: <1686fe2dfdfd4a0890c037a53818aec1@compal.com>
References: <20261014-t9xx_driver_v1-v10-0-4d0dde3613f5@compal.com>
 <20261014-t9xx_driver_v1-v10-1-4d0dde3613f5@compal.com>,<CAFEp6-0d86Mx1gardmN74WNFCerY00Pm1B=720tqOqKhz5EE1Q@mail.gmail.com>
In-Reply-To: <CAFEp6-0d86Mx1gardmN74WNFCerY00Pm1B=720tqOqKhz5EE1Q@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30258.005
x-tm-as-result: No-10--15.752000-8.000000
x-tmase-matchedrid: q6+TWfRxf4cuv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZuZd
	NI5cmL7EqJ63gZLKrOBDdLXYWGnDb52vFMfvZjTGiu6u4shZ+fFtT5dsVizXEi+IwZW+xLvQ9PE
	ncRVMUNt0GOgwQ+Y9+BEz71V9WVMe28Nv2hpJvnB4lyF1lyvUrRnz+kO152KHwnWkERiSip3i9D
	rRYAMc5Df8MHPNq3cEyrzRjZhtElOvngkjHjojpPe3el8uYlFT28gAxP/Ts6IH2l80MvY9heUo4
	N9PjSkTthRFAcCnfMqUTGVAhB5EbQ==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--15.752000-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30258.005
x-tm-snts-smtp: 6D4F98746250E19D728C3E331916E799E093B7B9BF113165B5D1611D73E97CB82000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgTG9pYywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpPbiBXZWQsIE9jdCAxNCwgMjAy
NiBhdCA4OjQ5IFBNIExvaWMgUG91bGFpbg0KPGxvaWMucG91bGFpbkBvc3MucXVhbGNvbW0uY29t
PiB3cm90ZToNCj4gPiArI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+DQo+ID4gKyNpbmNs
dWRlIDxsaW51eC9kbWFwb29sLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvc2NoZWQu
aD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3Nw
aW5sb2NrLmg+DQo+DQo+IExvb2tzIGxpa2UgYSBsb3Qgb2YgaGVhZGVycyBmb3Igc3VjaCBhIHNt
YWxsIGhlYWRlciBmaWxlLiBDb3VsZCB5b3UNCj4gdHJpbSB0aGUgdW5uZWNlc3NhcnkgaW5jbHVk
ZXM/IEZvciBleGFtcGxlLCBzcGlubG9jay5oIGRvZXNuJ3QgYXBwZWFyDQo+IHRvIGJlIHVzZWQu
DQoNCldpbGwgZml4IGluIHYxMS4gIEFsbCBzZXZlbiBnbzogdGhlIGhlYWRlciBvbmx5IHVzZXMg
QklUKCkgYW5kIHUzMiwgc28NCjxsaW51eC9iaXRzLmg+IGFuZCA8bGludXgvdHlwZXMuaD4gYXJl
IGxlZnQsIHBsdXMgYSBmb3J3YXJkIGRlY2xhcmF0aW9uDQpmb3Igc3RydWN0IGRldmljZS4NCg0K
PiA+ICsjZGVmaW5lIFNFVF9IV19CSVRTKGRlc3QsIGNocywgbWhjY2lmLCBkZXYpCQlcDQo+ID4g
KwkoewkJCQkJCVwNCj4gPiArCQlpZiAoKGNocykgJiAoZGV2KSkJCQkJCVwNCj4gPiArCQkJKGRl
c3QpIHw9IEZJRUxEX1BSRVAobWhjY2lmLCAxKTsJCVwNCj4gPiArCX0pDQo+DQo+IEEgc3RhdGlj
IGlubGluZSBoZWxwZXIgd291bGQgYmUgY2xlYW5lci4NCg0KV2lsbCBmaXggaW4gdjExOg0KDQog
IHN0YXRpYyBpbmxpbmUgdTMyIG10a19wY2lfbWFwX2V2dF9iaXQodTMyIHZhbCwgdTMyIGZyb20s
IHUzMiB0bykNCiAgew0KCXJldHVybiAodmFsICYgZnJvbSkgPyB0byA6IDA7DQogIH0NCg0KRXZl
cnkgbWFzayBpbnZvbHZlZCBpcyBhIHNpbmdsZSBiaXQsIHNvIEZJRUxEX1BSRVAobWFzaywgMSkg
d2FzIGp1c3QNCm1hc2suICBUaGUgc2FtZSBoZWxwZXIgYWxzbyByZXBsYWNlcyB0aGUgRklFTERf
UFJFUChGSUVMRF9HRVQoKSkgcGFpcnMNCmluIG10a19wY2lfZXh0X2QyaF9ldnRfY2hzKCksIHdo
aWNoIGlzIHRoaXMgdHJhbnNsYXRpb24gaW4gdGhlIG90aGVyDQpkaXJlY3Rpb24uDQoNClRoYW5r
cywNCkphY2s=
