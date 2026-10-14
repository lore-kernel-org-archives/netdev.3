Received: from outbound.baidu.com (mx16.baidu.com [111.202.115.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B064547069;
	Wed, 14 Oct 2026 02:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946719; cv=none; b=CtLcXrBYv5mDjFRwbm3BOOOuxoIp5wpQCBtHHfi1z+Jl0ztYALriBD1t/dGqxMLAJv8cwhcofQUnUOPJI9ji5/fKV0Zb9dMZj58+2usWEiiSfZKopas97ssotXaCuPI1kOweNLsuj1wmuBqhcZwZykC2AbS7M71bfVIaCTJJPtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946719; c=relaxed/simple;
	bh=0IA0JOmqfBGmUNQPoIZE4r6R7pwjYsrxhRYxpkC7Ib4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fV9AIkVp/zYJA8kKGcmkileJNjtOFZ8qMwgB/01WMqGzods73/2QAqAwQI9/uZna+LbyFbEZ3GRNvw9KiTnLT701uT/Xc4GIgN1o21TrIb7dFSHveDJQKEU2lmmC1K3y7BP/HQElFr/mR05q/7x7uEzOXHTvyTi8RXzz9Jsbdr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=Vs5HHC0H; arc=none smtp.client-ip=111.202.115.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="Vs5HHC0H"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.46
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "netdev-bot+sinfo@kernel.org" <netdev-bot+sinfo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIIG5ldF0gdmV0aDog?=
 =?utf-8?B?ZGVjaWRlIHBlZXIgcXVldWUgY291bnQgZnJvbSB0aGUgcGVlcidzIG93biBh?=
 =?utf-8?Q?ttributes?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSCBuZXRdIHZldGg6IGRlY2lkZSBw?=
 =?utf-8?Q?eer_queue_count_from_the_peer's_own_attributes?=
Thread-Index: AQHdW3xuL5UdhP5ue0+JcjYLLGxuq7b7vNGAgACGmJA=
Date: Wed, 14 Oct 2026 02:56:05 +0000
Message-ID: <e4f034a6a4c64d28ab0fc0e33c85149b@baidu.com>
References: <20261014013620.2497-1-lirongqing@baidu.com>
 <179194201171.160550.1001715704134094403@kernel.org>
In-Reply-To: <179194201171.160550.1001715704134094403@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1791946580;
	bh=0IA0JOmqfBGmUNQPoIZE4r6R7pwjYsrxhRYxpkC7Ib4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=Vs5HHC0HBYGrnXI4Dk9mXodCwNEfdQBjLa8QHT5lIM/5dtNpee4G+3gxOcGf7f7M9
	 sENqPFUK0SfqIBcUOTlUmk0GnVy0xeLhe25Jk3pCgxsOlrAo5LgRYsc2Dbhi97nEMO
	 ThSP18dkuuRT6cuXLojbzNyWFCNEJOfk/f9O+B89uGqR02XXdbJq0T4EMXwsanbQ/s
	 hBiUT+u3r1cjLDWTqMuovLbhSAFu5zAVjO6LRNz6OSXuWoG4gZgvJ75Q/Nd1qow7vv
	 2afvTk/psNDBEIYTaO3+nhiK7NdVY6/XS4PHm85V0QeGLSaDAqePOzcFKtWTnUHFLD
	 Uct7S4ZNmb9Yw==

PiANCj4gVGhpcyBpcyBhbiBhdXRvbWF0ZWQgbWVzc2FnZS4gVGhpcyBzZXJpZXMgbG9va3MgbGlr
ZSBhIGZpeCwgYnV0IGl0cyBjb21taXQgbWVzc2FnZXMNCj4gc2VlbSB0byBiZSBtaXNzaW5nIHNv
bWUgaW5mb3JtYXRpb246DQo+IA0KPiAgLSBIb3cgdGhlIGlzc3VlIHdhcyBkaXNjb3ZlcmVkLCBl
LmcuIGhpdCBpbiBwcm9kdWN0aW9uLCBoaXQgZHVyaW5nDQo+ICAgIGRldmVsb3BtZW50LCBzeXpi
b3QgcmVwb3J0LCBtYW51YWwgY29kZSBpbnNwZWN0aW9uLCBMTE0gb3Igc3RhdGljDQo+ICAgIGFu
YWx5c2lzIHRvb2wgc2Nhbi4NCj4gDQo+ICAtIFdoZXRoZXIgdGhlIGlzc3VlIHdhcyBhY3R1YWxs
eSB0cmlnZ2VyZWQsIG9yIGlzIG9ubHkgdGhlb3JldGljYWwNCj4gICAgKGUuZy4gZm91bmQgYnkg
Y29kZSBpbnNwZWN0aW9uKS4gSWYgaXQgd2FzIHRyaWdnZXJlZCBwbGVhc2UgaW5jbHVkZQ0KPiAg
ICB0aGUgc3ltcHRvbXMsIGxpa2UgdGhlIHN0YWNrIHRyYWNlIG9yIGVycm9yIG1lc3NhZ2VzLg0K
PiANCj4gUGxlYXNlIGRvIG5vdCByZXBvc3QgdGhlIHNlcmllcyBqdXN0IHRvIGFkZHJlc3MgdGhl
IGFib3ZlLiBJbnN0ZWFkLCByZXBseSB0byB0aGlzDQo+IGVtYWlsIHdpdGggdGhlIG1pc3Npbmcg
aW5mb3JtYXRpb24sIHNvIHRoYXQgcmV2aWV3ZXJzIGNhbiB0YWtlIGl0IGludG8gYWNjb3VudC4g
SWYNCj4gdGhlIHNlcmllcyBuZWVkcyBhbm90aGVyIHJldmlzaW9uIGZvciBvdGhlciByZWFzb25z
LCBwbGVhc2UgaW5jbHVkZSB0aGUNCj4gaW5mb3JtYXRpb24gaW4gdGhlIGNvbW1pdCBtZXNzYWdl
cyB0aGVuLg0KPiANCj4gVGhlIGV2YWx1YXRpb24gaXMgZG9uZSBieSBhbiBMTE0gc28gaXQgbWF5
IGJlIHdyb25nLCBpZiB5b3UgdGhpbmsgdGhhdCBpcyB0aGUgY2FzZQ0KPiBwbGVhc2UgcmVwbHkg
YW5kIGV4cGxhaW4uDQoNCldpdGhvdXQgdGhpcyBwYXRjaA0KDQojaXAgbGluayBhZGQgdmV0aDAg
dHlwZSB2ZXRoICAgICBwZWVyIG5hbWUgdmV0aDEgbnVtdHhxdWV1ZXMgNCBudW1yeHF1ZXVlcyA0
DQojIGV0aHRvb2wgLWwgdmV0aDENCkNoYW5uZWwgcGFyYW1ldGVycyBmb3IgdmV0aDE6DQpQcmUt
c2V0IG1heGltdW1zOg0KUlg6ICAgICAgICAgICAgIDQNClRYOiAgICAgICAgICAgICA0DQpPdGhl
cjogICAgICAgICAgbi9hDQpDb21iaW5lZDogICAgICAgbi9hDQpDdXJyZW50IGhhcmR3YXJlIHNl
dHRpbmdzOg0KUlg6ICAgICAgICAgICAgIDENClRYOiAgICAgICAgICAgICAxDQpPdGhlcjogICAg
ICAgICAgbi9hDQpDb21iaW5lZDogICAgICAgbi9hDQoNCldpdGggdGhpcyBwYXRjaDoNCmlwIGxp
bmsgYWRkIHZldGgwIHR5cGUgdmV0aCAgICAgcGVlciBuYW1lIHZldGgxIG51bXR4cXVldWVzIDQg
bnVtcnhxdWV1ZXMgNA0KIyBldGh0b29sIC1sIHZldGgxDQpDaGFubmVsIHBhcmFtZXRlcnMgZm9y
IHZldGgxOg0KUHJlLXNldCBtYXhpbXVtczoNClJYOiAgICAgICAgICAgICA0DQpUWDogICAgICAg
ICAgICAgNA0KT3RoZXI6ICAgICAgICAgIG4vYQ0KQ29tYmluZWQ6ICAgICAgIG4vYQ0KQ3VycmVu
dCBoYXJkd2FyZSBzZXR0aW5nczoNClJYOiAgICAgICAgICAgICA0DQpUWDogICAgICAgICAgICAg
NA0KT3RoZXI6ICAgICAgICAgIG4vYQ0KQ29tYmluZWQ6ICAgICAgIG4vYQ0KDQotTGkNCg==
