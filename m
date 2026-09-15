Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557D47F3DC;
	Tue, 15 Sep 2026 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470234; cv=none; b=ZMAJsZY+8iVY0woSNsQS2sDPniofp7muYtyejqq85IGRUF8q9quZpNAqOVpLRF0748TIpeQnNaPLZ4beQKPdqz/5MqkA61y4vPktnr7iSmEIY+yVQNOQSPUM9h8KleIs2ksyeN2jI2Ajm/WTi6FOSmWXTtv3sJfrjQ3TQ6CREB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470234; c=relaxed/simple;
	bh=k7QeMySm+9gS8bryy23hxcRHWR3uLfK4KuB+7x/JlGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XjDtYD2Z77nVFu3lUqBXNxjh9rD++UhRNBFGwnOE7AI7wHBSkzMxYbj0RSSfKi0/vcQBB5yFO4FiUi5uCyVWAoorvm6vO4zJ5iv2Vox5COz9x/HuXgz8eF7M9FjmqQr19WAlHdypoyZ8RcLxyT6UkMtkV3V7c130Cas0BNay/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IutC8cLX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IutC8cLX"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68FB3FrrC1471823, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1789470195; bh=k7QeMySm+9gS8bryy23hxcRHWR3uLfK4KuB+7x/JlGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IutC8cLXFjQm6tBEIXX2SAacJ5pgwsDEchEe84/qbVvJfDqM1qQaKuj4xZ7qj2muB
	 NEFEqxOXI7GCAi6GelLDRgphERWU5E8eWuWsV1fLvL/oT8KisOtWHEvkoDDvTNT2pF
	 ZK2HBiZ1rC8HQBqxReSlTJN1rJ/8Obw9aZ9sGlBvuCUqAFKfrdgzQVx5pvLzd+tyNj
	 ieIfd//ixK+c4DlLrEGgzk8zO73EeM/Wowey7G38D44pZu2RxM5zU0TtfPqhQIXAW7
	 xg2Uk3sg0MV4URXE14XRiVu/YCiV91sMRrAw+/cFGEIizBZU79SDdXHYf6XIda2T06
	 t4G13bKSK0YTA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68FB3FrrC1471823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 19:03:15 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 19:03:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 19:03:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Tue, 15 Sep 2026 19:03:14 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	nic_swsd <nic_swsd@realtek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"bjorn@mork.no" <bjorn@mork.no>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
Subject: RE: [PATCH net-next v3 2/8] r8152: support RTL8159 for different
 packages
Thread-Topic: [PATCH net-next v3 2/8] r8152: support RTL8159 for different
 packages
Thread-Index: AQHdP2eUZXR8+LOxTEmuy6vw5pozlbbK4zOAgASfBoA=
Date: Tue, 15 Sep 2026 11:03:14 +0000
Message-ID: <916cdbfe3e7c45d589449b26705ed6da@realtek.com>
References: <20260908075634.23740-3-nic_swsd@realtek.com>
 <178924438904.3125.17659166669293112223@kernel.org>
In-Reply-To: <178924438904.3125.17659166669293112223@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBmb3Vu
ZCAxIHBvdGVudGlhbA0KPiBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gDQo+IENyaXRpY2FsOiAw
IMK3IEhpZ2g6IDAgwrcgTWVkaXVtOiAwIMK3IExvdzogMQ0KPiANCj4gLSBbTG93XSBUaGUgY2hh
bmdlbG9nIGRlc2NyaWJlcyB0aGUgcGF0Y2ggYXMgYSBwdXJlIGVudW0gc3BsaXQgKCJSVEw4MTU5
DQo+ICAgY29tZXMgaW4gdHdvIHBhY2thZ2VzLCBRRk42OCBhbmQgUUZOMTAwLCB3aGljaCByZXF1
aXJlIGRpZmZlcmVudOKApg0KPiANCj4gLS0NCj4gDQo+IHI4MTUyOiBzdXBwb3J0IFJUTDgxNTkg
Zm9yIGRpZmZlcmVudCBwYWNrYWdlcw0KPiANCj4gVGhpcyBzcGxpdHMgUlRMX1ZFUl8xNyBpbnRv
IFJUTF9WRVJfMTdfUUZONjggYW5kIFJUTF9WRVJfMTdfUUZOMTAwDQo+IGFuZCB1cGRhdGVzIGV2
ZXJ5IHZlcnNpb24gc3dpdGNoIGFjY29yZGluZ2x5LiAgUHJvYmUgbm93IHJlYWRzDQo+IFBMQV9Q
S0dfREVUIG92ZXIgYSBVU0IgY29udHJvbCB0cmFuc2ZlciB0byBkZWNpZGUgd2hpY2ggb2YgdGhl
IHR3byBwYWNrYWdlcw0KPiBpcyBwcmVzZW50LCBhbmQgcjgxNTlfaW5pdCgpIGdhaW5zIG9uZSBw
YWNrYWdlLXNwZWNpZmljIHJlZ2lzdGVyIHdyaXRlLg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvdXNiL3I4MTUyLmMgYi9kcml2ZXJzL25ldC91c2IvcjgxNTIuYyBpbmRleA0KPiA+
IDAxM2U4ZDFhYmZjMjQuLmYwMWY0NDJmYTcxYTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvdXNiL3I4MTUyLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC91c2IvcjgxNTIuYw0KPiANCj4g
WyAuLi4gXQ0KPiANCj4gPiBAQCAtODcxNiw2ICs4NzM5LDEwIEBAIHN0YXRpYyB2b2lkIHI4MTU5
X2luaXQoc3RydWN0IHI4MTUyICp0cCkNCj4gPiAgICAgICAvKiBUWCBkZXNjcmlwdG9yIFNpZ25h
dHVyZSAqLw0KPiA+ICAgICAgIG9jcF9ieXRlX2Nscl9iaXRzKHRwLCBNQ1VfVFlQRV9VU0IsIDB4
ZDRhZSwgQklUKDEpKTsNCj4gPg0KPiA+ICsgICAgIC8qIEVuYWJsZSB1MnBoeSBiYWNrdXAgcmVz
dG9yZSBwYXRjaCAqLw0KPiA+ICsgICAgIGlmICh0cC0+dmVyc2lvbiA9PSBSVExfVkVSXzE3X1FG
TjY4KQ0KPiA+ICsgICAgICAgICAgICAgb2NwX2J5dGVfc2V0X2JpdHModHAsIE1DVV9UWVBFX1VT
QiwgMHhiOTljLCBCSVQoMCkpOw0KPiA+ICsNCj4gDQo+IFtTZXZlcml0eTogTG93XQ0KPiBUaGlz
IGlzbid0IGEgYnVnLCBidXQgY291bGQgdGhlIGNoYW5nZWxvZyBtZW50aW9uIHRoaXMgd3JpdGU/
ICBUaGUgY29tbWl0DQo+IG1lc3NhZ2UgZGVzY3JpYmVzIHRoZSBjaGFuZ2UgYXMgYW4gZW51bSBz
cGxpdDoNCj4gDQo+ICAgICBSVEw4MTU5IGNvbWVzIGluIHR3byBwYWNrYWdlcywgUUZONjggYW5k
IFFGTjEwMCwgd2hpY2ggcmVxdWlyZQ0KPiBkaWZmZXJlbnQNCj4gICAgIGhhbmRsaW5nLiBTcGxp
dCBSVExfVkVSXzE3IGludG8gUlRMX1ZFUl8xN19RRk42OCBhbmQNCj4gUlRMX1ZFUl8xN19RRk4x
MDAuDQo+IA0KDQpTdXJlLCBJIHdpbGwgbWVudGlvbiB0aGlzIGNoYW5nZSBpbiB0aGUgbmV4dCB2
ZXJzaW9uLg0KDQo+IEV2ZXJ5IG90aGVyIGh1bmsgaW4gdGhlIHBhdGNoIGlzIGEgbWVjaGFuaWNh
bCByZW5hbWUsIGFuZCB0aGlzDQo+IG9jcF9ieXRlX3NldF9iaXRzKHRwLCBNQ1VfVFlQRV9VU0Is
IDB4Yjk5YywgQklUKDApKSBpbiByODE1OV9pbml0KCkgaXMgdGhlDQo+IG9ubHkgcGxhY2Ugd2hl
cmUgdGhlIHR3byBwYWNrYWdlcyBhY3R1YWxseSBiZWhhdmUgZGlmZmVyZW50bHkuDQo+IA0KPiBS
VEw4MTU5IGhhcyBiZWVuIGRyaXZlbiBhcyBSVExfVkVSXzE3IHNpbmNlIGNvbW1pdCBhZDJhNTVi
NjNiNDFhZg0KPiAoInI4MTUyOg0KPiBBZGQgc3VwcG9ydCBmb3IgdGhlIFJUTDgxNTkgY2hpcCIp
LCBzbyBRRk42OCBwYXJ0cyBhcmUgcnVubmluZyB0b2RheSB3aXRob3V0DQo+IHRoaXMgdTJwaHkg
YmFja3VwIHJlc3RvcmUgYml0Lg0KPiANCj4gSXMgdGhpcyB3cml0ZSBjb3JyZWN0aW5nIG1pc2Jl
aGF2aW91ciBvbiBRRk42OCBoYXJkd2FyZSB0aGF0IGlzIGFscmVhZHkNCj4gc3VwcG9ydGVkLCBv
ciBpcyBpdCBlbmFibGVtZW50IGZvciBzaWxpY29uIHRoYXQgd2FzIG5vdCBwcmV2aW91c2x5IGlu
IHRoZSBmaWVsZD8NCj4gSWYgaXQgaXMgdGhlIGZvcm1lciwgd291bGQgYSBGaXhlczogYWQyYTU1
YjYzYjQxYWYgKCJyODE1MjogQWRkIHN1cHBvcnQgZm9yIHRoZQ0KPiBSVEw4MTU5IGNoaXAiKSB0
YWcgYmUgYXBwcm9wcmlhdGUgc28gaXQgcmVhY2hlcyBzdGFibGUsIGFuZCBjb3VsZCB0aGUNCj4g
Y2hhbmdlbG9nIGRlc2NyaWJlIHRoZSBzeW1wdG9tIGl0IGFkZHJlc3Nlcz8NCj4gDQo+ID4gICAg
ICAgLyogRW5hYmxlIHUzcGh5IHBhdGNoIGJhY2t1cCAqLw0KPiA+ICAgICAgIG9jcF93cml0ZV93
b3JkKHRwLCBNQ1VfVFlQRV9VU0IsIDB4YjlhMiwgMHgwNDQ4KTsNCj4gPg0KPiANCg0KSXQgaXMg
ZW5hYmxlbWVudCBmb3IgdGhlIGNoaXAgdGhhdCB3YXMgbm90IHByZXZpb3VzbHkgaW4gdGhlIGZp
ZWxkLg0KDQo+IFsgLi4uIF0NCj4gDQo+ID4gQEAgLTEwMjg3LDcgKzEwMzQwLDE2IEBAIHN0YXRp
YyB1OCBfX3J0bF9nZXRfaHdfdmVyKHN0cnVjdCB1c2JfZGV2aWNlDQo+ICp1ZGV2KQ0KPiA+ICAg
ICAgICAgICAgICAgdmVyc2lvbiA9IFJUTF9WRVJfMTY7DQo+ID4gICAgICAgICAgICAgICBicmVh
azsNCj4gPiAgICAgICBjYXNlIDB4MjAyMDoNCj4gPiAtICAgICAgICAgICAgIHZlcnNpb24gPSBS
VExfVkVSXzE3Ow0KPiA+ICsgICAgICAgICAgICAgcGtnX2RldCA9IF9fcnRsX2dldF9wa2dfZGV0
KHVkZXYpOw0KPiA+ICsgICAgICAgICAgICAgaWYgKHBrZ19kZXQgPT0gMHgxZSB8fCBwa2dfZGV0
ID09IDB4MWMpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgdmVyc2lvbiA9IFJUTF9WRVJf
MTdfUUZONjg7DQo+ID4gKyAgICAgICAgICAgICB9IGVsc2UgaWYgKHBrZ19kZXQgPT0gMHgxOCB8
fCBwa2dfZGV0ID09IDB4MWEpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgdmVyc2lvbiA9
IFJUTF9WRVJfMTdfUUZOMTAwOw0KPiA+ICsgICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgdmVyc2lvbiA9IFJUTF9WRVJfVU5LTk9XTjsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgZGV2X2luZm8oJnVkZXYtPmRldiwgIlVua25vd24gcGFja2FnZQ0KPiAl
IzAyeFxuIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGtnX2RldCk7DQo+
ID4gKyAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgICAgICBicmVhazsNCj4gDQo+IFtTZXZl
cml0eTogTG93XQ0KPiBBbG9uZyB0aGUgc2FtZSBsaW5lcywgdGhlIGNoYW5nZWxvZyBkb2VzIG5v
dCBtZW50aW9uIHRoYXQgaHcgdmVyc2lvbiAweDIwMjANCj4gbm93IHJlcXVpcmVzIGFuIGV4dHJh
IFBMQV9QS0dfREVUIGNvbnRyb2wgcmVhZCBhdCBwcm9iZSB0aW1lIHRvIGJlIGNsYXNzaWZpZWQN
Cj4gYXQgYWxsLiAgQ291bGQgYSBzZW50ZW5jZSBiZSBhZGRlZCBjb3ZlcmluZyB0aGF0Pw0KDQpT
dXJlLCB3aWxsIGRvLg0KDQo+IA0KPiBXYXMgdGhpcyBuZXcgZGV0ZWN0aW9uIHBhdGggdmFsaWRh
dGVkIGFnYWluc3QgYm90aCBwYWNrYWdlcywgYW5kIHdoaWNoDQo+IFBMQV9QS0dfREVUIHZhbHVl
cyB3ZXJlIG9ic2VydmVkIG9uIGVhY2g/DQo+IA0KPiA+ICAgICAgIGRlZmF1bHQ6DQo+ID4gICAg
ICAgICAgICAgICB2ZXJzaW9uID0gUlRMX1ZFUl9VTktOT1dOOw0KPiANCg0KWWVzLiBQTEEgMHhE
QzQ4WzQ6MV0gaXMgMGIxMTExIG9yIDBiMTExMTAgZm9yIFFGTjY4OyAwYjExMDAgb3IgMGIxMTAx
IGZvciBRRk4xMDAuDQoNCj4gLS0NCj4gU2FzaGlrbyBBSSByZXZpZXcgwrcNCj4gaHR0cHM6Ly9u
ZXRkZXYtYWkuYm90cy5saW51eC5kZXYvc2FzaGlrby8jL3BhdGNoc2V0LzIwMjYwOTA4MDc1NjM0
LjIzNzQwLTENCj4gLW5pY19zd3NkJTQwcmVhbHRlay5jb20NCg0KDQpCZXN0LA0KQ2hpaC1LYWkN
Cg==
