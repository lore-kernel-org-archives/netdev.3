Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556333CB8F5;
	Wed, 10 Jun 2026 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085529; cv=none; b=hnZ0o0Oa+FNTnjcVhUQ9VFkPZYpI5B8AFVFp/NeqQGvvkgaZYIAo/kYmlWRq7GlJZVVfhYh9a5tHWfE3aknMScip3XL8d0M3E3s0YdI3yb1p+KMwCA/16vR7rBUDb/E7P2ThUPgGG+TeU8s5qA77/xbz4zEWTnxsN853QtLZnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085529; c=relaxed/simple;
	bh=sWa9YynIU2LvC3Mt6e37a2fH7NTi87NMosy2gBe5NQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DxRgNaBDhfYZPKRXcWRzWVqw3S9qeM8TON0F56W8p6D6xT0aUP4UjTCLxKLTNmxZiHvhhxh/TaJ+CBpuI4cuO2pkqCOsbgyq8YgXO3GMvOaDI//TX4ZJYZxqGsQfkxiVPr96p2B1H+LJmH2M3usCw7i03fXIVnBw4sodTCaXq14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=Fdk3jnFq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="Fdk3jnFq"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65A9vQVA11048669, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781085447;
	bh=sWa9YynIU2LvC3Mt6e37a2fH7NTi87NMosy2gBe5NQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Fdk3jnFqKOPESw4jGL19d0+30zM0A/pf3kfp/54QzelnrTwUc6S7fD39Qd3h6peEb
	 wn9fBZjpPTaA2kSr7mwcnMIv4ofM3ymuCVU40dWCJvk9uBJsrRDSaOqYaPvDQKvj1Q
	 z9M0oPK43YJlrVJFE2AO2/hH3KA61EKwQcqF8le+uXQPLqqb8BuChuH4bNLiTlmngc
	 ienqp0uBDcGPee2/hitWaBw12gNy0xJRhnfXCuQbC7pYFiq6PM3OZG0+KqzJZX9JYh
	 5k0PPRtHLiQyJ5XOCyGCY6LkSYk5VQyYlCcHWkUcbE23/XJP/TP/d4z8o4Podx2qzn
	 7554ayDkgaCJw==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65A9vQVA11048669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Jun 2026 17:57:26 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Jun 2026 17:57:26 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Wed,
 10 Jun 2026 17:57:26 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Javen <javen_xu@realsil.com.cn>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	=?utf-8?B?6aG+5pmT5Yab?= <freddy_gu@realsil.com.cn>, "nb@tipi-net.de"
	<nb@tipi-net.de>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>
Subject: RE: [PATCH net-next v4 0/4] Add support for RTL8261C_CG
Thread-Topic: [PATCH net-next v4 0/4] Add support for RTL8261C_CG
Thread-Index: AQHc97S7NuXfYRxcjU6whIH+ws73vLY3jYdg
Date: Wed, 10 Jun 2026 09:57:26 +0000
Message-ID: <6e1d2207b4324a77be49de0867bf7a9f@realsil.com.cn>
References: <20260609020727.1152-1-javen_xu@realsil.com.cn>
In-Reply-To: <20260609020727.1152-1-javen_xu@realsil.com.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PlN1YmplY3Q6IFtQQVRDSCBuZXQtbmV4dCB2NCAwLzRdIEFkZCBzdXBwb3J0IGZvciBSVEw4MjYx
Q19DRw0KPg0KPkZyb206IEphdmVuIFh1IDxqYXZlbl94dUByZWFsc2lsLmNvbS5jbj4NCj4NCj5B
ZGQgc3VwcG9ydCBmb3IgUlRMODI2MUNfQ0cgYW5kIGFkZCBzdXBwb3J0IGZvciBsb2FkaW5nIGZp
cm13YXJlLg0KPg0KPkphdmVuIFh1ICg0KToNCj4gIG5ldDogcGh5OiBjNDU6IGFkZCBnZW5waHlf
YzQ1X3NvZnRfcmVzZXQoKQ0KPiAgbmV0OiBwaHk6IGM0NTogYWRkIGdlbnBoeV9jNDVfY29uZmln
X21hc3Rlcl9zbGF2ZSgpDQo+ICBuZXQ6IHBoeTogcmVhbHRlazogYWRkIHN1cHBvcnQgZm9yIFJU
TDgyNjFDX0NHDQo+ICBuZXQ6IHBoeTogcmVhbHRlazogbG9hZCBmaXJtd2FyZSBmb3IgUlRMODI2
MUNfQ0cNCj4NCj4gZHJpdmVycy9uZXQvcGh5L3BoeS1jNDUuYyAgICAgICAgICAgICAgfCAgNjQg
KysrKw0KPiBkcml2ZXJzL25ldC9waHkvcmVhbHRlay9yZWFsdGVrX21haW4uYyB8IDQwNiArKysr
KysrKysrKysrKysrKysrKysrKysrDQo+IGluY2x1ZGUvbGludXgvcGh5LmggICAgICAgICAgICAg
ICAgICAgIHwgICAyICsNCj4gaW5jbHVkZS91YXBpL2xpbnV4L21kaW8uaCAgICAgICAgICAgICAg
fCAgIDMgKw0KPiA0IGZpbGVzIGNoYW5nZWQsIDQ3NSBpbnNlcnRpb25zKCspDQo+DQo+LS0NCj4y
LjQzLjANCg0KSGksIE5pY29sYWkNCg0KU29ycnksIEkgZm9yZ290IHRvIGluY2x1ZGUgeW91ciBS
ZXZpZXdlZC1ieSB0YWcgaW4gdGhpcyB2ZXJzaW9uLg0KVGhlIG9ubHkgY2hhbmdlIGluIHRoaXMg
cGF0Y2ggY29tcGFyZWQgdG8gdGhlIHByZXZpb3VzIHZlcnNpb24gaXMgdGhhdCBJIG1vdmVkIHRo
ZSBkZWZpbml0aW9uIG9mIHN0cnVjdCBkZXZpY2UgKmRldiAgdG8gcGF0Y2ggNC80IGluIHRoaXMg
c2VyaWVzLiBUaGVyZSBhcmUgbm8gb3RoZXIgbG9naWMgY2hhbmdlcy4NCk1heSBJIGFzayBpZiB5
b3VyIHJldmlldyBpcyBzdGlsbCB2YWxpZCBmb3IgdGhpcyB1cGRhdGVkIHZlcnNpb24/IElmIHNv
LCBzaG91bGQgSSByZXN1Ym1pdCBhIG5ldyB2ZXJzaW9uIHRvIGluY2x1ZGUgeW91ciB0YWcsIG9y
IHdvdWxkIHlvdSBwcmVmZXIgdG8gcmV2aWV3IGl0IGFnYWluPw0KDQpUaGFua3MsDQpCUnMsDQpK
YXZlbg0KDQoNCg==
