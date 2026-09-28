Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90233C73F6;
	Mon, 28 Sep 2026 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790579914; cv=none; b=Mm3I66JdC8NPVQEUS6p5K4GnZZIfyIlv2Pz5SmjAMzSOrXESlzehdTa+5dNpiUuHbGIY1h3yK18Pw89vnQryw13/V9hXMNIy2SNrtbbjmI/XdNftVdSzdpEIvym0qu5HMIYnKao6FapJvPlFUPBxILdLMhpIeTeZDrbBXpPV9i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790579914; c=relaxed/simple;
	bh=6nE/aob3vX0Cz/9qEejZPnS2F7p5IsfvZPQCM8PWuiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hrO+twMfE8iBoMl17hEQBdlZRn6/MYlgnZFqrfW1JM58ianArWH72jj+WfMxxe6eTx3AM457nquU1PUPFnKGKEduUMc12/Zy9KmVf/QwMkgBNIvuAMeQ3OUp3Ws0CyRO6oD7MjrDz4iuFf7EVilBPAP9NAnGz2nVUf5bAKF3ex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=n7/c40il; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="n7/c40il"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68S7GxzD6221009, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1790579820;
	bh=6nE/aob3vX0Cz/9qEejZPnS2F7p5IsfvZPQCM8PWuiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=n7/c40il+GIOz/Eol9A9AbJ5Wvw25w2My6aK7lRDc0W6TrAVESi/wGeLAQVJ51+F8
	 fTTynlrL0FpGHF6uGdz3SsVcEan6T1YCIYFAozqjlv+i/jS2ds1iLKu+AwjJITql5T
	 VAnXJq9RMQhLL4hP61ynpciLOSXGShSOuZjL/GjJDQ4ewHPE55y+eT4UeXzbnWo5IX
	 eHzW8aFeiT+Q9PqrOwiv8KBZqvrXRkjngFDNCFuNodT5+vkDnOAW7BioZ4nBNNi2QO
	 z0RieWre57f0G7qOcN9yBOSFW+7by6QgPjhpr0o/Bdul0YOEmv1EvuECIMpZBtOm1R
	 yOnWiXACT5UtA==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68S7GxzD6221009
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Sep 2026 15:17:00 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 28 Sep 2026 15:17:00 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.049; Mon,
 28 Sep 2026 15:17:00 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Simon Polack <spolack+git@mailbox.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "chad@monroe.io"
	<chad@monroe.io>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/3] net: phy: realtek: apply SerDes lane
 polarity on RTL8261C/D
Thread-Topic: [PATCH net-next 2/3] net: phy: realtek: apply SerDes lane
 polarity on RTL8261C/D
Thread-Index: AQHdSeUSgG4YbBhFwEWSJTCNCwbTfLbjm/ZA
Date: Mon, 28 Sep 2026 07:17:00 +0000
Message-ID: <8d7917660a9c4718ad1efe8b3e8e1f80@realsil.com.cn>
References: <20260921161817.565185-1-spolack+git@mailbox.org>
 <20260921161817.565185-3-spolack+git@mailbox.org>
In-Reply-To: <20260921161817.565185-3-spolack+git@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Pg0KPkJvYXJkcyBzdWNoIGFzIHRoZSBHZW10ZWsgVzE3MDBLIChBaXJvaGEgQU43NTgxKSByb3V0
ZSB0aGUgVVNYR01JSSBsYW5lcw0KPmJldHdlZW4gdGhlIFNvQyBhbmQgdGhlIFBIWSBpbnZlcnRl
ZCBhbmQgZGVzY3JpYmUgdGhhdCBpbiB0aGUgZGV2aWNlIHRyZWUgd2l0aA0KPnRoZSBnZW5lcmlj
IHR4LXBvbGFyaXR5L3J4LXBvbGFyaXR5IHByb3BlcnRpZXMuDQo+Tm90aGluZyBpbiB0aGUgUlRM
ODI2MUMvRCBkcml2ZXIgcmVhZHMgdGhlbSBhbmQgdGhlIEFpcm9oYSBQQ1MgaGFzIG5vDQo+cG9s
YXJpdHkgaGFuZGxpbmcgb2YgaXRzIG93biwgc28gdGhlIGludmVyc2lvbiBpcyBuZXZlciBwcm9n
cmFtbWVkLg0KPlRoZSBjb3BwZXIgc2lkZSBuZWdvdGlhdGVzIG5vcm1hbGx5IHdoaWxlIHRoZSBT
ZXJEZXMgbmV2ZXIgdHJhaW5zIGFuZCB0aGUNCj5uZXRkZXYgc3RheXMgTk8tQ0FSUklFUi4NCj4N
Cj5MYW5lIHBvbGFyaXR5IG9uIHRoaXMgcGFydCBsaXZlcyBiZWhpbmQgdGhlIHNhbWUgVkVORDEg
U2VyRGVzIGNvbW1hbmQNCj53aW5kb3cgdGhlIFJUTDgyMnggY29kZSBhbHJlYWR5IHVzZXMgZm9y
IGluLWJhbmQgYXV0b25lZywgaW4gU2VyRGVzIHJlZ2lzdGVycw0KPjB4MDAwMCAoYml0cyA5Ojgp
IGFuZCAweDAwYzIgKGJpdHMgMTQ6MTMpLiBUaGUgcmVnaXN0ZXIgYXQNCj5WRU5EMSAweGMxIHRo
YXQgc29tZSBvdGhlciBSZWFsdGVrIDEwRyBQSFlzIHVzZSBmb3IgdGhlIHNhbWUgcHVycG9zZSBp
cyBub3QNCj5pbXBsZW1lbnRlZCBvbiB0aGlzIGRpZSBhbmQgcmVhZHMgYmFjayBhcyB6ZXJvIGFm
dGVyIGEgd3JpdGUuDQo+DQo+QWRkIGEgcmVhZCBzaWRlIGFuZCBhIHJlYWQtbW9kaWZ5LXdyaXRl
IGhlbHBlciB0byB0aGUgY29tbWFuZCB3aW5kb3csDQo+bW92ZSBydGw4MjJ4X3NlcmRlc193cml0
ZSgpIHVwIG5leHQgdG8gdGhlbSBzbyBhbGwgdGhyZWUgYXJlIHZpc2libGUgZnJvbSB0aGUNCj5S
VEw4MjYxIGNvZGUsIGFwcGx5IHRoZSBwb2xhcml0eSBmcm9tIGNvbmZpZ19pbml0KCkgYW5kIHNl
bGVjdA0KPlBIWV9DT01NT05fUFJPUFMgZm9yIHRoZSBwcm9wZXJ0eSBoZWxwZXJzLiBPbmx5IGxh
bmVzIGFjdHVhbGx5IGRlc2NyaWJlZA0KPmluIHRoZSBmaXJtd2FyZSBub2RlIGFyZSB0b3VjaGVk
OyBhIGJvYXJkIHdpdGhvdXQgdGhlIHByb3BlcnRpZXMga2VlcHMNCj53aGF0ZXZlciB0aGUgYm9v
dCBsb2FkZXIgYW5kIHRoZSBQSFkgZmlybXdhcmUgbGVmdCBpbiBwbGFjZS4NCj4NCj5UaGUgYml0
IGFzc2lnbm1lbnQgaGFzIGJlZW4gdmVyaWZpZWQgb24gYW4gUlRMODI2MUNFIChzdWItbW9kZWwg
MHgwMCwgUEhZDQo+SUQgMHgwMDFjYzg5OSk6IG9uIHRoZSBXMTcwMEssIFNlckRlcyByZWdpc3Rl
ciAweDAwMDAgZ29lcyBmcm9tDQo+MHgxNDAzIHRvIDB4MTcwMyBhbmQgMHgwMGMyIGZyb20gMHgw
MDAwIHRvIDB4NjAwMCwgYWZ0ZXIgd2hpY2ggVkVORDENCj4weDc1OGQgcmVwb3J0cyB0aGUgU2Vy
RGVzIGxpbmtlZCAoMHgwMDEwIC0+IDB4MDAxZSkgYW5kIHRoZSBsaW5rIGNvbWVzIHVwIGF0DQo+
MUcgYW5kIDEwRyBhbmQgcGFzc2VzIHRyYWZmaWMuIFRoZSBSVEw4MjYxQywgUlRMODI2MUQgYW5k
IFJUTDgyNjFEX1ZNDQo+c2hhcmUgcnRsODI2MXhfY29uZmlnX2luaXQoKSBhbmQgZ2V0IHRoZSBz
YW1lIHRyZWF0bWVudCwgYnV0IGhhdmUgbm90IGJlZW4NCj50ZXN0ZWQgd2l0aCBpbnZlcnRlZCBs
YW5lcy4NCj4NCj5Bc3Npc3RlZC1ieTogTExNDQo+U2lnbmVkLW9mZi1ieTogU2ltb24gUG9sYWNr
IDxzcG9sYWNrK2dpdEBtYWlsYm94Lm9yZz4NCj4tLS0NCj4gZHJpdmVycy9uZXQvcGh5L3JlYWx0
ZWsvS2NvbmZpZyAgICAgICAgfCAgIDEgKw0KPiBkcml2ZXJzL25ldC9waHkvcmVhbHRlay9yZWFs
dGVrX21haW4uYyB8IDE3NCArKysrKysrKysrKysrKysrKysrKystLS0tDQo+IDIgZmlsZXMgY2hh
bmdlZCwgMTQ4IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPg0KPmRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9waHkvcmVhbHRlay9LY29uZmlnIGIvZHJpdmVycy9uZXQvcGh5L3JlYWx0
ZWsvS2NvbmZpZw0KPmluZGV4IGE3NDFiMzRkMTkzZS4uYTkyNzJhZWJlMjZkIDEwMDY0NA0KPi0t
LSBhL2RyaXZlcnMvbmV0L3BoeS9yZWFsdGVrL0tjb25maWcNCj4rKysgYi9kcml2ZXJzL25ldC9w
aHkvcmVhbHRlay9LY29uZmlnDQo+QEAgLTEsNiArMSw3IEBADQo+ICMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb25seSAgY29uZmlnIFJFQUxURUtfUEhZDQo+ICAgICAgICB0cmlz
dGF0ZSAiUmVhbHRlayBQSFlzIg0KPisgICAgICAgc2VsZWN0IFBIWV9DT01NT05fUFJPUFMNCj4g
ICAgICAgIHNlbGVjdCBQSFlfUEFDS0FHRQ0KPiAgICAgICAgaGVscA0KPiAgICAgICAgICBDdXJy
ZW50bHkgc3VwcG9ydHMgUlRMODIxeC9SVEw4MjJ4IGFuZCBmYXN0IGV0aGVybmV0IFBIWXMgZGlm
ZiAtLWdpdA0KPmEvZHJpdmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVhbHRla19tYWluLmMNCj5iL2Ry
aXZlcnMvbmV0L3BoeS9yZWFsdGVrL3JlYWx0ZWtfbWFpbi5jDQo+aW5kZXggMWU2NzA2MzhkZDFj
Li4wNGQzOTdmMGEyZDggMTAwNjQ0DQo+LS0tIGEvZHJpdmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVh
bHRla19tYWluLmMNCj4rKysgYi9kcml2ZXJzL25ldC9waHkvcmVhbHRlay9yZWFsdGVrX21haW4u
Yw0KPkBAIC0xMyw5ICsxMywxMSBAQA0KPiAjaW5jbHVkZSA8bGludXgvZmlybXdhcmUuaD4NCj4g
I2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ICNpbmNsdWRlIDxsaW51eC9waHkuaD4NCj4rI2luY2x1
ZGUgPGxpbnV4L3BoeS9waHktY29tbW9uLXByb3BzLmg+DQo+ICNpbmNsdWRlIDxsaW51eC9wbV93
YWtlaXJxLmg+DQo+ICNpbmNsdWRlIDxsaW51eC9uZXRkZXZpY2UuaD4NCj4gI2luY2x1ZGUgPGxp
bnV4L21vZHVsZS5oPg0KPisjaW5jbHVkZSA8bGludXgvcHJvcGVydHkuaD4NCj4gI2luY2x1ZGUg
PGxpbnV4L2RlbGF5Lmg+DQo+ICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gI2luY2x1ZGUgPGxp
bnV4L3N0cmluZ19jaG9pY2VzLmg+DQo+QEAgLTE2NCw2ICsxNjYsNyBAQA0KPiAjZGVmaW5lICAg
UlRMODIyWF9WTkQxX1NFUkRFU19JTkJBTkRfRElTQUJMRSAgIDB4NzFkMA0KPiAjZGVmaW5lICAg
UlRMODIyWF9WTkQxX1NFUkRFU19JTkJBTkRfRU5BQkxFICAgIDB4NzBkMA0KPiAjZGVmaW5lIFJU
TDgyMlhfVk5EMV9TRVJERVNfREFUQSAgICAgICAgICAgICAgIDB4NzU4OQ0KPisjZGVmaW5lIFJU
TDgyMlhfVk5EMV9TRVJERVNfUkRBVEEgICAgICAgICAgICAgIDB4NzU4YQ0KPg0KPiAjZGVmaW5l
IFJUTDgyMlhfVk5EMl9UT19QQUdFKHJlZykgICAgICAgICAgICAgICgocmVnKSA+PiA0KQ0KPiAj
ZGVmaW5lIFJUTDgyMlhfVk5EMl9UT19QQUdFX1JFRyhyZWcpICAgICAgICAgICgxNiArICgoKHJl
ZykgJiBHRU5NQVNLKDMsDQo+MCkpID4+IDEpKQ0KPkBAIC0yNzEsNiArMjc0LDE4IEBADQo+ICNk
ZWZpbmUgUlRMODI2MVhfSU5UX0FMRFBTX0NIRyAgICAgICAgIEJJVCg5KQ0KPiAjZGVmaW5lIFJU
TDgyNjFYX0lOVF9KQUJCRVIgICAgICAgICAgICBCSVQoMTApDQo+DQo+Ky8qIFNlckRlcyBsYW5l
IHBvbGFyaXR5LCBiZWhpbmQgdGhlIFZFTkQxIFNlckRlcyBjb21tYW5kIHdpbmRvdy4gVGhpcw0K
PitpcyBub3QNCj4rICogdGhlIGdsb2JhbCBpbnZlcnNpb24gYml0IHRoYXQgb3RoZXIgUmVhbHRl
ayAxMEcgUEhZcyB1c2U7IHRoZSBiaXQNCj4rICogYXNzaWdubWVudCBiZWxvdyBoYXMgb25seSBi
ZWVuIHZlcmlmaWVkIG9uIGFuIFJUTDgyNjFDRSByZXBvcnRpbmcNCj4rUEhZIElEDQo+KyAqIDB4
MDAxY2M4OTkuDQo+KyAqLw0KPisjZGVmaW5lIFJUTDgyNjFYX1NFUkRFU19QT0xfUkVHMCAgICAg
ICAweDAwMDANCj4rI2RlZmluZSAgUlRMODI2MVhfU0VSREVTX1BPTF9SRUcwX1RYICAgQklUKDgp
DQo+KyNkZWZpbmUgIFJUTDgyNjFYX1NFUkRFU19QT0xfUkVHMF9SWCAgIEJJVCg5KQ0KPisjZGVm
aW5lIFJUTDgyNjFYX1NFUkRFU19QT0xfUkVHQzIgICAgICAweDAwYzINCj4rI2RlZmluZSAgUlRM
ODI2MVhfU0VSREVTX1BPTF9SRUdDMl9UWCAgQklUKDE0KSAjZGVmaW5lDQo+K1JUTDgyNjFYX1NF
UkRFU19QT0xfUkVHQzJfUlggIEJJVCgxMykNCj4rDQoNCkhpLA0KDQpUaGFua3MgZm9yIHN1Ym1p
dHRpbmcgdGhpcyBwYXRjaC4NCg0KVGhlIHNlcmRlcyByZWdpc3RlcnMgbW9kaWZpZWQgaW4gdGhp
cyBwYXRjaCBhcmUgbm90IHVuaWZpZWQgYWNyb3NzIFJUTDgyNjEgZmFtaWx5LiBUaGlzIHBhdGNo
IHdpbGwgbGVhZCB0byB1bmRlZmluZWQgYmVoYXZpb3JzIG9uIG90aGVyIElDLiBBbmQgb3BlcmF0
aW5nIHRoZXNlIFNlckRlcyByZWdpc3RlcnMgcmVxdWlyZXMgYSBzcGVjaWZpYyBoYXJkd2FyZSBj
b250cm9sIGZsb3cuIFRoZSBkaXJlY3QgbWFuaXB1bGF0aW9uIHVzZWQgaW4gdGhpcyBwYXRjaCB3
aWxsIGludHJvZHVjZSB1bmtub3duIHJpc2suDQoNClRoZXJlZm9yZSwgd2Uga2luZGx5IHN1Z2dl
c3QgZHJvcCB0aGlzIHBhdGNoLg0KDQpCUlMsDQpKYXZlbg0KDQo=
