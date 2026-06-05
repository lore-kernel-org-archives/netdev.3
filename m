Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322B330BB8A;
	Fri,  5 Jun 2026 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780629674; cv=none; b=mEZdDyZ2M3Mga1KO8buoRT/c3FDSHdK9Xc8PquWH/qpB8xKXZAmd2b91RhEA8lPaWek57wIYoPlGvgahsWQZn1832Qt66L3ALPoZlyDJHvUakfxSflw4Vl61ju2l4vi5jQUQD4QN9sDAdnBbk1YdogDL8TBXFyBTa1gp9tEQae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780629674; c=relaxed/simple;
	bh=hXVgQNlynljjtrPJ+dfgtb/MzNa9jC6vOZPzn9oR8SE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BD7uLKGZzBwtE5WdM0n8nqDAFQ2wTLxS5M3hdJabvKpZJqOSK9en5py4x5PU3scWt1q6Gf5YxL/bfDBIfyWesM0wpNnqMymmspQOvHBUZvHvuJre554EaQOrpMkwjuOaEsFqMRBDHyVgOy3E2hqJ1pfUbd7ahuINWtarOwoOgjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=mQync9q4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="mQync9q4"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6553Ju8121096197, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780629597;
	bh=hXVgQNlynljjtrPJ+dfgtb/MzNa9jC6vOZPzn9oR8SE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mQync9q4o1blY6pa8OpijIG4SzszRJSb5RQ9T5HTHjY/w0UcO5Gz7L00wrpK5gI/5
	 jm+72V8lxCufpZEj2xjj+LCFTXzuJLbl2Hoav7v8+RaqUG7gLgJzLcuQTStcs/CU5n
	 LtyOLPD94McYzp1CkyVZKjVPddMSuGFiwC+Zm/3lLINIdxJZKD8cJkAOoV9Nh56gB3
	 HKIOzaN+WWutZ8IgaG8s4yr3KalQRxKyl5xHPaLs8+vmLnIeQlH7QvzPyw0CgLarqF
	 AG092lIoSbBeuJun423Q+7IF8Uh1SJo2Zz6icpqgIk4pxuuRHSLhPQtfxQMhR5t9Ol
	 +RVtUFyGVa82w==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6553Ju8121096197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jun 2026 11:19:57 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Jun 2026 11:19:56 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Fri,
 5 Jun 2026 11:19:56 +0800
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
Subject: RE: [PATCH net-next v2 2/4] net: phy: c45: add
 genphy_c45_config_master_slave()
Thread-Topic: [PATCH net-next v2 2/4] net: phy: c45: add
 genphy_c45_config_master_slave()
Thread-Index: AQHc8/WnKcsUE7Sb+kW6lZTT1vLRgrYtkA+AgAG8GVA=
Date: Fri, 5 Jun 2026 03:19:56 +0000
Message-ID: <91b78641a1da403f865eb81c03c3ce10@realsil.com.cn>
References: <20260604074209.93-1-javen_xu@realsil.com.cn>
 <20260604074209.93-3-javen_xu@realsil.com.cn>
 <521e53fe8f22eb938ea7b9073516378f@tipi-net.de>
In-Reply-To: <521e53fe8f22eb938ea7b9073516378f@tipi-net.de>
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

PkhpIEphdmVuDQo+DQo+T24gNC42LjIwMjYgMDk6NDIsIGphdmVuIHdyb3RlOg0KPj4gRnJvbTog
SmF2ZW4gWHUgPGphdmVuX3h1QHJlYWxzaWwuY29tLmNuPg0KPj4NCj4+IEFkZCBhIGdlbmVyaWMg
aGVscGVyIHRvIGNvbmZpZ3VyZSBmb3JjZWQgbWFzdGVyL3NsYXZlIG1vZGUgZm9yIENsYXVzZQ0K
Pj4gNDUNCj4+IFBIWXMgdXNpbmcgdGhlIDEwR0JBU0UtVCBBTiBjb250cm9sIHJlZ2lzdGVyLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IEphdmVuIFh1IDxqYXZlbl94dUByZWFsc2lsLmNvbS5jbj4N
Cj4NCj4+IFsuLi5dDQo+DQo+PiArLyoqDQo+PiArICogZ2VucGh5X2M0NV9jb25maWdfbWFzdGVy
X3NsYXZlIC0gQ29uZmlndXJlIE1hc3Rlci9TbGF2ZSBzZXR0aW5nDQo+PiArZm9yDQo+PiBDNDUg
UEhZcw0KPj4gKyAqIEBwaHlkZXY6IHRhcmdldCBwaHlfZGV2aWNlIHN0cnVjdA0KPj4gKyAqDQo+
PiArICogRGVzY3JpcHRpb246IENvbmZpZ3VyZXMgdGhlIE1hc3Rlci9TbGF2ZSBtYW51YWwgc2V0
dGluZyBpbiB0aGUNCj4+ICsgKiAxMEdCQVNFLVQgY29udHJvbCByZWdpc3RlciAoTU1EIDcsIFJl
Z2lzdGVyIDB4MDAyMCkgYWNjb3JkaW5nIHRvDQo+PiArICogSUVFRSA4MDIuMyBzdGFuZGFyZHMu
DQo+PiArICovDQo+DQo+UGxlYXNlIGRvY3VtZW50IHRoZSByZXR1cm4gdmFsdWUgKDAgPSB1bmNo
YW5nZWQsIDEgPSBjaGFuZ2VkLCA8MCBlcnJubyksIGxpa2UNCj5pdCBpcyBkb25lIGZvciBnZW5w
aHlfYzQ1X2FuX2NvbmZpZ19hbmVnKCkuDQo+DQo+PiAraW50IGdlbnBoeV9jNDVfY29uZmlnX21h
c3Rlcl9zbGF2ZShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KSB7DQo+PiArICAgICB1MTYgdmFs
ID0gMDsNCj4+ICsNCj4+ICsgICAgIHN3aXRjaCAocGh5ZGV2LT5tYXN0ZXJfc2xhdmVfc2V0KSB7
DQo+PiArICAgICBjYXNlIE1BU1RFUl9TTEFWRV9DRkdfTUFTVEVSX0ZPUkNFOg0KPj4gKyAgICAg
ICAgICAgICB2YWwgPSBNRElPX0FOXzEwR0JUX0NUUkxfTVNfRU5BQkxFIHwNCj5NRElPX0FOXzEw
R0JUX0NUUkxfTVNfVkFMVUU7DQo+PiArICAgICAgICAgICAgIGJyZWFrOw0KPj4gKyAgICAgY2Fz
ZSBNQVNURVJfU0xBVkVfQ0ZHX1NMQVZFX0ZPUkNFOg0KPj4gKyAgICAgICAgICAgICB2YWwgPSBN
RElPX0FOXzEwR0JUX0NUUkxfTVNfRU5BQkxFOw0KPj4gKyAgICAgICAgICAgICBicmVhazsNCj4+
ICsgICAgIGNhc2UgTUFTVEVSX1NMQVZFX0NGR19VTktOT1dOOg0KPj4gKyAgICAgY2FzZSBNQVNU
RVJfU0xBVkVfQ0ZHX01BU1RFUl9QUkVGRVJSRUQ6DQo+PiArICAgICBjYXNlIE1BU1RFUl9TTEFW
RV9DRkdfU0xBVkVfUFJFRkVSUkVEOg0KPj4gKyAgICAgZGVmYXVsdDoNCj4+ICsgICAgICAgICAg
ICAgYnJlYWs7DQo+PiArICAgICB9DQo+DQo+UGVyIElFRUUgODAyLjMgKDQ1LjIuNy4xMC4zKSwg
Ny4zMi4xMyAocG9ydCB0eXBlKSBpcyBhIGNvcHkgb2YgOS4xMCAvDQo+Q1RMMTAwMF9QUkVGRVJf
TUFTVEVSLCBsaWtlIGl0IGlzIGRvbmUgaW4gYzIyJ3MNCj5nZW5waHlfc2V0dXBfbWFzdGVyX3Ns
YXZlKCkuDQo+DQo+U28gc2V0IGl0IGZvciBNQVNURVJfUFJFRkVSUkVELCBjbGVhciBpdCBmb3Ig
U0xBVkVfUFJFRkVSUkVEIGFuZCBsZWF2ZQ0KPlVOS05PV04vVU5TVVBQT1JURUQgdW50b3VjaGVk
IChyZXR1cm4gMCkuIFVzZSAtRU9QTk9UU1VQUCBvbmx5IGZvcg0KPmRlZmF1bHQuDQoNClRoYW5r
cyBmb3IgeW91ciByZXZpZXcuDQpJIGhhdmUgYXBwbGllZCBhbGwgdGhlIHN1Z2dlc3Rpb25zIHRv
IHBhdGNoIHYzLg0KDQpUaGFua3MsDQpCUnMsDQpKYXZlbg0KDQo+DQo+PiBbLi4uXQ0KPg0KPlRo
YW5rcywNCj5OaWNvbGFpDQo=
