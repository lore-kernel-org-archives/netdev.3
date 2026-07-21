Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A96363C62;
	Tue, 21 Jul 2026 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630316; cv=none; b=VXAjBfi2+okx1dOOJVH3csk03+tnKYleTlsNniOJ2fE3Vhff1SePdhQ2lwnxlmGGJGTJnPhw6XARtuzauEpG+wGS2dQwiOdOok79Mnc/PvjJGL5Yd/ylcLZ5fPLsplR6fcaZue8eG1nPqDMbiYok18N5gkEPkC9rGolp7a61O4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630316; c=relaxed/simple;
	bh=wxHkabTvhqOu1bwSz3KohLkH7YMXnkDGS6XvPWtPUrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ShPfoh4shKiqcuarBNYGG0u7wiBogDTN/z6UbUs/No6VN6XaZjNQm5IYPZwdXAmzivJ30NBVCn0OYG14Cq98U/PDArQOiFU4sBqCtiz+9NsQ6aJERH3tWd4Uxrs0qfy9O9M4lt6Ylm9e9LLaOnpIvdocKuTLNbSQw2Lqy99fzgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=aXSjm1Cw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="aXSjm1Cw"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66LAbdMP33110061, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1784630260;
	bh=wxHkabTvhqOu1bwSz3KohLkH7YMXnkDGS6XvPWtPUrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=aXSjm1CwAXGgcjTXdBDtDJmbvhg1S8b9N5wxbbhtWbJNP+CK2XfxqycgjXh8PZW1O
	 J3mkFiH8By/YPF/yTJmUWe8RYMRGyPTpshFobO1BEm29AxuiZAJeSVQmmjSllCoEnx
	 gLF+ULz9ELBVKLEfR68YIa8SFpLBWFXt4lIItImBhMelATK5DMRJCvRR5wi5TlUK48
	 A9IX407wcR8VbpwPBe4q5RxfhepxwMWI8xhRAhw42Vf8+T9UdDCmlwOPbqE5100Z+J
	 1+KHiFudRbx/oITB/AVqVVuKTGEMp+cHDeL5zm8p7riZGeWCGYtPW7oR0O9wkqOhKN
	 3+StwBJ9R7CwA==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66LAbdMP33110061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 18:37:40 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 18:37:40 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.043; Tue,
 21 Jul 2026 18:37:40 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "enelsonmoore@gmail.com" <enelsonmoore@gmail.com>,
	"daniel@thingy.jp" <daniel@thingy.jp>
Subject: RE: [PATCH net-next v6 2/7] net: phy: phylink: add helper to modify
 pause
Thread-Topic: [PATCH net-next v6 2/7] net: phy: phylink: add helper to modify
 pause
Thread-Index: AQHdD4oZroBMux4FbUmVRxSq3rFPErZmAfkAgAUT7jCAASfegIALjzrw//99foCAAJAcgA==
Date: Tue, 21 Jul 2026 10:37:40 +0000
Message-ID: <9ca915e4384a48f1832e4d0e24a977d8@realsil.com.cn>
References: <20260709100237.541-1-javen_xu@realsil.com.cn>
 <20260709100237.541-3-javen_xu@realsil.com.cn>
 <0c188a7d-3637-4e08-9ac8-c1d824b461ed@bootlin.com>
 <aeed474059bc4fd7b9c5e3074ef591a4@realsil.com.cn>
 <044a9996-1cd0-49c4-892b-fb267037c568@bootlin.com>
 <ba61c475562f49c4a18038130f3508bc@realsil.com.cn>
 <c1e3f0c6-89a7-42de-ad77-aede3cd93ea5@bootlin.com>
In-Reply-To: <c1e3f0c6-89a7-42de-ad77-aede3cd93ea5@bootlin.com>
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

Pg0KPkhpIEphdmVuLA0KPg0KPk9uIDcvMjEvMjYgMTE6NTIsIEphdmVuIHdyb3RlOg0KPj4gSGkg
TWF4aW1lLA0KPj4NCj4+Pg0KPj4+IEhpIEphdmVuLA0KPj4+DQo+Pj4gT24gNy8xMy8yNiAwOTo1
MSwgSmF2ZW4gd3JvdGU6DQo+Pj4+IEhpLA0KPj4+Pg0KPj4+Pj4gVGhlcmUncyBhIGNoYW5nZSBp
biB0aGUgTUFDJ3MgYWJpbGl0eSB0byBzdXBwb3J0IFBhdXNlLCBzbyB3ZSBzaG91bGQgOg0KPj4+
Pj4NCj4+Pj4+IC0gUmVjb21wdXRlIHRoZSBwbC0+c3VwcG9ydGVkIGZpZWxkLiBVcGRhdGUgdGhl
DQo+Pj4+PiBjb25maWcubWFjX2NhcGFiaWxpdGllcyB3aXRoIHRoZQ0KPj4+Pj4gICBuZXcgcGF1
c2Ugc2V0dGluZ3MsIGNhbGxpbmcgcGh5bGlua192YWxpZGF0ZSgpIHNob3VsZCBkbyB0aGUNCj4+
Pj4+IHRyaWNrIEkgdGhpbmssDQo+Pj4gdGhpcw0KPj4+Pj4gICB3aWxsIHJlYnVpbGQgdGhlIGNh
cGFiaWxpdHkgbGlzdDoNCj4+Pj4+DQo+Pj4+PiAgIHBoeWxpbmtfdmFsaWRhdGUocGwsIHBsLT5z
dXBwb3J0ZWQsICZwbC0+bGlua19jb25maWcpOw0KPj4+Pj4NCj4+Pj4+IC0gVGhlbiB1cGRhdGUg
dGhlIHBsLT5saW5rX2NvbmZpZy5wYXVzZSwNCj4+Pj4+DQo+Pj4+PiAtIFRoZW4gdXBkYXRlIHRo
ZSBwYXVzZSBhZHZlcnRpc2luZywgbGlrZSBkb25lIGluIHBoeWxpbmtfc2V0cGF1c2VwYXJhbQ0K
Pj4+Pj4gICAoIEkgdGhpbmssIGV2ZXJ5dGhpbmcgdGhhdCBjb21lcyBhZnRlciBwbC0+c3RhdGVf
bXV0ZXggZ2V0cyByZWxlYXNlZCBpbg0KPj4+Pj4gICAgcGh5bGlua19ldGh0b29sX3NldF9wYXVz
ZXBhcmFtKQ0KPj4+Pj4NCj4+Pj4+IElkZWFsbHksIHRoZSBsb2dpYyB0byB1cGRhdGUgdGhlIGFk
dmVydGlzaW5nIGFuZCByZS10cmlnZ2VyIGENCj4+Pj4+IG5lZ29jaWF0aW9uIHNob3VsZCBiZSBm
YWN0b3JlZCBvdXQgaW4gYSBwcml2YXRlIGhlbHBlciwgdGhlbiByZXVzZWQNCj4+Pj4+IGZyb20g
Ym90aCB0aGlzIHBhdGggKE1BQyB1cGRhdGVzIHBhdXNlIHN1cHBvcnQpIGFuZCB0aGUNCj4+PiBw
aHlsaW5rX2V0aHRvb2xfc2V0X3BhdXNlcGFyYW0gcGF0aC4NCj4+Pj4+DQo+Pj4+PiBNYXhpbWUN
Cj4+Pj4NCj4+Pj4gVGhhbmtzIGZvciByZXZpZXcgYW5kIGhlbHBmdWwgc3VnZ2VzdGlvbnMuDQo+
Pj4+DQo+Pj4+IEkgYWdyZWUgd2l0aCB5b3VyIHN1Z2dlc3Rpb24gdG8gZmFjdG9yIG91dCB0aGUg
bG9naWMgaW50byBhIHByaXZhdGUNCj4+Pj4gaGVscGVyIGFuZA0KPj4+IHJldXNlIGl0IGZvciBi
b3RoIHBoeWxpbmtfZXRodG9vbF9zZXRfcGF1c2VwYXJhbSgpIGFuZA0KPj4+IHBoeWxpbmtfdXBk
YXRlX21hY19wYXVzZV9jYXBhYmlsaXRpZXMoKS4NCj4+Pj4NCj4+Pj4gSGVyZSBpcyB0aGUgcmVm
YWN0b3JlZCBsb2dpYy4gSSB3YW50IHRvIHNoYXJlIHRoaXMgc3BlY2lmaWMgcGFydA0KPj4+PiB3
aXRoIHlvdSBmb3IgYQ0KPj4+IHF1aWNrIGNoZWNrIGJlZm9yZSBJIHN1Ym1pdCB2NyBwYXRjaC4N
Cj4+Pg0KPj4+IEknbSBjdXJyZW50bHkgYXR0ZW5kaW5nIHRoZSBuZXRkZXYgY29uZmVyZW5jZSwg
SXQnbGwgdGFrZSBhIGZldyBkYXlzDQo+Pj4gZm9yIG1lIHRvIGxvb2sgYXQgdGhpcywgc29ycnkg
YWJvdXQgdGhhdCA6Lw0KPj4+DQo+Pj4gTWF4aW1lDQo+Pg0KPj4gSnVzdCBhIGdlbnRsZSBwaW5n
IG9uIHRoaXMgdGhyZWFkLiBDb3VsZCB5b3UgcGxlYXNlIHRha2UgYSBxdWljayBsb29rIGF0IHRo
aXMNCj5yZWZhY3RvcmVkIGxvZ2ljIHdoZW5ldmVyIHlvdSBhcmUgZnJlZT8gQW55IHN1Z2dlc3Rp
b24gd291bGQgYmUgZ3JlYXRseQ0KPmFwcHJlY2lhdGVkLg0KPg0KPlRoYW5rcyBmb3IgdGhlIHBp
bmcsIEkganVzdCBsb29rZWQgYXQgaXQgZnJvbSBhIGhpZ2ggbGV2ZWwgYW5kIHRoaXMgaXMgdGhl
IHRoaW5nIEkNCj5oYWQgaW4gbWluZCB5ZXMgOikNCj4NCj5JIHRoaW5rIHlvdSBjYW4gcG9zdCBh
IG5ldyByZXZpc2lvbiB0aGVuLg0KPg0KPlRoYW5rcyBmb3IgdGhhdCB3b3JrLA0KPg0KPk1heGlt
ZQ0KDQpUaGFua3MgZm9yIHJldmlldy4gSSB3aWxsIHJlc2VuZCB0aGUgbmV4dCB2ZXJzaW9uLg0K
DQpCUnMsDQpKYXZlbg0KDQo=
