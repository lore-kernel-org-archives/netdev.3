Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3A3AB26B;
	Tue, 21 Jul 2026 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627633; cv=none; b=tiUivpTKHPkJqakCXirStZyc4d4VD+hvAUn2WGmSaHs6jVtAwsmp/wnT60ySN+JmZy8lbGh/Yw8os95DnNZWMeqCW1ELIq+s64V6ay0i4VgWc1JgSqbhoQWNplphgeK1ILSaqBabrLs5QrSyzO/JqkooR0tR75CDxyxTRv89VA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627633; c=relaxed/simple;
	bh=EpHUgotz8m/VwBYix2PhBTYLXewj9q3NtHkqRIpmcIk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JP4Pb+FbnvEmc2npjzEZ+RD52avVC/cHXTQV826av0degGaImzjfG/x4wcIhbuFHwu5Ii48wbHKQccaHa7pae6ctzQtFK4NbxbivjYHarV8mo89ESzShO494RbgVEyFePxlkpIseYbSViFitsanChMa0H0henBDrgdCdpj5NCRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=LzPNQFi1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="LzPNQFi1"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66L9qlndF3096253, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1784627567;
	bh=EpHUgotz8m/VwBYix2PhBTYLXewj9q3NtHkqRIpmcIk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LzPNQFi14XZx9OxvhG1yY5t6LZar8O6+aVurwOC0de7JAeHDcQg+1EZ/KMIDHCHAZ
	 aUsmMnqa3U8kav8XYRk/nbWl/rzrNCYb0fNu1/ocGfz7y0siN3MZQO4sD6/HruTQnO
	 HfUj7IEIoQekWagRK2bREzz214lfSpvXNMCmxemfzO9NrtMFW7wm0Q18lF3wSJqqkC
	 QRzITf+cDJgByoSR/StZv0gi82zKSMbujKVarHyRwojxohHd3OIqqYZ1m+bKAzfzsQ
	 marX+5aBAJmx9kzE6Z+1UmuLuMOvcfstD8HFgJSv502VRHkiMgcfpSF9lft/BMzhQf
	 OKsuqZjUvM8qg==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66L9qlndF3096253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 17:52:47 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Jul 2026 17:52:47 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.043; Tue,
 21 Jul 2026 17:52:47 +0800
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
Thread-Index: AQHdD4oZroBMux4FbUmVRxSq3rFPErZmAfkAgAUT7jCAASfegIALjzrw
Date: Tue, 21 Jul 2026 09:52:47 +0000
Message-ID: <ba61c475562f49c4a18038130f3508bc@realsil.com.cn>
References: <20260709100237.541-1-javen_xu@realsil.com.cn>
 <20260709100237.541-3-javen_xu@realsil.com.cn>
 <0c188a7d-3637-4e08-9ac8-c1d824b461ed@bootlin.com>
 <aeed474059bc4fd7b9c5e3074ef591a4@realsil.com.cn>
 <044a9996-1cd0-49c4-892b-fb267037c568@bootlin.com>
In-Reply-To: <044a9996-1cd0-49c4-892b-fb267037c568@bootlin.com>
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

SGkgTWF4aW1lLA0KDQo+DQo+SGkgSmF2ZW4sDQo+DQo+T24gNy8xMy8yNiAwOTo1MSwgSmF2ZW4g
d3JvdGU6DQo+PiBIaSwNCj4+DQo+Pj4gVGhlcmUncyBhIGNoYW5nZSBpbiB0aGUgTUFDJ3MgYWJp
bGl0eSB0byBzdXBwb3J0IFBhdXNlLCBzbyB3ZSBzaG91bGQgOg0KPj4+DQo+Pj4gLSBSZWNvbXB1
dGUgdGhlIHBsLT5zdXBwb3J0ZWQgZmllbGQuIFVwZGF0ZSB0aGUNCj4+PiBjb25maWcubWFjX2Nh
cGFiaWxpdGllcyB3aXRoIHRoZQ0KPj4+ICAgbmV3IHBhdXNlIHNldHRpbmdzLCBjYWxsaW5nIHBo
eWxpbmtfdmFsaWRhdGUoKSBzaG91bGQgZG8gdGhlIHRyaWNrIEkgdGhpbmssDQo+dGhpcw0KPj4+
ICAgd2lsbCByZWJ1aWxkIHRoZSBjYXBhYmlsaXR5IGxpc3Q6DQo+Pj4NCj4+PiAgIHBoeWxpbmtf
dmFsaWRhdGUocGwsIHBsLT5zdXBwb3J0ZWQsICZwbC0+bGlua19jb25maWcpOw0KPj4+DQo+Pj4g
LSBUaGVuIHVwZGF0ZSB0aGUgcGwtPmxpbmtfY29uZmlnLnBhdXNlLA0KPj4+DQo+Pj4gLSBUaGVu
IHVwZGF0ZSB0aGUgcGF1c2UgYWR2ZXJ0aXNpbmcsIGxpa2UgZG9uZSBpbiBwaHlsaW5rX3NldHBh
dXNlcGFyYW0NCj4+PiAgICggSSB0aGluaywgZXZlcnl0aGluZyB0aGF0IGNvbWVzIGFmdGVyIHBs
LT5zdGF0ZV9tdXRleCBnZXRzIHJlbGVhc2VkIGluDQo+Pj4gICAgcGh5bGlua19ldGh0b29sX3Nl
dF9wYXVzZXBhcmFtKQ0KPj4+DQo+Pj4gSWRlYWxseSwgdGhlIGxvZ2ljIHRvIHVwZGF0ZSB0aGUg
YWR2ZXJ0aXNpbmcgYW5kIHJlLXRyaWdnZXIgYQ0KPj4+IG5lZ29jaWF0aW9uIHNob3VsZCBiZSBm
YWN0b3JlZCBvdXQgaW4gYSBwcml2YXRlIGhlbHBlciwgdGhlbiByZXVzZWQNCj4+PiBmcm9tIGJv
dGggdGhpcyBwYXRoIChNQUMgdXBkYXRlcyBwYXVzZSBzdXBwb3J0KSBhbmQgdGhlDQo+cGh5bGlu
a19ldGh0b29sX3NldF9wYXVzZXBhcmFtIHBhdGguDQo+Pj4NCj4+PiBNYXhpbWUNCj4+DQo+PiBU
aGFua3MgZm9yIHJldmlldyBhbmQgaGVscGZ1bCBzdWdnZXN0aW9ucy4NCj4+DQo+PiBJIGFncmVl
IHdpdGggeW91ciBzdWdnZXN0aW9uIHRvIGZhY3RvciBvdXQgdGhlIGxvZ2ljIGludG8gYSBwcml2
YXRlIGhlbHBlciBhbmQNCj5yZXVzZSBpdCBmb3IgYm90aCBwaHlsaW5rX2V0aHRvb2xfc2V0X3Bh
dXNlcGFyYW0oKSBhbmQNCj5waHlsaW5rX3VwZGF0ZV9tYWNfcGF1c2VfY2FwYWJpbGl0aWVzKCku
DQo+Pg0KPj4gSGVyZSBpcyB0aGUgcmVmYWN0b3JlZCBsb2dpYy4gSSB3YW50IHRvIHNoYXJlIHRo
aXMgc3BlY2lmaWMgcGFydCB3aXRoIHlvdSBmb3IgYQ0KPnF1aWNrIGNoZWNrIGJlZm9yZSBJIHN1
Ym1pdCB2NyBwYXRjaC4NCj4NCj5JJ20gY3VycmVudGx5IGF0dGVuZGluZyB0aGUgbmV0ZGV2IGNv
bmZlcmVuY2UsIEl0J2xsIHRha2UgYSBmZXcgZGF5cyBmb3IgbWUgdG8NCj5sb29rIGF0IHRoaXMs
IHNvcnJ5IGFib3V0IHRoYXQgOi8NCj4NCj5NYXhpbWUNCg0KSnVzdCBhIGdlbnRsZSBwaW5nIG9u
IHRoaXMgdGhyZWFkLiBDb3VsZCB5b3UgcGxlYXNlIHRha2UgYSBxdWljayBsb29rIGF0IHRoaXMg
cmVmYWN0b3JlZCBsb2dpYyB3aGVuZXZlciB5b3UgYXJlIGZyZWU/IEFueSBzdWdnZXN0aW9uIHdv
dWxkIGJlIGdyZWF0bHkgYXBwcmVjaWF0ZWQuDQoNClRoYW5rcywNCkJScywNCkphdmVuDQoNCg==
