Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF2C3D1A8F;
	Tue, 28 Jul 2026 07:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223907; cv=none; b=T/RtBp/XvW9OQVFmNYSq+1nY+aRLzfmM3NyZivCfDTxuM9AH+tdOjBpkJhvmoEzpHeEz+IvfhRNJ9UQ5jcNoBD/junuTajM7YksSyyRIfg1ZqD+yywc7DnCEH50MQgpf+mNQfZlGJ0hUP0BhHnLp2DFYKujvztFLqDQR6tEzSOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223907; c=relaxed/simple;
	bh=mkSHfLfTlSe07poYKCbFaI2FI7uVAwYI6N4CyEz9XMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D+jIHh4QIOV2seDAEw3gDDAlcYuEzwkQzR//emmSXz3Ts7NxeUT+wYC9EbbjHgZkC+lyeajLcSVD/H4fIWKTt11EU+i+eeF4TrJRiRpJ9uk6jlMEVV66mz+LsK244XjIlbTxePKg/9XdfULu/cji7SZdG1b4MscYt1MYUJhIH4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=ppxDI68+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="ppxDI68+"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66S7UNMQ03680748, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1785223824;
	bh=mkSHfLfTlSe07poYKCbFaI2FI7uVAwYI6N4CyEz9XMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ppxDI68+ZYz6JimC2MSCBvGg+2PRa17ISSJJYbVnJEwYDy2Wc5cXT4LO6Qku1USxx
	 zv577g/rwBgwXbGepAf3VQGGLVw1TpbV7zwyDy42WWDDj+ZVb2mVIBYGb/bHQFM/Ij
	 zGtMOaI5veTMaSLiLZ/bx/+tVUP78pC27S3XEUPkdy3Tb9blQN2oXhzcKKKkgcwqGw
	 xBjkNtTqD0dnwuwezkD1oTh7Fsv/xr7hIMT0doizKy+3wfNyU+S7HYWhMKElb7NKR7
	 Abbh9+pLsOkpkq4KjdeSp5U9Jzn7xE3++95PITWdkRy6g0i+kC2bGoBG0n4c3Ald+f
	 UcTD7xbtyjh+w==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66S7UNMQ03680748
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 Jul 2026 15:30:24 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 15:30:24 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.043; Tue,
 28 Jul 2026 15:30:24 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Chukun Pan <amadeus@jmu.edu.cn>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, =?utf-8?B?6aG+5pmT5Yab?=
	<freddy_gu@realsil.com.cn>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "nb@tipi-net.de" <nb@tipi-net.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
Subject: RE: [PATCH net-next v10 5/5] net: phy: realtek: add support for
 RTL8261D
Thread-Topic: [PATCH net-next v10 5/5] net: phy: realtek: add support for
 RTL8261D
Thread-Index: AQHdGLgFnWqKo3yoJ026TnnGe+U6QrZ48LqAgAeu6XCAAWNwgIAAkP7w
Date: Tue, 28 Jul 2026 07:30:24 +0000
Message-ID: <01571a1acbed47d69cdc97437f106fb5@realsil.com.cn>
References: <bb782164800a421397c2085f7e58aff4@realsil.com.cn>
 <20260728065001.1487282-1-amadeus@jmu.edu.cn>
In-Reply-To: <20260728065001.1487282-1-amadeus@jmu.edu.cn>
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

Pg0KPkhpLA0KPg0KPj4gVGhlIHJlYXNvbiBmb3IgdGhpcyBjaGFuZ2UgaXMgdGhhdCBSVEw4MjYx
IDEwR2JwcyBQSFkgc2hhcmUgdGhlIHNhbWUNCj4+IHBoeSBpZC4gVGhlIHNwZWNpZmljIGhhcmR3
YXJlIHZlcnNpb25zIGFyZSBkaXN0aW5ndWlzaGVkIGJ5IGEgc3ViLXBoeQ0KPj4gaWQgaW5zdGVh
ZC4gQW5kIGluIHByb2JlIGZ1bmN0aW9uLCB3ZSB3aWxsIHByaW50IG91dCB0aGUgZXhhY3QNCj4+
IGhhcmR3YXJlIHZlcnNpb24gZXhwbGljaXRseS4NCj4NCj5UaGlzIGlzIG9ubHkgcHJpbnRlZCBk
dXJpbmcgcHJvYmUuIElmIEknbSBub3QgbWlzdGFrZW4sIHRoZSBQSFkgSURzIG9mIFJUTDgyNjFO
DQo+YW5kIFJUTDgyNjFDIGFyZSBub3QgdGhlIHNhbWUuIFBlcmhhcHMgeW91IGNvdWxkIG5hbWUg
aXQgc29tZXRoaW5nIGxpa2UNCj5SVEw4MjYxQy9EIGhlcmU/DQoNClRoaXMgY2hhbmdlIHdpbGwg
YmUgYWRkZWQgaW50byAgbmV3IHBhdGNoLg0KDQpUaGFua3MsDQpKYXZlbg0K
