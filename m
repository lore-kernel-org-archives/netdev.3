Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.181.50.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478760;
	b=MxPbi1GPqO9k9Ieax3dIW19ZJXDUhd4+lth48+ZStVBeDpxFamQhK4R4j46lYxdREY4e
	 zauXKX0PY/7Q+l4wzooKMRaqpImC0yv7+1ynT28iSnbixxiuSMIptaay25Xn2sg5Zj3DN
	 2ZAOTOxruX8xqPjPJstgmdMLqQ38e/CZ+sSg3lZp1rEHzixweDOT0L4I7z+P8gH/LuxEA
	 hVzl6AiDzwYvHXgHgdppF4RbBNzfT0UiYbJ8eURMY2zoLEvMobnj+mlbudgzwi9OJhAva
	 3lS0jzqW9XFcnal9+hvX4hTe04P9s2rI5hkXzqhFBqyTC3hBS4E+VHl2tp/0jRoid+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478760;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 DKIM-Signature;
	bh=pY+jHYqacW53aGPVQlsITJbWPYPkjGEhS1f+2DPF9mk=;
	b=zqmBD32Ju1DGqJpQd2/RCTGAEOUEmK3WwbK/PE715QHOZCvJjj472rQWpb7K82qzMW9e
	 3DPJxJkT2K6pahIjHqJvczCRWGmTCNOShnXDTG+PvOb8XtvG+X8TSEd/iAKNhWjIRQFQd
	 w0p4OBDdvHHw90Avl6WlLxN813dFx5MD+SGj9ObTFoc1uYxAxsEjbRvFZrCiHslBJ0Axn
	 oasQsl6eIbf4Foe2qGiNX+4Gl07OL6dC+7ZL+aCUilXBz38YHdhLyh6sPyGrSQZof5U3a
	 lxQSOwReeF7DO1L6D11gLEtfv0/8VvHJIV30a07KVw6/ER4dgqTxGKTDIvtkngzBgcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=QGRqSjq9;
	arc=none smtp.remote-ip=220.181.50.185
Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7E19B606A31E;
	Tue, 20 Oct 2026 06:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E19B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=QGRqSjq9
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.45
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Hangbin Liu <hangbin.liu@linux.dev>
CC: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hangbin Liu
	<liuhangbin@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbUEFUQ0hdIHRlYW06IGZpeCBwcm9taXNjL2Fs?=
 =?gb2312?B?bG11bHRpIGxlYWsgaW4gdGVhbV9wb3J0X2FkZCBlcnJvciBwYXRo?=
Thread-Topic: [????] Re: [PATCH] team: fix promisc/allmulti leak in
 team_port_add error path
Thread-Index: AQHdX6Q+0WyQSL0fHEKaEJcut0OQcrcFI+mAgADZv9A=
Date: Tue, 20 Oct 2026 06:45:45 +0000
Message-ID: <bf6a5ad0e59f47f58e0e6f475ffffa2f@baidu.com>
References: <20261019083122.1841-1-lirongqing@baidu.com>
 <atbHq7a_YzR6VuTg@fedora>
In-Reply-To: <atbHq7a_YzR6VuTg@fedora>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1792478748;
	bh=pY+jHYqacW53aGPVQlsITJbWPYPkjGEhS1f+2DPF9mk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=QGRqSjq9uieIG4fIzhYws5BDXOR+QxGlzNPoB0dG+4Cx75yeeZmr+BYmMjPmItzip
	 E7w4xxDX3a02vbKzIDS07hFZgqglLa+apncT24D2An/7mqOUHBVV8BJ4Aafoa9DfyH
	 c6UXEyc8CxcpzLEI+K2At/6TpWg9bS0PZk3d7V7z/EsUTWUCa08NITSQp9PDqUOU57
	 vQRC5kOAAC9gqgUh1uW7iGWodguLuZtOTT+w/Phu0Nc6Z1w7uCzfX+sBD8fKZDJnV2
	 Gkyh0tLeaPSeh5TavhK7YVBVfmfFIVDI+PowYEzm82cSHortWCbRLQNydOefnhikAZ
	 jvycuGYjODaOQ==

DQoNCj4gZXJyb3IgcGF0aA0KPiANCj4gSGkgUm9uZ3FpbmcsDQo+IE9uIE1vbiwgT2N0IDE5LCAy
MDI2IGF0IDA0OjMxOjIyUE0gKzA4MDAsIGxpcm9uZ3Fpbmcgd3JvdGU6DQo+ID4gRnJvbTogTGkg
Um9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+DQo+ID4gdGVhbV9wb3J0X2FkZCgp
IGluY3JlbWVudHMgdGhlIHBvcnQncyBwcm9taXNjdWl0eSBhbmQgYWxsbXVsdGkgY291bnRzDQo+
ID4gYmVmb3JlIGNhbGxpbmcgdGVhbV9kZXZfdHlwZV9jaGVja19jaGFuZ2UoKS4gSWYgdGhlIGxh
dHRlciBmYWlscywgdGhlDQo+ID4gZXJyb3IgcGF0aCBkb2VzIG5vdCB1bmRvIHRoZXNlIGluY3Jl
bWVudHMsIGxlYXZpbmcgdGhlIHBvcnQgaW4NCj4gPiBwcm9taXNjdW91cyBhbmQgYWxsbXVsdGkg
bW9kZSBldmVuIHRob3VnaCBpdCB3YXMgbm90IHN1Y2Nlc3NmdWxseQ0KPiA+IGFkZGVkIHRvIHRo
ZSB0ZWFtLg0KPiA+DQo+ID4gVW5kbyBib3RoIGluY3JlbWVudHMgaW4gZXJyX3NldF9kZXZfdHlw
ZSwgbWF0Y2hpbmcgdGhlIGNsZWFudXANCj4gPiBwZXJmb3JtZWQgYnkgdGVhbV9wb3J0X2RlbCgp
Lg0KPiA+DQo+ID4gRml4ZXM6IDQzYzJhZGI5ZGY3ZCAoInRlYW06IHNldCBzbGF2ZSB0byBwcm9t
aXNjIGlmIHRlYW0gaXMgYWxyZWFkeSBpbg0KPiA+IHByb21pc2MgbW9kZSIpDQo+ID4gU2lnbmVk
LW9mZi1ieTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL25ldC90ZWFtL3RlYW1fY29yZS5jIHwgNCArKysrDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC90
ZWFtL3RlYW1fY29yZS5jDQo+ID4gYi9kcml2ZXJzL25ldC90ZWFtL3RlYW1fY29yZS5jIGluZGV4
IGNhNzVmMDguLjNiMzAwNjMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvdGVhbS90ZWFt
X2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3RlYW0vdGVhbV9jb3JlLmMNCj4gPiBAQCAt
MTM4Niw2ICsxMzg2LDEwIEBAIHN0YXRpYyBpbnQgdGVhbV9wb3J0X2FkZChzdHJ1Y3QgdGVhbSAq
dGVhbSwNCj4gc3RydWN0IG5ldF9kZXZpY2UgKnBvcnRfZGV2LA0KPiA+ICAJcmV0dXJuIDA7DQo+
ID4NCj4gPiAgZXJyX3NldF9kZXZfdHlwZToNCj4gPiArCWlmIChkZXYtPmZsYWdzICYgSUZGX1BS
T01JU0MpDQo+ID4gKwkJZGV2X3NldF9wcm9taXNjdWl0eShwb3J0X2RldiwgLTEpOw0KPiA+ICsJ
aWYgKGRldi0+ZmxhZ3MgJiBJRkZfQUxMTVVMVEkpDQo+ID4gKwkJZGV2X3NldF9hbGxtdWx0aShw
b3J0X2RldiwgLTEpOw0KPiA+ICBlcnJfc2V0X3NsYXZlX2FsbG11bHRpOg0KPiANCj4gSSB0aGlu
ayB3ZSBjYW4gcmVtb3ZlIHRoZSBkZXZfc2V0X3Byb21pc2N1aXR5KHBvcnRfZGV2LCAtMSk7IGlu
IGlmIChkZXYtPmZsYWdzDQo+ICYgSUZGX0FMTE1VTFRJKSBhbmQgbW92ZSBpdCB1bmRlciBoZXJl
Lg0KPiANCg0KUmVhc29uYWJsZSwgSSB3aWxsIHNlbmQgVjIsIHRoYW5rcyANCg0KW0xpLFJvbmdx
aW5nXSANCg0KDQo+IA0KPiBUaGFua3MNCj4gSGFuZ2Jpbg0K
