Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701672BDC05;
	Thu, 11 Jun 2026 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781145166; cv=none; b=J45cYEVXBMKlsdlN84LQF9vFSn3AKd4aTcJh8yGQE2cypgFsWrHYPa743JbZ3NPM+YwBZZt38gbev+dUZ+Ls9GQM6aNbGEweeV73LZfI9EwtXKk/NNf1k5i15kT1dHvjN4JymrSOOt/SYEoDbggLiRqrYknY6/Ixc6FWyszh4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781145166; c=relaxed/simple;
	bh=XY4WYpJx/t9nlmRpXG1TkqnF02AL3FX0XM5V/RvLNmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H9yOGkWiIkOTjmuVGr7PkV5yDIvrAETXnfIbx0zgpZhH9We9YXaTprF6Yk5R39QDvHLFly9NBSxCuxaM5fqtM4LyPzGKsHnu1NloI1oCOqc20J5ppBTFewI1e8vsw7koz/kUik4ga5t3UjjWvFkF0aXwqnbY1yhwIy3mdsPAyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=PkqxRT/i; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="PkqxRT/i"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B2VHvX41540746, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781145078;
	bh=XY4WYpJx/t9nlmRpXG1TkqnF02AL3FX0XM5V/RvLNmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=PkqxRT/iwFPCWN/sca8+ZHLUU3gKW2uCvp/Rt5ty9iGmHqOU42QIu9u4nEZPmXqBD
	 K/5U0c5/TtkaEjFi3FGL9s5n6zLf1eG4znfXAso6kfDxd0cNlYUMGkVL/eoDSvReLA
	 81NCCODhV0dBKltKmDBGb8Q814oLxsN7QJXQw0FocUEy9kzNzEx8A8E0srIRQ9u+YD
	 YaQAkV+Mz7Z9sE2b+XUee/zByTiZdpHOchOAtaWbNtmDZ/tT+ClWhfib0TBuhXVhmk
	 xIPlPX6gy64qNWcLhJDvk5wHeImslcXQoKXp14DlbkySYJMTmN49cG8mMhrAMD1RWJ
	 vjxfMJFE38ZYQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B2VHvX41540746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jun 2026 10:31:18 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 10:31:17 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Thu,
 11 Jun 2026 10:31:17 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	=?utf-8?B?6aG+5pmT5Yab?= <freddy_gu@realsil.com.cn>, "nb@tipi-net.de"
	<nb@tipi-net.de>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>
Subject: RE: [PATCH net-next v4 3/4] net: phy: realtek: add support for
 RTL8261C_CG
Thread-Topic: [PATCH net-next v4 3/4] net: phy: realtek: add support for
 RTL8261C_CG
Thread-Index: AQHc97S7Xxs7An9PlEezHDlxAIQrFbY3d/oAgAEtBvA=
Date: Thu, 11 Jun 2026 02:31:17 +0000
Message-ID: <8bbb4c1a13904338816dbd6827c8630d@realsil.com.cn>
References: <20260609020727.1152-1-javen_xu@realsil.com.cn>
 <20260609020727.1152-4-javen_xu@realsil.com.cn>
 <6309a8e9-c0cb-4473-8d94-c6c4ca8ec3f9@bootlin.com>
In-Reply-To: <6309a8e9-c0cb-4473-8d94-c6c4ca8ec3f9@bootlin.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Pg0KPkhpLA0KPg0KPk9uIDYvOS8yNiAwNDowNywgamF2ZW4gd3JvdGU6DQo+PiBGcm9tOiBKYXZl
biBYdSA8amF2ZW5feHVAcmVhbHNpbC5jb20uY24+DQo+Pg0KPj4gVGhpcyBwYXRjaCBhZGRzIHN1
cHBvcnQgZm9yIFJlYWx0ZWsgcGh5IGNoaXAgUlRMODI2MUNfQ0cuIEl0cyBQSFkgSUQNCj4+IGlz
IDB4MDAxY2M4OTguDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSmF2ZW4gWHUgPGphdmVuX3h1QHJl
YWxzaWwuY29tLmNuPg0KPg0KPlsuLi5dDQo+DQo+PiArc3RhdGljIGludCBydGw4MjYxeF9jb25m
aWdfYW5lZyhzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KSB7DQo+PiArICAgICBib29sIGNoYW5n
ZWQgPSBmYWxzZTsNCj4+ICsgICAgIHUxNiBhZHZfMWcgPSAwOw0KPj4gKyAgICAgaW50IHJldDsN
Cj4+ICsNCj4+ICsgICAgIGlmIChwaHlkZXYtPmF1dG9uZWcgPT0gQVVUT05FR19ESVNBQkxFKQ0K
Pj4gKyAgICAgICAgICAgICByZXR1cm4gZ2VucGh5X2M0NV9wbWFfc2V0dXBfZm9yY2VkKHBoeWRl
dik7DQo+DQo+VGhpcyBjb25kaXRpb24gYWJvdmUgaXMgYWxyZWFkeSBkb25lIHdoZW4gY2FsbGlu
ZyBnZW5waHlfYzQ1X2NvbmZpZ19hbmVnLCBpcw0KPml0IHJlYWxseSBuZWNlc3NhcnkgdG8gcHV0
IGl0IHRoZXJlID8NCg0KSSB3aWxsIHJlbW92ZSBpdC4NCg0KPg0KPj4gKw0KPj4gKyAgICAgcmV0
ID0gZ2VucGh5X2M0NV9hbl9zZXR1cF9tYXN0ZXJfc2xhdmUocGh5ZGV2KTsNCj4+ICsgICAgIGlm
IChyZXQgPCAwKQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKyAgICAgaWYgKHJl
dCA+IDApDQo+PiArICAgICAgICAgICAgIGNoYW5nZWQgPSB0cnVlOw0KPg0KPkknbSB3b25kZXJp
bmcgaWYgdGhpcyBjYWxsIHRvIGdlbnBoeV9jNDVfYW5fc2V0dXBfbWFzdGVyX3NsYXZlKCkgbWF5
DQo+YWN0dWFsbHkgYmUgaW50ZWdyYXRlZCBkaXJlY3RseSBpbnRvIGdlbnBoeV9jNDVfY29uZmln
X2FuZWcgKCksIGFzIHdlIGRvIGZvcg0KPkMyMi4NCj4NCj5JdCBfbWF5XyBicmVhayBzb21lIEM0
NSBwaHlzIHRoYXQgd291bGQgcmVseSBvbiBkZWZhdWx0IHZhbHVlcyB0aG91Z2gsIGJ1dA0KPnRo
aXMgc2hvdWxkIGJlIG1vcmUgY29ycmVjdCA/DQoNCkkgd2lsbCBtb3ZlIGl0IHRvIGdlbnBoeV9j
NDVfY29uZmlnX2FuZWcuDQoNClRoYW5rcw0KQlJzLA0KSmF2ZW4NCg0KPg0KPk1heGltZQ0KDQo=
