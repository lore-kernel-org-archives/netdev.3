Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFC389455;
	Fri, 17 Jul 2026 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285631; cv=none; b=h7DACU6yQRtMDNeh0GPxB3jxYQlcQaERHsYHORTciPnz0bqVg8R68HYXqEb8wxinipDTq8ie3LkEmBlgFPuWFK3dEJIZQ1T4u5IevFwFHr0qWeoOoU8lCPvEiS2UEg3Ztu1sNyjr3HwRw9H6DLD9CQZCE9CnuQn/zSS00I0mrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285631; c=relaxed/simple;
	bh=7d4qJ+T8ver1Wxgr9oYxe2ulrXqphYcvsiqipcUS47g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mN5KoerKn4e7IKeL3+WUjrgWUQK2SKxPG+2eM65YObWV6ZQLOU6gNhh4fCaZy3BRwDw2IOEOnvcBLb31L9AC/TExbaqO0qJkZ6qXCl8uD8Z0PxPRUuICrEWQvUYG4Bbj80A462HaBlZJ/LtneP5u3sEPMcOOPi9yFJt4Uy2HRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: c7b746fc81cd11f1b2470fb4f881575f-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:5d0155b7-8d2d-44ab-974d-ca8ee9bc5ca5,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:d497b38,CLOUDID:3a39613f-46cf-453a-bd84-ad9fc7cb0e8c,B
	ulkID:nil,BulkQuantity:0,SF:81|82|83|102|110|111|836|865|888|898,TC:-5,Con
	tent:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c7b746fc81cd11f1b2470fb4f881575f-20260717
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 463780398; Fri, 17 Jul 2026 18:53:44 +0800
X-UUID: c4e776ea81cd11f1a9f9c99e036204b4-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:8f60a7f5-c765-41cc-8bf9-c82a64e37990,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e276073,CLOUDID:bbf83c19-ab14-4403-9336-76696324c5a8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|110|111|836|865|888|898
	,TC:-5,Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c4e776ea81cd11f1a9f9c99e036204b4-20260717
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 393036499; Fri, 17 Jul 2026 18:53:39 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 17 Jul 2026 18:53:37 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86%11]) with mapi id
 15.02.2562.043; Fri, 17 Jul 2026 18:53:37 +0800
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
Thread-Index: AQHdFQZLXFhkpHGHwk+0HowAeOhgTrZxQAIhgABKmI8=
Date: Fri, 17 Jul 2026 10:53:36 +0000
Message-ID: <e4c414ee18a0428f8388ee8c847b3ad5@compal.com>
References: <20260709-t9xx_driver_v1-v4-2-a8c009d509c5@compal.com>,<20260716093355.231047-1-horms@kernel.org>,<47002e869f5b4f0985316669d2769c19@compal.com>
In-Reply-To: <47002e869f5b4f0985316669d2769c19@compal.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30074.006
x-tm-as-result: No-10--6.899800-8.000000
x-tmase-matchedrid: T+XxcFniPGwuv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZnw0
	UcwaiWo2Fz8NwhmlWx4y7EpJodRIQMz74oElhNRBJfg23t68rFm+UXZnp3CKAPQOK2Gf/k+ts/y
	bVOXU6piLzhmh6kfDWhg0mD5ur2qoJGhCEy7RQMEk+VN5SeE/Ck04j7+oEbb9WjsaYI4lh3U7nR
	P0DvgcK7YURQHAp3zKSNJOcVup57cdMK1D9OMWjF3tbFMDIsdT+t7DQ0cGcYxMJBDuBaOWuw==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--6.899800-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30074.006
x-tm-snts-smtp: D535A7E008353EB58D5883760F67864E65A4896D13E2587800F8A8BFB77112F32000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQpIaSBTaW1vbiwNCg0KQWZ0ZXIgZnVydGhlciBpbnRlcm5hbCByZXZpZXcsIHdlIGFncmVlIHRo
aXMgbmVlZHMgdG8gYmUgZml4ZWQuDQoNCk9uIEphY2sgV3Ugd3JvdGU6DQoNCj4+IFtTZXZlcml0
eTogSGlnaF0NCj4+IERvZXMgdGhpcyBjb2RlIGFwcGx5IGEgZG91YmxlIGJ5dGUtc3dhcCBvbiBi
aWctZW5kaWFuIGFyY2hpdGVjdHVyZXM/DQoNCj5UOVhYIGN1cnJlbnRseSBvbmx5IHRhcmdldHMg
eDg2IChsaXR0bGUtZW5kaWFuKSBwbGF0Zm9ybXMgd2hlcmUNCj5jcHVfdG9fbGUzMigpIGlzIGEg
bm8tb3AuIFRoZSBLY29uZmlnIGVuZm9yY2VzICJkZXBlbmRzIG9uIFBDSSAmJg0KDQpJbiB2NSB3
ZSB3aWxsIHJlbW92ZSBMRTMyX1RPX1UzMihjcHVfdG9fbGUzMiguLi4pKSBhbmQgcmV0dXJuDQpo
d19iaXRzIGRpcmVjdGx5IGluIGJvdGggbXRrX3BjaV9leHRfZDJoX2V2dF9od19iaXRzKCkgYW5k
DQptdGtfcGNpX2V4dF9oMmRfZXZ0X2h3X2JpdHMoKS4gVGhlIGN1c3RvbSBMRTMyX1RPX1UzMiBt
YWNybw0Kd2lsbCBhbHNvIGJlIHJlbW92ZWQuDQoNClRoYW5rcy4NCg0KSmFjayBXdQ0K
