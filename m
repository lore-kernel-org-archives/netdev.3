Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49A447807;
	Thu,  8 Oct 2026 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447187; cv=none; b=unXvQ2buDSt+x9BLt2oaYc/SztXGd0wiZdK6+Ik8ZTpLLcaCiiPNzfdv7teIrRMyVebCr1TaCaHEyk4RZFrCANsJZnZ/T4z2uKuYyjaPzKBJMvGXCUm4DvSHoUbJMxvZQ19U5rbhnqLVkVrxwsDfzDk1CDjnXxwlTroKdUnWDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447187; c=relaxed/simple;
	bh=OtjlvuWVh9wi3HW6K8YW83rKNQk3WRIGleru4XsNFWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R9rQZxfaf1n73gn4KVGrTHHxCdygITOQiEFqzyAwdAZuCWqtah8mr70BOXTQ0XPs5LzDeCfXQEg9OqPddHzoiBcoielcDLeM9XrIeRYmIjCEFrN7kPZ26flVvX5TH8HXunfhxFUZNt1jcc92SyqHRcM4+uJy8qjmfezkZUT+VP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=XMZVX2qa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="XMZVX2qa"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6988CcyR6314731, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1791447158;
	bh=OtjlvuWVh9wi3HW6K8YW83rKNQk3WRIGleru4XsNFWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XMZVX2qamuuCcFHt9MIcGOudmwnYNUfkeul/a7zuxqx2V/mKStrtomwBoLUYu0T8e
	 VTtFOFqW84SyBzFAnJbslM9LwCdYMuuCkZ/601Ij57XsF+aNpELhWHlF/KyFt13l5C
	 VlSlKoGc559govxACs5ishnOWn3KQRCJ8xuTRqj4qBsbKTAy/QNqdyyjS+M9wdqlp1
	 9Fe6xZaXikwrHaQNdHYE5I4iOPhCLyGAVTzLjVf8VmMAIt3RX9/oRM+0caphCNCyzG
	 dlxHRbesAERodpXlOS0iOVF8dd9g9y7NY2fo/7Gur48CMKoLkrBotkjrENr7pLPMAm
	 5uo0Llv6sVpMQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6988CcyR6314731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 16:12:38 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 16:12:37 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.049; Thu,
 8 Oct 2026 16:12:37 +0800
From: Javen <javen_xu@realsil.com.cn>
To: "d.piecha@ymail.com" <d.piecha@ymail.com>, Oleksij Rempel
	<o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>
Subject: RE: linux-next: manual merge of the net-next tree with the net tree
Thread-Topic: linux-next: manual merge of the net-next tree with the net tree
Thread-Index: AQHdUbG5SCctzw8m1UKvxMWuI5v70rbpWGEAgAn4EBA=
Date: Thu, 8 Oct 2026 08:12:37 +0000
Message-ID: <0e0b727e94d046b19ad463e7a1a9fe68@realsil.com.cn>
References: <ar5vAxEqS8tO8aVT@sirena.org.uk> <ar9fVCfceZG7Nz3l@pengutronix.de>
In-Reply-To: <ar9fVCfceZG7Nz3l@pengutronix.de>
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

SGkgRGVubmlzLCBPbGVrc2lqLA0KDQo+DQo+SGkgSmF2ZW4sDQo+DQo+T24gVGh1LCBPY3QgMDEs
IDIwMjYgYXQgMDM6MzI6MzVQTSArMDEwMCwgTWFyayBCcm93biB3cm90ZToNCj4+IEhpIGFsbCwN
Cj4+DQo+PiBUb2RheSdzIGxpbnV4LW5leHQgbWVyZ2Ugb2YgdGhlIG5ldC1uZXh0IHRyZWUgZ290
IGEgY29uZmxpY3QgaW46DQo+Pg0KPj4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4
MTY5X21haW4uYw0KPj4NCj4+IGJldHdlZW4gY29tbWl0Og0KPj4NCj4+ICAgM2NkZWFlZjE3NTRh
YiAoInI4MTY5OiBkaXNhYmxlIEVFRSBvbiBSVEw4MTY4aC84MTExaCIpDQo+Pg0KPj4gZnJvbSB0
aGUgbmV0IHRyZWUgYW5kIGNvbW1pdDoNCj4+DQo+PiAgIDhhM2M3NjUyM2U0NDkgKCJyODE2OTog
YWRkIHN1cHBvcnQgZm9yIHBoeWxpbmsiKQ0KPj4NCj4+IGZyb20gdGhlIG5ldC1uZXh0IHRyZWUu
DQo+Pg0KPj4gSSBmaXhlZCBpdCB1cCAoc2VlIGJlbG93KSBhbmQgY2FuIGNhcnJ5IHRoZSBmaXgg
YXMgbmVjZXNzYXJ5LiBUaGlzIGlzDQo+PiBub3cgZml4ZWQgYXMgZmFyIGFzIGxpbnV4LW5leHQg
aXMgY29uY2VybmVkLCBidXQgYW55IG5vbiB0cml2aWFsDQo+PiBjb25mbGljdHMgc2hvdWxkIGJl
IG1lbnRpb25lZCB0byB5b3VyIHVwc3RyZWFtIG1haW50YWluZXIgd2hlbiB5b3VyDQo+PiB0cmVl
IGlzIHN1Ym1pdHRlZCBmb3IgbWVyZ2luZy4gIFlvdSBtYXkgYWxzbyB3YW50IHRvIGNvbnNpZGVy
DQo+PiBjb29wZXJhdGluZyB3aXRoIHRoZSBtYWludGFpbmVyIG9mIHRoZSBjb25mbGljdGluZyB0
cmVlIHRvIG1pbmltaXNlDQo+PiBhbnkgcGFydGljdWxhcmx5IGNvbXBsZXggY29uZmxpY3RzLg0K
Pj4NCj4+IGRpZmYgLS1jYyBkcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4u
Yw0KPj4gaW5kZXggZWUxYmM5YmQwNDQ3MCwxZDA2ZGRmZjk4MzI3Li4wMDAwMDAwMDAwMDAwDQo+
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYw0KPj4gKysr
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4+IEBAQCAtNTQ3
NCwyMiAtNTYxOSw2ICs1NjE5LDEyIEBAQCBzdGF0aWMgaW50DQo+cjgxNjlfbWRpb19yZWdpc3Rl
cihzdHJ1Y3Qgcg0KPj4gICAgICAgICAgICAgICByZXR1cm4gLUVVTkFUQ0g7DQo+PiAgICAgICB9
DQo+Pg0KPj4gLSAgICAgdHAtPnBoeWRldi0+bWFjX21hbmFnZWRfcG0gPSB0cnVlOw0KPj4gLSAg
ICAgaWYgKHJ0bF9zdXBwb3J0c19lZWUodHApKQ0KPj4gLSAgICAgICAgICAgICBwaHlfc3VwcG9y
dF9lZWUodHAtPnBoeWRldik7DQo+PiAtICAgICBwaHlfc3VwcG9ydF9hc3ltX3BhdXNlKHRwLT5w
aHlkZXYpOw0KPj4gLQ0KPj4gLSAgICAgLyogbWltaWMgYmVoYXZpb3Igb2YgcjgxMjUvcjgxMjYg
dmVuZG9yIGRyaXZlcnMgKi8NCj4+IC0gICAgIGlmICh0cC0+bWFjX3ZlcnNpb24gPT0gUlRMX0dJ
R0FfTUFDX1ZFUl82MSkNCj4+IC0gICAgICAgICAgICAgcGh5X2Rpc2FibGVfZWVlX21vZGUodHAt
PnBoeWRldiwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRVRIVE9PTF9M
SU5LX01PREVfMjUwMGJhc2VUX0Z1bGxfQklUKTsNCj4+IC0NCj4+ICArICAgIC8qIEtlZXAgRUVF
IG9mZiBidXQgdGhlIHZlcnNpb24gc3RheXMgRUVFLWNhcGFibGUgc28gdGhhdCBsaW5rLXVwDQo+
PiAgKyAgICAgKiBzdGlsbCBjbGVhcnMgdGhlIE1BQyBUWC1MUEkgYml0cy4NCj4+ICArICAgICAq
Lw0KPj4gICsgICAgaWYgKHRwLT5tYWNfdmVyc2lvbiA9PSBSVExfR0lHQV9NQUNfVkVSXzQ2KQ0K
Pj4gICsgICAgICAgICAgICBwaHlfZGlzYWJsZV9lZWUodHAtPnBoeWRldik7DQo+PiAgKw0KPj4g
ICAgICAgLyogUEhZIHdpbGwgYmUgd29rZW4gdXAgaW4gcnRsX29wZW4oKSAqLw0KPj4gICAgICAg
cGh5X3N1c3BlbmQodHAtPnBoeWRldik7DQo+DQo+SSBndWVzcyB0aGlzIHF1aXJrIHNob3VsZCBi
ZSBmb2xkZWQgaW4gdG8gcnRsODE2OV9nZXRfbHBpX2NhcHMoKSBvcg0KPnJ0bF9zdXBwb3J0c19l
ZWUoKS4gQ2FuIHlvdSBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgaXQ/IEkgZG8gbm90IGhhdmUgYWNj
ZXNzIHRvIGFueQ0KPnN0YW5kIGFsb25lIHJlYWx0ZWsgTUFDcy4NCg0KZHJpdmVycy9uZXQvZXRo
ZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMgfCAxMiArKysrKystLS0tLS0NCiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYw0KaW5kZXggNDNjNDZkNDgzZWI4Li4zZTAyZDljMTA1
YTkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4u
Yw0KKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCkBAIC01
NjE5LDEyICs1NjE5LDYgQEAgc3RhdGljIGludCByODE2OV9tZGlvX3JlZ2lzdGVyKHN0cnVjdCBy
dGw4MTY5X3ByaXZhdGUgKnRwKQ0KIAkJcmV0dXJuIC1FVU5BVENIOw0KIAl9DQogDQotCS8qIEtl
ZXAgRUVFIG9mZiBidXQgdGhlIHZlcnNpb24gc3RheXMgRUVFLWNhcGFibGUgc28gdGhhdCBsaW5r
LXVwDQotCSAqIHN0aWxsIGNsZWFycyB0aGUgTUFDIFRYLUxQSSBiaXRzLg0KLQkgKi8NCi0JaWYg
KHRwLT5tYWNfdmVyc2lvbiA9PSBSVExfR0lHQV9NQUNfVkVSXzQ2KQ0KLQkJcGh5X2Rpc2FibGVf
ZWVlKHRwLT5waHlkZXYpOw0KLQ0KIAkvKiBQSFkgd2lsbCBiZSB3b2tlbiB1cCBpbiBydGxfb3Bl
bigpICovDQogCXBoeV9zdXNwZW5kKHRwLT5waHlkZXYpOw0KIA0KQEAgLTU5MjAsNiArNTkxNCwx
MiBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBydGw4MTY5X2dldF9scGlfY2FwcyhzdHJ1Y3QgcnRs
ODE2OV9wcml2YXRlICp0cCkNCiAJaWYgKCFydGxfc3VwcG9ydHNfZWVlKHRwKSB8fCB0cC0+c2Zw
X21vZGUgPT0gUlRMX1NGUF84MTI3X0FURikNCiAJCXJldHVybiAwOw0KIA0KKwkvKiBLZWVwIEVF
RSBvZmYgb24gUlRMODE2OGgvODExMWggYnV0IHRoZSB2ZXJzaW9uIHN0YXlzIEVFRS1jYXBhYmxl
IHNvDQorCSAqIHRoYXQgbWFjX2Rpc2FibGVfdHhfbHBpIGNhbGxiYWNrIHN0aWxsIGNsZWFycyB0
aGUgTUFDIFRYLUxQSSBiaXRzLg0KKwkgKi8NCisJaWYgKHRwLT5tYWNfdmVyc2lvbiA9PSBSVExf
R0lHQV9NQUNfVkVSXzQ2KQ0KKwkJcmV0dXJuIDA7DQorDQogCWNhcHMgfD0gTUFDXzEwMEZEIHwg
TUFDXzEwMDBGRDsNCiANCiAJLyogbWltaWMgYmVoYXZpb3Igb2YgcjgxMjUvcjgxMjYgdmVuZG9y
IGRyaXZlcnMNCi0tIA0KMi40My4wDQoNCkkgaGF2ZSBhZGFwdGVkIHRoaXMgd29ya2Fyb3VuZCB0
byBwaHlsaW5rIGZyYW1ld29yay4NCg0KV2l0aCB0aGUgcGF0Y2ggdGhlIE5JQyByZXBvcnRzIEVF
RSBhcyBub3Qgc3VwcG9ydGVkLiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgZG8gYSB0ZXN0IHRvIHNl
ZSBpZiB0aGUgUlggc3RhbGwgaXMgZ29uZT8NCg0KQlJzLA0KSmF2ZW4NCg==
