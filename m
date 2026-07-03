Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C2B2367D9;
	Fri,  3 Jul 2026 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783042904; cv=none; b=b8djcF4sKMq/L+08fHQGUFK0zNx6BBXEntgSFI4oKlZAXHsrTG3FqngU2DZRJh1Q+ccZi4HhnQal6fYurvQHFFFOolX2gUN8KGVaTKOuovRDOHNlPTipDe+xgPIZ85v3uYLyIj558lXr2BOV7wrf5vOfUduHSdvQjhxh0eQNiuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783042904; c=relaxed/simple;
	bh=/W3D+rzoWkPh7MCbp4ijewyi6WoKPug+vKhz+GCY9eQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HxnZqjcgYbFSeDGLBEUeqCgO/RV/iCy0rtRPMC+I1bTIQB306UENNopfNooq7Wno2dt1wfwZ3SV8Xtr9IwN1fUK/SiwsHiotUloXbNVihckIGJxf0WKRUyRjTCAJgN9sGKIAItU/JMjmO3sqxdM0gCFisMmOrTvGx0wwSMOP+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=wilf81Gu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="wilf81Gu"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6631eKtyD2342106, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783042821;
	bh=/W3D+rzoWkPh7MCbp4ijewyi6WoKPug+vKhz+GCY9eQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=wilf81GufY2gqMi/U6EJTJ+r/0gorKKj3PSUxbEwWgST98aft1z78ewJxstyuTtky
	 sE40G32GYApbXIgqU72YfKE5AKym7UAvordc/NsRi7TpnuZ7l3AqCHDaZrV5ULxUUl
	 rXGz5dGrpvYAP43o8P8zh71mh+rVG9lMRW9AdE3bQX7BwHmCODkO0TyiD/Um5J8X2y
	 NDeY272vq5bUWYtw6QBmtoPA4IXdzNxQVXxBsrTQv3ZvKgBEew8RGSxKKSgFB9gLDy
	 dkac3hDxAsVLt5Di4XJ74Vhu1lBQeNjhWOQfPYOYzwBzXcgf2ntGO0dpF6R5QLtEq8
	 ei/4nX2u710+A==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6631eKtyD2342106
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 09:40:20 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 09:40:20 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Fri,
 3 Jul 2026 09:40:19 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	=?utf-8?B?6aG+5pmT5Yab?= <freddy_gu@realsil.com.cn>, "nb@tipi-net.de"
	<nb@tipi-net.de>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>
Subject: RE: [PATCH net-next v8 1/4] net: phy: c45: add
 genphy_c45_soft_reset()
Thread-Topic: [PATCH net-next v8 1/4] net: phy: c45: add
 genphy_c45_soft_reset()
Thread-Index: AQHdCdG4ScNNhh5l/kmL0Bh2hiJ4m7ZZnj8AgAFntcA=
Date: Fri, 3 Jul 2026 01:40:19 +0000
Message-ID: <31db813874d04c49866c6353bbf0e0c7@realsil.com.cn>
References: <20260702032020.589-1-javen_xu@realsil.com.cn>
 <20260702032020.589-2-javen_xu@realsil.com.cn>
 <9f777a53-f38e-4730-b95f-25f53cdaafc7@bootlin.com>
In-Reply-To: <9f777a53-f38e-4730-b95f-25f53cdaafc7@bootlin.com>
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

Pg0KPkhpIEphdmVuLA0KPg0KPk9uIDcvMi8yNiAwNToyMCwgamF2ZW4gd3JvdGU6DQo+PiBGcm9t
OiBKYXZlbiBYdSA8amF2ZW5feHVAcmVhbHNpbC5jb20uY24+DQo+Pg0KPj4gQWRkIGEgZ2VuZXJp
YyBDbGF1c2UgNDUgc29mdHdhcmUgcmVzZXQgaGVscGVyLiBUaGUgaGVscGVyIHNldHMgdGhlDQo+
PiByZXNldCBiaXQgaW4gdGhlIFBNQS9QTUQgY29udHJvbCByZWdpc3RlciBhbmQgd2FpdHMgdW50
aWwgdGhlIGJpdCBpcw0KPj4gY2xlYXJlZCBieSBoYXJkd2FyZS4NCj4+DQo+PiBSZXZpZXdlZC1i
eTogTmljb2xhaSBCdWNod2l0eiA8bmJAdGlwaS1uZXQuZGU+DQo+PiBTaWduZWQtb2ZmLWJ5OiBK
YXZlbiBYdSA8amF2ZW5feHVAcmVhbHNpbC5jb20uY24+DQo+PiAtLS0NCj4+IENoYW5nZXMgaW4g
djI6DQo+PiAgLSBubyBjaGFuZ2VzLCBuZXcgZmlsZQ0KPj4NCj4+IENoYW5nZXMgaW4gdjM6DQo+
PiAgLSByZS1vcmRlciBmdW5jdGlvbiBhY2NvcmRpbmcgdG8gdGhlIG9yZGVyIGluIHBoeS1jNDUu
Yw0KPj4NCj4+IENoYW5nZXMgaW4gdjQ6DQo+PiAgLSBubyBjaGFuZ2VzDQo+Pg0KPj4gQ2hhbmdl
cyBpbiB2NToNCj4+ICAtIG5vIGNoYW5nZXMNCj4+DQo+PiBDaGFuZ2VzIGluIHY2Og0KPj4gIC0g
aW5jcmVhc2UgdGltZW91dCB0byA2MDBtcw0KPj4NCj4+IENoYW5nZXMgaW4gdjc6DQo+PiAgLSBu
byBjaGFuZ2VzDQo+Pg0KPj4gQ2hhbmdlcyBpbiB2ODoNCj4+ICAtIG5vIGNoYW5nZXMNCj4+IC0t
LQ0KPj4gIGRyaXZlcnMvbmV0L3BoeS9waHktYzQ1LmMgfCAyMiArKysrKysrKysrKysrKysrKysr
KysrDQo+PiAgaW5jbHVkZS9saW51eC9waHkuaCAgICAgICB8ICAxICsNCj4+ICAyIGZpbGVzIGNo
YW5nZWQsIDIzIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
cGh5L3BoeS1jNDUuYyBiL2RyaXZlcnMvbmV0L3BoeS9waHktYzQ1LmMNCj4+IGluZGV4IDEyNjk1
MTc0MTQyOC4uNjBkMDQ0MTU2YTgzIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L3Bo
eS1jNDUuYw0KPj4gKysrIGIvZHJpdmVycy9uZXQvcGh5L3BoeS1jNDUuYw0KPj4gQEAgLTM4NCw2
ICszODQsMjggQEAgaW50IGdlbnBoeV9jNDVfY2hlY2tfYW5kX3Jlc3RhcnRfYW5lZyhzdHJ1Y3QN
Cj4+IHBoeV9kZXZpY2UgKnBoeWRldiwgYm9vbCByZXN0YXJ0KSAgfQ0KPj4gRVhQT1JUX1NZTUJP
TF9HUEwoZ2VucGh5X2M0NV9jaGVja19hbmRfcmVzdGFydF9hbmVnKTsNCj4+DQo+PiArLyoqDQo+
PiArICogZ2VucGh5X2M0NV9zb2Z0X3Jlc2V0IC0gc29mdHdhcmUgcmVzZXQgdGhlIFBIWSB2aWEg
Q2xhdXNlIDQ1DQo+PiArUE1BL1BNRCBjb250cm9sIHJlZ2lzdGVyDQo+PiArICogQHBoeWRldjog
dGFyZ2V0IHBoeV9kZXZpY2Ugc3RydWN0DQo+PiArICoNCj4+ICsgKiBSZXR1cm46IDAgb24gc3Vj
Y2VzcywgbmVnYXRpdmUgZXJybm8gb24gZmFpbHVyZS4NCj4+ICsgKi8NCj4+ICtpbnQgZ2VucGh5
X2M0NV9zb2Z0X3Jlc2V0KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpIHsNCj4+ICsgICAgIGlu
dCByZXQsIHZhbDsNCj4+ICsNCj4+ICsgICAgIHJldCA9IHBoeV9zZXRfYml0c19tbWQocGh5ZGV2
LCBNRElPX01NRF9QTUFQTUQsIE1ESU9fQ1RSTDEsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIE1ESU9fQ1RSTDFfUkVTRVQpOw0KPj4gKyAgICAgaWYgKHJldCA8IDApDQo+PiArICAg
ICAgICAgICAgIHJldHVybiByZXQ7DQo+PiArDQo+PiArICAgICByZXR1cm4gcGh5X3JlYWRfbW1k
X3BvbGxfdGltZW91dChwaHlkZXYsIE1ESU9fTU1EX1BNQVBNRCwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE1ESU9fQ1RSTDEsIHZhbCwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICEodmFsICYgTURJT19DVFJMMV9SRVNFVCksDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA1MDAwLCA2MDAwMDAsIHRy
dWUpOyB9DQo+PiArRVhQT1JUX1NZTUJPTF9HUEwoZ2VucGh5X2M0NV9zb2Z0X3Jlc2V0KTsNCj4N
Cj5DYW4geW91IG5hbWUgaXQgZ2VucGh5X2M0NV9wbWFfc29mdF9yZXNldCgpIGluc3RlYWQgPyBU
aGF0J3MgdGhlIGNvbW1vbg0KPm5hbWluZyBwYXR0ZXJuIGZvciBDNDUgZ2VuZXJpYyBoZWxwZXJz
IHRhcmdldHRpbmcgdGhlIFBNQVBNRCBNTUQuDQo+DQo+VGhpcyB3aWxsIGF2b2lkIHNvbWUgY29u
ZnVzaW9uIGFzIHNvbWUgaW4tdHJlZSBkcml2ZXJzIGFsc28gY29uZmlndXJlIHRoZQ0KPk1ESU9f
Q1RSTDFfUkVTRVQgcmVnaXN0ZXIsIGJ1dCBmcm9tIHRoZSBQSFlYUyBvciBQQ1MgTU1Ecy4NCj4N
Cg0KU3VyZS4gVGhhbmtzIGZvciByZXZpZXcuDQoNCkJScywNCkphdmVuDQoNCj5UaGFua3MsDQo+
DQo+TWF4aW1lDQo+DQo+Pg0K
