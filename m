Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA949E13D;
	Fri, 11 Sep 2026 05:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105987; cv=none; b=nqS+1rsBj7BFWa3rsiDURtGezbMYXOz6thBulQf99BoWToCZHGz2xtsocM6MIEcLG6pptQm3jtb/69DMHXJsQ1NpPioyXhHy6iFsnE+q55isREAnzm2gt1QurGOCPTWI20ioKO1dyHq/eN4PLqY5gSNf4J/VO5+r5sSdWSXEm7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105987; c=relaxed/simple;
	bh=nU9B5y26o33nG3YlPCB8wfzCWG6lZXHa9iV+7bKAOo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m0L9Ev/O3Nf5Y0xcHEnJUerXoY1c0+/jXrfoUxqGURzFLTOdZZGtWV2TxdxVewZ1YrSkngTfwZ4+tHgAz8tlFWIgiFZ310qblsrSNry0XV5zW7lNJSGEVRCBCHggdGx7MpidTKMbQpQgfwEyRJYs+6Prf5NNebVeXm+J/vKmyI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=dEysdXA0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="dEysdXA0"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68B5pUW312144573, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1789105891;
	bh=nU9B5y26o33nG3YlPCB8wfzCWG6lZXHa9iV+7bKAOo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dEysdXA0fiDI6M3mvKYF70SVv3S4CnFvW8bPJQf1WND0/jvxDTdjgMxrNI0tv/Xk0
	 iUqn/MA8CFDtMgKtyY4jLxJgHBcnPXDuydVf3QVxnWCQkvtpTps+OlO7yohaQv7xl2
	 daELQJcc7TImaP8TETfGYrky/7d13oDAULEjZJ12en9Dnvvf+Tycm+z4Ozh9RgYQPL
	 nrXPd6uGbuT9wX2WD8NPRVoaFIv6VKsoxRiwwrMPQZhHPApTn8ldb+5C8GdnY05v+5
	 NEuifCTIMS/RtkCOCCyC2uCUcSNNHEdju2mPdJzSG+1bniLR8Qy/xQYf2yVo/LqeHE
	 JU7jH2qD5S8jQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68B5pUW312144573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Sep 2026 13:51:31 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 11 Sep 2026 13:51:30 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.049; Fri,
 11 Sep 2026 13:51:30 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	=?gb2312?B?ucvP/r78?= <freddy_gu@realsil.com.cn>, "nb@tipi-net.de"
	<nb@tipi-net.de>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
Subject: RE: [PATCH net-next v1] net: phy: realtek: improve firmware write
 speed
Thread-Topic: [PATCH net-next v1] net: phy: realtek: improve firmware write
 speed
Thread-Index: AQHdQM8Aro+LuH6GrEqnm3voX1CC9bbHNxeAgAGpGVA=
Date: Fri, 11 Sep 2026 05:51:30 +0000
Message-ID: <52ca9b2eddf24d5088124f1274d8cb17@realsil.com.cn>
References: <20260910024927.1644-1-javen_xu@realsil.com.cn>
 <06862775-e6cb-425c-9118-d2571e8ab222@lunn.ch>
In-Reply-To: <06862775-e6cb-425c-9118-d2571e8ab222@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Pg0KPk9uIFRodSwgU2VwIDEwLCAyMDI2IGF0IDEwOjQ5OjI2QU0gKzA4MDAsIGphdmVuIHdyb3Rl
Og0KPj4gRnJvbTogSmF2ZW4gWHUgPGphdmVuX3h1QHJlYWxzaWwuY29tLmNuPg0KPj4NCj4+IEZp
cm13YXJlIGV4ZWN1dGlvbiByb3V0aW5lIHVuY29uZGl0aW9uYWxseSB1c2VzIHBoeV9tb2RpZnlf
bW1kKCkgZm9yDQo+PiBhbGwgT1BfV1JJVEUgZW50cmllcyB3aGljaCBpbnRyb2R1Y2VzIGFuIHVu
bmVjZXNzYXJ5IHJlYWQgdHJhbnNhY3Rpb24NCj4+IHdoZW4gdXBkYXRpbmcgYW4gZW50aXJlIDE2
LWJpdCByZWdpc3Rlci4gU28gd2Ugb3B0aW1pemUgdGhpcyBieQ0KPj4gY2hlY2tpbmcgYml0bWFz
ayBib3VuZGFyaWVzLiBVc2UgcGh5X3dyaXRlX21tZCgpIGRpcmVjdGx5IHRvIHNwZWVkIHVwDQo+
PiBmaXJtd2FyZSBsb2FkaW5nIHByb2Nlc3MuDQo+DQo+Rm9yIG9wdGltaXNhdGlvbnMsIGl0IGlz
IG5vcm1hbCB0byBpbmNsdWRlIHNvbWUgYmVuY2htYXJrIG51bWJlcnMgdG8gc2hvdw0KPmhvdyBi
aWcgYSBjaGFuZ2UgaXQgbWFkZS4gSXMgdGhlIGFkZGVkIGNvbXBsZXhpdHkgd29ydGggdGhlIGNo
YW5nZT8NCj4NCg0KSSB0cmFjZWQgdGhlIGFjdHVhbCBNREMvTURJTyBoYXJkd2FyZSB0cmFuc2Fj
dGlvbnMgZHVyaW5nIGZpcm13YXJlIGxvYWRpbmcgcHJvY2Vzcy4gSGVyZSBhcmUgdGhlIGJlbmNo
bWFyayBudW1iZXJzOg0KDQotIFVucGF0Y2hlZCA6IGFib3V0IDI4LDAwMCBNRElPIHRyYW5zYWN0
aW9ucy4NCi0gUGF0Y2hlZDogYWJvdXQgOSw2MDAgTURJTyB0cmFuc2FjdGlvbnMuDQoNClRoaXMg
cmVzdWx0cyBpbiBhIDY1JSByZWR1Y3Rpb24gaW4gTURJTyB0cmFmZmljLg0KDQpUaGFua3MsDQpK
YXZlbg0KDQo+ICAgICAgICBBbmRyZXcNCg==
