Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08691303CAB;
	Tue,  2 Jun 2026 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398036; cv=none; b=YaPoQXyLHHo627YX68LwAzXZMbiZFJxiAfljRuvR/NYiAewCcQin4TLpRLoW8496rUY+DEAuPklHPoEy6+MbVGK3OSRzNIr5ppv+0kNrIKB5miHsOUaEJtCUmb+50iYM3bNM2bv74s1db1hnfez/GXd0M8Ku2d8a4ukUejJlqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398036; c=relaxed/simple;
	bh=bAmLVjrvQ9lb6U8CDeiNeJwg8fFD50jdw68pPGb5KO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DGbOJrii7k3a5CHAGlcZGHu1ftWWXcKb83WyKOialS1AYU7Fn7Vxy2NySPc+5COt0jujhgxn2Ogwxp78gx45x7gRJR7ovXKTCVcCVl+u6HithuccbMRMQ0YGoeuPWN+hppM864ne3SyoXklsxzDZfwFW3Z8SLchmC27iFBtCils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jBrMwyDm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jBrMwyDm"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 652AoCaqD2852325, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780397412; bh=bAmLVjrvQ9lb6U8CDeiNeJwg8fFD50jdw68pPGb5KO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jBrMwyDmiwgj94cPecxui45usjVbaawVB4x9Oxa8toChGnbOzvfQxKFTUjfQVJAT9
	 mkKM3tBBoULM4XoApmSqNzb40fg8OdOhMfl5XcwdskqXKAkbZrEYqAVIVrvfmrWKEF
	 jFCWfOfG+M1R7bz0huC0MGqip+H2FkrX4ozdp2+cM0VdlfBYHV5oH+fE6H3qgzTC7d
	 orWY/sKir+CnbhP2pH80NS1AX/7xOV0mr2kyOLdETqkxaKcwR8y8+GvN+HY/+bviGg
	 8i+zyHXi6a6It8qxtYBce2VUiHPXZm+eZMUxWJn5TvaFWykofl7smD2N/rT8o1BTce
	 L1bnxgLoRJMMA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 652AoCaqD2852325
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jun 2026 18:50:12 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Jun 2026 18:50:13 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Tue, 2 Jun 2026 18:50:13 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>, Ping-Ke Shih
	<pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH] rtase: Avoid sleeping in get_stats64()
Thread-Topic: [PATCH] rtase: Avoid sleeping in get_stats64()
Thread-Index: AQHc8Y9Zk86yDw9UQUiLPdmdwKAAprYpKAUAgAHvlVA=
Date: Tue, 2 Jun 2026 10:50:13 +0000
Message-ID: <c3ca6a679d694890828ac9e7cc2d6305@realtek.com>
References: <20260601062447.64027-1-justinlai0215@realtek.com>
 <f4b96c08-c6f7-422f-aceb-aa48fa2bfef6@intel.com>
In-Reply-To: <f4b96c08-c6f7-422f-aceb-aa48fa2bfef6@intel.com>
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

PiBGcm9tOiBKdXN0aW4gTGFpIDxqdXN0aW5sYWkwMjE1QHJlYWx0ZWsuY29tPg0KPiBEYXRlOiBN
b24sIDEgSnVuIDIwMjYgMTQ6MjQ6NDcgKzA4MDANCj4gDQo+ID4gVGhlIC5uZG9fZ2V0X3N0YXRz
NjQgY2FsbGJhY2sgbXVzdCBub3Qgc2xlZXAgYmVjYXVzZSBpdCBjYW4gYmUgY2FsbGVkDQo+ID4g
d2hlbiByZWFkaW5nIC9wcm9jL25ldC9kZXYuDQo+ID4NCj4gPiBydGFzZV9nZXRfc3RhdHM2NCgp
IGNhbGxzIHJ0YXNlX2R1bXBfdGFsbHlfY291bnRlcigpLCB3aGljaCBwb2xscyB0aGUNCj4gPiB0
YWxseSBjb3VudGVyIGR1bXAgYml0IHdpdGggcmVhZF9wb2xsX3RpbWVvdXQoKS4gVGhpcyBtYXkg
c2xlZXAgd2hpbGUNCj4gPiB3YWl0aW5nIGZvciB0aGUgaGFyZHdhcmUgY291bnRlciBkdW1wIHRv
IGNvbXBsZXRlLg0KPiA+DQo+ID4gVXNlIHJlYWRfcG9sbF90aW1lb3V0X2F0b21pYygpIGluc3Rl
YWQgdG8gYXZvaWQgc2xlZXBpbmcgaW4gdGhlDQo+ID4gZ2V0X3N0YXRzNjQoKSBwYXRoLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogSnVzdGluIExhaSA8anVzdGlubGFpMDIxNUByZWFsdGVrLmNv
bT4NCj4gDQo+IExvb2tzIGxlZ2l0Lg0KPiANCj4gT25lIHF1ZXN0aW9uOiBmb3IgaG93IGxvbmcg
Y2FuIHRoaXMgcG9sbCBmb3IgaW4gcmVhbCBsaWZlIHNjZW5hcmlvcz8gVXAgdG8gfjEgbXMNCj4g
aXMgb2theS1pc2ggZm9yIGF0b21pYywgYnV0IGlmIGxvbmdlciwgdGhlbiB5b3UnZCBiZXR0ZXIg
dG8gc3BsaXQgaXQgaW50byBzaG9ydGVyDQo+IHBvbGxzIGFuZCByZXNjaGVkdWxlKCkgdGltZSB0
byB0aW1lLg0KPiANCj4gVGhhbmtzLA0KPiBPbGVrDQoNCkhpIE9sZWssDQogDQpUaGFua3MgZm9y
IHRoZSByZXZpZXcuDQogDQpPbiBvdXIgdGVzdCBwbGF0Zm9ybSwgdGhlIHRhbGx5IGR1bXAgb3Bl
cmF0aW9uIHR5cGljYWxseQ0KY29tcGxldGVzIGluIGFib3V0IDI1IHVzLiBUaGUgMjUwIHVzIHRp
bWVvdXQgaXMgYQ0KY29uc2VydmF0aXZlIHZhbHVlLg0KIA0KSSdsbCBhZGQgdGhlIEZpeGVzIHRh
ZyBhbmQgcmVzZW5kIHRoaXMgcGF0Y2ggdGFyZ2V0aW5nDQp0aGUgbmV0IHRyZWUuDQogDQpUaGFu
a3MsDQpKdXN0aW4NCg==
