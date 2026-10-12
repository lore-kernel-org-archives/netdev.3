Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80AF433BD4;
	Mon, 12 Oct 2026 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789406; cv=none; b=JyjdtLkUaA3Qs8CB1f+RVr+op9lcHRBwsr22yEjub2XzmrMoayAwyk82y3lRoI/VB7Gq3xrh3Gr1vdt+mEYaMXYxLL5/QlT63JmwwLbh2G+X4TSAKh87vHAADW3F8+5jVI5PdX/OVUI/DnPhmrVLywmjHFsehzOOVTp2cjGg7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789406; c=relaxed/simple;
	bh=zg26uMNz8Rod70GTBPQkyNHcw/orcT7Ofvka2N0cUcc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rQ0qeAomt1hhgOxiMFL0HII8i8KS0+ioQ2VN6kugVzg0plW0yFtPjoBImcFMppOmY15kQjkd/kM4NbLROjOoQK44pdpNN2oCVReoOsyidLx6a4npq7EBZxrJRUKDgN9RJkps7WdZ3cb8k25bQSJXfV4fjzM2XkLrMov1C96OTB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dw/eFeLi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dw/eFeLi"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69C7G8nhC3614875, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791789368; bh=zg26uMNz8Rod70GTBPQkyNHcw/orcT7Ofvka2N0cUcc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dw/eFeLiOAmeSmIsASeNoi0W8/wTTq1CWZ0sFsdDitIr8Jkaaz3Dv5eo/wZNAqBUk
	 nqBkFNhk6Qe0bffj1FweN8jsd503v5CLQl/WNYsxWbDmDIc6iieREm2UemhupPooF2
	 Y4x7YCLhfnphfXmiZtMqyPYQODCqCipmsqAIOpigYFI3FAUvYWfLm+EeKhL76Y0b6N
	 4nefZqwwcqGB28vVpR5n24O2Bu/D+pXsNkXZNcrqsrnVQ7T+azm2r+4alGY00GrhFV
	 BX2aUoiWzs+Xgvv2JwK9GpIwvxwzxHLzq21Y0fRfnKGFZqE7bMrLWdk6PAZI+Mg9TQ
	 +9ruhObL/NqSw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69C7G8nhC3614875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Oct 2026 15:16:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 15:16:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Mon, 12 Oct 2026 15:16:15 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: Birger Koblitz <mail@birger-koblitz.de>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, nic_swsd
	<nic_swsd@realtek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"bjorn@mork.no" <bjorn@mork.no>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
Subject: RE: [PATCH net-next v6 01/10] r8152: split r8156_init per chip and
 factor out wait_autoload_done
Thread-Topic: [PATCH net-next v6 01/10] r8152: split r8156_init per chip and
 factor out wait_autoload_done
Thread-Index: AQHdVv1AdBx9zD4lckuTWpQnvZF0MLbzCemAgAZd6BA=
Date: Mon, 12 Oct 2026 07:16:15 +0000
Message-ID: <52a5180dfe614973b22696d30338dc7a@realtek.com>
References: <20261008081556.47901-1-nic_swsd@realtek.com>
 <20261008081556.47901-2-nic_swsd@realtek.com>
 <633a0f2b-67b3-4896-8464-6a4d0c05498f@birger-koblitz.de>
In-Reply-To: <633a0f2b-67b3-4896-8464-6a4d0c05498f@birger-koblitz.de>
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

SGkgQmlyZ2VyLA0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpPbiBUaHVyc2RheSwgT2N0b2Jl
ciA4LCAyMDI2LCA4OjE4IFBNLCBCaXJnZXIgd3JvdGU6DQo+IEhpIENoaWggS2FpLA0KPiANCj4g
T24gMDgvMTAvMjAyNiAxMDoxNSBhbSwgQ2hpaCBLYWkgSHN1IHdyb3RlOg0KPiA+IFJUTDgxNTYs
IFJUTDgxNTZCLCBSVEw4MTU3IGFuZCBSVEw4MTU5IHNoYXJlZCBhIHNpbmdsZSByODE1Nl9pbml0
KCksDQo+ID4gZ2F0ZWQgYnkgYSBkZW5zZSBzZXQgb2YgdHAtPnZlcnNpb24gcmFuZ2UgY2hlY2tz
LiBUaGF0IG1hZGUgdGhlIGluaXQNCj4gPiBzZXF1ZW5jZSBoYXJkIHRvIGZvbGxvdy4NCj4gPg0K
PiA+IFNwbGl0IHI4MTU2X2luaXQoKSBpbnRvIG9uZSBmdW5jdGlvbiBwZXIgY2hpcCBmYW1pbHk6
DQo+ID4gLSByODE1Nl9pbml0ICAoVkVSXzEwLzExKQ0KPiA+IC0gcjgxNTZiX2luaXQgKFZFUl8x
Mi8xMy8xNSkNCj4gPiAtIHI4MTU3X2luaXQgIChWRVJfMTYpDQo+ID4gLSByODE1OV9pbml0ICAo
VkVSXzE3KQ0KPiBJIGhhdmUgYSBoYXJkIHRpbWUgdG8gdW5kZXJzdGFuZCB3aHkgeW91IHdhbnQg
dG8gc2VwYXJhdGUgb3V0IG9uZSBpbml0DQo+IGZ1bmN0aW9uIGludG8gNCBkaWZmZXJlbnQgb25l
cywgZm9yIGVhY2ggY2hpcCBvbmUuIEVzcGVjaWFsbHksIGlmLCBhcyB5b3Ugc2F5IG5vDQo+IGZ1
bmN0aW9uYWwgY2hhbmdlcyBhcmUgaW50ZW5kZWQsIHdoaWNoIG1pZ2h0IGp1c3RpZnkgdGhlIHJl
LWZhY3RvcmluZyBpbiB0aGlzDQo+IG1hbm5lci4gQnkgbXVsdGlwbHlpbmcgdGhlIGZ1bmN0aW9u
cywgaXQgd2lsbCBiZWNvbWUgbW9yZSBkaWZmaWN1bHQgdG8gbWFpbnRhaW4NCj4gdGhlIGNvZGU6
IGlmIGFuIGlzc3VlIGlzIGZvdW5kIGluIHRoZSBpbml0LXNlcXVlbmNlLCBpdCBtYXkgbm93IGJl
IG5lY2Vzc2FyeSB0bw0KPiBmaXggaXQgNC10aW1lcyBhbmQgZnV0dXJlIGRldmVsb3BtZW50cyB0
b3VjaGluZyB0aGUgaW5pdC1zZXF1ZW5jZSB3aWxsIGFsc28NCj4gbmVlZCB0byBiZSByZXBsaWNh
dGVkIG11bHRpcGxlIHRpbWVzLiBJbiB0b3RhbCwgdGhlcmUgd291bGQgYWZ0ZXJ3YXJkcyBiZSA4
KCEpDQo+IGRpZmZlcmVudCBpbml0IHNlcXVlbmNlcyBpbmNsdWRpbmcgdGhlIG90aGVyIG9uZXMg
Zm9yIHRoZSBSVEw4MTUyIGFuZCBkaWZmZXJlbnQNCj4gdmVyc2lvbnMgb2YgdGhlIFJUTDgxNTMu
IFRoZSBzYW1lIHBhdHRlcm4gcmVwZWF0cyB3aXRoIF91cCgpLCBfZG93bigpIGFuZA0KPiBvdGhl
ciBjb25maWd1cmF0aW9uIGZ1bmN0aW9ucy4NCg0KVGhlIHNwbGl0IGlzIG1lYW50IHRvIG1ha2Ug
ZWFjaCBmdW5jdGlvbiByZWFkYWJsZSBvbiBpdHMgb3duLiBJbiBhIHNpbmdsZSBzaGFyZWQgZnVu
Y3Rpb24sIGV2ZXJ5IGNoaXAgZGlmZmVyZW5jZSBpcyBhIHRwLT52ZXJzaW9uIHJhbmdlIGNoZWNr
LCBhbmQgdGhlIGZ1bmN0aW9uIGlzIGhhcmQgdG8gZm9sbG93LiBZb3VyIGNvbmNlcm4gaXMgdmFs
aWQ6IGlmIGEgZml4IG5lZWRzIHRvIGJlIGFwcGxpZWQgdG8gdGhlIGZvdXIgY2hpcHMsIGl0IHdp
bGwgbmVlZCB0byBiZSBhcHBsaWVkIGZvdXIgdGltZXMuIEJ1dCBpZiBhIGNoaXAgZ2V0cyBjaGlw
LXNwZWNpZmljIGZpeGVzLCB0aGUgaW5pdCBvciBvdGhlciBmdW5jdGlvbnMgd2lsbCBiZSBtb3Jl
IGNvbXBsZXggd2l0aCBzZXZlcmFsIHRwLT52ZXJzaW9uIGNoZWNrcy4gT24gdGhlIG90aGVyIGhh
bmQsIHVzaW5nIGEgc2luZ2xlIHNoYXJlZCBmdW5jdGlvbiB3aWxsIG1ha2UgdGhlIGZ1bmN0aW9u
IHZlcnkgY29tcGxleCB3aGVuIG5ldyBJQ3MgYXJlIGFkZGVkLg0KDQo+IA0KPiBXb3VsZCBpdCBu
b3QgbWFrZSBtb3JlIHNlbnNlIHRvIHRyeSB0byBmdXJ0aGVyIGNvbWJpbmUgdGhlIGluaXQgc2Vx
dWVuY2VzIG9yDQo+IHRyeSB0byBkaXNlbnRhbmdsZSB0aGUgY29kZSBieSBlc3RhYmxpc2hpbmcg
Y29tbW9uIGxpYnJhcnkgcm91dGluZXMgcHV0IGludG8gYQ0KPiBfbGliLmMgZmlsZSBhbmQgcG9z
c2libHkgZGlmZmVyZW50IC5jIGZpbGVzIGZvciB0aGUgZGlmZmVyZW50IGdlbmVyYXRpb25zIG9m
IHRoZSBjaGlwcz8NCj4gRm9yIGV4YW1wbGUsIGl0IGFwcGVhcnMgdGhhdCB0aGUNCj4gcnRsODE1
Ny85IGJlbG9uZyB0byBvbmUgZ2VuZXJhdGlvbiBvZiBjaGlwcywgYmFzZWQgb24gdGhlIHJ0bDgx
NTYgZGVzaWduLiBPbg0KPiB0aGUgb3RoZXIgaGFuZCwgcnRsODE1Mi8zIGFwcGVhciB0byBiZSBh
IGRpZmZlcmVudCBnZW5lcmF0aW9uIHdpdGggdmFyaW91cw0KPiBmYW1pbHkgbWVtYmVycy4gVGhh
dCB3b3VsZCBhbGxvdyB0byBidWlsZCBhIGJhc2lzIGZvciBmdXR1cmUgZGV2ZWxvcG1lbnQgbGlr
ZQ0KPiB0byByZWx5IG9uIHVzaW5nIHBoeWxpbmsgdG8gaGFuZGxlIHRoZSBQSFlzIGludGVncmF0
ZWQgaW4gdGhlIGNoaXBzLCB3aGljaCBhbGwNCj4gYXBwZWFyIHRvIGJlIGFscmVhZHkgc3VwcG9y
dGVkIGJ5IHRoZSBSZWFsdGVrLVBIWSBkcml2ZXIuDQoNCkkgYWdyZWUgdGhhdCBjaGlwcyB3aXRo
IHRoZSBzYW1lIGdlbmVyYXRpb24gb3IgdmVyeSBzaW1pbGFyIHNlcXVlbmNlcyBzaG91bGQgYmUg
Y29tYmluZWQuDQoNCkkgcHJlZmVyIHRvIGNvbWJpbmUgdGhlIGNhbGxiYWNrcywgaW5jbHVkaW5n
IGluaXQsIHVwLCBkb3duLCBhbmQgZW5hYmxlLiANCi0gRm9yIGluaXQsIEkgY2FuIG1lcmdlIHI4
MTU2Yl9pbml0IGludG8gcjgxNTZfaW5pdCBhbmQgcjgxNTlfaW5pdCBpbnRvIHI4MTU3X2luaXQu
IA0KLSBGb3IgdXAvZG93biwgSSBjYW4gbW92ZSB0aGUgc2VxdWVuY2Ugc2hhcmVkIGJ5IHJ0bDgx
NTZfdXAvcnRsODE1N191cCBhbmQgYnkgdGhlIGRvd24gZnVuY3Rpb25zIGludG8gY29tbW9uIGhl
bHBlcnMsIGFzIHJ0bDgxNTJiLzMgZG8gd2l0aCBleGl0X29vYi9lbnRlcl9vb2IuIA0KLSBGb3Ig
ZW5hYmxlLCBJIGNhbiBjb21iaW5lIHJ0bDgxNTZfZW5hYmxlIGFuZCBydGw4MTU2Yl9lbmFibGUu
DQoNCj4gDQo+IFsuLi5dDQo+ID4NCj4gPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENoaWggS2FpIEhzdSA8aHN1LmNoaWgua2FpQHJlYWx0
ZWsuY29tPg0KPiBCZXN0LA0KPiAgICBCaXJnZXINCkJlc3QsDQpDaGloLUthaQ0K
