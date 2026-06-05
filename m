Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA293E8325;
	Fri,  5 Jun 2026 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653567; cv=none; b=cbsPQhdpsv6daYnhWcv8zxhW+fu3n2O7hkfRPwWYmcmX5eBNF6nnJKbvCulL+1spusUwQ82PakdFWLD2uqu4zX6henHQVxiOex3CtRdFRDHxPFRxV44pR6vrIB/as4/56UmNcE7AExtsfSy1PZ5w05psdsULocCny9p+B6uZpsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653567; c=relaxed/simple;
	bh=beXL6icbRMRcStpe1b88boZUqln4leUNubu3tDnjd1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mTxZWwlqptazeVoZ3eHMqlp4OxUyukHPmd4xlnjXurJhlkAx13yWR+fEg0f44/PRyDcGZOMivclHu1aUoZGwIsvKG2zVArm5nFEnC6ge4kXqaXn+Goo3FvNQr5caTCLEKN/2ahosl25Crl1qo7oGz8noscNUwaQwI5/ABc7SwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=neNwKoGO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="neNwKoGO"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6559wRrW51310688, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780653507;
	bh=beXL6icbRMRcStpe1b88boZUqln4leUNubu3tDnjd1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=neNwKoGOQIRPPN38GE/9LyzAnT83kor2F0Tb1ot29GKuARIURz8PRRxzf3yEdksiV
	 gP2JDeyYwHnqKnSc+X9Cl/eWVgMnazOT6XL2lICMlmkgFuitgQB/cR3k/dhFpfjSwn
	 ZKVCgD40X8YehhDoNjN2CrGbTFpixJ1xCrwAas4tGzHW8fCh9Jk5uUbp7rv+3zZQYa
	 zhx4fImHye3sO+Qkdeki4oup7l9fK9o+YEWyJrRrvfjMPcyKxiHiRSNzSsg3nYDVXp
	 b6kdsWUDgrwAAw2PqbKYqkW+OuHxgQuArySlDJUg1rDUoK/T8G1rQBHgwvPgEC/2o0
	 6/BHl2MDDixWA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6559wRrW51310688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jun 2026 17:58:27 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Jun 2026 17:58:27 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Fri,
 5 Jun 2026 17:58:27 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Nicolai Buchwitz <nb@tipi-net.de>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, =?gb2312?B?ucvP/r78?=
	<freddy_gu@realsil.com.cn>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
Subject: RE: [PATCH net-next v3 4/4] net: phy: realtek: load firmware for
 RTL8261C_CG
Thread-Topic: [PATCH net-next v3 4/4] net: phy: realtek: load firmware for
 RTL8261C_CG
Thread-Index: AQHc9L8BR5LGE7/b4kyGC8/Vf6LoC7YvJxOAgACRqBA=
Date: Fri, 5 Jun 2026 09:58:27 +0000
Message-ID: <2ef7327934824882a33e43eaca58d923@realsil.com.cn>
References: <20260605074328.1800-1-javen_xu@realsil.com.cn>
 <20260605074328.1800-5-javen_xu@realsil.com.cn>
 <b2b2d485db137d26e3838116560f6d59@tipi-net.de>
In-Reply-To: <b2b2d485db137d26e3838116560f6d59@tipi-net.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PkhpIEphdmVuDQo+DQo+T24gNS42LjIwMjYgMDk6NDMsIGphdmVuIHdyb3RlOg0KPj4gRnJvbTog
SmF2ZW4gWHUgPGphdmVuX3h1QHJlYWxzaWwuY29tLmNuPg0KPj4NCj4+IFRoaXMgcGF0Y2ggYWRk
cyBzdXBwb3J0IGZvciBsb2FkaW5nIGZpcm13YXJlLiBEb3dubG9hZCBzb21lIHBhcmFtZXRlcnMN
Cj4+IGZvciBSVEw4MjYxQ19DRy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKYXZlbiBYdSA8amF2
ZW5feHVAcmVhbHNpbC5jb20uY24+DQo+PiAtLS0NCj4+IENoYW5nZXMgaW4gdjI6DQo+PiAgLSBy
ZW1vdmUgX19wYWNrLCBzdHJ1Y3QgcnRsODI2MXhfZndfaGVhZGVyIGFuZCBydGw4MjYxeF9md19l
bnRyeSB3aWxsDQo+PiBub3QgcGFkDQo+PiAgLSByZXZlcnNlIHhtYXMgdHJlZSBmb3Igc29tZSBk
ZWZpbml0aW9uDQo+PiAgLSBhZGQgZXhwbGFuYXRpb24gb24gcnRsX3BoeV93cml0ZV9tbWRfYml0
cygpDQo+Pg0KPj4gQ2hhbmdlcyBpbiB2MzoNCj4+ICAtIGFkZCBzdHJ1Y3QgcnRsODI2MXhfcHJp
dg0KPj4gLS0tDQo+DQo+PiBbLi4uXQ0KPg0KPj4gK3N0YXRpYyBpbnQgcnRsODI2MXhfY29uZmln
X2luaXQoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikgew0KPj4gKyAgICAgc3RydWN0IHJ0bDgy
NjF4X3ByaXYgKnByaXYgPSBwaHlkZXYtPnByaXY7DQo+PiArICAgICBpbnQgcmV0ID0gMDsNCj4+
ICsNCj4+ICsgICAgIGlmIChwcml2LT5md19uYW1lICYmICFwcml2LT5md19sb2FkZWQpIHsNCj4+
ICsgICAgICAgICAgICAgcmV0ID0gcnRsODI2MXhfZndfbG9hZChwaHlkZXYpOw0KPj4gKyAgICAg
ICAgICAgICBpZiAocmV0KSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgcGh5ZGV2X2Vycihw
aHlkZXYsICJGaXJtd2FyZSBsb2FkaW5nIGZhaWxlZDogJWRcbiIsIHJldCk7DQo+PiArICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICsgICAgICAgICAgICAgfQ0KPj4gKyAgICAg
fQ0KPg0KPmZ3X2xvYWRlZCBsb2FkcyBvbmNlIHBlciBsaWZldGltZSwgcGh5X2luaXRfaHcoKSBk
b2VzIHNvZnRfcmVzZXQgYmVmb3JlDQo+Y29uZmlnX2luaXQuDQo+U28gYWZ0ZXIgYSByZXNldCAo
ZS5nLiByZXN1bWUpLCBhcmVuJ3QgdGhlIHBhdGNoZXMgZ29uZSBhbmQgbmV2ZXIgcmUtYXBwbGll
ZD8NCj5lbjg4MTFoIGZvciBleGFtcGxlIHJlLXJ1bnMgZXZlcnkgY29uZmlnX2luaXQgLSBidXQg
anVzdCBndWVzc2luZyBhcyBJIGRvbid0DQo+a25vdyB0aGUgaW50ZXJuYWxzIG9mIHlvdXIgZncu
DQo+DQo+PiBbLi4uXQ0KPg0KPlRoYW5rcywNCj5OaWNvbGFpDQoNCkhpLCBOaWNvbGFpDQoNCkZv
ciBSVEw4MjYxQ19DRywgdGhlIHBhdGNoZXMgd2lsbCBub3QgYmUgbG9zdCBhZnRlciByZXN1bWUg
b3Igc29mdF9yZXNldC4gVGhleSBvbmx5IG5lZWQgdG8gYmUgZG93bmxvYWRlZCBhZ2FpbiBhZnRl
ciBhIHBvd2VyIGN5Y2xlIG9yIGEgaGFyZHdhcmUgcmVzZXQuDQpTbyB0aGUgZndfbG9hZGVkIGZs
YWcgaXMgaW50ZW5kZWQgdG8gYXZvaWQgcmVsb2FkaW5nIHRoZSBzYW1lIHBhcmFtZXRlcnMgbXVs
dGlwbGUgdGltZXMgZHVyaW5nIHRoZSBQSFkgZGV2aWNlIGxpZmV0aW1lLg0KDQpUaGFua3MsDQpC
UnMsDQpKYXZlbg0K
