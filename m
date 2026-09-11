Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63F739B97B;
	Fri, 11 Sep 2026 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119563; cv=none; b=cG9JwuJV4qSYezJiB/xeLmxlKeIUUsHy0+JlcBwGV73oczv0h+6zkPZ+4fD6S8bSdvXv36Ox3e42PA/vPgFeghj6sq8iCV6S4bfuY9U8iBtU8NMmCu2vRYzkyNeaI0woIk009aZhkF3yKX0VPr1TXu/UwF34mSiYUXH1IeKqjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119563; c=relaxed/simple;
	bh=y72/QzXDG8tc9kO9AQkK2ciWZDMBRhIby0nhauW63EM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=auDIGf65lTK+obzqYGk+ymbEUVXQ2PJGgZC39EUyYeLrD55QxWiV0p1Db9zH+lFUP2in/4s8q1XNWSYf8RBplywSrShOwqAL+pJjoFPYi6d6z2gn/3wP8ylbKlrXKUrX2fEJ0sXpx3H3fvWSuvPjHPbP+Uo3cY3DcaGrupTRz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=cMQZFRQF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="cMQZFRQF"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68B9c15d92286366, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1789119482;
	bh=y72/QzXDG8tc9kO9AQkK2ciWZDMBRhIby0nhauW63EM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cMQZFRQFqm5r3VX2KfPCAJxmQZs0ideRjZQKq1zN0RNk+p3HUi8aWdORJB0nySQ0d
	 nra1CQIQDcgPey8fflUBfoIYEbNdDQH5RzC/m38Z7D53+Jmt9I37svFEvvsp15Sb0D
	 sRbC9FD4Y+ERGUkA9ouxNw7ERMOc93HAP12FcHfXVcCn9kCkNqhYTC9vUIlY2FQ8TY
	 /JEv9j3SEFN5XdCB12wdLQ6hjwXwYBmE62Dub2ziwSzYDdLNh7KDf7TR3u5J4FsbXB
	 T/yTsSPyg8rqGYD3Re/+ph1JsurZm9cqUHtvaT9BslqD17TCqqb6ro4y0x0ZzsoQhA
	 +1i5kUSKEc4Fw==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68B9c15d92286366
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Sep 2026 17:38:01 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 11 Sep 2026 17:38:01 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.049; Fri,
 11 Sep 2026 17:38:01 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Nicolai Buchwitz <nb@tipi-net.de>
CC: Andrew Lunn <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, =?gb2312?B?ucvP/r78?=
	<freddy_gu@realsil.com.cn>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
Subject: RE: [PATCH net-next v1] net: phy: realtek: improve firmware write
 speed
Thread-Topic: [PATCH net-next v1] net: phy: realtek: improve firmware write
 speed
Thread-Index: AQHdQM8Aro+LuH6GrEqnm3voX1CC9bbHNxeAgAGpGVD//5fSAIAAqKRw
Date: Fri, 11 Sep 2026 09:38:01 +0000
Message-ID: <90de3f8b5e00417fb8ad6038cf0855e1@realsil.com.cn>
References: <20260910024927.1644-1-javen_xu@realsil.com.cn>
 <06862775-e6cb-425c-9118-d2571e8ab222@lunn.ch>
 <52ca9b2eddf24d5088124f1274d8cb17@realsil.com.cn>
 <1e621cbb34e8077a76fb44b72c8c44fc@tipi-net.de>
In-Reply-To: <1e621cbb34e8077a76fb44b72c8c44fc@tipi-net.de>
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

Pg0KPg0KPkhpIEphdmVuDQo+DQo+T24gMTEuOS4yMDI2IDA3OjUxLCBKYXZlbiB3cm90ZToNCj4+
Pg0KPj4+IE9uIFRodSwgU2VwIDEwLCAyMDI2IGF0IDEwOjQ5OjI2QU0gKzA4MDAsIGphdmVuIHdy
b3RlOg0KPj4+PiBGcm9tOiBKYXZlbiBYdSA8amF2ZW5feHVAcmVhbHNpbC5jb20uY24+DQo+Pj4+
DQo+Pj4+IEZpcm13YXJlIGV4ZWN1dGlvbiByb3V0aW5lIHVuY29uZGl0aW9uYWxseSB1c2VzIHBo
eV9tb2RpZnlfbW1kKCkgZm9yDQo+Pj4+IGFsbCBPUF9XUklURSBlbnRyaWVzIHdoaWNoIGludHJv
ZHVjZXMgYW4gdW5uZWNlc3NhcnkgcmVhZA0KPj4+PiB0cmFuc2FjdGlvbiB3aGVuIHVwZGF0aW5n
IGFuIGVudGlyZSAxNi1iaXQgcmVnaXN0ZXIuIFNvIHdlIG9wdGltaXplDQo+Pj4+IHRoaXMgYnkg
Y2hlY2tpbmcgYml0bWFzayBib3VuZGFyaWVzLiBVc2UgcGh5X3dyaXRlX21tZCgpIGRpcmVjdGx5
IHRvDQo+Pj4+IHNwZWVkIHVwIGZpcm13YXJlIGxvYWRpbmcgcHJvY2Vzcy4NCj4+Pg0KPj4+IEZv
ciBvcHRpbWlzYXRpb25zLCBpdCBpcyBub3JtYWwgdG8gaW5jbHVkZSBzb21lIGJlbmNobWFyayBu
dW1iZXJzIHRvDQo+Pj4gc2hvdyBob3cgYmlnIGEgY2hhbmdlIGl0IG1hZGUuIElzIHRoZSBhZGRl
ZCBjb21wbGV4aXR5IHdvcnRoIHRoZQ0KPj4+IGNoYW5nZT8NCj4+Pg0KPj4NCj4+IEkgdHJhY2Vk
IHRoZSBhY3R1YWwgTURDL01ESU8gaGFyZHdhcmUgdHJhbnNhY3Rpb25zIGR1cmluZyBmaXJtd2Fy
ZQ0KPj4gbG9hZGluZyBwcm9jZXNzLiBIZXJlIGFyZSB0aGUgYmVuY2htYXJrIG51bWJlcnM6DQo+
Pg0KPj4gLSBVbnBhdGNoZWQgOiBhYm91dCAyOCwwMDAgTURJTyB0cmFuc2FjdGlvbnMuDQo+PiAt
IFBhdGNoZWQ6IGFib3V0IDksNjAwIE1ESU8gdHJhbnNhY3Rpb25zLg0KPj4NCj4+IFRoaXMgcmVz
dWx0cyBpbiBhIDY1JSByZWR1Y3Rpb24gaW4gTURJTyB0cmFmZmljLg0KPg0KPkNhbiB5b3UgcGxl
YXNlIGFkZCB0aGVzZSBudW1iZXJzIHRvIHRoZSBjb21taXQ/DQo+DQo+VGhlIHBhdGNoIGl0c2Vs
ZiBsb29rcyBmaW5lIGFuZCBhbHNvIGNvbXBpbGVzIGNsZWFubHkgb24gbXkgbWFjaGluZS4NCj5T
byB3aXRoIHRoZSBudW1iZXIgYWRkZWQsIEknZCBiZSBoYXBweSB0byBSLWIuDQo+DQoNCkhpIE5p
Y29sYWksDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgdGVzdGluZy4gDQpJIHdpbGwgYWRk
IHRoZXNlIGJlbmNobWFyayBudW1iZXJzIHRvIHRoZSBjb21taXQgbWVzc2FnZSBhbmQgc2VuZCBv
dXQgYSB2MiBwYXRjaC4NCg0KVGhhbmtzLA0KSmF2ZW4NCg0K
