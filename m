Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F221338333A;
	Wed,  3 Jun 2026 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780454050; cv=none; b=t2/MkTpxrV/uHwtKYlgEBmmgO878ww/aFLBqHVp8B4bVuq9NOYZVUbfDJbI6ahI5IhSKc5PvrEOYLVWDfns49/vAFT/CrVirKcEED4zFXkzpVWNhShsLPnwiKp62row1+bh+f/WR4eEm9hCpzH/XCwb+00Coqt8u2xB9aiwMftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780454050; c=relaxed/simple;
	bh=p4aFoM/H2PgvAcWTfZbby9wwZpBDoLzO835AXyrmcK4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pXMO0dTg8JXU5oLa+49/i6dOMkscWMLn9XIwHLLKhAdqxqbBkQu3H9oq4w1y9WmIJJRZCHf7b4G2fU9uU6A+h0LpKhkBfTtNN/OSbTwoV2ytL/do391O/r6RBQu6pJOkGSxnBcX7Qlym8uojTXOzm77dSJjUEnh8Z3+cnMF2hR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=ZhY3FsVH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="ZhY3FsVH"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6532WbdX63479084, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780453958;
	bh=p4aFoM/H2PgvAcWTfZbby9wwZpBDoLzO835AXyrmcK4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=ZhY3FsVHTtdcgzfU8uLEuYzZey9m7LR8T8CguMsRY49pRlmSJ8IU0bugaIUBLptZj
	 4xxRQVhKuBer/t82KAOkHJn3t4eSjbsC7pHjqB1Ck5uZCNFpPoLBBF+vWV6ZtQnhp1
	 JOENyEpL7m5MQGSG0UGHd6SwITUhaWEL3Sp87mLUSRS6byOmh0atCk4rcF51nf/Rim
	 +Jej7v6GxRVzH0RGcha5+I3RE5fWA4S05xLEbvP2sNIPbhmCmxfRJcrlLD+9lEz5ln
	 5D4l4HUHHpEYWGf4yLKa31aWgxFp9T8i4lSTeA0egUWeCBj7J+cWcmT6Jsc+OWX2z3
	 i2Tuqq6ZNwWbg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6532WbdX63479084
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 10:32:38 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 10:32:37 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Wed,
 3 Jun 2026 10:32:37 +0800
From: Javen <javen_xu@realsil.com.cn>
To: "nb@tipi-net.de" <nb@tipi-net.de>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, =?gb2312?B?ucvP/r78?=
	<freddy_gu@realsil.com.cn>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	Javen <javen_xu@realsil.com.cn>, "kuba@kernel.org" <kuba@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v1 1/2] net: phy: realtek: add support for
 RTL8261
Thread-Topic: Re: [PATCH net-next v1 1/2] net: phy: realtek: add support for
 RTL8261
Thread-Index: Adzy/8h6VxK4KTARRxedgL4rwPWxeQ==
Date: Wed, 3 Jun 2026 02:32:37 +0000
Message-ID: <10b6718e8fe84e1895f82ea05c446925@realsil.com.cn>
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

SGksIE5pY29sYWkNCg0KPj4gKy8qIENvbmNhdGVuYXRlZCA0LWJpdCBzcGVlZCBjb2RlIHZhbHVl
cyAoU1BEX0ggPDwgMiB8IFNQRF9MKSAqLw0KPj4gKyNkZWZpbmUgUlRMODI2MVhfU1BFRURfQ09E
RV81MDBNCTB4MwkvKiBIPTAsIEw9MyAqLw0KPj4gKyNkZWZpbmUgUlRMODI2MVhfU1BFRURfQ09E
RV8xMDAwTQkweDcJLyogSD0xLCBMPTMgKi8NCj4+ICsjZGVmaW5lIFJUTDgyNjFYX1NQRUVEX0NP
REVfMjUwME0JMHg4CS8qIEg9MiwgTD0wICovDQo+PiArI2RlZmluZSBSVEw4MjYxWF9TUEVFRF9D
T0RFXzUwMDBNCTB4OQkvKiBIPTIsIEw9MSAqLw0KPj4gKyNkZWZpbmUgUlRMODI2MVhfU1BFRURf
NTAwCQk1MDANCj4NCj4gNTAwIE1CaXQvcyBpc250IGEgc3RhbmRhcmQgcmF0ZSB3aGljaCBhbHNv
IGlzbnQgcmVwcmVzZW50ZWQgaW4gZXRodG9vbC4NCj4gSXMgdGhpcyBqdXN0IGZvciBkb2N1bWVu
dGF0aW9uIG9yIGludGVuZGVkIHRvIGJlIHVzZWQ/IElmIHllcywgaG93Pw0KDQpHaWdhLWxpdGUg
KDUwME0pIGlzIGEgUmVhbHRlay1wcm9wcmlldGFyeSBzcGVlZDogd2hlbiB0d28gUmVhbHRlayBQ
SFlzIHN1cHBvcnRpbmcgR2lnYS1saXRlIGFyZSBjb25uZWN0ZWQgYW5kIHRoZSBoaWdoZXIgc3Bl
ZWQgaXMgZGlzYWJsZWQgb3IgdW5zdGFibGUsIGF1dG8tbmVnb3RpYXRpb24gbWF5IGZhbGwgYmFj
ayB0byA1MDBNLiBTaW5jZSBldGh0b29sIGhhcyBubyBTUEVFRF81MDAgZGVmaW5pdGlvbiwgdGhl
IGRyaXZlciByZXBvcnRzIFNQRUVEX1VOS05PV04gZm9yIHRoaXMgY2FzZS4gIFNvIHdlIGFkZCB0
aGlzLg0KDQo+PiArDQo+PiArc3RhdGljIGludCBydGw4MjYxeF9nZXRfZmVhdHVyZXMoc3RydWN0
IHBoeV9kZXZpY2UgKnBoeWRldikNCj4+ICt7DQo+PiArCWludCByZXQ7DQo+PiArDQo+PiArCXJl
dCA9IGdlbnBoeV9jNDVfcG1hX3JlYWRfYWJpbGl0aWVzKHBoeWRldik7DQo+PiArCWlmIChyZXQp
DQo+PiArCQlyZXR1cm4gcmV0Ow0KPj4gKwkvKg0KPj4gKwkgKiBTdXBwbGVtZW50IE11bHRpLUdp
ZyBzcGVlZHMgdGhhdCBtYXkgbm90IGJlIGF1dG9tYXRpY2FsbHkgZGV0ZWN0ZWQNCj4+ICsJICog
UlRMODI2MVggc3VwcG9ydHMgMi41Ry81RyBpbiBhZGRpdGlvbiB0byBzdGFuZGFyZCAxMEcNCj4+
ICsJICovDQo+PiArCWxpbmttb2RlX3NldF9iaXQoRVRIVE9PTF9MSU5LX01PREVfMjUwMGJhc2VU
X0Z1bGxfQklULA0KPj4gKwkJCSBwaHlkZXYtPnN1cHBvcnRlZCk7DQo+PiArCWxpbmttb2RlX3Nl
dF9iaXQoRVRIVE9PTF9MSU5LX01PREVfNTAwMGJhc2VUX0Z1bGxfQklULA0KPj4gKwkJCSBwaHlk
ZXYtPnN1cHBvcnRlZCk7DQo+DQo+RmVhdHVyZSBiaXRzIGZvciAyLjUgYW5kIDUgR0JpdC9zIGFy
ZSBzZXQgdW5jb25kaXRpb25hbGx5IC0gZXZlbiBmb3IgdGhlIA0KPmdlbmVyaWMgdmFyaWFudC4N
Cj5EbyBhbGwgdmFyaWFudHMgaGF2ZSB0aGVzZSBjYXBhYmlsaXRpZXM/IElmIG5vdCBiZXR0ZXIg
YWRkIGNoZWNrIGZvciBhdCANCmw+ZWFzdCB0aGUgZ2VuZXJpYyBvbmUuDQoNClRoYW5rIHlvdSBm
b3IgcG9pbnRpbmcgdGhpcyBvdXQuDQpXZSBjYW4gY29uZmlybSB0aGF0IFJUTDgyNjFDIGFuZCBS
VEw4MjYxRCBzdXBwb3J0IDIuNUcgYW5kIDVHLg0KDQpGb3IgdGhpcyBwYXRjaCBvbmx5IHN1cHBv
cnQgZm9yIFJUTDgyNjFDLCBJIHdpbGwgcmVtb3ZlIHRoZSBjb2RlIGFzc29jaWF0ZWQgd2l0aCBS
VEw4MjYxRC4gQW5kIG90aGVyIHN1Z2dlc3Rpb25zIGFyZSBhbGwgYWNjZXB0ZWQuDQpUaGFua3Mg
Zm9yIHlvdXIgdGltZS4NCg0KQlJzLA0KSmF2ZW4NCg==
