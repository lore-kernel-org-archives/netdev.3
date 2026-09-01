Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A59D3BB674;
	Tue,  1 Sep 2026 07:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246837; cv=none; b=g2Zuwm/aIJ0Gz3JfAC4Bi2GAjzSPvbsOZS4FBPLbzCRRqeK4GBGDyCDJqI5gF00YNKH9GpQVkiCUDXkoY0i/sNs1A9AlcCk0xxv8I2jEL1kA+z8LygeCjec9PVnAkwszfdDfWPEw0So9XzNKl+kAdASJNcvHZV0wDuHRhfEfo2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246837; c=relaxed/simple;
	bh=fo3eEH+mpRfdJzCSVpOfwHZwWLVlDIEbk28HxZcXPPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Af+gPyunef2Joxi99VVpeItpNXyWiDuiFkR0bac9PNOtFjigZYkn33XxlOSjPKhEaaERadUtGCz7KBuDX4taqAUQKcQluIzGv9ilG6DyvVfOt1jS6h5clTuQlJB9c9AWlYndiGY27IPvqRvudBEfHAYmnkRP42d67pE3XTx1/cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RbCWRFst; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RbCWRFst"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6817DJ8f81480650, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788246800; bh=fo3eEH+mpRfdJzCSVpOfwHZwWLVlDIEbk28HxZcXPPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RbCWRFst9c3PRAH5ZL+RA+ZZ98n+akGV2a6u8ELslEmpcBYr4mw0LXkSBfQV4pgqM
	 TO4GQ0HqA/O3Ar37VIXbkpFXQcophFwJahs4mbimYydhjp6JFRi5doGfTFQv7uTAGz
	 ZnsgHdNa2XBOnwU7TVH2T8WCy+ARuHY82SHqwKbr7Gte/dRS9MY0u6druPIenKexD5
	 gvYNEjVTb6Rrc2j3lsDaDymAxY8TbZ4drP7SZWDhSF85jn+6Tc+SFB8Go5l4bFl3Qg
	 i8vTErgjDrfAGRVTFPWA/b1yNxgfa2jPd1SVszjwnV3a58V2hEOsKSKgLMmC9o02Yn
	 7kARxTI0LYL1w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6817DJ8f81480650
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 1 Sep 2026 15:13:20 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 1 Sep 2026 15:13:18 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::6d7e:80bb:9fcb:1a5e%6]) with mapi id
 15.02.2562.043; Tue, 1 Sep 2026 15:13:18 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Yang Zi <2959243019@qq.com>, Larry Chiu <larry.chiu@realtek.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: rtase: Fix NULL pointer dereference in NAPI cleanup
 on probe failure
Thread-Topic: [PATCH] net: rtase: Fix NULL pointer dereference in NAPI cleanup
 on probe failure
Thread-Index: AQHdNHB+KP6gOL0O7kacMo8VAsZX0ba5WYJA
Date: Tue, 1 Sep 2026 07:13:18 +0000
Message-ID: <b2e37853a4634b3b8810283580b6d393@realtek.com>
References: <tencent_AFD4DC7BE2EC61C628B53A3BCF4B558C2105@qq.com>
In-Reply-To: <tencent_AFD4DC7BE2EC61C628B53A3BCF4B558C2105@qq.com>
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

WWFuZyBaaSA8Mjk1OTI0MzAxOUBxcS5jb20+IHdyb3RlOg0KPiANCj4gRXh0ZXJuYWwgbWFpbCA6
IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgdGhlIG9yZ2FuaXphdGlvbi4gRG8g
bm90DQo+IHJlcGx5LCBjbGljayBsaW5rcywgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZA0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+
IA0KPiANCj4gDQo+IHJ0YXNlX2luaXRfbmFwaSgpICh3aGljaCBhZGRzIHRoZSBOQVBJIGNvbnRl
eHRzIGFuZCBzZXRzIG5hcGktPmRldikgaXMNCj4gY2FsbGVkIGFmdGVyIHJ0YXNlX2FsbG9jX2lu
dGVycnVwdCgpLiAgSWYgaW50ZXJydXB0IGFsbG9jYXRpb24gZmFpbHMsDQo+IHJ0YXNlX2luaXRf
b25lKCkganVtcHMgdG8gZXJyX291dF9kZWxfbmFwaSBhbmQgY2FsbHMgbmV0aWZfbmFwaV9kZWwo
KSBvbg0KPiBOQVBJIGNvbnRleHRzIHRoYXQgd2VyZSBuZXZlciBhZGRlZCwgc28gbmFwaS0+ZGV2
IGlzIHN0aWxsIE5VTEwuDQo+IG5ldGlmX25hcGlfZGVsKCkgLT4gX19uZXRpZl9uYXBpX2RlbCgp
IC0+IG5ldGRldl9sb2NrKG5hcGktPmRldikNCj4gZGVyZWZlcmVuY2VzIHRoYXQgTlVMTCBwb2lu
dGVyLg0KPiANCj4gS0FTQU4gcmVwb3J0Og0KPiANCj4gICAgIEJVRzogS0FTQU46IG51bGwtcHRy
LWRlcmVmIGluIF9fbXV0ZXhfbG9ja19jb21tb24NCj4ga2VybmVsL2xvY2tpbmcvbXV0ZXguYzo2
MjUgW2lubGluZV0NCj4gICAgIEJVRzogS0FTQU46IG51bGwtcHRyLWRlcmVmIGluIF9fbXV0ZXhf
bG9jaysweDhmLzB4Y2UwDQo+IGtlcm5lbC9sb2NraW5nL211dGV4LmM6ODIwDQo+ICAgICBSZWFk
IG9mIHNpemUgOCBhdCBhZGRyIDAwMDAwMDAwMDAwMDBjZDggYnkgdGFzayBzeXouMC4xLzExNDcN
Cj4gDQo+ICAgICBfX211dGV4X2xvY2srMHg4Zi8weGNlMCBrZXJuZWwvbG9ja2luZy9tdXRleC5j
OjgyMA0KPiAgICAgbmV0ZGV2X2xvY2sgaW5jbHVkZS9saW51eC9uZXRkZXZpY2UuaDoyODE4IFtp
bmxpbmVdIFtydGFzZV0NCj4gICAgIF9fbmV0aWZfbmFwaV9kZWwgaW5jbHVkZS9saW51eC9uZXRk
ZXZpY2UuaDoyOTQyIFtpbmxpbmVdIFtydGFzZV0NCj4gICAgIG5ldGlmX25hcGlfZGVsIGluY2x1
ZGUvbGludXgvbmV0ZGV2aWNlLmg6Mjk2MSBbaW5saW5lXSBbcnRhc2VdDQo+ICAgICBydGFzZV9p
bml0X29uZSsweDVjM2QvMHg1ZmQwDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcnRh
c2UvcnRhc2VfbWFpbi5jOjIyOTUgW3J0YXNlXQ0KPiANCj4gT25seSBjYWxsIG5ldGlmX25hcGlf
ZGVsKCkgb24gTkFQSSBjb250ZXh0cyB0aGF0IHdlcmUgYWN0dWFsbHkgYWRkZWQNCj4gKG5hcGkt
PmRldiAhPSBOVUxMKSwgc28gdGhlIGludGVycnVwdC1hbGxvY2F0aW9uIGZhaWx1cmUgcGF0aCBz
a2lwcyB0aGVtDQo+IHdoaWxlIHRoZSBwb3N0LW5hcGktaW5pdCBmYWlsdXJlIHBhdGhzIHN0aWxs
IHJlbW92ZSB0aGVtLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWWFuZyBaaSA8Mjk1OTI0MzAxOUBx
cS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9ydGFzZS9ydGFz
ZV9tYWluLmMgfCA3ICsrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9y
ZWFsdGVrL3J0YXNlL3J0YXNlX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0
ZWsvcnRhc2UvcnRhc2VfbWFpbi5jDQo+IGluZGV4IGUzY2Q0ZjdjMTM4MC4uYjRkODgyOGNhODdk
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3J0YXNlL3J0YXNl
X21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3J0YXNlL3J0YXNl
X21haW4uYw0KPiBAQCAtMjQ5Myw5ICsyNDkzLDE0IEBAIHN0YXRpYyBpbnQgcnRhc2VfaW5pdF9v
bmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsDQo+ICAgICAgfQ0KPiANCj4gIGVycl9vdXRfZGVsX25h
cGk6DQo+ICsgICAgLyogcnRhc2VfaW5pdF9uYXBpKCkgcnVucyBhZnRlciBydGFzZV9hbGxvY19p
bnRlcnJ1cHQoKTsgaWYgaW50ZXJydXB0DQo+ICsgICAgICogYWxsb2NhdGlvbiBmYWlsZWQgdGhl
IE5BUEkgY29udGV4dHMgd2VyZSBuZXZlciBhZGRlZCBhbmQgbmFwaS0+ZGV2DQo+IGlzDQo+ICsg
ICAgICogc3RpbGwgTlVMTCwgc28gbmV0aWZfbmFwaV9kZWwoKSBtdXN0IG5vdCBiZSBjYWxsZWQg
b24gdGhlbS4NCj4gKyAgICAgKi8NCj4gICAgICBmb3IgKGkgPSAwOyBpIDwgdHAtPmludF9udW1z
OyBpKyspIHsNCj4gICAgICAgICAgaXZlYyA9ICZ0cC0+aW50X3ZlY3RvcltpXTsNCj4gLSAgICAg
ICAgbmV0aWZfbmFwaV9kZWwoJml2ZWMtPm5hcGkpOw0KPiArICAgICAgICBpZiAoaXZlYy0+bmFw
aS5kZXYpDQo+ICsgICAgICAgICAgICBuZXRpZl9uYXBpX2RlbCgmaXZlYy0+bmFwaSk7DQo+ICAg
ICAgfQ0KPiANCj4gIGVycl9vdXRfcmVsZWFzZV9ib2FyZDoNCg0KVGhhbmtzIGZvciB0aGUgcGF0
Y2guDQogDQpTaW5jZSBydGFzZV9pbml0X25hcGkoKSBpcyBvbmx5IGNhbGxlZCBhZnRlcg0KcnRh
c2VfYWxsb2NfaW50ZXJydXB0KCkgc3VjY2VlZHMsIEkgdGhpbmsgdGhlIGludGVycnVwdCBhbGxv
Y2F0aW9uDQpmYWlsdXJlIHBhdGggY2FuIHNpbXBseSBqdW1wIHRvIGVycl9vdXRfcmVsZWFzZV9i
b2FyZCBpbnN0ZWFkIG9mDQpjaGVja2luZyBuYXBpLT5kZXYgaW4gdGhlIE5BUEkgY2xlYW51cCBw
YXRoLiBUaGUNCmVycl9vdXRfZGVsX25hcGkgbGFiZWwgY2FuIHRoZW4gYmUgcmVtb3ZlZC4NCiAN
Ckp1c3Rpbg0K
