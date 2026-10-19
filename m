Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD98951DB01;
	Mon, 19 Oct 2026 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418275; cv=none; b=HMzNnWXoeV/RggK0xqfdnfpCpZB24dy0dLDY+fbl7gMoTIIiKkcb6fYxD6fWtVl33Sw8vgSkAkW7DdHaqfvzYMKJocqtGZjxINlo6yJkXuvBgCzdO9JZOvCeXgFR9A5UIH6F+y24pYmX0A4JyV9zQSXKxzrz85S9+ZJSFmZVflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418275; c=relaxed/simple;
	bh=NUVrmqJ3wa34ZHUp8WURsPG1HnxdJlsqP2m9p2AS2pU=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=HdvhzVvyvY/aErHv7idPWsuD7T1TDwt9tqygNtqx2gaw7CmSVOPcR/xWd3dy6giuBDlDqwSVh+0BsR3+wPs3XxW3gID7w9uQQajCEs4JmAGiW2gXtQ+fBAJDroywGDsU9KcALr3U3WWd+vIgDBnP1sqP5dKLfv9MrBlGZnjvSLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=sdCxRRKE; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="sdCxRRKE"
Content-Language: ru-RU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1792417369; h=from:to:date:message-id:subject;
	bh=NUVrmqJ3wa34ZHUp8WURsPG1HnxdJlsqP2m9p2AS2pU=;
	b=sdCxRRKEitvfTRkDWO9lIdH7dPlqyJHKCaO38BQHt0uQabI2uIr2vRDOn2kMmN0bbMN10eX6dPQ
	AyhM8TiAd8gZf7EIB4AyTp5WtY9Sew1/wf8qnVpDeiyqNEMcMqu1kHLRR9YviArQ7bo/P2O0nQf1n
	W93fmrAfA8TFbOrDFrjLnAHRE2qjbgXNsJxmlVKmFEfsBr3zohNcq789G3PnAH4PlWyFwr2cYBPiB
	Rrtd8f97TWrxGm6+kKqL+pWYntISd5enn4IXPIU3k/iDPe6ZUnufW8GStXAMt9iG5585DOvQtKulg
	BSEbiL6K0dv2ff3cuiuFVQIvwGhq5ewQ72TQ==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Mon, 19 Oct
 2026 18:42:49 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 19 Oct 2026 18:42:40 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Mon, 19 Oct
 2026 18:42:40 +0500
From: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
To: Andrew Lunn <andrew+netdev@lunn.ch>
CC: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michael
 Grzeschik" <mgr@kernel.org>, Jijie Shao <shaojijie@huawei.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>, Denis Benato
	<benato.denis96@gmail.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
	<u.kleine-koenig@baylibre.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH net v3 0/3] net: fealnx: fix card-index overflow and PCI
 device teardown
Thread-Topic: [PATCH net v3 0/3] net: fealnx: fix card-index overflow and PCI
 device teardown
Thread-Index: AQHdX8+14xaiZdZEf0K3eda2tjJQYQ==
Date: Mon, 19 Oct 2026 13:42:40 +0000
Message-ID: <20261019134136.104932-1-r.zhambakiev@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

RnJvbTogUmFkaXkgWmhhbWJha2lldiA8ci56aGFtYmFraWV2QHByb3NvZnRzeXN0ZW1zLnJ1Pg0K
DQpDaGFuZ2VzIHNpbmNlIHYyOg0KUGF0Y2ggMToNCiAgLSBSZXdvcmRlZCBwYXRjaCB0ZXh0IHRv
IGF2b2lkIG92ZXJjb25maWRlbnQgY2xhaW1zOw0KICAgIG5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4N
ClBhdGNoIDM6DQogIC0gUmVwbGFjZWQgSURBIGZpeCB3aXRoIHNpbXBsZSBjYXJkX2lkeCBjaGVj
ayBhcyByZXF1ZXN0ZWQNCiAgICBieSBBbmRyZXcgTHVubi4NCg0KTGluazogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjYxMDAyMTQwOTU0LjI2MTc3OS0xLXIuemhhbWJha2lldkBwcm9z
b2Z0c3lzdGVtcy5ydS8NCg0KUmFkaXkgWmhhbWJha2lldiAoMyk6DQogIG5ldDogZmVhbG54OiBm
aXggdGVhcmRvd24gb3JkZXIgaW4gcmVtb3ZlDQogIG5ldDogZmVhbG54OiBkaXNhYmxlIHRoZSBQ
Q0kgZGV2aWNlIG9uIHJlbW92ZSBhbmQgcHJvYmUgZmFpbHVyZQ0KICBuZXQ6IGZlYWxueDogYm91
bmQgY2FyZF9pZHggdG8gcHJldmVudCBvdXQtb2YtYm91bmRzIGFjY2Vzcw0KDQogZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZmVhbG54LmMgfCAxOSArKysrKysrKysrKysrKy0tLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi41My4wDQo=
