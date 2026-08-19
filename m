Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC726367F26;
	Wed, 19 Aug 2026 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126445; cv=none; b=R/pQ+HU3T/k0n6aWoqTTGmDzGTlUZMEN56fB7JX8bwTH7mhgnL9lSNG4jy4129bCYJ5yI3fCkDkuf4Kpf39f7m1pqqtAP9siPiP1Ob5paJg3r88tSz3ZF/tE28JmmrKiugh/+fbw7D+r5GkgNFLdkivCnrywQ5DuLxygTNiV5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126445; c=relaxed/simple;
	bh=B6Hwogk4xuc023cZNOOiB9kxauBFDCx4dg2yArYsBKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KanszgzCT1p2Z6CpYgJW9BwuYBWdV0I6nAzjlVRG5MlzcdExwdehEuydvEM7ME5Iblk6WNfF34B5Tc20GsR6urngZlasiAbRNKg1mOBatRImH5/n+W7Nk9NiBVv9smJOYfLtaQ1T9CI3TBvRDy2LdkPfkK3bDs8P+X2XXd7LOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: e2099c549ba311f1b2470fb4f881575f-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ccdc2836-a0c5-4c1d-a860-ac4d677d1f82,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7f1ae54,CLOUDID:41dade61-1095-45ea-9bc1-5380c95abe0b,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|110|111|836|865|888|898,TC:-5,Conten
	t:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e2099c549ba311f1b2470fb4f881575f-20260819
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1231623425; Wed, 19 Aug 2026 15:59:19 +0800
X-UUID: de6629f09ba311f1a9f9c99e036204b4-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:d4680aac-9536-4db1-b73a-04136b04f194,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e276073,CLOUDID:c5d4cfa0-7377-490f-a356-eb91016bc023,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|110|111|836|865|888|898,TC
	:-5,Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: de6629f09ba311f1a9f9c99e036204b4-20260819
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 489627133; Wed, 19 Aug 2026 15:59:13 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Wed, 19 Aug 2026 15:59:12 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86%11]) with mapi id
 15.02.2562.043; Wed, 19 Aug 2026 15:59:12 +0800
From: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
To: Jakub Kicinski <kuba@kernel.org>, Jack Wu via B4 Relay
	<devnull+jackbb_wu.compal.com@kernel.org>
CC: Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov
	<ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Wen-Zhi
 Huang <wen-zhi.huang@mediatek.com>, Shi-Wei Yeh <shi-wei.yeh@mediatek.com>,
	"Minano Tseng" <Minano.tseng@mediatek.com>, Matthias Brugger
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
Subject: [PATCH v6 7/7] net: wwan: t9xx: Add maintainers entry
Thread-Topic: [PATCH v6 7/7] net: wwan: t9xx: Add maintainers entry
Thread-Index: AQHdL7Cff36K70JpjEGgLe8eVrrWfw==
Date: Wed, 19 Aug 2026 07:59:11 +0000
Message-ID: <8420be34b7774eff879c1d4f83699ed0@compal.com>
References: <20260811-t9xx_driver_v1-v6-0-2c969fad57c6@compal.com>
	<20260811-t9xx_driver_v1-v6-7-2c969fad57c6@compal.com>,<20260817153821.6ee1b4a8@kernel.org>
In-Reply-To: <20260817153821.6ee1b4a8@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30142.005
x-tm-as-result: No-10--9.060000-8.000000
x-tmase-matchedrid: g7XVaO+YFMvZmVIfLFnK1FY9XYa1m8xA1gfGMJv7tZLlNADTSrHgla89
	5HEdohSr6lROzfyovSO4fx6iZUeivg/RC70xblB+bSejuH+Mi11krVIXZHd52MKcbytqP33nssb
	eQsTRANLO+1REui4fP9XNOAQ2MSi2UV8QgFV01kxIkEj2f2VroVo7GmCOJYd1O50T9A74HCu2FE
	UBwKd8yqMp+U+0bFgFhD1jXM2Nd1zTJ5ZgafpXEr2+fGXKVCfTH/DYKaRnY4A=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--9.060000-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30142.005
x-tm-snts-smtp: AA6D6C90046F3F3B7BEB2A4F68C37B6437A24F8C9D9EFB33508FFA298C45B9432000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAxNyBBdWcgMjAyNiBhdCAyMjozOCwgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVs
Lm9yZz4gd3JvdGU6DQoNCj4gT24gVHVlLCAxMSBBdWcgMjAyNiAxNToxNDoyOSArMDgwMCBKYWNr
IFd1IHZpYSBCNCBSZWxheSB3cm90ZToNCj4+IEFkZCBNQUlOVEFJTkVSUyBlbnRyeSBmb3IgdGhl
IE1lZGlhVGVrIFQ5WFggNUcgV1dBTiBtb2RlbSBkZXZpY2UNCj4+IGRyaXZlci4NCg0KDQo+IFBs
ZWFzZSBzcXVhc2ggdGhpcyBpbnRvIHRoZSBmaXJzdCBwYXRjaA0KDQpXaWxsIGZpeCBpbiB2Ny4N
Cg0KVGhhbmtzLg0KDQotLQ0KSmFjayAgICA=
