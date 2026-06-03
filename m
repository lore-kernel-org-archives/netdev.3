Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2E11B983F;
	Wed,  3 Jun 2026 02:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780454151; cv=none; b=O1WE0HCowhYXe4FJ/arspjgUdrmAXXhEA8XBcqpxW/269RexmtJM2D4uG43CpdeR3eeftrZNYMo7LyDxkHLMklX56W19z6WUnavE9tSunoklrBqwkd/XldesuT+rXRoxzOkT34jOE4VMTeCMVZhPnqj7fYR34K+NBi2wBA0GyXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780454151; c=relaxed/simple;
	bh=WB5c4KZVKOvzdRK9kuSId8bTDm+bZtQ/TyrYLqjejYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rP6fu850PyoUjQz250b9MKw9GV0sLzYBFOzs1P2m37b+CGw8ksR7w5xqmQx3nx65JwGU1DDwP3Cj2emqApa2RNC9+aKlYHd4d/S0fpLE3gbiYJi19NEZW5yKAH8shul0WJf8ASYnHFriOuJSgkYI9R44NwSAG4wzBu53otYKfCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=cBhK3Jv9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="cBhK3Jv9"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6532Z8Rt83479927, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780454109;
	bh=WB5c4KZVKOvzdRK9kuSId8bTDm+bZtQ/TyrYLqjejYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cBhK3Jv94REoZRjZe0/dSVNl1XDYcqS+fPFms/g43gCgnOASpIhb8bv+I5X0NqZsd
	 F/iyKdO+3gOV69NCRNqWanz1VihWaglqye9cL9AkLZXkhrOF1irBVwf7P34XyzR7Rf
	 6cNncKSHFDMT2g7dCZMVAWUi/YVznOHbLvyYczu1kSFtk+jUjEOx5lq+U/OOZQYff4
	 TQ2TG+MRkNOn4voGYH1xRWAoqnPV8dLO7Ro1xbep6aNa9jjMaYOd2IAqHoDRsEzkFX
	 m/BgAaVhb2OzzhzPu0w+v7drPi5i2WoOv9BuQ6lKd08S4it5sIzRPfYYQVnLX9BnHr
	 ptefXbrFIUVQg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6532Z8Rt83479927
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 10:35:08 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 10:35:07 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Wed,
 3 Jun 2026 10:35:07 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Andrew Lunn <andrew@lunn.ch>, Nicolai Buchwitz <nb@tipi-net.de>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	=?gb2312?B?ucvP/r78?= <freddy_gu@realsil.com.cn>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
Subject: RE: [PATCH net-next v1 1/2] net: phy: realtek: add support for
 RTL8261
Thread-Topic: [PATCH net-next v1 1/2] net: phy: realtek: add support for
 RTL8261
Thread-Index: AQHc7ncQCbYjlfoUyUunc+IUY0+96LYkLbmegAf4TOA=
Date: Wed, 3 Jun 2026 02:35:07 +0000
Message-ID: <b7a623057b07403fbf52061ae1d6dc09@realsil.com.cn>
References: <20260528075226.1054-1-javen_xu@realsil.com.cn>
 <20260528075226.1054-2-javen_xu@realsil.com.cn>
 <d37ead5b1f9549d4903138cc4f70ffd0@tipi-net.de>
 <048a1319-f3c6-487f-901b-f303c7d40a1b@lunn.ch>
In-Reply-To: <048a1319-f3c6-487f-901b-f303c7d40a1b@lunn.ch>
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

Pg0KPj4gPiArc3RhdGljIGludCBydGw4MjYxeF9jb25maWdfbWFzdGVyX3NsYXZlKHN0cnVjdCBw
aHlfZGV2aWNlICpwaHlkZXYpDQo+PiA+ICt7DQo+PiA+ICsgICB1MTYgdmFsOw0KPj4gPiArICAg
LyoNCj4+ID4gKyAgICAqIENvbmZpZ3VyZSBiaXRzIDE1OjE0IG9mIE1NRCA3LjB4MDAyMA0KPj4g
PiArICAgICoNCj4+ID4gKyAgICAqIEJpdCAxNSAoRW5hYmxlKSB8IEJpdCAxNCAoVmFsdWUpIHwg
TW9kZQ0KPj4gPiArICAgICogLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tfC0tLS0t
LS0tLS0tLS0NCj4+ID4gKyAgICAqICAgICAgIDAgICAgICAgICB8ICAgICAgIDAgICAgICAgIHwg
QXV0byAoZGlzYWJsZWQpDQo+PiA+ICsgICAgKiAgICAgICAxICAgICAgICAgfCAgICAgICAwICAg
ICAgICB8IEZvcmNlIFNsYXZlDQo+PiA+ICsgICAgKiAgICAgICAxICAgICAgICAgfCAgICAgICAx
ICAgICAgICB8IEZvcmNlIE1hc3Rlcg0KPj4gPiArICAgICovDQo+PiA+ICsgICBzd2l0Y2ggKHBo
eWRldi0+bWFzdGVyX3NsYXZlX3NldCkgew0KPj4gPiArICAgY2FzZSBNQVNURVJfU0xBVkVfQ0ZH
X01BU1RFUl9GT1JDRToNCj4+ID4gKyAgICAgICAgICAgdmFsID0gUlRMODI2MVhfTVNfTUFTVEVS
Ow0KPj4gPiArICAgICAgICAgICBicmVhazsNCj4+ID4gKyAgIGNhc2UgTUFTVEVSX1NMQVZFX0NG
R19TTEFWRV9GT1JDRToNCj4+ID4gKyAgICAgICAgICAgdmFsID0gUlRMODI2MVhfTVNfU0xBVkU7
DQo+PiA+ICsgICAgICAgICAgIGJyZWFrOw0KPj4gPiArICAgY2FzZSBNQVNURVJfU0xBVkVfQ0ZH
X1VOS05PV046DQo+PiA+ICsgICBjYXNlIE1BU1RFUl9TTEFWRV9DRkdfTUFTVEVSX1BSRUZFUlJF
RDoNCj4+ID4gKyAgIGNhc2UgTUFTVEVSX1NMQVZFX0NGR19TTEFWRV9QUkVGRVJSRUQ6DQo+PiA+
ICsgICBkZWZhdWx0Og0KPj4gPiArICAgICAgICAgICB2YWwgPSBSVEw4MjYxWF9NU19BVVRPOw0K
Pj4gPiArICAgICAgICAgICBicmVhazsNCj4+ID4gKyAgIH0NCj4+ID4gKw0KPj4gPiArICAgcmV0
dXJuIHBoeV9tb2RpZnlfbW1kKHBoeWRldiwgTURJT19NTURfQU4sDQo+UlRMODI2MVhfTVVMVElH
X0NUUkwsDQo+PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgUlRMODI2MVhfTUFTVEVSX1NM
QVZFX01BU0ssIHZhbCk7IH0NCj4+DQo+PiBSVEw4MjYxWF9NVUxUSUdfQ1RSTCBpcyBhIElFRUUt
ZGVmaW5lZCByZWdpc3Rlciwgc28gaXQgY2FuIHVzZQ0KPj4gTURJT19BTl8xMEdCVF9DVFJMIGlu
c3RlYWQuDQo+PiBBbHNvIHRoZSBkZWZpbmUgZm9yIFJUTDgyNjFYX01VTFRJR19DVFJMIGNhbiBi
ZSBkcm9wcGVkLg0KPj4NCj4+IFdoaWxlIGF0IGl0IEkgd291bGQgc3VnZ2VzdCB0byBhZGQgTURJ
T19BTl8xMEdCVF9DVFJMX01TX0VOQUJMRSAoYml0DQo+PiAxNSkgYW5kIE1ESU9fQU5fMTBHQlRf
Q1RSTF9NU19WQUxVRSAoYml0IDE0KSB0bw0KPj4gaW5jbHVkZS91YXBpL2xpbnV4L21kaW8uaCBh
bmQgYWxzbyBtYWtlIHVzZSBvZiBpdC4NCj4+IFJUTDgyNjFYX01TX0FVVE8gd291bGQgYmVjb21l
DQo+DQo+SWYgdGhpcyBpcyBhbGwganVzdCBzdGFuZGFyZCA4MDIuMywgdGhlIGZ1bmN0aW9uIHNo
b3VsZCBiZSBhZGRlZCB0byBwaHktYzQ1LmMsIHNvDQo+aXQgY2FuIGJlIHVzZWQgYnkgYW55IFBI
WSBkcml2ZXIuDQo+DQo+ICAgICAgICBBbmRyZXcNCg0KVGhhbmtzIGZvciB5b3Ugc3VnZ2VzdGlv
bnMuIEFsbCB0aGUgY2hhbmdlcyB3aWxsIGJlIGFkZGVkIGludG8gbmV4dCB2ZXJzaW9uLg0KDQpC
UnMsDQpKYXZlbg0K
